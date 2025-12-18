package com.mit.elis.servlets;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ws.casemgt.cls_lrd_encumbrances_section;
import java.io.File;
import java.util.ArrayList;

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
public class lrd_encumbrances_section_serv {
	cls_lrd_encumbrances_section lrd_encumbrances_section_cl = new cls_lrd_encumbrances_section();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/lrd_encumbrances_section_serv")
	@PostMapping
	public String lrd_encumbrances_section_serv(HttpSession session, Model model, HttpServletRequest request,
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

			System.out.println(request_type);

			if (request_type.equals("select_lrd_encumbrances_section_all_by_case_number")) {
				String case_number = request.getParameter("case_number");
				System.out.println(case_number);
				web_service_response = lrd_encumbrances_section_cl
						.select_lrd_encumbrances_section_all_by_case_number(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								case_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lrd_encumbrances_section_all_by_id")) {
				String case_number = request.getParameter("case_number");
				System.out.println(case_number);
				web_service_response = lrd_encumbrances_section_cl
						.select_lrd_encumbrances_section_all_by_id(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								case_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lrd_encumbrances_section_add_and_update")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String es_id = request.getParameter("es_id");
				String case_number = request.getParameter("es_case_number");
				String es_date_of_instrument = request.getParameter("es_date_of_instrument");
				String es_date_of_registration = request.getParameter("es_date_of_registration");
				String es_registered_number = request.getParameter("es_registered_number");
				String es_memorials = request.getParameter("es_memorials");
				String es_back = request.getParameter("es_back");
				String es_forward = request.getParameter("es_forward");
				String es_remarks = request.getParameter("es_remarks");
				String es_signature = request.getParameter("es_signature");
				String modified_by = request.getParameter("modified_by");
				String modified_by_id = request.getParameter("modified_by_id");
				String es_entry_number = request.getParameter("es_entry_number");
				

				obj.put("es_id", es_id);
				obj.put("case_number", case_number);
				obj.put("es_date_of_instrument", es_date_of_instrument);
				obj.put("es_date_of_registration", es_date_of_registration);
				obj.put("es_registered_number", es_registered_number);
				obj.put("es_memorials", es_memorials);
				obj.put("es_back", es_back);
				obj.put("es_forward", es_forward);
				obj.put("es_remarks", es_remarks);
				obj.put("es_signature", es_signature);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("es_entry_number", es_entry_number);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				System.out.println(input);
				web_service_response = lrd_encumbrances_section_cl
						.select_lrd_encumbrances_section_add_and_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					System.out.println(web_service_response);
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
