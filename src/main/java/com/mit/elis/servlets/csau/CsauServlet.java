package com.mit.elis.servlets.csau;

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
import ws.csaumgt.ws_csau_monitoring;

// @MultipartConfig(
//         fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
//         maxFileSize         = 1024 * 1024 * 10, // 10 MB
//         maxRequestSize      = 1024 * 1024 * 15 // 15 MB
// )

@RestController
public class CsauServlet {
    @Autowired
	private Ws_url_config cls_url_config;
	//cls_business_process business_process_cl = new cls_business_process();
    ws_csau_monitoring cls_monitoring = new ws_csau_monitoring();

	@RequestMapping("/csau_manager_dashboard")
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

			if (request_type.equals("select_count_received_today_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
              //  System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_count_received_today_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }


            if (request_type.equals("select_count_received_month_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
               // System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_count_received_month_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                 //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }






             if (request_type.equals("select_count_received_year_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_count_received_year_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



             if (request_type.equals("select_applications_received_year_by_csau_front_officers")) {

                String created_by = request.getParameter("created_by");

                obj.put( "created_by",created_by);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_applications_received_year_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



            if (request_type.equals("select_applications_received_month_by_csau_front_officers")) {

                String created_by = request.getParameter("created_by");

                obj.put( "created_by",created_by);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_applications_received_month_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



            if (request_type.equals("select_6months_bills_created_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_6months_bills_created_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("select_bills_created_by_csau_front_officers_and_paid")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_bills_created_by_csau_front_officers_and_paid(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



              if (request_type.equals("select_bills_created_by_csau_front_officers_and_acknowledged")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_bills_created_by_csau_front_officers_and_acknowledged(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



             if (request_type.equals("get_bills_created_by_csau_front_officers_last6months")) {

               
                String created_by_id = request.getParameter("created_by_id");

                obj.put( "created_by_id",created_by_id);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .get_bills_created_by_csau_front_officers_last6months(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("get_bills_created_by_csau_front_officers_last6months_and_paid")) {
               
                String created_by_id = request.getParameter("created_by_id");

                obj.put( "created_by_id",created_by_id);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .get_bills_created_by_csau_front_officers_last6months_and_paid(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





              if (request_type.equals("get_bills_created_by_csau_front_officers_last6months_and_paid")) {
               
                String created_by_id = request.getParameter("created_by_id");

                obj.put( "created_by_id",created_by_id);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .get_bills_created_by_csau_front_officers_last6months_and_paid(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("get_bills_created_by_csau_front_officers_last6months_and_acknow")) {
               
                String created_by_id = request.getParameter("created_by_id");

                obj.put( "created_by_id",created_by_id);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .get_bills_created_by_csau_front_officers_last6months_and_acknow(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



             if (request_type.equals("get_applications_signedout_year")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .get_applications_signedout_year(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





             if (request_type.equals("get_applications_signedout_today")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .get_applications_signedout_today(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("get_applications_signedout_month")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .get_applications_signedout_month(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("select_count_received_week_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_count_received_week_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;


            }


              if (request_type.equals("select_applications_received_week_by_csau_front_officers")) {
               
                String created_by_id = request.getParameter("created_by_id");

                obj.put( "created_by_id",created_by_id);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_applications_received_week_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



              if (request_type.equals("select_applications_received_today_by_csau_front_officers")) {
               
                String created_by_id = request.getParameter("created_by_id");

                obj.put( "created_by_id",created_by_id);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_applications_received_today_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




            


             if (request_type.equals("get_applications_signedout_week")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .get_applications_signedout_week(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



            if (request_type.equals("select_count_signedout_today_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_count_signedout_today_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("select_count_signedout_week_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_count_signedout_week_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("select_count_signedout_week_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_count_signedout_week_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



             if (request_type.equals("select_count_signedout_today_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_count_signedout_today_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("select_count_signedout_month_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_count_signedout_month_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("select_count_signedout_year_by_csau_front_officers")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_count_signedout_year_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("select_applications_signedout_year_by_csau_front_officers")) {

                String created_by = request.getParameter("created_by");

                obj.put( "created_by",created_by);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_applications_signedout_year_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



             if (request_type.equals("select_applications_signedout_today_by_csau_front_officers")) {

                String created_by = request.getParameter("created_by");

                obj.put( "created_by",created_by);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_applications_signedout_today_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



             if (request_type.equals("select_applications_signedout_week_by_csau_front_officers")) {

                String created_by = request.getParameter("created_by");

                obj.put( "created_by",created_by);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_applications_signedout_week_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("select_applications_signedout_month_by_csau_front_officers")) {

                String created_by = request.getParameter("created_by");

                obj.put( "created_by",created_by);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_applications_signedout_month_by_csau_front_officers(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



             if (request_type.equals("select_bills_today_by_csau_front_officers_and_paid")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
               // System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_bills_today_by_csau_front_officers_and_paid(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                 //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }



              if (request_type.equals("get_bills_created_by_csau_front_officers_today_and_paid")) {
               
                String created_by_id = request.getParameter("created_by_id");

                obj.put( "created_by_id",created_by_id);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .get_bills_created_by_csau_front_officers_today_and_paid(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }


            if (request_type.equals("select_bills_today_by_csau_front_officers_and_acknowledged")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
               // System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .select_bills_today_by_csau_front_officers_and_acknowledged(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                 //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }



            if (request_type.equals("get_bills_created_by_csau_front_officers_today_and_acknowledged")) {
               
                String created_by_id = request.getParameter("created_by_id");

                obj.put( "created_by_id",created_by_id);
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .get_bills_created_by_csau_front_officers_today_and_acknowledged(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





            if (request_type.equals("csau_report_count_received_by_csau_front_officers_by_date")) {
               
                String start_date = request.getParameter("start_date");
                String regional_code = request.getParameter("regional_code");
                String end_date = request.getParameter("end_date");

                obj.put( "start_date",start_date);
                obj.put( "regional_code",regional_code);
                obj.put( "end_date",end_date);

                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .csau_report_count_received_by_csau_front_officers_by_date(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }






            if (request_type.equals("csau_report_apps_received_by_csau_front_officers_by_date")) {
               
                String start_date = request.getParameter("start_date");
                String created_by_id = request.getParameter("created_by_id");
                String end_date = request.getParameter("end_date");

                obj.put( "start_date",start_date);
                obj.put( "created_by_id",created_by_id);
                obj.put( "end_date",end_date);

                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .csau_report_apps_received_by_csau_front_officers_by_date(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }






            if (request_type.equals("csau_report_count_signedout_by_csau_front_officers_by_date")) {
               
                String start_date = request.getParameter("start_date");
                String regional_code = request.getParameter("regional_code");
                String end_date = request.getParameter("end_date");

                obj.put( "start_date",start_date);
                obj.put( "regional_code",regional_code);
                obj.put( "end_date",end_date);

                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .csau_report_count_signedout_by_csau_front_officers_by_date(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




            if (request_type.equals("csau_report_apps_signedout_by_csau_front_officers_by_date")) {
               
                String start_date = request.getParameter("start_date");
                String collection_issued_by = request.getParameter("collection_issued_by");
                String end_date = request.getParameter("end_date");

                obj.put( "start_date",start_date);
                obj.put( "collection_issued_by",collection_issued_by);
                obj.put( "end_date",end_date);

                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .csau_report_apps_signedout_by_csau_front_officers_by_date(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





            if (request_type.equals("csau_report_count_bills_created_by_csau_front_officers_by_date")) {
               
                String start_date = request.getParameter("start_date");
                String regional_code = request.getParameter("regional_code");
                String end_date = request.getParameter("end_date");
                String mode_of_query = request.getParameter("mode_of_query");

                obj.put( "start_date",start_date);
                obj.put( "regional_code",regional_code);
                obj.put( "end_date",end_date);
                obj.put( "mode_of_query",mode_of_query);

                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .csau_report_count_bills_created_by_csau_front_officers_by_date(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }






            if (request_type.equals("csau_report_all_bills_created_by_csau_front_officers_by_date")) {
               
                String start_date = request.getParameter("start_date");
                String created_by_id = request.getParameter("created_by_id");
                String end_date = request.getParameter("end_date");
                String mode_of_query = request.getParameter("mode_of_query");

                obj.put( "start_date",start_date);
                obj.put( "created_by_id",created_by_id);
                obj.put( "end_date",end_date);
                obj.put( "mode_of_query",mode_of_query);

                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .csau_report_all_bills_created_by_csau_front_officers_by_date(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }





               if (request_type.equals("compliance_executive_dashboard10")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .compliance_executive_dashboard10(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("compliance_executive_dashboard11")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .compliance_executive_dashboard11(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }




            if (request_type.equals("compliance_executive_dashboard12")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .compliance_executive_dashboard12(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;
            }



            if (request_type.equals("compliance_executive_dashboard13")) {

                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
                System.out.println(obj.toString());

                web_service_response = cls_monitoring
                        .compliance_executive_dashboard13(cls_url_config.getWeb_service_url_ser(),
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
