package com.mit.elis.controllers;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.util.ReflectionTestUtils;
import com.mit.elis.class_common.Ws_url_config;
import ws.ws_valueadded_services.cls_valueadded_services;

class ShortReviewSectionControllerTest {
    private ShortReviewSectionController controller;
    private FakeApi api;
    private static class FakeApi extends cls_valueadded_services {
        String response;
        String input;
        int calls;
        @Override
        public String select_review_digital_workflow_short(String url, String key, String json) {
            assertEquals("http://service/", url);
            assertEquals("test-key", key);
            input = json;
            calls++;
            return response;
        }
    }
    private MockHttpSession session;
    private String token;

    @BeforeEach
    void setup() {
        controller = new ShortReviewSectionController();
        api = new FakeApi();
        Ws_url_config config = new Ws_url_config() {
            @Override public String getWeb_service_url_ser() { return "http://service/"; }
            @Override public String getWeb_service_url_ser_api_key() { return "test-key"; }
        };
        ReflectionTestUtils.setField(controller, "config", config);
        ReflectionTestUtils.setField(controller, "workflowService", api);
        session = new MockHttpSession();
        MockHttpServletRequest page = new MockHttpServletRequest();
        page.setAttribute("job_number", "JOB1");
        page.setAttribute("transaction_number", "TRANS1");
        page.setAttribute("review_type", "GeneralWorkRequest");
        ShortReviewSectionController.register(session, page);
        token = (String) page.getAttribute("short_review_context");
    }

    private MockHttpServletRequest request(String section) {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setSession(session);
        request.setRequestedSessionIdValid(true);
        request.setParameter("context", token);
        request.setParameter("section", section);
        return request;
    }

    @Test
    void requiresSessionAndKnownPageContext() throws Exception {
        MockHttpServletResponse response = new MockHttpServletResponse();
        assertNull(controller.load(new MockHttpServletRequest(), response));
        assertEquals(401, response.getStatus());
        MockHttpServletRequest request = request("jobs");
        request.setParameter("context", "unknown");
        response = new MockHttpServletResponse();
        assertNull(controller.load(request, response));
        assertEquals(410, response.getStatus());
        assertEquals(0, api.calls);
    }

    @Test
    void rejectsUnknownSectionWithoutCallingApi() throws Exception {
        MockHttpServletResponse response = new MockHttpServletResponse();
        assertNull(controller.load(request("arbitrary-load-type"), response));
        assertEquals(400, response.getStatus());
        assertEquals(0, api.calls);
    }

    @Test
    void loadsOnlyRequestedSectionUsingServerSideIdentifiers() throws Exception {
        api.response = "{\"success\":true,\"data\":[{\"job_number\":\"JOB2\"}]}";
        MockHttpServletRequest request = request("jobs");
        request.setParameter("job_number", "TAMPERED");
        MockHttpServletResponse response = new MockHttpServletResponse();
        assertEquals("pages/client_application/_short_review_section", controller.load(request, response));
        assertEquals(1, ((List<?>) request.getAttribute("job_details")).size());
        assertEquals("no-store", response.getHeader("Cache-Control"));
        assertEquals(1, api.calls);
        assertTrue(api.input.contains("JOB1"));
        assertTrue(api.input.contains("TRANS1"));
        assertTrue(api.input.contains("\"section\":\"jobs\""));
        assertFalse(api.input.contains("TAMPERED"));
    }

    @Test
    void distinguishesEmptyDataFromApiFailure() throws Exception {
        api.response = "{\"data\":[]}";
        MockHttpServletRequest request = request("parties");
        assertNotNull(controller.load(request, new MockHttpServletResponse()));
        assertTrue(((List<?>) request.getAttribute("parties")).isEmpty());
        for (String failure : new String[]{"{\"success\":false}", "Data Not Received"}) {
            api.response = failure;
            MockHttpServletResponse response = new MockHttpServletResponse();
            assertNull(controller.load(request("parties"), response));
            assertEquals(502, response.getStatus());
        }
    }
    @Test
    void normalizesNullableAndEncodedShortCollections() throws Exception {
        var result = new org.codehaus.jettison.json.JSONObject(
            "{\"parties\":null,\"baby_step_milestone\":\"[]\",\"transaction_details\":{\"term\":null}}");
        ShortReviewSectionController.normalizeInitialResponse(result);
        assertEquals(0, result.getJSONArray("parties").length());
        assertEquals(0, result.getJSONArray("baby_step_milestone").length());
        assertEquals(0, result.getJSONArray("application_notes").length());
        assertEquals("", result.getJSONObject("transaction_details").getString("term"));
    }

