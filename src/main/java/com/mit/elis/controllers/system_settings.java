package com.mit.elis.controllers;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import java.io.File;
import java.util.ArrayList;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import org.springframework.beans.factory.annotation.Autowired;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import org.springframework.stereotype.Controller;

@Controller
public class system_settings {
	cls_casemgt casemgt_cl = new cls_casemgt();

	@Autowired
	private Ws_url_config cls_url_config;

	Ws_client_application user_web_service = new Ws_client_application();

	@RequestMapping("/all_settings")
	@GetMapping
	public String all_setups(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
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

			String jsonArrayContent = user_web_service
					.select_lc_office_regions_districts(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject sub_service_obj = new JSONObject(jsonArrayContent);
			String all_list = sub_service_obj.get("data").toString();
			// System.out.println("all_list");

			// System.out.println(all_list);

			Gson googleJson_1 = new Gson();
			ArrayList javaArrayListFromGSON = googleJson_1.fromJson(all_list, ArrayList.class);
			request.setAttribute("data_rows", javaArrayListFromGSON);

			request.setAttribute("page_name", "settings_all");
					model.addAttribute("content", "../pages/setup/all_setups.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("/basic_settings")
	@GetMapping
	public String basic_setup(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
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

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(
					office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			String jsonArrayContent = user_web_service
					.select_lc_office_regions_districts(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject sub_service_obj = new JSONObject(jsonArrayContent);
			String all_list = sub_service_obj.get("data").toString();
			// System.out.println("all_list");

			// System.out.println(all_list);

			Gson googleJson_1 = new Gson();
			ArrayList javaArrayListFromGSON = googleJson_1.fromJson(all_list, ArrayList.class);
			request.setAttribute("data_rows", javaArrayListFromGSON);

			request.setAttribute("page_name", "settings_basic");
					model.addAttribute("content", "../pages/setup/basic_setup.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("/settings_checklists")
	@GetMapping
	public String setup_checklist(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
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
			String web_main_services_list = (String) session.getAttribute("web_main_services");
			Gson googleJson_web_main_services = new Gson();
			ArrayList javaArrayListFromGSON_web_main_services = googleJson_web_main_services.fromJson(
					web_main_services_list,
					ArrayList.class);
			request.setAttribute("webmainserviceslist", javaArrayListFromGSON_web_main_services);
			request.setAttribute("page_name", "settings_checklist");
					model.addAttribute("content", "../pages/setup/setup_checklist.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("/settings_milestones")
	@PostMapping
	public String setup_milestones(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
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
			String web_main_services_list = (String) session.getAttribute("web_main_services");
			Gson googleJson_web_main_services = new Gson();
			ArrayList javaArrayListFromGSON_web_main_services = googleJson_web_main_services.fromJson(
					web_main_services_list,
					ArrayList.class);
			request.setAttribute("webmainserviceslist", javaArrayListFromGSON_web_main_services);
			request.setAttribute("page_name", "settings_milestones");
					model.addAttribute("content", "../pages/setup/setup_milestones.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("/settings_units")
	@GetMapping
	public String settings_units(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
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

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(
					office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			request.setAttribute("page_name", "settings_units");
					model.addAttribute("content", "../pages/setup/settings_units.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

}
