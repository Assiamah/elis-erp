package com.mit.elis.servlets.reports;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
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

@RestController

public class report_by_application_type {
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/report_by_application_type")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// doGet(request, response);

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
				Gson googleJson = new Gson();
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
					obj.put("region_id", region_id);
					// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());
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
					obj.put("region_id", region_id);
					// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());
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
				}
				ArrayList javaArrayListFromGSON_sub_service = googleJson
						.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
				request.setAttribute("main_services", javaArrayListFromGSON_sub_service);

				request.setAttribute("page_name", "reports_by_application_type");

			} catch (Exception e) {
				System.out.println("error : " + e);
				e.printStackTrace();
			}

			return "/reports/report_by_app_type.jsp";

		} else {
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
	}
}
