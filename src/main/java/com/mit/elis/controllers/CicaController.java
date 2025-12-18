package com.mit.elis.controllers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import org.springframework.ui.Model;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.mit.elis.class_common.Ws_url_config;

import ws.casemgt.cls_casemgt;
import ws.cica.cica_docs;
import ws.cica.ws_cica;

@Controller
public class CicaController {
    
    @Autowired
	private Ws_url_config cls_url_config;

    ServletRequest servletContext;

	cls_casemgt casemagt_cl = new cls_casemgt();
	ws_cica cls_cica = new ws_cica();
    cica_docs cls_cica_docs = new cica_docs();

    @RequestMapping("/cica_complaints")
	@GetMapping
	public String cica_complaints(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

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

		//Gson googleJson = new Gson();
		try {

					model.addAttribute("content", "../pages/CICA/cica_complaints.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/cica_dashboard")
	@GetMapping
	public String cica_dashboard(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

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

		//Gson googleJson = new Gson();
		try {

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(
					office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

					model.addAttribute("content", "../pages/CICA/cica_dashboard.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/cica_enquiries")
	@GetMapping
	public String cica_enquiries(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

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

		//Gson googleJson = new Gson();
		try {

            // JSONObject obj =new JSONObject();
			// obj.put("type","enquiry");

			// String web_service_response = cls_cica.load_counts(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

            // System.out.println(web_service_response);
            // JSONObject web_response_obj = new JSONObject(web_service_response); 
            // Integer open = web_response_obj.getInt("open");
            // Integer archived = web_response_obj.getInt("resolved");

            // request.setAttribute("open",open);
            // request.setAttribute("archived",archived);

					model.addAttribute("content", "../pages/CICA/cica_enquiries.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/cica_focal_person")
	@GetMapping
	public String cica_focal_person(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

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

		//Gson googleJson = new Gson();
		try {

            String regional_code = (String) session.getAttribute("regional_code");
			String division = (String) session.getAttribute("division");
			
			JSONObject obj =new JSONObject();
			
			obj.put("division",division);
			obj.put("regional_code",regional_code);

			String web_service_response = cls_cica.load_focal_person_counts(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

            System.out.println(web_service_response);
            JSONObject web_response_obj = new JSONObject(web_service_response); 
            Integer incoming = web_response_obj.getInt("incoming");
            Integer outgoing = web_response_obj.getInt("outgoing");
            
            request.setAttribute("incoming",incoming);
            request.setAttribute("outgoing", outgoing);

					model.addAttribute("content", "../pages/CICA/cica_focal_person.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/cica_focal_person_post")
	@PostMapping
	public String cica_focal_person_post(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String web_response = null;
			JSONObject obj = new JSONObject();
			Gson googleJson = new Gson();
			//JSONObject obj_r = new JSONObject();
			String request_type =request.getParameter("request_type");

			if (request_type.equals("load_ticket_details")) {

				String ticket_id =request.getParameter("ticket_id");
				String ticket_no =request.getParameter("ticket_no");
				
				session.setAttribute("view_by", 0);
				session.setAttribute("update_status", "d-none");
				session.setAttribute("move_to", "d-block");
                session.setAttribute("print_request", "d-block");
				session.setAttribute("cica_route", "cica_focal_person");
				session.setAttribute("add_reply", "d-block");
				session.setAttribute("edit_ticket", "d-none");
				
				obj.put("ticket_id", new Double(ticket_id).intValue());
				obj.put("ticket_no", ticket_no);

				web_response = cls_cica.load_ticket_details(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String ticket_details = web_response_case.get("data").toString(); 

				ArrayList ticket_details_list = googleJson.fromJson(ticket_details, ArrayList.class);
				request.setAttribute("ticket_details",ticket_details_list);

						model.addAttribute("content", "../pages/CICA/cica_ticket_details.jsp"); return "layouts/app";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/cica_replies")
	@GetMapping
	public String cica_replies(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

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

		//Gson googleJson = new Gson();
		try {

            String regional_code = (String) session.getAttribute("regional_code");
			String division = (String) session.getAttribute("division");
			
			JSONObject obj =new JSONObject();
			
			obj.put("division",division);
			obj.put("regional_code",regional_code);

			String web_service_response = cls_cica.load_replies_counts(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

            System.out.println(web_service_response);
            JSONObject web_response_obj = new JSONObject(web_service_response); 
            Integer replies = web_response_obj.getInt("replies");
		 	Integer archived = web_response_obj.getInt("archived");
		 	
            request.setAttribute("replies",replies);
            request.setAttribute("archived", archived);

					model.addAttribute("content", "../pages/CICA/cica_replies.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/cica_replies_post")
	@PostMapping
	public String cica_replies_post(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String web_response = null;
			JSONObject obj = new JSONObject();
			Gson googleJson = new Gson();
			//JSONObject obj_r = new JSONObject();
			String request_type =request.getParameter("request_type");

			if (request_type.equals("load_ticket_details")) {

				String ticket_id =request.getParameter("ticket_id");
				String ticket_no =request.getParameter("ticket_no");
				
				// session.setAttribute("view_by", 0);
				// session.setAttribute("update_status", "d-none");
				// session.setAttribute("cica_route", "cica_focal_person");
				
				obj.put("ticket_id", new Double(ticket_id).intValue());
				obj.put("ticket_no", ticket_no);

				web_response = cls_cica.load_ticket_details(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String ticket_details = web_response_case.get("data").toString(); 

				ArrayList ticket_details_list = googleJson.fromJson(ticket_details, ArrayList.class);
				request.setAttribute("ticket_details",ticket_details_list);

						model.addAttribute("content", "../pages/CICA/cica_reply_details.jsp"); return "layouts/app";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/cica_tickets")
	@GetMapping
	public String cica_tickets(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

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

		//Gson googleJson = new Gson();
		try {

            String regional_code=(String) session.getAttribute("regional_code");
			JSONObject obj =new JSONObject();

			obj.put("type","tickets");
			obj.put("regional_code",regional_code);

			String web_service_response = cls_cica.load_counts(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

            System.out.println(web_service_response);
            JSONObject web_response_obj = new JSONObject(web_service_response); 
            Integer open = web_response_obj.getInt("open");
            Integer hold = web_response_obj.getInt("hold");
            Integer pending = web_response_obj.getInt("pending");
            Integer resolved = web_response_obj.getInt("resolved");
            
            request.setAttribute("open",open);
            request.setAttribute("hold",hold);
            request.setAttribute("pending",pending);
            request.setAttribute("resolved", resolved);

					model.addAttribute("content", "../pages/CICA/cica_tickets.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

	@RequestMapping("/cica_tickets_no_login")
	@GetMapping
	public String cica_tickets_no_login(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        // String servletName = request.getServletPath();
		// servletName = servletName.replace("/", "");
		// String assigenedmenus = (String) session.getAttribute("menus_com");
		// boolean isFound = false;
		// try {
		// 	isFound = assigenedmenus.contains(servletName); // true
		// } catch (Exception e) {
		// }

        // if (!isFound) {
		// 	request.setAttribute("login", "Please this is not alllowed");
		// 	//
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		// }

		// if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
		// 	// Session is expired
		// 	request.setAttribute("login", "sessionout");
		// 	System.out.println("If Not success");
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		// }

		//Gson googleJson = new Gson();
		try {

            String regional_code=(String) session.getAttribute("regional_code");
			JSONObject obj =new JSONObject();

			obj.put("type","tickets");
			obj.put("regional_code",11);

			String web_service_response = cls_cica.load_counts(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

            System.out.println(web_service_response);
            JSONObject web_response_obj = new JSONObject(web_service_response); 
            Integer open = web_response_obj.getInt("open");
            Integer hold = web_response_obj.getInt("hold");
            Integer pending = web_response_obj.getInt("pending");
            Integer resolved = web_response_obj.getInt("resolved");
            
            request.setAttribute("open",open);
            request.setAttribute("hold",hold);
            request.setAttribute("pending",pending);
            request.setAttribute("resolved", resolved);

					model.addAttribute("content", "../pages/CICA/cica_tickets.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/cica_tickets_post")
	@PostMapping
	public String cica_tickets_post(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String web_response = null;
			JSONObject obj = new JSONObject();
			Gson googleJson = new Gson();
			//JSONObject obj_r = new JSONObject();
			String request_type =request.getParameter("request_type");

			if (request_type.equals("load_ticket_details")) {

				String ticket_id =request.getParameter("ticket_id");
				String ticket_no =request.getParameter("ticket_no");
				
				session.setAttribute("view_by", 1);
				session.setAttribute("update_status", "d-block");
				session.setAttribute("move_to", "d-none");
                session.setAttribute("print_request", "d-none");
				session.setAttribute("cica_route", "cica_tickets");
				session.setAttribute("add_reply", "d-block");
				session.setAttribute("edit_ticket", "d-none");
				
				obj.put("ticket_id", new Double(ticket_id).intValue());
				obj.put("ticket_no", ticket_no);

				web_response = cls_cica.load_ticket_details(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String ticket_details = web_response_case.get("data").toString(); 

				ArrayList ticket_details_list = googleJson.fromJson(ticket_details, ArrayList.class);
				request.setAttribute("ticket_details",ticket_details_list);

						model.addAttribute("content", "../pages/CICA/cica_ticket_details.jsp"); return "layouts/app";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/cica_clients")
	@GetMapping
	public String cica_clients(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

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

		//Gson googleJson = new Gson();
		try {

					model.addAttribute("content", "../pages/CICA/clients.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/complaint")
	@GetMapping
	public String complaint(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

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

		//Gson googleJson = new Gson();
		try {

					model.addAttribute("content", "../pages/CICA/complaint.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/enquiry")
	@GetMapping
	public String enquiry(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

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

		//Gson googleJson = new Gson();
		try {

					model.addAttribute("content", "../pages/CICA/enquiry.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }


	@RequestMapping("/cica_enquiry_details")
	@PostMapping
	public String cica_enquiry_details(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String web_response = null;
			JSONObject obj = new JSONObject();
			Gson googleJson = new Gson();
			//JSONObject obj_r = new JSONObject();
			String request_type =request.getParameter("request_type");

			if (request_type.equals("load_ticket_details")) {

				String ticket_id =request.getParameter("ticket_id");
				String ticket_no =request.getParameter("ticket_no");
				
				session.setAttribute("view_by", 1);
				session.setAttribute("update_status", "d-none");
				session.setAttribute("move_to", "d-none");
                session.setAttribute("print_request", "d-none");
				session.setAttribute("cica_route", "cica_enquiries");
				session.setAttribute("add_reply", "d-none");
				session.setAttribute("edit_ticket", "d-block");
				
				obj.put("ticket_id", new Double(ticket_id).intValue());
				obj.put("ticket_no", ticket_no);

				web_response = cls_cica.load_ticket_details(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String ticket_details = web_response_case.get("data").toString(); 

				ArrayList ticket_details_list = googleJson.fromJson(ticket_details, ArrayList.class);
				request.setAttribute("ticket_details",ticket_details_list);

						model.addAttribute("content", "../pages/CICA/cica_ticket_details.jsp"); return "layouts/app";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }
}
