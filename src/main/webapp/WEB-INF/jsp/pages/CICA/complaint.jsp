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
		        			<h5 class="text-uppercase text-bold text-secondary col-sm-4">CLIENTS</h5>
		        		</div>
		        	</div>
	        	</div>
	          
		          <div class="card-body">
		            <form id="frmCCJobSearch"  method="post">
			            <div class="row col-md-7 mt-3">
			            <h5 class="text-bold text-secondary mb-3">Complaint's Details</h5>
			            <div class="row mb-3">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
				           <div class="col-sm-8">
				             <input type="text" class="form-control" name="complaint_subject" required>
				           </div>
				         </div>
				         <div class="row mb-5">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
				           <div class="col-sm-8">
				             <textarea type="text" class="form-control" id="notes_text" name="complaint_description" required></textarea>
				           </div>
				         </div>
				         <div class="row mb-3">
				           <label for="inputText" class="col-sm-4 col-form-label"></label>
				           <div class="col-sm-8">
				             <a type="reset" id="clear_btn" href="javascript:history.back()" class="btn btn-danger text-white" style="border-radius: 20px"><i class="fas fa-arrow-circle-left"></i>Previous</a>
         					 <button type="submit" id="save_btn" class="btn btn-success"><i class="fas fa-check-circle"></i>Submit</button>
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