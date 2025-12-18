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

import ws.compliance.ws_director_compliance;
import ws.csaumgt.ws_backoffice_monitoring;
import ws.csaumgt.ws_csau_monitoring;


// @MultipartConfig(
//         fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
//         maxFileSize         = 1024 * 1024 * 10, // 10 MB
//         maxRequestSize      = 1024 * 1024 * 15 // 15 MB
// )


@RestController
public class ComplianceDirector {

     @Autowired
	private Ws_url_config cls_url_config;
	//cls_business_process business_process_cl = new cls_business_process();
    // ws_csau_monitoring cls_monitoring = new ws_csau_monitoring();

    ws_director_compliance cls_director_compliance = new ws_director_compliance();

	@RequestMapping("/director_dashboard")
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

			if (request_type.equals("director_report_dashboard_created_today")) {

                String region_id = request.getParameter("region_id");
                String user_division = request.getParameter("user_division");

                obj.put( "region_id" , region_id );
                obj.put( "user_division" , user_division );
              //  System.out.println(obj.toString());

                web_service_response = cls_director_compliance
                        .director_report_dashboard_created_today(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }




            if (request_type.equals("director_report_dashboard_created_day_by_division")) {

                String region_id = request.getParameter("region_id");
                String division = request.getParameter("division");

                obj.put( "region_id" , region_id );
                obj.put( "division" , division );
              //  System.out.println(obj.toString());

                web_service_response = cls_director_compliance
                        .director_report_dashboard_created_day_by_division(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }



            if (request_type.equals("director_report_dashboard_created_day_by_service_type")) {

                String region_id = request.getParameter("region_id");
                String service_type = request.getParameter("service_type");

                obj.put( "region_id" , region_id );
                obj.put( "service_type" , service_type );
              //  System.out.println(obj.toString());

                web_service_response = cls_director_compliance
                        .director_report_dashboard_created_day_by_service_type(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }





            if (request_type.equals("director_report_dashboard_created_this_month")) {

              String region_id = request.getParameter("region_id");
              String user_division = request.getParameter("user_division");

              obj.put( "region_id" , region_id );
              obj.put( "user_division" , user_division );
            //  System.out.println(obj.toString());

              web_service_response = cls_director_compliance
                      .director_report_dashboard_created_this_month(cls_url_config.getWeb_service_url_ser(),
                              cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
              if (web_service_response != null) {
                //  System.out.println(web_service_response);
              } else {
                //  System.out.println(web_service_response);
              }

              return web_service_response;
          }




          if (request_type.equals("director_report_dashboard_created_month_by_division")) {

            String region_id = request.getParameter("region_id");
            String division = request.getParameter("division");

            obj.put( "region_id" , region_id );
            obj.put( "division" , division );
          //  System.out.println(obj.toString());

            web_service_response = cls_director_compliance
                    .director_report_dashboard_created_month_by_division(cls_url_config.getWeb_service_url_ser(),
                            cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            if (web_service_response != null) {
              //  System.out.println(web_service_response);
            } else {
              //  System.out.println(web_service_response);
            }

            return web_service_response;
        }




        if (request_type.equals("director_report_dashboard_created_month_by_service_type")) {

          String region_id = request.getParameter("region_id");
          String service_type = request.getParameter("service_type");

          obj.put( "region_id" , region_id );
          obj.put( "service_type" , service_type );
        //  System.out.println(obj.toString());

          web_service_response = cls_director_compliance
                  .director_report_dashboard_created_month_by_service_type(cls_url_config.getWeb_service_url_ser(),
                          cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
          if (web_service_response != null) {
            //  System.out.println(web_service_response);
          } else {
            //  System.out.println(web_service_response);
          }

          return web_service_response;
      }


      if (request_type.equals("director_report_dashboard_completed_today")) {

        String region_id = request.getParameter("region_id");
        String user_division = request.getParameter("user_division");

        obj.put( "region_id" , region_id );
        obj.put( "user_division" , user_division );
      //  System.out.println(obj.toString());

        web_service_response = cls_director_compliance
                .director_report_dashboard_completed_today(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
        if (web_service_response != null) {
          //  System.out.println(web_service_response);
        } else {
          //  System.out.println(web_service_response);
        }

        return web_service_response;
    }





  if (request_type.equals("director_report_dashboard_completed_today_by_division")) {

    String region_id = request.getParameter("region_id");
    String division = request.getParameter("division");

    obj.put( "region_id" , region_id );
    obj.put( "division" , division );
  //  System.out.println(obj.toString());

    web_service_response = cls_director_compliance
            .director_report_dashboard_completed_today_by_division(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
    if (web_service_response != null) {
      //  System.out.println(web_service_response);
    } else {
      //  System.out.println(web_service_response);
    }

    return web_service_response;
}






if (request_type.equals("director_report_dashboard_completed_today_by_service_type")) {

  String region_id = request.getParameter("region_id");
  String service_type = request.getParameter("service_type");

  obj.put( "region_id" , region_id );
  obj.put( "service_type" , service_type );
//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_completed_today_by_service_type(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("director_report_dashboard_completed_month")) {

  String region_id = request.getParameter("region_id");
  String user_division = request.getParameter("user_division");

  obj.put( "region_id" , region_id );
  obj.put( "user_division" , user_division );
//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_completed_month(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}



if (request_type.equals("director_report_dashboard_completed_month_by_division")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");

  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_completed_month_by_division(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("director_report_dashboard_pending_as_at_day_by_division")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");

  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_pending_as_at_day_by_division(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}






if (request_type.equals("director_report_dashboard_completed_month_by_service_type")) {

  String region_id = request.getParameter("region_id");
  String service_type = request.getParameter("service_type");

  obj.put( "region_id" , region_id );
  obj.put( "service_type" , service_type );
//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_completed_month_by_service_type(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}


if (request_type.equals("director_report_dashboard_all")) {

  // String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");
  String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");

  // obj.put( "region_id" , region_id );
  obj.put( "division" , division );
    obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );

 System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_all(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    // System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}





if (request_type.equals("director_report_dashboard_created_year_by_division")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");
  String region_name = request.getParameter("region_name");
  String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");

  // obj.put( "region_id" , region_id );
    obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
  obj.put( "region_name" , region_name );
  
 System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_created_year_by_division(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
//   System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("director_report_dashboard_created_year_by_service_type")) {

  String region_id = request.getParameter("region_id");
  String service_type = request.getParameter("service_type");
    String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");
  String status = request.getParameter("status");

  


  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "region_id" , region_id );
  obj.put( "service_type" , service_type );
  obj.put( "status" , status );
//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_created_year_by_service_type(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("director_report_dashboard_created_completed_year_by_division")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");
   String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");

  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
 System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_created_completed_year_by_division(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
//   System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}





if (request_type.equals("director_report_dashboard_created_completed_year_by_service_typ")) {

  String region_id = request.getParameter("region_id");
  String service_type = request.getParameter("service_type");
 String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");
  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "region_id" , region_id );
  obj.put( "service_type" , service_type );
//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_created_completed_year_by_service_typ(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}





if (request_type.equals("director_report_dashboard_completed_year_by_division")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");
  String region_name = request.getParameter("region_name");
  String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");


  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
  obj.put( "region_name" , region_name );

 System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_completed_year_by_division(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
//   System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("director_report_dashboard_completed_year_by_service_type")) {

  String region_id = request.getParameter("region_id");
  String service_type = request.getParameter("service_type");
  String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");

  
  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "region_id" , region_id );
  obj.put( "service_type" , service_type );
//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_completed_year_by_service_type(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}






if (request_type.equals("director_compliance_apps_pastdue_units")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");
  String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");

  
  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_compliance_apps_pastdue_units(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("director_compliance_apps_pastdue_within_unit")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");
  String unit = request.getParameter("unit");
  String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");

  
  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
  obj.put( "unit" , unit );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_compliance_apps_pastdue_within_unit(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}










if (request_type.equals("director_compliance_apps_pastdue_with_officer")) {

  String staff_id = request.getParameter("staff_id");
  String division = request.getParameter("division");
  String region_code = request.getParameter("region_code");
  String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");

  
  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "staff_id" , staff_id );
  obj.put( "division" , division );
  obj.put( "region_code" , region_code );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_compliance_apps_pastdue_with_officer(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}





if (request_type.equals("director_compliance_apps_with_division_units")) {

  String division = request.getParameter("division");
  String region_id = request.getParameter("region_id");
  String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");

  
  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "division" , division );
  obj.put( "region_id" , region_id );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_compliance_apps_with_division_units(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}







if (request_type.equals("director_compliance_apps_withdivision_within_unit")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");
  String unit = request.getParameter("unit");
 String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");

  
  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
  obj.put( "unit" , unit );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_compliance_apps_withdivision_within_unit(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("director_compliance_apps_withdivisions_with_officer")) {

  String staff_id = request.getParameter("staff_id");
  String division = request.getParameter("division");
  String region_code = request.getParameter("region_code");


  obj.put( "staff_id" , staff_id );
  obj.put( "division" , division );
  obj.put( "region_code" , region_code );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_compliance_apps_withdivisions_with_officer(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}







if (request_type.equals("director_report_dashboard_created_day_by_regions")) {

  String division = request.getParameter("division");

  obj.put( "division" , division );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_created_day_by_regions(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}





if (request_type.equals("director_report_dashboard_created_month_by_regions")) {

  String division = request.getParameter("division");

  obj.put( "division" , division );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_created_month_by_regions(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}





if (request_type.equals("director_report_dashboard_completed_today_by_regions")) {

  String division = request.getParameter("division");

  obj.put( "division" , division );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_completed_today_by_regions(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("director_report_dashboard_completed_month_by_regions")) {

  String division = request.getParameter("division");

  obj.put( "division" , division );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_report_dashboard_completed_month_by_regions(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}





if (request_type.equals("director_compliance_apps_withdivision_with_officer")) {

  String staff_id = request.getParameter("staff_id");
  String division = request.getParameter("division");
  String region_code = request.getParameter("region_code");
  String date_from = request.getParameter("date_from");
  String date_to = request.getParameter("date_to");

  
  // obj.put( "region_id" , region_id );
  obj.put( "date_from" , date_from );
  obj.put( "date_to" , date_to );
  obj.put( "staff_id" , staff_id );
  obj.put( "division" , division );
  obj.put( "region_code" , region_code );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .director_compliance_apps_withdivision_with_officer(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("select_application_stages_by_job_number")) {

  String job_number = request.getParameter("job_number");

  
  // obj.put( "region_id" , region_id );
  obj.put( "job_number" , job_number );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .select_application_stages_by_job_number(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("select_application_notices_by_job_number")) {

  String job_number = request.getParameter("job_number");

  
  // obj.put( "region_id" , region_id );
  obj.put( "job_number" , job_number );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .select_application_notices_by_job_number(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("select_application_notice_replies")) {

  String notice_id = request.getParameter("notice_id");

  
  // obj.put( "region_id" , region_id );
  obj.put( "notice_id" , notice_id );

//  System.out.println(obj.toString());

  web_service_response = cls_director_compliance
          .select_application_notice_replies(cls_url_config.getWeb_service_url_ser(),
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
