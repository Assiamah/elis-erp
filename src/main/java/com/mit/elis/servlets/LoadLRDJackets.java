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
import ws.legal.ws_suits;

import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import ws.casemgt.cls_case_documents;

@RestController
public class LoadLRDJackets {

	@Autowired
	private Ws_url_config cls_url_config;

	cls_case_documents cls_case_documents = new cls_case_documents();

	@RequestMapping("/LoadLRDJackets")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {

			String request_type = request.getParameter("request_type");
			JSONArray arr_r = new JSONArray();
			JSONObject obj = new JSONObject();
			Gson googleJson = new Gson();

			if (request_type.equals("load_case_scanned_document")) {

				String certificate_number = request.getParameter("case_number");
				String folderpath = cls_url_config.getCase_upload_location() + certificate_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " +
						// certificate_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + "/" + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));

						JSONObject obj_r = new JSONObject();

						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// System.out.println(arr_r.toString());

			}

			if (request_type.equals("load_case_scanned_document_public")) {

				String certificate_number = request.getParameter("case_number");
				String folderpath = cls_url_config.getPublic_docs_upload_location() + certificate_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " +
						// certificate_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + File.separator + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));

						JSONObject obj_r = new JSONObject();

						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				System.out.println(arr_r.toString());
			}

			if (request_type.equals("load_case_scanned_document_new")) {

				String case_number = request.getParameter("case_number");
				obj.put("doc_reference_number", case_number);
				obj.put("document_type", "case_docs");
				
					
				System.out.println(obj.toString());

				String web_response = cls_case_documents.select_case_documents_by_case_number(cls_url_config.getDoc_mgt_api(), cls_url_config.getDoc_mgt_api_key(), obj.toString());
				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String docs_data = web_response_case.get("data").toString(); 
				//System.out.println(docs_data);

				return docs_data;
			}

			if (request_type.equals("load_case_scanned_document_new_admin")) {

				String case_number = request.getParameter("case_number");
				obj.put("doc_reference_number", case_number);
				obj.put("document_type", "case_docs");
				
					
				System.out.println(obj.toString());

				String web_response = cls_case_documents.select_doc_files_details_by_reference_number_backend_admin(cls_url_config.getDoc_mgt_api(), cls_url_config.getDoc_mgt_api_key(), obj.toString());
				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String docs_data = web_response_case.get("data").toString(); 
				//System.out.println(docs_data);

				return docs_data;
			}

			

			if (request_type.equals("load_case_scanned_document_public_new")) {

				String case_number = request.getParameter("case_number");
				obj.put("doc_reference_number", case_number);
				obj.put("document_type", "public_docs");
				
				System.out.println(obj.toString());
				
				String web_response = cls_case_documents.select_case_documents_by_case_number(cls_url_config.getDoc_mgt_api(), cls_url_config.getDoc_mgt_api_key(), obj.toString());
				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String docs_data = web_response_case.get("data").toString(); 
				//System.out.println(docs_data);

				return docs_data;
			}

			

			if (request_type.equals("load_case_scanned_document_public_new_admin")) {

				String case_number = request.getParameter("case_number");
				obj.put("doc_reference_number", case_number);
				obj.put("document_type", "public_docs");
				
				System.out.println(obj.toString());
				
				String web_response = cls_case_documents.select_doc_files_details_by_reference_number_backend_admin(cls_url_config.getDoc_mgt_api(), cls_url_config.getDoc_mgt_api_key(), obj.toString());
				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String docs_data = web_response_case.get("data").toString(); 
				//System.out.println(docs_data);

				return docs_data;
			}

			if (request_type.equals("load_lrd_jacket_certificate")) {

				String certificate_number = request.getParameter("certificate_number");
				String folderpath = cls_url_config.getLrd_jacket_raw_path() + certificate_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " +
						// certificate_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + File.separator + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));

						JSONObject obj_r = new JSONObject();

						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// System.out.println(arr_r.toString());

			}

			if (request_type.equals("load_pvlmd_garro_file")) {

				String certificate_number = request.getParameter("certificate_number");
				String folderpath = cls_url_config.getLrd_jacket_raw_path() + certificate_number;
				// System.out.println("folderpath: " +folderpath);
				// List All Files In a Folder
				File subdir = new File(folderpath.toString());
				String[] children = subdir.list();
				if (children == null) {
					// System.out.println("Either dir does not exist or is not a
					// directory");
				} else {
					for (int j = 0; j < children.length; j++) {
						String filename_doc = children[j];
						// System.out.println("case_number: " +
						// certificate_number);
						// System.out.println("File: " + filename_doc);
						String path = folderpath.toString() + File.separator + filename_doc;

						String extension = filename_doc.substring(filename_doc.lastIndexOf("."));

						JSONObject obj_r = new JSONObject();

						// obj_r.put( "d_id" , 0 );
						// obj_r.put( "job_number" , "SMDGARGA37542018" );
						// obj_r.put( "case_number" , "LCGARGACN37542018" );
						obj_r.put("document_name", filename_doc);
						obj_r.put("document_type", path);
						obj_r.put("document_extention", extension);
						obj_r.put("document_file", path);
						obj_r.put("uploaded_by", "");
						obj_r.put("uploaded_date", "");

						arr_r.put(obj_r);
					}

				}
				// System.out.println(arr_r.toString());

			}
			// System.out.println(arr_r.toString());

			return arr_r.toString();
			// out.println(arr_r.toString());
			// out.close();

			// obj_ar.put( "success" , true );

			// obj_ar.put( "data" , arr_r.toString() );

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}
}
