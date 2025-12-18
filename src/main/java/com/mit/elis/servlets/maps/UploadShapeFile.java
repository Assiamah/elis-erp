package com.mit.elis.servlets.maps;

import java.io.File;
import java.io.IOException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.UnzipUtility;
import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.ServletException;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class UploadShapeFile {
	@Autowired
	private Ws_url_config cls_url_config;

	// private final String SAVE_DIR = cls_url_config.getTempfile_location();
	// private final File TEMP_DIRECTORY = new
	// File(cls_url_config.getTempfile_location());

	@RequestMapping("/UploadShapeFile")
	@PostMapping
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// TODO Auto-generated method stub

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			// System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		String filename1 = "";
		String fullpath = "";
		String savePath = cls_url_config.getTempfile_location();
		// String savePath = appPath + "/" + SAVE_DIR;

		// creates the save directory if it does not exists
		File fileSaveDir = new File(savePath);
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}

		for (Part part : request.getParts()) {
			String fileName = extractFileName(part);

			filename1 = fileName;
			// refines the fileName in case it is an absolute path
			fileName = new File(fileName).getName();
			part.write(savePath + "/" + fileName);
			fullpath = savePath + "/" + fileName;
		}

		File newDirectory = new File(cls_url_config.getTempfile_location(), "SHAPE");
		// assertFalse(newDirectory.exists());
		newDirectory.mkdir();
		// new File("/path/directory").mkdir();

		String zipFilePath = fullpath;
		String destDirectory = savePath + "/" + "SHAPE";
		UnzipUtility unzipper = new UnzipUtility();
		try {
			unzipper.unzip(zipFilePath, destDirectory);
		} catch (Exception ex) {
			// some errors occurred
			ex.printStackTrace();
		}

		// out.println("Upload has been done successfully!");
		// out.println(jsonArr.toString());
		return "Upload has been done successfully!";
		// request.setAttribute("message", "Upload has been done
		// successfully!");
		// getServletContext().getRequestDispatcher("/message.jsp").forward(
		// request, response);

	}

	private String extractFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return "";
	}

}
