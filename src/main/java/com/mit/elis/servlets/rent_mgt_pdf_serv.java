package com.mit.elis.servlets;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.CSAU_billgeneration;
import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import ws.casemgt.ws_sms;
import ws.rentmgt.Ws_rent_mgt;
import org.springframework.ui.Model;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;
import com.mit.elis.class_common.cls_sms;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;

@RestController
public class rent_mgt_pdf_serv {

	@Autowired
	private Ws_url_config cls_url_config;

	Ws_rent_mgt rent_cl = new Ws_rent_mgt();

	CSAU_billgeneration billgeneration_cl = new CSAU_billgeneration();
	cls_casemgt casemgt_cl_m = new cls_casemgt();

	Ws_client_application user_web_service = new Ws_client_application();

	Ws_rent_mgt rent_mgt_service = new Ws_rent_mgt();

	Ws_url_config ws_url_config = new Ws_url_config();
	ws_sms sms_sl = new ws_sms();


	@RequestMapping("/rent_mgt_pdf_serv")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		String web_service_response = null;

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// HttpSession session = request.getSession();

		try {
			String request_type = request.getParameter("request_type");

			billgeneration_cl.web_compname = (String) session.getAttribute("web_compname");
			billgeneration_cl.web_comp_address = (String) session.getAttribute("web_comp_address");
			billgeneration_cl.web_city = (String) session.getAttribute("web_city");
			billgeneration_cl.web_fax_number = (String) session.getAttribute("web_fax_number");
			billgeneration_cl.web_telephone = (String) session.getAttribute("web_telephone");
			billgeneration_cl.web_email = (String) session.getAttribute("web_email");
			billgeneration_cl.web_branch_of_csau = (String) session.getAttribute("web_branch_of_csau");
			billgeneration_cl.web_rlo = (String) session.getAttribute("web_rlo");
			billgeneration_cl.web_regional_accountant = (String) session.getAttribute("web_regional_accountant");
			billgeneration_cl.web_head_of_csau = (String) session.getAttribute("web_head_of_csau");
			billgeneration_cl.web_chairman_regional_land_commission = (String) session.getAttribute("web_chairman_regional_land_commission");
			billgeneration_cl.web_office_region = (String) session.getAttribute("web_office_region");

			
			if (request_type.equals("print_rent_demand_notice")) {

				String rdn_rent_id = request.getParameter("rdn_rent_id");
				String rdn_account_number = request.getParameter("rdn_account_number");

				String userid = (String) session.getAttribute("userid");
				String fullname = (String) session.getAttribute("fullname"); 
				String mac_address = (String) session.getAttribute("mac_address"); 
				String ip_address =  (String) session.getAttribute("ip_address");


				String rs_result = null;

			//	JSONArray jsonArray = new JSONArray();
				JSONObject property_data_json = new JSONObject();

				property_data_json.put("rdn_rent_id", rdn_rent_id);
				property_data_json.put("rdn_account_number", rdn_account_number);
				
				property_data_json.put("userid", userid);
				property_data_json.put("fullname", fullname);
				property_data_json.put("mac_address", mac_address); 
				property_data_json.put("ip_address", ip_address);

				

				rs_result = property_data_json.toString();

				 System.out.println(rs_result);

				// web_service_response = "data";
				web_service_response = rent_cl.select_rent_leasee_details_by_rl_id(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						property_data_json.toString());

				if (web_service_response != null) {
					 System.out.println(web_service_response);
					String pdfFileName = "rent_demand_notice.pdf";

					//String pdf_dest = cls_url_config.getCase_upload_location();
					//String files_pdf_jackets_p = pdf_dest + case_number + "/" + job_number + pdfFileName;

					//File files_pdf_jackets = new File(pdf_dest + case_number);

					// if (!files_pdf_jackets.exists()) {
					// 	if (files_pdf_jackets.mkdirs()) {
					// 		System.out.println("Multiple directories are created!");
					// 	} else {
					// 		// System.out.println("Failed to create multiple
					// 		// directories!");
					// 	}
					// }
					JSONObject jsonobj = new JSONObject(web_service_response);
					web_service_response = (String) jsonobj.getString("data");
					String estate_name = (String) jsonobj.getString("estate_name");

					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_lc_rent_demand_notice_for_rent_mgt_unit(
							cls_url_config.getSoftfile_location(), web_service_response,estate_name,
							session.getAttribute("fullname").toString(), session.getAttribute("userid").toString());


				// 	JSONObject pdf_upload_obj = new JSONObject();
				// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);
				
				// pdf_upload_obj.put("jobNumber", rdn_account_number);
				// pdf_upload_obj.put("caseNumber",rdn_account_number);
				// pdf_upload_obj.put("fileData",base64Encoded);
							
				
				// pdf_upload_obj.put("doc_name",rdn_account_number);
				// pdf_upload_obj.put("doc_description","Rent Demand Notice Bill");
				// pdf_upload_obj.put("doc_category","public_docs");
				// pdf_upload_obj.put("doc_app_uploaded","elis");
				// pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				// pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				// pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
			
 				// String pdf_upload_response= rent_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				// cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

					
					if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}


				} else {
					System.out.println(web_service_response);
				}
			}

			
			if (request_type.equals("select_get_party_by_party_id")) {

				String client_id = request.getParameter("client_id");

				// System.out.println(client_id);
				// web_service_response = casemgt_cl.select_get_party_by_party_id(cls_url_config.getWeb_service_url_ser(),
				// 		cls_url_config.getWeb_service_url_ser_api_key(),
				// 		client_id);
				if (web_service_response != null) {
					// System.out.println(web_service_response);
					// System.out.println("nothing to " + web_service_response);

				} else {
					System.out.println(web_service_response);
					// System.out.println("son=mtni to " +
					// web_service_response);
				}

				return web_service_response;

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

				// System.out.println("testing cabinet batch: " + obj.toString());
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


		} catch (

		Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return web_service_response;
	}

}
