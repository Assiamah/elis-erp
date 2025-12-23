package com.mit.elis.servlets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.ui.Model;
import com.mit.elis.class_common.Ws_url_config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;

import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ws.casemgt.CSAU_billgeneration;
import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

@RestController
public class Case_Management_Serv_Upload {

    @Autowired
    private Ws_url_config cls_url_config;

    Ws_url_config ws_url_config = new Ws_url_config();
    CSAU_billgeneration billgeneration_cl = new CSAU_billgeneration();
    // cls_casemgt casemgt_cl_m = new cls_casemgt();

    Ws_client_application casemgt_cl = new Ws_client_application();
    private final RestTemplate restTemplate = new RestTemplate();
    
    @RequestMapping("/Case_Management_Serv_Upload")
    @PostMapping
    public String doPost(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "sampleFile", required = false) MultipartFile file) {
        // TODO Auto-generated method stub

        if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
            // Session is expired
            request.setAttribute("login", "sessionout");
            // System.out.println("If Not success");
            return "index.jsp";

        }
        // HttpSession session = request.getSession();
        // gets absolute path of the web application
        // String appPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
        try {

            String request_type = request.getParameter("request_type");

            String web_service_response = null;

            billgeneration_cl.web_compname = (String) session.getAttribute("web_compname");
            billgeneration_cl.web_comp_address = (String) session.getAttribute("web_comp_address");
            billgeneration_cl.web_city = (String) session.getAttribute("web_city");
            billgeneration_cl.web_fax_number = (String) session.getAttribute("web_fax_number");
            billgeneration_cl.web_telephone = (String) session.getAttribute("web_telephone");
            billgeneration_cl.web_email = (String) session.getAttribute("web_email");
            billgeneration_cl.web_branch_of_csau = (String) session.getAttribute("web_branch_of_csau");
            billgeneration_cl.web_rlo = (String) session.getAttribute("web_rlo");
            billgeneration_cl.web_regional_accountant = (String) session.getAttribute("web_regional_accountant");
            billgeneration_cl.web_head_of_csau = (String) session.getAttribute("web_head_of_csau");
            billgeneration_cl.web_chairman_regional_land_commission = (String) session
                    .getAttribute("web_chairman_regional_land_commission");
            billgeneration_cl.web_office_region = (String) session.getAttribute("web_office_region");

            System.out.println(request_type);

            if (request_type.equals("process_online_select_acknowledgement_not_on_case")) {

                String main_service_id = request.getParameter("main_service_id");
                String main_service_sub_id = request.getParameter("main_service_sub_id");
                String main_service_desc = request.getParameter("main_service_desc");
                String main_service_sub_desc = request.getParameter("main_service_sub_desc");
                String client_name = request.getParameter("client_name");
                String ar_address = request.getParameter("ar_address");
                String land_size = request.getParameter("land_size");
                String locality_of_parcel = request.getParameter("locality_of_parcel");
                String application_type = request.getParameter("application_type");
                String type_of_interest = request.getParameter("type_of_interest");
                String type_of_use = request.getParameter("type_of_use");
                String job_number = request.getParameter("job_number");
                String case_number = request.getParameter("case_number");
                String jn_id = request.getParameter("jn_id");
                String userid = (String) session.getAttribute("userid");
                String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

                String ar_gender = request.getParameter("ar_gender");
                String ar_cell_phone = request.getParameter("ar_cell_phone");
                String ar_id_type = request.getParameter("ar_id_type");
                String ar_id_number = request.getParameter("ar_id_number");
                String ap_type_of_party = request.getParameter("ap_type_of_party");

                String region = request.getParameter("region");
                String district = request.getParameter("district");
                String licensed_surveyor_number = request.getParameter("licensed_surveyor_number");
                String licensed_surveyor_name = request.getParameter("licensed_surveyor_name");

                String regional_code = (String) session.getAttribute("regional_code");
                String regional_name = (String) session.getAttribute("regional_name");
                String distict_code = (String) session.getAttribute("distict_code");
                String district_name = (String) session.getAttribute("district_name");

                String file_name_incoming = request.getParameter("file_name");




                // String jn_id = request.getParameter("jn_id");

                // String[] output = registration_forms.split("-");
                // String form_number=output[0];
                // String form_name=output[1];

                // String[] output_sub = type_of_interest.split("-");
                // String type_of_interest_id=output_sub[0];
                // String type_of_interest_name=output_sub[1];

                String rs_result = null;
                String service_bill_descdription_formated = main_service_sub_desc.replace(" ", "_");
                JSONArray jsonArray = new JSONArray();
                JSONObject property_data_json = new JSONObject();

                property_data_json.put("business_process_id", main_service_id);
                // property_data_json.put("jn_id",jn_id);
                property_data_json.put("business_process_name", main_service_desc);
                property_data_json.put("business_process_sub_id", main_service_sub_id);
                property_data_json.put("business_process_sub_name", main_service_sub_desc);
                property_data_json.put("ar_name", client_name);
                property_data_json.put("ar_address", ar_address);
                property_data_json.put("land_size", land_size);
                property_data_json.put("type_of_instrument", type_of_interest);
                property_data_json.put("type_of_use", type_of_use);

                property_data_json.put("application_type", application_type);
                property_data_json.put("locality_of_parcel", locality_of_parcel);
                property_data_json.put("job_number", job_number);

                property_data_json.put("userid", userid);
                property_data_json.put("fullname", fullname);

                property_data_json.put("case_number", case_number);
                property_data_json.put("jn_id", jn_id);

                property_data_json.put("ar_gender", ar_gender);
                property_data_json.put("ar_cell_phone", ar_cell_phone);
                property_data_json.put("ar_id_type", ar_id_type);
                property_data_json.put("ar_id_number", ar_id_number);
                property_data_json.put("ap_type_of_party", ap_type_of_party);

                property_data_json.put("region", region);
                property_data_json.put("district", district);
                property_data_json.put("licensed_surveyor_number", licensed_surveyor_number);
                property_data_json.put("licensed_surveyor_name", licensed_surveyor_name);

                property_data_json.put("regional_name", regional_name);
                property_data_json.put("regional_code", regional_code);
                property_data_json.put("mac_address", mac_address);
                property_data_json.put("ip_address", ip_address);
                jsonArray.put(property_data_json);

                rs_result = jsonArray.toString();

                System.out.println(rs_result);
                web_service_response = casemgt_cl.online_select_process_acknowledgement_not_on_case_sub(
                        cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
                        rs_result);
                if (web_service_response != null) {
                    // System.out.println(web_service_response);
                    String pdfFileName = "acnkwledgeslip.pdf";

                    JSONObject jsonobject = new JSONObject(web_service_response);
                    String ws_case_number = jsonobject.getString("case_number");
                    
                    String apiKey = cls_url_config.getDoc_mgt_api_key(); 
                    String mimeType = file.getContentType();

                    String apiUrl = cls_url_config.getDoc_mgt_api() + "document_upload/file_upload_public";  // Target API URL
                   
                   
                    if (file != null && !file.isEmpty()) {
                        try {
                            // Forward the file to the Spring Boot API
                           // InputStream fileInputStream = file.getInputStream();

                           

                            //RestTemplate restTemplate = new RestTemplate();

                            HttpHeaders headers = new HttpHeaders();
                            headers.setContentType(MediaType.MULTIPART_FORM_DATA);
                            headers.set("x-api-key", apiKey);
                            // Prepare the multipart body
                            // Convert the file to a byte array
                byte[] fileBytes = file.getBytes();

                // Prepare the multipart body
                MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
                body.add("file", new ByteArrayResource(fileBytes) {
                    @Override
                    public String getFilename() {
                        return file.getOriginalFilename();  // Set the filename
                    }
                });
                            // Add additional parameters if needed
                          //  body.add("additionalParam", "value");
                            body.add("case_number", ws_case_number);
                            body.add("document_type", "public_docs");
                            body.add("document_open_type", mimeType);
                            body.add("job_number", ws_case_number);
                           
            
                            // Create the HttpEntity with the headers and body
                            HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
                            
                            ResponseEntity<String> responseEntity = restTemplate.exchange(apiUrl, HttpMethod.POST, requestEntity, String.class);

                            if (responseEntity.getStatusCode() == HttpStatus.OK) {
                                System.out.println("Response: " + "File forwarded successfully!");
                            } else {
                                System.out.println("Failed to upload file. Status code: " + responseEntity.getStatusCode());
                            }

                        } catch (Exception e) {
                            //response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                            //response.getWriter().write("Error forwarding file: " + e.getMessage());
                            System.out.println("Error forwarding file!"  + e.getMessage());
                        }
                    } else {
                       // response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        //response.getWriter().write("No file found in request!");
                        System.out.println("No file found in request!");
                    }


                    byte[] buffer = null;

					// Generate the PDF as a byte array
					buffer = billgeneration_cl.create_acknowledgement_slip_online_new_on_case(
                            cls_url_config.getSoftfile_location(),
                            property_data_json.toString(), web_service_response,
                            session.getAttribute("fullname").toString());

                            JSONObject pdf_upload_obj = new JSONObject();
                            String base64Encoded = Base64.getEncoder().encodeToString(buffer);
                    
                        pdf_upload_obj.put("jobNumber", ws_case_number);
                        pdf_upload_obj.put("caseNumber",ws_case_number);
                        pdf_upload_obj.put("fileData",base64Encoded);
                                    
 
                        pdf_upload_obj.put("doc_name","Acknowledgement Slip"+" - "+job_number);
                        pdf_upload_obj.put("doc_description", main_service_sub_desc + "_" + job_number +"_Acknowledgement Slip" );
                        pdf_upload_obj.put("doc_category","public_docs");
                        pdf_upload_obj.put("doc_app_uploaded","elis");
                        pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
                        pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
                        pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
                        
                    
                    
                         String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
                         cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());
        
                    if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}

                } else {
                    System.out.println(web_service_response);
                }
            }

            if (request_type.equals("process_online_select_acknowledgement_on_case")) {

                String main_service_id = request.getParameter("main_service_id");
                String main_service_sub_id = request.getParameter("main_service_sub_id");
                String main_service_desc = request.getParameter("main_service_desc");
                String main_service_sub_desc = request.getParameter("main_service_sub_desc");
                String client_name = request.getParameter("client_name");
                String licensed_surveyor_name = request.getParameter("licensed_surveyor_name");

                String land_size = request.getParameter("land_size");
                String locality_of_parcel = request.getParameter("locality_of_parcel");
                String application_type = request.getParameter("application_type");
                String type_of_interest = request.getParameter("type_of_interest");

                String type_of_use = request.getParameter("type_of_use");
                String job_number = request.getParameter("job_number");
                String case_number = request.getParameter("case_number");
                String transaction_number = request.getParameter("transaction_number");
                String jn_id = request.getParameter("jn_id");
                String userid = (String) session.getAttribute("userid");
                String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

                String ar_gender = request.getParameter("ar_gender");
                String ar_cell_phone = request.getParameter("ar_cell_phone");
                String ar_id_type = request.getParameter("ar_id_type");
                String ar_id_number = request.getParameter("ar_id_number");
                String ap_type_of_party = request.getParameter("ap_type_of_party");

                String file_name_incoming = request.getParameter("file_name");
              
			

                // String jn_id = request.getParameter("jn_id");

                // String[] output = registration_forms.split("-");
                // String form_number=output[0];
                // String form_name=output[1];

                // String[] output_sub = type_of_interest.split("-");
                // String type_of_interest_id=output_sub[0];
                // String type_of_interest_name=output_sub[1];

                String rs_result = null;
                String service_bill_descdription_formated = main_service_sub_desc.replace(" ", "_");
                JSONArray jsonArray = new JSONArray();
                JSONObject property_data_json = new JSONObject();

                property_data_json.put("business_process_id", main_service_id);
                // property_data_json.put("jn_id",jn_id);
                property_data_json.put("business_process_name", main_service_desc);
                property_data_json.put("business_process_sub_id", main_service_sub_id);
                property_data_json.put("business_process_sub_name", main_service_sub_desc);
                property_data_json.put("ar_name", client_name);
                property_data_json.put("licensed_surveyor_name", licensed_surveyor_name);

                property_data_json.put("land_size", land_size);
                property_data_json.put("type_of_interest", type_of_interest);
                property_data_json.put("type_of_use", type_of_use);
                property_data_json.put("application_type", application_type);
                property_data_json.put("locality_of_parcel", locality_of_parcel);
                property_data_json.put("job_number", job_number);

                property_data_json.put("userid", userid);
                property_data_json.put("fullname", fullname);

                property_data_json.put("case_number", case_number);
                property_data_json.put("transaction_number", transaction_number);

                property_data_json.put("jn_id", jn_id);

                property_data_json.put("ar_gender", ar_gender);
                property_data_json.put("ar_cell_phone", ar_cell_phone);
                property_data_json.put("ar_id_type", ar_id_type);
                property_data_json.put("ar_id_number", ar_id_number);
                property_data_json.put("ap_type_of_party", ap_type_of_party);

                property_data_json.put("mac_address", mac_address);
                property_data_json.put("ip_address", ip_address);
                jsonArray.put(property_data_json);

                rs_result = jsonArray.toString();

                System.out.println(rs_result);
                web_service_response = casemgt_cl.online_select_process_acknowledgement_on_case_sub(
                        cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key(),
                        rs_result);
                if (web_service_response != null) {
                    // System.out.println(web_service_response);
                    String pdfFileName = "acknowledgeslip";

                    JSONObject jsonobject = new JSONObject(web_service_response);
                    String ws_case_number = jsonobject.getString("case_number");

                    // String ws_bill_details_db=
                    // case_mgt_cl.online_lc_job_number_payment_bill_by_bill_number(ws_bill_number);
                    // String ws_bill_details_db=
                    // case_mgt_cl.check_payment_status_of_bill_generate_bill(ws_bill_number);

                    // String pdf_dest = cls_url_config.getPublic_docs_upload_location();
                    // String files_pdf_jackets_p = pdf_dest + ws_case_number + File.separator
                    //         + service_bill_descdription_formated
                    //         + "_" + job_number + pdfFileName;

                    // File files_pdf_jackets = new File(pdf_dest + ws_case_number);

                    // if (!files_pdf_jackets.exists()) {
                    //     if (files_pdf_jackets.mkdirs()) {
                    //         // System.out.println("Multiple directories are
                    //         // created!");
                    //     } else {
                    //         System.out.println("Failed to create multiple directories!");
                    //     }
                    // }

                    // String savePath = pdf_dest + ws_case_number;

                    // String file_extension = "";
                    // // System.out.println(files_pdf_jackets_p);

                    // // System.out.println(savePath);
                    // // System.out.println(savePath + File.separator);
                    // // System.out.println(request.getParts());

                    // // Save attached uploaded File

                    // for (Part part : request.getParts()) {
                    //     String fileName = extractFileName(part);
                    //     // refines the fileName in case it is an absolute path
                    //     // System.out.println("path");
                    //     // System.out.println(fileName);

                    //     fileName = new File(fileName).getName();
                    //     // fileName = new File(fileName).getName();

                    //     if (fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0)
                    //         file_extension = fileName.substring(fileName.lastIndexOf(".") + 1);
                    //     else
                    //         file_extension = "";

                    //     // System.out.println("file");
                    //     // System.out.println(fileName);
                    //     // System.out.println(savePath + "/" +
                    //     // fileName);
                    //     // part.write(savePath + "/" +
                    //     // file_name_incoming);
                    //     // part.write(savePath + "/" +
                    //     // "client_scanned_document" + "." + file_extension);
                    //     part.write(savePath + "/" + "client_scanned_document" + timeStamp + ".pdf");

                    // }

                    // Get additional parameters
                    // String caseNumber = request.getParameter("case_number");
                    // String fileName = request.getParameter("file_name");
                    String apiKey = cls_url_config.getDoc_mgt_api_key(); 
                    String mimeType = file.getContentType();
                    //System.out.print(file);
                    String apiUrl = cls_url_config.getDoc_mgt_api() + "document_upload/file_upload_public";  // Target API URL
              
                  
            // Check if the file exists in the request
            if (file != null && !file.isEmpty()) {
                try {
                    // Forward the file to the Spring Boot API
                   // InputStream fileInputStream = file.getInputStream();

                   

                    //RestTemplate restTemplate = new RestTemplate();

                    HttpHeaders headers = new HttpHeaders();
                    headers.setContentType(MediaType.MULTIPART_FORM_DATA);
                    headers.set("x-api-key", apiKey);
                    // Prepare the multipart body
                    // Convert the file to a byte array
        byte[] fileBytes = file.getBytes();

        // Prepare the multipart body
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", new ByteArrayResource(fileBytes) {
            @Override
            public String getFilename() {
                return file.getOriginalFilename();  // Set the filename
            }
        });
                    // Add additional parameters if needed
                  //  body.add("additionalParam", "value");
                    body.add("case_number", ws_case_number);
                    body.add("document_type", "public_docs");
                    body.add("document_open_type", mimeType);
                    body.add("job_number", ws_case_number);
                   
    
                    // Create the HttpEntity with the headers and body
                    HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
                    
                    ResponseEntity<String> responseEntity = restTemplate.exchange(apiUrl, HttpMethod.POST, requestEntity, String.class);

                    if (responseEntity.getStatusCode() == HttpStatus.OK) {
                        System.out.println("Response: " + "File forwarded successfully!");
                    } else {
                        System.out.println("Failed to upload file. Status code: " + responseEntity.getStatusCode());
                    }

                } catch (Exception e) {
                    //response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    //response.getWriter().write("Error forwarding file: " + e.getMessage());
                    System.out.println("Error forwarding file!"  + e.getMessage());
                }
            } else {
               // response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                //response.getWriter().write("No file found in request!");
                System.out.println("No file found in request!");
            }


            byte[] buffer = null;

            // Generate the PDF as a byte array
            buffer = billgeneration_cl.create_acknowledgement_slip_online_new_on_case(
                    cls_url_config.getSoftfile_location(),
                    property_data_json.toString(), web_service_response,
                    session.getAttribute("fullname").toString());

                    JSONObject pdf_upload_obj = new JSONObject();
                    String base64Encoded = Base64.getEncoder().encodeToString(buffer);
            
                
                    pdf_upload_obj.put("jobNumber", ws_case_number);
                    pdf_upload_obj.put("caseNumber",ws_case_number);
                    pdf_upload_obj.put("fileData",base64Encoded);
                                
                    
                    pdf_upload_obj.put("doc_name","Acknowledgement Slip"+" - "+job_number);
                    pdf_upload_obj.put("doc_description","Acknowledgement Slip");
                    pdf_upload_obj.put("doc_category","public_docs");
                    pdf_upload_obj.put("doc_app_uploaded","elis");
                    pdf_upload_obj.put("doc_uploaded_by",session.getAttribute("fullname").toString());
                    pdf_upload_obj.put("doc_uploaded_by_id",session.getAttribute("userid").toString());
                    pdf_upload_obj.put("doc_uploaded_by_ip_address",session.getAttribute("mac_address"));
                    
                
            
            
                 String pdf_upload_response= casemgt_cl.pdf_byte_upload_to_service(cls_url_config.getDoc_mgt_api(),
                 cls_url_config.getDoc_mgt_api_key(),pdf_upload_obj.toString());

                    if (buffer != null) {
						// Set response content type to PDF
						response.setContentType("application/pdf");
						
						// Set the content-disposition header to download the file with the specified name
						response.addHeader("Content-Disposition", "attachment; filename=" + pdfFileName);
						
						// Set the content length of the response based on the buffer length (size of the PDF in bytes)
						response.setContentLength(buffer.length);
						
						// Write the PDF byte array to the output stream to download it
						response.getOutputStream().write(buffer, 0, buffer.length);
						
						// Flush the output stream
						response.getOutputStream().flush();
						
						// Close the output stream
						response.getOutputStream().close();
					} else {
						// Handle the case where the PDF generation failed
						response.setContentType("text/html");
						response.getWriter().write("Error generating PDF.");
					}

                } else {
                    System.out.println(web_service_response);
                }
            }

        } catch (

        Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return timeStamp;

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

     private File convertMultipartFileToFile(MultipartFile file) throws IOException {
		// Create a temporary file
        String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HHmmss").format(Calendar.getInstance().getTime());
        
		//File tempFile = File.createTempFile("upload-", file.getOriginalFilename());
        File tempFile = File.createTempFile("client_scanned_document_", timeStamp + ".pdf");
		try (FileOutputStream fos = new FileOutputStream(tempFile)) {
			fos.write(file.getBytes());
		}
		return tempFile;
	}

    public File convertMultipartFileToFile(byte[] buffer, String pdfFileName) throws IOException {
        File tempFile = File.createTempFile(pdfFileName+"_", ".pdf");
    
        try (FileOutputStream fos = new FileOutputStream(tempFile)) {
            fos.write(buffer);
            fos.flush();
        }
    
        return tempFile;
    }

	public static void uploadPdf(String apiUrl, File pdfFile, String caseNumber, String apiKey, String document_type, String mimeType) {
		RestTemplate restTemplate = new RestTemplate();

		// Set headers
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
		// Add API Key to the headers
		headers.set("x-api-key", apiKey);

		// Prepare the file as a resource
		FileSystemResource fileResource = new FileSystemResource(pdfFile);

		// Create a MultiValueMap to hold the file and additional parameters
		MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
		body.add("file", fileResource);           // Attach the file
		body.add("case_number", caseNumber);       // Attach the additional string parameter
		body.add("document_type", document_type); 
		body.add("document_open_type", mimeType); 
		body.add("job_number", caseNumber); 

		// Build request entity
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

		// Send the request
		ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.POST, requestEntity, String.class);

		// Handle response
		if (response.getStatusCode().is2xxSuccessful()) {
			System.out.println("Response: " + response.getBody());
		} else {
			System.out.println("Failed to upload file. Status code: " + response.getStatusCode());
		}
	}

}
