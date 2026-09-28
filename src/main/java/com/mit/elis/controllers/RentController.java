package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
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
public class RentController {

	@Autowired
	private Ws_url_config cls_url_config;

	Ws_rent_mgt rent_mgt_service = new Ws_rent_mgt();

	@RequestMapping("/rent_management_dashboard")
	@GetMapping
	public String rent_management_dashboard(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			//System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			JSONObject obj = new JSONObject();

			// obj.put("unit_id", (String) session.getAttribute("unit_id"));
			obj.put("office_region", (String) session.getAttribute("regional_code"));

			NumberFormat numberFormat = NumberFormat.getNumberInstance(new Locale("en", "GH"));
			numberFormat.setMinimumFractionDigits(2); // Ensuring two decimal places

			String web_service_response_menu = null;
			web_service_response_menu = rent_mgt_service
					.select_rent_dashboard_stats(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			JSONObject professioan_dashboard_details_obj;
			professioan_dashboard_details_obj = new JSONObject(web_service_response_menu);
			//System.out.println(web_service_response_menu);
			String total_leasee_count = professioan_dashboard_details_obj.get("total_leasee")
					.toString();
			request.setAttribute("total_leasee", total_leasee_count);

			String total_rent_oustanding_count = professioan_dashboard_details_obj.get("total_rent_outstanding")
					.toString();
			double value = Double.parseDouble(total_rent_oustanding_count);
			request.setAttribute("total_rent_outstanding", numberFormat.format(value));

			String estate_outstanding_rent = professioan_dashboard_details_obj.get("estate_outstanding_rent")
					.toString();
			request.setAttribute("estate_outstanding_rent", estate_outstanding_rent);

			// String bills_unpaid_count =
			// professioan_dashboard_details_obj.get("bills_unpaid_count").toString();
			// request.setAttribute("bills_unpaid_count", bills_unpaid_count);

			String web_service_response_est = null;

			web_service_response_est = rent_mgt_service.select_rt_govt_estatesg_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_est = new JSONObject(web_service_response_est);
			String estate_list = web_response_case_est.get("data").toString();
			ArrayList estate_list_list = googleJson.fromJson(estate_list, ArrayList.class);

			request.setAttribute("estate_list", estate_list_list);

			String web_service_response_nt = null;

			web_service_response_nt = rent_mgt_service.select_rt_nature_of_instrument_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_nt = new JSONObject(web_service_response_nt);
			String nature_of_instrument_list = web_response_case_nt.get("data").toString();
			ArrayList nature_of_instrument_list_list = googleJson.fromJson(nature_of_instrument_list, ArrayList.class);

			request.setAttribute("nature_of_instrument_list", nature_of_instrument_list_list);

			String web_service_response_na = null;

			web_service_response_na = rent_mgt_service.select_rt_nature_of_development_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_na = new JSONObject(web_service_response_na);
			String nature_of_development_list = web_response_case_na.get("data").toString();
			ArrayList nature_of_development_list_list = googleJson.fromJson(nature_of_development_list,
					ArrayList.class);

			request.setAttribute("nature_of_development_list", nature_of_development_list_list);

			String web_service_response_us = null;

			web_service_response_us = rent_mgt_service.select_rt_user_category_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_us = new JSONObject(web_service_response_us);
			String user_category_list = web_response_case_us.get("data").toString();
			ArrayList user_category_list_list = googleJson.fromJson(user_category_list, ArrayList.class);

			request.setAttribute("user_category_list", user_category_list_list);

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			String regional_code = (String) session.getAttribute("regional_code");

			String web_service_response_incoming_lessee_update = null;
			web_service_response_incoming_lessee_update = rent_mgt_service
					.select_ground_rent_lessee_information_update_by_region(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), regional_code);

			JSONObject incoming_lessee_update_obj = new JSONObject(web_service_response_incoming_lessee_update);
			String incoming_lessee_update_data = incoming_lessee_update_obj.optString("data", "[]");
			JSONArray incoming_lessee_update_array = new JSONArray(incoming_lessee_update_data);
			ArrayList<Object> incoming_lessee_updates = new ArrayList<>();
			ArrayList<Object> pending_lessee_updates = new ArrayList<>();
			ArrayList<Object> approved_lessee_updates = new ArrayList<>();
			ArrayList<Object> rejected_lessee_updates = new ArrayList<>();

			for (int i = 0; i < incoming_lessee_update_array.length(); i++) {
				JSONObject update = incoming_lessee_update_array.getJSONObject(i);
				Object update_data = googleJson.fromJson(update.toString(), Object.class);
				String review_status = update.optString("review_status", "pending_review").trim().toLowerCase();

				incoming_lessee_updates.add(update_data);
				if (review_status.equals("accepted") || review_status.equals("approved")) {
					approved_lessee_updates.add(update_data);
				} else if (review_status.equals("rejected")) {
					rejected_lessee_updates.add(update_data);
				} else {
					pending_lessee_updates.add(update_data);
				}
			}

			request.setAttribute("total_incoming_lessee_update",
					incoming_lessee_update_obj.optInt("record_count", incoming_lessee_updates.size()));
			request.setAttribute("incoming_lessee_updates", incoming_lessee_updates);
			request.setAttribute("pending_lessee_updates", pending_lessee_updates);
			request.setAttribute("approved_lessee_updates", approved_lessee_updates);
			request.setAttribute("rejected_lessee_updates", rejected_lessee_updates);
			request.setAttribute("pending_lessee_update_count", pending_lessee_updates.size());
			request.setAttribute("approved_lessee_update_count", approved_lessee_updates.size());
			request.setAttribute("rejected_lessee_update_count", rejected_lessee_updates.size());

			request.setAttribute("page_name", "rent_management_dashboard");
					model.addAttribute("content", "../pages/rent_management/rent_management_dashboard.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@PostMapping("/review_ground_rent_lessee_information_update")
	@ResponseBody
	public String review_ground_rent_lessee_information_update(HttpSession session, HttpServletRequest request) {
		JSONObject response = new JSONObject();
		try {
			String user_id = (String) session.getAttribute("userid");
			String reviewed_by = (String) session.getAttribute("fullname");
			if (user_id == null || user_id.trim().isEmpty()) {
				response.put("success", false);
				response.put("message", "Your session has expired. Please sign in again.");
				return response.toString();
			}

			if (reviewed_by == null || reviewed_by.trim().isEmpty()) {
				reviewed_by = user_id;
			}

			String submission_id_value = request.getParameter("submission_id");
			String decision = request.getParameter("decision");
			String review_comment = request.getParameter("review_comment");
			long submission_id = Long.parseLong(submission_id_value);

			JSONObject review_data = new JSONObject();
			review_data.put("submission_id", submission_id);
			review_data.put("decision", decision == null ? "" : decision.trim().toLowerCase());
			review_data.put("reviewed_by", reviewed_by);
			review_data.put("review_comment", review_comment == null ? "" : review_comment.trim());

			String service_response = rent_mgt_service.review_ground_rent_lessee_information_update(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), review_data.toString());
			return new JSONObject(service_response).toString();
		} catch (NumberFormatException e) {
			try {
				response.put("success", false);
				response.put("message", "A valid submission is required.");
			} catch (JSONException ignored) {
			}
			return response.toString();
		} catch (Exception e) {
			try {
				response.put("success", false);
				response.put("message", "The review could not be completed. Please try again.");
			} catch (JSONException ignored) {
			}
			return response.toString();
		}
	}

	@RequestMapping("/rent_management_map")
	@GetMapping
	public String rent_management_maps(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
		String web_service_response = null;

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			//System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			// request.setAttribute("fullname", Ws_url_config.web_fullname);
			// request.setAttribute("userid", Ws_url_config.web_useid);
			// request.setAttribute("division", Ws_url_config.web_division);
			// request.setAttribute("user_level", Ws_url_config.user_level);

			// request.setAttribute("fullname", Ws_url_config.web_fullname);
			// request.setAttribute("userid", Ws_url_config.web_useid);
			// request.setAttribute("division", Ws_url_config.web_division);
			// request.setAttribute("user_level", Ws_url_config.user_level);

			// HttpSession session = request.getSession();

			web_service_response = rent_mgt_service
					.select_rt_govt_estatesg_list(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case = new JSONObject(web_service_response);
			String estate_list = web_response_case.get("data").toString();
			ArrayList estate_list_list = googleJson.fromJson(estate_list, ArrayList.class);

			//String web_service_response_est = null;

			// web_service_response_est = rent_mgt_service.select_rt_govt_estatesg_list(
			// 		cls_url_config.getWeb_service_url_ser(),
			// 		cls_url_config.getWeb_service_url_ser_api_key());
			// JSONObject web_response_case_est = new JSONObject(web_service_response_est);
			// String estate_list = web_response_case_est.get("data").toString();
			// ArrayList estate_list_list = googleJson.fromJson(estate_list, ArrayList.class);

			request.setAttribute("estate_list", estate_list_list);

			String web_service_response_nt = null;

			web_service_response_nt = rent_mgt_service.select_rt_nature_of_instrument_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_nt = new JSONObject(web_service_response_nt);
			String nature_of_instrument_list = web_response_case_nt.get("data").toString();
			ArrayList nature_of_instrument_list_list = googleJson.fromJson(nature_of_instrument_list, ArrayList.class);

			request.setAttribute("nature_of_instrument_list", nature_of_instrument_list_list);

			String web_service_response_na = null;

			web_service_response_na = rent_mgt_service.select_rt_nature_of_development_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_na = new JSONObject(web_service_response_na);
			String nature_of_development_list = web_response_case_na.get("data").toString();
			ArrayList nature_of_development_list_list = googleJson.fromJson(nature_of_development_list,
					ArrayList.class);

			request.setAttribute("nature_of_development_list", nature_of_development_list_list);

			String web_service_response_us = null;

			web_service_response_us = rent_mgt_service.select_rt_user_category_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_us = new JSONObject(web_service_response_us);
			String user_category_list = web_response_case_us.get("data").toString();
			ArrayList user_category_list_list = googleJson.fromJson(user_category_list, ArrayList.class);

			request.setAttribute("user_category_list", user_category_list_list);

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			request.setAttribute("estate_list", estate_list_list);
			request.setAttribute("page_name", "rent_management_maps");
					model.addAttribute("content", "../pages/rent_management/rent_management_maps.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("/rent_application_progress_details")
	@PostMapping
	public String rent_application_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		String web_service_response = null;
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			//System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		String web_service_response_obj = null;
		Gson googleJson = new Gson();
		try {

			String rent_id = request.getParameter("rent_id");
			JSONObject obj = new JSONObject();

			obj.put("rent_id", rent_id);

			web_service_response_obj = rent_mgt_service.select_rent_application_progress_details(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			if (web_service_response_obj != null) {

				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response_obj);

				String data_list = case_obj.get("data").toString();

				request.setAttribute("data_list", data_list);

			}

			web_service_response = rent_mgt_service.select_rt_govt_estatesg_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case = new JSONObject(web_service_response);
			String estate_list = web_response_case.get("data").toString();
			ArrayList estate_list_list = googleJson.fromJson(estate_list, ArrayList.class);

			request.setAttribute("estate_list", estate_list_list);
			request.setAttribute("page_name", "rent_management_dashboard");
					model.addAttribute("content", "../pages/rent_management/rent_application_detail.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("/rent_data_upload")
	@GetMapping
	public String rent_data_upload(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// Check if user allowed for page
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
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			//System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			Gson googleJson = new Gson();
			try {

				String office_region_list = (String) session.getAttribute("office_region_list");
				Gson googleJson_officeregions = new Gson();
				ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
						ArrayList.class);
				request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

				String region_list = (String) session.getAttribute("region_list");
				Gson googleJson_regions = new Gson();
				ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
				request.setAttribute("regionlist", javaArrayListFromGSON_regions);

				String web_service_response_est = null;

				web_service_response_est = rent_mgt_service.select_rt_govt_estatesg_list(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				JSONObject web_response_case_est = new JSONObject(web_service_response_est);
				String estate_list = web_response_case_est.get("data").toString();
				ArrayList estate_list_list = googleJson.fromJson(estate_list, ArrayList.class);

				request.setAttribute("estate_list", estate_list_list);

				Gson googleJson_1 = new Gson();
				// ArrayList javaArrayListFromGSON = googleJson_1.fromJson(all_list,
				// ArrayList.class);
				// request.setAttribute("data_rows", javaArrayListFromGSON);

				request.setAttribute("page_name", "rent_data_upload");
						model.addAttribute("content", "../pages/rent_management/rent_data_upload.jsp"); return "layouts/app";

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {

			// Session is expired
			request.setAttribute("login", "sessionout");
			//System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		return assigenedmenus;

	}

	@RequestMapping("/rent_report_dashboard")
	@GetMapping
	public String rent_report_dashboard(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			JSONObject obj = new JSONObject();

			// obj.put("unit_id", (String) session.getAttribute("unit_id"));
			obj.put("office_region", (String) session.getAttribute("regional_code"));

			NumberFormat numberFormat = NumberFormat.getNumberInstance(new Locale("en", "GH"));
			numberFormat.setMinimumFractionDigits(2); // Ensuring two decimal places

			String web_service_response_menu = null;
			web_service_response_menu = rent_mgt_service
					.select_rent_dashboard_stats(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			JSONObject professioan_dashboard_details_obj;
			professioan_dashboard_details_obj = new JSONObject(web_service_response_menu);
			System.out.println(web_service_response_menu);
			String total_leasee_count = professioan_dashboard_details_obj.get("total_leasee")
					.toString();
			request.setAttribute("total_leasee", total_leasee_count);

			String total_rent_oustanding_count = professioan_dashboard_details_obj.get("total_rent_outstanding")
					.toString();
			double value = Double.parseDouble(total_rent_oustanding_count);
			request.setAttribute("total_rent_outstanding", numberFormat.format(value));

			String estate_outstanding_rent = professioan_dashboard_details_obj.get("estate_outstanding_rent")
					.toString();
			request.setAttribute("estate_outstanding_rent", estate_outstanding_rent);

			// String bills_unpaid_count =
			// professioan_dashboard_details_obj.get("bills_unpaid_count").toString();
			// request.setAttribute("bills_unpaid_count", bills_unpaid_count);

			String web_service_response_est = null;

			web_service_response_est = rent_mgt_service.select_rt_govt_estatesg_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_est = new JSONObject(web_service_response_est);
			String estate_list = web_response_case_est.get("data").toString();
			ArrayList estate_list_list = googleJson.fromJson(estate_list, ArrayList.class);

			request.setAttribute("estate_list", estate_list_list);

			String web_service_response_nt = null;

			web_service_response_nt = rent_mgt_service.select_rt_nature_of_instrument_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_nt = new JSONObject(web_service_response_nt);
			String nature_of_instrument_list = web_response_case_nt.get("data").toString();
			ArrayList nature_of_instrument_list_list = googleJson.fromJson(nature_of_instrument_list, ArrayList.class);

			request.setAttribute("nature_of_instrument_list", nature_of_instrument_list_list);

			String web_service_response_na = null;

			web_service_response_na = rent_mgt_service.select_rt_nature_of_development_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_na = new JSONObject(web_service_response_na);
			String nature_of_development_list = web_response_case_na.get("data").toString();
			ArrayList nature_of_development_list_list = googleJson.fromJson(nature_of_development_list,
					ArrayList.class);

			request.setAttribute("nature_of_development_list", nature_of_development_list_list);

			String web_service_response_us = null;

			web_service_response_us = rent_mgt_service.select_rt_user_category_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_us = new JSONObject(web_service_response_us);
			String user_category_list = web_response_case_us.get("data").toString();
			ArrayList user_category_list_list = googleJson.fromJson(user_category_list, ArrayList.class);

			request.setAttribute("user_category_list", user_category_list_list);

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			request.setAttribute("page_name", "rent_report_dashboard");
					model.addAttribute("content", "../pages/rent_management/rent_reporting_dashboard.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

		/**
	 * Admin review workspace. The regional service remains the source of truth;
	 * this route aggregates one response per region that the session is allowed
	 * to see, rather than accepting region codes from the browser.
	 */
	@RequestMapping("/incoming_lessee_updates")
	@GetMapping
	public String admin_incoming_lessee_updates(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
		// 	request.setAttribute("login", "sessionout");
		// 	model.addAttribute("content", "../auth/login.jsp");
		// 	return "layouts/guest";
		// }

		// if (!canViewAllLesseeUpdates(session)) {
		// 	response.setStatus(HttpServletResponse.SC_FORBIDDEN);
		// 	request.setAttribute("error_title", "Administrator access required");
		// 	request.setAttribute("error_message", "This workspace is available to authorised rent administrators only.");
		// 	model.addAttribute("content", "../errors/403.jsp");
		// 	return "layouts/app";
		// }

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			loadAdminIncomingLesseeUpdates(session, request);
			request.setAttribute("page_name", "admin_incoming_lessee_updates");
			model.addAttribute("content", "../pages/rent_management/admin_incoming_lessee_updates.jsp");
			return "layouts/app";
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_BAD_GATEWAY);
			request.setAttribute("error_title", "Updates unavailable");
			request.setAttribute("error_message", "Incoming lessee updates could not be loaded. Please try again.");
			model.addAttribute("content", "../errors/500.jsp");
			return "layouts/app";
		}
	}

	// private boolean canViewAllLesseeUpdates(HttpSession session) {
	// 	String viewAll = String.valueOf(session.getAttribute("view_all_offices"));
	// 	String userLevel = String.valueOf(session.getAttribute("user_level"));
	// 	String designation = String.valueOf(session.getAttribute("designation"));
	// 	return "true".equalsIgnoreCase(viewAll) || "yes".equalsIgnoreCase(viewAll)
	// 			|| userLevel.toLowerCase(Locale.ROOT).contains("admin")
	// 			|| designation.toLowerCase(Locale.ROOT).contains("admin");
	// }

	private void loadAdminIncomingLesseeUpdates(HttpSession session, HttpServletRequest request) throws Exception {
		Gson gson = new Gson();
		Map<String, String> regions = new LinkedHashMap<>();
		String regionList = (String) session.getAttribute("region_list");
		if (regionList != null && !regionList.trim().isEmpty()) {
			JSONArray regionArray = new JSONArray(regionList);
			for (int i = 0; i < regionArray.length(); i++) {
				JSONObject region = regionArray.optJSONObject(i);
				if (region == null) continue;
				String code = firstNonBlank(region.optString("regional_code"), region.optString("region_code"),
						region.optString("code"));
				String name = firstNonBlank(region.optString("region"), region.optString("regional_name"),
						region.optString("name"), code);
				if (!code.isEmpty()) regions.putIfAbsent(code, name);
			}
		}
		String currentRegion = String.valueOf(session.getAttribute("regional_code"));
		if (regions.isEmpty() && !currentRegion.isBlank() && !"null".equalsIgnoreCase(currentRegion)) {
			regions.put(currentRegion, String.valueOf(session.getAttribute("regional_name")));
		}

		List<Object> updates = new ArrayList<>();
		Set<String> seenSubmissionIds = new LinkedHashSet<>();
		Map<String, Integer> regionCounts = new LinkedHashMap<>();
		for (Map.Entry<String, String> region : regions.entrySet()) {
			String raw = rent_mgt_service.select_ground_rent_lessee_information_update_by_region(
					cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), region.getKey());
			if (raw == null || raw.isBlank() || "Data Not Received".equalsIgnoreCase(raw.trim())) continue;
			JSONObject payload = new JSONObject(raw);
			JSONArray rows = new JSONArray(payload.optString("data", "[]"));
			int regionCount = 0;
			for (int i = 0; i < rows.length(); i++) {
				JSONObject row = rows.optJSONObject(i);
				if (row == null) continue;
				String submissionId = row.optString("submission_id", "");
				if (!submissionId.isBlank() && !seenSubmissionIds.add(submissionId)) continue;
				if (row.optString("region").isBlank()) row.put("region", region.getValue());
				if (row.optString("regional_code").isBlank()) row.put("regional_code", region.getKey());
				updates.add(gson.fromJson(row.toString(), Object.class));
				regionCount++;
			}
			regionCounts.put(region.getKey(), regionCount);
		}

		List<Object> pending = new ArrayList<>(), approved = new ArrayList<>(), rejected = new ArrayList<>();
		for (Object value : updates) {
			JSONObject row = new JSONObject(gson.toJson(value));
			String status = row.optString("review_status", "pending_review").trim().toLowerCase(Locale.ROOT);
			if ("accepted".equals(status) || "approved".equals(status)) approved.add(value);
			else if ("rejected".equals(status)) rejected.add(value);
			else pending.add(value);
		}
		request.setAttribute("incoming_lessee_updates", updates);
		request.setAttribute("pending_lessee_updates", pending);
		request.setAttribute("approved_lessee_updates", approved);
		request.setAttribute("rejected_lessee_updates", rejected);
		request.setAttribute("pending_lessee_update_count", pending.size());
		request.setAttribute("approved_lessee_update_count", approved.size());
		request.setAttribute("rejected_lessee_update_count", rejected.size());
		request.setAttribute("total_incoming_lessee_update", updates.size());
		request.setAttribute("admin_lessee_region_counts", regionCounts);
		request.setAttribute("admin_lessee_region_options", regions);
	}

	private String firstNonBlank(String... values) {
		for (String value : values) if (value != null && !value.isBlank() && !"null".equalsIgnoreCase(value)) return value.trim();
		return "";
	}

}
