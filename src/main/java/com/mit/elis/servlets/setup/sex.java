package com.mit.elis.servlets.setup;

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
import ws.setup.Ws_sex;

import org.codehaus.jettison.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class sex {

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/sex")
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
				String sex_name = request.getParameter("sex_name");

				obj.put("sex_name", sex_name);
				jsonArr.put(obj);
				String input = jsonArr.toString();
				// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),input);
				web_service_response = Ws_sex.sex_add(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("update")) {
				String religion_id = request.getParameter("sex_id");
				String religion_name = request.getParameter("sex_name");

				obj.put("sex_id", religion_id);
				obj.put("sex_name", religion_name);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),input);
				web_service_response = Ws_sex.sex_update(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("delete")) {
				String sex_id = request.getParameter("sex_id");
				// obj.put( "userid" , userid );
				// System.out.println(sex_id);
				web_service_response = Ws_sex.sex_delete(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), sex_id);
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
				// =Ws_sex.get_list_of_users_division(search_by);
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
