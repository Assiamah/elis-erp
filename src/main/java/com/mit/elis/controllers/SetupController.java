package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;

@Controller
public class SetupController {

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/manage_milestone5")
	@GetMapping
	public String manage_milestone5(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		// Check if user allowed for page
		// HttpSession session = request.getSession();

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = assigenedmenus.contains(servletName); // true

		// Log User out if the user tries to access right not assigned
		if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println(("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			// //HttpSession session = request.getSession();

			cls_casemgt casemgt_web_service = new cls_casemgt();
			String web_service_response_menu = null;
			web_service_response_menu = casemgt_web_service
					.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							(String) session.getAttribute("userid"));
			JSONObject menu_obj;
			menu_obj = new JSONObject(web_service_response_menu);
			String all_menus = menu_obj.get("data").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
			request.setAttribute("applicationlist", javaArrayListFromGSON);

					model.addAttribute("content", "../pages/setup/manage_milestone.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

}
