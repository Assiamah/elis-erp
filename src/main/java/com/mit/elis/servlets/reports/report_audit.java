package com.mit.elis.servlets.reports;

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
import ws.reports.ws_audit_report;

// @MultipartConfig(
//         fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
//         maxFileSize         = 1024 * 1024 * 10, // 10 MB
//         maxRequestSize      = 1024 * 1024 * 15 // 15 MB
// )

@RestController
public class report_audit {


    @Autowired
	private Ws_url_config cls_url_config;
	//cls_business_process business_process_cl = new cls_business_process();
    // ws_csau_monitoring cls_monitoring = new ws_csau_monitoring();

    ws_audit_report cls_audit_report = new ws_audit_report();

	@RequestMapping("/audit_reporting")
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

			if (request_type.equals("audit_report_count_on_payments")) {

                String regional_code = request.getParameter("regional_code");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");


                obj.put( "regional_code" , regional_code );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
              //  System.out.println(obj.toString());

                web_service_response = cls_audit_report
                        .audit_report_count_on_payments(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }





            if (request_type.equals("audit_report_on_subservices")) {

                

                String regional_code = request.getParameter("regional_code");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");

                obj.put( "regional_code" , regional_code );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
              //  System.out.println(obj.toString());

                web_service_response = cls_audit_report
                        .audit_report_on_subservices(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }




            if (request_type.equals("audit_report_on_bill_items")) {

                String business_sub_id = request.getParameter("business_sub_id");

                String regional_code = request.getParameter("regional_code");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");

                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );
                obj.put( "regional_code" , regional_code );
                obj.put( "business_sub_id" , business_sub_id );
              //  System.out.println(obj.toString());

                web_service_response = cls_audit_report
                        .audit_report_on_bill_items(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }





            if (request_type.equals("audit_report_on_all_transactions")) {

                String regional_code = request.getParameter("regional_code");
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");


                obj.put( "regional_code" , regional_code );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );

                web_service_response = cls_audit_report
                        .audit_report_on_all_transactions(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }






            if (request_type.equals("audit_report_on_bill_items_by_job_number")) {

                String job_number = request.getParameter("job_number");

                obj.put( "job_number" , job_number );
              //  System.out.println(obj.toString());

                web_service_response = cls_audit_report
                        .audit_report_on_bill_items_by_job_number(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }




            if (request_type.equals("audit_report_on_bill_items_by_regions")) {

                String bill_item_name = request.getParameter("bill_item_name");
                String business_process_sub_name = request.getParameter("business_process_sub_name");

                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");

                


                obj.put( "bill_item_name" , bill_item_name );
                obj.put( "business_process_sub_name" , business_process_sub_name );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );

                web_service_response = cls_audit_report
                        .audit_report_on_bill_items_by_regions(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }


              if (request_type.equals("get_activity_trends")) {

                String bill_item_name = request.getParameter("bill_item_name");
                String business_process_sub_name = request.getParameter("business_process_sub_name");

                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");

                


                obj.put( "bill_item_name" , bill_item_name );
                obj.put( "business_process_sub_name" , business_process_sub_name );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );

                web_service_response = cls_audit_report
                        .get_activity_trends(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }


              if (request_type.equals("get_audit_dashboard_stats")) {

                String get_change_region_compliance_ar = request.getParameter("get_change_region_compliance_ar");
                String type_of_report_name_rpt = request.getParameter("type_of_report_name_rpt");
                String unit_division_to_send_to_rpt_ar = request.getParameter("unit_division_to_send_to_rpt_ar");
                String unit_to_send_to_rpt_ar = request.getParameter("unit_to_send_to_rpt_ar");
                String user_to_send_to_rpt_ar = request.getParameter("user_to_send_to_rpt_ar");
                String start_date_ar = request.getParameter("start_date_ar");
                String end_date_ar = request.getParameter("end_date_ar");


                obj.put( "get_change_region_compliance_ar" , get_change_region_compliance_ar );
                obj.put( "type_of_report_name_rpt" , type_of_report_name_rpt );
                obj.put( "unit_division_to_send_to_rpt_ar" , unit_division_to_send_to_rpt_ar );
                obj.put( "unit_to_send_to_rpt_ar" , unit_to_send_to_rpt_ar );
                obj.put( "user_to_send_to_rpt_ar" , user_to_send_to_rpt_ar );
                obj.put( "start_date_ar" , start_date_ar );
               obj.put( "end_date_ar" , end_date_ar );


               System.out.println(obj.toString());

                web_service_response = cls_audit_report
                        .get_audit_dashboard_stats(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }


              if (request_type.equals("get_recent_activities")) {

                String bill_item_name = request.getParameter("bill_item_name");
                String business_process_sub_name = request.getParameter("business_process_sub_name");

                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");

                


                obj.put( "bill_item_name" , bill_item_name );
                obj.put( "business_process_sub_name" , business_process_sub_name );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );

                web_service_response = cls_audit_report
                        .get_recent_activities(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }


              if (request_type.equals("get_user_activity_summary")) {

                String bill_item_name = request.getParameter("bill_item_name");
                String business_process_sub_name = request.getParameter("business_process_sub_name");

                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");

                


                obj.put( "bill_item_name" , bill_item_name );
                obj.put( "business_process_sub_name" , business_process_sub_name );
                obj.put( "start_date" , start_date );
                obj.put( "end_date" , end_date );

                web_service_response = cls_audit_report
                        .get_user_activity_summary(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }

            



            

 if (request_type.equals("get_audit_dashboard_stats_admin")) {

                // String bill_item_name = request.getParameter("bill_item_name");
                // String business_process_sub_name = request.getParameter("business_process_sub_name");

                String start_date_ar = request.getParameter("start_date_ar");
                String end_date_ar = request.getParameter("end_date_ar");

                
                // obj.put( "bill_item_name" , bill_item_name );
                // obj.put( "business_process_sub_name" , business_process_sub_name );
                obj.put( "start_date_ar" , start_date_ar );
                obj.put( "end_date_ar" , end_date_ar );

                web_service_response = cls_audit_report
                        .get_audit_dashboard_stats_admin(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }





              if (request_type.equals("get_advanced_activity_logs_summary")) {

                // String bill_item_name = request.getParameter("bill_item_name");
                // String business_process_sub_name = request.getParameter("business_process_sub_name");

                String start_date_ar = request.getParameter("start_date_ar");
                String end_date_ar = request.getParameter("end_date_ar");

                
                // obj.put( "bill_item_name" , bill_item_name );
                // obj.put( "business_process_sub_name" , business_process_sub_name );
                obj.put( "start_date_ar" , start_date_ar );
                obj.put( "end_date_ar" , end_date_ar );

                web_service_response = cls_audit_report
                        .get_advanced_activity_logs_summary(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }




             if (request_type.equals("get_advanced_activity_logs_summary_by_type")) {

                // String bill_item_name = request.getParameter("bill_item_name");
                // String business_process_sub_name = request.getParameter("business_process_sub_name");

                String start_date_ar = request.getParameter("start_date_ar");
                String end_date_ar = request.getParameter("end_date_ar");
                 String p_log_type = request.getParameter("p_log_type");

                
                // obj.put( "bill_item_name" , bill_item_name );
                // obj.put( "business_process_sub_name" , business_process_sub_name );
                obj.put( "start_date_ar" , start_date_ar );
                obj.put( "end_date_ar" , end_date_ar );
                obj.put( "p_log_type" , p_log_type );

                web_service_response = cls_audit_report
                        .get_advanced_activity_logs_summary_by_type(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }




              if (request_type.equals("get_advanced_activity_logs_summary_by_type_by_userid")) {

                // String bill_item_name = request.getParameter("bill_item_name");
                // String business_process_sub_name = request.getParameter("business_process_sub_name");

                String start_date_ar = request.getParameter("start_date_ar");
                String end_date_ar = request.getParameter("end_date_ar");
                 String p_user_id = request.getParameter("p_user_id");
                String p_log_type = request.getParameter("p_log_type");

                
                // obj.put( "bill_item_name" , bill_item_name );
                // obj.put( "business_process_sub_name" , business_process_sub_name );
                obj.put( "start_date_ar" , start_date_ar );
                obj.put( "end_date_ar" , end_date_ar );
                obj.put( "p_user_id" , p_user_id );
                obj.put( "p_log_type" , p_log_type );


                web_service_response = cls_audit_report
                        .get_advanced_activity_logs_summary_by_type_by_userid(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }





              if (request_type.equals("get_advanced_activity_logs_summary_by_type_by_activity_id")) {

                // String bill_item_name = request.getParameter("bill_item_name");
                // String business_process_sub_name = request.getParameter("business_process_sub_name");

                String start_date_ar = request.getParameter("start_date_ar");
                String end_date_ar = request.getParameter("end_date_ar");
                String p_sal_id = request.getParameter("p_sal_id");

                
                // obj.put( "bill_item_name" , bill_item_name );
                // obj.put( "business_process_sub_name" , business_process_sub_name );
                obj.put( "start_date_ar" , start_date_ar );
                obj.put( "end_date_ar" , end_date_ar );
                obj.put( "p_sal_id" , p_sal_id );


                web_service_response = cls_audit_report
                        .get_advanced_activity_logs_summary_by_type_by_activity_id(cls_url_config.getWeb_service_url_ser(),
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
