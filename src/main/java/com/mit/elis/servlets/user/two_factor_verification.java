package com.mit.elis.servlets.user;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
System.out.println(userName);
System.out.println(password);
//System.out.println(web_service_response);
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
					model.addAttribute("email", emailaddress);

				  model.addAttribute("content", "../auth/reset_password_form.jsp");
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
		String userName = request.getParameter("email");
		String web_service_response = null;
		String new_userid = null;
		String vr_region_code = null;

		System.out.println(userName);

		try {
			web_service_response = cls_users.send_code_for_password_reset(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), userName);

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
				
				// Generate a unique reset token
				String resetToken = UUID.randomUUID().toString() + System.currentTimeMillis();
				session.setAttribute("reset_token", resetToken);
				session.setAttribute("reset_token_expiry", System.currentTimeMillis() + (24 * 60 * 60 * 1000)); // 24 hours
				
			} else {
				request.setAttribute("login", "failed");
				model.addAttribute("content", "../auth/forgot_password.jsp");
				return "layouts/guest";
			}

			if (arr_login_response != "null") {
				JSONObject obj = new JSONObject(arr_login_response);
				new_userid = obj.get("userid").toString();
				String new_phone = obj.get("phone").toString();
				String new_email = obj.get("emailaddress").toString(); // Assuming email is in response
				String fullName = obj.get("fullname").toString(); // Assuming full name is in response
				
				session.setAttribute("user_id_init", new_userid);
				session.setAttribute("user_phone", new_phone);
				session.setAttribute("user_emailaddress", new_email);
				session.setAttribute("full_name", fullName);

				// Check if email exists and send reset link
				if (new_email != null && !new_email.isEmpty()) {
					try {
						// Get base URL
						String baseUrl = request.getScheme() + "://" + request.getServerName();
						if (request.getServerPort() != 80 && request.getServerPort() != 443) {
							baseUrl += ":" + request.getServerPort();
						}
						baseUrl += request.getContextPath();

						String firstName = fullName.split(" ")[0];

						JSONObject obj_mail = new JSONObject();
						obj_mail.put("emailaddress", new_email);
						obj_mail.put("firstName", firstName);
						obj_mail.put("baseUrl", baseUrl);
								
						// Send email with reset link
						String resetToken = (String) session.getAttribute("reset_token");

						obj_mail.put("resetToken", resetToken);
						mail_sl.send_otp_mail_for_password_reset(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(), obj_mail.toString());
						
						// Store email sent status
						session.setAttribute("email_sent", true);
						
						// Log the email sending
						System.out.println("Password reset email sent to: " + new_email);
						
					} catch (Exception e) {
						System.err.println("Failed to send email: " + e.getMessage());
						// Fallback to SMS if email fails
						sendSMSFallback(new_phone, verification_code_obj);
					}
				} else {
					// Fallback to SMS if no email
					sendSMSFallback(new_phone, verification_code_obj);
				}

				// Log the access
				String request_url = request.getRequestURI();
				String protocol = request.getProtocol();
				String ip_address = request.getRemoteAddr();
				
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
				LocalDateTime now = LocalDateTime.now();

				if (new_userid != "null" && new_userid != null) {
					JSONObject obj_usr_log = new JSONObject();
					obj_usr_log.put("user_id", new_userid);
					obj_usr_log.put("work_station", ip_address);
					obj_usr_log.put("ip_address", ip_address);
					obj_usr_log.put("request_url", request_url);
					obj_usr_log.put("protocol", protocol);
					obj_usr_log.put("log_date", dtf.format(now));
					obj_usr_log.put("log_type", "PASSWORD_RESET");
					obj_usr_log.put("description", "Password reset requested by user");
					obj_usr_log.put("t_date", dtf.format(now));
					obj_usr_log.put("comp_id", "0");

					cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj_usr_log.toString());

					// Set success message
					request.setAttribute("reset_email_sent", true);
					request.setAttribute("user_email", new_email != null ? maskEmail(new_email) : userName);
					
					// Redirect to confirmation page
					model.addAttribute("content", "../auth/reset_password_email_sent.jsp");
					return "layouts/guest";

				} else {
					request.setAttribute("login", "failed");
					model.addAttribute("content", "../auth/forgot_password.jsp");
					return "layouts/guest";
				}

			} else {
				request.setAttribute("login", "failed");
				model.addAttribute("content", "../auth/login.jsp");
				return "layouts/guest";
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "An error occurred while processing your request");
			model.addAttribute("content", "../auth/forgot_password.jsp");
			return "layouts/guest";
		}
	}

	// Helper method to mask email
	private String maskEmail(String email) {
		if (email == null || email.isEmpty()) return "";
		int atIndex = email.indexOf('@');
		if (atIndex <= 2) return "***@" + email.substring(atIndex + 1);
		
		String firstPart = email.substring(0, 2);
		String masked = firstPart + "****" + email.substring(atIndex);
		return masked;
	}

	// SMS fallback method
	private void sendSMSFallback(String phone, String verificationCode) {
		try {
			JSONObject obj_sms = new JSONObject();
			obj_sms.put("recipient", phone);
			obj_sms.put("msg", "Your password reset OTP is: " + verificationCode + ". Use this to reset your password.");
			
			String smsm_result = sms_sl.send_single_sms(
				cls_url_config.getWeb_service_url_ser(),
				cls_url_config.getWeb_service_url_ser_api_key(), 
				obj_sms.toString()
			);
			
			System.out.println("SMS sent: " + smsm_result);
		} catch (Exception e) {
			System.err.println("Failed to send SMS: " + e.getMessage());
		}
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

	@GetMapping("/reset-password")
	public String showResetPasswordForm(@RequestParam("token") String token,
									@RequestParam("email") String email,
									HttpSession session,
									Model model) {
		
		String sessionToken = (String) session.getAttribute("reset_token");
		Long expiryTime = (Long) session.getAttribute("reset_token_expiry");
		
		// Validate token
		if (sessionToken == null || !sessionToken.equals(token) || 
			expiryTime == null || System.currentTimeMillis() > expiryTime) {
			model.addAttribute("error", "Reset link is invalid or has expired");
			model.addAttribute("content", "../auth/reset_password_expired.jsp");
			return "layouts/guest";
		}
		
		model.addAttribute("email", email);
		model.addAttribute("token", token);
		model.addAttribute("content", "../auth/reset_password_form.jsp");
		return "layouts/guest";
	}


	@PostMapping("/perform-password-reset")
	public String performPasswordReset(HttpServletRequest request,
									HttpSession session,
									Model model) {
		
		String token = request.getParameter("token");
		String email = request.getParameter("email");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");
		
		// Validate passwords match
		if (!newPassword.equals(confirmPassword)) {
			model.addAttribute("error", "Passwords do not match");
			model.addAttribute("email", email);
			model.addAttribute("token", token);
			model.addAttribute("content", "../auth/reset_password_form.jsp");
			return "layouts/guest";
		}
		
		// Validate password strength
		if (newPassword.length() < 14) {
			model.addAttribute("error", "Password must be at least 14 characters long");
			model.addAttribute("email", email);
			model.addAttribute("token", token);
			model.addAttribute("content", "../auth/reset_password_form.jsp");
			return "layouts/guest";
		}
		
		// Validate token
		String sessionToken = (String) session.getAttribute("reset_token");
		Long expiryTime = (Long) session.getAttribute("reset_token_expiry");
		
		if (sessionToken == null || !sessionToken.equals(token) || 
			expiryTime == null || System.currentTimeMillis() > expiryTime) {
			model.addAttribute("error", "Reset link has expired");
			model.addAttribute("content", "../auth/reset_password_expired.jsp");
			return "layouts/guest";
		}
		
		try {
			// Call your existing password reset service
			// JSONObject resetRequest = new JSONObject();
			// resetRequest.put("email", email);
			// resetRequest.put("new_password", newPassword);
			
			String result = cls_users.select_self_change_user_password(
				cls_url_config.getWeb_service_url_ser(),
				cls_url_config.getWeb_service_url_ser_api_key(),
				email, newPassword
			);
			
			JSONObject resultObj = new JSONObject(result);
			if ("Success".equals(resultObj.get("msg"))) {
				// Clear reset token from session
				session.removeAttribute("reset_token");
				session.removeAttribute("reset_token_expiry");
				
				// Show success page
				model.addAttribute("content", "../auth/reset_password_success.jsp");
				return "layouts/guest";
			} else {
				model.addAttribute("error", "Failed to reset password. Please try again.");
				model.addAttribute("email", email);
				model.addAttribute("token", token);
				model.addAttribute("content", "../auth/reset_password_form.jsp");
				return "layouts/guest";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "An error occurred. Please try again.");
			model.addAttribute("email", email);
			model.addAttribute("token", token);
			model.addAttribute("content", "../auth/reset_password_form.jsp");
			return "layouts/guest";
		}
	}

	@PostMapping("/perform-first-time-password-reset")
	public String performFirstTimePasswordReset(HttpServletRequest request,
									HttpSession session,
									Model model) {
		
		//String token = request.getParameter("token");
		String email = request.getParameter("email");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");
		
		// Validate passwords match
		if (!newPassword.equals(confirmPassword)) {
			model.addAttribute("error", "Passwords do not match");
			model.addAttribute("email", email);
			//model.addAttribute("token", token);
			model.addAttribute("content", "../auth/first_time_reset_password_form.jsp");
			return "layouts/guest";
		}
		
		// Validate password strength
		if (newPassword.length() < 14) {
			model.addAttribute("error", "Password must be at least 14 characters long");
			model.addAttribute("email", email);
			//model.addAttribute("token", token);
			model.addAttribute("content", "../auth/first_time_reset_password_form.jsp");
			return "layouts/guest";
		}
		
		// Validate token
		// String sessionToken = (String) session.getAttribute("reset_token");
		// Long expiryTime = (Long) session.getAttribute("reset_token_expiry");
		
		// if (sessionToken == null || !sessionToken.equals(token) || 
		// 	expiryTime == null || System.currentTimeMillis() > expiryTime) {
		// 	model.addAttribute("error", "Reset link has expired");
		// 	model.addAttribute("content", "../auth/reset_password_expired.jsp");
		// 	return "layouts/guest";
		// }
		
		try {
			// Call your existing password reset service
			// JSONObject resetRequest = new JSONObject();
			// resetRequest.put("email", email);
			// resetRequest.put("new_password", newPassword);
			
			String result = cls_users.select_self_change_user_password(
				cls_url_config.getWeb_service_url_ser(),
				cls_url_config.getWeb_service_url_ser_api_key(),
				email, newPassword
			);
			
			JSONObject resultObj = new JSONObject(result);
			if ("Success".equals(resultObj.get("msg"))) {
				// Clear reset token from session
				session.removeAttribute("reset_token");
				session.removeAttribute("reset_token_expiry");
				
				// Show success page
				model.addAttribute("content", "../auth/reset_password_success.jsp");
				return "layouts/guest";
			} else {
				model.addAttribute("error", "Failed to reset password. Please try again.");
				model.addAttribute("email", email);
				//model.addAttribute("token", token);
				model.addAttribute("content", "../auth/first_time_reset_password_form.jsp");
				return "layouts/guest";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "An error occurred. Please try again.");
			model.addAttribute("email", email);
			//model.addAttribute("token", token);
			model.addAttribute("content", "../auth/first_time_reset_password_form.jsp");
			return "layouts/guest";
		}
	}
									

}
