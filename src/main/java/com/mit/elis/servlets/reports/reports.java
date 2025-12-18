package com.mit.elis.servlets.reports;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

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
import ws.casemgt.cls_business_process;
import ws.casemgt.cls_casemgt;
import ws.reports.cls_excel_writer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@RestController
public class reports {

    @Autowired
    private Ws_url_config cls_url_config;
    cls_excel_writer excel_report_cl = new cls_excel_writer();

    @RequestMapping("/reports_api")
    @PostMapping
    public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

        if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
            // Session is expired
            request.setAttribute("login", "sessionout");
            // System.out.println("If Not success");
             model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

        }

        /*
         * request.setAttribute("sub_service", sub_service);
         * request.setAttribute("main_service", main_service);
         */

        /*
         * request.setAttribute("main_service_sub_id", main_service_sub_id);
         * request.setAttribute("main_service_sub_desc", main_service_sub_desc);
         * 
         * request.setAttribute("main_service_id", main_service_id);
         * request.setAttribute("main_service_desc", main_service_desc);
         */

        // String request_type = "excelfile";
        String request_type = request.getParameter("request_type");
        String web_service_response = null;
        JSONObject obj_r = new JSONObject();

        // cls_reports reports_cl = new ();

        request.setAttribute("page_name", "reports");

        // HttpSession session = request.getSession();
        String region_id = (String) (request.getParameter("region_id") != null
                ? request.getParameter("region_id")
                : (String) session.getAttribute("regional_code"));

        if (request_type.equals("excelfile")) {

            String main_service_id;
            String main_service_desc;

            String main_service_sub_id;
            String main_service_sub_desc;

            String main_service = request.getParameter("main_service_rpt");
            String sub_service = request.getParameter("sub_service_rpt");

            /*
             * String[] output = main_service.split("-"); main_service_id =
             * output[0]; main_service_desc = output[1];
             * //main_service_id.replace(".0", "");
             * 
             * String[] output_sub = sub_service.split("-"); main_service_sub_id
             * = output_sub[0]; main_service_sub_desc = output_sub[1];
             */
            // System.out.println(main_service);
            // System.out.println(sub_service);

            String type_of_report_name = request.getParameter("type_of_report_name");
            String business_process = main_service;
            String business_process_sub_name = sub_service;
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");
            String report_parameters = null;

            try {
                // String xmlLocation =
                // getServletContext().getRealPath("/resources/employee.csv");
                String xmlLocation = "C:\\gelisscans\\scanpdf\\employee.csv";

                // System.out.println(xmlLocation);

                obj_r.put("type_of_report_name", type_of_report_name);
                obj_r.put("business_process_id", business_process);
                obj_r.put("business_process_sub_id", business_process_sub_name);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                report_parameters = obj_r.toString();
                String json_output = "excel_cl.get_list_of_users(report_parameters)";

                // JsonFlattener parser = new JsonFlattener();
                // CSVWriter writer = new CSVWriter();
                //
                // List<Map<String, String>> flatJson =
                // parser.parseJson(json_output);
                // writer.writeAsCSV(flatJson, "sample.csv");

                /*
                 * // boolean st =false;
                 * 
                 * 
                 * // Create a Workbook // Workbook workbook = new
                 * XSSFWorkbook(); // new HSSFWorkbook() for generating `.xls`
                 * file Workbook workbook = new HSSFWorkbook(); CreationHelper
                 * helps us create instances of various things like DataFormat,
                 * Hyperlink, RichTextString etc, in a format (HSSF, XSSF)
                 * independent way CreationHelper createHelper =
                 * workbook.getCreationHelper();
                 * 
                 * // Create a Sheet Sheet sheet =
                 * workbook.createSheet("Employee");
                 * 
                 * // Create a Font for styling header cells Font headerFont =
                 * workbook.createFont(); headerFont.setBold(true);
                 * headerFont.setFontHeightInPoints((short) 14);
                 * headerFont.setColor(IndexedColors.RED.getIndex());
                 * 
                 * // Create a CellStyle with the font CellStyle headerCellStyle
                 * = workbook.createCellStyle();
                 * headerCellStyle.setFont(headerFont);
                 * 
                 * // Create a Row Row headerRow = sheet.createRow(0);
                 * 
                 * // Create cells for(int i = 0; i < columns.length; i++) {
                 * Cell cell = headerRow.createCell(i);
                 * cell.setCellValue(columns[i]);
                 * cell.setCellStyle(headerCellStyle); }
                 * 
                 * // Create Cell Style for formatting Date CellStyle
                 * dateCellStyle = workbook.createCellStyle();
                 * dateCellStyle.setDataFormat(createHelper.createDataFormat().
                 * getFormat("dd-MM-yyyy")); // Create Other rows and cells with
                 * employees data int rowNum = 1;
                 * 
                 * 
                 * JSONObject object = new JSONObject(json_output); //JSONArray
                 * jsonarray = new JSONArray(object.getJSONArray("data")); //
                 * String output_arr = object.getJSONArray("data").toString() ;
                 * // JSONArray jsonarray = new JSONArray(output_arr); JSONArray
                 * jsonarray = object.getJSONArray("data") ; for (int i = 0; i <
                 * jsonarray.length(); i++) { Row row =
                 * sheet.createRow(rowNum++); JSONObject jsonobject =
                 * jsonarray.getJSONObject(i);
                 * row.createCell(0).setCellValue(rowNum);
                 * row.createCell(1).setCellValue(jsonobject.getString(
                 * "job_number"));
                 * row.createCell(2).setCellValue(jsonobject.getString("ar_name"
                 * )); row.createCell(3).setCellValue(jsonobject.getString(
                 * "created_date"));
                 * row.createCell(4).setCellValue(jsonobject.getString(
                 * "batch_date"));
                 * row.createCell(5).setCellValue(jsonobject.getString(
                 * "current_application_status"));
                 * row.createCell(6).setCellValue(jsonobject.getString(
                 * "completed_date"));
                 * row.createCell(7).setCellValue(jsonobject.getString(
                 * "collected_date"));
                 * row.createCell(8).setCellValue(jsonobject.getString(
                 * "days_completed"));
                 * row.createCell(9).setCellValue(jsonobject.getString(
                 * "days_collected"));
                 * row.createCell(10).setCellValue(jsonobject.getString(
                 * "business_process_sub_name"));
                 * 
                 * }
                 */

                /*
                 * // Resize all columns to fit the content size for(int i = 0;
                 * i < columns.length; i++) { sheet.autoSizeColumn(i); }
                 */
                // Write the output to a file

                // OutputStream file = new FileOutputStream(new
                // File(xmlLocation));
                // FileOutputStream fileOut = new
                // FileOutputStream("poi-generated-file.xlsx");

                // response.setContentType("application/vnd.ms-excel");

                // ServletOutputStream outStream = response.getOutputStream();

                FileInputStream fileInputStream = new FileInputStream(xmlLocation);
                OutputStream responseOutputStream = response.getOutputStream();

                String disposition = "attachment; fileName=outputfile.csv";
                response.setContentType("text/csv");
                response.setHeader("Content-Disposition", disposition);
                // response.setHeader("content-Length",
                // String.valueOf(stream(inputStream,
                // response.getOutputStream())));

                int bytes;
                while ((bytes = fileInputStream.read()) != -1) {
                    responseOutputStream.write(bytes);
                }

                responseOutputStream.flush();
                responseOutputStream.close();

                /*
                 * response.setHeader("Pragma","public");
                 * response.setHeader("Expires","0"); response.setHeader(
                 * "Cache-Control","must-revalidate, post-check=0, pre-check=0"
                 * ); response.setHeader("Content-Type",
                 * "application/force-download");
                 * response.setHeader("Content-Type","application/vnd.ms-excel")
                 * ; response.setHeader("Content-Disposition",
                 * "attachment; filename=export2excel.xls");
                 */
                /*
                 * workbook.write(responseOutputStream); // Closing the workbook
                 * workbook.close();
                 */

                /*
                 * web_service_response
                 * =excel_cl.create_excel_file(xmlLocation,report_parameters);
                 * 
                 * //try { if(web_service_response!=null) {
                 * 
                 * 
                 * 
                 * // File file = new File(xmlLocation); File pdfFile = new
                 * File(xmlLocation);
                 * 
                 * //response.setContentType("application/pdf");
                 * //response.addHeader("Content-Disposition",
                 * "attachment; filename=MyJerseyPdfFile.pdf");
                 * response.setContentLength((int) pdfFile.length());
                 * 
                 * FileInputStream fileInputStream = new
                 * FileInputStream(pdfFile); OutputStream responseOutputStream =
                 * response.getOutputStream(); int bytes; while ((bytes =
                 * fileInputStream.read()) != -1) {
                 * responseOutputStream.write(bytes); } }else{
                 * 
                 * }
                 */
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            /*
             * } catch (JSONException e) { // TODO Auto-generated catch block
             * e.printStackTrace(); }
             */
            //
            // out.println(obj_r.toString());
            // out.close();
        }

        if (request_type.equals("report_general")) {

            String main_service_id;
            String main_service_desc;

            String main_service_sub_id;
            String main_service_sub_desc;

            String main_service = request.getParameter("main_service_rpt");
            String sub_service = request.getParameter("sub_service_rpt");

            /*
             * String[] output = main_service.split("-"); main_service_id =
             * output[0]; main_service_desc = output[1];
             * //main_service_id.replace(".0", "");
             * 
             * String[] output_sub = sub_service.split("-"); main_service_sub_id
             * = output_sub[0]; main_service_sub_desc = output_sub[1];
             */
            // System.out.println(main_service);
            // System.out.println(sub_service);

            String type_of_report_name = request.getParameter("type_of_report_name");
            String business_process = main_service;
            String business_process_sub_name = sub_service;
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");
            String report_parameters = null;

            try {
                // String xmlLocation =
                // getServletContext().getRealPath("/resources/employee.csv");
                String xmlLocation = "C:\\gelisscans\\scanpdf\\generalreport.xls";

                // System.out.println(xmlLocation);

                obj_r.put("type_of_report_name", type_of_report_name);
                obj_r.put("business_process_id", business_process);
                obj_r.put("business_process_sub_id", business_process_sub_name);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                obj_r.put("region_id", region_id);
                report_parameters = obj_r.toString();

                report_parameters = obj_r.toString();
                // System.out.println(report_parameters);

                String json_output = " excel_cl.get_list_of_users(report_parameters)";

                File pdfFile = new File(xmlLocation);
                byte[] buffer = null;

                // String pdfFilename = "test.pdf"; // I use id here to
                // determine pdf
                // File f = new File(pdfFilename);

                BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
                ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

                int ch;
                long actual = 0;
                while ((ch = is.read()) != -1) {
                    bos.write(ch);
                    actual++;
                }
                bos.flush();
                bos.close();
                buffer = bos.toByteArray();

                // response.setContentType("text/csv");
                response.setContentType("application/vnd.ms-excel");
                response.addHeader("Content-Disposition", "attachment; filename=outputgenfile.xls");

                // response.addHeader("Content-Disposition", "inline;
                // filename=Documentation.pdf");
                response.setContentLength((int) pdfFile.length());
                response.getOutputStream().write(buffer, 0, buffer.length);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            //
            // out.println(obj_r.toString());
            // out.close();
        }

        if (request_type.equals("report_general_new")) {

            String main_service_id;
            String main_service_desc;

            String main_service_sub_id;
            String main_service_sub_desc;

            String main_service = request.getParameter("main_service_rpt");
            String sub_service = request.getParameter("sub_service_rpt");

            // System.out.println(main_service);
            // System.out.println(sub_service);

            String type_of_report_name = request.getParameter("type_of_report_name");
            String business_process = main_service;
            String business_process_sub_name = sub_service;
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");
            String region_code = request.getParameter("region_code");

            String report_parameters = null;
            String json_output = null;

            try {

                obj_r.put("type_of_report_name", type_of_report_name);
                obj_r.put("business_process_id", business_process);
                obj_r.put("business_process_sub_id", business_process_sub_name);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                obj_r.put("region_id", region_id);
                obj_r.put("region_code", region_code);
                report_parameters = obj_r.toString();

                report_parameters = obj_r.toString();
                // System.out.println("Assiamah");
                // System.out.println(report_parameters);

                json_output = excel_report_cl.get_list_of_users(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return json_output;
        }



        if (request_type.equals("report_general_count")) {

            String main_service_id;
            String main_service_desc;

            String main_service_sub_id;
            String main_service_sub_desc;

            String main_service = request.getParameter("main_service_rpt");
            String sub_service = request.getParameter("sub_service_rpt");

            // System.out.println(main_service);
            // System.out.println(sub_service);

            // String type_of_report_name = request.getParameter("type_of_report_name");
            String business_process = main_service;
            String business_process_sub_name = sub_service;
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");
            String region_code = request.getParameter("region_code");

            String report_parameters = null;
            String json_output = null;

            try {

                // obj_r.put("type_of_report_name", type_of_report_name);
                obj_r.put("business_process_id", business_process);
                obj_r.put("business_process_sub_id", business_process_sub_name);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                obj_r.put("region_id", region_id);
                obj_r.put("region_code", region_code);
                report_parameters = obj_r.toString();

                report_parameters = obj_r.toString();
                // System.out.println("Assiamah");
                // System.out.println(report_parameters);

                json_output = excel_report_cl.get_count_of_users(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return json_output;
        }







        if (request_type.equals("report_general_count_query")) {

            String main_service_id;
            String main_service_desc;

            String main_service_sub_id;
            String main_service_sub_desc;

            String main_service = request.getParameter("main_service_rpt");
            String sub_service = request.getParameter("sub_service_rpt");

            // System.out.println(main_service);
            // System.out.println(sub_service);

            // String type_of_report_name = request.getParameter("type_of_report_name");
            String business_process = main_service;
            String business_process_sub_name = sub_service;
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");
            String region_code = request.getParameter("region_code");

            String report_parameters = null;
            String json_output = null;

            try {

                // obj_r.put("type_of_report_name", type_of_report_name);
                obj_r.put("business_process_id", business_process);
                obj_r.put("business_process_sub_id", business_process_sub_name);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                obj_r.put("region_id", region_id);
                obj_r.put("region_code", region_code);
                report_parameters = obj_r.toString();

                report_parameters = obj_r.toString();
                // System.out.println("Assiamah");
                // System.out.println(report_parameters);

                json_output = excel_report_cl.get_count_of_query(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return json_output;
        }

        if (request_type.equals("report_general_new_stpc")) {

            String main_service_id;
            String main_service_desc;

            String main_service_sub_id;
            String main_service_sub_desc;

            String main_service = request.getParameter("main_service_rpt");
            String sub_service = request.getParameter("sub_service_rpt");

            // System.out.println(main_service);
            // System.out.println(sub_service);

            String type_of_report_name = request.getParameter("type_of_report_name");
            String business_process = main_service;
            String business_process_sub_name = sub_service;
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");

            String ar_name_search = request.getParameter("ar_name_search_stpc");
            String report_parameters = null;
            String json_output = null;

            try {

                obj_r.put("type_of_report_name", type_of_report_name);
                obj_r.put("business_process_id", business_process);
                obj_r.put("business_process_sub_id", business_process_sub_name);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                obj_r.put("region_id", region_id);
                obj_r.put("ar_name_search", ar_name_search);

                report_parameters = obj_r.toString();

                report_parameters = obj_r.toString();
                // System.out.println("Assiamah");
                System.out.println(report_parameters);

                json_output = excel_report_cl.report_on_the_cases_stamping(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return json_output;
        }

        if (request_type.equals("generate_details_gra_reports")) {

            String main_service_id;
            String main_service_desc;

            String main_service_sub_id;
            String main_service_sub_desc;

            String main_service = request.getParameter("main_service_rpt");
            String sub_service = request.getParameter("sub_service_rpt");

            // System.out.println(main_service);
            // System.out.println(sub_service);

            String type_of_report_name = request.getParameter("type_of_report_name");
            String business_process = main_service;
            String business_process_sub_name = sub_service;
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");
            String report_parameters = null;
            String json_output = null;

            try {

                obj_r.put("type_of_report_name", type_of_report_name);
                obj_r.put("business_process_id", business_process);
                obj_r.put("business_process_sub_id", business_process_sub_name);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                obj_r.put("region_id", region_id);
                report_parameters = obj_r.toString();

                report_parameters = obj_r.toString();
                // System.out.println("Assiamah");
                System.out.println(report_parameters);

                web_service_response = excel_report_cl
                        .report_landed_cases_gra_revised(cls_url_config.getWeb_service_url_ser(),
                                cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

                System.out.println(web_service_response);

                if (web_service_response != null) {
                    System.out.println(web_service_response);
                } else {
                    System.out.println(web_service_response);
                }

                return web_service_response;

                // json_output = " excel_cl.get_list_of_users(report_parameters)";

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return web_service_response;
        }

        if (request_type.equals("report_dashboard_unit_for_each_staff")) {

            String main_service_id;
            String main_service_desc;

            String main_service_sub_id;
            String main_service_sub_desc;

            String batch_to_id = request.getParameter("batch_to_id");

            String report_parameters = null;
            String json_output = null;

            try {

                obj_r.put("staff_id", batch_to_id);

                report_parameters = obj_r.toString();
                // System.out.println(report_parameters);

                json_output = excel_report_cl.report_dashboard_unit_for_each_staff(
                        cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

                        return json_output;

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return "";
        }

        if (request_type.equals("report_audit_for_each_staff")) {

         
            String batch_to_id = request.getParameter("batch_to_id");

            String report_parameters = null;
            String json_output = null;

            try {

                obj_r.put("staff_id", batch_to_id);

                report_parameters = obj_r.toString();
                // System.out.println(report_parameters);

                json_output = excel_report_cl.report_audit_for_each_staff(
                        cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

                        return json_output;

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return "";
        }

        if (request_type.equals("lvd_comparable_report_rpt")) {
            String batch_to_id = request.getParameter("batch_to_id");

            String report_parameters = null;
            String json_output = null;

            try {
                // json_output = cls_maps.select_lvd_comparable_unapproved_all("0");

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return "";
        }

        if (request_type.equals("lvd_comparable_report")) {
            String main_service_id;
            String main_service_desc;

            String main_service_sub_id;
            String main_service_sub_desc;

            String main_service = request.getParameter("main_service_rpt");
            String sub_service = request.getParameter("sub_service_rpt");

            // System.out.println(main_service);
            // System.out.println(sub_service);
            String type_of_report_name = request.getParameter("type_of_report_name");
            String business_process = main_service;
            String business_process_sub_name = sub_service;
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");
            String report_parameters = null;

            try {
                // String xmlLocation =
                // getServletContext().getRealPath("/resources/employee.csv");
                // String xmlLocation = "C:\\gelisscans\\scanpdf\\employee.csv";
                String xmlLocation = "C:\\gelisscans\\scanpdf\\employee.xls";

                // System.out.println(xmlLocation);

                obj_r.put("type_of_report_name", type_of_report_name);
                obj_r.put("business_process_id", business_process);
                obj_r.put("business_process_sub_id", business_process_sub_name);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                report_parameters = obj_r.toString();

                String web_service_response_menu = null;
                // web_service_response_menu =
                // cls_maps.select_lvd_comparable_unapproved_all("0");
                JSONObject menu_obj;
                menu_obj = new JSONObject(web_service_response_menu);
                String all_menus = menu_obj.get("data").toString();

                String json_output = web_service_response_menu;

                String report_output = excel_report_cl.create_excel_file_for_comparable_reports(xmlLocation,
                        json_output);

                /*
                 * FileInputStream fileInputStream = new
                 * FileInputStream(xmlLocation); OutputStream
                 * responseOutputStream = response.getOutputStream();
                 * 
                 * String disposition = "attachment; fileName=outputfile.csv";
                 * response.setContentType("text/csv");
                 * response.setHeader("Content-Disposition", disposition);
                 * 
                 * while ((bytes = fileInputStream.read()) != -1) {
                 * responseOutputStream.write(bytes); }
                 * 
                 * responseOutputStream.flush(); responseOutputStream.close();
                 */
                // int bytes;
                File pdfFile = new File(xmlLocation);
                byte[] buffer = null;

                // String pdfFilename = "test.pdf"; // I use id here to
                // determine pdf
                // File f = new File(pdfFilename);

                BufferedInputStream is = new BufferedInputStream(new FileInputStream(pdfFile));
                ByteArrayOutputStream bos = new ByteArrayOutputStream((int) pdfFile.length());

                int ch;
                long actual = 0;
                while ((ch = is.read()) != -1) {
                    bos.write(ch);
                    actual++;
                }
                bos.flush();
                bos.close();
                buffer = bos.toByteArray();

                // response.setContentType("text/csv");
                response.setContentType("application/vnd.ms-excel");
                response.addHeader("Content-Disposition", "attachment; filename=outputfile.xls");

                // response.addHeader("Content-Disposition", "inline;
                // filename=Documentation.pdf");
                response.setContentLength((int) pdfFile.length());
                response.getOutputStream().write(buffer, 0, buffer.length);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            /*
             * out.println(bytes);
             * out.close();
             */
        }

        if (request_type.equals("report_on_plan_approval")) {

    

            // System.out.println(main_service);
            // System.out.println(sub_service);

            String ls_number = request.getParameter("ls_number");

            String business_process_name = request.getParameter("business_process_name");
            String application_status = request.getParameter("application_status");
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");
            String region_code = request.getParameter("region_code");

            String report_parameters = null;
            String json_output = null;

            try {

                obj_r.put("ls_number", ls_number);
                obj_r.put("business_process_name", business_process_name);
                obj_r.put("application_status", application_status);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                obj_r.put("region_code", region_code);
                report_parameters = obj_r.toString();

                report_parameters = obj_r.toString();
                // System.out.println("Assiamah");
                // System.out.println(report_parameters);

                json_output = excel_report_cl.report_on_plan_approval(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return json_output;
        }





        if (request_type.equals("report_on_plan_approval2")) {


            // System.out.println(main_service);
            // System.out.println(sub_service);

            String ls_number = request.getParameter("ls_number");
            String application_status = request.getParameter("application_status");
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");
            String region_code = request.getParameter("region_code");

            String report_parameters = null;
            String json_output = null;

            try {

                obj_r.put("ls_number", ls_number);
                obj_r.put("application_status", application_status);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                obj_r.put("region_code", region_code);
                report_parameters = obj_r.toString();

                report_parameters = obj_r.toString();
                // System.out.println("Assiamah");
                // System.out.println(report_parameters);

                json_output = excel_report_cl.report_on_plan_approval2(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return json_output;
        }





        if (request_type.equals("report_on_smd_cartogis")) {


            // System.out.println(main_service);
            // System.out.println(sub_service);

            String application_status = request.getParameter("application_status");
            String date_from = request.getParameter("date_from");
            String date_to = request.getParameter("date_to");
            String userid = request.getParameter("userid");
            String regionid = request.getParameter("regionid");

            

            String report_parameters = null;
            String json_output = null;

            try {

                obj_r.put("application_status", application_status);
                obj_r.put("date_from", date_from);
                obj_r.put("date_to", date_to);
                obj_r.put("userid", userid);
                obj_r.put("regionid", regionid);

            
                report_parameters = obj_r.toString();

                report_parameters = obj_r.toString();
                // System.out.println("Assiamah");
                // System.out.println(report_parameters);

                json_output = excel_report_cl.report_on_smd_cartogis(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return json_output;
        }






        if (request_type.equals("general_user_in_unit")) {


            // System.out.println(main_service);
            // System.out.println(sub_service);

            String unitid = request.getParameter("unitid");
            

            

            String report_parameters = null;
            String json_output = null;

            try {

                obj_r.put("unitid", unitid);
               

            
                report_parameters = obj_r.toString();

                report_parameters = obj_r.toString();
                // System.out.println("Assiamah");
                // System.out.println(report_parameters);

                json_output = excel_report_cl.general_user_in_unit(cls_url_config.getWeb_service_url_ser(),
                        cls_url_config.getWeb_service_url_ser_api_key(), report_parameters);

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // out.println(json_output);
            // out.close();
            return json_output;
        }


        return region_id;
    }

    
}
