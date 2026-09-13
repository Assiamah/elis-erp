package com.mit.elis.controllers;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Iterator;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.google.gson.Gson;
import com.mit.elis.class_common.Ws_url_config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.ws_valueadded_services.cls_valueadded_services;

@Controller
public class ShortReviewSectionController {
    private static final JSONObject MODALS = readDefinition("/short-review-modals.json");
    private static final JSONObject FIELDS = readDefinition("/short-review-fields.json");

    private static String scalar(JSONObject object, String key) {
        if (object == null || object.isNull(key) || "null".equals(String.valueOf(object.opt(key)))) return "";
        return object.optString(key, "");
    }

    private static JSONObject readDefinition(String resource) {
        try (InputStream stream = ShortReviewSectionController.class.getResourceAsStream(resource)) {
            if (stream == null) throw new IllegalStateException("Missing short review definition");
            return new JSONObject(new String(stream.readAllBytes(), StandardCharsets.UTF_8));
        } catch (Exception ex) {
            throw new IllegalStateException("Invalid short review definition", ex);
        }
    }

    /** Validate the short page without replacing a service error with a generic one. */
    static JSONObject parseInitialResponse(String raw, String endpoint, String expectedJob) throws Exception {
        if (raw == null || raw.trim().isEmpty()) {
            throw new org.codehaus.jettison.json.JSONException(endpoint + ": empty service response");
        }
        JSONObject result;
        try {
            result = new JSONObject(raw);
        } catch (org.codehaus.jettison.json.JSONException ex) {
            throw new org.codehaus.jettison.json.JSONException(endpoint + ": service returned invalid JSON");
        }
        String message = scalar(result, "message").replaceAll("[\\r\\n\\t]+", " ");
        if (message.length() > 500) message = message.substring(0, 500);
        String detail = message.isEmpty() ? "No service error message was returned." : message;
        // Older general-request responses may omit success; explicit failure is never ignored.
        if (result.has("success") && !result.optBoolean("success", false)) {
            throw new org.codehaus.jettison.json.JSONException(endpoint + ": service reported failure. " + detail);
        }
        for (String key : new String[]{"job_detail", "parcel_details", "transaction_details"}) {
            Object value = result.opt(key);
            if (value instanceof String && !((String) value).trim().isEmpty()
                    && !"null".equals(((String) value).trim())) {
                try {
                    result.put(key, new JSONObject((String) value));
                } catch (org.codehaus.jettison.json.JSONException ex) {
                    throw new org.codehaus.jettison.json.JSONException(endpoint + ": invalid " + key + " object. " + detail);
                }
            }
        }
        JSONObject job = result.optJSONObject("job_detail");
        if (job == null) {
            throw new org.codehaus.jettison.json.JSONException(endpoint + ": missing job_detail object. " + detail);
        }
        String returnedJob = scalar(job, "job_number");
        if (expectedJob == null || expectedJob.trim().isEmpty() || !expectedJob.equals(returnedJob)) {
            throw new org.codehaus.jettison.json.JSONException(endpoint + ": job_detail does not match the requested application");
        }
        normalizeInitialResponse(result);
        return result;
    }

    /** The short response may omit optional arrays or encode workflow arrays as JSON text. */
    static void normalizeInitialResponse(JSONObject result) throws Exception {
        for (String objectKey : new String[]{"parcel_details", "transaction_details", "job_detail"}) {
            JSONObject object = result.optJSONObject(objectKey);
            if (object == null) continue;
            for (Iterator<?> keys = object.keys(); keys.hasNext();) {
                String key = keys.next().toString();
                if (object.isNull(key) || "null".equals(String.valueOf(object.opt(key)))) object.put(key, "");
            }
        }
        for (String key : new String[]{"job_details", "parcels_coordinates", "lrd_valuation_section",
                "lrd_memorials_section", "lrd_encumbrances_section", "lrd_certificate_section",
                "lrd_proprietorship_section", "lrd_reservation_section", "application_requests",
                "digital_workflow_steps", "application_munites", "application_notes", "payment_bill",
                "payment_invoice", "parties", "case_query", "case_objection", "inspection_reports_on_appliction",
                "case_letters", "mother_to_child_link", "certificate_search_relation",
                "baby_step_milestone", "active_digital_workflow_step"}) {
            Object value = result.opt(key);
            if (result.isNull(key) || value == null || value == JSONObject.NULL || "".equals(value) || "null".equals(String.valueOf(value))) {
                result.put(key, new JSONArray());
            } else if (value instanceof String) {
                result.put(key, new JSONArray((String) value));
            } else if (!(value instanceof JSONArray)) {
                throw new IllegalArgumentException("Invalid short review collection: " + key);
            }
        }
    }

