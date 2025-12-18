package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import java.util.ArrayList;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.users.Ws_users;

@Controller
public class LoginController {

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/user_mgt_module_per_region00z1")
	@GetMapping
	public String user_mgt_module_per_region(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			// HttpSession session = request.getSession();

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
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}
			Ws_users user_web_service = new Ws_users();

			String web_service_response = null;

			if ((String) session.getAttribute("regional_code") != null
					&& (String) session.getAttribute("regional_code") != "") {

				JSONObject obj_rc = new JSONObject();

				obj_rc.put("region_code", (String) session.getAttribute("regional_code"));

				// obj.put("case_number", case_number);

				// String input_details = obj.toString();

				web_service_response = user_web_service
						.get_list_of_users_per_region(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_rc.toString());
				JSONObject users_obj;
				users_obj = new JSONObject(web_service_response);
				String all_users = users_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_users, ArrayList.class);
				request.setAttribute("users_list", javaArrayListFromGSON);

				request.setAttribute("page_name", "user_management");

						model.addAttribute("content", "../pages/user_management/user_mgt_module_per_region.jsp"); return "layouts/app";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("/user_mgt_module00z1")
	@GetMapping
	public String user_mgt_module(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			// HttpSession session = request.getSession();

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
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}
			Ws_users user_web_service = new Ws_users();

			String web_service_response = null;
			web_service_response = user_web_service.get_list_of_users(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject users_obj;
			users_obj = new JSONObject(web_service_response);
			String all_users = users_obj.get("data").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_users, ArrayList.class);
			request.setAttribute("users_list", javaArrayListFromGSON);
			request.setAttribute("page_name", "user_management");

