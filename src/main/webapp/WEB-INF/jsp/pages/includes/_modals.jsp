<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<jsp:useBean id="now" class="java.util.Date" />



<!-- Applications with staff Details modal Section============================= -->
	<div class="modal fade" id="cstStaffDetailsModal" tabindex="-1" role="dialog" aria-labelledby="cstStaffDetailsModal" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header bg-primary text-light">
	        <h5 class="modal-title" id="">Records Information Applications with <span id="cst_modal_staff_name"></span></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <table id="cst_apps_with_staff_details_table" class="table data-table-">
	        	<thead>
		        	<tr>
		        		<th>Job Number</th>
		        		<th>Received Date</th>
		        		<th>Duration</th>
		        		<th>Sent by</th>
		        		<th>Action</th>
	        		</tr>
	        	</thead>
	        	<tbody>
	        	
	        	</tbody>
	        </table>
	           
	      </div>
	      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		   </div>
	    </div>
	  </div>
	</div>


	<div class="modal fade" id="cstUnitSummaryModal" tabindex="-1" role="dialog" aria-labelledby="cstUnitSummaryModal" aria-hidden="true">
		<div class="modal-dialog modal-xl">
		  <div class="modal-content">
			<div class="modal-header bg-primary text-light">
			  <h5 class="modal-title" id=""><span id="cst_us_modal_name"></span></h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <table id="cst_unit_summary_details_table" class="table data-table-">
				  <thead>
					  <tr>
						  <th>Job Number</th>
						  <th>APPLICANT NAME</th>
						  <th>Received Date</th>
						  <th>Duration</th>
						  <th>Action</th>
					  </tr>
				  </thead>
				  <tbody>
				  
				  </tbody>
			  </table>
				 
			</div>
			<div class="modal-footer">
				  <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			 </div>
		  </div>
		</div>
	  </div>

	  <div class="modal fade" id="qcUnitSummaryModal" tabindex="-1" role="dialog" aria-labelledby="qcUnitSummaryModal" aria-hidden="true">
		<div class="modal-dialog modal-xl">
		  <div class="modal-content">
			<div class="modal-header bg-primary text-light">
			  <h5 class="modal-title" id=""><span id="qc_us_modal_name"></span></h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <table id="qc_unit_summary_details_table" class="table data-table-">
				  <thead>
					  <tr>
						  <th>Job Number</th>
						  <th>APPLICANT NAME</th>
						  <th>Received Date</th>
						  <th>Duration</th>
						  <!-- <th class="d-none" id="hide_from_qc">Action</th> -->
					  </tr>
				  </thead>
				  <tbody>
				  
				  </tbody>
			  </table>
				 
			</div>
			<div class="modal-footer">
				  <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			 </div>
		  </div>
		</div>
	  </div>
	
	
<!-- Applications with staff summary modal Section============================= -->
	<div class="modal fade" id="cstStaffSummaryModal" tabindex="-1" role="dialog" aria-labelledby="cstStaffSummaryModal" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header ">
	        <h5 class="modal-title" id="cstStaffSummaryModalLabel">Summary of Assigned Applications for Records Information at <span id="cst_modal_divison_name"></span></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <table id="cst_apps_with_staff_summary_table" class="table data-table-">
	        	<thead>
		        	<tr>
		        		<th>Staff Name</th>
		        		<th>No of Applications</th>
		        		<th>No of Overdue Applications</th>
		        		<th>Action</th>
	        		</tr>
	        	</thead>
	        	<tbody>
	        	
	        	</tbody>
	        </table>
	           
	      </div>
	      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		   </div>
	    </div>
	  </div>
	</div>
	
<!-- Receive Hard Doc Stamp modal Section============================= -->
	<div class="modal fade" id="receiveDocsStampingModal" tabindex="-1" role="dialog" aria-labelledby="appsPassedDueModal" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header bg-primary text-light">
	        <h5 class="modal-title">Receive Hardcopy Document for Application</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="frmReceiveDocsStamping">
	        	<h3>Application Details </h3>
						<hr>
	        	 
						
						
						 <div class="form-group row">
						  <div class="col-sm-6">
						  	  <label  class="form-label">Job Number</label>
						      <input type="text" readonly class="form-control"  id="stmp_job_number">
						    </div>
						    
						    <div class="col-sm-6">
						      <label  class="form-label">Application Type</label>
						      <input type="text" readonly class="form-control"  id="stmp_business_process_sub_name">
						    </div>
						  </div>
						  <div class="form-group row">
							<label class="col form-label">Applicant Name</label>
							<div class="col">
								<input type="text" readonly class="form-control" id="stmp_ar_name">
							</div>
						</div>
						
						
						<hr>
						
						
						<br><br>
						<div class="row">
							<div class="col-6  border-right">
								<h3>Depositor Details </h3>
					          	<hr>											  
								  <div class="form-group row">
								    <label class="col form-label">Depositor Name</label>
								    <div class="col-sm-12">
								      <textarea required class="form-control" id="smtp_depositor_name" placeholder="Name of person submitting document"></textarea>
								    </div>
								  </div>
								  <div class="form-group row">
								    <label class="col form-label">Depositor Contact</label>
								    <div class="col-sm-12">
								      <input type="text" required class="form-control" id="smtp_depositor_phone" placeholder="eg. 0244 222333">
								    </div>
								  </div>
							</div>
							<div class="col-6">
								<h3>Document Details </h3>
					          	<hr>											  
								  <div class="form-group row">
								    <label class="col form-label">Document content/type/description</label>
								    <div class="col-sm-12">
								      <button class='col-3 txt-action-rec' type="button" value="Indenture" >Indenture</button>  
								        <button class='col-3 txt-action-rec' type="button" value="Site Plan" >Site Plan</button>   
								        <button class='col-3 txt-action-rec' type="button" value="ID Card" >ID Card</button> <br><br>
								    </div>
								    <div class="col-sm-12">
								      <textarea required class="form-control" 
								      id="smtp_document_description" placeholder="Description or content of document"
								      rows=4></textarea>
								    </div>
								  </div>
							</div>
						
						
						</div>
			          	
						  
						  
						  <hr>
			          	
																	  
						  <div class="form-group row">
						    
						    <div class="col-sm-12" id="btnSumitRecDocSecion">
						    	<button data-backdrop="static" data-keyboard="false" class="btn btn-primary btn-block  p-3 col" id="btnSumitRecDoc"> 
								Submit
								</button>
								
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

  <!-- Past due application modal Section============================= -->
	<div class="modal fade" id="appsPassedDueModal" tabindex="-1" role="dialog" aria-labelledby="appsPassedDueModal" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header bg-danger text-light">
	        <h5 class="modal-title" id="newQueryModalLabel">Applications Passed Due Dates</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <table id="report_dashboard_apps_past_due_date_by_user_table" class="table data-table-">
	        	<thead>
		        	<tr>
		        		<th>Job Number</th>
		        		<th>Application Type</th>
		        		<th>Applicant Name</th>
		        		<th>Date Received</th>
		        		<th>Action</th>
	        		</tr>
	        	</thead>
	        	<tbody>
	        	
	        	</tbody>
	        </table>
	           
	      </div>
	      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		   </div>
	    </div>
	  </div>
	</div>


	<!-- Past due application modal Section============================= -->
	<div class="modal fade" id="corpappsPassedDueModal" tabindex="-1" role="dialog" aria-labelledby="corpappsPassedDueModal" aria-hidden="true">
		<div class="modal-dialog modal-xl">
		  <div class="modal-content">
			<div class="modal-header bg-danger text-light">
			  <h5 class="modal-title" id="newQueryModalLabel">Applications Passed Due Dates</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <table id="report_dashboard_corp_apps_past_due_date_by_user_table" class="table data-table-">
				  <thead>
					  <tr>
						  <th>Job Number</th>
						  <th>Application Type</th>
						  <th>Applicant Name</th>
						  <th>Date Received</th>
						  <th>Action</th>
					  </tr>
				  </thead>
				  <tbody>
				  
				  </tbody>
			  </table>
				 
			</div>
			<div class="modal-footer">
				  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			 </div>
		  </div>
		</div>
	  </div>


	<!-- Past due application modal Section============================= -->
	<div class="modal fade" id="transitionalcaseModal" tabindex="-1" role="dialog" aria-labelledby="transitionalcaseModal" aria-hidden="true">
		<div class="modal-dialog modal-xl">
		  <div class="modal-content">
			<div class="modal-header bg-warning text-light">
			  <h5 class="modal-title" id="newQueryModalLabel">Transitional Plotting Application List</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <table id="job_coor_tbl" class="table data-table-">
				  <thead>
					  <tr>
						  <th>Job Number</th>
						  <th>Application Type</th>
						  <th>Applicant Name</th>
						  <th>Locality</th>
						  <th>Date Received</th>
						  <th>Action</th>
					  </tr>
				  </thead>
				  <tbody>
				  
				  </tbody>
			  </table>
				 
			</div>
			<div class="modal-footer">
				  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			 </div>
		  </div>
		</div>
	  </div>




 

	  <!-- Past due application modal Section============================= -->
	<div class="modal fade" id="requestappModal" tabindex="-1" role="dialog" aria-labelledby="requestappModal" aria-hidden="true">
		<div class="modal-dialog modal-xl">
		  <div class="modal-content">
			<div class="modal-header bg-warning text-light"><h5>Incoming Requests</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <!-- <table id="" class="table data-table-"> -->
				<div class="table-responsive">
					<table class="table table-bordered table-hover " id="job_request_app_tbl" width="100%" cellspacing="0">
				  <thead>
					  <tr>
						  <th>Job Number</th>
						  <th>Applicant Name</th>
						  <th>Application Type</th>
						  <th>Purpose</th>
						  <th>Comment</th>
						  <th>Sent By</th>
						  <th>Received Date</th>
						  <th>Action</th>
					  </tr>
				  </thead>
				  <tbody>
				  
				  </tbody>
			  </table>
				 
			</div>
		</div>
			<div class="modal-footer">
				  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			 </div>
		  </div>
		</div>
	  </div>



     
	
	<!-- Past due application modal Section============================= -->
	<div class="modal fade" id="appsReceivedMonthModal" tabindex="-1" role="dialog" aria-labelledby="appsReceivedMonthModal" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header bg-info text-light">
	        <h5 class="modal-title" id="newQueryModalLabel">Applications Received This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <table id="report_dashboard_apps_rec_month_by_user_table" class="table data-table-">
	        	<thead>
		        	<tr>
		        		<th>Job Number</th>
		        		<th>Application Type</th>
		        		<th>Applicant Name</th>
		        		<th>Date Received</th>
		        		<th>Sent By </th>
	        		</tr>
	        	</thead>
	        	<tbody>
	        	
	        	</tbody>
	        </table>
	           
	      </div>
	      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		   </div>
	    </div>
	  </div>
	</div>
	
	
	<!-- Completed application modal Section============================= -->
	<div class="modal fade" id="appsCompletedMonthModal" tabindex="-1" role="dialog" aria-labelledby="appsCompletedMonthModal" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header  bg-success text-light">
	        <h5 class="modal-title" id="newQueryModalLabel">Applications Completed This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <table id="report_dashboard_apps_comp_month_by_user_table" class="table data-table-">
	        	<thead>
	        		<th>Job Number</th>
	        		<th>Application Type</th>
	        		<th>Applicant Name</th>
	        		<th>Date Completed</th>
	        	</thead>
	        	<tbody>
	        	
	        	</tbody>
	        </table>
	           
	      </div>
	      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		   </div>
	    </div>
	  </div>
	</div>
	
	
	
   <!-- Query Section============================= -->
	<div class="modal fade" id="newQueryModal" tabindex="-1" role="dialog" aria-labelledby="newQueryModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="newQueryModalLabel">Query Form</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	     	<div id="alert-display-space-query"></div>
	        <form id="form_add_query">
	        
	        	
	        	<input  id="qid" name="qid" type="hidden" value="0" >
           		<input type="hidden"  id="query_job_number" class="form-control" required readonly value="${job_number}">	          		
           		<input type="hidden" name="query_case_number" id="query_case_number" class="form-control" required readonly value="${case_number}">
       	
	          <div class="row">
	          	
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          			<div class="form-group">
		            		<label for="query_reasons" class="col-form-label">General Reasons (What is wrong with this Application)</label>
		            		<textarea name="query_general_reason" id="query_general_reason" class="form-control" required rows=2></textarea>
		          		</div>
		          	<div class="to_hide_on_level_1">
		          		<div class="form-group">
		            		<label for="query_reasons" class="col-form-label">Reasons (Reason for Query that will be displayed for Applicant)</label>
		            		<textarea name="query_reasons" id="query_reasons" class="form-control" required rows=2></textarea>
		          		</div>
		          		<div class="form-group">
		            		<label for="query_remarks" class="col-form-label">Remarks (What do you recommend to be done)</label>
		            		<textarea name="query_remarks" id="query_remarks" class="form-control" required rows=2></textarea>
		          		</div>
		          		<div class="form-group">
		          		
		          			<label for="query_case_number" class="col-form-label">Is Document Attachment Required? </label>
		          			
		          			<div class="from-row">
			          			<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="query_attachement_requried" id="query_attachement_requried1" value="1" required>
								  <label class="form-check-label">
								    YES
								  </label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="query_attachement_requried" id="query_attachement_requried2" value="0" required>
								  <label class="form-check-label" >
								    NO
								  </label>
								</div>
							</div>
		          		
		            		
		          		</div>
	          		</div>
	          		<div class="form-group">
	            		<label for="query_status" class="col-form-label">Status</label>
	            		<select name="query_status" id="query_status" class="form-control" required>
	            			<option value=1>Active</option>
	            			<option value=0>Inactive</option>
	            		</select>
	          		</div>
	          	</div>
	          	
	          	
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="query_job_number" class="col-form-label">Queried By</label>
	            		<input type="text"  id="query_created_by" class="form-control" required readonly value="">
	          		</div>
	          		<div class="form-group">
	            		<label for="query_case_number" class="col-form-label">Queried Date </label>
	            		<input type="text"  id="query_created_date" class="form-control" required readonly value="">
	          		</div>
	          		<div class="form-group">
	            		<label for="query_job_number" class="col-form-label">Modified By</label>
	            		<input type="text"  id="query_modified_by" class="form-control" required readonly value="">
	          		</div>
	          		<div class="form-group">
	            		<label for="query_case_number" class="col-form-label">Modified Date </label>
	            		<input type="text"  id="query_modified_date" class="form-control" required readonly value="">
	          		</div>
	          		<hr><br>
	          		<div class="form-group">
		            		<label for="query_response" class="col-form-label">Responds From Applicant</label>
		            		<textarea name="query_response" id="query_response" class="form-control" required rows=2 disabled readonly></textarea>
		          		</div>
	          		
	          		
	          	</div>
	          </div>
	           <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" id="btn_query_section" class="btn btn-primary">Save Changes</button>
		      </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
 
	

