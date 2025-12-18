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
import ws.rentmgt.Ws_rent_mgt;

@Controller
public class CropRateController {

	@Autowired
	private Ws_url_config cls_url_config;

	Ws_rent_mgt rent_mgt_service = new Ws_rent_mgt();

	@RequestMapping("/lvd_crop_rate")
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

			

			request.setAttribute("page_name", "lvd_crop_rates");
					model.addAttribute("content", "../pages/lvd_crop_rates /lvd_crop_rate.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	


}
