package com.mit.elis.servlets.legal;

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
import org.springframework.http.codec.multipart.Part;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.mit.elis.class_common.Ws_url_config;

import ws.legal.legal_docs;
import ws.legal.ws_suits;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		maxFileSize = 1024 * 1024 * 10, // 10 MB
		maxRequestSize = 1024 * 1024 * 15 // 15 MB
)

@RestController
public class LegalServlet {

	ws_suits cls_suits = new ws_suits();
	legal_docs cls_legal_docs = new legal_docs();
	// Ws_url_config cls_url_config = new Ws_url_config();

	@Autowired
	private Ws_url_config cls_url_config;

	ServletRequest servletContext;

	@RequestMapping("/secretariat_serv")
	@PostMapping
	public String secretariat_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");
			JSONObject obj = new JSONObject();
			String suit_number = request.getParameter("suit_number");

			String web_service_response = null;
			String pdfFileName = "acknowledgeslip.pdf";

			if (request_type.equals("secretariat_writs")) {

				// JSONObject obj = new JSONObject();
				// obj.put("region_id", region_id);
				// String input_details = obj.toString();
				// System.out.println(input_details + " Started @ : " + new java.util.Date());
				web_service_response = cls_suits.secretariat_writs(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			else if (request_type.equals("get_courts")) {

				// JSONObject obj = new JSONObject();
				// obj.put("region_id", region_id);
				// String input_details = obj.toString();
				// System.out.println(input_details + " Started @ : " + new java.util.Date());
				web_service_response = cls_suits.get_courts(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}

				// return web_service_response;
			}

			else if (request_type.equals("forward_cases")) {

				String list = request.getParameter("list");
				obj.put("list", list);
				//System.out.println(list);

				cls_suits.forward_cases(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), list);

				String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
				String files_pdf_jackets_p = cls_url_config.getLegal_batch_list_location() + "batch_list" + "_"
						+ timeStamp + ".pdf";

						byte[] buffer = null;

						// Generate the PDF as a byte array
						buffer = cls_legal_docs.create_batch_list(
						cls_url_config.getSoftfile_location(),
						list, session.getAttribute("fullname").toString(), files_pdf_jackets_p, timeStamp,
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

			}

			return web_service_response;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("/case_details_serv")
	@PostMapping
	public String case_details_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		JSONObject obj = new JSONObject();

		String m_case_id = request.getParameter("case_id");
		String m_suit_number = request.getParameter("suit_number");

		obj.put("case_id", new Double(m_case_id).intValue());
		obj.put("suit_number", m_suit_number);
		// System.out.println(obj);

		web_service_response = cls_suits.load_minutes_on_case(cls_url_config.getWeb_service_url_ser(),
				cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

		if (web_service_response != null) {
			System.out.println(web_service_response);
		} else {
			System.out.println(web_service_response);
		}

		return web_service_response;
	}

	@RequestMapping("/case_summary")
	@PostMapping
	public String case_summary(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		JSONObject obj = new JSONObject();

		String m_case_id = request.getParameter("case_id");
		// String m_suit_number =request.getParameter("suit_number");

		obj.put("case_id", m_case_id);
		// obj.put("suit_number", m_suit_number);
		// System.out.println(obj);

		web_service_response = cls_suits.case_details(cls_url_config.getWeb_service_url_ser(),
				cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

		if (web_service_response != null) {
			System.out.println(web_service_response);
		} else {
			System.out.println(web_service_response);
		}

		return web_service_response;
	}

	@RequestMapping("/case_work_serv")
	@PostMapping
	public String case_work_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			String request_type = request.getParameter("request_type");
			JSONObject obj = new JSONObject();
			String suit_number = request.getParameter("suit_number");
			String case_id = request.getParameter("case_id");

			String web_service_response = null;

			if (request_type.equals("case_note")) {

				String n_case_id = request.getParameter("case_id");
				String subject = request.getParameter("subject");
				String notes = request.getParameter("notes");
				String created_by = request.getParameter("created_by");

				obj.put("suit_number", suit_number);
				obj.put("subject", subject);
				obj.put("notes", notes);
				obj.put("created_by", created_by);
				obj.put("case_id", n_case_id.equals("") ? "999999" : n_case_id);

				System.out.println(obj);

				web_service_response = cls_suits.case_note_insert(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			else if (request_type.equals("load_notes")) {

				obj.put("suit_number", suit_number);

				web_service_response = cls_suits.case_note_select(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			else if (request_type.equals("load_case_details")) {

				obj.put("suit_number", suit_number);

				web_service_response = cls_suits.load_further_entry(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			else if (request_type.equals("update_parties")) {

				obj.put("suit_number", suit_number);

				String web_response = cls_suits.load_further_entry(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				String plaintiffs = request.getParameter("plaintiffs");
				String defendants = request.getParameter("defendants");
				JSONArray plaintiffs_arr = new JSONArray(plaintiffs);
				JSONArray defendants_arr = new JSONArray(defendants);

				JSONObject web_response_obj = new JSONObject(web_response);
				JSONArray data = new JSONArray(web_response_obj.getString("data"));
				JSONObject case_obj = data.getJSONObject(0);

				case_obj.remove("plaintiffs");
				case_obj.remove("defendants");

				case_obj.put("plaintiffs", plaintiffs_arr);
				case_obj.put("defendants", defendants_arr);

				web_service_response = cls_suits.load_further_entry(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), case_obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}

			}

			else if (request_type.equals("update_case_status")) {

				
				String status_of_case = request.getParameter("status_of_case");
				String updated_by = request.getParameter("updated_by");
				String start_date = request.getParameter("start_date");
				String end_date = request.getParameter("end_date");
				
				obj.put("case_id", case_id);
				obj.put("suit_number", suit_number);
				obj.put("status_of_case", status_of_case);
				obj.put("updated_by", updated_by);
				obj.put("start_date", start_date);
				obj.put("end_date", end_date);

				web_service_response = cls_suits.update_case_status(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			else if (request_type.equals("load_suit_number_timeline")) {
				obj.put("suit_number", suit_number);

				web_service_response = cls_suits.load_suit_number_timeline(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			else if (request_type.equals("load_timeline")) {
				// obj.put("suit_number", suit_number);

				web_service_response = cls_suits.load_timeline(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			else if (request_type.equals("load_user_timeline")) {

				String user_id = (String) session.getAttribute("userid");
				obj.put("user_id", user_id);

				web_service_response = cls_suits.load_user_timeline(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			else if (request_type.equals("update_releifs_and_summary")) {

				String up_case_id = request.getParameter("case_id");
				String releifs = request.getParameter("releifs");
				String summary = request.getParameter("summary");

				obj.put("case_id", new Double(up_case_id).intValue());
				obj.put("releifs", releifs);
				obj.put("summary", summary);

				web_service_response = cls_suits.update_releifs_and_summary(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			else if (request_type.equals("update_status_form_with_note")) {

				String up_case_id = request.getParameter("up_case_id");
				String up_suit_number = request.getParameter("up_suit_number");
				String up_notes = request.getParameter("up_notes");

				obj.put("case_id", new Double(up_case_id).intValue());
				obj.put("suit_number", up_suit_number);
				obj.put("notes", up_notes);

				web_service_response = cls_suits.update_status_form_with_note(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
				if (web_service_response != null) {
					// System.out.println("Ended a@ : " + new java.util.Date() + " \n" +
					// web_service_response);
				} else {
					System.out.println(web_service_response);
				}
			}

			else if (request_type.equals("add_minutes_on_case")) {

				String m_case_id = request.getParameter("case_id");
				String m_suit_number = request.getParameter("suit_number");
				String minutes = request.getParameter("minutes");
				String created_by = request.getParameter("created_by");
				String created_by_id = request.getParameter("created_by_id");

				obj.put("case_id", new Double(m_case_id).intValue());
				obj.put("suit_number", m_suit_number);
				obj.put("minutes", minutes);
				obj.put("user_name", created_by);
				obj.put("user_id", created_by_id);

				web_service_response = cls_suits.add_minutes_on_case(cls_url_config.getWeb_service_url_ser(),
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

	@RequestMapping("/cases_upload_serv")
	@PostMapping
	public String cases_upload_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response,
			HttpServletRequest servletRequest, @RequestParam(value = "file", required = false) MultipartFile file)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub

		try {
			String suit_number = request.getParameter("suit_number");
			System.out.println(suit_number);
			String case_id = request.getParameter("case_id");
			String type_of_document = request.getParameter("type_of_document");
			String scan_type = request.getParameter("scan_type");
			String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
			String web_service_response = "";

			String suit_upload = suit_number.replace("/", "_");
			String type_of_document_upload = type_of_document.replace(" ", "_");

			String fileName = file.getOriginalFilename();

			// String path =
			// servletRequest.getSession().getServletContext().getRealPath("/"+File.separator+fileName);

			String path = cls_url_config.getLc_temp_folder() + suit_upload;

			InputStream is = file.getInputStream();

			boolean success = writeToFile(is, path);

			if (success) {
				System.out.println("File Uploaded to this directory: " + path);

				// File file = new File(path + fileName);

				JSONObject obj = new JSONObject();
				obj.put("suit_number", suit_number);
				obj.put("type_of_document", type_of_document);
				obj.put("fileName", fileName);
				// obj.put("case_number", Double.valueOf(case_number).intValue());
				obj.put("case_id", Double.valueOf(case_id).intValue());
				String newpath = cls_url_config.getLegal_document_location() + suit_upload;

				// Creating a File object
				File filedir = new File(newpath);
				File sourcePath = new File(path);
				File destinationPath = new File(
						newpath + "/" + type_of_document_upload + "_" + timeStamp + "_" + fileName);

				// Creating the directory
				if (!filedir.exists()) {
					boolean bool = filedir.mkdir();
					if (bool) {
						fileCopy(sourcePath, destinationPath);
					} else {
						System.out.println("Sorry couldn't create specified directory");
					}
				} else {
					fileCopy(sourcePath, destinationPath);
					obj.put("location", destinationPath);
				}

				if (scan_type.equals("partial")) {
					web_service_response = cls_suits.update_initial_scan(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				} else if (scan_type.equals("full")) {
					System.out.println("Testing");
					System.out.println(obj);
					web_service_response = cls_suits.update_full_scan(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				} else {
					web_service_response = cls_suits.save_file_location(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				}

			} else {
				// upload_status = false;
			}

			return web_service_response;

		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/legal_further_entries")
	@PostMapping
	public String further_entries(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		// JSONObject obj = new JSONObject();

		try {
			String suit_number = request.getParameter("suit_number");
			// String case_id = request.getParameter("case_id");
			System.out.println(suit_number);
			// String web_response = null;
			JSONObject obj = new JSONObject();
			// Gson googleJson = new Gson();
			// JSONObject obj_r = new JSONObject();
			String request_type = request.getParameter("request_type");

			if (request_type.equals("further_entries")) {

				int caseid = Integer.parseInt(request.getParameter("case_id"));
				suit_number = request.getParameter("suit_number");
				int nature_of_case = Integer.parseInt(request.getParameter("nature_of_case"));
				int court_id = Integer.parseInt(request.getParameter("court_id"));
				String date_document = request.getParameter("date_of_document");
				String summary = request.getParameter("summary");
				String reference_number = request.getParameter("reference_number");
				String reliefs = request.getParameter("reliefs");
				String parties = request.getParameter("parties");
				String court_description = request.getParameter("court_description");
				String court_process = request.getParameter("court_process");

				// Create a json obj
				obj.put("case_id", caseid);
				obj.put("suit_number", suit_number);
				obj.put("reference_number", reference_number);
				obj.put("nature_of_case", nature_of_case);
				obj.put("court", court_id);
				obj.put("date_document", date_document);
				obj.put("summary", summary);
				obj.put("reliefs", reliefs);
				obj.put("parties", parties);
				obj.put("court_description", court_description);
				obj.put("court_process", court_process);

				// System.out.println(obj);

				web_service_response = cls_suits.further_entry(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);
			}

			return web_service_response;

		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/head_legal_serv")
	@PostMapping
	public String head_legal(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		// JSONObject obj = new JSONObject();

		try {
			String suit_number = request.getParameter("suit_number");
			System.out.println(suit_number);
			JSONObject obj = new JSONObject();
			JSONObject obj_r = new JSONObject();
			;

			String pdfFileName = "acknowledgeslip.pdf";

			String request_type = request.getParameter("request_type");

			if (request_type.equals("load_data")) {

				web_service_response = cls_suits.load_legal_head_cases(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);
			}

			else if (request_type.equals("load_incoming_cases")) {

				web_service_response = cls_suits.load_incoming_cases(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			else if (request_type.equals("receive_cases")) {

				// String list = request.getParameter("list");
				// obj.put("list",list);

				// web_service_response =
				// cls_suits.receive_cases(cls_url_config.getWeb_service_url_ser(),
				// cls_url_config.getWeb_service_url_ser_api_key(), list);

				// System.out.println(web_service_response);

				// if (web_service_response != null) {
				// System.out.println(web_service_response);
				// } else {

				// obj_r.put("success", false);
				// obj_r.put("msg", "Error Getting Ticket Categories");
				// }

				String list = request.getParameter("list");
				obj.put("list", list);
				System.out.println(list);

				cls_suits.receive_cases(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), list);

				String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
				String files_pdf_jackets_p = cls_url_config.getLegal_batch_list_location() + "batch_list" + "_"
						+ timeStamp + ".pdf";

						byte[] buffer = null;

						// Generate the PDF as a byte array
						buffer = cls_legal_docs.create_batch_list(
						cls_url_config.getSoftfile_location(),
						list, session.getAttribute("fullname").toString(), files_pdf_jackets_p, timeStamp,
						session.getAttribute("web_comp_address").toString(),
						session.getAttribute("web_city").toString(),
						session.getAttribute("web_telephone").toString(),
						session.getAttribute("web_fax_number").toString(),
						session.getAttribute("web_email").toString());

				// File pdfFile = new File(files_pdf_jackets_p);
				// byte[] buffer = null;

				// BufferedInputStream is = new BufferedInputStream(new
				// FileInputStream(pdfFile));
				// ByteArrayOutputStream bos = new ByteArrayOutputStream((int)
				// pdfFile.length());

				// int ch;
				// long actual = 0;
				// while ((ch = is.read()) != -1) {
				// bos.write(ch);
				// actual++;
				// }
				// bos.flush();
				// bos.close();
				// buffer = bos.toByteArray();

				// response.setContentType("application/pdf");
				// response.addHeader("Content-Disposition", "inline;
				// filename=Documentation.pdf");
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
			}

			else if (request_type.equals("load_pending_actions")) {

				web_service_response = cls_suits.load_pending_actions(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			else if (request_type.equals("load_archived_cases")) {

				web_service_response = cls_suits.load_archived_cases(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			if (request_type.equals("assign_one_case")) {

				suit_number = request.getParameter("suit_number");
				String case_id = request.getParameter("case_id");
				String user_to_send_to_name = request.getParameter("user_to_send_to_name");
				String user_to_send_to_id = request.getParameter("user_to_send_to_id");
				String reasons = request.getParameter("reasons");

				// Create a json obj
				obj.put("suit_number", suit_number);
				obj.put("user_to_send_to_name", user_to_send_to_name);
				obj.put("user_to_send_to_id", user_to_send_to_id);
				obj.put("case_id", case_id);
				obj.put("reasons", reasons);

				// //System.out.println(obj);

				web_service_response = cls_suits.assign_one_case(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put(" success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			if (request_type.equals("restore_one_case")) {

				suit_number = request.getParameter("suit_number");
				String case_id = request.getParameter("case_id");

				// Create a json obj
				obj.put("suit_number", suit_number);
				obj.put("case_id", case_id);

				// //System.out.println(obj);

				web_service_response = cls_suits.restore_one_case(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put(" success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			if (request_type.equals("archive_one_case")) {

				suit_number = request.getParameter("suit_number");
				String case_id = request.getParameter("case_id");
				String reasons = request.getParameter("reasons");

				// Create a json obj
				obj.put("suit_number", suit_number);
				obj.put("case_id", case_id);
				obj.put("reasons", reasons);

				// //System.out.println(obj);

				web_service_response = cls_suits.archive_one_case(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put(" success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			if (request_type.equals("search_archived_case")) {

				String case_id = request.getParameter("case_id");

				obj.put("suit_number", case_id);

				// //System.out.println(obj);

				web_service_response = cls_suits.search_archived_case(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put(" success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			else if (request_type.equals("assigned_cases")) {

				web_service_response = cls_suits.assigned_cases_select(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

			} else if (request_type.equals("assigned_unit_cases")) {

				web_service_response = cls_suits.assigned_unit_cases_select(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

			} else if (request_type.equals("assigned_cases_user")) {
				String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

				String userid = (String) session.getAttribute("userid");
				obj.put("fullname", fullname); obj.put("mac_address", mac_address); obj.put("ip_address", ip_address);


				web_service_response = cls_suits.assigned_cases_user(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
			} else if (request_type.equals("load_cases")) {
				String load_type = request.getParameter("load_type");
				obj.put("load_type", load_type);

				web_service_response = cls_suits.load_type(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
			}

			else if (request_type.equals("load_user_pending_actions")) {

				String user_id = (String) session.getAttribute("userid");
				obj.put("user_id", user_id);

				web_service_response = cls_suits.load_user_pending_actions(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			}

			return web_service_response;

		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/legacy_cases_serv")
	@PostMapping
	public String legacy_cases(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub

		try {
			String request_type = request.getParameter("request_type");
			String suit_number = request.getParameter("suit_number");

			JSONObject obj = new JSONObject();
			String web_service_response = "";

			if (request_type.equals("search_suit")) {
				// suit_number =request.getParameter("suit_number");

				obj.put("suit_number", suit_number);

				web_service_response = cls_suits.suit_exist(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				System.out.println(web_service_response);

			}
			if (request_type.equals("add_case")) {
				suit_number = request.getParameter("suit_number");
				String reference_number = request.getParameter("reference_number");
				String nature_of_case = request.getParameter("nature_of_case");
				String court = request.getParameter("court");
				String court_description = request.getParameter("court_description");
				String court_process = request.getParameter("court_process");
				String date_received = request.getParameter("date_received");
				String date_document = request.getParameter("date_document");
				String parties = request.getParameter("parties");
				String received_by = request.getParameter("received_by");
				String releifs = request.getParameter("releifs");
				String summary = request.getParameter("summary");
				String files_location = request.getParameter("files_location");

				// System.out.println(parties);
				JSONArray parties_obj = new JSONArray(parties);

				obj.put("suit_number", suit_number);
				obj.put("reference_number", reference_number);
				obj.put("nature_of_case", new Double(nature_of_case).intValue());
				obj.put("court", new Double(court).intValue());
				obj.put("court_process", court_process);
				obj.put("date_received", date_received);
				obj.put("date_document", date_document);
				obj.put("court_description", court_description);
				obj.put("parties", parties_obj);
				obj.put("received_by", received_by);
				obj.put("releifs", releifs);
				obj.put("summary", summary);
				obj.put("files_location", files_location);
				// System.out.println(obj);

				web_service_response = cls_suits.addcase(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
			}
			if (request_type.equals("secretariat_add_case")) {
				suit_number = request.getParameter("suit_number");
				String reference_number = request.getParameter("reference_number");
				String nature_of_case = request.getParameter("nature_of_case");
				String court = request.getParameter("court");
				String court_description = request.getParameter("court_description");
				String court_process = request.getParameter("court_process");
				String date_received = request.getParameter("date_received");
				String date_document = request.getParameter("date_document");
				String parties = request.getParameter("parties");
				String received_at = request.getParameter("received_at");
				String reliefs = request.getParameter("reliefs");
				String summary = request.getParameter("summary");
				String court_region = request.getParameter("court_region");

				JSONArray parties_obj = new JSONArray(parties);

				obj.put("suit_number", suit_number);
				obj.put("reference_number", reference_number);
				obj.put("nature_of_case", new Double(nature_of_case).intValue());
				obj.put("court", new Double(court).intValue());
				obj.put("court_process", court_process);
				obj.put("court_description", court_description);
				obj.put("date_received", date_received);
				obj.put("date_document", date_document);
				obj.put("court_description", court_description);
				obj.put("parties", parties_obj);
				obj.put("received_at", received_at);
				obj.put("reliefs", reliefs);
				obj.put("summary", summary);
				obj.put("court_region", court_region);

				System.out.println(obj);

				web_service_response = cls_suits.secretariat_addcase(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
			}
			if (request_type.equals("suit_all_cases")) {
				suit_number = request.getParameter("suit_number");

				obj.put("suit_number", suit_number);

				web_service_response = cls_suits.suit_all_cases(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			}

			if (request_type.equals("update_parties")) {
				suit_number = request.getParameter("suit_number");
				String case_id = request.getParameter("case_id");
				String parties = request.getParameter("parties");

				JSONArray parties_obj = new JSONArray(parties);

				obj.put("suit_number", suit_number);
				obj.put("case_id", new Double(case_id).intValue());
				obj.put("parties", parties_obj);

				System.out.println(obj);

				web_service_response = cls_suits.update_suit_parties(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			}

			return web_service_response;

		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/legal_case_management_serv")
	@PostMapping
	public String legal_case_management(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		// JSONObject obj = new JSONObject();

		try {
			String request_type = request.getParameter("request_type");
			String user_id = (String) session.getAttribute("userid");
			// String web_response="";
			JSONObject obj = new JSONObject();
			obj.put("user_id", user_id);

			if (request_type.equals("pending_action")) {

				web_service_response = cls_suits.pending_action(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
			}

			else if (request_type.equals("officer_cases")) {

				web_service_response = cls_suits.assigned_cases(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
			} else if (request_type.equals("scheduled_events")) {

				web_service_response = cls_suits.scheduled_events(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
			}

			else if (request_type.equals("schedule_insert")) {

				String schedule = request.getParameter("scheduleObject");
				obj.put("schedule", schedule);

				web_service_response = cls_suits.schedule_insert(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			}

			return web_service_response;

		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/legal_request_serv")
	@PostMapping
	public String legal_request(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		// JSONObject obj = new JSONObject();

		try {
			String request_type = request.getParameter("request_type");
			// System.out.println(request_type);
			JSONObject obj = new JSONObject();
			JSONObject obj_r = new JSONObject();

			if (request_type.equals("load_data")) {

				String division = request.getParameter("division");
				String regional_code = request.getParameter("regional_code");
				String unit_name = request.getParameter("unit_name");
				String movement = request.getParameter("movement");

				obj.put("division", division);
				obj.put("region", regional_code);
				obj.put("unit_name", unit_name);
				obj.put("movement", movement);

				System.out.println(obj);
				web_service_response = cls_suits.load_requests(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}

			}

			return web_service_response;

		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/legal_settings_serv")
	@PostMapping
	public String legal_settings_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		// JSONObject obj = new JSONObject();

		try {
			String request_type = request.getParameter("request_type");
			// System.out.println(request_type);
			JSONObject obj = new JSONObject();
			JSONObject obj_r = new JSONObject();

			if (request_type.equals("add_nature")) {

				String nature_of_case = request.getParameter("nature_of_case");
				String nature_of_case_id = request.getParameter("nature_of_case_id");

				obj.put("nature_of_case", nature_of_case);
				obj.put("nature_of_case_id", nature_of_case_id.equals("") ? nature_of_case_id
						: Double.valueOf(nature_of_case_id).intValue());

				System.out.println(obj);
				web_service_response = cls_suits.add_nature(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}

			}

			if (request_type.equals("add_court")) {

				String court_name = request.getParameter("court_name");
				String court_region = request.getParameter("court_region");
				String city = request.getParameter("city");
				String description = request.getParameter("description");
				String court_id = request.getParameter("court_id");

				obj.put("court_name", court_name);
				obj.put("court_region", court_region);
				obj.put("city", city);
				obj.put("description", description);
				obj.put("court_id", court_id.equals("") ? court_id : Double.valueOf(court_id).intValue());

				System.out.println(obj);
				web_service_response = cls_suits.add_court(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}

			}

			return web_service_response;

		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/legal_reports_serv")
	@PostMapping
	public String legal_reports(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		// JSONObject obj = new JSONObject();

		try {
			String request_type = request.getParameter("request_type");
			// System.out.println(request_type);
			JSONObject obj = new JSONObject();

			if (request_type.equals("report_by_nature_of_case")) {

				String nature_of_case = request.getParameter("nature_of_case");
				String court_region = request.getParameter("court_region");
				String date_from = request.getParameter("date_from");
				String date_to = request.getParameter("date_to");

				obj.put("nature_of_case", new Double(nature_of_case).intValue());
				obj.put("court_region", court_region);
				obj.put("date_from", date_from);
				obj.put("date_to", date_to);

				System.out.println(obj);

				web_service_response = cls_suits.report_by_nature_of_case(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

			}

			return web_service_response;

		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/legal_unit_serv")
	@PostMapping
	public String legal_unit_serv(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		// JSONObject obj = new JSONObject();

		try {
			String request_type = request.getParameter("request_type");
			// System.out.println(request_type);
			JSONObject obj = new JSONObject();
			JSONObject obj_r = new JSONObject();

			if (request_type.equals("load_data")) {

				web_service_response = cls_suits.load_unit_cases(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			else if (request_type.equals("unit_cases_unassigned")) {

				web_service_response = cls_suits.load_unit_cases_unassigned(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			else if (request_type.equals("unit_cases_assigned")) {

				web_service_response = cls_suits.load_unit_cases_assigned(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			else if (request_type.equals("load_incoming_cases")) {

				web_service_response = cls_suits.load_incoming_cases(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key());

				System.out.println(web_service_response);

				if (web_service_response != null) {
					System.out.println(web_service_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
			}

			else if (request_type.equals("open_pdf")) {
				String file_path = request.getParameter("file_path").trim();
				System.out.println(file_path);

				// File pdfFile = new
				// File("C:\\legal_docs\\batchlist\\batch_list_"+file_path+".pdf");
				File pdfFile = new File(
						cls_url_config.getLegal_batch_list_location() + "batch_list" + "_" + file_path + ".pdf");
				System.out.println(pdfFile);

				// response.setContentType("application/pdf");
				// // response.addHeader("Content-Disposition", "attachment; filename=" +
				// // pdfFileName);
				// response.addHeader("Content-Disposition", "inline;
				// filename=Documentation.pdf");
				// response.setContentLength((int) pdfFile.length());

				// FileInputStream fileInputStream = new FileInputStream(pdfFile);
				// OutputStream responseOutputStream = response.getOutputStream();
				// int bytes;
				// while ((bytes = fileInputStream.read()) != -1) {
				// responseOutputStream.write(bytes);
				// }

				// responseOutputStream.flush();
				// responseOutputStream.close();

				// File pdfFile = new File(files_pdf_jackets_p);
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

			else if (request_type.equals("open_case_doc")) {
				String file_path = request.getParameter("file_path").trim();
				String suit_number = request.getParameter("suit_number").trim();
				suit_number = suit_number.replace("/", "_");
				System.out.println(file_path);

				// File pdfFile = new
				// File("C:\\legal_docs\\batchlist\\batch_list_"+file_path+".pdf");
				File pdfFile = new File(cls_url_config.getLegal_document_location() + suit_number + "/" + file_path);
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

			else if (request_type.equals("open_request_doc")) {
				String file_path = request.getParameter("file_path").trim();
				String suit_number = request.getParameter("suit_number").trim();
				suit_number = suit_number.replace("/", "_");
				System.out.println(file_path);

				File pdfFile = new File(cls_url_config.getLegal_request_document() + suit_number + "/" + file_path);
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

			else if (request_type.equals("open_provided_doc")) {
				String file_path = request.getParameter("file_path").trim();
				String suit_number = request.getParameter("suit_number").trim();
				suit_number = suit_number.replace("/", "_");
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

			else if (request_type.equals("open_request_pdf")) {
				String file_path = request.getParameter("file_path").trim();
				System.out.println(file_path);

				// File pdfFile = new
				// File("C:\\legal_docs\\batchlist\\batch_list_"+file_path+".pdf");
				File pdfFile = new File(
						cls_url_config.getLegal_batch_list_location() + "batch_list" + "_" + file_path + ".pdf");
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
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/load_scanned_documents")
	@PostMapping
	public String load_scanned_documents(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		// JSONObject obj = new JSONObject();

		try {
			String request_type = request.getParameter("request_type");
			// String request_type = request.getParameter("request_type");
			JSONArray arr_r = new JSONArray();

			if (request_type.equals("load_scanned_document")) {

				String suit_number = request.getParameter("suit_number");
				suit_number = suit_number.replace("/", "_");
				String folderpath = cls_url_config.getLegal_document_location() + suit_number;

				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();

				System.out.println(folderpath);

				if (children == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));

						JSONObject obj_r = new JSONObject();

						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);

						arr_r.put(obj_r);
					}

					System.out.println(arr_r.toString());

				}

				// System.out.println(children);
			}

			if (request_type.equals("load_requested_document")) {

				String suit_number = request.getParameter("suit_number");
				suit_number = suit_number.replace("/", "_");
				String folderpath = cls_url_config.getLegal_request_document() + suit_number;

				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();

				if (children == null) {
					System.out.println("Either dir does not exist or is not a directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));

						JSONObject obj_r = new JSONObject();

						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);

						arr_r.put(obj_r);
					}

					System.out.println(arr_r.toString());

				}

			}

			return arr_r.toString();

		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/record_info_serv")
	@PostMapping
	public String record_info(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response,
			HttpServletRequest servletRequest, @RequestParam(value = "file", required = false) MultipartFile file)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		// JSONObject obj = new JSONObject();

		try {
			String request_type = request.getParameter("request_type");
			JSONArray arr_r = new JSONArray();
			JSONObject obj = new JSONObject();
			JSONObject obj_r = new JSONObject();
			String suit_number = request.getParameter("suit_number");
			String case_id = request.getParameter("case_id");
			String web_response = "";

			if (request_type.equals("load_provided_record_info")) {

				obj.put("case_id", new Double(case_id).intValue());
				obj.put("suit_number", suit_number);

				// System.out.println(obj);

				web_response = cls_suits.load_provided_record_info(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				// System.out.println(web_response);

				if (web_response != null) {
					// System.out.println(web_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}

				return web_response;
			}

			if (request_type.equals("load_requested_record_info")) {

				obj.put("case_id", new Double(case_id).intValue());
				obj.put("suit_number", suit_number);

				// System.out.println(obj);

				web_response = cls_suits.load_requested_record_info(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				// System.out.println(web_response);

				if (web_response != null) {
					// System.out.println(web_response);
				} else {

					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}

				return web_response;
			}

			if (request_type.equals("provide_record_info")) {

				String notes = request.getParameter("notes");
				String provided_by = (String) session.getAttribute("userid");
				String division = (String) session.getAttribute("division");
				String regional_code = (String) session.getAttribute("regional_code");
				String unit_name = (String) session.getAttribute("unit_name");
				String attach_file = request.getParameter("attach_file");

				obj.put("suit_number", suit_number);
				obj.put("case_id", new Double(case_id).intValue());
				obj.put("notes", notes);
				obj.put("region", regional_code);
				obj.put("division", division);
				obj.put("unit", unit_name);
				obj.put("provided_by", provided_by);

				System.out.println(obj);
				System.out.println(attach_file);

				if (attach_file.equals("")) {
					attach_file = "false";
					obj.put("attach_file", attach_file);

					web_service_response = cls_suits.provide_record_info(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

					if (web_service_response != null) {
						System.out.println(web_service_response);

					} else {
						obj_r.put("success", false);
						obj_r.put("msg", "Error occurred");
					}

					return web_service_response;
				}

				else {

					attach_file = "true";
					obj.put("attach_file", attach_file);

					String type_of_document = "provided_info";
					String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss")
							.format(Calendar.getInstance().getTime());
					// String web_service_response = "";
					String suit_upload = suit_number.replace("/", "_");
					String type_of_document_upload = type_of_document.replace(" ", "_");

					String fileName = file.getOriginalFilename();
					// String path =
					// servletRequest.getSession().getServletContext().getRealPath("/"+File.separator+fileName);

					String path = cls_url_config.getLc_temp_folder() + suit_upload;

					InputStream is = file.getInputStream();

					boolean success = writeToFile(is, path);

					if (success) {
						System.out.println("File Uploaded to this directory: " + path);

						// File file = new File(path + fileName);

						// JSONObject obj = new JSONObject();
						obj.put("suit_number", suit_number);
						obj.put("type_of_document", type_of_document);
						obj.put("fileName", fileName);
						// obj.put("case_number", Double.valueOf(case_number).intValue());
						// obj.put("case_id", Double.valueOf(case_id).intValue());
						String newpath = cls_url_config.getLegal_provide_document() + suit_upload;

						// Creating a File object
						File filedir = new File(newpath);
						File sourcePath = new File(path);
						File destinationPath = new File(
								newpath + "/" + type_of_document_upload + "_" + timeStamp + "_" + fileName);

						// Creating the directory
						if (!filedir.exists()) {
							boolean bool = filedir.mkdir();
							if (bool) {
								fileCopy(sourcePath, destinationPath);
								obj.put("location", destinationPath);
								web_service_response = cls_suits.provide_record_info(
										cls_url_config.getWeb_service_url_ser(),
										cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

								// return "/legal/record_info.jsp";
								// return "/legal/work_record_info.jsp?success=true";
								// return web_response;
							} else {
								System.out.println("Sorry couldn't create specified directory");
								request.setAttribute("status", "failed");

								// return web_service_response;
							}
						} else {
							System.out.println("Directory already exist");

							fileCopy(sourcePath, destinationPath);
							obj.put("location", destinationPath);

							web_service_response = cls_suits.provide_record_info(
									cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

							// return "/legal/work_record_info.jsp?success=true";
							return web_service_response;
						}

					}

				}

			}

		} catch (Exception e) {
			// TODO: handle exception
		}

		return null;
	}

	@RequestMapping("/work_record_info_serv")
	@PostMapping
	public String work_record_info(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		String web_service_response = null;
		// JSONObject obj = new JSONObject();

		try {
			String suit_number = request.getParameter("suit_number");
			System.out.println(suit_number);
			JSONObject obj = new JSONObject();
			// JSONObject obj_r = new JSONObject();;

			String pdfFileName = "acknowledgeslip.pdf";

			String request_type = request.getParameter("request_type");

			if (request_type.equals("print_request")) {

				String deadline = request.getParameter("deadline");
				String subject = request.getParameter("subject");
				String description = request.getParameter("description");
				String requested_by = request.getParameter("requested_by");

				obj.put("suit_number", suit_number);
				obj.put("deadline", deadline);
				obj.put("subject", subject);
				obj.put("description", description);
				obj.put("requested_by", requested_by);

				// cls_suits.receive_cases(cls_url_config.getWeb_service_url_ser(),
				// cls_url_config.getWeb_service_url_ser_api_key(), list);

				String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
				String files_pdf_jackets_p = cls_url_config.getLegal_batch_list_location() + "batch_list" + "_"
						+ timeStamp + ".pdf";

						byte[] buffer = null;

						// Generate the PDF as a byte array
						buffer = cls_legal_docs.create_print_request(
						cls_url_config.getSoftfile_location(),
						suit_number, deadline, subject, description, requested_by, files_pdf_jackets_p, timeStamp,
						session.getAttribute("web_comp_address").toString(),
						session.getAttribute("web_city").toString(),
						session.getAttribute("web_telephone").toString(),
						session.getAttribute("web_fax_number").toString(),
						session.getAttribute("web_email").toString());

				// File pdfFile = new File(files_pdf_jackets_p);
				// byte[] buffer = null;

				// BufferedInputStream is = new BufferedInputStream(new
				// FileInputStream(pdfFile));
				// ByteArrayOutputStream bos = new ByteArrayOutputStream((int)
				// pdfFile.length());

				// int ch;
				// long actual = 0;
				// while ((ch = is.read()) != -1) {
				// bos.write(ch);
				// actual++;
				// }
				// bos.flush();
				// bos.close();
				// buffer = bos.toByteArray();

				// response.setContentType("application/pdf");
				// response.addHeader("Content-Disposition", "inline;
				// filename=Documentation.pdf");
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
			}

			return web_service_response;

		} catch (Exception e) {
			// TODO: handle exception
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
}
