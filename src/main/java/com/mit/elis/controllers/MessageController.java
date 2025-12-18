package com.mit.elis.controllers;

import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import ws.casemgt.cls_casemgt;
import ws.users.Ws_users;

@Controller
public class MessageController {
    @Autowired
	private Ws_url_config cls_url_config;

	cls_casemgt casemagt_cl = new cls_casemgt();

    @RequestMapping("/message_center")
	@GetMapping
	public String add_new_case_template(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
		// Check if user allowed for page
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
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// Gson googleJson = new Gson();
		try {

			// cls_casemgt casemgt_web_service = new cls_casemgt();
			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

            cls_casemgt casemgt_web_service = new cls_casemgt();

			String web_service_response = null;
			JSONObject obj = new JSONObject();
			obj.put("userid", (String) session.getAttribute("userid"));

            web_service_response = casemgt_web_service
            .select_message_by_userid(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			JSONObject msg_obj;
			msg_obj = new JSONObject(web_service_response);
			String all_users = msg_obj.get("data").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_users, ArrayList.class);
			request.setAttribute("message_list", javaArrayListFromGSON);

				request.setAttribute("page_name", "message_center");

						model.addAttribute("content", "../pages/message/message_center.jsp"); return "layouts/app";

			} else {
				request.setAttribute("login", "sessionout");
				// System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}
    
}
