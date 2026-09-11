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
}
