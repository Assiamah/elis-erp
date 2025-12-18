package com.mit.elis.servlets.csaumgt;

import java.io.File;
import java.io.PrintWriter;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ws.csaumgt.ws_csaumgt;
import java.io.File;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class csau_mgt_serv {
	ws_csaumgt csaumgt_cl = new ws_csaumgt();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/csau_mgt_serv")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		// System.out.println("How are you");
		String web_service_response = null;

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {
			String request_type = request.getParameter("request_type");

			// System.out.println(request_type);

			if (request_type.equals("select_portal_users_add_update")) {
				String cl_first_name = request.getParameter("cl_first_name");
				String cl_other_names = request.getParameter("cl_other_names");
				String cl_last_name = request.getParameter("cl_last_name");
				String cl_gender = request.getParameter("cl_gender");
				String cl_tin = request.getParameter("cl_tin");
				String cl_id_type = request.getParameter("cl_id_type");
				String cl_id_number = request.getParameter("cl_id_number");
				String cl_contact_person = request.getParameter("cl_contact_person");
				String cl_contact_person_phone = request.getParameter("cl_contact_person_phone");

				String cl_email = request.getParameter("cl_email");
				String cl_country = request.getParameter("cl_country");
				String cl_address = request.getParameter("cl_address");
				String cl_phone = request.getParameter("cl_phone");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

String fullname =  (String) session.getAttribute("fullname");
String userid =  (String) session.getAttribute("userid");

				JSONObject obj_d = new JSONObject();

				obj_d.put("email", cl_email);
				obj_d.put("password", "12345678");
				obj_d.put("type", "Individual");
				obj_d.put("first_name", cl_first_name);
				obj_d.put("other_names", cl_other_names);
				obj_d.put("last_name", cl_last_name);

				obj_d.put("gender", cl_gender);
				obj_d.put("address", cl_address);
				obj_d.put("tin", cl_tin);
				obj_d.put("id_type", cl_id_type);
				obj_d.put("id_number", cl_id_number);

				obj_d.put("contact_person", cl_contact_person);
				obj_d.put("contact_person_phone", cl_contact_person_phone);

				obj_d.put("phone", cl_phone);
				obj_d.put("created", "CREATED");
				obj_d.put("status", "created");
				obj_d.put("country", cl_country);
				obj_d.put("industry", "Individual");
				obj_d.put("registration_no", "");
				obj_d.put("subscription_paid", "0");
				obj_d.put("subscription_due", "0");
				obj_d.put("document_attached", "0");
				obj_d.put("company", "0");
				obj_d.put("account_number", "0");
				obj_d.put("fullname", fullname);
				obj_d.put("userid", userid); 
				obj_d.put("mac_address", mac_address); obj_d.put("ip_address", ip_address);

				// System.out.println(cl_first_name + "-" + cl_other_names + ""
				// + cl_last_name);
				// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj_d.toString());

				web_service_response = csaumgt_cl
						.select_portal_users_add_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_portal_users_by_email")) {
				String search_by = request.getParameter("search_by");
				// System.out.println(polygon);

				JSONObject obj_d = new JSONObject();
				obj_d.put("email", search_by);

				web_service_response = csaumgt_cl.select_portal_users_by_email(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());

				// System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}
			

			if (request_type.equals("select_portal_users_by_job_number")) {
				String search_by = request.getParameter("search_by");
				// System.out.println(polygon);

				JSONObject obj_d = new JSONObject();
				obj_d.put("job_number", search_by);

				web_service_response = csaumgt_cl.select_portal_users_by_job_number(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());

				// System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			return web_service_response;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// PrintWriter out = response.getWriter();
		// out.println("<p>Hello World!</p>");

		return web_service_response;
	}
}
