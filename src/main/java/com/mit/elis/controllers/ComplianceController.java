package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import ws.casemgt.Ws_client_application;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ComplianceController {
    @Autowired
    private Ws_url_config cls_url_config;

    Ws_client_application user_web_service = new Ws_client_application();

    @RequestMapping("/compliance_no_login")
	@GetMapping
	public String cica_complaints(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException {

        // String servletName = request.getServletPath();
		// servletName = servletName.replace("/", "");
		// String assigenedmenus = (String) session.getAttribute("menus_com");
		// boolean isFound = false;
		// try {
		// 	isFound = assigenedmenus.contains(servletName); // true
		// } catch (Exception e) {
		// }

        // if (!isFound) {
		// 	request.setAttribute("login", "Please this is not alllowed");
		// 	//
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		// }

		// if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
		// 	// Session is expired
		// 	request.setAttribute("login", "sessionout");
		// 	System.out.println("If Not success");
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		// }

        String jsonArrayContent_office_region = user_web_service
							.select_lc_office_regions_districts_all(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());

        JSONObject office_region_obj = new JSONObject(jsonArrayContent_office_region);
        String office_region_list = office_region_obj.get("data").toString();

        Gson googleJson_officeregions = new Gson();
        ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
                ArrayList.class);
        request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

        String region_list = (String) session.getAttribute("region_list");
        Gson googleJson_regions = new Gson();
        ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
        request.setAttribute("regionlist", javaArrayListFromGSON_regions);


		try {
            request.setAttribute("page_name", "compliance_no_login");
					model.addAttribute("content", "../pages/client_application/compliance_no_login.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

}
