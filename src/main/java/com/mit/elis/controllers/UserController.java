package com.mit.elis.controllers;

import java.util.ArrayList;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.users.Ws_users;

@Controller
public class UserController {
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/user_mgt_module_servlet00z1")
	@GetMapping
	public String tpp_coordinator_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			// HttpSession session = request.getSession();

			String servletName = request.getServletPath();
			servletName = servletName.replace("/", "");
			String assigenedmenus = (String) session.getAttribute("menus_com");
			boolean isFound = false;
			try {
				isFound = assigenedmenus.contains(servletName); // true
			} catch (Exception e) {
			}

			// Log User out if the user tries to access right not assigned
			if (!isFound) {
				request.setAttribute("login", "Please this is not alllowed");
				//
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}
			Ws_users user_web_service = new Ws_users();

			String web_service_response = null;
			web_service_response = user_web_service.get_list_of_users(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject users_obj;
			users_obj = new JSONObject(web_service_response);
			String all_users = users_obj.get("data").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_users, ArrayList.class);

			String web_elis_app_levels_list = (String) session.getAttribute("web_elis_app_levels");
					Gson googleJson_web_elis_app_levels = new Gson();
					ArrayList javaArrayListFromGSON_web_elis_app_levels = googleJson_web_elis_app_levels.fromJson(
						web_elis_app_levels_list,
							ArrayList.class);
					request.setAttribute("elis_app_levels_list", javaArrayListFromGSON_web_elis_app_levels);
					
			request.setAttribute("users_list", javaArrayListFromGSON);
			request.setAttribute("page_name", "user_management");

					model.addAttribute("content", "../pages/user_management/user_mgt_module.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

}