    private static final String CONTEXTS = ShortReviewSectionController.class.getName();
    private static final Map<String, String> SECTIONS = Map.ofEntries(
        Map.entry("jobs", "job_details"),
        Map.entry("parties", "parties"),
        Map.entry("payments", "payment_invoice"),
        Map.entry("minutes", "application_munites"),
        Map.entry("records", "application_notes"),
        Map.entry("queries", "case_query"),
        Map.entry("encumbrances", "lrd_encumbrances_section"),
        Map.entry("links", "mother_to_child_link_list"),
        Map.entry("objections", "case_objection"),
        Map.entry("letters", "case_letters")
    );

    private cls_valueadded_services workflowService = new cls_valueadded_services();

    @Autowired
    private Ws_url_config config;

    /** Keep identifiers server-side and isolate multiple open application tabs. */
    @SuppressWarnings("unchecked")
    static void register(HttpSession session, HttpServletRequest request) {
        Map<String, Object> context = new LinkedHashMap<>();
        for (String key : new String[]{"job_number", "case_number", "transaction_number",
                "business_process_sub_name", "review_type", "rq_id", "job_purpose"}) {
            context.put(key, request.getAttribute(key));
        }
        Map<String, Object> renderAttributes = new LinkedHashMap<>();
        for (Iterator<?> keys = FIELDS.keys(); keys.hasNext();) {
            String key = keys.next().toString();
            renderAttributes.put(key, request.getAttribute(key));
        }
        for (String key : new String[]{"genderlist", "officeregionlist", "regionlist", "parcel_wkt",
                "certificete_approval_status", "final_approval_status", "compliance_query_status",
                "review_instruction", "transaction_id", "active_case_queries", "active_case_objection"}) {
            renderAttributes.put(key, request.getAttribute(key));
        }
        context.put("renderAttributes", renderAttributes);
        String token = UUID.randomUUID().toString();
        synchronized (session) {
            Map<String, Map<String, Object>> contexts =
                (Map<String, Map<String, Object>>) session.getAttribute(CONTEXTS);
            if (contexts == null) contexts = new LinkedHashMap<>();
            contexts.put(token, context);
            while (contexts.size() > 20) contexts.remove(contexts.keySet().iterator().next());
            session.setAttribute(CONTEXTS, contexts);
        }
        request.setAttribute("short_review_context", token);
    }

