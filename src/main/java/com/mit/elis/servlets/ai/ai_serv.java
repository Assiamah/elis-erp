package com.mit.elis.servlets.ai;

import java.io.File;
import java.io.PrintWriter;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;

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

import ws.ai_api.Ws_ai_api;
import ws.casemgt.cls_casemgt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class ai_serv {
	Ws_ai_api ai_cl = new Ws_ai_api();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/ai_serv")
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

	     if (request_type.equals("send_agent_question")) {
               
                String query = (String) request.getParameter("query"); 
               System.out.println(query);
				JSONObject obj_d = new JSONObject();

                obj_d.put("user_question", query);
			

               System.out.println(obj_d.toString());

               web_service_response = ai_cl.select_ai_response(
               cls_url_config.getAi_api(),cls_url_config.getAi_api_key(),
               obj_d.toString());

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