<!-- Bills and EGCR ============================ -->
<div class="modal fade" id="viewNotificationModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" >Notification on Application </h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				
					<!-- <div class="container"> -->

						<!-- <div class="col-sm-12 col-xs-12"> -->
							
							 
							  <div class="mb-3 row">
							    <label for="" class="col-sm-4 col-form-label">Job Number:</label>
							    <div class="col-sm-8">
							      <input type="text" readonly class="form-control" id="notice-frm-jobnumber" >
							    </div>
							  </div>
							  <div class="mb-3 row">
							    <label for="" class="col-sm-4 col-form-label"> Date: </label>
							    <div class="col-sm-8">
							      <input type="text" readonly class="form-control" id="notice-frm-date" >
							    </div>
							  </div>
							  <div class="mb-3 row">
							    <label for="" class="col-sm-4 col-form-label">Sent By: </label>
							    <div class="col-sm-8">
							      <input type="text" readonly class="form-control" id="notice-frm-by" >
							    </div>
							  </div>
							  <div class="mb-3 row">
							    <label for="" class="col-sm-4 col-form-label"> Type </label>
							    <div class="col-sm-8">
							      <input type="text" readonly class="form-control" id="notice-frm-type" >
							    </div>
							  </div>
							  <div class="mb-3 row">
							    <label for="" class="col-sm-4 col-form-label"> Details </label>
							    <div class="col-sm-8">
							    	<textarea rows="" cols="" readonly class="form-control" id="notice-frm-details"></textarea>
							    </div>
							  </div>
							  <div class="mb-3 row">
							    <label for="" class="col-sm-4 col-form-label"> Status </label>
							    <div class="col-sm-8">
							      <input type="text" readonly class="form-control" id="notice-frm-status" >
							    </div>
							  </div>
							<div class="form-group">
								
								

							</div>
						<!-- </div> -->
						
						<h5>Replies</h5>
						<hr>
						<div class="row px-2" id="notificationReplies">
						</div>
					<!-- </div> -->
					<br/>
						
						<form id="frmNotificationReply" class="">
							 <div class="mb-3 row">
							    <label for="" class="col-sm-4 col-form-label">Reply Message </label>
							    <div class="col-sm-8">
							    	<textarea rows="" cols=""  class="form-control" id="reply-frm-details" required></textarea>
							    	<input type="hidden" id="reply-frm-notice-id">
							    </div>
							  </div>
							  
							    
							    	<button  class="btn btn-success float-right" >Submit</button>
							 						
						</form>
					</div>
					
					
					<div class="modal-footer">
						<form action="registration_application_progress_details" method="post">
							<input type="hidden" name="case_number" id="nt_case_number" value="${appfiles.case_number}">
							<input type="hidden" name="transaction_number" id="nt_transaction_number" value="${appfiles.transaction_number}">
							<input type="hidden" name="job_number" id="nt_job_number" value="${appfiles.job_number}">
							
								<button type="submit" name="save" class="btn btn-danger btn-icon-split" >
								<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Open/Work on Application</span>
								</button>
						</form>
					
						<button type="button" class="btn btn-info" id="btnReplyNotification">Reply Notification</button>
								
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal"
						>Close</button>
						
					</div>
			</div>
		</div>
	</div>
</div>
<!--=============================================== END aLERT ========================================================================  -->


<!-- Bills and EGCR ============================ -->
<div class="modal fade" id="viewMessageModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" >Message Details </h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" value="" id="sender_name_text" />
				<input type="hidden" value="${userid}" id="userid_text" />
				<div class="row" id="message_alert_details">
					
				</div>
				
				<div id="text_message_div">
					<textarea class="form-control" id="txt_reply_message_alert" rows="5"  placeholder="Type something here..."></textarea>
				</div>
			</div>
					
					
					<div class="modal-footer">
					
						<button type="button" class="btn btn-danger"
							data-dismiss="modal"
						>Close</button>
						<button type="button" class="btn btn-success" id="btn_reply_message_alert">Reply</button>
								
						
					</div>
			</div>
		</div>
	</div>
</div>
<!--=============================================== END aLERT ========================================================================  -->



<!-- Bills and EGCR ============================ -->
<div class="modal fade" id="viewBillModal" tabindex="-1"
	role="dialog" aria-labelledby="viewBillModal" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="viewBillModalLabel">Bill Details  </h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
					
					<div class="container">

						<div class="col-sm-12 col-xs-12">

							<div class="form-group">
								<h2>Bill Items List</h2>
								<div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="bill__dataTable">
				           		
				              <thead>
				                  <tr>
				
					                 <th>Bill No</th>
					                 <th>Amount</th>
					                 <!-- <th>Receipt Number</th>
					                 <th>Payment Date</th> -->
					                 <th>Division</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							     <c:forEach items="${payment_bill}" var="payment_bill_row">
					                <tr>
					                    <td>${payment_bill_row.bill_number}</td>
					                    <td>${payment_bill_row.bill_amount}</td>
					                    <%-- <td>${payment_bill_row.payment_slip_number}</td>
					                    <td>${payment_bill_row.payment_date}</td> --%>
					                    <td>${payment_bill_row.division}</td>
					                 </tr>
					             </c:forEach>
				  				</tbody>
				    
				            
				            </table>
				          </div>

							</div>
						</div>
					</div>
					<br/>
						<div class="container">
							<div class="col-sm-12 col-xs-12" >
								<h2>EGCR Receipt <a  id="egcr_container"  target="_blank"
								href="#"><button  class="btn btn-primary"  id="egcr_container_btn"  
								>View/Download</button></a></h2>
								 <iframe id="egcr_box" height="100%" width="100%" src=""></iframe>
								    
							</div> 
						</div>
					</div>
					<br/> <br/> <br/>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal"
						>Close</button>
						
					</div>
			</div>
		</div>
	</div>
</div>
<!--=============================================== UPDATE JUDE 15 March 2021 ========================================================================  -->



<!-- Assign Inspection ============================ -->
<div class="modal fade" id="assignInspectionModal" tabindex="-1"
	role="dialog" aria-labelledby="assignInspectionModal" aria-hidden="true"
>
	<div class="modal-dialog ">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="viewBatchlistModalLabel">Assign Inspection </h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="form_assign_inpection">
					<%-- <input id="bl_modified_by" name="bl_modified_by" type="hidden"
						value="${fullname}"
					> <input id="bl_modified_by_id" name="bl_modified_by_id"
						type="hidden" value="${userid}"
					> --%>

					<div class="container">

						<div class="col-sm-12 col-xs-12">

							<div class="form-group">
								<label for="mt_to" class="col-form-label">Assign To :</label> <input class="form-control" id="in_user_to_send_to"
											name="user_to_send_to" type="text"
											aria-describedby="nameHelp" list="in_listofusers"
											class="autocomplat" placeholder="Enter Username" required>
											<datalist id="in_listofusers">

												<c:forEach items="${userlist}" var="user">
													<option data-value="${user.userid}" value="${user.fullname}"></option>
										      </c:forEach>
										  
											</datalist>

							</div>
						</div>
					</div>
					<br/>
					<div class="container">
						<div class="col-sm-12 col-xs-12">
							
							<div class="form-group">
							    <label for="purpose-of-inspection">Purpose of Inspection</label>
							    <input required list="purpose_list"  type="text" class="form-control" id="purpose-of-inspection" aria-describedby="purpose-of-inspection" >
							    <!-- <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> -->
							    <datalist id="purpose_list">
				                    <option value="General Valuation">
				                    <option value="Court Judgement">
				                </datalist> 
							  </div>
						</div>
					</div>
					<br/> <br/> <br/>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal"
						>Close</button>
						<button type="button" id="btn_assign_inspection"
							class="btn btn-primary"
						>Assign to Officer</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!--=============================================== UPDATE JUDE 26 July 2020 ========================================================================  -->



