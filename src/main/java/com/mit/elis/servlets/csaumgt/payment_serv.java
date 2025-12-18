package com.mit.elis.servlets.csaumgt;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.CSAU_billgeneration;
import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import ws.csaumgt.ws_csaupayment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class payment_serv {
	Ws_client_application casemgt_cl = new Ws_client_application();
	CSAU_billgeneration billgeneration_cl = new CSAU_billgeneration();

	@Autowired
	private Ws_url_config cls_url_config;
	ws_csaupayment csaupayment_cl = new ws_csaupayment();

	@RequestMapping("/payment_serv")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
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
			String request_type = request.getParameter("request_type");

			String web_service_response = null;

			// System.out.println(request_type);

			if (request_type.equals("generate_payment_payment_checkout")) {

				String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());

				String totalAmount = request.getParameter("totalAmount");
				String description = request.getParameter("description");
				String merchantAccountNumber = request.getParameter("merchantAccountNumber");

				String callbackUrl = "cls_url_config.getPayment_callbackUrl()";
				String cancellationUrl = "cls_url_config.getPayment_cancellationUrl()";
				String returnUrl = "cls_url_config.getPayment_returnUrl()";
				String clientReference = request.getParameter("clientReference");

				clientReference = clientReference + "_" + timeStamp;

				JSONObject obj = new JSONObject();

				obj.put("totalAmount", totalAmount);
				obj.put("description", description);
				obj.put("merchantAccountNumber", merchantAccountNumber);
				obj.put("callbackUrl", callbackUrl);
				obj.put("cancellationUrl", cancellationUrl);
				obj.put("returnUrl", returnUrl);
				obj.put("clientReference", clientReference);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());
				web_service_response = csaupayment_cl
						.generate_payment_payment_checkout(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
				/*
				 * 
				 * return web_service_response;
				 */

				return web_service_response;
			}


			if (request_type.equals("load_bill_by_ref_or_gog")) {
				String search_by = request.getParameter("search_by");
				String search_value = request.getParameter("search_value");
				JSONObject obj_d = new JSONObject();
				obj_d.put("search_by", search_by);
				obj_d.put("search_value", search_value);
				web_service_response = csaupayment_cl.select_load_bill_by_ref_or_gog(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
				return web_service_response;
			}


			if (request_type.equals("check_gog_for_payment_by_ref_or_gog")) {
				String search_by = request.getParameter("search_by");
				String invoice_number = request.getParameter("invoice_number");
				String ref_number = request.getParameter("ref_number");
				JSONObject obj_d = new JSONObject();
				obj_d.put("search_by", search_by);
				obj_d.put("search_value", invoice_number);
				obj_d.put("invoice_number", invoice_number);
				obj_d.put("ref_number", ref_number);
				web_service_response = csaupayment_cl.check_gog_for_payment_by_ref_or_gog(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
				return web_service_response;
			}

			if (request_type.equals("lc_payment_verification_for_name_change_")) {
				String ref_number = request.getParameter("ref_number");
				JSONObject obj_d = new JSONObject();
				obj_d.put("ref_number", ref_number);
				web_service_response = csaupayment_cl.lc_payment_verification_for_name_change(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}
				return web_service_response;
			}



			if (request_type.equals("lc_payment_verification_for_bill")) {
				String ref_number = request.getParameter("ref_number");
				// System.out.println(ref_number);

				JSONObject obj_d = new JSONObject();
				obj_d.put("ref_number", ref_number);

				web_service_response = csaupayment_cl
						.lc_payment_verification_for_bill(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("lc_payment_verification_for_name_change")) {
				String ref_number = request.getParameter("ref_number");
				// System.out.println(ref_number);

				JSONObject obj_d = new JSONObject();
				obj_d.put("ref_number", ref_number);

				web_service_response = csaupayment_cl.lc_payment_verification_for_name_change(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("lc_payment_verification_for_bill_revised")) {
				String ref_number = request.getParameter("ref_number");
				// System.out.println(ref_number);

				JSONObject obj_d = new JSONObject();
				obj_d.put("ref_number", ref_number);

				web_service_response = csaupayment_cl.lc_payment_verification_for_bill_revised(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("lc_payment_verification_for_bill_stamping")) {
				String ref_number = request.getParameter("ref_number");
				// System.out.println(ref_number);

				JSONObject obj_d = new JSONObject();
				obj_d.put("ref_number", ref_number);

				web_service_response = csaupayment_cl.lc_payment_verification_for_bill_stamping(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("load_bill_for_payment_individual")) {
				String bill_number = request.getParameter("bill_number");
				// System.out.println(bill_number);

				JSONObject obj_d = new JSONObject();
				obj_d.put("bill_number", bill_number);

				web_service_response = csaupayment_cl
						.load_bill_for_payment_individual(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_d.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}

			if (request_type.equals("load_bill_for_payment_individual_old")) {
				String job_number = request.getParameter("job_number");
				// System.out.println(job_number);

				JSONObject obj_d = new JSONObject();
				obj_d.put("job_number", job_number);

				web_service_response = csaupayment_cl.load_bill_for_payment_individual_old_system(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj_d.toString());

				if (web_service_response != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				return web_service_response;

			}
			if (request_type.equals("generate_egcr")) {
				String ref_number = request.getParameter("ref_number");
				String receipt_number = request.getParameter("receipt_number");
				// System.out.println(ref_number);
				// System.out.println(receipt_number);
				/*
				 * JSONObject obj_d = new JSONObject(); obj_d.put("ref_number",
				 * ref_number); obj_d.put("receipt_number", ref_number);
				 */

				if (receipt_number.length() > 4) {
					String pdf_dest = cls_url_config.getCase_upload_location() + "egcr\\";
					// String pdf_dest =
					// Ws_url_config.get_case_upload_location() + "egcr\\";

					String files_pdf_jackets_p = pdf_dest + receipt_number + ".pdf";

					File files_pdf_jackets = new File(pdf_dest);

					// if (!files_pdf_jackets.exists()) {
					// 	if (files_pdf_jackets.mkdirs()) {
					// 		// System.out.println("Multiple directories are
					// 		// created!");
					// 	} else {
					// 		// System.out.println("Failed to create multiple
					// 		// directories!");
					// 	}
					// }

					// System.out.println("EGCR number : " + receipt_number);

					InputStream pdf_blob = billgeneration_cl.generate_egcr_get_pdf(cls_url_config.getEgcr_url(),
							cls_url_config.getEgcr_apikey(), receipt_number);

					try {
						/*
						 * FileOutputStream fos = new
						 * FileOutputStream(files_pdf_jackets_p);
						 * BufferedOutputStream outputStream = new
						 * BufferedOutputStream(fos);
						 * outputStream.write(fileBytes); outputStream.close();
						 */
						File targetFile = new File(files_pdf_jackets_p);
						FileOutputStream output = new FileOutputStream(targetFile);
						// InputStream input = pdf_blob;
						// InputStream input = pdf_blob.get();
						// byte[] buffer = new byte[(int)file.length()];
						byte[] buffer = new byte[1024];
						// byte[] buffer = new byte[8192];
						int len;
						/*
						 * while (pdf_blob.read(buffer) != -1) {
						 * output.write(buffer); }
						 */

						while ((len = pdf_blob.read(buffer)) != -1) {
							output.write(buffer, 0, len);
						}

						// System.out.println("File downloaded: " +
						// files_pdf_jackets_p);
					} catch (IOException ex) {
						System.err.println(ex);
					}

					File file = new File(files_pdf_jackets_p);
					// ResponseBuilder response = Response.ok((Object) file);
					// response.type("application/pdf");
					// response.header("Content-Disposition", "attachment;
					// filename=bill_for_payment.pdf");
					// return response.build();
				} else {
					// ResponseBuilder response = Response.noContent();
					// response.type("application/pdf");
					// response.header("Content-Disposition", "attachment;
					// filename=bill_for_payment.pdf");
					// return response.build();
				}

				// web_service_response =
				// csaupayment_cl.generate_egcr(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj_d.toString());

				/*
				 * if (web_service_response != null) {
				 * System.out.println(web_service_response); } else {
				 * System.out.println(web_service_response); } PrintWriter out =
				 * response.getWriter(); return web_service_response;
				 */

			}
			if (request_type.equals("capture_manual_bill_payment")) {

				String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());

				String client_name = request.getParameter("client_name");

				String bill_number = request.getParameter("bill_number");
				String payment_slip_number = request.getParameter("payment_slip_number");
				String payment_remarks = request.getParameter("payment_remarks");
				String payment_mode = request.getParameter("payment_mode");
				String payment_bank = request.getParameter("payment_bank");
				String payment_bank_branch = request.getParameter("payment_bank_branch");

				String payment_amount = request.getParameter("payment_amount");
				String assessed_amount = request.getParameter("assessed_amount");

				JSONObject obj = new JSONObject();

				obj.put("client_name", client_name);
				obj.put("assessed_amount", assessed_amount);
				obj.put("bill_number", bill_number);
				obj.put("payment_slip_number", payment_slip_number);
				obj.put("payment_remarks", payment_remarks);
				obj.put("payment_mode", payment_mode);
				obj.put("payment_bank", payment_bank);
				obj.put("payment_bank_branch", payment_bank_branch);
				obj.put("payment_amount", payment_amount);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());
				web_service_response = csaupayment_cl.lc_payment_confirmation_for_bill_individual(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);

					String pdfFileName = "bill_payment_capture.pdf";

					JSONObject jsonobject = new JSONObject(web_service_response);
					// String ws_bill_number = jsonobject.getString("unique");
					// String ws_bill_details_db=general_all
					// case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
					// String ws_bill_details_db=
					// case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

					// System.out.println(bill_number);

					// String pdf_dest = "C:\\gelisdocs\\billspdf\\";

					String pdf_dest = cls_url_config.getTempfile_location();
					String files_pdf_jackets_p = pdf_dest + bill_number + "_" + pdfFileName;
					/*
					 * String files_pdf_jackets_p = pdf_dest + ws_case_number +
					 * "\\" + service_bill_descdription_formated + "_" +
					 * job_number + pdfFileName;
					 */
					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.capture_manual_bill_payment(cls_url_config.getSoftfile_location(),
							input_details, web_service_response,
							session.getAttribute("fullname").toString(), files_pdf_jackets_p);



				// 	JSONObject pdf_upload_obj = new JSONObject();
				// 	String base64Encoded = Base64.getEncoder().encodeToString(buffer);
			
				// pdf_upload_obj.put("jobNumber", bill_number);
				// pdf_upload_obj.put("caseNumber",bill_number);
				// pdf_upload_obj.put("fileData",base64Encoded);
							
				
			
 				// String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
 				// cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

					// System.out.println(files_pdf_jackets_p);
					// File pdfFile = new File(files_pdf_jackets_p);
					// byte[] buffer = null;

					// // String pdfFilename = "test.pdf"; // I use id here to
					// // determine pdf
					// // File f = new File(pdfFilename);

					// BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
					// ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

					// int ch;
					// long actual = 0;
					// while ((ch = is.read()) != -1) {
					// 	bos.write(ch);
					// 	actual++;
					// }
					// bos.flush();
					// bos.close();
					// buffer = bos.toByteArray();

					// response.setContentType("application/pdf");
					// response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
					// // response.addHeader("Content-Disposition", "inline;
					// // filename=Documentation.pdf");
					// response.setContentLength((int) pdfFile.length());
					// response.getOutputStream().write(buffer, 0, buffer.length);

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
				/*
				 * 
				 * return web_service_response;
				 */
			}

			if (request_type.equals("lc_payment_confirmation_for_bill_individual")) {

				String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());

				String client_name = request.getParameter("client_name");

				String bill_number = request.getParameter("bill_number");
				String payment_slip_number = request.getParameter("payment_slip_number");
				String payment_remarks = request.getParameter("payment_remarks");
				String payment_mode = request.getParameter("payment_mode");
				String payment_bank = request.getParameter("payment_bank");
				String payment_bank_branch = request.getParameter("payment_bank_branch");

				String payment_amount = request.getParameter("payment_amount");
				String assessed_amount = request.getParameter("assessed_amount");

				JSONObject obj = new JSONObject();

				obj.put("client_name", client_name);
				obj.put("assessed_amount", assessed_amount);
				obj.put("bill_number", bill_number);
				obj.put("payment_slip_number", payment_slip_number);
				obj.put("payment_remarks", payment_remarks);
				obj.put("payment_mode", payment_mode);
				obj.put("payment_bank", payment_bank);
				obj.put("payment_bank_branch", payment_bank_branch);
				obj.put("payment_amount", payment_amount);

				String input_details = obj.toString();

				// String wkt_polgon_wgs84 =
				// request.getParameter("wkt_polgon_wgs84");

				// System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());
				web_service_response = csaupayment_cl.lc_payment_confirmation_for_bill_individual(
						cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
						obj.toString());
				if (web_service_response != null) {
					// System.out.println(web_service_response);

					String pdfFileName = "bill_gra.pdf";

					JSONObject jsonobject = new JSONObject(web_service_response);
					// String ws_bill_number = jsonobject.getString("unique");
					// String ws_bill_details_db=general_all
					// case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
					// String ws_bill_details_db=
					// case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

					// System.out.println(bill_number);

					// String pdf_dest = "C:\\gelisdocs\\billspdf\\";

					String pdf_dest = cls_url_config.getTempfile_location();
					String files_pdf_jackets_p = pdf_dest + "gra_" + bill_number + pdfFileName;
					/*
					 * String files_pdf_jackets_p = pdf_dest + ws_case_number +
					 * "\\" + service_bill_descdription_formated + "_" +
					 * job_number + pdfFileName;
					 */
					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_service_bill_stamp_duty(
							cls_url_config.getSoftfile_location(), input_details,
							web_service_response, session.getAttribute("fullname").toString(), files_pdf_jackets_p);

					// System.out.println(files_pdf_jackets_p);
					// File pdfFile = new File(files_pdf_jackets_p);
					// byte[] buffer = null;

					// // String pdfFilename = "test.pdf"; // I use id here to
					// // determine pdf
					// // File f = new File(pdfFilename);

					// BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
					// ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

					// int ch;
					// long actual = 0;
					// while ((ch = is.read()) != -1) {
					// 	bos.write(ch);
					// 	actual++;
					// }
					// bos.flush();
					// bos.close();
					// buffer = bos.toByteArray();

					// response.setContentType("application/pdf");
					// response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
					// // response.addHeader("Content-Disposition", "inline;
					// // filename=Documentation.pdf");
					// response.setContentLength((int) pdfFile.length());
					// response.getOutputStream().write(buffer, 0, buffer.length);

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
				/*
				 * 
				 * return web_service_response;
				 */
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
