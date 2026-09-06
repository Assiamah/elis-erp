package com.mit.elis.servlets.ai;

import java.io.File;
import java.io.PrintWriter;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ws.csaumgt.ws_csaumgt;
import ws.rentmgt.Ws_rent_mgt;
import ws.ws_valueadded_services.cls_valueadded_services;

import java.io.File;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import ws.ai_api.Ws_ai_api;
import ws.casemgt.cls_casemgt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class ai_serv {
	Ws_ai_api ai_cl = new Ws_ai_api();

		cls_valueadded_services vas_cl = new cls_valueadded_services();
	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/ai_serv")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);
		// //System.out.println("How are you");
		String web_service_response = null;

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// //System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		try {
			String request_type = request.getParameter("request_type");

			//System.out.println(request_type);

	     if (request_type.equals("send_agent_question")) {
               
                String query = (String) request.getParameter("query"); 
               //System.out.println(query);
				JSONObject obj_d = new JSONObject();

                obj_d.put("user_question", query);
			

             

               web_service_response = ai_cl.select_ai_response(
               cls_url_config.getAi_api(),cls_url_config.getAi_api_key(),
               obj_d.toString());

				if (web_service_response != null) {
					//System.out.println(web_service_response);
				} else {
					//System.out.println(web_service_response);
				}

			}

          
		  if (request_type.equals("chat_with_agent")) {
               
                String chat_messages = (String) request.getParameter("chat_message"); 
				 String case_number = (String) request.getParameter("case_number"); 
				  String job_number = (String) request.getParameter("job_number"); 
				    String business_process_sub_name = (String) request.getParameter("business_process_sub_name"); 
               //System.out.println(query);
			JSONObject obj_d = new JSONObject();

obj_d.put("user_question", chat_messages);
obj_d.put("case_number", case_number);
obj_d.put("job_number", job_number);
obj_d.put("business_process_sub_name", business_process_sub_name);

JSONObject obj = new JSONObject();

			obj.put("case_number", case_number);
			obj.put("job_number", job_number);
			obj.put("job_purpose", "GeneralWorkRequest");


			web_service_response = vas_cl.select_general_request_workflow(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					obj.toString());

					obj_d.put("applicationdetails", web_service_response);


System.out.println(obj_d.toString());

String prompt = ai_cl.prepare_llm_prompt(

        obj_d.toString()

);


JSONObject ollama_request = new JSONObject();

ollama_request.put( "model","llama3.2:latest");

// ollama_request.put( "model","qwen3:8b");
ollama_request.put(
        "prompt",
        prompt
);

ollama_request.put(
        "stream",
        false
);



System.out.println(

        "Ollama Request: "

        + ollama_request.toString()

);

web_service_response = ai_cl.select_llm_response(

        cls_url_config.getAi_api(),

        cls_url_config.getAi_api_key(),

        ollama_request.toString()

);

				if (web_service_response != null) {
					//System.out.println(web_service_response);
				} else {
					//System.out.println(web_service_response);
				}


				// Parse AI response and send back to client
    JSONObject jsonResponse = new JSONObject();
   
        // Parse the AI response (assuming it returns JSON)
        JSONObject aiResult = new JSONObject(web_service_response);
        
        // Extract the response message
        String aiMessage = aiResult.optString("response", "I processed your request.");
      //  String aiOutput = aiResult.optString("output", aiMessage);
        
        jsonResponse.put("success", true);
        jsonResponse.put("message", aiMessage);
        jsonResponse.put("data", aiMessage);
        
 
    
//web_service_response="Howa re you";
				//web_service_response="{\"success\":\"true\",\"message\":\"How are you?\",\"data\":\"How are you?\"}";

web_service_response=jsonResponse.toString();
			}


             System.out.println(web_service_response);
			return web_service_response;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// PrintWriter out = response.getWriter();
		// out.println("<p>Hello World!</p>");

		return web_service_response;
	}



}