<!--===============================================NEW UPDATE JUDE ========================================================================  -->
<div class="modal fade" id="addeditpartyGeneral" tabindex="-1"
	role="dialog" aria-labelledby="addeditpartyGeneral" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add New Party</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="party_id_gen" value="" >

				<div class="form-group">
					<label for="bl_ar_name_gen">Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="party_ar_name_gen"
					></textarea>
				</div>
				
				<div class="form-group">
					<label for="bl_ar_name_gen">Address</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="party_ar_address_gen"
					></textarea>
				</div>
				
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_job_number">Sex</label> <select
								name="bl_txt_ar_gender" id="party_ar_gender_gen"
								data-live-search="true"
								data-none-results-text="I found no results"
								title="Please select fruit" class="form-control selectpicker"
							>
								<option value="-1">Select Gender</option>
								
								<c:forEach items="${genderlist}" var="gender">
									<option value="${gender.gender_name}">${gender.gender_name}</option>
						 		 </c:forEach>
						  
							</select>
						</div>
						<div class="col">
							<label for="bl_job_number">Person Type</label> <select
								name="bl_txt_ar_gender" id="party_ar_person_type_gen"
								data-live-search="true"
								data-none-results-text="I found no results"
								title="Please select fruit" class="form-control selectpicker"
							>
								<option value="Male">Natural Person</option>
								<option value="Female">Company</option>
							</select>
						</div>
					</div>
				</div>




				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_job_number">Phone #</label> <input
								class="form-control " type="text"
								placeholder="Enter Phone Number" id="party_ar_cell_phone_gen"
							>
						</div>

						<div class="col">
							<label for="bl_job_number">Phone # 2</label> <input
								class="form-control " type="text"
								placeholder="Enter Phone Number" id="party_ar_cell_phone2_gen"
							>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_job_number">ID Type</label> <select
								name="party_ar_id_type_gen" id="party_ar_id_type_gen"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="National ID">National ID</option>
								<option value="Drivers License">Drivers License</option>
								<option value="NHIS">NHIS</option>
								<option value="Passport">Passport</option>

							</select>
						</div>


						<div class="col">
							<label for="bl_job_number">ID Number</label> <input
								class="form-control" type="text" placeholder=""
								id="party_ar_id_number_gen"
							>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="bl_job_number">TIN</label> <input class="form-control "
								type="text" placeholder="Enter TIN" id="party_ar_tin_no_gen"
							>
						</div>
				
						<div class="col">
							<label for="party_ar_nationality_gen">Nationality</label> <select
								id="party_ar_nationality_gen"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="Ghanaian">Ghanaian</option>
								<option value="Foreigner">Foreigner</option>

							</select>
						</div>
					</div>
				</div>


				
				<div class="form-group">
					<label for="bl_job_number">Type of Party</label> <select
						name="party_ar_type_of_party_gen" id="party_ar_type_of_party_gen"
						data-live-search="true" class="form-control selectpicker"
					>
						<option value="Applicant">Applicant</option>
						<option value="Grantor">Grantor</option>
						<option value="Assignor">Assignor</option>
						<option value="Assignee">Assignee</option>
						<option value="Mortgagor">Mortgagor</option>
						<option value="Mortgagee">Mortgagee</option>
						<option value="Lessee">Lessee</option>
						<option value="Lessor">Lessor</option>
						<option value="Depositor">Depositor</option>
					</select>
				</div>
				<div id="grantor-family-div" style="display: none">
					<div class="form-group">
						<label for="">Stool/Family Name</label> <input type="text"
							class="form-control" id="family_name_gen"
							placeholder="Stool/Family Name" required
						>

					</div>

					<div class="form-group">
						<label for="">Grantor's Family</label> <input type="text"
							class="form-control" id="grantor_family_gen" placeholder=""
							required
						>
					</div>
				</div>


				<div class="form-group">
					<label for="">Residential Address/GhanaPost Address</label> <input type="text"
						class="form-control" id="party_ar_location_gen"
						placeholder="" required
					>
				</div>

				




			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnsavenewpartyGeneral"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Save</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->



			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>




<div class="modal fade" id="deletepartyGeneral" tabindex="-1"
	role="dialog" aria-labelledby="deletepartyGeneral" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Delete Party</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="party_id_gen_d" value="" >
				<input type="hidden" id="party_p_uid" value="" >
				<input type="hidden" id="party_ar_id" value="" >
				<div class="form-group">
					<label for="bl_ar_name_gen">Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="party_ar_name_gen_d"
					></textarea>
				</div>
				
				


			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="confirmDeletePartyGeneral"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Confirm</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->



			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<!--===============================================NEW UPDATE JUDE ========================================================================  -->
<div class="modal fade" id="addpaymentforinpayservice" tabindex="-1"
	role="dialog" aria-labelledby="addpaymentforinpayservice" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add New Fees</h4>
			</div>
			<div class="modal-body">
				<!-- <input type="text" id="party_id_gen" value="" style="display: none"> -->

				<div class="form-group">
										
					<input type="text"
						class="form-control" id="apis_job_number"
						value="${job_number}" required readonly
					>
				</div>
				
				<div class="form-group">
					<label for="bl_ar_name_gen">Type of Fees</label>
									
					<input type="text"
						class="form-control" id="apis_type_of_fee"
						placeholder="Premium" required
					>
				</div>
				
	
				<div class="form-group">
					<label for="">Amount</label> <input type="text"
						class="form-control" id="apis_type_of_amount"
						placeholder="0.00" required
					>
				</div>

				




			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btn_save_addpaymentforinpayservice"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Save</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->



			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



<div class="modal fade" id="askForPurposeOfBatching" tabindex="-1" role="dialog" data-position="10"
	aria-labelledby="askForPurposeOfBatching" aria-hidden="true" style="z-index:10000000000"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add To Batch List</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="bl_application_stage" name="bl_application_stage">
				<input type="hidden" id="bl_application_stage_baby_step" name="bl_application_stage_baby_step">

				<div class="form-group">
					<label for="bl_job_number">Job Number</label> <input
						class="form-control " type="text" placeholder=""
						id="bl_job_number_new" readonly
					>
				</div>





				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_ar_name_new" readonly
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Application Type</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_business_process_sub_name_new" readonly
					></textarea>
				</div>


				<div class="form-group">
					<label for="bl_application_stage_name">Main Milestone</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_application_stage_name" readonly
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_application_stage_name_baby_step">Baby Step</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_application_stage_name_baby_step" readonly
					></textarea>
				</div>




				<div class="form-group">
					<label for="bl_job_purpose">Sent Purpose</label>
				<select name="bl_job_purpose_new" id="bl_job_purpose_new" class="form-control selectpicker"
					>
						<!-- <option value="Male">Male</option>
						<option value="Female">Female</option> -->
				</select>
					
				</div>

				<div class="form-group">
					<label for="bl_application_stage_name_baby_step">Remarks/Notes</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_remarks_notes"
					></textarea>
				</div>


				

				
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnaddjobtolistFinal"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Add to List</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="askForPurposeOfSendingRequest" tabindex="-1" role="dialog" data-position="10"
	aria-labelledby="askForPurposeOfSendingRequest" aria-hidden="true" style="z-index:10000000000"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add To Request List</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="bl_application_stage" name="bl_application_stage">
				<input type="hidden" id="bl_application_stage_baby_step" name="bl_application_stage_baby_step">

				<div class="form-group">
					<label for="bl_job_number">Job Number</label> <input
						class="form-control " type="text" placeholder=""
						id="req_job_number" readonly
					>
				</div>





				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="req_ar_name" readonly
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Application Type</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="req_business_process_sub_name" readonly
					></textarea>
				</div>


				<div class="form-group">
					<label for="bl_application_stage_name">Locality</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="req_locality" readonly
					></textarea>
				</div>




				<div class="form-group">
					<label for="bl_job_purpose">Sent Purpose</label>
				<select name="req_job_purpose" id="req_job_purpose" class="form-control selectpicker"
					>
						<!-- <option value="Male">Male</option>
						<option value="Female">Female</option> -->
						<!-- <option value="">-- select Purpose --</option>
						<option value="Reverification of Search">Reverification of Search</option>
						<option value="Noting of parcels">Noting of parcels</option>
						<option value="Further Entries">Further Entries</option>
						<option value="Root of Title">Root of Title</option>
						<option value="Link Child to Mother">Link Child to Mother</option>
						<option value="Plan Preparation">Plan Preparation</option>
						<option value="Certificate Generation">Certificate Generation</option>
						<option value="Certificate Generation Transition">Certificate Generation Transition</option>
						<option value="Volume and Folio Generation">Volume and Folio Generation</option>
						<option value="Certificate Signing">Certificate Signing</option>
						<option value="Final Ploting">Final Plotting</option>
						<option value="Final Approval Registration">Final Approval Registration</option>
						<option value="Approval Vetting">Approval Vetting</option>
						<option value="Generate Interest Number">Generate Interest Number</option>
						<option value="Update Existing Plan Details">Update Existing Plan Details</option>
						<option value="Update Existing Certificate Details">Update Existing Certificate Details</option>
						<option value="Update Mortgage Certificate Number">Update Mortgage Certificate Number</option>
						<option value="Generate Sub-Interest Number">Generate Sub-Interest Number</option>
						<option value="Objection">Objection</option>
						<option value="Update Registered Number">Update Registered Number</option>
						<option value="Update Publication Details">Update Publication Details</option>
						<option value="Title Plan Preparation">Title Plan Preparation</option>
						<option value="Inspection">Inspection</option> -->
				</select>
					
				</div>

				<div class="form-group">
					<label for="bl_application_stage_name_baby_step">Remarks</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="req_remarks"
					></textarea>
				</div>


				

				
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnaddreqtolistFinal"
					class="btn btn-success btn-icon-split d-none"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Add to List</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="checkAppdetailsforRequest" tabindex="-1" role="dialog" data-position="10"
	aria-labelledby="checkAppdetailsforRequest" aria-hidden="true" style="z-index:10000000000"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Applicaion Details</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="bl_application_stage" name="bl_application_stage">
				<input type="hidden" id="bl_application_stage_baby_step" name="bl_application_stage_baby_step">

				<div class="form-group">
					<label for="bl_job_number">Job Number</label> <input
						class="form-control " type="text" placeholder=""
						id="reqsss_job_number" readonly
					>
				</div>

				<div class="form-group">
					<label for="bl_ar_name">District Number</label>
					<input
						class="form-control " type="text" placeholder=""
						id="req_distict_no" readonly
					>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Section Number</label>
					<input
						class="form-control " type="text" placeholder=""
						id="req_section_no" readonly
					>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Block Number</label>
					<input
						class="form-control " type="text" placeholder=""
						id="req_block_no" readonly
					>
				</div>


				<div class="form-group">
					<label for="bl_application_stage_name">Folio</label>
					<input
						class="form-control " type="text" placeholder=""
						id="req_folio_no" readonly
					>
				</div>

				<div class="form-group">
					<label for="bl_application_stage_name">Volume</label>
					<input
						class="form-control " type="text" placeholder=""
						id="req_volume_no" readonly
					>
				</div>

				<div class="form-group">
					<label for="bl_application_stage_name">Parcel WKT</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="req_parcel_wkt" readonly
					></textarea>
				</div>


			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<!-- <a href="#" id="btnaddreqtolistFinal"
					class="btn btn-success btn-icon-split d-none"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Add to List</span>
				</a> -->

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="askArchiveRequest" tabindex="-1" role="dialog" data-position="10"
	aria-labelledby="askArchiveRequest" aria-hidden="true" style="z-index:10000000000"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Are you sure you want to archive request?</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="arc_rq_id" name="bl_application_stage">
				<input type="hidden" id="bl_application_stage_baby_step" name="bl_application_stage_baby_step">

				<div class="form-group">
					<label for="bl_job_number">Job Number</label> <input
						class="form-control " type="text" placeholder=""
						id="arc_job_number" readonly
					>
				</div>





				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="arc_ar_name" readonly
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_application_stage_name_baby_step">Note</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="arch_note"
					></textarea>
				</div>


				

				
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnarchiverequest"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Yes</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">No</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="askForPurposeOfSendingRequesttoOfficer" tabindex="-1" role="dialog" data-position="10"
	aria-labelledby="askForPurposeOfSendingRequesttoOfficer" aria-hidden="true" style="z-index:10000000000"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add To Request List</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="bl_application_stage" name="bl_application_stage">
				<input type="hidden" id="bl_application_stage_baby_step" name="bl_application_stage_baby_step">

				<div class="form-group">
					<label for="bl_job_number">Job Number</label> <input
						class="form-control " type="text" placeholder=""
						id="reqn_job_number" readonly
					>
				</div>





				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="reqn_ar_name" readonly
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Application Type</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="reqn_business_process_sub_name" readonly
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_job_purpose">Sent Purpose</label>
				
					<input
						class="form-control " type="text" placeholder=""
						id="reqn_job_purpose" readonly
					>
				</div>

				<div class="form-group">
					<label for="bl_application_stage_name_baby_step">Remarks</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="reqn_remarks"
					></textarea>
				</div>


				

				
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnaddreqtosendlistFinal"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Add to List</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- ============================================END NEW UPDATE=============================================================================== -->
<div class="modal fade" id="edit" tabindex="-1" role="dialog"
	aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add To Batch
					List</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Job Number</label> <input
						class="form-control " type="text" placeholder=""
						id="bl_job_number"
					>
				</div>


				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_ar_name"
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Application Type</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_business_process_sub_name"
					></textarea>
				</div>




				<div class="form-group">
					<label for="bl_job_purpose">Sent Purpose</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_job_purpose"
					></textarea>
				</div>



				<div class="form-group">
					<label for="result">Application Milestones</label>
					<div id="result"></div>

				</div>
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnaddjobtolist"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Add to List</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="addeditparty" tabindex="-1" role="dialog"
	aria-labelledby="addeditparty" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add New Party</h4>
			</div>
			<div class="modal-body">


				<div class="form-group">
					<label for="bl_ar_name">Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_txt_ar_name"
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_job_number">Gender</label> <select
						name="bl_txt_ar_gender" id="bl_cbo_ar_gender"
						data-live-search="true"
						data-none-results-text="I found no results"
						title="Please select fruit" class="form-control selectpicker"
					>
						<option value="Male">Male</option>
						<option value="Female">Female</option>
					</select>
				</div>


				<div class="form-group">
					<label for="bl_job_number">Phone #</label> <input
						class="form-control " type="text" placeholder="Enter Phone Number"
						id="bl_txt_ar_cell_phone"
					>
				</div>

				<div class="form-group">
					<label for="bl_job_number">ID Type</label> <select
						name="bl_cbo_ar_id_type" id="bl_cbo_ar_id_type"
						data-live-search="true"
						data-none-results-text="I found no results"
						title="Please select fruit" class="form-control selectpicker"
					>
						<option value="National ID">National ID</option>
						<option value="Drivers License">Drivers License</option>
						<option value="NHIS">NHIS</option>
						<option value="Passport">Passport</option>

					</select>
				</div>

				<div class="form-group">
					<label for="bl_job_number">ID Number</label> <input
						class="form-control " type="text" placeholder=""
						id="bl_txt_ar_id_number"
					>
				</div>

				<div class="form-group">
					<label for="bl_job_number">Type of Party</label> <select
						name="bl_cbo_type_of_party" id="bl_cbo_type_of_party"
						data-live-search="true"
						data-none-results-text="I found no results"
						title="Please select fruit" class="form-control selectpicker"
					>
						<option value="Applicant">Applicant</option>
						<option value="Grantor">Grantor</option>
						<option value="Depositor">Depositor</option>
					</select>
				</div>

			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnsavenewparty"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Save</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->



			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>






