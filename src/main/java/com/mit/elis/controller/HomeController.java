package com.mit.elis.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

  @GetMapping("/login")
  public String login(HttpSession session, Model model) {
      // Set session attribute
      session.setAttribute("appName", "ELIS App V5");
      // Set content for dynamic include
      // model.addAttribute("content", "/auth/login.jsp"); // use absolute path relative to /WEB-INF/jsp/
      // // Return the main layout
      // return "layouts/app"; // resolves to /WEB-INF/jsp/layouts/app.jsp
        model.addAttribute("content", "../auth/login.jsp");
          return "layouts/guest";
  }


}
