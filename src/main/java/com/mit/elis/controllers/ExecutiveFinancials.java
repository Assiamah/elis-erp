package com.mit.elis.controllers;


import java.util.ArrayList;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import ws.compliance.ws_compliance;
import ws.compliance.ws_executive_financials;
import ws.users.Ws_users;

@Controller
public class ExecutiveFinancials {

       @Autowired
	private Ws_url_config cls_url_config;

    ws_executive_financials cls_financials = new ws_executive_financials();
	

    @RequestMapping("/executive_financials")
	@GetMapping
	public String executive_financials(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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

			Gson googleJson = new Gson(); 

			String web_service_response = cls_financials.compliance_executive_financials(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
			String web_service_response1 = cls_financials.compliance_executive_financials1(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
			String web_service_response2 = cls_financials.compliance_executive_financials2(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
			String web_service_response3 = cls_financials.compliance_executive_financials3(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
            String web_service_response5 = cls_financials.compliance_executive_financials5(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
            String web_service_response4 = cls_financials.compliance_executive_financials4(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
			

			JSONObject web_response_obj = new JSONObject(web_service_response); 
            JSONObject web_response_obj1 = new JSONObject(web_service_response1); 
			JSONObject web_response_obj2 = new JSONObject(web_service_response2); 
			JSONObject web_response_obj3 = new JSONObject(web_service_response3); 
            JSONObject web_response_obj5 = new JSONObject(web_service_response5); 
            JSONObject web_response_obj4 = new JSONObject(web_service_response4); 


         JSONObject jo81 = new JSONObject(web_service_response);
        final JSONArray geodata81 = jo81.getJSONArray("daily_revenue");
        int arrLength81 = geodata81.length();
        for(int i = 0; i< arrLength81;i++) {
            jo81 = geodata81.getJSONObject(i);
           String daily_revenue = jo81.get("total").toString(); 
          request.setAttribute("daily_revenue",daily_revenue);
          //System.out.println(daily_revenue);
        }


		JSONObject jo = new JSONObject(web_service_response);
        final JSONArray geodata = jo.getJSONArray("yearly_revenue");
        int arrLength = geodata.length();
        for(int i = 0; i< arrLength;i++) {
            jo  = geodata.getJSONObject(i);
           String yearly_revenue = jo.get("total").toString(); 
          request.setAttribute("yearly_revenue",yearly_revenue);
		  //System.out.println(yearly_revenue);
        }


        JSONObject jo1 = new JSONObject(web_service_response);
        final JSONArray geodata1 = jo1.getJSONArray("monthly_revenue");
        int arrLength1 = geodata1.length();
        for(int i = 0; i< arrLength1;i++) {
            jo1 = geodata1.getJSONObject(i);
           String monthly_revenue = jo1.get("total").toString(); 
          request.setAttribute("monthly_revenue",monthly_revenue);
          //System.out.println(monthly_revenue);
        }

           JSONObject jo2 = new JSONObject(web_service_response);
        final JSONArray geodata2 = jo2.getJSONArray("total_reg_jan");
        int arrLength2 = geodata2.length();
        for(int i = 0; i< arrLength2;i++) {
            jo2 = geodata2.getJSONObject(i);
           String total_reg_jan = jo2.get("total").toString(); 
          request.setAttribute("total_reg_jan",total_reg_jan);
        }
		

		JSONObject jo3 = new JSONObject(web_service_response);
        final JSONArray geodata3 = jo3.getJSONArray("total_reg_feb");
        int arrLength3 = geodata3.length();
        for(int i = 0; i< arrLength3;i++) {
            jo3 = geodata3.getJSONObject(i);
           String total_reg_feb = jo3.get("total").toString(); 
          request.setAttribute("total_reg_feb",total_reg_feb);
        }


		JSONObject jo4 = new JSONObject(web_service_response);
        final JSONArray geodata4 = jo4.getJSONArray("total_reg_mar");
        int arrLength4 = geodata4.length();
        for(int i = 0; i< arrLength4;i++) {
            jo4 = geodata4.getJSONObject(i);
           String total_reg_mar = jo4.get("total").toString(); 
          request.setAttribute("total_reg_mar",total_reg_mar);
        }




        JSONObject jo5 = new JSONObject(web_service_response);
        final JSONArray geodata5 = jo5.getJSONArray("total_reg_apr");
        int arrLength5 = geodata5.length();
        for(int i = 0; i< arrLength5;i++) {
            jo5 = geodata5.getJSONObject(i);
           String total_reg_apr = jo5.get("total").toString(); 
          request.setAttribute("total_reg_apr",total_reg_apr);
        }



		JSONObject jo6 = new JSONObject(web_service_response);
        final JSONArray geodata6 = jo6.getJSONArray("total_reg_may");
        int arrLength6 = geodata6.length();
        for(int i = 0; i< arrLength6;i++) {
            jo6 = geodata6.getJSONObject(i);
           String total_reg_may = jo6.get("total").toString(); 
          request.setAttribute("total_reg_may",total_reg_may);
          //int percentage = total_yearly_completed_apps * 100; 
        }


        JSONObject jo7 = new JSONObject(web_service_response);
        final JSONArray geodata7 = jo7.getJSONArray("total_reg_june");
        int arrLength7 = geodata7.length();
        for(int i = 0; i< arrLength7;i++) {
            jo7 = geodata7.getJSONObject(i);
           String total_reg_june = jo7.get("total").toString(); 
          request.setAttribute("total_reg_june",total_reg_june);
          //int percentage = total_yearly_completed_apps * 100; 
        //  System.out.println(total_december);
        }

		JSONObject jo8 = new JSONObject(web_service_response);
        final JSONArray geodata8 = jo8.getJSONArray("total_reg_july");
        int arrLength8 = geodata8.length();
        for(int i = 0; i< arrLength8;i++) {
            jo8 = geodata8.getJSONObject(i);
           String total_reg_july = jo8.get("total").toString(); 
          request.setAttribute("total_reg_july",total_reg_july);
          //int percentage = total_yearly_completed_apps * 100; 
        // System.out.println(total_january);
        }


        JSONObject jo9 = new JSONObject(web_service_response);
        final JSONArray geodata9 = jo9.getJSONArray("total_reg_aug");
        int arrLength9 = geodata9.length();
        for(int i = 0; i< arrLength9;i++) {
            jo9 = geodata9.getJSONObject(i);
           String total_reg_aug = jo9.get("total").toString(); 
          request.setAttribute("total_reg_aug",total_reg_aug);
          //int percentage = total_yearly_completed_apps * 100; 
        // System.out.println(total_february);
        }


		JSONObject jo10 = new JSONObject(web_service_response);
        final JSONArray geodata10 = jo10.getJSONArray("total_reg_sep");
        int arrLength10 = geodata10.length();
        for(int i = 0; i< arrLength10;i++) {
            jo10 = geodata10.getJSONObject(i);
           String total_reg_sep = jo10.get("total").toString(); 
          request.setAttribute("total_reg_sep",total_reg_sep);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_march);
        }



         JSONObject jo11 = new JSONObject(web_service_response);
        final JSONArray geodata11 = jo11.getJSONArray("total_reg_oct");
        int arrLength11 = geodata11.length();
        for(int i = 0; i< arrLength11;i++) {
            jo11= geodata11.getJSONObject(i);
           String total_reg_oct = jo11.get("total").toString(); 
          request.setAttribute("total_reg_oct",total_reg_oct);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_march);
        }

		JSONObject jo12 = new JSONObject(web_service_response);
        final JSONArray geodata12 = jo12.getJSONArray("total_reg_nov");
        int arrLength12 = geodata12.length();
        for(int i = 0; i< arrLength12;i++) {
            jo12= geodata12.getJSONObject(i);
           String total_reg_nov = jo12.get("total").toString(); 
          request.setAttribute("total_reg_nov",total_reg_nov);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_april);
        }

      

          JSONObject jo13 = new JSONObject(web_service_response);
        final JSONArray geodata13 = jo13.getJSONArray("total_reg_dec");
        int arrLength13 = geodata13.length();
        for(int i = 0; i< arrLength13;i++) {
            jo13= geodata13.getJSONObject(i);
           String total_reg_dec = jo13.get("total").toString(); 
          request.setAttribute("total_reg_dec",total_reg_dec);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_april);
        }


		JSONObject jo14 = new JSONObject(web_service_response1);
        final JSONArray geodata14 = jo14.getJSONArray("total_search_jan");
        int arrLength14 = geodata14.length();
        for(int i = 0; i< arrLength14;i++) {
            jo14= geodata14.getJSONObject(i);
           String total_search_jan = jo14.get("total").toString(); 
          request.setAttribute("total_search_jan",total_search_jan);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_july);
        }


		JSONObject jo15 = new JSONObject(web_service_response1);
        final JSONArray geodata15 = jo15.getJSONArray("total_search_feb");
        int arrLength15 = geodata15.length();
        for(int i = 0; i< arrLength15;i++) {
            jo15= geodata15.getJSONObject(i);
           String total_search_feb = jo15.get("total").toString(); 
          request.setAttribute("total_search_feb",total_search_feb);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_august);
        }


		JSONObject jo16 = new JSONObject(web_service_response1);
        final JSONArray geodata16 = jo16.getJSONArray("total_search_mar");
        int arrLength16 = geodata16.length();
        for(int i = 0; i< arrLength16;i++) {
            jo16= geodata16.getJSONObject(i);
           String total_search_mar = jo16.get("total").toString(); 
          request.setAttribute("total_search_mar",total_search_mar);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_september);
        }


