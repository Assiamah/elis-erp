package com.mit.elis.servlets.menu;

import java.io.File;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import ws.users.Ws_users;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class DashboardMenu {
	Ws_users cls_users = new Ws_users();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/DashboardMenu")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		String request_type = request.getParameter("request_type");
		String web_service_response = null;

		// System.out.println(request_type);

		if (request_type.equals("get_all")) {

			web_service_response = cls_users.get_all_dashboard_menu(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			if (web_service_response != null) {
				// System.out.println(web_service_response);
			} else {
				System.out.println(web_service_response);
			}

		}

		if (request_type.equals("get_profile_by_user")) {

			String userid = request.getParameter("userid");

			// System.out.println(ap_number);
			web_service_response = cls_users.user_profile_for_user(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), userid);
			if (web_service_response != null) {
				// System.out.println(web_service_response);
			} else {
				System.out.println(web_service_response);
			}
		}

		return web_service_response;

	}
}
