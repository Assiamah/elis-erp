package com.mit.elis.servlets;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ws.casemgt.cls_lrd_memorials_section;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class lrd_memorials_section_serv {
	cls_lrd_memorials_section lrd_memorials_section_cl = new cls_lrd_memorials_section();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/lrd_memorials_section_serv")
	@PostMapping
	public String lrd_memorials_section_serv(HttpSession session, Model model, HttpServletRequest request,
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

			if (request_type.equals("select_lrd_memorials_section_all_by_case_number")) {
				String case_number = request.getParameter("case_number");
				// System.out.println("Assiamah");
				System.out.println(case_number);
				web_service_response = lrd_memorials_section_cl
						.select_lrd_memorials_section_all_by_case_number(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								case_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lrd_memorials_section_all_by_id")) {
				String case_number = request.getParameter("case_number");
				// System.out.println("Assiamah");
				System.out.println(case_number);
				web_service_response = lrd_memorials_section_cl
						.select_lrd_memorials_section_all_by_id(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), case_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lrd_memorials_section_add_and_update")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String mid = request.getParameter("mid");
				String case_number = request.getParameter("m_case_number");
				String m_registered_no = request.getParameter("m_registered_no");
				String m_memorials = request.getParameter("m_memorials");
				String m_date_of_instrument = request.getParameter("m_date_of_instrument");
				String m_date_of_registration = request.getParameter("m_date_of_registration");
				String m_back = request.getParameter("m_back");
				String m_forward = request.getParameter("m_forward");
				String m_remarks = request.getParameter("m_remarks");
				String modified_by = request.getParameter("modified_by");
				String modified_by_id = request.getParameter("modified_by_id");
				String m_entry_number =  request.getParameter("m_entry_number");

				obj.put("mid", mid);
				obj.put("case_number", case_number);
				obj.put("m_registered_no", m_registered_no);
				obj.put("m_memorials", m_memorials);
				obj.put("m_date_of_instrument", m_date_of_instrument);
				obj.put("m_date_of_registration", m_date_of_registration);
				obj.put("m_back", m_back);
				obj.put("m_forward", m_forward);
				obj.put("m_remarks", m_remarks);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("m_entry_number", m_entry_number);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				System.out.println(input);
				web_service_response = lrd_memorials_section_cl
						.select_lrd_memorials_section_add_and_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("select_lrd_memorials_section_mother_registered_no")) {
				String case_number = request.getParameter("case_number");
				// System.out.println("Assiamah");
				System.out.println(case_number);
				web_service_response = lrd_memorials_section_cl
						.select_lrd_memorials_section_mother_registered_no(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), case_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			return web_service_response;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
