<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


   <jsp:include page="../client_application/_application_process_header.jsp"></jsp:include>
					          
   <h3 class="border-bottom border-gray pb-2">Update Certificate Details</h3>
  <input id="lc_txt_transaction_number" value="${transaction_number}" type="hidden" />
   <div class="form-row mt-5">
	<div class="col-md-3">
	  <label for="job_number">Certificte Type</label>
	<select name="lc_txt_type_of_certificate" id="lc_txt_type_of_certificate" class="form-control input-sm" data-style="btn-info" required data-live-search="true">
		<option value="${certificate_type == 'Individual' ? '' : certificate_type}">${certificate_type == 'Individual' ? '-- select --' : certificate_type}</option>
		<option value="Provisional Certificate">Provisional Certificate</option>
		<option value="Land Certificate">Land Certificate</option>
		<option value="Substituted Certificate">Substituted Certificate</option>
	</select> 

	  </div>
	  <div class="col-md-3">
		<label for="job_number">Certificate Number</label>
		 <input class="form-control" id="lc_txt_certificate_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${certificate_number}" >
		</div>
	   <div class="col-md-3">
	  <label for="job_number">Volume</label>
	   <input class="form-control" id="lc_txt_volume_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${volume_number}" >
	 </div>
	 
	  <div class="col-md-3">
		  <label for="job_number">Folio</label>
	   <input class="form-control" id="lc_txt_folio_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${folio_number}" >
	
		
	  </div>

		 <!-- <div class="col-md-3 mt-4">
		  <input type="button" id="lc_btn_generate_certificate_volume_folio" class="btn btn-warning btn-block to_hide_on_level_1" value="Generate Indices" />  
	   </div> -->

	   <div class="col-md-3 mt-4">
		<button class="btn btn-primary btn-block" id="btn_save_lrd_certificate_update_details">
			<span class="text" >Save</span>
	</button>	   
	  </div>
	
   </div>
		   
		   <div class="form-row">
		   
			
		   </div>

		   <input type="hidden" id="ars_job_purpose" class="form-control" value="${job_purpose}">
				   

		   <div class="mt-5">
			<button class="btn btn-success btn-icon-split float-left "  data-job_number="${job_number}" id="btnApproveJob">
				<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve Request</span>
			</button>

			<button class="btn btn-danger btn-icon-split float-left ml-3"  data-job_number="${job_number}" id="btnQueryJob">
				<span class="icon text-white-50"> <i class="fas fa-times fa-2x"></i></span><span class="text">Query Request</span>
			</button>
		 </div>	   
		 
            
   <jsp:include page="../client_application/_application_process_footer_ar.jsp"></jsp:include>
  
  
