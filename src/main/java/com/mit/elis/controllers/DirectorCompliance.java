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
 

@Controller
public class DirectorCompliance {


    @Autowired
	private Ws_url_config cls_url_config;

    ServletRequest servletContext;

	// ws_csau_monitoring cls_monitoring = new ws_csau_monitoring();
	// ws_backoffice_monitoring cls_backoffice_monitoring = new ws_backoffice_monitoring();


	
    @RequestMapping("/director_compliance")
	@GetMapping
	public String director_compliance_monitor(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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


            String regional_code = (String) session.getAttribute("regional_code");

            String division = (String) session.getAttribute("division");

			
			JSONObject obj =new JSONObject();
			
			obj.put("regional_code",regional_code);
            obj.put("division",division);


        
    String office_region_list = (String) session.getAttribute("office_region_list");
    // System.out.println(office_region_list);
    Gson googleJson = new Gson();
    ArrayList javaArrayListFromGSON = googleJson.fromJson(office_region_list, ArrayList.class);
    request.setAttribute("officeregionlist", javaArrayListFromGSON);

    request.setAttribute("page_name", "director_compliance");
		
	//  System.out.println(web_service_response);

					model.addAttribute("content", "../pages/client_application/director_compliance.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }
}
    
