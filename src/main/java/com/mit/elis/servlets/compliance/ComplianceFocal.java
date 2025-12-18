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

import ws.compliance.ws_focal_compliance;


@RestController
public class ComplianceFocal {



    @Autowired
	private Ws_url_config cls_url_config;
	//cls_business_process business_process_cl = new cls_business_process();
    // ws_csau_monitoring cls_monitoring = new ws_csau_monitoring();

    // ws_director_compliance cls_director_compliance = new ws_director_compliance();

    ws_focal_compliance cls_focal_compliance = new ws_focal_compliance();
    

	@RequestMapping("/focal_compliance")
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

			if (request_type.equals("compliance_focal_report_dashboard_created_today")) {

                String region_id = request.getParameter("region_id");
                String user_division = request.getParameter("user_division");

                obj.put( "region_id" , region_id );
                obj.put( "user_division" , user_division );
              //  System.out.println(obj.toString());

                web_service_response = cls_focal_compliance
                        .compliance_focal_report_dashboard_created_today(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }




            if (request_type.equals("compliance_focal_report_dashboard_created_day_by_division")) {

                String region_id = request.getParameter("region_id");
                String division = request.getParameter("division");

                obj.put( "region_id" , region_id );
                obj.put( "division" , division );
              //  System.out.println(obj.toString());

                web_service_response = cls_focal_compliance
                        .compliance_focal_report_dashboard_created_day_by_division(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }



            if (request_type.equals("compliance_focal_report_dashboard_created_day_by_service_type")) {

                String region_id = request.getParameter("region_id");
                String service_type = request.getParameter("service_type");

                obj.put( "region_id" , region_id );
                obj.put( "service_type" , service_type );
              //  System.out.println(obj.toString());

                web_service_response = cls_focal_compliance
                        .compliance_focal_report_dashboard_created_day_by_service_type(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }





            if (request_type.equals("compliance_focal_report_dashboard_created_this_month")) {

              String region_id = request.getParameter("region_id");
              String user_division = request.getParameter("user_division");

              obj.put( "region_id" , region_id );
              obj.put( "user_division" , user_division );
            //  System.out.println(obj.toString());

              web_service_response = cls_focal_compliance
                      .compliance_focal_report_dashboard_created_this_month(cls_url_config.getWeb_service_url_ser(),
                              cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
              if (web_service_response != null) {
                //  System.out.println(web_service_response);
              } else {
                //  System.out.println(web_service_response);
              }

              return web_service_response;
          }




          if (request_type.equals("compliance_focal_report_dashboard_created_month_by_division")) {

            String region_id = request.getParameter("region_id");
            String division = request.getParameter("division");

            obj.put( "region_id" , region_id );
            obj.put( "division" , division );
          //  System.out.println(obj.toString());

            web_service_response = cls_focal_compliance
                    .compliance_focal_report_dashboard_created_month_by_division(cls_url_config.getWeb_service_url_ser(),
                            cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            if (web_service_response != null) {
              //  System.out.println(web_service_response);
            } else {
              //  System.out.println(web_service_response);
            }

            return web_service_response;
        }




        if (request_type.equals("compliance_focal_report_dashboard_created_month_by_service_type")) {

          String region_id = request.getParameter("region_id");
          String service_type = request.getParameter("service_type");

          obj.put( "region_id" , region_id );
          obj.put( "service_type" , service_type );
        //  System.out.println(obj.toString());

          web_service_response = cls_focal_compliance
                  .compliance_focal_report_dashboard_created_month_by_service_type(cls_url_config.getWeb_service_url_ser(),
                          cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
          if (web_service_response != null) {
            //  System.out.println(web_service_response);
          } else {
            //  System.out.println(web_service_response);
          }

          return web_service_response;
      }


      if (request_type.equals("compliance_focal_report_dashboard_completed_today")) {

        String region_id = request.getParameter("region_id");
        String user_division = request.getParameter("user_division");

        obj.put( "region_id" , region_id );
        obj.put( "user_division" , user_division );
      //  System.out.println(obj.toString());

        web_service_response = cls_focal_compliance
                .compliance_focal_report_dashboard_completed_today(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
        if (web_service_response != null) {
          //  System.out.println(web_service_response);
        } else {
          //  System.out.println(web_service_response);
        }

        return web_service_response;
    }





  if (request_type.equals("compliance_focal_report_dashboard_completed_today_by_division")) {

    String region_id = request.getParameter("region_id");
    String division = request.getParameter("division");

    obj.put( "region_id" , region_id );
    obj.put( "division" , division );
  //  System.out.println(obj.toString());

    web_service_response = cls_focal_compliance
            .compliance_focal_report_dashboard_completed_today_by_division(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
    if (web_service_response != null) {
      //  System.out.println(web_service_response);
    } else {
      //  System.out.println(web_service_response);
    }

    return web_service_response;
}






if (request_type.equals("compliance_focal_report_dashboard_completed_today_by_service_ty")) {

  String region_id = request.getParameter("region_id");
  String service_type = request.getParameter("service_type");

  obj.put( "region_id" , region_id );
  obj.put( "service_type" , service_type );
//  System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_completed_today_by_service_ty(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("compliance_focal_report_dashboard_completed_month")) {

  String region_id = request.getParameter("region_id");
  String user_division = request.getParameter("user_division");

  obj.put( "region_id" , region_id );
  obj.put( "user_division" , user_division );
//  System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_completed_month(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}



if (request_type.equals("compliance_focal_report_dashboard_completed_month_by_division")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");

  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
//  System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_completed_month_by_division(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("compliance_focal_report_dashboard_completed_month_by_service_ty")) {

  String region_id = request.getParameter("region_id");
  String service_type = request.getParameter("service_type");

  obj.put( "region_id" , region_id );
  obj.put( "service_type" , service_type );
//  System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_completed_month_by_service_ty(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}


if (request_type.equals("compliance_focal_report_dashboard_all")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");

  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
 System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_all(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    // System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}





if (request_type.equals("compliance_focal_report_dashboard_created_year_by_division")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");

  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
 System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_created_year_by_division(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
//   System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("compliance_focal_report_dashboard_created_year_by_service_type")) {

  String region_id = request.getParameter("region_id");
  String service_type = request.getParameter("service_type");

  obj.put( "region_id" , region_id );
  obj.put( "service_type" , service_type );
//  System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_created_year_by_service_type(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("compliance_focal_report_dashboard_created_completed_year_by_div")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");

  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
 System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_created_completed_year_by_div(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
//   System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}





if (request_type.equals("compliance_focal_report_dashboard_created_completed_year_by_ser")) {

  String region_id = request.getParameter("region_id");
  String service_type = request.getParameter("service_type");

  obj.put( "region_id" , region_id );
  obj.put( "service_type" , service_type );
//  System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_created_completed_year_by_ser(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}





if (request_type.equals("compliance_focal_report_dashboard_completed_year_by_division")) {

  String region_id = request.getParameter("region_id");
  String division = request.getParameter("division");

  obj.put( "region_id" , region_id );
  obj.put( "division" , division );
 System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_completed_year_by_division(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
//   System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}




if (request_type.equals("compliance_focal_report_dashboard_completed_year_by_service_typ")) {

  String region_id = request.getParameter("region_id");
  String service_type = request.getParameter("service_type");

  obj.put( "region_id" , region_id );
  obj.put( "service_type" , service_type );
//  System.out.println(obj.toString());

  web_service_response = cls_focal_compliance
          .compliance_focal_report_dashboard_completed_year_by_service_typ(cls_url_config.getWeb_service_url_ser(),
                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
  if (web_service_response != null) {
    //  System.out.println(web_service_response);
  } else {
    //  System.out.println(web_service_response);
  }

  return web_service_response;
}






if (request_type.equals("compliance_focal_apps_pastdue_units")) {

    String region_id = request.getParameter("region_id");
    String division = request.getParameter("division");
  
    obj.put( "region_id" , region_id );
    obj.put( "division" , division );
  //  System.out.println(obj.toString());
  
    web_service_response = cls_focal_compliance
            .compliance_focal_apps_pastdue_units(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
    if (web_service_response != null) {
      //  System.out.println(web_service_response);
    } else {
      //  System.out.println(web_service_response);
    }
  
    return web_service_response;
  }





  if (request_type.equals("compliance_focal_apps_pastdue_within_unit")) {

    String region_id = request.getParameter("region_id");
    String division = request.getParameter("division");
    String unit = request.getParameter("unit");


    
  
    obj.put( "region_id" , region_id );
    obj.put( "division" , division );
    obj.put( "unit" , unit );
  //  System.out.println(obj.toString());
  
    web_service_response = cls_focal_compliance
            .compliance_focal_apps_pastdue_within_unit(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
    if (web_service_response != null) {
      //  System.out.println(web_service_response);
    } else {
      //  System.out.println(web_service_response);
    }
  
    return web_service_response;
  }





  if (request_type.equals("compliance_focal_apps_pastdue_with_officer")) {

    String staff_id = request.getParameter("staff_id");
    // String division = request.getParameter("division");
    // String unit = request.getParameter("unit");


    
  
    obj.put( "staff_id" , staff_id );
    // obj.put( "division" , division );
    // obj.put( "unit" , unit );
  //  System.out.println(obj.toString());
  
    web_service_response = cls_focal_compliance
            .compliance_focal_apps_pastdue_with_officer(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
    if (web_service_response != null) {
      //  System.out.println(web_service_response);
    } else {
      //  System.out.println(web_service_response);
    }
  
    return web_service_response;
  }

  




  if (request_type.equals("compliance_focal_apps_with_division")) {

    String region_id = request.getParameter("region_id");
    String division = request.getParameter("division");
  
    obj.put( "region_id" , region_id );
    obj.put( "division" , division );
  //  System.out.println(obj.toString());
  
    web_service_response = cls_focal_compliance
            .compliance_focal_apps_with_division(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
    if (web_service_response != null) {
      //  System.out.println(web_service_response);
    } else {
      //  System.out.println(web_service_response);
    }
  
    return web_service_response;
  }








  if (request_type.equals("compliance_focal_apps_with_division_unit")) {

    String region_id = request.getParameter("region_id");
    String division = request.getParameter("division");
    String unit = request.getParameter("unit");


    
    obj.put( "region_id" , region_id );
    obj.put( "division" , division );
    obj.put( "unit" , unit );
  //  System.out.println(obj.toString());
  
    web_service_response = cls_focal_compliance
            .compliance_focal_apps_with_division_unit(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
    if (web_service_response != null) {
      //  System.out.println(web_service_response);
    } else {
      //  System.out.println(web_service_response);
    }
  
    return web_service_response;
  }

  






  if (request_type.equals("compliance_focal_apps_with_division_staff_apps")) {

    String staff_id = request.getParameter("staff_id");
    // String division = request.getParameter("division");
    // String unit = request.getParameter("unit");


    
  
    obj.put( "staff_id" , staff_id );
    // obj.put( "division" , division );
    // obj.put( "unit" , unit );
  //  System.out.println(obj.toString());
  
    web_service_response = cls_focal_compliance
            .compliance_focal_apps_with_division_staff_apps(cls_url_config.getWeb_service_url_ser(),
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
