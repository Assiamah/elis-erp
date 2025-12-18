package com.mit.elis.servlets;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ws.casemgt.cls_lrd_certificate_section;
import ws.lvd_compensation_maps.Ws_category_and_rate;
import org.springframework.ui.Model;
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
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;

@RestController
public class category_and_rate_serv {
	Ws_category_and_rate category_and_rate_cl = new Ws_category_and_rate();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/category_and_rate_serv")
	@PostMapping
	public String category_and_rate_serv(HttpSession session, Model model, HttpServletRequest request,
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

			if (request_type.equals("get_list_sub_category")) {
				String mc_code = request.getParameter("mc_code");
				
				JSONObject property_data_json = new JSONObject();

                property_data_json.put("mc_code", mc_code);

				web_service_response = category_and_rate_cl.select_cr_category_sub_classification_by_mc_code(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								property_data_json.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("sub_category_model_by_sub_category_code")) {
				String mc_code = request.getParameter("sub_category");
				
				JSONObject property_data_json = new JSONObject();

                property_data_json.put("sub_category_code", mc_code);

				web_service_response = category_and_rate_cl.select_cr_sub_category_model_by_sub_category_code(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								property_data_json.toString());
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
