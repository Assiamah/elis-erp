package com.mit.elis.servlets;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ws.casemgt.cls_casemgt;
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
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

@RestController
public class Data_Resource_Locations_Serv {
	cls_casemgt case_documents_cl = new cls_casemgt();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/Data_Resource_Locations_Serv")
	@PostMapping
	public String doGet(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		String web_service_response = null;
		web_service_response = case_documents_cl
				.select_all_lc_data_resource_locations(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

		if (web_service_response != null) {

			System.out.println(web_service_response);
		} else {
			// obj.put( "success" , false );
			// obj.put( "msg" , "Incorrect user or password.';" );
			System.out.println(web_service_response);
		}

		return web_service_response;
	}
}
