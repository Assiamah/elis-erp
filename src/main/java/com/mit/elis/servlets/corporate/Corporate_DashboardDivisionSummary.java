package com.mit.elis.servlets.corporate;
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

import com.mit.elis.class_common.Ws_url_config;
import org.springframework.ui.Model;
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
public class Corporate_DashboardDivisionSummary {
    
    ws_compliance cls_compliance = new ws_compliance();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/Corporate_DashboardDivisionSummary")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");
            String corp_id = request.getParameter("corp_id");

            System.out.println(corp_id);
			// HttpSession session = request.getSession();
			String region_id = (String) (request.getParameter("region_id") != null
					? request.getParameter("region_id")
					: (String) session.getAttribute("regional_code"));
			// System.out.println(String.format(" REGION FROM : %s",
			// region_id));

			String web_service_response = null;

			if (request_type.equals("summary_created_day")) {
				JSONObject obj = new JSONObject();
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_created_today_post(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_created_day_service_type")) {
				String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				obj.put("division", division);
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance.report_dashboard_created_day_by_division_post(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_created_day_service_type_applications")) {
				String service = request.getParameter("service");

				// System.out.println(service);

				JSONObject obj = new JSONObject();
				obj.put("service_type", service);
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_created_day_application_for_each_service_post(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_created_month")) {
				JSONObject obj = new JSONObject();
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_created_month_post(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_created_month_service_type")) {
				String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				obj.put("division", division);
				obj.put("region_id", region_id);

				String input_details = obj.toString();

				web_service_response = cls_compliance.report_dashboard_created_month_by_division_post(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_created_month_service_type_applications")) {
				String service = request.getParameter("service");

				// System.out.println(service);

				JSONObject obj = new JSONObject();
				obj.put("service_type", service);
				obj.put("region_id", region_id);

				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_created_month_application_for_each_service_post(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// //System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_completed_day")) {
				JSONObject obj = new JSONObject();
				obj.put("region_id", region_id);

				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_completed_today_post(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_completed_day_service_type")) {
				String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				obj.put("division", division);
				obj.put("region_id", region_id);

				String input_details = obj.toString();
				web_service_response = cls_compliance.report_dashboard_completed_day_by_division_post(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_completed_day_service_type_applications")) {
				String service = request.getParameter("service");

				// System.out.println(service);

				JSONObject obj = new JSONObject();
				obj.put("service_type", service);
				obj.put("region_id", region_id);

				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_completed_day_application_for_each_service_post(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_completed_month")) {
				JSONObject obj = new JSONObject();
				obj.put("region_id", region_id);
				String input_details = obj.toString();
				System.out.println("testing comp  by divsion: " + input_details);

				web_service_response = cls_compliance
						.report_dashboard_completed_month_post(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_completed_month_service_type")) {
				String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				obj.put("division", division);
				obj.put("region_id", region_id);
				String input_details = obj.toString();
				System.out.println("testing comp  by service: " + input_details);

				web_service_response = cls_compliance.report_dashboard_completed_month_by_division_post(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("summary_completed_month_service_type_applications")) {
				String service = request.getParameter("service");

				// System.out.println(service);

				JSONObject obj = new JSONObject();
				obj.put("service_type", service);
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_completed_month_application_for_each_service_post(
								cls_url_config.getWeb_service_url_ser(),
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
