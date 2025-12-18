package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import ws.maps.Ws_maps;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class PVLMDMapsController {

	Ws_maps cls_maps = new Ws_maps();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/dlrev_map")
	@PostMapping
	public String dlrev_map(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/pvlmd_maps_templates/dlrev_map.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_map_searches")
	@GetMapping
	public String pvlmd_map_searches(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		/*
		 * Ws_users user_web_service = new Ws_users();
		 * 
		 * String jsonArrayContent =null; jsonArrayContent
		 * =user_web_service.get_list_of_users();
		 * 
		 * 
		 * 
		 * Gson gson = new Gson(); List<Cls_users> list =
		 * gson.fromJson(jsonArrayContent, new
		 * TypeToken<List<Cls_users>>(){}.getType());
		 * 
		 * List<Cls_users> result=new ArrayList<Cls_users>(); JSONArray jArr;
		 * try { jArr = new JSONArray(jsonArrayContent); for (int i=0; i <
		 * jArr.length(); i++) { JSONObject jsonObject = jArr.getJSONObject(i);
		 * 
		 * String uid = (String) jsonObject.getString("uid"); String user_name =
		 * (String) jsonObject.getString("user_name"); String gender = (String)
		 * jsonObject.getString("gender"); String password = (String)
		 * jsonObject.getString("password");
		 * 
		 * Cls_users user = new Cls_users(); user.setUid(uid);
		 * user.setUser_name(user_name); user.setGender(gender);
		 * user.setPassword(password); result.add(user); } } catch
		 * (JSONException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 */

		// request.setAttribute("errorString", "Error on Page");
		// request.setAttribute("users_list", result);
		// request"/client_application/app_database_update.jsp").forward(request,
		// response);

		/*
		 * //HttpSession session = request.getSession();
		 * 
		 * session.setAttribute("fullname", (String)
		 * session.getAttribute("web_fullname")); session.setAttribute("userid",
		 * (String) session.getAttribute("web_useid"));
		 * session.setAttribute("division", (String)
		 * session.getAttribute("web_division"));
		 * session.setAttribute("user_level", (String)
		 * session.getAttribute("user_level"));
		 */
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_map_searches.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_maps")
	@GetMapping
	public String pvlmd_maps(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_maps.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_noted_proposal_map")
	@GetMapping
	public String pvlmd_noted_proposal_map(HttpSession session, Model model, HttpServletRequest request,
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
		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_noted_proposal_map.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_number_generation_template")
	@GetMapping
	public String pvlmd_number_generation_template(HttpSession session, Model model, HttpServletRequest request,
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
				model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_number_generation_template.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_transaction_search_add")
	@GetMapping
	public String pvlmd_transaction_search_add(HttpSession session, Model model, HttpServletRequest request,
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
		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_transaction_search_add.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_transaction_search_delete")
	@GetMapping
	public String pvlmd_transaction_search_delete(HttpSession session, Model model, HttpServletRequest request,
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
		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_transaction_search_delete.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_transaction_search_edit")
	@GetMapping
	public String pvlmd_transaction_search_edit(HttpSession session, Model model, HttpServletRequest request,
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

		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_transaction_search_edit.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_transaction_search")
	@GetMapping
	public String pvlmd_transaction_search(HttpSession session, Model model, HttpServletRequest request,
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

		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_transaction_search.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_deletion_request")
	@GetMapping
	public String pvlmd_deletion_request(HttpSession session, Model model, HttpServletRequest request,
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

		try {

            String web_response = null;
			//JSONObject obj = new JSONObject();
			//Gson googleJson = new Gson();

			web_response = cls_maps.select_pvlmd_deletion_count(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
				
			System.out.println(web_response);

			JSONObject web_response_obj = new JSONObject(web_response); 
            Integer parcel_delete_request_count = web_response_obj.getInt("parcel_delete_request_count");
            Integer parcel_delete_approved_count = web_response_obj.getInt("parcel_delete_approved_count");
            Integer transaction_delete_request_count = web_response_obj.getInt("transaction_delete_request_count");
            Integer transaction_delete_approved_count = web_response_obj.getInt("transaction_delete_approved_count");

			request.setAttribute("parcel_delete_request_count",parcel_delete_request_count);
            request.setAttribute("parcel_delete_approved_count",parcel_delete_approved_count);
            request.setAttribute("transaction_delete_request_count",transaction_delete_request_count);
            request.setAttribute("transaction_delete_approved_count", transaction_delete_approved_count);

			request.setAttribute("page_name", "pvlmd_deletion_request");
					model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_deletion_request.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;

	}

	@RequestMapping("/pvlmd_deletion_approval")
	@GetMapping
	public String pvlmd_deletion_approval(HttpSession session, Model model, HttpServletRequest request,
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

		try {

            String web_response = null;
			//JSONObject obj = new JSONObject();
			//Gson googleJson = new Gson();

			web_response = cls_maps.select_pvlmd_deletion_count(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
				
			System.out.println(web_response);

			JSONObject web_response_obj = new JSONObject(web_response); 
            Integer parcel_delete_review_count = web_response_obj.getInt("parcel_delete_review_count");
            Integer transaction_delete_review_count = web_response_obj.getInt("transaction_delete_review_count");

			request.setAttribute("parcel_delete_review_count",parcel_delete_review_count);
            request.setAttribute("transaction_delete_review_count",transaction_delete_review_count);

			request.setAttribute("page_name", "pvlmd_deletion_approval");
					model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_deletion_approval.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;

		// request.setAttribute("page_name", "pvlmd_deletion_approval");
		// 		model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_deletion_approval.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_deletion_review")
	@GetMapping
	public String pvlmd_deletion_review(HttpSession session, Model model, HttpServletRequest request,
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

		try {

            String web_response = null;
			//JSONObject obj = new JSONObject();
			//Gson googleJson = new Gson();

			web_response = cls_maps.select_pvlmd_deletion_count(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
				
			System.out.println(web_response);

			JSONObject web_response_obj = new JSONObject(web_response); 
            Integer parcel_delete_request_count = web_response_obj.getInt("parcel_delete_request_count");
            Integer parcel_delete_approved_count = web_response_obj.getInt("parcel_delete_approved_count");
            Integer transaction_delete_request_count = web_response_obj.getInt("transaction_delete_request_count");
            Integer transaction_delete_approved_count = web_response_obj.getInt("transaction_delete_approved_count");

			request.setAttribute("parcel_delete_request_count",parcel_delete_request_count);
            request.setAttribute("parcel_delete_approved_count",parcel_delete_approved_count);
            request.setAttribute("transaction_delete_request_count",transaction_delete_request_count);
            request.setAttribute("transaction_delete_approved_count", transaction_delete_approved_count);

			request.setAttribute("page_name", "pvlmd_deletion_review");
					model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_deletion_review.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;

		// request.setAttribute("page_name", "pvlmd_deletion_approval");
		// 		model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_deletion_approval.jsp"); return "layouts/app";

	}

	@RequestMapping("/pvlmd_deletion_report")
	@GetMapping
	public String pvlmd_deletion_report(HttpSession session, Model model, HttpServletRequest request,
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

		try {

            String web_response = null;
			//JSONObject obj = new JSONObject();
			//Gson googleJson = new Gson();

			web_response = cls_maps.select_pvlmd_deletion_count(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
				
			System.out.println(web_response);

			JSONObject web_response_obj = new JSONObject(web_response); 
            Integer parcel_deleted_count = web_response_obj.getInt("parcel_deleted_count");
            Integer transaction_deleted_count = web_response_obj.getInt("transaction_deleted_count");

			request.setAttribute("parcel_deleted_count",parcel_deleted_count);
            request.setAttribute("transaction_deleted_count",transaction_deleted_count);

			request.setAttribute("page_name", "pvlmd_deletion_report");
					model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_deletion_report.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;

		// request.setAttribute("page_name", "pvlmd_deletion_approval");
		// 		model.addAttribute("content", "../pages/pvlmd_maps_templates/pvlmd_deletion_approval.jsp"); return "layouts/app";

	}

}
