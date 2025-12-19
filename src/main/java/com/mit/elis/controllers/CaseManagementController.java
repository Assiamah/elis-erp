package com.mit.elis.controllers;

import java.io.File;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.jfree.chart.title.Title;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import ws.casemgt.cls_licensed_surveyors;
import ws.ws_valueadded_services.cls_valueadded_services;

@Controller
public class CaseManagementController {

	@Autowired
	private Ws_url_config cls_url_config;

	cls_casemgt casemagt_cl = new cls_casemgt();
	cls_valueadded_services vas_cl = new cls_valueadded_services();
	Ws_client_application user_web_service = new Ws_client_application();

	@RequestMapping("/financial_document_application")
	@PostMapping
	public String financial_document_application(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

		try {

			String web_service_response = null;
			Gson googleJson = new Gson();

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			// System.out.println(case_number);

			JSONObject obj = new JSONObject();

			obj.put("case_number", case_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			// System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				// System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);
				String main_details = case_obj.get("main_details").toString();
				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				
				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				request.setAttribute("main_details", main_details);
				request.setAttribute("job_details", job_details_list);
				request.setAttribute("parcels_coordinates", parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				JSONObject main_detailse_obj;
				main_detailse_obj = new JSONObject(main_details);

				request.setAttribute("application_stage", main_detailse_obj.get("application_stage").toString());
				request.setAttribute("case_number", main_detailse_obj.get("case_number").toString());
				request.setAttribute("glpin", main_detailse_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number",
						main_detailse_obj.get("licensed_surveyor_number").toString());
				request.setAttribute("regional_number", main_detailse_obj.get("regional_number").toString());
				request.setAttribute("locality", main_detailse_obj.get("locality").toString());
				request.setAttribute("district", main_detailse_obj.get("district").toString());
				request.setAttribute("region", main_detailse_obj.get("region").toString());
				request.setAttribute("size_of_land", main_detailse_obj.get("size_of_land").toString());
				request.setAttribute("date_of_document", main_detailse_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument", main_detailse_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number", main_detailse_obj.get("certificate_number").toString());
				request.setAttribute("extent", main_detailse_obj.get("extent").toString());
				request.setAttribute("registry_mapref", main_detailse_obj.get("registry_mapref").toString());
				request.setAttribute("type_of_interest", main_detailse_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", main_detailse_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", main_detailse_obj.get("volume_number").toString());
				request.setAttribute("folio_number", main_detailse_obj.get("folio_number").toString());
				request.setAttribute("term", main_detailse_obj.get("term").toString());
				request.setAttribute("commencement_date", main_detailse_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", main_detailse_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", main_detailse_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable", main_detailse_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", main_detailse_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", main_detailse_obj.get("locality").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", main_detailse_obj.get("publicity_date").toString());
				request.setAttribute("plan_no", main_detailse_obj.get("plan_no").toString());
				request.setAttribute("cc_no", main_detailse_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", main_detailse_obj.get("ltr_plan_no").toString());
				request.setAttribute("family_of_grantor", main_detailse_obj.get("family_of_grantor").toString());
				request.setAttribute("locality_class", main_detailse_obj.get("locality_class").toString());
				request.setAttribute("rent_review_period", main_detailse_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", main_detailse_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered", main_detailse_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", main_detailse_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						main_detailse_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", main_detailse_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", main_detailse_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration", main_detailse_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", main_detailse_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", main_detailse_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// main_detailse_obj.get("is_part_of_gelis_area").toString());
				// request.setAttribute("stamp_duty_description",
				// main_detailse_obj.get("stamp_duty_description").toString());
				request.setAttribute("registration_district_number",
						main_detailse_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						main_detailse_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						main_detailse_obj.get("registration_block_number").toString());

			} else {
				System.out.println(web_service_response);
			}

			request.setAttribute("page_name", "case_processing");

					model.addAttribute("content", "../pages/client_application/financial_document_application.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/landed_inspection_application")
	@PostMapping
	public String landed_inspection_application(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			System.out.println(case_number);

			JSONObject obj = new JSONObject();

			obj.put("case_number", case_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);
				String main_details = case_obj.get("main_details").toString();
				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				request.setAttribute("main_details", main_details);
				request.setAttribute("job_details", job_details_list);
				request.setAttribute("parcels_coordinates", parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				JSONObject main_detailse_obj;
				main_detailse_obj = new JSONObject(main_details);

				request.setAttribute("application_stage", main_detailse_obj.get("application_stage").toString());
				request.setAttribute("case_number", main_detailse_obj.get("case_number").toString());
				request.setAttribute("glpin", main_detailse_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number",
						main_detailse_obj.get("licensed_surveyor_number").toString());
				request.setAttribute("regional_number", main_detailse_obj.get("regional_number").toString());
				request.setAttribute("locality", main_detailse_obj.get("locality").toString());
				request.setAttribute("district", main_detailse_obj.get("district").toString());
				request.setAttribute("region", main_detailse_obj.get("region").toString());
				request.setAttribute("size_of_land", main_detailse_obj.get("size_of_land").toString());
				request.setAttribute("date_of_document", main_detailse_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument", main_detailse_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number", main_detailse_obj.get("certificate_number").toString());
				request.setAttribute("extent", main_detailse_obj.get("extent").toString());
				request.setAttribute("registry_mapref", main_detailse_obj.get("registry_mapref").toString());
				request.setAttribute("type_of_interest", main_detailse_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", main_detailse_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", main_detailse_obj.get("volume_number").toString());
				request.setAttribute("folio_number", main_detailse_obj.get("folio_number").toString());
				request.setAttribute("term", main_detailse_obj.get("term").toString());
				request.setAttribute("commencement_date", main_detailse_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", main_detailse_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", main_detailse_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable", main_detailse_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", main_detailse_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", main_detailse_obj.get("locality").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", main_detailse_obj.get("publicity_date").toString());
				request.setAttribute("plan_no", main_detailse_obj.get("plan_no").toString());
				request.setAttribute("cc_no", main_detailse_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", main_detailse_obj.get("ltr_plan_no").toString());
				request.setAttribute("family_of_grantor", main_detailse_obj.get("family_of_grantor").toString());
				request.setAttribute("locality_class", main_detailse_obj.get("locality_class").toString());
				request.setAttribute("rent_review_period", main_detailse_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", main_detailse_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered", main_detailse_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", main_detailse_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						main_detailse_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", main_detailse_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", main_detailse_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration", main_detailse_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", main_detailse_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", main_detailse_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// main_detailse_obj.get("is_part_of_gelis_area").toString());
				// request.setAttribute("stamp_duty_description",
				// main_detailse_obj.get("stamp_duty_description").toString());
				request.setAttribute("registration_district_number",
						main_detailse_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						main_detailse_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						main_detailse_obj.get("registration_block_number").toString());
				request.setAttribute("job_number", job_number);

			} else {
				System.out.println(web_service_response);
			}

			request.setAttribute("page_name", "case_processing");
					model.addAttribute("content", "../pages/client_application/landed_inspection_application.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/landed_non_inspection_application")
	@PostMapping
	public String landed_non_inspection_application(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			System.out.println(case_number);

			JSONObject obj = new JSONObject();

			obj.put("case_number", case_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);
				String main_details = case_obj.get("main_details").toString();
				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				request.setAttribute("main_details", main_details);
				request.setAttribute("job_details", job_details_list);
				request.setAttribute("parcels_coordinates", parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				JSONObject main_detailse_obj;
				main_detailse_obj = new JSONObject(main_details);

				request.setAttribute("application_stage", main_detailse_obj.get("application_stage").toString());
				request.setAttribute("case_number", main_detailse_obj.get("case_number").toString());
				request.setAttribute("glpin", main_detailse_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number",
						main_detailse_obj.get("licensed_surveyor_number").toString());
				request.setAttribute("regional_number", main_detailse_obj.get("regional_number").toString());
				request.setAttribute("locality", main_detailse_obj.get("locality").toString());
				request.setAttribute("district", main_detailse_obj.get("district").toString());
				request.setAttribute("region", main_detailse_obj.get("region").toString());
				request.setAttribute("size_of_land", main_detailse_obj.get("size_of_land").toString());
				request.setAttribute("date_of_document", main_detailse_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument", main_detailse_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number", main_detailse_obj.get("certificate_number").toString());
				request.setAttribute("extent", main_detailse_obj.get("extent").toString());
				request.setAttribute("registry_mapref", main_detailse_obj.get("registry_mapref").toString());
				request.setAttribute("type_of_interest", main_detailse_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", main_detailse_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", main_detailse_obj.get("volume_number").toString());
				request.setAttribute("folio_number", main_detailse_obj.get("folio_number").toString());
				request.setAttribute("term", main_detailse_obj.get("term").toString());
				request.setAttribute("commencement_date", main_detailse_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", main_detailse_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", main_detailse_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable", main_detailse_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", main_detailse_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", main_detailse_obj.get("locality").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", main_detailse_obj.get("publicity_date").toString());
				request.setAttribute("plan_no", main_detailse_obj.get("plan_no").toString());
				request.setAttribute("cc_no", main_detailse_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", main_detailse_obj.get("ltr_plan_no").toString());
				request.setAttribute("family_of_grantor", main_detailse_obj.get("family_of_grantor").toString());
				request.setAttribute("locality_class", main_detailse_obj.get("locality_class").toString());
				request.setAttribute("rent_review_period", main_detailse_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", main_detailse_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered", main_detailse_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", main_detailse_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						main_detailse_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", main_detailse_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", main_detailse_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration", main_detailse_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", main_detailse_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", main_detailse_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// main_detailse_obj.get("is_part_of_gelis_area").toString());
				// request.setAttribute("stamp_duty_description",
				// main_detailse_obj.get("stamp_duty_description").toString());
				request.setAttribute("registration_district_number",
						main_detailse_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						main_detailse_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						main_detailse_obj.get("registration_block_number").toString());

			} else {
				System.out.println(web_service_response);
			}

			request.setAttribute("page_name", "case_processing");
					model.addAttribute("content", "../pages/client_application/landed_non_inspection_application.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/light_document_application")
	@PostMapping
	public String light_document_application(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			System.out.println(case_number);

			JSONObject obj = new JSONObject();

			obj.put("case_number", case_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);
				String main_details = case_obj.get("main_details").toString();
				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				request.setAttribute("main_details", main_details);
				request.setAttribute("job_details", job_details_list);
				request.setAttribute("parcels_coordinates", parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				JSONObject main_detailse_obj;
				main_detailse_obj = new JSONObject(main_details);

				request.setAttribute("application_stage", main_detailse_obj.get("application_stage").toString());
				request.setAttribute("case_number", main_detailse_obj.get("case_number").toString());
				request.setAttribute("glpin", main_detailse_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number",
						main_detailse_obj.get("licensed_surveyor_number").toString());
				request.setAttribute("regional_number", main_detailse_obj.get("regional_number").toString());
				request.setAttribute("locality", main_detailse_obj.get("locality").toString());
				request.setAttribute("district", main_detailse_obj.get("district").toString());
				request.setAttribute("region", main_detailse_obj.get("region").toString());
				request.setAttribute("size_of_land", main_detailse_obj.get("size_of_land").toString());
				request.setAttribute("date_of_document", main_detailse_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument", main_detailse_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number", main_detailse_obj.get("certificate_number").toString());
				request.setAttribute("extent", main_detailse_obj.get("extent").toString());
				request.setAttribute("registry_mapref", main_detailse_obj.get("registry_mapref").toString());
				request.setAttribute("type_of_interest", main_detailse_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", main_detailse_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", main_detailse_obj.get("volume_number").toString());
				request.setAttribute("folio_number", main_detailse_obj.get("folio_number").toString());
				request.setAttribute("term", main_detailse_obj.get("term").toString());
				request.setAttribute("commencement_date", main_detailse_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", main_detailse_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", main_detailse_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable", main_detailse_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", main_detailse_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", main_detailse_obj.get("locality").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", main_detailse_obj.get("publicity_date").toString());
				request.setAttribute("plan_no", main_detailse_obj.get("plan_no").toString());
				request.setAttribute("cc_no", main_detailse_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", main_detailse_obj.get("ltr_plan_no").toString());
				request.setAttribute("family_of_grantor", main_detailse_obj.get("family_of_grantor").toString());
				request.setAttribute("locality_class", main_detailse_obj.get("locality_class").toString());
				request.setAttribute("rent_review_period", main_detailse_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", main_detailse_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered", main_detailse_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", main_detailse_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						main_detailse_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", main_detailse_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", main_detailse_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration", main_detailse_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", main_detailse_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", main_detailse_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// main_detailse_obj.get("is_part_of_gelis_area").toString());
				// request.setAttribute("stamp_duty_description",
				// main_detailse_obj.get("stamp_duty_description").toString());
				request.setAttribute("registration_district_number",
						main_detailse_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						main_detailse_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						main_detailse_obj.get("registration_block_number").toString());

			} else {
				System.out.println(web_service_response);
			}

			request.setAttribute("page_name", "case_processing");
					model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/mortgage_application")
	@PostMapping
	public String mortgage_application(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			System.out.println(case_number);

			JSONObject obj = new JSONObject();

			obj.put("case_number", case_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);
				String main_details = case_obj.get("main_details").toString();
				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				request.setAttribute("main_details", main_details);
				request.setAttribute("job_details", job_details_list);
				request.setAttribute("parcels_coordinates", parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				JSONObject main_detailse_obj;
				main_detailse_obj = new JSONObject(main_details);

				request.setAttribute("application_stage", main_detailse_obj.get("application_stage").toString());
				request.setAttribute("case_number", main_detailse_obj.get("case_number").toString());
				request.setAttribute("glpin", main_detailse_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number",
						main_detailse_obj.get("licensed_surveyor_number").toString());
				request.setAttribute("regional_number", main_detailse_obj.get("regional_number").toString());
				request.setAttribute("locality", main_detailse_obj.get("locality").toString());
				request.setAttribute("district", main_detailse_obj.get("district").toString());
				request.setAttribute("region", main_detailse_obj.get("region").toString());
				request.setAttribute("size_of_land", main_detailse_obj.get("size_of_land").toString());
				request.setAttribute("date_of_document", main_detailse_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument", main_detailse_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number", main_detailse_obj.get("certificate_number").toString());
				request.setAttribute("extent", main_detailse_obj.get("extent").toString());
				request.setAttribute("registry_mapref", main_detailse_obj.get("registry_mapref").toString());
				request.setAttribute("type_of_interest", main_detailse_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", main_detailse_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", main_detailse_obj.get("volume_number").toString());
				request.setAttribute("folio_number", main_detailse_obj.get("folio_number").toString());
				request.setAttribute("term", main_detailse_obj.get("term").toString());
				request.setAttribute("commencement_date", main_detailse_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", main_detailse_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", main_detailse_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable", main_detailse_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", main_detailse_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", main_detailse_obj.get("locality").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", main_detailse_obj.get("publicity_date").toString());
				request.setAttribute("plan_no", main_detailse_obj.get("plan_no").toString());
				request.setAttribute("cc_no", main_detailse_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", main_detailse_obj.get("ltr_plan_no").toString());
				request.setAttribute("family_of_grantor", main_detailse_obj.get("family_of_grantor").toString());
				request.setAttribute("locality_class", main_detailse_obj.get("locality_class").toString());
				request.setAttribute("rent_review_period", main_detailse_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", main_detailse_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered", main_detailse_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", main_detailse_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						main_detailse_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", main_detailse_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", main_detailse_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration", main_detailse_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", main_detailse_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", main_detailse_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// main_detailse_obj.get("is_part_of_gelis_area").toString());
				// request.setAttribute("stamp_duty_description",
				// main_detailse_obj.get("stamp_duty_description").toString());
				request.setAttribute("registration_district_number",
						main_detailse_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						main_detailse_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						main_detailse_obj.get("registration_block_number").toString());

			} else {
				System.out.println(web_service_response);
			}
			request.setAttribute("page_name", "case_processing");
					model.addAttribute("content", "../pages/client_application/mortgage_application.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/publication_management")
	@GetMapping
	public String publication_management(HttpSession session, Model model, HttpServletRequest request,
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
		try {

			cls_casemgt casemgt_web_service = new cls_casemgt();
			String web_service_response_publication = null;
			// String web_service_response_awaiting_date_list = null;
			// select_load_application_for_publication_management
			web_service_response_publication = casemgt_web_service
					.select_load_application_for_publication_management(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							(String) session.getAttribute("regional_code"));

			JSONObject applications_obj;
			applications_obj = new JSONObject(web_service_response_publication);

			String all_list = applications_obj.get("ready_for_publication_list").toString();
			String all_list2 = applications_obj.get("awaiting_publication_date_list").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_list, ArrayList.class);
			ArrayList javaArrayListFromGSON2 = googleJson.fromJson(all_list2, ArrayList.class);

			// System.out.printf("ready_for_publication_list : " +
			// javaArrayListFromGSON);
			// System.out.printf("awaiting_publication_date_list : " +
			// javaArrayListFromGSON);
			// System.out.printf("published_but_not_worked_on : " +
			// applications_obj.get("published_but_not_worked_on".toString()));

			request.setAttribute("ready_for_publication_list", javaArrayListFromGSON);
			request.setAttribute("awaiting_publication_date_list", javaArrayListFromGSON2);
			request.setAttribute("published_but_not_worked_on",
					applications_obj.get("published_but_not_worked_on".toString()));
			request.setAttribute("page_name", "publication_management");

					model.addAttribute("content", "../pages/client_application/publication_management.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/registration_application_progress_details_cst")
	@PostMapping
	public String registration_application_progress_details_cst(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				// System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				// System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject(parcel_details);

				String new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());
				/*
				 * request.setAttribute("created_date",
				 * transaction_details_obj.get("created_date").toString());
				 */
				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());

				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());

				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());

				JSONArray arr_r = new JSONArray();
				request.setAttribute("page_name", "case_processing");

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				// JSONArray arr_r_public = new JSONArray();
				// String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// // System.out.println("folderpath: " +folderpath);
				// // List All Files In a Folder
				// File subdir_public = new File(folderpath_public.toString());
				// String[] children_public = subdir_public.list();
				// if (children_public == null) {
				// 	System.out.println("Either dir does not exist or is not a directory");
				// } else {
				// 	for (int j = 0; j < children_public.length; j++) {
				// 		String filename_doc_public = children_public[j];
				// 		System.out.println("case_number: " + case_number);
				// 		System.out.println("File: " + filename_doc_public);
				// 		String path = folderpath_public.toString() + "/" + filename_doc_public;

				// 		String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
				// 		JSONObject obj_r = new JSONObject();
				// 		// obj_r.put( "d_id" , 0 );
				// 		// obj_r.put( "job_number" , "SMDGARGA37542018" );
				// 		// obj_r.put( "case_number" , "LCGARGACN37542018" );
				// 		obj_r.put("document_name", filename_doc_public);
				// 		obj_r.put("document_type", path);
				// 		obj_r.put("document_extention", extension);
				// 		obj_r.put("document_file", path);
				// 		obj_r.put("uploaded_by", "");
				// 		obj_r.put("uploaded_date", "");

				// 		arr_r_public.put(obj_r);
				// 	}

				// }
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

				// request.setAttribute("page_name",
				// "first_registration_record_verification");

						model.addAttribute("content", "../pages/client_application/registration_application_progress_details_cst.jsp"); return "layouts/app";

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/registration_application_progress_details_frrv_cst")
	@PostMapping
	public String registration_application_progress_details_frrv_cst(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				// System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				// System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject(parcel_details);

				String new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());
				/*
				 * request.setAttribute("created_date",
				 * transaction_details_obj.get("created_date").toString());
				 */
				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());

				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());

				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());

				JSONArray arr_r = new JSONArray();
				request.setAttribute("page_name", "case_processing");

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

				// request.setAttribute("page_name",
				// "first_registration_record_verification");

						model.addAttribute("content", "../pages/client_application/registration_application_progress_details_frrv_cst.jsp"); return "layouts/app";

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/registration_application_progress_details_frrv")
	@PostMapping
	public String registration_application_progress_details_1(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				// System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				// System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject(parcel_details);

				String new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());
				/*
				 * request.setAttribute("created_date",
				 * transaction_details_obj.get("created_date").toString());
				 */
				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());

				System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());

				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());

				JSONArray arr_r = new JSONArray();
				request.setAttribute("page_name", "case_processing");

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

				// request.setAttribute("page_name",
				// "first_registration_record_verification");

				if (business_process_sub_name.equals("APPLICATION FOR REGIONAL NUMBER")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PLAN APPROVAL")) {
							model.addAttribute("content", "../pages/client_application/plan_approval_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION (STOOL)")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_frrv.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION (FAMILY)")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_frrv.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION")) {

							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_frrv.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PART TRANSFER")) {
							model.addAttribute("content", "../pages/client_application/part_transfer_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR WHOLE TRANFER")) {
							model.addAttribute("content", "../pages/client_application/part_transfer_progress_details.jsp"); return "layouts/app";
					//		model.addAttribute("content", "../pages/client_application/whole_transfer_progress_details.jsp"); return "layouts/app";


				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR MORTGAGES")) {
							model.addAttribute("content", "../pages/client_application/mortgage_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR DISCHARGE")) {
							model.addAttribute("content", "../pages/client_application/discharge_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CAVEAT OR RESTRICTION")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OBJECTION")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SUBSTITUTED CERTIFICATE")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(NON LANDED DOCUMENTS)")) {
							model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(FINANCIAL DOCUMENTS)")) {
							model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(LANDED INSPECTION CASES)")) {
							model.addAttribute("content", "../pages/client_application/landed_inspection_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(LANDED NON INSPECTION CASES)")) {
							model.addAttribute("content", "../pages/client_application/landed_non_inspection_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CONCURRENCE")) {
							model.addAttribute("content", "../pages/client_application/application_concurrence_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name
						.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (WHOLE SITE)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name
						.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (PORTION OR PART)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process_part.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("")) {
					/*
					 * return
					 * "/client_application/general_application_without_major_process.jsp"
					 * );
					 */

							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_frrv.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN (JUDICIAL SALE)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO MORTGAGE")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				}

				else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO VEST (VESTING ASSENT)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION")) {
							model.addAttribute("content", "../pages/client_application/application_lease_preparation_process.jsp"); return "layouts/app";

				}

				else if (business_process_sub_name.equals("APPLICATION FOR LEASE")) {
							model.addAttribute("content", "../pages/client_application/application_lease_preparation_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CERTIFIED TRUE COPY")) {
							model.addAttribute("content", "../pages/client_application/certified_true_copy_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR ASSESSMENT AND PAYMENT OF GROUND RENT")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR RE PRINT OF TITLE OR APPROVED PLAN")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR APPROVAL OF TITLE PLAN")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				}

				else if (business_process_sub_name.equals("APPLICATION FOR REGIONAL NUMBER FOR OFFICIAL SURVEYS")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH(PERMIT)")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CERTIFICATE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/certificate_search_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR ADMINISTRATIVE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PERMIT SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD OFFICIAL SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD PERMIT SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD POLICE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD ADMINISTRATIVE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD PERMIT SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD ADMINISTRATIVE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD POLICE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD CERTIFICATE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/certificate_search_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SUPPLEMENTARY LODGEMENT")) {
							model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION UP TO TITLE REGISTRATION")) {
							model.addAttribute("content", "../pages/client_application/application_for_regularization_to_title_registration.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD PLOTTING")) {
							model.addAttribute("content", "../pages/client_application/application_for_pvlmd_plotting.jsp"); return "layouts/app";

				} else {
					/*
					 * return
					 * "/client_application/general_application_without_major_process.jsp"
					 * );
					 */

							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_frrv.jsp"); return "layouts/app";

				}

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";

	}

	@RequestMapping("/registration_application_progress_details_tpp")
	@PostMapping
	public String registration_application_progress_details_tpp(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			String web_service_response_tpp = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				// System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject();
				if (parcel_details != "null") {
					parcel_details_obj = new JSONObject(parcel_details);
				}

				String new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject transaction_details_obj;

				transaction_details_obj = new JSONObject(transaction_details);
				if (transaction_details != "null") {
					transaction_details_obj = new JSONObject(transaction_details);
				}

				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());
				/*
				 * request.setAttribute("created_date",
				 * transaction_details_obj.get("created_date").toString());
				 */
				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				if (job_detail != "null") {
					job_detail_obj = new JSONObject(job_detail);
				}
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());

				System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());

				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());

				web_service_response_tpp = casemagt_cl
						.load_application_stage_tpp(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), batchlistdivison);
				String vr_job_status = null;

				if (web_service_response_tpp != null) {
					JSONObject case_obj_tpp;
					case_obj_tpp = new JSONObject(web_service_response_tpp);

					vr_job_status = case_obj_tpp.get("vr_job_status").toString();
					request.setAttribute("vr_job_status", vr_job_status);

				}

				JSONArray arr_r = new JSONArray();
				request.setAttribute("page_name", "case_processing");

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

				// request.setAttribute("page_name",
				// "first_registration_record_verification");

				if (business_process_sub_name.equals("APPLICATION FOR REGIONAL NUMBER")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PLAN APPROVAL")) {
							model.addAttribute("content", "../pages/client_application/plan_approval_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION (STOOL)")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_tpp.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION (FAMILY)")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_tpp.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION")) {

							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_tpp.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PART TRANSFER")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_tpp.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR WHOLE TRANFER")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_tpp.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_tpp.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR MORTGAGES")) {
							model.addAttribute("content", "../pages/client_application/mortgage_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR DISCHARGE")) {
					//		model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
							model.addAttribute("content", "../pages/client_application/discharge_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CAVEAT OR RESTRICTION")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OBJECTION")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SUBSTITUTED CERTIFICATE")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(NON LANDED DOCUMENTS)")) {
							model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(FINANCIAL DOCUMENTS)")) {
							model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(LANDED INSPECTION CASES)")) {
							model.addAttribute("content", "../pages/client_application/landed_inspection_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(LANDED NON INSPECTION CASES)")) {
							model.addAttribute("content", "../pages/client_application/landed_non_inspection_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CONCURRENCE")) {
							model.addAttribute("content", "../pages/client_application/application_concurrence_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name
						.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (WHOLE SITE)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name
						.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (PORTION OR PART)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process_part.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("")) {
					/*
					 * return
					 * "/client_application/general_application_without_major_process.jsp"
					 * );
					 */

							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_frrv.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN (JUDICIAL SALE)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO MORTGAGE")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				}

				else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO VEST (VESTING ASSENT)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION")) {
							model.addAttribute("content", "../pages/client_application/application_lease_preparation_process.jsp"); return "layouts/app";

				}

				else if (business_process_sub_name.equals("APPLICATION FOR LEASE")) {
							model.addAttribute("content", "../pages/client_application/application_lease_preparation_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CERTIFIED TRUE COPY")) {
							model.addAttribute("content", "../pages/client_application/certified_true_copy_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR ASSESSMENT AND PAYMENT OF GROUND RENT")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR RE PRINT OF TITLE OR APPROVED PLAN")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR APPROVAL OF TITLE PLAN")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				}

				else if (business_process_sub_name.equals("APPLICATION FOR REGIONAL NUMBER FOR OFFICIAL SURVEYS")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH(PERMIT)")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CERTIFICATE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/certificate_search_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR ADMINISTRATIVE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PERMIT SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD OFFICIAL SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD PERMIT SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD POLICE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD ADMINISTRATIVE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD PERMIT SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD ADMINISTRATIVE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD POLICE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD CERTIFICATE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/certificate_search_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SUPPLEMENTARY LODGEMENT")) {
							model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
				} else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION UP TO TITLE REGISTRATION")) {
							model.addAttribute("content", "../pages/client_application/application_for_regularization_to_title_registration.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD PLOTTING")) {
							model.addAttribute("content", "../pages/client_application/application_for_pvlmd_plotting.jsp"); return "layouts/app";

				} else {
					/*
					 * return
					 * "/client_application/general_application_without_major_process.jsp"
					 * );
					 */

							model.addAttribute("content", "../pages/client_application/registration_application_progress_details_frrv.jsp"); return "layouts/app";

				}

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/registration_application_progress_details")
	@PostMapping
	public String registration_application_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();

				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String outgoing_sms = case_obj.get("outgoing_sms").toString();




				
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();
				String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
				String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
				String compliance_query_status = case_obj.get("compliance_query_status").toString();

				//System.out.println(compliance_query_status);

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
						ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
						ArrayList.class);


						ArrayList outgoing_sms_list = googleJson.fromJson(outgoing_sms, ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
				ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
				ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
						ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
				request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);
				request.setAttribute("outgoing_sms", outgoing_sms_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
				request.setAttribute("certificete_approval_status",
						case_obj.get("certificete_approval_status").toString());
				request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());

				request.setAttribute("compliance_query_status", compliance_query_status);

				// System.out.println(case_obj.get("parcel_wkt").toString());
				String new_case_number = "";
				JSONObject parcel_details_obj;

				parcel_details_obj = new JSONObject(parcel_details);

				new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				request.setAttribute("parcel_remarks",
						parcel_details_obj.get("remarks").toString());

				request.setAttribute("smd_reference_number",
						parcel_details_obj.get("smd_reference_number").toString());
				request.setAttribute("smd_type_of_plotting",
						parcel_details_obj.get("smd_type_of_plotting").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				request.setAttribute("considertion_fee_adopted_rate",
						transaction_details_obj.get("considertion_fee_adopted_rate").toString());

				request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
	

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());
				request.setAttribute("smd_licensed_surveyor_name",
						job_detail_obj.get("smd_licensed_surveyor_name").toString());
				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}

				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

				if (business_process_sub_name.equals("APPLICATION FOR REGIONAL NUMBER")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PLAN APPROVAL")) {
							model.addAttribute("content", "../pages/client_application/plan_approval_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION (STOOL)")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION (FAMILY)")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION")) {

							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PART TRANSFER")) {
							model.addAttribute("content", "../pages/client_application/part_transfer_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR WHOLE TRANFER")) {
							model.addAttribute("content", "../pages/client_application/part_transfer_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION")) {
							model.addAttribute("content", "../pages/client_application/application_for_deed_registration.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION WITH CONSENT")) {
							model.addAttribute("content", "../pages/client_application/application_for_deed_registration_with_consent.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION WITH CONCURRENCE")) {
							model.addAttribute("content", "../pages/client_application/application_for_deed_registration_with_concurrence.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION ON FAMILY LAND")) {
							model.addAttribute("content", "../pages/client_application/application_for_deed_registration_on_family_land.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR MORTGAGES")) {
							model.addAttribute("content", "../pages/client_application/mortgage_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR DISCHARGE")) {
					//		model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
							model.addAttribute("content", "../pages/client_application/discharge_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CAVEAT OR RESTRICTION")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OBJECTION")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SUBSTITUTED CERTIFICATE")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(NON LANDED DOCUMENTS)")) {
							model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(FINANCIAL DOCUMENTS)")) {
							model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(LANDED INSPECTION CASES)")) {
							model.addAttribute("content", "../pages/client_application/landed_inspection_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(LANDED NON INSPECTION CASES)")) {
							model.addAttribute("content", "../pages/client_application/landed_non_inspection_application.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CONCURRENCE")) {
							model.addAttribute("content", "../pages/client_application/application_concurrence_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name
						.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (WHOLE SITE)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name
						.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (PORTION OR PART)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process_part.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("")) {
							model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN (JUDICIAL SALE)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO MORTGAGE")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				}

				else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO VEST (VESTING ASSENT)")) {
							model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION")) {
							model.addAttribute("content", "../pages/client_application/application_lease_preparation_process.jsp"); return "layouts/app";

				}

				else if (business_process_sub_name.equals("APPLICATION FOR LEASE")) {
							model.addAttribute("content", "../pages/client_application/application_lease_preparation_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CERTIFIED TRUE COPY")) {
							model.addAttribute("content", "../pages/client_application/certified_true_copy_process.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR ASSESSMENT AND PAYMENT OF GROUND RENT")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR RE PRINT OF TITLE OR APPROVED PLAN")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR APPROVAL OF TITLE PLAN")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				}

				else if (business_process_sub_name.equals("APPLICATION FOR REGIONAL NUMBER FOR OFFICIAL SURVEYS")) {
							model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH(PERMIT)")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR CERTIFICATE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/certificate_search_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR ADMINISTRATIVE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PERMIT SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD OFFICIAL SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD PERMIT SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD POLICE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD ADMINISTRATIVE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD PERMIT SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD ADMINISTRATIVE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD POLICE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD CERTIFICATE SEARCH")) {
							model.addAttribute("content", "../pages/client_application/certificate_search_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
							model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR SUPPLEMENTARY LODGEMENT")) {
							model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
				} else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION UP TO TITLE REGISTRATION")) {
							model.addAttribute("content", "../pages/client_application/application_for_regularization_to_title_registration.jsp"); return "layouts/app";

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD PLOTTING")) {
							model.addAttribute("content", "../pages/client_application/application_for_pvlmd_plotting.jsp"); return "layouts/app";

				} else {
							model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";

				}

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}

	
	@RequestMapping("/motherfile_application_progress_details")
	@PostMapping
	public String motherfile_application_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");
			String job_purpose = request.getParameter("job_purpose");
			String review_instruction = request.getParameter("review_instruction");
			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */
			System.out.println(review_instruction);
			request.setAttribute("job_purpose", job_purpose);
			request.setAttribute("review_instruction", review_instruction);

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			obj.put("job_purpose", job_purpose);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details_new_app_flow(cls_url_config.getWeb_service_url_ser(),
			//web_service_response = casemagt_cl.select_general_case_details_new_general_request(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();

				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String outgoing_sms = case_obj.get("outgoing_sms").toString();

				String application_requests = case_obj.get("application_requests").toString();


				
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();
				String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
				String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
				String compliance_query_status = case_obj.get("compliance_query_status").toString();


				String baby_step_milestone = case_obj.get("baby_step_milestone").toString();

				//System.out.println(compliance_query_status);

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
						ArrayList.class);

						ArrayList application_requests_list = googleJson.fromJson(application_requests,
						ArrayList.class);

						ArrayList outgoing_sms_list = googleJson.fromJson(outgoing_sms, ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
				ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
				ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
						ArrayList.class);

						ArrayList baby_step_milestone_list = googleJson.fromJson(baby_step_milestone,
						ArrayList.class);

						

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);
				request.setAttribute("application_requests", application_requests_list);
				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
				request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);
				request.setAttribute("baby_step_milestone_list", baby_step_milestone_list);
				

				request.setAttribute("outgoing_sms", outgoing_sms_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
				request.setAttribute("certificete_approval_status",
						case_obj.get("certificete_approval_status").toString());
				request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());

				request.setAttribute("compliance_query_status", compliance_query_status);

				// System.out.println(case_obj.get("parcel_wkt").toString());
				String new_case_number = "";
				JSONObject parcel_details_obj;

				parcel_details_obj = new JSONObject(parcel_details);

				new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				request.setAttribute("parcel_remarks",
						parcel_details_obj.get("remarks").toString());

				request.setAttribute("smd_reference_number",
						parcel_details_obj.get("smd_reference_number").toString());
				request.setAttribute("smd_type_of_plotting",
						parcel_details_obj.get("smd_type_of_plotting").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());
						request.setAttribute("sub_interest_number",
						transaction_details_obj.get("sub_interest_number").toString());
				//request.setAttribute("sub_interest_number",transaction_details_obj.get("sub_interest_number").toString());
				request.setAttribute("considertion_fee_adopted_rate",
						transaction_details_obj.get("considertion_fee_adopted_rate").toString());

				request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
					request.setAttribute("type_of_transfer",transaction_details_obj.get("type_of_transfer").toString());
					request.setAttribute("intended_interest",transaction_details_obj.get("intended_interest").toString());
					request.setAttribute("intended_parcel",transaction_details_obj.get("intended_parcel").toString());
	

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());
				request.setAttribute("smd_licensed_surveyor_name",
						job_detail_obj.get("smd_licensed_surveyor_name").toString());
				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}

				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				request.setAttribute("page_name_", "review_application_progress_details");
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);
				
						model.addAttribute("content", "../pages/client_application/motherfile_review_details.jsp"); return "layouts/app";
				

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}


	@RequestMapping("/registration_application_progress_details_new")
	@PostMapping
	public String registration_application_progress_details_new(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details_new_app_flow(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
					if (web_service_response != null) {
						System.out.println(web_service_response);
						JSONObject case_obj;
						case_obj = new JSONObject(web_service_response);
		
						String parcel_details = case_obj.get("parcel_details").toString();
						String transaction_details = case_obj.get("transaction_details").toString();
						String job_detail = case_obj.get("job_detail").toString();
		
						String job_details = case_obj.get("job_details").toString();
						String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
						String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
						String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
						String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
						String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
						String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
		
						String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
						String outgoing_sms = case_obj.get("outgoing_sms").toString();
		
		
		
		
						
						String collection_checklist = case_obj.get("collection_checklist").toString();
						String application_munites = case_obj.get("application_munites").toString();
						String application_notes = case_obj.get("application_notes").toString();
						String payment_bill = case_obj.get("payment_bill").toString();
						String payment_invoice = case_obj.get("payment_invoice").toString();
						String comments_on_application = case_obj.get("comments_on_application").toString();
						String parties = case_obj.get("parties").toString();
						String active_case_queries = case_obj.get("active_case_query").toString();
						String active_case_objection = case_obj.get("active_case_objection").toString();
						String case_query = case_obj.get("case_query").toString();
						String case_objection = case_obj.get("case_objection").toString();
						String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
						String case_letters = case_obj.get("case_letters").toString();
						String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
						String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
						String compliance_query_status = case_obj.get("compliance_query_status").toString();
		
						//System.out.println(compliance_query_status);
		
						// ArrayList main_details_list =
						// googleJson.fromJson(main_details, ArrayList.class);
						ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
						ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
						ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
						ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
						ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
								ArrayList.class);
						ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
						ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
								ArrayList.class);
								ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
								ArrayList.class);
		
		
								ArrayList outgoing_sms_list = googleJson.fromJson(outgoing_sms, ArrayList.class);
						ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
						ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
						ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
						ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
						ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
						ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
						ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);
		
						ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
						ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);
		
						ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
						ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
						ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
						ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
								ArrayList.class);
		
						// request.setAttribute("transaction_details", main_details);
						request.setAttribute("job_details", job_details_list);
						// request.setAttribute("parcels_coordinates",
						// parcels_coordinates_list);
						request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
						request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
						request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
						request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
						request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
						request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
						request.setAttribute("collection_checklist", collection_checklist_list);
						request.setAttribute("application_munites", application_munites_list);
						request.setAttribute("application_notes", application_notes_list);
						request.setAttribute("payment_bill", payment_bill_list);
						request.setAttribute("comments_on_application", comments_on_application_list);
						request.setAttribute("parties", parties_list);
						request.setAttribute("payment_invoice", payment_invoice_list);
		
						request.setAttribute("case_query", case_query_list);
						request.setAttribute("active_case_queries", active_case_queries);
						request.setAttribute("case_objection", case_objection_list);
						request.setAttribute("active_case_objection", active_case_objection);
						request.setAttribute("case_inspections", case_inspections_list);
						request.setAttribute("case_letters", case_letters_list);
						request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
						request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);
						request.setAttribute("outgoing_sms", outgoing_sms_list);
		
						request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
						request.setAttribute("certificete_approval_status",
								case_obj.get("certificete_approval_status").toString());
						request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());
		
						request.setAttribute("compliance_query_status", compliance_query_status);
		
						// System.out.println(case_obj.get("parcel_wkt").toString());
						String new_case_number = "";
						JSONObject parcel_details_obj;
		
						parcel_details_obj = new JSONObject(parcel_details);
		
						new_case_number = parcel_details_obj.get("case_number").toString();
						request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
						request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
						request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
						request.setAttribute("locality", parcel_details_obj.get("locality").toString());
						request.setAttribute("district", parcel_details_obj.get("district").toString());
						request.setAttribute("region", parcel_details_obj.get("region").toString());
						request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
						request.setAttribute("extent", parcel_details_obj.get("extent").toString());
						request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
						request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
						request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
						request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
						request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
						request.setAttribute("registration_district_number",
								parcel_details_obj.get("registration_district_number").toString());
						request.setAttribute("registration_section_number",
								parcel_details_obj.get("registration_section_number").toString());
						request.setAttribute("registration_block_number",
								parcel_details_obj.get("registration_block_number").toString());
		
						request.setAttribute("need_for_new_transaction",
								parcel_details_obj.get("need_for_new_transaction").toString());
		
						request.setAttribute("parcel_remarks",
								parcel_details_obj.get("remarks").toString());
		
						request.setAttribute("smd_reference_number",
								parcel_details_obj.get("smd_reference_number").toString());
						request.setAttribute("smd_type_of_plotting",
								parcel_details_obj.get("smd_type_of_plotting").toString());
		
						JSONObject transaction_details_obj;
						transaction_details_obj = new JSONObject(transaction_details);
						request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
						request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
						request.setAttribute("transaction_number",
								transaction_details_obj.get("transaction_number").toString());
						request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
						request.setAttribute("nature_of_instrument",
								transaction_details_obj.get("nature_of_instrument").toString());
						request.setAttribute("certificate_number",
								transaction_details_obj.get("certificate_number").toString());
		
						request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
						request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
						request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
						request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
						request.setAttribute("term", transaction_details_obj.get("term").toString());
						request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());
		
						request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
						request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
						request.setAttribute("consideration_fee_currency",
								transaction_details_obj.get("consideration_fee_currency").toString());
						request.setAttribute("consideration_fee_adopted_rate",
								transaction_details_obj.get("consideration_fee_adopted_rate").toString());
						request.setAttribute("stamp_duty_payable",
								transaction_details_obj.get("stamp_duty_payable").toString());
						request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
						request.setAttribute("parcel_description",
								transaction_details_obj.get("parcel_description").toString());
						request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
						request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
						request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());
		
						request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());
		
						request.setAttribute("rent_review_period",
								transaction_details_obj.get("rent_review_period").toString());
						request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());
		
						request.setAttribute("rent_period_covered",
								transaction_details_obj.get("rent_period_covered").toString());
						request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
						request.setAttribute("date_of_first_payment",
								transaction_details_obj.get("date_of_first_payment").toString());
						request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
						request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
						request.setAttribute("date_of_registration",
								transaction_details_obj.get("date_of_registration").toString());
						request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());
		
						request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
						// request.setAttribute("is_part_of_gelis_area",
						// transaction_details_obj.get("is_part_of_gelis_area").toString());
						request.setAttribute("stamp_duty_description",
								transaction_details_obj.get("stamp_duty_description").toString());
						request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
						request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());
		
						request.setAttribute("case_process_stage",
								transaction_details_obj.get("case_process_stage").toString());
								request.setAttribute("interest_number",
								transaction_details_obj.get("interest_number").toString());
		
						request.setAttribute("considertion_fee_adopted_rate",
								transaction_details_obj.get("considertion_fee_adopted_rate").toString());
		
						request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
							request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
			
		
						JSONObject job_detail_obj;
						job_detail_obj = new JSONObject(job_detail);
						request.setAttribute("job_number", job_number);
						request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
						request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
						request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
						// System.out.println(job_detail_obj.get("application_stage").toString());
						request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
						request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
						request.setAttribute("business_process_sub_id",
								job_detail_obj.get("business_process_sub_id").toString());
						request.setAttribute("business_process_sub_name",
								job_detail_obj.get("business_process_sub_name").toString());
						request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
						request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
						request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());
						request.setAttribute("smd_licensed_surveyor_name",
								job_detail_obj.get("smd_licensed_surveyor_name").toString());
						JSONArray arr_r = new JSONArray();
		
						business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();
		
						String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
						// System.out.println("folderpath: " +folderpath);
						// List All Files In a Folder
						File subdir = new File(folderpath.toString());
						String[] children = subdir.list();
						if (children == null) {
							// System.out.println("Either dir does not exist or is not a
							// directory");
						} else {
							for (int j = 0; j < children.length; j++) {
								String filename_doc = children[j];
								// System.out.println("case_number: " + case_number);
								// System.out.println("File: " + filename_doc);
								String path = folderpath.toString() + "/" + filename_doc;
		
								String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
								JSONObject obj_r = new JSONObject();
								// obj_r.put( "d_id" , 0 );
								// obj_r.put( "job_number" , "SMDGARGA37542018" );
								// obj_r.put( "case_number" , "LCGARGACN37542018" );
								obj_r.put("document_name", filename_doc);
								obj_r.put("document_type", path);
								obj_r.put("document_extention", extension);
								obj_r.put("document_file", path);
								obj_r.put("uploaded_by", "");
								obj_r.put("uploaded_date", "");
		
								arr_r.put(obj_r);
							}
		
						}
						// request.setAttribute("casescanneddocuments",
						// arr_r.toString());
		
						JSONArray arr_r_public = new JSONArray();
						String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
						// System.out.println("folderpath: " +folderpath);
						// List All Files In a Folder
						File subdir_public = new File(folderpath_public.toString());
						String[] children_public = subdir_public.list();
						if (children_public == null) {
							// System.out.println("Either dir does not exist or is not a
							// directory");
						} else {
							for (int j = 0; j < children_public.length; j++) {
								String filename_doc_public = children_public[j];
								// System.out.println("case_number: " + case_number);
								// System.out.println("File: " + filename_doc_public);
								String path = folderpath_public.toString() + "/" + filename_doc_public;
		
								String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
								JSONObject obj_r = new JSONObject();
								// obj_r.put( "d_id" , 0 );
								// obj_r.put( "job_number" , "SMDGARGA37542018" );
								// obj_r.put( "case_number" , "LCGARGACN37542018" );
								obj_r.put("document_name", filename_doc_public);
								obj_r.put("document_type", path);
								obj_r.put("document_extention", extension);
								obj_r.put("document_file", path);
								obj_r.put("uploaded_by", "");
								obj_r.put("uploaded_date", "");
		
								arr_r_public.put(obj_r);
							}
		
						}
		
						String get_gender_list = user_web_service.get_list_of_gender(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());
						// web_service_response = get_gender_list;
						System.out.println(get_gender_list);
						JSONObject menu_obj_data;
						// menu_obj_data = new JSONObject(get_gender_list);
						// String all_menus_data = menu_obj_data.get("data").toString();
						// System.out.println(all_menus_data);
						// Gson googleJson = new Gson();
						ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);
		
						request.setAttribute("genderlist", javaArrayListFromGSON);
						// request.setAttribute("casescanneddocuments_public",
						// arr_r_public.toString());
						request.setAttribute("page_name", "case_processing");
						// System.out.println(arr_r.toString());
						// System.out.println(arr_r_public.toString());
		
						// System.out.println(business_process_sub_name);
		
						if (business_process_sub_name.equals("APPLICATION FOR REGIONAL NUMBER")) {
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR PLAN APPROVAL")) {
									model.addAttribute("content", "../pages/client_application/plan_approval_application.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION (STOOL)")) {
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION (FAMILY)")) {
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION")) {
		
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR PART TRANSFER")) {
									model.addAttribute("content", "../pages/client_application/part_transfer_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR WHOLE TRANFER")) {
									model.addAttribute("content", "../pages/client_application/part_transfer_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION")) {
									model.addAttribute("content", "../pages/client_application/application_for_deed_registration.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION WITH CONSENT")) {
									model.addAttribute("content", "../pages/client_application/application_for_deed_registration_with_consent.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION WITH CONCURRENCE")) {
									model.addAttribute("content", "../pages/client_application/application_for_deed_registration_with_concurrence.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION ON FAMILY LAND")) {
									model.addAttribute("content", "../pages/client_application/application_for_deed_registration_on_family_land.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR MORTGAGES")) {
									model.addAttribute("content", "../pages/client_application/mortgage_application.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR DISCHARGE")) {
							//		model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
									model.addAttribute("content", "../pages/client_application/discharge_application.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR CAVEAT OR RESTRICTION")) {
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR OBJECTION")) {
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR SUBSTITUTED CERTIFICATE")) {
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(NON LANDED DOCUMENTS)")) {
									model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(FINANCIAL DOCUMENTS)")) {
									model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(LANDED INSPECTION CASES)")) {
									model.addAttribute("content", "../pages/client_application/landed_inspection_application.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(LANDED NON INSPECTION CASES)")) {
									model.addAttribute("content", "../pages/client_application/landed_non_inspection_application.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR CONCURRENCE")) {
									model.addAttribute("content", "../pages/client_application/application_concurrence_process.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name
								.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (WHOLE SITE)")) {
									model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name
								.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (PORTION OR PART)")) {
									model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process_part.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("")) {
									model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN (JUDICIAL SALE)")) {
									model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO MORTGAGE")) {
									model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";
		
						}
		
						else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO VEST (VESTING ASSENT)")) {
									model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION")) {
									model.addAttribute("content", "../pages/client_application/application_lease_preparation_process.jsp"); return "layouts/app";
		
						}
		
						else if (business_process_sub_name.equals("APPLICATION FOR LEASE")) {
									model.addAttribute("content", "../pages/client_application/application_lease_preparation_process.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR CERTIFIED TRUE COPY")) {
									model.addAttribute("content", "../pages/client_application/certified_true_copy_process.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR ASSESSMENT AND PAYMENT OF GROUND RENT")) {
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR RE PRINT OF TITLE OR APPROVED PLAN")) {
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR APPROVAL OF TITLE PLAN")) {
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						}
		
						else if (business_process_sub_name.equals("APPLICATION FOR REGIONAL NUMBER FOR OFFICIAL SURVEYS")) {
									model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH(PERMIT)")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR CERTIFICATE SEARCH")) {
									model.addAttribute("content", "../pages/client_application/certificate_search_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR ADMINISTRATIVE SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR PERMIT SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD OFFICIAL SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD PERMIT SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD POLICE SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD ADMINISTRATIVE SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR LRD PERMIT SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR LRD ADMINISTRATIVE SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR LRD POLICE SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR LRD CERTIFICATE SEARCH")) {
									model.addAttribute("content", "../pages/client_application/certificate_search_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
									model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR SUPPLEMENTARY LODGEMENT")) {
									model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
						} else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION UP TO TITLE REGISTRATION")) {
									model.addAttribute("content", "../pages/client_application/application_for_regularization_to_title_registration.jsp"); return "layouts/app";
		
						} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD PLOTTING")) {
									model.addAttribute("content", "../pages/client_application/application_for_pvlmd_plotting.jsp"); return "layouts/app";
		
						} else {
									model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
		
						}
		
					} else {
						System.out.println(web_service_response);
					}
		
				} catch (
		
				JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}



	@RequestMapping("/request_application_progress_details")
	@PostMapping
	public String request_application_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");
			String job_purpose = request.getParameter("job_purpose");
			String review_instruction = request.getParameter("review_instruction");
			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */
			System.out.println(review_instruction);
			request.setAttribute("job_purpose", job_purpose);
			request.setAttribute("review_instruction", review_instruction);

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			obj.put("job_purpose", job_purpose);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details_new_app_flow(cls_url_config.getWeb_service_url_ser(),
			//web_service_response = casemagt_cl.select_general_case_details_new_general_request(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();

				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String outgoing_sms = case_obj.get("outgoing_sms").toString();

				String application_requests = case_obj.get("application_requests").toString();
				
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();
				String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
				String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
				String compliance_query_status = case_obj.get("compliance_query_status").toString();


				String baby_step_milestone = case_obj.get("baby_step_milestone").toString();

				//System.out.println(compliance_query_status);

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
						ArrayList.class);

						ArrayList application_requests_list = googleJson.fromJson(application_requests,
						ArrayList.class);

						ArrayList outgoing_sms_list = googleJson.fromJson(outgoing_sms, ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
				ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
				ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
						ArrayList.class);

						ArrayList baby_step_milestone_list = googleJson.fromJson(baby_step_milestone,
						ArrayList.class);

						

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);
				request.setAttribute("application_requests", application_requests_list);
				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
				request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);
				request.setAttribute("baby_step_milestone_list", baby_step_milestone_list);
				

				request.setAttribute("outgoing_sms", outgoing_sms_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
				request.setAttribute("certificete_approval_status",
						case_obj.get("certificete_approval_status").toString());
				request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());

				request.setAttribute("compliance_query_status", compliance_query_status);

				// System.out.println(case_obj.get("parcel_wkt").toString());
				String new_case_number = "";
				JSONObject parcel_details_obj;

				parcel_details_obj = new JSONObject(parcel_details);

				new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				request.setAttribute("parcel_remarks",
						parcel_details_obj.get("remarks").toString());

				request.setAttribute("smd_reference_number",
						parcel_details_obj.get("smd_reference_number").toString());
				request.setAttribute("smd_type_of_plotting",
						parcel_details_obj.get("smd_type_of_plotting").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());
						request.setAttribute("sub_interest_number",
						transaction_details_obj.get("sub_interest_number").toString());
				//request.setAttribute("sub_interest_number",transaction_details_obj.get("sub_interest_number").toString());
				request.setAttribute("considertion_fee_adopted_rate",
						transaction_details_obj.get("considertion_fee_adopted_rate").toString());

				    request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
					request.setAttribute("type_of_transfer",transaction_details_obj.get("type_of_transfer").toString());
					request.setAttribute("intended_interest",transaction_details_obj.get("intended_interest").toString());
					request.setAttribute("intended_parcel",transaction_details_obj.get("intended_parcel").toString());
		
					request.setAttribute("deed_number",transaction_details_obj.get("deed_number").toString());
					request.setAttribute("file_number",transaction_details_obj.get("file_number").toString());
					request.setAttribute("ls_number",transaction_details_obj.get("ls_number").toString());
					request.setAttribute("ground_rent",transaction_details_obj.get("ground_rent").toString());
	

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());
				request.setAttribute("smd_licensed_surveyor_name",
						job_detail_obj.get("smd_licensed_surveyor_name").toString());
				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}

				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				request.setAttribute("page_name_", "review_application_progress_details");
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);
				

				if (job_purpose.equals("Reverification of Search") && business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)")) {
							model.addAttribute("content", "../pages/client_application/_ap_registration_application_progress_details_cst.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Reverification of Search") && !(business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)"))) {
							model.addAttribute("content", "../pages/client_application/_ap_registration_application_progress_details_frrv.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Further Entries")) {
							model.addAttribute("content", "../pages/client_application/_ap_further_entries.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Noting of parcels")) {
							model.addAttribute("content", "../pages/client_application/_ap_noting_of_parcel.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Final Ploting")) {
							model.addAttribute("content", "../pages/client_application/_ap_final_plotting.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Certificate Generation")) {
							model.addAttribute("content", "../pages/client_application/_ap_certificate_volume_folio_generation.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Certificate Generation Transition")) {
							model.addAttribute("content", "../pages/client_application/_ap_certificate_volume_folio_generation_with_dist_sec.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Volume and Folio Generation")) {
							model.addAttribute("content", "../pages/client_application/_ap_volume_folio_generation.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Root of Title")) {
							model.addAttribute("content", "../pages/client_application/_ap_entry_of_root_of_title.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Link Child to Mother")) {
							model.addAttribute("content", "../pages/client_application/_ap_link_child_to_mother.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Plan Preparation")) {
							model.addAttribute("content", "../pages/client_application/_ap_plan_preparation.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Final Approval Registration")) {
							model.addAttribute("content", "../pages/client_application/_ap_final_approval_of_registration.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Approval Vetting")) {
							model.addAttribute("content", "../pages/client_application/_ap_approval_vetting.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Generate Interest Number")) {
							model.addAttribute("content", "../pages/client_application/_ap_generate_interest_number.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Update Existing Plan Details")) {
							model.addAttribute("content", "../pages/client_application/_ap_existing_plan_details.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Update Existing Certificate Details")) {
							model.addAttribute("content", "../pages/client_application/_ap_update_existing_certificate.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Update Mortgage Certificate Number")) {
							model.addAttribute("content", "../pages/client_application/_ap_update_certificate_number.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Generate Sub-Interest Number")) {
							model.addAttribute("content", "../pages/client_application/_ap_generate_sub_interest_number.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Certificate Signing")) {
							model.addAttribute("content", "../pages/client_application/_ap_certificate_signing.jsp"); return "layouts/app";
				
				
				} else if (job_purpose.equals("Final Vetting")) { 
							model.addAttribute("content", "../pages/client_application/_application_review_details.jsp"); return "layouts/app";
				
				
				} else if (job_purpose.equals("Update Registered Number")) {
							model.addAttribute("content", "../pages/client_application/_ap_update_registered_number.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Update Publication Details")) {
							model.addAttribute("content", "../pages/client_application/_ap_update_publication_details.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Update Date of Issue")) {
							model.addAttribute("content", "../pages/client_application/_ap_update_date_of_issue.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Title Plan Preparation")) {
							model.addAttribute("content", "../pages/client_application/_application_review_details_short.jsp"); return "layouts/app";
				} else if (job_purpose.equals("Inspection")) {
							model.addAttribute("content", "../pages/client_application/_application_review_details_short.jsp"); return "layouts/app";
				}  else if (job_purpose.equals("Objection")) {
							model.addAttribute("content", "../pages/client_application/_application_review_details_short.jsp"); return "layouts/app";
				}   else if (job_purpose.equals("Upload Document")) {
							model.addAttribute("content", "../pages/client_application/_ap_upload_document.jsp"); return "layouts/app";
				}   else if (job_purpose.equals("Motherfile Creation")) {
							model.addAttribute("content", "../pages/client_application/_ap_motherfile_creation.jsp"); return "layouts/app";
				}   else if (job_purpose.equals("Generate SMD Numbers")) {
							model.addAttribute("content", "../pages/client_application/_ap_generate_smd_numbers.jsp"); return "layouts/app";
				} 
				 else {
							model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
				}

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}



	@RequestMapping("/request_application_progress_details_ai")
	@PostMapping
	public String request_application_progress_details_ai(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String rq_id = request.getParameter("rq_id");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");
			String job_purpose = request.getParameter("job_purpose");
			String review_instruction = request.getParameter("review_instruction");
			String review_type = request.getParameter("review_type");
			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */
			System.out.println(review_instruction);
			request.setAttribute("job_purpose", job_purpose);
			request.setAttribute("review_instruction", review_instruction);

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			obj.put("job_purpose", job_purpose);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
		
			if (review_type.equals("GeneralWorkRequest")) {
	         web_service_response = vas_cl.select_review_digital_workflow(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);

			// web_service_response = vas_cl.select_general_request_workflow(cls_url_config.getWeb_service_url_ser(),
			// 		cls_url_config.getWeb_service_url_ser_api_key(),
			// 		batchlistdivison);


			}else{
			//web_service_response = vas_cl.select_review_digital_workflow(cls_url_config.getWeb_service_url_ser(),
			web_service_response = vas_cl.select_general_request_workflow(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			}
			



			if (web_service_response != null) {
				//System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();

				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String outgoing_sms = case_obj.get("outgoing_sms").toString();

				String application_requests = case_obj.get("application_requests").toString();
String digital_workflow_steps = case_obj.get("digital_workflow_steps").toString();

				
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();
				String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
				String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
				String compliance_query_status = case_obj.get("compliance_query_status").toString();


				String baby_step_milestone = case_obj.get("baby_step_milestone").toString();


				String active_digital_workflow_step = case_obj.get("active_digital_workflow_step").toString();

				

				//System.out.println(compliance_query_status);

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
						ArrayList.class);

						ArrayList application_requests_list = googleJson.fromJson(application_requests,
						ArrayList.class);
						
						ArrayList baby_steps_list = googleJson.fromJson(digital_workflow_steps,
						ArrayList.class);

							ArrayList active_digital_workflow_step_list = googleJson.fromJson(active_digital_workflow_step,
						ArrayList.class);

						

						

						ArrayList outgoing_sms_list = googleJson.fromJson(outgoing_sms, ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
				ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
				ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
						ArrayList.class);

						ArrayList baby_step_milestone_list = googleJson.fromJson(baby_step_milestone,
						ArrayList.class);


						System.out.println("baby_step_milestone_list");

						System.out.println(baby_step_milestone_list);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
request.setAttribute("baby_steps_list", baby_steps_list);
request.setAttribute("active_digital_workflow_step_list", active_digital_workflow_step_list);

				
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);
				request.setAttribute("application_requests", application_requests_list);
				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
				request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);
				request.setAttribute("baby_step_milestone_list", baby_step_milestone_list);
				

				request.setAttribute("outgoing_sms", outgoing_sms_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
				request.setAttribute("certificete_approval_status",
						case_obj.get("certificete_approval_status").toString());
				request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());

				request.setAttribute("compliance_query_status", compliance_query_status);

				System.out.println("case_obj.getparcel_wkt.toString()");
				System.out.println(case_obj.get("parcel_wkt").toString());

				String new_case_number = "";
				JSONObject parcel_details_obj;

				parcel_details_obj = new JSONObject(parcel_details);

				new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				request.setAttribute("parcel_remarks",
						parcel_details_obj.get("remarks").toString());

				request.setAttribute("smd_reference_number",
						parcel_details_obj.get("smd_reference_number").toString());
				request.setAttribute("smd_type_of_plotting",
						parcel_details_obj.get("smd_type_of_plotting").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());
						request.setAttribute("sub_interest_number",
						transaction_details_obj.get("sub_interest_number").toString());
				//request.setAttribute("sub_interest_number",transaction_details_obj.get("sub_interest_number").toString());
				request.setAttribute("considertion_fee_adopted_rate",
						transaction_details_obj.get("considertion_fee_adopted_rate").toString());

				    request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
					// request.setAttribute("type_of_transfer",transaction_details_obj.get("type_of_transfer").toString());
					// request.setAttribute("intended_interest",transaction_details_obj.get("intended_interest").toString());
					// request.setAttribute("intended_parcel",transaction_details_obj.get("intended_parcel").toString());
		
					// request.setAttribute("deed_number",transaction_details_obj.get("deed_number").toString());
					// request.setAttribute("file_number",transaction_details_obj.get("file_number").toString());
					// request.setAttribute("ls_number",transaction_details_obj.get("ls_number").toString());
					// request.setAttribute("ground_rent",transaction_details_obj.get("ground_rent").toString());
	

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());
				request.setAttribute("smd_licensed_surveyor_name",
						job_detail_obj.get("smd_licensed_surveyor_name").toString());

