package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import java.io.File;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;

@Controller
public class InspectionController {

	@Autowired
	private Ws_url_config cls_url_config;

	cls_casemgt casemagt_cl = new cls_casemgt();

	@RequestMapping("/inspection_staff_module")
	@GetMapping
	public String inspection_staff_module(HttpSession session, Model model, HttpServletRequest request,
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
		// HttpSession session = request.getSession();

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
			isFound = true;
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

				/*
				 * web_service_response_menu = casemgt_web_service
				 * .load_count_application_batched_to_user((String)
				 * session.getAttribute("userid")); //
				 * System.out.println(web_service_response_menu); JSONObject
				 * menu_obj; menu_obj = new
				 * JSONObject(web_service_response_menu); String all_menus =
				 * menu_obj.get("total").toString();
				 */

				// Gson googleJson = new Gson();
				// ArrayList javaArrayListFromGSON =
				// googleJson.fromJson(all_menus, ArrayList.class);
				// request.setAttribute("applicationlistcount", all_menus);
				System.out.println("user_id : " + (String) session.getAttribute("userid"));
				JSONObject obj = new JSONObject();
				obj.put("userid", (String) session.getAttribute("userid"));
				// obj.put("modified_by_id", modified_by_id);

				web_service_response_menu_data = casemgt_web_service
						.inpection_app_load_assigned_inspections_by_userid(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								obj.toString());

				JSONObject menu_obj_data;
				menu_obj_data = new JSONObject(web_service_response_menu_data);
				String all_menus_data = menu_obj_data.get("data").toString();
				System.out.println(all_menus_data);
				Gson googleJson = new Gson();
				ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus_data, ArrayList.class);

				request.setAttribute("applicationlist", javaArrayListFromGSON);

						model.addAttribute("content", "../pages/inspection_module/inspection_staff_module.jsp"); return "layouts/app";

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
		return assigenedmenus;
	}

	@RequestMapping("/landed_inspection_application1")
	@PostMapping
	public String landed_inspection_application(HttpSession session, Model model, HttpServletRequest request,
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
				request.setAttribute("application_stage", "0");
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

						model.addAttribute("content", "../pages/inspection_module/landed_inspection_application.jsp"); return "layouts/app";

			} else {
				System.out.println(web_service_response);
			}

		} catch (

		JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

}
