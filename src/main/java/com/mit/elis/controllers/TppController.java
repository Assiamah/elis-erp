package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import java.util.ArrayList;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;

@Controller
public class TppController {

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/tpp_coordinator_module")
	@GetMapping
	public String tpp_coordinator_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

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
			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				web_service_response_menu = casemgt_web_service
						.load_application_details_to_unit_tpp_cordinator(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("unit_id"));
				JSONObject menu_obj;

				menu_obj = new JSONObject(web_service_response_menu);
				String incoming = menu_obj.get("incoming").toString();
				String completed = menu_obj.get("completed").toString();
				String queried = menu_obj.get("queried").toString();
				String awaiting_tpp = menu_obj.get("awaiting_tpp").toString();
				String awaiting_signing = menu_obj.get("awaiting_signing").toString();

				String awaiting_scanning = menu_obj.get("awaiting_scanning").toString();
				/*
				 * String smd_remaining =
				 * menu_obj.get("smd_remaining").toString(); String
				 * lrd_remaining = menu_obj.get("lrd_remaining").toString();
				 * String pvlmd_remaining =
				 * menu_obj.get("pvlmd_remaining").toString();
				 */

				request.setAttribute("page_name", "title_plan_preparation");

				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("queried", queried);
				request.setAttribute("awaiting_tpp", awaiting_tpp);
				request.setAttribute("awaiting_signing", awaiting_signing);
				request.setAttribute("awaiting_scanning", awaiting_scanning);

				/*
				 * request.setAttribute("smd_remaining", smd_remaining);
				 * request.setAttribute("lrd_remaining", lrd_remaining);
				 * request.setAttribute("pvlmd_remaining", pvlmd_remaining);
				 */

						model.addAttribute("content", "../pages/title_plan_preparation/tpp_coordinator_module.jsp"); return "layouts/app";

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
		return null;

	}

	@RequestMapping("/tpp_divisional_supervisor_module")
	@GetMapping
	public String tpp_divisional_supervisor_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

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
			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				web_service_response_menu = casemgt_web_service
						.load_application_details_to_unit_tpp_supervisor(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("division"));
				JSONObject menu_obj;

				menu_obj = new JSONObject(web_service_response_menu);
				String incoming = menu_obj.get("incoming").toString();
				String completed = menu_obj.get("completed").toString();
				String queried = menu_obj.get("queried").toString();
				String awaiting_payments = menu_obj.get("awaiting_payments").toString();
				String awaiting_signing = menu_obj.get("awaiting_signing").toString();
				String awaiting_scanning = menu_obj.get("awaiting_scanning").toString();

				request.setAttribute("page_name", "title_plan_preparation");

				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("queried", queried);
				request.setAttribute("awaiting_payment", awaiting_payments);
				request.setAttribute("awaiting_signing", awaiting_signing);
				request.setAttribute("awaiting_scanning", awaiting_scanning);

						model.addAttribute("content", "../pages/title_plan_preparation/tpp_divisional_supervisor_module.jsp"); return "layouts/app";

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
		return null;

	}

	@RequestMapping("/tpp_sealing_scanning_module")
	@GetMapping
	public String tpp_sealing_scanning_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

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
			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				web_service_response_menu = casemgt_web_service
						.load_application_details_to_unit_tpp_supervisor(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("division"));
				JSONObject menu_obj;

				menu_obj = new JSONObject(web_service_response_menu);
				String incoming = menu_obj.get("incoming").toString();
				String completed = menu_obj.get("completed").toString();
				String queried = menu_obj.get("queried").toString();
				String awaiting_payments = menu_obj.get("awaiting_payments").toString();
				String awaiting_signing = menu_obj.get("awaiting_signing").toString();
				String awaiting_scanning = menu_obj.get("awaiting_scanning").toString();

				request.setAttribute("page_name", "title_plan_preparation");

				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("queried", queried);
				request.setAttribute("awaiting_payment", awaiting_payments);
				request.setAttribute("awaiting_signing", awaiting_signing);
				request.setAttribute("awaiting_scanning", awaiting_scanning);

						model.addAttribute("content", "../pages/title_plan_preparation/tpp_sealing_scanning_module.jsp"); return "layouts/app";

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
		return null;

	}

	@RequestMapping("/tpp_signing_module")
	@GetMapping
	public String tpp_signing_module(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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
			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				web_service_response_menu = casemgt_web_service
						.load_application_details_to_unit_tpp_supervisor(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("division"));
				JSONObject menu_obj;

				menu_obj = new JSONObject(web_service_response_menu);
				String incoming = menu_obj.get("incoming").toString();
				String completed = menu_obj.get("completed").toString();
				String queried = menu_obj.get("queried").toString();
				String awaiting_payments = menu_obj.get("awaiting_payments").toString();
				String awaiting_signing = menu_obj.get("awaiting_signing").toString();
				String awaiting_scanning = menu_obj.get("awaiting_scanning").toString();

				request.setAttribute("page_name", "title_plan_preparation");

				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("queried", queried);
				request.setAttribute("awaiting_payment", awaiting_payments);
				request.setAttribute("awaiting_signing", awaiting_signing);
				request.setAttribute("awaiting_scanning", awaiting_scanning);

						model.addAttribute("content", "../pages/title_plan_preparation/tpp_signing_module.jsp"); return "layouts/app";

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
		return null;

	}

	@RequestMapping("/tpp_staff_module")
	@GetMapping
	public String tpp_staff_module(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

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

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				web_service_response_menu = casemgt_web_service
						.load_application_batched_to_user_tpp_staff(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));
				System.out.println(web_service_response_menu);
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				// request.setAttribute("applicationlistcount", all_menus);
				request.setAttribute("page_name", "title_plan_preparation");

				request.setAttribute("applicationlist", javaArrayListFromGSON);
						model.addAttribute("content", "../pages/title_plan_preparation/tpp_staff_module.jsp"); return "layouts/app";

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
		return null;

	}


	@RequestMapping("/create_job_number")
	@GetMapping
	public String create_job_number(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

					model.addAttribute("content", "../pages/transitional_templates/create_job_number.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

}
