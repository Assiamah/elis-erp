package com.mit.elis.controllers;

import java.util.ArrayList;
import org.springframework.ui.Model;
// import jakarta.script.ScriptContext;
// import jakarta.script.SimpleScriptContext;
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
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import ws.cica.ws_cica;
import ws.compliance.ws_compliance;


@Controller
public class AuditReport {


    @Autowired
	private Ws_url_config cls_url_config;

    //cls_casemgt casemagt_cl = new cls_casemgt();
	ws_compliance cls_compliance = new ws_compliance();

    // @RequestMapping("/audit_report_")
	// @GetMapping
	// public String compliance(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

    //     String servletName = request.getServletPath();
	// 	servletName = servletName.replace("/", "");
	// 	String assigenedmenus = (String) session.getAttribute("menus_com");
	// 	boolean isFound = false;
	// 	try {
	// 		isFound = assigenedmenus.contains(servletName); // true
	// 	} catch (Exception e) {
	// 	}

    //     if (!isFound) {
	// 		request.setAttribute("login", "Please this is not alllowed");
	// 		//
	// 		 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
	// 	}

	// 	if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
	// 		// Session is expired
	// 		request.setAttribute("login", "sessionout");
	// 		System.out.println("If Not success");
	// 		 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

	// 	}

	// 	//Gson googleJson = new Gson();
	// 	try {

    //   String office_region_list = (String) session.getAttribute("office_region_list");
	// 		Gson googleJson_officeregions = new Gson();
	// 		ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
	// 				ArrayList.class);
	// 		request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);
      

    //   //String regional_code = (String) request.getParameter("regional_code");
			
			
	// 		JSONObject obj =new JSONObject();
	
            


	// 				model.addAttribute("content", "../pages/client_application/audit_report.jsp"); return "layouts/app";
        

	// 	} catch (Exception e) {
	// 		// TODO Auto-generated catch block
	// 		e.printStackTrace();
	// 	}
	// 	return null;
    // }


	@RequestMapping("/audit_report")
	@GetMapping
	public String audit_report(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);
      

      //String regional_code = (String) request.getParameter("regional_code");
			
			
			JSONObject obj =new JSONObject();
	
            


					model.addAttribute("content", "../pages/client_application/audit_report_dashboard.jsp"); return "layouts/app";
        

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }
    
    
}
