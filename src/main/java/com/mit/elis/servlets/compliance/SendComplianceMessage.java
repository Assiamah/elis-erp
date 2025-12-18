package com.mit.elis.servlets.compliance;

import org.codehaus.jettison.json.JSONObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.compliance.ws_compliance;
import java.io.File;
import java.util.ArrayList;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class SendComplianceMessage {
	ws_compliance cls_compliance = new ws_compliance();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/SendComplianceMessage")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// HttpSession session = request.getSession();

		try {
			String request_type = request.getParameter("request_type");

			// System.out.println(String.format("Log level: %s",
			// request.getParameter("request_type")));

			/*
			 * final Enumeration<String> parameterNames =
			 * request.getParameterNames(); while
			 * (parameterNames.hasMoreElements()) {
			 * System.out.println("{parameter} " +
			 * request.getParameter(parameterNames.nextElement())); }
			 */

			String web_service_response = null;

			if (request_type.equals("send_compliance_message")) {
				JSONObject obj = new JSONObject();
				obj.put("send_by_name", (String) session.getAttribute("fullname"));
				obj.put("send_by_id", (String) session.getAttribute("userid"));
				obj.put("send_to_id", request.getParameter("officer_id"));
				obj.put("send_to_name", request.getParameter("officer_name"));
				obj.put("list_of_application", request.getParameter("job_numbers"));
				obj.put("message_type", request.getParameter("message_type"));
				obj.put("message", request.getParameter("message"));
				obj.put("csd_compliance", request.getParameter("csd_compliance"));

				String input_details = obj.toString();
				System.out.println("ff" + input_details);
				
				web_service_response = cls_compliance
						.send_compliance_message_post(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("send_compliance_focal_person_message")) {
				JSONObject obj = new JSONObject();
				obj.put("send_by_name", (String) session.getAttribute("fullname"));
				obj.put("send_by_id", (String) session.getAttribute("userid"));
				obj.put("send_to_id", request.getParameter("officer_id"));
				obj.put("send_to_name", request.getParameter("officer_name"));
				obj.put("list_of_application", request.getParameter("job_numbers"));
				obj.put("message_type", request.getParameter("message_type"));
				obj.put("message", request.getParameter("message"));

				String input_details = obj.toString();
				System.out.println("ff" + input_details);
				
				web_service_response = cls_compliance
						.send_compliance_focal_person_message(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("update_compliance_application_notice")) {
				JSONObject obj = new JSONObject();
				obj.put("job_number", request.getParameter("job_number"));

				String input_details = obj.toString();
				// System.out.println("ff" + input_details);
				web_service_response = cls_compliance
						.update_compliance_application_notice(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("select_responses_on_compliance_application_notice")) {
				JSONObject obj = new JSONObject();
				obj.put("notice_id", request.getParameter("notice_id"));

				String input_details = obj.toString();
				// System.out.println("ff" + input_details);
				web_service_response = cls_compliance
						.select_responses_on_compliance_application_notice(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			return web_service_response;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
