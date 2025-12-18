package com.mit.elis.class_common;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
@ConfigurationProperties(prefix = "app.config")
public class Ws_url_config {

    String web_service_url_ser;
    String web_service_url_ser_api_key;
    String web_service_url_dlrev_server;

    String site_plan_verification;
    String doc_mgt_api;
    String doc_mgt_api_key;


    String doc_mgt_api_v1;
    String doc_mgt_api_v1_key;


    String ai_api;
    String ai_api_key;

    String get_public_docs_upload_location;

    String case_upload_location;
    String public_docs_upload_location;
    String softfile_location;
    String sample_sign_location;
    String batching_files_location;
    String publicaton_files_location;
    String tempfile_location;
    String lrd_jacket_raw_path;

    String egcr_url;
    String egcr_apikey;

    String geoserver_url;
    String geoserver_user;
    String geoserver_password;
    String geoserver_workspace_name;

    String legal_batch_list_location;
    String legal_document_location;
    String legal_request_document;
    String legal_provide_document;

    String cica_reply_document;
    String cica_created_ticket;
    String cica_request_form;
    
    String lc_temp_folder;
    String lc_deleted_case;
 
}
