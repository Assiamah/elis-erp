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
 <jsp:useBean id="now" class="java.util.Date"/>    


<!-- Division Modal-->


		
	<div class="modal fade" id="cabinetModal" tabindex="-1" role="dialog"
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
						<div class="row">
							<div class="col-md-8">
								<div class="card">
									<div class="card-header">History</div>
									<div class="card-body">
										<table class="table table-bordered" id="cabinet-tracking">
											<thead>
												<tr>
													<th>Comments</th>
													<th>Division/Unit</th>
													<th>Batching Officer</th>
													<th>Date</th>
												</tr>
											</thead>
											<tbody></tbody>
		
										</table>
									</div>
								</div>
		
		
		
		
							</div>
							<div class="col-md-4">
								<div class="card">
									<div class="card-header">Details</div>
									<div class="card-body">
										<form >
											<fieldset>
												<div class="form-group ">
													<label for="staticEmail" class=" col-form-label">Applicant
														Name</label>
		
													<textarea readonly class="form-control"
														id="enq_applicant_name"></textarea>
		
												</div>
		
												<div class="form-group ">
													<label for="staticEmail" class=" col-form-label">Applicant type</label> 
													<input type="text" readonly class="form-control" id="enq_applicant_type">
		
												</div>
											</fieldset>
											<hr>
											<fieldset>
												<div class="form-group ">
													<label for="staticEmail" class=" col-form-label">Cabinet
														Name</label> <input type="text" readonly class="form-control"
														id="enq_cabinet_name">
												</div>
												<hr>
												<!-- <div class="form-group ">
												<label for="staticEmail" class=" col-form-label">Shelve Number</label>
												  <input type="text" readonly class="form-control" id="shelve_number" value="3C">
											 </div> -->
												 <div class="form-group ">
												<label for="staticEmail" class=" col-form-label">Job Purpose</label>
												  <textarea  readonly class="form-control" id="enq_job_purpose" rows="4"></textarea>
											 </div> 
												<div class="form-group ">
													<label for="staticEmail" class=" col-form-label">Job
														Status</label> 
														<textarea readonly class="form-control"
														id="enq_job_status" rows="4"></textarea>
														
												</div>
												<div class="form-group ">
													<label for="staticEmail" class=" col-form-label">Application Status
														</label> 
														<textarea  readonly class="form-control" id="enq_current_application_status" rows="4"></textarea>
														
												</div>
											</fieldset>
		
		
										</form>
									</div>
								</div>
							</div>
		
						</div>
		
		
					</div>
				</div>
			</div>
		</div>






 <div class="modal fade" id="recieved_reporting_modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="recieved_applications_title"><span id="reportheading"></span> </h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"> <i class="fa fa-times"></i></span>
					</button>
				</div>
				<div class="modal-body">
					
					<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-4">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications</h6>
												<h3 class="stat-value" id="totalServices">0</h3>
											</div>
										</div>

										<div class="col-md-4">
											<div class="stat-card bg-info text-white p-3 rounded">
												<h6 class="stat-title">Total Services</h6>
												<h3 class="stat-value" id="totalApplications">0</h3>
											</div>
										</div>
								
										<div class="col-md-4">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="dateRange">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="table-responsive">
						<table class="table table-bordered table-hover" id="main_service_table" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Service Name</th>
						<th>Count</th>
						<th>Percentage</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
					</div> 
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
				</div>
			</div>
		</div>
		</div>





<div class="modal fade" id="sub_service_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="sub_service_modalLabel"></h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">

			<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-4">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications</h6>
												<h3 class="stat-value" id="totalServicesSub">0</h3>
											</div>
										</div>

										<div class="col-md-4">
											<div class="stat-card bg-info text-white p-3 rounded">
												<h6 class="stat-title">Total Sub Services</h6>
												<h3 class="stat-value" id="totalApplicationsSub">0</h3>
											</div>
										</div>
								
										<div class="col-md-4">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="dateRangeSub">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="sub_service_table" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Sub Service Name</th>
						<th>Count</th>
						<th>Percentage</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>




<div class="modal fade" id="apps_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="apps_modalLabel">Applications Recieved </h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-6">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications</h6>
												<h3 class="stat-value" id="totalApplicationsRecApps">0</h3>
											</div>
										</div>

								
										<div class="col-md-6">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="dateRangeSubRecApps">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>




					  
    
        

			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="apps_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
					<th>Job Number</th>
					<th>Applicant Name</th>
					<th>Application Type</th>
					<th>Submission Date</th>
				    <th>Pending Days</th>
					<th>Current Stage</th>
					<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>




<div class="modal fade" id="completed_apps_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="completed_apps_modalLabel">Applications Recieved </h5>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-6">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications</h6>
												<h3 class="stat-value" id="completed_totalApplicationsRecApps">0</h3>
											</div>
										</div>

								
										<div class="col-md-6">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="completed_dateRangeSubRecApps">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="completed_apps_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
					<th>Job Number</th>
					<th>Applicant Name</th>
					<th>Application Type</th>
					<th>Submission Date</th>
					<th>Completed Date</th>
					<th>TAT</th>
					<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>