<!-- Extra large modal -->


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="mainmodalrecordinformation" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Records
					Information</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				<div class="container">
					<div class="row">
						<div class="col">


							<div class="form-group">
								<label for="bl_job_number">Job Number</label> <input
									class="form-control " type="text" placeholder=""
									id="bl_job_number1"
								>
							</div>


							<div class="form-group">
								<label for="bl_ar_name">Applicant Name</label>
								<textarea rows="2" class="form-control" placeholder=""
									id="bl_ar_name"
								></textarea>
							</div>

							<div class="form-group">
								<label for="bl_business_process_sub_name">Application
									Type</label>
								<textarea rows="2" class="form-control" placeholder=""
									id="bl_business_process_sub_name"
								></textarea>
							</div>




							<div class="form-group">
								<label for="bl_job_purpose">Sent Purpose</label>
								<textarea rows="2" class="form-control" placeholder=""
									id="bl_job_purpose"
								></textarea>
							</div>


						</div>
						<div class="col">
							<div class="btn-group" role="group"
								aria-label="Vertical button group"
							>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-exchange-alt"></span>
								</button>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-folder"></span>
								</button>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-shield-alt"></span>
								</button>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-arrow-right"></span>
								</button>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-shield-alt"></span>
								</button>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-calendar-alt"></span>
								</button>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-microphone-alt"></span>
								</button>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-volume-mute"></span>
								</button>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-marker"></span>
								</button>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-sliders-h"></span>
								</button>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fas fa-map"></span>
								</button>

							</div>


							<div class="form-group">
								<div id="map-lrd"
									style="width: 500px; height: 300px; display: inline-block;"
									class="map"
								></div>

							</div>



						</div>
					</div>

				</div>







				<!--   Here is the right Table -->








			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">
				<button type="button" class="btn btn-success">
					<span class="glyphicon glyphicon-ok-sign"></span>Yes
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
			</div>

		</div>
	</div>
</div>




<div class="modal fade" class='modal-dialog mw-100 w-75'
	id="modalrecordinformation" tabindex="-1" role="dialog"
	aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">records
					Information</h4>
			</div>
			<div class="modal-body">



				<div class="form-group">
					<div id="map"
						style="width: 500px; height: 300px; display: inline-block;"
						class="map"
					></div>

				</div>
				<!--   Here is the right Table -->






				<div class="form-group">
					<label for="result">Application Milestones</label>
					<div id="result"></div>

				</div>
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnaddjobtolist"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Add to List</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



<div class="modal fade" id="delete" tabindex="-1" role="dialog"
	aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Delete this
					entry</h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-danger">
					<span class="glyphicon glyphicon-warning-sign"></span> Are you sure
					you want to delete this Record?
				</div>

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success">
					<span class="glyphicon glyphicon-ok-sign"></span>Yes
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>No
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



<div class="modal fade" id="stepconfirmationDialog" tabindex="-1"
	role="dialog" aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Approve this
					Process</h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-danger">
					<span class="glyphicon glyphicon-warning-sign"></span> Are you sure
					you want to Approve the process?
				</div>

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success"
					id="btn_approve_registration_process"
				>
					<span class="glyphicon glyphicon-ok-sign"></span>Yes
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>No
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="stepconfirmationPlottingDialog" tabindex="-1"
	role="dialog" aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Approve this
					Process</h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-danger">
					<span class="glyphicon glyphicon-warning-sign"></span> Are you sure
					you want to Approve the process?
				</div>

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success"
					id="btn_approve_map_plotting_process"
				>
					<span class="glyphicon glyphicon-ok-sign"></span>Yes
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>No
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="stepreverseconfirmationDialog" tabindex="-1"
	role="dialog" aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Reverse
					Approval of Milestones</h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-danger">
					<span class="glyphicon glyphicon-warning-sign"></span> Are you sure
					you want to Reverse Approval of Milestones?
				</div>

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success"
					id="btn_reverse_approve_registration_process"
				>
					<span class="glyphicon glyphicon-ok-sign"></span>Yes
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>No
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



<div class="modal fade" id="stepconfirmationDialognoRight" tabindex="-1"
	role="dialog" aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">No Right to
					Appove</h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-danger">
					<span class="glyphicon glyphicon-warning-sign"></span> Please you
					donot have the right to approve the process
				</div>

			</div>
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="stepPlottingconfirmation" tabindex="-1"
	role="dialog" aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Approve this
					Process</h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-danger">
					<span class="glyphicon glyphicon-warning-sign"></span> Are you sure
					you want to Approve the process?
				</div>

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success"
					id="btn_approve_plotting_process"
				>
					<span class="glyphicon glyphicon-ok-sign"></span>Yes
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>No
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="final_registration_approval_dialog"
	tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button> -->
				<h4 class="modal-title custom_align" id="Heading">Approve Transaction for this case</h4>
			</div>
			<div class="modal-body">

			
				<form id="frmVerification" autocomplete="off">
					<input type="hidden" id="ta_txt_ta_id" name="ta_txt_ta_id" value="0">
					<input type="hidden" id="ta_txt_type_of_transaction" name="ta_txt_type_of_transaction">
					<input type="hidden" id="ta_txt_business_process_sub_name" name="ta_txt_business_process_sub_name">
					
					<div class="form-row">

						<div class="col">	
							<div class="form-group">
								<label for="bl_job_number">Job #</label> <input
									class="form-control " type="text" placeholder="Enter Phone Number"
									id="ta_txt_job_number" readonly
								>
							</div>
						</div>

						<div class="col">	
							<div class="form-group">
								<label for="bl_job_number">Case #</label> <input
									class="form-control " type="text" placeholder="Enter Phone Number"
									id="ta_txt_case_number" readonly
								>
							</div>
						</div>
						
					</div>
					
					<!-- <div class="form-row"> -->
					 <div class="form-group">
							<label for="bl_ar_name">Message</label>
							<textarea rows="2" columns="2" class="form-control" placeholder=""
								id="ta_txt_transaction_details" readonly
							></textarea>
						 </div> 
					<!-- </div> -->
				
							
							
								<div class="form-row">


									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code1" maxlength="1" required
												autocomplete="off" data-index="3"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code2" maxlength="1"  required
												autocomplete="off" data-index="4"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code3" maxlength="1"  required
												autocomplete="off" data-index="5"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code4" maxlength="1" required
												autocomplete="off" data-index="6"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code5" maxlength="1" required
												autocomplete="off" data-index="7"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="veri_code6" maxlength="1" required
												autocomplete="off" data-index="8"
											>
										</div>
									</div>

								</div>

								
								
								<!-- <br/> <br/> -->
								<div class="clearfix"></div>
							</form>

							<div class="alert alert-danger">
								<span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to Approve this transaction?
							</div>

							

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success"
					id="btn_final_registration_approval_dialog"
				>
					<span class="glyphicon glyphicon-ok-sign"></span>Approve
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="map_plotting_approval_dialog"
	tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button> -->
				<h4 class="modal-title custom_align" id="Heading">Approve Transaction for this case</h4>
			</div>
			<div class="modal-body">

			
				<form id="frmVerification" autocomplete="off">
					<input type="hidden" id="ma_txt_ta_id" name="ma_txt_ta_id" value="0">
					<input type="hidden" id="ma_txt_type_of_transaction" name="ma_txt_type_of_transaction">
					<input type="hidden" id="ma_txt_business_process_sub_name" name="ma_txt_business_process_sub_name">
					
					<div class="form-row">

						<div class="col">	
							<div class="form-group">
								<label for="bl_job_number">Job #</label> <input
									class="form-control " type="text" placeholder="Enter Phone Number"
									id="ma_txt_job_number" readonly
								>
							</div>
						</div>

						<div class="col">	
							<div class="form-group">
								<label for="bl_job_number">Case #</label> <input
									class="form-control " type="text" placeholder="Enter Phone Number"
									id="ma_txt_case_number" readonly
								>
							</div>
						</div>
						
					</div>
					
					<!-- <div class="form-row"> -->
					 <div class="form-group">
							<label for="bl_ar_name">Message</label>
							<textarea rows="2" columns="2" class="form-control" placeholder=""
								id="ma_txt_transaction_details" readonly
							></textarea>
						 </div> 
					<!-- </div> -->
				
							
							
								<div class="form-row">


									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="m_veri_code1" maxlength="1" required
												autocomplete="off" data-index="3"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="m_veri_code2" maxlength="1"  required
												autocomplete="off" data-index="4"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="m_veri_code3" maxlength="1"  required
												autocomplete="off" data-index="5"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="m_veri_code4" maxlength="1" required
												autocomplete="off" data-index="6"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="m_veri_code5" maxlength="1" required
												autocomplete="off" data-index="7"
											>
										</div>
									</div>
									-
									<div class="col">
										<div class="form-group col">
											<input type="text" class="form-control text-center"
												id="m_veri_code6" maxlength="1" required
												autocomplete="off" data-index="8"
											>
										</div>
									</div>

								</div>

								
								
								<!-- <br/> <br/> -->
								<div class="clearfix"></div>
							</form>

							<div class="alert alert-danger">
								<span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to Approve this transaction?
							</div>

						
							

			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-success"
					id="btn_map_plotting_approval_dialog"
				>
					<span class="glyphicon glyphicon-ok-sign"></span>Approve
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



