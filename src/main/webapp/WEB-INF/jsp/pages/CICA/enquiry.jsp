 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws_casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


  <jsp:include page="../legal/includes/header.jsp"></jsp:include>
  

 <div class="content-wrapper">
    <div class="container-fluid">
       <div class="row">
	      <div class="col">
	        <div class="card mb-3 mt-3">
	        	<div class="card-header">
		        	<div class="row">
		        		<div class="col-md-9">
		        			<h5 class="text-uppercase text-bold text-secondary">Search Applications</h5>
		        		</div>
		        		<div class="col-md-3 text-end">
		        			<button class="btn btn-success btn-end" type="button" data-toggle="modal" data-target="#addTicketModal"><i class="fas fa-plus-circle"></i>Add Ticket</button>
		        		</div>
		        	</div>
	        	</div>
	          
		          <div class="card-body">
		            <form id="frmCCJobSearch"  method="post">
		            <div class="form-group">
		            	<label><b>Search By: </b></label>
				  	</div>
				    <div class="custom-control custom-radio custom-control-inline">
					  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input" value="job_number" required>
					  <label class="custom-control-label" for="rbtn_search_type1">Job number</label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
					  <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="custom-control-input" value="case_number" required>
					  <label class="custom-control-label" for="rbtn_search_type2">Case Number</label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
					  <input type="radio" id="rbtn_search_type3" name="rbtn_search_type" class="custom-control-input" value="regional_number" required>
					  <label class="custom-control-label" for="rbtn_search_type3">Regional Number</label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
					  <input type="radio" id="rbtn_search_type4" name="rbtn_search_type" class="custom-control-input" value="glpin" required>
					  <label class="custom-control-label" for="rbtn_search_type4">GLPIN</label>
					</div>
					<br><br>
		          <div class="form-group">
		            <div class="form-row">
		            <!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
		              <div class="col-md-5">
		                
		                <input class="form-control" id="cc_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
		              </div>
		              <div class="col-md-3">
		              	
		                <button type="submit" class="btn btn-warning" value="Search" id="btnCCJobSearch" ><i class="fas fa-search"></i> Search </button>
		                
		              </div>
		            </div>
		          </div>
		        </form>
		     </div>
	       </div>
	    </div>
   	  </div>
   </div>   
 </div>
 
 
<div class="modal fade" id="addTicketModal" tabindex="-1">
   <div class="modal-dialog modal-lg">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title text-uppercase">Add Ticket</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
       </div>
       <form action="secretariat" method="post">
       <div class="modal-body" >
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Complainant Name</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="text" class="form-control" name="complainant_name" required>
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="text" class="form-control" name="subject" required>
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <textarea class="form-control" name="description" required></textarea>
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Email:</b></label>
           <div class="col-sm-8">
             <input type="email" class="form-control" name="complainant_email">
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Telephone</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <input type="number" class="form-control" name="complainant_tel" required>
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Contact Type</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <select class="form-control" aria-label="Default select example" name="contact_type" required>
               <option disabled selected>-- select --</option>
               <option value="telephone">Telephone</option>
			<option value="email">Email</option>	
             </select>
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Complaint Type</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <select class="form-control" aria-label="Default select example" name="complaint_type_id" required>
               <option disabled selected>-- select --</option>
               <option value="service related">Service Related</option>
			<option value="None-service related">None-Service Related</option>	
             </select>
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Priority</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <select class="form-control" aria-label="Default select example" name="priority" required>
               <option disabled selected>-- select --</option>
               <option value="1">Low</option>
			<option value="2">Medium</option>
			<option value="3">High</option>
			<option value="4">Urgent</option>
             </select>
           </div>
         </div>
         <div class="row mb-3">
           <label for="inputText" class="col-sm-4 col-form-label"><b>Related Service</b><span class="text-danger">*</span>:</label>
           <div class="col-sm-8">
             <select class="form-control" id="related_service" name="related_service" onChange="get_related_service(this.value);" required>
			    <option value="" disabled selected>-- select --</option>
			    <option value="Job Number">Job Number</option>
			    <option value="Bill Number">Bill Number</option>
		    </select>
           </div>
         </div>
         <div id="related_services"></div>
       </div>
       <div class="modal-footer">
       <button type="reset" id="clear_btn" class="btn btn-danger"><i class="fas fa-times-circle"></i>Clear</button>
         <button type="submit" id="save_btn" class="btn btn-success"><i class="fas fa-check-circle"></i>Save</button>
       </div>
       </form>
     </div>
   </div>
 </div>

<script>
 function get_related_service(val){
     var related_service = val;
     let html = '';
     if (related_service == 'Job Number'){
         html = "<div class='row mb-3'><label for='inputText' class='col-sm-4 col-form-label'><b>Job Number</b><span class='text-danger'>*</span>:</label><div class='col-sm-8'><input type='text' class='form-control' name='service_number' required></div></div>";
     }
     
     if (related_service == 'Bill Number'){
         html = "<div class='row mb-3'><label for='inputText' class='col-sm-4 col-form-label'><b>Bill Number</b><span class='text-danger'>*</span>:</label><div class='col-sm-8'><input type='number' class='form-control' name='service_number' required></div></div>";
     }
     
     document.getElementById('related_services').innerHTML = html;        
 }
 </script>
    
 <jsp:include page="../legal/includes/footer.jsp"></jsp:include>
 <script src="legal/includes/bootstrap/js/bootstrap.bundle.js"></script>