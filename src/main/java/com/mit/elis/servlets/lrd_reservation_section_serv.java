package com.mit.elis.servlets;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ws.casemgt.cls_lrd_reservation_section;

import java.io.File;
import java.util.ArrayList;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;

@RestController
public class lrd_reservation_section_serv {

    cls_lrd_reservation_section lrd_reservation_section_cl = new cls_lrd_reservation_section();
    
    @Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/lrd_reservation_section_serv")
	@PostMapping
	public String lrd_certificate_section_serv(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");

			String web_service_response = null;

			System.out.println(request_type);

			// if (request_type.equals("select_lrd_certificate_section_all_by_case_number")) {
			// 	String case_number = request.getParameter("case_number");
			// 	// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),case_number);
			// 	web_service_response = lrd_reservation_section_cl
			// 			.select_lrd_certificate_section_all_by_case_number(cls_url_config.getWeb_service_url_ser(),
			// 					cls_url_config.getWeb_service_url_ser_api_key(),
			// 					case_number);
			// 	if (web_service_response != null) {
			// 		// System.out.println(web_service_response);
			// 	} else {
			// 		System.out.println(web_service_response);
			// 	}

			// }

			// if (request_type.equals("select_lrd_certificate_section_all_by_id")) {
			// 	String case_number = request.getParameter("c_id");
			// 	// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),case_number);
			// 	web_service_response = lrd_certificate_section_cl
			// 			.select_lrd_certificate_section_all_by_id(cls_url_config.getWeb_service_url_ser(),
			// 					cls_url_config.getWeb_service_url_ser_api_key(), case_number);
			// 	if (web_service_response != null) {
			// 		// System.out.println(web_service_response);
			// 	} else {
			// 		System.out.println(web_service_response);
			// 	}

			// }

			if (request_type.equals("select_lrd_reservation_section_add_and_update")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String rs_id = request.getParameter("rs_id") == "" ? "0" : request.getParameter("rs_id");
                Integer rs_idd = Integer.valueOf(rs_id.replace(".0", ""));
				String case_number = request.getParameter("rs_case_number");
				String reservation_description = request.getParameter("rs_reservation_description");
				//String modified_by = request.getParameter("modified_by");
				//String modified_by_id = request.getParameter("modified_by_id");
                String modified_by = (String) session.getAttribute("fullname");
			    String modified_by_id = (String) session.getAttribute("userid");

				obj.put("rs_id", rs_idd);
				obj.put("case_number", case_number);
				obj.put("reservation_description", reservation_description);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),input);
				web_service_response = lrd_reservation_section_cl
						.select_lrd_reservation_section_add_and_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			// if (request_type.equals("select_lrd_certificate_section_all_by_id")) {

			// 	/*
			// 	 * JSONArray jsonArr = new JSONArray(); JSONObject obj = new
			// 	 * JSONObject();
			// 	 */

			// 	String cs_id = request.getParameter("cs_id");

			// 	/*
			// 	 * obj.put( "cs_id",cs_id );
			// 	 * 
			// 	 * 
			// 	 * jsonArr.put(obj); String input = jsonArr.toString();
			// 	 */
			// 	// System.out.println(cs_id);
			// 	web_service_response = lrd_certificate_section_cl
			// 			.select_lrd_certificate_section_add_and_update(cls_url_config.getWeb_service_url_ser(),
			// 					cls_url_config.getWeb_service_url_ser_api_key(), cs_id);
			// 	if (web_service_response != null) {
			// 		// System.out.println(web_service_response);
			// 	} else {
			// 		System.out.println(web_service_response);
			// 	}
			// }

			return web_service_response;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
