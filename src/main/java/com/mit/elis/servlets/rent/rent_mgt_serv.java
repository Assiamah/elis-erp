package com.mit.elis.servlets.rent;

import java.io.File;
import java.io.PrintWriter;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ws.csaumgt.ws_csaumgt;
import ws.rentmgt.Ws_rent_mgt;

import java.io.File;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class rent_mgt_serv {
	Ws_rent_mgt rent_mgt_cl = new Ws_rent_mgt();
	@Autowired
	private Ws_url_config cls_url_config;
	cls_casemgt casemgt_cl_m = new cls_casemgt();

	@RequestMapping("/rent_mgt_serv")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		// System.out.println("How are you");
	
		String web_service_response = null;
		//JSONObject obj = new JSONObject();

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {
			String request_type = request.getParameter("request_type");

			System.out.println(request_type);

			if (request_type.equals("select_rt_govt_estates_get_wkt")) {
				String ge_id = request.getParameter("ge_id");
				JSONObject obj_d = new JSONObject();

				obj_d.put("ge_id", ge_id);
				System.out.println(obj_d.toString());
				web_service_response = rent_mgt_cl
						.select_rt_govt_estates_get_wkt(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
	
			}

			if (request_type.equals("select_prepare_rent_demand_notice_single")) {
				
				System.out.println("dddddddd");
				String ge_id = request.getParameter("rdn_rent_id");
				JSONObject obj_d = new JSONObject();

				obj_d.put("rl_id", ge_id);
				System.out.println(obj_d.toString());
				web_service_response = rent_mgt_cl
						.select_prepare_rent_demand_notice_single(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());
			
								System.out.println("web_service_response");
				if (web_service_response != null) {
					 System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}


			if (request_type.equals("select_rent_leasee_details")) {


				String select_type = request.getParameter("select_type");		
				String estate = request.getParameter("estate");	
				String keyword = request.getParameter("keyword");			

				// System.out.println(list_of_application);

				JSONObject obj = new JSONObject();
				obj.put("select_type", select_type);
				obj.put("estate", estate);
				obj.put("keyword", keyword);
				

				// String batchlistdivison = obj.toString();

			  System.out.println("testing cabinet batch: " + obj.toString());
				web_service_response = casemgt_cl_m.select_rent_leasee_details(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("add_update_rent_leasee_details")) {

				String rent_id = request.getParameter("rent_id");
				String parcel_id = request.getParameter("parcel_id");
				String owners_name = request.getParameter("owners_name");
				String address = request.getParameter("address");
				String mobile = request.getParameter("mobile");
				String mobile_1 = request.getParameter("mobile_1");
				String email = request.getParameter("email");
				String file_number = request.getParameter("file_number");
				String ledger = request.getParameter("ledger");
				String folio = request.getParameter("folio");
				String digital_address = request.getParameter("digital_address");
				//String block = request.getParameter("block");
				String plot_number = request.getParameter("plot_number");
				String plot_size = request.getParameter("plot_size");
				String covenanted_user = request.getParameter("covenanted_user");
				String current_use = request.getParameter("current_use");
				String nature_of_devt = request.getParameter("nature_of_devt");
				String parcel_address = request.getParameter("parcel_address");
				String ls_number = request.getParameter("ls_number");
				String comm_date = request.getParameter("comm_date");
				String term = request.getParameter("term");
				//String expiry_date = request.getParameter("expiry_date");
				String consent_date = request.getParameter("consent_date");
				String location_rate = request.getParameter("location_rate");
				String rent_category = request.getParameter("rent_category");
				String rent_review_clause = request.getParameter("rent_review_clause");
				String rent_passing = request.getParameter("rent_passing");
				//String adjoining_plots = request.getParameter("adjoining_plots");
				//String amount_due = request.getParameter("amount_due");
				//String arrears_amounts = request.getParameter("arrears_amounts");
				//String original_use = request.getParameter("original_use");
				String glpin = request.getParameter("glpin");
				String remarks = request.getParameter("remarks");
				//String classification_of_arrears = request.getParameter("classification_of_arrears");
				String rent_outstanding = request.getParameter("rent_outstanding");
				String estate = request.getParameter("estate");
				String last_payment_date = request.getParameter("last_payment_date");
				String nature_of_instrument = request.getParameter("nature_of_instrument");
				//String last_review_date = request.getParameter("last_review_date");
				String region_id = (String) session.getAttribute("regional_code");
				String last_payment_period = request.getParameter("last_payment_period");
				String period_in_arrears = request.getParameter("period_in_arrears");

				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();

				obj.put("rent_id", rent_id);
				obj.put("parcel_id", parcel_id);
				obj.put("modified_by_id", modified_by_id);
				obj.put("modified_by", modified_by);
				obj.put("owners_name", owners_name);
				obj.put("address", address);
				obj.put("mobile", mobile);
				obj.put("mobile_1", mobile_1);
				obj.put("email", email);
				obj.put("file_number", file_number);
				obj.put("ledger", ledger);
				obj.put("folio", folio);
				obj.put("digital_address", digital_address);
				//obj.put("block", block);
				obj.put("plot_number", plot_number);
				obj.put("plot_size", plot_size);
				obj.put("covenanted_user", covenanted_user);
				obj.put("current_use", current_use);
				obj.put("nature_of_devt", nature_of_devt);
				obj.put("parcel_address", parcel_address);
				obj.put("ls_number", ls_number);
				obj.put("comm_date", comm_date);
				obj.put("term", term);
				//obj.put("expiry_date", expiry_date);
				obj.put("consent_date", consent_date);
				obj.put("location_rate", location_rate);
				obj.put("rent_category", rent_category);
				obj.put("rent_review_clause", rent_review_clause);
				obj.put("rent_passing", rent_passing);
				//obj.put("adjoining_plots", adjoining_plots);
				//obj.put("amount_due", amount_due);
				//obj.put("arrears_amounts", arrears_amounts);
				//obj.put("original_use", original_use);
				obj.put("rent_outstanding", rent_outstanding);
				//obj.put("classification_of_arrears", classification_of_arrears);
				obj.put("remarks", remarks);
				obj.put("glpin", glpin);
				obj.put("estate", estate);
				obj.put("nature_of_instrument", nature_of_instrument);
				//obj.put("last_review_date", last_review_date);
				obj.put("last_payment_date", last_payment_date);
				obj.put("region_id", region_id);
				obj.put("last_payment_period", last_payment_period);
				obj.put("period_in_arrears", period_in_arrears);


				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);



				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.add_update_rent_leasee_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("add_update_rent_transaction_history")) {

				String rent_id = request.getParameter("rent_id");
				String account_number = request.getParameter("account_number");
				String lessee_name = request.getParameter("lessee_name");
				String address = request.getParameter("address");
				String mobile_1 = request.getParameter("mobile_1");
				String mobile = request.getParameter("mobile");
				String email = request.getParameter("email");
				String plot_number = request.getParameter("plot_number");
				String plot_size = request.getParameter("plot_size");
				String comm_date = request.getParameter("comm_date");
				String nature_of_instrument = request.getParameter("nature_of_instrument");
				String consent_date = request.getParameter("consent_date");
				String term = request.getParameter("term");
				String remarks = request.getParameter("remarks");
				String m_id = request.getParameter("m_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();

				obj.put("rent_id", rent_id);
				obj.put("account_number", account_number);
				obj.put("lessee_name", lessee_name);
				obj.put("address", address);
				obj.put("mobile_1", mobile_1);
				obj.put("mobile", mobile);
				obj.put("email", email);
				obj.put("plot_number", plot_number);
				obj.put("plot_size", plot_size);
				obj.put("comm_date", comm_date);
				obj.put("term", term);
				obj.put("consent_date", consent_date);
				obj.put("nature_of_instrument", nature_of_instrument);
				obj.put("remarks", remarks);
				obj.put("m_id", m_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.add_update_rent_transaction_history(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}
			

			if (request_type.equals("load_rent_transaction_history")) {

				String m_id = request.getParameter("m_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("m_id", m_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.load_rent_transaction_history(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("load_parcel_transaction_history")) {

				String parcel_id = request.getParameter("parcel_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("parcel_id", parcel_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.load_parcel_transaction_history(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

				
			if (request_type.equals("get_estate_list")) {
				web_service_response = (String) session.getAttribute("estate_list");
				//System.out.println("get_estate_list");
				System.out.println(web_service_response);
				return web_service_response;
			}

			if (request_type.equals("get_nature_of_instrument_list")) {
				web_service_response = (String) session.getAttribute("nature_of_instrument_list");
				return web_service_response;
			}

			if (request_type.equals("get_nature_of_development_list")) {
				web_service_response = (String) session.getAttribute("nature_of_development_list");
				return web_service_response;
			}


			
			
			if (request_type.equals("load_rent_transaction_history_details")) {

				String t_id = request.getParameter("t_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("t_id", t_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.load_rent_transaction_history_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("load_rent_transaction_remarks")) {

				String m_id = request.getParameter("m_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("m_id", m_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.load_rent_transaction_remarks(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("load_rent_transaction_remarks_details")) {

				String r_id = request.getParameter("r_id");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("r_id", r_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.load_rent_transaction_remarks_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			
			if (request_type.equals("add_update_rent_transaction_remarks")) {
				String m_id = request.getParameter("m_id");
				String id = request.getParameter("id");
				String remarks = request.getParameter("remarks");
				String modified_by = (String) session.getAttribute("fullname");
				String modified_by_id = (String) session.getAttribute("userid");
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");
				JSONObject obj = new JSONObject();
				obj.put("id", id);
				obj.put("remarks", remarks);
				obj.put("m_id", m_id);
				obj.put("modified_by", modified_by);
				obj.put("modified_by_id", modified_by_id);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);

				String input_details = obj.toString();
				System.out.println(obj.toString());
				web_service_response = casemgt_cl_m.add_update_rent_transaction_remarks(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			if (request_type.equals("select_upload_rent_data")) {
				String rent_data_upload_list = request.getParameter("rent_data_upload_list");		
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("rent_data_upload_list", rent_data_upload_list);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);


				// String batchlistdivison = obj.toString();

				 System.out.println("testing cabinet batch: " +rent_data_upload_list);
				web_service_response = casemgt_cl_m.select_rent_data_upload(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						rent_data_upload_list);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}


			if (request_type.equals("upload_bulk_rent_ledger")) {
				String rent_data_upload_list = request.getParameter("rent_data_upload_list");		
				String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String fullname =  (String) session.getAttribute("fullname");
				String userid =  (String) session.getAttribute("userid");

				JSONObject obj = new JSONObject();
				obj.put("rent_data_upload_list", rent_data_upload_list);
				obj.put("fullname", fullname);
				obj.put("userid", userid); 
				obj.put("mac_address", mac_address); 
				obj.put("ip_address", ip_address);


				// String batchlistdivison = obj.toString();

				 System.out.println("testing new json: " +obj.toString());
				  System.out.println("testing cabinet batch: " +rent_data_upload_list);
				web_service_response = casemgt_cl_m.upload_bulk_rent_ledger(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						rent_data_upload_list);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;
			}

			return web_service_response;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// PrintWriter out = response.getWriter();
		// out.println("<p>Hello World!</p>");

		return web_service_response;
	}


			
}
