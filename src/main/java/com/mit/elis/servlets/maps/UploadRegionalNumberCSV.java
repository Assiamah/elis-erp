package com.mit.elis.servlets.maps;

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

public class UploadRegionalNumberCSV {
	@Autowired
	private Ws_url_config cls_url_config;

	// private final String SAVE_DIR = cls_url_config.getTempfile_location();
	// private final File TEMP_DIRECTORY = new
	// File(cls_url_config.getTempfile_location());

	@RequestMapping("/UploadRegionalNumberCSV")
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

			FileInputStream excelFile = new FileInputStream(new File(fullpath));
			Workbook workbook = new HSSFWorkbook(excelFile);
			Sheet datatypeSheet = workbook.getSheetAt(0);
			Iterator<Row> iterator = datatypeSheet.iterator();

			int rowNumber = 0;

			while (iterator.hasNext()) {

				Row currentRow = iterator.next();
				// skip header
				if (rowNumber == 0) {
					rowNumber++;
					continue;
				}

				Iterator<Cell> cellsInRow = currentRow.iterator();

				JSONObject obj = new JSONObject();
				int cellIndex = 0;
				while (cellsInRow.hasNext()) {

					Cell currentCell = cellsInRow.next();
					// System.out.print(currentCell.getStringCellValue() +
					// "--");
					// obj.put("coordinate_name",
					// currentCell.getStringCellValue());

					if (cellIndex == 0) { // ID
						// cust.setId(String.valueOf(currentCell.getNumericCellValue()));
						obj.put("id", currentCell.getNumericCellValue());
					} else if (cellIndex == 1) { // Name
						// cust.setName(currentCell.getStringCellValue());
						obj.put("applicant_name", currentCell.getStringCellValue());
					} else if (cellIndex == 2) { // Address
						// cust.setAddress(currentCell.getStringCellValue());
						obj.put("locality", currentCell.getStringCellValue());
					} else if (cellIndex == 3) { // Age
						// cust.setAge((int) currentCell.getNumericCellValue());
						obj.put("gender", currentCell.getStringCellValue());
					} else if (cellIndex == 4) { // Age
						// cust.setAge((int) currentCell.getNumericCellValue());
						obj.put("district", currentCell.getStringCellValue());
					} else if (cellIndex == 5) { // Age
						// cust.setAge((int) currentCell.getNumericCellValue());
						obj.put("region", currentCell.getStringCellValue());
					}

					cellIndex++;

				}
				jsonArr.put(obj);
				//// System.out.println();

			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/*
		 * File newDirectory = new File(TEMP_DIRECTORY, "SHAPE"); //
		 * assertFalse(newDirectory.exists()); newDirectory.mkdir(); //new
		 * File("/path/directory").mkdir();
		 * 
		 * String zipFilePath = fullpath; String destDirectory = savePath + "/"
		 * + "SHAPE"; UnzipUtility unzipper = new UnzipUtility(); try {
		 * unzipper.unzip(zipFilePath, destDirectory); } catch (Exception ex) {
		 * // some errors occurred ex.printStackTrace(); }
		 */

		/*
		 * JSONArray jsonArr = new JSONArray(); String input = "";
		 * 
		 * String csvFile = fullpath; BufferedReader br = null; String line =
		 * ""; String cvsSplitBy = ",";
		 * 
		 * try {
		 * 
		 * br = new BufferedReader(new FileReader(csvFile)); while ((line =
		 * br.readLine()) != null) {
		 * 
		 * // use comma as separator String[] country = line.split(cvsSplitBy);
		 * 
		 * // //System.out.println("x_coodinate [code= " + country[1] + " , //
		 * y_coodinate=" + country[2] + "]");
		 * 
		 * JSONObject obj = new JSONObject();
		 * 
		 * // String gid = request.getParameter("gid"); // String sheet_number =
		 * request.getParameter("sheet_number"); // String file_number =
		 * request.getParameter("file_number");
		 * 
		 * System.out.println(country.toString()); obj.put("coordinate_name",
		 * country[0]); obj.put("x_coordinate", country[1]);
		 * obj.put("y_coordinate", country[2]);
		 * 
		 * jsonArr.put(obj);
		 * 
		 * // Get all tokens available in line // String[] tokens =
		 * line.split(DELIMITER);
		 * 
		 * for(String token : country) { //Print all tokens
		 * 
		 * }
		 * 
		 * 
		 * }
		 * 
		 * input = jsonArr.toString(); System.out.println(input);
		 * 
		 * } catch (FileNotFoundException e) { e.printStackTrace(); } catch
		 * (IOException e) { e.printStackTrace(); } catch (JSONException e) { //
		 * TODO Auto-generated catch block e.printStackTrace(); } finally { if
		 * (br != null) { try { br.close(); } catch (IOException e) {
		 * e.printStackTrace(); } } }
		 * 
		 * JSONObject obj = new JSONObject(); try { obj.put("success", true);
		 * obj.put("data", input); } catch (JSONException e) { // TODO
		 * Auto-generated catch block e.printStackTrace(); }
		 */

		// out.println(jsonArr.toString());
		return jsonArr.toString();
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
