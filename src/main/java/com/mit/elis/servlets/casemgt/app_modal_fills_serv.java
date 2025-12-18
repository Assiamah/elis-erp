package com.mit.elis.servlets.casemgt;

import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import ws.casemgt.cls_lc_case_query;
import ws.setup.Ws_region;
import ws.users.Ws_users;

@RestController

public class app_modal_fills_serv {
	cls_lc_case_query lc_case_query_cl = new cls_lc_case_query();
	Ws_client_application user_web_service = new Ws_client_application();
	cls_casemgt casemgt_cl = new cls_casemgt();
	Ws_region region_cl = new Ws_region();
	Ws_users cls_users = new Ws_users();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/app_modal_fills_serv")
	@PostMapping
	public String app_modal_fills_serv_fill(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}
		// HttpSession session = request.getSession();
		String web_service_response = null;
		try {
			String request_type = request.getParameter("request_type");

			System.out.println(request_type);

			// session.setAttribute("office_region_list", all_list_office_region);
			// session.setAttribute("division_list", all_list_division_list);
			// session.setAttribute("region_list", all_list_region_list);

			if (request_type.equals("get_all_office_region")) {
				String office_region_list = (String) session.getAttribute("office_region_list");
				web_service_response = office_region_list;
			}

			if (request_type.equals("get_divisions_get_list")) {
				String division_list = (String) session.getAttribute("division_list");
				web_service_response = division_list;
			}

			if (request_type.equals("get_region_list")) {
				String region_list = (String) session.getAttribute("region_list");
				web_service_response = region_list;
			}

			if (request_type.equals("get_all_users_short")) {
				String get_all_users_short = (String) session.getAttribute("get_all_users_short");
				web_service_response = get_all_users_short;
			}

			if (request_type.equals("get_all_users_short_call")) {
				String get_all_users_short = cls_users.get_all_users_short(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				web_service_response = get_all_users_short;
				// session.setAttribute("get_all_users_short", web_service_response_all_users);
			}

			if (request_type.equals("get_gender_list")) {
				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				web_service_response = get_gender_list;
				// session.setAttribute("get_all_users_short", web_service_response_all_users);
			}

			if (request_type.equals("get_region_list_1")) {
				String get_gender_list = user_web_service.get_list_of_region(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				web_service_response = get_gender_list;
			}

			if (request_type.equals("tags_for_batching_jobs_list")) {
				String tags_for_batching_jobs_list = (String) session.getAttribute("tags_for_batching_jobs_list");
				web_service_response = tags_for_batching_jobs_list;
			}

			if (request_type.equals("get_all_office_region_old")) {

				String jsonArrayContent = user_web_service
						.select_lc_office_regions_districts(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());

				JSONObject sub_service_obj = new JSONObject(jsonArrayContent);
				String all_list = sub_service_obj.get("data").toString();

				// Gson googleJson = new Gson();
				// ArrayList javaArrayListFromGSON = googleJson.fromJson(all_list,
				// ArrayList.class);
				// request.setAttribute("data_row", javaArrayListFromGSON);
				web_service_response = all_list;

				// System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("get_divisions_get_list_old")) {

				String jsonArrayContent = casemgt_cl
						.divisions_get_list(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());
				// System.out.println(jsonArrayContent);

				JSONObject sub_service_obj = new JSONObject(jsonArrayContent);
				String all_list = sub_service_obj.get("data").toString();
				web_service_response = all_list;

				// System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("get_region_list_old")) {

				String jsonArrayContent = casemgt_cl
						.get_region_list(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());
				// System.out.println("new get_region_list");
				// System.out.println(jsonArrayContent);

				JSONObject sub_service_obj = new JSONObject(jsonArrayContent);
				String all_list = sub_service_obj.get("data").toString();
				web_service_response = all_list;

				// System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("get_list_of_designation")) {

				String jsonArrayContent = user_web_service
						.get_list_of_designation(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());
				// System.out.println(jsonArrayContent);

				// JSONObject sub_service_obj = new JSONObject(jsonArrayContent);
				// String all_list = sub_service_obj.get("data").toString();

				// Gson googleJson = new Gson();
				// ArrayList javaArrayListFromGSON = googleJson.fromJson(all_list,
				// ArrayList.class);
				// request.setAttribute("data_row", javaArrayListFromGSON);
				web_service_response = jsonArrayContent;

				// System.out.println(web_service_response);
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

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

				obj.put("qid", qid);
				obj.put("job_number", job_number);

				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

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

			if (request_type.equals("get_locality_list")) {

				String region_id = request.getParameter("region_code");
				JSONObject obj_s = new JSONObject();
				obj_s.put("region_code", region_id);
				String locality_list = user_web_service.get_locality_by_region(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj_s.toString());

				JSONObject jsonobj_locality = new JSONObject(locality_list);
				web_service_response = (String) jsonobj_locality.getString("data");
				// Gson googleJson_locality = new Gson();
				// ArrayList javaArrayListFromGSON_locality =
				// googleJson_locality.fromJson(locality_list,
				// ArrayList.class);
				// request.setAttribute("localitylist", javaArrayListFromGSON_locality);

				// System.out.println(web_service_response);
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
		return web_service_response;
	}
}
