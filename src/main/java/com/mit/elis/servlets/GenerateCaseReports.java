package com.mit.elis.servlets;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.codehaus.jettison.json.JSONException;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.util.ArrayList;
import java.util.Base64;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;
import com.mit.elis.class_common.cls_casemgt_reports;

@RestController
public class GenerateCaseReports {
	cls_casemgt_reports case_reports_cl = new cls_casemgt_reports();

	Ws_client_application casemgt_cl = new Ws_client_application();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/GenerateCaseReports")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ParseException, JSONException {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// HttpSession session = request.getSession();
	    byte[] buffer = null;
		String request_type = request.getParameter("request_type");

		String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
		// System.out.println(timeStamp);\

		case_reports_cl.web_compname = (String) session.getAttribute("web_compname");
		case_reports_cl.web_comp_address = (String) session.getAttribute("web_comp_address");
		case_reports_cl.web_city = (String) session.getAttribute("web_city");
		case_reports_cl.web_fax_number = (String) session.getAttribute("web_fax_number");
		case_reports_cl.web_telephone = (String) session.getAttribute("web_telephone");
		case_reports_cl.web_email = (String) session.getAttribute("web_email");
		case_reports_cl.web_branch_of_csau = (String) session.getAttribute("web_branch_of_csau");
		case_reports_cl.web_rlo = (String) session.getAttribute("web_rlo");
		case_reports_cl.web_regional_accountant = (String) session.getAttribute("web_regional_accountant");
		case_reports_cl.web_head_of_csau = (String) session.getAttribute("web_head_of_csau");
		case_reports_cl.web_chairman_regional_land_commission = (String) session
				.getAttribute("web_chairman_regional_land_commission");
		case_reports_cl.web_office_region = (String) session.getAttribute("web_office_region");

