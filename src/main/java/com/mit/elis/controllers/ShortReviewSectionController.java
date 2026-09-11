package com.mit.elis.controllers;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

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
}
