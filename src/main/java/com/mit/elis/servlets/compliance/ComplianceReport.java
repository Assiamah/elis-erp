package com.mit.elis.servlets.compliance;

import org.codehaus.jettison.json.JSONObject;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.compliance.ws_compliance;
import java.io.File;
import java.util.ArrayList;
import org.springframework.ui.Model;
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

public class ComplianceReport {
	ws_compliance cls_compliance = new ws_compliance();

	@Autowired
	private Ws_url_config cls_url_config;

	// @RequestMapping("/report_dashboard_all")
	@RequestMapping("/ComplianceReport")

	@PostMapping
	public String report_dashboard_all(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");

			// HttpSession session = request.getSession();
			String region_id = (String) (request.getParameter("region_id") != null
					? request.getParameter("region_id")
					: (String) session.getAttribute("regional_code"));

			// System.out.println(String.format("Log level: %s",
			// request.getParameter("request_type")));

			String web_service_response = null;

			if (request_type.equals("report_dashboard_all")) {

				JSONObject obj = new JSONObject();
				obj.put("region_id", region_id);
				String input_details = obj.toString();
				// System.out.println(input_details + " Started @ : " + new java.util.Date());
				web_service_response = cls_compliance.report_dashboard_all_post(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
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
