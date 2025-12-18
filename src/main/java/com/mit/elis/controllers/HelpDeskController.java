package com.mit.elis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;

@Controller
public class HelpDeskController {

    @Autowired
    private Ws_url_config cls_url_config;
    cls_casemgt casemgt_cl = new cls_casemgt();

    @RequestMapping("/call_center")
    @PostMapping
    public String call_center(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
            // Session is expired
            request.setAttribute("login", "sessionout");
            System.out.println("If Not success");
             model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

        }

        try {

            // HttpSession session = request.getSession();

            String servletName = request.getServletPath();
            servletName = servletName.replace("/", "");
            String assigenedmenus = (String) session.getAttribute("menus_com");
            boolean isFound = assigenedmenus.contains(servletName); // true

            // Log User out if the user tries to access right not assigned
            if (!isFound) {
                request.setAttribute("login", "Please this is not alllowed");
                //
                 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

            }

            request.setAttribute("page_name", "help_desk");
            		model.addAttribute("content", "../pages/help_desk/call_center.jsp"); return "layouts/app";

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;

    }

    @RequestMapping("/ticket")
    @PostMapping
    public String ticket(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
            // Session is expired
            request.setAttribute("login", "sessionout");
            System.out.println("If Not success");
             model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

        }

        try {

            // HttpSession session = request.getSession();

            String servletName = request.getServletPath();
            servletName = servletName.replace("/", "");
            String assigenedmenus = (String) session.getAttribute("menus_com");
            boolean isFound = assigenedmenus.contains(servletName); // true

            // Log User out if the user tries to access right not assigned
            if (!isFound) {
                request.setAttribute("login", "Please this is not alllowed");
                //
                 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

            }

            // Set units arrays from db
            ArrayList<String> issuesList = new ArrayList<String>();
            issuesList.add("General Issues");
            issuesList.add("Billing Issues");
            issuesList.add("Support Issues");
            issuesList.add("Password Issues");
            issuesList.add("Account Issues");

            String[] jobs = { "LVDGAST6098162021", "LVDGAST905162021", "LVDGAST634162021" };

            request.setAttribute("page_name", "ticket");
            request.setAttribute("issues", issuesList);
            request.setAttribute("jobs", jobs);
            		model.addAttribute("content", "../pages/tickets/ticket.jsp"); return "layouts/app";

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;

    }

}
