package ws.reports;

import java.io.File;
import java.io.FileOutputStream;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import com.mit.elis.class_common.Ws_url_config;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class cls_excel_writer {
    static Ws_url_config ws_url_config = new Ws_url_config();
    private static String[] columns = { "S/N", "Job Number", "Applicant Name", "Date Recieved", "Date Batched",
            "Application Status", "Date Completed", "Date Collected", "Days Completed", "Days Collected",
            "Service Type" };

    public String get_list_of_users(String web_service_url, String web_service_api_key, String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "report_service/report_on_the_cases");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }

    public String report_on_the_cases_stamping(String web_service_url, String web_service_api_key, String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "report_service/report_on_the_cases_stamping");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }

    public String report_dashboard_unit_for_each_staff(String web_service_url, String web_service_api_key,
            String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "compliance_service/report_dashboard_unit_for_each_staff");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }


    public String report_audit_for_each_staff(String web_service_url, String web_service_api_key,
            String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "compliance_service/report_audit_for_each_staff");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }

    public String report_landed_cases_gra_revised(String web_service_url, String web_service_api_key,
            String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "report_service/report_landed_cases_gra_revised");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }

    public String create_excel_file(String filename, String report_parameters)

    {

        String output = null;
        // output = get_list_of_users(report_parameters);
        // boolean st =false;
        try {

            // Create a Workbook
            // Workbook workbook = new XSSFWorkbook(); // new HSSFWorkbook() for
            // generating `.xls` file
            Workbook workbook = new HSSFWorkbook();
            /*
             * CreationHelper helps us create instances of various things like
             * DataFormat, Hyperlink, RichTextString etc, in a format (HSSF,
             * XSSF) independent way
             */
            CreationHelper createHelper = workbook.getCreationHelper();

            // Create a Sheet
            Sheet sheet = workbook.createSheet("Employee");

            // Create a Font for styling header cells
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 14);
            headerFont.setColor(IndexedColors.RED.getIndex());

            // Create a CellStyle with the font
            CellStyle headerCellStyle = workbook.createCellStyle();
            headerCellStyle.setFont(headerFont);

            // Create a Row
            Row headerRow = sheet.createRow(0);

            // Create cells
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerCellStyle);
            }

            // Create Cell Style for formatting Date
            CellStyle dateCellStyle = workbook.createCellStyle();
            dateCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-MM-yyyy"));
            // Create Other rows and cells with employees data
            int rowNum = 1;
            /*
             * for(Employee employee: employees) { Row row =
             * sheet.createRow(rowNum++);
             * row.createCell(0).setCellValue(employee.getName());
             * row.createCell(1).setCellValue(employee.getEmail());
             * 
             * Cell dateOfBirthCell = row.createCell(2);
             * 
             * dateOfBirthCell.setCellValue(employee.getDateOfBirth());
             * dateOfBirthCell.setCellStyle(dateCellStyle);
             * row.createCell(3).setCellValue(employee.getSalary()); }
             */

            JSONObject object = new JSONObject(output);
            // JSONArray jsonarray = new JSONArray(object.getJSONArray("data"));
            // String output_arr = object.getJSONArray("data").toString() ;
            // JSONArray jsonarray = new JSONArray(output_arr);
            JSONArray jsonarray = object.getJSONArray("data");
            for (int i = 0; i < jsonarray.length(); i++) {
                Row row = sheet.createRow(rowNum++);
                JSONObject jsonobject = jsonarray.getJSONObject(i);
                row.createCell(0).setCellValue(rowNum);
                row.createCell(1).setCellValue(jsonobject.getString("job_number"));
                row.createCell(2).setCellValue(jsonobject.getString("ar_name"));
                row.createCell(3).setCellValue(jsonobject.getString("created_date"));
                row.createCell(4).setCellValue(jsonobject.getString("batch_date"));
                row.createCell(5).setCellValue(jsonobject.getString("current_application_status"));
                row.createCell(6).setCellValue(jsonobject.getString("completed_date"));
                row.createCell(7).setCellValue(jsonobject.getString("collected_date"));
                row.createCell(8).setCellValue(jsonobject.getString("days_completed"));
                row.createCell(9).setCellValue(jsonobject.getString("days_collected"));
                row.createCell(10).setCellValue(jsonobject.getString("business_process_sub_name"));

            }

            // Resize all columns to fit the content size
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Write the output to a file

            // OutputStream file = new FileOutputStream(new File(xmlLocation));
            // FileOutputStream fileOut = new
            // FileOutputStream("poi-generated-file.xlsx");
            FileOutputStream fileOut = new FileOutputStream(new File(filename));

            workbook.write(fileOut);
            fileOut.close();

            // Closing the workbook
            workbook.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return output;
    }

    public String create_excel_file_for_comparable_reports(String filename, String data)

    {

        String output = null;
        output = data;
        // boolean st =false;
        try {

            // Create a Workbook
            // Workbook workbook = new XSSFWorkbook(); // new HSSFWorkbook() for
            // generating `.xls` file
            Workbook workbook = new HSSFWorkbook();
            /*
             * CreationHelper helps us create instances of various things like
             * DataFormat, Hyperlink, RichTextString etc, in a format (HSSF,
             * XSSF) independent way
             */
            CreationHelper createHelper = workbook.getCreationHelper();

            // Create a Sheet
            Sheet sheet = workbook.createSheet("comparable");

            // Create a Font for styling header cells
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 14);
            headerFont.setColor(IndexedColors.RED.getIndex());

            // Create a CellStyle with the font
            CellStyle headerCellStyle = workbook.createCellStyle();
            headerCellStyle.setFont(headerFont);

            // Create a Row
            Row headerRow = sheet.createRow(0);

            // Create cells
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerCellStyle);
            }

            // Create Cell Style for formatting Date
            CellStyle dateCellStyle = workbook.createCellStyle();
            dateCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-MM-yyyy"));
            // Create Other rows and cells with employees data
            int rowNum = 1;
            /*
             * for(Employee employee: employees) { Row row =
             * sheet.createRow(rowNum++);
             * row.createCell(0).setCellValue(employee.getName());
             * row.createCell(1).setCellValue(employee.getEmail());
             * 
             * Cell dateOfBirthCell = row.createCell(2);
             * 
             * dateOfBirthCell.setCellValue(employee.getDateOfBirth());
             * dateOfBirthCell.setCellStyle(dateCellStyle);
             * row.createCell(3).setCellValue(employee.getSalary()); }
             */

            JSONObject object = new JSONObject(output);
            // JSONArray jsonarray = new JSONArray(object.getJSONArray("data"));
            // String output_arr = object.getJSONArray("data").toString() ;
            // JSONArray jsonarray = new JSONArray(output_arr);
            JSONArray jsonarray = object.getJSONArray("data");
            for (int i = 0; i < jsonarray.length(); i++) {
                Row row = sheet.createRow(rowNum++);
                JSONObject jsonobject = jsonarray.getJSONObject(i);
                row.createCell(0).setCellValue(rowNum);
                row.createCell(1).setCellValue(jsonobject.getString("job_no"));
                row.createCell(2).setCellValue(jsonobject.getString("transaction_date"));
                row.createCell(3).setCellValue(jsonobject.getString("accreage_size_of_land"));
                row.createCell(4).setCellValue(jsonobject.getString("unexpired_term"));
                row.createCell(5).setCellValue(jsonobject.getString("source_data"));
                row.createCell(6).setCellValue(jsonobject.getString("value_of_property"));
                row.createCell(7).setCellValue(jsonobject.getString("prominent_landmarks"));
                row.createCell(8).setCellValue(jsonobject.getString("type_of_house"));
                row.createCell(9).setCellValue(jsonobject.getString("locality"));
                row.createCell(10).setCellValue(jsonobject.getString("type_of_use"));

            }

            // Resize all columns to fit the content size
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Write the output to a file

            // OutputStream file = new FileOutputStream(new File(xmlLocation));
            // FileOutputStream fileOut = new
            // FileOutputStream("poi-generated-file.xlsx");
            FileOutputStream fileOut = new FileOutputStream(new File(filename));

            workbook.write(fileOut);
            fileOut.close();

            // Closing the workbook
            workbook.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return output;
    }

    public String get_count_of_query(String web_service_url, String web_service_api_key, String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "report_service/report_count_on_query_cases");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }

    public String get_count_of_users(String web_service_url, String web_service_api_key, String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "report_service/report_count_on_the_cases");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }


    public String report_on_plan_approval(String web_service_url, String web_service_api_key, String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "report_service/report_on_plan_approval");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }



    public String report_on_plan_approval2(String web_service_url, String web_service_api_key, String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "report_service/report_on_plan_approval2");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }





    public String report_on_smd_cartogis(String web_service_url, String web_service_api_key, String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "report_service/report_on_smd_cartogis");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }




    public String general_user_in_unit(String web_service_url, String web_service_api_key, String data_input) {

        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "report_service/general_user_in_unit");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;

    }

    
}
