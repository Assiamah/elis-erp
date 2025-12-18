package com.mit.elis.servlets.menu;

import java.io.File;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;
import ws.users.Ws_users;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController

public class Menu {
	Ws_users cls_users = new Ws_users();

	@Autowired
	private Ws_url_config cls_url_config;

	@RequestMapping("/Menu")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		JSONObject obj_main_1 = new JSONObject();

		JSONObject obj_main = new JSONObject();
		JSONObject obj_sub_1 = new JSONObject();
		JSONObject obj_sub_2 = new JSONObject();
		JSONObject obj_sub_3 = new JSONObject();

		JSONArray jArr_main = new JSONArray();
		JSONArray jArr_sub = new JSONArray();

		/*
		 * String userName = request.getParameter("user"); String password =
		 * request.getParameter("password");
		 * 
		 */

		/*
		 * String web_service_response =null; web_service_response
		 * =Ws_users.checkUser(userName, password);
		 */
		// try {
		/*
		 * if(web_service_response!=null) {
		 * 
		 * obj.put( "success" , true ); obj.put( "msg" , "User authenticated!"
		 * );
		 */

		/*
		 * obj_sub_1.put( "id" , "1" ); obj_sub_1.put( "text" , "menu11" );
		 * obj_sub_1.put( "iconCls" , "menu_groups" ); obj_sub_1.put(
		 * "parent_id" , "1" ); obj_sub_1.put( "className" , "panel" );
		 * obj_sub_1.put( "leaf" , Boolean.TRUE ); jArr_sub.put(obj_sub_1);
		 * 
		 * 
		 * obj_sub_2.put( "id" , "1" ); obj_sub_2.put( "text" , "menu11" );
		 * obj_sub_2.put( "iconCls" , "menu_groups" ); obj_sub_2.put(
		 * "parent_id" , "1" ); obj_sub_2.put( "className" , "panel" );
		 * obj_sub_2.put( "leaf" , Boolean.TRUE ); jArr_sub.put(obj_sub_2);
		 * 
		 * obj_sub_3.put( "id" , "1" ); obj_sub_3.put( "text" , "menu11" );
		 * obj_sub_3.put( "iconCls" , "menu_groups" ); obj_sub_3.put(
		 * "parent_id" , "1" ); obj_sub_3.put( "className" , "panel" );
		 * obj_sub_3.put( "leaf" , Boolean.TRUE ); jArr_sub.put(obj_sub_3);
		 * 
		 * obj_main.put( "id" , "1" ); obj_main.put( "text" , "menu1" );
		 * obj_main.put( "iconCls" , "menu_admin" ); obj_main.put( "parent_id" ,
		 * "null" ); obj_main.put( "className" , "null" ); obj_main.put( "leaf"
		 * , Boolean.FALSE ); obj_main.put( "items" , jArr_sub.toString());
		 * 
		 * 
		 * jArr_main.put(obj_main);
		 * 
		 * obj_main_1.put( "success" , true ); obj_main_1.put( "items" ,
		 * jArr_main.toString());
		 * 
		 * System.out.println(obj_main_1);
		 */
		/*
		 * }else{ obj.put( "success" , false ); obj.put( "msg" ,
		 * "Incorrect user or password.';" );
		 * 
		 * System.out.println(cls_url_config.getWeb_service_url_ser(),cls_url_config.
		 * getWeb_service_url_ser_api_key(),obj.toString()); }
		 */
		try {

			String web_service_response = null;
			web_service_response = cls_users.get_all_menu(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());

			// System.out.println(web_service_response);

			return web_service_response;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

}
