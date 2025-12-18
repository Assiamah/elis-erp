package com.mit.elis.servlets;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import ws.casemgt.cls_lc_application_minutes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class lc_application_minutes_serv {

	@Autowired
	private Ws_url_config cls_url_config;

	cls_lc_application_minutes lc_application_minutes_cl = new cls_lc_application_minutes();

	@RequestMapping("/lc_application_minutes_serv")
	@PostMapping
	public String lc_application_minutes_serv(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// HttpSession session = request.getSession();
		try {
			String request_type = request.getParameter("request_type");

			String web_service_response = null;

			System.out.println(request_type);

			if (request_type.equals("select_lc_application_minutes_all_by_case_number")) {
				String case_number = request.getParameter("case_number");
				// System.out.println(case_number);
				web_service_response = lc_application_minutes_cl
						.select_lc_application_minutes_all_by_am_case_number(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								case_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lc_application_minutes_all_by_id")) {
				String case_number = request.getParameter("case_number");
				// System.out.println(case_number);
				web_service_response = lc_application_minutes_cl
						.select_lc_application_minutes_all_by_id(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), case_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lc_application_minutes_add_and_update")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String am_id = request.getParameter("am_id");
				String am_case_number = request.getParameter("am_case_number");
				String am_job_number = request.getParameter("am_job_number");
				String am_description = request.getParameter("am_description");
				String am_from_officer = request.getParameter("am_from_officer");
				String am_from_position = request.getParameter("am_from_position");
				String am_to_officer = request.getParameter("am_to_officer");
				String am_to_position = request.getParameter("am_to_position");
				String am_status = request.getParameter("am_status");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

				obj.put("am_id", am_id);
				obj.put("am_case_number", am_case_number);
				obj.put("am_job_number", am_job_number);
				obj.put("am_description", am_description);
				obj.put("am_from_officer", am_from_officer);
				obj.put("am_from_position", am_from_position);
				obj.put("am_to_officer", am_to_officer);
				obj.put("am_to_position", am_to_position);
				obj.put("am_status", am_status);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = lc_application_minutes_cl
						.select_lc_application_minutes_add_and_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("select_send_message_on_application")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				//String am_id = request.getParameter("am_id");
				String sms_case_number = request.getParameter("sms_case_number");
				String sms_job_number = request.getParameter("sms_job_number");
				String sms_description = request.getParameter("sms_description");
				String sms_from_officer = request.getParameter("sms_from_officer");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

				obj.put("sms_case_number", sms_case_number);
				obj.put("sms_job_number", sms_job_number);
				obj.put("sms_description", sms_description);
				obj.put("sms_from_officer", sms_from_officer);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = lc_application_minutes_cl
						.select_send_message_on_application(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("select_lc_application_notes_add_and_update")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String an_id = request.getParameter("an_id");
				String an_case_number = request.getParameter("an_case_number");
				String an_job_number = request.getParameter("an_job_number");
				String an_description = request.getParameter("an_description");
				String an_type = request.getParameter("an_type");
				String modified_by = (String) session.getAttribute("fullname");
				String division = (String) session.getAttribute("division");
				String modified_by_id = (String) session.getAttribute("userid");

				obj.put("an_id", an_id);
				obj.put("an_case_number", an_case_number);
				obj.put("an_job_number", an_job_number);
				obj.put("an_description", an_description);
				obj.put("an_division", division);
				obj.put("an_type", an_type);

				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = lc_application_minutes_cl
						.select_lc_application_notes_add_and_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			return web_service_response;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
