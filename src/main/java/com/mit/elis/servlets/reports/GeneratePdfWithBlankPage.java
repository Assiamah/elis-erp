package com.mit.elis.servlets.reports;

import java.io.File;
import java.io.FileFilter;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class GeneratePdfWithBlankPage {

	@RequestMapping("/GeneratePdfWithBlankPage")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		JSONObject obj_r = new JSONObject();
		// Cls_reports reports_cl = new Cls_reports();
		/*
		 * String directories = "D:\\scandoc\\casenumber\\jobume2"; File file =
		 * new File(directories); boolean result= false;
		 * 
		 * if (!file.exists()) { System.out.println("creating directory: " +
		 * file.getName()); // boolean result = false;
		 * 
		 * try { result = file.mkdirs(); file.mkdirs(); result = true;
		 * System.out.println("Status = " + result); } catch (SecurityException
		 * se) { // handle it System.out.println(se.getMessage()); } if (result)
		 * { System.out.println("Folder created"); } } else if (file.exists()) {
		 * 
		 * System.out.println("Folder exist"); }
		 * 
		 * try { obj_r.put( "success" , true ); obj_r.put( "msg" , result );
		 * 
		 * out.println(obj_r.toString()); out.close(); } catch (JSONException e)
		 * { // TODO Auto-generated catch block e.printStackTrace(); }
		 */

		// List All Files In a Folder

		/*
		 * //List All Folders in a Folder File dir = new
		 * File("D:\\gelisscans\\jackets"); File[] files = dir.listFiles();
		 * FileFilter fileFilter = new FileFilter() { public boolean accept(File
		 * file) { return file.isDirectory(); } }; files =
		 * dir.listFiles(fileFilter); System.out.println(files.length);
		 * 
		 * if (files.length == 0) {
		 * System.out.println("Either dir does not exist or is not a directory"
		 * ); } else { for (int i = 0; i< files.length; i++) { File foldername =
		 * files[i]; System.out.println("Folder: " + foldername.toString());
		 * //List All Files In a Folder File subdir = new
		 * File(foldername.toString()); String[] children = subdir.list(); if
		 * (children == null) { System.out.println(
		 * "Either dir does not exist or is not a directory"); } else { for (int
		 * j = 0; j< children.length; j++) { String filename = children[j];
		 * System.out.println("File: " +filename); } } //List All Files In a
		 * Folder// End
		 * 
		 * } }
		 */

		// List All Folders in a Folder

		String pdf_dest = "C:\\gelisscans\\scanpdf\\";
		File dir = new File("C:\\gelisscans\\jackets");
		File[] files = dir.listFiles();
		FileFilter fileFilter = new FileFilter() {
			public boolean accept(File file) {
				return file.isDirectory();
			}
		};

		files = dir.listFiles(fileFilter);
		// System.out.println(files.length);

		if (files.length == 0) {
			// System.out.println("Either dir does not exist or is not a
			// directory");
		} else {
			for (int i = 0; i < files.length; i++) {
				File foldername = files[i];
				// System.out.println("Folder: " + foldername.toString());
				// System.out.println("pdf_dest: " + pdf_dest);
				// System.out.println("Folder: " +
				// foldername.getName().toString());

				File files_pdf_jackets = new File(pdf_dest + foldername.getName().toString());
				String files_pdf_jackets_p = pdf_dest + foldername.getName().toString() + File.separator;
				// if (!files_pdf_jackets.exists()) {
				// 	if (files_pdf_jackets.mkdirs()) {
				// 		// System.out.println("Multiple directories are
				// 		// created!");
				// 	} else {
				// 		// System.out.println("Failed to create multiple
				// 		// directories!");
				// 	}
				// }

				/*
				 * try { //reports_cl.createregionalnumberbill(pdf_dest
				 * ,foldername.toString(),foldername.getName().toString());
				 * reports_cl.createregionalnumberbill(files_pdf_jackets_p
				 * ,foldername.toString(),foldername.getName().toString()); }
				 * catch (DocumentException e) { // TODO Auto-generated catch
				 * block e.printStackTrace(); }
				 */

			}
		}
		try {
			obj_r.put("success", true);
			obj_r.put("msg", "Greated");

			// out.println(obj_r.toString());
			// out.close();
			return "";
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pdf_dest;

	}
}
