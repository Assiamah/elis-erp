package com.mit.elis.servlets.user;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.mit.elis.services.SmtpMailService;
//import com.mit.elis.class_common.cls_sms;
import com.google.gson.Gson;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.warrenstrange.googleauth.GoogleAuthenticatorKey;
import com.warrenstrange.googleauth.GoogleAuthenticatorQRGenerator;

import ws.casemgt.ws_mail;
import ws.casemgt.ws_sms;
import ws.users.Ws_users;
import ws.ws_valueadded_services.cls_valueadded_services;

//import com.ws_casemgt.Ws_client_application;
//import com.ws_casemgt.cls_casemgt;
//import com.ws_casemgt.cls_general_query;

/**
 * Servlet implementation class Login
 */
// @WebServlet("/two_factor_verification")
@Controller
// @WebServlet(urlPatterns = { "/two_factor_verification" })
public class two_factor_verification extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Autowired
	private Ws_url_config cls_url_config;

	ws_sms sms_sl = new ws_sms();

	ws_mail mail_sl = new ws_mail();

	Ws_users cls_users = new Ws_users();
	cls_valueadded_services vas_cl = new cls_valueadded_services();


	@Autowired
	private SmtpMailService smtpMailService;

	// cls_casemgt casemagt_cl = new cls_casemgt();
	@RequestMapping("/two_factor_verification")
	@PostMapping
	public String two_factor_authentication(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		String userName = request.getParameter("email");
		String password = request.getParameter("password");
		// System.out.println(userName + password);
		String web_service_response = null;
		String new_userid = null;
		String vr_region_code = null;

		// code
		try {
// System.out.println(userName);
// System.out.println(password);
			web_service_response = vas_cl.select_user_for_two_factor_verification(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), userName, password);
					System.out.println(web_service_response);
			JSONObject obj_test = new JSONObject(web_service_response);
			String arr_login_response = obj_test.get("data").toString();
			String success_obj = obj_test.get("success").toString();
			String msg_obj = obj_test.get("msg").toString();

			String otp_enabled_obj = "";

			String verification_code_obj = "";

			if (msg_obj.equals("Success")) {
				verification_code_obj = obj_test.get("verification_code").toString();
				otp_enabled_obj = obj_test.get("otp_enabled").toString();
				session.setAttribute("verification_code", verification_code_obj);
				session.setAttribute("user", userName);
				session.setAttribute("pass", password);

				// Store passKey with expiry metadata
				Map<String, Object> passKeyData = new HashMap<>();
				passKeyData.put("value", userName);
				passKeyData.put("expiryTime", System.currentTimeMillis() + 10 * 60 * 1000); // 1 min from now

				session.setAttribute("passKey", passKeyData);

			} else {
				System.out.println("user verification error");
				request.setAttribute("login", "failed");
				  model.addAttribute("content", "../auth/login.jsp");
        return "layouts/guest";

			}

			// JSONObject obj = new JSONObject(web_service_response);
			// JSONArray arr = obj.getJSONArray("data");

			

			// for (int i = 0; i < arr.length(); i++) {
			// 	String passwordchanged = arr.getJSONObject(i).getString("passwordchanged");

			// 	if(passwordchanged.equals("No")) {
			// 		return "/change_password.jsp";
			// 	}
			// }


			if (arr_login_response != "null") {

				//System.out.println(verification_code_obj);

				JSONObject obj = new JSONObject(arr_login_response);
				new_userid = obj.get("userid").toString();
				String new_phone = obj.get("phone").toString();
				String emailaddress = obj.get("emailaddress").toString();
				String passwordchanged = obj.get("passwordchanged").toString();
				String fullName = obj.get("fullname").toString();
				String firstName = fullName.split(" ")[0];

				if(passwordchanged.equals("NO")) {

					session.setAttribute("user", userName);

				  model.addAttribute("content", "../auth/change_password.jsp");
        return "layouts/guest";

				}

				String new_message = "Use this OTP Code: " + verification_code_obj + " to login to ELIS";
				//System.out.println(new_phone);
				session.setAttribute("user_id_init", new_userid);
				session.setAttribute("user_phone", new_phone);
				session.setAttribute("user_emailaddress", emailaddress);

				JSONObject obj_sms = new JSONObject();
				obj_sms.put("recipient", new_phone);
				obj_sms.put("msg", new_message);

				String otpLabel = "To complete log in, please use the following verification code:";

				JSONObject obj_mail = new JSONObject();
				obj_mail.put("emailaddress", emailaddress);
				obj_mail.put("firstName", firstName);
				obj_mail.put("verification_code_obj", verification_code_obj);
				obj_mail.put("otpLabel", otpLabel);

				if (otp_enabled_obj.equals("1")) {
						// currently 30 caraters
						// if (arr_verify.equals("Sms Send Sucessfull")) {
						String request_url = request.getRequestURI();
						String protocol = request.getProtocol();
						String path_info = request.getPathInfo();
						String ip_address = request.getRemoteAddr();
						String ip_mac_address = request.getLocalAddr();
	
						String getQueryString = request.getQueryString();
						String getRemoteHost = request.getRemoteHost();
						String getRemoteUser = request.getRemoteUser();
						String getServerName = request.getServerName();
						String getServletPath = request.getServletPath();
						String getScheme = request.getScheme();
	
						DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
						LocalDateTime now = LocalDateTime.now();
						// System.out.println(dtf.format(now));
	
						System.out.println("userid");
	
						System.out.println(new_userid);
	
						if (new_userid != "null" || new_userid != null) {
							request.setAttribute("user", userName);
							request.setAttribute("pass", password);
	
							JSONObject obj_usr_log = new JSONObject();
							obj_usr_log.put("user_id", new_userid);
							obj_usr_log.put("work_station", ip_address);
							obj_usr_log.put("ip_address", ip_address);
							obj_usr_log.put("request_url", request_url);
							obj_usr_log.put("protocol", protocol);
							obj_usr_log.put("log_date", dtf.format(now));
							obj_usr_log.put("log_type", "OTP");
	
							obj_usr_log.put("description", "User log in of the System");
							obj_usr_log.put("t_date", dtf.format(now));
							obj_usr_log.put("comp_id", "0");
	
							System.out.println(obj_usr_log.toString());
							web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj_usr_log.toString());

				// 					String otpLabel = "To finish logging in, please use the following verification code:";

				// // Use the autowired mail service
                // smtpMailService.sendOtpEmail(emailaddress, firstName, verification_code_obj, otpLabel);
	
							 request.setAttribute("otp_code", verification_code_obj);
							// request.setAttribute("pass", password);
							  model.addAttribute("content", "../auth/login_2fa.jsp");
        return "layouts/guest";
							// return "/user_management/two_factor_authentication.jsp";

						// 	GoogleAuthenticator gAuth = new GoogleAuthenticator();

						// // Generate a secret key for the user if not already generated
						// String secretKey = (String) session.getAttribute("secretKey");
						// if (secretKey == null) {
						// 	GoogleAuthenticatorKey key = gAuth.createCredentials();
						// 	secretKey = key.getKey();
						// 	session.setAttribute("secretKey", secretKey);
 
						// 	// Generate QR Code URL for the user to scan
						// 	String qrCodeURL = GoogleAuthenticatorQRGenerator.getOtpAuthURL("example.com", userName, key);
						// 	session.setAttribute("qrCodeURL", qrCodeURL);
						//}

						// Return the QR Code page for the user to configure Google Authenticator
						//return "/configure_google_authenticator.jsp"; // Redirect to QR Code setup page
	
						} else {
							System.out.println("attemted login");
	
							System.out.println(new_userid);
	
							new_userid = new_userid;
							JSONObject obj_usr_log = new JSONObject();
							obj_usr_log.put("user_id", new_userid);
							obj_usr_log.put("work_station", ip_address);
							obj_usr_log.put("ip_address", ip_address);
							obj_usr_log.put("request_url", request_url);
							obj_usr_log.put("protocol", protocol);
							obj_usr_log.put("log_date", dtf.format(now));
							obj_usr_log.put("log_type", "IN");
	
							obj_usr_log.put("description", "User attemted login in System");
							obj_usr_log.put("t_date", dtf.format(now));
							obj_usr_log.put("comp_id", "0");
	
							System.out.println(obj_usr_log.toString());
							web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj_usr_log.toString());
	
							request.setAttribute("login", "failed");
							// System.out.println("If Not success");
							  model.addAttribute("content", "../auth/login.jsp");
        return "layouts/guest";
	
						}
	
				
				} else {
					//Code to Send SMS 
					//System.out.println(obj_sms.toString());
				String smsm_result = sms_sl.send_single_sms(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());	
				//System.out.println("smsm_result");
				System.out.println(smsm_result);

				// Use the autowired mail service
                mail_sl.send_otp_mail(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(), obj_mail.toString());

				JSONObject obj_verify = new JSONObject(smsm_result);
				String arr_verify = obj_verify.get("msg").toString();
				String arr_verify_messageId = obj_verify.get("messageId").toString();
	
				if (arr_verify_messageId.length() > 20) {
					// currently 30 caraters
					// if (arr_verify.equals("Sms Send Sucessfull")) {
					String request_url = request.getRequestURI();
					String protocol = request.getProtocol();
					String path_info = request.getPathInfo();
					String ip_address = request.getRemoteAddr();
					String ip_mac_address = request.getLocalAddr();

					String getQueryString = request.getQueryString();
					String getRemoteHost = request.getRemoteHost();
					String getRemoteUser = request.getRemoteUser();
					String getServerName = request.getServerName();
					String getServletPath = request.getServletPath();
					String getScheme = request.getScheme();

					DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
					LocalDateTime now = LocalDateTime.now();
					// System.out.println(dtf.format(now));

					System.out.println("userid");

					System.out.println(new_userid);

					if (new_userid != "null" || new_userid != null) {
						request.setAttribute("user", userName);
						request.setAttribute("pass", password);

						JSONObject obj_usr_log = new JSONObject();
						obj_usr_log.put("user_id", new_userid);
						obj_usr_log.put("work_station", ip_address);
						obj_usr_log.put("ip_address", ip_address);
						obj_usr_log.put("request_url", request_url);
						obj_usr_log.put("protocol", protocol);
						obj_usr_log.put("log_date", dtf.format(now));
						obj_usr_log.put("log_type", "OTP");

						obj_usr_log.put("description", "User log in of the System");
						obj_usr_log.put("t_date", dtf.format(now));
						obj_usr_log.put("comp_id", "0");

						System.out.println(obj_usr_log.toString());
						web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_usr_log.toString());

					     request.setAttribute("otp_code", "Check your Phone");
						// request.setAttribute("pass", password);
						  model.addAttribute("content", "../auth/login_2fa.jsp");
        return "layouts/guest";
						// return "/user_management/two_factor_authentication.jsp";


						// // Initialize Google Authenticator
						// GoogleAuthenticator gAuth = new GoogleAuthenticator();

						// // Generate a secret key for the user if not already generated
						// String secretKey = (String) session.getAttribute("secretKey");
						// if (secretKey == null) {
						// 	GoogleAuthenticatorKey key = gAuth.createCredentials();
						// 	secretKey = key.getKey();
						// 	session.setAttribute("secretKey", secretKey);

						// 	// Generate QR Code URL for the user to scan
						// 	String qrCodeURL = GoogleAuthenticatorQRGenerator.getOtpAuthURL("elis.lc.gov.gh", userName, key);
						// 	session.setAttribute("qrCodeURL", qrCodeURL);
						// }

						// // Return the QR Code page for the user to configure Google Authenticator
						// return "/configure_google_authenticator.jsp"; // Redirect to QR Code setup page

					} else {
						System.out.println("attemted login");

						System.out.println(new_userid);

						new_userid = new_userid;
						JSONObject obj_usr_log = new JSONObject();
						obj_usr_log.put("user_id", new_userid);
						obj_usr_log.put("work_station", ip_address);
						obj_usr_log.put("ip_address", ip_address);
						obj_usr_log.put("request_url", request_url);
						obj_usr_log.put("protocol", protocol);
						obj_usr_log.put("log_date", dtf.format(now));
						obj_usr_log.put("log_type", "IN");

						obj_usr_log.put("description", "User attemted login in System");
						obj_usr_log.put("t_date", dtf.format(now));
						obj_usr_log.put("comp_id", "0");

						System.out.println(obj_usr_log.toString());
						web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_usr_log.toString());

						request.setAttribute("login", "failed");
						// System.out.println("If Not success");
					  model.addAttribute("content", "../auth/login.jsp");
        return "layouts/guest";

					}

				} else {
					System.out.println("sms error");

					request.setAttribute("login", "SMS Error");
					 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
				}

				}

			
				

			} else {
				System.out.println("user verification error");
				request.setAttribute("login", "failed");
				  model.addAttribute("content", "../auth/login.jsp");
        return "layouts/guest";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  model.addAttribute("content", "../auth/login.jsp");
        return "layouts/guest";
	}

	@RequestMapping("/send_code_for_password_reset")
	@PostMapping
	public String send_code_for_password_reset(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		String userName = request.getParameter("username");
		//String password = request.getParameter("password");
		// System.out.println(userName + password);
		String web_service_response = null;
		String new_userid = null;
		String vr_region_code = null;

		// code
		try {

			web_service_response = cls_users.send_code_for_password_reset(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), userName);
			JSONObject obj_test = new JSONObject(web_service_response);
			String arr_login_response = obj_test.get("data").toString();
			String success_obj = obj_test.get("success").toString();
			String msg_obj = obj_test.get("msg").toString();

			String otp_enabled_obj = "";

			String verification_code_obj = "";

			if (msg_obj.equals("Success")) {
				verification_code_obj = obj_test.get("verification_code").toString();
				otp_enabled_obj = obj_test.get("otp_enabled").toString();
				session.setAttribute("verification_code", verification_code_obj);
				session.setAttribute("user", userName);
				//session.setAttribute("pass", password);

			} else {
				System.out.println("user verification error");
				request.setAttribute("login", "failed");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}


			if (arr_login_response != "null") {

				//System.out.println(verification_code_obj);

				JSONObject obj = new JSONObject(arr_login_response);
				new_userid = obj.get("userid").toString();
				String new_phone = obj.get("phone").toString();
				String new_message = "Use this OTP Code: " + verification_code_obj + " to login to ELIS";
				//System.out.println(new_phone);
				session.setAttribute("user_id_init", new_userid);
				session.setAttribute("user_phone", new_phone);

				JSONObject obj_sms = new JSONObject();
				obj_sms.put("recipient", new_phone);
				obj_sms.put("msg", new_message);

				if (otp_enabled_obj.equals("1")) {
						// currently 30 caraters
						// if (arr_verify.equals("Sms Send Sucessfull")) {
						String request_url = request.getRequestURI();
						String protocol = request.getProtocol();
						String path_info = request.getPathInfo();
						String ip_address = request.getRemoteAddr();
						String ip_mac_address = request.getLocalAddr();
	
						String getQueryString = request.getQueryString();
						String getRemoteHost = request.getRemoteHost();
						String getRemoteUser = request.getRemoteUser();
						String getServerName = request.getServerName();
						String getServletPath = request.getServletPath();
						String getScheme = request.getScheme();
	
						DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
						LocalDateTime now = LocalDateTime.now();
						// System.out.println(dtf.format(now));
	
						System.out.println("userid");
	
						System.out.println(new_userid);
	
						if (new_userid != "null" || new_userid != null) {
							request.setAttribute("user", userName);
							//request.setAttribute("pass", password);
	
							JSONObject obj_usr_log = new JSONObject();
							obj_usr_log.put("user_id", new_userid);
							obj_usr_log.put("work_station", ip_address);
							obj_usr_log.put("ip_address", ip_address);
							obj_usr_log.put("request_url", request_url);
							obj_usr_log.put("protocol", protocol);
							obj_usr_log.put("log_date", dtf.format(now));
							obj_usr_log.put("log_type", "OTP");
	
							obj_usr_log.put("description", "User log in of the System");
							obj_usr_log.put("t_date", dtf.format(now));
							obj_usr_log.put("comp_id", "0");
	
							System.out.println(obj_usr_log.toString());
							web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj_usr_log.toString());
	
							 request.setAttribute("otp_code", verification_code_obj);
							// request.setAttribute("pass", password);
							return "/two_factor_authentication_for_password_reset.jsp";
							// return "/user_management/two_factor_authentication.jsp";
	
						} else {
							System.out.println("attemted login");
	
							System.out.println(new_userid);
	
							new_userid = new_userid;
							JSONObject obj_usr_log = new JSONObject();
							obj_usr_log.put("user_id", new_userid);
							obj_usr_log.put("work_station", ip_address);
							obj_usr_log.put("ip_address", ip_address);
							obj_usr_log.put("request_url", request_url);
							obj_usr_log.put("protocol", protocol);
							obj_usr_log.put("log_date", dtf.format(now));
							obj_usr_log.put("log_type", "IN");
	
							obj_usr_log.put("description", "User attemted login in System");
							obj_usr_log.put("t_date", dtf.format(now));
							obj_usr_log.put("comp_id", "0");
	
							System.out.println(obj_usr_log.toString());
							web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj_usr_log.toString());
	
							request.setAttribute("login", "failed");
							// System.out.println("If Not success");
							return "forgot_password.jsp";
	
						}
	
				
				} else {
					//Code to Send SMS 
					//System.out.println(obj_sms.toString());
				String smsm_result = sms_sl.send_single_sms(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());	
				//System.out.println("smsm_result");
				System.out.println(smsm_result);

				JSONObject obj_verify = new JSONObject(smsm_result);
				String arr_verify = obj_verify.get("msg").toString();
				String arr_verify_messageId = obj_verify.get("messageId").toString();
	
				if (arr_verify_messageId.length() > 20) {
					// currently 30 caraters
					// if (arr_verify.equals("Sms Send Sucessfull")) {
					String request_url = request.getRequestURI();
					String protocol = request.getProtocol();
					String path_info = request.getPathInfo();
					String ip_address = request.getRemoteAddr();
					String ip_mac_address = request.getLocalAddr();

					String getQueryString = request.getQueryString();
					String getRemoteHost = request.getRemoteHost();
					String getRemoteUser = request.getRemoteUser();
					String getServerName = request.getServerName();
					String getServletPath = request.getServletPath();
					String getScheme = request.getScheme();

					DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
					LocalDateTime now = LocalDateTime.now();
					// System.out.println(dtf.format(now));

					System.out.println("userid");

					System.out.println(new_userid);

					if (new_userid != "null" || new_userid != null) {
						request.setAttribute("user", userName);
						//request.setAttribute("pass", password);

						JSONObject obj_usr_log = new JSONObject();
						obj_usr_log.put("user_id", new_userid);
						obj_usr_log.put("work_station", ip_address);
						obj_usr_log.put("ip_address", ip_address);
						obj_usr_log.put("request_url", request_url);
						obj_usr_log.put("protocol", protocol);
						obj_usr_log.put("log_date", dtf.format(now));
						obj_usr_log.put("log_type", "OTP");

						obj_usr_log.put("description", "User log in of the System");
						obj_usr_log.put("t_date", dtf.format(now));
						obj_usr_log.put("comp_id", "0");

						System.out.println(obj_usr_log.toString());
						web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_usr_log.toString());

					     request.setAttribute("otp_code", "Check your Phone");
						// request.setAttribute("pass", password);
						return "/two_factor_authentication_for_password_reset.jsp";
						// return "/user_management/two_factor_authentication.jsp";

					} else {
						System.out.println("attemted login");

						System.out.println(new_userid);

						new_userid = new_userid;
						JSONObject obj_usr_log = new JSONObject();
						obj_usr_log.put("user_id", new_userid);
						obj_usr_log.put("work_station", ip_address);
						obj_usr_log.put("ip_address", ip_address);
						obj_usr_log.put("request_url", request_url);
						obj_usr_log.put("protocol", protocol);
						obj_usr_log.put("log_date", dtf.format(now));
						obj_usr_log.put("log_type", "IN");

						obj_usr_log.put("description", "User attemted login in System");
						obj_usr_log.put("t_date", dtf.format(now));
						obj_usr_log.put("comp_id", "0");

						System.out.println(obj_usr_log.toString());
						web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_usr_log.toString());

						request.setAttribute("login", "failed");
						// System.out.println("If Not success");
						return "forgot_password.jsp";

					}

				} else {
					System.out.println("sms error");

					request.setAttribute("login", "SMS Error");
					 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
				}

				}


			} else {
				System.out.println("user verification error");
				request.setAttribute("login", "failed");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest"; 
	}

	@RequestMapping("/select_self_change_user_password")
	@PostMapping
	public String select_self_change_user_password(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		String userName = session.getAttribute("user").toString();
		String new_password = request.getParameter("new_password");
		String confirm_password = request.getParameter("confirm_password");
		// System.out.println(userName + password);
		String web_service_response = null;
		String new_userid = null;
		String vr_region_code = null;

		if(!new_password.equals(confirm_password)) {
			request.setAttribute("password_not_match", "failed");
			return "change_password.jsp";
		}

		// code
		try {

			web_service_response = cls_users.select_self_change_user_password(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), userName, new_password);
			JSONObject obj_test = new JSONObject(web_service_response);
			// String arr_login_response = obj_test.get("data").toString();
			// String success_obj = obj_test.get("success").toString();
			String msg_obj = obj_test.get("msg").toString();

			if (msg_obj.equals("Success")) {

				request.setAttribute("password_changed", "passed");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			} else {
				System.out.println("user verification error");
				request.setAttribute("login", "failed");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest"; 
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher view = request.getRequestDispatcher("/index.jsp");
		view.forward(request, response);
	}

}
