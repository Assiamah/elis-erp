package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;
import org.springframework.ui.Model;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import ws.maps.Ws_maps;

@Controller
public class LvdMapsController {

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/comparable_mgt")
	@GetMapping
	public String comparable_mgt(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		// HttpSession session = request.getSession();

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

		// System.out.println(isFound);
		// System.out.println(servletName);

		// Log User out if the user tries to access right not assigned
		if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		/*
		 * Ws_users user_web_service = new Ws_users();
		 * 
		 * String jsonArrayContent =null; jsonArrayContent
		 * =user_web_service.get_list_of_users();
		 * 
		 * 
		 * 
		 * Gson gson = new Gson(); List<Cls_users> list =
		 * gson.fromJson(jsonArrayContent, new
		 * TypeToken<List<Cls_users>>(){}.getType());
		 * 
		 * List<Cls_users> result=new ArrayList<Cls_users>(); JSONArray jArr;
		 * try { jArr = new JSONArray(jsonArrayContent); for (int i=0; i <
		 * jArr.length(); i++) { JSONObject jsonObject = jArr.getJSONObject(i);
		 * 
		 * String uid = (String) jsonObject.getString("uid"); String user_name =
		 * (String) jsonObject.getString("user_name"); String gender = (String)
		 * jsonObject.getString("gender"); String password = (String)
		 * jsonObject.getString("password");
		 * 
		 * Cls_users user = new Cls_users(); user.setUid(uid);
		 * user.setUser_name(user_name); user.setGender(gender);
		 * user.setPassword(password); result.add(user); } } catch
		 * (JSONException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 */

		// request.setAttribute("errorString", "Error on Page");
		// request.setAttribute("users_list", result);
		// request"/client_application/app_database_update.jsp").forward(request,
		// response);

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			Ws_maps cls_maps = new Ws_maps();
			String web_service_response_menu = null;
			web_service_response_menu = cls_maps
					.select_lvd_comparable_unapproved_all(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), "0");
			JSONObject menu_obj;
			menu_obj = new JSONObject(web_service_response_menu);
			String all_menus = menu_obj.get("data").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
			request.setAttribute("applicationlist", javaArrayListFromGSON);

			// request.setAttribute("page_name", "comparable");
			request.setAttribute("page_name", "case_processing");
					model.addAttribute("content", "../pages/client_application/comparable_mgt.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return assigenedmenus;

	}

	cls_casemgt casemgt_cl = new cls_casemgt();

	@RequestMapping("/maps_lvd_comparables")
	@GetMapping
	public String maps_lvd_comparables(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
	
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			Ws_maps cls_maps = new Ws_maps();
			String web_service_response_menu = null;
			web_service_response_menu = cls_maps
					.select_sp_parcels_lvd_location_list(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), "0");
			JSONObject menu_obj;
			menu_obj = new JSONObject(web_service_response_menu);
			String all_menus = menu_obj.get("data").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
			request.setAttribute("localitylist", javaArrayListFromGSON);

			// request.setAttribute("page_name", "comparable");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		request.setAttribute("page_name", "case_comparable");
				model.addAttribute("content", "../pages/client_application/maps_lvd_comparables.jsp"); return "layouts/app";

	}

	@RequestMapping("/lvd_compensation_map_1")
	@GetMapping
	public String lvd_compensation_map(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			Ws_maps cls_maps = new Ws_maps();
			String web_service_response_menu = null;
			web_service_response_menu = cls_maps
					.select_sp_parcels_lvd_location_list(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), "0");
			JSONObject menu_obj;
			menu_obj = new JSONObject(web_service_response_menu);
			String all_menus = menu_obj.get("data").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
			request.setAttribute("localitylist", javaArrayListFromGSON);

			// request.setAttribute("page_name", "comparable");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/lvd_compensation_maps/lvd_compensation_map.jsp"); return "layouts/app";

	}

}
