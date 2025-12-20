package com.mit.elis.servlets;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.CSAU_billgeneration;
import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import ws.casemgt.ws_sms;
import ws.rentmgt.Ws_rent_mgt;
import ws.users.Ws_users;
import org.springframework.ui.Model;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;
import com.mit.elis.class_common.cls_sms;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;

@RestController
public class Case_Management_Serv {
	@Autowired
	private Ws_url_config cls_url_config;

	Ws_client_application casemgt_cl = new Ws_client_application();

	CSAU_billgeneration billgeneration_cl = new CSAU_billgeneration();
	cls_casemgt casemgt_cl_m = new cls_casemgt();

	Ws_client_application user_web_service = new Ws_client_application();

	Ws_rent_mgt rent_mgt_service = new Ws_rent_mgt();

	Ws_url_config ws_url_config = new Ws_url_config();
	ws_sms sms_sl = new ws_sms();
	Ws_users users_sl = new Ws_users();

	@RequestMapping("/Case_Management_Serv_session")
	@GetMapping
	public String doGet(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// HttpSession session = request.getSession();
		String web_service_response = null;
		JSONObject obj = new JSONObject();
		// System.out.println("test job: ");

		// session.invalidate();

		// JSONObject obj = new JSONObject();
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			try {
				obj.put("success", "false");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			// refresh the session timeout
			session.setMaxInactiveInterval(25 * 60);
			//
			try {
				obj.put("success", "true");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		web_service_response = obj.toString();

		if (web_service_response != null) {
			// System.out.println(web_service_response);
		} else {
			// System.out.println(web_service_response);
		}
		System.out.println(web_service_response);
		return web_service_response;
	}

	@RequestMapping("/Case_Management_Serv")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		String web_service_response = null;

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// HttpSession session = request.getSession();

		try {
			String request_type = request.getParameter("request_type");

			billgeneration_cl.web_compname = (String) session.getAttribute("web_compname");
			billgeneration_cl.web_comp_address = (String) session.getAttribute("web_comp_address");
			billgeneration_cl.web_city = (String) session.getAttribute("web_city");
			billgeneration_cl.web_fax_number = (String) session.getAttribute("web_fax_number");
			billgeneration_cl.web_telephone = (String) session.getAttribute("web_telephone");
			billgeneration_cl.web_email = (String) session.getAttribute("web_email");
			billgeneration_cl.web_branch_of_csau = (String) session.getAttribute("web_branch_of_csau");
			billgeneration_cl.web_rlo = (String) session.getAttribute("web_rlo");
			billgeneration_cl.web_regional_accountant = (String) session.getAttribute("web_regional_accountant");
			billgeneration_cl.web_head_of_csau = (String) session.getAttribute("web_head_of_csau");
			billgeneration_cl.web_chairman_regional_land_commission = (String) session.getAttribute("web_chairman_regional_land_commission");
			billgeneration_cl.web_office_region = (String) session.getAttribute("web_office_region");

			// System.out.println(request_type);

			if (request_type.equals("update_application_details")) {

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String ar_name = request.getParameter("ar_name");
				String region = request.getParameter("region");
				String district = request.getParameter("district");
				String locality = request.getParameter("locality");
				String transaction_number = request.getParameter("transaction_number");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
							

				JSONObject obj = new JSONObject();
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("ar_name", ar_name);
				obj.put("region", region);
				obj.put("district", district);
				obj.put("locality", locality);
				obj.put("transaction_number", transaction_number);

obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				web_service_response = casemgt_cl_m.update_application_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				if (web_service_response != null) {
				
				}

				return web_service_response;
			}
			if (request_type.equals("load_application_assigned_by_division_cst")) {
				String division = request.getParameter("division");
				web_service_response = casemgt_cl_m
						.load_application_assigned_by_division_cst(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), division);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				}
				return web_service_response;
			}

			if (request_type.equals("load_application_assigned_to_staff_cst")) {
				String userid = request.getParameter("userid");
				// System.out.println("teting:" + userid);
				web_service_response = casemgt_cl_m
						.load_application_assigned_to_staff_cst(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), userid);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				}
				return web_service_response;
			}

			if (request_type.equals("load_corporate_app_assigned_to_staff_frrv_cst")) {
				String userid = request.getParameter("userid");
				// System.out.println("teting:" + userid);
				web_service_response = casemgt_cl_m
						.load_corporate_app_assigned_to_staff_frrv_cst(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), userid);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				}
				return web_service_response;
			}

			if (request_type.equals("load_cst_unit_summary")) {
				String summary_type = request.getParameter("summary_type");
				// System.out.println("teting:" + userid);
				web_service_response = casemgt_cl_m
						.load_cst_unit_summary(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), summary_type);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_corporate_frrv_cst_unit_summary")) {
				String summary_type = request.getParameter("summary_type");
				// System.out.println("teting:" + userid);
				web_service_response = casemgt_cl_m
						.load_corporate_frrv_cst_unit_summary(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), summary_type);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_cst_unit_chart_summary")) {
				String division_name = request.getParameter("division_name");
				String application_type = request.getParameter("application_type");

				JSONObject obj = new JSONObject();
				obj.put("division_name", division_name);
				obj.put("application_type", application_type);

				// System.out.println("teting:" + userid);
				web_service_response = casemgt_cl_m
						.load_cst_unit_chart_summary(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_corporate_frrv_cst_unit_chart_summary")) {
				String division_name = request.getParameter("division_name");
				String application_type = request.getParameter("application_type");

				JSONObject obj = new JSONObject();
				obj.put("division_name", division_name);
				obj.put("application_type", application_type);

				// System.out.println("teting:" + userid);
				web_service_response = casemgt_cl_m
						.load_corporate_frrv_cst_unit_chart_summary(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_applicant_details_by_job_number")) {
				String userid = request.getParameter("job_number");
				// System.out.println("teting:" + userid);
				web_service_response = casemgt_cl_m
						.load_applicant_details_by_job_number(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), userid);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("compliance_create_notice_reply")) {

				String notice_id = request.getParameter("notice_id");
				String message = request.getParameter("message");

				JSONObject obj = new JSONObject();
				obj.put("notice_id", notice_id);
				obj.put("message", message);
				obj.put("send_by_name", (String) session.getAttribute("fullname"));
				obj.put("send_by_id", (String) session.getAttribute("userid"));

				web_service_response = casemgt_cl_m
						.compliance_create_notice_reply(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				if (web_service_response != null) {

				}

				return web_service_response;
			}
			if (request_type.equals("get_lc_list_notifications")) {

				String user_id = (String) session.getAttribute("userid");
				// System.out.println("user_id");
				// System.out.println(user_id);
				web_service_response = casemgt_cl_m.get_lc_list_notifications(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						user_id);
				System.out.println(web_service_response);
				if (web_service_response != null) {

				}

				return web_service_response;
			}

			if (request_type.equals("get_lc_list_messages")) {
				String user_id = (String) session.getAttribute("userid");
				// System.out.println("user_id");
				// System.out.println(user_id);
				web_service_response = casemgt_cl_m.get_lc_list_messages(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						user_id);
				System.out.println(web_service_response);
				if (web_service_response != null) {

				}

				return web_service_response;
			}

			if (request_type.equals("report_dashboard_all_by_user")) {

				String user_id = (String) session.getAttribute("userid");

				web_service_response = casemgt_cl_m
						.report_dashboard_all_by_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), user_id);

				if (web_service_response != null) {

				}
				return web_service_response;
			}


			if (request_type.equals("select_application_correction_request")) {

				String user_id = (String) session.getAttribute("userid");

				web_service_response = casemgt_cl_m
						.select_application_correction_request(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), user_id);

				if (web_service_response != null) {

				}
				return web_service_response;
			}


			
			if (request_type.equals("report_dashboard_apps_comp_month_by_user")) {

				String user_id = (String) session.getAttribute("userid");

				web_service_response = casemgt_cl_m
						.report_dashboard_apps_comp_month_by_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), user_id);

				if (web_service_response != null) {

				}
				return web_service_response;
			}
			if (request_type.equals("report_dashboard_apps_rec_month_by_user")) {

				String user_id = (String) session.getAttribute("userid");

				web_service_response = casemgt_cl_m
						.report_dashboard_apps_rec_month_by_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), user_id);

				if (web_service_response != null) {

				}

				return web_service_response;
			}
			if (request_type.equals("report_dashboard_apps_past_due_date_by_user")) {

				String user_id = (String) session.getAttribute("userid");

				web_service_response = casemgt_cl_m
						.report_dashboard_apps_past_due_date_by_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), user_id);

				if (web_service_response != null) {

				}

				return web_service_response;
			}

			if (request_type.equals("report_dashboard_corp_apps_past_due_date_by_user")) {

				String user_id = (String) session.getAttribute("userid");

				web_service_response = casemgt_cl_m
						.report_dashboard_corp_apps_past_due_date_by_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), user_id);

				if (web_service_response != null) {

				}

				return web_service_response;
			}

			if (request_type.equals("load_application_batched_to_user_new")) {

				String user_id = (String) session.getAttribute("userid");

				web_service_response = casemgt_cl_m
						.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), user_id);

				if (web_service_response != null) {

				}

				return web_service_response;
			}

			if (request_type.equals("load_corporate_application_batched_to_user_new")) {

				String user_id = (String) session.getAttribute("userid");

				web_service_response = casemgt_cl_m
						.load_corporate_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), user_id);

				if (web_service_response != null) {

				}

				return web_service_response;
			}

			if (request_type.equals("check_session_expired")) {

				// System.out.println("test job: ");
				JSONObject obj = new JSONObject();
				if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
					// Session is expired
					obj.put("success", "false");
				} else {
					// refresh the session timeout
					session.setMaxInactiveInterval(25 * 60);
					//
					obj.put("success", "true");
				}
				web_service_response = obj.toString();

				if (web_service_response != null) {
					// System.out.println("out " + web_service_response);
				} else {
					System.out.println("Else " + web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_list_of_district")) {
				String region_id = request.getParameter("region_id");
				// System.out.println("test job: " + region_id);

				JSONObject obj = new JSONObject();
				obj.put("region_code", region_id);

				web_service_response = user_web_service.get_list_of_district(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");
				System.out.println("test Region: " + region_id);
				if (web_service_response != null) {
					// System.out.println("out " + web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_list_of_locality")) {
				String region_id = request.getParameter("region_id");
				System.out.println("test job: " + region_id);

				JSONObject obj = new JSONObject();
				obj.put("region_code", region_id);
				// System.out.println("test job: " + obj.toString(0));
				web_service_response = user_web_service.get_locality_by_region(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				// System.out.println("test job: " + web_service_response);
				web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println("out " + web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			/*
			 * if (request_type.equals(
			 * "load_application_cabinet_details_by_job_number")) { String
			 * job_number = request.getParameter("job_number");
			 * System.out.println("test job: " + job_number);
			 * web_service_response =
			 * casemgt_cl.load_application_cabinet_details_by_job_number(
			 * job_number);
			 * 
			 * JSONObject jsonobj = new JSONObject(web_service_response); //
			 * web_service_response = (String) jsonobj.getString("data");
			 * 
			 * if (web_service_response != null) { System.out.println("out " +
			 * web_service_response); } else {
			 * System.out.println(web_service_response); } PrintWriter out =
			 * response.getWriter(); out.println(jsonobj.toString()); }
			 */

			if (request_type.equals("reverse_acknowledgement")) {

				String ms_id = request.getParameter("ms_id");
				String business_process_sub_id = request.getParameter("business_process_sub_id");
				String business_process_id = request.getParameter("business_process_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				obj.put("ms_id", ms_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				obj.put("business_process_id", business_process_id);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);
				String input_details = obj.toString();
				web_service_response = casemgt_cl_m.lc_checklist_remove(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
				return web_service_response;
			}

			if (request_type.equals("lc_stamp_duty_document_received")) {

				String job_number = request.getParameter("job_number");
				String depositor_name = request.getParameter("smtp_depositor_name");
				String depositor_phone = request.getParameter("smtp_depositor_phone");
				String doc_description = request.getParameter("smtp_document_description");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

                String fullname =  (String) session.getAttribute("fullname");
                String userid =  (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("depositor_phone", depositor_phone);
				obj.put("depositor_name", depositor_name);
				obj.put("created_by", modified_by);
				obj.put("created_by_id", modified_by_id);
				obj.put("doc_description", doc_description);
				obj.put("fullname", fullname);
                obj.put("userid", userid); 
                obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);
				web_service_response = casemgt_cl_m
						.lc_stamp_duty_document_received(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
				return web_service_response;
			}

			if (request_type.equals("lc_regional_stamp_duty_bill_log")) {

				String job_number = request.getParameter("job_number");
				String ref_number = request.getParameter("ref_number");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				obj.put("job_number", job_number);
				obj.put("ref_number", ref_number);
				obj.put("created_by", modified_by);
				obj.put("created_by_id", modified_by_id);
				obj.put("fullname", fullname);
                obj.put("userid", userid); 
                obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);
				web_service_response = casemgt_cl_m
						.lc_regional_stamp_duty_bill_log(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("account_report_on_bill_by_dates_gra")) {

				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
				LocalDateTime now = LocalDateTime.now();
				JSONObject obj = new JSONObject();
				String date_from = (String) request.getParameter("date_from") != null
						? request.getParameter("date_from")
						: dtf.format(now);
				String date_to = (String) request.getParameter("date_to") != null ? request.getParameter("date_to")
						: dtf.format(now);
				String region_id = (String) (request.getParameter("region_id") != null
						? request.getParameter("region_id")
						: (String) session.getAttribute("regional_code"));
				// String type = (String) (request.getParameter("type") != null
				// ? request.getParameter("type") : "values");

				obj.put("date_from", date_from);
				obj.put("date_to", date_to);
				obj.put("region_id", region_id);

				// System.out.println("account_report_on_received_gra : " +
				// obj.toString());
				web_service_response = casemgt_cl_m
						.account_report_on_bill_by_dates_gra(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("account_report_on_ground_rent_bill_update")) {

				JSONObject obj = new JSONObject();
				String ref_number = (String) request.getParameter("ref_number") != null
						? request.getParameter("ref_number")
						: "";

				obj.put("ref_number", ref_number);
				web_service_response = casemgt_cl_m.account_report_on_ground_rent_bill_update(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("account_report_on_received_gra")) {
				// System.out.println("account_report_on_received_gra :1 ");

				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
				LocalDateTime now = LocalDateTime.now();
				JSONObject obj = new JSONObject();
				String date_from = (String) request.getParameter("date_from") != null
						? request.getParameter("date_from")
						: dtf.format(now);
				String date_to = (String) request.getParameter("date_to") != null ? request.getParameter("date_to")
						: dtf.format(now);
				String region_id = (String) (request.getParameter("region_id") != null
						? request.getParameter("region_id")
						: (String) session.getAttribute("regional_code"));
				// String type = (String) (request.getParameter("type") != null
				// ? request.getParameter("type") : "values");

				obj.put("date_from", date_from);
				obj.put("date_to", date_to);
				obj.put("region_id", region_id);

				// System.out.println("account_report_on_received_gra : " +
				// obj.toString());
				web_service_response = casemgt_cl_m
						.account_report_on_received_gra(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("select_update_application_as_work_done")) {

				String job_number = request.getParameter("job_number");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String unit_id = (String) session.getAttribute("unit_id");
				String unit_name = (String) session.getAttribute("unit_name");
				String job_purpose = request.getParameter("job_purpose");


String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");
			

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("unit_id", unit_id);
				obj.put("unit_name", unit_name);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("job_purpose", job_purpose);

obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);



				web_service_response = casemgt_cl_m.select_update_application_as_work_done(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("select_update_application_as_approve_work_done")) {

				String job_number = request.getParameter("job_number");
				String job_purpose = request.getParameter("job_purpose");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String unit_id = (String) session.getAttribute("unit_id");
				String unit_name = (String) session.getAttribute("unit_name");


String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");
			

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("job_purpose", job_purpose);
				obj.put("unit_id", unit_id);
				obj.put("unit_name", unit_name);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

System.out.print(obj.toString());

				web_service_response = casemgt_cl_m.select_update_application_as_approve_work_done(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_update_application_as_request_queried")) {

				String job_number = request.getParameter("job_number");
				String job_purpose = request.getParameter("job_purpose");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String unit_id = (String) session.getAttribute("unit_id");
				String unit_name = (String) session.getAttribute("unit_name");
String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");
String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");
			

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("job_purpose", job_purpose);
				obj.put("unit_id", unit_id);
				obj.put("unit_name", unit_name);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				web_service_response = casemgt_cl_m.select_update_application_as_request_queried(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
				return web_service_response;
			}

			if (request_type.equals("select_update_application_as_work_done_frrv")) {
				String job_number = request.getParameter("job_number");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String unit_id = (String) session.getAttribute("unit_id");
				String unit_name = (String) session.getAttribute("unit_name");
				String division = (String) session.getAttribute("division");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				String job_purpose = request.getParameter("job_purpose");
				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("unit_id", unit_id);
				obj.put("unit_name", unit_name);
				obj.put("division", division);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);
				obj.put("job_purpose", job_purpose);
				web_service_response = casemgt_cl_m.select_update_application_as_work_done_frrv(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("lc_checklist_remove")) {

				String ms_id = request.getParameter("ms_id");
				String business_process_sub_id = request.getParameter("business_process_sub_id");
				String business_process_id = request.getParameter("business_process_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
							


				JSONObject obj = new JSONObject();

				obj.put("ms_id", ms_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				obj.put("business_process_id", business_process_id);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

				obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input_details = obj.toString();
				web_service_response = casemgt_cl_m.lc_checklist_remove(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_lc_add_update_district")) {

				String district_id = request.getParameter("district_id");
				String district_name = request.getParameter("district_name");
				String region_id = request.getParameter("region_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");
			

				JSONObject obj = new JSONObject();
				obj.put("district_id", district_id);
				obj.put("district_name", district_name);
				obj.put("region_id", region_id);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				web_service_response = casemgt_cl_m
						.select_lc_add_update_district(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("select_lc_add_update_locality")) {

				String locality_id = request.getParameter("locality_id");
				String locality_name = request.getParameter("locality_name");

				String office_id = request.getParameter("office_id");
				String office_name = request.getParameter("office_name");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
							
				


				JSONObject obj = new JSONObject();

				obj.put("locality_id", locality_id);
				obj.put("locality_name", locality_name);

				obj.put("office_id", office_id);
				obj.put("office_name", office_name);

				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

				obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				web_service_response = casemgt_cl_m
						.select_lc_add_update_locality(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_lc_add_update_unit")) {

				String unit_id = request.getParameter("unit_id");
				String unit_name = request.getParameter("unit_name");

				String office_id = request.getParameter("office_id");
				String office_name = request.getParameter("office_name");
				String divisions = request.getParameter("divisions");
				String status = request.getParameter("status");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();

				obj.put("unit_id", unit_id);
				obj.put("unit_name", unit_name);

				obj.put("office_id", office_id);
				obj.put("office_name", office_name);
				obj.put("divisions", divisions);
				obj.put("status", status);

				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
			
				web_service_response = casemgt_cl_m.select_lc_add_update_unit(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("checklist_add_and_update")) {

				String ms_id = request.getParameter("ms_id");
				String checklist_description = request.getParameter("checklist_description");
				String checklist_priority_value = request.getParameter("checklist_priority_value");
				String checklist_option = request.getParameter("checklist_option");

				String business_process_sub_id = request.getParameter("business_process_sub_id");
				String business_process_id = request.getParameter("business_process_id");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");
		

				JSONObject obj = new JSONObject();

				obj.put("ms_id", ms_id);
				obj.put("checklist_description", checklist_description);
				obj.put("checklist_priority_value", checklist_priority_value);
				obj.put("checklist_option", checklist_option);
				obj.put("business_process_sub_id", business_process_sub_id);
				obj.put("business_process_id", business_process_id);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);



				// obj.put("case_number", case_number);

				String input_details = obj.toString();

				web_service_response = casemgt_cl_m.checklist_add_and_update(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("lc_milestones_remove")) {

				String ms_id = request.getParameter("ms_id");
				String business_process_sub_id = request.getParameter("business_process_sub_id");
				String business_process_id = request.getParameter("business_process_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();

				obj.put("ms_id", ms_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				obj.put("business_process_id", business_process_id);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				// obj.put("case_number", case_number);

				String input_details = obj.toString();

				web_service_response = casemgt_cl_m.lc_milestones_remove(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("select_lc_checlist_remove")) {

				String ms_id = request.getParameter("ms_id");
				String business_process_sub_id = request.getParameter("business_process_sub_id");
				String business_process_id = request.getParameter("business_process_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

        String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();

				obj.put("ms_id", ms_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				obj.put("business_process_id", business_process_id);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				// obj.put("case_number", case_number);

				String input_details = obj.toString();
				web_service_response = casemgt_cl_m.select_lc_checlist_remove(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
				return web_service_response;
			}
			if (request_type.equals("milestones_add_and_update")) {

				String ms_id = request.getParameter("ms_id");
				String milestone_description = request.getParameter("milestone_description");
				String mile_stone_status = request.getParameter("mile_stone_status");
				String mile_stone_option = request.getParameter("mile_stone_option");
				String priority_value = request.getParameter("priority_value");
				String working_day_required = request.getParameter("working_day_required");
				String milestone_app_link = request.getParameter("milestone_app_link");
				String milestone_link = request.getParameter("milestone_link");
				String milestone_text_message = request.getParameter("milestone_text_message");
				String milestone_app_message = request.getParameter("milestone_app_message");
				String milestone_remaining = request.getParameter("milestone_remaining");
				String business_process_sub_id = request.getParameter("business_process_sub_id");
				String business_process_id = request.getParameter("business_process_id");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();

				obj.put("ms_id", ms_id);
				obj.put("milestone_description", milestone_description);
				obj.put("mile_stone_status", mile_stone_status);
				obj.put("mile_stone_option", mile_stone_option);
				obj.put("priority_value", priority_value);
				obj.put("working_day_required", working_day_required);
				obj.put("milestone_app_link", milestone_app_link);
				obj.put("milestone_link", milestone_link);
				obj.put("milestone_text_message", milestone_text_message);
				obj.put("milestone_app_message", milestone_app_message);
				obj.put("milestone_remaining", milestone_remaining);
				obj.put("business_process_sub_id", business_process_sub_id);
				obj.put("business_process_id", business_process_id);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				// obj.put("case_number", case_number);

				String input_details = obj.toString();
				web_service_response = casemgt_cl_m.milestones_add_and_update(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_application_milestone_for_tracking_by_job")) {
				String job_number = request.getParameter("job_number");
				// System.out.println(job_number);

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				web_service_response = casemgt_cl.load_application_milestone_for_tracking_by_job(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				// web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("load_application_details_for_enquiries")) {
				String job_number = request.getParameter("job_number");
				String search_type = request.getParameter("search_type");
				// System.out.println(job_number);

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("search_type", search_type);

				web_service_response = casemgt_cl.load_application_details_for_enquiries(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_application_details_for_enquiries_stamping")) {
				String job_number = request.getParameter("job_number");
				String search_type = request.getParameter("search_type");
				// System.out.println(job_number);

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("search_type", search_type);

				System.out.println(obj.toString());
				web_service_response = casemgt_cl.load_application_details_for_enquiries_stamping(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");
				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_application_details_for_enquiries_stamping")) {
				String job_number = request.getParameter("job_number");
				String search_type = request.getParameter("search_type");
				// System.out.println(job_number);

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("search_type", search_type);

				System.out.println(obj.toString());
				web_service_response = casemgt_cl.load_application_details_for_enquiries_stamping(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");
				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_application_file_location")) {
				String batch_number = request.getParameter("job_number");
				// System.out.println(batch_number);
				web_service_response = casemgt_cl
						.load_application_file_location(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), batch_number);

				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_applications_by_batchlist")) {
				String batch_number = request.getParameter("job_number");
				// System.out.println(batch_number);
				web_service_response = casemgt_cl
						.load_applications_by_batchlist(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), batch_number);

				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("add_application_to_publication_list")) {
				String job_number = request.getParameter("case_number");
				// System.out.println(job_number);
				web_service_response = casemgt_cl
						.add_application_to_publication_list(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), job_number);

				// JSONObject jsonobj = new JSONObject(web_service_response);
				// web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_application_details_by_job_number")) {

				String job_number = request.getParameter("job_number");
				String unit_name = (String) session.getAttribute("unit_name");
				String division_name = (String) session.getAttribute("division");

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("unit_name", unit_name);
				obj.put("division_name", division_name);

				System.out.println(obj.toString());
				web_service_response = casemgt_cl.online_select_application_details_by_job_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_application_details_by_job_number_or_certificate_number")) {

				String job_number = request.getParameter("job_number");
				String unit_name = (String) session.getAttribute("unit_name");
				String division_name = (String) session.getAttribute("division");

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("unit_name", unit_name);
				obj.put("division_name", division_name);

				System.out.println(obj.toString());
				web_service_response = casemgt_cl.online_select_application_details_by_job_number_or_certificate_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_archived_application_details_by_job_number")) {

				String job_number = request.getParameter("job_number");
				String unit_name = (String) session.getAttribute("unit_name");
				String unit_id = (String) session.getAttribute("unit_id");
				String division = (String) session.getAttribute("division");
				String user_id = (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("unit_name", unit_name);
				obj.put("unit_id", unit_id);
				obj.put("division", division);
				obj.put("user_id", user_id);

				System.out.println(obj.toString());

				web_service_response = casemgt_cl.online_select_archived_application_details_by_job_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("further_entries_update_case")) {

				String case_number = request.getParameter("case_number");
				String annual_rent = request.getParameter("annual_rent");
				String commencement_date = request.getParameter("commencement_date");
				String date_of_registration = request.getParameter("date_of_registration");

				String stool_family_name = request.getParameter("stool_family_name");
				String term = request.getParameter("term");
				String date_of_document = request.getParameter("date_of_document");
				String consideration_fee = request.getParameter("consideration_fee");
				String consideration_currency = request.getParameter("consideration_currency");
				String extent = request.getParameter("extent");
				String size_of_land = request.getParameter("size_of_land");
				String renewal_term = request.getParameter("renewal_term");
				String type_of_interest = request.getParameter("type_of_interest");
				String nature_of_instrument = request.getParameter("nature_of_instrument");
				String type_of_use = request.getParameter("type_of_use");
				String family_of_grantor = request.getParameter("family_of_grantor");
				String transaction_number = request.getParameter("transaction_number");
				String client_name = request.getParameter("client_name");
				String business_process_sub_name = request.getParameter("business_process_sub_name");
				String job_number = request.getParameter("job_number");
				String surveyor_number = request.getParameter("surveyor_number");
				String regional_number = request.getParameter("regional_number");
				String land_size = request.getParameter("land_size");
				String district = request.getParameter("district");
				String region = request.getParameter("region");
				String locality = request.getParameter("locality");
				String file_number = request.getParameter("file_number");
				String registry_mapref = request.getParameter("registry_mapref");

				String date_of_issue = request.getParameter("date_of_issue");
				String registered_number = request.getParameter("registered_number");
				String certificate_type = request.getParameter("certificate_type");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				JSONObject obj = new JSONObject();

				obj.put("modified_by_id", modified_by_id);
				obj.put("modified_by", modified_by);
				obj.put("type_of_use", type_of_use);
				obj.put("nature_of_instrument", nature_of_instrument);
				obj.put("type_of_interest", type_of_interest);
				obj.put("size_of_land", size_of_land);
				obj.put("extent", extent);
				obj.put("consideration_fee", consideration_fee);
				obj.put("consideration_currency", consideration_currency);
				obj.put("date_of_document", date_of_document);
				obj.put("term", term);
				obj.put("family_of_grantor", family_of_grantor);
				obj.put("renewal_term", renewal_term);
				obj.put("stool_family_name", stool_family_name);
				obj.put("commencement_date", commencement_date);
				obj.put("annual_rent", annual_rent);
				obj.put("case_number", case_number);
				obj.put("transaction_number", transaction_number);

				obj.put("client_name", client_name);
				obj.put("business_process_sub_name", business_process_sub_name);
				obj.put("job_number", job_number);
				obj.put("surveyor_number", surveyor_number);
				obj.put("regional_number", regional_number);
				obj.put("land_size", land_size);
				obj.put("locality", locality);
				obj.put("district", district);
				obj.put("region", region);
				obj.put("file_number", file_number);
				obj.put("registry_mapref", registry_mapref);

				obj.put("date_of_issue", date_of_issue);
				obj.put("registered_number", registered_number);
				obj.put("certificate_type", certificate_type);
				
				obj.put("date_of_registration", date_of_registration);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);



				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.further_entries_update_case(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("further_entries_update_case_for_publication")) {

				String case_number = request.getParameter("case_number");
				String extent = request.getParameter("extent");
				String type_of_interest = request.getParameter("type_of_interest");
				String transaction_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");
				String locality = request.getParameter("locality");;
				String registry_mapref = request.getParameter("registry_mapref");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();

				obj.put("modified_by_id", modified_by_id);
				obj.put("modified_by", modified_by);
				obj.put("type_of_interest", type_of_interest);
				obj.put("extent", extent);
				obj.put("case_number", case_number);
				obj.put("transaction_number", transaction_number);
				obj.put("job_number", job_number);
				obj.put("locality", locality);
				obj.put("registry_mapref", registry_mapref);

				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);



				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.further_entries_update_case_for_publication(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("further_entries_update_case_with_valuation")) {

				String case_number = request.getParameter("case_number");
				String annual_rent = request.getParameter("annual_rent");
				String commencement_date = request.getParameter("commencement_date");
				String stool_family_name = request.getParameter("stool_family_name");
				String term = request.getParameter("term");
				String date_of_document = request.getParameter("date_of_document");
				String consideration_fee = request.getParameter("consideration_fee");

				String consideration_currency = request.getParameter("consideration_currency");
				String extent = request.getParameter("extent");
				String size_of_land = request.getParameter("size_of_land");
				String renewal_term = request.getParameter("renewal_term");
				String type_of_interest = request.getParameter("type_of_interest");
				String nature_of_instrument = request.getParameter("nature_of_instrument");
				String type_of_use = request.getParameter("type_of_use");
				String family_of_grantor = request.getParameter("family_of_grantor");

				String transaction_number = request.getParameter("transaction_number");
				String client_name = request.getParameter("client_name");
				String business_process_sub_name = request.getParameter("business_process_sub_name");
				String job_number = request.getParameter("job_number");
				String surveyor_number = request.getParameter("surveyor_number");
				String regional_number = request.getParameter("regional_number");
				String land_size = request.getParameter("land_size");
				String district = request.getParameter("district");
				String region = request.getParameter("region");
				String locality = request.getParameter("locality");
				String file_number = request.getParameter("file_number");
				String registry_mapref = request.getParameter("registry_mapref");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

				String date_of_valuation = request.getParameter("date_of_valuation");
				String amount = request.getParameter("amount");
				String remarks = request.getParameter("remarks");
				String certificate_number  = request.getParameter("certificate_number");

				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();

				obj.put("modified_by_id", modified_by_id);
				obj.put("modified_by", modified_by);
				obj.put("type_of_use", type_of_use);
				obj.put("nature_of_instrument", nature_of_instrument);
				obj.put("type_of_interest", type_of_interest);
				obj.put("size_of_land", size_of_land);
				obj.put("extent", extent);
				obj.put("consideration_fee", consideration_fee);
				obj.put("consideration_currency", consideration_currency);
				obj.put("date_of_document", date_of_document);
				obj.put("term", term);
				obj.put("family_of_grantor", family_of_grantor);
				obj.put("renewal_term", renewal_term);
				obj.put("stool_family_name", stool_family_name);
				obj.put("commencement_date", commencement_date);
				obj.put("annual_rent", annual_rent);
				obj.put("case_number", case_number);
				obj.put("transaction_number", transaction_number);

				obj.put("client_name", client_name);
				obj.put("business_process_sub_name", business_process_sub_name);
				obj.put("job_number", job_number);
				obj.put("surveyor_number", surveyor_number);
				obj.put("regional_number", regional_number);
				obj.put("land_size", land_size);
				obj.put("locality", locality);
				obj.put("district", district);
				obj.put("region", region);
				obj.put("file_number", file_number);
				obj.put("registry_mapref", registry_mapref);
				obj.put("date_of_valuation", date_of_valuation);
				obj.put("amount", amount);
				obj.put("remarks", remarks);
				obj.put("certificate_number", certificate_number);


obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.further_entries_update_case_with_valuation(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("further_entries_update_case_certificate")) {

				String case_number = request.getParameter("case_number");
				String annual_rent = request.getParameter("annual_rent");
				String commencement_date = request.getParameter("commencement_date");
				String date_of_registration = request.getParameter("date_of_registration");

				String stool_family_name = request.getParameter("stool_family_name");
				String term = request.getParameter("term");
				String date_of_document = request.getParameter("date_of_document");
				String consideration_fee = request.getParameter("consideration_fee");
				String consideration_currency = request.getParameter("consideration_currency");
				String extent = request.getParameter("extent");
				String size_of_land = request.getParameter("size_of_land");
				String renewal_term = request.getParameter("renewal_term");
				String type_of_interest = request.getParameter("type_of_interest");
				String nature_of_instrument = request.getParameter("nature_of_instrument");
				String type_of_use = request.getParameter("type_of_use");
				String family_of_grantor = request.getParameter("family_of_grantor");
				String transaction_number = request.getParameter("transaction_number");
				String client_name = request.getParameter("client_name");
				String business_process_sub_name = request.getParameter("business_process_sub_name");
				String job_number = request.getParameter("job_number");
				String surveyor_number = request.getParameter("surveyor_number");
				String regional_number = request.getParameter("regional_number");
				String land_size = request.getParameter("land_size");
				String district = request.getParameter("district");
				String region = request.getParameter("region");
				String locality = request.getParameter("locality");
				String file_number = request.getParameter("file_number");
				String registry_mapref = request.getParameter("registry_mapref");

				String date_of_issue = request.getParameter("date_of_issue");
				String registered_number = request.getParameter("registered_number");
				String certificate_type = request.getParameter("certificate_type");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				JSONObject obj = new JSONObject();

				obj.put("modified_by_id", modified_by_id);
				obj.put("modified_by", modified_by);
				obj.put("type_of_use", type_of_use);
				obj.put("nature_of_instrument", nature_of_instrument);
				obj.put("type_of_interest", type_of_interest);
				obj.put("size_of_land", size_of_land);
				obj.put("extent", extent);
				obj.put("consideration_fee", consideration_fee);
				obj.put("consideration_currency", consideration_currency);
				obj.put("date_of_document", date_of_document);
				obj.put("term", term);
				obj.put("family_of_grantor", family_of_grantor);
				obj.put("renewal_term", renewal_term);
				obj.put("stool_family_name", stool_family_name);
				obj.put("commencement_date", commencement_date);
				obj.put("annual_rent", annual_rent);
				obj.put("case_number", case_number);
				obj.put("transaction_number", transaction_number);

				obj.put("client_name", client_name);
				obj.put("business_process_sub_name", business_process_sub_name);
				obj.put("job_number", job_number);
				obj.put("surveyor_number", surveyor_number);
				obj.put("regional_number", regional_number);
				obj.put("land_size", land_size);
				obj.put("locality", locality);
				obj.put("district", district);
				obj.put("region", region);
				obj.put("file_number", file_number);
				obj.put("registry_mapref", registry_mapref);

				obj.put("date_of_issue", date_of_issue);
				obj.put("registered_number", registered_number);
				obj.put("certificate_type", certificate_type);
				
				obj.put("date_of_registration", date_of_registration);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
System.out.println("further_entries_update_case_certificate");
				System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.further_entries_update_case_certificate(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_update_case_old_application")) {

				String case_number = request.getParameter("case_number");
				String annual_rent = request.getParameter("annual_rent");
				String commencement_date = request.getParameter("commencement_date");
				String stool_family_name = request.getParameter("stool_family_name");
				String term = request.getParameter("term");
				String date_of_document = request.getParameter("date_of_document");
				String consideration_fee = request.getParameter("consideration_fee");
				String extent = request.getParameter("extent");
				String size_of_land = request.getParameter("size_of_land");
				String renewal_term = request.getParameter("renewal_term");
				String type_of_interest = request.getParameter("type_of_interest");
				String nature_of_instrument = request.getParameter("nature_of_instrument");
				String type_of_use = request.getParameter("type_of_use");
				String family_of_grantor = request.getParameter("family_of_grantor");

				String transaction_number = request.getParameter("transaction_number");
				String client_name = request.getParameter("client_name");
				String business_process_sub_name = request.getParameter("business_process_sub_name");
				String job_number = request.getParameter("job_number");
				String surveyor_number = request.getParameter("surveyor_number");
				String regional_number = request.getParameter("regional_number");
				String land_size = request.getParameter("land_size");
				String district = request.getParameter("district");
				String region = request.getParameter("region");
				String locality = request.getParameter("locality");
				String file_number = request.getParameter("file_number");
				String registry_mapref = request.getParameter("registry_mapref");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				JSONObject obj = new JSONObject();

				obj.put("modified_by_id", modified_by_id);
				obj.put("modified_by", modified_by);
				obj.put("type_of_use", type_of_use);
				obj.put("nature_of_instrument", nature_of_instrument);
				obj.put("type_of_interest", type_of_interest);
				obj.put("size_of_land", size_of_land);
				obj.put("extent", extent);
				obj.put("consideration_fee", consideration_fee);
				obj.put("date_of_document", date_of_document);
				obj.put("term", term);
				obj.put("family_of_grantor", family_of_grantor);
				obj.put("renewal_term", renewal_term);
				obj.put("stool_family_name", stool_family_name);
				obj.put("commencement_date", commencement_date);
				obj.put("annual_rent", annual_rent);
				obj.put("case_number", case_number);

				obj.put("transaction_number", transaction_number);

				obj.put("client_name", client_name);
				obj.put("business_process_sub_name", business_process_sub_name);
				obj.put("job_number", job_number);
				obj.put("surveyor_number", surveyor_number);
				obj.put("regional_number", regional_number);
				obj.put("land_size", land_size);
				obj.put("locality", locality);
				obj.put("district", district);
				obj.put("region", region);
				obj.put("file_number", file_number);
				obj.put("registry_mapref", registry_mapref);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj.toString());
				web_service_response = casemgt_cl_m
						.select_update_case_old_application(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("select_update_application_ground_rent")) {

				/*
				 * String case_number = request.getParameter("case_number");
				 * String ground_rent = request.getParameter("ground_rent");
				 * String transaction_number =
				 * request.getParameter("transaction_number"); String job_number
				 * = request.getParameter("job_number");
				 * 
				 * String modified_by = (String)
				 * session.getAttribute("fullname"); String modified_by_id =
				 * (String) session.getAttribute("userid");
				 * 
				 * JSONObject obj = new JSONObject();
				 * 
				 * obj.put("modified_by_id", modified_by_id);
				 * obj.put("modified_by", modified_by); obj.put("ground_rent",
				 * ground_rent); obj.put("case_number", case_number);
				 * obj.put("transaction_number", transaction_number);
				 * 
				 * obj.put("job_number", job_number);
				 * 
				 * String input_details = obj.toString();
				 * 
				 * // String wkt_polgon_wgs84 = //
				 * request.getParameter("wkt_polgon_wgs84");
				 * 
				 * System.out.println(obj.toString()); web_service_response =
				 * casemgt_cl.select_update_application_ground_rent(obj.toString
				 * ()); if (web_service_response != null) { //
				 * System.out.println(web_service_response); } else {
				 * System.out.println(web_service_response); } PrintWriter out =
				 * response.getWriter(); return web_service_response;
				 */
			}

			if (request_type.equals("select_update_title_plan_details")) {

				String gid = request.getParameter("gid");
				String registry_mapref = request.getParameter("registry_mapref");
				String size_of_land = request.getParameter("size_of_land");
				String plan_no = request.getParameter("plan_no");
				String ltr_plan_no = request.getParameter("ltr_plan_no");
				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				String registration_block_number = request.getParameter("registration_block_number");
				String cc_no = request.getParameter("cc_no");
				String transaction_number = request.getParameter("transaction_number");
				String certificate_number = request.getParameter("certificate_number");
				String volume_number = request.getParameter("volume_number");
				String folio_number = request.getParameter("folio_number");
				String certificate_type = request.getParameter("certificate_type");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				obj_d.put("gid", gid);
				obj_d.put("registry_mapref", registry_mapref);
				obj_d.put("size_of_land", size_of_land);
				obj_d.put("plan_no", plan_no);
				obj_d.put("ltr_plan_no", ltr_plan_no);
				obj_d.put("registration_district_number", registration_district_number);
				obj_d.put("registration_section_number", registration_section_number);
				obj_d.put("registration_block_number", registration_block_number);
				obj_d.put("cc_no", cc_no);
				obj_d.put("transaction_number", transaction_number);
				obj_d.put("certificate_number", certificate_number);
				obj_d.put("volume_number", volume_number);
				obj_d.put("folio_number", folio_number);
				obj_d.put("certificate_type", certificate_type);

				obj_d.put("modified_by_name", fullname);
				obj_d.put("modified_by_id", userid);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m
						.select_update_title_plan_details(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("select_update_title_plan_certificate_details")) {

				
				String transaction_number = request.getParameter("transaction_number");
				String certificate_number = request.getParameter("certificate_number");
				String volume_number = request.getParameter("volume_number");
				String folio_number = request.getParameter("folio_number");
				String certificate_type = request.getParameter("certificate_type");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				
				obj_d.put("transaction_number", transaction_number);
				obj_d.put("certificate_number", certificate_number);
				obj_d.put("volume_number", volume_number);
				obj_d.put("folio_number", folio_number);
				obj_d.put("certificate_type", certificate_type);

				obj_d.put("modified_by_name", fullname);
				obj_d.put("modified_by_id", userid);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				 System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m
						.select_update_title_plan_certificate_details(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_update_title_plan_details_smd")) {

				String gid = request.getParameter("gid");
				String registry_mapref = request.getParameter("registry_mapref");
				String size_of_land = request.getParameter("size_of_land");
				String plan_no = request.getParameter("plan_no");
				String ltr_plan_no = request.getParameter("ltr_plan_no");
				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				String registration_block_number = request.getParameter("registration_block_number");
				String job_number = request.getParameter("job_number");
				String case_number = request.getParameter("case_number");
				String cc_no = request.getParameter("cc_no");

				String transaction_number = request.getParameter("transaction_number");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				obj_d.put("gid", gid);
				obj_d.put("registry_mapref", registry_mapref);
				obj_d.put("size_of_land", size_of_land);
				obj_d.put("plan_no", plan_no);
				obj_d.put("ltr_plan_no", ltr_plan_no);
				obj_d.put("registration_district_number", registration_district_number);
				obj_d.put("registration_section_number", registration_section_number);
				obj_d.put("registration_block_number", registration_block_number);
				obj_d.put("job_number", job_number);
				obj_d.put("case_number", case_number);
				obj_d.put("cc_no", cc_no);
				obj_d.put("transaction_number", transaction_number);
				obj_d.put("modified_by_name", fullname);
				obj_d.put("modified_by_id", userid);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m
						.select_update_title_plan_details_smd(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_load_record_notes")) {

				String job_number = request.getParameter("job_number");

				web_service_response = casemgt_cl_m.select_load_record_notes(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						job_number);
				JSONObject sub_service_obj = new JSONObject(web_service_response);
				web_service_response = sub_service_obj.get("data").toString();
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("select_approve_job_note_frrv")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				String job_purpose = request.getParameter("job_purpose");
				JSONObject obj_d = new JSONObject();

				obj_d.put("created_by", fullname);
				obj_d.put("created_by_id", userid);
				obj_d.put("division", division);
				obj_d.put("job_number", job_number);
				obj_d.put("job_purpose", job_purpose);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m
						.select_approve_job_note_frrv(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_update_application_as_work_done_tpp")) {
				String job_number = request.getParameter("job_number");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String unit_id = (String) session.getAttribute("unit_id");
				String unit_name = (String) session.getAttribute("unit_name");
				String division = (String) session.getAttribute("division");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				String job_purpose = request.getParameter("job_purpose");

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("unit_id", unit_id);
				obj.put("unit_name", unit_name);
				obj.put("division", division);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);
				obj.put("job_purpose", job_purpose);


				web_service_response = casemgt_cl_m.select_update_application_as_work_done_tpp(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_approve_job_note_tpp_sealed")) {
				String job_number = request.getParameter("job_number");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String unit_id = (String) session.getAttribute("unit_id");
				String unit_name = (String) session.getAttribute("unit_name");
				String division = (String) session.getAttribute("division");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("unit_id", unit_id);
				obj.put("unit_name", unit_name);
				obj.put("division", division);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				System.out.println(obj.toString());
				web_service_response = casemgt_cl_m
						.select_approve_job_note_tpp_sealed(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_approve_job_note_tpp")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				JSONObject obj_d = new JSONObject();

				obj_d.put("created_by", fullname);
				obj_d.put("created_by_id", userid);
				obj_d.put("division", division);
				obj_d.put("job_number", job_number);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m.select_approve_job_note_tpp(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_approve_job_note_tpp_signed")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				JSONObject obj_d = new JSONObject();

				obj_d.put("created_by", fullname);
				obj_d.put("created_by_id", userid);
				obj_d.put("division", division);
				obj_d.put("job_number", job_number);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m
						.select_approve_job_note_tpp_signed(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_udate_published_date_on_case")) {

				String publication_list1 = request.getParameter("publication_list1");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String published_date = request.getParameter("published_date");
				JSONObject obj_d = new JSONObject();

				obj_d.put("modified_by_name", fullname);
				obj_d.put("modified_by_id", userid);
				obj_d.put("published_date", published_date);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);

				String input_details = obj_d.toString();
				// System.out.println(input_details);

				JSONObject obj_g = new JSONObject();
				obj_g.put("publication_list1", publication_list1);
				obj_g.put("application_details", input_details);
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_g.toString());
				web_service_response = casemgt_cl_m
						.select_udate_published_date_on_case(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_g.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_set_cases_published")) {

				String publication_list = request.getParameter("publication_list");
				String to_email_address = request.getParameter("to_email_address");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				// System.out.println("========send_by_name=============");
				// System.out.println(userid);

				JSONObject obj_d = new JSONObject();

				obj_d.put("send_by_name", fullname);
				obj_d.put("send_by_id", userid);
				obj_d.put("to_email_address", to_email_address);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println("=====================");
				// System.out.println(obj_d.toString());
				// System.out.println("=====================");
				// String input_details = obj_d.toString();

				JSONObject obj_g = new JSONObject();
				obj_g.put("publication_list", publication_list);
				obj_g.put("application_details", obj_d.toString());
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_g.toString());
				web_service_response = casemgt_cl_m.select_set_cases_published(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_g.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					// Generate list herer
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_update_search_summary")) {

				String job_number = request.getParameter("job_number");
				String search_report = request.getParameter("search_report");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				// String userid = (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				obj_d.put("job_number", job_number);
				obj_d.put("search_report", search_report);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println(obj_d.toString());

				web_service_response = casemgt_cl_m
						.online_select_update_search_summary(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_complete_milestone_for_job")) {

				String job_number = request.getParameter("job_number");
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");
				//String search_report = request.getParameter("search_report");

				
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
		

				JSONObject obj_d = new JSONObject();

				obj_d.put("job_number", job_number);
				obj_d.put("case_number", case_number);
				obj_d.put("transaction_number", transaction_number);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println(obj_d.toString());

				web_service_response = casemgt_cl_m
						.process_complete_milestone_for_job(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("online_select_update_search_summary_deed")) {

				String job_number = request.getParameter("job_number");
				String search_report = request.getParameter("search_report");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				// String userid = (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				obj_d.put("job_number", job_number);
				obj_d.put("search_report", search_report);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println(obj_d.toString());

				web_service_response = casemgt_cl_m.online_select_update_search_summary_deed(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_update_resgister_description")) {

				String job_number = request.getParameter("job_number");
				String search_report = request.getParameter("search_report");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				// String userid = (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				obj_d.put("job_number", job_number);
				obj_d.put("search_report", search_report);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println(obj_d.toString());

				web_service_response = casemgt_cl_m.online_select_update_resgister_description(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_lc_plan_approval_plottings_update_final_status")) {

				String job_number = request.getParameter("job_number");
				String case_number = request.getParameter("case_number");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");


				// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				// String userid = (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				obj_d.put("job_number", job_number);
				obj_d.put("case_number", case_number);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println(obj_d.toString());

				web_service_response = casemgt_cl_m
						.select_lc_plan_approval_plottings_update_final_status(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_update_application_stage_for_a_job")) {

				String job_number = request.getParameter("job_number");
				String application_stage = request.getParameter("application_stage");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				// String userid = (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				obj_d.put("job_number", job_number);
				obj_d.put("application_stage", application_stage);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println(obj_d.toString());

				web_service_response = casemgt_cl_m.select_update_application_stage_for_a_job(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_load_app_details_for_request")) {

				String job_number = request.getParameter("job_number");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				// String userid = (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				obj_d.put("job_number", job_number);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println(obj_d.toString());

				web_service_response = casemgt_cl_m.select_load_app_details_for_request(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_send_request_for_app")) {

				String job_number = request.getParameter("job_number");
				String req_to = request.getParameter("req_to");
				String req_to_id = request.getParameter("req_to_id");
				String req_from = (String) session.getAttribute("unit_name");
				String req_from_id = (String) session.getAttribute("unit_id");
				String req_note = request.getParameter("req_note");

				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				String region_name =  (String) session.getAttribute("region_name");
				String region_id =  (String) session.getAttribute("regional_code");
				
				// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				// String userid = (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				obj_d.put("job_number", job_number);
				obj_d.put("req_to", req_to);
				obj_d.put("modified_by_id", userid); 
				obj_d.put("modified_by", fullname); 
				obj_d.put("req_from", req_from);
				obj_d.put("req_from_id", req_from_id);
				obj_d.put("req_to_id", req_to_id);
				obj_d.put("req_note", req_note);
				obj_d.put("region_name", region_name);
				obj_d.put("region_id", region_id);
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println(obj_d.toString());

				web_service_response = casemgt_cl_m.select_send_request_for_app(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_request_apps_at_unit_by_inbox_type")) {

				String inbox_type = request.getParameter("inbox_type");
				String unit_id = (String) session.getAttribute("unit_id");

				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				JSONObject obj_d = new JSONObject();

				obj_d.put("inbox_type", inbox_type);
				obj_d.put("unit_id", unit_id);
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println(obj_d.toString());

				web_service_response = casemgt_cl_m.load_request_apps_at_unit_by_inbox_type(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_respond_to_app_request")) {

				String response_type = request.getParameter("response_type");
				String unit_id = (String) session.getAttribute("unit_id");
				String resquest_id = request.getParameter("resquest_id");
				String response_note = request.getParameter("response_note");
				String job_number = request.getParameter("job_number");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname");
				String division = (String) session.getAttribute("division");

				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				JSONObject obj_d = new JSONObject();

				obj_d.put("response_type", response_type);
				obj_d.put("unit_id", unit_id);
				obj_d.put("resquest_id", new Double(resquest_id).intValue());
				obj_d.put("response_note", response_note);
				obj_d.put("job_number", job_number);
				obj_d.put("send_by_id", userid); 
				obj_d.put("send_by_name", fullname); 
				obj_d.put("division", division);
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				 System.out.println(obj_d.toString());

				web_service_response = casemgt_cl_m.select_respond_to_app_request(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_process_batchlist")) {

				String batch_list = request.getParameter("batch_list");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				// System.out.println("========send_by_name=============");
				// System.out.println(batch_list);

				String userid = (String) session.getAttribute("userid");
				// System.out.println("========send_by_name=============");
				// System.out.println(userid);

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				JSONObject obj_d = new JSONObject();

				obj_d.put("send_by_name", fullname);
				obj_d.put("send_by_id", userid);
				obj_d.put("send_to_id", send_to_id);
				obj_d.put("send_to_name", send_to_name);
				obj_d.put("division", division);
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);
				// System.out.println("=====================");
				// System.out.println(obj_d.toString());
				// System.out.println("=====================");
				String input_details = obj_d.toString();

				JSONObject obj_g = new JSONObject();
				obj_g.put("batch_list", batch_list);
				obj_g.put("application_details", input_details);
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_g.toString());
				web_service_response = casemgt_cl_m.select_process_batchlist(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_g.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_type_of_use_list")) {
				// String vr_type_of_number =
				// request.getParameter("vr_type_of_number");
				// System.out.println(polygon);
				web_service_response = user_web_service.get_list_of_typeofuse(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_load_details_of_licenced_surveyor")) {
				String ls_number = request.getParameter("ls_number");

				// System.out.println(polygon);
				web_service_response = casemgt_cl
						.select_load_details_of_licenced_surveyor(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), ls_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_list_of_natureofinstrument")) {
				// String vr_type_of_number =
				// request.getParameter("l");
				// System.out.println(polygon);
				web_service_response = user_web_service
						.get_list_of_natureofinstrument(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_list_of_ls_estates")) {
				// String vr_type_of_number =
				// request.getParameter("l");
				// System.out.println(polygon);
				web_service_response = rent_mgt_service
						.select_rt_govt_estatesg_list(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_list_of_revenue_item_list")) {
				// String vr_type_of_number =
				// request.getParameter("l");
				// System.out.println(polygon);
				web_service_response = user_web_service
						.select_revenue_items_for_lvd_stamping_list(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());

				JSONObject sub_service_obj = new JSONObject(web_service_response);
				web_service_response = sub_service_obj.get("data").toString();

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_rt_rates_table_current_per_estate")) {
				// String vr_type_of_number =
				// request.getParameter("l");
				String estate_code = request.getParameter("estate_code");
				// System.out.println(estate_code);
				web_service_response = rent_mgt_service
						.select_rt_rates_table_current_per_estate(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), estate_code);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_type_of_forms_list")) {
				// String vr_type_of_number =
				// request.getParameter("vr_type_of_number");
				// System.out.println(polygon);
				String main_service_id = request.getParameter("main_service_id");
				String sub_service_id = request.getParameter("sub_service_id");
				web_service_response = user_web_service.get_lrd_form_for_application(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						main_service_id, sub_service_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_lc_main_service")) {
				// String vr_type_of_number =
				// request.getParameter("vr_type_of_number");
				// System.out.println(polygon);
				web_service_response = (String) session.getAttribute("web_main_services");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			

			if (request_type.equals("get_request_purpose")) {
				// String vr_type_of_number =
				// request.getParameter("vr_type_of_number");
				// System.out.println(polygon);
				web_service_response = (String) session.getAttribute("request_purpose_all");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_lc_temporal_service")) {
				// String vr_type_of_number =
				// request.getParameter("vr_type_of_number");
				// System.out.println(polygon);
				web_service_response = (String) session.getAttribute("web_temporal_service");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_lc_sub_service")) {
				// String vr_type_of_number =
				// request.getParameter("vr_type_of_number");
				// System.out.println(polygon);
				web_service_response = (String) session.getAttribute("web_sub_services");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_lc_sub_service_all")) {
				// String vr_type_of_number =
				// request.getParameter("vr_type_of_number");
				// System.out.println(polygon);
				web_service_response = (String) session.getAttribute("web_sub_services_all");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("get_lc_list_of_units")) {
				String office_id = request.getParameter("office_id") != null ? request.getParameter("office_id")
						: (String) session.getAttribute("regional_code");
				// System.out.println(polygon);

				web_service_response = user_web_service.get_lc_list_of_units(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						office_id != null ? office_id : "11");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_lc_list_of_units_manage")) {
				String office_id = request.getParameter("office_id") != null ? request.getParameter("office_id")
						: (String) session.getAttribute("regional_code");
				// System.out.println(polygon);

				web_service_response = user_web_service.get_lc_list_of_units_manage(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						office_id != null ? office_id : "11");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_lc_list_of_users")) {
				// String vr_type_of_number =
				// request.getParameter("vr_type_of_number");
				// System.out.println(polygon);
				web_service_response = (String) session.getAttribute("web_list_of_users");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			

			if (request_type.equals("get_lc_list_of_users_rpt")) {
				JSONObject obj = new JSONObject();

                String region_code = request.getParameter("region_code");
				String division_name = request.getParameter("division_name");
				String unit_id = request.getParameter("unit_id");

                obj.put( "region_code" , region_code );
				obj.put( "unit_id" , unit_id );
				obj.put( "division" , division_name );

                System.out.println(obj.toString());

				web_service_response = users_sl.select_user_account_all_by_unit_per_region(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
   				System.out.println(web_service_response);

				
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }

			if (request_type.equals("get_lc_checklist")) {
				String main_service_id = request.getParameter("main_service_id");
				String sub_service_id = request.getParameter("sub_service_id");
				// System.out.println(polygon);
				web_service_response = user_web_service.get_check_list_for_a_service(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						main_service_id, sub_service_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("get_lc_checklist_new")) {
				String main_service_id = request.getParameter("main_service_id");
				String sub_service_id = request.getParameter("sub_service_id");
				// System.out.println(polygon);
				web_service_response = user_web_service.get_check_list_for_a_service_new(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						main_service_id,
						sub_service_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("get_tracking_milestones")) {
				String main_service_id = request.getParameter("main_service_id");
				String sub_service_id = request.getParameter("sub_service_id");
				// System.out.println(polygon);
				web_service_response = user_web_service.load_application_milestone_for_tracking(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						main_service_id,
						sub_service_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("auto_generate_file_number")) {
				JSONObject property_data_json = new JSONObject();

				String type_of_number = request.getParameter("vr_type_of_number");
				String case_number = request.getParameter("case_number");
				// System.out.println(polygon);
				property_data_json.put("type_of_number", type_of_number);
				// property_data_json.put("jn_id",jn_id);
				property_data_json.put("case_number", case_number);

				web_service_response = casemgt_cl_m.select_create_lc_file_numbering(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						property_data_json.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_lrd_registration_processing_update_parcel_plan")) {
				String case_number = request.getParameter("case_number");
				String registry_mapref = request.getParameter("registry_mapref");
				String plan_no = request.getParameter("plan_no");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String cc_no = request.getParameter("cc_no");
				String ltr_plan_no = request.getParameter("ltr_plan_no");
				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				String registration_block_number = request.getParameter("registration_block_number");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				obj.put("case_number", case_number);
				obj.put("registry_mapref", registry_mapref);
				obj.put("plan_no", plan_no);
				obj.put("cc_no", cc_no);
				obj.put("ltr_plan_no", ltr_plan_no);
				obj.put("registration_district_number", registration_district_number);
				obj.put("registration_section_number", registration_section_number);
				obj.put("registration_block_number", registration_block_number);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m.select_lrd_registration_processing_update_parcel_plan(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("update_job_step_status")) {

				String job_number = request.getParameter("job_number");
				String current_step_number = request.getParameter("current_step_number");
				String business_process_id = request.getParameter("business_process_id");
				String business_process_sub_id = request.getParameter("business_process_sub_id");
				String business_process_name = request.getParameter("business_process_name");
				String business_process_sub_name = request.getParameter("business_process_sub_name");
				String client_number = request.getParameter("client_number");
				String client_name = request.getParameter("client_name");
				String created_by = (String) session.getAttribute("fullname");
				String created_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				JSONObject obj = new JSONObject();

				obj.put("current_step_number", current_step_number);
				obj.put("job_number", job_number);
				obj.put("business_process_id", business_process_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				obj.put("business_process_name", business_process_name);
				obj.put("business_process_sub_name", business_process_sub_name);
				obj.put("client_number", client_number);
				obj.put("client_name", client_name);
				obj.put("created_by", created_by);
				obj.put("created_by_id", created_by_id);
obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				System.out.println(input);
				web_service_response = casemgt_cl_m.update_job_step_status(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("update_map_plotting_step_status")) {

				String job_number = request.getParameter("job_number");
				String current_step_number = request.getParameter("current_step_number");
				String business_process_id = request.getParameter("business_process_id");
				String business_process_sub_id = request.getParameter("business_process_sub_id");
				String business_process_name = request.getParameter("business_process_name");
				String business_process_sub_name = request.getParameter("business_process_sub_name");
				String client_number = request.getParameter("client_number");
				String client_name = request.getParameter("client_name");
				String created_by = (String) session.getAttribute("fullname");
				String created_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				JSONObject obj = new JSONObject();

				obj.put("current_step_number", current_step_number);
				obj.put("job_number", job_number);
				obj.put("business_process_id", business_process_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				obj.put("business_process_name", business_process_name);
				obj.put("business_process_sub_name", business_process_sub_name);
				obj.put("client_number", client_number);
				obj.put("client_name", client_name);
				obj.put("created_by", created_by);
				obj.put("created_by_id", created_by_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m.update_map_plotting_step_status(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("update_job_step_status_reverse")) {

				String job_number = request.getParameter("job_number");
				String current_step_number = request.getParameter("current_step_number");
				String business_process_id = request.getParameter("business_process_id");
				String business_process_sub_id = request.getParameter("business_process_sub_id");
				String business_process_name = request.getParameter("business_process_name");
				String business_process_sub_name = request.getParameter("business_process_sub_name");
				String client_number = request.getParameter("client_number");
				String client_name = request.getParameter("client_name");
				String created_by = (String) session.getAttribute("fullname");
				String created_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				JSONObject obj = new JSONObject();

				obj.put("current_step_number", current_step_number);
				obj.put("job_number", job_number);
				obj.put("business_process_id", business_process_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				obj.put("business_process_name", business_process_name);
				obj.put("business_process_sub_name", business_process_sub_name);
				obj.put("client_number", client_number);
				obj.put("client_name", client_name);
				obj.put("created_by", created_by);
				obj.put("created_by_id", created_by_id);
obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.update_job_step_status_reverse(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_generate_interest_number")) {

				String case_number = request.getParameter("case_number");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");
				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();
				obj.put("case_number", case_number);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);
				obj.put("userid", userid);

				jsonArr.put(obj);
				String input = jsonArr.toString();
		

				web_service_response = casemgt_cl_m.select_generate_interest_number(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						case_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			

			if (request_type.equals("select_update_registered_number")) {

				String case_number = request.getParameter("case_number");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");
				String userid = (String) session.getAttribute("userid");
				String registered_number = request.getParameter("registered_number");


				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();
				obj.put("case_number", case_number);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);
				obj.put("userid", userid);
				obj.put("registered_number", registered_number);

				jsonArr.put(obj);
				String input = jsonArr.toString();
		

				web_service_response = casemgt_cl_m.select_update_registered_number(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			

			if (request_type.equals("select_update_date_of_issue")) {

				String case_number = request.getParameter("case_number");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");
				String userid = (String) session.getAttribute("userid");
				String date_of_issue = request.getParameter("date_of_issue");


				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();
				obj.put("case_number", case_number);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);
				obj.put("userid", userid);
				obj.put("date_of_issue", date_of_issue);

				jsonArr.put(obj);
				String input = jsonArr.toString();
		

				web_service_response = casemgt_cl_m.select_update_date_of_issue(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_generate_sub_interest_number")) {

				String case_number = request.getParameter("case_number");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");
				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();
				obj.put("case_number", case_number);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);
				obj.put("userid", userid);

				jsonArr.put(obj);
				String input = jsonArr.toString();
		

				web_service_response = casemgt_cl_m.select_generate_sub_interest_number(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						case_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_update_certificate_number_on_case")) {

				String case_number = request.getParameter("case_number");
				String certificate_number = request.getParameter("certificate_number");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");
				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();
				obj.put("case_number", case_number);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);
				obj.put("userid", userid);
				obj.put("certificate_number", certificate_number);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				System.out.println(obj.toString());
		

				web_service_response = casemgt_cl_m.select_update_certificate_number_on_case(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_add_to_publication")) {

				String case_number = request.getParameter("case_number");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				// obj.put( "wkt_polygon",wkt_polgon );
				obj.put("case_number", case_number);
				// obj.put( "job_number", job_number );
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				jsonArr.put(obj);
				String input = jsonArr.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m.select_add_to_publication(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						case_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_update_publication_date")) {

				String case_number = request.getParameter("case_number");
				String publication_date = request.getParameter("publication_date");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				/// obj.put( "wkt_polygon",wkt_polgon );
				obj.put("case_number", case_number);
				obj.put("publication_date", publication_date);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				jsonArr.put(obj);
				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.select_update_publication_date(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_create_volume_folio_number")) {
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");

				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				String type_of_certificate = request.getParameter("type_of_certificate");

				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				obj.put("registration_district_number", registration_district_number);
				obj.put("registration_section_number", registration_section_number);
				obj.put("type_of_certificate", type_of_certificate);
				obj.put("transaction_number", transaction_number);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				// jsonArr.put(obj);
				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.select_generate_cert_volume_folio_number(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_create_volume_folio_number_tcs")) {
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");

				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				String type_of_certificate = request.getParameter("type_of_certificate");

				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				obj.put("registration_district_number", registration_district_number);
				obj.put("registration_section_number", registration_section_number);
				obj.put("type_of_certificate", type_of_certificate);
				obj.put("transaction_number", transaction_number);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				// jsonArr.put(obj);
				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.select_generate_cert_volume_folio_number_tcs(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("select_generate_certificate_number_only")) {
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");

				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				String type_of_certificate = request.getParameter("type_of_certificate");

				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				obj.put("registration_district_number", registration_district_number);
				obj.put("registration_section_number", registration_section_number);
				obj.put("type_of_certificate", type_of_certificate);
				obj.put("transaction_number", transaction_number);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				// jsonArr.put(obj);
				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.select_generate_certificate_number_only(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			

			if (request_type.equals("select_generate_deed_number_only")) {
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");

				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				//String type_of_certificate = request.getParameter("type_of_certificate");
				String region_code =  (String) session.getAttribute("regional_code");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

					//obj.put("registration_district_number", registration_district_number);
				//obj.put("registration_section_number", registration_section_number);
				//obj.put("type_of_certificate", type_of_certificate);
				obj.put("transaction_number", transaction_number);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);

				obj.put("region_code", region_code);
				obj.put("number_format", "DN");
			

				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				// jsonArr.put(obj);
				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.select_generate_deed_number_only(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_generate_ls_number_only")) {
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");

				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				//String type_of_certificate = request.getParameter("type_of_certificate");

				String region_code =  (String) session.getAttribute("regional_code");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

					//obj.put("registration_district_number", registration_district_number);
				//obj.put("registration_section_number", registration_section_number);
				//obj.put("type_of_certificate", type_of_certificate);
				obj.put("transaction_number", transaction_number);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);

				obj.put("region_code", region_code);
				obj.put("number_format", "LS");
			

				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				// jsonArr.put(obj);
				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.select_generate_ls_number_only(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("select_generate_file_number_only")) {
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");

				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				//String type_of_certificate = request.getParameter("type_of_certificate");

				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");
				String region_code =  (String) session.getAttribute("regional_code");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				//obj.put("registration_district_number", registration_district_number);
				//obj.put("registration_section_number", registration_section_number);
				//obj.put("type_of_certificate", type_of_certificate);
				obj.put("transaction_number", transaction_number);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);

				obj.put("region_code", region_code);
				obj.put("number_format", "FN");
			

				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				obj.put("userid", userid);


			
				// jsonArr.put(obj);
				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.select_generate_file_number_only(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_generate_ground_rent_only")) {
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");

				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				String ground_rent = request.getParameter("ground_rent");

				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");
				String region_code =  (String) session.getAttribute("regional_code");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				//obj.put("registration_district_number", registration_district_number);
				//obj.put("registration_section_number", registration_section_number);
				//obj.put("type_of_certificate", type_of_certificate);
				obj.put("transaction_number", transaction_number);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("ground_rent", ground_rent);

				obj.put("region_code", region_code);
				obj.put("number_format", "FN");
			

				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				obj.put("userid", userid);


			
				// jsonArr.put(obj);
				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.select_generate_ground_rent_only(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("select_determining_type_of_transfer")) {
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");

				// String registration_district_number = request.getParameter("registration_district_number");
				// String registration_section_number = request.getParameter("registration_section_number");
				String lc_intended_parcel = request.getParameter("lc_intended_parcel");
				String lc_intended_interest = request.getParameter("lc_intended_interest");
				String type_of_transfer = request.getParameter("type_of_transfer");

				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				// obj.put("registration_district_number", registration_district_number);
				// obj.put("registration_section_number", registration_section_number);
				obj.put("intended_parcel", lc_intended_parcel);
				obj.put("intended_interest", lc_intended_interest);
				obj.put("type_of_transfer", type_of_transfer);
				obj.put("transaction_number", transaction_number);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				// jsonArr.put(obj);
				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.select_determining_type_of_transfer(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_generate_volume_and_folio_number_only")) {
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");

				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				String type_of_certificate = request.getParameter("type_of_certificate");

				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				obj.put("registration_district_number", registration_district_number);
				obj.put("registration_section_number", registration_section_number);
				obj.put("type_of_certificate", type_of_certificate);
				obj.put("transaction_number", transaction_number);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				// jsonArr.put(obj);
				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(input);
				web_service_response = casemgt_cl_m
						.select_generate_volume_and_folio_number_only(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("user_to_batch_to_list_short")) {
				// String polygon = request.getParameter("vr_polygon");
				// System.out.println(polygon);
				// //web_service_response
				// =casemgt_cl.user_to_batch_to_list_short();
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_consolidated_internal_search_report_geom")) {
				String polygon = request.getParameter("vr_polygon");
				// System.out.println(polygon);
				web_service_response = casemgt_cl.select_consolidated_internal_search_report_geom(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						polygon);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			/*
			 * if (request_type.equals(
			 * "online_select_verification_code_final_approval")) { String
			 * polygon = request.getParameter("vr_polygon");
			 * System.out.println(polygon); web_service_response =
			 * casemgt_cl.select_consolidated_internal_search_report_geom(
			 * polygon); if (web_service_response != null) {
			 * System.out.println(web_service_response); } else {
			 * System.out.println(web_service_response); } PrintWriter out =
			 * response.getWriter(); return web_service_response; }
			 */

			if (request_type.equals("select_consolidated_internal_search_report_attribute")) {
				String polygon = request.getParameter("vr_polygon");
				// System.out.println(polygon);
				web_service_response = casemgt_cl.select_consolidated_internal_search_report_attribute(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						polygon);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_verification_code_final_approval")) {

				String job_number = request.getParameter("job_number");
				String ta_id = request.getParameter("ta_id");
				String type_of_transaction = request.getParameter("type_of_transaction");
				String case_number = request.getParameter("case_number");
				String business_process_sub_name = request.getParameter("business_process_sub_name");
				String full_code = request.getParameter("full_code");
				String created_by = (String) session.getAttribute("fullname");
				String created_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");
				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("ta_id", ta_id);
				obj.put("type_of_transaction", type_of_transaction);
				obj.put("case_number", case_number);
				obj.put("business_process_sub_name", business_process_sub_name);
				obj.put("full_code", full_code);
				obj.put("created_by", created_by);
				obj.put("created_by_id", created_by_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input = obj.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				System.out.println(input);
				// web_service_response =
				// casemgt_cl_m.update_job_step_status(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),input);

				web_service_response = casemgt_cl_m
						.online_select_verification_code_final_approval(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				System.out.println(web_service_response);
				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);

					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_verification_code_create")) {
				String case_number = request.getParameter("case_number");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String officers_grade = (String) session.getAttribute("designation");
				String job_number = request.getParameter("job_number");
				String type_of_transaction = request.getParameter("type_of_transaction");

				JSONObject obj = new JSONObject();

				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("type_of_transaction", type_of_transaction);
				obj.put("officers_grade", officers_grade);

				obj.put("userid", userid);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				String input = obj.toString();

				System.out.println(input);
				System.out.println(input);
				web_service_response = casemgt_cl
						.online_select_verification_code_create(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);

				// String user_phone = (String) session.getAttribute("user_phone");
				// user_phone = user_phone.replaceFirst("0", "+233");
				// System.out.println("web_service_response");
				// System.out.println(web_service_response);
				JSONObject web_response_obj = new JSONObject(web_service_response);
			//	System.out.println("web_response_obj");
			//	System.out.println(web_response_obj);
				//String msg_code = web_response_obj.getString("msg");
				// String vr_sms = web_response_obj.getString("sms");
				// String vr_client_number = web_response_obj.getString("phone");

				// // String new_message = "Use this OTP Code: " + verification_code
				// // + " to approve the transaction for Signature on to ELIS";

				// JSONObject obj_sms = new JSONObject();
				// obj_sms.put("recipient", vr_client_number);
				// obj_sms.put("msg", vr_sms);

				// String smsm_result = sms_sl.send_single_sms(cls_url_config.getWeb_service_url_ser(),
				// 		cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());
				// // String new_message = "Verification code is " + smsm_result;
				// System.out.println("smsm_result");
				// System.out.println(smsm_result);

				// JSONObject obj_verify = new JSONObject(smsm_result);
				// String arr_verify = obj_verify.get("msg").toString();

				// System.out.println("sms response");

				// System.out.println(arr_verify);

				// if (arr_verify.equals("Sms send Sucessfull")) {
				// 	web_service_response = "OTP has been generate to your phone";
				// } else {
				// 	web_service_response = "Error Sending otp";

				// }
				//web_service_response = msg_code;
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
				// out.println("Message has been sent to your phone. Please
				// verify and authenticate " + web_service_response);
			}

			
			if (request_type.equals("select_generate_smd_title_plan_numbers")) {
				String case_number = request.getParameter("case_number");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String job_number = request.getParameter("job_number");
				String transaction_number = request.getParameter("transaction_number");

				JSONObject obj = new JSONObject();

				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("transaction_number", transaction_number);

				obj.put("userid", userid);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				String input = obj.toString();

				System.out.println(input);
				System.out.println(input);
				web_service_response = casemgt_cl
						.select_generate_smd_title_plan_numbers(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);

			
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
				// out.println("Message has been sent to your phone. Please
				// verify and authenticate " + web_service_response);
			}

			if (request_type.equals("online_select_verification_code_details")) {
				String job_number = request.getParameter("job_number");
				String type_of_transaction = request.getParameter("type_of_transaction");
				// System.out.println(job_number);
				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("type_of_transaction", type_of_transaction);

				web_service_response = casemgt_cl
						.online_select_verification_code_details(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_verification_code_verify")) {
				String job_number = request.getParameter("job_number");
				// System.out.println(job_number);
				web_service_response = casemgt_cl
						.online_select_verification_code_create(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), job_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if(request_type.equals("check_request_purpose_validation")){
				String request_purpose = request.getParameter("request_purpose");
				String request_reference_type = request.getParameter("request_reference_type");
				String request_keyword = request.getParameter("request_keyword");

				JSONObject obj = new JSONObject();
				obj.put("request_purpose", request_purpose);
				obj.put("search_by", request_reference_type);
				obj.put("seach_value", request_keyword);
				String input = obj.toString();
				System.out.println(input);
				web_service_response = casemgt_cl
						.check_request_purpose_validation(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;				
			}

			if (request_type.equals("select_load_details_for_payment")) {
				String job_number = request.getParameter("job_number");
				// System.out.println(job_number);
				web_service_response = casemgt_cl
						.select_load_details_for_payment(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), job_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("PrintPDF")) {

			}

			if (request_type.equals("process_online_select_bill_for_registration")) {

				String main_service_id = request.getParameter("main_service_id");
				String main_service_sub_id = request.getParameter("main_service_sub_id");
				String main_service_desc = request.getParameter("main_service_desc");
				String main_service_sub_desc = request.getParameter("main_service_sub_desc");

				String client_name = request.getParameter("client_name");
				String case_number = request.getParameter("case_number");

				String land_size = request.getParameter("land_size");

				String registration_forms = request.getParameter("registration_forms");
				String publication_type = request.getParameter("publication_type");
				String type_of_use = request.getParameter("type_of_use");

				String licensed_surveyor_number = request.getParameter("licensed_surveyor_number");
				String licensed_surveyor_name = request.getParameter("licensed_surveyor_name");

				String locality = request.getParameter("locality");
				String ar_gender = request.getParameter("ar_gender");
				String ar_district = request.getParameter("ar_district");
				String ar_region = request.getParameter("ar_region");

				String paper_size = request.getParameter("paper_size");
				String revenue_item = request.getParameter("revenue_item");
				String no_of_copy = request.getParameter("no_of_copy");

				if (no_of_copy != null) {

				} else {
					no_of_copy = "0";
				}
				String office_region = (String) session.getAttribute("regional_code") + "_"
						+ (String) session.getAttribute("regional_name");
				String submission_type = request.getParameter("submission_type");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				String regional_code = (String) session.getAttribute("regional_code");
				String regional_name = (String) session.getAttribute("regional_name");
				String distict_code = (String) session.getAttribute("distict_code");
				String district_name = (String) session.getAttribute("district_name");

				String created_for = request.getParameter("created_for");
				String created_for_id = request.getParameter("created_for_id");
				String application_required_additional_bill = request
						.getParameter("application_required_additional_bill");

				String surveyors_client = request.getParameter("surveyors_client");
				String manual_bill_desc = request.getParameter("manual_bill_desc");
				/*
				 * String[] output = registration_forms.split("-"); String
				 * form_number = output[0]; String form_name = output[1];
				 * 
				 * String[] output_sub = type_of_use.split("-"); String
				 * typeofuse_id = output_sub[0]; String typeofuse_name =
				 * output_sub[1];
				 */

				String service_bill_descdription_formated = main_service_sub_desc.replace(" ", "_");
				String rs_result = null;

				JSONArray jsonArray = new JSONArray();
				JSONObject property_data_json = new JSONObject();

				property_data_json.put("business_process_id", main_service_id);
				property_data_json.put("business_process_name", main_service_desc);
				property_data_json.put("business_process_sub_id", main_service_sub_id);
				property_data_json.put("business_process_sub_name", main_service_sub_desc);
				property_data_json.put("client_name", client_name);
				property_data_json.put("case_number", case_number);

				property_data_json.put("land_size", land_size);
				property_data_json.put("type_of_use", type_of_use);
				property_data_json.put("publication_type", publication_type);
				property_data_json.put("form_number", registration_forms);
				property_data_json.put("revenue_item", revenue_item);

				property_data_json.put("licensed_surveyor_number", licensed_surveyor_number);
				property_data_json.put("licensed_surveyor_name", licensed_surveyor_name);

				property_data_json.put("locality", locality);
				property_data_json.put("ar_gender", ar_gender);
				property_data_json.put("ar_district", ar_district);
				property_data_json.put("ar_region", ar_region);

				property_data_json.put("paper_size", paper_size);
				property_data_json.put("no_of_copy", no_of_copy);

				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid);
				property_data_json.put("office_region", office_region);
				property_data_json.put("office_distict", "No" + "_" + "No");
				property_data_json.put("office_region_received", regional_code + "_" + regional_name);
				property_data_json.put("office_distict_received", distict_code + "_" + district_name);
				property_data_json.put("submission_type", submission_type);

				property_data_json.put("created_for", created_for);
				property_data_json.put("created_for_id", created_for_id);
				property_data_json.put("surveyors_client", surveyors_client);
				property_data_json.put("application_required_additional_bill", application_required_additional_bill);
				property_data_json.put("manual_bill_desc", manual_bill_desc);
				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid); 
				property_data_json.put("mac_address", mac_address);
				jsonArray.put(property_data_json);

				// rs_result = jsonArray.toString();

				System.out.println(jsonArray.toString());
				web_service_response = casemgt_cl
						.online_select_bill_for_application_general_all_backend(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								jsonArray.toString());
				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					String pdfFileName = "bill.pdf";

					JSONObject jsonobject = new JSONObject(web_service_response);
					String ws_bill_number = jsonobject.getString("unique");
					// String ws_bill_details_db=general_all
					// case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
					// String ws_bill_details_db=
					// case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

					// System.out.println(ws_bill_number);

					// String pdf_dest = "C:\\gelisdocs\\billspdf\\";

					String pdf_dest = cls_url_config.getCase_upload_location();
					String files_pdf_jackets_p = pdf_dest + service_bill_descdription_formated + "_" + ws_bill_number
							+ pdfFileName;
					/*
					 * String files_pdf_jackets_p = pdf_dest + ws_case_number +
					 * "\\" + service_bill_descdription_formated + "_" +
					 * job_number + pdfFileName;
					 */
					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_service_bill_online_new(
							cls_url_config.getSoftfile_location(), property_data_json.toString(),
							web_service_response, session.getAttribute("fullname").toString(), files_pdf_jackets_p);


				// 	JSONObject pdf_upload_obj = new JSONObject();
				// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				// pdf_upload_obj.put("jobNumber", ws_bill_number);
				// pdf_upload_obj.put("caseNumber",ws_bill_number);
				// pdf_upload_obj.put("fileData",base64Encoded);
				
				// pdf_upload_obj.put("doc_name",ws_bill_number);
				// pdf_upload_obj.put("doc_description","Service Bill");
				// pdf_upload_obj.put("doc_category","public_docs");
				// pdf_upload_obj.put("doc_app_uploaded","elis");
				// pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				// pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				// pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
 				// String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				// cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

 //System.out.println(pdf_upload_response);
// 					File pdfFile = new File(files_pdf_jackets_p);
// 					byte[] buffer = null;

// 					// String pdfFilename = "test.pdf"; // I use id here to
// 					// determine pdf
// 					// File f = new File(pdfFilename);

// 					BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
// 					ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

// 					int ch;
// 					long actual = 0;
// 					while ((ch = is.read()) != -1) {
// 						bos.write(ch);
// 						actual++;
// 					}
// 					bos.flush();
// 					bos.close();
// 					buffer = bos.toByteArray();
//  //Upload to DOCUMENT MGT
// 					//dealet the file
// 					//
// 					response.setContentType("application/pdf");
// 					response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
// 					// response.addHeader("Content-Disposition", "inline;
// 					// filename=Documentation.pdf");
// 					response.setContentLength((int) pdfFile.length());
// 					response.getOutputStream().write(buffer, 0, buffer.length);

				if (buffer != null) {
					// Set response content type to PDF
					response.setContentType("application/pdf");
					
					// Set the content-disposition header to download the file with the specified name
					response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
					
					// Set the content length of the response based on the buffer length (size of the PDF in bytes)
					response.setContentLength(buffer.length);
					
					// Write the PDF byte array to the output stream to download it
					response.getOutputStream().write(buffer, 0, buffer.length);
					
					// Flush the output stream
					response.getOutputStream().flush();
					
					// Close the output stream
					response.getOutputStream().close();
				} else {
					// Handle the case where the PDF generation failed
					response.setContentType("text/html");
					response.getWriter().write("Error generating PDF.");
				}

				} else {
					System.out.println(web_service_response);
				}
			}

			

			if (request_type.equals("process_online_calculate_bill_only")) {

				String main_service_id = request.getParameter("main_service_id");
				String main_service_sub_id = request.getParameter("main_service_sub_id");
				String main_service_desc = request.getParameter("main_service_desc");
				String main_service_sub_desc = request.getParameter("main_service_sub_desc");

				String client_name = request.getParameter("client_name");
				String case_number = request.getParameter("case_number");

				String land_size = request.getParameter("land_size");

				String registration_forms = request.getParameter("registration_forms");
				String publication_type = request.getParameter("publication_type");
				String type_of_use = request.getParameter("type_of_use");

				String licensed_surveyor_number = request.getParameter("licensed_surveyor_number");
				String licensed_surveyor_name = request.getParameter("licensed_surveyor_name");

				String locality = request.getParameter("locality");
				String ar_gender = request.getParameter("ar_gender");
				String ar_district = request.getParameter("ar_district");
				String ar_region = request.getParameter("ar_region");

				String paper_size = request.getParameter("paper_size");
				String revenue_item = request.getParameter("revenue_item");
				String no_of_copy = request.getParameter("no_of_copy");

				if (no_of_copy != null) {

				} else {
					no_of_copy = "0";
				}
				String office_region = (String) session.getAttribute("regional_code") + "_"
						+ (String) session.getAttribute("regional_name");
				String submission_type = request.getParameter("submission_type");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				String regional_code = (String) session.getAttribute("regional_code");
				String regional_name = (String) session.getAttribute("regional_name");
				String distict_code = (String) session.getAttribute("distict_code");
				String district_name = (String) session.getAttribute("district_name");

				String created_for = request.getParameter("created_for");
				String created_for_id = request.getParameter("created_for_id");
				String application_required_additional_bill = request
						.getParameter("application_required_additional_bill");

				String surveyors_client = request.getParameter("surveyors_client");
				String manual_bill_desc = request.getParameter("manual_bill_desc");
				/*
				 * String[] output = registration_forms.split("-"); String
				 * form_number = output[0]; String form_name = output[1];
				 * 
				 * String[] output_sub = type_of_use.split("-"); String
				 * typeofuse_id = output_sub[0]; String typeofuse_name =
				 * output_sub[1];
				 */

				String service_bill_descdription_formated = main_service_sub_desc.replace(" ", "_");
				String rs_result = null;

				JSONArray jsonArray = new JSONArray();
				JSONObject property_data_json = new JSONObject();

				property_data_json.put("business_process_id", main_service_id);
				property_data_json.put("business_process_name", main_service_desc);
				property_data_json.put("business_process_sub_id", main_service_sub_id);
				property_data_json.put("business_process_sub_name", main_service_sub_desc);
				property_data_json.put("client_name", client_name);
				property_data_json.put("case_number", case_number);

				property_data_json.put("land_size", land_size);
				property_data_json.put("type_of_use", type_of_use);
				property_data_json.put("publication_type", publication_type);
				property_data_json.put("form_number", registration_forms);
				property_data_json.put("revenue_item", revenue_item);

				property_data_json.put("licensed_surveyor_number", licensed_surveyor_number);
				property_data_json.put("licensed_surveyor_name", licensed_surveyor_name);

				property_data_json.put("locality", locality);
				property_data_json.put("ar_gender", ar_gender);
				property_data_json.put("ar_district", ar_district);
				property_data_json.put("ar_region", ar_region);

				property_data_json.put("paper_size", paper_size);
				property_data_json.put("no_of_copy", no_of_copy);

				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid);
				property_data_json.put("office_region", office_region);
				property_data_json.put("office_distict", "No" + "_" + "No");
				property_data_json.put("office_region_received", regional_code + "_" + regional_name);
				property_data_json.put("office_distict_received", distict_code + "_" + district_name);
				property_data_json.put("submission_type", submission_type);

				property_data_json.put("created_for", created_for);
				property_data_json.put("created_for_id", created_for_id);
				property_data_json.put("surveyors_client", surveyors_client);
				property_data_json.put("application_required_additional_bill", application_required_additional_bill);
				property_data_json.put("manual_bill_desc", manual_bill_desc);
				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid); 
				property_data_json.put("mac_address", mac_address);
				jsonArray.put(property_data_json);

				// rs_result = jsonArray.toString();

				System.out.println(jsonArray.toString());
				web_service_response = casemgt_cl
						.online_calculate_bill_only(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								jsonArray.toString());
				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					String pdfFileName = "bill.pdf";

					JSONObject jsonobject = new JSONObject(web_service_response);
					String ws_bill_number = jsonobject.getString("unique");
					// String ws_bill_details_db=general_all
					// case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
					// String ws_bill_details_db=
					// case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

					// System.out.println(ws_bill_number);

					// String pdf_dest = "C:\\gelisdocs\\billspdf\\";

					String pdf_dest = cls_url_config.getCase_upload_location();
					String files_pdf_jackets_p = pdf_dest + service_bill_descdription_formated + "_" + ws_bill_number
							+ pdfFileName;
					/*
					 * String files_pdf_jackets_p = pdf_dest + ws_case_number +
					 * "\\" + service_bill_descdription_formated + "_" +
					 * job_number + pdfFileName;
					 */
					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_service_bill_online_new(
							cls_url_config.getSoftfile_location(), property_data_json.toString(),
							web_service_response, session.getAttribute("fullname").toString(), files_pdf_jackets_p);


				// 	JSONObject pdf_upload_obj = new JSONObject();
				// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				// pdf_upload_obj.put("jobNumber", ws_bill_number);
				// pdf_upload_obj.put("caseNumber",ws_bill_number);
				// pdf_upload_obj.put("fileData",base64Encoded);
				
				// pdf_upload_obj.put("doc_name",ws_bill_number);
				// pdf_upload_obj.put("doc_description","Service Bill");
				// pdf_upload_obj.put("doc_category","public_docs");
				// pdf_upload_obj.put("doc_app_uploaded","elis");
				// pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				// pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				// pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
 				// String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				// cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

 //System.out.println(pdf_upload_response);
// 					File pdfFile = new File(files_pdf_jackets_p);
// 					byte[] buffer = null;

// 					// String pdfFilename = "test.pdf"; // I use id here to
// 					// determine pdf
// 					// File f = new File(pdfFilename);

// 					BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
// 					ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

// 					int ch;
// 					long actual = 0;
// 					while ((ch = is.read()) != -1) {
// 						bos.write(ch);
// 						actual++;
// 					}
// 					bos.flush();
// 					bos.close();
// 					buffer = bos.toByteArray();
//  //Upload to DOCUMENT MGT
// 					//dealet the file
// 					//
// 					response.setContentType("application/pdf");
// 					response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
// 					// response.addHeader("Content-Disposition", "inline;
// 					// filename=Documentation.pdf");
// 					response.setContentLength((int) pdfFile.length());
// 					response.getOutputStream().write(buffer, 0, buffer.length);

				if (buffer != null) {
					// Set response content type to PDF
					response.setContentType("application/pdf");
					
					// Set the content-disposition header to download the file with the specified name
					response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
					
					// Set the content length of the response based on the buffer length (size of the PDF in bytes)
					response.setContentLength(buffer.length);
					
					// Write the PDF byte array to the output stream to download it
					response.getOutputStream().write(buffer, 0, buffer.length);
					
					// Flush the output stream
					response.getOutputStream().flush();
					
					// Close the output stream
					response.getOutputStream().close();
				} else {
					// Handle the case where the PDF generation failed
					response.setContentType("text/html");
					response.getWriter().write("Error generating PDF.");
				}

				} else {
					System.out.println(web_service_response);
				}
			}


			if (request_type.equals("process_online_select_bill_for_regional_transitional")) {

				String main_service_id = request.getParameter("main_service_id");
				String main_service_sub_id = request.getParameter("main_service_sub_id");
				String main_service_desc = request.getParameter("main_service_desc");
				String main_service_sub_desc = request.getParameter("main_service_sub_desc");

				String client_name = request.getParameter("client_name");
				String case_number = request.getParameter("case_number");

				String land_size = request.getParameter("land_size");
				String old_bill_amount = request.getParameter("bill_amount");
				String old_bill_number = request.getParameter("old_bill_number");
				String registration_forms = request.getParameter("registration_forms");
				String publication_type = request.getParameter("publication_type");
				String type_of_use = request.getParameter("type_of_use");

				String licensed_surveyor_number = request.getParameter("licensed_surveyor_number");
				String licensed_surveyor_name = request.getParameter("licensed_surveyor_name");

				String locality = request.getParameter("locality");
				String ar_gender = request.getParameter("ar_gender");
				String ar_district = request.getParameter("ar_district");
				String ar_region = request.getParameter("ar_region");

				String paper_size = request.getParameter("paper_size");
				String revenue_item = request.getParameter("revenue_item");
				String no_of_copy = request.getParameter("no_of_copy");

				if (no_of_copy != null) {

				} else {
					no_of_copy = "0";
				}
				String office_region = (String) session.getAttribute("regional_code") + "_"
						+ (String) session.getAttribute("regional_name");
				String submission_type = request.getParameter("submission_type");

				String fullname = (String) session.getAttribute("fullname");
				String userid = (String) session.getAttribute("userid");

				String regional_code = (String) session.getAttribute("regional_code");
				String regional_name = (String) session.getAttribute("regional_name");
				String distict_code = (String) session.getAttribute("distict_code");
				String district_name = (String) session.getAttribute("district_name");

				String created_for = request.getParameter("created_for");
				String created_for_id = request.getParameter("created_for_id");
				String application_required_additional_bill = request
						.getParameter("application_required_additional_bill");

				String surveyors_client = request.getParameter("surveyors_client");
				String manual_bill_desc = request.getParameter("manual_bill_desc");
				/*
				 * String[] output = registration_forms.split("-"); String
				 * form_number = output[0]; String form_name = output[1];
				 * 
				 * String[] output_sub = type_of_use.split("-"); String
				 * typeofuse_id = output_sub[0]; String typeofuse_name =
				 * output_sub[1];
				 */

				String service_bill_descdription_formated = main_service_sub_desc.replace(" ", "_");
				String rs_result = null;

				JSONArray jsonArray = new JSONArray();
				JSONObject property_data_json = new JSONObject();

				property_data_json.put("business_process_id", main_service_id);
				property_data_json.put("business_process_name", main_service_desc);
				property_data_json.put("business_process_sub_id", main_service_sub_id);
				property_data_json.put("business_process_sub_name", main_service_sub_desc);
				property_data_json.put("client_name", client_name);
				property_data_json.put("case_number", case_number);

				property_data_json.put("land_size", land_size);
				property_data_json.put("old_bill_number", old_bill_number);
				property_data_json.put("old_bill_amount", old_bill_amount);
				property_data_json.put("type_of_use", type_of_use);
				property_data_json.put("publication_type", publication_type);
				property_data_json.put("form_number", registration_forms);
				property_data_json.put("revenue_item", revenue_item);

				property_data_json.put("licensed_surveyor_number", licensed_surveyor_number);
				property_data_json.put("licensed_surveyor_name", licensed_surveyor_name);

				property_data_json.put("locality", locality);
				property_data_json.put("ar_gender", ar_gender);
				property_data_json.put("ar_district", ar_district);
				property_data_json.put("ar_region", ar_region);

				property_data_json.put("paper_size", paper_size);
				property_data_json.put("no_of_copy", no_of_copy);

				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid);
				property_data_json.put("office_region", office_region);
				property_data_json.put("office_distict", "No" + "_" + "No");
				property_data_json.put("office_region_received", regional_code + "_" + regional_name);
				property_data_json.put("office_distict_received", distict_code + "_" + district_name);
				property_data_json.put("submission_type", submission_type);

				property_data_json.put("created_for", created_for);
				property_data_json.put("created_for_id", created_for_id);
				property_data_json.put("surveyors_client", surveyors_client);
				property_data_json.put("application_required_additional_bill", application_required_additional_bill);
				property_data_json.put("manual_bill_desc", manual_bill_desc);

				jsonArray.put(property_data_json);

				// rs_result = jsonArray.toString();

				System.out.println(jsonArray.toString());
				web_service_response = casemgt_cl
						.online_select_bill_for_regional_transitional_application(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								jsonArray.toString());
				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					String pdfFileName = "bill.pdf";

					JSONObject jsonobject = new JSONObject(web_service_response);
					String ws_bill_number = jsonobject.getString("unique");
					// String ws_bill_details_db=general_all
					// case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
					// String ws_bill_details_db=
					// case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

					// System.out.println(ws_bill_number);

					// String pdf_dest = "C:\\gelisdocs\\billspdf\\";

					String pdf_dest = cls_url_config.getCase_upload_location();
					String files_pdf_jackets_p = pdf_dest + service_bill_descdription_formated + "_" + ws_bill_number
							+ pdfFileName;
					/*
					 * String files_pdf_jackets_p = pdf_dest + ws_case_number +
					 * "\\" + service_bill_descdription_formated + "_" +
					 * job_number + pdfFileName;
					 */
					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_service_bill_for_regional_transitional(
							cls_url_config.getSoftfile_location(), property_data_json.toString(),
							web_service_response, session.getAttribute("fullname").toString(), files_pdf_jackets_p);

				// 	JSONObject pdf_upload_obj = new JSONObject();
				// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				// pdf_upload_obj.put("jobNumber", ws_bill_number);
				// pdf_upload_obj.put("caseNumber",ws_bill_number);
				// pdf_upload_obj.put("fileData",base64Encoded);
							
				
				// pdf_upload_obj.put("doc_name",ws_bill_number);
				// pdf_upload_obj.put("doc_description","Service Bill");
				// pdf_upload_obj.put("doc_category","public_docs");
				// pdf_upload_obj.put("doc_app_uploaded","elis");
				// pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				// pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				// pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
			
 				// String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				// cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

					if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}

				} else {
					System.out.println(web_service_response);
				}
			}

			if(request_type.equals("select_load_previous_bill_number")) {

				String bill_number = request.getParameter("bill_number");
				String regional_code = request.getParameter("regional_code");

				JSONObject obj = new JSONObject();

				obj.put("bill_number", bill_number);
				obj.put("regional_code", regional_code);

				String input = obj.toString();

				//System.out.println(input);
				web_service_response = casemgt_cl
						.select_load_previous_bill_number(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("online_select_bill_for_tamp_duty_light_document")) {

				String main_service_id = request.getParameter("main_service_id");
				String main_service_sub_id = request.getParameter("main_service_sub_id");
				String main_service_desc = request.getParameter("main_service_desc");
				String main_service_sub_desc = request.getParameter("main_service_sub_desc");

				String client_name = request.getParameter("client_name");
				String case_number = request.getParameter("case_number");

				String land_size = request.getParameter("land_size");

				String registration_forms = request.getParameter("registration_forms");
				String publication_type = request.getParameter("publication_type");
				String type_of_use = request.getParameter("type_of_use");

				String licensed_surveyor_number = request.getParameter("licensed_surveyor_number");
				String licensed_surveyor_name = request.getParameter("licensed_surveyor_name");

				String locality = request.getParameter("locality");
				String ar_gender = request.getParameter("ar_gender");
				String ar_district = request.getParameter("ar_district");
				String ar_region = request.getParameter("ar_region");

				String paper_size = request.getParameter("paper_size");
				String revenue_item = request.getParameter("revenue_item");
				String no_of_copy = request.getParameter("no_of_copy");
				String office_region = request.getParameter("office_region");
				String submission_type = request.getParameter("submission_type");
				String surveyors_client = request.getParameter("surveyors_client");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				String regional_code = (String) session.getAttribute("regional_code");
				String regional_name = (String) session.getAttribute("regional_name");
				String distict_code = (String) session.getAttribute("distict_code");
				String district_name = (String) session.getAttribute("district_name");

				String created_for = request.getParameter("created_for");
				String created_for_id = request.getParameter("created_for_id");
				String application_required_additional_bill = request
						.getParameter("application_required_additional_bill");

				/*
				 * String[] output = registration_forms.split("-"); String
				 * form_number = output[0]; String form_name = output[1];
				 * 
				 * String[] output_sub = type_of_use.split("-"); String
				 * typeofuse_id = output_sub[0]; String typeofuse_name =
				 * output_sub[1];
				 */

				String service_bill_descdription_formated = "APPLICATION FOR STAMP DUTY PAYMENT";
				String rs_result = null;

				JSONArray jsonArray = new JSONArray();
				JSONObject property_data_json = new JSONObject();

				property_data_json.put("business_process_id", 411);
				property_data_json.put("business_process_name", "APPLICATION FOR STAMP DUTY PAYMENT");
				property_data_json.put("business_process_sub_id", 411);
				property_data_json.put("business_process_sub_name", main_service_sub_desc);
				property_data_json.put("client_name", client_name);
				property_data_json.put("case_number", case_number);

				property_data_json.put("land_size", land_size);
				property_data_json.put("type_of_use", type_of_use);
				property_data_json.put("publication_type", publication_type);
				property_data_json.put("form_number", registration_forms);
				property_data_json.put("revenue_item", revenue_item);

				property_data_json.put("licensed_surveyor_number", licensed_surveyor_number);
				property_data_json.put("licensed_surveyor_name", licensed_surveyor_name);

				property_data_json.put("locality", locality);
				property_data_json.put("ar_gender", ar_gender);
				property_data_json.put("ar_district", ar_district);
				property_data_json.put("ar_region", ar_region);

				property_data_json.put("paper_size", paper_size);
				property_data_json.put("no_of_copy", no_of_copy);

				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid);
				property_data_json.put("office_region", office_region);
				property_data_json.put("office_distict", "No" + "_" + "No");
				property_data_json.put("office_region_received", regional_code + "_" + regional_name);
				property_data_json.put("office_distict_received", distict_code + "_" + district_name);
				property_data_json.put("submission_type", submission_type);
				property_data_json.put("surveyors_client", surveyors_client);
				property_data_json.put("created_for", created_for);
				property_data_json.put("created_for_id", created_for_id);
				property_data_json.put("application_required_additional_bill", application_required_additional_bill);
				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid); 
				property_data_json.put("mac_address", mac_address);

				jsonArray.put(property_data_json);

				rs_result = jsonArray.toString();

				System.out.println("rs_result");
				System.out.println(rs_result);
				web_service_response = casemgt_cl.online_select_bill_for_tamp_duty_light_document(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						rs_result);
				if (web_service_response != null) {
					System.out.println("web_service_response");
					System.out.println(web_service_response);
					String pdfFileName = "bill.pdf";

					JSONObject jsonobject = new JSONObject(web_service_response);
					String ws_bill_number = jsonobject.getString("unique");
					// String ws_bill_details_db=general_all
					// case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
					// String ws_bill_details_db=
					// case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

					// System.out.println(ws_bill_number);

					// String pdf_dest = "C:\\gelisdocs\\billspdf\\";

					String pdf_dest = cls_url_config.getCase_upload_location();
					String files_pdf_jackets_p = pdf_dest + service_bill_descdription_formated + "_" + ws_bill_number
							+ pdfFileName;
					/*
					 * String files_pdf_jackets_p = pdf_dest + ws_case_number +
					 * "\\" + service_bill_descdription_formated + "_" +
					 * job_number + pdfFileName;
					 */
					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_service_bill_online_new(
							cls_url_config.getSoftfile_location(), property_data_json.toString(),
							web_service_response, session.getAttribute("fullname").toString(), files_pdf_jackets_p);


				// 	JSONObject pdf_upload_obj = new JSONObject();
				// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				// pdf_upload_obj.put("jobNumber", ws_bill_number);
				// pdf_upload_obj.put("caseNumber",ws_bill_number);
				// pdf_upload_obj.put("fileData",base64Encoded);
							
				
				// pdf_upload_obj.put("doc_name",ws_bill_number);
				// pdf_upload_obj.put("doc_description","Service Bill");
				// pdf_upload_obj.put("doc_category","public_docs");
				// pdf_upload_obj.put("doc_app_uploaded","elis");
				// pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				// pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				// pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
			
 				// String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				// cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

					if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}

				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("generate_egcr_pdf_only")) {

				String ws_receipt_number = "";
				String ws_ref_number = request.getParameter("ref_number");
				JSONObject obj = new JSONObject();

				obj.put("ref_number", ws_ref_number);

				String ws_bill_details_db = casemgt_cl
						.lc_payment_verification_for_bill_gcr(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				JSONObject jsonobject_result_main = new JSONObject(ws_bill_details_db);
				if (jsonobject_result_main.getString("success") == "true") {
					String result_data = jsonobject_result_main.getString("data");
					JSONObject jsonobject_result = new JSONObject(result_data);
					ws_receipt_number = jsonobject_result.getString("payment_slip_number");

					if (ws_receipt_number.length() > 4) {
						String pdf_dest = cls_url_config.getCase_upload_location() + "egcr\\";
						String files_pdf_jackets_p = pdf_dest + ws_ref_number + ".pdf";
						File files_pdf_jackets = new File(pdf_dest);

						InputStream pdf_blob = billgeneration_cl.generate_egcr_get_pdf(cls_url_config.getEgcr_url(),
								cls_url_config.getSoftfile_location(), ws_receipt_number);

		byte[] buffer = new byte[1024]; // Initialize buffer for reading input in chunks
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream(); // For holding the PDF data
		int bytesRead;	
		// Read the InputStream and write to the ByteArrayOutputStream
		while ((bytesRead = pdf_blob.read(buffer)) != -1) {
			// Write the bytes to the output stream
			outputStream.write(buffer, 0, bytesRead);
		}
		// Convert the ByteArrayOutputStream to a byte array containing the full PDF
		byte[] pdfBytes = outputStream.toByteArray();
		// Close the input stream
		pdf_blob.close();
		// Close the ByteArrayOutputStream
		outputStream.close();
		
		// If the PDF data was successfully read
		if (pdfBytes != null && pdfBytes.length > 0) {
			
			// Set response content type to PDF
			response.setContentType("application/pdf");
							
			// Set the content-disposition header to download the file with the specified name
			response.addHeader("Content-Disposition", "attachment; filename=" + "pdfFileName.pdf");
			
			// Set the content length of the response based on the buffer length (size of the PDF in bytes)
			response.setContentLength(pdfBytes.length);
			
			// Write the PDF byte array to the output stream to download it
			response.getOutputStream().write(pdfBytes, 0, pdfBytes.length);
			
			// Flush the output stream
			response.getOutputStream().flush();
			
			// Close the output stream
			response.getOutputStream().close();
		} else {
			// Handle the case where the PDF generation failed
			response.setContentType("text/html");
			response.getWriter().write("Error generating PDF.");
		}
		
					
			}

		} else {
			System.out.println(web_service_response);
		}

	}

			if (request_type.equals("process_online_select_acknowledgement_for_registration")) {

				String main_service_id = request.getParameter("main_service_id");
				String main_service_sub_id = request.getParameter("main_service_sub_id");
				String main_service_desc = request.getParameter("main_service_desc");
				String main_service_sub_desc = request.getParameter("main_service_sub_desc");

				String client_name = request.getParameter("client_name");
				String land_size = request.getParameter("land_size");

				String locality_of_parcel = request.getParameter("locality_of_parcel");
				String application_type = request.getParameter("application_type");
				String type_of_interest = request.getParameter("type_of_interest");
				String job_number = request.getParameter("job_number");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				// String jn_id = request.getParameter("jn_id");

				// String[] output = registration_forms.split("-");
				// String form_number=output[0];
				// String form_name=output[1];

				String[] output_sub = type_of_interest.split("-");
				String type_of_interest_id = output_sub[0];
				String type_of_interest_name = output_sub[1];

				String rs_result = null;
				String service_bill_descdription_formated = main_service_sub_desc.replace(" ", "_");
				JSONArray jsonArray = new JSONArray();
				JSONObject property_data_json = new JSONObject();

				property_data_json.put("business_process_id", main_service_id);
				// property_data_json.put("jn_id",jn_id);
				property_data_json.put("business_process_name", main_service_desc);
				property_data_json.put("business_process_sub_id", main_service_sub_id);
				property_data_json.put("business_process_sub_name", main_service_sub_desc);
				property_data_json.put("ar_name", client_name);
				property_data_json.put("land_size", land_size);
				property_data_json.put("type_of_interest", type_of_interest);
				property_data_json.put("application_type", application_type);
				property_data_json.put("locality_of_parcel", locality_of_parcel);
				property_data_json.put("job_number", job_number);

				//property_data_json.put("userid", userid);
				//property_data_json.put("fullname", fullname);

				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid); 
				property_data_json.put("mac_address", mac_address);

				jsonArray.put(property_data_json);

				rs_result = jsonArray.toString();

				// System.out.println(rs_result);
				web_service_response = casemgt_cl.online_select_process_acknowledgement_registration(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						rs_result);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					String pdfFileName = "acnkwledgeslip.pdf";

					JSONObject jsonobject = new JSONObject(web_service_response);
					String ws_case_number = jsonobject.getString("case_number");
					// String ws_bill_details_db=
					// case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
					// String ws_bill_details_db=
					// case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

					String pdf_dest = cls_url_config.getCase_upload_location();
					String files_pdf_jackets_p = pdf_dest + ws_case_number + File.separator
							+ service_bill_descdription_formated
							+ "_" + job_number + pdfFileName;

					// File files_pdf_jackets = new File(pdf_dest + ws_case_number);

					// if (!files_pdf_jackets.exists()) {
					// 	if (files_pdf_jackets.mkdirs()) {
					// 		// System.out.println("Multiple directories are
					// 		// created!");
					// 	} else {
					// 		System.out.println("Failed to create multiple directories!");
					// 	}
					// }

					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_acknowledgement_slip_online_new(
							cls_url_config.getSoftfile_location(),
							property_data_json.toString(), web_service_response,
							session.getAttribute("fullname").toString(), files_pdf_jackets_p);


					JSONObject pdf_upload_obj = new JSONObject();
					String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				pdf_upload_obj.put("jobNumber", job_number);
				pdf_upload_obj.put("caseNumber",ws_case_number);
				pdf_upload_obj.put("fileData",base64Encoded);
							
				
				pdf_upload_obj.put("doc_name",job_number);
				pdf_upload_obj.put("doc_description","Acknowledgement Slip");
				pdf_upload_obj.put("doc_category","public_docs");
				pdf_upload_obj.put("doc_app_uploaded","elis");
				pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
			
 				String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

					// File pdfFile = new File(files_pdf_jackets_p);
					// byte[] buffer = null;

					// // String pdfFilename = "test.pdf"; // I use id here to
					// // determine pdf
					// // File f = new File(pdfFilename);

					// BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
					// ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

					// int ch;
					// long actual = 0;
					// while ((ch = is.read()) != -1) {
					// 	bos.write(ch);
					// 	actual++;
					// }
					// bos.flush();
					// bos.close();
					// buffer = bos.toByteArray();

					// response.setContentType("application/pdf");
					// response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
					// // response.addHeader("Content-Disposition", "inline;
					// // filename=Documentation.pdf");
					// response.setContentLength((int) pdfFile.length());
					// response.getOutputStream().write(buffer, 0, buffer.length);

					if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}
				} else {
					// System.out.println(web_service_response);
				}
			}

			if (request_type.equals("process_resubmission_slip")) {

				String client_name = request.getParameter("client_name");
				String case_number = request.getParameter("case_number");
				String publication_type = request.getParameter("publication_type");
				String job_number = request.getParameter("job_number");

				String userid = (String) session.getAttribute("userid");
				String fullname = request.getParameter("user_fullname");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

			
				JSONObject property_data_json = new JSONObject();

				property_data_json.put("client_name", client_name);
				// property_data_json.put("jn_id",jn_id);
				property_data_json.put("case_number", case_number);
				property_data_json.put("publication_type", publication_type);
				property_data_json.put("job_number", job_number);

				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid); 
				property_data_json.put("mac_address", mac_address);

				String rs_result = property_data_json.toString();

				// System.out.println(rs_result);
				web_service_response = casemgt_cl.process_resubmission_slip(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						rs_result);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					String pdfFileName = "re_sub_acnkwledgeslip.pdf";

					JSONObject jsonobject = new JSONObject(property_data_json.toString());
					String ws_case_number = jsonobject.getString("case_number");
					// String ws_bill_details_db=
					// case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
					// String ws_bill_details_db=
					// case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

					String pdf_dest = cls_url_config.getCase_upload_location();
					String files_pdf_jackets_p = pdf_dest + ws_case_number + File.separator
							+ "_" + job_number + pdfFileName;

					// File files_pdf_jackets = new File(pdf_dest + ws_case_number);

					// if (!files_pdf_jackets.exists()) {
					// 	if (files_pdf_jackets.mkdirs()) {
					// 		// System.out.println("Multiple directories are
					// 		// created!");
					// 	} else {
					// 		System.out.println("Failed to create multiple directories!");
					// 	}
					// }

					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_acknowledgement_slip_re_submission(
							cls_url_config.getSoftfile_location(),
							property_data_json.toString(), web_service_response,
							session.getAttribute("fullname").toString(), files_pdf_jackets_p);


					JSONObject pdf_upload_obj = new JSONObject();
					String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				pdf_upload_obj.put("jobNumber", job_number);
				pdf_upload_obj.put("caseNumber",ws_case_number);
				pdf_upload_obj.put("fileData",base64Encoded);
							
				
				pdf_upload_obj.put("doc_name",job_number);
				pdf_upload_obj.put("doc_description","Acknowledgement Slip");
				pdf_upload_obj.put("doc_category","public_docs");
				pdf_upload_obj.put("doc_app_uploaded","elis");
				pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
			
 				String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

					// File pdfFile = new File(files_pdf_jackets_p);
					// byte[] buffer = null;

					// // String pdfFilename = "test.pdf"; // I use id here to
					// // determine pdf
					// // File f = new File(pdfFilename);

					// BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
					// ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

					// int ch;
					// long actual = 0;
					// while ((ch = is.read()) != -1) {
					// 	bos.write(ch);
					// 	actual++;
					// }
					// bos.flush();
					// bos.close();
					// buffer = bos.toByteArray();

					// response.setContentType("application/pdf");
					// response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
					// // response.addHeader("Content-Disposition", "inline;
					// // filename=Documentation.pdf");
					// response.setContentLength((int) pdfFile.length());
					// response.getOutputStream().write(buffer, 0, buffer.length);

					if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}
				} else {
					// System.out.println(web_service_response);
				}
			}

			if (request_type.equals("online_select_process_acknowledgement_not_on_case_exist")) {

				String main_service_id = request.getParameter("main_service_id");
				String main_service_sub_id = request.getParameter("main_service_sub_id");
				String main_service_desc = request.getParameter("main_service_desc");
				String main_service_sub_desc = request.getParameter("main_service_sub_desc");

				String client_name = request.getParameter("client_name");
				String land_size = request.getParameter("land_size");
				String locality = request.getParameter("locality");

				String type_of_use = request.getParameter("type_of_use");
				String type_of_interest = request.getParameter("type_of_interest");
				String nature_of_instrument = request.getParameter("nature_of_instrument");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				String regional_code = (String) session.getAttribute("regional_code");
				String regional_name = (String) session.getAttribute("regional_name");
				String distict_code = (String) session.getAttribute("distict_code");
				String district_name = (String) session.getAttribute("district_name");

				// String service_bill_descdription_formated =
				// main_service_sub_desc.replace(" ", "_");
				String rs_result = null;

				JSONArray jsonArray = new JSONArray();
				JSONObject property_data_json = new JSONObject();
				property_data_json.put("business_process_id", main_service_id);
				property_data_json.put("business_process_name", main_service_desc);
				property_data_json.put("business_process_sub_id", main_service_sub_id);
				property_data_json.put("business_process_sub_name", main_service_sub_desc);
				property_data_json.put("ar_name", client_name);

				property_data_json.put("land_size", land_size);
				property_data_json.put("locality_of_parcel", locality);

				property_data_json.put("type_of_use", type_of_use);
				property_data_json.put("type_of_interest", type_of_interest);
				property_data_json.put("nature_of_instrument", nature_of_instrument);

				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid);
				// property_data_json.put("office_region", office_region);
				property_data_json.put("office_distict", "No" + "_" + "No");
				property_data_json.put("office_region_received", regional_code + "_" + regional_name);
				property_data_json.put("office_distict_received", distict_code + "_" + district_name);
				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid); 
				property_data_json.put("mac_address", mac_address);

				jsonArray.put(property_data_json);

				rs_result = jsonArray.toString();

				// System.out.println(rs_result);
				web_service_response = casemgt_cl.online_select_process_acknowledgement_not_on_case_exist(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						rs_result);
				if (web_service_response != null) {
					// System.out.println(web_service_response);

				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_process_acknowledgement_not_on_case_exist_cj")) {

				String main_service_id = request.getParameter("main_service_id");
				String main_service_sub_id = request.getParameter("main_service_sub_id");
				String main_service_desc = request.getParameter("main_service_desc");
				String main_service_sub_desc = request.getParameter("main_service_sub_desc");

				String client_name = request.getParameter("client_name");
				String land_size = request.getParameter("land_size");
				String locality = request.getParameter("locality");

				String type_of_use = request.getParameter("type_of_use");
				String type_of_interest = request.getParameter("type_of_interest");
				String nature_of_instrument = request.getParameter("nature_of_instrument");

				String job_number = request.getParameter("job_number");
				String case_number = request.getParameter("case_number");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				String regional_code = (String) session.getAttribute("regional_code");
				String regional_name = (String) session.getAttribute("regional_name");
				String distict_code = (String) session.getAttribute("distict_code");
				String district_name = (String) session.getAttribute("district_name");

				// String service_bill_descdription_formated =
				// main_service_sub_desc.replace(" ", "_");
				String rs_result = null;

				JSONArray jsonArray = new JSONArray();
				JSONObject property_data_json = new JSONObject();
				property_data_json.put("business_process_id", main_service_id);
				property_data_json.put("business_process_name", main_service_desc);
				property_data_json.put("business_process_sub_id", main_service_sub_id);
				property_data_json.put("business_process_sub_name", main_service_sub_desc);
				property_data_json.put("ar_name", client_name);

				property_data_json.put("land_size", land_size);
				property_data_json.put("locality_of_parcel", locality);

				property_data_json.put("type_of_use", type_of_use);
				property_data_json.put("type_of_interest", type_of_interest);
				property_data_json.put("nature_of_instrument", nature_of_instrument);

				property_data_json.put("job_number", job_number);
				property_data_json.put("case_number", case_number);

				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid);
				// property_data_json.put("office_region", office_region);
				property_data_json.put("office_distict", "No" + "_" + "No");
				property_data_json.put("office_region_received", regional_code + "_" + regional_name);
				property_data_json.put("office_distict_received", distict_code + "_" + district_name);
				property_data_json.put("fullname", fullname);
				property_data_json.put("userid", userid); 
				property_data_json.put("mac_address", mac_address);
				jsonArray.put(property_data_json);

				rs_result = jsonArray.toString();

				// System.out.println(rs_result);
				web_service_response = casemgt_cl.online_select_process_acknowledgement_not_on_case_exist_cj(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						rs_result);
				if (web_service_response != null) {
					// System.out.println(web_service_response);

				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("print_rent_demand_notice")) {

				String job_number = request.getParameter("job_number");
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");

				String rent_passing_per_acres = request.getParameter("rent_passing_per_acres");
				String rent_period_for_demand_note = request.getParameter("rent_period_for_demand_note");

				String interest_rate = request.getParameter("interest_rate");
				String size_of_land = request.getParameter("size_of_land");
				String rent_passing_per_app = request.getParameter("rent_passing_per_app");

				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String rs_result = null;

				JSONArray jsonArray = new JSONArray();
				JSONObject property_data_json = new JSONObject();

				property_data_json.put("job_number", job_number);
				property_data_json.put("case_number", case_number);
				property_data_json.put("transaction_number", transaction_number);

				property_data_json.put("rent_passing_per_acres", rent_passing_per_acres);
				property_data_json.put("interest_rate", interest_rate);
				property_data_json.put("size_of_land", size_of_land);
				property_data_json.put("rent_passing_per_app", rent_passing_per_app);
				property_data_json.put("rent_period_for_demand_note", rent_period_for_demand_note);

				property_data_json.put("userid", userid);
				property_data_json.put("fullname", fullname);

				jsonArray.put(property_data_json);

				rs_result = jsonArray.toString();

				// System.out.println(rs_result);

				// web_service_response = "data";
				web_service_response = casemgt_cl.online_select_update_assessesd_rent(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						property_data_json.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
					String pdfFileName = "rent_demand_notice.pdf";

					String pdf_dest = cls_url_config.getCase_upload_location();
					String files_pdf_jackets_p = pdf_dest + case_number + "/" + job_number + pdfFileName;

					// File files_pdf_jackets = new File(pdf_dest + case_number);

					// if (!files_pdf_jackets.exists()) {
					// 	if (files_pdf_jackets.mkdirs()) {
					// 		System.out.println("Multiple directories are created!");
					// 	} else {
					// 		// System.out.println("Failed to create multiple
					// 		// directories!");
					// 	}
					// }

					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_lc_rent_demand_notice(
							cls_url_config.getSoftfile_location(), property_data_json.toString(),
							session.getAttribute("fullname").toString(), files_pdf_jackets_p);


					JSONObject pdf_upload_obj = new JSONObject();
					String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				pdf_upload_obj.put("jobNumber", job_number);
				pdf_upload_obj.put("caseNumber",case_number);
				pdf_upload_obj.put("fileData",base64Encoded);
							
				
				pdf_upload_obj.put("doc_name",job_number);
				pdf_upload_obj.put("doc_description","Rent Demand Notice Bill");
				pdf_upload_obj.put("doc_category","public_docs");
				pdf_upload_obj.put("doc_app_uploaded","elis");
				pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
			
 				String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

					// File pdfFile = new File(files_pdf_jackets_p);
					// byte[] buffer = null;

					// // String pdfFilename = "test.pdf"; // I use id here to
					// // determine pdf
					// // File f = new File(pdfFilename);

					// BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
					// ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

					// int ch;
					// long actual = 0;
					// while ((ch = is.read()) != -1) {
					// 	bos.write(ch);
					// 	actual++;
					// }
					// bos.flush();
					// bos.close();
					// buffer = bos.toByteArray();

					// response.setContentType("application/pdf");
					// response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
					// // response.addHeader("Content-Disposition", "inline;
					// // filename=Documentation.pdf");
					// response.setContentLength((int) pdfFile.length());
					// response.getOutputStream().write(buffer, 0, buffer.length);

					if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}


				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("process_print_stamp_duty_bill")) {

				String main_service_id = request.getParameter("business_process_id");
				String main_service_sub_id = request.getParameter("business_process_name");
				String main_service_desc = request.getParameter("business_process_sub_id");
				String main_service_sub_desc = request.getParameter("business_process_sub_name");
				String client_name = request.getParameter("ar_name");
				String stamp_duty_amount = request.getParameter("stamp_duty_amount");
				String assessed_value_amount = request.getParameter("assessed_value_amount");
				String assessed_comment = request.getParameter("assessed_comment");

				// String land_size = request.getParameter("land_size");
				// String locality_of_parcel =
				// request.getParameter("locality_of_parcel");
				// String application_type =
				// request.getParameter("application_type");
				// String type_of_interest =
				// request.getParameter("type_of_interest");
				String job_number = request.getParameter("job_number");
				String case_number = request.getParameter("case_number");
				// String jn_id = request.getParameter("jn_id");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				// String ar_gender = request.getParameter("ar_gender");
				// String ar_cell_phone = request.getParameter("ar_cell_phone");
				// String ar_id_type = request.getParameter("ar_id_type");
				// String ar_id_number = request.getParameter("ar_id_number");
				// String ap_type_of_party =
				// request.getParameter("ap_type_of_party");

				// String jn_id = request.getParameter("jn_id");

				// String[] output = registration_forms.split("-");
				// String form_number=output[0];
				// String form_name=output[1];

				// String[] output_sub = type_of_interest.split("-");
				// String type_of_interest_id=output_sub[0];
				// String type_of_interest_name=output_sub[1];

				String rs_result = null;

				JSONArray jsonArray = new JSONArray();
				JSONObject property_data_json = new JSONObject();

				property_data_json.put("business_process_id", main_service_id);
				// property_data_json.put("jn_id",jn_id);
				property_data_json.put("business_process_name", main_service_desc);
				property_data_json.put("business_process_sub_id", main_service_sub_id);
				property_data_json.put("business_process_sub_name", main_service_sub_desc);
				property_data_json.put("ar_name", client_name);

				property_data_json.put("stamp_duty_amount", stamp_duty_amount);
				property_data_json.put("assessed_value_amount", assessed_value_amount);
				property_data_json.put("assessed_comment", assessed_comment);

				// property_data_json.put("application_type", application_type);
				// property_data_json.put("locality_of_parcel",
				// locality_of_parcel);
				property_data_json.put("job_number", job_number);

				property_data_json.put("userid", userid);
				property_data_json.put("fullname", fullname);

				property_data_json.put("case_number", case_number);
				// property_data_json.put("jn_id", jn_id);

				// property_data_json.put("ar_gender", ar_gender);
				// property_data_json.put("ar_cell_phone", ar_cell_phone);
				// property_data_json.put("ar_id_type", ar_id_type);
				// property_data_json.put("ar_id_number", ar_id_number);
				// property_data_json.put("ap_type_of_party", ap_type_of_party);

				jsonArray.put(property_data_json);

				rs_result = jsonArray.toString();

				// System.out.println(rs_result);
				// web_service_response =
				// casemgt_cl.online_select_process_acknowledgement_on_case_sub(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),rs_result);

				web_service_response = "data";

				if (web_service_response != null) {
					// System.out.println(web_service_response);
					String pdfFileName = "stap_duty_bill.pdf";

					// JSONObject jsonobject = new
					// JSONObject(web_service_response);
					// String ws_case_number =
					// jsonobject.getString("case_number");
					// String ws_bill_details_db=
					// case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
					// String ws_bill_details_db=
					// case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

					String pdf_dest = cls_url_config.getCase_upload_location();
					String files_pdf_jackets_p = pdf_dest + case_number + "/" + job_number + pdfFileName;

					// File files_pdf_jackets = new File(pdf_dest + case_number);

					// if (!files_pdf_jackets.exists()) {
					// 	if (files_pdf_jackets.mkdirs()) {
					// 		// System.out.println("Multiple directories are
					// 		// created!");
					// 	} else {
					// 		System.out.println("Failed to create multiple directories!");
					// 	}
					// }

					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_stamp_duty_bill(cls_url_config.getSoftfile_location(),
							property_data_json.toString(),
							session.getAttribute("fullname").toString(), files_pdf_jackets_p);



					JSONObject pdf_upload_obj = new JSONObject();
					String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				pdf_upload_obj.put("jobNumber", job_number);
				pdf_upload_obj.put("caseNumber",case_number);
				pdf_upload_obj.put("fileData",base64Encoded);
							
				
				pdf_upload_obj.put("doc_name",job_number);
				pdf_upload_obj.put("doc_description","Stamp Duty Bill");
				pdf_upload_obj.put("doc_category","public_docs");
				pdf_upload_obj.put("doc_app_uploaded","elis");
				pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
			
 				String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

					// File pdfFile = new File(files_pdf_jackets_p);
					// byte[] buffer = null;

					// // String pdfFilename = "test.pdf"; // I use id here to
					// // determine pdf
					// // File f = new File(pdfFilename);

					// BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
					// ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

					// int ch;
					// long actual = 0;
					// while ((ch = is.read()) != -1) {
					// 	bos.write(ch);
					// 	actual++;
					// }
					// bos.flush();
					// bos.close();
					// buffer = bos.toByteArray();

					// response.setContentType("application/pdf");
					// response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
					// // response.addHeader("Content-Disposition", "inline;
					// // filename=Documentation.pdf");
					// response.setContentLength((int) pdfFile.length());
					// response.getOutputStream().write(buffer, 0, buffer.length);

					if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}


				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("select_address_register_edit_general")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				// System.out.println("select_address_register_edit_general");

				String case_number = request.getParameter("case_number");
				String ar_client_id = request.getParameter("ar_client_id");
				String type_of_party = request.getParameter("type_of_party");
				String ar_name = request.getParameter("ar_name");
				String ar_gender = request.getParameter("ar_gender");
				String ar_cell_phone = request.getParameter("ar_cell_phone");
				String ar_id_type = request.getParameter("ar_id_type");
				String ar_id_number = request.getParameter("ar_id_number");

				String ar_cell_phone2 = request.getParameter("ar_cell_phone2");
				String ar_nationality = request.getParameter("ar_nationality");
				String ar_address = request.getParameter("ar_address");
				String ar_tin_no = request.getParameter("ar_tin_no");
				String ar_location = request.getParameter("ar_location");
				String ar_district = request.getParameter("ar_district");
				String ar_region = request.getParameter("ar_region");
				String ar_person_type = request.getParameter("ar_person_type");
				String created_by = (String) session.getAttribute("fullname");
				String created_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				
				obj.put("ar_client_id", ar_client_id);
				obj.put("type_of_party", type_of_party);
				obj.put("ar_name", ar_name);
				obj.put("ar_gender", ar_gender);
				obj.put("ar_cell_phone", ar_cell_phone);
				obj.put("ar_id_type", ar_id_type);
				obj.put("ar_id_number", ar_id_number);
				obj.put("case_number", case_number);
				obj.put("ar_cell_phone2", ar_cell_phone2);
				obj.put("ar_nationality", ar_nationality);
				obj.put("ar_address", ar_address);
				obj.put("ar_tin_no", ar_tin_no);
				obj.put("ar_location", ar_location);
				obj.put("ar_district", ar_district);
				obj.put("ar_region", ar_region);
				obj.put("ar_person_type", ar_person_type);
				obj.put("created_by", created_by);
				obj.put("created_by_id", created_by_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				//System.out.println("Edit: " + input);

				// System.out.println(ar_client_id);
				web_service_response = casemgt_cl
						.select_address_register_edit_general(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					//System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}
			if (request_type.equals("select_address_register_add_new_general")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				// System.out.println("select_address_register_add_new_general");

				String case_number = request.getParameter("case_number");
				String type_of_party = request.getParameter("type_of_party");
				String ar_name = request.getParameter("ar_name");
				String ar_gender = request.getParameter("ar_gender");
				String ar_cell_phone = request.getParameter("ar_cell_phone");
				String ar_id_type = request.getParameter("ar_id_type");
				String ar_id_number = request.getParameter("ar_id_number");

				String ar_cell_phone2 = request.getParameter("ar_cell_phone2");
				String ar_nationality = request.getParameter("ar_nationality");
				String ar_address = request.getParameter("ar_address");
				String ar_tin_no = request.getParameter("ar_tin_no");
				String ar_location = request.getParameter("ar_location");
				String ar_district = request.getParameter("ar_district");
				String ar_region = request.getParameter("ar_region");
				String ar_person_type = request.getParameter("ar_person_type");
				String created_by = (String) session.getAttribute("fullname");
				String created_by_id = (String) session.getAttribute("userid");

				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");

				obj.put("case_number", case_number);
				obj.put("type_of_party", type_of_party);
				obj.put("ar_name", ar_name);
				obj.put("ar_gender", ar_gender);
				obj.put("ar_cell_phone", ar_cell_phone);
				obj.put("ar_id_type", ar_id_type);
				obj.put("ar_id_number", ar_id_number);

				obj.put("ar_cell_phone2", ar_cell_phone2);
				obj.put("ar_nationality", ar_nationality);
				obj.put("ar_address", ar_address);
				obj.put("ar_tin_no", ar_tin_no);
				obj.put("ar_location", ar_location);
				obj.put("ar_district", ar_district);
				obj.put("ar_region", ar_region);
				obj.put("ar_person_type", ar_person_type);
				obj.put("created_by", created_by);
				obj.put("created_by_id", created_by_id);
				obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				System.out.println("add: " + input);

				// System.out.println(case_number);
				web_service_response = casemgt_cl
						.select_address_register_add_new_general(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			

			if (request_type.equals("select_delete_party")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				// System.out.println("select_address_register_add_new_general");

				String case_number = request.getParameter("case_number");
				String type_of_party = request.getParameter("type_of_party");
				String ar_name = request.getParameter("ar_name");
				String ar_gender = request.getParameter("ar_gender");
				String ar_cell_phone = request.getParameter("ar_cell_phone");
				String ar_id_type = request.getParameter("ar_id_type");
				String ar_id_number = request.getParameter("ar_id_number");
				String ar_client_id = request.getParameter("ar_client_id");
				
				String ar_cell_phone2 = request.getParameter("ar_cell_phone2");
				String ar_nationality = request.getParameter("ar_nationality");
				String ar_address = request.getParameter("ar_address");
				String ar_tin_no = request.getParameter("ar_tin_no");
				String ar_location = request.getParameter("ar_location");
				String ar_district = request.getParameter("ar_district");
				String ar_region = request.getParameter("ar_region");
				String ar_person_type = request.getParameter("ar_person_type");
				String created_by = (String) session.getAttribute("fullname");
				String created_by_id = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				String ar_id = request.getParameter("ar_id");
				String p_uid = request.getParameter("p_uid");

				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");

				obj.put("case_number", case_number);
				obj.put("type_of_party", type_of_party);
				obj.put("ar_name", ar_name);
				obj.put("ar_gender", ar_gender);
				obj.put("ar_cell_phone", ar_cell_phone);
				obj.put("ar_id_type", ar_id_type);
				obj.put("ar_id_number", ar_id_number);

				obj.put("ar_cell_phone2", ar_cell_phone2);
				obj.put("ar_nationality", ar_nationality);
				obj.put("ar_address", ar_address);
				obj.put("ar_tin_no", ar_tin_no);
				obj.put("ar_location", ar_location);
				obj.put("ar_district", ar_district);
				obj.put("ar_region", ar_region);
				obj.put("ar_person_type", ar_person_type);
				obj.put("created_by", created_by);
				obj.put("created_by_id", created_by_id);
				obj.put("fullname", fullname);
				obj.put("job_number", job_number);
				obj.put("ar_client_id", ar_client_id);
				obj.put("ar_id", ar_id);
				obj.put("p_uid", p_uid);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				System.out.println("add: " + input);

				// System.out.println(case_number);
				web_service_response = casemgt_cl
						.select_delete_party(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("select_get_parties_by_case")) {

				String case_number = request.getParameter("case_number");

				// System.out.println(case_number);
				web_service_response = casemgt_cl.select_get_parties_by_case(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						case_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					// System.out.println("nothing to " + web_service_response);

				} else {
					System.out.println(web_service_response);
					// System.out.println("son=mtni to " +
					// web_service_response);
				}

				return web_service_response;

			}
			if (request_type.equals("select_get_party_by_party_id")) {

				String client_id = request.getParameter("client_id");

				// System.out.println(client_id);
				web_service_response = casemgt_cl.select_get_party_by_party_id(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						client_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					// System.out.println("nothing to " + web_service_response);

				} else {
					System.out.println(web_service_response);
					// System.out.println("son=mtni to " +
					// web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("select_load_application_for_publication_management")) {
				// String job_recieved_by_id =
				// request.getParameter("job_recieved_by_id");
				// System.out.println("loading ready for publication");
				web_service_response = casemgt_cl
						.select_load_application_for_publication_management(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_address_register_by_id_number")) {
				String id_number = request.getParameter("id_number");
				// System.out.println(id_number);
				web_service_response = casemgt_cl
						.select_address_register_by_id_number(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), id_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_address_register_add_new")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String case_number = request.getParameter("case_number");
				String type_of_party = request.getParameter("type_of_party");
				String ar_name = request.getParameter("ar_name");
				String ar_gender = request.getParameter("ar_gender");
				String ar_cell_phone = request.getParameter("ar_cell_phone");
				String ar_id_type = request.getParameter("ar_id_type");
				String ar_id_number = request.getParameter("ar_id_number");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				
				obj.put("case_number", case_number);
				obj.put("type_of_party", type_of_party);
				obj.put("ar_name", ar_name);
				obj.put("ar_gender", ar_gender);
				obj.put("ar_cell_phone", ar_cell_phone);
				obj.put("ar_id_type", ar_id_type);
				obj.put("ar_id_number", ar_id_number);
				obj.put("fullname", fullname);
obj.put("userid", userid); 
obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);

				// System.out.println(case_number);
				web_service_response = casemgt_cl
						.select_address_register_add_new(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("load_application_details_by_job_number")) {
				String job_number = request.getParameter("job_number");
				// System.out.println(job_number);
				web_service_response = casemgt_cl
						.load_application_details_by_job_number(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), job_number);

				JSONObject jsonobj = new JSONObject(web_service_response);
				// web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_application_details_by_job_number_within_unit")) {

				String job_number = (String) request.getParameter("job_number");
				String unit_id = (String) session.getAttribute("unit_id");
				// String userid = (String) session.getAttribute("userid");
				// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("unit_id", unit_id);
				
				 System.out.println(obj.toString());
				web_service_response = casemgt_cl
						.load_application_details_by_job_number_within_unit(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				// web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_application_details_by_job_number_all")) {
				String job_number = request.getParameter("job_number");
				// System.out.println(job_number);
				web_service_response = casemgt_cl.load_application_details_by_job_number_all(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						job_number);

				JSONObject jsonobj = new JSONObject(web_service_response);
				// web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_load_details_for_batching")) {
				String job_number = request.getParameter("job_number");
				// System.out.println(job_number);
				web_service_response = casemgt_cl
						.select_load_details_for_batching(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), job_number);

				// JSONObject jsonobj = new JSONObject(web_service_response);
				// web_service_response = (String)jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			
			if (request_type.equals("select_lc_mother_file_update_final_register")) {
				String case_number = request.getParameter("case_number");
				// System.out.println(case_number);
				web_service_response = casemgt_cl
						.select_lc_mother_file_update_final_register(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), case_number);

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("search_for_case_details")) {
				String case_number = request.getParameter("case_number");
				// System.out.println(case_number);
				// //web_service_response
				// =casemgt_cl.select_load_records_for_file_movement(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),case_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("select_user_account_all_for_batching")) {
				// String case_number = request.getParameter("case_number");
				// System.out.println(case_number);
				// //web_service_response
				// =casemgt_cl.select_user_account_all_for_batching();
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("load_responded_queried_applications_at_unit")) {
				String inbox_type = request.getParameter("inbox_type");
				// System.out.println("test: " + inbox_type);
				/*
				 * String[] parts = inbox_type.split("_"); inbox_type =
				 * parts[0]; // 004 String is_csau = parts[1];
				 */

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("regional_code", (String) session.getAttribute("regional_code"));
				/*
				 * json_data.put("inbox_type", inbox_type);
				 * json_data.put("is_csau", is_csau);
				 */
				/*
				 * json_data.put("division", (String)
				 * session.getAttribute("division"));
				 */
				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl.load_responded_queried_applications_at_unit(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("load_incoming_app_for_unit_using_adv_filter")) {
				String inbox_type = request.getParameter("inbox_type");
				// System.out.println("test: " + inbox_type);
				String view_all_offices = (String) session.getAttribute("view_all_offices");
				String[] parts = inbox_type.split("_");
				inbox_type = parts[0]; // 004
				String is_csau = parts[1];

				String adv_filter = request.getParameter("adv_filter");
				String adv_job_number = request.getParameter("adv_job_number");
				String adv_application_type = request.getParameter("adv_application_type");
				String adv_from_date = request.getParameter("adv_from_date");
				String adv_to_date = request.getParameter("adv_to_date");
				String adv_limit = request.getParameter("adv_limit");
				String enq_search_type = request.getParameter("enq_search_type");
				String adv_job_purpose = request.getParameter("adv_job_purpose");
				String adv_sorting = request.getParameter("adv_sorting");
				String adv_search_type = request.getParameter("adv_search_type");

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("regional_code", (String) session.getAttribute("regional_code"));
				json_data.put("inbox_type", inbox_type);
				json_data.put("is_csau", is_csau);
				json_data.put("view_all_offices", view_all_offices);
				json_data.put("division", (String) session.getAttribute("division"));
				json_data.put("adv_filter", adv_filter);
				json_data.put("adv_job_number", adv_job_number);
				json_data.put("adv_application_type", adv_application_type);
				json_data.put("adv_from_date", adv_from_date);
				json_data.put("adv_to_date", adv_to_date);
				json_data.put("adv_limit", adv_limit);
				json_data.put("enq_search_type", enq_search_type);
				json_data.put("adv_job_purpose", adv_job_purpose);
				json_data.put("adv_sorting", adv_sorting);
				json_data.put("adv_search_type", adv_search_type);

				System.out.println(json_data.toString());
				
				web_service_response = casemgt_cl.load_incoming_app_for_unit_using_adv_filter(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_applications_at_unit_by_inbox_type")) {
				String inbox_type = request.getParameter("inbox_type");
				// System.out.println("test: " + inbox_type);
				String view_all_offices = (String) session.getAttribute("view_all_offices");
				String[] parts = inbox_type.split("_");
				inbox_type = parts[0]; // 004
				String is_csau = parts[1];

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("regional_code", (String) session.getAttribute("regional_code"));
				json_data.put("inbox_type", inbox_type);
				json_data.put("is_csau", is_csau);
				json_data.put("view_all_offices", view_all_offices);
				json_data.put("division", (String) session.getAttribute("division"));

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl.load_applications_at_unit_by_inbox_type(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_certificate_signing_applications_at_unit_by_inbox_type")) {
				String inbox_type = request.getParameter("inbox_type");
				// System.out.println("test: " + inbox_type);
				String view_all_offices = (String) session.getAttribute("view_all_offices");
				String[] parts = inbox_type.split("_");
				inbox_type = parts[0]; // 004
				String is_csau = parts[1];

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("regional_code", (String) session.getAttribute("regional_code"));
				json_data.put("inbox_type", inbox_type);
				json_data.put("is_csau", is_csau);
				json_data.put("view_all_offices", view_all_offices);
				json_data.put("division", (String) session.getAttribute("division"));

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl.load_certificate_signing_applications_at_unit_by_inbox_type(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			

			if (request_type.equals("load_app_request_at_unit_by_inbox_type")) {
				String inbox_type = request.getParameter("inbox_type");
				// System.out.println("test: " + inbox_type);
				String view_all_offices = (String) session.getAttribute("view_all_offices");
				String[] parts = inbox_type.split("_");
				inbox_type = parts[0]; // 004
				String is_csau = parts[1];

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("regional_code", (String) session.getAttribute("regional_code"));
				json_data.put("inbox_type", inbox_type);
				json_data.put("is_csau", is_csau);
				json_data.put("view_all_offices", view_all_offices);
				json_data.put("division", (String) session.getAttribute("division"));

				System.out.println(json_data.toString());
				web_service_response = casemgt_cl.load_app_request_at_unit_by_inbox_type(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_sub_process_application_type_for_adv_filter")) {

				JSONObject json_data = new JSONObject();
				String inbox_type = request.getParameter("inbox_type");
				String[] parts = inbox_type.split("_");
				inbox_type = parts[0]; // 004
				String is_csau = parts[1];

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("inbox_type", inbox_type);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl.load_sub_process_application_type_for_adv_filter(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("load_applications_at_unit_by_inbox_type_frrv_coordinator")) {
				String inbox_type = request.getParameter("inbox_type");

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("division", (String) session.getAttribute("division"));
				json_data.put("inbox_type", inbox_type);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl
						.load_applications_at_unit_by_inbox_type_frrv_coordinator(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_applications_at_unit_by_inbox_type_tpp_coordinator")) {
				String inbox_type = request.getParameter("inbox_type");

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("division", (String) session.getAttribute("division"));
				json_data.put("inbox_type", inbox_type);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl
						.load_applications_at_unit_by_inbox_type_tpp_coordinator(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_applications_at_unit_by_inbox_type_tpp")) {
				String inbox_type = request.getParameter("inbox_type");

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("division", (String) session.getAttribute("division"));
				json_data.put("inbox_type", inbox_type);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl.load_applications_at_unit_by_inbox_type_tpp(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_applications_at_unit_by_inbox_type_frrv")) {
				String inbox_type = request.getParameter("inbox_type");

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("division", (String) session.getAttribute("division"));
				json_data.put("inbox_type", inbox_type);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl.load_applications_at_unit_by_inbox_type_frrv(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_application_batched_to_user")) {
				String job_recieved_by_id = request.getParameter("job_recieved_by_id");
				// System.out.println(job_recieved_by_id);
				// //web_service_response=casemgt_cl.load_application_batched_to_user(job_recieved_by_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_file_list")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");
				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);

				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println(obj.toString());
				web_service_response = casemgt_cl.process_file_list(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_file_movement_list")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");
				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);

				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println(obj.toString());
				web_service_response = casemgt_cl.process_file_movement_list(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_request_list")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");
				String division = (String) session.getAttribute("division");
				String batch_type = request.getParameter("batch_type");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("division", division);
				obj.put("batch_type", batch_type);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				System.out.println(obj.toString());

				web_service_response = casemgt_cl.process_request_list(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_request_list_to_user")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");
				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				System.out.println(obj.toString());
				web_service_response = casemgt_cl.process_request_list_to_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			

			if (request_type.equals("process_request_list_to_archive")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				// String send_to_id = request.getParameter("send_to_id");
				// String send_to_name = request.getParameter("send_to_name");
				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				// obj.put("send_to_id", send_to_id);
				// obj.put("send_to_name", send_to_name);
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println(obj.toString());
				web_service_response = casemgt_cl.process_request_list_to_archive(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("select_check_wkt_polygon_by_job_number")) {

				String job_number = request.getParameter("job_number");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("job_number", job_number);

				//System.out.print(obj.toString());

				web_service_response = casemgt_cl.select_check_wkt_polygon_by_job_number(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			

			if (request_type.equals("select_review_baby_steps_check_for_completion")) {

				String job_number = request.getParameter("job_number");
				String bs_id = request.getParameter("bs_id");
				String bse_id = request.getParameter("bse_id");
				String approve_comment = request.getParameter("approve_comment");
				String fullname = (String) session.getAttribute("fullname");
				String userid = (String) session.getAttribute("userid");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("job_number", job_number);
				obj.put("bs_id", bs_id);
				obj.put("bse_id", bse_id);
				obj.put("approve_comment", approve_comment);
				obj.put("fullname", fullname);
				obj.put("userid", userid);

				System.out.print(obj.toString());

				web_service_response = casemgt_cl.select_review_baby_steps_check_for_completion(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			

			if (request_type.equals("select_load_step_approved_comment")) {

				String job_number = request.getParameter("job_number");
				String bs_id = request.getParameter("bs_id");
				//String approve_comment = request.getParameter("approve_comment");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("job_number", job_number);
				obj.put("bs_id", bs_id);
				//obj.put("approve_comment", approve_comment);

				System.out.print(obj.toString());

				web_service_response = casemgt_cl.select_load_step_approved_comment(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_check_application_details_for_request")) {

				String job_number = request.getParameter("job_number");
				String transaction_number = request.getParameter("transaction_number");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("job_number", job_number);
				obj.put("transaction_number", transaction_number);

				//System.out.print(obj.toString());

				web_service_response = casemgt_cl.select_check_application_details_for_request(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_cabinet")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String division = (String) session.getAttribute("division");

				// String send_to_id = request.getParameter("send_to_id");
				String cabinet_name = request.getParameter("cabinet_name");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				// obj.put("send_to_id", send_to_id);
				obj.put("cabinet_name", cabinet_name);
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();
				// System.out.println(batchlistdivison);
				web_service_response = casemgt_cl
						.select_process_batch_list_cabinet(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_issue_collection")) {
				String list_of_application = request.getParameter("list_of_application");
				String bcd_collected_by = request.getParameter("bcd_collected_by");
				String bcd_id_type = request.getParameter("bcd_id_type");
				String bcd_id_number = request.getParameter("bcd_id_number");
				String bcd_phone_number = request.getParameter("bcd_phone_number");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String division = (String) session.getAttribute("division");

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("division", division);

				obj.put("bcd_collected_by", bcd_collected_by);
				obj.put("bcd_id_type", bcd_id_type);
				obj.put("bcd_id_number", bcd_id_number);
				obj.put("bcd_phone_number", bcd_phone_number);

				obj.put("list_of_application", list_of_application);

				String batchlistdivison = obj.toString();
				System.out.println(batchlistdivison);
				web_service_response = casemgt_cl
						.select_process_batch_list_issue_collected(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("process_batch_list_issue_for_payment_collection")) {
				String list_of_application = request.getParameter("list_of_application");
				String bcd_collected_by = request.getParameter("bcd_collected_by");
				String bcd_id_type = request.getParameter("bcd_id_type");
				String bcd_id_number = request.getParameter("bcd_id_number");
				String bcd_phone_number = request.getParameter("bcd_phone_number");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String division = (String) session.getAttribute("division");

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("division", division);

				obj.put("bcd_collected_by", bcd_collected_by);
				obj.put("bcd_id_type", bcd_id_type);
				obj.put("bcd_id_number", bcd_id_number);
				obj.put("bcd_phone_number", bcd_phone_number);

				obj.put("list_of_application", list_of_application);

				String batchlistdivison = obj.toString();
				System.out.println(batchlistdivison);
				web_service_response = casemgt_cl
						.select_process_batch_list_issue_for_payment_collected(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_new")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				String is_map_plotting = request.getParameter("is_map_plotting");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				obj.put("is_map_plotting", is_map_plotting);

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.select_process_batch_list_new(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("update_job_step_status_bulk")) {
				String list_of_application = request.getParameter("list_of_application");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("list_of_application", list_of_application);

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.update_job_step_status_bulk(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("update_job_step_status_bulk_frrv_cst")) {
				String list_of_application = request.getParameter("list_of_application");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("list_of_application", list_of_application);

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.update_job_step_status_bulk_frrv_cst(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_frrv")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.process_batch_list_frrv(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("process_send_job_number_to_ffrv")) {
				String job_number = request.getParameter("job_number");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("job_number", job_number);

				// String batchlistdivison = obj.toString();

				System.out.println("testing cabinet batch: " + obj.toString());

				web_service_response = casemgt_cl.process_send_job_number_to_ffrv(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			

			if (request_type.equals("select_frrv_details_on_job_number")) {
				String job_number = request.getParameter("job_number");

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);

				// String batchlistdivison = obj.toString();

				System.out.println("testing cabinet batch: " +
				obj.toString());
				web_service_response = casemgt_cl.select_frrv_details_on_job_number(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_tpp")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.process_batch_list_tpp(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_frrv_supervisor")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				System.out.println("testing cabinet batch: " + obj.toString());
				web_service_response = casemgt_cl
						.process_batch_list_frrv_supervisor(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("process_batch_list_frrv_supervisor_to_cordinator")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.process_batch_list_frrv_supervisor_to_cordinator(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_tpp_supervisor")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl
						.process_batch_list_tpp_supervisor(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("process_batch_list_tpp_supervisor_to_cordinator")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.process_batch_list_tpp_supervisor_to_cordinator(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_unit")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println(batchlistdivison);
				web_service_response = casemgt_cl
						.select_process_batch_list_unit(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("process_batch_list_unit_crb")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");
				String region_id = request.getParameter("region_id");
				String region_name = request.getParameter("region_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);
				obj.put("region_id", region_id);
				obj.put("region_name", region_name);

				String batchlistdivison = obj.toString();

				System.out.println(batchlistdivison);
				web_service_response = casemgt_cl
						.select_process_batch_list_unit_crb(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_for_certificate_signing")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				System.out.println(obj.toString());
				web_service_response = casemgt_cl
						.select_process_batch_list_for_certificate_signing(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_user_account_all_by_unit_for_combo")) {
				String division = (String) session.getAttribute("division");
				String department = request.getParameter("department");

				// System.out.println(division);
				// web_service_response
				// =casemgt_cl.select_user_account_all_by_unit_for_combo(division,department);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_user_account_all_by_unit_head_for_combo")) {
				String division = (String) session.getAttribute("division");
				String department = request.getParameter("department");

				// System.out.println(division);
				// System.out.println(department);
				// web_service_response
				// =casemgt_cl.select_user_account_all_by_unit_head_for_combo(division,department);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_user_account_all_by_unit_head_all_for_combo")) {
				String division = (String) session.getAttribute("division");
				// System.out.println(division);
				// web_service_response
				// =casemgt_cl.select_user_account_all_by_unit_head_all_for_combo(division);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("select_lc_application_mile_stone_each_sub_all_by_job")) {
				String job_number = request.getParameter("job_number");
				String userid = (String) session.getAttribute("userid");
				// System.out.println(job_number);
				// web_service_response
				// =casemgt_cl.select_lc_application_mile_stone_each_sub_all_by_job(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),job_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("select_lc_application_mile_stone_each_sub_activated_for_user")) {
				String job_number = request.getParameter("job_number");
				String userid = (String) session.getAttribute("userid");
				// System.out.println(job_number);
				// web_service_response
				// =casemgt_cl.select_lc_application_mile_stone_each_sub_activated_for_user(job_number,userid);
				if (web_service_response != null) {
					/// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("select_lc_application_mile_stone_each_all_by_job")) {
				String job_number = request.getParameter("job_number");
				String userid = (String) session.getAttribute("userid");
				// System.out.println(job_number);
				// web_service_response
				// =casemgt_cl.select_lc_application_mile_stone_each_all_by_job(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),job_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("select_lc_application_mile_stone_each_activated_for_user")) {
				String job_number = request.getParameter("job_number");
				String userid = (String) session.getAttribute("userid");
				// System.out.println(job_number);
				// web_service_response
				// =casemgt_cl.select_lc_application_mile_stone_each_activated_for_user(job_number,userid);
				if (web_service_response != null) {
					/// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("select_lc_application_mile_stone_each_sub_all_by_job_level")) {
				String job_number = request.getParameter("job_number");
				String p_main_fk = request.getParameter("p_main_fk");
				int id_p_main_fk = Integer.parseInt(p_main_fk);
				// System.out.println(job_number);
				// web_service_response
				// =casemgt_cl.select_lc_application_mile_stone_each_sub_all_by_job_level(job_number,id_p_main_fk);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("update_for_case_details")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String case_number = request.getParameter("case_number");

				String ar_name = request.getParameter("ar_name");
				String ar_address = request.getParameter("ar_address");
				String glpin = request.getParameter("glpin");
				String licensed_surveyor_number = request.getParameter("licensed_surveyor_number");
				String regional_number = request.getParameter("regional_number");
				String locality = request.getParameter("locality");
				String district = request.getParameter("district");
				String region = request.getParameter("region");
				String size_of_land = request.getParameter("size_of_land");
				String date_of_document = request.getParameter("date_of_document");
				String nature_of_instrument = request.getParameter("nature_of_instrument");
				String certificate_number = request.getParameter("certificate_number");
				String extent = request.getParameter("extent");
				String registry_mapref = request.getParameter("registry_mapref");
				String type_of_interest = request.getParameter("type_of_interest");
				String type_of_use = request.getParameter("type_of_use");
				String volume_number = request.getParameter("volume_number");
				String folio_number = request.getParameter("folio_number");
				String term = request.getParameter("term");
				String commencement_date = request.getParameter("commencement_date");
				String renewal_term = request.getParameter("renewal_term");
				String consideration_fee = request.getParameter("consideration_fee");
				String stamp_duty_payable = request.getParameter("stamp_duty_payable");
				String assessed_value = request.getParameter("assessed_value");
				String parcel_description = request.getParameter("parcel_description");
				String plot_number = request.getParameter("plot_number");
				String publicity_date = request.getParameter("publicity_date");
				String plan_no = request.getParameter("plan_no");
				String cc_no = request.getParameter("cc_no");
				String ltr_plan_no = request.getParameter("ltr_plan_no");
				String family_of_grantor = request.getParameter("family_of_grantor");
				String locality_class = request.getParameter("locality_class");
				String rent_review_period = request.getParameter("rent_review_period");
				String annual_rent = request.getParameter("annual_rent");
				String rent_period_covered = request.getParameter("rent_period_covered");
				String rent_review_date = request.getParameter("rent_review_date");
				String date_of_first_payment = request.getParameter("date_of_first_payment");
				String outstanding_rent = request.getParameter("outstanding_rent");
				String date_of_registration = request.getParameter("date_of_registration");
				String case_status = request.getParameter("case_status");
				String grantors_name = request.getParameter("grantors_name");
				String grantors_address = request.getParameter("grantors_address");
				String stool_family_name = request.getParameter("stool_family_name");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

				String registration_district_number = request.getParameter("registration_district_number");
				String registration_section_number = request.getParameter("registration_section_number");
				String registration_block_number = request.getParameter("registration_block_number");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				
				obj.put("case_number", case_number);
				obj.put("ar_name", ar_name);
				obj.put("ar_address", ar_address);
				obj.put("glpin", glpin);
				obj.put("licensed_surveyor_number", licensed_surveyor_number);

				obj.put("regional_number", regional_number);
				obj.put("locality", locality);
				obj.put("district", district);
				obj.put("region", region);
				obj.put("size_of_land", size_of_land);
				obj.put("date_of_document", date_of_document);
				obj.put("nature_of_instrument", nature_of_instrument);
				obj.put("certificate_number", certificate_number);
				obj.put("extent", extent);
				obj.put("registry_mapref", registry_mapref);
				obj.put("type_of_interest", type_of_interest);
				obj.put("type_of_use", type_of_use);
				obj.put("volume_number", volume_number);
				obj.put("folio_number", folio_number);
				obj.put("term", term);
				obj.put("commencement_date", commencement_date);
				obj.put("renewal_term", renewal_term);
				obj.put("consideration_fee", consideration_fee);
				obj.put("stamp_duty_payable", stamp_duty_payable);
				obj.put("assessed_value", assessed_value);
				obj.put("parcel_description", parcel_description);
				obj.put("plot_number", plot_number);
				obj.put("publicity_date", publicity_date);
				obj.put("plan_no", plan_no);
				obj.put("cc_no", cc_no);
				obj.put("ltr_plan_no", ltr_plan_no);
				obj.put("family_of_grantor", family_of_grantor);
				obj.put("locality_class", locality_class);
				obj.put("rent_review_period", rent_review_period);
				obj.put("annual_rent", annual_rent);
				obj.put("rent_period_covered", rent_period_covered);
				obj.put("rent_review_date", rent_review_date);
				obj.put("date_of_first_payment", date_of_first_payment);
				obj.put("outstanding_rent", outstanding_rent);
				obj.put("date_of_registration", date_of_registration);
				obj.put("case_status", case_status);
				obj.put("grantors_name", grantors_name);
				obj.put("grantors_address", grantors_address);
				obj.put("stool_family_name", stool_family_name);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

				obj.put("registration_district_number", registration_district_number);
				obj.put("registration_section_number", registration_section_number);
				obj.put("registration_block_number", registration_block_number);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				// web_service_response
				// =casemgt_cl.select_process_case_update(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("select_on_lc_inspection_reports")) {
				String polygon = request.getParameter("json_data");

				JSONObject property_data_json = new JSONObject();

				property_data_json.put("job_number", polygon);

				// System.out.println(property_data_json.toString());
				web_service_response = casemgt_cl.select_on_lc_inspection_reports(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						property_data_json.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("insert_update_on_lc_inspection_reports")) {

				JSONObject json_data = new JSONObject();

				json_data.put("job_number", request.getParameter("job_number"));
				json_data.put("case_number", request.getParameter("case_number"));
				json_data.put("requested_by", request.getParameter("requested_by"));
				json_data.put("requested_by_id", request.getParameter("requested_by_id"));
				json_data.put("inspection_date", request.getParameter("inspection_date"));
				json_data.put("inspection_purpose", request.getParameter("inspection_purpose"));
				json_data.put("development_level", request.getParameter("development_level"));
				json_data.put("possession_person", request.getParameter("possession_person"));
				json_data.put("neighbor_names", request.getParameter("neighbor_names"));
				json_data.put("ground_opinion", request.getParameter("ground_opinion"));
				json_data.put("neighborhood_description", request.getParameter("neighborhood_description"));
				json_data.put("created_by", (String) session.getAttribute("fullname"));
				json_data.put("created_by_id", (String) session.getAttribute("userid"));

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl.insert_update_on_lc_inspection_reports(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					// System.out.println("somthing");
				} else {
					System.out.println(web_service_response);
					// System.out.println("somthing else");
				}

				return web_service_response;
			}

			if (request_type.equals("update_stamp_duty_records")) {

				JSONObject json_data = new JSONObject();

				// JSONObject json_data_srs = new JSONObject();

				String assessed_value = request.getParameter("assessed_value");
				String stamp_duty = request.getParameter("stamp_duty");

				assessed_value = assessed_value.replace(",", "");
				stamp_duty = stamp_duty.replace(",", "");

				json_data.put("case_number", request.getParameter("case_number"));
				json_data.put("job_number", request.getParameter("job_number"));
				json_data.put("assessed_value", assessed_value);
				json_data.put("stamp_duty", stamp_duty);
				json_data.put("assessed_comment", request.getParameter("assessed_comment"));
				json_data.put("considertion_fee_adopted_rate", request.getParameter("considertion_fee_adopted_rate"));
				json_data.put("created_by", (String) session.getAttribute("fullname"));
				json_data.put("created_by_id", (String) session.getAttribute("userid"));
				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));

				System.out.println(json_data.toString());
				web_service_response = casemgt_cl.update_stamp_duty_records(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());

				if (web_service_response != null) {
					String srs_web_service_response = casemgt_cl
							.srs_assessment_complete(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), web_service_response);

					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("update_stamp_duty_records_embossment")) {

				JSONObject json_data = new JSONObject();

				json_data.put("job_number", request.getParameter("job_number"));

				json_data.put("created_by", (String) session.getAttribute("fullname"));
				json_data.put("created_by_id", (String) session.getAttribute("userid"));

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl.update_stamp_duty_records_embossment(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("assign_inspection_case_to_officer")) {

				String case_number = request.getParameter("case_number");
				String job_number = request.getParameter("job_number");
				String purpose_of_inspection = request.getParameter("purpose_of_inspection");
				String assigned_to = request.getParameter("assigned_to");
				String assigned_to_id = request.getParameter("assigned_to_id");
				String assigned_by = (String) session.getAttribute("fullname");
				String assigned_by_id = (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();

				obj.put("assigned_by", assigned_by);
				obj.put("assigned_by_id", assigned_by_id);
				obj.put("purpose_of_inspection", purpose_of_inspection);
				obj.put("assigned_to_id", assigned_to_id);
				obj.put("assigned_to", assigned_to);
				obj.put("job_number", job_number);
				obj.put("case_number", case_number);

				System.out.println(obj.toString());

				web_service_response = casemgt_cl
						.assign_inspection_case_to_officer(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				JSONObject jsonobj = new JSONObject(web_service_response);
				web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println("out " + web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_application_cabinet_details_by_job_number")) {
				String job_number = request.getParameter("job_number");
				// System.out.println("test job: " + job_number);
				web_service_response = casemgt_cl.load_application_cabinet_details_by_job_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						job_number);

				JSONObject jsonobj = new JSONObject(web_service_response);
				// web_service_response = (String) jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println("out " + web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			/*
			 * if
			 * (request_type.equals("load_application_details_for_enquiries")) {
			 * String job_number = request.getParameter("job_number");
			 * System.out.println(job_number); web_service_response =
			 * casemgt_cl.load_application_details_for_enquiries(cls_url_config.
			 * getWeb_service_url_ser(),job_number);
			 * 
			 * JSONObject jsonobj = new JSONObject(web_service_response);
			 * web_service_response = (String) jsonobj.getString("data");
			 * 
			 * if (web_service_response != null) { //
			 * System.out.println(web_service_response); } else {
			 * System.out.println(web_service_response); } PrintWriter out =
			 * response.getWriter(); return web_service_response; }
			 */

			if (request_type.equals("select_send_email")) {

				String send_to = request.getParameter("send_to");
				String publication_list = request.getParameter("publication_list");
				String message_body = "";
				String subject = request.getParameter("subject");

				JSONArray jsonobj = (JSONArray) new JSONArray(publication_list);

				// division = (String) jsonobj.getString("division");
				for (int i = 0; i < jsonobj.length(); i++) {
					// Make the body text
					message_body += " <br><hr><p><h1>" + (i + 1) + "</h1><ul>" + "<li> location: "
							+ jsonobj.getJSONObject(i).getString("location") + "</li>" + "<li> Lessee's Name: "
							+ jsonobj.getJSONObject(i).getString("ar_name") + "</li>" + "<li> Grantor: "
							+ jsonobj.getJSONObject(i).getString("grantor") + "</li>" + "<li> Description: "
							+ jsonobj.getJSONObject(i).getString("description") + "</li>" + "<li> Extent: "
							+ jsonobj.getJSONObject(i).getString("extent") + "</li>" + "<li> Type of Interest: "
							+ jsonobj.getJSONObject(i).getString("interest") + "</li>" + "<li> Registry Map Ref: "
							+ jsonobj.getJSONObject(i).getString("registry_map") + "</li>" + "<li> Lodgement Number: "
							+ jsonobj.getJSONObject(i).getString("client_number") + "</li>" + " </ul></p><br>";
				}

				// System.out.println("Body: " + message_body);

				/*
				 * JSONObject obj = new JSONObject();
				 * 
				 * obj.put("subject", subject); obj.put("message_body",
				 * message_body); obj.put("send_to", send_to);
				 * 
				 * System.out.println(obj.toString()); web_service_response =
				 * casemgt_cl_m.select_send_email(cls_url_config.getWeb_service_url_ser(),
				 * cls_url_config.getWeb_service_url_ser_api_key(),obj.
				 * toString());
				 */

				// //HttpSession session = request.getSession();

				/*
				 * 
				 * System.out.println("SimpleEmail Start");
				 * 
				 * String smtpHostServer = "mail.orangable.com";
				 * 
				 * Properties props = System.getProperties();
				 * 
				 * props.put("mail.smtp.host", smtpHostServer);
				 * 
				 * Session session1 = Session.getInstance(props, null);
				 * 
				 * web_service_response = EmailUtil.sendEmail(session1, send_to,
				 * subject, message_body);
				 * 
				 * if (web_service_response != null) {
				 * System.out.println(web_service_response); } else {
				 * System.out.println(web_service_response); } PrintWriter out =
				 * response.getWriter(); return web_service_response;
				 */
			}

			/*
			 * if (request_type.equals(
			 * "load_application_cabinet_details_by_job_number")) { String
			 * job_number = request.getParameter("job_number");
			 * System.out.println("test job: " + job_number);
			 * web_service_response =
			 * casemgt_cl.load_application_cabinet_details_by_job_number(
			 * job_number);
			 * 
			 * // JSONObject jsonobj = new // JSONObject(web_service_response);
			 * // web_service_response = (String) // jsonobj.getString("data");
			 * 
			 * if (web_service_response != null) { System.out.println("out " +
			 * web_service_response); } else {
			 * System.out.println(web_service_response); } PrintWriter out =
			 * response.getWriter(); out.println(jsonobj.toString()); }
			 */

			if (request_type.equals("load_application_collection_details_by_job_number")) {
				String job_number = request.getParameter("job_number");
				// System.out.println("test job: " + job_number);
				web_service_response = casemgt_cl.load_application_collection_details_by_job_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						job_number);

				// JSONObject jsonobj = new
				// JSONObject(web_service_response);
				// web_service_response = (String)
				// jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println("out " + web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("load_save_collection_details_by_job_number")) {
				String job_number = request.getParameter("job_number");
				String collected_by_id_type = request.getParameter("collected_by_id_type");
				String collected_by = request.getParameter("collected_by");
				String collected_by_id_number = request.getParameter("collected_by_id_number");
				String collected_by_phone_number = request.getParameter("collected_by_phone_number");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");


				JSONObject obj = new JSONObject();

				obj.put("collected_by_id_type", collected_by_id_type);
				obj.put("collected_by", collected_by);
				obj.put("collected_by_id_number", collected_by_id_number);
				obj.put("collected_by_phone_number", collected_by_phone_number);
				obj.put("modified_by", modified_by);
				obj.put("job_number", job_number);
				obj.put("modified_by_id", modified_by_id);
				obj.put("collection_issued_by_id", modified_by_id);

				 System.out.println(obj.toString());

				web_service_response = casemgt_cl.load_save_collection_details_by_job_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				// JSONObject jsonobj = new
				// JSONObject(web_service_response);
				// web_service_response = (String)
				// jsonobj.getString("data");

				if (web_service_response != null) {
					// System.out.println("out " + web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			

			if (request_type.equals("select_archive_application_request")) {
				String job_number = request.getParameter("job_number");
				String rq_id = request.getParameter("rq_id");
				String note = request.getParameter("note");
				// String collected_by_id_number = request.getParameter("collected_by_id_number");
				// String collected_by_phone_number = request.getParameter("collected_by_phone_number");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");


				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("rq_id", rq_id);
				obj.put("note", note);
				obj.put("modified_by_id", modified_by_id);
				obj.put("modified_by", modified_by);

				System.out.println(obj.toString());

				web_service_response = casemgt_cl.select_archive_application_request(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());


				if (web_service_response != null) {
					// System.out.println("out " + web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("select_load_published_but_not_worked_on")) {

				web_service_response = casemgt_cl_m
						.select_load_published_but_not_worked_on(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("select_load_published_but_not_worked_on")) {

				web_service_response = casemgt_cl_m
						.select_load_published_but_not_worked_on(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("update_user_profile")) {
				String userid = (String) session.getAttribute("userid");

				String phone = request.getParameter("phone");
				String phone2 = request.getParameter("phone2");
				String password = request.getParameter("password");

				JSONObject obj = new JSONObject();

				obj.put("phone", phone);
				obj.put("phone2", phone2);
				obj.put("password", password);
				obj.put("userid", userid);

				web_service_response = casemgt_cl.update_user_profile(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				System.out.println(obj.toString());

				// JSONObject jsonobj = new JSONObject(web_service_response);
				// web_service_response = (String) jsonobj.getString("data");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_link_account_to_jobs")) {
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String client_name = request.getParameter("client_name");
				String job_number = request.getParameter("job_number");
				String created_for_id = request.getParameter("created_for_id");

				JSONObject obj = new JSONObject();

				obj.put("client_name", client_name);
				obj.put("job_number", job_number);
				obj.put("created_for_id", created_for_id);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				web_service_response = casemgt_cl.online_link_account_to_jobs(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				System.out.println(obj.toString());

				// JSONObject jsonobj = new JSONObject(web_service_response);
				// web_service_response = (String) jsonobj.getString("data");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_link_account_to_jobs")) {
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String new_transaction_number = request.getParameter("new_transaction_number");
				String new_job_number = request.getParameter("new_job_number");
				String old_transaction_number = request.getParameter("old_transaction_number");

				JSONObject obj = new JSONObject();

				obj.put("new_transaction_number", new_transaction_number);
				obj.put("new_job_number", new_job_number);
				obj.put("old_transaction_number", old_transaction_number);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				web_service_response = casemgt_cl
						.online_link_transaction_to_jobs(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(obj.toString());

				// JSONObject jsonobj = new JSONObject(web_service_response);
				// web_service_response = (String) jsonobj.getString("data");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("lc_comment_on_job")) {
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String comment = request.getParameter("comment");
				String job_number = request.getParameter("job_number");

				JSONObject obj = new JSONObject();

				obj.put("comment", comment);
				obj.put("job_number", job_number);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				web_service_response = casemgt_cl.lc_comment_on_job(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				System.out.println(obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("lc_case_letters_add_update")) {
				String id = (String) request.getParameter("id");
				String job_number = (String) request.getParameter("job_number");
				String case_number = (String) request.getParameter("case_number");
				String letter_type = (String) request.getParameter("letter_type");
				String letter_template = (String) request.getParameter("letter_template");
				String letter_cc = (String) request.getParameter("letter_cc");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				JSONObject obj = new JSONObject();

				obj.put("id", id);
				obj.put("job_number", job_number);
				obj.put("case_number", case_number);
				obj.put("letter_type", letter_type);
				obj.put("letter_cc", letter_cc);
				obj.put("letter_template", letter_template);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				// System.out.println(obj.toString());
				web_service_response = casemgt_cl.lc_case_letters_add_update(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_copy_mother_file_transaction_to_child")) {

				String mc_job_number = (String) request.getParameter("mc_job_number");
				String job_number = (String) request.getParameter("job_number");
				String case_number = (String) request.getParameter("case_number");
				String transaction_number = (String) request.getParameter("transaction_number");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String type_of_value = (String) request.getParameter("type_of_value");

				JSONObject obj = new JSONObject();

				obj.put("mc_job_number", mc_job_number);
				obj.put("job_number", job_number);
				obj.put("case_number", case_number);
				obj.put("transaction_number", transaction_number);

				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				obj.put("type_of_value", type_of_value);

				web_service_response = casemgt_cl.select_copy_mother_file_transaction_to_child(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				System.out.println(obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("lc_certificate_search_relation_details_add_update")) {

				String mc_job_number = (String) request.getParameter("mc_job_number");
				String job_number = (String) request.getParameter("job_number");
				String case_number = (String) request.getParameter("case_number");
				String mc_certificate_number = (String) request.getParameter("mc_certificate_number");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				JSONObject obj = new JSONObject();

				obj.put("mc_job_number", mc_job_number);
				obj.put("job_number", job_number);
				obj.put("case_number", case_number);
				obj.put("mc_certificate_number", mc_certificate_number);

				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				System.out.println(obj.toString());

				web_service_response = casemgt_cl.lc_certificate_search_relation_details_add_update(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				System.out.println(obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_transaction_approvals_create")) {

				String transaction_id = (String) request.getParameter("transaction_id");
				String nature_of_instrument = (String) request.getParameter("nature_of_instrument");
				String case_number = (String) request.getParameter("case_number");
				String job_number = (String) request.getParameter("job_number");
				String proprietor = (String) request.getParameter("proprietor");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				JSONObject obj = new JSONObject();

				obj.put("transaction_id", transaction_id);
				obj.put("nature_of_instrument", nature_of_instrument);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("proprietor", proprietor);

				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				web_service_response = casemgt_cl.online_select_transaction_approvals_create(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				System.out.println(obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("transaction_approvals_certificate_create")) {

				String transaction_id = (String) request.getParameter("transaction_id");
				String certificate_number = (String) request.getParameter("certificate_number");
				String case_number = (String) request.getParameter("case_number");
				String job_number = (String) request.getParameter("job_number");
				String proprietor = (String) request.getParameter("proprietor");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				JSONObject obj = new JSONObject();

				obj.put("transaction_id", transaction_id);
				obj.put("certificate_number", certificate_number);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("proprietor", proprietor);

				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				web_service_response = casemgt_cl.select_transaction_approvals_certificate_create(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				System.out.println(obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_transaction_approvals_final_approval")) {

				String mc_job_number = (String) request.getParameter("mc_job_number");
				String job_number = (String) request.getParameter("job_number");
				String case_number = (String) request.getParameter("case_number");
				String transaction_number = (String) request.getParameter("transaction_number");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				JSONObject obj = new JSONObject();

				obj.put("mc_job_number", mc_job_number);
				obj.put("job_number", job_number);
				obj.put("case_number", case_number);
				obj.put("transaction_number", transaction_number);

				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				web_service_response = casemgt_cl.online_select_transaction_approvals_final_approval(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				System.out.println(obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_transaction_approvals_by_user")) {

				String mc_job_number = (String) request.getParameter("mc_job_number");
				String job_number = (String) request.getParameter("job_number");
				String case_number = (String) request.getParameter("case_number");
				String transaction_number = (String) request.getParameter("transaction_number");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				JSONObject obj = new JSONObject();

				obj.put("mc_job_number", mc_job_number);
				obj.put("job_number", job_number);
				obj.put("case_number", case_number);
				obj.put("transaction_number", transaction_number);

				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				web_service_response = casemgt_cl
						.select_transaction_approvals_by_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				System.out.println(obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_general_case_details")) {

				String job_number = (String) request.getParameter("job_number");
				String case_number = (String) request.getParameter("case_number");
				String transaction_number = (String) request.getParameter("transaction_number");
				// String userid = (String) session.getAttribute("userid");
				// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("case_number", transaction_number);
				obj.put("transaction_number", case_number);

				web_service_response = casemgt_cl_m.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				System.out.println(obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_new_application_for_division")) {

				String division = (String) session.getAttribute("division");
				String regional_code = (String) session.getAttribute("regional_code");

				web_service_response = casemgt_cl_m.load_new_application_for_division(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						division, regional_code);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("app_update_job_set_uncompleted")) {

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("job_number", job_number);

				// System.out.println(obj.toString());
				web_service_response = casemgt_cl_m
						.app_update_job_set_uncompleted(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			if (request_type.equals("app_update_copy_name_to_job_table")) {

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("job_number", job_number);

				// System.out.println(obj.toString());
				web_service_response = casemgt_cl_m
						.app_update_copy_name_to_job_table(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_update_application_as_work_done_cst")) {
				String job_number = request.getParameter("job_number");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String unit_id = (String) session.getAttribute("unit_id");
				String unit_name = (String) session.getAttribute("unit_name");
				String division = (String) session.getAttribute("division");
				String job_purpose = request.getParameter("job_purpose");

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("unit_id", unit_id);
				obj.put("unit_name", unit_name);
				obj.put("division", division);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("job_purpose", job_purpose);

				web_service_response = casemgt_cl_m.select_update_application_as_work_done_cst(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_update_application_as_work_done_frrv_cst")) {
				String job_number = request.getParameter("job_number");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String unit_id = (String) session.getAttribute("unit_id");
				String unit_name = (String) session.getAttribute("unit_name");
				String division = (String) session.getAttribute("division");
				String job_purpose = request.getParameter("job_purpose");

				JSONObject obj = new JSONObject();

				obj.put("job_number", job_number);
				obj.put("unit_id", unit_id);
				obj.put("unit_name", unit_name);
				obj.put("division", division);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("job_purpose", job_purpose);

				web_service_response = casemgt_cl_m.select_update_application_as_work_done_frrv_cst(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_approve_job_note_cst")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				String job_purpose = request.getParameter("job_purpose");
				JSONObject obj_d = new JSONObject();

				obj_d.put("created_by", fullname);
				obj_d.put("created_by_id", userid);
				obj_d.put("division", division);
				obj_d.put("job_number", job_number);
				obj_d.put("job_purpose", job_purpose);

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m.select_approve_job_note_cst(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_confirm_consolidated_searches_from_division")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				JSONObject obj_d = new JSONObject();

				// obj_d.put("created_by", fullname);
				// obj_d.put("created_by_id", userid);
				// obj_d.put("division", division);
				obj_d.put("job_number", job_number);

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m.select_confirm_consolidated_searches_from_division(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			

			if (request_type.equals("select_verify_ffrv_from_division")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				JSONObject obj_d = new JSONObject();

				// obj_d.put("created_by", fullname);
				// obj_d.put("created_by_id", userid);
				// obj_d.put("division", division);
				obj_d.put("job_number", job_number);

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m.select_verify_ffrv_from_division(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_confirm_ffrv_from_division")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				JSONObject obj_d = new JSONObject();

				// obj_d.put("created_by", fullname);
				// obj_d.put("created_by_id", userid);
				// obj_d.put("division", division);
				obj_d.put("job_number", job_number);

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m.select_confirm_ffrv_from_division(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_confirm_frrv_cst_searches_from_division")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				JSONObject obj_d = new JSONObject();

				// obj_d.put("created_by", fullname);
				// obj_d.put("created_by_id", userid);
				// obj_d.put("division", division);
				obj_d.put("job_number", job_number);

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m.select_confirm_frrv_cst_searches_from_division(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_upddate_cst_searches_as_completed_from_division")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				JSONObject obj_d = new JSONObject();

				obj_d.put("created_by", fullname);
				obj_d.put("created_by_id", userid);
				obj_d.put("division", division);
				obj_d.put("job_number", job_number);

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m.select_upddate_cst_searches_as_completed_from_division(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("select_upddate_frrv_cst_searches_as_completed_from_division")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				JSONObject obj_d = new JSONObject();

				obj_d.put("created_by", fullname);
				obj_d.put("created_by_id", userid);
				obj_d.put("division", division);
				obj_d.put("job_number", job_number);

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m.select_upddate_frrv_cst_searches_as_completed_from_division(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_approve_job_note_frrv_cst")) {

				String division = (String) session.getAttribute("division");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				JSONObject obj_d = new JSONObject();

				obj_d.put("created_by", fullname);
				obj_d.put("created_by_id", userid);
				obj_d.put("division", division);
				obj_d.put("job_number", job_number);

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(obj_d.toString());
				web_service_response = casemgt_cl_m.select_approve_job_note_frrv_cst(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_applications_at_unit_by_inbox_type_cst_coordinator")) {
				String inbox_type = request.getParameter("inbox_type");

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("division", (String) session.getAttribute("division"));
				json_data.put("inbox_type", inbox_type);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl
						.load_applications_at_unit_by_inbox_type_cst_coordinator(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("load_applications_at_unit_by_inbox_type_frrv_cst_coordinator")) {
				String inbox_type = request.getParameter("inbox_type");

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("division", (String) session.getAttribute("division"));
				json_data.put("inbox_type", inbox_type);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl
						.load_applications_at_unit_by_inbox_type_frrv_cst_coordinator(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_applications_at_unit_by_inbox_type_cst")) {
				String inbox_type = request.getParameter("inbox_type");

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("division", (String) session.getAttribute("division"));
				json_data.put("inbox_type", inbox_type);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl.load_applications_at_unit_by_inbox_type_cst(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_applications_at_unit_by_inbox_type_frrv_cst")) {
				String inbox_type = request.getParameter("inbox_type");

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", (String) session.getAttribute("unit_id"));
				json_data.put("unit_name", (String) session.getAttribute("unit_name"));
				json_data.put("division", (String) session.getAttribute("division"));
				json_data.put("inbox_type", inbox_type);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl.load_applications_at_unit_by_inbox_type_frrv_cst(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_cst")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.process_batch_list_cst(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("process_batch_list_frrv_cst")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.process_batch_list_frrv_cst(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("process_batch_list_cst_supervisor")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				System.out.println("testing cabinet batch: " + obj.toString());
				web_service_response = casemgt_cl
						.process_batch_list_cst_supervisor(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			
			if (request_type.equals("process_batch_list_frrv_cst_supervisor")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				System.out.println("testing cabinet batch: " + obj.toString());
				web_service_response = casemgt_cl
						.process_batch_list_frrv_cst_supervisor(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("process_batch_list_cst_supervisor_to_cordinator")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.process_batch_list_cst_supervisor_to_cordinator(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			

			if (request_type.equals("process_batch_list_frrv_cst_supervisor_to_cordinator")) {
				String list_of_application = request.getParameter("list_of_application");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("send_by_name", fullname);
				obj.put("send_by_id", userid);
				obj.put("send_to_id", send_to_id);
				obj.put("send_to_name", send_to_name);
				/*
				 * System.out.println("=====================");
				 * System.out.println(obj.toString());
				 * System.out.println("=====================");
				 */
				obj.put("division", division);
				obj.put("list_of_application", list_of_application);

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " +
				// obj.toString());
				web_service_response = casemgt_cl.process_batch_list_frrv_cst_supervisor_to_cordinator(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("pvlmd_number_generation_deed_number_ls_number")) {

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				String region_code = (String) session.getAttribute("regional_code");
				String case_number = request.getParameter("case_number");
				String job_number = request.getParameter("job_number");
				String number_format = request.getParameter("number_format");

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				obj.put("region_code", region_code);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("number_format", number_format);

				// String batchlistdivison = obj.toString();

				System.out.println("testing cabinet batch: " + obj.toString());
				web_service_response = casemgt_cl.pvlmd_number_generation_deed_number_ls_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("online_select_process_acknowledgement_regional_number_bulk")) {
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String regional_number_list = request.getParameter("regional_number_list");
				String ref_number = request.getParameter("ref_number");

				String licensed_surveyor_name = request.getParameter("licensed_surveyor_name");
				String business_process_id = request.getParameter("business_process_id");
				String business_process_name = request.getParameter("business_process_name");
				String business_process_sub_id = request.getParameter("business_process_sub_id");
				String business_process_sub_name = request.getParameter("business_process_sub_name");

				JSONObject obj = new JSONObject();

				obj.put("regional_number_list", regional_number_list);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("ref_number", ref_number);
				obj.put("userid", userid);

				obj.put("licensed_surveyor_name", licensed_surveyor_name);
				obj.put("business_process_id", business_process_id);
				obj.put("business_process_name", business_process_name);
				obj.put("business_process_sub_id", business_process_sub_id);
				obj.put("business_process_sub_name", business_process_sub_name);

				System.out.println(obj.toString());

				web_service_response = casemgt_cl
						.online_select_process_acknowledgement_regional_number_bulk(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				System.out.println(web_service_response);

				if (web_service_response != null) {
					String pdfFileName = "acnkwledgeslip_rn.pdf";

					String ws_case_number = ref_number;
					JSONObject jsonobject = new JSONObject(web_service_response);
					// String ws_case_number =
					// jsonobject.getString("case_number");

					// String ws_bill_details_db=
					// case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
					// String ws_bill_details_db=
					// case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

					String pdf_dest = cls_url_config.getCase_upload_location();
					String files_pdf_jackets_p = pdf_dest + ws_case_number + "/" + ref_number + "_" + "rn_b"
							+ pdfFileName;

					// File files_pdf_jackets = new File(pdf_dest + ws_case_number);

					// if (!files_pdf_jackets.exists()) {
					// 	if (files_pdf_jackets.mkdirs()) {
					// 		System.out.println("Multiple directories are created!");
					// 	} else {
					// 		System.out.println("Failed to create multiple directories!");
					// 	}
					// }
					
					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_service_acknoeledgement_bulk_regional_number(
							cls_url_config.getSoftfile_location(), 
							obj.toString(), 
							web_service_response, 
							session.getAttribute("fullname").toString(), 
							files_pdf_jackets_p);



				// 	JSONObject pdf_upload_obj = new JSONObject();
				// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				// pdf_upload_obj.put("jobNumber", job_number);
				// pdf_upload_obj.put("caseNumber",case_number);
				// pdf_upload_obj.put("fileData",base64Encoded);
							
				
			
 				// String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				// cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

					if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}

				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_compliance_application_notice_count_per_division")) {
				String region_id = request.getParameter("region_id");

				JSONObject json_data = new JSONObject();

				json_data.put("region_id", region_id);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl
						.select_compliance_application_notice_count_per_division(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_compliance_application_notice_by_division")) {
				String region_id = (String) session.getAttribute("regional_code");
				String unit_name = (String) session.getAttribute("unit_name");
				String division = (String) session.getAttribute("division");
				String notice_status = request.getParameter("notice_status");

				JSONObject obj = new JSONObject();

				obj.put("unit_name", unit_name);
				obj.put("division", division);
				obj.put("region_id", region_id);
				obj.put("notice_status", notice_status);

				String input_details = obj.toString();

				System.out.println(input_details);
				web_service_response = casemgt_cl
						.select_compliance_application_notice_by_division(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_compliance_application_notice")) {
				String region_id = request.getParameter("region_id");
				String division_name = request.getParameter("division_name");

				JSONObject json_data = new JSONObject();

				json_data.put("region_id", region_id);
				json_data.put("division_name", division_name);

				// System.out.println(json_data.toString());
				web_service_response = casemgt_cl
						.select_compliance_application_notice(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("update_application_sub_service")) {

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String job_number = request.getParameter("job_number");
				String sub_service_id = request.getParameter("sub_service_id");
				String sub_service_name = request.getParameter("sub_service_name");
				String officer_comment = request.getParameter("officer_comment");

				JSONObject obj = new JSONObject();

				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("job_number", job_number);
				obj.put("sub_service_id", sub_service_id);
				obj.put("sub_service_name", sub_service_name);
				obj.put("officer_comment", officer_comment);

				// System.out.println(obj.toString());

				web_service_response = casemgt_cl_m.update_application_sub_service(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
					/*
					 * JSONObject jsonobj = new
					 * JSONObject(web_service_response); web_service_response =
					 * (String) jsonobj.getString("data");
					 */
				}

				return web_service_response;
			}


			if (request_type.equals("online_select_regenerate_process_acknowledgment_slip")) {

				String job_number = request.getParameter("job_number");

				JSONObject obj = new JSONObject();
				obj.put("job_number", job_number);

				System.out.println(obj.toString());

				web_service_response = casemgt_cl_m.online_select_regenerate_process_acknowledgment_slip(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());

				if (web_service_response != null) {

					String pdfFileName = "acnkwledgeslip.pdf";

					JSONObject jsonobject = new JSONObject(web_service_response);
					//String ws_bill_number = jsonobject.getString("unique");
					String case_number = jsonobject.getString("case_number");
					String business_process_id = jsonobject.getString("business_process_id");
					String business_process_name = jsonobject.getString("business_process_name");
					String business_process_sub_id = jsonobject.getString("business_process_sub_id");
					String business_process_sub_name = jsonobject.getString("business_process_sub_name");
					String land_size = jsonobject.getString("land_size") == null ? "0.00" : jsonobject.getString("land_size");
					String client_name = jsonobject.getString("client_name");
					String locality_of_parcel = jsonobject.getString("locality_of_parcel");
					String type_of_interest = jsonobject.getString("type_of_interest");
					String created_date = jsonobject.getString("created_date");

					String service_bill_descdription_formated = business_process_sub_name.replace(" ", "_");

					JSONArray jsonArray = new JSONArray();
					JSONObject property_data_json = new JSONObject();

					property_data_json.put("business_process_id", business_process_id);
					property_data_json.put("business_process_name", business_process_name);
					property_data_json.put("business_process_sub_id", business_process_sub_id);
					property_data_json.put("business_process_sub_name", business_process_sub_name);
					property_data_json.put("ar_name", client_name);
					property_data_json.put("case_number", case_number);
					property_data_json.put("land_size", land_size);
					property_data_json.put("locality_of_parcel", locality_of_parcel);
					property_data_json.put("type_of_interest", type_of_interest);
					property_data_json.put("application_type", business_process_sub_name);
					property_data_json.put("created_date", created_date);

					jsonArray.put(property_data_json);

					//JSONObject jsonobject = new JSONObject(web_service_response);
					String ws_case_number = jsonobject.getString("case_number");

					JSONObject case_data_json = new JSONObject();
					case_data_json.put("job_number", job_number);
					case_data_json.put("case_number", case_number);

					jsonArray.put(case_data_json);

					String pdf_dest = cls_url_config.getCase_upload_location();
					String files_pdf_jackets_p = pdf_dest + ws_case_number + File.separator
							+ service_bill_descdription_formated
							+ "_" + job_number + pdfFileName;

					// File files_pdf_jackets = new File(pdf_dest + ws_case_number);

					// if (!files_pdf_jackets.exists()) {
					// 	if (files_pdf_jackets.mkdirs()) {
					// 		// System.out.println("Multiple directories are
					// 		// created!");
					// 	} else {
					// 		System.out.println("Failed to create multiple directories!");
					// 	}
					// }

					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.regenerate_process_acknowledgment_slip(
							cls_url_config.getSoftfile_location(),
							property_data_json.toString(), case_data_json.toString(),
							session.getAttribute("fullname").toString(), files_pdf_jackets_p);



					JSONObject pdf_upload_obj = new JSONObject();
					String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				pdf_upload_obj.put("jobNumber", job_number);
				pdf_upload_obj.put("caseNumber",case_number);
				pdf_upload_obj.put("fileData",base64Encoded);
							
				
				pdf_upload_obj.put("doc_name",job_number);
				pdf_upload_obj.put("doc_description","Acknowledgement Slip");
				pdf_upload_obj.put("doc_category","public_docs");
				pdf_upload_obj.put("doc_app_uploaded","elis");
				pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
			
 				String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

					// File pdfFile = new File(files_pdf_jackets_p);
					// byte[] buffer = null;

					// // String pdfFilename = "test.pdf"; // I use id here to
					// // determine pdf
					// // File f = new File(pdfFilename);

					// BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
					// ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

					// int ch;
					// long actual = 0;
					// while ((ch = is.read()) != -1) {
					// 	bos.write(ch);
					// 	actual++;
					// }
					// bos.flush();
					// bos.close();
					// buffer = bos.toByteArray();

					// response.setContentType("application/pdf");
					// response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
					// // response.addHeader("Content-Disposition", "inline;
					// // filename=Documentation.pdf");
					// response.setContentLength((int) pdfFile.length());
					// response.getOutputStream().write(buffer, 0, buffer.length);

					if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}

				} else {
					System.out.println(web_service_response);
				}

				//return web_service_response;
			}


			if (request_type.equals("select_cabinet_completed_searches")) {
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String division = (String) session.getAttribute("division");
				String list_of_application = request.getParameter("list_of_application");
				String cabinet_to_send_to = request.getParameter("cabinet_to_send_to");

				JSONObject json_data = new JSONObject();

				json_data.put("send_by_name", modified_by);
				json_data.put("send_by_id", modified_by_id);
				json_data.put("list_of_application", list_of_application);
				json_data.put("cabinet_name", cabinet_to_send_to);
				json_data.put("division", division);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_cabinet_completed_searches(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("select_cabinet_completed_application")) {
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String division = (String) session.getAttribute("division");
				String job_number = request.getParameter("job_number");
				String cabinet_to_send_to = request.getParameter("cabinet_to_send_to");

				JSONObject json_data = new JSONObject();

				json_data.put("send_by_name", modified_by);
				json_data.put("send_by_id", modified_by_id);
				json_data.put("job_number", job_number);
				json_data.put("cabinet_name", cabinet_to_send_to);
				json_data.put("division", division);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_cabinet_completed_application(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			

			if (request_type.equals("select_confirm_registration_transaction")) {
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String division = (String) session.getAttribute("division");
				String job_number = request.getParameter("job_number");
				String case_number = request.getParameter("case_number");
				String transaction_number = request.getParameter("transaction_number");

				JSONObject json_data = new JSONObject();

				json_data.put("send_by_name", modified_by);
				json_data.put("send_by_id", modified_by_id);
				json_data.put("job_number", job_number);
				json_data.put("case_number", case_number);
				json_data.put("division", division);
				json_data.put("transaction_number", transaction_number);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_confirm_registration_transaction(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("select_check_if_motherfile_linked")) {
				// String modified_by = (String) session.getAttribute("fullname");
				// String modified_by_id = (String) session.getAttribute("userid");
				// String division = (String) session.getAttribute("division");
				String job_number = request.getParameter("job_number");
				String case_number = request.getParameter("case_number");
				//String transaction_number = request.getParameter("transaction_number");

				JSONObject json_data = new JSONObject();

				// json_data.put("send_by_name", modified_by);
				// json_data.put("send_by_id", modified_by_id);
				json_data.put("job_number", job_number);
				json_data.put("case_number", case_number);
				// json_data.put("division", division);
				//json_data.put("transaction_number", transaction_number);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_check_if_motherfile_linked(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("select_linked_motherfile_details")) {
				// String modified_by = (String) session.getAttribute("fullname");
				// String modified_by_id = (String) session.getAttribute("userid");
				// String division = (String) session.getAttribute("division");
				String job_number = request.getParameter("job_number");
				String case_number = request.getParameter("case_number");
				//String transaction_number = request.getParameter("transaction_number");

				JSONObject json_data = new JSONObject();

				// json_data.put("send_by_name", modified_by);
				// json_data.put("send_by_id", modified_by_id);
				json_data.put("job_number", job_number);
				json_data.put("case_number", case_number);
				// json_data.put("division", division);
				//json_data.put("transaction_number", transaction_number);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_linked_motherfile_details(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_add_intended_interest_and_parcel_to_transfer")) {
				// String modified_by = (String) session.getAttribute("fullname");
				// String modified_by_id = (String) session.getAttribute("userid");
				// String division = (String) session.getAttribute("division");
				String case_number = request.getParameter("case_number");
				String job_number = request.getParameter("job_number");
				String intended_land = request.getParameter("intended_land");
				String intended_interest = request.getParameter("intended_interest");

				JSONObject json_data = new JSONObject();

				json_data.put("case_number", case_number);
				json_data.put("job_number", job_number);
				json_data.put("intended_land", intended_land);
				json_data.put("intended_interest", intended_interest);
				//json_data.put("division", division);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_add_intended_interest_and_parcel_to_transfer(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_reverse_transaction_approvals")) {
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				//String division = (String) session.getAttribute("division");
				String list_of_application = request.getParameter("list_of_application");
				//String cabinet_to_send_to = request.getParameter("cabinet_to_send_to");

				JSONObject json_data = new JSONObject();

				json_data.put("send_by_name", modified_by);
				json_data.put("send_by_id", modified_by_id);
				json_data.put("list_of_application", list_of_application);
				//json_data.put("cabinet_name", cabinet_to_send_to);
				//json_data.put("division", division);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_reverse_transaction_approvals(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_applications_for_transitional_plotting")) {
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				//String division = (String) session.getAttribute("division");
				String list_of_application = request.getParameter("list_of_application");
				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				JSONObject json_data = new JSONObject();

				json_data.put("send_by_name", modified_by);
				json_data.put("send_by_id", modified_by_id);
				json_data.put("list_of_application", list_of_application);
				json_data.put("send_to_id", send_to_id);
				json_data.put("send_to_name", send_to_name);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_applications_for_transitional_plotting(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_unit_for_compliance_report")) {

				String division_name = request.getParameter("division_name");
				String region_code = request.getParameter("region_code");

				JSONObject json_data = new JSONObject();

				json_data.put("division_name", division_name);
				json_data.put("region_code", region_code);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_unit_for_compliance_report(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_officers_for_compliance_report")) {
				
				String unit_id = request.getParameter("unit_id");

				JSONObject json_data = new JSONObject();

				json_data.put("unit_id", unit_id);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_officers_for_compliance_report(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_generate_compliance_notice_report")) {
				
				String officer_id = request.getParameter("officer_id");
				String date_from = request.getParameter("date_from");
				String date_to = request.getParameter("date_to");
				String unit_id = request.getParameter("unit_id");

				JSONObject json_data = new JSONObject();

				json_data.put("officer_id", officer_id);
				json_data.put("date_from", date_from);
				json_data.put("date_to", date_to);
				json_data.put("unit_id", unit_id);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_generate_compliance_notice_report(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_compliance_notice_report_logs")) {
				
				String job_number = request.getParameter("job_number");

				JSONObject json_data = new JSONObject();

				json_data.put("job_number", job_number);

				System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_compliance_notice_report_logs(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_pending_queries_for_compliance_notice")) {
				
				String pending_queries_input = request.getParameter("pending_queries_input");
				String region_id = request.getParameter("region_id");

				JSONObject json_data = new JSONObject();

				json_data.put("pending_queries_input", pending_queries_input);
				json_data.put("region_id", region_id);

				//System.out.println(json_data.toString());

				web_service_response = casemgt_cl_m.select_pending_queries_for_compliance_notice(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), json_data.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_incoming_application_for_transitional_plotting")) {
				
				//String job_number = request.getParameter("job_number");

				JSONObject obj = new JSONObject();

				//obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				//obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));
				obj.put("application_stage", 1);

				web_service_response = casemgt_cl_m
							.load_incoming_application_for_transitional_plotting(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_pending_application_for_transitional_plotting")) {
				
				//String job_number = request.getParameter("job_number");

				JSONObject obj = new JSONObject();

				//obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				//obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));
				obj.put("application_stage", 1);

				web_service_response = casemgt_cl_m
							.load_pending_application_for_transitional_plotting(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_completed_application_for_transitional_plotting")) {
				
				//String job_number = request.getParameter("job_number");

				JSONObject obj = new JSONObject();

				//obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				//obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));
				obj.put("application_stage", 1);

				web_service_response = casemgt_cl_m
							.load_completed_application_for_transitional_plotting(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("load_transitional_plotting_application_batched_to_user")) {

				web_service_response = casemgt_cl_m
							.load_transitional_plotting_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									(String) session.getAttribute("userid"));

									System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			

			if (request_type.equals("load_request_application_batched_to_user")) {

				
				web_service_response = casemgt_cl_m
							.load_request_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									(String) session.getAttribute("userid"));

									System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_send_message_to_officer")) {

				String am_to_officer = request.getParameter("am_to_officer");
				String message = request.getParameter("message");

				JSONObject obj = new JSONObject();

				obj.put("userid", (String) session.getAttribute("userid"));
				obj.put("am_to_officer", am_to_officer);
				obj.put("message", message);

				web_service_response = casemgt_cl_m
							.select_send_message_to_officer(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_load_message_details")) {

				String message_id = request.getParameter("message_id");

				JSONObject obj = new JSONObject();

				obj.put("message_id", message_id);

				web_service_response = casemgt_cl_m
							.select_load_message_details(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("corporate_processing_units_staff")) {


				String unit_code = request.getParameter("unit_code");				

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("unit_code", unit_code);
				

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " + obj.toString());
				web_service_response = casemgt_cl.corporate_processing_units_staff(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}





			if (request_type.equals("corporate_processing_units_application_with_staff")) {


				String staff_id = request.getParameter("staff_id");				

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("staff_id", staff_id);
				

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " + obj.toString());
				web_service_response = casemgt_cl.corporate_processing_units_application_with_staff(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("select_load_application_details")) {


				String transaction_number = request.getParameter("transaction_number");		
				String job_number = request.getParameter("job_number");	
				String load_type = request.getParameter("load_type");			

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("transaction_number", transaction_number);
				obj.put("job_number", job_number);
				obj.put("load_type", load_type);
				

				// String batchlistdivison = obj.toString();

				// System.out.println("testing cabinet batch: " + obj.toString());
				web_service_response = casemgt_cl.select_load_application_details(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			


		} catch (

		Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return web_service_response;
	}

}
