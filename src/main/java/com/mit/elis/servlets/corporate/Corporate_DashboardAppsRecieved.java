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

public class Corporate_DashboardAppsRecieved {
    ws_compliance cls_compliance = new ws_compliance();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/Corporate_DashboardAppsRecieved")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String incoming_requestType = request.getParameter("request_type");

				String requestType = null;
				String corp_id = null;
				String additionalInfo = null;

				if (incoming_requestType != null && incoming_requestType.contains("-")) {
					String[] split = incoming_requestType.split("-", 2); // Split at the first hyphen
					requestType = split[0];
					corp_id = split[1];

					System.out.println("Request Type: " + requestType);
					System.out.println("Corp ID: " + corp_id);
				}

				if (corp_id != null && corp_id.contains("+")) {
					String[] splitAfterPlus = corp_id.split("\\+", 2); // Split at the first plus
					corp_id = splitAfterPlus[0];
					additionalInfo = splitAfterPlus[1];

					System.out.println("Corp ID after splitting: " + corp_id);
					System.out.println("Additional Info: " + additionalInfo);
				}



			String region_id = (String) (request.getParameter("region_id") != null
					? request.getParameter("region_id")
					: (String) session.getAttribute("regional_code"));

			String web_service_response = null;

			if (requestType.equals("apps_created_year")) {
				String division = request.getParameter("division");
                String created_for_id = request.getParameter("created_for_id");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				obj.put("division", corp_id);
				obj.put("created_for_id", additionalInfo);
				String input_details = obj.toString();

				web_service_response = cls_compliance.corporate_applications_report_dashboard_created_year_by_divisio(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (requestType.equals("apps_created_year_applications")) {
				String service = request.getParameter("service");
                

				// System.out.println(service);

				JSONObject obj = new JSONObject();
				obj.put("service_type", corp_id);
				obj.put("created_for_id", additionalInfo);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.corporate_applications_report_dashboard_created_year_by_service(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}



            if (requestType.equals("apps_completed_year")) {
				String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				obj.put("division", corp_id);
				obj.put("created_for_id", additionalInfo);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.corporate_applications_report_dashboard_completed_year_by_divis(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}



            if (requestType.equals("apps_completed_year_applications")) {
				String service = request.getParameter("service");

				System.out.println(service);

				JSONObject obj = new JSONObject();
				obj.put("service_type", corp_id);
				obj.put("created_for_id", additionalInfo);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.corporate_applications_report_dashboard_completed_year_by_servi(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}




            if (requestType.equals("apps_received_completed_year")) {
				String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				obj.put("division", corp_id);
				obj.put("created_for_id", additionalInfo);

				String input_details = obj.toString();

				web_service_response = cls_compliance
						.corporate_applications_report_dashboard_created_completed_year(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}



            if (requestType.equals("apps_received_completed_year_applications")) {
				String service = request.getParameter("service");

				// System.out.println(service);

				JSONObject obj = new JSONObject();
				obj.put("service_type", corp_id);
				obj.put("created_for_id", additionalInfo);

				System.out.println(service);
                System.out.println(corp_id);



				String input_details = obj.toString();

				web_service_response = cls_compliance
						.corporate_applications_report_dashboard_created_completed(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}





            if (requestType.equals("corporate_apps_past_due")) {
				// String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				// obj.put("division", division);
				obj.put("unit_id", corp_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.corporate_applications_report_dashboard_apps_past_due_officer(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}




			if (requestType.equals("corporate_apps_past_due_applications")) {
				// String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				// obj.put("division", division);
				obj.put("staff_id", corp_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.corporate_applications_report_dashboard_apps_past_due_appss(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}






			if (requestType.equals("apps_with_division")) {
				// String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				// obj.put("division", division);
				obj.put("unit_code", corp_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.corporate_processing_units_staff(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}




			if (requestType.equals("apps_with_division_services")) {
				// String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				// obj.put("division", division);
				obj.put("recieved_by_id", corp_id);
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.corporate_applications_report_dashboard_by_subservice(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}




			if (requestType.equals("apps_with_division_applications")) {
				// String division = request.getParameter("division");

				// System.out.println(division);

				JSONObject obj = new JSONObject();
				// obj.put("division", division);
				obj.put("staff_id", additionalInfo);
				obj.put("sub_process_id", corp_id);
				
				String input_details = obj.toString();

				web_service_response = cls_compliance
						.corporate_processing_units_application_with_stamping_staff(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								input_details);
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
