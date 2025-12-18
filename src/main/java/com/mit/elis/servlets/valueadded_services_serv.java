package com.mit.elis.servlets;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import ws.casemgt.cls_lrd_valuation_section;
import ws.ws_valueadded_services.cls_valueadded_services;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class valueadded_services_serv {
	cls_valueadded_services vas_cl = new cls_valueadded_services();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/valueadded_services_serv")
	@PostMapping
	public String lrd_valuation_section_serv(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");

			String web_service_response = null;

			// System.out.println(request_type);

			

			if (request_type.equals("select_set_request_as_completed")) {
				//JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String rq_id = request.getParameter("rq_id");
				String job_number = request.getParameter("job_number");
				String transaction_number = request.getParameter("transaction_number");
				String modified_by = request.getParameter("modified_by");
				String modified_by_id = request.getParameter("modified_by_id");

				 System.out.println(rq_id);
				  System.out.println(job_number);
				   System.out.println(transaction_number);

				obj.put("rq_id", rq_id);
				obj.put("job_number", job_number);
				obj.put("transaction_number", transaction_number);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

				//jsonArr.put(obj);
				String input = obj.toString();
 System.out.println("How are you");
				 System.out.println(input);
				web_service_response = vas_cl
						.select_set_request_as_completed(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}
			if (request_type.equals("get_all_baby_steps_for_job")) {
				JSONObject obj = new JSONObject();

				String job_number = request.getParameter("job_number");
				String workflow_type = request.getParameter("workflow_type");

				obj.put("job_number", job_number);
				obj.put("workflow_type", workflow_type);

				String input = obj.toString();
				//System.out.println(input);
				web_service_response = vas_cl
						.get_all_baby_steps_for_job(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("get_process_milestone_update_baby_steps_for_job")) {
				JSONObject obj = new JSONObject();

				String bse_id = request.getParameter("bse_id");
				obj.put("bse_id", bse_id);

				String input = obj.toString();
				//System.out.println(input);
				web_service_response = vas_cl
						.get_process_milestone_update_baby_steps_for_job(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			


			if (request_type.equals("process_sent_jobs_for_records_verification")) {
				//JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String job_number = request.getParameter("job_number");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				String userid = (String) session.getAttribute("userid");

				String send_to_id = request.getParameter("send_to_id");
				String send_to_name = request.getParameter("send_to_name");

				String division = (String) session.getAttribute("division");

				// System.out.println(list_of_application);

				
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
				//jsonArr.put(obj);
				String input = obj.toString();
 System.out.println("How are you");
				 System.out.println(input);
				web_service_response = vas_cl
						.process_sent_jobs_for_records_verification(cls_url_config.getWeb_service_url_ser(),
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
