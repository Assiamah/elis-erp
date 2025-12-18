package com.mit.elis.servlets;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.util.ArrayList;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;
import com.mit.elis.class_common.cls_sms;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import ws.casemgt.ws_sms;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class Case_SMS_Serv {
	cls_sms sms_cl = new cls_sms();
	ws_sms sms_sl = new ws_sms();
	Ws_client_application casemgt_cl = new Ws_client_application();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/Case_SMS_Serv")
	@PostMapping
	public String SendSMS(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {
			String request_type = request.getParameter("request_type");

			String web_service_response = null;

			System.out.println(request_type);

			if (request_type.equals("send_final_registration_massage_to_register")) {
				// String case_number = request.getParameter("case_number");
				// String msg = request.getParameter("msg");
				// String recipient = request.getParameter("recipient");

				String case_number = request.getParameter("case_number");
				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String job_number = request.getParameter("job_number");
				String type_of_transaction = request.getParameter("type_of_transaction");

				JSONObject obj = new JSONObject();

				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("type_of_transaction", type_of_transaction);
				obj.put("userid", userid);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				String input = obj.toString();

				// System.out.println(case_number);
				web_service_response = casemgt_cl
						.online_select_verification_code_create(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);

				// String user_phone = (String) session.getAttribute("user_phone");
				JSONObject web_response_obj = new JSONObject(web_service_response);
				String user_phone = web_response_obj.getString("open");
				user_phone = user_phone.replaceFirst("0", "+233");

				String new_message = "Use this OTP Code: " + user_phone
						+ " to approve the transaction for Signature on to ELIS";

				JSONObject obj_sms = new JSONObject();
				obj_sms.put("recipient", user_phone);
				obj_sms.put("msg", new_message);

				String smsm_result = sms_sl.send_single_sms(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());
				// String new_message="Verification code is "+ smsm_result;
				System.out.println("smsm_result");
				System.out.println(smsm_result);

				JSONObject obj_verify = new JSONObject(smsm_result);
				String arr_verify = obj_verify.get("msg").toString();

				System.out.println("sms response");

				System.out.println(arr_verify);

				if (arr_verify.equals("Sms send Sucessfull")) {
					web_service_response = "OTP has been generatent to your phone";
				} else {
					web_service_response = "Error Sending otp";

				}

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("auto_generate_file_number")) {
				String vr_type_of_number = request.getParameter("vr_type_of_number");
				// System.out.println(polygon);
				// web_service_response
				// =casemgt_cl_m.select_create_lc_file_numbering(vr_type_of_number);
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
		return null;
	}
}
