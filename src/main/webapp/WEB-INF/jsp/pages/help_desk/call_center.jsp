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
	              <i class="fa fa-bar-chart"></i>Search Applications   <%-- ${page_name == "page_enquiry_backoffice" ? "test value" : ""} --%> </div>
	            <div class="card-body">
	              	<!--  The Form starts here -->
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
						<!-- <div class="custom-control custom-radio custom-control-inline">
						  <input type="radio" id="rbtn_search_type5" name="rbtn_search_type" class="custom-control-input" value="ar_name" required>
						  <label class="custom-control-label" for="rbtn_search_type5">Applicant Name</label>
						</div> -->
					  
					  <br><br>
			          <div class="form-group">
			            <div class="form-row">
			            <!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
			              <div class="col-md-8">
			                
			                <input class="form-control" id="cc_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
			              </div>
			              <div class="col-md-4">
			              	
			                <button type="submit" class="btn btn-primary btn-block" value="Search" id="btnCCJobSearch" > Search </button>
			                
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
	        <div class="col-sm-4">
	          <!-- Example Pie Chart Card-->
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fas fa-pie-chart"></i> Load Applicant Details</div>
	            <div class="card-body">
	            
	            	<form id="frmEnquiryApplicantDetails"  method="post">
						<div class="form-group">
					  	
					  		<label><b>Search By: </b></label>
					  	
					  </div>
			          <div class="form-group mb-4">
			          <label for="search_value">Job Number <br> &nbsp;</label>
			            <div class="form-row">
			              <div class="col-md-8">
			                <input class="form-control" id="hpl_job_number"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
			              </div>
			              <div class="col-md-4">
			              	
			                <input type="submit" class="btn btn-primary btn-block" value="Find Details" />  
			                
			              </div>
			            </div>
			          </div>
			        </form>
			        
			        <div class="mt-4 bg-success px-5" id="tbl_applicant_details_section" style="display:none"]>
			        	<!-- <h4 class="mb-4">Current Applicant details for Job Number : LVDGAST4765892020</h4>
			        	<table class="table text-xl" id="tbl_applicant_details">
			        		<tr><th>Name: </th><td>James Amrjhks</td></tr>
			        		<tr><th>Phone: </th><td>0876447857</td></tr>
			        		<tr><th>Email: </th><td>judeyamoah@gmial.com
			        		</td></tr>
			        	</table> -->
			        
			        </div>
	            
	          </div>
	              
	        </div> 
	      <!--   Here is the end of right table -->
      
      
   
      </div>
       
      	  </div>
    
    
    <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3" style="display:none" id="cc-search-results-section">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Search Results</div>
            <div class="card-body">
            
         
            
	             <!--  Here is where the fee list comes -->
	             
	             <div class="table-responsive" >
			           <table class="table table-bordered " id="cc-search-results-table" style="min-height:500px">
			              <thead>
			                <tr>
			                 <th>Applicant Name</th>
			                  <!-- <th>Case Number</th> -->
			                  <th>Job Number</th>
			                  <!-- <th>GLPIN</th> -->
			                  
			                  <th>Locality</th>
			                  <th>Regional Number</th>
			                  <th>Case Status</th>
			                  
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
 
 
 
 <div class="modal fade" id="trackingModal" tabindex="-1" role="dialog"
	aria-labelledby="addInspectionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addMinutesModalLabel">Application
					Tracking History</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container px-5">
					<h3>Details</h3>
					
					</div>
					<hr class="mt-2 mb-3">
					<div class="row  px-5">
					<br>
					
					
								<div class="col-sm-4"><b>Date Created</b><br><div id="date_created_text"></div>
								
								</div>
								<div class="col-sm-4"><b>Job Number</b><br><div id="job_number_text"></div>
								</div>
								<div class="col-sm-4"><b>Submitted By</b><br><div id="submitted_by_text"></div>
								</div>
							</div>
							<br>
					<div class="row  px-5">
							
								<div class="col-sm-4"><b>Main Service</b><br><div id="main_service_text"></div>
								</div>
								<div class="col-sm-4"><b>Sub Service</b><br><div id="sub_service_text"></div>
								</div>
								<div class="col-sm-4"><b>Status</b><br><div id="status_text"></div>
								</div>
							
						
				</div>
				<br><br>
				<hr class="mt-2 mb-3">
				<div class="row  px-2">
					<div class="col-md-6">
						<div class="card">
							<div class="card-header">Milestones</div>
							<div class="card-body">
								<table class="table table-bordered" id="cabinet-tracking">
									<thead>
										<tr>
											<th>SN</th>
											<th>Milestone Status</th>
											<!-- <th>status</th> -->
											<!-- <th>Date</th> -->
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>




					</div>
					<div class="col-md-6">
						<div class="card">
							<div class="card-header">SMS Messages/ Notifications</div>
							<div class="card-body">
								<table class="table table-bordered" id="sms-tracking">
									<thead>
										<tr>
											<th>SN</th>
											<th>Message</th>
											<th>Date Sent</th>
											<!-- <th>Date</th> -->
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>
					</div>

				</div>


			</div>
		</div>
	</div>
</div>
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>