package com.mit.elis.servlets;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_business_process;
import ws.casemgt.cls_casemgt;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class business_process {
	@Autowired
	private Ws_url_config cls_url_config;
	cls_business_process business_process_cl = new cls_business_process();

	@RequestMapping("/business_process")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String web_service_response = null;
		String business_process_id = request.getParameter("business_process_id");
		// obj.put( "userid" , userid );
		System.out.println(business_process_id);

		web_service_response = business_process_cl
				.select_business_processes_sub_list(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), business_process_id);
		if (web_service_response != null) {
			System.out.println(web_service_response);
		} else {
			System.out.println(web_service_response);
		}

		return web_service_response;
	}
}
