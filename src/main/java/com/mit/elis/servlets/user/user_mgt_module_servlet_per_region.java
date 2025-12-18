package com.mit.elis.servlets.user;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import ws.users.Ws_users;

/**
 * Servlet implementation class regional_number
 */
@Controller
// @WebServlet(urlPatterns = { "/user_mgt_module_servlet_per_region" })
public class user_mgt_module_servlet_per_region extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/user_mgt_module_servlet_per_region00z1")
	@PostMapping
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			RequestDispatcher view = request.getRequestDispatcher("index.jsp");
			view.forward(request, response);

		}

		try {

			HttpSession session = request.getSession();

			String servletName = request.getServletPath();
			servletName = servletName.replace("/", "");
			String assigenedmenus = (String) session.getAttribute("menus_com");
			boolean isFound = false;
			try {
				isFound = assigenedmenus.contains(servletName); // true
			} catch (Exception e) {
			}

			// Log User out if the user tries to access right not assigned
			if (!isFound) {
				request.setAttribute("login", "Please this is not alllowed");
				//
				RequestDispatcher view = request.getRequestDispatcher("index.jsp");
				view.forward(request, response);
			}
			Ws_users user_web_service = new Ws_users();

			String web_service_response = null;

			if ((String) session.getAttribute("regional_code") != null
					&& (String) session.getAttribute("regional_code") != "") {

				JSONObject obj_rc = new JSONObject();

				obj_rc.put("region_code", (String) session.getAttribute("regional_code"));

				// obj.put("case_number", case_number);

				// String input_details = obj.toString();

				web_service_response = user_web_service.get_list_of_users_per_region(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj_rc.toString());
				JSONObject users_obj;
				users_obj = new JSONObject(web_service_response);
				String all_users = users_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_users, ArrayList.class);
				request.setAttribute("users_list", javaArrayListFromGSON);
				request.setAttribute("page_name", "user_management");

				RequestDispatcher rd = request.getRequestDispatcher("/user_management/user_mgt_module_per_region.jsp");
				rd.include(request, response);
			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);

	}

}
