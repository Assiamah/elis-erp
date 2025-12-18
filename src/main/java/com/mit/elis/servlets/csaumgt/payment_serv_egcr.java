package com.mit.elis.servlets.csaumgt;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import org.springframework.ui.Model;
// import jakarta.ws.rs.core.Response;
// import jakarta.ws.rs.core.Response.ResponseBuilder;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class payment_serv_egcr {
	Ws_client_application casemgt_cl = new Ws_client_application();
	CSAU_billgeneration billgeneration_cl = new CSAU_billgeneration();

	@Autowired
	private Ws_url_config cls_url_config;

	ws_csaupayment csaupayment_cl = new ws_csaupayment();

	@RequestMapping("/payment_serv_egcr")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

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

			if (request_type.equals("generate_egcr")) {
				String ref_number = request.getParameter("ref_number");
				String receipt_number = request.getParameter("receipt_number");
				System.out.println(ref_number);
				System.out.println(receipt_number);
				/*
				 * JSONObject obj_d = new JSONObject(); obj_d.put("ref_number",
				 * ref_number); obj_d.put("receipt_number", ref_number);
				 */

				if (receipt_number.length() > 4) {
				
					InputStream pdf_blob = billgeneration_cl.generate_egcr_get_pdf(cls_url_config.getEgcr_url(),
							cls_url_config.getEgcr_apikey(), receipt_number);

				

							byte[] buffer = new byte[1024]; // Initialize buffer for reading input in chunks
							ByteArrayOutputStream outputStream = new ByteArrayOutputStream(); // For holding the PDF data
							int bytesRead;	
							// Read the InputStream and write to the ByteArrayOutputStream
							while ((bytesRead = pdf_blob.read(buffer)) != -1) {
								// Write the bytes to the output stream
								outputStream.write(buffer, 0, bytesRead);
							}
							// Convert the ByteArrayOutputStream to a byte array containing the full PDF
							byte[] pdfBytes = outputStream.toByteArray();
							// Close the input stream
							pdf_blob.close();
							// Close the ByteArrayOutputStream
							outputStream.close();
							
							// If the PDF data was successfully read
							if (pdfBytes != null && pdfBytes.length > 0) {
								
								// Set response content type to PDF
								response.setContentType("application/pdf");
												
								// Set the content-disposition header to download the file with the specified name
								response.addHeader("Content-Disposition", "attachment; filename=" + "pdfFileName.pdf");
								
								// Set the content length of the response based on the buffer length (size of the PDF in bytes)
								response.setContentLength(pdfBytes.length);
								
								// Write the PDF byte array to the output stream to download it
								response.getOutputStream().write(pdfBytes, 0, pdfBytes.length);
								
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
					response.setContentType("text/html");
								response.getWriter().write("Error generating PDF.");
				}

			

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
