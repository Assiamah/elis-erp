package com.mit.elis.servlets;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;

import org.codehaus.jettison.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.mit.elis.class_common.cls_casemgt_reports;

import org.springframework.beans.factory.annotation.Autowired;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;

@RestController
public class CaseDocsFromFolder {
	cls_casemgt_reports case_reports_cl = new cls_casemgt_reports();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/CaseDocsFromFolder")
	@GetMapping
	public String create_land_register(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		String request_type = request.getParameter("request_type");

		if (request_type.equals("case_documents_list")) {

			String case_number = request.getParameter("case_number");
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();

			File files_pdf_jackets = new File(contextPath + case_number);

			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_register" + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);

			String files_pdf_jackets_p = contextPath + case_number + "/" + pdfFileName;
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 		// System.out.println("Multiple directories are created!");
			// 	} else {
			// 		System.out.println("Failed to create multiple directories!");
			// 	}
			// }

			// try {
			// 	case_reports_cl.create_land_register(cls_url_config.getWeb_service_url_ser(),
			// 			cls_url_config.getWeb_service_url_ser_api_key(), cls_url_config.getSoftfile_location(),
			// 			case_number, "",
			// 			files_pdf_jackets_p);
			// } catch (SQLException e) {
			// 	// TODO Auto-generated catch block
			// 	e.printStackTrace();
			// } catch (JSONException e) {
			// 	// TODO Auto-generated catch block
			// 	e.printStackTrace();
			// }
			// File pdfFile = new File(contextPath + pdfFileName);
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
			response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
			// response.addHeader("Content-Disposition", "inline;
			// filename=Documentation.pdf");
			response.setContentLength((int) pdfFile.length());
			response.getOutputStream().write(buffer, 0, buffer.length);
		}

		if (request_type.equals("request_to_generate_certificate")) {

			String case_number = request.getParameter("case_number");
			System.out.println(request_type);

			String contextPath = cls_url_config.getCase_upload_location();
			// String contextPath
			// ="C:\\gelisscans\\scanpdf\\LCGARGACN37542018\\";
			String pdfFileName = case_number + "_certificate" + ".pdf";

			// String pdfFileName = "timer.pdf";

			// String contextPath =
			// getServletContext().getRealPath(File.separator);
			File pdfFile = new File(contextPath + case_number + "/" + pdfFileName);

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
			response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
			// response.addHeader("Content-Disposition", "inline;
			// filename=Documentation.pdf");
			response.setContentLength((int) pdfFile.length());
			response.getOutputStream().write(buffer, 0, buffer.length);
		}
		return request_type;

	}
}
