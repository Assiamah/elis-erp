package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
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
public class FrrvController {
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/frrv_coordinator_module")
	@GetMapping
	public String frrv_coordinator_module(HttpSession session, Model model, HttpServletRequest request,
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

				if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
					cls_casemgt casemgt_web_service = new cls_casemgt();
					String web_service_response_menu = null;

					web_service_response_menu = casemgt_web_service
							.load_application_details_to_unit_frrv_cordinator(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									(String) session.getAttribute("unit_id"));
					JSONObject menu_obj;

					menu_obj = new JSONObject(web_service_response_menu);
					String incoming = menu_obj.get("incoming").toString();
					String completed = menu_obj.get("completed").toString();
					String queried = menu_obj.get("queried").toString();
					String awaiting_payments = menu_obj.get("awaiting_payments").toString();

					String smd_remaining = menu_obj.get("smd_remaining").toString();
					String lrd_remaining = menu_obj.get("lrd_remaining").toString();
					String pvlmd_remaining = menu_obj.get("pvlmd_remaining").toString();

					request.setAttribute("page_name", "first_registration_record_verification");

					request.setAttribute("incoming", incoming);
					request.setAttribute("completed", completed);
					request.setAttribute("queried", queried);
					request.setAttribute("awaiting_payment", awaiting_payments);

					request.setAttribute("smd_remaining", smd_remaining);
					request.setAttribute("lrd_remaining", lrd_remaining);
					request.setAttribute("pvlmd_remaining", pvlmd_remaining);

							model.addAttribute("content", "../pages/frrv/frrv_coordinator_module.jsp"); return "layouts/app";

				} else {

					// Session is expired
					request.setAttribute("login", "sessionout");
					// System.out.println("If Not success");
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

	@RequestMapping("/frrv_divisional_supervisor_module")
	@GetMapping
	public String frrv_divisional_supervisor_module(HttpSession session, Model model, HttpServletRequest request,
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

			try {

				if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
					cls_casemgt casemgt_web_service = new cls_casemgt();
					String web_service_response_menu = null;

					web_service_response_menu = casemgt_web_service.load_application_details_to_unit_frrv_supervisor(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							(String) session.getAttribute("division"));
					JSONObject menu_obj;

					menu_obj = new JSONObject(web_service_response_menu);
					String incoming = menu_obj.get("incoming").toString();
					String completed = menu_obj.get("completed").toString();
					String queried = menu_obj.get("queried").toString();
					String awaiting_payments = menu_obj.get("awaiting_payments").toString();

					request.setAttribute("page_name", "first_registration_record_verification");

					request.setAttribute("incoming", incoming);
					request.setAttribute("completed", completed);
					request.setAttribute("queried", queried);
					request.setAttribute("awaiting_payment", awaiting_payments);
							model.addAttribute("content", "../pages/frrv/frrv_divisional_supervisor_module.jsp"); return "layouts/app";

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

	@RequestMapping("/frrv_staff_module")
	@GetMapping
	public String frrv_staff_module(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
							.load_application_batched_to_user_frrv_staff(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									(String) session.getAttribute("userid"));
					// System.out.println(web_service_response_menu);
					JSONObject menu_obj;
					menu_obj = new JSONObject(web_service_response_menu);
					String all_menus = menu_obj.get("data").toString();

					Gson googleJson = new Gson();
					ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
					// request.setAttribute("applicationlistcount", all_menus);
					request.setAttribute("page_name", "first_registration_record_verification");

					request.setAttribute("applicationlist", javaArrayListFromGSON);
							model.addAttribute("content", "../pages/frrv/frrv_staff_module.jsp"); return "layouts/app";

				} else {

					// Session is expired
					request.setAttribute("login", "sessionout");
					// System.out.println("If Not success");
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

}
