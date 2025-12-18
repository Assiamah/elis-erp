package com.mit.elis.servlets.casemgt;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
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
import ws.casemgt.cls_licensed_surveyors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import org.springframework.beans.factory.annotation.Autowired;

@RestController
public class licensed_surveyors {
	cls_licensed_surveyors licensed_surveyors_cl = new cls_licensed_surveyors();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/licensed_surveyors")
	@PostMapping
	public String licensed_surveyors(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		String request_type = request.getParameter("request_type");

		String web_service_response = null;

		if (request_type.equals("search_by_surveyor_number")) {
			String surveyor_number = request.getParameter("surveyor_number");
			// System.out.println(parcel_id);
			web_service_response = licensed_surveyors_cl.online_smd_licensed_surveyors_list_by_number(
					cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
					surveyor_number);
			if (web_service_response != null) {
				System.out.println(web_service_response);
			} else {
				System.out.println(web_service_response);
			}

		}

		return web_service_response;
	}
}
