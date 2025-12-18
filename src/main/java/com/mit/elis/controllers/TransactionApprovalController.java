package com.mit.elis.controllers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import org.springframework.ui.Model;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.mit.elis.class_common.Ws_url_config;

import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import ws.cica.cica_docs;
import ws.cica.ws_cica;

@Controller
public class TransactionApprovalController {

	@Autowired
	private Ws_url_config cls_url_config;

	ServletRequest servletContext;

	Ws_client_application casemgt_cl = new Ws_client_application();

	@RequestMapping("/transaction_approvals")
	@GetMapping
	public String transaction_approvals(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

		if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			// String mc_job_number = (String) request.getParameter("mc_job_number");
			// String job_number = (String) request.getParameter("job_number");
			// String case_number = (String) request.getParameter("case_number");
			// String transaction_number = (String)
			// request.getParameter("transaction_number");
			String userid = (String) session.getAttribute("userid");
			String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


			JSONObject obj = new JSONObject();

			// obj.put("mc_job_number", mc_job_number);
			// obj.put("job_number", job_number);
			// obj.put("case_number", case_number);
			// obj.put("transaction_number", transaction_number);

			obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

			obj.put("userid", userid);

			String web_service_response = casemgt_cl
					.select_transaction_approvals_by_user(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			JSONObject case_obj;
			case_obj = new JSONObject(web_service_response);
			String total_count = case_obj.get("total_count").toString();
			String transaction_list = case_obj.get("transaction_list").toString();

			ArrayList javaArrayListFromGSON_sub_service = googleJson.fromJson(transaction_list, ArrayList.class);

			request.setAttribute("total_count", total_count);
			request.setAttribute("transactionlist", javaArrayListFromGSON_sub_service);

					model.addAttribute("content", "../pages/transaction_approvals/transaction_approval.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("/parcel_based_transaction_approvals")
	@GetMapping
	public String parcel_based_transaction_approvals(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

		if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			String userid = (String) session.getAttribute("userid");
			String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


			JSONObject obj = new JSONObject();

			// obj.put("mc_job_number", mc_job_number);
			// obj.put("job_number", job_number);
			// obj.put("case_number", case_number);
			// obj.put("transaction_number", transaction_number);

			obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

			obj.put("userid", userid);

			String web_service_response = casemgt_cl
					.select_transaction_approvals_by_user(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			ArrayList javaArrayListFromGSON_sub_service = googleJson.fromJson(web_service_response, ArrayList.class);
			request.setAttribute("transactionlist", javaArrayListFromGSON_sub_service);

					model.addAttribute("content", "../pages/transaction_approvals/records_parcel_related_transactions.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