<div class="modal fade" id="general_message_dialog" tabindex="-1"
	role="dialog" aria-labelledby="edit" aria-hidden="true" style="z-index:10000000"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">LCELIS
					Message</h4>
			</div>
			<div class="modal-body">

				<!-- 	<div class="alert alert-danger" id="general_message_dialog_msg">
				</div>
 -->

				<div class="form-group">
					<label for="bl_ar_name">Message</label>
					<textarea rows="4" class="form-control" placeholder=""
						id="general_message_dialog_msg_new" readonly
					></textarea>
				</div>

			</div>
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<!-- Extra large modal -->


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="lrdparcelIndormation" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">LRD
					Transaction Informations</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				<div class="container">
					<div class="row">
						<div class="col">


							<div class="form-group">
								<label for="bl_job_number">Reference Number</label> <input
									class="form-control " type="text" placeholder=""
									id="lrd_ps_reference_number"
								>
							</div>


							<div class="form-group">
								<label for="bl_ar_name">Locality</label> <input
									class="form-control " type="text" placeholder=""
									id="lrd_ps_locality"
								>
							</div>

							<div class="form-group">
								<label for="bl_business_process_sub_name">Plotted By</label> <input
									class="form-control " type="text" placeholder=""
									id="lrd_ps_plotted_by"
								>
							</div>


							<div class="form-group">
								<label for="bl_job_number">Date Plotted</label> <input
									class="form-control " type="text" placeholder=""
									id="lrd_ps_date_plott"
								>
							</div>


							<div class="form-group">
								<label for="bl_ar_name">Checked By</label> <input
									class="form-control " type="text" placeholder=""
									id="lrd_ps_checked_by"
								>
							</div>

							<div class="form-group">
								<label for="bl_business_process_sub_name">Type of
									Plotting</label> <input class="form-control " type="text"
									placeholder="" id="lrd_ps_type_of_plotting"
								>
							</div>

									<div class="form-row">
										<div class="col">
											<label for="bl_business_process_sub_name">Last Update By</label> <input
												class="form-control " type="text" placeholder=""
												id="lrd_ps_modified_by" readonly
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Date Last Updated</label> <input
														class="form-control " type="text" placeholder=""
														id="lrd_ps_modified_date" readonly
													>
										</div>
										
										
										
									</div>



						</div>
						<div class="col">
							<div class="btn-group" role="group"
								aria-label="Vertical button group"
							>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fa fa-plus-circle"></span>
								</button>
								<button type="button" class="btn btn-primary btn-sm"
									data-toggle="modal" data-target="#addlrdtransaction"
								>Add New Transaction</button>

							</div>


							<div class="form-group">
								<div class="table w-auto small">
									<table class="table table-bordered"
										id="lrd_transaction_dataTable" width="100%" cellspacing="0"
									>

										<thead>
											<tr>

												<th>Name</th>
												<th>Grantor</th>
												<th>Certificate Number</th>
												<th>Instrument Type</th>
												<th>Details</th>
											</tr>
										</thead>

										<tbody>

										</tbody>
										<!--  <tfoot>
                <tr>
                  <th>Job Number</th>
                  <th>Applicant Name</th>
                  <th>Status</th>
                  <th>Case Details</th>
                      
                       <th>Add To List</th>
                </tr>
              </tfoot> -->

									</table>
								</div>
							</div>
							
							Encumbrance and Caveat
							<br>
							<div class="btn-group" role="group"
								aria-label="Vertical button group"
							>
								
								<button type="button" class="btn btn-primary btn-sm"
									data-toggle="modal" data-target="#lrdpEncumbranceModal"
								>Add New Encumbrance or Caveat</button>

							</div>
					<div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_memorial_encumbrance_details_dataTable" >
			           
			              <thead>
			                <tr>
			
			                 <th>Registered_no</th>
			                 <th>Memorials</th>
			                 <th>Date of Instrument</th>
			                 <th>Date of Registration</th>
			                 <th>Details</th>
			                
			                 </tr>
			              </thead>
			              
			                <tbody>
						     <c:forEach items="${lrd_memorials_section}" var="memorials_section">
				                <tr>
				                    <td>${memorials_section.m_registered_no}</td>
				                    <td>${memorials_section.m_memorials}</td>
				                    <td>${memorials_section.m_date_of_instrument}</td>
				                    <td>${memorials_section.m_date_of_registration}</td>
				                    <td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${memorials_section.mid}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p></td>
				            
                     
                    
                    </tr>
          				  </c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>


							<div class="form-group">
								<div class="table w-auto small">
									<table class="table table-bordered"
										id="lrd_scanned_documents_dataTable" width="100%"
										cellspacing="0"
									>

										<thead>
											<tr>

												<th>Document Name</th>
												<th>Document Type</th>
												<!-- <th>Document Path</th>
												<th>Open File</th> -->
											</tr>
										</thead>

										<tbody>

										</tbody>
										<!--  <tfoot>
                <tr>
                  <th>Job Number</th>
                  <th>Applicant Name</th>
                  <th>Status</th>
                  <th>Case Details</th>
                      
                       <th>Add To List</th>
                </tr>
              </tfoot> -->

									</table>
								</div>
							</div>


						</div>
					</div>

				</div>



			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

								<!-- <button type="button" class="btn btn-danger to_hide_on_level_1"  id="lrd_tr_btn_delete_parcel">
										<span class="glyphicon glyphicon-remove"></span>Delete
									</button> -->

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				<input type="hidden" id="lrd_ps_fid" name="lrd_ps_fid">
			</div>

		</div>
	</div>
</div>



<!-- Add LRD Transaction -->


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="addlrdtransaction" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">LRD
					Transaction Informations</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">



			<!-- 	<form method="POST" action="Maps" target="_blank" id="downloadForm">
			
				<input type="hidden" name="request_type" id="request_type"
						value="lrd_add_update_transaction"
					> 
			
			 -->	
			 
			 <input type="hidden" name="lrd_td_gid"
						id="lrd_td_gid"
					>
			 
			 <input type="hidden" name="lrd_td_fid_id_fk"
						id="lrd_td_fid_id_fk"
					> <input type="hidden" id="lrd_td_gid" name="lrd_td_gid">
					<input type="hidden" id="lrd_td_plotted_by_reg"
						name="lrd_td_plotted_by_reg"
					> <input type="hidden" id="lrd_td_checked_by"
						name="lrd_td_checked_by"
					> <input type="hidden" id="lrd_td_plott_date_reg"
						name="lrd_td_plott_date_reg"
					>



					<div class="container">
						<div class="row">
							<div class="col">


								<div class="form-group">
									<label for="bl_job_number">Nature of Instrument</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_nature_of_instument"
										name="lrd_td_nature_of_instument"
									>
								</div>


								<div class="form-group">
									<label for="bl_ar_name">Date of Registration</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_date_of_registration"
										name="lrd_td_date_of_registration"
									>

								</div>

								<div class="form-group">
									<label for="bl_business_process_sub_name">Volume</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_volume" name="lrd_td_volume"
									>
								</div>



								<div class="form-group">
									<label for="bl_business_process_sub_name">Folio</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_folio" name="lrd_td_folio"
									>
								</div>


								<div class="form-group">
									<label for="bl_job_number">Date of Issue certificate No</label>
									<input class="form-control " type="text" placeholder=""
										id="lrd_td_date_of_issued_cert_no"
										name="lrd_td_date_of_issued_cert_no"
									>
								</div>


								<div class="form-group">
									<label for="bl_ar_name">Type of Certificate</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_type_of_certificate"
										name="lrd_td_type_of_certificate"
									>
								</div>

								<div class="form-group">
									<label for="bl_business_process_sub_name">Registered No</label>
									<input class="form-control " type="text" placeholder=""
										id="lrd_td_registered_number" name="lrd_td_registered_number"
									>
								</div>




							</div>



							<!--  Second Column-->

							<div class="col">

								<div class="form-group">
									<label for="bl_job_number">CC Number</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_cc_number" name="lrd_td_cc_number"
									>
								</div>


								<div class="form-group">
									<label for="bl_ar_name">Certificate NUmber</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_certicate_number" name="lrd_td_certicate_number"
									>

								</div>

								<div class="form-group">
									<label for="bl_business_process_sub_name">Applicant
										Name</label> <input class="form-control " type="text" placeholder=""
										id="lrd_td_applicant_name" name="lrd_td_applicant_name"
									>
								</div>





								<div class="form-group">
									<label for="bl_business_process_sub_name">Grantor Name</label>
									<input class="form-control " type="text" placeholder=""
										id="lrd_td_grantor_name" name="lrd_td_grantor_name"
									>
								</div>


								<div class="form-group">
									<label for="bl_job_number">Job Number</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_job_number" name="lrd_td_job_number"
									>
								</div>


								<div class="form-group">
									<label for="bl_ar_name">Type of Instrument</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_type_instrument" name="lrd_td_type_instrument"
									>
								</div>

								<div class="form-group">
									<label for="bl_business_process_sub_name">Date of
										Instrument</label> <input class="form-control " type="text"
										placeholder="" id="lrd_td_date_of_instument"
										name="lrd_td_date_of_instument"
									>
								</div>

								<div class="form-group">
									<label for="bl_job_number">Consideration</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_consideration" name="lrd_td_consideration"
									>
								</div>

							</div>



							<!-- Third Column -->
							<div class="col">





								<div class="form-group">
									<label for="bl_ar_name">Purpose</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_purpose" name="lrd_td_purpose"
									>

								</div>

								<div class="form-group">
									<label for="date_commencement">Date Commencement</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_date_commencement" name="lrd_td_date_commencement"
									>
								</div>



								<div class="form-group">
									<label for="bl_business_process_sub_name">Term</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_term" name="lrd_td_term"
									>
								</div>


								<div class="form-group">
									<label for="bl_job_number">Remarks</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_remarks" name="lrd_td_remarks"
									>
								</div>


								<div class="form-group">
									<label for="bl_ar_name">Type of Registration</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_type_of_registration"
										name="lrd_td_type_of_registration"
									>
								</div>
								
									<div class="form-group">
									<label for="bl_ar_name">Land Size</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_land_size"
										name="lrd_td_land_size"
									>
								</div>

								<div class="form-group">
									<label for="bl_ar_name">Reference Number</label> <input
										class="form-control " type="text" placeholder=""
										id="lrd_td_reference_number" name="lrd_td_reference_number"
										readonly
									>
								</div>

								<div class="form-row">
										<div class="col">
											<label for="bl_business_process_sub_name">Last Update By</label> <input
												class="form-control " type="text" placeholder=""
												id="lrd_td_modified_by" readonly
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Date Last Updated</label> <input
														class="form-control " type="text" placeholder=""
														id="lrd_td_modified_date" readonly
													>
										</div>
								</div>
								
								<!--       <div class="form-group">
						          <label for="bl_business_process_sub_name">Plan Number</label>
						        <input class="form-control " type="text" placeholder="" id="lrd_td_plan_number" name="lrd_td_encumbrance">
						         </div>
						         
						           <div class="form-group">
						          <label for="bl_business_process_sub_name">Encumbrance</label>
						        <input class="form-control " type="text" placeholder="" id="lrd_td_encumbrance" name="lrd_td_encumbrance">
						        
						        </div> -->

								<div class="form-group">


									<!-- <button type="button" class="btn btn-primary">Save
										Data</button>
										 -->
										
										<button class="btn btn-primary btn-block" id="btn_save_lrd_transaction">
												<span class="text" >Save Data</span>
										</button>
										
								</div>


							</div>


						</div>

					</div>

				<!-- </form> -->

			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>


			</div>

		</div>
	</div>
