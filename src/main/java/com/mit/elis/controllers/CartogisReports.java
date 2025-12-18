package com.mit.elis.controllers;

import java.util.ArrayList;

import jakarta.servlet.ServletRequest;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

@Controller
public class CartogisReports {

                @Autowired
	private Ws_url_config cls_url_config;

    ServletRequest servletContext;

	// ws_csau_monitoring cls_monitoring = new ws_csau_monitoring();
	// ws_register_instruments cls_instruments_register = new ws_register_instruments();
    // ws_legal_monitoring  cls_legal_monitoring = new ws_legal_monitoring();

    
	@RequestMapping("/unit_report")
	@GetMapping
	public String plan_approval_report(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {


        String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);




            String surveyors_report_list = (String) session.getAttribute("surveyors_report_list");
			Gson googleJsonSurveyorslist = new Gson();
			ArrayList jsonArrayContent_surveyors = googleJsonSurveyorslist.fromJson(surveyors_report_list,
					ArrayList.class);
			request.setAttribute("surveyorsreportlist", jsonArrayContent_surveyors);


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



            String unit_id = (String) session.getAttribute("unit_id");
			String userlevel = (String) session.getAttribute("user_level");
            String userid = (String) session.getAttribute("userid");
            String division = (String) session.getAttribute("division");
            String unit_name = (String) session.getAttribute("unit_name");
            String region_id = (String) session.getAttribute("regional_code");
            

			request.setAttribute("userlevel",userlevel);
            request.setAttribute("region_id",region_id);

			
			
			JSONObject obj =new JSONObject();
			
			obj.put("unit_id",unit_id);

	// String web_service_response = cls_instruments_register.monitoring_backoffice_csau(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());


	//  String web_service_response = cls_backoffice_monitoring.monitoring_backoffice_csau(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());

        
           System.out.println(userid);
           System.out.println(unit_id);
           System.out.println(division);
           System.out.println(unit_name);
           System.out.println(region_id);
           
           
           

        //    System.out.println(userid);



           		model.addAttribute("content", "../pages/reports/unit_report.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }
    
}
