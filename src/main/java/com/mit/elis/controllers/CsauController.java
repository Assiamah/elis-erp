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
public class CsauController {
	@Autowired
	private Ws_url_config cls_url_config;

	cls_casemgt casemagt_cl = new cls_casemgt();

	@RequestMapping("/add_new_case_template")
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

				request.setAttribute("page_name", "csau_online");

						model.addAttribute("content", "../pages/csau_template/add_new_case_template.jsp"); return "layouts/app";

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

	@RequestMapping("/change_of_names")
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

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/csau_template/change_of_names.jsp"); return "layouts/app";

			// request"/csau_template/csau_online.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/gra_dashboard_online")
	@GetMapping
	public String gra_dashboard_online(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
			// request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

				cls_casemgt casemgt_web_service = new cls_casemgt();

				// System.out.println(Ws_url_config.web_main_services);
				ArrayList javaArrayListFromGSON_sub_service = googleJson
						.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
				request.setAttribute("main_services", javaArrayListFromGSON_sub_service);

				request.setAttribute("page_name", "csau_online");

						model.addAttribute("content", "../pages/csau_template/gra_dashboard_online.jsp"); return "layouts/app";

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

	@RequestMapping("/csau_backoffice_revised_module")
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

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/csau_template/csau_backoffice_revised_module.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}


	@RequestMapping("/motherfile_review_template")
	@GetMapping
	public String motherfile_review_template(HttpSession session, Model model, HttpServletRequest request,
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

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/client_application/motherfile_review_template.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/application_review")
	@GetMapping
	public String applicaiton_review_mod(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		
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

				if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
					cls_casemgt casemgt_web_service = new cls_casemgt();
					String web_service_response_menu = null;
					String web_service_response_menu_data = null;
					String web_service_response_tc = null;
	

					// web_service_response_menu = casemgt_web_service
					// 		.load_count_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
					// 				cls_url_config.getWeb_service_url_ser_api_key(),
					// 				(String) session.getAttribute("userid"));

										
				web_service_response_menu = casemgt_web_service
							.load_request_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									(String) session.getAttribute("userid"));



					// System.out.println(web_service_response_menu);
					JSONObject menu_obj;
					menu_obj = new JSONObject(web_service_response_menu);
					String all_menus = menu_obj.get("total").toString();
	
					// Gson googleJson = new Gson();
					// ArrayList javaArrayListFromGSON =
					// googleJson.fromJson(all_menus, ArrayList.class);
					request.setAttribute("applicationlistcount", all_menus);
	
					// String web_service_response_menu_data_n = casemgt_web_service
					// 		.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
					// 				cls_url_config.getWeb_service_url_ser_api_key(),
					// 				(String) session.getAttribute("userid"));
	//System.out.println("In correct data all_menus_data all all");
	//System.out.println(web_service_response_menu_data);
					 //menu_obj_data;
					//JSONObject menu_obj_data_n = new JSONObject(web_service_response_menu_data_n);
					String all_menus_data = menu_obj.get("data").toString(); 
					//System.out.println("In correct data all_menus_data");
					//System.out.println(all_menus_data);
					Gson googleJson = new Gson();
					ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus_data, ArrayList.class);
	
					request.setAttribute("applicationlist", javaArrayListFromGSON);
	
					// web_service_response_tc = casemgt_web_service
					// 		.load_count_transitional_plotting_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
					// 				cls_url_config.getWeb_service_url_ser_api_key(),
					// 				(String) session.getAttribute("userid"));
	
					// web_service_response_tc = casemgt_web_service
					// .load_count_request_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
					// 		cls_url_config.getWeb_service_url_ser_api_key(),
					// 		(String) session.getAttribute("userid"));
	
					// JSONObject result_obj;
	
					// result_obj = new JSONObject(web_service_response_tc);
					// String incoming = result_obj.get("incoming").toString();
	
					// request.setAttribute("applicationCount", incoming);
	
	
					//request.setAttribute("page_name", "csau_online");
							model.addAttribute("content", "../pages/client_application/application_review.jsp"); return "layouts/app";
	
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

	@RequestMapping("/transitional_coordinate_entry")
	@GetMapping
	public String transitional_coordinate_entry(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
		// Check if user allowed for page
		// HttpSession session = request.getSession();
		cls_casemgt casemgt_web_service = new cls_casemgt();
		String web_service_response_menu = null;

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

			web_service_response_menu = casemgt_web_service
						.load_application_batched_to_user_for_transitional_coordinate_en(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));