    @Test
    void modalUsesServerSelectedCollectionsAndRetainsQuotedRecords() throws Exception {
        api.response = "{\"success\":true,\"section\":\"modal\",\"job_detail\":{\"job_number\":\"JOB1\"},\"application_notes\":[{\"an_description\":\"A \\\"quoted\\\" note\"}]}";
        var request = request("ignored");
        request.setParameter("modal", "review_records_verification");
        request.setParameter("collections", "payment_invoice");
        request.setParameter("job_number", "TAMPERED");
        var response = new MockHttpServletResponse();
        assertEquals("pages/client_application/_short_review_modal", controller.loadModal(request, response));
        var input = new org.codehaus.jettison.json.JSONObject(api.input);
        assertEquals("JOB1", input.getString("job_number"));
        assertEquals("modal", input.getString("section"));
        assertEquals("[\"application_notes\"]", input.getJSONArray("collections").toString());
        assertEquals(1, ((List<?>) request.getAttribute("application_notes")).size());
        assertEquals("review_records_verification", request.getAttribute("short_review_modal_id"));
        assertEquals("no-store", response.getHeader("Cache-Control"));
    }

    @Test
    void modalRejectsMissingSessionsUnknownContextsAndArbitraryTemplates() throws Exception {
        var response = new MockHttpServletResponse();
        assertNull(controller.loadModal(new MockHttpServletRequest(), response));
        assertEquals(401, response.getStatus());
        var request = request("ignored");
        request.setParameter("modal", "../../other.jsp");
        response = new MockHttpServletResponse();
        assertNull(controller.loadModal(request, response));
        assertEquals(400, response.getStatus());
        request.setParameter("context", "unknown");
        response = new MockHttpServletResponse();
        assertNull(controller.loadModal(request, response));
        assertEquals(410, response.getStatus());
        assertEquals(0, api.calls);
    }

    @Test
    void modalFailureCannotMasqueradeAsAnEmptyCollection() throws Exception {
        for (String body : new String[]{"", "{\"success\":false}", "{\"success\":true}",
                "{\"success\":true,\"section\":\"modal\"}"}) {
            api.response = body;
            var request = request("ignored");
            request.setParameter("modal", "check_for_payment");
            var response = new MockHttpServletResponse();
            assertNull(controller.loadModal(request, response));
            assertEquals(502, response.getStatus());
        }
        api.response = "{\"success\":true,\"section\":\"modal\",\"job_detail\":{\"job_number\":\"JOB1\"},\"payment_invoice\":[]}";
        var request = request("ignored");
        request.setParameter("modal", "check_for_payment");
        assertNotNull(controller.loadModal(request, new MockHttpServletResponse()));
        assertTrue(((List<?>) request.getAttribute("payment_invoice")).isEmpty());
    }

    @Test
    void modalContextsRemainIsolatedAcrossApplicationTabs() throws Exception {
        var secondPage = new MockHttpServletRequest();
        secondPage.setAttribute("job_number", "JOB2");
        secondPage.setAttribute("transaction_number", "TRANS2");
        ShortReviewSectionController.register(session, secondPage);
        api.response = "{\"success\":true,\"section\":\"modal\",\"job_detail\":{\"job_number\":\"JOB2\"},\"payment_invoice\":[]}";
        var request = request("ignored");
        request.setParameter("context", (String) secondPage.getAttribute("short_review_context"));
        request.setParameter("modal", "check_for_payment");
        assertNotNull(controller.loadModal(request, new MockHttpServletResponse()));
        assertTrue(api.input.contains("JOB2"));
        assertTrue(api.input.contains("TRANS2"));
        request.setParameter("context", token);
        var response = new MockHttpServletResponse();
        assertNull(controller.loadModal(request, response));
        assertEquals(502, response.getStatus());
        assertTrue(api.input.contains("JOB1"));
    }

    @Test
    void initialResponsePreservesDatabaseFailureReason() {
        Exception error = assertThrows(Exception.class, () -> ShortReviewSectionController.parseInitialResponse(
            "{\"success\":false,\"message\":\"column example_column does not exist\"}",
            "select_review_digital_workflow_short", "JOB1"));
        assertTrue(error.getMessage().contains("column example_column does not exist"));
        assertTrue(error.getMessage().contains("select_review_digital_workflow_short"));
    }

    @Test
    void initialResponseAcceptsLegacySuccessAndEncodedObjects() throws Exception {
        var result = ShortReviewSectionController.parseInitialResponse(
            "{\"job_detail\":\"{\\\"job_number\\\":\\\"JOB1\\\"}\",\"parcel_details\":null}",
            "select_general_request_workflow", "JOB1");
        assertEquals("JOB1", result.getJSONObject("job_detail").getString("job_number"));
        assertEquals(0, result.getJSONArray("parties").length());
    }

    @Test
    void initialResponseRejectsMissingMismatchedAndFailedJobDetails() {
        for (String raw : new String[]{"", "not JSON", "{\"success\":true}",
                "{\"job_detail\":{\"job_number\":\"OTHER\"}}",
                "{\"success\":false,\"job_detail\":{\"job_number\":\"JOB1\"}}"}) {
            assertThrows(Exception.class, () -> ShortReviewSectionController.parseInitialResponse(
                raw, "select_review_digital_workflow_short", "JOB1"));
        }
    }

}