					model.addAttribute("content", "../pages/user_management/user_mgt_module.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	Ws_users cls_users = new Ws_users();

	@RequestMapping("/Add_Update_User")
	@PostMapping
	public String Add_Update_User(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		// HttpSession session = request.getSession();

		try {
			String request_type = request.getParameter("request_type");
			String web_service_response = null;
			JSONObject obj_r = new JSONObject();
			JSONArray jsonArr = new JSONArray();
			JSONObject obj = new JSONObject();

			// System.out.println(request_type);

			if (request_type.equals("add")) {
				//// System.out.println("assmahfgf");

				/*
				 * String createdby = (String) session.getAttribute("fullname");
				 * String createddatetime =
				 * request.getParameter("createddatetime");
				 */
				// String modified_by = (String)
				// session.getAttribute("fullname");
				// String modified_by_id = (String)
				// session.getAttribute("userid");

				// String websiteaddress =
				// request.getParameter("websiteaddress");

				// String locality = request.getParameter("locality");

				String userid = request.getParameter("userid");
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				String fullname = request.getParameter("fullname");
				String userprofile = request.getParameter("userprofile");
				String isdisabled = request.getParameter("isdisabled");
				String canpasswordexpire = request.getParameter("canpasswordexpire");
				String passwordexpirydate = request.getParameter("passwordexpirydate");
				String passwordchanged = request.getParameter("passwordchanged");
				String staffnumber = request.getParameter("staffnumber");
				String title = request.getParameter("title");
				String designation = request.getParameter("designation");
				String division = request.getParameter("division");
				String emailaddress = request.getParameter("emailaddress");
				String address = request.getParameter("address");
				String phone = request.getParameter("phone");
				String mobile = request.getParameter("mobile");
				String user_level = request.getParameter("user_level");

				String department_id = request.getParameter("department_id");
				String department_name = request.getParameter("department_name");
				String district_code = request.getParameter("district_code");
				String district_name = request.getParameter("district_name");
				String region = request.getParameter("region");
				String region_id = request.getParameter("region_id");
				String view_all_offices = request.getParameter("view_all_offices");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				//String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				//String userid = (String) session.getAttribute("userid");

				obj.put("userid", userid);
				obj.put("username", username);
				obj.put("password", password);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userprofile", userprofile);
				obj.put("isdisabled", isdisabled);
				obj.put("canpasswordexpire", canpasswordexpire);
				obj.put("passwordexpirydate", passwordexpirydate);
				obj.put("passwordchanged", passwordchanged);
				obj.put("staffnumber", staffnumber);
				obj.put("title", title);
				obj.put("designation", designation);
				obj.put("division", division);
				obj.put("address", address);
				obj.put("phone", phone);
				obj.put("mobile", mobile);
				obj.put("emailaddress", emailaddress);
				obj.put("user_level", user_level);
				obj.put("view_all_offices", view_all_offices);
				obj.put("department_id", department_id);
				obj.put("department_name", department_name);
				obj.put("district_code", district_code);
				obj.put("district_name", district_name);
				obj.put("region", region);
				obj.put("region_id", region_id);
				obj.put("created_by", modified_by);
				obj.put("created_by_id", modified_by_id);

				jsonArr.put(obj);

				// System.out.println("Add User params: " + jsonArr.toString());
				web_service_response = cls_users.add_new_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						jsonArr.toString());
				if (web_service_response != null) {
					obj_r.put("success", true);
					obj_r.put("msg", "User Saved!");
					// System.out.println(obj_r.toString());
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Saving User.';");
				}

			}

			if (request_type.equals("update")) {
				String userid = request.getParameter("userid");
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				String fullname = request.getParameter("fullname");
				String userprofile = request.getParameter("userprofile");
				String isdisabled = request.getParameter("isdisabled");
				String canpasswordexpire = request.getParameter("canpasswordexpire");
				String passwordvaliditydays = request.getParameter("passwordvaliditydays");
				String passwordexpirydate = request.getParameter("passwordexpirydate");
				String createdby = request.getParameter("createdby");
				String createddatetime = request.getParameter("createddatetime");
				String compid = request.getParameter("compid");

				String passwordchanged = request.getParameter("passwordchanged");
				String staffnumber = request.getParameter("staffnumber");
				String loglocation = request.getParameter("loglocation");
				String logstatus = request.getParameter("logstatus");
				String title = request.getParameter("title");
				String designation = request.getParameter("designation");

				String division = request.getParameter("division");
				String address = request.getParameter("address");
				String phone = request.getParameter("phone");
				String mobile = request.getParameter("mobile");
				String websiteaddress = request.getParameter("websiteaddress");
				String emailaddress = request.getParameter("emailaddress");

				String department = request.getParameter("department");
				String locality = request.getParameter("locality");
				String district = request.getParameter("district");
				String region = request.getParameter("region");
				String view_all_offices = request.getParameter("view_all_offices");
				 String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				

				obj.put("userid", userid);
				obj.put("username", username);
				obj.put("password", password);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userprofile", userprofile);
				obj.put("isdisabled", isdisabled);
				obj.put("canpasswordexpire", canpasswordexpire);
				obj.put("passwordvaliditydays", passwordvaliditydays);
				obj.put("passwordexpirydate", passwordexpirydate);
				obj.put("passwordchanged", passwordchanged);
				obj.put("staffnumber", staffnumber);
				obj.put("title", title);
				obj.put("designation", designation);
				obj.put("division", division);
				obj.put("address", address);
				obj.put("phone", phone);
				obj.put("mobile", mobile);
				obj.put("websiteaddress", websiteaddress);
				obj.put("emailaddress", emailaddress);
				obj.put("department", department);
				obj.put("location", locality);
				obj.put("district", district);
				obj.put("region", region);
				obj.put("view_all_offices", view_all_offices);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = cls_users.update_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					obj_r.put("success", true);
					obj_r.put("msg", "User Saved!");
					// System.out.println(obj_r.toString());
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Saving User.';");
				}
			}

			if (request_type.equals("delete")) {
				String userid = request.getParameter("userid");
				// obj.put( "userid" , userid );
				// System.out.println(userid);
				web_service_response = cls_users.delete_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), userid);
				if (web_service_response != null) {
					obj_r.put("success", true);
					obj_r.put("msg", "User Saved!");
					// System.out.println(obj_r.toString());
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Delete User.';");
				}
			}

			if (request_type.equals("update_user_profile")) {
				String profile_list = request.getParameter("profile_list");
				String userid = request.getParameter("userid");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

				obj.put("userid", userid);
				obj.put("profile_list", profile_list);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);

				jsonArr.put(obj);
				String input = obj.toString();
				// System.out.println(input);
				// System.out.println(user_profile);
				web_service_response = cls_users
						.select_update_user_profile_per_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					obj_r.put("success", true);
					obj_r.put("msg", web_service_response);
					// System.out.println(obj_r.toString());
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Delete User.';");
				}
			}

			if (request_type.equals("get_user_profile_per_user")) {
				String userid = request.getParameter("userid");
				// String user_profile = request.getParameter("user_profile");
				obj.put("userid", userid);
				// obj.put("user_profile", user_profile);

				jsonArr.put(obj);
				String input = jsonArr.toString();
				// System.out.println(input);
				// System.out.println(user_profile);
				web_service_response = cls_users.user_profile_for_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), userid);
				if (web_service_response != null) {
					obj_r.put("success", true);
					obj_r.put("msg", "User Saved!");
					// System.out.println(obj_r.toString());
					// System.out.println(web_service_response.toString());
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Delete User.';");
				}
			}

			if (request_type.equals("get_all")) {

				String search_by = request.getParameter("search_by");
				// System.out.println(search_by);
				web_service_response = cls_users.get_list_of_users_division(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						search_by);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					/*
					 * obj_r.put( "success" , false ); obj_r.put( "msg" ,
					 * "Error Delete User.';" );
					 */
				}
			}
			// PrintWriter out = response.getWriter();
			// out.println(web_service_response);
			return web_service_response;
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

}
 