request.setAttribute("rq_id",rq_id);

						
				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

			

				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				//request.setAttribute("page_name_", "review_application_progress_details");
                //request.setAttribute("page_name", "application_review_details_advanced");
				
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);
						model.addAttribute("content", "../pages/client_application/_application_review_details_ai.jsp"); return "layouts/app";

				

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}



	@RequestMapping("/request_application_progress_details_advance")
	@PostMapping
	public String request_application_progress_details_advance(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String rq_id = request.getParameter("rq_id");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");
			String job_purpose = request.getParameter("job_purpose");
			String review_instruction = request.getParameter("review_instruction");
			String review_type = request.getParameter("review_type");
			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */
			System.out.println(review_instruction);
			request.setAttribute("job_purpose", job_purpose);
			request.setAttribute("review_instruction", review_instruction);

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			obj.put("job_purpose", job_purpose);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
		
			if (review_type.equals("GeneralWorkRequest")) {
	         web_service_response = vas_cl.select_review_digital_workflow(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);

			// web_service_response = vas_cl.select_general_request_workflow(cls_url_config.getWeb_service_url_ser(),
			// 		cls_url_config.getWeb_service_url_ser_api_key(),
			// 		batchlistdivison);


			}else{
			//web_service_response = vas_cl.select_review_digital_workflow(cls_url_config.getWeb_service_url_ser(),
			web_service_response = vas_cl.select_general_request_workflow(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			}
			





			if (web_service_response != null) {
				//System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();

				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String outgoing_sms = case_obj.get("outgoing_sms").toString();

				String application_requests = case_obj.get("application_requests").toString();
String digital_workflow_steps = case_obj.get("digital_workflow_steps").toString();

				
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();
				String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
				String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
				String compliance_query_status = case_obj.get("compliance_query_status").toString();


				String baby_step_milestone = case_obj.get("baby_step_milestone").toString();


				String active_digital_workflow_step = case_obj.get("active_digital_workflow_step").toString();

				

				//System.out.println(compliance_query_status);

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
						ArrayList.class);

						ArrayList application_requests_list = googleJson.fromJson(application_requests,
						ArrayList.class);
						
						ArrayList baby_steps_list = googleJson.fromJson(digital_workflow_steps,
						ArrayList.class);

							ArrayList active_digital_workflow_step_list = googleJson.fromJson(active_digital_workflow_step,
						ArrayList.class);

						

						

						ArrayList outgoing_sms_list = googleJson.fromJson(outgoing_sms, ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
				ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
				ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
						ArrayList.class);

						ArrayList baby_step_milestone_list = googleJson.fromJson(baby_step_milestone,
						ArrayList.class);


						System.out.println("baby_step_milestone_list");

						System.out.println(baby_step_milestone_list);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
request.setAttribute("baby_steps_list", baby_steps_list);
request.setAttribute("active_digital_workflow_step_list", active_digital_workflow_step_list);

				
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);
				request.setAttribute("application_requests", application_requests_list);
				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
				request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);
				request.setAttribute("baby_step_milestone_list", baby_step_milestone_list);
				

				request.setAttribute("outgoing_sms", outgoing_sms_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
				request.setAttribute("certificete_approval_status",
						case_obj.get("certificete_approval_status").toString());
				request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());

				request.setAttribute("compliance_query_status", compliance_query_status);

				System.out.println("case_obj.getparcel_wkt.toString()");
				System.out.println(case_obj.get("parcel_wkt").toString());

				String new_case_number = "";
				JSONObject parcel_details_obj;

				parcel_details_obj = new JSONObject(parcel_details);

				new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				request.setAttribute("parcel_remarks",
						parcel_details_obj.get("remarks").toString());

				request.setAttribute("smd_reference_number",
						parcel_details_obj.get("smd_reference_number").toString());
				request.setAttribute("smd_type_of_plotting",
						parcel_details_obj.get("smd_type_of_plotting").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());
						request.setAttribute("sub_interest_number",
						transaction_details_obj.get("sub_interest_number").toString());
				//request.setAttribute("sub_interest_number",transaction_details_obj.get("sub_interest_number").toString());
				request.setAttribute("considertion_fee_adopted_rate",
						transaction_details_obj.get("considertion_fee_adopted_rate").toString());

				    request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
					// request.setAttribute("type_of_transfer",transaction_details_obj.get("type_of_transfer").toString());
					// request.setAttribute("intended_interest",transaction_details_obj.get("intended_interest").toString());
					// request.setAttribute("intended_parcel",transaction_details_obj.get("intended_parcel").toString());
		
					// request.setAttribute("deed_number",transaction_details_obj.get("deed_number").toString());
					// request.setAttribute("file_number",transaction_details_obj.get("file_number").toString());
					// request.setAttribute("ls_number",transaction_details_obj.get("ls_number").toString());
					// request.setAttribute("ground_rent",transaction_details_obj.get("ground_rent").toString());
	

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());
				request.setAttribute("smd_licensed_surveyor_name",
						job_detail_obj.get("smd_licensed_surveyor_name").toString());