<div class="modal fade" id="sendMessageModal_FocalCompliance" tabindex="-1" role="dialog"
	aria-labelledby="sendMessageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="sendMessageModalLabel_FocalCompliance"></h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>

			<div class="modal-body">
				<!-- 🕓 PREVIOUS MESSAGES SECTION -->
				<div id="previousMessages" class="mb-3">
					<h6 class="text-dark font-weight-bold mb-2">Previous Notices</h6>
					<div id="messagesContainer" class="border rounded p-2 bg-light" style="max-height: 200px; overflow-y: auto;">
						<p class="text-muted mb-0">Loading previous messages...</p>
					</div>
				</div>

				<hr>

				<!-- 📨 SEND NEW MESSAGE FORM -->
				<form method="post" id="message-form_focal_complaince" action="SendComplianceMessage">
					<input id="focal_officer_id" name="officer_id" type="hidden"/>
					<input id="request_type" value="send_compliance_focal_person_message" type="hidden">
					<input id="officer_name" name="officer_name" type="hidden"/>
					<input id="job_numbers" name="job_numbers[]" type="hidden"/>

					<div class="mb-3">
						<label for="message_type" class="form-label">Message Type</label>
						<select required class="form-control" name="message_type" id="message_type">
							<option value="">Select One</option>
							<option value="query">Query</option>
							<option value="Warning">Warning</option>
						</select>
					</div>

					<div class="mb-3">
						<label for="message" class="form-label">Message</label>
						<textarea required class="form-control" name="message" id="message"></textarea>
					</div>

					<button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	</div>
</div>




<div class="modal fade" data-position="0" id="sendMessageModal" tabindex="-1" role="dialog"
	aria-labelledby="sendMessageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="sendMessageModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" id="message-form" action="SendComplianceMessage">
					<input id="officer_id" name="officer_id" type="hidden"/>
					<input id="request_type" value="send_compliance_focal_person_message" type="hidden">
					<input id="officer_name" name="officer_name" type="hidden"/>
					<input id="job_numbers" name="job_numbers[]" type="hidden"/>
				  <div class="mb-3">
				    <label for="message_type" class="form-label">Message Type</label>
				    <select required class="form-control" name="message_type" id="message_type">
				    	<option value="">Select One</option>
				    	<option value="query">Query</option>
				    	<option value="Warning">Warning</option>
				    </select>
				  </div>
				  <div class="mb-3">
				    <label for="message" class="form-label">Message</label>
				    <textarea required class="form-control" name="message" id="message"></textarea>
				  </div>
				  <button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	</div>
</div>




 <div class="modal fade" id="status_modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="status_title"><span id="reportheading"></span> </h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"> <i class="fa fa-times"></i></span>
					</button>
				</div>
				<div class="modal-body">
					
					<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-6">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications</h6>
												<h3 class="stat-value" id="totalRegApps">0</h3>
											</div>
										</div>

										<!-- <div class="col-md-4">
											<div class="stat-card bg-info text-white p-3 rounded">
												<h6 class="stat-title">Total Services</h6>
												<h3 class="stat-value" id="totalApplications">0</h3>
											</div>
										</div> -->
								
										<div class="col-md-6">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="dateRangeRegApps">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="table-responsive">
						<table class="table table-bordered table-hover" id="status_table" width="100%" cellspacing="0">
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Status Type</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
					</div> 
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
				</div>
			</div>
		</div>
		</div>



		

 <div class="modal fade" id="regional_modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="region_title"><span id="reportheading"></span> </h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"> <i class="fa fa-times"></i></span>
					</button>
				</div>
				<div class="modal-body">
					
					
					
					<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-4">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications</h6>
												<h3 class="stat-value" id="totalregionApps">0</h3>
											</div>
										</div>

										<div class="col-md-4">
											<div class="stat-card bg-info text-white p-3 rounded">
												<h6 class="stat-title">Total Row Count</h6>
												<h3 class="stat-value" id="totalRegionalCount">0</h3>
											</div>
										</div>
								
										<div class="col-md-4">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="dateRangeRegions">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="table-responsive">
						<table class="table table-bordered table-hover" id="regions_table" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Region</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
					</div> 
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
				</div>
			</div>
		</div>
		</div>		



		
	 <div class="modal fade" id="divisions_modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="divisions_title"><span id="reportheading"></span> </h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"> <i class="fa fa-times"></i></span>
					</button>
				</div>
				<div class="modal-body">
					
				
					
					<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-4">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications</h6>
												<h3 class="stat-value" id="totalDivisionalApps">0</h3>
											</div>
										</div>

										<div class="col-md-4">
											<div class="stat-card bg-info text-white p-3 rounded">
												<h6 class="stat-title">Total Row Count</h6>
												<h3 class="stat-value" id="totalDivisionCount">0</h3>
											</div>
										</div>
								
										<div class="col-md-4">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="dateRangeDivision">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="table-responsive">
						<table class="table table-bordered table-hover" id="divisions_table" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Division</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
					</div> 
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
				</div>
			</div>
		</div>
		</div>		



