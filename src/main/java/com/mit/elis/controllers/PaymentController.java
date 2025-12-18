package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.ws_professional_portal;
import ws.rentmgt.Ws_rent_mgt;

@Controller
public class PaymentController {

	@Autowired
	private Ws_url_config cls_url_config;

	Ws_rent_mgt rent_mgt_service = new Ws_rent_mgt();

	@RequestMapping("/payment_receipt_dashboard")
	@GetMapping
	public String rent_management_dashboard(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}
		Gson googleJson = new Gson();
		try {
			//  JSONObject obj = new JSONObject();
			// 	obj.put("office_region", (String) session.getAttribute("regional_code"));
			// 	NumberFormat numberFormat = NumberFormat.getNumberInstance(new Locale("en", "GH"));
        	// 	numberFormat.setMinimumFractionDigits(2); // Ensuring two decimal places

			//     String web_service_response_menu = null;
			// 			web_service_response_menu = rent_mgt_service
			// 					.select_rent_dashboard_stats(
			// 							cls_url_config.getWeb_service_url_ser(),
			// 							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			// JSONObject professioan_dashboard_details_obj;
			// professioan_dashboard_details_obj = new JSONObject(web_service_response_menu);
			// System.out.println(web_service_response_menu);
			// String total_leasee_count = professioan_dashboard_details_obj.get("total_leasee")
			// 		.toString();
			// request.setAttribute("total_leasee", total_leasee_count);

			// String total_rent_oustanding_count = professioan_dashboard_details_obj.get("total_rent_oustanding").toString();
			// double value = Double.parseDouble(total_rent_oustanding_count);
			// request.setAttribute("total_rent_oustanding", numberFormat.format(value));

			// // String bills_unpaid_count = professioan_dashboard_details_obj.get("bills_unpaid_count").toString();
			// // request.setAttribute("bills_unpaid_count", bills_unpaid_count);

			// String web_service_response_est = null;

			// web_service_response_est = rent_mgt_service.select_rt_govt_estatesg_list(cls_url_config.getWeb_service_url_ser(),
			// 				cls_url_config.getWeb_service_url_ser_api_key());
			// JSONObject web_response_case_est = new JSONObject(web_service_response_est);
			// String estate_list = web_response_case_est.get("data").toString();
			// ArrayList estate_list_list = googleJson.fromJson(estate_list, ArrayList.class);

			// request.setAttribute("estate_list", estate_list_list);

			// String web_service_response_nt = null;

			// web_service_response_nt = rent_mgt_service.select_rt_nature_of_instrument_list(cls_url_config.getWeb_service_url_ser(),
			// 				cls_url_config.getWeb_service_url_ser_api_key());
			// JSONObject web_response_case_nt = new JSONObject(web_service_response_nt);
			// String nature_of_instrument_list = web_response_case_nt.get("data").toString();
			// ArrayList nature_of_instrument_list_list = googleJson.fromJson(nature_of_instrument_list, ArrayList.class);

			// request.setAttribute("nature_of_instrument_list", nature_of_instrument_list_list);

			// String web_service_response_na = null;

			// web_service_response_na = rent_mgt_service.select_rt_nature_of_development_list(cls_url_config.getWeb_service_url_ser(),
			// 				cls_url_config.getWeb_service_url_ser_api_key());
			// JSONObject web_response_case_na = new JSONObject(web_service_response_na);
			// String nature_of_development_list = web_response_case_na.get("data").toString();
			// ArrayList nature_of_development_list_list = googleJson.fromJson(nature_of_development_list, ArrayList.class);

			// request.setAttribute("nature_of_development_list", nature_of_development_list_list);

			// String web_service_response_us = null;

			// web_service_response_us = rent_mgt_service.select_rt_user_category_list(cls_url_config.getWeb_service_url_ser(),
			// 				cls_url_config.getWeb_service_url_ser_api_key());
			// JSONObject web_response_case_us = new JSONObject(web_service_response_us);
			// String user_category_list = web_response_case_us.get("data").toString();
			// ArrayList user_category_list_list = googleJson.fromJson(user_category_list, ArrayList.class);

			// request.setAttribute("user_category_list", user_category_list_list);

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			request.setAttribute("page_name", "payment_receipt_dashboard");
					model.addAttribute("content", "../pages/payment_receipt_management/payment_receipt_dashboard.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}



}
