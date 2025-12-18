package com.mit.elis.servlets;

import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ws.users.Ws_users;
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
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FileMovement {
	Ws_users cls_users = new Ws_users();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/FileMovement")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		// System.out.println(userName + password);
		String web_service_response = null;

		web_service_response = cls_users.checkUser(cls_url_config.getWeb_service_url_ser(),
				cls_url_config.getWeb_service_url_ser_api_key(), userName, password);
		// JSONObject obj = new JSONObject();
		// System.out.println(web_service_response);
		try {
			if (web_service_response != null) {
				System.out.println(web_service_response);
			} else {
				/*
				 * obj_r.put( "success" , false ); obj_r.put( "msg" ,
				 * "Error Delete User.';" );
				 */
				System.out.println(web_service_response);
			}
			// System.out.println(web_service_response);
			JSONObject obj = new JSONObject(web_service_response);
			// String pageName = obj.get("data").toString();

			JSONArray arr = obj.getJSONArray("data");
			for (int i = 0; i < arr.length(); i++) {
				String fullname = arr.getJSONObject(i).getString("fullname");
				// System.out.println(fullname);
				request.setAttribute("jjson", fullname);
			}

			String web_service_response_menu = null;
			web_service_response_menu = cls_users.get_all_dashboard_menu(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject menu_obj = new JSONObject(web_service_response_menu);
			String all_menus = menu_obj.get("data").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
			request.setAttribute("menus", javaArrayListFromGSON);
			// System.out.println(pageName);

			// //HttpSession session = request.getSession();
			// session.setAttribute("username", userName);

			/*
			 * //setting session to expiry in 30 mins
			 * session.setMaxInactiveInterval(30*60); Cookie user_Name = new
			 * Cookie("user", userName); response.addCookie(user_Name);
			 */

			return "/mainpage/main_dashboard.jsp";
			// RequestDispatcher view =
			// request.getRequestDispatcher("main_dashboard.jsp";

			// }
			// else
			// {
			// out.println("Username or Password incorrect");
			// RequestDispatcher rs =
			// request.getRequestDispatcher("index.html");
			// rs.include(request, response);
			// }
			//
			//
			// return web_service_response;
			// } catch (JSONException e) {

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return web_service_response;

		// $result['success'] = true; // #15
		// $result['msg'] = 'User authenticated!'; // #16
		// doGet(request, response);
	}

}