</div>



<!-- Add Coordinates Modal -->

<div class="modal fade" id="lrdparcelinformationdetailsmain" tabindex="-1"
	role="dialog" aria-labelledby="addcoordinatetoplot" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">LRD Parcel Info</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Name </label> <input
						class="form-control " type="text" placeholder=""
						id="bl_coordiante_name1"
					>
				</div>


				<div class="form-group">
					<label for="bl_ar_name">X-Coordinate</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_X_coordinate"
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Y-Coordinate</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_y_coordinate"
					></textarea>
				</div>


				<div class="form-group">
					<label for="bl_job_number">Name </label> <input
						class="form-control " type="text" placeholder=""
						id="bl_coordiante_name2"
					>
				</div>


					<div class="form-group">
								<label for="bl_parcelwkt">Parcel WKT</label> <input
									class="form-control " type="text" placeholder=""
									id="lrd_parcel_wkt_main"
								>
					</div>



			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnsavelrdparcelmain"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Save </span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>



			

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>




<!-- Add Coordinates Modal -->

<div class="modal fade" id="addcoordinatetoplot" tabindex="-1"
	role="dialog" aria-labelledby="addcoordinatetoplot" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add
					Coordinate List</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Name </label> <input
						class="form-control " type="text" placeholder=""
						id="ac_coordinate_name"
					>
				</div>


				<div class="form-group">
					<label for="bl_ar_name">X-Coordinate</label>
									
					<input
						class="form-control " type="text" placeholder=""
						id="ac_x_coordinate"
					>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Y-Coordinate</label>
					<input
						class="form-control " type="text" placeholder=""
						id="ac_y_coordinate"
					>
					
				</div>





			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btnaddcoordinatelist"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Add </span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


			<!-- 	<input type="hidden" id="bl_coordinate_id" name="bl_coordinate_id"> -->

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



<!-- Add Coordinates Modal -->

<div class="modal fade" id="uploadcoordiantecsv" tabindex="-1"
	role="dialog" aria-labelledby="uploadcoordiantecsv" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Upload
					Coordinate</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<fieldset>
						<input type="file" name="File Upload"
							id="txtFileUploaduploadcoordiantecsv" accept=".csv"
						/>
					</fieldset>
				</div>







			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btn-uploadcoordiantecsv"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Upload </span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


				<input type="hidden" id="bl_coordinate_id" name="bl_coordinate_id">

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



<!-- View Completed and Queried============================= -->
<div class="modal fade" id="viewCompletedQueriedModal" tabindex="-1"
   role="dialog" aria-labelledby="viewCompletedQueriedModal" aria-hidden="true">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="viewBatchlistModalLabel">Completed & Queried Application List</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         </div>
         <div class="modal-body modal-body_lg">
            <form >
               
               
               <br/>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                        <table id="completedQueriedListdataTable"
                           class="table table-bordered table-hover"></table>
                     </div>
                  </div>
               </div>
               <br/> <br/> <br/>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary"
                     data-dismiss="modal">Close</button>
                     
                     <button type="button"  id="btn_print_completed_queried_list" class="btn  btn-primary btn-icon-split "  >
		    			<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Print List</span>
		    		</button>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>





<!-- View Batchlist============================= -->
<div class="modal fade" id="viewBatchlistModal" tabindex="-1"
   role="dialog" aria-labelledby="viewBatchlistModal" aria-hidden="true">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="viewBatchlistModalLabel">Batch List Processing</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         </div>
         <div class="modal-body modal-body_lg">
         
          <input id="lbl_batch_type" name="lbl_batch_type" type="hidden" value="normal">
           
               <%-- <input id="bl_modified_by" name="bl_modified_by" type="hidden" value="${fullname}"> 
               <input id="bl_modified_by_id" name="bl_modified_by_id" type="hidden" value="${userid}"> --%>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                     
                     	<div class="form-group row">
							
							<div class='${unit_name == "CSAU" ? "col-sm-5" : "col-sm-4"}'>
							<label class="col-form-label" style="text-align: right"><h2>Batch To :</h2></label>
								<div class="input-group">
									<div id="radioBtnBatching" class="btn-group ">
										<a class="btn btn-primary btn-sm notActive" data-toggle="batch_type" data-title="Unit"><h2>Unit</h2></a> 
										<a class="btn btn-primary btn-sm notActive" data-toggle="batch_type" data-title="Individual"><h2>Individual</h2></a>
										${unit_name == "CSAU" ? "<a class='btn btn-primary btn-sm notActive' data-toggle='batch_type' data-title='Cabinet'><h2>Cabinet</h2></a>" : unit_name == "CORPORATE CSAU UNIT" ? "<a class='btn btn-primary btn-sm notActive' data-toggle='batch_type' data-title='Cabinet'><h2>Cabinet</h2></a>" : ""}
										
										
									</div>
									<input type="hidden" name="batch_type" id="batch_type">
								</div>
							</div>
							<div class="col">
								<div class="form-row unit-batching" id="unit-batching" style="background-color:#123456; padding:15px; display:none">
									<div class="col-12"><h4 style="" class="text-white">Batching to a Unit</h4></div>
								    <div class="col">
								      <label for="" class="col-form-label">Division :</label>
		                              <select id="unit_division_to_send_to" class="form-control" >
		                                 <option value="none">---Select Division---</option>
		                                 <!-- ${division == "CORPORATE" ? "" : "<option value='LVD'>LVD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='LRD'>LRD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='PVLMD'>PVLMD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='SMD'>SMD</option>"}
		                                 ${division == "CORPORATE" ? "" : "<option value='RLO'>RLO</option>"}
										 ${division == "CORPORATE" ? "<option value='CORPORATE'>CORPORATE</option>" : ""} -->
										 <option value='LVD'>LVD</option>
		                                 <option value='LRD'>LRD</option>
		                                 <option value='PVLMD'>PVLMD</option>
		                                <option value='SMD'>SMD</option>
		                                 <option value='RLO'>RLO</option>
										 <option value='CORPORATE'>CORPORATE</option>
		                              </select>
								      
								    </div>
								    <div class="col">
								    <label for="" class="col-form-label">Unit :</label>
								      <input autocomplete="off" class="form-control" id="unit_to_send_to"  type="text"  list="listofunitsbatching" class=""  placeholder="Select/Enter Unit" required  >
		                              <datalist id="listofunitsbatching"></datalist>
								    </div>
								</div>
								
								<div class="form-row individual-batching"  style="background-color:#654321; padding:15px; display:none" id="individual-batching" >
		                           <div class="col-12"><h4 style="" class="text-white">Batching to an Individual</h4></div>
		                           <div class="col-sm-3">
		                              <label for="" class="col-form-label text-light">Division/Unit :</label>
		                              <!-- <select id="division_to_send_to" class="form-control" >
		                                 <option value="none">---Select Division---</option>
		                                 <option value="CSAU">CSAU</option>
		                                 <option value="LVD">LVD</option>
		                                 <option value="LRD">LRD</option>
		                                 <option value="PVLMD">PVLMD</option>
		                                 <option value="SMD">SMD</option>
		                                   <option value="RLO">RLO</option>
		                              </select> -->
		                              <input class="form-control" type="text" value="${unit_name}" id="division_to_send_to" readonly>
		                           </div>
		                           <div class="col-sm-9">
		                              <label for="" class="col-form-label text-light">User :</label>
		                              <!-- <select id="user_to_send_to" class="form-control" >
		                                 </select> -->
		                              <input class="form-control" id="user_to_send_to"  name="user_to_send_to" type="text" autocomplete="off" 
		                                 list="listofusersbatching" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
		                              <datalist id="listofusersbatching"></datalist>
		                           </div>
		                        </div>
		                        <form id="frmBatchToCabinet">
		                        <div class="form-row"  style="background-color:#32a852; padding:15px; display:none " id="cabinet-batching" >
		                           <div class="col-12"><h4 style="" class="text-white">Batching to Cabinet</h4></div>
		                           
			                           <div class="col-auto">
			                              <label for="" class="col-form-label text-light">Cabinet Name :</label>
			                              
			                              <input class="form-control" type="text"  id="cabinet_to_send_to" required>
			                           </div>
			                           <div class="col-sm-4">
			                              <label for="" class="col-form-label text-light">&nbsp;</label>
			                              <!-- <select id="user_to_send_to" class="form-control" >
			                                 </select> -->
			                              <button class="form-control btn btn-primary" type="Submit" >Batch to Cabinet</button>
			                             
			                           </div>
		                           
		                        </div>
								</form>
								
							  &nbsp;
							</div>
						</div>
                     	
                        
                        
                     </div>
                  </div>
               </div>
               <br/>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                        <table id="batchlistdataTable"
                           class="table table-bordered table-hover"></table>
                     </div>
                  </div>
               </div>
               <br/> <br/> <br/>
               <div class="modal-footer">
               		<button type="button" class="btn btn-dark float-left  mr-auto" id="btn_clear_all_batchlist">Remove all from list</button>
               		<!-- <button type="button" class="btn btn-dark float-left  mr-auto" id="btn_sent_for_frrv_batchlist">Sent For FRRV</button> -->
                  <button type="button" class="btn btn-secondary"
                     data-dismiss="modal">Close</button>
                  <button type="button" id="btn_process_batchlist"  class="btn btn-primary" style="display:none">Process Batch List</button>
               </div>
            
         </div>
      </div>
   </div>
</div>


<!-- Change Name After Payments  modals============================= -->
<div class="modal fade" id="changeOfNamesModal" tabindex="-1"
   role="dialog" aria-labelledby="changeOfNamesModal" aria-hidden="true">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="changeOfNamesModalLabel">Batch List Processing</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         </div>
         <div class="modal-body modal-body_lg">
           
               <%-- <input id="bl_modified_by" name="bl_modified_by" type="hidden" value="${fullname}"> 
               <input id="bl_modified_by_id" name="bl_modified_by_id" type="hidden" value="${userid}"> --%>
               
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                        <table id="batchlistdataTable"
                           class="table table-bordered table-hover"></table>
                     </div>
                  </div>
               </div>
               <br/> <br/> <br/>
               <div class="modal-footer">
               		<button type="button" class="btn btn-dark float-left  mr-auto" id="btn_clear_all_batchlist">Remove all from list</button>
                  <button type="button" class="btn btn-secondary"
                     data-dismiss="modal">Close</button>
                  <button type="button" id=""  class="btn btn-primary" style="display:none">Process Batch List</button>
               </div>
            
         </div>
      </div>
   </div>
</div>


