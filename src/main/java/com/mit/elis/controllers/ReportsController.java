package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;
import org.springframework.ui.Model;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;

@Controller
public class ReportsController {

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/manage_milestone")
	@GetMapping
	public String manage_milestone(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

	@RequestMapping("/manage_milestone_1")
	@GetMapping
	public String manage_milestone_1(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

	@RequestMapping("/manage_milestone2")
	@GetMapping
	public String manage_milestone_2(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

	@RequestMapping("/transactions_report")
	@GetMapping
	public String transactions_report(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
 
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
			try {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				// String web_service_response_menu_data = null;
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				LocalDateTime now = LocalDateTime.now();
				JSONObject obj = new JSONObject();

				if (request.getParameter("transactions_form") != null) {
					// System.out.println("good");
					request.setAttribute("active", "trans");
					String date_from = (String) request.getParameter("t_date_from") != null
							? request.getParameter("t_date_from")
							: dtf.format(now);
					String date_to = (String) request.getParameter("t_date_to") != null
							? request.getParameter("t_date_to")
							: dtf.format(now);

					String region_id = (String) (request.getParameter("t_region_id") != null
							? request.getParameter("t_region_id")
							: (String) session.getAttribute("regional_code"));
					String[] division = request.getParameterValues("t_division");
					String division_list = "";
					if (division != null) {
						for (String item : division) {
							division_list += item;
						}
					}

					// System.out.println("division: " + division_list);
					obj.put("date_from", date_from);
					obj.put("date_to", date_to);
					obj.put("division",
							division_list != "" ? division_list : (String) session.getAttribute("division"));
					obj.put("region_id", region_id.replace(".0", ""));
					System.out.println(obj.toString());
					web_service_response_menu = casemgt_web_service
							.account_report_on_bill_by_dates(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

					JSONObject result_obj = new JSONObject(web_service_response_menu);
					JSONObject summary = (JSONObject) result_obj.get("summary");
					String total_count = summary.get("total_count").toString();
					String total_amount = summary.get("total_amount").toString();
					String data = (String) result_obj.get("data").toString();
					// System.out.println("testing : " +
					// total_count.toString());
					Gson googleJson = new Gson();
					ArrayList<?> javaArrayListFromGSON = googleJson.fromJson(data, ArrayList.class);
					request.setAttribute("t_total_count", total_count);
					request.setAttribute("t_total_amount", total_amount);
					request.setAttribute("t_data", data);
					request.setAttribute("t_division",
							division_list != "" ? division_list : (String) session.getAttribute("division"));
					request.setAttribute("t_date_from", date_from);
					request.setAttribute("t_date_to", date_to);

					request.setAttribute("t_applicationlist", javaArrayListFromGSON);

				} else {
					String date_from = (String) request.getParameter("date_from") != null
							? request.getParameter("date_from")
							: dtf.format(now);
					String date_to = (String) request.getParameter("date_to") != null ? request.getParameter("date_to")
							: dtf.format(now);
					String limit = (String) (request.getParameter("limit") != null ? request.getParameter("limit")
							: "10");
					String type = (String) (request.getParameter("type") != null ? request.getParameter("type")
							: "values");
					String region_id = (String) (request.getParameter("region_id") != null
							? request.getParameter("region_id")
							: (String) session.getAttribute("regional_code"));
					String[] division = request.getParameterValues("division");
					String division_list = "";
					if (division != null) {
						for (String item : division) {
							division_list += item;
						}
					}

					// System.out.println("division: " + division_list);
					obj.put("date_from", date_from);
					obj.put("date_to", date_to);
					obj.put("limit", limit);
					obj.put("type", type);
					obj.put("division",
							division_list != "" ? division_list : (String) session.getAttribute("division"));
					obj.put("region_id", region_id.replace(".0", ""));
					System.out.println(obj.toString());
					web_service_response_menu = casemgt_web_service
							.account_report_on_bill_by_dates_graph(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

					JSONObject result_obj = new JSONObject(web_service_response_menu);
					JSONObject summary = (JSONObject) result_obj.get("summary"); 
					String total_count = summary.get("total_count").toString();
					String total_amount = summary.get("total_amount").toString();
					String data = (String) result_obj.get("data").toString();
					// System.out.println("testing : " +
					// total_count.toString());
					Gson googleJson = new Gson();
					ArrayList<?> javaArrayListFromGSON = googleJson.fromJson(data, ArrayList.class);
					request.setAttribute("total_count", total_count);
					request.setAttribute("total_amount", total_amount);
					request.setAttribute("data", data);
					request.setAttribute("division",
							division_list != "" ? division_list : (String) session.getAttribute("division"));
					request.setAttribute("date_from", date_from);
					request.setAttribute("date_to", date_to);
					request.setAttribute("limit", limit);
					request.setAttribute("type", type);
					request.setAttribute("active", "graph");

					request.setAttribute("applicationlist", javaArrayListFromGSON);

					String office_region_list = (String) session.getAttribute("office_region_list");
					Gson googleJson_officeregions = new Gson();
					ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(
							office_region_list,
							ArrayList.class);
					request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);
				}

				request.setAttribute("page_name", "account-reports");

			} catch (Exception e) {
				System.out.println("error : " + e);
				e.printStackTrace();
			}

					model.addAttribute("content", "../pages/account_reports/transaction_report.jsp"); return "layouts/app";

		} else {
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
	}

	@RequestMapping("/stamp_duty_payments_reports")
	@GetMapping
	public String stamp_duty_payments_reports(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
			try {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				String web_service_response_menu_data = null;
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				LocalDateTime now = LocalDateTime.now();
				JSONObject obj = new JSONObject();
				String date_from = (String) request.getParameter("date_from") != null
						? request.getParameter("date_from")
						: dtf.format(now);
				String date_to = (String) request.getParameter("date_to") != null ? request.getParameter("date_to")
						: dtf.format(now);
				String region_id = (String) (request.getParameter("region_id") != null
						? request.getParameter("region_id")
						: (String) session.getAttribute("regional_code"));
				// String type = (String) (request.getParameter("type") != null
				// ? request.getParameter("type") : "values");

				obj.put("date_from", date_from);
				obj.put("date_to", date_to);
				obj.put("region_id", region_id);
				// obj.put("type", type);
				// System.out.println("testing : " + (String) obj.toString());

				web_service_response_menu = casemgt_web_service
						.account_report_on_bill_by_dates_gra(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				// System.out.println("testing : " + web_service_response_menu);

				JSONObject result_obj = new JSONObject(web_service_response_menu);
				JSONObject summary = (JSONObject) result_obj.get("summary");
				String total_count = summary.get("total_count").toString();
				String total_amount = summary.get("total_amount").toString() != "null"
						? summary.get("total_amount").toString()
						: "0";
				String data = (String) result_obj.get("data").toString();
				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(data, ArrayList.class);
				request.setAttribute("total_count", total_count);
				request.setAttribute("total_amount", total_amount);
				request.setAttribute("data", javaArrayListFromGSON);
				request.setAttribute("date_from", date_from);
				request.setAttribute("date_to", date_to);
				// request.setAttribute("limit", limit);
				request.setAttribute("region_id", region_id);
				request.setAttribute("page_name", "account-reports-std");

				request.setAttribute("applicationlist", javaArrayListFromGSON);
			} catch (Exception e) {
				System.out.println("error : " + e);
				e.printStackTrace();
			}

					model.addAttribute("content", "../pages/account_reports/stamp_duty_payments_reports.jsp"); return "layouts/app";

		} else {
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
	}

	@RequestMapping("/reports")
	@GetMapping
	public String reports(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println(("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			// System.out.println(Ws_url_config.web_main_services);
			ArrayList javaArrayListFromGSON_sub_service = googleJson
					.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
			request.setAttribute("page_name", "reports");

			request.setAttribute("main_services", javaArrayListFromGSON_sub_service);
					model.addAttribute("content", "../pages/reports/reports.jsp"); return "layouts/app";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				model.addAttribute("content", "../pages/reports/reports.jsp"); return "layouts/app";
	}


	// @RequestMapping("/audit_report")
	// @GetMapping
	// public String audit_report(HttpSession session, Model model, HttpServletRequest request,
	// 		HttpServletResponse response) {
	// 	// HttpSession session = request.getSession();



	// 	String servletName = request.getServletPath();
	// 	servletName = servletName.replace("/", "");
	// 	String assigenedmenus = (String) session.getAttribute("menus_com");
	// 	boolean isFound = false;
	// 	try {
	// 		isFound = assigenedmenus.contains(servletName); // true
	// 	} catch (Exception e) {
	// 	}

	// 	// Log User out if the user tries to access right not assigned

	// 	if (!isFound) {
	// 		request.setAttribute("login", "Please this is not alllowed");
	// 		 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

	// 	}

	// 	if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
	// 		// Session is expired
	// 		request.setAttribute("login", "sessionout");
	// 		request.setAttribute("page_name", "audit_reports");
			
	// 		// System.out.println(("If Not success");
	// 		 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

	// 	}

	// 	Gson googleJson = new Gson();
	// 	try {

	// 		String office_region_list = (String) session.getAttribute("office_region_list");
	// 		Gson googleJson_officeregions = new Gson();
	// 		ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
	// 				ArrayList.class);
	// 		request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

	// 		// System.out.println(Ws_url_config.web_main_services);
	// 		ArrayList javaArrayListFromGSON_sub_service = googleJson
	// 				.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
	// 		request.setAttribute("page_name", "audit_reports");

	// 		request.setAttribute("main_services", javaArrayListFromGSON_sub_service);
	// 				model.addAttribute("content", "../pages/reports/audit_reports.jsp"); return "layouts/app";
	// 	} catch (Exception e) {
	// 		// TODO Auto-generated catch block
	// 		e.printStackTrace();
	// 	}
	// 			model.addAttribute("content", "../pages/reports/audit_reports.jsp"); return "layouts/app";
	// }

	@RequestMapping("/reports_stamping")
	@GetMapping
	public String reports_stamping(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println(("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			// System.out.println(Ws_url_config.web_main_services);
			ArrayList javaArrayListFromGSON_sub_service = googleJson
					.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
			request.setAttribute("page_name", "reports_stamping");

			request.setAttribute("main_services", javaArrayListFromGSON_sub_service);
					model.addAttribute("content", "../pages/reports/reports_stamping.jsp"); return "layouts/app";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				model.addAttribute("content", "../pages/reports/reports_stamping.jsp"); return "layouts/app";
	}

	@RequestMapping("/transactions_report_ground_rent")
	@GetMapping
	public String transactions_report_ground_rent(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
			try {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				// String web_service_response_menu_data = null;
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				LocalDateTime now = LocalDateTime.now();
				JSONObject obj = new JSONObject();

				// System.out.println("good");
				request.setAttribute("active", "trans");
				String date_from = (String) request.getParameter("t_date_from") != null
						? request.getParameter("t_date_from")
						: dtf.format(now);
				String date_to = (String) request.getParameter("t_date_to") != null ? request.getParameter("t_date_to")
						: dtf.format(now);

				String region_id = (String) (request.getParameter("t_region_id") != null
						? request.getParameter("t_region_id")
						: (String) session.getAttribute("regional_code"));
				/*
				 * String[] division = request.getParameterValues("t_division");
				 * String division_list = ""; if (division != null) { for
				 * (String item : division) { division_list += item; } }
				 */

				// System.out.println("division: " + division_list);
				obj.put("date_from", date_from);
				obj.put("date_to", date_to);
				/*
				 * obj.put("division", division_list != "" ? division_list :
				 * (String) session.getAttribute("division"));
				 */
				obj.put("region_id", region_id);
				// System.out.println(obj.toString());
				web_service_response_menu = casemgt_web_service
						.account_report_on_ground_rent_bill_by_dates(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								obj.toString());

				JSONObject result_obj = new JSONObject(web_service_response_menu);
				JSONObject summary = (JSONObject) result_obj.get("summary");
				String total_count = summary.get("total_count").toString();
				String total_amount = summary.get("total_amount").toString();
				String data = (String) result_obj.get("data").toString();
				// System.out.println("testing : " +
				// total_count.toString());
				Gson googleJson = new Gson();
				ArrayList<?> javaArrayListFromGSON = googleJson.fromJson(data, ArrayList.class);
				request.setAttribute("t_total_count", total_count);
				request.setAttribute("t_total_amount", total_amount);
				request.setAttribute("t_data", data);
				/*
				 * request.setAttribute("t_division", division_list != "" ?
				 * division_list : (String) session.getAttribute("division"));
				 */
				request.setAttribute("t_date_from", date_from);
				request.setAttribute("t_date_to", date_to);

				request.setAttribute("t_applicationlist", javaArrayListFromGSON);

				request.setAttribute("page_name", "account-reports-grand-rent");

			} catch (Exception e) {
				System.out.println("error : " + e);
				e.printStackTrace();
			}

					model.addAttribute("content", "../pages/account_reports/transaction_report_rent.jsp"); return "layouts/app";

		} else {
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
	}

}
