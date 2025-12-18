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
        <!-- <li class="breadcrumb-item">
          <a href="index.html">Case Management</a>
        </li>
        <li class="breadcrumb-item active">Create New case</li> -->
      </ol>
           
          <div class="row">
	        <div class="col">
	          <!-- Example Bar Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bar-chart"></i>Manage Milestones</div>
	            <div class="card-body">
	              	<!--  The Form starts here -->
	              	<form id="frmMilestones"  method="post">
						<div class="form-group">
							<div class="form-row">
								<div class="col-md-6">
									<label for="main_service_desc">Main Service</label> 
										<select id="main_service_ms" class="form-control selectpicker">
											<option value="-1">Select Main Service</option>
											<c:forEach items="${webmainserviceslist}" var="mainservice">
												<option  value="${mainservice.business_process_id}">${mainservice.business_process_name}</option>
											 </c:forEach>
					 
										</select>
									 
									 
									 
								</div>
								<div class="col-md-6">
									<label for="main_service_sub_desc">Sub Service</label>
									 <select name="sub_service_ms" id="sub_service_ms" class="form-control input-sm" >
			                   <option value="-1">Select Sub Service</option>
			                 
			               </select>
								</div>
							</div>
						</div>
			          
			        </form>
	            
	            <!-- The form Ends Hers -->
	
	            </div>
	           <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
	          </div>
	
	          
	         
	        </div>
        
	      	<!--   Here is the right Table -->
	        
       
      	  </div>
    
    
    <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3" id="milestones-search-results-section">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Miles Stones Results</div>
            <div class="card-body">
            <!-- <button id="test_json_sort"> test</button> -->
            
         
            
	             <!--  Here is where the fee list comes -->
	             
	             <div class="table-responsive" >
			           <table class="table table-bordered " id="milestones-results-table" style="min-height:500px">
			              <thead>
			                <tr>
			                 <th>Description</th>
			                  <th>Priority</th>
			                  <th>SMS Message</th>
			                  <th>App Message</th>
			                  <th>Days</th>
			                  <!-- <th>Regional Number</th> -->
			                  
			                  <th>Actions</th>
			                  
			                  
			                
			                 </tr>
			              </thead>
			              
			              <tbody>
			               	
			                              
						     
			              </tbody> 
			            </table>
	          	</div>
             
              <!--  End Of Table -->
             </div>
            <!-- <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
          </div>
          
     <!-- Example Bar Chart Card-->
          
        
    
       </div>
        
      </div>
     </div>
     
     
    
 </div>
 
 
 
 <div class="modal fade" id="editMilestoneModal" tabindex="-1"
	role="dialog" aria-labelledby="assignInspectionModal" aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="viewBatchlistModalLabel">Milestone </h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="edit_add_milestone">
					<input type="hidden" id="ms_id" value=0/>
					
					<div class="container">
						<div class="row">
	
							<div class="col">
	
								<div class="form-group">
									<label for="mt_to" class="col-form-label">Milestone Description :</label> 
									<textarea class="form-control" id="milestone_description" required></textarea>
								</div>
							</div>
							
							
							<div class="col">
								<div class="row">
									<div class="col">
							
										<div class="form-group">
											<label for="mt_to" class="col-form-label">Default Status :</label> 
											<select class="form-control" id="mile_stone_status" required>
												<option>Not Completed</option>
												<option>Not Passed</option>
												<option>Passed</option>
											</select>	
														
			
										</div>
									</div>
									<div class="col">
							
										<div class="form-group">
											<label for="mt_to" class="col-form-label">Option</label> 
											<!-- <input class="form-control" id="mile_stone_option" required> -->
											 <select class="form-control" id="mile_stone_option" required>
												<option value="true">true</option>
												<option value="false" >false</option>
											</select>	 
														
			
										</div>
									</div>
								</div>
								
							</div>
						</div>
						<div class="row">
							<div class="col">
	
								<div class="form-group">
									<label for="mt_to" class="col-form-label">Priority Level :</label> 
									<input type="number" step=1 min=1 class="form-control" id="priority_value" required>
										
								</div>
							</div>
							<div class="col">
	
								<div class="form-group">
									<label for="mt_to" class="col-form-label">Remaining Steps:</label> 
									<input type="number" step=1 min=1 class="form-control" id="milestone_remaining" required>
										
								</div>
							</div>
							<div class="col">
	
								<div class="form-group">
									<label for="mt_to" class="col-form-label">Working Days :</label> 
									<input type="number" step=1 min=1 class="form-control" id="working_day_required" required>
										
								</div>
							</div>
							<div class="col">
	
								<div class="form-group">
									<label for="mt_to" class="col-form-label">Milestone App Link :</label> 
									<input type="text" class="form-control" id="milestone_app_link" >
										
								</div>
							</div>
							
						</div>
						<div class="row">
							<div class="col">
	
								<div class="form-group">
									<label for="mt_to" class="col-form-label">Milestone App Message :</label> 
									<textarea class="form-control" id="milestone_app_message" required rows=5></textarea>
								</div>
							</div>
							<div class="col">
	
								<div class="form-group">
									<label for="mt_to" class="col-form-label">Milestone SMS :</label> 
									<textarea class="form-control" id="milestone_text_message" required rows=5></textarea>
								</div>
							</div>
						</div>
					
					<button type="button" id="btn_delete_milestone" class="btn btn-danger float-left">Delete</button>
					
					</div>
					<BR>
					
					

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						
						<button type="submit" id="btn_save_milestone" class="btn btn-success btn-lg btn-block">Save</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>