<!-- Add File Upload============================= -->
<div class="modal fade" id="fileUploadModal" tabindex="-1" role="dialog"
	aria-labelledby="fileUploadModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="fileUploadModalLabel">Upload File</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			
			
				<div class="d-flex justify-content-between">
					<label for="file">Document on Case File:</label>
					<a href="#!" class="text-right" id="addOCFile">Add More</a>
				</div>
				<div class="card card-body fileUpload" id="ocfileContainer">	
			 <form class="form-horizontal" method="POST" enctype="multipart/form-data" id="id_form">
			    
			    <input id="fileUploadForm" class="form-control" type="file" name="sampleFile" />
				<a href="#" class="ocPreviewBtn mb-3" style="text-decoration: underline;">Preview PDF</a>
			  
			</form>
			</div>
			<label for="query_case_number" class="col-form-label">Case
				Number</label> <input type="text" name="file_upload_case_number"
							id="file_upload_case_number" class="form-control" required readonly value="${case_number}"
						>
			<input type="button" id="btn_upload_case_file"
						class="btn btn-primary" value="Click to upload"
		>
			
			
			
			
		<%-- 	
				<form method="POST" enctype="multipart/form-data" id="fileUploadForm" name="fileUploadForm">
					<div class="row">
						<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
							<div class="form-group">
								<label for="query_case_number" class="col-form-label">Case
									Number</label> <input type="text" name="file_upload_case_number"
									id="file_upload_case_number" class="form-control" required readonly value="${case_number}"
								>
							</div>
						</div>
				

					</div>
					<div class="row">
						<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
							<input type="file" name="files" id="files"
								class="form-control" required
							>
						</div>
						
						
						
    				
						
						<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
							<input type="submit" id="btn_upload_case_file"
								class="btn btn-primary" value="Click to upload"
							>
							
							
							<br/>
							<br/>
						</div>
					</div>
					
					</form> --%>
					
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal"
						>Close</button>
					</div>
				
				
				
			</div>
		</div>
	</div>


	
<!-- Add File Upload============================= -->
<div class="modal fade" id="publicFileUploadModal" tabindex="-1" role="dialog" aria-labelledby="publicFileUploadModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="fileUploadModalLabel">Upload Public Document</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
				<label for="query_case_number" class="form-label">Type of Document: <span class="text-danger">*</span></label> 
								 <!-- <input type="text" name="file_name_pu"
								 id="file_name_pu" class="form-control mb-3" required 
							 > -->

							 <select name="file_name_pu"
							 id="file_type_pu" class="form-control mb-3" required >
							 <option value="" selected disabled>-- select one --</option>
							 <option value="Acknowledge Slip">Acknowledge Slip</option>
							 <option value="Birth Certificate">Birth Certificate</option>
							 <option value="Company Certificate">Company Certificate</option>
							 <option value="Consent Letter">Consent Letter</option>
							 <option value="Headlease">Headlease</option>
							 <option value="Identification Card">Identification Card</option>
							 <option value="Indenture">Indenture</option>
							 <option value="Judgement">Judgement</option>
							 <option value="Letters of Administration">Letters of Administration</option>
							 <option value="Plotted Indenture">Plotted Indenture</option>
							 <option value="Power of Attorney">Power of Attorney</option>
							 <option value="Receipts">Receipts</option>
							 <option value="Site Plan">Site Plan</option>
							 <option value="Statutory Declaration">Statutory Declaration</option>
							 <option value="Hatched Site Plan">Hatched Site Plan</option>
							 <option value="Others">Others</option>
							 </select>

                <div class="d-flex justify-content-between">
                    <label for="file">Public File:</label>
                    <a href="#!" class="text-right" id="addFile">Add More</a>
                </div>
                <div class="card card-body fileUpload" id="fileContainer">    
                    <form class="form-horizontal" method="POST" enctype="multipart/form-data" id="id_form_public">
                        <input id="publicFileUploadForm" class="form-control" type="file" name="samplePublicFile" />
                        <a href="#" class="previewBtn mb-3" style="text-decoration: underline;">Preview PDF</a>
                        <br/>
                    </form>
                </div>
                <label for="query_case_number" class="col-form-label">Case Number</label> 
                <input type="text" name="public_file_upload_case_number" id="public_file_upload_case_number" class="form-control fileUpload mb-2" required readonly value="${case_number}">
                <input type="button" id="btn_upload_public_case_file" class="btn btn-primary" value="Click to upload Public Document">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="publicViewFileModal" tabindex="-1" role="dialog"
	aria-labelledby="publicViewFileModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="fileUploadModalLabel">View Public Document</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			
			<input type="hidden" id="cs_main_case_number">
			
			<button type="button" class="btn btn-primary" id="btn_load_scanned_documents_public" data-placement="top"  title="Load Docs">
				<i class="fas fa-eye"></i> View
			</button>
			
			
			<div  class="table-responsive">
			<table class="table table-bordered  table-hover table-sm" id="lc_public_documents_dataTable" width="100%" class="display" cellspacing="0">
			
				<thead>
					<tr>

					<th>Document Name</th>
					<th>Document Type</th>
				</tr>
				</thead>
				
					<tbody>				
					<!-- <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
					<tr>
						<td>${casescanneddocuments_row.document_name}</td>
						<td>${casescanneddocuments_row.document_type}</td>
							<td>
								<form action="registration_application_progress_details" method="post">
									<input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
										<button type="submit" name="save" class="btn btn-info btn-icon-split" >
										<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Open</span>
										</button>
								</form>
							</td>

						</tr>
						</c:forEach> -->
					</tbody>
		
				
				</table>
			</div>
			
			
		
					
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal"
						>Close</button>
					</div>
				
				
				
			</div>
		</div>
	</div>


	
	
		
<!--  Service Bill============================= -->
<div class="modal fade" id="addNewserviceBillModal" tabindex="-1"
	role="dialog" aria-labelledby="newValuationModalLabel"
	aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addNewserviceBillModal">New Service
					Bill</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- <form id="from_add_valuation"> -->

			<%-- 	<input id="action_on_form_valuation" type="hidden"> <input
					type="hidden" id="main_service_id" name="main_service_id"
					value="${main_service_id}"
				> <input type="hidden" id="main_service_sub_id"
					name="main_service_sub_id" value="${main_service_sub_id}"
				> <input type="hidden" id="request_type" name="request_type"
					value="process_online_select_bill_for_registration"
				> --%>


    
				      		

				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="main_service_desc">Main Service</label> 
							 <select name="main_service_cp" id="main_service_cp" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                
                </select>
						</div>
						<div class="col-md-6">
							<label for="main_service_sub_desc">Sub Service</label>
							 <select name="sub_service_cp" id="sub_service_cp" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  
                </select>
						</div>
					</div>
				</div>
				
				
		


				<div id="checksigs-no-div" style="display: none">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-3">
								<label for="new_bill_application_ls_number">Surveyor's
									Number</label> <input class="form-control"
									id="new_bill_application_ls_number" name="ls_number"
									type="text" aria-describedby="nameHelp" required
								>
							</div>
							<div class="col-md-1">
								<label for="new_bill_application_ls_number">-</label>
								<!--  <input type="button" id="lc_btn_check_status_of_lincense_surveyor" class="btn btn-primary btn-block" value="C" /> -->
								<button type="button" class="btn btn-primary pull-right"
									style="margin-bottom: 5px"
									id="lc_btn_check_status_of_lincense_surveyor"
									data-placement="top" data-toggle="tooltip"
									title="Search for Surveyor"
								>
									<i class="fa fa-search"></i>
								</button>
							</div>
							<div class="col-md-8">
								<label for="qty">Surveyor's Name</label> <input
									class="form-control" id="new_bill_application_surveyors_name"
									name="new_bill_application_surveyors_name" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>
						</div>
					</div>


					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="new_bill_application_ls_number">Surveyor's
									Status</label> <input class="form-control"
									id="new_bill_application_surveyors_status"
									name="new_bill_application_surveyors_status" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>
							<!-- <div class="col-md-6">
                <label for="qty">Quantity Required</label>
                <input class="form-control" id="new_bill_application_qty" name="new_bill_application_qty"  type="number" min="0" step="1"aria-describedby="nameHelp" placeholder="Enter Quantity" required>
              </div> -->
						</div>
					</div>

				</div>

				<div class="row">
					<div class="col-lg-8">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>${main_service_desc} Check List
							</div>
							<div class="card-body">



								<!--  Here is where the fee list comes -->

								<div class="table-responsive">
									<table class="table table-bordered"
										id="new_checlist_table_billdataTable" width="100%"
										cellspacing="0"
									>
										<thead>
											<tr>
												<th>Description</th>
												<th>Option</th>

											</tr>
										</thead>
										<tfoot>
											<tr>
												<th>Description</th>
												<th>Option</th>
											</tr>
										</tfoot>
										<tbody>



										</tbody>
									</table>
								</div>

								<!--  End Of Table -->
							</div>
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>


				<div class="form-group">
					<div class="form-row">
						
						
						
						<div class="col-md-6">

							<label for="client_name">Client Name</label> <input
							class="form-control" id="new_bill_application_client_name"
							name="new_bill_application_client_name" type="text"
							aria-describedby="nameHelp" placeholder="Enter Client Name"
							required readonly
						>
						
						</div>
							
							<div class="col-md-6">

								<label for="client_name">Client Ref</label> 
								<input class="form-control" id="new_bill_application_client_id"
							name="new_bill_application_client_id" type="text"
							aria-describedby="nameHelp" placeholder="Enter Client Name"
							required readonly
						>
							</div>
					</div>
				</div>




				<div id="reg-no-div" style="display: none">






					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="gender">Gender</label> <select
									name="new_bill_application_gender"
									id="new_bill_application_gender" class="form-control input-sm"
									data-style="btn-info" data-live-search="true"
								>
									<option value="-1">Select Gender</option>
									<c:forEach items="${genderlist}" var="gender">
									<option value="${gender.gender_name}">${gender.gender_name}</option>
						 		 </c:forEach>
						  
									
									<option value="Male">Male</option>
								<option value="Female">Female</option>
								
								<option value="Couple">Couple</option>
								<option value="Company">Company</option>
								<option value="Multiple">Multiple</option>
								</select>

							</div>

						</div>
					</div>


					<div class="form-group">
						<div class="form-row">

							<div class="col-md-6">
								<label for="region">Region</label> 
								<select
									name="new_bill_application_region"
									id="new_bill_application_region" class="form-control input-sm"
									data-style="btn-info" data-live-search="true"
								>
									<option value="-1">Select Region</option>
									<c:forEach items="${regionlist}" var="region">
										<option  value="${region.region_id}">${region.region_name}</option>
							  </c:forEach>
								</select>

							</div>

							<div class="col-md-6">
								<label for="disitrict">District</label> <select
									name="new_bill_application_district"
									id="new_bill_application_district"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select District</option>
									
								</select>

							</div>

						</div>
					</div>



				</div>


					<div class="form-group">
						<div class="form-row">

							<div class="col-md-6">
								<label for="locality">Office Region</label> <select
									name="new_bill_application_office_region"
									id="new_bill_application_office_region"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select Office Region</option>
						
									<c:forEach items="${officeregionlist}" var="officeregion">
										<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
							  </c:forEach>
			 
								</select>

							</div>
						</div>
					</div>



				<div id="selectlocality-no-div" style="display: none">
					<div class="form-group">
						<div class="form-row">

							<div class="col-md-6">
								<label for="locality">Locality</label> <select
									name="new_bill_application_locality"
									id="new_bill_application_locality"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select Locality</option>
									<c:forEach items="${localitylist}" var="locality">
										<option  value="${locality.locality_name}">${locality.locality_name}</option>
							 </c:forEach>
			 
								</select>

							</div>
						</div>
					</div>
				</div>



				<div id="stp-no-div" style="display: none">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">

								<label for="client_name">Number of Copies</label> <input
									class="form-control" id="new_number_of_copies"
									name="new_number_of_copies" type="text"
									aria-describedby="nameHelp" placeholder="Enter No of Copies"
									required
								>
							</div>
							<div class="col-md-6">
								<label for="new_type_of_revenue_item">Type of Revenue
									Item</label> <select name="new_type_of_revenue_item"
									id="new_type_of_revenue_item" class="form-control input-sm"
									data-style="btn-info" data-live-search="true"
								>
									<option value="-1">Select Type of Revenue</option>
									<!-- <c:forEach items="${lvdrevenuelist}" var="lvdrevenue">
										<option  value="${lvdrevenue.rv_item_id}-${lvdrevenue.revenue_items_name}">${lvdrevenue.revenue_items_name}</option>
							 </c:forEach> -->
									
								</select>

							</div>
						</div>
					</div>
				</div>



				<div id="fsearches-no-div" style="display: none">

					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">

								<label for="client_name">Land Size(Acres)</label> <input
									class="form-control" id="new_bill_land_size"
									name="new_bill_land_size" type="text"
									aria-describedby="nameHelp" placeholder="Enter land Size"
									value="0.00" required
								>
							</div>
							<div class="col-md-6">
								<label for="new_bill_type_of_use">Type of Use</label> <select
									name="type_of_use" id="new_bill_type_of_use"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select Type of Use</option>

								</select>

							</div>
						</div>
					</div>



				</div>



				<div id="freg-no-div" style="display: none">


					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="registration_forms">Forms</label> <select
									name="new_bill_registration_forms"
									id="new_bill_registration_forms" class="form-control input-sm"
									data-style="btn-info" data-live-search="true"
								>
									<option value="-1">Select Registration Forms</option>

								</select>

							</div>
							<div class="col-md-6">

								<label for="publication_type">Publication Type</label> <select
									name="new_bill_publication_type" id="new_bill_publication_type"
									data-live-search="true"
									data-none-results-text="I found no results"
									title="Please select fruit" class="form-control selectpicker"
								>
									<option value="normal_publication">Normal Publication</option>
									<option value="special_publication">Special
										Publication</option>
								</select>

							</div>
						</div>
					</div>
				</div>
				
				
				
				

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal"
					>Close</button>
					<button type="button"
						id="btn_save_to_generate_new_bill_not_on_case"
						class="btn btn-primary"
					>Generate Bill</button>
				</div>
				<!-- </form> -->
			</div>
		</div>
	</div>