request.setAttribute("rq_id",rq_id);

						
				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

			

				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				request.setAttribute("page_name_", "review_application_progress_details");
                request.setAttribute("page_name", "application_review_details_advanced");
				
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);
						model.addAttribute("content", "../pages/client_application/_request_application_progress_details_advance.jsp"); 
						return "layouts/app";

				

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}



	@RequestMapping("/new_request_application_progress_details")
	@PostMapping
	public String new_request_application_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");
			String job_purpose = request.getParameter("job_purpose");
			String review_instruction = request.getParameter("review_instruction");
			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */
			System.out.println(review_instruction);
			request.setAttribute("job_purpose", job_purpose);
			request.setAttribute("review_instruction", review_instruction);

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			obj.put("job_purpose", job_purpose);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
			//web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
			web_service_response = casemagt_cl.select_general_case_details_new_general_request(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();

				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String outgoing_sms = case_obj.get("outgoing_sms").toString();

				String application_requests = case_obj.get("application_requests").toString();


				
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();
				String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
				String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
				String compliance_query_status = case_obj.get("compliance_query_status").toString();


				String baby_step_milestone = case_obj.get("baby_step_milestone").toString();

				//System.out.println(compliance_query_status);

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
						ArrayList.class);

						ArrayList application_requests_list = googleJson.fromJson(application_requests,
						ArrayList.class);

						ArrayList outgoing_sms_list = googleJson.fromJson(outgoing_sms, ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
				ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
				ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
						ArrayList.class);

						ArrayList baby_step_milestone_list = googleJson.fromJson(baby_step_milestone,
						ArrayList.class);

						

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);
				request.setAttribute("application_requests", application_requests_list);
				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
				request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);
				request.setAttribute("baby_step_milestone_list", baby_step_milestone_list);
				

				request.setAttribute("outgoing_sms", outgoing_sms_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
				request.setAttribute("certificete_approval_status",
						case_obj.get("certificete_approval_status").toString());
				request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());

				request.setAttribute("compliance_query_status", compliance_query_status);

				// System.out.println(case_obj.get("parcel_wkt").toString());
				String new_case_number = "";
				JSONObject parcel_details_obj;

				parcel_details_obj = new JSONObject(parcel_details);

				new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				request.setAttribute("parcel_remarks",
						parcel_details_obj.get("remarks").toString());

				request.setAttribute("smd_reference_number",
						parcel_details_obj.get("smd_reference_number").toString());
				request.setAttribute("smd_type_of_plotting",
						parcel_details_obj.get("smd_type_of_plotting").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());
						request.setAttribute("sub_interest_number",
						transaction_details_obj.get("sub_interest_number").toString());
				//request.setAttribute("sub_interest_number",transaction_details_obj.get("sub_interest_number").toString());
				request.setAttribute("considertion_fee_adopted_rate",
						transaction_details_obj.get("considertion_fee_adopted_rate").toString());

				request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
	

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());
				request.setAttribute("smd_licensed_surveyor_name",
						job_detail_obj.get("smd_licensed_surveyor_name").toString());
				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}

				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				request.setAttribute("page_name_", "review_application_progress_details");
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

				// if (job_purpose.equals("Reverification of Search") && business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_registration_application_progress_details_cst.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Reverification of Search") && !(business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)"))) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_registration_application_progress_details_frrv.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Further Entries")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_further_entries.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Noting of parcels")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_noting_of_parcel.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Final Ploting")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_final_plotting.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Certificate Generation")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_certificate_volume_folio_generation.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Certificate Generation Transition")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_certificate_volume_folio_generation_with_dist_sec.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Volume and Folio Generation")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_volume_folio_generation.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Root of Title")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_entry_of_root_of_title.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Link Child to Mother")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_link_child_to_mother.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Plan Preparation")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_plan_preparation.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Final Approval Registration")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_final_approval_of_registration.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Approval Vetting")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_approval_vetting.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Generate Interest Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_generate_interest_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Existing Plan Details")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_existing_plan_details.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Existing Certificate Details")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_existing_certificate.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Mortgage Certificate Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_certificate_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Generate Sub-Interest Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_generate_sub_interest_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Certificate Signing")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_certificate_signing.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Final Vetting")) { 
				// 			model.addAttribute("content", "../pages/client_application/_application_review_details.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Registered Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_registered_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Publication Details")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_publication_details.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Date of Issue")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_date_of_issue.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Title Plan Preparation")) {
							model.addAttribute("content", "../pages/client_application/_application_review_details_short.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Inspection")) {
				// 			model.addAttribute("content", "../pages/client_application/_application_review_details_short.jsp"); return "layouts/app";
				// }  else if (job_purpose.equals("Objection")) {
				// 			model.addAttribute("content", "../pages/client_application/_application_review_details_short.jsp"); return "layouts/app";
				// }    else if (job_purpose.equals("Upload Document")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_upload_document.jsp"); return "layouts/app";
				// }   else if (job_purpose.equals("Motherfile Creation")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_motherfile_creation.jsp"); return "layouts/app";
				// }  else if (job_purpose.equals("Generate SMD Numbers")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_generate_smd_numbers.jsp"); return "layouts/app";
				// } 
				//  else {
				// 			model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
				// }

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}


	@RequestMapping("/new_general_request_application_progress_details")
	@PostMapping
	public String new_general_request_application_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");
			String job_purpose = request.getParameter("job_purpose");
			
			String service_process_id = "300";
			String service_process_sub_id = "300";
			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			request.setAttribute("job_purpose", job_purpose);

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details_new_general_request(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();

				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String outgoing_sms = case_obj.get("outgoing_sms").toString();




				
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();
				String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
				String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
				String compliance_query_status = case_obj.get("compliance_query_status").toString();


				String baby_step_milestone = case_obj.get("baby_step_milestone").toString();

				//System.out.println(compliance_query_status);

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
						ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
						ArrayList.class);


						ArrayList outgoing_sms_list = googleJson.fromJson(outgoing_sms, ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
				ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
				ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
						ArrayList.class);

						ArrayList baby_step_milestone_list = googleJson.fromJson(baby_step_milestone,
						ArrayList.class);

						

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
				request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);
				request.setAttribute("baby_step_milestone_list", baby_step_milestone_list);
				

				request.setAttribute("outgoing_sms", outgoing_sms_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
				request.setAttribute("certificete_approval_status",
						case_obj.get("certificete_approval_status").toString());
				request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());

				request.setAttribute("compliance_query_status", compliance_query_status);

				// System.out.println(case_obj.get("parcel_wkt").toString());
				String new_case_number = "";
				JSONObject parcel_details_obj;

				parcel_details_obj = new JSONObject(parcel_details);

				new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				request.setAttribute("parcel_remarks",
						parcel_details_obj.get("remarks").toString());

				request.setAttribute("smd_reference_number",
						parcel_details_obj.get("smd_reference_number").toString());
				request.setAttribute("smd_type_of_plotting",
						parcel_details_obj.get("smd_type_of_plotting").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());
						request.setAttribute("sub_interest_number",
						transaction_details_obj.get("sub_interest_number").toString());
				//request.setAttribute("sub_interest_number",transaction_details_obj.get("sub_interest_number").toString());
				request.setAttribute("considertion_fee_adopted_rate",
						transaction_details_obj.get("considertion_fee_adopted_rate").toString());

				request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
	

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());
				request.setAttribute("smd_licensed_surveyor_name",
						job_detail_obj.get("smd_licensed_surveyor_name").toString());
				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}

				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				request.setAttribute("page_name_", "review_application_progress_details");
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);
				
						model.addAttribute("content", "../pages/client_application/_application_review_details_short.jsp"); return "layouts/app";
				// if (job_purpose.equals("Reverification of Search") && business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_registration_application_progress_details_cst.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Reverification of Search") && !(business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)"))) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_registration_application_progress_details_frrv.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Further Entries")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_further_entries.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Noting of parcels")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_noting_of_parcel.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Final Ploting")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_final_plotting.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Certificate Generation")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_certificate_volume_folio_generation.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Certificate Generation Transition")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_certificate_volume_folio_generation_with_dist_sec.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Volume and Folio Generation")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_volume_folio_generation.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Root of Title")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_entry_of_root_of_title.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Link Child to Mother")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_link_child_to_mother.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Plan Preparation")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_plan_preparation.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Final Approval Registration")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_final_approval_of_registration.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Approval Vetting")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_approval_vetting.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Generate Interest Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_generate_interest_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Existing Plan Details")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_existing_plan_details.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Existing Certificate Details")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_existing_certificate.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Mortgage Certificate Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_certificate_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Generate Sub-Interest Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_generate_sub_interest_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Certificate Signing")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_certificate_signing.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Final Vetting")) { 
				// 			model.addAttribute("content", "../pages/client_application/_application_review_details.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Registered Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_registered_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Publication Details")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_publication_details.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Date of Issue")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_date_of_issue.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Title Plan Preparation")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_title_plan_preparation.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Inspection")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_inspection.jsp"); return "layouts/app";
				// }  else if (job_purpose.equals("Objection")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_objection.jsp"); return "layouts/app";
				// } 
				//  else {
				// 			model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
				// }

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}
	
	@RequestMapping("/review_application_progress_details")
	@PostMapping
	public String review_application_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");
			//String job_purpose = request.getParameter("job_purpose");
			
			System.out.println(transaction_number);
			System.out.println(case_number);
			 System.out.println(job_number);
			

			//request.setAttribute("job_purpose", job_purpose);

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details_new_app_flow(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();

				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String outgoing_sms = case_obj.get("outgoing_sms").toString();




				
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();
				String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
				String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
				String compliance_query_status = case_obj.get("compliance_query_status").toString();

				//System.out.println(compliance_query_status);

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
						ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
						ArrayList.class);


						ArrayList outgoing_sms_list = googleJson.fromJson(outgoing_sms, ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
				ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
				ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
						ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
				request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);
				request.setAttribute("outgoing_sms", outgoing_sms_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
				request.setAttribute("certificete_approval_status",
						case_obj.get("certificete_approval_status").toString());
				request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());

				request.setAttribute("compliance_query_status", compliance_query_status);

				// System.out.println(case_obj.get("parcel_wkt").toString());
				String new_case_number = "";
				JSONObject parcel_details_obj;

				parcel_details_obj = new JSONObject(parcel_details);

				new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				request.setAttribute("parcel_remarks",
						parcel_details_obj.get("remarks").toString());

				request.setAttribute("smd_reference_number",
						parcel_details_obj.get("smd_reference_number").toString());
				request.setAttribute("smd_type_of_plotting",
						parcel_details_obj.get("smd_type_of_plotting").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",transaction_details_obj.get("case_process_stage").toString());
				request.setAttribute("interest_number",transaction_details_obj.get("interest_number").toString());
				request.setAttribute("sub_interest_number",transaction_details_obj.get("sub_interest_number").toString());

				request.setAttribute("considertion_fee_adopted_rate",
						transaction_details_obj.get("considertion_fee_adopted_rate").toString());

				request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
					
					request.setAttribute("deed_number",transaction_details_obj.get("deed_number").toString());
					request.setAttribute("file_number",transaction_details_obj.get("file_number").toString());
					request.setAttribute("ls_number",transaction_details_obj.get("ls_number").toString());
	
			

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());
				request.setAttribute("smd_licensed_surveyor_name",
						job_detail_obj.get("smd_licensed_surveyor_name").toString());
				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}

				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "review_application_progress_details");
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

				// if (job_purpose.equals("Reverification of Search") && business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_registration_application_progress_details_cst.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Reverification of Search") && !(business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)"))) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_registration_application_progress_details_frrv.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Further Entries")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_further_entries.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Noting of parcels")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_noting_of_parcel.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Final Ploting")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_final_plotting.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Certificate Generation")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_certificate_volume_folio_generation.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Certificate Generation Transition")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_certificate_volume_folio_generation_with_dist_sec.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Root of Title")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_entry_of_root_of_title.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Link Child to Mother")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_link_child_to_mother.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Plan Preparation")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_plan_preparation.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Final Approval Registration")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_final_approval_of_registration.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Approval Vetting")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_approval_vetting.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Generate Interest Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_generate_interest_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Existing Plan Details")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_existing_plan_details.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Existing Certificate Details")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_existing_certificate.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Update Mortgage Certificate Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_update_certificate_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Generate Sub-Interest Number")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_generate_sub_interest_number.jsp"); return "layouts/app";
				// } else if (job_purpose.equals("Certificate Signing")) {
				// 			model.addAttribute("content", "../pages/client_application/_ap_certificate_signing.jsp"); return "layouts/app";
				// }  else {
							model.addAttribute("content", "../pages/client_application/_application_review_details.jsp"); return "layouts/app";
				// }

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}
	

	@RequestMapping("/transitional_application_for_coordinate_noting_and_plotting")
	@PostMapping
	public String transitional_application_for_coordinate_noting_and_plotting(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();

				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();

				
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();
				String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
				String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
				String compliance_query_status = case_obj.get("compliance_query_status").toString();

				//System.out.println(compliance_query_status);

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
						ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
						ArrayList.class);


				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
				ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
				ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
						ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
				request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
				request.setAttribute("certificete_approval_status",
						case_obj.get("certificete_approval_status").toString());
				request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());

				request.setAttribute("compliance_query_status", compliance_query_status);

				// System.out.println(case_obj.get("parcel_wkt").toString());
				String new_case_number = "";
				JSONObject parcel_details_obj;

				parcel_details_obj = new JSONObject(parcel_details);

				new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				request.setAttribute("parcel_remarks",
						parcel_details_obj.get("remarks").toString());

				request.setAttribute("smd_reference_number",
						parcel_details_obj.get("smd_reference_number").toString());
				request.setAttribute("smd_type_of_plotting",
						parcel_details_obj.get("smd_type_of_plotting").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				request.setAttribute("considertion_fee_adopted_rate",
						transaction_details_obj.get("considertion_fee_adopted_rate").toString());

				request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
	

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());
				request.setAttribute("smd_licensed_surveyor_name",
						job_detail_obj.get("smd_licensed_surveyor_name").toString());
				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

				
						model.addAttribute("content", "../pages/client_application/transitional_application_for_coordinate_noting_and_plotting.jsp"); return "layouts/app";

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}


	@RequestMapping("/map_plotting_application_progress_details")
	@PostMapping
	public String map_plotting_application_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String office_region_list = (String) session.getAttribute("office_region_list");
			Gson googleJson_officeregions = new Gson();
			ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
					ArrayList.class);
			request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			// String get_gender_list =
			// user_web_service.get_list_of_gender(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key());

			// Gson googleJson_gender = new Gson();
			// ArrayList javaArrayListFromGSON_gender =
			// googleJson_gender.fromJson(get_gender_list, ArrayList.class);
			// request.setAttribute("genderlist", javaArrayListFromGSON_gender);

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");
			String plotting_page_name = request.getParameter("plotting_page_name");
			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			 System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();

				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();
				String mother_to_child_link = case_obj.get("mother_to_child_link").toString();
				String certificate_search_relation = case_obj.get("certificate_search_relation").toString();
				String compliance_query_status = case_obj.get("compliance_query_status").toString();

				//System.out.println(compliance_query_status);

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
						ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section,
						ArrayList.class);


				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);
				ArrayList mother_to_child_link_list = googleJson.fromJson(mother_to_child_link, ArrayList.class);
				ArrayList certificate_search_relation_list = googleJson.fromJson(certificate_search_relation,
						ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("mother_to_child_link_list", mother_to_child_link_list);
				request.setAttribute("certificate_search_relation_list", certificate_search_relation_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());
				request.setAttribute("certificete_approval_status",
						case_obj.get("certificete_approval_status").toString());
				request.setAttribute("final_approval_status", case_obj.get("final_approval_status").toString());

				request.setAttribute("compliance_query_status", compliance_query_status);

				request.setAttribute("plotting_page_name", plotting_page_name);

				// System.out.println(case_obj.get("parcel_wkt").toString());
				String new_case_number = "";
				JSONObject parcel_details_obj;

				parcel_details_obj = new JSONObject(parcel_details);

				new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				request.setAttribute("parcel_remarks",
						parcel_details_obj.get("remarks").toString());

				request.setAttribute("smd_reference_number",
						parcel_details_obj.get("smd_reference_number").toString());
				request.setAttribute("smd_type_of_plotting",
						parcel_details_obj.get("smd_type_of_plotting").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				request.setAttribute("considertion_fee_adopted_rate",
						transaction_details_obj.get("considertion_fee_adopted_rate").toString());

				request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());
	

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_licensed_surveyor_name",
						job_detail_obj.get("smd_licensed_surveyor_name").toString());
				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

				// if (business_process_sub_name.equals("APPLICATION FOR REGIONAL NUMBER")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR PLAN APPROVAL")) {
				// 			model.addAttribute("content", "../pages/client_application/plan_approval_application.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION (STOOL)")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION (FAMILY)")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION")) {

				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR PART TRANSFER")) {
				// 			model.addAttribute("content", "../pages/client_application/part_transfer_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR WHOLE TRANFER")) {
				// 			model.addAttribute("content", "../pages/client_application/whole_transfer_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION")) {
				// 			model.addAttribute("content", "../pages/client_application/application_for_deed_registration.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION WITH CONSENT")) {
				// 			model.addAttribute("content", "../pages/client_application/application_for_deed_registration_with_consent.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION WITH CONCURRENCE")) {
				// 			model.addAttribute("content", "../pages/client_application/application_for_deed_registration_with_concurrence.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION ON FAMILY LAND")) {
				// 			model.addAttribute("content", "../pages/client_application/application_for_deed_registration_on_family_land.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR MORTGAGES")) {
				// 			model.addAttribute("content", "../pages/client_application/mortgage_application.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR DISCHARGE")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR CAVEAT OR RESTRICTION")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR OBJECTION")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR SUBSTITUTED CERTIFICATE")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(NON LANDED DOCUMENTS)")) {
				// 			model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(FINANCIAL DOCUMENTS)")) {
				// 			model.addAttribute("content", "../pages/client_application/light_document_application.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(LANDED INSPECTION CASES)")) {
				// 			model.addAttribute("content", "../pages/client_application/landed_inspection_application.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR STAMPING(LANDED NON INSPECTION CASES)")) {
				// 			model.addAttribute("content", "../pages/client_application/landed_non_inspection_application.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR CONCURRENCE")) {
				// 			model.addAttribute("content", "../pages/client_application/application_concurrence_process.jsp"); return "layouts/app";

				// } else if (business_process_sub_name
				// 		.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (WHOLE SITE)")) {
				// 			model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				// } else if (business_process_sub_name
				// 		.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (PORTION OR PART)")) {
				// 			model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process_part.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("")) {
				// 			model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN (JUDICIAL SALE)")) {
				// 			model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO MORTGAGE")) {
				// 			model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				// }

				// else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO VEST (VESTING ASSENT)")) {
				// 			model.addAttribute("content", "../pages/client_application/application_pvlmd_consent_process.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION")) {
				// 			model.addAttribute("content", "../pages/client_application/application_lease_preparation_process.jsp"); return "layouts/app";

				// }

				// else if (business_process_sub_name.equals("APPLICATION FOR LEASE")) {
				// 			model.addAttribute("content", "../pages/client_application/application_lease_preparation_process.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR CERTIFIED TRUE COPY")) {
				// 			model.addAttribute("content", "../pages/client_application/certified_true_copy_process.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR ASSESSMENT AND PAYMENT OF GROUND RENT")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR RE PRINT OF TITLE OR APPROVED PLAN")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR APPROVAL OF TITLE PLAN")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// }

				// else if (business_process_sub_name.equals("APPLICATION FOR REGIONAL NUMBER FOR OFFICIAL SURVEYS")) {
				// 			model.addAttribute("content", "../pages/client_application/registration_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH(PERMIT)")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR CERTIFICATE SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/certificate_search_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR ADMINISTRATIVE SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR PERMIT SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR PVLMD OFFICIAL SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR PVLMD PERMIT SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR PVLMD POLICE SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR PVLMD ADMINISTRATIVE SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR LRD PERMIT SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR LRD ADMINISTRATIVE SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR LRD POLICE SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR LRD CERTIFICATE SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/certificate_search_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
				// 			model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

				// } else if (business_process_sub_name.equals("APPLICATION FOR SUPPLEMENTARY LODGEMENT")) {
				// 			model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";

				// } else 
				if (business_process_sub_name.equals("APPLICATION FOR PVLMD PLOTTING")) {
							model.addAttribute("content", "../pages/client_application/map_plotting_application_progress_details.jsp"); return "layouts/app";

				} 
				else {
							model.addAttribute("content", "../pages/client_application/map_plotting_application_progress_details.jsp"); return "layouts/app";

				}

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
		// 		model.addAttribute("content", "../pages/client_application/general_application_without_major_process.jsp"); return "layouts/app";
	}

	@RequestMapping("/smd_plan_approval_case_plottings_1")
	@GetMapping
	public String smd_plan_approval_case_plottings_1(HttpSession session, Model model, HttpServletRequest request,
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
		Gson googleJson = new Gson();
		try {

			cls_casemgt casemgt_web_service = new cls_casemgt();
			String web_service_response_menu = null;
			web_service_response_menu = casemgt_web_service
					.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							(String) session.getAttribute("userid"));
			JSONObject menu_obj;
			menu_obj = new JSONObject(web_service_response_menu);
			String all_menus = menu_obj.get("data").toString();

			// Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
			request.setAttribute("applicationlist", javaArrayListFromGSON);

			/*
			 * RequestDispatcher rd=request
			 * "/client_application/case_movement_module.jsp"); return "layouts/app";
			 * rd.include(request,response);
			 */
			request.setAttribute("page_name", "case_processing");
					model.addAttribute("content", "../pages/client_application/smd_plan_approval_case_plottings.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				model.addAttribute("content", "../pages/client_application/smd_plan_approval_case_plottings.jsp"); return "layouts/app";
	}

	@RequestMapping("/certificate_register_movement_module")
	@GetMapping
	public String certificate_register_movement_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		// HttpSession session = request.getSession();

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}
		// System.out.println(servletName + ' ' + assigenedmenus);
		// Log User out if the user tries to access right not assigned
		if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				String web_service_response_menu_data = null;

				// String get_all_users_short = (String)
				// session.getAttribute("get_all_users_short");
				// Gson googleJson_user = new Gson();
				// ArrayList javaArrayListFromGSON_users =
				// googleJson_user.fromJson(get_all_users_short, ArrayList.class);
				// request.setAttribute("userlist", javaArrayListFromGSON_users);

				web_service_response_menu = casemgt_web_service
						.load_count_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));
				// System.out.println(web_service_response_menu);
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("total").toString();

				// Gson googleJson = new Gson();
				// ArrayList javaArrayListFromGSON =
				// googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlistcount", all_menus);

				web_service_response_menu_data = casemgt_web_service
						.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));

				JSONObject menu_obj_data;
				menu_obj_data = new JSONObject(web_service_response_menu_data);
				String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus_data, ArrayList.class);

				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/certificate_register/certificate_register_movement_module.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";

	}




	@RequestMapping("/interest_in_land_movement_module")
	@GetMapping
	public String interest_in_land_movement_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		// HttpSession session = request.getSession();

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}
		// System.out.println(servletName + ' ' + assigenedmenus);
		// Log User out if the user tries to access right not assigned
		if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				String web_service_response_menu_data = null;

				// String get_all_users_short = (String)
				// session.getAttribute("get_all_users_short");
				// Gson googleJson_user = new Gson();
				// ArrayList javaArrayListFromGSON_users =
				// googleJson_user.fromJson(get_all_users_short, ArrayList.class);
				// request.setAttribute("userlist", javaArrayListFromGSON_users);

				web_service_response_menu = casemgt_web_service
						.load_count_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));
				// System.out.println(web_service_response_menu);
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("total").toString();

				// Gson googleJson = new Gson();
				// ArrayList javaArrayListFromGSON =
				// googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlistcount", all_menus);

				web_service_response_menu_data = casemgt_web_service
						.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));

				JSONObject menu_obj_data;
				menu_obj_data = new JSONObject(web_service_response_menu_data);
				String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus_data, ArrayList.class);

				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/certificate_register/interest_in_land_movement_module.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";

	}


	

	@RequestMapping("/certificate_register_progress_details")
	@PostMapping
	public String certificate_register_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			// System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section, ArrayList.class);
				
				
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);

				
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				// System.out.println(case_obj.get("parcel_wkt").toString());
				String new_case_number = "";
				JSONObject parcel_details_obj;
				try {

					parcel_details_obj = new JSONObject(parcel_details);

					new_case_number = parcel_details_obj.get("case_number").toString();
					request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
					request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
					request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
					request.setAttribute("locality", parcel_details_obj.get("locality").toString());
					request.setAttribute("district", parcel_details_obj.get("district").toString());
					request.setAttribute("region", parcel_details_obj.get("region").toString());
					request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
					request.setAttribute("extent", parcel_details_obj.get("extent").toString());
					request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
					request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
					request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
					request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
					request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
					request.setAttribute("registration_district_number",
							parcel_details_obj.get("registration_district_number").toString());
					request.setAttribute("registration_section_number",
							parcel_details_obj.get("registration_section_number").toString());
					request.setAttribute("registration_block_number",
							parcel_details_obj.get("registration_block_number").toString());

					request.setAttribute("need_for_new_transaction",
							parcel_details_obj.get("need_for_new_transaction").toString());
				} catch (Exception e) {
					System.out.println(e);
				}
				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				// System.out.println("Date of registration is:
				// "+transaction_details_obj.get("date_of_registration").toString());
				// System.out.println("Date of commencement is:
				// "+transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());
						request.setAttribute("sub_interest_number",
						transaction_details_obj.get("sub_interest_number").toString());
				request.setAttribute("considertion_fee_adopted_rate",transaction_details_obj.get("considertion_fee_adopted_rate").toString());
           
			     	request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());


				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());

				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}

				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
				// request.setAttribute("genderlist", "web_service_response");
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

						model.addAttribute("content", "../pages/certificate_register/certificate_register_progress_details.jsp"); return "layouts/app";

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}



	@RequestMapping("/interest_in_land_progress_details")
	@PostMapping
	public String interest_in_land_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			// System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				// System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section, ArrayList.class);
				
				
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);

				
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				// System.out.println(case_obj.get("parcel_wkt").toString());
				String new_case_number = "";
				JSONObject parcel_details_obj;
				try {

					parcel_details_obj = new JSONObject(parcel_details);

					new_case_number = parcel_details_obj.get("case_number").toString();
					request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
					request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
					request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
					request.setAttribute("locality", parcel_details_obj.get("locality").toString());
					request.setAttribute("district", parcel_details_obj.get("district").toString());
					request.setAttribute("region", parcel_details_obj.get("region").toString());
					request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
					request.setAttribute("extent", parcel_details_obj.get("extent").toString());
					request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
					request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
					request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
					request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
					request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
					request.setAttribute("registration_district_number",
							parcel_details_obj.get("registration_district_number").toString());
					request.setAttribute("registration_section_number",
							parcel_details_obj.get("registration_section_number").toString());
					request.setAttribute("registration_block_number",
							parcel_details_obj.get("registration_block_number").toString());

					request.setAttribute("need_for_new_transaction",
							parcel_details_obj.get("need_for_new_transaction").toString());
				} catch (Exception e) {
					System.out.println(e);
				}
				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				// System.out.println("Date of registration is:
				// "+transaction_details_obj.get("date_of_registration").toString());
				// System.out.println("Date of commencement is:
				// "+transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("consideration_fee_currency",
						transaction_details_obj.get("consideration_fee_currency").toString());
				request.setAttribute("consideration_fee_adopted_rate",
						transaction_details_obj.get("consideration_fee_adopted_rate").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				request.setAttribute("considertion_fee_adopted_rate",transaction_details_obj.get("considertion_fee_adopted_rate").toString());
           
			     	request.setAttribute("date_of_issue",transaction_details_obj.get("date_of_issue").toString());
					request.setAttribute("registered_number",transaction_details_obj.get("registered_number").toString());


				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				// System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				request.setAttribute("smd_region", job_detail_obj.get("smd_region").toString());

				JSONArray arr_r = new JSONArray();

				business_process_sub_name = job_detail_obj.get("business_process_sub_name").toString();

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						// System.out.println("case_number: " + case_number);
						// System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}

				String get_gender_list = user_web_service.get_list_of_gender(
						cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());
				// web_service_response = get_gender_list;
				System.out.println(get_gender_list);
				JSONObject menu_obj_data;
				// menu_obj_data = new JSONObject(get_gender_list);
				// String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				// Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(get_gender_list, ArrayList.class);

				request.setAttribute("genderlist", javaArrayListFromGSON);
				// request.setAttribute("genderlist", "web_service_response");
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				request.setAttribute("page_name", "case_processing");
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

						model.addAttribute("content", "../pages/certificate_register/interest_in_land_progress_details.jsp"); return "layouts/app";

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/lrd_nothing_movement_module")
	@GetMapping
	public String lrd_nothing_movement_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		// HttpSession session = request.getSession();

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}
		// System.out.println(servletName + ' ' + assigenedmenus);
		// Log User out if the user tries to access right not assigned
		if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				String web_service_response_menu_data = null;

				String get_all_users_short = (String) session.getAttribute("get_all_users_short");
				Gson googleJson_user = new Gson();
				ArrayList javaArrayListFromGSON_users = googleJson_user.fromJson(get_all_users_short, ArrayList.class);
				request.setAttribute("userlist", javaArrayListFromGSON_users);

				web_service_response_menu = casemgt_web_service
						.load_count_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));
				// System.out.println(web_service_response_menu);
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("total").toString();

				// Gson googleJson = new Gson();
				// ArrayList javaArrayListFromGSON =
				// googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlistcount", all_menus);

				web_service_response_menu_data = casemgt_web_service
						.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));

				JSONObject menu_obj_data;
				menu_obj_data = new JSONObject(web_service_response_menu_data);
				String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus_data, ArrayList.class);

				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/certificate_register/lrd_nothing_movement_module.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/lrd_nothing_progress_details")
	@PostMapping
	public String lrd_nothing_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_reservation_section = case_obj.get("lrd_reservation_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_reservation_section_list = googleJson.fromJson(lrd_reservation_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_reservation_section", lrd_reservation_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				// System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject(parcel_details);

				String new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());
				/*
				 * request.setAttribute("created_date",
				 * transaction_details_obj.get("created_date").toString());
				 */
				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
				request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());

				System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());

				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());

				JSONArray arr_r = new JSONArray();
				request.setAttribute("page_name", "case_processing");

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				// System.out.println(arr_r.toString());
				// System.out.println(arr_r_public.toString());

				// System.out.println(business_process_sub_name);

				// request.setAttribute("page_name",
				// "first_registration_record_verification");

						model.addAttribute("content", "../pages/certificate_register/lrd_nothing_progress_details.jsp"); return "layouts/app";

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/app_database_not_in_use_update")
	@GetMapping
	public String app_database_update(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
		request.setAttribute("page_name", "app_database_update");
				model.addAttribute("content", "../pages/client_application/app_database_update.jsp"); return "layouts/app";

	}

	@RequestMapping("/milestone_update")
	@GetMapping
	public String milestone_update(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
		request.setAttribute("page_name", "milestone_update");
				model.addAttribute("content", "../pages/client_application/milestone_update.jsp"); return "layouts/app";

	}


	@RequestMapping("/further_entries_with_valuation")
	@GetMapping
	public String further_entries_with_valuation(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
		request.setAttribute("page_name", "further_entries_with_valuation");
				model.addAttribute("content", "../pages/client_application/further_entries_with_valuation.jsp"); return "layouts/app";

	}

	@RequestMapping("/app_database_update_2")
	@GetMapping
	public String app_database_update_2(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

			request.setAttribute("page_name", "page_enquiry_backoffice");
					model.addAttribute("content", "../pages/client_application/app_database_update.jsp"); return "layouts/app";

		} else {

			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

	}

	@RequestMapping("/app_update")
	@GetMapping
	public String app_update(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

			// Page Name
			request.setAttribute("page_name", "app_update");

			cls_casemgt casemgt_web_service = new cls_casemgt();
			/*
			 * String web_service_response_menu = null;
			 * web_service_response_menu = casemgt_web_service
			 * .load_application_batched_to_user((String)
			 * session.getAttribute("userid")); JSONObject menu_obj; menu_obj =
			 * new JSONObject(web_service_response_menu); String all_menus =
			 * menu_obj.get("data").toString();
			 * 
			 * Gson googleJson = new Gson(); ArrayList javaArrayListFromGSON =
			 * googleJson.fromJson(all_menus, ArrayList.class);
			 * request.setAttribute("applicationlist", javaArrayListFromGSON);
			 */
					model.addAttribute("content", "../pages/client_application/app_update.jsp"); return "layouts/app";

		} else {

			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

	}

	@RequestMapping("/case_movement_module_search_jobs")
	@GetMapping
	public String case_movement_module_search_jobs(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

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
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				String get_all_users_short = (String) session.getAttribute("get_all_users_short");
				Gson googleJson_user = new Gson();
				ArrayList javaArrayListFromGSON_users = googleJson_user.fromJson(get_all_users_short, ArrayList.class);
				request.setAttribute("userlist", javaArrayListFromGSON_users);

				web_service_response_menu = casemgt_web_service
						.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));
				System.out.println(web_service_response_menu);
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);
						model.addAttribute("content", "../pages/client_application/case_movement_module_search_jobs.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/case_movement_module")
	@GetMapping
	public String case_movement_module(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
		// request"/client_application/app_database_update.jsp").forward(request,
		// response);
		// HttpSession session = request.getSession();

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}
		// System.out.println(servletName + ' ' + assigenedmenus);
		// Log User out if the user tries to access right not assigned
		if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				String web_service_response_menu_data = null;
				String web_service_response_tc = null;

				web_service_response_menu = casemgt_web_service
						.load_count_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));
				// System.out.println(web_service_response_menu);
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("total").toString();

				// Gson googleJson = new Gson();
				// ArrayList javaArrayListFromGSON =
				// googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlistcount", all_menus);

				web_service_response_menu_data = casemgt_web_service
						.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));

				JSONObject menu_obj_data;
				menu_obj_data = new JSONObject(web_service_response_menu_data);
				String all_menus_data = menu_obj_data.get("data").toString();
				// System.out.println(all_menus_data);
				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus_data, ArrayList.class);

				request.setAttribute("applicationlist", javaArrayListFromGSON);

				// web_service_response_tc = casemgt_web_service
				// 		.load_count_transitional_plotting_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
				// 				cls_url_config.getWeb_service_url_ser_api_key(),
				// 				(String) session.getAttribute("userid"));

				web_service_response_tc = casemgt_web_service
				.load_count_request_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						(String) session.getAttribute("userid"));

				JSONObject result_obj;

				result_obj = new JSONObject(web_service_response_tc);
				String incoming = result_obj.get("incoming").toString();

				request.setAttribute("applicationCount", incoming);


						model.addAttribute("content", "../pages/client_application/case_movement_module.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";
	}

	@RequestMapping("/compliance_cst")
	@GetMapping
	public String compliance_cst(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// HttpSession session = request.getSession();
		try {

			cls_casemgt casemgt_web_service = new cls_casemgt();
			String web_service_response_menu = null;
			web_service_response_menu = casemgt_web_service
					.load_cst_compliance_dashboard(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), "null");
			JSONObject menu_obj = new JSONObject(web_service_response_menu);
			// System.out.print("compliance_cst: " + web_service_response_menu);
			JSONObject cordiantor = new JSONObject(menu_obj.get("cordiantor").toString());
			JSONObject supervisor_smd = new JSONObject(menu_obj.get("supervisor_smd").toString());
			JSONObject supervisor_pvlmd = new JSONObject(menu_obj.get("supervisor_pvlmd").toString());
			JSONObject supervisor_lrd = new JSONObject(menu_obj.get("supervisor_lrd").toString());
			String apps_at_qc = menu_obj.get("apps_at_qc").toString();
			String summary_count = menu_obj.get("summary_count").toString();
			JSONObject summary = new JSONObject(menu_obj.get("summary").toString());

			Gson googleJson = new Gson();

			// ArrayList cordiantor_list = googleJson.fromJson(cordiantor,
			// ArrayList.class);
			// request.setAttribute("summary", summary);
			request.setAttribute("cordiantor_in", cordiantor.get("incoming"));
			request.setAttribute("cordiantor_comp", cordiantor.get("completed"));
			request.setAttribute("cordiantor_smd", cordiantor.get("smd_remaining"));
			request.setAttribute("cordiantor_lrd", cordiantor.get("lrd_remaining"));
			request.setAttribute("cordiantor_pvlmd", cordiantor.get("pvlmd_remaining"));
			request.setAttribute("cordiantor_all", cordiantor.get("queried"));
			request.setAttribute("supervisor_pvlmd_in", supervisor_pvlmd.get("incoming"));
			request.setAttribute("supervisor_pvlmd_comp", supervisor_pvlmd.get("completed"));
			request.setAttribute("supervisor_pvlmd_queried", supervisor_pvlmd.get("queried"));

			request.setAttribute("supervisor_smd_in", supervisor_smd.get("incoming"));
			request.setAttribute("supervisor_smd_comp", supervisor_smd.get("completed"));
			request.setAttribute("supervisor_smd_queried", supervisor_smd.get("queried"));

			request.setAttribute("supervisor_lrd_in", supervisor_lrd.get("incoming"));
			request.setAttribute("supervisor_lrd_comp", supervisor_lrd.get("completed"));
			request.setAttribute("supervisor_lrd_queried", supervisor_lrd.get("queried"));

			request.setAttribute("summary_in", summary.get("incoming"));
			request.setAttribute("summary_comp", summary.get("completed"));
			request.setAttribute("summary_queried", summary.get("queried"));

			request.setAttribute("apps_at_qc", apps_at_qc);
			request.setAttribute("summary_count", summary_count);

			request.setAttribute("page_name", "compliance_cst");
					model.addAttribute("content", "../pages/client_application/compliance_cst.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}


	@RequestMapping("/corporate_frrv_cst_compliance")
	@GetMapping
	public String corporate_frrv_cst_compliance(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// HttpSession session = request.getSession();
		try {

			cls_casemgt casemgt_web_service = new cls_casemgt();
			String web_service_response_menu = null;
			web_service_response_menu = casemgt_web_service
					.load_corporate_frrv_cst_compliance_dashboard(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), "null");
			JSONObject menu_obj = new JSONObject(web_service_response_menu);
			// System.out.print("compliance_cst: " + web_service_response_menu);
			JSONObject cordiantor = new JSONObject(menu_obj.get("cordiantor").toString());
			JSONObject supervisor_smd = new JSONObject(menu_obj.get("supervisor_smd").toString());
			JSONObject supervisor_pvlmd = new JSONObject(menu_obj.get("supervisor_pvlmd").toString());
			JSONObject supervisor_lrd = new JSONObject(menu_obj.get("supervisor_lrd").toString());
			String apps_at_qc = menu_obj.get("apps_at_qc").toString();
			String summary_count = menu_obj.get("summary_count").toString();
			JSONObject summary = new JSONObject(menu_obj.get("summary").toString());
			String stamping_unit_count = menu_obj.get("stamping_unit_count").toString();
			String registration_unit_count = menu_obj.get("registration_unit_count").toString();
			String estates_unit_count = menu_obj.get("estates_unit_count").toString();

			Gson googleJson = new Gson();

			// ArrayList cordiantor_list = googleJson.fromJson(cordiantor,
			// ArrayList.class);
			// request.setAttribute("summary", summary);
			request.setAttribute("cordiantor_in", cordiantor.get("incoming"));
			request.setAttribute("cordiantor_comp", cordiantor.get("completed"));
			request.setAttribute("cordiantor_smd", cordiantor.get("smd_remaining"));
			request.setAttribute("cordiantor_lrd", cordiantor.get("lrd_remaining"));
			request.setAttribute("cordiantor_pvlmd", cordiantor.get("pvlmd_remaining"));
			request.setAttribute("cordiantor_all", cordiantor.get("queried"));
			request.setAttribute("supervisor_pvlmd_in", supervisor_pvlmd.get("incoming"));
			request.setAttribute("supervisor_pvlmd_comp", supervisor_pvlmd.get("completed"));
			request.setAttribute("supervisor_pvlmd_queried", supervisor_pvlmd.get("queried"));

			request.setAttribute("supervisor_smd_in", supervisor_smd.get("incoming"));
			request.setAttribute("supervisor_smd_comp", supervisor_smd.get("completed"));
			request.setAttribute("supervisor_smd_queried", supervisor_smd.get("queried"));

			request.setAttribute("supervisor_lrd_in", supervisor_lrd.get("incoming"));
			request.setAttribute("supervisor_lrd_comp", supervisor_lrd.get("completed"));
			request.setAttribute("supervisor_lrd_queried", supervisor_lrd.get("queried"));

			request.setAttribute("summary_in", summary.get("incoming"));
			request.setAttribute("summary_comp", summary.get("completed"));
			request.setAttribute("summary_queried", summary.get("queried"));

			request.setAttribute("apps_at_qc", apps_at_qc);
			request.setAttribute("summary_count", summary_count);

			request.setAttribute("stamping_unit_count", stamping_unit_count);
			request.setAttribute("registration_unit_count", registration_unit_count);
			request.setAttribute("estates_unit_count", estates_unit_count);

			request.setAttribute("page_name", "compliance_cst");
					model.addAttribute("content", "../pages/client_application/corporate_frrv_cst_compliance.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/compliance")
	@GetMapping
	public String compliance_1(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		// //HttpSession session = request.getSession();

		// String servletName = request.getServletPath();
		// servletName = servletName.replace("/", "");
		// String assigenedmenus = (String) session.getAttribute("menus_com");
		// boolean isFound = false;
		// try {
		// isFound = assigenedmenus.contains(servletName); // true
		// } catch (Exception e) {
		// }
		//
		// // Log User out if the user tries to access right not assigned
		// if (!isFound) {
		// request.setAttribute("login", "Please this is not alllowed");
		// //
		//  model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		//
		// }
		// if ((String) session.getAttribute("userid") != null || (String)
		// session.getAttribute("userid") != "") {

		// cls_casemgt casemgt_web_service = new cls_casemgt();
		/*
		 * String web_service_response_menu = null;
		 * web_service_response_menu = casemgt_web_service
		 * .load_application_batched_to_user((String)
		 * session.getAttribute("userid")); JSONObject menu_obj; menu_obj =
		 * new JSONObject(web_service_response_menu); String all_menus =
		 * menu_obj.get("data").toString();
		 * 
		 * Gson googleJson = new Gson(); ArrayList javaArrayListFromGSON =
		 * googleJson.fromJson(all_menus, ArrayList.class);
		 * request.setAttribute("applicationlist", javaArrayListFromGSON);
		 */

		String office_region_list = (String) session.getAttribute("office_region_list");
		// System.out.println(office_region_list);
		Gson googleJson = new Gson();
		ArrayList javaArrayListFromGSON = googleJson.fromJson(office_region_list, ArrayList.class);
		request.setAttribute("officeregionlist", javaArrayListFromGSON);

		request.setAttribute("page_name", "compliance");
				model.addAttribute("content", "../pages/client_application/compliance.jsp"); return "layouts/app";

		// } else {
		// request.setAttribute("login", "sessionout");
		// // System.out.println("If Not success");
		//  model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		//
		// }

	}

	@RequestMapping("/compliance_executive")
	@GetMapping
	public String compliance_executive(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		String office_region_list = (String) session.getAttribute("office_region_list");
		// System.out.println(office_region_list);
		Gson googleJson = new Gson();
		ArrayList javaArrayListFromGSON = googleJson.fromJson(office_region_list, ArrayList.class);
		request.setAttribute("officeregionlist", javaArrayListFromGSON);
		request.setAttribute("page_name", "compliance");
				model.addAttribute("content", "../pages/client_application/compliance_executive.jsp"); return "layouts/app";

	}

	@RequestMapping("/regional_compliance")
	@GetMapping
	public String compliance_regional(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			cls_casemgt casemgt_web_service = new cls_casemgt();
			/*
			 * String web_service_response_menu = null;
			 * web_service_response_menu = casemgt_web_service
			 * .load_application_batched_to_user((String)
			 * session.getAttribute("userid")); JSONObject menu_obj; menu_obj =
			 * new JSONObject(web_service_response_menu); String all_menus =
			 * menu_obj.get("data").toString();
			 * 
			 * Gson googleJson = new Gson(); ArrayList javaArrayListFromGSON =
			 * googleJson.fromJson(all_menus, ArrayList.class);
			 * request.setAttribute("applicationlist", javaArrayListFromGSON);
			 */
			request.setAttribute("page_name", "compliance");
			request.setAttribute("page_sub_name", "regional_compliance");
					model.addAttribute("content", "../pages/client_application/compliance_regional.jsp"); return "layouts/app";

		} else {
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		// return "";
	}

	@RequestMapping("/compliance2")
	@GetMapping
	public String compliance(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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
		if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {

			cls_casemgt casemgt_web_service = new cls_casemgt();
			/*
			 * String web_service_response_menu = null;
			 * web_service_response_menu = casemgt_web_service
			 * .load_application_batched_to_user((String)
			 * session.getAttribute("userid")); JSONObject menu_obj; menu_obj =
			 * new JSONObject(web_service_response_menu); String all_menus =
			 * menu_obj.get("data").toString();
			 * 
			 * Gson googleJson = new Gson(); ArrayList javaArrayListFromGSON =
			 * googleJson.fromJson(all_menus, ArrayList.class);
			 * request.setAttribute("applicationlist", javaArrayListFromGSON);
			 */
			request.setAttribute("page_name", "compliance");
					model.addAttribute("content", "../pages/client_application/compliance.jsp"); return "layouts/app";

		} else {
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

	}

	@RequestMapping("/divisional_registry_case_movement_module")
	@GetMapping
	public String divisional_registry_case_movement_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// HttpSession session = request.getSession();

			if ((String) session.getAttribute("division") != null && (String) session.getAttribute("division") != "") {
				// Session is expired

				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				web_service_response_menu = casemgt_web_service.load_new_application_for_division(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						(String) session.getAttribute("division"),
						(String) session.getAttribute("regional_code"));
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/client_application/divisional_registry_case_movement_module.jsp"); return "layouts/app";

			} else {
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/client_application_1")
	@PostMapping
	public String client_application(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		String gender_id = "";
		String gender_desc;

		String locality_id = "";
		String locality_desc;

		String district_id = "";
		String district_desc;

		String region_id = "";
		String region_desc;

		String main_service_sub_id = request.getParameter("main_service_sub_id");
		String main_service_sub_desc = request.getParameter("main_service_sub_desc");
		String main_service_id = request.getParameter("main_service_id");
		String main_service_desc = request.getParameter("main_service_desc");
		String ls_number = request.getParameter("ls_number");
		String number_of_request = request.getParameter("qty");
		String client_name = request.getParameter("client_name");

		String gender = request.getParameter("gender");
		String locality = request.getParameter("locality");
		String district = request.getParameter("district");
		String region = request.getParameter("region");

		String[] gender_to_split = gender.split("-");
		gender_id = gender_to_split[0];
		gender_desc = gender_to_split[1];

		String[] locality_to_split = locality.split("-");
		locality_id = locality_to_split[0];
		locality_desc = locality_to_split[1];

		String[] district_to_split = district.split("-");
		district_id = district_to_split[0];
		district_desc = district_to_split[1];

		String[] region_to_split = region.split("-");
		region_id = region_to_split[0];
		region_desc = region_to_split[1];

		JSONArray jsonArr = new JSONArray();
		try {
			JSONObject obj = new JSONObject();
			obj.put("business_process_id", main_service_id);
			obj.put("business_process_name", main_service_desc);
			obj.put("business_process_sub_id", main_service_sub_id);
			obj.put("business_process_sub_name", main_service_sub_desc);
			obj.put("ls_number", ls_number);
			obj.put("number_of_request", number_of_request);
			obj.put("client_name", client_name);

			obj.put("gender", gender_desc);
			obj.put("locality", locality_desc);
			obj.put("district", district_desc);
			obj.put("region", region_desc);

			jsonArr.put(obj);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String input = jsonArr.toString();
		System.out.println(input);

		Ws_client_application user_web_service = new Ws_client_application();
		String jsonArrayContent = null;
		jsonArrayContent = user_web_service.get_bill_pdf(cls_url_config.getWeb_service_url_ser(),
				cls_url_config.getWeb_service_url_ser_api_key(), input);
		// System.out.println("ResponseMessageFromServer: " + jsonArrayContent);
		// response.setContentType("application/pdf");
		// response.setHeader("Content-disposition", "attachment; " +
		// "filename=MyJerseyPdfFile.pdf");

		File pdfFile = new File(jsonArrayContent);

		response.setContentType("application/pdf");
		// response.addHeader("Content-Disposition", "inline;
		// filename=bill_file.pdf");
		response.addHeader("Content-Disposition", "attachment; filename=bill_file.pdf");
		response.setContentLength((int) pdfFile.length());

		/*
		 * FileInputStream fileInputStream = new FileInputStream(pdfFile);
		 * OutputStream responseOutputStream = response.getOutputStream(); int
		 * bytes; while ((bytes = fileInputStream.read()) != -1) {
		 * responseOutputStream.write(bytes);
		 * 
		 * }
		 */
				model.addAttribute("content", "../pages/client_application/client_application.jsp"); return "layouts/app";
	}

	@RequestMapping("/enquiry_backoffice")
	@GetMapping
	public String enquiry_backoffice(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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

		try {

			/// //HttpSession session = request.getSession();

			request.setAttribute("page_name", "page_enquiry_backoffice");
					model.addAttribute("content", "../pages/client_application/enquiry_backoffice.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";

	}

	@RequestMapping("/enquiry_teller")
	@GetMapping
	public String enquiry_teller(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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

		try {

			/// //HttpSession session = request.getSession();

			request.setAttribute("page_name", "page_enquiry_teller");
					model.addAttribute("content", "../pages/client_application/enquiry_teller.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";

	}

	@RequestMapping("/file_management_1")
	@PostMapping
	public String file_management_1(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			request.setAttribute("page_name", "page_file_management");
			// HttpSession session = request.getSession();
			request.setAttribute("page_name", "page_enquiry_backoffice");
					model.addAttribute("content", "../pages/client_application/file_management.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";

	}

	@RequestMapping("/front_office_batch_module")
	@PostMapping
	public String front_office_batch_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

		// String case_number = "LCGARGAPCN716613620190";
		// String job_number = "SMDGAPPA132305820190";
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
				model.addAttribute("content", "../pages/client_application/front_office_batch_module.jsp"); return "layouts/app";

	}

	@RequestMapping("/front_office_case_add_on")
	@PostMapping
	public String front_office_case_add_on(HttpSession session, Model model, HttpServletRequest request,HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// HttpSession session = request.getSession();

		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String search_text = request.getParameter("search_text");

			System.out.println(search_text);

			// JSONObject obj = new JSONObject();

			// String batchlistdivison = obj.toString();
			System.out.println(search_text);
			web_service_response = casemagt_cl.select_general_case_details_fo_case_add_on(
					cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
					search_text.trim());
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);
				String parcel_details = case_obj.get("parcel_details").toString();
				String case_details = case_obj.get("all_transaction").toString();
				String current_transaction = case_obj.get("current_transaction").toString();
				// String job_details = case_obj.get("job_details").toString();
				// String parcels_coordinates =
				// case_obj.get("parcels_coordinates").toString();
				// String lrd_valuation_section =
				// case_obj.get("lrd_valuation_section").toString();
				// String lrd_memorials_section =
				// case_obj.get("lrd_memorials_section").toString();
				// String lrd_encumbrances_section =
				// case_obj.get("lrd_encumbrances_section").toString();
				// String lrd_certificate_section =
				// case_obj.get("lrd_certificate_section").toString();
				// String lrd_proprietorship_section =
				// case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				// String payment_bill =
				// case_obj.get("payment_bill").toString();
				// String comments_on_application =
				// case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();

				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList case_details_list = googleJson.fromJson(case_details, ArrayList.class);
				// ArrayList job_details_list = googleJson.fromJson(job_details,
				// ArrayList.class);
				// ArrayList parcels_coordinates_list =
				// googleJson.fromJson(parcels_coordinates, ArrayList.class);
				// ArrayList lrd_valuation_section_list =
				// googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				// ArrayList lrd_memorials_section_list =
				// googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				// ArrayList lrd_encumbrances_section_list =
				// googleJson.fromJson(lrd_encumbrances_section,ArrayList.class);

				// ArrayList lrd_certificate_section_list =
				// googleJson.fromJson(lrd_certificate_section,
				// ArrayList.class);
				// ArrayList lrd_proprietorship_section_list =
				// googleJson.fromJson(lrd_proprietorship_section,ArrayList.class);

				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				// ArrayList payment_bill_list =
				// googleJson.fromJson(payment_bill, ArrayList.class);
				// ArrayList comments_on_application_list =
				// googleJson.fromJson(comments_on_application,
				// ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				/// request.setAttribute("main_details", main_details);
				// request.setAttribute("job_details", job_details_list);
				request.setAttribute("case_details", case_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				// request.setAttribute("lrd_valuation_section",
				// lrd_valuation_section_list);
				// request.setAttribute("lrd_memorials_section",
				// lrd_memorials_section_list);
				// request.setAttribute("lrd_encumbrances_section",
				// lrd_encumbrances_section_list);
				// request.setAttribute("lrd_certificate_section",
				// lrd_certificate_section_list);
				// request.setAttribute("lrd_proprietorship_section",
				// lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				// request.setAttribute("payment_bill", payment_bill_list);
				// request.setAttribute("comments_on_application",
				// comments_on_application_list);
				request.setAttribute("parties", parties_list);

				request.setAttribute("case_query", case_query_list);

				request.setAttribute("case_objection", case_objection_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject(parcel_details);

				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("case_number", parcel_details_obj.get("case_number").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				// main_detailse_obj.get("stamp_duty_description").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject main_detailse_obj;
				main_detailse_obj = new JSONObject(current_transaction);

				request.setAttribute("ar_name", main_detailse_obj.get("ar_name").toString());
				// request.setAttribute("application_stage",
				// main_detailse_obj.get("application_stage").toString());
				request.setAttribute("transaction_number", main_detailse_obj.get("transaction_number").toString());

				request.setAttribute("date_of_document", main_detailse_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument", main_detailse_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number", main_detailse_obj.get("certificate_number").toString());

				// request.setAttribute("registry_mapref",
				// main_detailse_obj.get("registry_mapref").toString());
				request.setAttribute("type_of_interest", main_detailse_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", main_detailse_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", main_detailse_obj.get("volume_number").toString());
				request.setAttribute("folio_number", main_detailse_obj.get("folio_number").toString());
				request.setAttribute("term", main_detailse_obj.get("term").toString());
				request.setAttribute("commencement_date", main_detailse_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", main_detailse_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", main_detailse_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable", main_detailse_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", main_detailse_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", main_detailse_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", main_detailse_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period", main_detailse_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", main_detailse_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered", main_detailse_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", main_detailse_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						main_detailse_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", main_detailse_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", main_detailse_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration", main_detailse_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", main_detailse_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", main_detailse_obj.get("stool_family_name").toString()); //
				request.setAttribute("is_part_of_gelis_area", //
						main_detailse_obj.get("is_part_of_gelis_area").toString());
				// request.setAttribute("stamp_duty_description",

				// request.setAttribute("job_number", job_number);

				// request.setAttribute("business_process_id",
				// main_detailse_obj.get("business_process_id").toString());
				// request.setAttribute("business_process_name",
				// main_detailse_obj.get("business_process_name").toString());
				// request.setAttribute("business_process_sub_id",
				// main_detailse_obj.get("business_process_sub_id").toString());
				// request.setAttribute("business_process_sub_name",
				// main_detailse_obj.get("business_process_sub_name").toString());
				// request.setAttribute("phone_number",
				// main_detailse_obj.get("phone_number").toString());

				request.setAttribute("certificate_type", main_detailse_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", main_detailse_obj.get("case_file_number").toString());
				// request.setAttribute("embossed",
				// main_detailse_obj.get("embossed").toString());
				request.setAttribute("case_process_stage", main_detailse_obj.get("case_process_stage").toString());

				System.out.println((String) session.getAttribute("web_main_services"));
				ArrayList javaArrayListFromGSON_sub_service = googleJson
						.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
				request.setAttribute("main_services", javaArrayListFromGSON_sub_service);

			} else {
				System.out.println(web_service_response);
			}

			/*
			 * JSONArray arr_r = new JSONArray();
			 * 
			 * String folderpath
			 * =cls_url_config.get_lrd_jacket_pdf_path_final_app() + case_number;
			 * //System.out.println("folderpath: " +folderpath); //List All
			 * Files In a Folder File subdir = new File(folderpath.toString());
			 * String[] children = subdir.list(); if (children == null) {
			 * System.out.println(
			 * "Either dir does not exist or is not a directory"); } else { for
			 * (int j = 0; j< children.length; j++) { String filename_doc =
			 * children[j]; System.out.println("case_number: " +case_number);
			 * System.out.println("File: " +filename_doc); String path =
			 * folderpath.toString()+"\\"+filename_doc;
			 * 
			 * String extension =
			 * filename_doc.substring(filename_doc.lastIndexOf("."));
			 * 
			 * JSONObject obj_r = new JSONObject(); obj_r.put( "document_name" ,
			 * filename_doc ); obj_r.put( "document_type" , path ); obj_r.put(
			 * "document_extention" , extension ); obj_r.put( "document_file"
			 * ,path ); obj_r.put( "uploaded_by" , "" ); obj_r.put(
			 * "uploaded_date" , "" );
			 * 
			 * arr_r.add(obj_r); }
			 * 
			 * } System.out.println(arr_r.toString());
			 * 
			 * request.setAttribute("casescanneddocuments", arr_r.toString());
			 */

					model.addAttribute("content", "../pages/client_application/front_office_case_add_on.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/front_office_enquiry_desk_module")
	@GetMapping
	public String front_office_enquiry_desk_module(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
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

		} // TODO Auto-generated method stub
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
		// request"/client_application/app_database_update.jsp").forward(request,
		// response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
				model.addAttribute("content", "../pages/client_application/front_office_enquiry_desk_module.jsp"); return "layouts/app";

	}

	@RequestMapping("/front_office_view_application")
	@PostMapping
	public String front_office_view_application(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// HttpSession session = request.getSession();

		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String search_text = request.getParameter("search_text");

			// System.out.println(search_text);

			// JSONObject obj = new JSONObject();

			// String batchlistdivison = obj.toString();
			// System.out.println(search_text);
			web_service_response = casemagt_cl.select_general_case_details_fo_case_add_on(
					cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
					search_text.trim());
			if (web_service_response != null) {
				// System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);
				String parcel_details = case_obj.get("parcel_details").toString();
				String case_details = case_obj.get("all_transaction").toString();
				String current_transaction = case_obj.get("current_transaction").toString();
				String job_details = case_obj.get("job_details").toString();
				String job_detail = case_obj.get("job_detail").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();

				ArrayList case_details_list = googleJson.fromJson(case_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				// ArrayList parcels_coordinates_list =
				// googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);

				

				request.setAttribute("job_details", job_details_list);
				request.setAttribute("case_details", case_details_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("payment_invoice", payment_invoice_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject(parcel_details);
				JSONObject job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("job_number", job_detail_obj.get("job_number").toString());
				request.setAttribute("case_number", parcel_details_obj.get("case_number").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				// main_detailse_obj.get("stamp_duty_description").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject main_detailse_obj;
				main_detailse_obj = new JSONObject(current_transaction);

				request.setAttribute("ar_name", main_detailse_obj.get("ar_name").toString());
				// request.setAttribute("application_stage",
				// main_detailse_obj.get("application_stage").toString());
				request.setAttribute("transaction_number", main_detailse_obj.get("transaction_number").toString());

				request.setAttribute("date_of_document", main_detailse_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument", main_detailse_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number", main_detailse_obj.get("certificate_number").toString());

				// request.setAttribute("registry_mapref",
				// main_detailse_obj.get("registry_mapref").toString());
				request.setAttribute("type_of_interest", main_detailse_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", main_detailse_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", main_detailse_obj.get("volume_number").toString());
				request.setAttribute("folio_number", main_detailse_obj.get("folio_number").toString());
				request.setAttribute("term", main_detailse_obj.get("term").toString());
				request.setAttribute("commencement_date", main_detailse_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", main_detailse_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", main_detailse_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable", main_detailse_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", main_detailse_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", main_detailse_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", main_detailse_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period", main_detailse_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", main_detailse_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered", main_detailse_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", main_detailse_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						main_detailse_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", main_detailse_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", main_detailse_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration", main_detailse_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", main_detailse_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", main_detailse_obj.get("stool_family_name").toString()); //
				request.setAttribute("is_part_of_gelis_area", //
						main_detailse_obj.get("is_part_of_gelis_area").toString());
				// request.setAttribute("stamp_duty_description",

				// request.setAttribute("business_process_id",
				// main_detailse_obj.get("business_process_id").toString());
				// request.setAttribute("business_process_name",
				// main_detailse_obj.get("business_process_name").toString());
				// request.setAttribute("business_process_sub_id",
				// main_detailse_obj.get("business_process_sub_id").toString());
				// request.setAttribute("business_process_sub_name",
				// main_detailse_obj.get("business_process_sub_name").toString());
				// request.setAttribute("phone_number",
				// main_detailse_obj.get("phone_number").toString());

				request.setAttribute("certificate_type", main_detailse_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", main_detailse_obj.get("case_file_number").toString());
				// request.setAttribute("embossed",
				// main_detailse_obj.get("embossed").toString());
				request.setAttribute("case_process_stage", main_detailse_obj.get("case_process_stage").toString());

				request.setAttribute("created_date", main_detailse_obj.get("created_date").toString());
				request.setAttribute("modified_date", main_detailse_obj.get("modified_date").toString());

				System.out.println((String) session.getAttribute("web_main_services"));
				ArrayList javaArrayListFromGSON_sub_service = googleJson
						.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
				request.setAttribute("main_services", javaArrayListFromGSON_sub_service);

			} else {
				System.out.println(web_service_response);
			}

					model.addAttribute("content", "../pages/client_application/front_office_view_application.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/view_application_details")
	@PostMapping
	public String view_application_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// HttpSession session = request.getSession();

		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String search_text = request.getParameter("search_text");

			// System.out.println(search_text);

			// JSONObject obj = new JSONObject();

			// String batchlistdivison = obj.toString();
			// System.out.println(search_text);
			web_service_response = casemagt_cl.select_general_case_details_fo_case_add_on(
					cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
					search_text.trim());
			if (web_service_response != null) {
				// System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);
				String parcel_details = case_obj.get("parcel_details").toString();
				String case_details = case_obj.get("all_transaction").toString();
				String current_transaction = case_obj.get("current_transaction").toString();
				String job_details = case_obj.get("job_details").toString();
				String job_detail = case_obj.get("job_detail").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();

				ArrayList case_details_list = googleJson.fromJson(case_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				// ArrayList parcels_coordinates_list =
				// googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);

				

				request.setAttribute("job_details", job_details_list);
				request.setAttribute("case_details", case_details_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("payment_invoice", payment_invoice_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject(parcel_details);
				JSONObject job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("job_number", job_detail_obj.get("job_number").toString());
				request.setAttribute("case_number", parcel_details_obj.get("case_number").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				// main_detailse_obj.get("stamp_duty_description").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject main_detailse_obj;
				main_detailse_obj = new JSONObject(current_transaction);

				request.setAttribute("ar_name", main_detailse_obj.get("ar_name").toString());
				// request.setAttribute("application_stage",
				// main_detailse_obj.get("application_stage").toString());
				request.setAttribute("transaction_number", main_detailse_obj.get("transaction_number").toString());

				request.setAttribute("date_of_document", main_detailse_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument", main_detailse_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number", main_detailse_obj.get("certificate_number").toString());

				// request.setAttribute("registry_mapref",
				// main_detailse_obj.get("registry_mapref").toString());
				request.setAttribute("type_of_interest", main_detailse_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", main_detailse_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", main_detailse_obj.get("volume_number").toString());
				request.setAttribute("folio_number", main_detailse_obj.get("folio_number").toString());
				request.setAttribute("term", main_detailse_obj.get("term").toString());
				request.setAttribute("commencement_date", main_detailse_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", main_detailse_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", main_detailse_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable", main_detailse_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", main_detailse_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", main_detailse_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", main_detailse_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period", main_detailse_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", main_detailse_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered", main_detailse_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", main_detailse_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						main_detailse_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", main_detailse_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", main_detailse_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration", main_detailse_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", main_detailse_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", main_detailse_obj.get("stool_family_name").toString()); //
				request.setAttribute("is_part_of_gelis_area", //
						main_detailse_obj.get("is_part_of_gelis_area").toString());
				// request.setAttribute("stamp_duty_description",

				// request.setAttribute("business_process_id",
				// main_detailse_obj.get("business_process_id").toString());
				// request.setAttribute("business_process_name",
				// main_detailse_obj.get("business_process_name").toString());
				// request.setAttribute("business_process_sub_id",
				// main_detailse_obj.get("business_process_sub_id").toString());
				// request.setAttribute("business_process_sub_name",
				// main_detailse_obj.get("business_process_sub_name").toString());
				// request.setAttribute("phone_number",
				// main_detailse_obj.get("phone_number").toString());

				request.setAttribute("certificate_type", main_detailse_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", main_detailse_obj.get("case_file_number").toString());
				// request.setAttribute("embossed",
				// main_detailse_obj.get("embossed").toString());
				request.setAttribute("case_process_stage", main_detailse_obj.get("case_process_stage").toString());

				request.setAttribute("created_date", main_detailse_obj.get("created_date").toString());
				request.setAttribute("modified_date", main_detailse_obj.get("modified_date").toString());

				System.out.println((String) session.getAttribute("web_main_services"));
				ArrayList javaArrayListFromGSON_sub_service = googleJson
						.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
				request.setAttribute("main_services", javaArrayListFromGSON_sub_service);

			} else {
				System.out.println(web_service_response);
			}

					model.addAttribute("content", "../pages/client_application/view_application_details.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/front_office_view_application_st")
	@PostMapping
	public String front_office_view_application_st(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();

			String search_text = request.getParameter("search_text");

			// System.out.println(search_text);

			// JSONObject obj = new JSONObject();

			// String batchlistdivison = obj.toString();
			// System.out.println(search_text);
			web_service_response = casemagt_cl.select_general_case_details_fo_case_add_on(
					cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
					search_text.trim());
			if (web_service_response != null) {
				// System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);
				String parcel_details = case_obj.get("parcel_details").toString();
				String case_details = case_obj.get("all_transaction").toString();
				String current_transaction = case_obj.get("current_transaction").toString();
				String job_details = case_obj.get("job_details").toString();
				String job_detail = case_obj.get("job_detail").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();

				ArrayList case_details_list = googleJson.fromJson(case_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				// ArrayList parcels_coordinates_list =
				// googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);

				request.setAttribute("job_details", job_details_list);
				request.setAttribute("case_details", case_details_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("payment_invoice", payment_invoice_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject(parcel_details);
				JSONObject job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("job_number", job_detail_obj.get("job_number").toString());
				request.setAttribute("case_number", parcel_details_obj.get("case_number").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				// main_detailse_obj.get("stamp_duty_description").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject main_detailse_obj;
				main_detailse_obj = new JSONObject(current_transaction);

				request.setAttribute("ar_name", main_detailse_obj.get("ar_name").toString());
				// request.setAttribute("application_stage",
				// main_detailse_obj.get("application_stage").toString());
				request.setAttribute("transaction_number", main_detailse_obj.get("transaction_number").toString());

				request.setAttribute("date_of_document", main_detailse_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument", main_detailse_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number", main_detailse_obj.get("certificate_number").toString());

				// request.setAttribute("registry_mapref",
				// main_detailse_obj.get("registry_mapref").toString());
				request.setAttribute("type_of_interest", main_detailse_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", main_detailse_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", main_detailse_obj.get("volume_number").toString());
				request.setAttribute("folio_number", main_detailse_obj.get("folio_number").toString());
				request.setAttribute("term", main_detailse_obj.get("term").toString());
				request.setAttribute("commencement_date", main_detailse_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", main_detailse_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", main_detailse_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable", main_detailse_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", main_detailse_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", main_detailse_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", main_detailse_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period", main_detailse_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", main_detailse_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered", main_detailse_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", main_detailse_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						main_detailse_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", main_detailse_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", main_detailse_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration", main_detailse_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", main_detailse_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", main_detailse_obj.get("stool_family_name").toString()); //
				request.setAttribute("is_part_of_gelis_area", //
						main_detailse_obj.get("is_part_of_gelis_area").toString());

				request.setAttribute("certificate_type", main_detailse_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", main_detailse_obj.get("case_file_number").toString());
				// request.setAttribute("embossed",
				// main_detailse_obj.get("embossed").toString());
				request.setAttribute("case_process_stage", main_detailse_obj.get("case_process_stage").toString());

				request.setAttribute("created_date", main_detailse_obj.get("created_date").toString());
				request.setAttribute("modified_date", main_detailse_obj.get("modified_date").toString());

				System.out.println((String) session.getAttribute("web_main_services"));
				ArrayList javaArrayListFromGSON_sub_service = googleJson
						.fromJson((String) session.getAttribute("web_main_services"), ArrayList.class);
				request.setAttribute("main_services", javaArrayListFromGSON_sub_service);

			} else {
				System.out.println(web_service_response);
			}

					model.addAttribute("content", "../pages/client_application/front_office_view_application_st.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/app_database_update_1")
	@GetMapping
	public String app_database_update_1(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/client_application/app_database_update.jsp"); return "layouts/app";

	}

	@RequestMapping("/maps_internal_search")
	@GetMapping
	public String maps_internal_search(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		request.setAttribute("page_name", "case_processing");
				model.addAttribute("content", "../pages/client_application/maps_internal_search.jsp"); return "layouts/app";

	}

	@RequestMapping("/new_case_modal")
	@GetMapping
	public String new_case_modal(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
				model.addAttribute("content", "../pages/client_application/new_case_modal.jsp"); return "layouts/app";

	}

	@RequestMapping("/processing_after_payment_reg")
	@PostMapping
	public String processing_after_payment_reg(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

		// String web_service_response =null;
		// String job_number = request.getParameter("job_number");
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		String job_number = request.getParameter("job_number");
		System.out.println(job_number);

		request.setAttribute("job_number", job_number);
				model.addAttribute("content", "../pages/client_application/processing_after_payment_reg.jsp"); return "layouts/app";

	}

	@RequestMapping("/registratio_records_Info_module")
	@GetMapping
	public String registratio_records_Info_module(HttpSession session, Model model, HttpServletRequest request,
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
		// request"/client_application/app_database_update.jsp").forward(request,
		// response);

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// HttpSession session = request.getSession();

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				web_service_response_menu = casemgt_web_service
						.load_application_first_regisstration_records(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));
				System.out.println(web_service_response_menu);
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);
				request.setAttribute("page_name", "registration_rec_info_module");
						model.addAttribute("content", "../pages/client_application/registratio_records_Info_module.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/search_application_progress_details")
	@PostMapping
	public String search_application_progress_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			System.out.println(case_number);

			JSONObject obj = new JSONObject();

			obj.put("case_number", case_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);
				String main_details = case_obj.get("main_details").toString();
				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				request.setAttribute("main_details", main_details);
				request.setAttribute("job_details", job_details_list);
				request.setAttribute("parcels_coordinates", parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				JSONObject main_detailse_obj;
				main_detailse_obj = new JSONObject(main_details);

				request.setAttribute("application_stage", main_detailse_obj.get("application_stage").toString());
				request.setAttribute("case_number", main_detailse_obj.get("case_number").toString());
				request.setAttribute("glpin", main_detailse_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number",
						main_detailse_obj.get("licensed_surveyor_number").toString());
				request.setAttribute("regional_number", main_detailse_obj.get("regional_number").toString());
				request.setAttribute("locality", main_detailse_obj.get("locality").toString());
				request.setAttribute("district", main_detailse_obj.get("district").toString());
				request.setAttribute("region", main_detailse_obj.get("region").toString());
				request.setAttribute("size_of_land", main_detailse_obj.get("size_of_land").toString());
				request.setAttribute("date_of_document", main_detailse_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument", main_detailse_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number", main_detailse_obj.get("certificate_number").toString());
				request.setAttribute("extent", main_detailse_obj.get("extent").toString());
				request.setAttribute("registry_mapref", main_detailse_obj.get("registry_mapref").toString());
				request.setAttribute("type_of_interest", main_detailse_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", main_detailse_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", main_detailse_obj.get("volume_number").toString());
				request.setAttribute("folio_number", main_detailse_obj.get("folio_number").toString());
				request.setAttribute("term", main_detailse_obj.get("term").toString());
				request.setAttribute("commencement_date", main_detailse_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", main_detailse_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", main_detailse_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable", main_detailse_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", main_detailse_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", main_detailse_obj.get("locality").toString());
				request.setAttribute("parcel_description", main_detailse_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", main_detailse_obj.get("publicity_date").toString());
				request.setAttribute("plan_no", main_detailse_obj.get("plan_no").toString());
				request.setAttribute("cc_no", main_detailse_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", main_detailse_obj.get("ltr_plan_no").toString());
				request.setAttribute("family_of_grantor", main_detailse_obj.get("family_of_grantor").toString());
				request.setAttribute("locality_class", main_detailse_obj.get("locality_class").toString());
				request.setAttribute("rent_review_period", main_detailse_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", main_detailse_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered", main_detailse_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", main_detailse_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						main_detailse_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", main_detailse_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", main_detailse_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration", main_detailse_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", main_detailse_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", main_detailse_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// main_detailse_obj.get("is_part_of_gelis_area").toString());
				// request.setAttribute("stamp_duty_description",
				// main_detailse_obj.get("stamp_duty_description").toString());
				request.setAttribute("registration_district_number",
						main_detailse_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						main_detailse_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						main_detailse_obj.get("registration_block_number").toString());

			} else {
				System.out.println(web_service_response);
			}

			request.setAttribute("page_name", "case_processing");

					model.addAttribute("content", "../pages/client_application/search_application_progress_details.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/smd_plan_approval_case_plottings")
	@GetMapping
	public String smd_plan_approval_case_plottings(HttpSession session, Model model, HttpServletRequest request,
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
		// request"/client_application/app_database_update.jsp").forward(request,
		// response);

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

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;

				web_service_response_menu = casemgt_web_service
						.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);

				request.setAttribute("page_name", "case_processing");
						model.addAttribute("content", "../pages/client_application/smd_plan_approval_case_plottings.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/smd_plan_approval_plotting_details")
	@PostMapping
	public String smd_plan_approval_plotting_details(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			System.out.println(case_number);
			System.out.println(job_number);

			JSONObject obj = new JSONObject();

			obj.put("case_number", case_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();

				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);
				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);

				request.setAttribute("case_query", case_query_list);

				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("case_inspections", case_inspections_list);

				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject(parcel_details);

				String new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());
				// request.setAttribute("phone_number",
				// job_detail_obj.get("phone_number").toString());
				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());

				System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				JSONArray arr_r = new JSONArray();

				String folderpath = cls_url_config.getLrd_jacket_raw_path() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				request.setAttribute("page_name", "case_processing");
						model.addAttribute("content", "../pages/client_application/smd_plan_approval_plotting_details.jsp"); return "layouts/app";

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/smd_temp_barcode")
	@GetMapping
	public String smd_temp_barcode(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());
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
		try {

			// Page Name
			request.setAttribute("page_name", "smd_temp_barcode");

			// //HttpSession session = request.getSession();

			cls_casemgt casemgt_web_service = new cls_casemgt();
			String web_service_response_menu = null;
			web_service_response_menu = casemgt_web_service
					.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							(String) session.getAttribute("userid"));
			JSONObject menu_obj;
			menu_obj = new JSONObject(web_service_response_menu);
			String all_menus = menu_obj.get("data").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
			request.setAttribute("applicationlist", javaArrayListFromGSON);

					model.addAttribute("content", "../pages/client_application/smd_temp_barcode.jsp"); return "layouts/app";

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/test_dashboard")
	@GetMapping
	public String test_dashboard(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
				model.addAttribute("content", "../pages/client_application/test_dashboard.jsp"); return "layouts/app";

	}

	@RequestMapping("/unit_case_management")
	@GetMapping
	public String unit_case_management(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				String web_service_response_compliance_notice = null;
				String view_all_offices = (String) session.getAttribute("view_all_offices");
				JSONObject obj = new JSONObject();

				obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));

				if (view_all_offices.equals("Yes")) {
					web_service_response_menu = casemgt_web_service
							.load_application_details_to_unit_all(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());
				} else {
					web_service_response_menu = casemgt_web_service
							.load_application_details_to_unit(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				}

				web_service_response_compliance_notice = casemgt_web_service
							.select_load_compliance_notice_count_by_unit(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(obj.toString());

				JSONObject menu_obj;

				menu_obj = new JSONObject(web_service_response_menu);
				String incoming = menu_obj.get("incoming").toString();
				String completed = menu_obj.get("completed").toString();
				String queried = menu_obj.get("queried").toString();
				String awaiting_payments = menu_obj.get("awaiting_payments").toString();
				String awaiting_request = menu_obj.get("awaiting_request").toString();
				String completed_request = menu_obj.get("completed_request").toString();

				

				JSONObject notice_count_obj;

				notice_count_obj = new JSONObject(web_service_response_compliance_notice);
				String reminders = notice_count_obj.get("reminders").toString();
				String warnings = notice_count_obj.get("warnings").toString();
				String compliance_queries = notice_count_obj.get("compliance_queries").toString();
				String query_response  = notice_count_obj.get("query_response").toString();

				request.setAttribute("page_name", "unit_case_management");
				request.setAttribute("view_all_offices", view_all_offices);
				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("queried", queried);
				request.setAttribute("awaiting_payment", awaiting_payments);
request.setAttribute("awaiting_request", awaiting_request);
request.setAttribute("completed_request", completed_request);



				request.setAttribute("reminders", reminders);
				request.setAttribute("warnings", warnings);
				request.setAttribute("compliance_queries", compliance_queries);
				request.setAttribute("query_response", query_response);

						model.addAttribute("content", "../pages/client_application/unit_case_management.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/unit_case_management_revised")
	@GetMapping
	public String unit_case_management_revised(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				String web_service_response_compliance_notice = null;
				String view_all_offices = (String) session.getAttribute("view_all_offices");
				JSONObject obj = new JSONObject();

				obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));

				if (view_all_offices.equals("Yes")) {
					web_service_response_menu = casemgt_web_service
							.load_application_details_to_unit_all(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());
				} else {
					web_service_response_menu = casemgt_web_service
							.load_application_details_to_unit(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				}


				System.out.println(web_service_response_menu);

				web_service_response_compliance_notice = casemgt_web_service
							.select_load_compliance_notice_count_by_unit(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(obj.toString());

				JSONObject menu_obj;

				menu_obj = new JSONObject(web_service_response_menu);
				String incoming = menu_obj.get("incoming").toString();
				String completed = menu_obj.get("completed").toString();
				String queried = menu_obj.get("queried").toString();
				String awaiting_payments = menu_obj.get("awaiting_payments").toString();
				String awaiting_request = menu_obj.get("awaiting_request").toString();
				String completed_request = menu_obj.get("completed_request").toString();
				String attention_required = menu_obj.get("attention_required").toString();

				

				

				JSONObject notice_count_obj;

				notice_count_obj = new JSONObject(web_service_response_compliance_notice);
				String reminders = notice_count_obj.get("reminders").toString();
				String warnings = notice_count_obj.get("warnings").toString();
				String compliance_queries = notice_count_obj.get("compliance_queries").toString();
				String query_response  = notice_count_obj.get("query_response").toString();

				request.setAttribute("page_name", "unit_case_management_revised");
				request.setAttribute("view_all_offices", view_all_offices);
				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("queried", queried);
				request.setAttribute("awaiting_payment", awaiting_payments);
request.setAttribute("awaiting_request", awaiting_request);
request.setAttribute("completed_request", completed_request);

request.setAttribute("attention_required", attention_required);





				request.setAttribute("reminders", reminders);
				request.setAttribute("warnings", warnings);
				request.setAttribute("compliance_queries", compliance_queries);
				request.setAttribute("query_response", query_response);

				request.setAttribute("page_name", "unit_case_management_revised");

						model.addAttribute("content", "../pages/client_application/unit_case_management_revised.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}




	@RequestMapping("/certificate_signing_module")
	@GetMapping
	public String certificate_signing_module(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				String web_service_response_compliance_notice = null;
				String view_all_offices = (String) session.getAttribute("view_all_offices");
				JSONObject obj = new JSONObject();

				obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));

				if (view_all_offices.equals("Yes")) {
					web_service_response_menu = casemgt_web_service
							.load_application_details_to_unit_all(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());
				} else {
					web_service_response_menu = casemgt_web_service
							.load_certificate_sisgning_application_details_to_unit(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				}

				// web_service_response_compliance_notice = casemgt_web_service
				// 			.select_load_compliance_notice_count_by_unit(cls_url_config.getWeb_service_url_ser(),
				// 					cls_url_config.getWeb_service_url_ser_api_key(),
				// 					obj.toString());

									System.out.println(obj.toString());

				JSONObject menu_obj;

				menu_obj = new JSONObject(web_service_response_menu);
				String incoming = menu_obj.get("incoming").toString();
				String completed = menu_obj.get("completed").toString();
				String queried = menu_obj.get("queried").toString();
				String assigned_to_officers = menu_obj.get("assigned_to_officers").toString();

				// JSONObject notice_count_obj;

				// notice_count_obj = new JSONObject(web_service_response_compliance_notice);
				// String reminders = notice_count_obj.get("reminders").toString();
				// String warnings = notice_count_obj.get("warnings").toString();
				// String compliance_queries = notice_count_obj.get("compliance_queries").toString();

				request.setAttribute("page_name", "certificate_signing_module");
				request.setAttribute("view_all_offices", view_all_offices);
				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("queried", queried);
				request.setAttribute("assigned_to_officers", assigned_to_officers);
				// request.setAttribute("reminders", reminders);
				// request.setAttribute("warnings", warnings);
				// request.setAttribute("compliance_queries", compliance_queries);

						model.addAttribute("content", "../pages/client_application/certificate_signing_module.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/useredit")
	@GetMapping
	public String useredit(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
		// request.setAttribute("errorString", "Error on Page");
		// request.setAttribute("users_list", result);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
				model.addAttribute("content", "../pages/user_management/edit.jsp"); return "layouts/app";

	}

	@RequestMapping("/case_movement_module_1")
	@GetMapping
	public String case_movement_module_1(HttpSession session, Model model, HttpServletRequest request,
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
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */

			if ((String) session.getAttribute("userid") != null && (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				String web_service_response_menu_data = null;

				web_service_response_menu = casemgt_web_service
						.load_count_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));
				System.out.println(web_service_response_menu);
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("total").toString();

				// Gson googleJson = new Gson();
				// ArrayList javaArrayListFromGSON =
				// googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlistcount", all_menus);

				web_service_response_menu_data = casemgt_web_service
						.load_application_batched_to_user(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								(String) session.getAttribute("userid"));

				JSONObject menu_obj_data;
				menu_obj_data = new JSONObject(web_service_response_menu_data);
				String all_menus_data = menu_obj_data.get("data").toString();
				System.out.println(all_menus_data);
				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus_data, ArrayList.class);

				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/regional_template/case_movement_module.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/general_application_without_major_process")
	@PostMapping
	public String general_application_without_major_process(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String web_service_response = null;
			Gson googleJson = new Gson();
			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// String case_number = "LCGARGAPCN716613620190";
			// String job_number = "SMDGAPPA132305820190";

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("business_process_sub_name");

			/*
			 * System.out.println(transaction_number);
			 * System.out.println(case_number); System.out.println(job_number);
			 */

			JSONObject obj = new JSONObject();

			obj.put("case_number", transaction_number);
			obj.put("job_number", job_number);
			String batchlistdivison = obj.toString();
			System.out.println(batchlistdivison);
			web_service_response = casemagt_cl.select_general_case_details(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					batchlistdivison);
			if (web_service_response != null) {
				System.out.println(web_service_response);
				JSONObject case_obj;
				case_obj = new JSONObject(web_service_response);

				String parcel_details = case_obj.get("parcel_details").toString();
				String transaction_details = case_obj.get("transaction_details").toString();
				String job_detail = case_obj.get("job_detail").toString();

				String job_details = case_obj.get("job_details").toString();
				String parcels_coordinates = case_obj.get("parcels_coordinates").toString();
				String lrd_valuation_section = case_obj.get("lrd_valuation_section").toString();
				String lrd_memorials_section = case_obj.get("lrd_memorials_section").toString();
				String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();
				String lrd_certificate_section = case_obj.get("lrd_certificate_section").toString();
				String lrd_proprietorship_section = case_obj.get("lrd_proprietorship_section").toString();
				String collection_checklist = case_obj.get("collection_checklist").toString();
				String application_munites = case_obj.get("application_munites").toString();
				String application_notes = case_obj.get("application_notes").toString();
				String payment_bill = case_obj.get("payment_bill").toString();
				String payment_invoice = case_obj.get("payment_invoice").toString();
				String comments_on_application = case_obj.get("comments_on_application").toString();
				String parties = case_obj.get("parties").toString();
				String active_case_queries = case_obj.get("active_case_query").toString();
				String active_case_objection = case_obj.get("active_case_objection").toString();
				String case_query = case_obj.get("case_query").toString();
				String case_objection = case_obj.get("case_objection").toString();
				String case_inspections = case_obj.get("inspection_reports_on_appliction").toString();
				String case_letters = case_obj.get("case_letters").toString();

				// ArrayList main_details_list =
				// googleJson.fromJson(main_details, ArrayList.class);
				ArrayList job_details_list = googleJson.fromJson(job_details, ArrayList.class);
				ArrayList parcels_coordinates_list = googleJson.fromJson(parcels_coordinates, ArrayList.class);
				ArrayList lrd_valuation_section_list = googleJson.fromJson(lrd_valuation_section, ArrayList.class);
				ArrayList lrd_memorials_section_list = googleJson.fromJson(lrd_memorials_section, ArrayList.class);
				ArrayList lrd_encumbrances_section_list = googleJson.fromJson(lrd_encumbrances_section,
						ArrayList.class);
				ArrayList lrd_certificate_section_list = googleJson.fromJson(lrd_certificate_section, ArrayList.class);
				ArrayList lrd_proprietorship_section_list = googleJson.fromJson(lrd_proprietorship_section,
						ArrayList.class);
				ArrayList collection_checklist_list = googleJson.fromJson(collection_checklist, ArrayList.class);
				ArrayList application_munites_list = googleJson.fromJson(application_munites, ArrayList.class);
				ArrayList application_notes_list = googleJson.fromJson(application_notes, ArrayList.class);
				ArrayList payment_bill_list = googleJson.fromJson(payment_bill, ArrayList.class);
				ArrayList comments_on_application_list = googleJson.fromJson(comments_on_application, ArrayList.class);
				ArrayList parties_list = googleJson.fromJson(parties, ArrayList.class);
				ArrayList payment_invoice_list = googleJson.fromJson(payment_invoice, ArrayList.class);

				ArrayList case_query_list = googleJson.fromJson(case_query, ArrayList.class);
				ArrayList case_objection_list = googleJson.fromJson(case_objection, ArrayList.class);

				ArrayList case_inspections_list = googleJson.fromJson(case_inspections, ArrayList.class);
				ArrayList case_letters_list = googleJson.fromJson(case_letters, ArrayList.class);

				// request.setAttribute("transaction_details", main_details);
				request.setAttribute("job_details", job_details_list);
				// request.setAttribute("parcels_coordinates",
				// parcels_coordinates_list);
				request.setAttribute("lrd_valuation_section", lrd_valuation_section_list);
				request.setAttribute("lrd_memorials_section", lrd_memorials_section_list);
				request.setAttribute("lrd_encumbrances_section", lrd_encumbrances_section_list);
				request.setAttribute("lrd_certificate_section", lrd_certificate_section_list);
				request.setAttribute("lrd_proprietorship_section", lrd_proprietorship_section_list);
				request.setAttribute("collection_checklist", collection_checklist_list);
				request.setAttribute("application_munites", application_munites_list);
				request.setAttribute("application_notes", application_notes_list);
				request.setAttribute("payment_bill", payment_bill_list);
				request.setAttribute("comments_on_application", comments_on_application_list);
				request.setAttribute("parties", parties_list);
				request.setAttribute("payment_invoice", payment_invoice_list);

				request.setAttribute("case_query", case_query_list);
				request.setAttribute("active_case_queries", active_case_queries);
				request.setAttribute("case_objection", case_objection_list);
				request.setAttribute("active_case_objection", active_case_objection);
				request.setAttribute("case_inspections", case_inspections_list);
				request.setAttribute("case_letters", case_letters_list);
				request.setAttribute("parcel_wkt", case_obj.get("parcel_wkt").toString());

				// System.out.println(case_obj.get("parcel_wkt").toString());

				JSONObject parcel_details_obj;
				parcel_details_obj = new JSONObject(parcel_details);

				String new_case_number = parcel_details_obj.get("case_number").toString();
				request.setAttribute("glpin", parcel_details_obj.get("glpin").toString());
				request.setAttribute("licensed_surveyor_number", parcel_details_obj.get("licensed_no").toString());
				request.setAttribute("regional_number", parcel_details_obj.get("regional_number").toString());
				request.setAttribute("locality", parcel_details_obj.get("locality").toString());
				request.setAttribute("district", parcel_details_obj.get("district").toString());
				request.setAttribute("region", parcel_details_obj.get("region").toString());
				request.setAttribute("size_of_land", parcel_details_obj.get("land_size").toString());
				request.setAttribute("extent", parcel_details_obj.get("extent").toString());
				request.setAttribute("registry_mapref", parcel_details_obj.get("registry_mapref").toString());
				request.setAttribute("plan_no", parcel_details_obj.get("plan_no").toString());
				request.setAttribute("cc_no", parcel_details_obj.get("cc_no").toString());
				request.setAttribute("ltr_plan_no", parcel_details_obj.get("ltr_plan_no").toString());
				request.setAttribute("locality_class", parcel_details_obj.get("locality_class").toString());
				request.setAttribute("registration_district_number",
						parcel_details_obj.get("registration_district_number").toString());
				request.setAttribute("registration_section_number",
						parcel_details_obj.get("registration_section_number").toString());
				request.setAttribute("registration_block_number",
						parcel_details_obj.get("registration_block_number").toString());

				request.setAttribute("need_for_new_transaction",
						parcel_details_obj.get("need_for_new_transaction").toString());

				JSONObject transaction_details_obj;
				transaction_details_obj = new JSONObject(transaction_details);
				request.setAttribute("ar_name", transaction_details_obj.get("ar_name").toString());
				request.setAttribute("case_number", transaction_details_obj.get("case_number").toString());
				request.setAttribute("transaction_number",
						transaction_details_obj.get("transaction_number").toString());
				request.setAttribute("date_of_document", transaction_details_obj.get("date_of_document").toString());
				request.setAttribute("nature_of_instrument",
						transaction_details_obj.get("nature_of_instrument").toString());
				request.setAttribute("certificate_number",
						transaction_details_obj.get("certificate_number").toString());

				request.setAttribute("type_of_interest", transaction_details_obj.get("type_of_interest").toString());
				request.setAttribute("type_of_use", transaction_details_obj.get("type_of_use").toString());
				request.setAttribute("volume_number", transaction_details_obj.get("volume_number").toString());
				request.setAttribute("folio_number", transaction_details_obj.get("folio_number").toString());
				request.setAttribute("term", transaction_details_obj.get("term").toString());
				request.setAttribute("commencement_date", transaction_details_obj.get("commencement_date").toString());

				request.setAttribute("renewal_term", transaction_details_obj.get("renewal_term").toString());
				request.setAttribute("consideration_fee", transaction_details_obj.get("consideration_fee").toString());
				request.setAttribute("stamp_duty_payable",
						transaction_details_obj.get("stamp_duty_payable").toString());
				request.setAttribute("assessed_value", transaction_details_obj.get("assessed_value").toString());
				request.setAttribute("parcel_description",
						transaction_details_obj.get("parcel_description").toString());
				request.setAttribute("plot_number", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("parcel_description", transaction_details_obj.get("plot_number").toString());
				request.setAttribute("publicity_date", transaction_details_obj.get("publicity_date").toString());

				request.setAttribute("family_of_grantor", transaction_details_obj.get("family_of_grantor").toString());

				request.setAttribute("rent_review_period",
						transaction_details_obj.get("rent_review_period").toString());
				request.setAttribute("annual_rent", transaction_details_obj.get("annual_rent").toString());

				request.setAttribute("rent_period_covered",
						transaction_details_obj.get("rent_period_covered").toString());
				request.setAttribute("rent_review_date", transaction_details_obj.get("rent_review_date").toString());
				request.setAttribute("date_of_first_payment",
						transaction_details_obj.get("date_of_first_payment").toString());
				request.setAttribute("outstanding_rent", transaction_details_obj.get("outstanding_rent").toString());
				request.setAttribute("remark_or_comment", transaction_details_obj.get("remark_or_comment").toString());
				request.setAttribute("date_of_registration",
						transaction_details_obj.get("date_of_registration").toString());
				request.setAttribute("case_status", transaction_details_obj.get("case_status").toString());

				request.setAttribute("stool_family_name", transaction_details_obj.get("stool_family_name").toString());
				// request.setAttribute("is_part_of_gelis_area",
				// transaction_details_obj.get("is_part_of_gelis_area").toString());
				request.setAttribute("stamp_duty_description",
						transaction_details_obj.get("stamp_duty_description").toString());
				request.setAttribute("certificate_type", transaction_details_obj.get("certificate_type").toString());
				request.setAttribute("case_file_number", transaction_details_obj.get("case_file_number").toString());

				request.setAttribute("case_process_stage",
						transaction_details_obj.get("case_process_stage").toString());
						request.setAttribute("interest_number",
						transaction_details_obj.get("interest_number").toString());

				JSONObject job_detail_obj;
				job_detail_obj = new JSONObject(job_detail);
				request.setAttribute("job_number", job_number);
				request.setAttribute("application_stage", job_detail_obj.get("application_stage").toString());
				request.setAttribute("created_date", job_detail_obj.get("created_date").toString());
				request.setAttribute("modified_date", job_detail_obj.get("modified_date").toString());
				System.out.println(job_detail_obj.get("application_stage").toString());
				request.setAttribute("business_process_id", job_detail_obj.get("business_process_id").toString());
				request.setAttribute("business_process_name", job_detail_obj.get("business_process_name").toString());
				request.setAttribute("business_process_sub_id",
						job_detail_obj.get("business_process_sub_id").toString());
				request.setAttribute("business_process_sub_name",
						job_detail_obj.get("business_process_sub_name").toString());
				request.setAttribute("embossed", job_detail_obj.get("embossed").toString());
				request.setAttribute("remark_or_comment", job_detail_obj.get("remark_or_comment").toString());
				JSONArray arr_r = new JSONArray();

				request.setAttribute("page_name", "case_processing");

				String folderpath = cls_url_config.getCase_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments",
				// arr_r.toString());

				JSONArray arr_r_public = new JSONArray();
				String folderpath_public = cls_url_config.getPublic_docs_upload_location() + new_case_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir_public = new File(folderpath_public.toString());
				String[] children_public = subdir_public.list();
				if (children_public == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children_public.length; j++) {
						String filename_doc_public = children_public[j];
						System.out.println("case_number: " + case_number);
						System.out.println("File: " + filename_doc_public);
						String path = folderpath_public.toString() + "/" + filename_doc_public;

						String extension = filename_doc_public.substring(filename_doc_public.lastIndexOf("."));
						JSONObject obj_r = new JSONObject();
						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc_public);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r_public.put(obj_r);
					}

				}
				// request.setAttribute("casescanneddocuments_public",
				// arr_r_public.toString());
				System.out.println(arr_r.toString());
				System.out.println(arr_r_public.toString());

				System.out.println(business_process_sub_name);

						model.addAttribute("content", "../pages/regional_template/general_application_without_major_process.jsp"); return "layouts/app";

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/edit_application")
	@PostMapping
	public String edit_application(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		Gson googleJson = new Gson();
		try {

			cls_casemgt casemgt_web_service = new cls_casemgt();

			String region_list = (String) session.getAttribute("region_list");
			Gson googleJson_regions = new Gson();
			ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
			request.setAttribute("regionlist", javaArrayListFromGSON_regions);

			String region_id = (String) session.getAttribute("regional_code");
			JSONObject obj = new JSONObject();
			obj.put("region_code", region_id);
			String locality_list = user_web_service.get_locality_by_region(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					obj.toString());

			JSONObject jsonobj_locality = new JSONObject(locality_list);

			locality_list = (String) jsonobj_locality.getString("data");
			Gson googleJson_locality = new Gson();
			ArrayList javaArrayListFromGSON_locality = googleJson_locality.fromJson(locality_list,
					ArrayList.class);
			request.setAttribute("localitylist", javaArrayListFromGSON_locality);

			// String office_region_list = (String)
			// session.getAttribute("office_region_list");
			// Gson googleJson_officeregions = new Gson();
			// ArrayList javaArrayListFromGSON_officeregions =
			// googleJson_officeregions.fromJson(
			// office_region_list,
			// ArrayList.class);
			// request.setAttribute("officeregionlist",
			// javaArrayListFromGSON_officeregions);

			request.setAttribute("page_name", "csau_online");
					model.addAttribute("content", "../pages/csau_template/change_of_names.jsp"); return "layouts/app";

			// request.getRequestDispatcher("/csau_template/csau_online.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/divisional_registry")
	@PostMapping
	public String divisional_registry(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			/*
			 * //HttpSession session = request.getSession();
			 * 
			 * session.setAttribute("fullname", (String)
			 * session.getAttribute("web_fullname"));
			 * session.setAttribute("userid", (String)
			 * session.getAttribute("web_useid"));
			 * session.setAttribute("division", (String)
			 * session.getAttribute("web_division"));
			 * session.setAttribute("user_level", (String)
			 * session.getAttribute("user_level"));
			 */
			// HttpSession session = request.getSession();

			if ((String) session.getAttribute("division") != null && (String) session.getAttribute("division") != "") {
				// Session is expired

				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response_menu = null;
				web_service_response_menu = casemgt_web_service.load_new_application_for_division(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						(String) session.getAttribute("division"), (String) session.getAttribute("regional_code"));
				JSONObject menu_obj;
				menu_obj = new JSONObject(web_service_response_menu);
				String all_menus = menu_obj.get("data").toString();

				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/client_application/divisional_registry_case_movement_module.jsp"); return "layouts/app";

			} else {
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/file_tracking_receive_hard_copy")
	@PostMapping
	public String file_tracking_receive_hard_copy(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			// HttpSession session = request.getSession();

			request.setAttribute("page_name", "page_file_management_receive_hard_copy");
					model.addAttribute("content", "../pages/client_application/file_management_receive_hard_copy.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/file_tracking")
	@PostMapping
	public String file_tracking(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			// HttpSession session = request.getSession();

			request.setAttribute("page_name", "page_file_management");
					model.addAttribute("content", "../pages/client_application/file_management.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/file_movement_module")
	@PostMapping
	public String file_movement_module(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			// HttpSession session = request.getSession();

			request.setAttribute("page_name", "page_file_management");
					model.addAttribute("content", "../pages/client_application/file_movement_module.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/data_upload_template")
	@GetMapping
	public String data_upload_template(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			// HttpSession session = request.getSession();

					model.addAttribute("content", "../pages/client_application/data_upload_template.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

				model.addAttribute("content", "../pages/client_application/data_upload_template.jsp"); return "layouts/app";
	}

	@RequestMapping("/change_of_job_service")
	@GetMapping
	public String change_of_job_service(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			// HttpSession session = request.getSession();

			request.setAttribute("page_name", "change_of_job_service");
					model.addAttribute("content", "../pages/csau_template/change_of_job_service.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";
	}


	@RequestMapping("/transitional_plotting_module")
	@GetMapping
	public String transitional_plotting_module(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			// HttpSession session = request.getSession();

			request.setAttribute("page_name", "transitional_plotting_module");
					model.addAttribute("content", "../pages/client_application/transitional_plotting_module.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";
	}


	@RequestMapping("/coordinate_entry_and_record_verification")
	@GetMapping
	public String coordinate_entry_and_record_verification(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			// HttpSession session = request.getSession();

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response = null;
	
				JSONObject obj = new JSONObject();

				//obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				//obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));
				obj.put("application_stage", 1);

				web_service_response = casemgt_web_service
							.select_count_application_stage_for_transitional_plotting_by_division(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(obj.toString());
									System.out.println(web_service_response);

				// JSONObject apps_obj;
				// apps_obj = new JSONObject(web_service_response);
				// String app_list = apps_obj.get("data").toString();

				// ArrayList javaArrayListFromGSON = googleJson.fromJson(app_list, ArrayList.class);
				// request.setAttribute("applicationlist", javaArrayListFromGSON);

				JSONObject result_obj;

				result_obj = new JSONObject(web_service_response);
				String incoming = result_obj.get("incoming").toString();
				String completed = result_obj.get("completed").toString();
				String pending = result_obj.get("pending").toString();

				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("pending", pending);

				request.setAttribute("page_name", "coordinate_entry_and_record_verification");
						model.addAttribute("content", "../pages/client_application/coordinate_entry_and_record_verification.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";
	}


	@RequestMapping("/plot_vetting_and_approval")
	@GetMapping
	public String plot_vetting_and_approval(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			// HttpSession session = request.getSession();

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response = null;
	
				JSONObject obj = new JSONObject();

				//obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				//obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));
				obj.put("application_stage", 2);

				web_service_response = casemgt_web_service
							.select_application_stage_for_transitional_plotting_by_division(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(obj.toString());

				JSONObject apps_obj;
				apps_obj = new JSONObject(web_service_response);
				String app_list = apps_obj.get("data").toString();

				ArrayList javaArrayListFromGSON = googleJson.fromJson(app_list, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);

				request.setAttribute("page_name", "plot_vetting_and_approval");
						model.addAttribute("content", "../pages/client_application/plot_vetting_and_approval.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";
	}


	@RequestMapping("/plot_final_approval")
	@GetMapping
	public String plot_final_approval(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			// HttpSession session = request.getSession();

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();
				String web_service_response = null;
	
				JSONObject obj = new JSONObject();

				//obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				//obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));
				obj.put("application_stage", 3);

				web_service_response = casemgt_web_service
							.select_application_stage_for_transitional_plotting_by_division(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(obj.toString());

				JSONObject apps_obj;
				apps_obj = new JSONObject(web_service_response);
				String app_list = apps_obj.get("data").toString();

				ArrayList javaArrayListFromGSON = googleJson.fromJson(app_list, ArrayList.class);
				request.setAttribute("applicationlist", javaArrayListFromGSON);

				request.setAttribute("page_name", "plot_final_approval");
						model.addAttribute("content", "../pages/client_application/plot_final_approval.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";
	}

	@RequestMapping("/app_request_module")
	@GetMapping
	public String app_request_module(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();

				String web_service_response_compliance_notice = null;
				String view_all_offices = (String) session.getAttribute("view_all_offices");
				JSONObject obj = new JSONObject();

				obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));

				web_service_response_compliance_notice = casemgt_web_service
							.select_load_app_request_count_by_unit(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(obj.toString());

				JSONObject notice_count_obj;

				notice_count_obj = new JSONObject(web_service_response_compliance_notice);
				String incoming = notice_count_obj.get("incoming").toString();
				String outgoing = notice_count_obj.get("outgoing").toString();

				request.setAttribute("page_name", "milestone_update");
				request.setAttribute("incoming", incoming);
				request.setAttribute("outgoing", outgoing);

						model.addAttribute("content", "../pages/client_application/application_request.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}


	@RequestMapping("/app_request_details")
	@PostMapping
	public String cica_focal_person_post(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {
			cls_casemgt casemgt_web_service = new cls_casemgt();
            String web_response = null;
			JSONObject obj = new JSONObject();
			Gson googleJson = new Gson();
			//JSONObject obj_r = new JSONObject();
			String request_type =request.getParameter("request_type");

			if (request_type.equals("load_app_request_details")) {

				String req_id =request.getParameter("req_id");
				
				// session.setAttribute("view_by", 0);
				// session.setAttribute("update_status", "d-none");
				// session.setAttribute("move_to", "d-block");
                // session.setAttribute("print_request", "d-block");
				// session.setAttribute("cica_route", "cica_focal_person");
				// session.setAttribute("add_reply", "d-block");
				// session.setAttribute("edit_ticket", "d-none");
				
				obj.put("req_id", new Double(req_id).intValue());
				//obj.put("ticket_no", ticket_no);

				web_response = casemgt_web_service.load_app_request_details(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String request_details = web_response_case.get("data").toString(); 

				ArrayList request_details_list = googleJson.fromJson(request_details, ArrayList.class);
				request.setAttribute("request_details",request_details_list);
				request.setAttribute("page_name","milestone_update");
						model.addAttribute("content", "../pages/client_application/app_request_details.jsp"); return "layouts/app";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

	@RequestMapping("/app_job_request_module")
	@GetMapping
	public String app_job_request_module(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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

		try {

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();

				String web_service_response_compliance_notice = null;
				String view_all_offices = (String) session.getAttribute("view_all_offices");
				JSONObject obj = new JSONObject();

				obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));

				web_service_response_compliance_notice = casemgt_web_service
							.select_load_job_app_request_count_by_unit(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(obj.toString());

				JSONObject notice_count_obj;

				notice_count_obj = new JSONObject(web_service_response_compliance_notice);
				String incoming = notice_count_obj.get("incoming").toString();
				String with_officers = notice_count_obj.get("with_officers").toString();
				String completed = notice_count_obj.get("completed").toString();
				String awaiting = notice_count_obj.get("awaiting").toString();
				String queried = notice_count_obj.get("queried").toString();

				request.setAttribute("page_name", "page_file_management");
				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("with_officers", with_officers);
				request.setAttribute("awaiting", awaiting);
				request.setAttribute("queried", queried);

						model.addAttribute("content", "../pages/client_application/general_request_module.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/new_general_request")
	@PostMapping
	public String new_general_request(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			// HttpSession session = request.getSession();

			request.setAttribute("page_name", "page_file_management");
					model.addAttribute("content", "../pages/client_application/create_new_general_request.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/document_management_mod")
	@PostMapping
	public String document_management_mod(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {

			// HttpSession session = request.getSession();

			request.setAttribute("page_name", "page_file_management");
					model.addAttribute("content", "../pages/client_application/document_management.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/elis_general_workflow")
	@PostMapping
	public String elis_general_workflow(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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

		try {

			if ((String) session.getAttribute("userid") != null || (String) session.getAttribute("userid") != "") {
				cls_casemgt casemgt_web_service = new cls_casemgt();

				String web_service_response_compliance_notice = null;
				String view_all_offices = (String) session.getAttribute("view_all_offices");
				JSONObject obj = new JSONObject();

				obj.put("unit_id", (String) session.getAttribute("unit_id"));
				obj.put("office_region", (String) session.getAttribute("regional_code"));
				obj.put("unit_name", (String) session.getAttribute("unit_name"));
				obj.put("division", (String) session.getAttribute("division"));

				web_service_response_compliance_notice = casemgt_web_service
							.select_load_job_app_request_count_by_unit(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(),
									obj.toString());

									System.out.println(obj.toString());

				JSONObject notice_count_obj;

				notice_count_obj = new JSONObject(web_service_response_compliance_notice);
				String incoming = notice_count_obj.get("incoming").toString();
				String with_officers = notice_count_obj.get("with_officers").toString();
				String completed = notice_count_obj.get("completed").toString();
				String awaiting = notice_count_obj.get("awaiting").toString();
				String queried = notice_count_obj.get("queried").toString();

				request.setAttribute("page_name", "page_file_management");
				request.setAttribute("incoming", incoming);
				request.setAttribute("completed", completed);
				request.setAttribute("with_officers", with_officers);
				request.setAttribute("awaiting", awaiting);
				request.setAttribute("queried", queried);

				request.setAttribute("page_name", "page_file_management");
			    model.addAttribute("content", "../pages/general_workflow/general_workflow_main.jsp"); return "layouts/app";

			} else {

				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	cls_licensed_surveyors licensed_surveyors_cl = new cls_licensed_surveyors();


@RequestMapping("/licensed_surveyor_dashboard")
	@GetMapping
	public String licensed_surveyor_dashboard(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		
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
			web_service_response_menu = licensed_surveyors_cl
					.online_smd_licensed_surveyors_list(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			JSONObject professioan_dashboard_details_obj;
			professioan_dashboard_details_obj = new JSONObject(web_service_response_menu);
			System.out.println(web_service_response_menu);
			
			String surveyors_list = professioan_dashboard_details_obj.get("data")
					.toString();

			String capacity_list = professioan_dashboard_details_obj.get("capacity").toString();
			//request.setAttribute("surveyorList", surveyors_list);

			Gson googleJson_e = new Gson();
             ArrayList javaArrayListFromGSON = googleJson_e.fromJson(surveyors_list, ArrayList.class);
            request.setAttribute("surveyorList", javaArrayListFromGSON);

			Gson googleJson_j = new Gson();
             ArrayList javaArrayListFromGSON_j = googleJson_j.fromJson(capacity_list, ArrayList.class);
            request.setAttribute("capacityList", javaArrayListFromGSON_j);

			request.setAttribute("page_name", "licensed_surveyor_dashboard");
					model.addAttribute("content", "../pages/surveyors_management/licensed_surveyor_dashboard.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}
	


}
