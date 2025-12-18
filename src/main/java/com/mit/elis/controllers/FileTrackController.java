package com.mit.elis.controllers;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import com.google.gson.Gson;

import ws.casemgt.cls_casemgt;

public class FileTrackController {
    
    @RequestMapping("/unit_file_track")
	@GetMapping
	public String unit_file_track(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		String servletName = request.getServletPath();
		servletName = servletName.replace("/", "");
		String assigenedmenus = (String) session.getAttribute("menus_com");
		boolean isFound = false;
		try {
			isFound = assigenedmenus.contains(servletName); // true
			isFound = true;
		} catch (Exception e) {
		}
		// System.out.println(servletName + ' ' + assigenedmenus);
		// Log User out if the user tries to access right not assigned
		if (!isFound) {
			request.setAttribute("login", "Please this is not alllowed");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}
		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		//Gson googleJson = new Gson();
		try {

			request.setAttribute("page_name", "page_file_track");
					model.addAttribute("content", "../pages/file_track/unit_file_track.jsp"); return "layouts/app";

			// request"/csau_template/manual_bills_dashboard.jsp").forward(request,
			// response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return assigenedmenus;
	}
}