</div>




<!-- Add Coordinates Modal -->

<div class="modal fade" id="lrdtransactionapprovalmodal" tabindex="-1"
	role="dialog" aria-labelledby="lrdtransactionapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Transaction Approval Confirmation</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Case Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_case_number"
					>
				</div>


				<div class="form-group">
					<label for="lbl_proprietor">Proprietor's Name</label>
									
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_proprietor"
					>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Nature of Instrument</label>
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_nature_of_instrument"
					>
					
				</div>

			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btn_lrd_transaction_approval"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Send for Approval</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>




<!-- Add Coordinates Modal -->

<div class="modal fade" id="lrdcertificateapprovalmodal" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Certificate Approval Confirmation</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Case Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_case_number"
					>
				</div>
				
				<div class="form-group">
					<label for="bl_job_number">Job Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_job_number"
					>
				</div>


				<div class="form-group">
					<label for="lbl_ca_proprietor">Applicant's Name</label>
									
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_ar_name"
					>
				</div>

				<!-- <div class="form-group">
					<label for="bl_business_process_sub_name">Cerficate Number</label>
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_certificate_number"
					>
					
				</div> -->

			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btn_lrd_ca_certificate_approval"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Send for Approval</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="pvlmdsearchapprovalmodal" tabindex="-1"
	role="dialog" aria-labelledby="pvlmdsearchapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Search Approval Confirmation</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Case Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_cs_case_number"
					>
				</div>
				
				<div class="form-group">
					<label for="bl_job_number">Job Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_cs_job_number"
					>
				</div>


				<div class="form-group">
					<label for="lbl_cs_proprietor">Applicant's Name</label>
									
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_cs_ar_name"
					>
				</div>

				<!-- <div class="form-group">
					<label for="bl_business_process_sub_name">Cerficate Number</label>
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_certificate_number"
					>
					
				</div> -->

			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btn_pvlmd_search_approval"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Send for Approval</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_cs_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="lrdcertificateapprovalmodal_" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Certificate Approval Confirmation</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Case Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_case_number_"
					>
				</div>
				
				<div class="form-group">
					<label for="bl_job_number">Job Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_job_number_"
					>
				</div>


				<div class="form-group">
					<label for="lbl_ca_proprietor">Applicant's Name</label>
									
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_ar_name_"
					>
				</div>

				<!-- <div class="form-group">
					<label for="bl_business_process_sub_name">Cerficate Number</label>
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_certificate_number"
					>
					
				</div> -->

			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btn_lrd_ca_certificate_approval_"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Send for Approval</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_ca_transaction_id_" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="lrdencumbranceapprovalmodal" tabindex="-1"
	role="dialog" aria-labelledby="lrdencumbranceapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Encumbrance Approval Confirmation</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Case Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_en_case_number"
					>
				</div>
				
				<div class="form-group">
					<label for="bl_job_number">Job Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_en_job_number"
					>
				</div>


				<div class="form-group">
					<label for="lbl_en_proprietor">Applicant's Name</label>
									
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_en_ar_name"
					>
				</div>

				<!-- <div class="form-group">
					<label for="bl_business_process_sub_name">Cerficate Number</label>
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_certificate_number"
					>
					
				</div> -->

			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btn_lrd_encumbrance_approval"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Send for Approval</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_en_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="smdplottransactionlayerapprovalmodal" tabindex="-1"
	role="dialog" aria-labelledby="smdplottransactionlayerapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Plot Approval Confirmation</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Case Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_case_number__"
					>
				</div>
				
				<div class="form-group">
					<label for="bl_job_number">Job Number </label> <input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_job_number__"
					>
				</div>


				<div class="form-group">
					<label for="lbl_ca_proprietor">Applicant's Name</label>
									
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_ar_name__"
					>
				</div>

				<!-- <div class="form-group">
					<label for="bl_business_process_sub_name">Cerficate Number</label>
					<input
						class="form-control " type="text" placeholder=""
						id="lbl_ca_certificate_number"
					>
					
				</div> -->

			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<a href="#" id="btn_smd_plot_transaction_approval"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Send for Approval</span>
				</a>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_ca_transaction_id__" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="update_application_status_cst_modal" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Update Application Status</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row mb-3">
					<!-- <label for="bl_job_number">Job Number </label>  -->
					<div class="col-md-10">
						<div class="form-group">
							<input
								class="form-control " type="text"
								id="up_cst_job_number" placeholder="Job Number"
							>
						</div>
					</div>
					<div class="col-md-2">
						<button class="btn btn-success" id="_check_cst_application_status"><i class="fas fa-search"></i></button>
					</div>
				</div>

				<ul class="list-group list-group-flush">
					<li class="list-group-item"><b>LRD: </b> <h5 id="_html_lrd_badge"></h5></li>
					<li class="list-group-item"><b>SMD: </b> <h5 id="_html_smd_badge"></h5></li>
					<li class="list-group-item"><b>PVLMD: </b> <h5 id="_html_pvlmd_badge"></h5></li>
				  </ul>


			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<button type="button" id="btn_update_app_status_cst" style="display:none"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Confirm Final Approval</span>
				</button>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal fade" id="update_application_status_frrv_cst_modal" tabindex="-1"
	role="dialog" aria-labelledby="lrdcertificateapprovalmodal" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Update Application Status</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row mb-3">
					<!-- <label for="bl_job_number">Job Number </label>  -->
					<div class="col-md-10">
						<div class="form-group">
							<input
								class="form-control " type="text"
								id="up_frrv_cst_job_number" placeholder="Job Number"
							>
						</div>
					</div>
					<div class="col-md-2">
						<button class="btn btn-success" id="_check_frrv_cst_application_status"><i class="fas fa-search"></i></button>
					</div>
				</div>

				<ul class="list-group list-group-flush">
					<li class="list-group-item"><b>LRD: </b> <h5 id="_html_lrd_badge_corp"></h5></li>
					<li class="list-group-item"><b>SMD: </b> <h5 id="_html_smd_badge_corp"></h5></li>
					<li class="list-group-item"><b>PVLMD: </b> <h5 id="_html_pvlmd_badge_corp"></h5></li>
				  </ul>


			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				<button type="button" id="btn_update_app_status_frrv_cst" style="display:none"
					class="btn btn-success btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-check"></i>
				</span> <span class="text">Confirm Final Approval</span>
				</button>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>


				<input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id"> 

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<!-- Modal from previous artifact -->
<div class="modal fade" id="update_surveyor_capacity_modal" tabindex="-1" role="dialog" aria-labelledby="surveyorCapacityModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Update Surveyor Capacity Determinant</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row mb-3">
					<div class="col-md-10">
						<div class="form-group">
							<input class="form-control" type="text" id="scd_ls_number" placeholder="LS Number" maxlength="100">
						</div>
					</div>
					<div class="col-md-2">
						<button class="btn btn-success" id="check_scd_record"><i class="fas fa-search"></i></button>
					</div>
				</div>

				<div class="form-group">
					<label for="scd_ls_name">LS Name</label>
					<input class="form-control" type="text" id="scd_ls_name" placeholder="Enter LS Name" maxlength="2000">
				</div>

				<div class="form-group">
					<label for="scd_determinant_factor">Determinant Factor</label>
					<textarea class="form-control" id="scd_determinant_factor" placeholder="Enter Determinant Factor" maxlength="4000" rows="4"></textarea>
				</div>

				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label for="scd_ls_value">LS Value</label>
							<input class="form-control" type="number" id="scd_ls_value" placeholder="Enter LS Value" step="0.01" min="0" max="99999999.99">
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="scd_ls_weight">Weight Attached</label>
							<input class="form-control" type="number" id="scd_ls_weight" placeholder="Enter Weight" step="0.01" min="0" max="99999999.99">
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="my-2"></div>
				<button type="button" id="btn_update_scd" style="display:none" class="btn btn-success btn-icon-split">
					<span class="icon text-white-50"><i class="fas fa-check"></i></span>
					<span class="text">Save Changes</span>
				</button>

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal" class="btn btn-danger btn-icon-split">
					<span class="icon text-white-50"><i class="fas fa-trash"></i></span>
					<span class="text">Close</span>
				</a>

				<input type="hidden" id="scd_id" name="scd_id">
			</div>
		</div>
	</div>
</div>



	
<div class="modal fade" id="list_surveyor_determinants_modal" tabindex="-1" role="dialog" aria-labelledby="surveyorDeterminantsListModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Surveyor Capacity Determinants List</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>SCD ID</th>
								<th>LS Number</th>
								<th>LS Name</th>
								<th>Determinant Factor</th>
								<th>LS Value</th>
								<th>Weight Attached</th>
							</tr>
						</thead>
						<tbody id="determinants_table_body">
							<!-- Dynamically populated rows will go here -->
							<c:forEach var="surveyor" items="${surveyorList}">
								<tr>
									<td>${surveyor.scd_id}</td>
									<td>${surveyor.licensed_surveyor_number}</td>
									<td>${surveyor.licensed_surveyor_name}</td>
									<td>${surveyor.ls_determinant_factor}</td>
									<td>${surveyor.ls_value}</td>
									<td>${surveyor.ls_weight}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<div class="my-2"></div>
				<a href="#" data-dismiss="modal" class="btn btn-danger btn-icon-split">
					<span class="icon text-white-50"><i class="fas fa-trash"></i></span>
					<span class="text">Close</span>
				</a>
			</div>
		</div>
	</div>
</div>