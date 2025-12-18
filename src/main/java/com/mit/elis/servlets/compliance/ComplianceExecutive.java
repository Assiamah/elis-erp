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

import ws.casemgt.cls_casemgt;
import ws.compliance.ws_executive_compliance;
import ws.csaumgt.ws_csau_monitoring;

// @MultipartConfig(
//         fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
//         maxFileSize         = 1024 * 1024 * 10, // 10 MB
//         maxRequestSize      = 1024 * 1024 * 15 // 15 MB
// )

@RestController
public class ComplianceExecutive {

    @Autowired
	private Ws_url_config cls_url_config;
	//cls_business_process business_process_cl = new cls_business_process();
    // ws_csau_monitoring cls_monitoring = new ws_csau_monitoring();

    ws_executive_compliance cls_executivedashboard = new ws_executive_compliance();


    @RequestMapping("/executive_dashboard")
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

            //    if (request_type.equals("compliance_executive_dashboard10")) {

            //     String regional_code = request.getParameter("regional_code");
            //     String start_date = request.getParameter("start_date");				
            //     String end_date = request.getParameter("end_date");			
                
                
                
            //     // String staff_id = request.getParameter("staff_id");			
            //     // System.out.println(list_of_application);
            //     obj.put("start_date", start_date);
            //     obj.put("end_date", end_date);
            //     obj.put( "regional_code" , regional_code );
            //     System.out.println(obj.toString());

            //     web_service_response = cls_executivedashboard
            //             .compliance_executive_dashboard10(cls_url_config.getWeb_service_url_ser(),
            //                     cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            //     if (web_service_response != null) {
            //         System.out.println(web_service_response);
            //     } else {
            //         System.out.println(web_service_response);
            //     }

            //     return web_service_response;
            // }




            //  if (request_type.equals("compliance_executive_dashboard11")) {

            //     String regional_code = request.getParameter("regional_code");
            //     String start_date = request.getParameter("start_date");				
            //     String end_date = request.getParameter("end_date");			
                
                
                
            //     // String staff_id = request.getParameter("staff_id");			
            //     // System.out.println(list_of_application);
            //     obj.put("start_date", start_date);
            //     obj.put("end_date", end_date);
            //     obj.put( "regional_code" , regional_code );
            //     System.out.println(obj.toString());

            //     web_service_response = cls_executivedashboard
            //             .compliance_executive_dashboard11(cls_url_config.getWeb_service_url_ser(),
            //                     cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            //     if (web_service_response != null) {
            //         System.out.println(web_service_response);
            //     } else {
            //         System.out.println(web_service_response);
            //     }

            //     return web_service_response;
            // }




            // if (request_type.equals("compliance_executive_dashboard12")) {

            //     String regional_code = request.getParameter("regional_code");
            //     String start_date = request.getParameter("start_date");				
            //     String end_date = request.getParameter("end_date");			
                
                
                
            //     // String staff_id = request.getParameter("staff_id");			
            //     // System.out.println(list_of_application);
            //     obj.put("start_date", start_date);
            //     obj.put("end_date", end_date);
            //     obj.put( "regional_code" , regional_code );
            //     System.out.println(obj.toString());

            //     web_service_response = cls_executivedashboard
            //             .compliance_executive_dashboard12(cls_url_config.getWeb_service_url_ser(),
            //                     cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            //     if (web_service_response != null) {
            //         System.out.println(web_service_response);
            //     } else {
            //         System.out.println(web_service_response);
            //     }

            //     return web_service_response;
            // }



