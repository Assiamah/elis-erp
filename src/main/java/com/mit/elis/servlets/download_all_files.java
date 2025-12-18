package com.mit.elis.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.cls_casemgt;

@RestController
public class download_all_files {

    @RequestMapping("/download_all_files")
    @PostMapping

    public String download_all_files(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String file_path = request.getParameter("file_path");
        System.out.println(file_path);

        if (file_path == null || file_path.equals("")) {
            throw new ServletException("File Name can't be null or empty");
        }
        File file = new File(file_path);
        if (!file.exists()) {
            throw new ServletException("File doesn't exists on server.");
        }
        System.out.println("File location on server::" + file.getAbsolutePath());
        // ServletContext ctx = getServletContext();
        InputStream fis = new FileInputStream(file);
        /// String mimeType = ctx.getMimeType(file.getAbsolutePath());
        // response.setContentType(mimeType != null ? mimeType :
        /// "application/octet-stream");
        response.setContentLength((int) file.length());
        // response.setHeader("Content-Disposition", "attachment; filename=\"" +
        // "file_path" + mimeType + "\"");

        ServletOutputStream os = response.getOutputStream();
        byte[] bufferData = new byte[1024];
        int read = 0;
        while ((read = fis.read(bufferData)) != -1) {
            os.write(bufferData, 0, read);
        }
        os.flush();
        os.close();
        fis.close();
        System.out.println("File downloaded at client successfully");
        return file_path;

    }

}
