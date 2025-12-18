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

import ws.casemgt.cls_casemgt;
import ws.cica.cica_docs;
import ws.cica.ws_cica;
import ws.compliance.ws_executive_financials;
import ws.csaumgt.ws_csau_monitoring;

@Controller
public class CsauMonitoringController {
    

    @Autowired
	private Ws_url_config cls_url_config;

    ServletRequest servletContext;


	ws_executive_financials cls_financials = new ws_executive_financials();
	ws_csau_monitoring cls_monitoring = new ws_csau_monitoring();
	

	

    @RequestMapping("/csau_monitoring")
	@GetMapping
	public String csau_monitoring(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

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
			
			
			JSONObject obj =new JSONObject();
			
			obj.put("regional_code",regional_code);

			String web_service_response = cls_monitoring.monitoring_csau(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(), obj.toString());

            //System.out.println(web_service_response);
            JSONObject web_response_obj = new JSONObject(web_service_response); 
           

			//String web_service_response = cls_financials.compliance_executive_financials(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
			//String web_service_response = cls_monitoring.monitoring_csau(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
            //String web_service_response1 = cls_monitoring.monitoring_csau1(cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());

			//JSONObject web_response_obj = new JSONObject(web_service_response); 


		JSONObject jo = new JSONObject(web_service_response);
        final JSONArray geodata = jo.getJSONArray("recieved_today");
        int arrLength = geodata.length();
        for(int i = 0; i< arrLength;i++) {
            jo  = geodata.getJSONObject(i);
           String recieved_today = jo.get("total").toString(); 
          request.setAttribute("recieved_today",recieved_today);
		 // System.out.println(recieved_month);
        }


        JSONObject jo11 = new JSONObject(web_service_response);
        final JSONArray geodata11 = jo11.getJSONArray("recieved_week");
        int arrLength11 = geodata11.length();
        for(int i = 0; i< arrLength11;i++) {
            jo11  = geodata11.getJSONObject(i);
           String recieved_week = jo11.get("total").toString(); 
          request.setAttribute("recieved_week",recieved_week);
		 // System.out.println(recieved_week);
        }


        JSONObject jo1 = new JSONObject(web_service_response);
        final JSONArray geodata1 = jo1.getJSONArray("recieved_month");
        int arrLength1 = geodata1.length();
        for(int i = 0; i< arrLength1;i++) {
            jo1 = geodata1.getJSONObject(i);
           String recieved_month = jo1.get("total").toString(); 
          request.setAttribute("recieved_month",recieved_month);

        }

		JSONObject jo2 = new JSONObject(web_service_response);
        final JSONArray geodata2 = jo2.getJSONArray("recieved_year");
        int arrLength2 = geodata2.length();
        for(int i = 0; i< arrLength2;i++) {
            jo2 = geodata2.getJSONObject(i);
           String recieved_year = jo2.get("total").toString(); 
          request.setAttribute("recieved_year",recieved_year);
        }
		

		JSONObject jo3 = new JSONObject(web_service_response);
        final JSONArray geodata3 = jo3.getJSONArray("bills_6months");
        int arrLength3 = geodata3.length();
        for(int i = 0; i< arrLength3;i++) {
            jo3 = geodata3.getJSONObject(i);
           String bills_6months = jo3.get("total").toString(); 
          request.setAttribute("bills_6months",bills_6months);
        }


		JSONObject jo4 = new JSONObject(web_service_response);
        final JSONArray geodata4 = jo4.getJSONArray("createdandpaid");
        int arrLength4 = geodata4.length();
        for(int i = 0; i< arrLength4;i++) {
            jo4 = geodata4.getJSONObject(i);
           String createdandpaid = jo4.get("total").toString(); 
          request.setAttribute("createdandpaid",createdandpaid);
        }
		

		JSONObject jo5 = new JSONObject(web_service_response);
        final JSONArray geodata5 = jo5.getJSONArray("bills_acknowledged");
        int arrLength5 = geodata5.length();
        for(int i = 0; i< arrLength5;i++) {
            jo5 = geodata5.getJSONObject(i);
           String bills_acknowledged = jo5.get("total").toString(); 
          request.setAttribute("bills_acknowledged",bills_acknowledged);
        }



		JSONObject jo6 = new JSONObject(web_service_response);
        final JSONArray geodata6 = jo6.getJSONArray("signedout_today");
        int arrLength6 = geodata6.length();
        for(int i = 0; i< arrLength6;i++) {
            jo6 = geodata6.getJSONObject(i);
           String signedout_today = jo6.get("total").toString(); 
          request.setAttribute("signedout_today",signedout_today);
          //int percentage = total_yearly_completed_apps * 100; 
        }


        JSONObject jo7 = new JSONObject(web_service_response);
        final JSONArray geodata7 = jo7.getJSONArray("signedout_month");
        int arrLength7 = geodata7.length();
        for(int i = 0; i< arrLength7;i++) {
            jo7 = geodata7.getJSONObject(i);
           String signedout_month = jo7.get("total").toString(); 
          request.setAttribute("signedout_month",signedout_month);
          //int percentage = total_yearly_completed_apps * 100; 
        //  System.out.println(total_december);
        }

		JSONObject jo8 = new JSONObject(web_service_response);
        final JSONArray geodata8 = jo8.getJSONArray("signedout_year");
        int arrLength8 = geodata8.length();
        for(int i = 0; i< arrLength8;i++) {
            jo8 = geodata8.getJSONObject(i);
           String signedout_year = jo8.get("total").toString(); 
          request.setAttribute("signedout_year",signedout_year);
          //int percentage = total_yearly_completed_apps * 100; 
        //System.out.println(signedout_year);
        }

		JSONObject jo9 = new JSONObject(web_service_response);
        final JSONArray geodata9 = jo9.getJSONArray("createdandpaid_today");
        int arrLength9 = geodata9.length();
        for(int i = 0; i< arrLength9;i++) {
            jo9 = geodata9.getJSONObject(i);
           String createdandpaid_today = jo9.get("total").toString(); 
          request.setAttribute("createdandpaid_today",createdandpaid_today);
          //int percentage = total_yearly_completed_apps * 100; 
        // System.out.println(total_february);
        }


		JSONObject jo10 = new JSONObject(web_service_response);
        final JSONArray geodata10 = jo10.getJSONArray("createdandack_today");
        int arrLength10 = geodata10.length();
        for(int i = 0; i< arrLength10;i++) {
            jo10 = geodata10.getJSONObject(i);
           String createdandack_today = jo10.get("total").toString(); 
          request.setAttribute("createdandack_today",createdandack_today);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(total_march);
        }


        JSONObject jo12 = new JSONObject(web_service_response);
        final JSONArray geodata12 = jo12.getJSONArray("signedout_week");
        int arrLength12 = geodata12.length();
        for(int i = 0; i< arrLength12;i++) {
            jo12 = geodata12.getJSONObject(i);
           String signedout_week = jo12.get("total").toString(); 
          request.setAttribute("signedout_week",signedout_week);
          //int percentage = total_yearly_completed_apps * 100; 
         //System.out.println(signedout_week);
        }
		



		//System.out.println(web_service_response);


					model.addAttribute("content", "../pages/client_application/csau_monitoring.jsp"); return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }
}
