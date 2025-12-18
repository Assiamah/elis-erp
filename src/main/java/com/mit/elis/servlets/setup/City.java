package com.mit.elis.servlets.setup;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import ws.setup.Ws_city;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class City {
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/City")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		try {
			String request_type = request.getParameter("request_type");
			String web_service_response = null;
			JSONObject obj_r = new JSONObject();
			JSONArray jsonArr = new JSONArray();
			JSONObject obj = new JSONObject();

			// System.out.println(request_type);

			if (request_type.equals("add")) {
				String city_name = request.getParameter("city_name");

				obj.put("city_name", city_name);
				jsonArr.put(obj);
				String input = jsonArr.toString();
				// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),input);
				web_service_response = Ws_city.city_add(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("update")) {
				String religion_id = request.getParameter("city_id");
				String religion_name = request.getParameter("city_name");

				obj.put("city_id", religion_id);
				obj.put("city_name", religion_name);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),input);
				web_service_response = Ws_city.city_update(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("delete")) {
				String city_id = request.getParameter("city_id");
				// obj.put( "userid" , userid );
				// System.out.println(city_id);
				web_service_response = Ws_city.city_delete(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), city_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("get_all")) {

				String search_by = request.getParameter("search_by");
				// System.out.println(search_by);
				// web_service_response
				// =Ws_city.get_list_of_users_division(search_by);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			return web_service_response;

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}
}
