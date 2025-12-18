package com.mit.elis.servlets;

import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

@RestController
public class LoadCaseDocuments {

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/LoadCaseDocuments")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		try {

			if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
				// Session is expired
				request.setAttribute("login", "sessionout");
				System.out.println("If Not success");
				 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

			}

			// JSONObject obj_ar = new JSONObject();
			JSONArray arr_r = new JSONArray();
			String case_number = request.getParameter("case_number");
			// cls_reports reports_cl = new cls_reports();

			// List All Folders in a Folder

			String folderpath = cls_url_config.getCase_upload_location() + case_number;
			// System.out.println("folderpath: " +folderpath);
			// List All Files In a Folder
			File subdir = new File(folderpath.toString());
			String[] children = subdir.list();
			if (children == null) {
				System.out.println("Either dir does not exist or is not a directory");
			} else {
				for (int j = 0; j < children.length; j++) {
					String filename_doc = children[j];
					System.out.println("case_number: " + case_number);
					System.out.println("File: " + filename_doc);
					String path = folderpath.toString() + "/" + filename_doc;

					String extension = filename_doc.substring(filename_doc.lastIndexOf("."));

					JSONObject obj_r = new JSONObject();

					obj_r.put("d_id", 0);
					obj_r.put("job_number", "SMDGARGA37542018");
					obj_r.put("case_number", "LCGARGACN37542018");
					obj_r.put("document_name", filename_doc);
					obj_r.put("document_type", path);
					obj_r.put("document_extention", extension);
					obj_r.put("document_file", path);
					obj_r.put("uploaded_by", "");
					obj_r.put("uploaded_date", "");

					arr_r.put(obj_r);
				}

			}

			// obj_ar.put( "success" , true );

			// obj_ar.put( "data" , arr_r.toString() );
			System.out.println(arr_r.toString());

			return arr_r.toString();
			// out.println(arr_r.toString());
			// out.close();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}
}
