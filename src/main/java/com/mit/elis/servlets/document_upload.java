package com.mit.elis.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import org.springframework.ui.Model;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.mit.elis.class_common.Ws_url_config;

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
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;

@RestController
public class document_upload {
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/document_upload")
	@PostMapping
	public String document_upload(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// gets absolute path of the web application
		// String appPath = request.getServletContext().getRealPath("");
		// constructs path of the directory to save uploaded file
		String case_number = request.getParameter("case_number");
		String file_name_incoming = request.getParameter("file_name");

		// String case_number = "LCGARGAPCN717315620190";
		String savePath = cls_url_config.getCase_upload_location();
		// String savePath = SAVE_DIR;

		savePath = savePath + case_number;

		// String savePath = appPath + "/" + SAVE_DIR;

		// creates the save directory if it does not exists

		File files_pdf_jackets = new File(savePath);

		if (!files_pdf_jackets.exists()) {
			if (files_pdf_jackets.mkdirs()) {
				System.out.println("Multiple directories are created!");
			} else {
				System.out.println("Failed to create multiple directories!");
			}
		}

		System.out.println(savePath);
		System.out.println(savePath + File.separator);
		System.out.println(request.getParts());
		for (Part part : request.getParts()) {
			String fileName = extractFileName(part);
			// refines the fileName in case it is an absolute path
			System.out.println("path");
			System.out.println(fileName);

			fileName = new File(fileName).getName();
			System.out.println("file");
			System.out.println(fileName);
			System.out.println(savePath + "/" + fileName);
			part.write(savePath + "/" + file_name_incoming);
		}

		// out.println("Upload has been done successfully!");
		return "Upload has been done successfully!";
		// request.setAttribute("message", "Upload has been done
		// successfully!");
		// getServletContext().getRequestDispatcher("/message.jsp").forward(
		// request, response);

	}


	@RequestMapping("/document_upload_new")
	@PostMapping
	public String document_upload_new(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response, 
									@RequestParam(value = "sampleFile", required = false) MultipartFile file) 
									throws IOException, ServletException {

		// Check if session is valid
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		// Get additional parameters
		String caseNumber = request.getParameter("case_number");
		String fileName = request.getParameter("file_name");
		String apiKey = cls_url_config.getWeb_service_url_ser_api_key(); 
		// Get the MIME type (document type) of the file
        String mimeType = file.getContentType();
		//System.out.print(file);

		// Check if the file is not empty
		if (file != null && !file.isEmpty()) {
			// Save the MultipartFile to a temporary file
			String filename=getFileNameWithoutExtension(file);
			File tempFile = convertMultipartFileToFile(file);

			// Send the file to the external API
			String apiUrl = cls_url_config.getDoc_mgt_api() + "document_upload/file_upload_public_backend";  // Target API URL
			uploadPdf(apiUrl, tempFile, caseNumber, cls_url_config.getDoc_mgt_api_key(), "case_docs", mimeType,filename);

			// Delete the temporary file after uploading
			tempFile.delete();
		}

		return "Upload has been done successfully!"; // Return the success page
	}

	
	@RequestMapping("/document_upload_mutiple_new")
	@PostMapping
	public String document_upload_mutiple_new(HttpSession session, Model model, HttpServletRequest request, 
						HttpServletResponse response,
						@RequestParam(value = "sampleApplicationFile", required = true) MultipartFile[] files) 
						throws IOException, ServletException {

		// Check if session is valid
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			request.setAttribute("login", "sessionout");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		// Get additional parameters
		String caseNumber = request.getParameter("case_number");
		String fileName = request.getParameter("file_name");
		String apiKey = cls_url_config.getWeb_service_url_ser_api_key(); 
		String apiUrl = cls_url_config.getDoc_mgt_api() + "document_upload/file_upload_public_backend";
		// Get the MIME type (document type) of the file
        // String mimeType = file.getContentType();
		// //System.out.print(file);

		// // Check if the file is not empty
		// if (file != null && !file.isEmpty()) {
		// 	// Save the MultipartFile to a temporary file
		// 	String filename=getFileNameWithoutExtension(file);
		// 	File tempFile = convertMultipartFileToFile(file);

		// 	// Send the file to the external API
		// 	String apiUrl = cls_url_config.getDoc_mgt_api() + "document_upload/file_upload_public_backend";  // Target API URL
		// 	uploadPdf(apiUrl, tempFile, caseNumber, cls_url_config.getDoc_mgt_api_key(), "case_docs", mimeType,filename);

		// 	// Delete the temporary file after uploading
		// 	tempFile.delete();
		// }

		// Process each file
        if (files != null && files.length > 0) {
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    try {
                        String mimeType = file.getContentType();
						// Save the MultipartFile to a temporary file
						String filename=getFileNameWithoutExtension(file);
						File tempFile = convertMultipartFileToFile(file);

						uploadPdf(apiUrl, tempFile, caseNumber, cls_url_config.getDoc_mgt_api_key(), "case_docs", mimeType,filename);

						// Delete the temporary file after uploading
						tempFile.delete();

                    } catch (Exception e) {
                        System.out.println("Error uploading file: " + file.getOriginalFilename() + 
                                         ". Error: " + e.getMessage());
                    }
                }
            }
        }

		return "Upload has been done successfully!"; // Return the success page
	}

	private String extractFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return "";
	}

	@SuppressWarnings("null")
	private File convertMultipartFileToFile(MultipartFile file) throws IOException {
		// Create a temporary file
		String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
        String fileName = file.getOriginalFilename();
		fileName = fileName.replace(".pdf","");
		//File tempFile = File.createTempFile("upload-", file.getOriginalFilename());
		File tempFile = File.createTempFile(fileName, timeStamp + ".pdf");
		try (FileOutputStream fos = new FileOutputStream(tempFile)) {
			fos.write(file.getBytes());
		}
		return tempFile;
	}

	public static void uploadPdf(String apiUrl, File pdfFile, String caseNumber, String apiKey, String document_type, String mimeType,String filename) {
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
		body.add("case_number", caseNumber);       // Attach the additional string parameter
		body.add("document_type", document_type); 
		body.add("document_open_type", mimeType); 
		body.add("job_number", caseNumber);
		body.add("doc_name", filename);
		 

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

	public String getFileNameWithoutExtension(MultipartFile file) {
        String originalFileName = file.getOriginalFilename();
        
        if (originalFileName != null && originalFileName.contains(".")) {
            return originalFileName.substring(0, originalFileName.lastIndexOf('.'));
        }
        return originalFileName; // No extension found, return the file name as is.
    }
}
