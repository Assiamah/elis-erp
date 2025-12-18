package com.mit.elis.servlets.compliance;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import org.springframework.ui.Model;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.codec.multipart.Part;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.mit.elis.class_common.Ws_url_config;

import ws.compliance.ws_request_monitoring;
import ws.csaumgt.ws_backoffice_monitoring;
import ws.csaumgt.ws_csau_monitoring;


// @MultipartConfig(
//         fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
//         maxFileSize         = 1024 * 1024 * 10, // 10 MB
//         maxRequestSize      = 1024 * 1024 * 15 // 15 MB
// )


@RestController
public class RequestMonitoring {
    @Autowired
	private Ws_url_config cls_url_config;

        // ws_csau_monitoring cls_monitoring = new ws_csau_monitoring();
        ws_request_monitoring clRequest_monitoring = new ws_request_monitoring();


        @RequestMapping("/request_monitoring_dashboard")
        @PostMapping
        public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
            // TODO Auto-generated method stub
    
            if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
                // Session is expired
                request.setAttribute("login", "sessionout");
                 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
    
            }
    
            try {
                String request_type = request.getParameter("request_type");
                JSONObject obj = new JSONObject();
    
                String web_service_response = null;
    
                if (request_type.equals("select_staff_apps_with_unit_monitoring")) {
    
                    String unit_id = request.getParameter("unit_id");
    
                    obj.put( "unit_id" , unit_id );
                  //  System.out.println(obj.toString());
    
                    web_service_response = clRequest_monitoring
                            .select_staff_apps_with_unit_monitoring(cls_url_config.getWeb_service_url_ser(),
                                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                    if (web_service_response != null) {
                      //  System.out.println(web_service_response);
                    } else {
                      //  System.out.println(web_service_response);
                    }
    
                    return web_service_response;
                }





                if (request_type.equals("select_all_staff_apps_with_unit_monitoring")) {
    
                    String unit_id = request.getParameter("unit_id");
    
                    obj.put( "unit_id" , unit_id );
                  //  System.out.println(obj.toString());
    
                    web_service_response = clRequest_monitoring
                            .select_all_staff_apps_with_unit_monitoring(cls_url_config.getWeb_service_url_ser(),
                                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                    if (web_service_response != null) {
                      //  System.out.println(web_service_response);
                    } else {
                      //  System.out.println(web_service_response);
                    }
    
                    return web_service_response;
                }





                if (request_type.equals("all_staff_apps_with_unit_monitoring")) {
    
                    String staff_id = request.getParameter("staff_id");
    
                    obj.put( "staff_id" , staff_id );
                  //  System.out.println(obj.toString());
    
                    web_service_response = clRequest_monitoring
                            .all_staff_apps_with_unit_monitoring(cls_url_config.getWeb_service_url_ser(),
                                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                    if (web_service_response != null) {
                      //  System.out.println(web_service_response);
                    } else {
                      //  System.out.println(web_service_response);
                    }
    
                    return web_service_response;
                }






                if (request_type.equals("select_staff_apps_with_unit_request_incoming_applications")) {
    
                    String unit_id = request.getParameter("unit_id");
    
                    obj.put( "unit_id" , unit_id );
                  //  System.out.println(obj.toString());
    
                    web_service_response = clRequest_monitoring
                            .select_staff_apps_with_unit_request_incoming_applications(cls_url_config.getWeb_service_url_ser(),
                                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                    if (web_service_response != null) {
                      //  System.out.println(web_service_response);
                    } else {
                      //  System.out.println(web_service_response);
                    }
    
                    return web_service_response;
                }





                if (request_type.equals("select_staff_apps_with_officers_request_withinunit_applications")) {
    
                    String unit_id = request.getParameter("unit_id");
                    String inbox_type = request.getParameter("inbox_type");

                    
    
                    obj.put( "unit_id" , unit_id );
                    obj.put( "inbox_type" , inbox_type );
                  //  System.out.println(obj.toString());
    
                    web_service_response = clRequest_monitoring
                            .select_staff_apps_with_officers_request_withinunit_applications
                            (cls_url_config.getWeb_service_url_ser(),
                                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                    if (web_service_response != null) {
                      //  System.out.println(web_service_response);
                    } else {
                      //  System.out.println(web_service_response);
                    }
    
                    return web_service_response;
                }




                if (request_type.equals("select_staff_apps_with_officers_request_withinuni")) {
    
                    String unit_id = request.getParameter("unit_id");
                    String inbox_type = request.getParameter("inbox_type");

                    
    
                    obj.put( "unit_id" , unit_id );
                    obj.put( "inbox_type" , inbox_type );
                  //  System.out.println(obj.toString());
    
                    web_service_response = clRequest_monitoring
                            .select_staff_apps_with_officers_request_withinuni
                            (cls_url_config.getWeb_service_url_ser(),
                                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                    if (web_service_response != null) {
                      //  System.out.println(web_service_response);
                    } else {
                      //  System.out.println(web_service_response);
                    }
    
                    return web_service_response;
                }





                


                

                






                




                


            }catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
    
    
            
            return null;

        }


}