		if (request_type.equals("request_to_generate_register_unsigned")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");

			String currentuser = (String) session.getAttribute("designation");

			String currentuserfullname = (String) session.getAttribute("fullname").toString();

			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_register_unsigned" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			try {
				buffer = case_reports_cl.create_land_register(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					case_number, job_number,
					files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
		
					JSONObject pdf_upload_obj = new JSONObject();
					String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				pdf_upload_obj.put("jobNumber", job_number);
				pdf_upload_obj.put("caseNumber",case_number);
				pdf_upload_obj.put("fileData",base64Encoded);
							
				
				pdf_upload_obj.put("doc_name",job_number);
				pdf_upload_obj.put("doc_description","Land Register");
				pdf_upload_obj.put("doc_category","case_docs");
				pdf_upload_obj.put("doc_app_uploaded","elis");
				pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
				pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
				pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
				
			
			
 				String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_register_signed")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");

			String currentuser = (String) session.getAttribute("designation");

			String currentuserfullname = (String) session.getAttribute("fullname").toString();

			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_register_signed" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			try {
				buffer = case_reports_cl.create_land_register(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					case_number, job_number,
					files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Land Register");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}
		// ------------for smd temporal barcoding

		if (request_type.equals("request_to_generate_smd_temp_barcode")) {

			// String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			// String wkt_polygon = request.getParameter("wkt_polygon");
			// String case_number = request.getParameter("case_number");
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = job_number + "_smd_barcode" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// // String contextPath =
			// // getServletContext().getRealPath(File.separator);
			// File pdfFile = new File(contextPath + "temporal_barcode" + "/" + pdfFileName);
			// File files_pdf_jackets = new File(contextPath + job_number);
			// String files_pdf_jackets_p = contextPath + "temporal_barcode" + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			try {
				buffer = case_reports_cl.create_smd_temp_barcode(job_number);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();

			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
	// 	JSONObject pdf_upload_obj = new JSONObject();
	// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
	// 	pdf_upload_obj.put("jobNumber", job_number);
	// 	pdf_upload_obj.put("caseNumber",job_number);
	// 	pdf_upload_obj.put("fileData",base64Encoded);
					
				
	
	// 	pdf_upload_obj.put("doc_name",job_number);
	// 	pdf_upload_obj.put("doc_description","Service Bill");
	// 	pdf_upload_obj.put("doc_category","public_docs");
	// 	pdf_upload_obj.put("doc_app_uploaded","elis");
	// 	pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	//  String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	//  cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		// ------------------------------------------------

		if (request_type.equals("request_to_generate_register")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_register" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			if (!files_pdf_jackets.exists()) {
				if (files_pdf_jackets.mkdirs()) {
					System.out.println("Multiple directories are created!");
				} else {
					System.out.println("Failed to create multiple directories!");
				}
			}

			try {
				buffer = case_reports_cl.create_land_register(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number, job_number,
						files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
		
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Land Register");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
			
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_case_letter")) {

			String lc_letter_type = request.getParameter("lc_letter_type");
			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String lc_letter_cc = request.getParameter("lc_letter_cc");
			String leter_details = request.getParameter("lc_search_report_summary_details_final");
			String currentuser = (String) session.getAttribute("designation");

			// System.out.println(leter_details);
			// System.out.println(ir_business_process_sub_name);
			// System.out.println(case_number);
			// System.out.println("CC1: " + lc_letter_cc);

			String contextPath = cls_url_config.getPublic_docs_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_" + lc_letter_type.replaceAll("\\s+", "_") + "_" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			if (!files_pdf_jackets.exists()) {
				if (files_pdf_jackets.mkdirs()) {
					// System.out.println("Multiple directories are created!");
				} else {
					// System.out.println("Failed to create multiple
					// directories!");
				}
			}

			try {

				buffer = case_reports_cl.create_general_letters_templates(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number,
						job_number, leter_details,
						session.getAttribute("fullname").toString(), currentuser, lc_letter_cc, files_pdf_jackets_p);

				/*
				 * if (lc_letter_type.equals("inspection_letter")) {
				 * System.out.println("inspection_letter");
				 * buffer = case_reports_cl.create_inspection_letter(cls_url_config.getSoftfile_location(
				 * ),case_number,
				 * job_number, ir_business_process_sub_name,
				 * session.getAttribute("fullname").toString(),
				 * files_pdf_jackets_p); } else if
				 * (lc_letter_type.equals("planning_comments_letter")) {
				 * System.out.println("planning_comments_letter");
				 * buffer = case_reports_cl.create_planning_comments_letter(cls_url_config.
				 * getSoftfile_location(),case_number,
				 * job_number, ir_business_process_sub_name,
				 * session.getAttribute("fullname").toString(),
				 * files_pdf_jackets_p); } else if (lc_letter_type.equals("")) {
				 * 
				 * } else if (lc_letter_type.equals("")) {
				 * 
				 * }
				 */

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Letters");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_inspection_letter")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String ir_business_process_sub_name = request.getParameter("ir_business_process_sub_name");
			System.out.println(ir_business_process_sub_name);
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_inspection_letter" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			if (!files_pdf_jackets.exists()) {
				if (files_pdf_jackets.mkdirs()) {
					System.out.println("Multiple directories are created!");
				} else {
					System.out.println("Failed to create multiple directories!");
				}
			}

			try {
				buffer = case_reports_cl.create_inspection_letter(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number, job_number,
						ir_business_process_sub_name,
						session.getAttribute("fullname").toString(), files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
		
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Case Letter");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
			
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_planning_letter")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String ir_business_process_sub_name = request.getParameter("ir_business_process_sub_name");
			System.out.println(ir_business_process_sub_name);
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_planning_comment_letter" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			if (!files_pdf_jackets.exists()) {
				if (files_pdf_jackets.mkdirs()) {
					System.out.println("Multiple directories are created!");
				} else {
					System.out.println("Failed to create multiple directories!");
				}
			}

			try {
				buffer = case_reports_cl.create_planning_comments_letter(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number,
						job_number, ir_business_process_sub_name,
						session.getAttribute("fullname").toString(), files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Letter");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_offer_letter")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String ir_business_process_sub_name = request.getParameter("ir_business_process_sub_name");
			System.out.println(ir_business_process_sub_name);
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_planning_comment_letter" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			if (!files_pdf_jackets.exists()) {
				if (files_pdf_jackets.mkdirs()) {
					System.out.println("Multiple directories are created!");
				} else {
					System.out.println("Failed to create multiple directories!");
				}
			}

			try {
				buffer = case_reports_cl.create_offer_letter(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number, job_number,
						ir_business_process_sub_name,
						session.getAttribute("fullname").toString(), files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Offer Latter");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}


		if (request_type.equals("request_to_generate_offer_letter_external")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String ir_business_process_sub_name = request.getParameter("ir_business_process_sub_name");
			System.out.println(ir_business_process_sub_name);
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_planning_comment_letter" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			if (!files_pdf_jackets.exists()) {
				if (files_pdf_jackets.mkdirs()) {
					System.out.println("Multiple directories are created!");
				} else {
					System.out.println("Failed to create multiple directories!");
				}
			}

			try {
				buffer = case_reports_cl.create_offer_letter_external(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number, job_number,
						ir_business_process_sub_name,
						session.getAttribute("fullname").toString(), files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Offer Latter");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_lease_document")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String ir_business_process_sub_name = request.getParameter("ir_business_process_sub_name");
			System.out.println(ir_business_process_sub_name);
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_lease_documents" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			if (!files_pdf_jackets.exists()) {
				if (files_pdf_jackets.mkdirs()) {
					System.out.println("Multiple directories are created!");
				} else {
					System.out.println("Failed to create multiple directories!");
				}
			}

			try {
				buffer = case_reports_cl.create_lc_lease_document(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number, job_number,
						files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();

			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
		
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Lease Docs");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
			
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_consent_certificate")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String business_process_sub_name = request.getParameter("ir_business_process_sub_name");
			System.out.println(business_process_sub_name);
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_lease_documents" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			try {

				if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (WHOLE SITE)")) {
					buffer = case_reports_cl.create_consent_certificate(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, files_pdf_jackets_p);
				} else if (business_process_sub_name
						.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (PORTION OR PART)")) {
					buffer = case_reports_cl.create_consent_certificate(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONCURRENCE")) {
					buffer = case_reports_cl.create_concurrence_certificate(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN (JUDICIAL SALE)")) {
					buffer = case_reports_cl.create_consent_certificate(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO MORTGAGE")) {
					buffer = case_reports_cl.create_consent_certificate(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO VEST (VESTING ASSENT)")) {
					buffer = case_reports_cl.create_consent_certificate(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, files_pdf_jackets_p);
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();

			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Concent/Concurrent Certificate");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_consent_certificate_typed")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String transaction_number = request.getParameter("transaction_number");
			String business_process_sub_name = request.getParameter("ir_business_process_sub_name");
			String notes = request.getParameter("notes");
			String type_of_certificate = request.getParameter("type_of_certificate");
			String designation = (String) session.getAttribute("designation");

			System.out.println(business_process_sub_name);
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_consent_certificate" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			if (!files_pdf_jackets.exists()) {
				if (files_pdf_jackets.mkdirs()) {
					System.out.println("Multiple directories are created!");
				} else {
					System.out.println("Failed to create multiple directories!");
				}
			}

			try {
				// System.out.println(files_pdf_jackets_p);

				if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (WHOLE SITE)")) {

					buffer = case_reports_cl.create_consent_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							notes,
							transaction_number, job_number,
							files_pdf_jackets_p);
				} else if (business_process_sub_name
						.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (PORTION OR PART)")) {
					buffer = case_reports_cl.create_consent_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							notes,
							transaction_number, job_number,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONCURRENCE")) {
					buffer = case_reports_cl.create_concurrence_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							notes,
							transaction_number, job_number,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN (JUDICIAL SALE)")) {
					buffer = case_reports_cl.create_consent_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							notes,
							transaction_number, job_number,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO MORTGAGE")) {
					buffer = case_reports_cl.create_consent_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							notes,
							transaction_number, job_number,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO VEST (VESTING ASSENT)")) {
					buffer = case_reports_cl.create_consent_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							notes,
							transaction_number, job_number,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION")) {
					buffer = case_reports_cl.create_consent_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							notes,
							transaction_number, job_number,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR LEASE")) {
					buffer = case_reports_cl.create_consent_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							notes,
							transaction_number, job_number,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						
							transaction_number, job_number, type_of_certificate,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR PART TRANSFER")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						
							transaction_number, job_number, type_of_certificate,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION")) {
					buffer = case_reports_cl.create_deeds_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							
							transaction_number, job_number,"",
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION WITH CONCURRENCE")) {
					buffer = case_reports_cl.create_deeds_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					
					transaction_number, job_number,"",
					files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION ON FAMILY LAND")) {
					buffer = case_reports_cl.create_deeds_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					
					transaction_number, job_number,"",
					files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION WITH CONSENT")) {
					buffer = case_reports_cl.create_deeds_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					
					transaction_number, job_number,"",
					files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR WHOLE TRANFER")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							
							transaction_number, job_number, type_of_certificate,
							files_pdf_jackets_p);

				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
		
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Land Certificate");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
			
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_concurrence_certificate")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String ir_business_process_sub_name = request.getParameter("ir_business_process_sub_name");
			System.out.println(ir_business_process_sub_name);
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_lease_documents" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			try {
				buffer = case_reports_cl.create_concurrence_certificate(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number,
						job_number, files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();

			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Concurrence Certificate");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_title_plan")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String wkt_polygon = request.getParameter("wkt_polygon");
			String transaction_number = request.getParameter("transaction_number");
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_title_plan" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		// System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			try {
				buffer = case_reports_cl.create_title_plan(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						transaction_number, job_number,
						wkt_polygon, files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Title Plan");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_smd_barcode")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String wkt_polygon = request.getParameter("wkt_polygon");
			// String case_number = request.getParameter("case_number");
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_smd_barcode" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		// System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			try {
				buffer = case_reports_cl.create_smd_barcode_gated_wor_flow(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number, job_number,files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
	// 	JSONObject pdf_upload_obj = new JSONObject();
	// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);


	// 	pdf_upload_obj.put("jobNumber", job_number);
	// 	pdf_upload_obj.put("caseNumber",case_number);
	// 	pdf_upload_obj.put("fileData",base64Encoded);
		
		
	// 	pdf_upload_obj.put("doc_name",job_number);
	// 	pdf_upload_obj.put("doc_description","Service Bill");
	// 	pdf_upload_obj.put("doc_category","public_docs");
	// 	pdf_upload_obj.put("doc_app_uploaded","elis");
	// 	pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	//  String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	//  cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_smd_barcode_with_address_code")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String wkt_polygon = request.getParameter("wkt_polygon");
			// String case_number = request.getParameter("case_number");
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_smd_barcode" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		// System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			try {
				buffer = case_reports_cl.create_smd_barcode_gated_work_flow_address_code(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number, job_number,files_pdf_jackets_p,cls_url_config.getSite_plan_verification());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
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
		}

		if (request_type.equals("request_to_generate_search_template")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

			String division = (String) session.getAttribute("division");

			String designation = (String) session.getAttribute("designation");
			String business_process_sub_name = request.getParameter("business_process_sub_name");
			String signature = request.getParameter("signature");

			System.out.println(request_type);

			String contextPath = cls_url_config.getPublic_docs_upload_location();
			String case_docs_location = cls_url_config.getCase_upload_location();

			String sign_path = cls_url_config.getSample_sign_location();

			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_search_report_letter" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		// System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			try {

				if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH")) {
					buffer = case_reports_cl.create_search_report_pvlmd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD OFFICIAL SEARCH")) {
					buffer = case_reports_cl.create_search_report_pvlmd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR OFFICIAL SEARCH (CONSOLIDATED)")) {
					
					
					
					buffer = case_reports_cl.create_search_report_lc_consolidated_search(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getDoc_mgt_api(), cls_url_config.getDoc_mgt_api_key(),cls_url_config.getSoftfile_location(),
							case_number, job_number, files_pdf_jackets_p, sign_path, case_docs_location, contextPath);
				} else if (business_process_sub_name.equals("APPLICATION FOR LRD SITE PLAN SEARCH")) {
					buffer = case_reports_cl.create_search_report_lrd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR LRD ADMINISTRATIVE SEARCH (POLICE)")) {
					buffer = case_reports_cl.create_search_report_police(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR LRD POLICE SEARCH")) {
					buffer = case_reports_cl.create_search_report_police(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR LRD ADMINISTRATIVE SEARCH")) {
					buffer = case_reports_cl.create_search_report_police(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR CERTIFICATE SEARCH")) {
					buffer = case_reports_cl.create_search_report_lrd_2(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							designation, files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR LRD CERTIFICATE SEARCH")) {
					buffer = case_reports_cl.create_search_report_lrd_2(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							designation, files_pdf_jackets_p);

				} else if (business_process_sub_name.equals("APPLICATION FOR LRD PERMIT SEARCH")) {
					buffer = case_reports_cl.create_search_report_pvlmd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR ADMINISTRATIVE SEARCH")) {
					buffer = case_reports_cl.create_search_report_pvlmd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);

				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD ADMINISTRATIVE SEARCH")) {
					buffer = case_reports_cl.create_search_report_pvlmd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH")) {
					buffer = case_reports_cl.create_search_report_pvlmd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR PERMIT SEARCH")) {
					buffer = case_reports_cl.create_search_report_pvlmd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR PVLMD PERMIT SEARCH")) {
					buffer = case_reports_cl.create_search_report_pvlmd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR SMD SITE PLAN SEARCH")) {
					buffer = case_reports_cl.create_search_report_smd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				} else if (business_process_sub_name.equals("APPLICATION FOR TITLE SEARCH(PERMIT)")) {
					buffer = case_reports_cl.create_search_report_pvlmd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
					/*
					 * } else if (business_process_sub_name.equals("LRD")) {
					 * buffer = case_reports_cl.create_search_report_lrd(cls_url_config.getSoftfile_location(
					 * ),case_number,
					 * job_number, fullname, files_pdf_jackets_p); } else if
					 * (business_process_sub_name.equals("LRD")) {
					 */
					// sbuffer = case_reports_cl.create_search_report_lrd(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),cls_url_config.getSoftfile_location(),case_number,
					// job_number, fullname, files_pdf_jackets_p);
				} else {
					buffer = case_reports_cl.create_search_report_pvlmd(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number,
							job_number, signature, fullname,
							files_pdf_jackets_p);
				}

				// buffer = case_reports_cl.create_search_report_smd(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),cls_url_config.getSoftfile_location(),case_number,
				// job_number, fullname, files_pdf_jackets_p);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
	// 	JSONObject pdf_upload_obj = new JSONObject();
	// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
	// 	pdf_upload_obj.put("jobNumber", job_number);
	// 	pdf_upload_obj.put("caseNumber",case_number);
	// 	pdf_upload_obj.put("fileData",base64Encoded);
					
	
	// 	pdf_upload_obj.put("doc_name",job_number);
	// 	pdf_upload_obj.put("doc_description","Service Bill");
	// 	pdf_upload_obj.put("doc_category","public_docs");
	// 	pdf_upload_obj.put("doc_app_uploaded","elis");
	// 	pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	//  String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	//  cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_transitional_certificate")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String cert_type = request.getParameter("cert_type");
			String notes = request.getParameter("notes");
			String registration_district_number = request.getParameter("registration_district_number");
			String registration_section_number = request.getParameter("registration_section_number");
			String type_of_certificate = request.getParameter("type_of_certificate");
			System.out.println(cert_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_certificate" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		// System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {

				// cls_case_m.select_generate_cert_volume_folio_number(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),cls_url_config.getSoftfile_location(),case_number,registration_district_number,registration_section_number);

				buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number, type_of_certificate,
						job_number, files_pdf_jackets_p);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
			
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Land Certificate");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
			

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_provisional_certificate")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String cert_type = request.getParameter("cert_type");
			String registration_district_number = request.getParameter("registration_district_number");
			String registration_section_number = request.getParameter("registration_section_number");

			System.out.println(cert_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_certificate" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		// System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {

				// cls_case_m.select_generate_cert_volume_folio_number(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),cls_url_config.getSoftfile_location(),case_number,registration_district_number,registration_section_number);

				if (cert_type.equals("ASSIGNMENT")) {
					// buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					// 		cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					// 		case_number, job_number, files_pdf_jackets_p);
				} else if (cert_type.equals("LEASEHOLD")) {
					// buffer = case_reports_cl.create_land_certificate_LEASEHOLD_provisional(
					// 		cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
					// 		cls_url_config.getSoftfile_location(),
					// 		case_number, job_number, files_pdf_jackets_p);
				} else if (cert_type.equals("COMPANY ASSIGNMENT")) {
					// buffer = case_reports_cl.create_land_certificate_COMPANY_ASSIGNMENT(cls_url_config.getWeb_service_url_ser(),
					// 		cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					// 		case_number, job_number,
					// 		files_pdf_jackets_p);
				} else if (cert_type.equals("COMPANY LEASEHOLD")) {
					// buffer = case_reports_cl.create_land_certificate_COMPANY_LEASEHOLD(cls_url_config.getWeb_service_url_ser(),
					// 		cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					// 		case_number, job_number,
					// 		files_pdf_jackets_p);
				} else if (cert_type.equals("FREEHOLD")) {
					// buffer = case_reports_cl.create_land_certificate_FREEHOLD(cls_url_config.getWeb_service_url_ser(),
					// 		cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					// 		case_number,
					// 		job_number, files_pdf_jackets_p);
				} else if (cert_type.equals("CASDASTRAL LEASE")) {
					// buffer = case_reports_cl.create_land_certificate_CASDASTRAL_LEASE(cls_url_config.getWeb_service_url_ser(),
					// 		cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					// 		case_number, job_number,
					// 		files_pdf_jackets_p);
				} else if (cert_type.equals("CASDASTRAL ASSIGNMENT")) {
					// buffer = case_reports_cl.create_land_certificate_CASDASTRAL_ASSIGNMENT(
					// 		cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
					// 		cls_url_config.getSoftfile_location(),
					// 		case_number, job_number,
					// 		files_pdf_jackets_p);
				} else if (cert_type.equals("CASDASTRAL FREEHOLD")) {
					// buffer = case_reports_cl.create_land_certificate_CASDASTRAL_FREEHOLD(cls_url_config.getWeb_service_url_ser(),
					// 		cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					// 		case_number, job_number,
					// 		files_pdf_jackets_p);
				}

			
			}
			// File pdfFile = new File(contextPath + pdfFileName);
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		//byte[] buffer = null;
			
	// 	JSONObject pdf_upload_obj = new JSONObject();
	// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);


	// 	pdf_upload_obj.put("jobNumber", job_number);
	// 	pdf_upload_obj.put("caseNumber",case_number);
	// 	pdf_upload_obj.put("fileData",base64Encoded);
					
		
	// 	pdf_upload_obj.put("doc_name",job_number);
	// 	pdf_upload_obj.put("doc_description","Service Bill");
	// 	pdf_upload_obj.put("doc_category","public_docs");
	// 	pdf_upload_obj.put("doc_app_uploaded","elis");
	// 	pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
			
	

	//  String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	//  cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_certificate")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String cert_type = request.getParameter("cert_type");
			String registration_district_number = request.getParameter("registration_district_number");
			String registration_section_number = request.getParameter("registration_section_number");
			String type_of_certificate = request.getParameter("type_of_certificate");
			// String case_number = request.getParameter("case_number");
			// String job_number = request.getParameter("job_number");
			String transaction_number = request.getParameter("transaction_number");
			String business_process_sub_name = request.getParameter("ir_business_process_sub_name");
			String notes = request.getParameter("notes");

			String designation = (String) session.getAttribute("designation");


			
			System.out.println(cert_type);
			//System.out.println(case_number);
			//System.out.println(job_number);
			//System.out.println(transaction_number);


			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_certificate" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		// System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {

				// cls_case_m.select_generate_cert_volume_folio_number(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),cls_url_config.getSoftfile_location(),case_number,registration_district_number,registration_section_number);

				if (cert_type.equals("ASSIGNMENT")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					
					transaction_number, job_number, type_of_certificate,
					files_pdf_jackets_p);
				} else if (cert_type.equals("LEASEHOLD")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							
							transaction_number, job_number, type_of_certificate,
							files_pdf_jackets_p);
				} else if (cert_type.equals("COMPANY ASSIGNMENT")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						
							transaction_number, job_number, type_of_certificate,
							files_pdf_jackets_p);
				} else if (cert_type.equals("COMPANY LEASEHOLD")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					
					transaction_number, job_number, type_of_certificate,
					files_pdf_jackets_p);
				} else if (cert_type.equals("FREEHOLD")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					
					transaction_number, job_number, type_of_certificate,
					files_pdf_jackets_p);
				} else if (cert_type.equals("CASDASTRAL LEASE")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					
					transaction_number, job_number, type_of_certificate,
					files_pdf_jackets_p);
				} else if (cert_type.equals("CASDASTRAL ASSIGNMENT")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					
					transaction_number, job_number, type_of_certificate,
					files_pdf_jackets_p);
				} else if (cert_type.equals("CASDASTRAL FREEHOLD")) {
					buffer = case_reports_cl.create_land_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					
					transaction_number, job_number, type_of_certificate,
					files_pdf_jackets_p);
				} else if (cert_type.equals("CONCURRENCE")) {
					buffer = case_reports_cl.create_concurrence_certificate_typed(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
					
					transaction_number, job_number, type_of_certificate,
					files_pdf_jackets_p);
				}else if (cert_type.equals("CERTIFICATE_FOR_REGISTRATION_OF_INSTRUMENT")) {
				buffer = case_reports_cl.create_deeds_certificate_typed(cls_url_config.getWeb_service_url_ser(),
				cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
				
				transaction_number, job_number, type_of_certificate,
				files_pdf_jackets_p);
			}

				

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Land Certificate");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}
		

		if (request_type.equals("request_to_generate_discharge_memo")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_MEMO" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {
				// buffer = case_reports_cl.create_primeval_report(case_nuiimber,
				// files_pdf_jackets_p);
				buffer = case_reports_cl.create_generate_discharge_memo_for_certificate(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number,
						job_number,
						session.getAttribute("fullname").toString(), files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);

		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Memo Certificate");
		pdf_upload_obj.put("doc_category","ELIS Support Docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_memo")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_MEMO" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {
				// buffer = case_reports_cl.create_primeval_report(case_nuiimber,
				// files_pdf_jackets_p);
				buffer = case_reports_cl.create_generate_memo_for_certificate(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						case_number,
						job_number,
						session.getAttribute("fullname").toString(), files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);

		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Memo Certificate");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_pink")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_certificate" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {
				// buffer = case_reports_cl.create_land_certificate_ASSIGNMENT(cls_url_config.getWeb_service_url_ser(),
				// 		cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
				// 		case_number,
				// 		job_number, files_pdf_jackets_p);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // File pdfFile = new File(contextPath + pdfFileName);

		//byte[] buffer = null;
			
	// 	JSONObject pdf_upload_obj = new JSONObject();
	// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);


	// 	pdf_upload_obj.put("jobNumber", job_number);
	// 	pdf_upload_obj.put("caseNumber",case_number);
	// 	pdf_upload_obj.put("fileData",base64Encoded);
					
	
	// 	pdf_upload_obj.put("doc_name",job_number);
	// 	pdf_upload_obj.put("doc_description","Concurrenceertificate");
	// 	pdf_upload_obj.put("doc_category","public_docs");
	// 	pdf_upload_obj.put("doc_app_uploaded","elis");
	// 	pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	//  String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	//  cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}
		if (request_type.equals("request_to_generate_batch_list_bulk_correction")) {

			String list_of_application = request.getParameter("list_of_application");
			String batch_number = request.getParameter("batch_number");
			// String user_to_batch_to =
			// request.getParameter("user_to_batch_to");

			String batching_officer = (String) session.getAttribute("fullname");

			String contextPath = cls_url_config.getBatching_files_location(); // "C:\\elis\\documents\\batchlist\\";
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";

			String pdfFileName = batch_number + "_bulk_collection_list" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath);
			String files_pdf_jackets_p = contextPath + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {
				buffer = case_reports_cl.create_batch_list_bulk_collection_slip(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						list_of_application,
						batch_number, batching_officer,
						files_pdf_jackets_p);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
		pdf_upload_obj.put("jobNumber", batch_number);
		pdf_upload_obj.put("caseNumber",batch_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",batch_number);
		pdf_upload_obj.put("doc_description","Batch List");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}
		if (request_type.equals("request_to_generate_batch_list")) {

			String list_of_application = request.getParameter("list_of_application");
			String batch_number = request.getParameter("batch_number");
			// String user_to_batch_to =
			// request.getParameter("user_to_batch_to");
			String modified_by = request.getParameter("send_to_name");
			String batching_officer = (String) session.getAttribute("fullname");

			System.out.println(list_of_application);

			String contextPath = cls_url_config.getBatching_files_location(); // "C:\\elis\\documents\\batchlist\\";
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";

			String pdfFileName = batch_number + "_batch_list" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath);
			String files_pdf_jackets_p = contextPath + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {
				buffer = case_reports_cl.create_batch_list(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						list_of_application,
						batch_number, batching_officer, modified_by,
						files_pdf_jackets_p);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
		pdf_upload_obj.put("jobNumber", batch_number);
		pdf_upload_obj.put("caseNumber",batch_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
		
		pdf_upload_obj.put("doc_name",batch_number);
		pdf_upload_obj.put("doc_description","Batch List");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
			
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}
		if (request_type.equals("request_to_generate_file_list")) {

			String list_of_application = request.getParameter("list_of_application");
			String batch_number = request.getParameter("batch_number");
			// String user_to_batch_to =
			// request.getParameter("user_to_batch_to");
			String modified_by = request.getParameter("send_to_name");
			String batching_officer = (String) session.getAttribute("fullname");

			System.out.println(list_of_application);

			String contextPath = cls_url_config.getBatching_files_location(); // "C:\\elis\\documents\\batchlist\\";
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";

			String pdfFileName = batch_number + "_batch_list" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath);
			String files_pdf_jackets_p = contextPath + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			//}
			try {
				buffer = case_reports_cl.create_file_list(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						list_of_application,
						batch_number, batching_officer, modified_by,
						files_pdf_jackets_p);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


		pdf_upload_obj.put("jobNumber", batch_number);
		pdf_upload_obj.put("caseNumber",batch_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",batch_number);
		pdf_upload_obj.put("doc_description","Batch List");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_request_list")) {

			String list_of_application = request.getParameter("list_of_application");
			String batch_number = request.getParameter("batch_number");
			// String user_to_batch_to =
			// request.getParameter("user_to_batch_to");
			String modified_by = request.getParameter("send_to_name");
			String batching_officer = (String) session.getAttribute("fullname");

			System.out.println(list_of_application);

			String contextPath = cls_url_config.getBatching_files_location(); // "C:\\elis\\documents\\batchlist\\";
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";

			String pdfFileName = batch_number + "_batch_list" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath);
			String files_pdf_jackets_p = contextPath + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {
				buffer = case_reports_cl.create_request_list(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						list_of_application,
						batch_number, batching_officer, modified_by,
						files_pdf_jackets_p);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


		pdf_upload_obj.put("jobNumber", batch_number);
		pdf_upload_obj.put("caseNumber",batch_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	
		pdf_upload_obj.put("doc_name",batch_number);
		pdf_upload_obj.put("doc_description","Batch List");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_publication_list")) {

			String publication_list = request.getParameter("publication_list");
			String to_email_address = request.getParameter("to_email_address");
			String batching_officer = (String) session.getAttribute("fullname");

			// System.out.println(list_of_application);

			String contextPath = cls_url_config.getPublicaton_files_location(); // "C:\\elis\\documents\\batchlist\\";

			String pdfFileName = "Publicationlist_to_" + to_email_address + "_on_" + timeStamp + ".pdf";

			File pdfFile = new File(contextPath + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath);
			String files_pdf_jackets_p = contextPath + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {
				buffer = case_reports_cl.create_publication_list(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						publication_list,
						to_email_address, batching_officer,
						files_pdf_jackets_p);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
		pdf_upload_obj.put("jobNumber", to_email_address);
		pdf_upload_obj.put("caseNumber",to_email_address);
		pdf_upload_obj.put("fileData",base64Encoded);
					
	   
		pdf_upload_obj.put("doc_name",to_email_address);
		pdf_upload_obj.put("doc_description","Publication List");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}
		if (request_type.equals("request_to_generate_special_publication")) {

			String publication_list = request.getParameter("publication_list");
			String to_email_address = request.getParameter("to_email_address");
			String batching_officer = (String) session.getAttribute("fullname");

			String contextPath = cls_url_config.getPublicaton_files_location(); // "C:\\elis\\documents\\batchlist\\";

			String pdfFileName = "Special_Publicationlist_to_" + to_email_address + "_on_" + timeStamp + ".pdf";

			File pdfFile = new File(contextPath + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath);
			String files_pdf_jackets_p = contextPath + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {
				buffer = case_reports_cl.create_special_publication_list(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						publication_list,
						to_email_address, batching_officer,
						files_pdf_jackets_p);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);


	
		pdf_upload_obj.put("jobNumber", to_email_address);
		pdf_upload_obj.put("caseNumber",to_email_address);
		pdf_upload_obj.put("fileData",base64Encoded);
					
		
		pdf_upload_obj.put("doc_name",to_email_address);
		pdf_upload_obj.put("doc_description","Publication List");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
			
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_special_publication_on_case")) {

			String publication_list = request.getParameter("publication_list");
			String to_email_address = request.getParameter("to_email_address");
			String case_number = request.getParameter("case_number");
			// String user_to_batch_to =
			// request.getParameter("user_to_batch_to");
			// String modified_by = request.getParameter("send_to_name");
			// System.out.println("Testing List : " +
			// request.getParameter("publication_list"));
			// System.out.println("Testing eMAIL TO : " + to_email_address);
			String batching_officer = (String) session.getAttribute("fullname");

			// System.out.println(list_of_application);

			String contextPath = cls_url_config.getPublic_docs_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";

			String pdfFileName = "Special_Publicationlist_requested_on_" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";
			// String contextPath =
			// getServletContext().getRealPath(File.separator);

			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }
			try {
				buffer = case_reports_cl.create_special_publication_list(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						publication_list,
						to_email_address, batching_officer,
						files_pdf_jackets_p);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		//byte[] buffer = null;
			
	// 	JSONObject pdf_upload_obj = new JSONObject();
	// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
	// 	pdf_upload_obj.put("jobNumber", to_email_address);
	// 	pdf_upload_obj.put("caseNumber",case_number);
	// 	pdf_upload_obj.put("fileData",base64Encoded);
					
	
	// 	pdf_upload_obj.put("doc_name","Punlication List");
	// 	pdf_upload_obj.put("doc_description","Service Bill");
	// 	pdf_upload_obj.put("doc_category","public_docs");
	// 	pdf_upload_obj.put("doc_app_uploaded","elis");
	// 	pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
	// 	pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
	

	//  String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	//  cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_generate_query_letter")) {

			String case_number = request.getParameter("case_number");
			String transaction_number = request.getParameter("transaction_number");
			String job_number = request.getParameter("job_number");
			String ir_business_process_sub_name = request.getParameter("ir_business_process_sub_name");

			System.out.println(ir_business_process_sub_name);
			System.out.println(request_type);

			String contextPath = cls_url_config.getPublic_docs_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_query_letter" + timeStamp + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);
			File files_pdf_jackets = new File(contextPath + case_number);
			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			try {
				buffer = case_reports_cl.create_query_letter(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
						transaction_number,
						job_number, ir_business_process_sub_name,
						session.getAttribute("fullname").toString(), files_pdf_jackets_p);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// File pdfFile = new File(contextPath + pdfFileName);
		//byte[] buffer = null;
			
		JSONObject pdf_upload_obj = new JSONObject();
		String base64Encoded = Base64.getEncoder().encodeToString(buffer);

	
		pdf_upload_obj.put("jobNumber", job_number);
		pdf_upload_obj.put("caseNumber",case_number);
		pdf_upload_obj.put("fileData",base64Encoded);
					
		
		pdf_upload_obj.put("doc_name",job_number);
		pdf_upload_obj.put("doc_description","Letters");
		pdf_upload_obj.put("doc_category","case_docs");
		pdf_upload_obj.put("doc_app_uploaded","elis");
		pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
		pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
		pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
		
			
	

	 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
	 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

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
		}

		if (request_type.equals("request_to_compose_certificate_template")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String cert_type = request.getParameter("cert_type");
			String notes = request.getParameter("notes");

			String business_process_sub_name = request.getParameter("business_process_sub_name");
			// String registration_section_number =
			// request.getParameter("registration_section_number");

			String cert_template = "";
			try {
				if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (WHOLE SITE)")) {

					cert_template =  case_reports_cl.create_consent_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);

				} else if (business_process_sub_name
						.equals("APPLICATION FOR CONSENT TO ASSIGN OR SUBLET (PORTION OR PART)")) {
					cert_template =  case_reports_cl.create_consent_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONCURRENCE")) {
					cert_template =  case_reports_cl.create_concurrence_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO ASSIGN (JUDICIAL SALE)")) {
					cert_template =  case_reports_cl.create_consent_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO MORTGAGE")) {
					cert_template =  case_reports_cl.create_consent_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR CONSENT TO VEST (VESTING ASSENT)")) {
					cert_template =  case_reports_cl.create_consent_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR REGULARIZATION")) {
					cert_template =  case_reports_cl.create_consent_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR LEASE")) {
					cert_template =  case_reports_cl.create_consent_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR FIRST REGISTRATION")) {
					cert_template = case_reports_cl.create_land_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR PART TRANSFER")) {
					cert_template =  case_reports_cl.create_land_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
						} else if (business_process_sub_name.equals("APPLICATION FOR WHOLE TRANSFER")) {
							cert_template =  case_reports_cl.create_land_certificate_template(
									cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
									cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION")) {
					cert_template =  case_reports_cl.create_deeds_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION ON FAMILY LAND")) {
					cert_template =  case_reports_cl.create_deeds_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION WITH CONSENT")) {
					cert_template =  case_reports_cl.create_deeds_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR DEED REGISTRATION WITH CONCURRENCE")) {
					if (cert_type.equals("concurrence_certificate")) {
						cert_template = case_reports_cl.create_concurrence_certificate_template(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
								case_number, job_number);
					} else {
						cert_template =  case_reports_cl.create_deeds_certificate_template(
								cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
								case_number, job_number);
					}
				} else if (business_process_sub_name.equals("APPLICATION FOR WHOLE TRANFER")) {
					cert_template = case_reports_cl.create_land_certificate_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR LRD CERTIFICATE SEARCH")) {
					// cert_template += "Description of Land:\r\n";
					// cert_template += "Proprietor:\r\n";
					// cert_template += "Date of Registration:\r\n";
					// cert_template += "Nature of Instrument:\r\n";
					// cert_template += "Certificate Number:\r\n";
					// cert_template += "Encumbrance:\r\n";
					// cert_template += "Registered Number:\r\n";
					cert_template =  case_reports_cl.create_certificate_search_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);
				} else if (business_process_sub_name.equals("APPLICATION FOR CERTIFICATE SEARCH")) {
					// cert_template += "Description of Land:\r\n";
					// cert_template += "Proprietor:\r\n";
					// cert_template += "Date of Registration:\r\n";
					// cert_template += "Nature of Instrument:\r\n";
					// cert_template += "Certificate Number:\r\n";
					// cert_template += "Encumbrance:\r\n";
					// cert_template += "Registered Number:\r\n";

					cert_template =  case_reports_cl.create_certificate_search_template(
							cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
							cls_url_config.getSoftfile_location(), case_number, job_number);

				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// out.println(cert_template);

			return cert_template;

		}

		if (request_type.equals("request_to_compose_register_description")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String cert_type = request.getParameter("cert_type");
			String notes = request.getParameter("notes");

			String business_process_sub_name = request.getParameter("business_process_sub_name");
			// String registration_section_number =
			// request.getParameter("registration_section_number");

			String cert_template = "";

			try {

				cert_template =case_reports_cl.create_land_register_description_of_land(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						cls_url_config.getSoftfile_location(), case_number, job_number);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// out.println(cert_template);
			return cert_template;
		}

		if (request_type.equals("request_to_letter_template")) {

			String case_number = request.getParameter("case_number");
			String job_number = request.getParameter("job_number");
			String type_of_letter = request.getParameter("type_of_letter");

			String cert_template = "";
			try {
				if (type_of_letter.equals("Inspection Letter")) {

					cert_template = case_reports_cl.create_inspection_template(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number, job_number);

				} else if (type_of_letter.equals("Physical Planning Letter")) {
					cert_template =  case_reports_cl.create_inspection_template(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number, job_number);

				} else if (type_of_letter.equals("APPLICATION FOR WHOLE TRANFER")) {
					cert_template =   case_reports_cl.create_inspection_template(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
							case_number, job_number);
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// out.println(cert_template);
			return cert_template;

		}
		return timeStamp;

	}
}
