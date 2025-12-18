package com.mit.elis.servlets.corporate;

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
import java.util.Arrays;
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

import ws.compliance.ws_director_compliance;
import ws.corporate.ws_corporate_apps;
import ws.csaumgt.ws_backoffice_monitoring;
import ws.csaumgt.ws_csau_monitoring;
// import ws.instrumentation.instruments_docs;
// import ws.instrumentation.ws_register_instruments;


// @MultipartConfig(
//         fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
//         maxFileSize         = 1024 * 1024 * 10, // 10 MB
//         maxRequestSize      = 1024 * 1024 * 15 // 15 MB
// )



@RestController
public class corporate_apps {



      @Autowired
	private Ws_url_config cls_url_config;

     ws_corporate_apps cls_corporate_apps = new ws_corporate_apps();
        




     @RequestMapping("/corporate_applications")
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
 
             if (request_type.equals("corporate_applications_report_dashboard_all")) {
 
                 String created_for_id = request.getParameter("created_for_id");
                
                 obj.put( "created_for_id" , created_for_id );
                
               //  System.out.println(obj.toString());
 
                 web_service_response = cls_corporate_apps
                         .corporate_applications_report_dashboard_all(cls_url_config.getWeb_service_url_ser(),
                                 cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                 if (web_service_response != null) {
                   //  System.out.println(web_service_response);
                 } else {
                   //  System.out.println(web_service_response);
                 }
 
                 return web_service_response;
             } 




             if (request_type.equals("corporate_applications_division_apps")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String division = request.getParameter("division");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "division" , division );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_division_apps(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 





            if (request_type.equals("corporate_applications_division_apps_by_service")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String service_type = request.getParameter("service_type");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "service_type" , service_type );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_division_apps_by_service(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 




            if (request_type.equals("corporate_applications_report_dashboard_created_today")) {
 
                String created_for_id = request.getParameter("created_for_id");
               
                obj.put( "created_for_id" , created_for_id );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_created_today(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 





            if (request_type.equals("corporate_applications_report_dashboard_created_day_by_division")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String division = request.getParameter("division");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "division" , division );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_created_day_by_division(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 




            if (request_type.equals("corporate_applications_report_dashboard_created_day_by_service")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String service_type = request.getParameter("service_type");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "service_type" , service_type );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_created_day_by_service(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 





            
            if (request_type.equals("corporate_applications_report_dashboard_created_month")) {
 
                String created_for_id = request.getParameter("created_for_id");
               
                obj.put( "created_for_id" , created_for_id );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_created_month(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 




            
            if (request_type.equals("corporate_applications_report_dashboard_created_month_by_divisi")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String division = request.getParameter("division");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "division" , division );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_created_month_by_divisi(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 



            

            if (request_type.equals("corporate_applications_report_dashboard_created_month_by_servic")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String service_type = request.getParameter("service_type");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "service_type" , service_type );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_created_month_by_servic(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 

            
            

           
            if (request_type.equals("corporate_applications_report_dashboard_completed_today")) {
 
                String created_for_id = request.getParameter("created_for_id");
               
                obj.put( "created_for_id" , created_for_id );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_completed_today(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 
            




            if (request_type.equals("corporate_applications_report_dashboard_completed_day_by_divisi")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String division = request.getParameter("division");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "division" , division );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_completed_day_by_divisi(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 





            if (request_type.equals("corporate_applications_report_dashboard_completed_day_by_servic")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String service_type = request.getParameter("service_type");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "service_type" , service_type );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_completed_day_by_servic(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 
            


            if (request_type.equals("corporate_applications_report_dashboard_completed_month")) {
 
                String created_for_id = request.getParameter("created_for_id");
               
                obj.put( "created_for_id" , created_for_id );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_completed_month(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 
            




            if (request_type.equals("corporate_applications_report_dashboard_completed_month_by_divi")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String division = request.getParameter("division");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "division" , division );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_completed_month_by_divi(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 





            if (request_type.equals("corporate_applications_report_dashboard_completed_month_by_serv")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String service_type = request.getParameter("service_type");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "service_type" , service_type );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_completed_month_by_serv(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 




            if (request_type.equals("corporate_applications_report_dashboard_recieved_between_dates")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_recieved_between_dates(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 




            if (request_type.equals("corporate_applications_report_dashboard_created_by_date_range")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String division = request.getParameter("division");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "division" , division );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_created_by_date_range(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 






            if (request_type.equals("corporate_applications_division_apps_by_service_date_range")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String service_type = request.getParameter("service_type");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "service_type" , service_type );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_division_apps_by_service_date_range(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 






            if (request_type.equals("corporate_apps_report_dashboard_recieved_completed_by_dates")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_apps_report_dashboard_recieved_completed_by_dates(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 






            if (request_type.equals("corporate_apps_report_dashboard_created_comp_by_date_range")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String division = request.getParameter("division");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "division" , division );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_apps_report_dashboard_created_comp_by_date_range(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 






            if (request_type.equals("corporate_app_division_apps_by_service_date_range_rec_comp")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String service_type = request.getParameter("service_type");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "service_type" , service_type );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_app_division_apps_by_service_date_range_rec_comp(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 





            if (request_type.equals("corporate_applications_report_dashboard_completed_by_dates")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_completed_by_dates(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 





            if (request_type.equals("corporate_applications_report_dashboard_completed_by_date")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String division = request.getParameter("division");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "division" , division );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_completed_by_date(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 




            if (request_type.equals("corporate_applications_report_dashboard_completed_by_serv_dates")) {
 
                String created_for_id = request.getParameter("created_for_id");
                String service_type = request.getParameter("service_type");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");
               
                obj.put( "created_for_id" , created_for_id );
                obj.put( "service_type" , service_type );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
               
              //  System.out.println(obj.toString());

                web_service_response = cls_corporate_apps
                        .corporate_applications_report_dashboard_completed_by_serv_dates(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            } 





            if (request_type.equals("corporate_sub_applications_report_dashboard_created_today")) {
 
              String created_for_id = request.getParameter("created_for_id");
              String process_id = request.getParameter("process_id");
             
             
              obj.put( "created_for_id" , created_for_id );
              obj.put( "process_id" , process_id );
              
             
            //  System.out.println(obj.toString());

              web_service_response = cls_corporate_apps
                      .corporate_sub_applications_report_dashboard_created_today(cls_url_config.getWeb_service_url_ser(),
                              cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
              if (web_service_response != null) {
                //  System.out.println(web_service_response);
              } else {
                //  System.out.println(web_service_response);
              }

              return web_service_response;
          } 




          if (request_type.equals("corporate_sub_applications_report_dashboard_created_month")) {
 
            String created_for_id = request.getParameter("created_for_id");
            String process_id = request.getParameter("process_id");
           
           
            obj.put( "created_for_id" , created_for_id );
            obj.put( "process_id" , process_id );
            
           
          //  System.out.println(obj.toString());

            web_service_response = cls_corporate_apps
                    .corporate_sub_applications_report_dashboard_created_month(cls_url_config.getWeb_service_url_ser(),
                            cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            if (web_service_response != null) {
              //  System.out.println(web_service_response);
            } else {
              //  System.out.println(web_service_response);
            }

            return web_service_response;
        } 





        if (request_type.equals("corporate_sub_applications_report_dashboard_completed_day")) {
 
          String created_for_id = request.getParameter("created_for_id");
          String process_id = request.getParameter("process_id");
         
         
          obj.put( "created_for_id" , created_for_id );
          obj.put( "process_id" , process_id );
          
         
        //  System.out.println(obj.toString());

          web_service_response = cls_corporate_apps
                  .corporate_sub_applications_report_dashboard_completed_day(cls_url_config.getWeb_service_url_ser(),
                          cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
          if (web_service_response != null) {
            //  System.out.println(web_service_response);
          } else {
            //  System.out.println(web_service_response);
          }

          return web_service_response;
      } 







      if (request_type.equals("corporate_sub_applications_report_dashboard_completed_month")) {
 
        String created_for_id = request.getParameter("created_for_id");
        String process_id = request.getParameter("process_id");
       
       
        obj.put( "created_for_id" , created_for_id );
        obj.put( "process_id" , process_id );
        
       
      //  System.out.println(obj.toString());

        web_service_response = cls_corporate_apps
                .corporate_sub_applications_report_dashboard_completed_month(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
        if (web_service_response != null) {
          //  System.out.println(web_service_response);
        } else {
          //  System.out.println(web_service_response);
        }

        return web_service_response;
    } 







    if (request_type.equals("corporate_applications_report_dashboard_past_due_apps")) {
 
      String created_for_id = request.getParameter("created_for_id");
     
      obj.put( "created_for_id" , created_for_id );
     
    //  System.out.println(obj.toString());

      web_service_response = cls_corporate_apps
              .corporate_applications_report_dashboard_past_due_apps(cls_url_config.getWeb_service_url_ser(),
                      cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
      if (web_service_response != null) {
        //  System.out.println(web_service_response);
      } else {
        //  System.out.println(web_service_response);
      }

      return web_service_response;
  } 




  if (request_type.equals("corporate_dashboard_two_all")) {
 
    String date_from = request.getParameter("date_from");				
    String date_to = request.getParameter("date_to");				
    // String staff_id = request.getParameter("staff_id");			

    // System.out.println(list_of_application);
    obj.put("date_from", date_from);
    obj.put("date_to", date_to);
   
  //  System.out.println(obj.toString());

    web_service_response = cls_corporate_apps
            .corporate_dashboard_two_all(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
    if (web_service_response != null) {
      //  System.out.println(web_service_response);
    } else {
      //  System.out.println(web_service_response);
    }

    return web_service_response;
} 





if (request_type.equals("corporate_dashboard_two_apps_recieved")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");				
  // String staff_id = request.getParameter("staff_id");			

  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
 
//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_recieved(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 




if (request_type.equals("corporate_dashboard_two_apps_pending")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");				
  // String staff_id = request.getParameter("staff_id");			

  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
 
//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_pending(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 







if (request_type.equals("corporate_dashboard_two_apps_completed")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");				
  // String staff_id = request.getParameter("staff_id");			

  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
 
//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_completed(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 




if (request_type.equals("corporate_dashboard_two_apps_by_subservices_recieved")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String sub_serv_id = request.getParameter("sub_serv_id");		
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_id", sub_serv_id);

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_by_subservices_recieved(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 



if (request_type.equals("corporate_dashboard_two_apps_by_subservices_completed")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String sub_serv_id = request.getParameter("sub_serv_id");		
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_id", sub_serv_id);

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_by_subservices_completed(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 





if (request_type.equals("corporate_dashboard_two_apps_by_subservices_pending")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String sub_serv_id = request.getParameter("sub_serv_id");		
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_id", sub_serv_id);

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_by_subservices_pending(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 







if (request_type.equals("corporate_dashboard_two_apps_by_subservices_recieved_from_banks")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");		
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_sub_id", sub_serv_sub_id);

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_by_subservices_recieved_from_banks(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 





if (request_type.equals("corporate_dashboard_two_apps_by_subservices_pending_from_banks")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");		
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_sub_id", sub_serv_sub_id);

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_by_subservices_pending_from_banks(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 








if (request_type.equals("corporate_dashboard_two_apps_by_subservices_completed_from_bank")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");		
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_sub_id", sub_serv_sub_id);

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_by_subservices_completed_from_bank(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 








if (request_type.equals("corporate_dashboard_two_applications_recieved_from_bank")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");		
  String created_for_id = request.getParameter("created_for_id");		
  
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_sub_id", sub_serv_sub_id);
  obj.put("created_for_id", created_for_id);
  

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_applications_recieved_from_bank(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 





if (request_type.equals("corporate_dashboard_two_applications_pending_from_bank")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");		
  String created_for_id = request.getParameter("created_for_id");		
  
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_sub_id", sub_serv_sub_id);
  obj.put("created_for_id", created_for_id);
  

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_applications_pending_from_bank(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 







if (request_type.equals("corporate_dashboard_two_applications_completed_from_bank")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");		
  String created_for_id = request.getParameter("created_for_id");		
  
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_sub_id", sub_serv_sub_id);
  obj.put("created_for_id", created_for_id);
  

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_applications_completed_from_bank(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 





if (request_type.equals("corporate_dashboard_two_all_chart")) {
 
  String start_date = request.getParameter("start_date");				
  String end_date = request.getParameter("end_date");			
  
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("start_date", start_date);
  obj.put("end_date", end_date);
  

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_all_chart(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 





if (request_type.equals("corporate_dashboard_two_applications_top_five_banks")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String created_for_id = request.getParameter("created_for_id");			
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("created_for_id", created_for_id);
  

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_applications_top_five_banks(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 






if (request_type.equals("corporate_dashboard_two_all_barchart")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_all_barchart(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 





if (request_type.equals("corporate_dashboard_two_apps_queried")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_queried(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 






if (request_type.equals("corporate_dashboard_two_apps_by_subservices_queried")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");	
  String sub_serv_id = request.getParameter("sub_serv_id");			
		

  
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_id", sub_serv_id);
  

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_by_subservices_queried(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 





if (request_type.equals("corporate_dashboard_two_apps_by_subservices_queried_from_banks")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");	
  String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");			
		

  
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_sub_id", sub_serv_sub_id);
  

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_apps_by_subservices_queried_from_banks(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 









if (request_type.equals("corporate_dashboard_two_applications_queried_from_bank")) {
 
  String date_from = request.getParameter("date_from");				
  String date_to = request.getParameter("date_to");			
  String sub_serv_sub_id = request.getParameter("sub_serv_sub_id");		
  String created_for_id = request.getParameter("created_for_id");		
  
  
  
  // String staff_id = request.getParameter("staff_id");			
  // System.out.println(list_of_application);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("sub_serv_sub_id", sub_serv_sub_id);
  obj.put("created_for_id", created_for_id);
  

//  System.out.println(obj.toString());

  web_service_response = cls_corporate_apps
          .corporate_dashboard_two_applications_queried_from_bank(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
} 



if (request_type.equals("report_on_the_corporate_applications")) {
  // ... other parameter handling ...
  String type_of_report_name = request.getParameter("type_of_report_name");				
  String business_process_id = request.getParameter("business_process_id");			
  String business_process_sub_id = request.getParameter("business_process_sub_id");		
  String date_from = request.getParameter("date_from");		
  String date_to = request.getParameter("date_to");		
  String region_code = request.getParameter("region_code");
  
  // Handle bank_email array parameter correctly
  String[] bank_email_array = request.getParameterValues("bank_email[]"); // Note the [] in parameter name
  
  JSONArray bankEmailJsonArray = new JSONArray();
  
  if (bank_email_array != null && bank_email_array.length > 0) {
      // Check if "All" is selected
      boolean hasAll = Arrays.stream(bank_email_array)
                           .anyMatch(email -> "All".equalsIgnoreCase(email.trim()));
      
      if (hasAll) {
          bankEmailJsonArray.put("All");
      } else {
          // Add all selected emails
          for (String email : bank_email_array) {
              if (email != null && !email.trim().isEmpty()) {
                  bankEmailJsonArray.put(email.trim());
              }
          }
      }
  } else {
      // Default to ["All"] if no selection
      bankEmailJsonArray.put("All");
  }
  
  System.out.println("Final bank_email JSON: " + bankEmailJsonArray);
  obj.put("bank_email", bankEmailJsonArray);
  obj.put("type_of_report_name", type_of_report_name);
  obj.put("business_process_id", business_process_id);
  obj.put("business_process_sub_id", business_process_sub_id);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("region_code", region_code);
  
  

  web_service_response = cls_corporate_apps
          .report_on_the_corporate_applications(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;


}





if (request_type.equals("report_on_the_corporate_applications_by_services")) {
  // ... other parameter handling ...
  String type_of_report_name = request.getParameter("type_of_report_name");				
  String business_process_id = request.getParameter("business_process_id");			
  String business_process_sub_id = request.getParameter("business_process_sub_id");		
  String date_from = request.getParameter("date_from");		
  String date_to = request.getParameter("date_to");		
  String region_code = request.getParameter("region_code");
  String bank_email = request.getParameter("bank_email");
  


  obj.put("type_of_report_name", type_of_report_name);
  obj.put("business_process_id", business_process_id);
  obj.put("business_process_sub_id", business_process_sub_id);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("region_code", region_code);
  obj.put("bank_email", bank_email);
  
  
  

  web_service_response = cls_corporate_apps
          .report_on_the_corporate_applications_by_services(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;

  
}






if (request_type.equals("report_on_the_corporate_applications_by_sub_services")) {
  // ... other parameter handling ..
  String type_of_report_name = request.getParameter("type_of_report_name");				
  String business_process_id = request.getParameter("business_process_id");			
  String business_process_sub_id = request.getParameter("business_process_sub_id");		
  String date_from = request.getParameter("date_from");		
  String date_to = request.getParameter("date_to");		
  String region_code = request.getParameter("region_code");
  String bank_email = request.getParameter("bank_email");
  


  obj.put("type_of_report_name", type_of_report_name);
  obj.put("business_process_id", business_process_id);
  obj.put("business_process_sub_id", business_process_sub_id);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("region_code", region_code);
  obj.put("bank_email", bank_email);
  
  
  

  web_service_response = cls_corporate_apps
          .report_on_the_corporate_applications_by_sub_services(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;

  
}





if (request_type.equals("report_on_the_corporate_applications_by_applications")) {
  // ... other parameter handling ..
  String type_of_report_name = request.getParameter("type_of_report_name");				
  String business_process_id = request.getParameter("business_process_id");			
  String business_process_sub_id = request.getParameter("business_process_sub_id");		
  String date_from = request.getParameter("date_from");		
  String date_to = request.getParameter("date_to");		
  String region_code = request.getParameter("region_code");
  String bank_email = request.getParameter("bank_email");
  


  obj.put("type_of_report_name", type_of_report_name);
  obj.put("business_process_id", business_process_id);
  obj.put("business_process_sub_id", business_process_sub_id);
  obj.put("date_from", date_from);
  obj.put("date_to", date_to);
  obj.put("region_code", region_code);
  obj.put("bank_email", bank_email);
  
  
  

  web_service_response = cls_corporate_apps
          .report_on_the_corporate_applications_by_applications(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
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