<div class="modal fade" id="units_modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="units_title"><span id="reportheading"></span> </h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"> <i class="fa fa-times"></i></span>
					</button>
				</div>
				<div class="modal-body">
					
				
					
					<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-4">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications With Unit(s)</h6>
												<h3 class="stat-value" id="totalDivisionalUnits">0</h3>
											</div>
										</div>

										<div class="col-md-4">
											<div class="stat-card bg-info text-white p-3 rounded">
												<h6 class="stat-title">Total Row Count</h6>
												<h3 class="stat-value" id="totalDivisionUnit">0</h3>
											</div>
										</div>
								
										<div class="col-md-4">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="dateRangeDivisionUnit">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="table-responsive">
						<table class="table table-bordered table-hover" id="units_table" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Division</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
					</div> 
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
				</div>
			</div>
		</div>
</div>	




<div class="modal fade" id="officers_modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="officers_title"><span id="reportheading"></span> </h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"> <i class="fa fa-times"></i></span>
					</button>
				</div>
				<div class="modal-body">
					
				
					
					<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-4">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications With Officer(s)</h6>
												<h3 class="stat-value" id="totalDivisionalAppsStaff">0</h3>
											</div>
										</div>
										<div class="col-md-4">
											<div class="stat-card bg-info text-white p-3 rounded">
												<h6 class="stat-title">Total Number of Officer(s)</h6>
												<h3 class="stat-value" id="totalDivisionCountStaff">0</h3>
											</div>
										</div>
								
										<div class="col-md-4">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="dateRangeDivisionStaff">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="table-responsive">
						<table class="table table-bordered table-hover" id="officers_table" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Staff Name</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
					</div> 
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
				</div>
			</div>
		</div>
</div>	






<div class="modal fade" id="staffapps_modal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="staffapps_modalLabel">Applications Recieved </h5>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <div id="sendmsg"></div>
			<button class="close" type="button" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-times"></i></span>
			</button>
		</div>
		<div class="modal-body">
			<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-6">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications</h6>
												<h3 class="stat-value" id="totalStaffApps">0</h3>
											</div>
										</div>

								
										<div class="col-md-6">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="dateRangeStaffApps">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

			<div class="table-responsive">
				<table class="table table-bordered table-hover" id="staffapps_table" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
				    <th>Select All<input type="checkbox" id="select-all"></th>
					<th>Job Number</th>
					<th>Applicant Name</th>
					<th>Application Type</th>
					<th>Submission Date</th>
					<th>Pending Days</th>
					<th>Date Received by Officer</th>
					<th>Days With Officer</th>
					<th>Current Stage</th>
					<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
			</div> 
		</div>
		<div class="modal-footer">
			<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
		</div>
	</div>
</div>
</div>






<div class="modal fade" id="regional_divisions_modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="regional_divisions_title"><span id="reportheading"></span> </h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"> <i class="fa fa-times"></i></span>
					</button>
				</div>
				<div class="modal-body">
					
				
					
					<div class="row mb-4">
						<div class="col-md-12">
							<div class="card shadow-sm">
								<div class="card-header bg-light">
									<h6 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Report Summary</h6>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-6">
											<div class="stat-card bg-success text-white p-3 rounded">
												<h6 class="stat-title">Total Applications</h6>
												<h3 class="stat-value" id="totalDivisionalAppsNew">0</h3>
											</div>
										</div>

								
										<div class="col-md-6">
											<div class="stat-card bg-danger text-white p-3 rounded">
												<h6 class="stat-title">Date Range</h6>
												<h3 class="stat-value" id="dateRangeDivisionNew">-</h3>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				


					<div class="table-responsive">
						<table class="table table-bordered table-hover" id="regional_divisions_table" width="100%" cellspacing="0" data-order='[[ 1, "desc" ]]'>
				<!-- <table id="batching_apps_worked_on_thisyear_table" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;"> -->
				   <thead>
						<th>Division</th>
						<th>Count</th>
						<th>Action</th>
				  </thead>
					  <tbody>        
					  </tbody>
				</table>
					</div> 
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" type="button" data-dismiss="modal">Close <i class="fa fa-times"></i></button>
				</div>
			</div>
		</div>
		</div>	




<div class="modal fade" id="repliesModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h6 class="modal-title">Notice Replies</h6>
         <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="repliesModalBody">
        <!-- Replies will load here -->
      </div>
    </div>
  </div>
</div>
