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
public class DashboardAppsWithDivision {
	ws_compliance cls_compliance = new ws_compliance();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/DashboardAppsWithDivision")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String requestType = request.getParameter("request_type");

			// System.out.println(String.format("Log level: %s", requestType));
			// HttpSession session = request.getSession();
			String region_id = (String) (request.getParameter("region_id") != null
					? request.getParameter("region_id")
					: (String) session.getAttribute("regional_code"));

			String web_service_response = null;

			if (requestType.equals("apps_with_division_units")) {
				String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				obj.put("division", division);
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.report_dashboard_units_with_apps_post(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (requestType.equals("apps_with_division_officers")) {
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
						.report_dashboard_officers_within_units_with_apps_post(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (requestType.equals("apps_with_division_applications")) {
				String staff = request.getParameter("staff");

				// System.out.println(staff);

				JSONObject obj = new JSONObject();
				obj.put("staff_id", staff);
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance.report_dashboard_applications_with_officers_post(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (requestType.equals("reminder_apps_officers")) {
				String unit_name = (String) session.getAttribute("unit_name");
				String division = (String) session.getAttribute("division");

				// System.out.println(staff);

				JSONObject obj = new JSONObject();
				obj.put("unit_name", unit_name);
				obj.put("division", division);
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				//System.out.println(input_details);

				web_service_response = cls_compliance.select_reminder_apps_from_complaince_notice_by_unit(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (requestType.equals("warning_apps_officers")) {
				String unit_name = (String) session.getAttribute("unit_name");
				String division = (String) session.getAttribute("division");

				// System.out.println(staff);

				JSONObject obj = new JSONObject();
				obj.put("unit_name", unit_name);
				obj.put("division", division);
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				System.out.println(input_details);

				web_service_response = cls_compliance.select_warning_apps_from_complaince_notice_by_unit(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (requestType.equals("send_reminder_jobs_to_active")) {
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				JSONObject obj = new JSONObject();

				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("message_type", "Reminder");
				obj.put("list_of_application", request.getParameter("job_numbers"));
				
				String input_details = obj.toString();

				System.out.println(input_details);

				web_service_response = cls_compliance.select_update_compliance_notice_to_active(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (requestType.equals("select_compliance_application_notice_by_unit")) {
				String unit_name = (String) session.getAttribute("unit_name");
				String division = (String) session.getAttribute("division");

				// System.out.println(staff);

				JSONObject obj = new JSONObject();
				obj.put("unit_name", unit_name);
				obj.put("division", division);
				obj.put("region_id", region_id);
				String input_details = obj.toString();

				System.out.println(input_details);

				web_service_response = cls_compliance.select_compliance_application_notice_by_unit(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					System.out.println(web_service_response);
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
