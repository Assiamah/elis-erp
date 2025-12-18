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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class lrd_valuation_section_serv {
	cls_lrd_valuation_section lrd_valuation_section_cl = new cls_lrd_valuation_section();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/lrd_valuation_section_serv")
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

			if (request_type.equals("select_by_case_number")) {
				String case_number = request.getParameter("case_number");
				// System.out.println(case_number);
				web_service_response = lrd_valuation_section_cl
						.select_lrd_valuation_section_all_by_case_number(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								case_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lrd_valuation_section_add_and_update")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String vs_id = request.getParameter("vs_id");
				String case_number = request.getParameter("vs_case_number");
				String vs_date_of_valuation = request.getParameter("vs_date_of_valuation");
				String vs_amount = request.getParameter("vs_amount");
				String vs_remarks = request.getParameter("vs_remarks");
				String modified_by = request.getParameter("modified_by");
				String modified_by_id = request.getParameter("modified_by_id");

				obj.put("vs_id", vs_id);
				obj.put("case_number", case_number);
				obj.put("vs_date_of_valuation", vs_date_of_valuation);
				obj.put("vs_amount", vs_amount);
				obj.put("vs_remarks", vs_remarks);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = lrd_valuation_section_cl
						.select_lrd_valuation_section_add_and_update(cls_url_config.getWeb_service_url_ser(),
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
