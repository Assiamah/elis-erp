package com.mit.elis.controllers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import org.springframework.ui.Model;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.mit.elis.class_common.Ws_url_config;

import ws.casemgt.cls_casemgt;
import ws.legal.legal_docs;
import ws.legal.ws_suits;
@Controller
public class LegalController {
    
    @Autowired
	private Ws_url_config cls_url_config;

    ServletRequest servletContext;

	cls_casemgt casemagt_cl = new cls_casemgt();
	ws_suits cls_suits = new ws_suits();
    legal_docs cls_legal_docs = new legal_docs();

	@RequestMapping("/secretariat")
	@GetMapping
	public String secretariat(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

					model.addAttribute("content", "../pages/legal/secretariat.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

    @RequestMapping("/case_details")
	@GetMapping
	public String case_details_get(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String suit_number = request.getParameter("suit_number");
			//String case_id =request.getParameter("case_id");
            System.out.println(suit_number);
            String web_response = null;
			JSONObject obj = new JSONObject();
			Gson googleJson = new Gson();
			//JSONObject obj_r = new JSONObject();
			
			obj.put("suit_number", suit_number);

			web_response = cls_suits.load_further_entry(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				
			System.out.println(web_response);

			JSONObject web_response_case = new JSONObject(web_response); 
			String case_details = web_response_case.get("data").toString(); 

			ArrayList case_details_list = googleJson.fromJson(case_details, ArrayList.class);
			request.setAttribute("case_detail",case_details_list);

					model.addAttribute("content", "../pages/legal/case_details.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

	@RequestMapping("/case_details_post")
	@PostMapping
	public String case_details_post(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String suit_number = request.getParameter("suit_number");
			String case_id =request.getParameter("case_id");
            System.out.println(suit_number);
            String web_response = null;
			JSONObject obj = new JSONObject();
			Gson googleJson = new Gson();
			//JSONObject obj_r = new JSONObject();
			String request_type =request.getParameter("request_type");

			if (request_type.equals("case_details")) {

				obj.put("case_id",  new Double(case_id).intValue());
				obj.put("suit_number", suit_number);

				web_response = cls_suits.load_further_entry(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String case_details = web_response_case.get("data").toString(); 

				ArrayList case_details_list = googleJson.fromJson(case_details, ArrayList.class);
				request.setAttribute("case_detail",case_details_list);

						model.addAttribute("content", "../pages/legal/case_details.jsp"); return "layouts/app";
			}

			if (request_type.equals("case_details_case")) {

				obj.put("case_id",  new Double(case_id).intValue());
				obj.put("suit_number", suit_number);

				web_response = cls_suits.load_further_entry(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String case_details = web_response_case.get("data").toString(); 

				ArrayList case_details_list = googleJson.fromJson(case_details, ArrayList.class);
				request.setAttribute("case_detail",case_details_list);

						model.addAttribute("content", "../pages/legal/case_details.jsp"); return "layouts/app";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/case_enquiry")
	@GetMapping
	public String case_enquiry(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {
            String web_response = null;
            Gson googleJson = new Gson();
			web_response = cls_suits.all_cases(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
				
			System.out.println(web_response);

			JSONObject web_response_case = new JSONObject(web_response); 
			String all_cases = web_response_case.get("data").toString(); 

			ArrayList cases_list = googleJson.fromJson(all_cases, ArrayList.class);
			request.setAttribute("cases",cases_list);

					model.addAttribute("content", "../pages/legal/case_enquiry.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/case_work")
	@PostMapping
	public String case_work(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String suit_number = request.getParameter("suit_number");
			String case_id = request.getParameter("case_id");
            System.out.println(suit_number);
            String web_response = null;
			JSONObject obj = new JSONObject();
			Gson googleJson = new Gson();
			//JSONObject obj_r = new JSONObject();
			String request_type =request.getParameter("request_type");

			if (request_type.equals("case_work")) {

				obj.put("case_id",  new Double(case_id).intValue());
				obj.put("suit_number", suit_number);

				web_response = cls_suits.load_case_details(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 

				String case_details = web_response_case.get("data").toString(); 
				ArrayList case_details_list = googleJson.fromJson(case_details, ArrayList.class);
				request.setAttribute("case_detail",case_details_list);

                String suit_cases = web_response_case.get("suit_cases").toString(); 
                ArrayList suit_cases_list = googleJson.fromJson(suit_cases, ArrayList.class);
				request.setAttribute("suit_cases",suit_cases_list);

                String cases_status = web_response_case.get("cases_status").toString(); 
                ArrayList cases_status_list = googleJson.fromJson(cases_status, ArrayList.class);
				request.setAttribute("cases_status",cases_status_list);

                String legal_document_location = cls_url_config.getLegal_document_location();
                String scanned_docs = cls_legal_docs.load_scanned_documents(suit_number, legal_document_location);
                ArrayList scanned_docs_list = googleJson.fromJson(scanned_docs, ArrayList.class);
				request.setAttribute("scanned_docs",scanned_docs_list);

						model.addAttribute("content", "../pages/legal/case_work.jsp"); return "layouts/app";
			}

			if (request_type.equals("case_work_case")) {

				obj.put("case_id",  new Double(case_id).intValue());
				obj.put("suit_number", suit_number);

				web_response = cls_suits.load_case_details(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 

				String case_details = web_response_case.get("data").toString(); 
				ArrayList case_details_list = googleJson.fromJson(case_details, ArrayList.class);
				request.setAttribute("case_detail",case_details_list);

                String suit_cases = web_response_case.get("suit_cases").toString(); 
                ArrayList suit_cases_list = googleJson.fromJson(suit_cases, ArrayList.class);
				request.setAttribute("suit_cases",suit_cases_list);

                String cases_status = web_response_case.get("cases_status").toString(); 
                ArrayList cases_status_list = googleJson.fromJson(cases_status, ArrayList.class);
				request.setAttribute("cases_status",cases_status_list);

                String legal_document_location = cls_url_config.getLegal_document_location();
                String scanned_docs = cls_legal_docs.load_scanned_documents(suit_number, legal_document_location);
                ArrayList scanned_docs_list = googleJson.fromJson(scanned_docs, ArrayList.class);
				request.setAttribute("scanned_docs",scanned_docs_list);

						model.addAttribute("content", "../pages/legal/case_work.jsp"); return "layouts/app";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null; 
    }


    @RequestMapping("/cases_upload")
	@GetMapping
	public String cases_upload(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {
            Gson courtsJson = new Gson();
            Gson typesJson = new Gson();
            JSONObject courtsObj = new JSONObject();
            JSONObject typesObj = new JSONObject();

			String courts_web_service_response = cls_suits.get_courts(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
			System.out.println(courts_web_service_response);
            courtsObj = new JSONObject(courts_web_service_response);

            String courts = courtsObj.get("data").toString(); 

			ArrayList courts_list = courtsJson.fromJson(courts, ArrayList.class);
			request.setAttribute("courts",courts_list);

            String types_web_service_response=cls_suits.get_types_of_cases(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
            System.out.println(types_web_service_response);
            typesObj = new JSONObject(courts_web_service_response);

            String type_of_cases = typesObj.get("data").toString(); 

			ArrayList types_list = typesJson.fromJson(type_of_cases, ArrayList.class);
			request.setAttribute("type_of_cases",types_list);

					model.addAttribute("content", "../pages/legal/secretariat.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/document_attachment")
    @PostMapping
	public String document_attachment(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response, HttpServletRequest servletRequest, @RequestParam(value="file", required=false) MultipartFile file) throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		
        try {
            String request_type =request.getParameter("request_type");
			String suit_number =request.getParameter("suit_number");

			JSONObject obj = new JSONObject();
            String web_service_response = "";
            JSONObject obj_loc = new JSONObject();
            obj_loc.put("suit_number", suit_number);

			web_service_response = cls_suits.file_locations(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj_loc.toString());

            System.out.println(web_service_response);
            JSONObject loc_obj = new JSONObject(web_service_response); 
            String locs = loc_obj.get("data").toString();
            Gson locsJson = new Gson();
            ArrayList locs_list = locsJson.fromJson(locs, ArrayList.class);
			request.setAttribute("attachments", locs_list);

            if (request_type.equals("upload_page")) {
				
                request.setAttribute("suit_number",suit_number);
               
                		model.addAttribute("content", "../pages/legal/document_upload.jsp"); return "layouts/app";
               
            }

            else if(request_type.equals("upload_document")) {

                //String suit_number = request.getParameter("suit_number");
               // String case_id = request.getParameter("case_id");
                String type_of_document=request.getParameter("type_of_document");
                //String scan_type=request.getParameter("scan_type");
                String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
                //String web_service_response="";
                
                String suit_upload = suit_number.replace("/","_");
                String type_of_document_upload = type_of_document.replace(" ", "_");

                String fileName = file.getOriginalFilename();
               // String path = servletRequest.getSession().getServletContext().getRealPath("/"+File.separator+fileName);

				String path = cls_url_config.getLc_temp_folder() + suit_upload;

                InputStream is = file.getInputStream();
            
                boolean success = writeToFile(is,path);

                if(success) {
                    System.out.println("File Uploaded to this directory: "+path);
                        
                    //File file = new File(path + fileName);
                    
                    //JSONObject obj = new JSONObject();
                    obj.put("suit_number", suit_number);
                    obj.put("type_of_document", type_of_document);
                    obj.put("fileName", fileName);
                    //obj.put("case_number", Double.valueOf(case_number).intValue());
                    //obj.put("case_id", Double.valueOf(case_id).intValue());
                    String newpath = cls_url_config.getLegal_document_location() + suit_upload;
                    
                    //Creating a File object
                    File filedir = new File(newpath);
                    File sourcePath = new File(path);
                    File destinationPath = new File(newpath+"/"+type_of_document_upload+"_"+timeStamp+"_"+fileName);
                        
                    //Creating the directory
                    if(!filedir.exists()) {
                        boolean bool = filedir.mkdir();
                        if(bool){
                            fileCopy(sourcePath,destinationPath);
                            obj.put("location", destinationPath);
							web_service_response = cls_suits.save_file_location(cls_url_config.getWeb_service_url_ser(),
						    cls_url_config.getWeb_service_url_ser_api_key(), obj.toString( ));

                            		model.addAttribute("content", "../pages/legal/document_upload.jsp"); return "layouts/app";
                        }
                        else{
                            System.out.println("Sorry couldn't create specified directory");
                            request.setAttribute("status","failed");	
                            
                            		model.addAttribute("content", "../pages/legal/document_upload.jsp"); return "layouts/app";
                        }
                    }
                    else {
                        System.out.println("Directory already exist");

                        fileCopy(sourcePath,destinationPath);
                        obj.put("location", destinationPath);

                        web_service_response = cls_suits.save_file_location(cls_url_config.getWeb_service_url_ser(),
						    cls_url_config.getWeb_service_url_ser_api_key(), obj.toString( ));

                        		model.addAttribute("content", "../pages/legal/document_upload.jsp"); return "layouts/app";
                    }

                }
                //return web_service_response;
            }

        } catch (Exception e) {
            // TODO: handle exception
        }

		return null;
	}

    @RequestMapping("/further_entry")
	@GetMapping
	public String further_entry(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

					model.addAttribute("content", "../pages/legal/legal_unit.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

    @RequestMapping("/further_entry_post")
    @PostMapping
	public String further_entry_post(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		
        try {
            String request_type =request.getParameter("request_type");
			String case_id =request.getParameter("case_id");
			String suit_number =request.getParameter("suit_number");

			String web_response = null;
			JSONObject obj =new JSONObject();
			JSONObject obj_r=new JSONObject();

            System.out.println(request_type);

			// web_service_response = cls_suits.file_locations(cls_url_config.getWeb_service_url_ser(),
			// 			cls_url_config.getWeb_service_url_ser_api_key(), obj.toString(_)loc);

            // System.out.println(web_service_response);
            // JSONObject loc_obj = new JSONObject(web_service_response); 
            // String locs = loc_obj.get("data").toString();
            // Gson locsJson = new Gson();
            // ArrayList locs_list = locsJson.fromJson(locs, ArrayList.class);
			// request.setAttribute("attachments", locs_list);

            if (request_type.equals("load_case")) {
				
                if (!case_id.trim().isEmpty()) {
                    obj.put("case_id", case_id);
					obj.put("suit_number", suit_number);

                    web_response= cls_suits.load_further_entry(cls_url_config.getWeb_service_url_ser(),
						    cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());

                    System.out.println(web_response);
            
                    if (web_response != null) {
                        //System.out.println(web_response);
                    } else {
                        
                        obj_r.put("success", false);
                        obj_r.put("msg", "Error Getting Ticket Categories");
                    }

                    JSONObject web_response_case = new JSONObject(web_response); 
					String case_details = web_response_case.get("data").toString(); 
                    System.out.println(case_details);

                    Gson caseJson = new Gson();
                    ArrayList case_list = caseJson.fromJson(case_details, ArrayList.class);
			        request.setAttribute("case_detail", case_list);

                    String courts_web_service_response = cls_suits.get_courts(cls_url_config.getWeb_service_url_ser(),
						    cls_url_config.getWeb_service_url_ser_api_key()); 
					JSONObject s_obj =new JSONObject(courts_web_service_response); 
					String courts = s_obj.get("data").toString(); 
                    System.out.println(courts);

					Gson courtsJson = new Gson(); 
                    ArrayList court_list = courtsJson.fromJson(courts, ArrayList.class);
			        request.setAttribute("courts", court_list);

                    String types_web_service_response = cls_suits.get_types_of_cases(cls_url_config.getWeb_service_url_ser(),
						    cls_url_config.getWeb_service_url_ser_api_key());
                    JSONObject types_obj = new JSONObject(types_web_service_response); 
                    String types = types_obj.get("data").toString(); 

                    Gson types_of_casesJson=new Gson();
                    ArrayList type_list = types_of_casesJson.fromJson(types, ArrayList.class);
			        request.setAttribute("type_of_cases", type_list);

                    		model.addAttribute("content", "../pages/legal/further_entry.jsp"); return "layouts/app";
                }
               
            }

        } catch (Exception e) {
            // TODO: handle exception
        }

		return null;
	}

    @RequestMapping("/head_legal")
	@GetMapping
	public String head_legal(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        //HttpSession session = request.getSession();
		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {
            String web_response = null;
            //Gson googleJson = new Gson();
			web_response = cls_suits.load_head_cases(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());

			JSONObject web_response_obj = new JSONObject(web_response); 
			Integer incoming = web_response_obj.getInt("incoming");
			Integer unit_count = web_response_obj.getInt("unit_count");
			Integer pending_count = web_response_obj.getInt("pending_count");
            Integer assigned_count=web_response_obj.getInt("assigned_count");
            Integer archive_count=web_response_obj.getInt("archive_count");
	
            request.setAttribute("incoming",incoming);
            request.setAttribute("unit_count",unit_count);
            request.setAttribute("pending_count",pending_count);
            request.setAttribute("assigned_count", assigned_count);
            request.setAttribute("archive_count", archive_count);

					model.addAttribute("content", "../pages/legal/head_legal.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/legacy_cases")
	@GetMapping
	public String legacy_cases(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        //HttpSession session = request.getSession();
		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {
            String web_response = null;
            //Gson googleJson = new Gson();
			web_response = cls_suits.get_types_of_cases(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());

            JSONObject types_obj = new JSONObject(web_response); 
            String types = types_obj.get("data").toString(); 
            Gson types_of_casesJson = new Gson();

            ArrayList type_list = types_of_casesJson.fromJson(types, ArrayList.class);
			request.setAttribute("type_of_cases", type_list);

					model.addAttribute("content", "../pages/legal/legacy_cases.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/legal_add_case")
	@GetMapping
	public String legal_add_case(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        //HttpSession session = request.getSession();
		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {
            String web_response = null;
            //Gson googleJson = new Gson();
			web_response = cls_suits.get_types_of_cases(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());

            JSONObject types_obj = new JSONObject(web_response); 
            String types = types_obj.get("data").toString(); 
            Gson types_of_casesJson = new Gson();

            ArrayList type_list = types_of_casesJson.fromJson(types, ArrayList.class);
			request.setAttribute("type_of_cases", type_list);

            String courts_web_service_response = cls_suits.get_courts(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key()); 
            JSONObject s_obj =new JSONObject(courts_web_service_response); 
            String courts = s_obj.get("data").toString(); 
            System.out.println(courts);

            Gson courtsJson = new Gson(); 
            ArrayList court_list = courtsJson.fromJson(courts, ArrayList.class);
            request.setAttribute("courts", court_list);

					model.addAttribute("content", "../pages/legal/legal_add_case.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/legal_case_management")
	@GetMapping
	public String legal_case_management(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            JSONObject obj = new JSONObject();
			String user_id= (String) session.getAttribute("userid");
			obj.put("user_id", user_id);
			String web_response = cls_suits.assigned_cases(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				
			System.out.println(web_response);

			//System.out.println(web_response);
			JSONObject web_response_obj=new JSONObject(web_response);
			
			Integer unit_count = web_response_obj.getInt("unit_count");
			Integer assigned_count = web_response_obj.getInt("assigned_count");
			Integer unassigned_count = web_response_obj.getInt("unassigned_count");
			Integer assigned_user_count = web_response_obj.getInt("assigned_user_count");

            request.setAttribute("unit_count",unit_count);
            request.setAttribute("assigned_count",assigned_count);
            request.setAttribute("unassigned_count",unassigned_count);
            request.setAttribute("assigned_user_count",assigned_user_count);

					model.addAttribute("content", "../pages/legal/case_management.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/legal_reports")
	@GetMapping
	public String legal_reports(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String web_response = null;
            //Gson googleJson = new Gson();
			web_response = cls_suits.get_types_of_cases(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());

            JSONObject types_obj = new JSONObject(web_response); 
            String types = types_obj.get("data").toString(); 
            Gson types_of_casesJson = new Gson();

            ArrayList type_list = types_of_casesJson.fromJson(types, ArrayList.class);
			request.setAttribute("type_of_cases", type_list);

					model.addAttribute("content", "../pages/legal/legal_reports.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/legal_request")
	@GetMapping
	public String legal_request(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            //String web_response = null;
            JSONObject obj = new JSONObject();
			//String user_id= (String) session.getAttribute("userid");
			String division=(String) session.getAttribute("division"); 
			String regional_code=(String) session.getAttribute("regional_code"); 
			String unit_name=(String) session.getAttribute("unit_name"); 
			//obj.put("user_id", user_id);
			
			obj.put("division", division);
			obj.put("region", regional_code);
			obj.put("unit_name", unit_name);
			
			String web_response = cls_suits.load_total_request_status(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
			
			//System.out.println(web_response);
			JSONObject web_response_obj=new JSONObject(web_response);
			
			//String assigned_cases = web_response_obj.get("cases").toString();
			Integer incoming_count	=web_response_obj.getInt("incoming_count");
			Integer outgoing_count=web_response_obj.getInt("outgoing_count");
			Integer total_count=web_response_obj.getInt("total_count");

            request.setAttribute("incoming_count",incoming_count);
            request.setAttribute("outgoing_count",outgoing_count);
            request.setAttribute("total_count",total_count);

					model.addAttribute("content", "../pages/legal/legal_request.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/legal_settings")
	@GetMapping
	public String legal_settings(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        //HttpSession session = request.getSession();
		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {
            String web_response = null;
            //Gson googleJson = new Gson();
			web_response = cls_suits.get_types_of_cases(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());

            JSONObject types_obj = new JSONObject(web_response); 
            String types = types_obj.get("data").toString(); 
            Gson types_of_casesJson = new Gson();

            ArrayList type_list = types_of_casesJson.fromJson(types, ArrayList.class);
			request.setAttribute("type_of_cases", type_list);

            String courts_web_service_response = cls_suits.get_courts(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key()); 
            JSONObject s_obj =new JSONObject(courts_web_service_response); 
            String courts = s_obj.get("data").toString(); 
            System.out.println(courts);

            Gson courtsJson = new Gson(); 
            ArrayList court_list = courtsJson.fromJson(courts, ArrayList.class);
            request.setAttribute("courts", court_list);

					model.addAttribute("content", "../pages/legal/legal_settings.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/legal_unit")
	@GetMapping
	public String legal_unit(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
		} catch (Exception e) {
		}

        if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			//
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		}

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

            String web_service_response = cls_suits.load_unit_cases(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());

			 System.out.println(web_service_response);
			 JSONObject web_response_obj = new JSONObject(web_service_response); 
			 Integer incoming = web_response_obj.getInt("incoming");
			 Integer unit_count = web_response_obj.getInt("unit_count");
			 Integer total_count = web_response_obj.getInt("total_count");
		
			 request.setAttribute("incoming",incoming);
			 request.setAttribute("unit_count",unit_count);
			 request.setAttribute("total_count",total_count);

					model.addAttribute("content", "../pages/legal/legal_unit.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/record_info")
    @PostMapping
	public String record_info(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response, HttpServletRequest servletRequest, @RequestParam(value ="file", required=false) MultipartFile file) throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		
        try {

            String request_type =request.getParameter("request_type");
			String case_id =request.getParameter("case_id");
			String suit_number =request.getParameter("suit_number");
			
			String web_response=null;
			JSONObject obj =new JSONObject();
			JSONObject obj_r=new JSONObject();

            if(request_type.equals("request_record_info")) {

                String nature_of_case =request.getParameter("nature_of_case");
				String nature_of_case_desc =request.getParameter("nature_of_case_desc");
				String court_name =request.getParameter("court_name");
				String region =request.getParameter("region");
				String division =request.getParameter("division");
				String unit =request.getParameter("unit");
				String subject =request.getParameter("subject");
				String description =request.getParameter("description");
				String deadline =request.getParameter("deadline");
				String request_by =request.getParameter("request_by");
				String attach_file =request.getParameter("attach_file");
				
				obj.put("suit_number", suit_number);
				obj.put("case_id", new Double(case_id).intValue());
				obj.put("nature_of_case",new Double(nature_of_case).intValue());
				obj.put("nature_of_case_desc", nature_of_case_desc);
				obj.put("court_name",court_name);
				obj.put("region", region);
				obj.put("division", division);
				obj.put("unit", unit);
				obj.put("subject", subject);
				obj.put("description", description);
				obj.put("deadline",deadline);
				obj.put("request_by",request_by);

                web_response = cls_suits.load_further_entry(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				
				JSONObject web_response_case = new JSONObject(web_response); 
				String case_details = web_response_case.get("data").toString(); 

				Gson caseJson=new Gson();
				ArrayList case_list = caseJson.fromJson(case_details, ArrayList.class);

				request.setAttribute("case_detail",case_list);

                if(attach_file == null) {
					attach_file="false";
					obj.put("attach_file",attach_file);
					
					web_response= cls_suits.request_record_info(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
					
					if (web_response != null) {
						System.out.println(web_response);
						
						request.setAttribute("suit_number",suit_number);
                        request.setAttribute("stage", "1");
                        request.setAttribute("case_id", case_id);
                        request.setAttribute("suit_number", suit_number);
						
								model.addAttribute("content", "../pages/legal/record_info.jsp?success=true"); return "layouts/app";

					} else {
						obj_r.put("success", false);
						obj_r.put("msg", "Error occurred");
					}
					
				}

                else {

                    attach_file = "true";
					obj.put("attach_file",attach_file);
					
					String type_of_document="requested_info";
					String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
					String web_service_response = "";
					String suit_upload=suit_number.replace("/","_");
                    String type_of_document_upload = type_of_document.replace(" ", "_");

                    String fileName = file.getOriginalFilename();
                    //String path = servletRequest.getSession().getServletContext().getRealPath("/"+File.separator+fileName);

					String path = cls_url_config.getLc_temp_folder() + suit_upload;

                    InputStream is = file.getInputStream();
                
                    boolean success = writeToFile(is,path);

                    if(success) {
                        System.out.println("File Uploaded to this directory: "+path);
                            
                        //File file = new File(path + fileName); 
                        
                        //JSONObject obj = new JSONObject();
                        obj.put("suit_number", suit_number);
                        obj.put("type_of_document", type_of_document);
                        obj.put("fileName", fileName);
                        //obj.put("case_number", Double.valueOf(case_number).intValue());
                        //obj.put("case_id", Double.valueOf(case_id).intValue());
                        String newpath = cls_url_config.getLegal_request_document() + suit_upload;
                        
                        //Creating a File object
                        File filedir = new File(newpath);
                        File sourcePath = new File(path);
                        File destinationPath = new File(newpath+"/"+type_of_document_upload+"_"+timeStamp+"_"+fileName);
                            
                        //Creating the directory
                        if(!filedir.exists()) {
                            boolean bool = filedir.mkdir();
                            if(bool){
                                fileCopy(sourcePath,destinationPath);
                                obj.put("location", destinationPath);
                                web_service_response = cls_suits.save_file_location(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(), obj.toString( ));

                                		model.addAttribute("content", "../pages/legal/record_info.jsp?success=true"); return "layouts/app";
                            }
                            else{
                                System.out.println("Sorry couldn't create specified directory");
                                request.setAttribute("status","failed");	
                                
                               //		model.addAttribute("content", "../pages/legal/record_info.jsp"); return "layouts/app";
                            }
                        }
                        else {
                            System.out.println("Directory already exist");

                            fileCopy(sourcePath,destinationPath);
                            obj.put("location", destinationPath);

                            web_service_response = cls_suits.save_file_location(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(), obj.toString( ));

                            //		model.addAttribute("content", "../pages/legal/record_info.jsp"); return "layouts/app";
                        }

                    }

                    web_response= cls_suits.request_record_info(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),obj.toString());
					
					if (web_response != null) {
						System.out.println(web_response);
						
						request.setAttribute("suit_number",suit_number);
						request.setAttribute("stage", "1");
						request.setAttribute("case_id", case_id);
						request.setAttribute("suit_number", suit_number);
						
								model.addAttribute("content", "../pages/legal/record_info.jsp?success=true"); return "layouts/app";

					} else {
						obj_r.put("success", false);
						obj_r.put("msg", "Error occurred");
					}
                }
                
                //return web_service_response;
            }

			// if (request_type.equals("provide_record_info")) {

            //     String notes =request.getParameter("notes");
			// 	String provided_by = (String) session.getAttribute("userid");
			// 	String division=(String) session.getAttribute("division"); 
			// 	String regional_code=(String) session.getAttribute("regional_code"); 
			// 	String unit_name=(String) session.getAttribute("unit_name"); 
			// 	String attach_file =request.getParameter("attach_file");
				
			// 	obj.put("suit_number", suit_number);
			// 	obj.put("case_id", new Double(case_id).intValue());
			// 	obj.put("notes",notes);
			// 	obj.put("region", regional_code);
			// 	obj.put("division", division);
			// 	obj.put("unit", unit_name);
			// 	obj.put("provided_by",provided_by);
				
			// 	if(attach_file == null) {
			// 		attach_file="false";
			// 		obj.put("attach_file",attach_file);
					
			// 		web_response = cls_suits.provide_record_info(cls_url_config.getWeb_service_url_ser(),
			// 			cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
					 
			// 		 		model.addAttribute("content", "../pages/legal/work_record_info.jsp?success=true";
			// 	}

            //     else {

            //         attach_file = "true";
            //         obj.put("attach_file",attach_file);
                    
            //         String type_of_document="provided_info";
            //         String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
            //         String web_service_response = "";
            //         String suit_upload=suit_number.replace("/","_");
            //         String type_of_document_upload = type_of_document.replace(" ", "_");

            //         String fileName = file.getOriginalFilename();
            //         String path = servletRequest.getSession().getServletContext().getRealPath("/"+File.separator+fileName);

            //         InputStream is = file.getInputStream();
                
            //         boolean success = writeToFile(is,path);

            //         if(success) {
            //             System.out.println("File Uploaded to this directory: "+path);
                            
            //             //File file = new File(path + fileName);
                        
            //             //JSONObject obj = new JSONObject();
            //             obj.put("suit_number", suit_number);
            //             obj.put("type_of_document", type_of_document);
            //             obj.put("fileName", fileName);
            //             //obj.put("case_number", Double.valueOf(case_number).intValue());
            //             //obj.put("case_id", Double.valueOf(case_id).intValue());
            //             String newpath = cls_url_config.getLegal_provide_document() + suit_upload;
                        
            //             //Creating a File object
            //             File filedir = new File(newpath);
            //             File sourcePath = new File(path);
            //             File destinationPath = new File(newpath+"/"+type_of_document_upload+"_"+timeStamp+"_"+fileName);
                            
            //             //Creating the directory
            //             if(!filedir.exists()) {
            //                 boolean bool = filedir.mkdir();
            //                 if(bool){
            //                     fileCopy(sourcePath,destinationPath);
            //                     obj.put("location", destinationPath);
            //                     web_service_response = cls_suits.provide_record_info(cls_url_config.getWeb_service_url_ser(),
            //                     cls_url_config.getWeb_service_url_ser_api_key(), obj.toString() );

            //                     //		model.addAttribute("content", "../pages/legal/record_info.jsp"); return "layouts/app";
            //                     		model.addAttribute("content", "../pages/legal/work_record_info.jsp?success=true";
            //                 }
            //                 else{
            //                     System.out.println("Sorry couldn't create specified directory");
            //                     request.setAttribute("status","failed");	
                                
            //                     //return web_service_response;
            //                 }
            //             }
            //             else {
            //                 System.out.println("Directory already exist");

            //                 fileCopy(sourcePath,destinationPath);
            //                 obj.put("location", destinationPath);

            //                 web_service_response = cls_suits.provide_record_info(cls_url_config.getWeb_service_url_ser(),
            //                     cls_url_config.getWeb_service_url_ser_api_key(), obj.toString() );

            //                 		model.addAttribute("content", "../pages/legal/work_record_info.jsp?success=true";
            //             }

            //         }

            //     }

            // }

        } catch (Exception e) {
            // TODO: handle exception
        }

		return null;
	}

	@RequestMapping("/request_record_info")
    @PostMapping
	public String request_record_info(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response, HttpServletRequest servletRequest) throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		
        try {

            String request_type =request.getParameter("request_type");
			String case_id =request.getParameter("case_id");
			String suit_number =request.getParameter("suit_number");
			
			String web_response=null;
			JSONObject obj =new JSONObject();
			JSONObject obj_r=new JSONObject();

            if (request_type.equals("record_info")) {
				
                obj.put("case_id", new Double(case_id).intValue());
				obj.put("suit_number", suit_number);
				
				//System.out.println(obj);

				web_response = cls_suits.load_further_entry(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				
				//System.out.println(web_response);
				
				if (web_response != null) {
					//System.out.println(web_response);
				} else {
					
					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
				
                JSONObject web_response_case = new JSONObject(web_response); 
                String case_details = web_response_case.get("data").toString(); 


                //System.out.println(case_details);

                Gson caseJson=new Gson();
                ArrayList case_list = caseJson.fromJson(case_details, ArrayList.class);

                request.setAttribute("case_detail",case_list);
                request.setAttribute("stage", "1");
               
                		model.addAttribute("content", "../pages/legal/record_info.jsp"); return "layouts/app";
               
            }

        } catch (Exception e) {
            // TODO: handle exception
        }

		return null;
	}

    @RequestMapping("/secretariat_add_case")
	@GetMapping
	public String secretariat_add_case(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:
		// ").append(request.getContextPath());

        //HttpSession session = request.getSession();
		// String servletName = request.getServletPath();
		// servletName = servletName.replace("/", "");
		// String assigenedmenus = (String) session.getAttribute("menus_com");
		// boolean isFound = false;
		// try {
		// 	isFound = assigenedmenus.contains(servletName); // true
		// } catch (Exception e) {
		// }

        // if (!isFound) {
		// 	request.setAttribute("login", "Please this is not alllowed");
		// 	//
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		// }

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {
            String web_response = null;
            //Gson googleJson = new Gson();
			web_response = cls_suits.get_types_of_cases(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());

            JSONObject types_obj = new JSONObject(web_response); 
            String types = types_obj.get("data").toString(); 
            Gson types_of_casesJson = new Gson();

            ArrayList type_list = types_of_casesJson.fromJson(types, ArrayList.class);
			request.setAttribute("type_of_cases", type_list);

            String courts_web_service_response = cls_suits.get_courts(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key()); 
            JSONObject s_obj =new JSONObject(courts_web_service_response); 
            String courts = s_obj.get("data").toString(); 
            System.out.println(courts);

            Gson courtsJson = new Gson(); 
            ArrayList court_list = courtsJson.fromJson(courts, ArrayList.class);
            request.setAttribute("courts", court_list);

					model.addAttribute("content", "../pages/legal/secretariat_add_case.jsp"); return "layouts/app";
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

    @RequestMapping("/work_record_info")
    @PostMapping
	public String work_record_info(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) throws NumberFormatException, JSONException {
		// TODO Auto-generated method stub
		
        try {

            String request_type =request.getParameter("request_type");
			String case_id =request.getParameter("case_id");
			String suit_number =request.getParameter("suit_number");
			
			String web_response=null;
			JSONObject obj =new JSONObject();
			JSONObject obj_r=new JSONObject();

            if (request_type.equals("load_case")) {
				
                obj.put("case_id", new Double(case_id).intValue());
				obj.put("suit_number", suit_number);
				
				//System.out.println(obj);

				web_response = cls_suits.load_record_case_details(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());
				
				//System.out.println(web_response);
				
				if (web_response != null) {
					//System.out.println(web_response);
				} else {
					
					obj_r.put("success", false);
					obj_r.put("msg", "Error Getting Ticket Categories");
				}
				
                JSONObject web_response_case = new JSONObject(web_response); 
                String case_details = web_response_case.get("data").toString(); 


                //System.out.println(case_details);

                Gson caseJson=new Gson();
                ArrayList case_list = caseJson.fromJson(case_details, ArrayList.class);

                request.setAttribute("case_detail",case_list);
                //request.setAttribute("stage", "1");

                String load_requested_documents = cls_url_config.getLegal_request_document();

                String scanned_docs = cls_legal_docs.load_requested_documents(suit_number, load_requested_documents);
					
                Gson scanned_docsJson = new Gson();
                ArrayList scanned_doc_list = scanned_docsJson.fromJson(scanned_docs, ArrayList.class);

                request.setAttribute("scanned_docs",scanned_doc_list);

                String legal_document_location = cls_url_config.getLegal_document_location();
                
                String docs = cls_legal_docs.load_scanned_documents(suit_number, legal_document_location);
                
                Gson docsJson = new Gson();
                ArrayList doc_list = docsJson.fromJson(docs, ArrayList.class);

                request.setAttribute("docs",doc_list);
               
                		model.addAttribute("content", "../pages/legal/work_record_info.jsp"); return "layouts/app";
               
            }

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
            out.flush(); out.close();
            
        } catch (IOException e) {
            e.printStackTrace(); 
        }

        return true; 
    }

    private boolean fileCopy(File sourcePath, File destinationPath) {
		  
        boolean status = false;
        try { 
            Files.copy(sourcePath.toPath(),destinationPath.toPath(),StandardCopyOption.REPLACE_EXISTING);
        
            status = true; 
        } catch (IOException e) {
            e.printStackTrace(); 
        }
        
        return status;
    }
}
