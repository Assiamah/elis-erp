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
public class DashboardAppsPastDueDate {
	ws_compliance cls_compliance = new ws_compliance();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/DashboardAppsPastDueDate")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String requestType = request.getParameter("request_type");
			// HttpSession session = request.getSession();
			String region_id = (String) (request.getParameter("region_id") != null
					? request.getParameter("region_id")
					: (String) session.getAttribute("regional_code"));

			// System.out.println(String.format("Log level: %s", requestType));

			String web_service_response = null;

			if (requestType.equals("apps_past_due_year_units")) {
				String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				obj.put("division", division);
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_units_with_apps_past_due_year_post(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (requestType.equals("apps_past_due_year_officers")) {
				String division = request.getParameter("division");
				String unit = request.getParameter("unit");

				// System.out.println(division);
				// System.out.println(unit);

				JSONObject obj = new JSONObject();
				obj.put("division", division);
				obj.put("unit", unit);
				obj.put("region_id", region_id);

				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_officers_within_units_with_apps_past_due_year_post(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (requestType.equals("apps_past_due_year_applications")) {
				String staff = request.getParameter("staff");

				// System.out.println(staff);

				JSONObject obj = new JSONObject();
				obj.put("staff_id", staff);
				obj.put("region_id", region_id);

				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_applications_with_officers_that_are_apps_past_due_year_post(
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
