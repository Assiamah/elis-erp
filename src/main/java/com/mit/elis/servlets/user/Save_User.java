package com.mit.elis.servlets.user;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;

import jakarta.servlet.http.Cookie;

/**
 * Servlet implementation class loginservlet
 */
// @WebServlet(description = "Login User Servlet", urlPatterns = {
// "/LoginUser.do" })

@RestController
@WebServlet(urlPatterns = { "/Save_User" })
public class Save_User extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Autowired
	private Ws_url_config cls_url_config;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		PrintWriter out = response.getWriter();
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		String gender = request.getParameter("gender");

		String web_service_response = null;
		// web_service_response =Ws_users.add_new_user(userName, password,gender);
		/*
		 * if(web_service_response!=null)
		 * {
		 * out.println("Username or Password incorrect");
		 * }
		 * request.setAttribute("username", userName);
		 * 
		 */

		response.sendRedirect(request.getContextPath() + "/user_list");

	}

}
