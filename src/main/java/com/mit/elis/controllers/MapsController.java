package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;
import org.springframework.ui.Model;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import ws.maps.Ws_maps;

@Controller
public class MapsController {

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/lrd_generation_of_ls_deed_numbers")
	@GetMapping
	public String lrd_generation_of_ls_deed_numbers(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				/*
				 * cls_casemgt casemgt_web_service = new cls_casemgt(); String
				 * web_service_response_menu = null;
				 * 
				 * web_service_response_menu = casemgt_web_service
				 * .load_application_batched_to_user((String)
				 * session.getAttribute("userid"));
				 * System.out.println(web_service_response_menu); JSONObject
				 * menu_obj; menu_obj = new
				 * JSONObject(web_service_response_menu); String all_menus =
				 * menu_obj.get("data").toString();
				 * 
				 * Gson googleJson = new Gson(); ArrayList javaArrayListFromGSON
				 * = googleJson.fromJson(all_menus, ArrayList.class);
				 */
				// request.setAttribute("applicationlist",
				// javaArrayListFromGSON);
				request.setAttribute("page_name", "case_processing");
						model.addAttribute("content", "../pages/lrd_maps_templates/lrd_generation_of_ls_deed_numbers.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/lrd_mother_file_update")
	@GetMapping
	public String lrd_mother_file_update(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			try {

				if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
					cls_casemgt casemgt_web_service = new cls_casemgt();
					String web_service_response_menu = null;

					web_service_response_menu = casemgt_web_service
							.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									(String) session.getAttribute("userid"));
					System.out.println(web_service_response_menu);
					JSONObject menu_obj;
					menu_obj = new JSONObject(web_service_response_menu);
					String all_menus = menu_obj.get("data").toString();

					Gson googleJson = new Gson();
					ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
					request.setAttribute("applicationlist", javaArrayListFromGSON);
							model.addAttribute("content", "../pages/lrd_maps_templates/lrd_mother_file_update.jsp"); return "layouts/app";

				} else {

					// Session is expired
					request.setAttribute("login", "sessionout");
					System.out.println("If Not success");
					 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

				}

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {

			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		return assigenedmenus;

	}

	@RequestMapping("/lrd_transaction_search")
	@PostMapping
	public String lrd_transaction_search(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
				model.addAttribute("content", "../pages/lrd_maps_templates/lrd_transaction_search.jsp"); return "layouts/app";

	}

	@RequestMapping("/maps_data_capture_update")
	@PostMapping
	public String maps_data_capture_update(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
		Ws_maps cls_maps = new Ws_maps();
		String web_service_response = null;

		// System.out.println(obj.toString());
		System.out.println(cls_url_config.getWeb_service_url_ser());
		System.out.println(cls_url_config.getWeb_service_url_ser_api_key());

		try {
			web_service_response = cls_maps.select_count_of_lc_spatial_objects(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					"No-Parameter");
			JSONObject obj_test = new JSONObject(web_service_response);
			String parcel_count = obj_test.get("data").toString();
			request.setAttribute("parcel_count", parcel_count);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("page_name", "case_processing");

				model.addAttribute("content", "../pages/lrd_maps_templates/maps_data_capture_update.jsp"); return "layouts/app";

	}

	@RequestMapping("/lrd_map_blocking_module")
	@PostMapping
	public String lrd_map_blocking_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
		Ws_maps cls_maps = new Ws_maps();
		String web_service_response = null;

		// System.out.println(obj.toString());
		// System.out.println(cls_url_config.getWeb_service_url_ser());
		// System.out.println(cls_url_config.getWeb_service_url_ser_api_key());

		try {
			web_service_response = cls_maps.select_count_of_lc_spatial_objects(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					"No-Parameter");
			JSONObject obj_test = new JSONObject(web_service_response);
			String parcel_count = obj_test.get("data").toString();
			request.setAttribute("parcel_count", parcel_count);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("page_name", "lrd_map_blocking_module");

				model.addAttribute("content", "../pages/lrd_maps_templates/lrd_map_blocking_module.jsp"); return "layouts/app";

	}

	@RequestMapping("/title_plan_details_update")
	@PostMapping
	public String title_plan_details_update(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				/*
				 * cls_casemgt casemgt_web_service = new cls_casemgt(); String
				 * web_service_response_menu = null;
				 * 
				 * web_service_response_menu = casemgt_web_service
				 * .load_application_batched_to_user((String)
				 * session.getAttribute("userid"));
				 * System.out.println(web_service_response_menu); JSONObject
				 * menu_obj; menu_obj = new
				 * JSONObject(web_service_response_menu); String all_menus =
				 * menu_obj.get("data").toString();
				 * 
				 * Gson googleJson = new Gson(); ArrayList javaArrayListFromGSON
				 * = googleJson.fromJson(all_menus, ArrayList.class);
				 */
				// request.setAttribute("applicationlist",
				// javaArrayListFromGSON);
				request.setAttribute("page_name", "case_processing");
						model.addAttribute("content", "../pages/lrd_maps_templates/title_plan_details_update.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/title_plan_details_update_smd")
	@PostMapping
	public String title_plan_details_update_smd(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				/*
				 * cls_casemgt casemgt_web_service = new cls_casemgt(); String
				 * web_service_response_menu = null;
				 * 
				 * web_service_response_menu = casemgt_web_service
				 * .load_application_batched_to_user((String)
				 * session.getAttribute("userid"));
				 * System.out.println(web_service_response_menu); JSONObject
				 * menu_obj; menu_obj = new
				 * JSONObject(web_service_response_menu); String all_menus =
				 * menu_obj.get("data").toString();
				 * 
				 * Gson googleJson = new Gson(); ArrayList javaArrayListFromGSON
				 * = googleJson.fromJson(all_menus, ArrayList.class);
				 */
				// request.setAttribute("applicationlist",
				// javaArrayListFromGSON);
				request.setAttribute("page_name", "case_processing");
						model.addAttribute("content", "../pages/lrd_maps_templates/title_plan_details_update_smd.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	//
	@RequestMapping("/OpenLayers_map")
	@PostMapping
	public String OpenLayers_map(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
				model.addAttribute("content", "../pages/map_interface/OpenLayers_map.jsp"); return "layouts/app";

	}

}
