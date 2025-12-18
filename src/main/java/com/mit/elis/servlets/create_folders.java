package com.mit.elis.servlets;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

@RestController
public class create_folders {
	private static final String SAVE_DIR = "C:/guru/upload";

	@RequestMapping("/create_folders")
	@PostMapping
	public String create_folders(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		// File file = new File("C:\\gelisscans\\file_list.txt");

		// BufferedReader br = new BufferedReader(new FileReader(file));

		// for (String line : Files.readAllLines(Paths.get("C:\\gelisscans\\file_list.txt"))) {
		// 	// File pdfFile = new File(SAVE_DIR + line);
		// 	File files_pdf_jackets = new File(SAVE_DIR + "/" + line);
		// 	// String files_pdf_jackets_p =contextPath+ "LCGARGACN37542018" +
		// 	// "\\"+ pdfFileName;
		// 	if (!files_pdf_jackets.exists()) {
		// 		if (files_pdf_jackets.mkdirs()) {
		// 			System.out.println("Multiple directories are created!");
		// 		} else {
		// 			System.out.println("Failed to create multiple directories!");
		// 		}
		// 	}
		// }
		return null;

		// String st;
		// while ((st = br.readLine()) != null)
		// System.out.println(st);

		// String.split("[\\r\\n]+")
		// String lines[] = st.split("(\r\n|\r|\n)", -1);
		// String lines[] = st.split("[\\r\\n]+");

		// String strInput = "Line1\r\nLine2\nLine3\rLine4";

		// String[] strParts = st.split("\\r?\\n|\\r");

		// System.out.println("Total lines: " + strParts.length);

		// String lines[] = st.split("");
		// System.out.println(lines.length);
		/*
		 * File pdfFile = new File(SAVE_DIR + st); File files_pdf_jackets = new
		 * File(SAVE_DIR + File.separator+ st); //String files_pdf_jackets_p
		 * =contextPath+
		 * "LCGARGACN37542018" + File.separator+ pdfFileName; if
		 * (!files_pdf_jackets.exists()) { if (files_pdf_jackets.mkdirs()) {
		 * System.out.println("Multiple directories are created!"); } else {
		 * System.out.println("Failed to create multiple directories!"); } }
		 */

	}

}
