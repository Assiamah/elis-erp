package com.mit.elis.servlets.strata;

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
import ws.rentmgt.Ws_rent_mgt;

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
public class strata_mgt_serv {
	Ws_rent_mgt rent_mgt_cl = new Ws_rent_mgt();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/strata_mgt_serv")
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

			System.out.println(request_type);

			if (request_type.equals("select_rt_govt_estates_get_wkt")) {
				String ge_id = request.getParameter("ge_id");
				JSONObject obj_d = new JSONObject();

				obj_d.put("ge_id", ge_id);
				System.out.println(obj_d.toString());
				web_service_response = rent_mgt_cl
						.select_rt_govt_estates_get_wkt(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
	
			}

			if (request_type.equals("select_prepare_rent_demand_notice_single")) {
				
				System.out.println("dddddddd");
				String ge_id = request.getParameter("rdn_rent_id");
				JSONObject obj_d = new JSONObject();

				obj_d.put("rl_id", ge_id);
				System.out.println(obj_d.toString());
				web_service_response = rent_mgt_cl
						.select_prepare_rent_demand_notice_single(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
			
								System.out.println("web_service_response");
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

		// PrintWriter out = response.getWriter();
		// out.println("<p>Hello World!</p>");

		return web_service_response;
	}
}
