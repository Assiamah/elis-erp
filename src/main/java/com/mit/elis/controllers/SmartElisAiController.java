package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.ws_professional_portal;
import ws.rentmgt.Ws_rent_mgt;

@Controller
public class SmartElisAiController {

	@Autowired
	private Ws_url_config cls_url_config;

	Ws_rent_mgt rent_mgt_service = new Ws_rent_mgt();

	@RequestMapping("/smart_elis_ai")
	@GetMapping
	public String rent_management_dashboard(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			//System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}
		Gson googleJson = new Gson();
		try {
			// String office_region_list = (String) session.getAttribute("office_region_list");
			// Gson googleJson_officeregions = new Gson();
			// ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
			// 		ArrayList.class);
			// request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			// String region_list = (String) session.getAttribute("region_list");
			// Gson googleJson_regions = new Gson();
			// ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			// request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			request.setAttribute("page_name", "smart_elis_ai");
					model.addAttribute("content", "../pages/smart_elis/smart_elis_ai.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}



}
