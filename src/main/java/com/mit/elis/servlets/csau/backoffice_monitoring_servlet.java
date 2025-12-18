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

import ws.csaumgt.ws_backoffice_monitoring;


// @MultipartConfig(
//         fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
//         maxFileSize         = 1024 * 1024 * 10, // 10 MB
//         maxRequestSize      = 1024 * 1024 * 15 // 15 MB
// )


@RestController
public class backoffice_monitoring_servlet {

    @Autowired
	private Ws_url_config cls_url_config;
	//cls_business_process business_process_cl = new cls_business_process();
    	ws_backoffice_monitoring cls_backoffice_monitoring = new ws_backoffice_monitoring();


        @RequestMapping("/csau_manager_dashboard_backoffice")
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
    
                if (request_type.equals("load_apps_backoffice_further_entries_applications_recieved_toda")) {
    
                    String regional_code = request.getParameter("regional_code");
    
                    obj.put( "regional_code" , regional_code );
                  //  System.out.println(obj.toString());
    
                    web_service_response = cls_backoffice_monitoring
                            .load_apps_backoffice_further_entries_applications_recieved_toda(cls_url_config.getWeb_service_url_ser(),
                                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                    if (web_service_response != null) {
                      //  System.out.println(web_service_response);
                    } else {
                      //  System.out.println(web_service_response);
                    }
    
                    return web_service_response;
                }



                 if (request_type.equals("load_apps_backoffice_further_entries_applications_recieved_week")) {
    
                    String regional_code = request.getParameter("regional_code");
    
                    obj.put( "regional_code" , regional_code );
                  //  System.out.println(obj.toString());
    
                    web_service_response = cls_backoffice_monitoring
                            .load_apps_backoffice_further_entries_applications_recieved_week(cls_url_config.getWeb_service_url_ser(),
                                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                    if (web_service_response != null) {
                      //  System.out.println(web_service_response);
                    } else {
                      //  System.out.println(web_service_response);
                    }
    
                    return web_service_response;
                }




                 if (request_type.equals("load_apps_backoffice_further_entries_applications_recieved_mont")) {
    
                    String regional_code = request.getParameter("regional_code");
    
                    obj.put( "regional_code" , regional_code );
                  //  System.out.println(obj.toString());
    
                    web_service_response = cls_backoffice_monitoring
                            .load_apps_backoffice_further_entries_applications_recieved_mont(cls_url_config.getWeb_service_url_ser(),
                                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                    if (web_service_response != null) {
                      //  System.out.println(web_service_response);
                    } else {
                      //  System.out.println(web_service_response);
                    }
    
                    return web_service_response;
                }




                 if (request_type.equals("load_apps_backoffice_further_entries_applications_recieved_year")) {
    
                    String regional_code = request.getParameter("regional_code");
    
                    obj.put( "regional_code" , regional_code );
                  //  System.out.println(obj.toString());
    
                    web_service_response = cls_backoffice_monitoring
                            .load_apps_backoffice_further_entries_applications_recieved_year(cls_url_config.getWeb_service_url_ser(),
                                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                    if (web_service_response != null) {
                      //  System.out.println(web_service_response);
                    } else {
                      //  System.out.println(web_service_response);
                    }
    
                    return web_service_response;
                }





                if (request_type.equals("select_count_worked_on_batching_officers")) {
    
                  String regional_code = request.getParameter("regional_code");
  
                  obj.put( "regional_code" , regional_code );
                //  System.out.println(obj.toString());
  
                  web_service_response = cls_backoffice_monitoring
                          .select_count_worked_on_batching_officers(cls_url_config.getWeb_service_url_ser(),
                                  cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                  if (web_service_response != null) {
                    //  System.out.println(web_service_response);
                  } else {
                    //  System.out.println(web_service_response);
                  }
  
                  return web_service_response;
              }




              if (request_type.equals("select_count_worked_on_batching_officers_week")) {
    
                String regional_code = request.getParameter("regional_code");

                obj.put( "regional_code" , regional_code );
              //  System.out.println(obj.toString());

                web_service_response = cls_backoffice_monitoring
                        .select_count_worked_on_batching_officers_week(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
                if (web_service_response != null) {
                  //  System.out.println(web_service_response);
                } else {
                  //  System.out.println(web_service_response);
                }

                return web_service_response;
            }




            if (request_type.equals("select_count_worked_on_batching_officers_month")) {
    
              String regional_code = request.getParameter("regional_code");

              obj.put( "regional_code" , regional_code );
            //  System.out.println(obj.toString());

              web_service_response = cls_backoffice_monitoring
                      .select_count_worked_on_batching_officers_month(cls_url_config.getWeb_service_url_ser(),
                              cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
              if (web_service_response != null) {
                //  System.out.println(web_service_response);
              } else {
                //  System.out.println(web_service_response);
              }

              return web_service_response;
          }





          if (request_type.equals("select_count_worked_on_batching_officers_year")) {
    
            String regional_code = request.getParameter("regional_code");

            obj.put( "regional_code" , regional_code );
          //  System.out.println(obj.toString());

            web_service_response = cls_backoffice_monitoring
                    .select_count_worked_on_batching_officers_year(cls_url_config.getWeb_service_url_ser(),
                            cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            if (web_service_response != null) {
              //  System.out.println(web_service_response);
            } else {
              //  System.out.println(web_service_response);
            }

            return web_service_response;
        }





        if (request_type.equals("select_applications_workedon_today_by_csau_batching_officers")) {
    
          String created_by_id = request.getParameter("created_by_id");

          obj.put( "created_by_id",created_by_id);
        //  System.out.println(obj.toString());

          web_service_response = cls_backoffice_monitoring
                  .select_applications_workedon_today_by_csau_batching_officers(cls_url_config.getWeb_service_url_ser(),
                          cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
          if (web_service_response != null) {
            //  System.out.println(web_service_response);
          } else {
            //  System.out.println(web_service_response);
          }

          return web_service_response;
      }



      if (request_type.equals("select_applications_workedon_week_by_csau_batching_officers")) {
    
        String created_by_id = request.getParameter("created_by_id");

        obj.put( "created_by_id",created_by_id);
      //  System.out.println(obj.toString());

        web_service_response = cls_backoffice_monitoring
                .select_applications_workedon_week_by_csau_batching_officers(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
        if (web_service_response != null) {
          //  System.out.println(web_service_response);
        } else {
          //  System.out.println(web_service_response);
        }

        return web_service_response;
    }




    if (request_type.equals("select_applications_workedon_month_by_csau_batching_officers")) {
    
      String created_by_id = request.getParameter("created_by_id");

      obj.put( "created_by_id",created_by_id);
    //  System.out.println(obj.toString());

      web_service_response = cls_backoffice_monitoring
              .select_applications_workedon_month_by_csau_batching_officers(cls_url_config.getWeb_service_url_ser(),
                      cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
      if (web_service_response != null) {
        //  System.out.println(web_service_response);
      } else {
        //  System.out.println(web_service_response);
      }

      return web_service_response;
  }




  if (request_type.equals("select_applications_workedon_year_by_csau_batching_officers")) {
    
    String created_by_id = request.getParameter("created_by_id");

    obj.put( "created_by_id",created_by_id);
  //  System.out.println(obj.toString());

    web_service_response = cls_backoffice_monitoring
            .select_applications_workedon_year_by_csau_batching_officers(cls_url_config.getWeb_service_url_ser(),
                    cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
    if (web_service_response != null) {
      //  System.out.println(web_service_response);
    } else {
      //  System.out.println(web_service_response);
    }

    return web_service_response;
}



          if (request_type.equals("select_count_worked_on_further_entries_officers_today")) {
              
            String regional_code = request.getParameter("regional_code");

            obj.put( "regional_code" , regional_code );
          //  System.out.println(obj.toString());

            web_service_response = cls_backoffice_monitoring
                    .select_count_worked_on_further_entries_officers_today(cls_url_config.getWeb_service_url_ser(),
                            cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            if (web_service_response != null) {
              //  System.out.println(web_service_response);
            } else {
              //  System.out.println(web_service_response);
            }

            return web_service_response;
          }




          if (request_type.equals("select_count_worked_on_further_entries_officers_week")) {
              
            String regional_code = request.getParameter("regional_code");

            obj.put( "regional_code" , regional_code );
          //  System.out.println(obj.toString());

            web_service_response = cls_backoffice_monitoring
                    .select_count_worked_on_further_entries_officers_week(cls_url_config.getWeb_service_url_ser(),
                            cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            if (web_service_response != null) {
              //  System.out.println(web_service_response);
            } else {
              //  System.out.println(web_service_response);
            }

            return web_service_response;
          }




          if (request_type.equals("select_count_worked_on_further_entries_officers_month")) {
              
            String regional_code = request.getParameter("regional_code");

            obj.put( "regional_code" , regional_code );
          //  System.out.println(obj.toString());

            web_service_response = cls_backoffice_monitoring
                    .select_count_worked_on_further_entries_officers_month(cls_url_config.getWeb_service_url_ser(),
                            cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            if (web_service_response != null) {
              //  System.out.println(web_service_response);
            } else {
              //  System.out.println(web_service_response);
            }

            return web_service_response;
          }




          if (request_type.equals("select_count_worked_on_further_entries_officers_year")) {
              
            String regional_code = request.getParameter("regional_code");

            obj.put( "regional_code" , regional_code );
          //  System.out.println(obj.toString());

            web_service_response = cls_backoffice_monitoring
                    .select_count_worked_on_further_entries_officers_year(cls_url_config.getWeb_service_url_ser(),
                            cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            if (web_service_response != null) {
              //  System.out.println(web_service_response);
            } else {
              //  System.out.println(web_service_response);
            }

            return web_service_response;
          }




          if (request_type.equals("select_applications_workedon_today_by_csau_futher_entries_offic")) {
    
            String created_by_id = request.getParameter("created_by_id");
        
            obj.put( "created_by_id",created_by_id);
          //  System.out.println(obj.toString());
        
            web_service_response = cls_backoffice_monitoring
                    .select_applications_workedon_today_by_csau_futher_entries_offic(cls_url_config.getWeb_service_url_ser(),
                            cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            if (web_service_response != null) {
              //  System.out.println(web_service_response);
            } else {
              //  System.out.println(web_service_response);
            }
        
            return web_service_response;
        }



        if (request_type.equals("select_applications_workedon_week_by_csau_futher_entries_offic")) {
    
          String created_by_id = request.getParameter("created_by_id");
      
          obj.put( "created_by_id",created_by_id);
        //  System.out.println(obj.toString());
      
          web_service_response = cls_backoffice_monitoring
                  .select_applications_workedon_week_by_csau_futher_entries_offic(cls_url_config.getWeb_service_url_ser(),
                          cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
          if (web_service_response != null) {
            //  System.out.println(web_service_response);
          } else {
            //  System.out.println(web_service_response);
          }
      
          return web_service_response;
      }




      if (request_type.equals("select_applications_workedon_month_by_csau_futher_entries_offic")) {
    
        String created_by_id = request.getParameter("created_by_id");
    
        obj.put( "created_by_id",created_by_id);
      //  System.out.println(obj.toString());
    
        web_service_response = cls_backoffice_monitoring
                .select_applications_workedon_week_by_csau_futher_entries_offic(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
        if (web_service_response != null) {
          //  System.out.println(web_service_response);
        } else {
          //  System.out.println(web_service_response);
        }
    
        return web_service_response;
    }



          if (request_type.equals("select_applications_workedon_year_by_csau_futher_entries_offic")) {
    
            String created_by_id = request.getParameter("created_by_id");
        
            obj.put( "created_by_id",created_by_id);
          //  System.out.println(obj.toString());
        
            web_service_response = cls_backoffice_monitoring
                    .select_applications_workedon_year_by_csau_futher_entries_offic(cls_url_config.getWeb_service_url_ser(),
                            cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
            if (web_service_response != null) {
              //  System.out.println(web_service_response);
            } else {
              //  System.out.println(web_service_response);
            }
        
            return web_service_response;
        }






        if (request_type.equals("load_apps_backoffice_further_entries_apps_by_divisions_today")) {
    
          String regional_division = request.getParameter("regional_division");

          String regional_code = request.getParameter("regional_code");

          obj.put( "regional_code" , regional_code );
      
          obj.put( "regional_division",regional_division);
        //  System.out.println(obj.toString());
      
          web_service_response = cls_backoffice_monitoring
                  .load_apps_backoffice_further_entries_apps_by_divisions_today(cls_url_config.getWeb_service_url_ser(),
                          cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
          if (web_service_response != null) {
            //  System.out.println(web_service_response);
          } else {
            //  System.out.println(web_service_response);
          }
      
          return web_service_response;
      }




      if (request_type.equals("load_apps_backoffice_further_entries_apps_by_divisions_week")) {
    
        String regional_division = request.getParameter("regional_division");

        String regional_code = request.getParameter("regional_code");

        obj.put( "regional_code" , regional_code );
    
        obj.put( "regional_division",regional_division);
      //  System.out.println(obj.toString());
    
        web_service_response = cls_backoffice_monitoring
                .load_apps_backoffice_further_entries_apps_by_divisions_week(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
        if (web_service_response != null) {
          //  System.out.println(web_service_response);
        } else {
          //  System.out.println(web_service_response);
        }
    
        return web_service_response;
    }





    if (request_type.equals("load_apps_backoffice_further_entries_apps_by_divisions_month")) {
    
      String regional_division = request.getParameter("regional_division");

      String regional_code = request.getParameter("regional_code");

      obj.put( "regional_code" , regional_code );
  
      obj.put( "regional_division",regional_division);
    //  System.out.println(obj.toString());
  
      web_service_response = cls_backoffice_monitoring
              .load_apps_backoffice_further_entries_apps_by_divisions_month(cls_url_config.getWeb_service_url_ser(),
                      cls_url_config.getWeb_service_url_ser_api_key(),  obj.toString());
      if (web_service_response != null) {
        //  System.out.println(web_service_response);
      } else {
        //  System.out.println(web_service_response);
      }
  
      return web_service_response;
  }




  if (request_type.equals("load_apps_backoffice_further_entries_apps_by_divisions_year")) {
    
    String regional_division = request.getParameter("regional_division");

    String regional_code = request.getParameter("regional_code");

    obj.put( "regional_code" , regional_code );

    obj.put( "regional_division",regional_division);
  //  System.out.println(obj.toString());

    web_service_response = cls_backoffice_monitoring
            .load_apps_backoffice_further_entries_apps_by_divisions_year(cls_url_config.getWeb_service_url_ser(),
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
