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

			String total_rent_oustanding_count = professioan_dashboard_details_obj.get("total_rent_oustanding")
					.toString();
			double value = Double.parseDouble(total_rent_oustanding_count);
			request.setAttribute("total_rent_oustanding", numberFormat.format(value));

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

			request.setAttribute("page_name", "rent_management_dashboard");
					model.addAttribute("content", "../pages/rent_management/rent_management_dashboard.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

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
			System.out.println("If Not success");
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
			System.out.println("If Not success");
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
			System.out.println("If Not success");
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
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		return assigenedmenus;

	}

}
