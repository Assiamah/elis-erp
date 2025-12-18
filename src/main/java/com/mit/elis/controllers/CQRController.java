package com.mit.elis.controllers;

import java.util.ArrayList;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import ws.compliance.ws_compliance;

@Controller
public class CQRController {

	ws_compliance cls_compliance = new ws_compliance();

    @Autowired
	private Ws_url_config cls_url_config;

    @RequestMapping("/compliance_query_and_response")
	@GetMapping
	public String compliance_query_and_response(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String office_region_list = (String) session.getAttribute("office_region_list");
            // System.out.println(office_region_list);
            Gson googleJson = new Gson();
            ArrayList javaArrayListFromGSON = googleJson.fromJson(office_region_list, ArrayList.class);
            request.setAttribute("officeregionlist", javaArrayListFromGSON);

            request.setAttribute("page_name", "compliance_query_and_response");
					model.addAttribute("content", "../pages/client_application/compliance_query_and_response.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}


	@RequestMapping("/regional_compliance_query_and_response")
	@GetMapping
	public String regional_compliance_query_and_response(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String office_region_list = (String) session.getAttribute("office_region_list");
            // System.out.println(office_region_list);
            Gson googleJson = new Gson();
            ArrayList javaArrayListFromGSON = googleJson.fromJson(office_region_list, ArrayList.class);
            request.setAttribute("officeregionlist", javaArrayListFromGSON);

			JSONObject obj = new JSONObject();

			String division = (String) session.getAttribute("division");
			String region_id = (String) (request.getParameter("region_id") != null
					? request.getParameter("region_id")
					: (String) session.getAttribute("regional_code"));

			obj.put("division", division);
			obj.put("region_id", region_id);
			
			String input_details = obj.toString();

			//System.out.println(input_details);

			String web_service_response = cls_compliance.select_compliance_application_notice_count_per_region(
					cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
					input_details);

			if (web_service_response != null) {

				JSONObject jsonObjCQ = new JSONObject(web_service_response);
				final JSONArray compliance_queries_array = jsonObjCQ.getJSONArray("compliance_queries");
				int arrLenghtCQ = compliance_queries_array.length();
				for(int i = 0; i< arrLenghtCQ;i++) {
					jsonObjCQ = compliance_queries_array.getJSONObject(i);
				String compliance_queries_count = jsonObjCQ.get("count").toString(); 
				request.setAttribute("compliance_queries_count",compliance_queries_count);
				}

				JSONObject jsonObjRC = new JSONObject(web_service_response);
				final JSONArray reminders_array = jsonObjRC.getJSONArray("reminders");
				int arrLenghtRC = reminders_array.length();
				for(int i = 0; i < arrLenghtRC;i++) {
					jsonObjRC = reminders_array.getJSONObject(i);
				String reminders_count = jsonObjRC.get("count").toString(); 
				request.setAttribute("reminders_count",reminders_count);
				}

				JSONObject jsonObjWC = new JSONObject(web_service_response);
				final JSONArray warnings_array = jsonObjWC.getJSONArray("warnings");
				int arrLenghtWC = warnings_array.length();
				for(int i = 0; i< arrLenghtWC;i++) {
					jsonObjWC = warnings_array.getJSONObject(i);
				String warnings_count = jsonObjWC.get("count").toString(); 
				request.setAttribute("warnings_count",warnings_count);
				}

				// JSONObject complaince_count_obj;

				// complaince_count_obj = new JSONObject(web_service_response);
				// String compliance_queries_count = complaince_count_obj.get("compliance_queries").toString();
				// String reminders_count = complaince_count_obj.get("reminders").toString();
				// String warnings_count = complaince_count_obj.get("warnings").toString();

				// request.setAttribute("compliance_queries_count", compliance_queries_count);
				// request.setAttribute("reminders_count", reminders_count);
				// request.setAttribute("warnings_count", warnings_count);

			} else {
				System.out.println(web_service_response);
			}

            request.setAttribute("page_name", "regional_compliance_query_and_response");
					model.addAttribute("content", "../pages/client_application/regional_compliance_query_and_response.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}


	@RequestMapping("/compliance_notice_report")
	@GetMapping
	public String compliance_notice_report(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String office_region_list = (String) session.getAttribute("office_region_list");
            // System.out.println(office_region_list);
            Gson googleJson = new Gson();
            ArrayList javaArrayListFromGSON = googleJson.fromJson(office_region_list, ArrayList.class);
            request.setAttribute("officeregionlist", javaArrayListFromGSON);

            request.setAttribute("page_name", "compliance_notice_report");
					model.addAttribute("content", "../pages/client_application/compliance_notice_report.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}
    
}
