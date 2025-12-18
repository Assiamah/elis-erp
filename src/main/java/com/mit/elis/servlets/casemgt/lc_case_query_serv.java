package com.mit.elis.servlets.casemgt;

import java.io.File;

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
import ws.casemgt.cls_lc_case_query;
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
public class lc_case_query_serv {
	cls_lc_case_query lc_case_query_cl = new cls_lc_case_query();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/lc_case_query_serv")
	@PostMapping
	public String lc_case_query_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		// HttpSession session = request.getSession();

		try {
			String request_type = request.getParameter("request_type");

			String web_service_response = null;

			System.out.println(request_type);

			if (request_type.equals("select_lc_case_query_all_by_case_number")) {
				String case_number = request.getParameter("case_number");
				// System.out.println(case_number);
				web_service_response = lc_case_query_cl.select_lc_case_query_all_by_am_case_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						case_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lc_case_query_all_by_id")) {
				String case_number = request.getParameter("case_number");
				// System.out.println(case_number);
				web_service_response = lc_case_query_cl
						.select_lc_case_query_all_by_id(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), case_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lc_case_query_add_and_update")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String qid = request.getParameter("qid");
				String job_number = request.getParameter("job_number");
				String case_number = request.getParameter("case_number");
				String status = request.getParameter("status");
				String reasons = request.getParameter("reasons");
				String remarks = request.getParameter("remarks");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String unit_id = (String) session.getAttribute("unit_id");
				String unit_name = (String) session.getAttribute("unit_name");
				String query_attachment = request.getParameter("query_attachment");
				String query_general_reason = request.getParameter("query_general_reason");

				obj.put("qid", qid);
				obj.put("job_number", job_number);
				obj.put("case_number", case_number);
				obj.put("status", status);
				obj.put("reasons", reasons);
				obj.put("remarks", remarks);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("unit_id", unit_id);
				obj.put("unit_name", unit_name);
				obj.put("query_attachment", query_attachment);
				obj.put("query_general_reason", query_general_reason);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				System.out.println(input);
				web_service_response = lc_case_query_cl
						.select_lc_case_query_add_and_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
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
		return null;
	}
}
