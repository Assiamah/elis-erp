package com.mit.elis.servlets;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import ws.casemgt.cls_lrd_proprietorship_section;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class lrd_proprietorship_section_serv {
	cls_lrd_proprietorship_section lrd_proprietorship_section_cl = new cls_lrd_proprietorship_section();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/lrd_proprietorship_section_serv")
	@PostMapping
	public String lrd_proprietorship_section_serv(HttpSession session, Model model, HttpServletRequest request,
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

			if (request_type.equals("select_lrd_proprietorship_section_all_by_case_number")) {
				String case_number = request.getParameter("case_number");
				// System.out.println(case_number);
				web_service_response = lrd_proprietorship_section_cl
						.select_lrd_proprietorship_section_all_by_case_number(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								case_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lrd_proprietorship_section_all_by_id")) {
				String case_number = request.getParameter("case_number");
				// System.out.println(case_number);
				web_service_response = lrd_proprietorship_section_cl
						.select_lrd_proprietorship_section_all_by_id(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								case_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lrd_proprietorship_section_add_and_update")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String ps_id = request.getParameter("ps_id");
				String case_number = request.getParameter("ps_case_number");
				String ps_registration_number = request.getParameter("ps_registration_number");
				String ps_proprietor = request.getParameter("ps_proprietor");
				String ps_date_of_instrument = request.getParameter("ps_date_of_instrument");
				String ps_nature_of_instrument = request.getParameter("ps_nature_of_instrument");
				String ps_date_of_registration = request.getParameter("ps_date_of_registration");
				String ps_transferor = request.getParameter("ps_transferor");
				String ps_transferee = request.getParameter("ps_transferee");
				String ps_price_paid = request.getParameter("ps_price_paid");
				String ps_remarks = request.getParameter("ps_remarks");
				String ps_signature = request.getParameter("ps_signature");
				String modified_by = request.getParameter("modified_by");
				String modified_by_id = request.getParameter("modified_by_id");
				String ps_term = request.getParameter("ps_term");

				obj.put("ps_id", ps_id);
				obj.put("case_number", case_number);
				obj.put("ps_registration_number", ps_registration_number);
				obj.put("ps_proprietor", ps_proprietor);
				obj.put("ps_date_of_instrument", ps_date_of_instrument);
				obj.put("ps_nature_of_instrument", ps_nature_of_instrument);
				obj.put("ps_date_of_registration", ps_date_of_registration);
				obj.put("ps_transferor", ps_transferor);
				obj.put("ps_transferee", ps_transferee);
				obj.put("ps_price_paid", ps_price_paid);
				obj.put("ps_remarks", ps_remarks);
				obj.put("ps_signature", ps_signature);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("ps_term", ps_term);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				System.out.println(input);
				web_service_response = lrd_proprietorship_section_cl
						.select_lrd_proprietorship_section_add_and_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								input);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("select_lrd_proprietorship_section_delete_by_id")) {
				String ps_id = request.getParameter("ps_id");
				String target_element = request.getParameter("target_element");
				JSONObject obj = new JSONObject();

				obj.put("del_id", ps_id);
				obj.put("target_element", target_element);
				// System.out.println(" testing action" + obj.toString());
				web_service_response = lrd_proprietorship_section_cl
						.select_lrd_proprietorship_section_delete_by_id(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								obj.toString());
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