				JSONObject menu_obj_data;
				menu_obj_data = new JSONObject(web_service_response_menu);
				String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus_data, ArrayList.class);

				request.setAttribute("applicationlist", javaArrayListFromGSON);

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/client_application/transitional_coordinate_entry.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/transitional_certificate_number")
	@GetMapping
	public String transitional_certificate_number(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
		// Check if user allowed for page
		// HttpSession session = request.getSession();
		cls_casemgt casemgt_web_service = new cls_casemgt();
		String web_service_response_menu = null;

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

			web_service_response_menu = casemgt_web_service
						.load_application_batched_to_user_for_transitional_certificate(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));

				JSONObject menu_obj_data;
				menu_obj_data = new JSONObject(web_service_response_menu);
				String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus_data, ArrayList.class);

				request.setAttribute("applicationlist", javaArrayListFromGSON);
			

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/client_application/transitional_certificate_number.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/transitional_plan_details_update")
	@GetMapping
	public String transitional_plan_details_update(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
		// Check if user allowed for page
		// HttpSession session = request.getSession();

		cls_casemgt casemgt_web_service = new cls_casemgt();
		String web_service_response_menu = null;

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

			web_service_response_menu = casemgt_web_service
						.load_application_batched_to_user_for_transitional_plan_details(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));

				JSONObject menu_obj_data;
				menu_obj_data = new JSONObject(web_service_response_menu);
				String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus_data, ArrayList.class);

				request.setAttribute("applicationlist", javaArrayListFromGSON);

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/client_application/transitional_plan_details_update.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/search_application_map_plotting")
	@GetMapping
	public String search_application_map_plotting(HttpSession session, Model model, HttpServletRequest request,
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

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/csau_template/search_application_map_plotting.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/files_room_module")
	@GetMapping
	public String files_room_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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

		}

		try {
			cls_casemgt casemgt_web_service = new cls_casemgt();

			String web_service_response_menu = null;
				JSONObject obj = new JSONObject();
				obj.put("unit_id", (String) session.getAttribute("unit_id"));

				web_service_response_menu = casemgt_web_service
						.load_count_archived_application_by_unit(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				// web_service_response_menu =
				// casemgt_web_service.load_application_details_to_unit((String)
				// session.getAttribute("unit_id"));
				JSONObject menu_obj;

				menu_obj = new JSONObject(web_service_response_menu);
				String count = menu_obj.get("count").toString();

				request.setAttribute("count", count);

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/csau_template/files_room_module.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/csau_backoffice")
	@GetMapping
	public String csau_backoffice(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				JSONObject obj = new JSONObject();
				obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				obj.put("is_csau", "true");
				obj.put("division", (String) session.getAttribute("division"));

				web_service_response_menu = casemgt_web_service
						.load_application_details_to_unit(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				// web_service_response_menu =
				// casemgt_web_service.load_application_details_to_unit((String)
				// session.getAttribute("unit_id"));
				JSONObject menu_obj;

				menu_obj = new JSONObject(web_service_response_menu);
				String incoming = menu_obj.get("incoming").toString();
				String completed = menu_obj.get("completed").toString();
				String queried = menu_obj.get("queried").toString();
				String awaiting_payments = menu_obj.get("awaiting_payments").toString();

				request.setAttribute("page_name", "csau_backoffice");

				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("queried", queried);
				request.setAttribute("awaiting_payment", awaiting_payments);
						model.addAttribute("content", "../pages/csau_template/csau_backoffice.jsp"); return "layouts/app";

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
		return assigenedmenus;

	}

	@RequestMapping("/csau_manual_payment_capture")
	@GetMapping
	public String csau_manual_payment_capture(HttpSession session, Model model, HttpServletRequest request,
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
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			Gson googleJson = new Gson();
			try {

				request.setAttribute("page_name", "csau_online");
						model.addAttribute("content", "../pages/csau_template/csau_manual_payment_capture.jsp"); return "layouts/app";

				// request"/csau_template/csau_manual_payment_capture.jsp").forward(request,
				// response);

			} catch (Exception e) {
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

	@RequestMapping("/enquiry_desk")
	@GetMapping
	public String enquiry_desk(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// //HttpSession session = request.getSession();

			request.setAttribute("page_name", "page_enquiry_desk");
					model.addAttribute("content", "../pages/client_application/enquiry_desk.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/bulk_csau_collection")
	@GetMapping
	public String bulk_csau_collection(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			request.setAttribute("page_name", "page_bulk_csau_collection");
					model.addAttribute("content", "../pages/client_application/bulk_csau_collection.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/bulk_csau_receiving")
	@GetMapping
	public String bulk_csau_receiving(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			request.setAttribute("page_name", "page_bulk_csau_receiving");
					model.addAttribute("content", "../pages/client_application/bulk_csau_receiving.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/bulk_collection_for_payment")
	@GetMapping
	public String bulk_collection_for_payment(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			request.setAttribute("page_name", "page_bulk_collection_for_payment");
					model.addAttribute("content", "../pages/client_application/bulk_collection_for_payment.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/appdata_transfer_template")
	@GetMapping
	public String appdata_transfer_template(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			request.setAttribute("page_name", "page_appdata_transfer_template");
					model.addAttribute("content", "../pages/client_application/appdata_transfer_template.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/enquiry_desk_stamping")
	@GetMapping
	public String enquiry_desk_stamping(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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
		try {

			request.setAttribute("page_name", "page_enquiry_desk_stamping");
					model.addAttribute("content", "../pages/client_application/enquiry_desk_stamping.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/further_entries_new_corporate")
	@GetMapping
	public String further_entries_new_corporate(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

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

		try {

			request.setAttribute("page_name", "further_entries_new");

			if ((String) session.getAttribute("division") != null && (String) session.getAttribute("division") != "") {
				// Session is expired

				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				JSONObject obj = new JSONObject();
				obj.put("regional_code", (String) session.getAttribute("regional_code"));
				obj.put("submission_type", "Corporate");
				String input = obj.toString();

				web_service_response_menu = casemgt_web_service
						.load_new_application_for_online(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				/*
				 * web_service_response_menu = casemgt_web_service
				 * .load_new_application_for_online((String)
				 * session.getAttribute("regional_code"));
				 */
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/client_application/further_entries_new_corporate.jsp"); return "layouts/app";

			} else {
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/further_entries_new_lisag")
	@GetMapping
	public String further_entries_new_lisag(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

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

		try {

			request.setAttribute("page_name", "further_entries_new");

			if ((String) session.getAttribute("division") != null && (String) session.getAttribute("division") != "") {
				// Session is expired

				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				JSONObject obj = new JSONObject();
				obj.put("regional_code", (String) session.getAttribute("regional_code"));
				obj.put("submission_type", "Lisag");
				String input = obj.toString();

				web_service_response_menu = casemgt_web_service
						.load_new_application_for_online(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				/*
				 * web_service_response_menu = casemgt_web_service
				 * .load_new_application_for_online((String)
				 * session.getAttribute("regional_code"));
				 */
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/client_application/further_entries_new_lisag.jsp"); return "layouts/app";

			} else {
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;
	}

	@RequestMapping("/further_entries_new_online")
	@GetMapping
	public String further_entries_new_online(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

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

		try {

			request.setAttribute("page_name", "further_entries_new");

			if ((String) session.getAttribute("division") != null && (String) session.getAttribute("division") != "") {
				// Session is expired

				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				JSONObject obj = new JSONObject();
				obj.put("regional_code", (String) session.getAttribute("regional_code"));
				obj.put("submission_type", "Online");
				String input = obj.toString();

				// web_service_response_menu =
				// casemgt_web_service.load_new_application_for_online(input);

				web_service_response_menu = casemgt_web_service
						.load_new_application_for_online(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/client_application/further_entries_new_online.jsp"); return "layouts/app";

			} else {
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/further_entries_new_regulariization")
	@GetMapping
	public String further_entries_new_regurilization(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

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

		try {

			request.setAttribute("page_name", "further_entries_new");

			if ((String) session.getAttribute("division") != null && (String) session.getAttribute("division") != "") {
				// Session is expired

				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				JSONObject obj = new JSONObject();
				obj.put("regional_code", (String) session.getAttribute("regional_code"));
				obj.put("submission_type", "Online_Regularization");
				String input = obj.toString();

				// web_service_response_menu =
				// casemgt_web_service.load_new_application_for_online(input);

				web_service_response_menu = casemgt_web_service
						.load_new_application_for_online(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/client_application/further_entries_new_regularization.jsp"); return "layouts/app";

			} else {
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/further_entries_new")
	@GetMapping
	public String further_entries_new(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			request.setAttribute("page_name", "further_entries_new");

			if ((String) session.getAttribute("division") != null && (String) session.getAttribute("division") != "") {
				// Session is expired

				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				web_service_response_menu = casemgt_web_service.load_count_new_application_for_division(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						(String) session.getAttribute("division"),
						(String) session.getAttribute("regional_code"));
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String total_count = menu_obj.get("total").toString();

				request.setAttribute("applicationlistcount", total_count);

				web_service_response_menu = casemgt_web_service.load_new_application_for_division(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						(String) session.getAttribute("division"),
						(String) session.getAttribute("regional_code"));
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/client_application/further_entries_new.jsp"); return "layouts/app";

			} else {
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

	@RequestMapping("/further_entries")
	@PostMapping
	public String further_entries(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			try {

				

				String web_service_response = null;
				Gson googleJson = new Gson();

				// Page Name
				request.setAttribute("page_name", "further_entries");

				String case_number = request.getParameter("transaction_number");
				String job_number = request.getParameter("job_number");
				String business_process_sub_name = request.getParameter("business_process_sub_name");

				// System.out.println(case_number);
				// System.out.println(job_number);

				JSONObject obj = new JSONObject();

				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				String batchlistdivison = obj.toString();
				// System.out.println(batchlistdivison);
				web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						batchlistdivison);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					JSONObject case_obj;
					case_obj = new JSONObject(web_service_response);

					String parcel_details = case_obj.get("parcel_details").toString();
					String transaction_details = case_obj.get("transaction_details").toString();
					String job_detail = case_obj.get("job_detail").toString();

					String job_details = case_obj.get("job_details").toString();
					String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
					String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
					String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
					String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
					String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
					String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
					String collection_checklist = case_obj.get("collection_checklist").toString();
					String application_munites = case_obj.get("application_munites").toString();
					String payment_bill = case_obj.get("payment_bill").toString();
					String comments_on_application = case_obj.get("comments_on_application").toString();
					String parties = case_obj.get("parties").toString();

					String case_query = case_obj.get("case_query").toString();
					String case_objection = case_obj.get("case_objection").toString();
					String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
					String recieving_checklist = case_obj.get("recieving_checklist").toString();

					// ArrayList main_details_list =
					// googleJson.fromJson(main_details, ArrayList.class);
					ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
					ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
					ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
					ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
					ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
							ArrayList.class);
					ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section,
							ArrayList.class);
					ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
							ArrayList.class);
					ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
					ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
					ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
					ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application,
							ArrayList.class);
					ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

					ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
					ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);
					ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
					ArrayList recieving_checklist_list = googleJson.fromJson(recieving_checklist, ArrayList.class);

					// request.setAttribute("transaction_details",
					// main_details);
					request.setAttribute("job_details", job_details_list);
					// request.setAttribute("parcels_coordinates",
					// parcels_coordinates_list);
					request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
					request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
					request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
					request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
					request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
					request.setAttribute("collection_checklist", collection_checklist_list);
					request.setAttribute("application_munites", application_munites_list);
					request.setAttribute("payment_bill", payment_bill_list);
					request.setAttribute("comments_on_application", comments_on_application_list);
					request.setAttribute("parties", parties_list);

					request.setAttribute("case_query", case_query_list);

					request.setAttribute("case_objection", case_objection_list);
					request.setAttribute("case_inspections", case_inspections_list);
					request.setAttribute("recieving_checklist", recieving_checklist_list);

					request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

					// System.out.println(case_obj.get("parcel_wkt").toString());

					JSONObject parcel_details_obj;
					parcel_details_obj = new JSONObject(parcel_details);

					String new_case_number = parcel_details_obj.get("case_number").toString();
					request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
					request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
					request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
					request.setAttribute("locality", parcel_details_obj.get("locality").toString());
					request.setAttribute("district", parcel_details_obj.get("district").toString());
					request.setAttribute("region", parcel_details_obj.get("region").toString());
					request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
					request.setAttribute("extent", parcel_details_obj.get("extent").toString());
					request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
					request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
					request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
					request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
					request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
					request.setAttribute("registration_district_number",
							parcel_details_obj.get("registration_district_number").toString());
					request.setAttribute("registration_section_number",
							parcel_details_obj.get("registration_section_number").toString());
					request.setAttribute("registration_block_number",
							parcel_details_obj.get("registration_block_number").toString());

					request.setAttribute("need_for_new_transaction",
							parcel_details_obj.get("need_for_new_transaction").toString());

					JSONObject transaction_details_obj;
					transaction_details_obj = new JSONObject(transaction_details);
					request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
					request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
					request.setAttribute("transaction_number",
							transaction_details_obj.get("transaction_number").toString());
					request.setAttribute("date_of_document",
							transaction_details_obj.get("date_of_document").toString());
					request.setAttribute("nature_of_instrument",
							transaction_details_obj.get("nature_of_instrument").toString());
					request.setAttribute("certificate_number",
							transaction_details_obj.get("certificate_number").toString());

					request.setAttribute("type_of_interest",
							transaction_details_obj.get("type_of_interest").toString());
					request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
					request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
					request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
					request.setAttribute("term", transaction_details_obj.get("term").toString());
					request.setAttribute("commencement_date",
							transaction_details_obj.get("commencement_date").toString());

					request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
					request.setAttribute("consideration_fee",
							transaction_details_obj.get("consideration_fee").toString());
					request.setAttribute("consideration_fee_currency",
							transaction_details_obj.get("consideration_fee_currency").toString());
					request.setAttribute("stamp_duty_payable",
							transaction_details_obj.get("stamp_duty_payable").toString());
					request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
					request.setAttribute("parcel_description",
							transaction_details_obj.get("parcel_description").toString());
					request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
					request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
					request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

					request.setAttribute("family_of_grantor",
							transaction_details_obj.get("family_of_grantor").toString());

					request.setAttribute("rent_review_period",
							transaction_details_obj.get("rent_review_period").toString());
					request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

					request.setAttribute("rent_period_covered",
							transaction_details_obj.get("rent_period_covered").toString());
					request.setAttribute("rent_review_date",
							transaction_details_obj.get("rent_review_date").toString());
					request.setAttribute("date_of_first_payment",
							transaction_details_obj.get("date_of_first_payment").toString());
					request.setAttribute("outstanding_rent",
							transaction_details_obj.get("outstanding_rent").toString());
					request.setAttribute("remark_or_comment",
							transaction_details_obj.get("remark_or_comment").toString());
					request.setAttribute("date_of_registration",
							transaction_details_obj.get("date_of_registration").toString());
					request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

					request.setAttribute("stool_family_name",
							transaction_details_obj.get("stool_family_name").toString());
					// request.setAttribute("is_part_of_gelis_area",
					// transaction_details_obj.get("is_part_of_gelis_area").toString());
					request.setAttribute("stamp_duty_description",
							transaction_details_obj.get("stamp_duty_description").toString());
					request.setAttribute("certificate_type",
							transaction_details_obj.get("certificate_type").toString());
					request.setAttribute("case_file_number",
							transaction_details_obj.get("case_file_number").toString());
					// request.setAttribute("phone_number",
					// job_detail_obj.get("phone_number").toString());
					request.setAttribute("case_process_stage",
							transaction_details_obj.get("case_process_stage").toString());

					request.setAttribute("interest_number",
							transaction_details_obj.get("interest_number").toString());

					JSONObject job_detail_obj;
					job_detail_obj = new JSONObject(job_detail);
					request.setAttribute("job_number", job_number);
					request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());

					// System.out.println(job_detail_obj.get("application_stage").toString());
					request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
					request.setAttribute("business_process_name",
							job_detail_obj.get("business_process_name").toString());
					request.setAttribute("business_process_sub_id",
							job_detail_obj.get("business_process_sub_id").toString());
					request.setAttribute("business_process_sub_name",
							job_detail_obj.get("business_process_sub_name").toString());
					request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
					request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
					JSONArray arr_r = new JSONArray();

					String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
					// System.out.println("folderpath: " +folderpath);
					// List All Files In a Folder
					File subdir = new File(folderpath.toString());
					String[] children = subdir.list();
					if (children == null) {
						// System.out.println("Either dir does not exist or is
						// not a
						// directory");
					} else {
						for (int j = 0; j < children.length; j++) {
							String filename_doc = children[j];
							// System.out.println("case_number: " +
							// case_number);
							// System.out.println("File: " + filename_doc);
							String path = folderpath.toString() + "/" + filename_doc;

							String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
							JSONObject obj_r = new JSONObject();
							// obj_r.put( "d_id" , 0 );
							// obj_r.put( "job_number" , "SMDGARGA37542018" );
							// obj_r.put( "case_number" , "LCGARGACN37542018" );
							obj_r.put("document_name", filename_doc);
							obj_r.put("document_type", path);
							obj_r.put("document_extention", extension);
							obj_r.put("document_file", path);
							obj_r.put("uploaded_by", "");
							obj_r.put("uploaded_date", "");

							arr_r.put(obj_r);
						}

					}

					String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
					// System.out.println(arr_r.toString());
					// request.setAttribute("casescanneddocuments",
					// arr_r.toString());

					// System.out.println(business_process_sub_name);

				} else {
					System.out.println(web_service_response);
				}

				/*
				 * JSONArray arr_r = new JSONArray();
				 * 
				 * String folderpath
				 * =ws_url_config.get_lrd_jacket_pdf_path_final_app() +
				 * case_number; //System.out.println("folderpath: "
				 * +folderpath); //List All Files In a Folder File subdir = new
				 * File(folderpath.toString()); String[] children =
				 * subdir.list(); if (children == null) { System.out.println(
				 * "Either dir does not exist or is not a directory"); } else {
				 * for (int j = 0; j< children.length; j++) { String
				 * filename_doc = children[j];
				 * System.out.println("case_number: " +case_number);
				 * System.out.println("File: " +filename_doc); String path =
				 * folderpath.toString()+"\\"+filename_doc;
				 * 
				 * String extension =
				 * filename_doc.substring(filename_doc.lastIndexOf("."));
				 * 
				 * JSONObject obj_r = new JSONObject(); obj_r.put(
				 * "document_name" , filename_doc ); obj_r.put( "document_type"
				 * , path ); obj_r.put( "document_extention" , extension );
				 * obj_r.put( "document_file" ,path ); obj_r.put( "uploaded_by"
				 * , "" ); obj_r.put( "uploaded_date" , "" );
				 * 
				 * arr_r.add(obj_r); }
				 * 
				 * } System.out.println(arr_r.toString());
				 * 
				 * request.setAttribute("casescanneddocuments",
				 * arr_r.toString());
				 */

						model.addAttribute("content", "../pages/client_application/further_entries.jsp"); return "layouts/app";

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

	@RequestMapping("/client_application")
	@GetMapping
	public String csau_online(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			Gson googleJson = new Gson();
			try {

				if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
					cls_casemgt casemgt_web_service = new cls_casemgt();

					String web_main_services_list = (String) session.getAttribute("web_main_services");
					Gson googleJson_web_main_services = new Gson();
					ArrayList javaArrayListFromGSON_web_main_services = googleJson_web_main_services.fromJson(
							web_main_services_list,
							ArrayList.class);
					request.setAttribute("webmainserviceslist", javaArrayListFromGSON_web_main_services);

					String web_sub_services_list = (String) session.getAttribute("web_sub_services");
					Gson googleJson_web_sub_services = new Gson();
					ArrayList javaArrayListFromGSON_web_sub_services = googleJson_web_sub_services.fromJson(
							web_sub_services_list,
							ArrayList.class);
					request.setAttribute("websubserviceslist", javaArrayListFromGSON_web_sub_services);

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

					String region_id = (String) session.getAttribute("regional_code");
					JSONObject obj = new JSONObject();
					obj.put("region_code", region_id);
					String locality_list = user_web_service.get_locality_by_region(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							obj.toString());

					JSONObject jsonobj_locality = new JSONObject(locality_list);
					locality_list = (String) jsonobj_locality.getString("data");
					Gson googleJson_locality = new Gson();
					ArrayList javaArrayListFromGSON_locality = googleJson_locality.fromJson(locality_list,
							ArrayList.class);
					request.setAttribute("localitylist", javaArrayListFromGSON_locality);

					String lvd_revenue_list = user_web_service.select_revenue_items_for_lvd_stamping_list(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key());

					JSONObject jsonobj = new JSONObject(lvd_revenue_list);
					lvd_revenue_list = (String) jsonobj.getString("data");
					Gson googleJson_lvd_revenue = new Gson();
					ArrayList javaArrayListFromGSON_lvd_revenue = googleJson_lvd_revenue.fromJson(lvd_revenue_list,
							ArrayList.class);
					request.setAttribute("lvdrevenuelist", javaArrayListFromGSON_locality);

					request.setAttribute("page_name", "csau_online");

					//		model.addAttribute("content", "../pages/csau_template/csau_online.jsp"); return "layouts/app";
					model.addAttribute("content", "../pages/csau_template/csau_online.jsp");
					return "layouts/app";

				} else {
					request.setAttribute("login", "sessionout");
					// System.out.println("If Not success");
					 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

				}

			} catch (Exception e) {
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

	@RequestMapping("/account_creation")
	@GetMapping
	public String account_creation(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			Gson googleJson = new Gson();
			try {

				if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
					cls_casemgt casemgt_web_service = new cls_casemgt();

					String web_main_services_list = (String) session.getAttribute("web_main_services");
					Gson googleJson_web_main_services = new Gson();
					ArrayList javaArrayListFromGSON_web_main_services = googleJson_web_main_services.fromJson(
							web_main_services_list,
							ArrayList.class);
					request.setAttribute("webmainserviceslist", javaArrayListFromGSON_web_main_services);

					String web_sub_services_list = (String) session.getAttribute("web_sub_services");
					Gson googleJson_web_sub_services = new Gson();
					ArrayList javaArrayListFromGSON_web_sub_services = googleJson_web_sub_services.fromJson(
							web_sub_services_list,
							ArrayList.class);
					request.setAttribute("websubserviceslist", javaArrayListFromGSON_web_sub_services);

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

					String region_id = (String) session.getAttribute("regional_code");
					JSONObject obj = new JSONObject();
					obj.put("region_code", region_id);
					String locality_list = user_web_service.get_locality_by_region(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							obj.toString());

					JSONObject jsonobj_locality = new JSONObject(locality_list);
					locality_list = (String) jsonobj_locality.getString("data");
					Gson googleJson_locality = new Gson();
					ArrayList javaArrayListFromGSON_locality = googleJson_locality.fromJson(locality_list,
							ArrayList.class);
					request.setAttribute("localitylist", javaArrayListFromGSON_locality);

					String lvd_revenue_list = user_web_service.select_revenue_items_for_lvd_stamping_list(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key());

					JSONObject jsonobj = new JSONObject(lvd_revenue_list);
					lvd_revenue_list = (String) jsonobj.getString("data");
					Gson googleJson_lvd_revenue = new Gson();
					ArrayList javaArrayListFromGSON_lvd_revenue = googleJson_lvd_revenue.fromJson(lvd_revenue_list,
							ArrayList.class);
					request.setAttribute("lvdrevenuelist", javaArrayListFromGSON_locality);

					request.setAttribute("page_name", "csau_online");
							model.addAttribute("content", "../pages/csau_template/account_creation.jsp"); return "layouts/app";

				} else {
					request.setAttribute("login", "sessionout");
					// System.out.println("If Not success");
					 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

				}

			} catch (Exception e) {
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

	@RequestMapping("/manual_bills_dashboard")
	@GetMapping
	public String manual_bills_dashboard(HttpSession session, Model model, HttpServletRequest request,
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
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			Gson googleJson = new Gson();
			try {

				// request.setAttribute("fullname", Ws_url_config.web_fullname);
				// request.setAttribute("userid", Ws_url_config.web_useid);
				// request.setAttribute("division", Ws_url_config.web_division);
				// request.setAttribute("user_level", Ws_url_config.user_level);

				// request.setAttribute("fullname", Ws_url_config.web_fullname);
				// request.setAttribute("userid", Ws_url_config.web_useid);
				// request.setAttribute("division", Ws_url_config.web_division);
				// request.setAttribute("user_level", Ws_url_config.user_level);

				cls_casemgt casemgt_web_service = new cls_casemgt();
				/*
				 * if ((String) session.getAttribute("userid") != null) { String
				 * web_service_response_menu = null; web_service_response_menu =
				 * casemgt_web_service
				 * .load_application_batched_to_user((String)
				 * session.getAttribute("userid"));
				 * 
				 * JSONObject menu_obj; menu_obj = new
				 * JSONObject(web_service_response_menu); String all_menus =
				 * menu_obj.get("data").toString();
				 * 
				 * ArrayList javaArrayListFromGSON =
				 * googleJson.fromJson(all_menus, ArrayList.class);
				 * request.setAttribute("applicationlist",
				 * javaArrayListFromGSON);
				 * 
				 * }
				 */
				/*
				 * System.out.println(Ws_url_config.web_main_services);
				 * ArrayList javaArrayListFromGSON_sub_service =
				 * googleJson.fromJson(Ws_url_config.web_main_services,
				 * ArrayList.class); request.setAttribute("main_services",
				 * javaArrayListFromGSON_sub_service);
				 */
				/*
				 * RequestDispatcher rd=request
				 * "/client_application/case_movement_module.jsp"); return "layouts/app";
				 * rd.include(request,response);
				 */
				request.setAttribute("page_name", "csau_online");
						model.addAttribute("content", "../pages/csau_template/manual_bills_dashboard.jsp"); return "layouts/app";

				// request"/csau_template/manual_bills_dashboard.jsp").forward(request,
				// response);

			} catch (Exception e) {
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

	@RequestMapping("/manual_bills_stamp_duty")
	@GetMapping
	public String manual_bills_stamp_duty(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
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
			// System.out.println("If Not success");
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
			/*
			 * if ((String) session.getAttribute("userid") != null) { String
			 * web_service_response_menu = null; web_service_response_menu =
			 * casemgt_web_service .load_application_batched_to_user((String)
			 * session.getAttribute("userid"));
			 * 
			 * JSONObject menu_obj; menu_obj = new
			 * JSONObject(web_service_response_menu); String all_menus =
			 * menu_obj.get("data").toString();
			 * 
			 * ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus,
			 * ArrayList.class); request.setAttribute("applicationlist",
			 * javaArrayListFromGSON);
			 * 
			 * }
			 */
			/*
			 * System.out.println(Ws_url_config.web_main_services); ArrayList
			 * javaArrayListFromGSON_sub_service =
			 * googleJson.fromJson(Ws_url_config.web_main_services,
			 * ArrayList.class); request.setAttribute("main_services",
			 * javaArrayListFromGSON_sub_service);
			 */
			/*
			 * RequestDispatcher rd=request
			 * "/client_application/case_movement_module.jsp"); return "layouts/app";
			 * rd.include(request,response);
			 */
			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/csau_template/manual_bills_stamp_duty.jsp"); return "layouts/app";

			// request"/csau_template/manual_bills_dashboard.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/regional_transitional_bill")
	@GetMapping
	public String regional_transitional_bill(HttpSession session, Model model, HttpServletRequest request,
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
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			Gson googleJson = new Gson();
			try {

				// request.setAttribute("fullname", Ws_url_config.web_fullname);
				// request.setAttribute("userid", Ws_url_config.web_useid);
				// request.setAttribute("division", Ws_url_config.web_division);
				// request.setAttribute("user_level", Ws_url_config.user_level);

				// request.setAttribute("fullname", Ws_url_config.web_fullname);
				// request.setAttribute("userid", Ws_url_config.web_useid);
				// request.setAttribute("division", Ws_url_config.web_division);
				// request.setAttribute("user_level", Ws_url_config.user_level);

				cls_casemgt casemgt_web_service = new cls_casemgt();
				/*
				 * if ((String) session.getAttribute("userid") != null) { String
				 * web_service_response_menu = null; web_service_response_menu =
				 * casemgt_web_service
				 * .load_application_batched_to_user((String)
				 * session.getAttribute("userid"));
				 * 
				 * JSONObject menu_obj; menu_obj = new
				 * JSONObject(web_service_response_menu); String all_menus =
				 * menu_obj.get("data").toString();
				 * 
				 * ArrayList javaArrayListFromGSON =
				 * googleJson.fromJson(all_menus, ArrayList.class);
				 * request.setAttribute("applicationlist",
				 * javaArrayListFromGSON);
				 * 
				 * }
				 */
				/*
				 * System.out.println(Ws_url_config.web_main_services);
				 * ArrayList javaArrayListFromGSON_sub_service =
				 * googleJson.fromJson(Ws_url_config.web_main_services,
				 * ArrayList.class); request.setAttribute("main_services",
				 * javaArrayListFromGSON_sub_service);
				 */
				/*
				 * RequestDispatcher rd=request
				 * "/client_application/case_movement_module.jsp"); return "layouts/app";
				 * rd.include(request,response);
				 */

				String office_region_list = (String) session.getAttribute("office_region_list");
				Gson googleJson_officeregions = new Gson();
				ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
						ArrayList.class);
				request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

				request.setAttribute("page_name", "csau_online");
						model.addAttribute("content", "../pages/csau_template/regional_transitional_bill.jsp"); return "layouts/app";

				// request"/csau_template/manual_bills_dashboard.jsp").forward(request,
				// response);

			} catch (Exception e) {
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

	@RequestMapping("/receive_document_plan_approval")
	@GetMapping
	public String receive_document_plan_approval(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
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
			// System.out.println("If Not success");
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

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/csau_template/receive_document_plan_approval.jsp"); return "layouts/app";

			// request"/csau_template/manual_bills_dashboard.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/receive_document_stamp_duty")
	@GetMapping
	public String receive_document_stamp_duty(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
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
			// System.out.println("If Not success");
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

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/csau_template/receive_document_stamp_duty.jsp"); return "layouts/app";

			// request"/csau_template/manual_bills_dashboard.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;
	}

	Ws_client_application user_web_service = new Ws_client_application();

	@RequestMapping("/regional_number_bulk_online")
	@GetMapping
	public String regional_number_bulk_online(HttpSession session, Model model, HttpServletRequest request,
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
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			Gson googleJson = new Gson();
			try {

				System.out.println((String) session.getAttribute("web_main_services"));
				ArrayList javaArrayListFromGSON_sub_service = googleJson
						.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
				request.setAttribute("main_services", javaArrayListFromGSON_sub_service);

				// request"/csau_template/regional_number_bulk_online.jsp").forward(request,
				// response);

				String jsonArrayContent = user_web_service
						.select_lc_office_regions_districts(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());
				JSONObject sub_service_obj = new JSONObject(jsonArrayContent);
				String all_list = sub_service_obj.get("data").toString();
				// System.out.println("all_list");

				// System.out.println(all_list);

				String office_region_list = (String) session.getAttribute("office_region_list");
				Gson googleJson_officeregions = new Gson();
				ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
						ArrayList.class);
				request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

				String region_list = (String) session.getAttribute("region_list");
				Gson googleJson_regions = new Gson();
				ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
				request.setAttribute("regionlist", javaArrayListFromGSON_regions);

				Gson googleJson_1 = new Gson();
				ArrayList javaArrayListFromGSON = googleJson_1.fromJson(all_list, ArrayList.class);
				request.setAttribute("data_rows", javaArrayListFromGSON);

				request.setAttribute("page_name", "csau_online");
						model.addAttribute("content", "../pages/csau_template/regional_number_bulk_online.jsp"); return "layouts/app";

			} catch (Exception e) {
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

	@RequestMapping("/stamping_light_document_bulk_online")
	@GetMapping
	public String stamping_light_document_bulk_online(HttpSession session, Model model, HttpServletRequest request,
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
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			Gson googleJson = new Gson();
			try {

				// request.setAttribute("fullname", Ws_url_config.web_fullname);
				// request.setAttribute("userid", Ws_url_config.web_useid);
				// request.setAttribute("division", Ws_url_config.web_division);
				// request.setAttribute("user_level", Ws_url_config.user_level);

				// request.setAttribute("fullname", Ws_url_config.web_fullname);
				// request.setAttribute("userid", Ws_url_config.web_useid);
				// request.setAttribute("division", Ws_url_config.web_division);
				// request.setAttribute("user_level", Ws_url_config.user_level);

				System.out.println((String) session.getAttribute("web_main_services"));
				ArrayList javaArrayListFromGSON_sub_service = googleJson
						.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
				request.setAttribute("main_services", javaArrayListFromGSON_sub_service);

				// request"/csau_template/regional_number_bulk_online.jsp").forward(request,
				// response);

				request.setAttribute("page_name", "csau_online");
						model.addAttribute("content", "../pages/csau_template/stamping_light_document_bulk_online.jsp"); return "layouts/app";

			} catch (Exception e) {
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

	@RequestMapping("/verify_stamp_duty")
	@GetMapping
	public String verify_stamp_duty_payment_only(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
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
			// System.out.println("If Not success");
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

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/csau_template/verify_stamp_duty_payment_only.jsp"); return "layouts/app";

			// request"/csau_template/manual_bills_dashboard.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	@RequestMapping("/generate_acknowledgement_slip")
	@GetMapping
	public String generate_acknowledgement_slip(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
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
			// System.out.println("If Not success");
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

			request.setAttribute("page_name", "generate_acknowledgement_slip");
					model.addAttribute("content", "../pages/csau_template/generate_acknowledgement_slip.jsp"); return "layouts/app";

			// request"/csau_template/manual_bills_dashboard.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;
	}

	@RequestMapping("/cabinet_completed_searches")
	@GetMapping
	public String cabinet_completed_searches(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
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
			// System.out.println("If Not success");
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

			request.setAttribute("page_name", "page_cabinet_completed_searches");
					model.addAttribute("content", "../pages/csau_template/cabinet_completed_searches.jsp"); return "layouts/app";

			// request"/csau_template/manual_bills_dashboard.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;
	}

	@RequestMapping("/reverse_transaction_approval")
	@GetMapping
	public String reverse_transaction_approval(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
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
			// System.out.println("If Not success");
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

			request.setAttribute("page_name", "page_reverse_transaction_approval");
					model.addAttribute("content", "../pages/csau_template/reverse_transaction_approval.jsp"); return "layouts/app";

			// request"/csau_template/manual_bills_dashboard.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;
	}

}
