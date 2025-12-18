package com.mit.elis.servlets.cica;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import org.springframework.ui.Model;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.codec.multipart.Part;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.mit.elis.class_common.Ws_url_config;

import ws.casemgt.cls_casemgt;
import ws.cica.cica_docs;
import ws.cica.ws_cica;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		maxFileSize = 1024 * 1024 * 10, // 10 MB
		maxRequestSize = 1024 * 1024 * 15 // 15 MB
)

@RestController
public class CicaServlet {

	// cls_casemgt casemagt_cl = new cls_casemgt();
	ws_cica cls_cica = new ws_cica();
	cica_docs cls_cica_docs = new cica_docs();

	@Autowired
	private Ws_url_config cls_url_config;

	ServletRequest servletContext;

	@RequestMapping("/cica_complaints_serv")
	@PostMapping
	public String cica_complaints_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");
			JSONObject obj = new JSONObject();

			String web_service_response = null;

			if (request_type.equals("load_complaints")) {

				String status = request.getParameter("status");

				obj.put("status", status);
				obj.put("type", "complaints");

				web_service_response = cls_cica.load_complaints(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
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

	@RequestMapping("/cica_dashboard_serv")
	@PostMapping
	public String cica_dashboard_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");
			JSONObject obj = new JSONObject();

			String web_service_response = null;

			if (request_type.equals("reports")) {

				String start_date = request.getParameter("start_date");
				String end_date = request.getParameter("end_date");
				String division = request.getParameter("division");
				String region = request.getParameter("region");
				String purpose = request.getParameter("purpose");
				String status = request.getParameter("status");

				obj.put("start_date", start_date);
				obj.put("end_date", end_date);
				obj.put("division", division);
				obj.put("region", region);
				obj.put("purpose", purpose);
				obj.put("status", status);

				web_service_response = cls_cica.load_reports(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
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

	@RequestMapping("/cica_enquiries_serv")
	@PostMapping
	public String cica_enquiries_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");
			JSONObject obj = new JSONObject();

			String web_service_response = null;

			if (request_type.equals("load_enquires")) {

				String status = request.getParameter("status");

				obj.put("status", status);
				obj.put("type", "enquiry");

				web_service_response = cls_cica.load_complaints(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
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

	@RequestMapping("/cica_focal_person_serv")
	@PostMapping
	public String cica_focal_person_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response,
			HttpServletRequest servletRequest) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");
			JSONObject obj = new JSONObject();
			JSONObject obj_r = new JSONObject();

			String web_service_response = null;
			String web_response = null;


			String pdfFileName = "acknowledgeslip.pdf";

			if (request_type.equals("load_focal_person_tickets")) {

				String focal_foward = request.getParameter("focal_foward");
				String regional_code = (String) session.getAttribute("regional_code");
				String division = (String) session.getAttribute("division");

				obj.put("focal_foward", focal_foward);
				obj.put("regional_code", regional_code);
				obj.put("division", division);

				web_service_response = cls_cica.load_focal_person_tickets(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("reply_ticket")) {

				String ticket_id = request.getParameter("ticket_id");
				String replies = request.getParameter("replies");
				String type = request.getParameter("type");

				obj.put("id", ticket_id);
				obj.put("type", type);
				obj.put("replies", replies);

				web_service_response = cls_cica.reply_ticket(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("get_replies")) {

				String ticket_id = request.getParameter("id");
				String type = request.getParameter("type");

				obj.put("id", ticket_id);
				obj.put("type", type);

				web_service_response = cls_cica.get_ticket_replies(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("get_client_replies")) {

				String ticket_id = request.getParameter("id");

				obj.put("id", ticket_id);
				obj.put("type", "tickets");

				web_service_response = cls_cica.get_client_replies(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("client_reply")) {

				String ticket_id = request.getParameter("ticket_id");
				String replies = request.getParameter("replies");

				obj.put("id", ticket_id);
				obj.put("type", "tickets");
				obj.put("replies", replies);

				web_service_response = cls_cica.client_reply(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("status_update")) {

				String ticket_id = request.getParameter("ticket_id");
				String status_obj = request.getParameter("status_obj");
				String status = request.getParameter("status");
				String type = request.getParameter("type");

				obj.put("id", ticket_id);
				obj.put("type", type);
				obj.put("status_obj", status_obj);
				obj.put("status", status);

				web_service_response = cls_cica.status_update(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("search_archived")) {

				String type = request.getParameter("type");
				String search_value = request.getParameter("search_value");
				String search_type = request.getParameter("search_type");

				obj.put("type", type);
				obj.put("search_value", search_value);
				obj.put("search_type", search_type);

				web_service_response = cls_cica.search_archived(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_enquiry_service")) {

				String purpose = request.getParameter("purpose");
				String regional_code = request.getParameter("regional_code");

				obj.put("purpose", purpose);
				obj.put("regional_code", regional_code);

				web_service_response = cls_cica.load_enquiry_service(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("get_tickets_by_id")) {

				String list = request.getParameter("list");

				obj.put("list", list);

				web_service_response = cls_cica.get_tickets_by_id(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("get_tickets_by_id")) {

				String list = request.getParameter("list");

				obj.put("list", list);

				web_service_response = cls_cica.get_tickets_by_id(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_status_note")) {

				String ticket_no = request.getParameter("ticket_no");

				obj.put("ticket_no", ticket_no);

				web_service_response = cls_cica.load_status_note(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_ticket_replies")) {

				String ticket_no = request.getParameter("ticket_no");

				obj.put("ticket_no", ticket_no);

				web_service_response = cls_cica.load_ticket_replies(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("open_replied_doc")) {
				String attachment_path = request.getParameter("attachment_path").trim();
				String ticket_no = request.getParameter("ticket_no").trim();
				ticket_no = ticket_no.replace("/", "_");
				System.out.println(attachment_path);

				// File pdfFile = new
				// File("C:\\legal_docs\\batchlist\\batch_list_"+file_path+".pdf");
				// File pdfFile = new File(cls_url_config.getLegal_document_location() +
				// suit_number + "/" + file_path);
				File pdfFile = new File(attachment_path);
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

			if (request_type.equals("forward_tickets")) {

				String list = request.getParameter("list");

				System.out.println(list);

				web_service_response = cls_cica.forward_focal_tickets(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), list);

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("print_request")) {

				String ticket_no = request.getParameter("ticket_no");
				String subject = request.getParameter("subject");
				String description = request.getParameter("description");
				String requested_by = session.getAttribute("fullname").toString();
				String duc_request = request.getParameter("duc_request");
				String request_to = request.getParameter("request_to");
				String reference_id = request.getParameter("reference_no");

				obj.put("ticket_no", ticket_no);
				// obj.put("deadline",deadline);
				// obj.put("subject",subject);
				obj.put("description", duc_request);
				obj.put("replied_by", requested_by);
				// obj.put("duc_request",duc_request);
				obj.put("print_request", 1);

				// cls_suits.receive_cases(cls_url_config.getWeb_service_url_ser(),
				// cls_url_config.getWeb_service_url_ser_api_key(), list);

				String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
				// String files_pdf_jackets_p = cls_url_config.getLegal_batch_list_location() +
				// "batch_list" + "_" + timeStamp + ".pdf";

				String newpath = cls_url_config.getCica_request_form() + ticket_no;
				File filedir = new File(newpath);
				filedir.mkdir();

				String files_pdf_jackets_p = filedir + "/" + "request_slip" + "_" + timeStamp + ".pdf";

				//System.out.print(files_pdf_jackets_p);

				obj.put("location", files_pdf_jackets_p);

				web_response = cls_cica.reply_to_ticket(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = cls_cica_docs.create_print_request(
						cls_url_config.getSoftfile_location(),
						ticket_no, subject, description, requested_by, duc_request, request_to, reference_id,
						files_pdf_jackets_p, timeStamp,
						session.getAttribute("web_comp_address").toString(),
						session.getAttribute("web_city").toString(),
						session.getAttribute("web_telephone").toString(),
						session.getAttribute("web_fax_number").toString(),
						session.getAttribute("web_email").toString());


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


				if (web_response != null) {
					System.out.println(web_response);

				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error occurred");
				}

			}

			if (request_type.equals("open_request_pdf")) {
				String ticket_no = request.getParameter("ticket_no");
				String file_path = request.getParameter("file_path").trim();
				System.out.println(file_path);

				// File pdfFile = new
				// File("C:\\legal_docs\\batchlist\\batch_list_"+file_path+".pdf");
				File pdfFile = new File(cls_url_config.getCica_request_form() + ticket_no + "/" + "request_slip" + "_"
						+ file_path + ".pdf");
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

			if (request_type.equals("open_requested_pdf")) {
				String ticket_no = request.getParameter("ticket_no");
				String file_path = request.getParameter("file_path").trim();
				System.out.println(file_path);

				// File pdfFile = new
				// File("C:\\legal_docs\\batchlist\\batch_list_"+file_path+".pdf");
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

			return web_service_response;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("/cica_replies_serv")
	@PostMapping
	public String cica_replies_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");

			JSONObject obj = new JSONObject();
			JSONObject obj_r = new JSONObject();
			JSONObject obj_sms = new JSONObject();

			String web_service_response = null;
			String sms_response = null;

			if (request_type.equals("load_replies")) {

				String type = request.getParameter("type");

				obj.put("type", type);

				web_service_response = cls_cica.load_replies(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("get_replies")) {

				String ticket_id = request.getParameter("id");

				obj.put("id", ticket_id);
				obj.put("type", "unit");

				web_service_response = cls_cica.get_ticket_replies(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("client_reply")) {

				String ticket_id = request.getParameter("id");
				String replies = request.getParameter("replies");
				String type = request.getParameter("type");
				String receiver = request.getParameter("receiver");
				String name = request.getParameter("name");
				String message = request.getParameter("message");
				String phone = request.getParameter("phone");
				String date = request.getParameter("date");

				obj.put("id", ticket_id);
				obj.put("ticket_id", ticket_id);
				obj.put("type", type);
				obj.put("replies", replies);
				obj.put("receiver", receiver);
				obj.put("name", name);
				obj.put("message", message);
				obj.put("phone", phone);
				obj.put("date", date);

				// System.out.println(receiver);
				// System.out.println(message);
				// System.out.println(phone);
				// System.out.println(date);
				cls_cica.sendMail(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				obj_sms.put("msg", message);
				obj_sms.put("recipient", phone);
				// System.out.println(obj_sms);
				cls_cica.sendText(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				web_service_response = cls_cica.client_reply(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_unit_tickets")) {

				String regional_code = request.getParameter("regional_code");
				String unit_id = request.getParameter("unit_id");

				obj.put("region", regional_code);
				obj.put("unit", unit_id);

				web_service_response = cls_cica.load_unit_tickets(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("forward_tickets")) {

				String list = request.getParameter("list");

				System.out.println(list);

				web_service_response = cls_cica.archive_replies(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), list);

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("send_reply_to_client")) {

				String ticket_no = request.getParameter("ticket_no");
				String contact_by = request.getParameter("contact_by");
				String client_contact = request.getParameter("client_contact");
				String message = request.getParameter("message");
				String sent_by = request.getParameter("sent_by");

				if (contact_by.equals("SMS")) {

					client_contact = client_contact.replaceFirst("0", "233");

					obj_sms.put("recipient", client_contact);
					obj_sms.put("msg", message);

					// Cica.sendText(obj_sms);
					sms_response = cls_cica.send_single_sms(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());

					System.out.println(sms_response);

					obj.put("ticket_no", ticket_no);
					obj.put("contact_by", contact_by);
					obj.put("client_contact", client_contact);
					obj.put("message", message);
					obj.put("sent_by", sent_by);

					web_service_response = cls_cica.save_reply_message(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

					if (web_service_response != null) {
						System.out.println(web_service_response);
					} else {

						obj_r.put("success", false);
						obj_r.put("msg", "Error Getting Ticket Categories");
					}

				} else if (contact_by.equals("Email")) {

				}
			}

			return web_service_response;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("/cica_tickets_serv")
	@PostMapping
	public String cica_tickets_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response,
			HttpServletRequest servletRequest) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");
			JSONObject obj = new JSONObject();
			JSONObject obj_r = new JSONObject();

			String web_service_response = null;

			if (request_type.equals("load_tickets")) {

				String status = request.getParameter("status");
				String regional_code = request.getParameter("regional_code");

				obj.put("status", status);
				obj.put("type", "tickets");
				obj.put("regional_code", regional_code);

				web_service_response = cls_cica.load_tickets(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("reply_ticket")) {

				String ticket_id = request.getParameter("ticket_id");
				String replies = request.getParameter("replies");
				String type = request.getParameter("type");

				obj.put("id", ticket_id);
				obj.put("type", type);
				obj.put("replies", replies);

				web_service_response = cls_cica.reply_ticket(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("get_replies")) {

				String ticket_id = request.getParameter("id");
				String type = request.getParameter("type");

				obj.put("id", ticket_id);
				obj.put("type", type);

				web_service_response = cls_cica.get_ticket_replies(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("get_client_replies")) {

				String ticket_id = request.getParameter("id");

				obj.put("id", ticket_id);
				obj.put("type", "tickets");

				web_service_response = cls_cica.get_client_replies(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("client_reply")) {

				String ticket_id = request.getParameter("ticket_id");
				String replies = request.getParameter("replies");

				obj.put("id", ticket_id);
				obj.put("type", "tickets");
				obj.put("replies", replies);

				web_service_response = cls_cica.client_reply(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("status_update")) {

				String ticket_id = request.getParameter("ticket_id");
				String status_obj = request.getParameter("status_obj");
				String status = request.getParameter("status");
				String type = request.getParameter("type");

				obj.put("id", ticket_id);
				obj.put("type", type);
				obj.put("status_obj", status_obj);
				obj.put("status", status);

				web_service_response = cls_cica.status_update(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("search_archived")) {

				String type = request.getParameter("type");
				String search_value = request.getParameter("search_value");
				String search_type = request.getParameter("search_type");

				obj.put("type", type);
				obj.put("search_value", search_value);
				obj.put("search_type", search_type);

				web_service_response = cls_cica.search_archived(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_enquiry_service")) {

				String purpose = request.getParameter("purpose");
				String regional_code = request.getParameter("regional_code");

				obj.put("purpose", purpose);
				obj.put("regional_code", regional_code);

				web_service_response = cls_cica.load_enquiry_service(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("get_tickets_by_id")) {

				String list = request.getParameter("list");

				obj.put("list", list);

				web_service_response = cls_cica.get_tickets_by_id(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("forward_ticket")) {

				String ticket_id = request.getParameter("ticket_id");
				String region = request.getParameter("region");
				String unit = request.getParameter("unit");

				obj.put("ticket_id", ticket_id);
				obj.put("region", region);
				obj.put("unit", unit);

				web_service_response = cls_cica.forward_ticket(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("forward_ticket")) {

				String ticket_id = request.getParameter("ticket_id");
				String region = request.getParameter("region");
				String unit = request.getParameter("unit");

				obj.put("ticket_id", ticket_id);
				obj.put("region", region);
				obj.put("unit", unit);

				web_service_response = cls_cica.forward_ticket(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("update_ticket_status")) {

				String ticket_id = request.getParameter("ticket_id");
				String ticket_no = request.getParameter("ticket_no");
				String status_id = request.getParameter("status_id");
				String status_note = request.getParameter("status_note");
				String updated_by = request.getParameter("updated_by");
				String updated_by_id = request.getParameter("updated_by_id");
				String req_client_phone = request.getParameter("req_client_phone");

				obj.put("ticket_id", ticket_id);
				obj.put("ticket_no", ticket_no);
				obj.put("status_id", status_id);
				obj.put("status_note", status_note);
				obj.put("updated_by", updated_by);
				obj.put("updated_by_id", updated_by_id);
				obj.put("client_phone", req_client_phone);

				System.out.print(obj.toString());

				web_service_response = cls_cica.update_ticket_status(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				//if (status_id.equals("1")) {
				req_client_phone = req_client_phone.replaceFirst("0", "233");

				JSONObject obj_sms = new JSONObject();
				obj_sms.put("recipient", req_client_phone);
				obj_sms.put("msg", status_note);

				// Cica.sendText(obj_sms);
				cls_cica.send_single_sms(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());

				System.out.println(obj_sms.toString());
				//}

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_status_note")) {

				String ticket_no = request.getParameter("ticket_no");

				obj.put("ticket_no", ticket_no);

				web_service_response = cls_cica.load_status_note(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_ticket_replies")) {

				String ticket_no = request.getParameter("ticket_no");

				obj.put("ticket_no", ticket_no);

				web_service_response = cls_cica.load_ticket_replies(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_ticket_one_replies")) {

				String ticket_no = request.getParameter("ticket_no");

				obj.put("ticket_no", ticket_no);

				web_service_response = cls_cica.load_ticket_one_replies(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("open_replied_doc")) {
				String attachment_path = request.getParameter("attachment_path").trim();
				String ticket_no = request.getParameter("ticket_no").trim();
				ticket_no = ticket_no.replace("/", "_");
				System.out.println(attachment_path);

				// File pdfFile = new
				// File("C:\\legal_docs\\batchlist\\batch_list_"+file_path+".pdf");
				// File pdfFile = new File(cls_url_config.getLegal_document_location() +
				// suit_number + "/" + file_path);
				File pdfFile = new File(attachment_path);
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

			if (request_type.equals("forward_tickets")) {

				String list = request.getParameter("list");
				String region = request.getParameter("region");
				String division = request.getParameter("division");

				obj.put("list", list);
				obj.put("region", region);
				obj.put("division", division);

				System.out.print(obj.toString());

				web_service_response = cls_cica.forward_tickets(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("load_sms_messages")) {

				String ticket_no = request.getParameter("ticket_no");

				obj.put("ticket_no", ticket_no);

				web_service_response = cls_cica.load_sms_messages(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			if (request_type.equals("update_ticket_details")) {

				String ticket_no = request.getParameter("ticket_no");
				String purpose = request.getParameter("purpose");
				String subject = request.getParameter("subject");
				String description = request.getParameter("description");
				String related_service = request.getParameter("related_service");
				String reference_no = request.getParameter("reference_no");

				obj.put("ticket_no", ticket_no);
				obj.put("purpose", purpose);
				obj.put("subject", subject);
				obj.put("description", description);
				obj.put("related_service", related_service);
				obj.put("reference_no", reference_no);

				web_service_response = cls_cica.update_ticket_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
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

	@RequestMapping("/cica_multipartfile_serv")
	@PostMapping
	public String cica_multipartfile_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response,
			HttpServletRequest servletRequest, @RequestParam(value = "file", required = false) MultipartFile file) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");
			JSONObject obj = new JSONObject();
			JSONObject obj_r = new JSONObject();

			String web_service_response = null;

			if (request_type.equals("reply_to_ticket")) {

				String ticket_no = request.getParameter("ticket_no");
				String description = request.getParameter("description");
				String replied_by = request.getParameter("replied_by");
				String ticket_id = request.getParameter("ticket_id");
				String attach_file = request.getParameter("attach_file");
				String region = (String) session.getAttribute("regional_code");
				String division = (String) session.getAttribute("division");
				String reply_from = request.getParameter("reply_from");
				String move_to = request.getParameter("move_to");

				obj.put("ticket_no", ticket_no);
				obj.put("ticket_id", new Double(ticket_id).intValue());
				obj.put("description", description);
				obj.put("replied_by", replied_by);
				obj.put("region", region);
				obj.put("division", division);
				obj.put("attach_file", attach_file);
				obj.put("reply_from", reply_from);
				obj.put("move_to", move_to);

				System.out.println(obj.toString());

				if (attach_file.equals("")) {
					attach_file = "false";
					obj.put("attach_file", attach_file);

					web_service_response = cls_cica.reply_to_ticket(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

					if (web_service_response != null) {
						System.out.println(web_service_response);

					} else {
						obj_r.put("success", false);
						obj_r.put("msg", "Error occurred");
					}

					return web_service_response;

				} else {

					web_service_response = cls_cica.reply_to_ticket(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

					attach_file = "true";
					obj.put("attach_file", attach_file);

					// String type_of_document="requested_info";
					String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss")
							.format(Calendar.getInstance().getTime());
					// String web_service_response = "";
					ticket_no = ticket_no.replace("/", "_");
					// String type_of_document_upload = type_of_document.replace(" ", "_");

					String fileName = file.getOriginalFilename();
					// String path =
					// servletRequest.getSession().getServletContext().getRealPath("/"+File.separator+fileName);

					String path = cls_url_config.getLc_temp_folder() + ticket_no;

					InputStream is = file.getInputStream();

					boolean success = writeToFile(is, path);

					if (success) {
						System.out.println("File Uploaded to this directory: " + path);

						// File file = new File(path + fileName);

						obj.put("ticket_no", ticket_no);
						// obj.put("type_of_document", type_of_document);
						obj.put("fileName", fileName);
						String newpath = cls_url_config.getCica_reply_document() + ticket_no;

						// Creating a File object
						File filedir = new File(newpath);
						File sourcePath = new File(path);
						File destinationPath = new File(newpath + "/" + timeStamp + "_" + fileName);

						// Creating the directory
						if (!filedir.exists()) {
							boolean bool = filedir.mkdir();
							if (bool) {
								fileCopy(sourcePath, destinationPath);
								obj.put("location", destinationPath);
							} else {
								System.out.println("Sorry couldn't create specified directory");
								obj.put("location", destinationPath);
							}
						} else {
							fileCopy(sourcePath, destinationPath);
							obj.put("location", destinationPath);
						}

					}

					System.out.println(obj);

					

					if (web_service_response != null) {
						System.out.println(web_service_response);

					} else {
						obj_r.put("success", false);
						obj_r.put("msg", "Error occurred");
					}

					return web_service_response;

					//Get additional parameters

					// String apiKey = cls_url_config.getDoc_mgt_api_key(); 
					// String mimeType = file.getContentType();
					// //System.out.print(file);

					// // Check if the file is not empty
					// if (file != null && !file.isEmpty()) {
					// 	// Save the MultipartFile to a temporary file
					// 	File tempFile = convertMultipartFileToFile(file);

					// 	// Send the file to the external API
					// 	String apiUrl = cls_url_config.getDoc_mgt_api() + "document_upload/cica_reply_document";  // Target API URL
					// 	uploadPdf(apiUrl, tempFile, ticket_no, apiKey, mimeType);

					// 	// Delete the temporary file after uploading
					// 	tempFile.delete();
					// }
				}
			}

			// if (request_type.equals("reply_to_ticket")) {

			// String ticket_no =request.getParameter("ticket_no");
			// String description =request.getParameter("description");
			// String replied_by =request.getParameter("replied_by");
			// String ticket_id =request.getParameter("ticket_id");
			// String attach_file =request.getParameter("attach_file");
			// String region =(String) session.getAttribute("regional_code");
			// String division =(String) session.getAttribute("division");
			// String reply_from=request.getParameter("reply_from");

			// obj.put("ticket_no", ticket_no);
			// obj.put("ticket_id", new Double(ticket_id).intValue());
			// obj.put("description", description);
			// obj.put("replied_by",replied_by);
			// obj.put("region",region);
			// obj.put("division",division);
			// obj.put("attach_file",attach_file);
			// obj.put("reply_from", reply_from);

			// if(attach_file.equals("")) {
			// attach_file="false";
			// obj.put("attach_file",attach_file);

			// web_service_response =
			// cls_cica.reply_to_ticket(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			// if (web_service_response != null) {
			// System.out.println(web_service_response);

			// } else {
			// obj_r.put("success", false);
			// obj_r.put("msg", "Error occurred");
			// }

			// return web_service_response;

			// }
			// else {
			// attach_file="true";
			// obj.put("attach_file",attach_file);

			// //String type_of_document="requested_info";
			// String timeStamp = new
			// SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
			// //String web_service_response = "";
			// ticket_no = ticket_no.replace("/","_");
			// //String type_of_document_upload = type_of_document.replace(" ", "_");

			// String fileName = file.getOriginalFilename();
			// String path =
			// servletRequest.getSession().getServletContext().getRealPath("/"+File.separator+fileName);

			// InputStream is = file.getInputStream();

			// boolean success = writeToFile(is,path);

			// if(success) {
			// System.out.println("File Uploaded to this directory: "+path);

			// //File file = new File(path + fileName);

			// obj.put("ticket_no", ticket_no);
			// //obj.put("type_of_document", type_of_document);
			// obj.put("fileName", fileName);
			// String newpath = cls_url_config.getCica_reply_document() + ticket_no;

			// //Creating a File object
			// File filedir = new File(newpath);
			// File sourcePath = new File(path);
			// File destinationPath = new File(newpath+"/"+timeStamp+"_"+fileName);

			// //Creating the directory
			// if(!filedir.exists()) {
			// boolean bool = filedir.mkdir();
			// if(bool){
			// fileCopy(sourcePath,destinationPath);
			// }
			// else{
			// System.out.println("Sorry couldn't create specified directory");
			// }
			// }
			// else {
			// fileCopy(sourcePath,destinationPath);
			// obj.put("location", destinationPath);
			// }

			// }

			// web_service_response =
			// cls_cica.reply_to_ticket(cls_url_config.getWeb_service_url_ser(),
			// cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			// if (web_service_response != null) {
			// System.out.println(web_service_response);

			// } else {
			// obj_r.put("success", false);
			// obj_r.put("msg", "Error occurred");
			// }

			// //return web_service_response;
			// }
			// }

			return web_service_response;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("/cica_clients_serv")
	@PostMapping
	public String cica_clients_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");

			JSONObject obj = new JSONObject();
			JSONObject obj_r = new JSONObject();
			JSONObject obj_sms = new JSONObject();

			String web_service_response = null;
			String web_response = null;

			String pdfFileName = "acknowledgeslip.pdf";

			if (request_type.equals("clients_details")) {

				String complainant_name = request.getParameter("complainant_name");
				String complainant_phone = request.getParameter("complainant_phone");
				String complainant_email = request.getParameter("complainant_email");
				String complainant_add = request.getParameter("complainant_add");
				String purpose = request.getParameter("purpose");
				String request_by = request.getParameter("request_by");
				String request_by_id = request.getParameter("request_by_id");
				String regional_code = (String) session.getAttribute("regional_code");
				// System.out.println(regional_code);
				String within_time_frame = "";
				String subject = "";
				String description = "";

				obj.put("complainant_name", complainant_name);
				obj.put("complainant_phone", complainant_phone);
				obj.put("complainant_email", complainant_email);
				obj.put("complainant_add", complainant_add);
				obj.put("request_by", request_by);
				obj.put("request_by_id", request_by_id);
				obj.put("purpose", purpose);
				obj.put("regional_code", regional_code);

				switch (purpose) {
					case "1":
						within_time_frame = request.getParameter("within_time_frame");
						obj.put("within_time_frame", within_time_frame);
						if (within_time_frame.equals("1")) {
							String milestone_status = request.getParameter("milestone_status");
							String nature_of_enquiry = request.getParameter("nature_of_enquiry");
							obj.put("milestone_status", milestone_status);
							obj.put("nature_of_enquiry", nature_of_enquiry);
						} else {
							subject = request.getParameter("subject");
							description = request.getParameter("description");
							String contact_type = request.getParameter("contact_type");
							String priority = request.getParameter("priority");
							String related_service = request.getParameter("related_service");
							String reference_id = request.getParameter("reference_id");
							obj.put("subject", subject);
							obj.put("description", description);
							obj.put("contact_type", contact_type);
							obj.put("priority", priority);
							obj.put("related_service", related_service);
							obj.put("reference_id", reference_id);
						}
						break;
					case "2":
						String reference_source = request.getParameter("reference_source");
						String nature_of_enquiry = request.getParameter("nature_of_enquiry");
						obj.put("reference_source", reference_source);
						obj.put("nature_of_enquiry", nature_of_enquiry);
						break;
					case "3":
						within_time_frame = request.getParameter("within_time_frame");
						obj.put("within_time_frame", within_time_frame);
						if (within_time_frame.equals("1")) {
							String milestone_status = request.getParameter("milestone_status");
							obj.put("milestone_status", milestone_status);
						} else {
							subject = request.getParameter("subject");
							description = request.getParameter("description");
							String contact_type = request.getParameter("contact_type");
							String priority = request.getParameter("priority");
							String related_service = request.getParameter("related_service");
							String reference_id = request.getParameter("reference_id");
							obj.put("subject", subject);
							obj.put("description", description);
							obj.put("contact_type", contact_type);
							obj.put("priority", priority);
							obj.put("related_service", related_service);
							obj.put("reference_id", reference_id);
						}
						break;
					case "4":

						subject = request.getParameter("subject");
						description = request.getParameter("description");
						String division = request.getParameter("division");
						String region = request.getParameter("region");
						String unit = request.getParameter("unit");
						obj.put("subject", subject);
						obj.put("description", description);
						obj.put("division", division);
						obj.put("region", region);
						obj.put("unit", unit);

						break;
					default:
						System.out.println("Non Service Complaint");

				}

				web_service_response = cls_cica.save_client_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			if (request_type.equals("open_ticket")) {

				String complainant_name = request.getParameter("complainant_name");
				String complainant_phone = request.getParameter("complainant_phone");
				String complainant_email = request.getParameter("complainant_email");
				String subject = request.getParameter("subject");
				String description = request.getParameter("description");
				String contact_type = request.getParameter("contact_type");
				String complaint_type = request.getParameter("complaint_type");
				String priority = request.getParameter("priority");
				String related_service = request.getParameter("related_service");
				String service_number = request.getParameter("service_number");
				String request_by = request.getParameter("request_by");
				String request_by_id = request.getParameter("request_by_id");

				obj.put("complainant_name", complainant_name);
				obj.put("complainant_phone", complainant_phone);
				obj.put("complainant_email", complainant_email);
				obj.put("subject", subject);
				obj.put("description", description);
				obj.put("contact_type", contact_type);
				obj.put("complaint_type", complaint_type);
				obj.put("priority", priority);
				obj.put("related_service", related_service);
				obj.put("service_number", service_number);
				obj.put("created_by", request_by);
				obj.put("created_by_id", request_by_id);

				web_service_response = cls_cica.open_ticket(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			if (request_type.equals("save_client_details")) {

				String complainant_name = request.getParameter("complainant_name");
				String complainant_phone = request.getParameter("complainant_phone");
				String complainant_email = request.getParameter("complainant_email");
				String complainant_add = request.getParameter("complainant_add");
				String gender = request.getParameter("gender");
				String purpose = request.getParameter("purpose");
				String within_time_frame = request.getParameter("within_time_frame");
				String reference_source = request.getParameter("reference_source");
				String subject = request.getParameter("subject");
				String description = request.getParameter("description");
				String division = request.getParameter("division");
				String regional_code = request.getParameter("region");
				String unit = request.getParameter("unit");
				String related_service = request.getParameter("related_service");
				String reference_id = request.getParameter("reference_id");
				String request_by = request.getParameter("request_by");
				String request_by_id = request.getParameter("request_by_id");
				String milestone_status = request.getParameter("milestone_status");
				// String regional_code=(String) session.getAttribute("regional_code");
				// System.out.println(regional_code);
				String contact_type = request.getParameter("contact_type");
				String priority = request.getParameter("priority");
				String user_region =  (String) session.getAttribute("region_id");

				obj.put("complainant_name", complainant_name);
				obj.put("complainant_phone", complainant_phone);
				obj.put("complainant_email", complainant_email);
				obj.put("complainant_email", complainant_email);
				obj.put("complainant_add", complainant_add);
				obj.put("gender", gender);
				obj.put("subject", subject);
				obj.put("description", description);
				obj.put("division", division);
				// obj.put("region", region);
				obj.put("unit", unit);
				obj.put("related_service", related_service);
				obj.put("reference_id", reference_id);
				obj.put("created_by", request_by);
				obj.put("created_by_id", request_by_id);
				obj.put("milestone_status", milestone_status);
				obj.put("purpose", purpose);
				obj.put("reference_source", reference_source);
				obj.put("within_time_frame", within_time_frame);
				obj.put("regional_code", regional_code == "" ? user_region : regional_code);
				obj.put("contact_type", contact_type);
				obj.put("priority", priority);
				// obj.put("message", "Hello "+complainant_name+", the incident you reported has
				// been lodged successfully. We'll be working speedily to resolve it. Your
				// ticket number is: ");

				//System.out.print(obj.toString());

				web_response = cls_cica.save_client_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				//System.out.print(web_response);

				JSONObject web_response_obj = new JSONObject(web_response);

				String success = web_response_obj.get("success").toString();
				String ticket_no = web_response_obj.get("ticket_no").toString();
				String client_name = web_response_obj.get("client_name").toString();
				// purpose = web_response_obj.get("purpose").toString();

				complainant_phone = complainant_phone.replaceFirst("0", "233");

				if (success.equals("true")) {

					if (subject.equals("Queried")) {

						if (purpose.equals("1")) {
							purpose = "Service Enquiry";
						}
						if (purpose.equals("2")) {
							purpose = "Other Enquiry";
						}
						if (purpose.equals("3")) {
							purpose = "Service Complaint";
						}
						if (purpose.equals("4")) {
							purpose = "Non-Service Complaint";
						}

						String message = "Dear valued client, the incident you reported has been lodged successfully with ticket number "
								+ ticket_no
								+ ". Address the query to enable further processing of your application. Login to onlineservices.lc.gov.gh to track the progress of your application. Thank you!";

						obj_sms.put("recipient", complainant_phone);
						obj_sms.put("msg", message);

						// Cica.sendText(obj_sms);
						cls_cica.send_single_sms(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());
					} else {

						if (purpose.equals("1")) {
							purpose = "Service Enquiry";
							String message = "";

							if (within_time_frame.equals("0")) {
								message = "Dear valued client, the incident you reported has been lodged successfully with ticket number "
										+ ticket_no
										+ ". We will be working speedily to resolve the issue. Login to onlineservices.lc.gov.gh to track the progress of your application. Thank you!";
							} else {
								message = "Dear valued client, thank you for contacting the Lands Commission. Login to onlineservices.lc.gov.gh to track the progress of your application. Thank you!";
							}

							obj_sms.put("recipient", complainant_phone);
							obj_sms.put("msg", message);

							// Cica.sendText(obj_sms);
							cls_cica.send_single_sms(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());

						} else if (purpose.equals("2")) {
							purpose = "Other Enquiry";
							String message = "Thank you for contacting the Lands Commission. Client Satisfaction is our Goal!";

							obj_sms.put("recipient", complainant_phone);
							obj_sms.put("msg", message);

							// Cica.sendText(obj_sms);
							cls_cica.send_single_sms(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());

						} else if (purpose.equals("3")) {
							purpose = "Service Complaint";
							String message = "Dear valued client, the incident you reported has been lodged successfully with ticket number "
									+ ticket_no
									+ ". We will be working speedily to resolve the issue. Login to onlineservices.lc.gov.gh to track the progress of your application. Thank you!";

							obj_sms.put("recipient", complainant_phone);
							obj_sms.put("msg", message);

							// Cica.sendText(obj_sms);
							cls_cica.send_single_sms(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());

						} else if (purpose.equals("4")) {
							purpose = "Non-Service Complaint";
							String message = "Dear valued client, the incident you reported has been lodged successfully with ticket number "
									+ ticket_no
									+ ". We will be working speedily to resolve the issue. Client Satisfaction is our Goal!";

							obj_sms.put("recipient", complainant_phone);
							obj_sms.put("msg", message);

							// Cica.sendText(obj_sms);
							cls_cica.send_single_sms(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj_sms.toString());

						}

					}

					// web_service_response = cica_docs.create_batch_list(ticket_no, client_name,
					// purpose, request_by);
					String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss")
							.format(Calendar.getInstance().getTime());
					String files_pdf_jackets_p = cls_url_config.getCica_created_ticket() + "batch_list" + "_"
							+ timeStamp + ".pdf";

					//System.out.print(cls_url_config.getSoftfile_location());

					byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = cls_cica_docs.create_batch_list(
							cls_url_config.getSoftfile_location(),
							ticket_no, client_name, purpose, request_by, files_pdf_jackets_p, timeStamp,
							session.getAttribute("web_comp_address").toString(),
							session.getAttribute("web_city").toString(),
							session.getAttribute("web_telephone").toString(),
							session.getAttribute("web_fax_number").toString(),
							session.getAttribute("web_email").toString());

							 System.out.println(buffer);
							// System.out.println(ticket_no);
							// System.out.println(client_name);
							// System.out.println(purpose);
							// System.out.println(request_by);
							// System.out.println(files_pdf_jackets_p);
							// System.out.println(timeStamp);
							// System.out.println(session.getAttribute("web_comp_address").toString());
							// System.out.println(session.getAttribute("web_city").toString());
							// System.out.println(session.getAttribute("web_telephone").toString());
							// System.out.println(session.getAttribute("web_fax_number").toString());
							// System.out.println(session.getAttribute("web_email").toString());

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
					web_service_response = null;
				}

				//System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			if (request_type.equals("open_pdf")) {
				String file_path = request.getParameter("file_path").trim();
				// String ticket_no = request.getParameter("ticket_no").trim();
				// ticket_no = ticket_no.replace("/", "_");
				System.out.println(file_path);

				// File pdfFile = new
				// File("C:\\legal_docs\\batchlist\\batch_list_"+file_path+".pdf");
				File pdfFile = new File(
						cls_url_config.getCica_created_ticket() + "batch_list" + "_" + file_path + ".pdf");
				// File pdfFile = new File(attachment_path);
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
			out.flush();
			out.close();

		} catch (IOException e) {
			e.printStackTrace();
		}

		return true;
	}

	private boolean fileCopy(File sourcePath, File destinationPath) {

		boolean status = false;
		try {
			Files.copy(sourcePath.toPath(), destinationPath.toPath(), StandardCopyOption.REPLACE_EXISTING);

			status = true;
		} catch (IOException e) {
			e.printStackTrace();
		}

		return status;
	}

	 private File convertMultipartFileToFile(MultipartFile file) throws IOException {
		// Create a temporary file
		File tempFile = File.createTempFile("upload-", file.getOriginalFilename());
		try (FileOutputStream fos = new FileOutputStream(tempFile)) {
			fos.write(file.getBytes());
		}
		return tempFile;
	}

	public static void uploadPdf(String apiUrl, File pdfFile, String caseNumber, String apiKey, String mimeType) {
		RestTemplate restTemplate = new RestTemplate();

		// Set headers
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
		// Add API Key to the headers
		headers.set("x-api-key", apiKey);

		// Prepare the file as a resource
		FileSystemResource fileResource = new FileSystemResource(pdfFile);

		// Create a MultiValueMap to hold the file and additional parameters
		MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
		body.add("file", fileResource);           // Attach the file
		body.add("ticket_number", caseNumber);       // Attach the additional string parameter
		body.add("document_type", mimeType); 
		body.add("job_number", caseNumber); 

		// Build request entity
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

		// Send the request
		ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.POST, requestEntity, String.class);

		// Handle response
		if (response.getStatusCode().is2xxSuccessful()) {
			System.out.println("Response: " + response.getBody());
		} else {
			System.out.println("Failed to upload file. Status code: " + response.getStatusCode());
		}
	}
}
