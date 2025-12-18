 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 


	  
%>

  
  

 <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="all_settings">All Settings</a>
        </li>
        <li class="breadcrumb-item active"></li> 
      </ol>
           
          <div class="row">
	        <div class="col-md-12">
	          <!-- Example Bar Chart Card-->
	          <div class="card mb-3">
	            
	            <div class="card-body row">
	            	
	            	<div class="col-md-3"  >
		              	<a href="settings_milestones" class="btn btn-lg btn-secondary btn-block p-5" >
		              		Manage Milestones
		              	</a>
					</div>
					<div class="col-md-3">
		              	<a href="settings_checklists" class="btn btn-lg btn-secondary btn-block p-5">
		              	
		              		Manage Checklist
		              	</a>
					</div>
					<div class="col-md-3">
		              	<a href="settings_milestones" class="btn btn-lg btn-secondary btn-block p-5">
		              	
		              		Manage Fees
		              	</a>
					</div>
					<div class="col-md-3">
		              	<a href="#"  data-toggle="modal" data-target="#fixBillModal" class="btn btn-lg btn-secondary btn-block p-5">
		              	
		              		Uncompleted Bill
		              	</a>
					</div>
					
					
	            </div>
	            
	            
	            <div class="card-body row">
	            	
	            	
					
					<div class="col-md-3"  >
		              	<a href="basic_settings" class="btn btn-lg btn-secondary btn-block p-5" >
		              		 Locality/Districts
		              	</a>
					</div>
					<div class="col-md-3">
		              	<a href="settings_units" class="btn btn-lg btn-secondary btn-block p-5">
		              	
		              		Manage Units
		              	</a>
					</div>
	            </div>
	           <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
	          </div>
	
	          
	         
	        </div>
        
	      	<!--   Here is the right Table -->
	        
       
      	  </div>
    
    
    
     </div>
     
     
    
 </div>
 
 <!-- Modal -->
<div class="modal fade" id="fixBillModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Reset Bill for Acknowledgement</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="frmSearchforBillDetails" method=post>
      
	        <div class="form-group">
	        	
				<label for="mt_to" class="col-form-label">Enter Ref. Number :</label> 
				<div class="row">
					<div class="col-md-8">
						<input class="form-control" id="ack_ref_number" required type="text">
					</div>
					<div class="col-md-4">
						<button type="submit" class="btn btn-block btn-primary">Search</button>
					</div>
				
				</div>
				
			</div>
			
			
		</form>
		<form id="frmReverseBillAcknowledgement" method=post>
			<div id="ref_result">
				<div class="form-group">
						<label for="mt_to" class="col-form-label">Client Name :</label> 
						<input class="form-control" id="ack_ref_number" required type="text">
				</div>
				<div class="form-group">
						<label for="mt_to" class="col-form-label">License Surveyor Name :</label> 
						<input class="form-control" id="ack_ref_number" required type="text">
				</div>
				<div class="form-group">
						<button type="submit" class="btn btn-block btn-primary">Search</button>
				</div>
			</div>
        </form>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        
      </div>
      
    </div>
  </div>
</div>
 
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>