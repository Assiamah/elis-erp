package com.mit.elis.servlets.user;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

@Controller
public class dashboard {
	cls_casemgt casemagt_cl = new cls_casemgt();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/dashboard")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {

		}

		/////System.out.println(assigenedmenus);
			////System.out.println(isFound);
			////System.out.println("servletName");
			////System.out.println(servletName);
		// Log User out if the user tries to access right not assigned
		
		// if (!isFound) {
		// 	request.setAttribute("login", "Please this is not alllowed");
		// 	//
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		// }
		// HttpSession session = request.getSession();

		try {

			String web_service_response = casemagt_cl
					.report_dashboard_all_by_user(cls_url_config.getReport_web_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							(String) session.getAttribute("userid"));
			JSONObject dash_obj = new JSONObject(web_service_response);

			String apps_rec_month = dash_obj.get("apps_rec_month").toString();
			String apps_comp_month = dash_obj.get("apps_comp_month").toString();
			String apps_rec_year = dash_obj.get("apps_rec_year").toString();
			String apps_comp_year = dash_obj.get("apps_comp_year").toString();
			String apps_past_due_dates = dash_obj.get("apps_past_due_dates").toString();
			String completion_rate = dash_obj.get("completion_rate").toString();
			String apps_with_user = dash_obj.get("apps_with_user").toString();
			String avg_turnaround_days = dash_obj.get("avg_turnaround_days").toString();
			String turnaround_target = dash_obj.get("turnaround_target").toString();
			String turnaround_performance = dash_obj.get("turnaround_performance").toString();
			String working_days = dash_obj.get("working_days").toString();
			String working_days_target = dash_obj.get("working_days_target").toString();
			String working_days_percentage = dash_obj.get("working_days_percentage").toString();
			String working_days_status = dash_obj.get("working_days_status").toString();

			request.setAttribute("working_days", working_days);
			request.setAttribute("working_days_target", working_days_target);
			request.setAttribute("working_days_percentage", working_days_percentage);
			request.setAttribute("working_days_status", working_days_status);
			request.setAttribute("apps_with_user", apps_with_user);
			request.setAttribute("avg_turnaround_days", avg_turnaround_days);
			request.setAttribute("turnaround_target", turnaround_target);
			request.setAttribute("turnaround_performance", turnaround_performance);
			request.setAttribute("apps_rec_month", apps_rec_month);
			request.setAttribute("apps_comp_month", apps_comp_month);
			request.setAttribute("apps_rec_year", apps_rec_year);
			request.setAttribute("apps_comp_year", apps_comp_year);
			request.setAttribute("apps_past_due_dates", apps_past_due_dates);
			request.setAttribute("completion_rate", completion_rate);

			//return "/mainpage/main_dashboard.jsp";
			// RequestDispatcher view =
			// request.getRequestDispatcher("main_dashboard.jsp";
			
			model.addAttribute("content", "../pages/mainpage/main_dashboard.jsp");
			return "layouts/app";

		} catch (

		Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

		// $result['success'] = true; // #15
		// $result['msg'] = 'User authenticated!'; // #16
		// doGet(request, response);
	}

	@RequestMapping("/dashboard2")
	@PostMapping
	public String doGet(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// HttpSession session = request.getSession();

		try {

			String web_service_response = casemagt_cl
					.report_dashboard_all_by_user(cls_url_config.getReport_web_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							(String) session.getAttribute("userid"));
			JSONObject dash_obj = new JSONObject(web_service_response);

			String apps_rec_month = dash_obj.get("apps_rec_month").toString();
			String apps_comp_month = dash_obj.get("apps_comp_month").toString();
			String apps_rec_year = dash_obj.get("apps_rec_year").toString();
			String apps_comp_year = dash_obj.get("apps_comp_year").toString();
			String apps_past_due_dates = dash_obj.get("apps_past_due_dates").toString();
			String completion_rate = dash_obj.get("completion_rate").toString();
			String apps_with_user = dash_obj.get("apps_with_user").toString();
			String avg_turnaround_days = dash_obj.get("avg_turnaround_days").toString();
			String turnaround_target = dash_obj.get("turnaround_target").toString();
			String turnaround_performance = dash_obj.get("turnaround_performance").toString();
			String working_days = dash_obj.get("working_days").toString();
			String working_days_target = dash_obj.get("working_days_target").toString();
			String working_days_percentage = dash_obj.get("working_days_percentage").toString();
			String working_days_status = dash_obj.get("working_days_status").toString();

			request.setAttribute("working_days", working_days);
			request.setAttribute("working_days_target", working_days_target);
			request.setAttribute("working_days_percentage", working_days_percentage);
			request.setAttribute("working_days_status", working_days_status);
			request.setAttribute("apps_with_user", apps_with_user);
			request.setAttribute("avg_turnaround_days", avg_turnaround_days);
			request.setAttribute("turnaround_target", turnaround_target);
			request.setAttribute("turnaround_performance", turnaround_performance);
			request.setAttribute("apps_rec_month", apps_rec_month);
			request.setAttribute("apps_comp_month", apps_comp_month);
			request.setAttribute("apps_rec_year", apps_rec_year);
			request.setAttribute("apps_comp_year", apps_comp_year);
			request.setAttribute("apps_past_due_dates", apps_past_due_dates);
			request.setAttribute("completion_rate", completion_rate);

			return "/mainpage/main_dashboard.jsp";
			// RequestDispatcher view =
			// request.getRequestDispatcher("main_dashboard.jsp";

		} catch (

		Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}


	@RequestMapping("/load_application_json")
	@PostMapping
	public String load_application_json(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {

		}

		/////System.out.println(assigenedmenus);
			////System.out.println(isFound);
			////System.out.println("servletName");
			////System.out.println(servletName);
		// Log User out if the user tries to access right not assigned
		
		// if (!isFound) {
		// 	request.setAttribute("login", "Please this is not alllowed");
		// 	//
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		// }
		// HttpSession session = request.getSession();

		try {
			
			model.addAttribute("content", "../pages/developer/load_application_json.jsp");
			return "layouts/app";

		} catch (

		Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

		// $result['success'] = true; // #15
		// $result['msg'] = 'User authenticated!'; // #16
		// doGet(request, response);
	}

	@RequestMapping("/live_monitoring")
	@PostMapping
	public String live_monitoring(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {

		}

		/////System.out.println(assigenedmenus);
			////System.out.println(isFound);
			////System.out.println("servletName");
			////System.out.println(servletName);
		// Log User out if the user tries to access right not assigned
		
		// if (!isFound) {
		// 	request.setAttribute("login", "Please this is not alllowed");
		// 	//
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		// }
		// HttpSession session = request.getSession();

		try {
			request.setAttribute("page_name", "live_monitoring");
			model.addAttribute("content", "../pages/developer/live_monitoring.jsp");
			return "layouts/app";

		} catch (

		Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

		// $result['success'] = true; // #15
		// $result['msg'] = 'User authenticated!'; // #16
		// doGet(request, response);
	}

	@RequestMapping("/load_application_gated_steps")
	@PostMapping
	public String load_application_gated_steps(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {

		}

		/////System.out.println(assigenedmenus);
			////System.out.println(isFound);
			////System.out.println("servletName");
			////System.out.println(servletName);
		// Log User out if the user tries to access right not assigned
		
		// if (!isFound) {
		// 	request.setAttribute("login", "Please this is not alllowed");
		// 	//
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		// }
		// HttpSession session = request.getSession();

		try {
			
			model.addAttribute("content", "../pages/developer/load_application_gated_steps.jsp");
			return "layouts/app";

		} catch (

		Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

		// $result['success'] = true; // #15
		// $result['msg'] = 'User authenticated!'; // #16
		// doGet(request, response);
	}
}