            if (request_type.equals("executive_dashboard_report_all_count")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");			
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_report_all_count(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }


            if (request_type.equals("executive_dashboard_report_charts")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");			
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_report_charts(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("executive_dashboard_get_division_totals")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");			
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_get_division_totals(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




               if (request_type.equals("executive_dashboard_get_regional_received")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");			
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_get_regional_received(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





               if (request_type.equals("executive_dashboard_get_regional_completed_stats")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");			
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_get_regional_completed_stats(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





              if (request_type.equals("executive_dashboard_apps_recieved")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");	
                
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_recieved(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("executive_dashboard_apps_by_subservices_recieved")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");		
                 String sub_serv_id = request.getParameter("sub_serv_id");	
	
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_serv_id", sub_serv_id);

                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_by_subservices_recieved(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("executive_dashboard_applications_recieved")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");		
                 String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");	
	
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_serv_sub_id", sub_serv_sub_id);

                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_applications_recieved(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





         if (request_type.equals("executive_dashboard_apps_pending")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");	
                
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_pending(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }


            


             if (request_type.equals("executive_dashboard_apps_by_subservices_pending")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");		
                 String sub_serv_id = request.getParameter("sub_serv_id");	
	
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_serv_id", sub_serv_id);

                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_by_subservices_pending(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("executive_dashboard_applications_pending")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");		
                 String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");	
	
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_serv_sub_id", sub_serv_sub_id);

                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_applications_pending(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



            //Completed




         if (request_type.equals("executive_dashboard_apps_completed")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");	
                
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_completed(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }


            


             if (request_type.equals("executive_dashboard_apps_by_subservices_completed")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");		
                 String sub_serv_id = request.getParameter("sub_serv_id");	
	
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_serv_id", sub_serv_id);

                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_by_subservices_completed(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("executive_dashboard_applications_completed")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");		
                 String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");	
	
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_serv_sub_id", sub_serv_sub_id);

                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_applications_completed(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





            //RECEIVED COMPLETED


         if (request_type.equals("executive_dashboard_apps_recieved_completed")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");	
                
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_recieved_completed(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }


            


             if (request_type.equals("executive_dashboard_apps_by_subservices_received_completed")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");		
                 String sub_serv_id = request.getParameter("sub_serv_id");	
	
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_serv_id", sub_serv_id);

                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_by_subservices_received_completed(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("executive_dashboard_applications_received_completed")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");		
                 String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");	
	
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_serv_sub_id", sub_serv_sub_id);

                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_applications_received_completed(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }






         
                        //QUERIED APPS

         if (request_type.equals("executive_dashboard_apps_queried")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");	
                
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_queried(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }


            


             if (request_type.equals("executive_dashboard_apps_by_subservices_queried")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");		
                 String sub_serv_id = request.getParameter("sub_serv_id");	
	
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_serv_id", sub_serv_id);

                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_by_subservices_queried(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("executive_dashboard_applications_queried")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");		
                 String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");	
	
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_serv_sub_id", sub_serv_sub_id);

                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_applications_queried(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





            if (request_type.equals("executive_dashboard_report_received_vs_pending")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");	
                
                
                
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_report_received_vs_pending(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



              if (request_type.equals("executive_dashboard_apps_by_regions")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");	
                String status = request.getParameter("status");	

            
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                obj.put("status", status);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_by_regions(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



              if (request_type.equals("executive_dashboard_regional_apps_division")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");	
                String v_region = request.getParameter("v_region");
                 String status = request.getParameter("status");
                
                

            
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                obj.put("v_region", v_region);
                  obj.put("status", status);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_regional_apps_division(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





             if (request_type.equals("executive_dashboard_apps_past_due")) {

                // String regional_code = request.getParameter("regional_code");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");	
                
                

            
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_past_due(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





             if (request_type.equals("executive_dashboard_apps_past_due_regions")) {

                String vrdivision = request.getParameter("vrdivision");
                String date_from = request.getParameter("date_from");				
                String date_to = request.getParameter("date_to");	
                
                

            
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("vrdivision", vrdivision);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_past_due_regions(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





         if (request_type.equals("executive_dashboard_apps_pastdue_units")) {

                String region_id = request.getParameter("region_id");
                String date_from = request.getParameter("date_from");
                String division = request.getParameter("division");				
                String date_to = request.getParameter("date_to");	
                
                


            
                
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("division", division);
                 obj.put("region_id", region_id);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                
                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_pastdue_units(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }






             if (request_type.equals("executive_dashboard_apps_pastdue_within_unit")) {

                String region_id = request.getParameter("region_id");
                String date_from = request.getParameter("date_from");
                String division = request.getParameter("division");	
                String unit = request.getParameter("unit");				
			    String date_to = request.getParameter("date_to");	
                
                        
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("division", division);
                 obj.put("region_id", region_id);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("unit", unit);


                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_pastdue_within_unit(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("executive_dashboard_apps_pastdue_with_officer")) {

                String region_code = request.getParameter("region_code");
                String date_from = request.getParameter("date_from");
                String division = request.getParameter("division");	
                String staff_id = request.getParameter("staff_id");				
			    String date_to = request.getParameter("date_to");	
                
                        
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("division", division);
                 obj.put("region_code", region_code);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("staff_id", staff_id);


                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_pastdue_with_officer(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




            if (request_type.equals("executive_dashboard_apps_by_regions_to_divisions")) {

                String region_code = request.getParameter("region_code");
                String date_from = request.getParameter("date_from");
                String status = request.getParameter("status");	
			    String date_to = request.getParameter("date_to");	
                
                        
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("status", status);
                 obj.put("region_code", region_code);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);


                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_apps_by_regions_to_divisions(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



             if (request_type.equals("executive_dashboard_divisions_services")) {

                String region_code = request.getParameter("region_code");
                String date_from = request.getParameter("date_from");
                String status = request.getParameter("status");	
                String division = request.getParameter("division");	
			    String date_to = request.getParameter("date_to");	
                
                        
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("status", status);
                obj.put("division", division);
                 obj.put("region_code", region_code);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);


                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_divisions_services(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("executive_dashboard_divisions_sub_services")) {

                String region_code = request.getParameter("region_code");
                String date_from = request.getParameter("date_from");
                String status = request.getParameter("status");	
                String division = request.getParameter("division");	
			    String date_to = request.getParameter("date_to");	
                String sub_service_id = request.getParameter("sub_service_id");	

                
                        
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("status", status);
                obj.put("division", division);
                 obj.put("region_code", region_code);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("sub_service_id", sub_service_id);

                


                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_divisions_sub_services(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





             if (request_type.equals("executive_dashboard_divisions_sub_services_applications")) {

                String region_code = request.getParameter("region_code");
                String date_from = request.getParameter("date_from");
                String status = request.getParameter("status");	
                String division = request.getParameter("division");	
			    String date_to = request.getParameter("date_to");	
                String business_process_sub_id = request.getParameter("business_process_sub_id");	

                
                        
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("status", status);
                obj.put("division", division);
                 obj.put("region_code", region_code);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);
                 obj.put("business_process_sub_id", business_process_sub_id);

                


                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_divisions_sub_services_applications(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }
  



             if (request_type.equals("executive_dashboard_get_apps_by_subservices_for_barchart")) {

                String date_from = request.getParameter("date_from");
			    String date_to = request.getParameter("date_to");	

                
                        
                // String staff_id = request.getParameter("staff_id");			
                // System.out.println(list_of_application);
                obj.put("date_from", date_from);
                obj.put("date_to", date_to);

                


                System.out.println(obj.toString());

                web_service_response = cls_executivedashboard
                        .executive_dashboard_get_apps_by_subservices_for_barchart(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }
  



            
            


        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


        
		return null;
	}
}

    

