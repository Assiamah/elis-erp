package com.mit.elis.servlets.maps;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import ws.casemgt.ws_sms;
import ws.maps.Ws_maps;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
        maxFileSize         = 1024 * 1024 * 10, // 10 MB
        maxRequestSize      = 1024 * 1024 * 15 // 15 MB
)

@RestController
public class Maps {
	Ws_maps cls_maps = new Ws_maps();

	@Autowired
	private Ws_url_config cls_url_config;

	ws_sms sms_sl = new ws_sms();

	@RequestMapping("/Maps")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam(value ="file", required=false) MultipartFile file) {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		// HttpSession session = request.getSession();

		try {
			String request_type = request.getParameter("request_type");

			String web_service_response = null;

			// System.out.println(request_type);

			if (request_type.equals("pvlmd_polygon_for_save")) {
				String wkt_polgon = request.getParameter("wkt_polgon");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				String pvlmd_unit = request.getParameter("pvlmd_unit");
				String pvlmd_plot_type = request.getParameter("pvlmd_plot_type");
				String number_format = request.getParameter("number_format");

				/*
				 * System.out.println(wkt_polgon + "-" + pvlmd_unit + "-" +
				 * pvlmd_plot_type + "-" + number_format + "-" + created_by +
				 * "-" + created_by_id);
				 */

				JSONObject obj = new JSONObject();

				obj.put("wkt_polgon", wkt_polgon);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				obj.put("pvlmd_unit", pvlmd_unit);
				obj.put("pvlmd_plot_type", pvlmd_plot_type);
				obj.put("number_format", number_format);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =

				web_service_response = cls_maps.select_save_pvlmd_parcels(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("pvlmd_polygon_for_save_with_info")) {
				String wkt_polgon = request.getParameter("wkt_polgon");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				String file_number = request.getParameter("file_number");
				String sheet_number = request.getParameter("sheet_number");
				String locality = request.getParameter("locality");
				String remarks = request.getParameter("remarks");

				/*
				 * System.out.println(wkt_polgon + "-" + pvlmd_unit + "-" +
				 * pvlmd_plot_type + "-" + number_format + "-" + created_by +
				 * "-" + created_by_id);
				 */

				JSONObject obj = new JSONObject();

				obj.put("wkt_polgon", wkt_polgon);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				obj.put("file_number", file_number);
				obj.put("sheet_number", sheet_number);
				obj.put("locality", locality);
				obj.put("remarks", remarks);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =

				web_service_response = cls_maps
						.select_save_pvlmd_parcels_with_info(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("lrd_polygon_for_save_with_info")) {
				String wkt_polgon = request.getParameter("wkt_polgon");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				
				String certificate_number = request.getParameter("certificate_number");

				String locality = request.getParameter("locality");
				String mul_claim = request.getParameter("mul_claim");
				String remarks = request.getParameter("remarks");

				/*
				 * System.out.println(wkt_polgon + "-" + pvlmd_unit + "-" +
				 * pvlmd_plot_type + "-" + number_format + "-" + created_by +
				 * "-" + created_by_id);
				 */

				JSONObject obj = new JSONObject();

				obj.put("wkt_polgon", wkt_polgon);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				obj.put("certificate_number", certificate_number);

				obj.put("locality", locality);
				obj.put("mul_claim", mul_claim);
				obj.put("remarks", remarks);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =

				web_service_response = cls_maps.select_lc_spatial_objects_save(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_update_pvlmd_parcels")) {

				String gid = request.getParameter("gid");
				String sheet_number = request.getParameter("sheet_number");

				String file_number = request.getParameter("file_number");
				String reference_number = request.getParameter("reference_number");
				String property_number = request.getParameter("property_number");
				String cro_reference = request.getParameter("cro_reference");
				String plot_number = request.getParameter("plot_number");
				String locality = request.getParameter("locality");
				String remarks = request.getParameter("remarks");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONArray jsonArray = new JSONArray();
				JSONObject obj = new JSONObject();

				obj.put("gid", gid);
				obj.put("sheet_number", sheet_number);
				obj.put("file_number", file_number);
				obj.put("reference_number", reference_number);
				obj.put("property_number", property_number);
				obj.put("cro_reference", cro_reference);
				obj.put("plot_number", plot_number);
				obj.put("locality", locality);
				obj.put("remarks", remarks);

				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				obj.put("data_of_clearness", "");
				obj.put("town_name", "");
				obj.put("plan_number", "");
				obj.put("type_of_data", "");

				jsonArray.put(obj);

				// rs_result = jsonArray.toString();

				String input_details = jsonArray.toString();

				// String wkt_polgon_wgs84 =
				// System.out.println(input_details);
				web_service_response = cls_maps.select_update_pvlmd_parcels(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			/*
			 * if
			 * (request_type.equals("search_for_lrd_scan_map_for_a_polygon")){
			 * String wkt_polgon = request.getParameter("wkt_polgon"); // String
			 * wkt_polgon_wgs84 = request.getParameter("wkt_polgon_wgs84");
			 * 
			 * System.out.println(wkt_polgon); web_service_response
			 * =cls_maps.select_search_scan_maps_polygons_by_wkt(cls_url_config.
			 * getWeb_service_url_ser(),wkt_polgon);
			 * if(web_service_response!=null) {
			 * System.out.println(web_service_response); }else{
			 * System.out.println(web_service_response); }
			 * 
			 * }
			 */

			if (request_type.equals("pvlmd_stateland_consent_for_save")) {
				String wkt_polgon = request.getParameter("wkt_polgon");
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(wkt_polgon);
				// web_service_response
				// =cls_maps.select_save_pvlmd_stateland_consent(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),wkt_polgon);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_save_spatial_objects_undergoing_registration")) {
				String wkt_polgon = request.getParameter("wkt_polygon");
				String case_number = request.getParameter("case_number");
				String job_number = request.getParameter("job_number");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				obj.put("wkt_polygon", wkt_polgon);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				// jsonArr.put(obj);
				// String input = jsonArr.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				System.out.println(obj.toString());
				web_service_response = cls_maps.select_save_spatial_objects_undergoing_registration(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_save_spatial_for_general_notiing")) {
				String wkt_polgon = request.getParameter("wkt_polygon");
				String case_number = request.getParameter("case_number");
				String job_number = request.getParameter("job_number");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				JSONArray jsonArr = new JSONArray();

				obj.put("wkt_polygon", wkt_polgon);
				obj.put("case_number", case_number);
				obj.put("job_number", job_number);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);

				// jsonArr.put(obj);
				// String input = jsonArr.toString();
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				System.out.println(obj.toString());
				web_service_response = cls_maps.select_save_spatial_for_general_notiing(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lc_plan_approval_plottings_search_by_job_number")) {
				String search_by_text = request.getParameter("search_by_text");
				// System.out.println(search_by_text);
				web_service_response = cls_maps.select_lc_plan_approval_plottings_search_by_job_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						search_by_text);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("pvlmd_statland_consent_update")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String gid = request.getParameter("gid");
				String file_number = request.getParameter("file_number");
				String reference_number = request.getParameter("reference_number");

				String applicant_name = request.getParameter("applicant_name");
				String application_type = request.getParameter("application_type");
				String area = request.getParameter("area");
				String region = request.getParameter("region");
				String job_number = request.getParameter("job_number");

				String applicant_phone_number = request.getParameter("applicant_phone_number");
				String applicant_address = request.getParameter("applicant_address");
				String date_received = request.getParameter("date_received");
				String locality = request.getParameter("locality");
				String remarks = request.getParameter("remarks");

				String plotted_by = request.getParameter("plotted_by");
				String plotted_by_id = request.getParameter("plotted_by_id");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("gid", gid.trim());

				obj.put("file_number", file_number);
				obj.put("reference_number", reference_number);
				obj.put("applicant_name", applicant_name);
				obj.put("application_type", application_type);
				obj.put("area", area);
				obj.put("region", region);
				obj.put("job_number", job_number);

				obj.put("applicant_phone_number", applicant_phone_number);
				obj.put("applicant_address", applicant_address);
				obj.put("date_received", date_received);
				obj.put("locality", locality);
				obj.put("remarks", remarks);

				obj.put("plotted_by", plotted_by);
				obj.put("plotted_by_id", plotted_by_id);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				// web_service_response
				// =cls_maps.select_update_pvlmd_stateland_consent(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("search_lrd_parcel_wkt")) {
				String parcel_id = request.getParameter("parcel_id");
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(parcel_id);
				web_service_response = cls_maps
						.select_search_parcels_lrd_by_parcel_id(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), parcel_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("search_smd_parcel_wkt")) {
				String parcel_id = request.getParameter("parcel_id");
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(parcel_id);
				web_service_response = cls_maps
						.select_search_parcels_smd_by_parcel_id(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), parcel_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("search_pvlmd_parcel_wkt")) {
				String parcel_id = request.getParameter("parcel_id");
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(parcel_id);
				web_service_response = cls_maps
						.select_search_parcels_pvlmd_by_parcel_id(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), parcel_id);

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("search_for_lrd_scan_map_for_a_polygon")) {
				String wkt_polygon = request.getParameter("wkt_polygon");
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(wkt_polygon);
				web_service_response = cls_maps
						.select_search_scan_maps_polygons_by_wkt(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), wkt_polygon);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("search_for_lrd_scan_map_all")) {
				// String wkt_polygon = request.getParameter("wkt_polygon");
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(wkt_polygon);
				web_service_response = cls_maps.select_search_scan_maps_all(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						"");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("search_for_lrd_scan_map_for_a_point")) {
				String wkt_polgon = request.getParameter("wkt_polgon");
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(wkt_polgon);
				web_service_response = cls_maps
						.select_search_scan_maps_polygons_by_point(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), wkt_polgon);

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("search_for_lrd_scan_map_for_a_polygon_district")) {
				String district = request.getParameter("district");
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_search_scan_maps_polygons_by_district(district);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("lvd_polygon_for_save")) {
				String wkt_polgon = request.getParameter("wkt_polgon");
				String wkt_polgon_wgs84 = request.getParameter("wkt_polgon_wgs84");

				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_save_lvd_parcels(wkt_polgon,wkt_polgon_wgs84);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_comparables_by_locality_report")) {
				String locality = request.getParameter("locality");

				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_comparables_by_locality_report(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),locality);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("search_smd_parcels_for_lrd_plot")) {
				String vr_cc_number = request.getParameter("vr_cc_number");
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_search_parcels_smd_by_ccno(vr_cc_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("plot_lrd_parcel_from_smd_data")) {
				String vr_fid = request.getParameter("vr_fid");
				String vr_user_name = request.getParameter("vr_user_name");
				String vr_user_id = request.getParameter("vr_user_id");
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_plot_lrd_parcel_from_smd_data(vr_fid,vr_user_name,vr_user_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("save_pvlmd_transaction_short")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String t_id = request.getParameter("t_id");
				String reference_number = request.getParameter("reference_number");
				String file_number = request.getParameter("file_number");
				String property_number = request.getParameter("property_number");
				String sheet_number = request.getParameter("sheet_number");
				String submission_date = request.getParameter("submission_date");
				// String mutation_number =
				// request.getParameter("mutation_number");
				String deed_number = request.getParameter("deed_number");
				// String serial_number = request.getParameter("serial_number");
				// String plan_number = request.getParameter("plan_number");
				String plot_number = request.getParameter("plot_number");
				// String lvb_number = request.getParameter("lvb_number");
				String instrument_date = request.getParameter("instrument_date");
				String instrument_type = request.getParameter("instrument_type");
				String doc_number = request.getParameter("doc_number");
				String party1_plaintiff = request.getParameter("party1_plaintiff");
				String party1_plaintiff_tel_no = request.getParameter("party1_plaintiff_tel_no");
				// String party1_plaintiff_email =
				// request.getParameter("party1_plaintiff_email");
				String party2_defendant = request.getParameter("party2_defendant");
				String party2_defendant_tel_no = request.getParameter("party2_defendant_tel_no");
				// String party2_defendant_email =
				// request.getParameter("party2_defendant_email");
				String term = request.getParameter("term");
				String commencement_date = request.getParameter("commencement_date");
				String purpose = request.getParameter("purpose");
				String consideration = request.getParameter("consideration");
				// String consideration_currency =
				// request.getParameter("consideration_currency");
				// String premium = request.getParameter("premium");
				// String premium_currency =
				// request.getParameter("premium_currency");
				// String compensation_status =
				// request.getParameter("compensation_status");
				// String suite_number = request.getParameter("suite_number");
				// String party1_plantiff_add =
				// request.getParameter("party1_plantiff_add");
				// String party2_defendant_add =
				// request.getParameter("party2_defendant_add");
				// String judgement_in_favour_of =
				// request.getParameter("judgement_in_favour_of");
				// String floor_level = request.getParameter("floor_level");
				String apartment_number = request.getParameter("apartment_number");
				String entered_date = request.getParameter("entered_date");
				// String rent = request.getParameter("rent");
				// String gid_id_fk = request.getParameter("gid_id_fk");
				// String unit_description =
				// request.getParameter("unit_description");
				String consent_date = request.getParameter("consent_date");

				String created_by = (String) session.getAttribute("fullname");
				String created_by_id = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				

				obj.put("t_id", t_id);
				obj.put("reference_number", reference_number);
				obj.put("file_number", file_number);
				obj.put("property_number", property_number);
				obj.put("sheet_number", sheet_number);

				obj.put("submission_date", submission_date);
				// obj.put( "mutation_number", mutation_number);
				obj.put("deed_number", deed_number);
				// obj.put( "serial_number", serial_number);
				// obj.put( "plan_number", plan_number);
				obj.put("plot_number", plot_number);
				// obj.put( "lvb_number", lvb_number);
				obj.put("instrument_date", instrument_date);
				obj.put("instrument_type", instrument_type);
				obj.put("doc_number", doc_number);
				obj.put("party1_plaintiff", party1_plaintiff);
				obj.put("party1_plaintiff_tel_no", party1_plaintiff_tel_no);
				// obj.put( "party1_plaintiff_email", party1_plaintiff_email);
				obj.put("party2_defendant", party2_defendant);
				obj.put("party2_defendant_tel_no", party2_defendant_tel_no);
				// obj.put( "party2_defendant_email", party2_defendant_email);
				obj.put("term", term);
				obj.put("commencement_date", commencement_date);
				obj.put("purpose", purpose);
				obj.put("consideration", consideration);
				// obj.put( "consideration_currency", consideration_currency);
				// obj.put( "premium",premium);
				// obj.put( "premium_currency", premium_currency);
				// obj.put( "compensation_status", compensation_status);
				// obj.put( "suite_number", suite_number);
				// obj.put( "party1_plantiff_add", party1_plantiff_add);
				// obj.put( "party2_defendant_add", party2_defendant_add);
				// obj.put( "judgement_in_favour_of", judgement_in_favour_of);
				// obj.put( "floor_level", floor_level);
				obj.put("apartment_number", apartment_number);
				obj.put("entered_date", entered_date);
				// obj.put( "rent", rent);
				// obj.put( "gid_id_fk", gid_id_fk);
				// obj.put( "unit_description", unit_description);
				obj.put("consent_date", consent_date);

				obj.put("entered_by", created_by); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("entered_by_id", created_by_id);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = cls_maps
						.select_add_update_pvlmd_transaction_short(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("save_pvlmd_transaction")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String t_id = request.getParameter("t_id");
				String reference_number = request.getParameter("reference_number");
				String file_number = request.getParameter("file_number");
				String property_number = request.getParameter("property_number");
				String submission_date = request.getParameter("submission_date");
				String mutation_number = request.getParameter("mutation_number");
				String deed_number = request.getParameter("deed_number");
				String serial_number = request.getParameter("serial_number");
				String sheet_number = request.getParameter("sheet_number");
				String plan_number = request.getParameter("plan_number");
				String plot_number = request.getParameter("plot_number");
				String lvb_number = request.getParameter("lvb_number");
				String instrument_date = request.getParameter("instrument_date");
				String instrument_type = request.getParameter("instrument_type");
				String doc_number = request.getParameter("doc_number");
				String party1_plaintiff = request.getParameter("party1_plaintiff");
				String party1_plaintiff_tel_no = request.getParameter("party1_plaintiff_tel_no");
				String party1_plaintiff_email = request.getParameter("party1_plaintiff_email");
				String party2_defendant = request.getParameter("party2_defendant");
				String party2_defendant_tel_no = request.getParameter("party2_defendant_tel_no");
				String party2_defendant_email = request.getParameter("party2_defendant_email");
				String term = request.getParameter("term");
				String commencement_date = request.getParameter("commencement_date");
				String purpose = request.getParameter("purpose");
				String consideration = request.getParameter("consideration");
				String consideration_currency = request.getParameter("consideration_currency");
				String premium = request.getParameter("premium");
				String premium_currency = request.getParameter("premium_currency");
				String compensation_status = request.getParameter("compensation_status");
				String suit_number = request.getParameter("suit_number");
				String party1_plantiff_add = request.getParameter("party1_plantiff_add");
				String party2_defendant_add = request.getParameter("party2_defendant_add");
				String judgement_in_favour_of = request.getParameter("judgement_in_favour_of");
				String floor_level = request.getParameter("floor_level");
				String apartment_number = request.getParameter("apartment_number");
				String rent = request.getParameter("rent");
				String gid_id_fk = request.getParameter("gid_id_fk");
				String unit_description = request.getParameter("unit_description");
				String consent_date = request.getParameter("consent_date");
				String remarks = request.getParameter("remarks");
				String created_by = (String) session.getAttribute("fullname");
				String created_by_id = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("t_id", t_id);
				obj.put("reference_number", reference_number);
				obj.put("file_number", file_number);
				obj.put("property_number", property_number);
				obj.put("submission_date", submission_date);
				obj.put("mutation_number", mutation_number);
				obj.put("deed_number", deed_number);
				obj.put("serial_number", serial_number);
				obj.put("sheet_number", sheet_number);
				obj.put("plan_number", plan_number);
				obj.put("plot_number", plot_number);
				obj.put("lvb_number", lvb_number);
				obj.put("instrument_date", instrument_date);
				obj.put("instrument_type", instrument_type);
				obj.put("doc_number", doc_number);
				obj.put("party1_plaintiff", party1_plaintiff);
				obj.put("party1_plaintiff_tel_no", party1_plaintiff_tel_no);
				obj.put("party1_plaintiff_email", party1_plaintiff_email);
				obj.put("party2_defendant", party2_defendant);
				obj.put("party2_defendant_tel_no", party2_defendant_tel_no);
				obj.put("party2_defendant_email", party2_defendant_email);
				obj.put("term", term);
				obj.put("commencement_date", commencement_date);
				obj.put("purpose", purpose);
				obj.put("consideration", consideration);
				obj.put("consideration_currency", consideration_currency);
				obj.put("premium", premium);
				obj.put("premium_currency", premium_currency);
				obj.put("compensation_status", compensation_status);
				obj.put("suit_number", suit_number);
				obj.put("party1_plantiff_add", party1_plantiff_add);
				obj.put("party2_defendant_add", party2_defendant_add);
				obj.put("judgement_in_favour_of", judgement_in_favour_of);
				obj.put("floor_level", floor_level);
				obj.put("apartment_number", apartment_number);
				obj.put("rent", rent);
				obj.put("gid_id_fk", gid_id_fk);
				obj.put("unit_description", unit_description);
				obj.put("consent_date", consent_date);
				obj.put("remarks", remarks);
				obj.put("entered_by", created_by); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("entered_by_id", created_by_id);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = cls_maps
						.select_add_update_pvlmd_transaction(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("pvlmd_parcel_update")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String gid = request.getParameter("gid");
				String sheet_number = request.getParameter("sheet_number");
				String file_number = request.getParameter("file_number");
				String reference_number = request.getParameter("reference_number");
				String property_number = request.getParameter("property_number");
				String data_of_clearness = request.getParameter("data_of_clearness");
				String town_name = request.getParameter("town_name");
				String plan_number = request.getParameter("plan_number");
				String plot_number = request.getParameter("plot_number");
				String locality = request.getParameter("locality");
				String type_of_data = request.getParameter("type_of_data");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				
				obj.put("gid", gid);
				obj.put("sheet_number", sheet_number);
				obj.put("file_number", file_number);
				obj.put("reference_number", reference_number);
				obj.put("property_number", property_number);
				obj.put("data_of_clearness", data_of_clearness);
				obj.put("town_name", town_name);
				obj.put("plan_number", plan_number);
				obj.put("plot_number", plot_number);
				obj.put("locality", locality);
				obj.put("type_of_data", type_of_data);

				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				// web_service_response
				// =cls_maps.select_update_pvlmd_parcels(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_update_smd_parcels")) {

				// JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String gid = request.getParameter("gid");
				String smd_cc_number = request.getParameter("smd_cc_number");
				String smd_reg_no = request.getParameter("smd_reg_no");
				String smd_a_name = request.getParameter("smd_a_name");
				String smd_job_number = request.getParameter("smd_job_number");
				String smd_locality = request.getParameter("smd_locality");
				String smd_plan_no = request.getParameter("smd_plan_no");
				String smd_remarks = request.getParameter("smd_remarks");
				String smd_wkt_polygon = request.getParameter("wkt_polygon");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				obj.put("gid", gid);

				obj.put("wkt_polygon", smd_wkt_polygon);
				obj.put("cc_number", smd_cc_number);
				obj.put("reg_no", smd_reg_no);
				obj.put("a_name", smd_a_name);
				obj.put("job_number", smd_job_number);
				obj.put("locality", smd_locality);
				obj.put("plan_no", smd_plan_no);
				obj.put("remarks", smd_remarks);
obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				// jsonArr.put(obj);
				// String input = jsonArr.toString();

				// System.out.println(obj.toString());
				web_service_response = cls_maps.select_parcels_smd_save(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("save_lvd_parcel")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String parcel_uuid = request.getParameter("parcel_uuid");
				String job_no = request.getParameter("job_no");
				String accreage_size_of_land = request.getParameter("accreage_size_of_land");
				String confirmed_acre_size = request.getParameter("confirmed_acre_size");
				String unexpired_term = request.getParameter("unexpired_term");
				String transaction_date = request.getParameter("transaction_date");
				String value_of_property = request.getParameter("value_of_property");
				String type_of_house = request.getParameter("type_of_house");
				String source_data = request.getParameter("source_data");
				String prominent_landmarks = request.getParameter("prominent_landmarks");
				String locality = request.getParameter("locality");
				String type_of_use = request.getParameter("type_of_use");
				String property_owner = request.getParameter("property_owner");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");


				obj.put("id", parcel_uuid);
				obj.put("job_no", job_no);
				obj.put("accreage_size_of_land", accreage_size_of_land);
				obj.put("confirmed_acre_size", confirmed_acre_size);
				obj.put("unexpired_term", unexpired_term);
				obj.put("transaction_date", transaction_date);
				obj.put("value_of_property", value_of_property);
				obj.put("type_of_house", type_of_house);
				obj.put("source_data", source_data);
				obj.put("prominent_landmarks", prominent_landmarks);
				obj.put("locality", locality);
				obj.put("type_of_use", type_of_use);
				obj.put("property_owner", property_owner);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = cls_maps.select_update_lvd_parcels(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						input);

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}
			if (request_type.equals("lvd_polygon_for_save")) {
				String wkt_polgon = request.getParameter("vr_wkt_polygon");
				String wkt_polgon_wgs84 = request.getParameter("wkt_polgon_wgs84");

				// System.out.println(parcel_id);
				web_service_response = cls_maps.select_save_lvd_parcels(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						wkt_polgon);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_comparables_by_locality_report")) {
				String locality = request.getParameter("locality");

				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_comparables_by_locality_report(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),locality);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("save_lvd_constructional_details")) {
				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String id = request.getParameter("id");
				String pid_fk = request.getParameter("pid_fk");
				String job_no = request.getParameter("job_no");
				String floor_details = request.getParameter("floor_details");
				String walls_details = request.getParameter("walls_details");
				String doors_details = request.getParameter("doors_details");
				String windows_details = request.getParameter("windows_details");
				String ceiling_details = request.getParameter("ceiling_details");
				String roof_details = request.getParameter("roof_details");
				String house_type = request.getParameter("house_type");
				String other_details = request.getParameter("other_details");

				String external_works = request.getParameter("external_works");
				String gross_external_area = request.getParameter("gross_external_area");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("id", id);
				obj.put("pid_fk", pid_fk);
				obj.put("job_no", job_no);
				obj.put("floor_details", floor_details);
				obj.put("walls_details", walls_details);
				obj.put("doors_details", doors_details);
				obj.put("windows_details", windows_details);
				obj.put("ceiling_details", ceiling_details);
				obj.put("roof_details", roof_details);
				obj.put("house_type", house_type);
				obj.put("other_details", other_details);

				obj.put("external_works", external_works);
				obj.put("gross_external_area", gross_external_area);

				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				// web_service_response
				// =cls_maps.select_add_update_lvd_transaction(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_update_sp_parcels_lvd_point")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String parcel_uuid = request.getParameter("parcel_uuid");
				String job_no = request.getParameter("job_no");
				// String accreage_size_of_land =
				// request.getParameter("accreage_size_of_land");
				// String confirmed_acre_size =
				// request.getParameter("confirmed_acre_size");
				String unexpired_term = request.getParameter("unexpired_term");
				String transaction_date = request.getParameter("transaction_date");
				String value_of_property = request.getParameter("value_of_property");
				String type_of_house = request.getParameter("type_of_house");
				String source_data = request.getParameter("source_data");
				String prominent_landmarks = request.getParameter("prominent_landmarks");
				String locality = request.getParameter("locality");
				String type_of_use = request.getParameter("type_of_use");
				String property_owner = request.getParameter("property_owner");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("id", parcel_uuid);
				obj.put("job_no", job_no);
				// obj.put("accreage_size_of_land", accreage_size_of_land);
				// obj.put("confirmed_acre_size", confirmed_acre_size);
				obj.put("unexpired_term", unexpired_term);
				obj.put("transaction_date", transaction_date);
				obj.put("value_of_property", value_of_property);
				obj.put("type_of_house", type_of_house);
				obj.put("source_data", source_data);
				obj.put("prominent_landmarks", prominent_landmarks);
				obj.put("locality", locality);
				obj.put("type_of_use", type_of_use);
				obj.put("property_owner", property_owner);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = cls_maps
						.select_update_sp_parcels_lvd_point(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_update_sp_parcels_lvd_point")) {
				// JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String id = request.getParameter("id");
				String job_no = request.getParameter("job_no");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("id", id);
				obj.put("job_no", job_no);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				// jsonArr.put(obj);
				String input = obj.toString();

				System.out.println(input);
				web_service_response = cls_maps.select_lvd_comparable_approve(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						input);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}
			if (request_type.equals("select_save_sp_parcels_lvd_point")) {
				String wkt_polgon = request.getParameter("vr_wkt_polygon");
				String wkt_polgon_wgs84 = request.getParameter("wkt_polgon_wgs84");

				// System.out.println(parcel_id);
				web_service_response = cls_maps
						.select_save_sp_parcels_lvd_point(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), wkt_polgon);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_sp_parcels_lvd_point_unapproved_all")) {
				String locality = request.getParameter("locality");

				// System.out.println(parcel_id);
				web_service_response = cls_maps
						.select_sp_parcels_lvd_point_unapproved_all(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), locality);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("load_lvd_constructional_details")) {
				String pid_fk = request.getParameter("pid_fk");

				web_service_response = cls_maps
						.select_lvd_contructional_details_all(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), pid_fk);

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_pvlmd_transaction_details")) {
				String gid_id_fk = request.getParameter("gid_id_fk");
				String reference_number = request.getParameter("reference_number");

				// web_service_response
				// =cls_maps.select_pvlmd_transactions_details_all(gid_id_fk,reference_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_pvlmd_transaction_details_by_gid_fk")) {
				String gid_id_fk = request.getParameter("gid_id_fk");
				// System.out.println(gid_id_fk);
				web_service_response = cls_maps
						.select_pvlmd_transactions_details_by_fk(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), gid_id_fk);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("select_pvlmd_transactions_details_by_t_id")) {
				String t_id = request.getParameter("t_id");
				// System.out.println(t_id);
				web_service_response = cls_maps
						.select_pvlmd_transactions_details_by_t_id(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), t_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("pvlmd_polgon_split")) {
				// int pid_fk = Integer.parseInt(json_request);
				int parcel_uid = Integer.parseInt(request.getParameter("parcel_uid"));
				String vr_blade_linestring = request.getParameter("vr_blade_linestring");
				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_pvlmd_polgon_split(parcel_uid,vr_blade_linestring);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_search_pvlmd_parcles_by_other_number")) {

				String vr_search_text = request.getParameter("vr_search_text");

				// System.out.println(vr_search_text);
				web_service_response = cls_maps.select_search_pvlmd_parcles_by_other_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						vr_search_text);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_search_smd_parcles_by_other_number")) {

				String vr_search_text = request.getParameter("vr_search_text");

				// System.out.println(vr_search_text);
				web_service_response = cls_maps.select_search_smd_parcles_by_other_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						vr_search_text);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("pvlmd_consent_search_by_attribute")) {

				String vr_search_text = request.getParameter("vr_search_text");
				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_search_pvlmd_stateland_consent_by_other_number(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),vr_search_text);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("pvlmd_transaction_select_by_reference_number")) {

				String reference_number = request.getParameter("reference_number");
				// System.out.println(parcel_id);
				web_service_response = cls_maps
						.select_pvlmd_transactions_details_all_by_refernce_number(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), reference_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			

			if (request_type.equals("get_rent_transaction_id_by_parcel_uuid")) {

				String parcel_uuid = request.getParameter("parcel_uuid");
				// System.out.println(parcel_id);
				web_service_response = cls_maps
						.get_rent_transaction_id_by_parcel_uuid(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), parcel_uuid);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			
			if (request_type.equals("get_rent_transaction_id_by_file_number")) {

				String file_number = request.getParameter("file_number");
				// System.out.println(parcel_id);
				web_service_response = cls_maps
						.get_rent_transaction_id_by_file_number(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), file_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("pvlmd_transaction_select_by_reference_number_main")) {

				String reference_number = request.getParameter("reference_number");
				// //System.out.println(parcel_id);
				web_service_response = cls_maps
						.select_pvlmd_transactions_details_all_by_refernce_number_main(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), reference_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("pvlmd_wkt_search")) {

				String vr_wkt_polygon = request.getParameter("vr_wkt_polygon");
				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_search_by_wkt_polygon(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),vr_wkt_polygon);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("pvlmd_search_transaction_by_wkt")) {

				String vr_wkt_polygon = request.getParameter("vr_wkt_polygon");
				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_search_transaction_by_wkt(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),vr_wkt_polygon);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_save_lvd_parcels")) {

				String vr_wkt_polygon = request.getParameter("vr_wkt_polygon");
				// System.out.println(parcel_id);
				web_service_response = cls_maps.select_save_lvd_parcels(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						vr_wkt_polygon);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("lrd_polygon_for_save")) {

				String vr_wkt_polygon = request.getParameter("wkt_polgon");
				String point_coordinate_list = request.getParameter("point_coordinate_list");

				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_lc_spatial_objects_save(vr_wkt_polygon,point_coordinate_list);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("lrd_parcel_update")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String fid = request.getParameter("fid");
				String reference_number = request.getParameter("reference_number");
				String locality = request.getParameter("locality");
				String plotted_by = request.getParameter("plotted_by");
				String date_plott = request.getParameter("date_plott");
				String checked_by = request.getParameter("checked_by");
				String type_of_plotting = request.getParameter("type_of_plotting");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("type_of_plotting", type_of_plotting);
				obj.put("reference_number", reference_number);
				obj.put("locality", locality);
				obj.put("plotted_by", plotted_by);
				obj.put("date_plott", date_plott);
				obj.put("checked_by", checked_by);
				obj.put("type_of_plotting", type_of_plotting);
				obj.put("fid", fid);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = cls_maps
						.select_lc_spatial_objects_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}
			if (request_type.equals("lrd_add_update_transaction")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String fid_id_fk = request.getParameter("fid_id_fk");
				String gid = request.getParameter("gid");
				String nature_of_instument = request.getParameter("nature_of_instument");
				String date_of_registration = request.getParameter("date_of_registration");
				String volume = request.getParameter("volume");
				String folio = request.getParameter("folio");
				String date_of_issued_cert_no = request.getParameter("date_of_issued_cert_no");
				String type_of_certificate = request.getParameter("type_of_certificate");
				String registered_number = request.getParameter("registered_number");
				// String locality = request.getParameter("locality");

				String cc_number = request.getParameter("cc_number");
				String certicate_number = request.getParameter("certicate_number");
				String applicant_name = request.getParameter("applicant_name");
				String grantor_name = request.getParameter("grantor_name");

				String job_number = request.getParameter("job_number");
				String type_instrument = request.getParameter("type_instrument");
				String date_of_instument = request.getParameter("date_of_instument");
				String consideration = request.getParameter("consideration");
				String purpose = request.getParameter("purpose");
				String date_commencement = request.getParameter("date_commencement");
				String term = request.getParameter("term");

				String remarks = request.getParameter("remarks");

				// String t_code = request.getParameter("t_code");
				// String label_code = request.getParameter("label_code");
				String plotted_by_reg = request.getParameter("plotted_by_reg");
				String checked_by = request.getParameter("checked_by");
				String plott_date_reg = request.getParameter("plott_date_reg");
				String type_of_registration = request.getParameter("type_of_registration");

				String reference_number = request.getParameter("reference_number");
				String land_size = request.getParameter("land_size");
				// String area_acre = request.getParameter("area_acre");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("gid", gid);
				obj.put("nature_of_instument", nature_of_instument);
				obj.put("date_of_registration", date_of_registration);
				obj.put("volume", volume);
				obj.put("folio", folio);
				obj.put("date_of_issued_cert_no", date_of_issued_cert_no);
				obj.put("type_of_certificate", type_of_certificate);
				obj.put("registered_number", registered_number);
				obj.put("cc_number", cc_number);
				obj.put("certicate_number", certicate_number);
				obj.put("applicant_name", applicant_name);
				obj.put("grantor_name", grantor_name);

				obj.put("job_number", job_number);
				obj.put("type_instrument", type_instrument);
				obj.put("date_of_instument", date_of_instument);
				obj.put("consideration", consideration);
				obj.put("purpose", purpose);
				obj.put("date_commencement", date_commencement);
				obj.put("term", term);
				obj.put("remarks", remarks);

				// obj.put( "label_code",label_code );
				obj.put("plotted_by_reg", plotted_by_reg);
				obj.put("checked_by", checked_by);
				obj.put("plott_date_reg", plott_date_reg);
				obj.put("type_of_registration", type_of_registration);
				obj.put("fid_id_fk", fid_id_fk);
				obj.put("reference_number", reference_number);
				obj.put("land_size", land_size);
				obj.put("fullname", fullname); 
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = cls_maps.select_lc_spatial_objects_transaction_add_update(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("load_lrd_transaction_details")) {
				String fid_fk = request.getParameter("fid_fk");
				// System.out.println(fid_fk);

				web_service_response = cls_maps.load_lrd_transaction_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						fid_fk);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_lrd_transaction_details_by_gid")) {
				String fid_fk = request.getParameter("gid");
				// System.out.println(fid_fk);

				web_service_response = cls_maps
						.load_lrd_transaction_details_by_gid(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), fid_fk);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_lrd_transaction_details_by_certificate_number")) {
				String certificate_number = request.getParameter("certificate_number");
				// System.out.println(certificate_number);

				web_service_response = cls_maps.load_lrd_transaction_details_by_certificate_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						certificate_number);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("lc_spatial_objects_search_by_other_details")) {
				String vr_search_text = request.getParameter("vr_search_text");

				web_service_response = cls_maps.select_lc_spatial_objects_search_by_other_details(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						vr_search_text);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					// System.out.println(web_service_response);
				}
			}

			if (request_type.equals("lvd_search_for_comparables_by_wkt_polygon")) {
				String wkt_polgon = request.getParameter("wkt_polgon");
				// System.out.println(parcel_id);
				web_service_response = cls_maps.select_sp_parcels_lvd_search_report_attribute_geom(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						wkt_polgon);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					// System.out.println(web_service_response);
				}

			}

			if (request_type.equals("lvd_search_for_comparables_by_locality")) {
				String locality = request.getParameter("locality");
				// System.out.println(parcel_id);
				// web_service_response
				// =cls_maps.select_comparables_by_locality(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),locality);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lc_locality_comparable_values_by_location")) {
				String locality = request.getParameter("locality");
				// System.out.println(locality);
				web_service_response = cls_maps.select_lc_locality_comparable_values_by_location(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						locality);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_calculate_area_in_acres")) {
				String locality = request.getParameter("wkt_polygon");
				// System.out.println(locality);
				web_service_response = cls_maps.select_calculate_area_in_acres(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						locality);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lc_spatial_objects_smd_transaction_by_fk")) {
				String fid_fk = request.getParameter("fid_fk");
				// System.out.println(fid_fk);

				web_service_response = cls_maps.select_lc_spatial_objects_smd_transaction_by_fk(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						fid_fk);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("select_lc_spatial_objects_smd_transaction_by_reference_number")) {
				String fid_fk = request.getParameter("reference_number");
				// System.out.println(fid_fk);

				web_service_response = cls_maps.select_lc_spatial_objects_smd_transaction_by_reference_number(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						fid_fk);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("select_lc_spatial_objects_smd_transaction_by_gid")) {
				String gid = request.getParameter("gid");
				// System.out.println(gid);

				web_service_response = cls_maps
						.select_lc_spatial_objects_smd_transaction_by_gid(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), gid);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("select_lc_spatial_objects_smd_save")) {
				String wkt_polgon = request.getParameter("wkt_polgon");

				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				String certificate_number = request.getParameter("certificate_number");

				String locality = request.getParameter("locality");
				String remarks = request.getParameter("remarks");

				JSONObject obj = new JSONObject();

				obj.put("wkt_polgon", wkt_polgon);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				obj.put("certificate_number", certificate_number);

				obj.put("locality", locality);
				obj.put("remarks", remarks);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =

				web_service_response = cls_maps
						.select_lc_spatial_objects_smd_save(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input_details);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lc_spatial_objects_smd_update")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String fid = request.getParameter("fid");
				String reference_number = request.getParameter("reference_number");
				String locality = request.getParameter("locality");
				String plotted_by = request.getParameter("plotted_by");
				String date_plott = request.getParameter("date_plott");
				String checked_by = request.getParameter("checked_by");
				String type_of_plotting = request.getParameter("type_of_plotting");
				String mul_claim = request.getParameter("mul_claim");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("mul_claim", mul_claim);
				obj.put("type_of_plotting", type_of_plotting);
				obj.put("reference_number", reference_number);
				obj.put("locality", locality);
				obj.put("plotted_by", plotted_by);
				obj.put("date_plott", date_plott);
				obj.put("checked_by", checked_by);
				obj.put("type_of_plotting", type_of_plotting);
				obj.put("fid", fid);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = cls_maps
						.select_lc_spatial_objects_smd_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_lc_spatial_objects_smd_transaction_add_update")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String fid_id_fk = request.getParameter("fid_id_fk");
				String gid = request.getParameter("gid");
				String regional_number = request.getParameter("regional_number");
				String plan_number = request.getParameter("plan_number");

				// String locality = request.getParameter("locality");

				String cc_number = request.getParameter("cc_number");

				String applicant_name = request.getParameter("applicant_name");
				String grantor_name = request.getParameter("grantor_name");

				String job_number = request.getParameter("job_number");
				String old_ref_number = request.getParameter("old_ref_number");
				String mul_claim = request.getParameter("mul_claim");

				String purpose = request.getParameter("purpose");

				String remarks = request.getParameter("remarks");

				// String t_code = request.getParameter("t_code");
				// String label_code = request.getParameter("label_code");
				String plotted_by_reg = request.getParameter("plotted_by");
				String checked_by = request.getParameter("checked_by");
				String plott_date_reg = request.getParameter("plott_date");
				String reference_number = request.getParameter("reference_number");
				// String area_acre = request.getParameter("area_acre");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");
				String userid = (String) session.getAttribute("userid");

				obj.put("gid", gid);
				obj.put("regional_number", regional_number);
				obj.put("plan_number", plan_number);
				obj.put("cc_number", cc_number);
				obj.put("applicant_name", applicant_name);
				obj.put("grantor_name", grantor_name);
				obj.put("job_number", job_number);
				obj.put("old_ref_number", old_ref_number);
				obj.put("mul_claim", mul_claim);
				obj.put("purpose", purpose);
				obj.put("remarks", remarks);
				// obj.put( "label_code",label_code );
				obj.put("plotted_by_reg", plotted_by_reg);
				obj.put("checked_by", checked_by);
				obj.put("plott_date_reg", plott_date_reg);
				obj.put("fid_id_fk", fid_id_fk);
				obj.put("reference_number", reference_number);
				obj.put("userid", userid); 
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);

				

				jsonArr.put(obj);
				String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = cls_maps.select_lc_spatial_objects_smd_transaction_add_update(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						input);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			/*
			 * if (request_type.equals(
			 * "select_lc_spatial_objects_smd_transaction_add_update")) {
			 * 
			 * JSONArray jsonArr = new JSONArray(); JSONObject obj = new
			 * JSONObject();
			 * 
			 * String fid_id_fk = request.getParameter("fid_id_fk"); String gid
			 * = request.getParameter("gid"); String regional_number =
			 * request.getParameter("regional_number"); String plan_number =
			 * request.getParameter("plan_number");
			 * 
			 * String cc_number = request.getParameter("cc_number"); String
			 * certicate_number = request.getParameter("certicate_number");
			 * String applicant_name = request.getParameter("applicant_name");
			 * String grantor_name = request.getParameter("grantor_name");
			 * String job_number = request.getParameter("job_number"); String
			 * type_instrument = request.getParameter("type_instrument"); String
			 * date_of_instument = request.getParameter("date_of_instument");
			 * String consideration = request.getParameter("consideration");
			 * String purpose = request.getParameter("purpose"); String
			 * date_commencement = request.getParameter("date_commencement");
			 * String term = request.getParameter("term"); String remarks =
			 * request.getParameter("remarks"); String plotted_by_reg =
			 * request.getParameter("plotted_by"); String plott_date_reg =
			 * request.getParameter("plott_date"); String reference_number =
			 * request.getParameter("reference_number");
			 * 
			 * obj.put("gid", gid); obj.put("cc_number", cc_number);
			 * obj.put("regional_number", regional_number);
			 * obj.put("job_number", job_number); obj.put("plan_number",
			 * plan_number); obj.put("certicate_number", certicate_number);
			 * obj.put("applicant_name", applicant_name);
			 * obj.put("grantor_name", grantor_name); obj.put("type_instrument",
			 * type_instrument); obj.put("date_of_instument",
			 * date_of_instument); obj.put("consideration", consideration);
			 * obj.put("purpose", purpose); obj.put("date_commencement",
			 * date_commencement); obj.put("term", term); obj.put("remarks",
			 * remarks); obj.put("fid_id_fk", fid_id_fk);
			 * obj.put("reference_number", reference_number);
			 * 
			 * obj.put("plotted_by", plotted_by_reg); // obj.put("checked_by",
			 * checked_by); obj.put("plott_date", plott_date_reg);
			 * 
			 * jsonArr.put(obj); String input = jsonArr.toString();
			 * 
			 * System.out.println(input); web_service_response =
			 * cls_maps.select_lc_spatial_objects_smd_transaction_add_update(
			 * input); if (web_service_response != null) {
			 * System.out.println(web_service_response); } else {
			 * System.out.println(web_service_response); }
			 * 
			 * }
			 */

			if (request_type.equals("pvlmd_number_generation_add_update")) {

				JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String id = request.getParameter("id");
				String reference_number = request.getParameter("reference_number");
				String locality = request.getParameter("locality");
				String applicant_name = request.getParameter("applicant_name");
				String old_ref_number = request.getParameter("old_ref_number");
				String number_format = request.getParameter("number_format");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("reference_number", reference_number);
				obj.put("locality", locality);
				obj.put("applicant_name", applicant_name);
				obj.put("old_ref_number", old_ref_number);
				obj.put("number_format", number_format);
				obj.put("fullname", fullname); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("id", id);
				// jsonArr.put(obj);
				// String input = jsonArr.toString();

				// System.out.println(input);
				web_service_response = cls_maps
						.pvlmd_number_generation_add_update(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_delete_pvlmd_transactions_all")) {
				String parcel_id = request.getParameter("parcel_id");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				obj.put("id", parcel_id);
				
				web_service_response = cls_maps
						.select_delete_pvlmd_transactions_all(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_delete_pvlmd_parcles")) {
				String parcel_id = request.getParameter("parcel_id");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				obj.put("id", parcel_id);

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(parcel_id);
				web_service_response = cls_maps.select_delete_pvlmd_parcles(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_delete_lc_spatial_objects")) {
				String parcel_id = request.getParameter("parcel_id");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				obj.put("id", parcel_id);
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(parcel_id);
				web_service_response = cls_maps
						.select_delete_lc_spatial_objects(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_delete_lc_spatial_objects_smd")) {
				String parcel_id = request.getParameter("parcel_id");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				obj.put("userid", userid);
				obj.put("id", parcel_id);
				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");
				// System.out.println(parcel_id);
				web_service_response = cls_maps
						.select_delete_lc_spatial_objects_smd(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_search_smd_parcles_by_other_number_lrd")) {

				JSONObject obj = new JSONObject();

				String reference_number = request.getParameter("reference_number");

				obj.put("reference_number", reference_number);

				// System.out.println(obj.toString());
				web_service_response = cls_maps.select_search_smd_parcles_by_other_number_lrd(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_update_sp_parcels_lvd_point")) {
				// JSONArray jsonArr = new JSONArray();
				JSONObject obj = new JSONObject();

				String id = request.getParameter("id");
				String job_no = request.getParameter("job_no");

				obj.put("id", id);
				obj.put("job_no", job_no);
				// jsonArr.put(obj);
				String input = obj.toString();

				System.out.println(input);
				web_service_response = cls_maps.select_lvd_comparable_approve(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						input);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_sp_parcels_lvd_search_report_geom")) {

				JSONObject obj = new JSONObject();

				String polygon = request.getParameter("polygon");

				// obj.put("reference_number", reference_number);

				System.out.println(obj.toString());
				web_service_response = cls_maps
						.select_sp_parcels_lvd_search_report_geom(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), polygon);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_sp_parcels_lvd_search_report_geom_locality")) {

				JSONObject obj = new JSONObject();

				String locality = request.getParameter("locality");

				// obj.put("reference_number", reference_number);

				System.out.println(obj.toString());
				web_service_response = cls_maps.select_sp_parcels_lvd_search_report_geom_locality(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						locality);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_sp_parcels_lvd_search_report_attribute_geom")) {
				JSONObject obj = new JSONObject();
				String reference_number = request.getParameter("reference_number");

				// obj.put("reference_number", reference_number);

				System.out.println(obj.toString());
				web_service_response = cls_maps.select_sp_parcels_lvd_search_report_attribute_geom(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						reference_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_sp_parcels_lvd_search_report_attribute_locality")) {

				JSONObject obj = new JSONObject();

				String reference_number = request
						.getParameter("select_sp_parcels_lvd_search_report_attribute_locality");

				// obj.put("reference_number", reference_number);

				System.out.println(obj.toString());
				web_service_response = cls_maps
						.select_sp_parcels_lvd_search_report_attribute_locality(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								reference_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_count_of_lc_spatial_objects")) {

				JSONObject obj = new JSONObject();
				String reference_number = request.getParameter("reference_number");

				// obj.put("reference_number", reference_number);
				// System.out.println(obj.toString());
				// System.out.println(obj.toString());
				// System.out.println(cls_url_config.getWeb_service_url_ser());
				// System.out.println(cls_url_config.getWeb_service_url_ser_api_key());
				web_service_response = cls_maps
						.select_count_of_lc_spatial_objects(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), "No-Parameter");
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_sp_parcels_lvd_search_report_geom")) {

				JSONObject obj = new JSONObject();

				String polygon = request.getParameter("polygon");

				// obj.put("reference_number", reference_number);

				System.out.println(obj.toString());
				web_service_response = cls_maps
						.select_sp_parcels_lvd_search_report_geom(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), polygon);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_sp_parcels_lvd_search_report_geom_locality")) {

				JSONObject obj = new JSONObject();

				String locality = request.getParameter("locality");

				// obj.put("reference_number", reference_number);

				System.out.println(obj.toString());
				web_service_response = cls_maps.select_sp_parcels_lvd_search_report_geom_locality(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						locality);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_sp_parcels_lvd_search_report_attribute_geom")) {

				JSONObject obj = new JSONObject();

				String reference_number = request.getParameter("reference_number");

				// obj.put("reference_number", reference_number);

				System.out.println(obj.toString());
				web_service_response = cls_maps.select_sp_parcels_lvd_search_report_attribute_geom(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						reference_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_sp_parcels_lvd_search_report_attribute_locality")) {

				JSONObject obj = new JSONObject();

				String reference_number = request
						.getParameter("select_sp_parcels_lvd_search_report_attribute_locality");

				// obj.put("reference_number", reference_number);

				web_service_response = cls_maps
						.select_sp_parcels_lvd_search_report_attribute_locality(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								reference_number);
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("search_pvlmd_transaction_details")) {

				JSONObject obj = new JSONObject();

				String search_value = request.getParameter("search_value");
				String layer_type = request.getParameter("layer_type");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("search_value", search_value);
				obj.put("layer_type", layer_type);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				web_service_response = cls_maps
						.search_pvlmd_transaction_details(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								obj.toString());
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("search_pvlmd_parcel_details")) {

				JSONObject obj = new JSONObject();

				String search_value = request.getParameter("search_value");
				String layer_type = request.getParameter("layer_type");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("search_value", search_value);
				obj.put("layer_type", layer_type);
obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				web_service_response = cls_maps
						.search_pvlmd_parcel_details(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								obj.toString());
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_pvlmd_deletion_request")) {

				JSONObject obj = new JSONObject();

				String tab_value = request.getParameter("tab_value");
				String layer_type = request.getParameter("layer_type");
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");

				obj.put("tab_value", tab_value);
				obj.put("layer_type", layer_type);
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				web_service_response = cls_maps
						.select_pvlmd_deletion_request(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								obj.toString());
				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_pvlmd_initiate_delete_request")) {

				JSONObject obj = new JSONObject();

				String _id = request.getParameter("_id");
				String reference_number = request.getParameter("reference_number");
				String delete_note = request.getParameter("delete_note");
				String initiate_type = request.getParameter("initiate_type");
				String send_to = request.getParameter("send_to");
				String layer_type = request.getParameter("layer_type");
				String deleted_requested_by_id = (String) session.getAttribute("userid");
				String deleted_requested_by = (String) session.getAttribute("fullname");

				obj.put("_id", _id);
				obj.put("reference_number", reference_number);
				obj.put("delete_note", delete_note);
				obj.put("initiate_type", initiate_type);
				obj.put("deleted_requested_by_id", deleted_requested_by_id);
				obj.put("deleted_requested_by", deleted_requested_by);
				obj.put("send_to", send_to);
				obj.put("layer_type", layer_type);
				

				reference_number = reference_number.replace("/","_");
				String fileName = file.getOriginalFilename(); 
				String path = cls_url_config.getLc_temp_folder() + reference_number;
				InputStream is = file.getInputStream();
            	boolean success = writeToFile(is,path);
				String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());

				if(success) {

					String newpath = cls_url_config.getLc_deleted_case() + reference_number;
					File filedir = new File(newpath);
					File sourcePath = new File(path);
					File destinationPath = new File(newpath + File.separator + timeStamp + "_" + fileName);

					if(!filedir.exists()) {
						boolean bool = filedir.mkdir();
						if(bool){
							fileCopy(sourcePath,destinationPath);
						}
						else{
							System.out.println("Sorry couldn't create specified directory");			
						}
						obj.put("attachment_location", destinationPath);
					}
					else {
						fileCopy(sourcePath,destinationPath);
						obj.put("attachment_location", destinationPath);
					}
				}

				System.out.println(obj.toString());

				web_service_response = cls_maps.select_pvlmd_initiate_delete_request(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_plvmd_cancel_delete_request")) {

				JSONObject obj = new JSONObject();

				String _id = request.getParameter("_id");
				String reference_number = request.getParameter("reference_number");
				//String delete_note = request.getParameter("delete_note");
				String initiate_type = request.getParameter("initiate_type");
				String decline_note = request.getParameter("decline_note");
				String layer_type = request.getParameter("layer_type");
				String declined_by_id = (String) session.getAttribute("userid");
				String declined_by = (String) session.getAttribute("fullname");

				obj.put("_id", _id);
				obj.put("reference_number", reference_number);
				obj.put("layer_type", layer_type);
				obj.put("initiate_type", initiate_type);
				obj.put("decline_note", decline_note);
				obj.put("declined_by_id", declined_by_id);
				obj.put("declined_by", declined_by);

				System.out.println(obj.toString());

				web_service_response = cls_maps.select_plvmd_cancel_delete_request(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_pvlmd_review_delete_request")) {

				JSONObject obj = new JSONObject();

				String _id = request.getParameter("_id");
				String reference_number = request.getParameter("reference_number");
				String initiate_type = request.getParameter("initiate_type");
				String layer_type = request.getParameter("layer_type");
				String review_note = request.getParameter("review_note");
				String send_to = request.getParameter("send_to");
				String reviewed_by_id = (String) session.getAttribute("userid");
				String reviewed_by = (String) session.getAttribute("fullname");

				obj.put("_id", _id);
				obj.put("reference_number", reference_number);
				obj.put("layer_type", layer_type);
				obj.put("initiate_type", initiate_type);
				obj.put("send_to", send_to);
				obj.put("review_note", review_note);
				obj.put("reviewed_by_id", reviewed_by_id);
				obj.put("reviewed_by", reviewed_by);

				System.out.println(obj.toString());

				//if(initiate_type.equals("parcel")) {
					web_service_response = cls_maps.select_pvlmd_review_delete_request(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());
				//}

				// else if(initiate_type.equals("transaction")) {
				// 	web_service_response = cls_maps.select_delete_pvlmd_transactions_all(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());
				// }

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if(request_type.equals("open_doc")) {

				String file_path = request.getParameter("file_path").trim();

				System.out.println(file_path);

				File pdfFile = new File(file_path);
				System.out.println(pdfFile);
				
                byte[] buffer = null;

                BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
                ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

                int ch;
                long actual = 0;
                while ((ch = is.read()) != -1) {
                    bos.write(ch);
                    actual++;
                }
                bos.flush();
                bos.close();
                buffer = bos.toByteArray();

                response.setContentType("application/pdf");
                response.addHeader("Content-Disposition", "inline; filename=Documentation.pdf");
                // response.addHeader("Content-Disposition", "inline;
                // filename=Documentation.pdf");
                response.setContentLength((int) pdfFile.length());
                response.getOutputStream().write(buffer, 0, buffer.length);
				
			}

			if (request_type.equals("verify_otp_for_initiate_delete")) {

				String user_phone =  (String) session.getAttribute("user_phone");
				String str = new String(user_phone);
				String new_phone = str.replaceFirst("0", "233");
				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				String job_number = request.getParameter("reference_number");

				int number = new Random().nextInt(900000) + 100000;
				session.setAttribute("delete_otp_code", number);

				String new_message = "Use this OTP Code: " + number + " to initiate amendment request.";
				System.out.println(number);

				JSONObject obj_sms = new JSONObject();
				obj_sms.put("recipient", new_phone);
				obj_sms.put("msg", new_message);
				obj_sms.put("fullname", fullname);
				obj_sms.put("userid", userid);
				obj_sms.put("job_number", job_number);
				obj_sms.put("otp_code", number);
				obj_sms.put("request_type", "Request");

				String smsm_result = sms_sl.send_single_sms(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());
				// String new_message="Verification code is "+ smsm_result;
				System.out.println("smsm_result");
				System.out.println(smsm_result);

				cls_maps.select_save_pvlmd_amendment_outgoing_sms(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj_sms.toString());
				

			}

			if (request_type.equals("verify_otp_for_review_delete")) {

				String user_phone =  (String) session.getAttribute("user_phone");
				String str = new String(user_phone);
				String new_phone = str.replaceFirst("0", "233");
				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				String job_number = request.getParameter("reference_number");

				int number = new Random().nextInt(900000) + 100000;
				session.setAttribute("delete_otp_code", number);

				String new_message = "Use this OTP Code: " + number + " to confirm review of amendment request.";
				System.out.println(number);

				JSONObject obj_sms = new JSONObject();
				obj_sms.put("recipient", new_phone);
				obj_sms.put("msg", new_message);
				obj_sms.put("fullname", fullname);
				obj_sms.put("userid", userid);
				obj_sms.put("job_number", job_number);
				obj_sms.put("otp_code", number);
				obj_sms.put("request_type", "Review");

				String smsm_result = sms_sl.send_single_sms(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());
				// String new_message="Verification code is "+ smsm_result;
				System.out.println("smsm_result");
				System.out.println(smsm_result);
				
				cls_maps.select_save_pvlmd_amendment_outgoing_sms(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj_sms.toString());

			}

			if (request_type.equals("confirm_otp_for_initiate_delete")) {

				String vc_1 = request.getParameter("vc_1");
				String vc_2 = request.getParameter("vc_2");
				String vc_3 = request.getParameter("vc_3");
				String vc_4 = request.getParameter("vc_4");
				String vc_5 = request.getParameter("vc_5");
				String vc_6 = request.getParameter("vc_6");

				String user_phone =  (String) session.getAttribute("user_phone");
				String str = new String(user_phone);
				String new_phone = str.replaceFirst("0", "233");

				String otp_code = vc_1 + vc_2 + vc_3 + vc_4 + vc_5 + vc_6;
				System.out.println(otp_code);

				String delete_otp_code = String.valueOf(session.getAttribute("delete_otp_code"));

				if(otp_code.equals(delete_otp_code)) {
					web_service_response = "true";

					JSONObject obj = new JSONObject();
					obj.put("recipient", new_phone);
					obj.put("otp_code", otp_code);

					cls_maps.select_approve_pvlmd_amendment_outgoing_sms(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());

				} else {
					web_service_response = "false";
				}

			}

			if (request_type.equals("verify_otp_for_approval_delete")) {

				String user_phone =  (String) session.getAttribute("user_phone");
				String str = new String(user_phone);
				String new_phone = str.replaceFirst("0", "233");
				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				String job_number = request.getParameter("reference_number");
				//String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				//String userid = (String) session.getAttribute("userid");

				int number = new Random().nextInt(900000) + 100000;
				session.setAttribute("delete_otp_code", number);

				String new_message = "Use this OTP Code: " + number + " to approve amendment request.";
				System.out.println(number);

				JSONObject obj_sms = new JSONObject();
				obj_sms.put("recipient", new_phone);
				obj_sms.put("msg", new_message);
				obj_sms.put("fullname", fullname);
				obj_sms.put("userid", userid);
				obj_sms.put("job_number", job_number);
				obj_sms.put("otp_code", number);
				obj_sms.put("request_type", "Approval");
				obj_sms.put("fullname", fullname);
				 obj_sms.put("mac_address", mac_address);

				String smsm_result = sms_sl.send_single_sms(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());
				// String new_message="Verification code is "+ smsm_result;
				System.out.println("smsm_result");
				System.out.println(smsm_result);
				
				cls_maps.select_save_pvlmd_amendment_outgoing_sms(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj_sms.toString());

			}

			if (request_type.equals("verify_otp_for_confirm_delete")) {

				String user_phone =  (String) session.getAttribute("user_phone");
				String str = new String(user_phone);
				String new_phone = str.replaceFirst("0", "233");
				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				String job_number = request.getParameter("reference_number");

				int number = new Random().nextInt(900000) + 100000;
				session.setAttribute("delete_otp_code", number);

				String new_message = "Use this OTP Code: " + number + " to confirm amendment request.";
				System.out.println(number);

				JSONObject obj_sms = new JSONObject();
				obj_sms.put("recipient", new_phone);
				obj_sms.put("msg", new_message);
				obj_sms.put("fullname", fullname);
				obj_sms.put("userid", userid);
				obj_sms.put("job_number", job_number);
				obj_sms.put("otp_code", number);
				obj_sms.put("request_type", "Delete");

				String smsm_result = sms_sl.send_single_sms(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());
				// String new_message="Verification code is "+ smsm_result;
				System.out.println("smsm_result");
				System.out.println(smsm_result);

				cls_maps.select_save_pvlmd_amendment_outgoing_sms(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj_sms.toString());
				

			}

			// if (request_type.equals("confirm_otp_for_initiate_delete")) {

			// 	String vc_1 = request.getParameter("vc_1");
			// 	String vc_2 = request.getParameter("vc_2");
			// 	String vc_3 = request.getParameter("vc_3");
			// 	String vc_4 = request.getParameter("vc_4");
			// 	String vc_5 = request.getParameter("vc_5");
			// 	String vc_6 = request.getParameter("vc_6");

			// 	String otp_code = vc_1 + vc_2 + vc_3 + vc_4 + vc_5 + vc_6;
			// 	System.out.println(otp_code);

			// 	String delete_otp_code = String.valueOf(session.getAttribute("delete_otp_code"));

			// 	if(otp_code.equals(delete_otp_code)) {
			// 		web_service_response = "true";

			// 	} else {
			// 		web_service_response = "false";
			// 	}

			// }

			if (request_type.equals("select_pvlmd_confirm_delete_request")) {

				JSONObject obj = new JSONObject();

				String _id = request.getParameter("_id");
				String reference_number = request.getParameter("reference_number");
				String initiate_type = request.getParameter("initiate_type");
				String layer_type = request.getParameter("layer_type");
				String approve_note = request.getParameter("approve_note");
				String deleted_approved_by_id = (String) session.getAttribute("userid");
				String deleted_approved_by = (String) session.getAttribute("fullname");

				obj.put("_id", _id);
				obj.put("reference_number", reference_number);
				obj.put("layer_type", layer_type);
				obj.put("userid", deleted_approved_by_id);
				obj.put("fullname", deleted_approved_by);
				obj.put("initiate_type", initiate_type);
				obj.put("approve_note", approve_note);

				System.out.println(obj.toString());

				//if(initiate_type.equals("parcel")) {
					web_service_response = cls_maps.select_pvlmd_review_delete_request(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());
				//}

				// else if(initiate_type.equals("transaction")) {
				// 	web_service_response = cls_maps.select_delete_pvlmd_transactions_all(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());
				// }

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_confirm_delete_pvlmd_parcles")) {
				JSONObject obj = new JSONObject();

				String _id = request.getParameter("_id");
				String reference_number = request.getParameter("reference_number");
				String initiate_type = request.getParameter("initiate_type");
				String layer_type = request.getParameter("layer_type");
				String deleted_approved_by_id = (String) session.getAttribute("userid");
				String deleted_approved_by = (String) session.getAttribute("fullname");

				obj.put("id", _id);
				obj.put("reference_number", reference_number);
				obj.put("layer_type", layer_type);
				obj.put("userid", deleted_approved_by_id);
				obj.put("fullname", deleted_approved_by);
				obj.put("initiate_type", initiate_type);

				System.out.println(obj.toString());

				web_service_response = cls_maps.select_delete_pvlmd_parcles(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_pvlmd_approve_delete_request")) {
				JSONObject obj = new JSONObject();

				String _id = request.getParameter("_id");
				String reference_number = request.getParameter("reference_number");
				String initiate_type = request.getParameter("initiate_type");
				String layer_type = request.getParameter("layer_type");
				String deleted_approved_by_id = (String) session.getAttribute("userid");
				String deleted_approved_by = (String) session.getAttribute("fullname");
				String approve_note = request.getParameter("approve_note");

				obj.put("id", _id);
				obj.put("reference_number", reference_number);
				obj.put("layer_type", layer_type);
				obj.put("userid", deleted_approved_by_id);
				obj.put("fullname", deleted_approved_by);
				obj.put("initiate_type", initiate_type);
				obj.put("approve_note", approve_note);

				System.out.println(obj.toString());

				web_service_response = cls_maps.select_pvlmd_approve_delete_request(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					 System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_pvlmd_deletion_request_details")) {
				JSONObject obj = new JSONObject();
				
				String reference_number = request.getParameter("reference_number");
				String layer_type = request.getParameter("layer_type");

				obj.put("reference_number", reference_number);
				obj.put("layer_type", layer_type);

				System.out.println(obj.toString());

				web_service_response = cls_maps.select_pvlmd_deletion_request_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					 System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_track_requested_details")) {
				JSONObject obj = new JSONObject();
				
				String reference_number = request.getParameter("reference_number");

				obj.put("reference_number", reference_number);

				System.out.println(obj.toString());

				web_service_response = cls_maps.select_track_requested_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					 System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_generate_requested_details")) {
				JSONObject obj = new JSONObject();
				
				String from_date = request.getParameter("from_date");
				String to_date = request.getParameter("to_date");

				obj.put("from_date", from_date);
				obj.put("to_date", to_date);

				System.out.println(obj.toString());

				web_service_response = cls_maps.select_generate_requested_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					 System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			if (request_type.equals("select_pvlmd_request_deleted")) {

				JSONObject obj = new JSONObject();

				String tab_value = request.getParameter("tab_value");
				String layer_type = request.getParameter("layer_type");

				obj.put("tab_value", tab_value);
				obj.put("layer_type", layer_type);

				web_service_response = cls_maps
						.select_pvlmd_request_deleted(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(),
								obj.toString());
				if (web_service_response != null) {
					System.out.println(web_service_response);
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

	 private boolean writeToFile(InputStream uploadedInputStream, String uploadedFileLocation) {
		  
        try { 
            OutputStream out = new FileOutputStream(new File(uploadedFileLocation)); 
            int read = 0; 
            byte[] bytes = new byte[1024];
        
            out = new FileOutputStream(new File(uploadedFileLocation));
            while ((read = uploadedInputStream.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
            out.flush(); out.close();
            
        } catch (IOException e) {
            e.printStackTrace(); 
        }

        return true; 
    }

    private boolean fileCopy(File sourcePath, File destinationPath) {
		  
        boolean status = false;
        try { 
            Files.copy(sourcePath.toPath(),destinationPath.toPath(),StandardCopyOption.REPLACE_EXISTING);
        
            status = true; 
        } catch (IOException e) {
            e.printStackTrace(); 
        }
        
        return status;
    }
}
