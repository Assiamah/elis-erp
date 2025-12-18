package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.ws_professional_portal;
import ws.lvd_compensation_maps.Ws_category_and_rate;
import ws.rentmgt.Ws_rent_mgt;

@Controller
public class CategoryRateController {

	@Autowired
	private Ws_url_config cls_url_config;

	Ws_category_and_rate category_and_rate_service = new Ws_category_and_rate();

	@RequestMapping("/lvd_category_rate")
	@GetMapping
	public String rent_management_dashboard(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			String web_service_response_us = null;

			web_service_response_us = category_and_rate_service.select_cr_category_classification_all(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_us = new JSONObject(web_service_response_us);
			String user_category_list = web_response_case_us.get("data").toString();
			ArrayList user_category_list_list = googleJson.fromJson(user_category_list, ArrayList.class);

			request.setAttribute("main_category_list", user_category_list_list);

			request.setAttribute("page_name", "lvd_category_rate");
					model.addAttribute("content", "../pages/lvd_category_rates/lvd_category_rate.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	


}
