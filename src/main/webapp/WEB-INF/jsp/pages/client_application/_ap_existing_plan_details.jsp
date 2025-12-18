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
					          
   <h3 class="border-bottom border-gray pb-2">Update Title Plan Details</h3>
  
   <input  id="gid_pl_smd" name="gid_pl_smd" type="hidden" value="0" >
   <input  id="lc_txt_transaction_number_pl_smd" name="lc_txt_transaction_number_pl_smd" type="hidden" value="0" >

		   <div class="form-row">
		   
			<div class="col-md-4">
				   <label for="search_value">District</label>
					  <input  class="form-control" id="txt_lc_registration_district_number_pl_smd"  name="txt_lc_registration_district_number_pl_smd"  type="text"  value="${registration_district_number}" >
											   
				   </div>
				   
				   
					<div class="col-md-4">
				   <label for="search_value">Section</label>
					  <input  class="form-control" id="txt_lc_registration_section_number_pl_smd"  name="txt_lc_registration_district_number_pl_smd"  type="text"  value="${registration_section_number}" >
											   
				   </div>
				   
					<div class="col-md-4">
				   <label for="search_value">Block</label>
					  <input  class="form-control" id="txt_lc_registration_block_number_pl_smd"  name="txt_lc_registration_district_number_pl_smd"  type="text"  value="${registration_block_number}" >
											   
				   </div>
		   
		   </div>							
					   
					   
					   
		   <div class="form-row mt-2">
		   
			<div class="col-md-4">
				   <label for="search_value">Plan Number</label>
					  <input  class="form-control" id="txt_lc_plan_no_pl_smd"  name="txt_lc_plan_no_pl_smd"  type="text"  value="${plan_no}" >
											   
				   </div>
				   
				   
					<div class="col-md-4">
				   <label for="search_value">LTR Plan Number</label>
					  <input  class="form-control" id="ltr_plan_no_pl_smd"  name="ltr_plan_no_pl_smd"  type="text"  value="${ltr_plan_no}" >
											   
				   </div>
				   
					<div class="col-md-4">
				   <label for="search_value">Registry Map Ref</label>
					  <input  class="form-control" id="txt_lc_registry_mapref_pl_smd"  name="txt_lc_registry_mapref_pl_smd"  type="text"  value="${registry_mapref}" >
											   
				   </div>
		   
		   </div>			
		   
		   
		   
								   
				   
			   <div class="form-row mt-2">
		   
			<div class="col-md-4">
				   <label for="search_value">GLPIN</label>
					  <input readonly class="form-control" id="txt_glpin_pl_smd"  name="txt_glpin_pl_smd"  type="text"  value="${glpin}" >
											   
				   </div>
				   
				   
					<div class="col-md-4">
				   <label for="search_value">Size of Land</label>
					  <input readonly class="form-control" id="txt_lc_size_of_land_pl_smd"  name="txt_lc_size_of_land_pl_smd"  type="text"  value="${size_of_land}" >
											   
				   </div>
				   
				   <div class="col-md-4">
					<label for="search_value">CC Number</label>
					   <input class="form-control" id="txt_cc_no_pl_smd"  name="txt_cc_no_pl_smd"  type="text"  value="${cc_no}" >
												
					</div>
		   
		   </div>	
		   
		   <div class="form-row mt-3">
		   
			<div class="col-md-4">
					<button class="btn btn-primary btn-block" id="btn_save_lrd_title_plan_update_details_smd_new_update">
						<span class="text" >Save</span>
					</button>			   
			  </div>
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
  
  
