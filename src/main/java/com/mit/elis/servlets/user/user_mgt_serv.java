package com.mit.elis.servlets.user;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import ws.users.Ws_users;

@RestController
// @WebServlet(urlPatterns = { "/user_mgt_serv" })
public class user_mgt_serv extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Autowired
	private Ws_url_config cls_url_config;

	Ws_users cls_users = new Ws_users();

	@RequestMapping("/user_mgt_serv")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			RequestDispatcher view = request.getRequestDispatcher("index.jsp");
			view.forward(request, response);

		}

		String web_service_response = null;
		try {
			String request_type = request.getParameter("request_type");

			JSONObject obj_r = new JSONObject();
			JSONArray jsonArr = new JSONArray();
			JSONObject obj = new JSONObject();

			// System.out.println(request_type);

			if (request_type.equals("add")) {
				//// System.out.println("assmahfgf");

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
				String usr_access_level = request.getParameter("usr_access_level");
				String district = request.getParameter("district");
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
				obj.put("usr_access_level", usr_access_level);
				obj.put("view_all_offices", view_all_offices);
				obj.put("department_id", department_id);
				obj.put("department_name", department_name);
				obj.put("district_code", district_code);
				obj.put("district_name", district_name);
				obj.put("district", district);
				obj.put("region", region);
				obj.put("region_id", region_id);
				obj.put("created_by", modified_by);
				obj.put("created_by_id", modified_by_id);

				jsonArr.put(obj);

				System.out.println("Add User params: " + jsonArr.toString());
				web_service_response = cls_users.add_new_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), jsonArr.toString());
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
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

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
				web_service_response = cls_users.select_update_user_profile_per_user(
						cls_url_config.getWeb_service_url_ser(),
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

			
			if (request_type.equals("update_user_milestone")) {
				String profile_list = request.getParameter("profile_list");
				String userid = request.getParameter("userid");
				// String main_service_id = request.getParameter("main_service_id");
				// String sub_service_id = request.getParameter("sub_service_id");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");

				obj.put("userid", userid);
				obj.put("profile_list", profile_list);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				// obj.put("main_service_id", main_service_id);
				// obj.put("sub_service_id", sub_service_id);

				jsonArr.put(obj);
				String input = obj.toString();
				// System.out.println(input);
				// System.out.println(user_profile);
				web_service_response = cls_users.select_update_user_milestone_per_user(
						cls_url_config.getWeb_service_url_ser(),
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

				
			if (request_type.equals("select_lc_milestone_per_user")) {
				String userid = request.getParameter("userid");
				String main_service_id = request.getParameter("main_service_id");
				String sub_service_id = request.getParameter("sub_service_id");

				obj.put("userid", userid);
				obj.put("main_service_id", main_service_id);
				obj.put("sub_service_id", sub_service_id);
				// obj.put("user_profile", user_profile);

				jsonArr.put(obj);
				String input = jsonArr.toString();
				System.out.println(obj.toString());
				// System.out.println(user_profile);
				web_service_response = cls_users.select_lc_milestone_per_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
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
						cls_url_config.getWeb_service_url_ser_api_key(), search_by);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					/*
					 * obj_r.put( "success" , false ); obj_r.put( "msg" ,
					 * "Error Delete User.';" );
					 */
				}
			}

			if (request_type.equals("corp_add")) {
				//// System.out.println("assmahfgf");

				String userid = request.getParameter("userid");
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				String fullname = request.getParameter("fullname");
				//String userprofile = request.getParameter("userprofile");
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
				String org_name = request.getParameter("org_name");

				// String department_id = request.getParameter("department_id");
				// String department_name = request.getParameter("department_name");
				// String district_code = request.getParameter("district_code");
				// String district_name = request.getParameter("district_name");
				// String region = request.getParameter("region");
				// String region_id = request.getParameter("region_id");
				// String view_all_offices = request.getParameter("view_all_offices");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				//String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				//String userid = (String) session.getAttribute("userid");

				obj.put("userid", userid);
				obj.put("username", username);
				obj.put("password", password);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				//obj.put("userprofile", userprofile);
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
				obj.put("org_name", org_name);
				// obj.put("view_all_offices", view_all_offices);
				// obj.put("department_id", department_id);
				// obj.put("department_name", department_name);
				// obj.put("district_code", district_code);
				// obj.put("district_name", district_name);
				// obj.put("region", region);
				// obj.put("region_id", region_id);
				obj.put("created_by", modified_by);
				obj.put("created_by_id", modified_by_id);

				jsonArr.put(obj);

				// System.out.println("Add User params: " + jsonArr.toString());
				web_service_response = cls_users.corp_add_new_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), jsonArr.toString());
				if (web_service_response != null) {
					obj_r.put("success", true);
					obj_r.put("msg", "User Saved!");
					// System.out.println(obj_r.toString());
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Saving User.';");
				}

			}

			if (request_type.equals("corp_acc_add")) {
				//// System.out.println("assmahfgf");

				String org_id = request.getParameter("org_id");
				// String username = request.getParameter("username");
				// String password = request.getParameter("password");
				String fullname = request.getParameter("fullname");
				//String userprofile = request.getParameter("userprofile");
				// String isdisabled = request.getParameter("isdisabled");
				// String canpasswordexpire = request.getParameter("canpasswordexpire");
				// String passwordexpirydate = request.getParameter("passwordexpirydate");
				// String passwordchanged = request.getParameter("passwordchanged");
				//String staffnumber = request.getParameter("staffnumber");
				String registration_no = request.getParameter("registration_no");
				String subscription_due = request.getParameter("subscription_due");
				String industry = request.getParameter("industry");
				String emailaddress = request.getParameter("emailaddress");
				String address = request.getParameter("address");
				String phone = request.getParameter("phone");
				String mobile = request.getParameter("mobile");
				//String user_level = request.getParameter("user_level");
				String subscription_paid = request.getParameter("subscription_paid");
				String contact_person_phone = request.getParameter("contact_person_phone");
				String contact_person_name = request.getParameter("contact_person_name");
				String good_standing = request.getParameter("good_standing");
				String account_number = request.getParameter("account_number");

				// String department_id = request.getParameter("department_id");
				// String department_name = request.getParameter("department_name");
				// String district_code = request.getParameter("district_code");
				// String district_name = request.getParameter("district_name");
				// String region = request.getParameter("region");
				// String region_id = request.getParameter("region_id");
				// String view_all_offices = request.getParameter("view_all_offices");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				obj.put("org_id", org_id);
				// obj.put("username", username);
				// obj.put("password", password);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("contact_person_phone", contact_person_phone);
				// obj.put("isdisabled", isdisabled);
				// obj.put("canpasswordexpire", canpasswordexpire);
				// obj.put("passwordexpirydate", passwordexpirydate);
				// obj.put("passwordchanged", passwordchanged);
				obj.put("subscription_paid", subscription_paid);
				obj.put("subscription_due", subscription_due);
				obj.put("registration_no", registration_no);
				obj.put("contact_person_name", contact_person_name);
				obj.put("address", address);
				obj.put("phone", phone);
				obj.put("mobile", mobile);
				obj.put("industry", industry);
				obj.put("emailaddress", emailaddress);
				//obj.put("user_level", user_level);
				obj.put("account_number", account_number);
				obj.put("good_standing", good_standing);
				obj.put("created_by", modified_by);
				obj.put("created_by_id", modified_by_id);

				jsonArr.put(obj);

				// System.out.println("Add User params: " + jsonArr.toString());
				web_service_response = cls_users.corp_update_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), jsonArr.toString());

					System.out.println(jsonArr.toString());
					System.out.println(web_service_response);
				if (web_service_response != null) {
					obj_r.put("success", true);
					obj_r.put("msg", "User Saved!");
					// System.out.println(obj_r.toString());
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Saving User.';");
				}

			}

			if (request_type.equals("select_corporate_users_by_org")) {
				//// System.out.println("assmahfgf");

				String corp_id = request.getParameter("corp_id");

				obj.put("corp_id", corp_id);

				jsonArr.put(obj);

				System.out.println("Add User params: " + jsonArr.toString());
				web_service_response = cls_users.select_corporate_portal_sub_users_all_by_org(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), corp_id);
				if (web_service_response != null) {
					obj_r.put("success", true);
					obj_r.put("msg", "User Saved!");
					// System.out.println(obj_r.toString());
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Saving User.';");
				}

			}
			// PrintWriter out = response.getWriter();
			// out.println(web_service_response);
			return web_service_response;
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return web_service_response;

	}

}
