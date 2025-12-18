package com.mit.elis.servlets.casemgt;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
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

import ws.casemgt.cls_case_documents;
import ws.casemgt.cls_casemgt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class open_pdffile {

	@Autowired
	private Ws_url_config cls_url_config;

	cls_case_documents cls_public_mgt= new cls_case_documents();

	@RequestMapping("/open_pdffile")
	@PostMapping
	public String open_pdffile(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, JSONException {

		
				if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
					// Session is expired
					request.setAttribute("login", "sessionout");
					System.out.println("If Not success");
					 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		
				}
				System.out.println("If Not succcvccess");
				// Get the "file_to_open" parameter from the request (you can change this according to your form)
				String fileToOpen = request.getParameter("file_to_open");
			
				// Ensure file_to_open is not null or empty
				if (fileToOpen == null || fileToOpen.isEmpty()) {
					response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing file_to_open parameter");
					return null;
				}
				System.out.println("If Not 66666");
				// Create a JSON object with doc_uuid
				JSONObject obj = new JSONObject();
				try {
					obj.put("doc_uuid", fileToOpen);
					//obj.put("doc_uuid", "44bd40f4-7733-11ef-a814-000c2930f1ec");
		
				// Read the InputStream from the external service
		InputStream pdf_blob = cls_public_mgt.open_doc_by_unique_id_new_vlob(
			 cls_url_config.getDoc_mgt_api(),
			//"http://10.4.1.47:1031/",
			cls_url_config.getDoc_mgt_api_key(),
			obj.toString()
		);
	
		
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
			// Set the content length of the response based on the size of the PDF in bytes
			response.setContentLength(pdfBytes.length);
			
			// Write the PDF byte array to the output stream to send it to the client
			response.getOutputStream().write(pdfBytes, 0, pdfBytes.length);
			
			// Flush the output stream
			response.getOutputStream().flush();
			
			// Close the output stream
			response.getOutputStream().close();
		} else {
			// Handle the case where the PDF could not be generated
			response.setContentType("text/html");
			response.getWriter().write("Error generating PDF.");
		}
		
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} // Adding the doc_uuid to the JSON object
		
				return null;

	}


	//@SuppressWarnings("deprecation")
	@RequestMapping("/open_pdffile_new")
	@PostMapping
	public String open_pdffile_new(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		System.out.println("If Not success");
		// Get the "file_to_open" parameter from the request (you can change this according to your form)
        String fileToOpen = request.getParameter("file_to_open");
		System.out.println(fileToOpen);
		System.out.println("fileToOpen");
        // Ensure file_to_open is not null or empty
        if (fileToOpen == null || fileToOpen.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing file_to_open parameter");
            return null;
        }

        // Create a JSON object with doc_uuid
        JSONObject obj = new JSONObject();
      
			//JSONObject obj = new JSONObject();
			try {
				obj.put("doc_uuid", fileToOpen);
				//obj.put("doc_uuid", "ec248374-7743-11ef-a814-000c2930f1ec");
				System.out.println(fileToOpen);
				System.out.println("fileToOpen");

				System.out.println(obj.toString());
				System.out.println("obj.toString()");


			// Read the InputStream from the external service
	InputStream pdf_blob = cls_public_mgt.open_doc_by_unique_id_new_vlob(
		 cls_url_config.getDoc_mgt_api(),
		//"http://10.4.1.47:1031/",
		cls_url_config.getDoc_mgt_api_key(),
		obj.toString()
	);

	
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
    // Set the content length of the response based on the size of the PDF in bytes
    response.setContentLength(pdfBytes.length);
    // Write the PDF byte array to the output stream to send it to the client
    response.getOutputStream().write(pdfBytes, 0, pdfBytes.length);
    // Flush the output stream
    response.getOutputStream().flush();
    // Close the output stream
    response.getOutputStream().close();
} else {
    // Handle the case where the PDF could not be generated
    response.setContentType("text/html");
    response.getWriter().write("Error generating PDF.");
}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // Adding the doc_uuid to the JSON object

		return null;

	}

	

	@RequestMapping("/delete_document_by_doc_uuid")
	@PostMapping
	public String delete_document_by_doc_uuid(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		System.out.println("If Not success");
		// Get the "file_to_open" parameter from the request (you can change this according to your form)
        String fileToOpen = request.getParameter("file_to_open");
		System.out.println(fileToOpen);
		System.out.println("fileToOpen");
        // Ensure file_to_open is not null or empty
        if (fileToOpen == null || fileToOpen.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing file_to_open parameter");
            return null;
        }

		String webservice = "";

        // Create a JSON object with doc_uuid
        JSONObject obj = new JSONObject();
      
			//JSONObject obj = new JSONObject();
			try {
				obj.put("doc_uuid", fileToOpen);
				obj.put("modified_by_id", (String) session.getAttribute("userid"));
				obj.put("modified_by", (String) session.getAttribute("fullname"));
	
				System.out.println(fileToOpen);
				
				webservice = cls_public_mgt
						.delete_document_by_doc_uuid(cls_url_config.getDoc_mgt_api_v1(),
						//"http://10.4.1.47:1031/",
						cls_url_config.getDoc_mgt_api_v1_key(), obj.toString());
				if (webservice != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(webservice);
				}

				return webservice;

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // Adding the doc_uuid to the JSON object

		return null;

	}

	

	@RequestMapping("/reverse_document_by_doc_uuid")
	@PostMapping
	public String reverse_document_by_doc_uuid(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		System.out.println("If Not success");
		// Get the "file_to_open" parameter from the request (you can change this according to your form)
        String fileToOpen = request.getParameter("file_to_open");
		System.out.println(fileToOpen);
		System.out.println("fileToOpen");
        // Ensure file_to_open is not null or empty
        if (fileToOpen == null || fileToOpen.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing file_to_open parameter");
            return null;
        }

		String webservice = "";

        // Create a JSON object with doc_uuid
        JSONObject obj = new JSONObject();
      
			//JSONObject obj = new JSONObject();
			try {
				obj.put("doc_uuid", fileToOpen);
				obj.put("modified_by_id", (String) session.getAttribute("userid"));
				obj.put("modified_by", (String) session.getAttribute("fullname"));
	
				System.out.println(fileToOpen);
				
				webservice = cls_public_mgt
						.reverse_document_by_doc_uuid(cls_url_config.getDoc_mgt_api_v1(),
						//"http://10.4.1.47:1031/",
						cls_url_config.getDoc_mgt_api_v1_key(), obj.toString());
				if (webservice != null) {
					// System.out.println(web_service_response);
				} else {
					System.out.println(webservice);
				}

				return webservice;

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // Adding the doc_uuid to the JSON object

		return null;

	}
}