		JSONObject jo17 = new JSONObject(web_service_response1);
        final JSONArray geodata17 = jo17.getJSONArray("total_search_apr");
        int arrLength17 = geodata17.length();
        for(int i = 0; i< arrLength17;i++) {
            jo17= geodata17.getJSONObject(i);
           String total_search_apr = jo17.get("total").toString(); 
          request.setAttribute("total_search_apr",total_search_apr);
          //int percentage = total_yearly_completed_apps * 100; 
          //System.out.println(total_october);
        }


        JSONObject jo18 = new JSONObject(web_service_response1);
        final JSONArray geodata18 = jo18.getJSONArray("total_search_may");
        int arrLength18 = geodata18.length();
        for(int i = 0; i< arrLength18;i++) {
            jo18= geodata18.getJSONObject(i);
           String total_search_may = jo18.get("total").toString(); 
          request.setAttribute("total_search_may",total_search_may);
          //int percentage = total_yearly_completed_apps * 100; 
           //System.out.println(total_november);
        }


		JSONObject jo19 = new JSONObject(web_service_response1);
        final JSONArray geodata19 = jo19.getJSONArray("total_search_june");
        int arrLength19 = geodata19.length();
        for(int i = 0; i< arrLength19;i++) {
            jo19= geodata19.getJSONObject(i);
           String total_search_june = jo19.get("total").toString(); 
          request.setAttribute("total_search_june",total_search_june);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_december);
        } 


		JSONObject jo20 = new JSONObject(web_service_response1);
        final JSONArray geodata20 = jo20.getJSONArray("total_search_july");
        int arrLength20 = geodata20.length();
        for(int i = 0; i< arrLength20;i++) {
            jo20= geodata20.getJSONObject(i);
           String total_search_july = jo20.get("total").toString(); 
          request.setAttribute("total_search_july",total_search_july);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_pending_january);
        } 


		JSONObject jo21 = new JSONObject(web_service_response1);
        final JSONArray geodata21 = jo21.getJSONArray("total_search_aug");
        int arrLength21 = geodata21.length();
        for(int i = 0; i< arrLength21;i++) {
            jo21= geodata21.getJSONObject(i);
           String total_search_aug = jo21.get("total").toString(); 
          request.setAttribute("total_search_aug",total_search_aug);
          //int percentage = total_yearly_completed_apps * 100; 
        // System.out.println(total_pending_february);
        } 


		JSONObject jo22 = new JSONObject(web_service_response1);
        final JSONArray geodata22 = jo22.getJSONArray("total_search_sep");
        int arrLength22 = geodata22.length();
        for(int i = 0; i< arrLength22;i++) {
            jo22= geodata22.getJSONObject(i);
           String total_search_sep = jo22.get("total").toString(); 
          request.setAttribute("total_search_sep",total_search_sep);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_pending_march);
        } 


		JSONObject jo23 = new JSONObject(web_service_response1);
        final JSONArray geodata23 = jo23.getJSONArray("total_search_oct");
        int arrLength23 = geodata23.length();
        for(int i = 0; i< arrLength23;i++) {
            jo23= geodata23.getJSONObject(i);
           String total_search_oct = jo23.get("total").toString(); 
          request.setAttribute("total_search_oct",total_search_oct);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_pending_march);
        } 


		JSONObject jo24 = new JSONObject(web_service_response1);
        final JSONArray geodata24 = jo24.getJSONArray("total_search_nov");
        int arrLength24 = geodata24.length();
        for(int i = 0; i< arrLength24;i++) {
            jo24= geodata24.getJSONObject(i);
           String total_search_nov = jo24.get("total").toString(); 
          request.setAttribute("total_search_nov",total_search_nov);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_pending_march);
        } 


		JSONObject jo25 = new JSONObject(web_service_response1);
        final JSONArray geodata25 = jo25.getJSONArray("total_search_dec");
        int arrLength25 = geodata25.length();
        for(int i = 0; i< arrLength25;i++) {
            jo25= geodata25.getJSONObject(i);
           String total_search_dec = jo25.get("total").toString(); 
          request.setAttribute("total_search_dec",total_search_dec);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_pending_march);
        } 


		JSONObject jo26 = new JSONObject(web_service_response2);
        final JSONArray geodata26 = jo26.getJSONArray("total_stamp_jan");
        int arrLength26 = geodata26.length();
        for(int i = 0; i< arrLength26;i++) {
            jo26= geodata26.getJSONObject(i);
           String total_stamp_jan = jo26.get("total").toString(); 
          request.setAttribute("total_stamp_jan",total_stamp_jan);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_pending_july);
        } 



		JSONObject jo27 = new JSONObject(web_service_response2);
        final JSONArray geodata27 = jo27.getJSONArray("total_stamp_feb");
        int arrLength27 = geodata27.length();
        for(int i = 0; i< arrLength27;i++) {
            jo27= geodata27.getJSONObject(i);
           String total_stamp_feb = jo27.get("total").toString(); 
          request.setAttribute("total_stamp_feb",total_stamp_feb);
          //int percentage = total_yearly_completed_apps * 100; 
        // System.out.println(total_pending_august);
        } 


		JSONObject jo28 = new JSONObject(web_service_response2);
        final JSONArray geodata28 = jo28.getJSONArray("total_stamp_mar");
        int arrLength28 = geodata28.length();
        for(int i = 0; i< arrLength28;i++) {
            jo28= geodata28.getJSONObject(i);
           String total_stamp_mar = jo28.get("total").toString(); 
          request.setAttribute("total_stamp_mar",total_stamp_mar);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_pending_september);
        }
		
		
		JSONObject jo29 = new JSONObject(web_service_response2);
        final JSONArray geodata29 = jo29.getJSONArray("total_stamp_apr");
        int arrLength29 = geodata29.length();
        for(int i = 0; i< arrLength29;i++) {
            jo29= geodata29.getJSONObject(i);
           String total_stamp_apr = jo29.get("total").toString(); 
          request.setAttribute("total_stamp_apr",total_stamp_apr);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_pending_september);
        } 


		JSONObject jo30 = new JSONObject(web_service_response2);
        final JSONArray geodata30 = jo30.getJSONArray("total_stamp_may");
        int arrLength30 = geodata30.length();
        for(int i = 0; i< arrLength30;i++) {
            jo30= geodata30.getJSONObject(i);
           String total_stamp_may = jo30.get("total").toString(); 
          request.setAttribute("total_stamp_may",total_stamp_may);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_pending_september);
        } 



		JSONObject jo31 = new JSONObject(web_service_response2);
        final JSONArray geodata31 = jo31.getJSONArray("total_stamp_june");
        int arrLength31 = geodata31.length();
        for(int i = 0; i< arrLength31;i++) {
            jo31= geodata31.getJSONObject(i);
           String total_stamp_june = jo31.get("total").toString(); 
          request.setAttribute("total_stamp_june",total_stamp_june);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_pending_december);
        } 


		JSONObject jo32 = new JSONObject(web_service_response2);
        final JSONArray geodata32 = jo32.getJSONArray("total_stamp_july");
        int arrLength32 = geodata32.length();
        for(int i = 0; i< arrLength32;i++) {
            jo32= geodata32.getJSONObject(i);
           String total_stamp_july = jo32.get("total").toString(); 
          request.setAttribute("total_stamp_july",total_stamp_july);
          //int percentage = total_yearly_completed_apps * 100; 
        //System.out.println(total_completed_january);
        } 


		JSONObject jo33 = new JSONObject(web_service_response2);
        final JSONArray geodata33 = jo33.getJSONArray("total_stamp_aug");
        int arrLength33 = geodata33.length();
        for(int i = 0; i< arrLength33;i++) {
            jo33= geodata33.getJSONObject(i);
           String total_stamp_aug = jo33.get("total").toString(); 
          request.setAttribute("total_stamp_aug",total_stamp_aug);
          //int percentage = total_yearly_completed_apps * 100; 
        //System.out.println(total_completed_january);
        } 


		JSONObject jo34 = new JSONObject(web_service_response2);
        final JSONArray geodata34 = jo34.getJSONArray("total_stamp_sep");
        int arrLength34 = geodata34.length();
        for(int i = 0; i< arrLength34;i++) {
            jo34= geodata34.getJSONObject(i);
           String total_stamp_sep = jo34.get("total").toString(); 
          request.setAttribute("total_stamp_sep",total_stamp_sep);
          //int percentage = total_yearly_completed_apps * 100; 
        //System.out.println(total_completed_january);
        } 


		JSONObject jo35 = new JSONObject(web_service_response2);
        final JSONArray geodata35 = jo35.getJSONArray("total_stamp_oct");
        int arrLength35 = geodata35.length();
        for(int i = 0; i< arrLength35;i++) {
            jo35= geodata35.getJSONObject(i);
           String total_stamp_oct = jo35.get("total").toString(); 
          request.setAttribute("total_stamp_oct",total_stamp_oct);
          //int percentage = total_yearly_completed_apps * 100; 
        //System.out.println(total_completed_january);
        } 


		JSONObject jo36 = new JSONObject(web_service_response2);
        final JSONArray geodata36 = jo36.getJSONArray("total_stamp_nov");
        int arrLength36 = geodata36.length();
        for(int i = 0; i< arrLength36;i++) {
            jo36= geodata36.getJSONObject(i);
           String total_stamp_nov = jo36.get("total").toString(); 
          request.setAttribute("total_stamp_nov",total_stamp_nov);
          //int percentage = total_yearly_completed_apps * 100; 
        //System.out.println(total_completed_january);
        } 


		JSONObject jo37 = new JSONObject(web_service_response2);
        final JSONArray geodata37 = jo37.getJSONArray("total_stamp_dec");
        int arrLength37 = geodata37.length();
        for(int i = 0; i< arrLength37;i++) {
            jo37= geodata37.getJSONObject(i);
           String total_stamp_dec = jo37.get("total").toString(); 
          request.setAttribute("total_stamp_dec",total_stamp_dec);
        } 



		JSONObject jo38 = new JSONObject(web_service_response3);
        final JSONArray geodata38 = jo38.getJSONArray("total_plan_jan");
        int arrLength38 = geodata38.length();
        for(int i = 0; i< arrLength38;i++) {
            jo38= geodata38.getJSONObject(i);
           String total_plan_jan = jo38.get("total").toString(); 
          request.setAttribute("total_plan_jan",total_plan_jan);
        } 


		JSONObject jo39 = new JSONObject(web_service_response3);
        final JSONArray geodata39 = jo39.getJSONArray("total_plan_feb");
        int arrLength39 = geodata39.length();
        for(int i = 0; i< arrLength39;i++) {
            jo39= geodata39.getJSONObject(i);
           String total_plan_feb = jo39.get("total").toString(); 
          request.setAttribute("total_plan_feb",total_plan_feb);
        } 



		JSONObject jo40 = new JSONObject(web_service_response3);
        final JSONArray geodata40 = jo40.getJSONArray("total_plan_mar");
        int arrLength40 = geodata40.length();
        for(int i = 0; i< arrLength40;i++) {
            jo40= geodata40.getJSONObject(i);
           String total_plan_mar = jo40.get("total").toString(); 
          request.setAttribute("total_plan_mar",total_plan_mar);
           //System.out.println(total_completed_september);
        } 



		JSONObject jo41 = new JSONObject(web_service_response3);
        final JSONArray geodata41 = jo41.getJSONArray("total_plan_apr");
        int arrLength41 = geodata41.length();
        for(int i = 0; i< arrLength41;i++) {
            jo41= geodata41.getJSONObject(i);
           String total_plan_apr = jo41.get("total").toString(); 
          request.setAttribute("total_plan_apr",total_plan_apr);
          // System.out.println(total_completed_september);
        } 

		JSONObject jo42 = new JSONObject(web_service_response3);
        final JSONArray geodata42 = jo42.getJSONArray("total_plan_may");
        int arrLength42 = geodata42.length();
        for(int i = 0; i< arrLength42;i++) {
            jo42= geodata42.getJSONObject(i);
           String total_plan_may = jo42.get("total").toString(); 
          request.setAttribute("total_plan_may",total_plan_may);
          // System.out.println(total_completed_september);
        } 

		JSONObject jo43 = new JSONObject(web_service_response3);
        final JSONArray geodata43 = jo43.getJSONArray("total_plan_june");
        int arrLength43 = geodata43.length();
        for(int i = 0; i< arrLength43;i++) {
            jo43= geodata43.getJSONObject(i);
           String total_plan_june = jo43.get("total").toString(); 
          request.setAttribute("total_plan_june",total_plan_june);
        
        } 

		JSONObject jo44 = new JSONObject(web_service_response3);
        final JSONArray geodata44 = jo44.getJSONArray("total_plan_july");
        int arrLength44 = geodata44.length();
        for(int i = 0; i< arrLength44;i++) {
            jo44= geodata44.getJSONObject(i);
           String total_plan_july = jo44.get("total").toString(); 
          request.setAttribute("total_plan_july",total_plan_july);
        
        } 

		JSONObject jo45 = new JSONObject(web_service_response3);
        final JSONArray geodata45 = jo45.getJSONArray("total_plan_aug");
        int arrLength45 = geodata45.length();
        for(int i = 0; i< arrLength45;i++) {
            jo45= geodata45.getJSONObject(i);
           String total_plan_aug = jo45.get("total").toString(); 
          request.setAttribute("total_plan_aug",total_plan_aug);
        
        } 

		JSONObject jo46 = new JSONObject(web_service_response3);
        final JSONArray geodata46  = jo46 .getJSONArray("total_plan_sep");
        int arrLength46  = geodata46 .length();
        for(int i = 0; i< arrLength46 ;i++) {
            jo46 = geodata46 .getJSONObject(i);
           String total_plan_sep = jo46 .get("total").toString(); 
          request.setAttribute("total_plan_sep",total_plan_sep);
        
        }
		

		JSONObject jo47 = new JSONObject(web_service_response3);
        final JSONArray geodata47  = jo47 .getJSONArray("total_plan_oct");
        int arrLength47  = geodata47 .length();
        for(int i = 0; i< arrLength47 ;i++) {
            jo47 = geodata47 .getJSONObject(i);
           String total_plan_oct = jo47 .get("total").toString(); 
          request.setAttribute("total_plan_oct",total_plan_oct);

		}


		JSONObject jo48= new JSONObject(web_service_response3);
        final JSONArray geodata48 = jo48.getJSONArray("total_plan_nov");
        int arrLength48 = geodata48.length();
        for(int i = 0; i< arrLength48;i++) {
            jo48= geodata48.getJSONObject(i);
           String total_plan_nov = jo48.get("total").toString(); 
          request.setAttribute("total_plan_nov",total_plan_nov);

		}


		JSONObject jo49= new JSONObject(web_service_response3);
        final JSONArray geodata49 = jo49.getJSONArray("total_plan_dec");
        int arrLength49 = geodata49.length();
        for(int i = 0; i< arrLength49;i++) {
            jo49= geodata49.getJSONObject(i);
           String total_plan_dec = jo49.get("total").toString(); 
          request.setAttribute("total_plan_dec",total_plan_dec);

		}


        JSONObject jo50= new JSONObject(web_service_response5);
        final JSONArray geodata50 = jo50.getJSONArray("yearly_accra_revenue");
        int arrLength50 = geodata50.length();
        for(int i = 0; i< arrLength50;i++) {
            jo50= geodata50.getJSONObject(i);
           String yearly_accra_revenue = jo50.get("total").toString(); 
          request.setAttribute("yearly_accra_revenue",yearly_accra_revenue);
         //System.out.println(yearly_accra_revenue);

		}

         JSONObject jo51= new JSONObject(web_service_response5);
        final JSONArray geodata51 = jo51.getJSONArray("yearly_kumasi_revenue");
        int arrLength51 = geodata51.length();
        for(int i = 0; i< arrLength51;i++) {
            jo51= geodata51.getJSONObject(i);
           String yearly_kumasi_revenue = jo51.get("total").toString(); 
          request.setAttribute("yearly_kumasi_revenue",yearly_kumasi_revenue);
         //System.out.println(yearly_accra_revenue);

		}



         JSONObject jo52= new JSONObject(web_service_response5);
        final JSONArray geodata52 = jo52.getJSONArray("yearly_secondi_revenue");
        int arrLength52 = geodata52.length();
        for(int i = 0; i< arrLength52;i++) {
            jo52= geodata52.getJSONObject(i);
           String yearly_secondi_revenue = jo52.get("total").toString(); 
          request.setAttribute("yearly_secondi_revenue",yearly_secondi_revenue);
         //System.out.println(yearly_accra_revenue);

         

		}

         JSONObject jo53= new JSONObject(web_service_response5);
        final JSONArray geodata53 = jo53.getJSONArray("yearly_bolga_revenue");
        int arrLength53 = geodata53.length();
        for(int i = 0; i< arrLength53;i++) {
            jo53= geodata53.getJSONObject(i);
           String yearly_bolga_revenue = jo53.get("total").toString(); 
          request.setAttribute("yearly_bolga_revenue",yearly_bolga_revenue);
         //System.out.println(yearly_accra_revenue);

		}


         JSONObject jo54= new JSONObject(web_service_response5);
        final JSONArray geodata54 = jo54.getJSONArray("yearly_tema_revenue");
        int arrLength54 = geodata54.length();
        for(int i = 0; i< arrLength54;i++) {
            jo54= geodata54.getJSONObject(i);
           String yearly_tema_revenue = jo54.get("total").toString(); 
          request.setAttribute("yearly_tema_revenue",yearly_tema_revenue);
         //System.out.println(yearly_accra_revenue);

		}



         JSONObject jo55= new JSONObject(web_service_response5);
        final JSONArray geodata55 = jo55.getJSONArray("yearly_techiman_revenue");
        int arrLength55 = geodata55.length();
        for(int i = 0; i< arrLength55;i++) {
            jo55= geodata55.getJSONObject(i);
           String yearly_techiman_revenue = jo55.get("total").toString(); 
          request.setAttribute("yearly_techiman_revenue",yearly_techiman_revenue);
         //System.out.println(yearly_accra_revenue);

		}


          JSONObject jo56= new JSONObject(web_service_response5);
        final JSONArray geodata56 = jo56.getJSONArray("yearly_goaso_revenue");
        int arrLength56 = geodata56.length();
        for(int i = 0; i< arrLength56;i++) {
            jo56= geodata56.getJSONObject(i);
           String yearly_goaso_revenue = jo56.get("total").toString(); 
          request.setAttribute("yearly_goaso_revenue",yearly_goaso_revenue);
         //System.out.println(yearly_accra_revenue);

		}


         JSONObject jo57= new JSONObject(web_service_response5);
        final JSONArray geodata57 = jo57.getJSONArray("yearly_damango_revenue");
        int arrLength57 = geodata57.length();
        for(int i = 0; i< arrLength57;i++) {
            jo57= geodata57.getJSONObject(i);
           String yearly_damango_revenue = jo57.get("total").toString(); 
          request.setAttribute("yearly_damango_revenue",yearly_damango_revenue);
         //System.out.println(yearly_accra_revenue);

		}



         JSONObject jo58= new JSONObject(web_service_response5);
        final JSONArray geodata58 = jo58.getJSONArray("yearly_dambai_revenue");
        int arrLength58 = geodata58.length();
        for(int i = 0; i< arrLength58;i++) {
            jo58= geodata58.getJSONObject(i);
           String yearly_dambai_revenue = jo58.get("total").toString(); 
          request.setAttribute("yearly_dambai_revenue",yearly_dambai_revenue);
         //System.out.println(yearly_accra_revenue);

		}


         JSONObject jo59= new JSONObject(web_service_response5);
        final JSONArray geodata59 = jo59.getJSONArray("yearly_dambai_revenue");
        int arrLength59 = geodata59.length();
        for(int i = 0; i< arrLength59;i++) {
            jo59= geodata59.getJSONObject(i);
           String yearly_dambai_revenue = jo59.get("total").toString(); 
          request.setAttribute("yearly_dambai_revenue",yearly_dambai_revenue);
         //System.out.println(yearly_accra_revenue);

		}



          JSONObject jo60= new JSONObject(web_service_response5);
        final JSONArray geodata60 = jo60.getJSONArray("yearly_wa_revenue");
        int arrLength60 = geodata60.length();
        for(int i = 0; i< arrLength60;i++) {
            jo60= geodata60.getJSONObject(i);
           String yearly_wa_revenue = jo60.get("total").toString(); 
          request.setAttribute("yearly_wa_revenue",yearly_wa_revenue);
         //System.out.println(yearly_accra_revenue);

		}


          JSONObject jo61= new JSONObject(web_service_response5);
        final JSONArray geodata61 = jo61.getJSONArray("yearly_kof_revenue");
        int arrLength61 = geodata61.length();
        for(int i = 0; i< arrLength61;i++) {
            jo61= geodata61.getJSONObject(i);
           String yearly_kof_revenue = jo61.get("total").toString(); 
          request.setAttribute("yearly_kof_revenue",yearly_kof_revenue);
         //System.out.println(yearly_accra_revenue);

		}


        JSONObject jo62= new JSONObject(web_service_response5);
        final JSONArray geodata62 = jo62.getJSONArray("yearly_suny_revenue");
        int arrLength62 = geodata62.length();
        for(int i = 0; i< arrLength62;i++) {
            jo62= geodata62.getJSONObject(i);
           String yearly_suny_revenue = jo62.get("total").toString(); 
          request.setAttribute("yearly_suny_revenue",yearly_suny_revenue);
         //System.out.println(yearly_accra_revenue);

		}



         JSONObject jo63= new JSONObject(web_service_response5);
        final JSONArray geodata63 = jo63.getJSONArray("yearly_cape_revenue");
        int arrLength63 = geodata63.length();
        for(int i = 0; i< arrLength63;i++) {
            jo63= geodata63.getJSONObject(i);
           String yearly_cape_revenue = jo63.get("total").toString(); 
          request.setAttribute("yearly_cape_revenue",yearly_cape_revenue);
         //System.out.println(yearly_accra_revenue);

		}


         JSONObject jo64= new JSONObject(web_service_response5);
        final JSONArray geodata64 = jo64.getJSONArray("yearly_tama_revenue");
        int arrLength64 = geodata64.length();
        for(int i = 0; i< arrLength64;i++) {
            jo64= geodata64.getJSONObject(i);
           String yearly_tama_revenue = jo64.get("total").toString(); 
          request.setAttribute("yearly_tama_revenue",yearly_tama_revenue);
         //System.out.println(yearly_accra_revenue);

		}


        JSONObject jo65= new JSONObject(web_service_response4);
        final JSONArray geodata65 = jo65.getJSONArray("monthly_accra_revenue");
        int arrLength65 = geodata65.length();
        for(int i = 0; i< arrLength65;i++) {
            jo65= geodata65.getJSONObject(i);
           String monthly_accra_revenue = jo65.get("total").toString(); 
          request.setAttribute("monthly_accra_revenue",monthly_accra_revenue);
         //System.out.println(monthly_accra_revenue);
		}



         JSONObject jo66= new JSONObject(web_service_response4);
        final JSONArray geodata66 = jo66.getJSONArray("monthly_secondi_revenue");
        int arrLength66 = geodata66.length();
        for(int i = 0; i< arrLength66;i++) {
            jo66= geodata66.getJSONObject(i);
           String monthly_secondi_revenue = jo66.get("total").toString(); 
          request.setAttribute("monthly_secondi_revenue",monthly_secondi_revenue);
        // System.out.println(monthly_accra_revenue);
		}



     JSONObject jo67= new JSONObject(web_service_response4);
        final JSONArray geodata67 = jo67.getJSONArray("monthly_bolga_revenue");
        int arrLength67 = geodata67.length();
        for(int i = 0; i< arrLength67;i++) {
            jo67= geodata67.getJSONObject(i);
           String monthly_bolga_revenue = jo67.get("total").toString(); 
          request.setAttribute("monthly_bolga_revenue",monthly_bolga_revenue);
        // System.out.println(monthly_accra_revenue);
		}


      JSONObject jo68= new JSONObject(web_service_response4);
        final JSONArray geodata68 = jo68.getJSONArray("monthly_tema_revenue");
        int arrLength68 = geodata68.length();
        for(int i = 0; i< arrLength68;i++) {
            jo68= geodata68.getJSONObject(i);
           String monthly_tema_revenue = jo68.get("total").toString(); 
          request.setAttribute("monthly_tema_revenue",monthly_tema_revenue);
        // System.out.println(monthly_accra_revenue);
		} 


        JSONObject jo69= new JSONObject(web_service_response4);
        final JSONArray geodata69 = jo69.getJSONArray("monthly_techiman_revenue");
        int arrLength69 = geodata69.length();
        for(int i = 0; i< arrLength69;i++) {
            jo69= geodata69.getJSONObject(i);
           String monthly_techiman_revenue = jo69.get("total").toString(); 
          request.setAttribute("monthly_techiman_revenue",monthly_techiman_revenue);
         //System.out.println(monthly_accra_revenue);
		} 


          JSONObject jo70= new JSONObject(web_service_response4);
        final JSONArray geodata70 = jo70.getJSONArray("monthly_goaso_revenue");
        int arrLength70 = geodata70.length();
        for(int i = 0; i< arrLength70;i++) {
            jo70= geodata70.getJSONObject(i);
           String monthly_goaso_revenue = jo70.get("total").toString(); 
          request.setAttribute("monthly_goaso_revenue",monthly_goaso_revenue);
         //System.out.println(monthly_accra_revenue);
		} 


        JSONObject jo71= new JSONObject(web_service_response4);
        final JSONArray geodata71 = jo71.getJSONArray("monthly_damango_revenue");
        int arrLength71 = geodata71.length();
        for(int i = 0; i< arrLength71;i++) {
            jo71= geodata71.getJSONObject(i);
           String monthly_damango_revenue = jo71.get("total").toString(); 
          request.setAttribute("monthly_damango_revenue",monthly_damango_revenue);
         //System.out.println(monthly_accra_revenue);
		} 



         JSONObject jo72= new JSONObject(web_service_response4);
        final JSONArray geodata72 = jo72.getJSONArray("monthly_dambai_revenue");
        int arrLength72 = geodata72.length();
        for(int i = 0; i< arrLength72;i++) {
            jo72= geodata72.getJSONObject(i);
           String monthly_dambai_revenue = jo72.get("total").toString(); 
          request.setAttribute("monthly_dambai_revenue",monthly_dambai_revenue);
         //System.out.println(monthly_accra_revenue);
		} 


          JSONObject jo73= new JSONObject(web_service_response4);
        final JSONArray geodata73 = jo73.getJSONArray("monthly_wa_revenue");
        int arrLength73 = geodata73.length();
        for(int i = 0; i< arrLength73;i++) {
            jo73= geodata73.getJSONObject(i);
           String monthly_wa_revenue = jo73.get("total").toString(); 
          request.setAttribute("monthly_wa_revenue",monthly_wa_revenue);
         //System.out.println(monthly_accra_revenue);
		} 



        JSONObject jo74= new JSONObject(web_service_response4);
        final JSONArray geodata74 = jo74.getJSONArray("monthly_kof_revenue");
        int arrLength74 = geodata74.length();
        for(int i = 0; i< arrLength74;i++) {
            jo74= geodata74.getJSONObject(i);
           String monthly_kof_revenue = jo74.get("total").toString(); 
          request.setAttribute("monthly_kof_revenue",monthly_kof_revenue);
         //System.out.println(monthly_accra_revenue);
		} 



        JSONObject jo75= new JSONObject(web_service_response4);
        final JSONArray geodata75 = jo75.getJSONArray("monthly_suny_revenue");
        int arrLength75 = geodata75.length();
        for(int i = 0; i< arrLength75;i++) {
            jo75= geodata75.getJSONObject(i);
           String monthly_suny_revenue = jo75.get("total").toString(); 
          request.setAttribute("monthly_suny_revenue",monthly_suny_revenue);
         //System.out.println(monthly_accra_revenue);
		} 



        JSONObject jo76= new JSONObject(web_service_response4);
        final JSONArray geodata76 = jo76.getJSONArray("monthly_cape_revenue");
        int arrLength76 = geodata76.length();
        for(int i = 0; i< arrLength76;i++) {
            jo76= geodata76.getJSONObject(i);
           String monthly_cape_revenue = jo76.get("total").toString(); 
          request.setAttribute("monthly_cape_revenue",monthly_cape_revenue);
         //System.out.println(monthly_accra_revenue);
		} 



         JSONObject jo77= new JSONObject(web_service_response4);
        final JSONArray geodata77 = jo77.getJSONArray("monthly_tama_revenue");
        int arrLength77 = geodata77.length();
        for(int i = 0; i< arrLength77;i++) {
            jo77= geodata77.getJSONObject(i);
           String monthly_tama_revenue = jo77.get("total").toString(); 
          request.setAttribute("monthly_tama_revenue",monthly_tama_revenue);
         //System.out.println(monthly_accra_revenue);
		} 


          JSONObject jo78= new JSONObject(web_service_response4);
        final JSONArray geodata78 = jo78.getJSONArray("monthly_secondi_revenue");
        int arrLength78 = geodata78.length();
        for(int i = 0; i< arrLength78;i++) {
            jo78= geodata78.getJSONObject(i);
           String monthly_secondi_revenue = jo78.get("total").toString(); 
          request.setAttribute("monthly_secondi_revenue",monthly_secondi_revenue);
         //System.out.println(monthly_accra_revenue);
		} 


       JSONObject jo79= new JSONObject(web_service_response4);
        final JSONArray geodata79 = jo79.getJSONArray("monthly_kumasi_revenue");
        int arrLength79 = geodata79.length();
        for(int i = 0; i< arrLength79;i++) {
            jo79= geodata79.getJSONObject(i);
           String monthly_kumasi_revenue = jo79.get("total").toString(); 
          request.setAttribute("monthly_kumasi_revenue",monthly_kumasi_revenue);
         //System.out.println(monthly_accra_revenue);
		} 

             
	      //System.out.println(web_service_response4);

					model.addAttribute("content", "../pages/client_application/executive_financials.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }
    
}