    @PostMapping("/short_review_section")
    @SuppressWarnings("unchecked")
    public String load(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setHeader("Cache-Control", "no-store");
        HttpSession session = request.getSession(false);
        if (session == null || !request.isRequestedSessionIdValid()) {
            response.sendError(401);
            return null;
        }
        Map<String, Object> context;
        synchronized (session) {
            Map<String, Map<String, Object>> contexts =
                (Map<String, Map<String, Object>>) session.getAttribute(CONTEXTS);
            context = contexts == null ? null : contexts.get(request.getParameter("context"));
        }
        if (context == null) {
            response.sendError(410);
            return null;
        }
        String section = request.getParameter("section");
        if (section == null || (!SECTIONS.containsKey(section) && !"workflow".equals(section))) {
            response.sendError(400);
            return null;
        }
        context.forEach(request::setAttribute);
        request.setAttribute("section", section);
        try {
            if ("workflow".equals(section)) {
                JSONObject input = new JSONObject();
                input.put("job_number", context.get("job_number"));
                input.put("case_number", context.get("transaction_number"));
                input.put("job_purpose", context.get("job_purpose"));
                input.put("rq_id", context.get("rq_id"));
                input.put("section", "workflow");
                // Specific work requests must retain their own workflow definition.
                String raw = "GeneralWorkRequest".equals(context.get("review_type"))
                    ? workflowService.select_review_digital_workflow_short(
                        config.getWeb_service_url_ser(), config.getWeb_service_url_ser_api_key(), input.toString())
                    : workflowService.select_general_request_workflow(
                        config.getWeb_service_url_ser(), config.getWeb_service_url_ser_api_key(), input.toString());
                JSONObject result = new JSONObject(raw);
                if (result.has("success") && !result.optBoolean("success", false)) {
                    throw new IllegalStateException("Workflow unavailable");
                }
                request.setAttribute("baby_step_milestone_list", new Gson().fromJson(
                    result.getJSONArray("baby_step_milestone").toString(), ArrayList.class));
            } else {
                String attribute = SECTIONS.get(section);
                JSONObject input = new JSONObject();
                input.put("transaction_number", context.get("transaction_number"));
                input.put("job_number", context.get("job_number"));
                input.put("section", section);
                String raw = workflowService.select_review_digital_workflow_short(
                    config.getWeb_service_url_ser(), config.getWeb_service_url_ser_api_key(), input.toString());
                JSONObject result = new JSONObject(raw);
                if (result.has("success") && !result.optBoolean("success", false)) {
                    throw new IllegalStateException("Section unavailable");
                }
                JSONArray rows = result.getJSONArray("data");
                request.setAttribute(attribute, new Gson().fromJson(rows.toString(), ArrayList.class));
            }
            return "pages/client_application/_short_review_section";
        } catch (Exception ex) {
            response.sendError(502, "Unable to load this section. Please retry.");
            return null;
        }
    }
    @PostMapping("/short_review_modal")
    @SuppressWarnings("unchecked")
    public String loadModal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setHeader("Cache-Control", "no-store");
        HttpSession session = request.getSession(false);
        if (session == null || !request.isRequestedSessionIdValid()) {
            response.sendError(401);
            return null;
        }
        Map<String, Object> context;
        synchronized (session) {
            Map<String, Map<String, Object>> contexts =
                (Map<String, Map<String, Object>>) session.getAttribute(CONTEXTS);
            context = contexts == null ? null : contexts.get(request.getParameter("context"));
        }
        if (context == null) {
            response.sendError(410);
            return null;
        }
        String modalId = request.getParameter("modal");
        JSONObject definition = modalId == null ? null : MODALS.optJSONObject(modalId);
        if (definition == null) {
            response.sendError(400);
            return null;
        }
        try {
            JSONObject input = new JSONObject();
            input.put("job_number", context.get("job_number"));
            input.put("case_number", context.get("transaction_number"));
            input.put("section", "modal");
            JSONArray attributes = definition.getJSONArray("collections");
            JSONArray collections = new JSONArray();
            for (int i = 0; i < attributes.length(); i++) {
                String key = attributes.getString(i);
                collections.put("mother_to_child_link_list".equals(key) ? "mother_to_child_link" : key);
            }
            input.put("collections", collections);
            JSONObject result = new JSONObject(workflowService.select_review_digital_workflow_short(
                config.getWeb_service_url_ser(), config.getWeb_service_url_ser_api_key(), input.toString()));
            if (!result.optBoolean("success", false) || !"modal".equals(result.optString("section"))) {
                throw new IllegalStateException("Short modal response unavailable; check database migration");
            }
            JSONObject job = result.optJSONObject("job_detail");
            if (job == null || !String.valueOf(context.get("job_number")).equals(job.optString("job_number"))) {
                throw new IllegalStateException("Modal response does not match this application");
            }
            Map<String, Object> snapshot = (Map<String, Object>) context.get("renderAttributes");
            if (snapshot != null) snapshot.forEach(request::setAttribute);
            context.forEach((key, value) -> { if (!"renderAttributes".equals(key)) request.setAttribute(key, value); });
            for (Iterator<?> keys = FIELDS.keys(); keys.hasNext();) {
                String attribute = keys.next().toString();
                JSONArray mapping = FIELDS.getJSONArray(attribute);
                JSONObject object = result.optJSONObject(mapping.getString(0));
                request.setAttribute(attribute, scalar(object, mapping.getString(1)));
            }
            for (String key : new String[]{"parcel_wkt", "certificete_approval_status", "final_approval_status",
                    "compliance_query_status", "active_case_objection"}) {
                request.setAttribute(key, scalar(result, key));
            }
            request.setAttribute("active_case_queries", result.optString("active_case_query", "0"));
            for (int i = 0; i < attributes.length(); i++) {
                JSONArray rows = result.getJSONArray(collections.getString(i));
                request.setAttribute(attributes.getString(i), new Gson().fromJson(rows.toString(), ArrayList.class));
            }
            request.setAttribute("short_review_modal_id", modalId);
            request.setAttribute("short_review_modal_template", definition.getString("template"));
            return "pages/client_application/_short_review_modal";
        } catch (Exception ex) {
            response.sendError(502, "Unable to load workflow details. Please retry.");
            return null;
        }
    }

}
