package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import java.io.File;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;

@Controller
public class FeesandChargesController {
	@Autowired
	private Ws_url_config cls_url_config;

	cls_casemgt casemagt_cl = new cls_casemgt();

	@RequestMapping("/flat_fees_and_charges")
	@GetMapping
	public String add_new_case_template(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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

				request.setAttribute("page_name", "fees_and_charges");

						model.addAttribute("content", "../pages/fees_and_charges_template/flat_fees_and_charges.jsp"); return "layouts/app";

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

	@RequestMapping("/smd_related_fees_charges")
	@GetMapping
	public String change_of_names(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		Gson googleJson = new Gson();
		try {

			cls_casemgt casemgt_web_service = new cls_casemgt();

			request.setAttribute("page_name", "fees_and_charges");
					model.addAttribute("content", "../pages/fees_and_charges_template/smd_related_fees_charges.jsp"); return "layouts/app";

			// request"/csau_template/csau_online.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/lvd_ralated_fees_and_charges")
	@GetMapping
	public String csau_backoffice_revised_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
			// request.setAttribute("login", "Please this is not alllowed");
			//
			//  model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
			//
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			// request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			//  model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
			//

		}

		try {

			request.setAttribute("page_name", "fees_and_charges");
					model.addAttribute("content", "../pages/fees_and_charges_template/lvd_ralated_fees_and_charges.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

}
