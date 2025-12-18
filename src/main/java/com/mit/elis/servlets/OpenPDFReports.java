package com.mit.elis.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import org.springframework.beans.factory.annotation.Autowired;

@RestController
public class OpenPDFReports {
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/OpenPDFReports")
	@PostMapping
	public String OpenPDFReportsPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		// String request_type = request.getParameter("request_type");

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		String document_path = request.getParameter("document_path");
		System.out.println(document_path);
		// String pdfFileName = "case_doc.pdf";

		File pdfFile = new File(document_path);

		response.setContentType("application/pdf");
		// response.addHeader("Content-Disposition", "attachment; filename=" +
		// pdfFileName);
		response.addHeader("Content-Disposition", "inline; filename=Documentation.pdf");
		response.setContentLength((int) pdfFile.length());

		FileInputStream fileInputStream = new FileInputStream(pdfFile);
		OutputStream responseOutputStream = response.getOutputStream();
		int bytes;
		while ((bytes = fileInputStream.read()) != -1) {
			responseOutputStream.write(bytes);
		}

		responseOutputStream.flush();
		responseOutputStream.close();
		return document_path;

	}
}
