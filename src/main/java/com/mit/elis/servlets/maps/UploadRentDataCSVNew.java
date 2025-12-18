package com.mit.elis.servlets.maps;

import java.io.BufferedReader;
import java.io.File;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.class_common.Ws_url_config;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;

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

public class UploadRentDataCSVNew {
	@Autowired
	private Ws_url_config cls_url_config;

	// private final String SAVE_DIR = cls_url_config.getTempfile_location();
	// private final File TEMP_DIRECTORY = new
	// File(cls_url_config.getTempfile_location());

	@RequestMapping("/UploadRentDataCSVNew")
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

		String case_number = request.getParameter("case_number");
		String file_name_incoming = request.getParameter("file_name");
		String result_of_csv ="";
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
			// System.out.println(filename1);
			// System.out.println(fileName);
			// refines the fileName in case it is an absolute path
			fileName = new File(fileName).getName();
			part.write(savePath + "/" + file_name_incoming);
			fullpath = savePath + "/" + file_name_incoming;
		}

		JSONArray jsonArr = new JSONArray();

		try {

			//FileInputStream excelFile = new FileInputStream(new File(fullpath));
		 String csvFile = fullpath;

            String line = "";  
            String splitBy = ";";  

           // JSONArray jsonArr = new JSONArray();
            Integer coordinate_count =0;
                        BufferedReader br = new BufferedReader(new FileReader(csvFile));       
                        while ((line = br.readLine()) != null)   //returns a Boolean value  
                        {  
							//System.out.println(line.toString());
							if (coordinate_count==0){

                            }else{
                                JSONObject obj = new JSONObject();
                                
								//System.out.println(splitBy);
								String[] coordinates = line.split(splitBy);  
                                // System.out.println(coordinates.toString());
									obj.put("owners_name", coordinates[0]);
									obj.put("address", coordinates[1]);
									obj.put("file_number", coordinates[2]);
									obj.put("ledger", coordinates[3]);
									obj.put("folio", coordinates[4]);
									obj.put("plot_number", coordinates[5]);
									obj.put("plot_size", coordinates[6]);
									obj.put("covenanted_user", coordinates[7]);
									obj.put("current_use", coordinates[8]);
									obj.put("nature_of_devt", coordinates[9]);
									obj.put("ls_number", coordinates[10]);
									obj.put("nature_of_instrument", coordinates[11]);
									obj.put("comm_date", coordinates[12]);
									obj.put("term", coordinates[13]);
									obj.put("consent_date", coordinates[14]);
									obj.put("rent_review_clause", coordinates[15]);
									obj.put("rent_passing", coordinates[16]);
									obj.put("period_in_arrears", coordinates[17]);

									//System.out.println(obj.toString());
                             jsonArr.put(obj);
                            }
                            
                         
                    
                        coordinate_count=+1;
                       }  
                      

			
                
                 result_of_csv=jsonArr.toString();
                // System.out.println(result_of_csv);
               
		

		
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonArr.toString();
	

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
