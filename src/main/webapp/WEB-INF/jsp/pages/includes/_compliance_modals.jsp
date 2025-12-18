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
<div class="modal fade" data-position="0" id="divisionModal" tabindex="-1" role="dialog"
	aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row"></div>
			</div>
		</div>
	</div>
</div>

<!-- Application Type Modal-->
<div class="modal fade" data-position="0" id="serviceTypeModal" tabindex="-1" role="dialog"
	aria-labelledby="serviceTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="serviceTypeModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-data="name" data-name="name">Service Name</th>
										<th data-data="total" data-name="total">Count</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Units Modal-->
<div class="modal fade" data-position="0" id="unitModal" tabindex="-1" role="dialog"
	aria-labelledby="unitModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="unitModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                   }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="name" data-data="name">Unit</th>
										<th data-name="total" data-data="total">Count</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Officers Modal-->
<div class="modal fade" data-position="0" id="officerModal" tabindex="-1" role="dialog"
	aria-labelledby="officerModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="officerModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="name" data-data="name">Officer</th>
										<th data-name="total" data-data="total">Count</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Applications Modal-->
<div class="modal fade" data-position="0" id="applicationsModal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="due_date" data-data="due_date">Date Received by Officer</th>
										<th data-name="days_due" data-data="days_due">Pending Days</th>
										<th data-name="days_since_batched" data-data="days_since_batched">Days With Officer</th>
										<!-- <th data-name="job_purpose" data-data="job_purpose">Purpose</th> -->
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>
 
<!-- Send Message Modal-->
<div class="modal fade" data-position="0" id="sendMessageModal" tabindex="-1" role="dialog"
	aria-labelledby="sendMessageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
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
					<input id="request_type" name="request_type" value="send_compliance_message" type="hidden">
					<input id="officer_name" name="officer_name" type="hidden"/>
					<input id="job_numbers" name="job_numbers[]" type="hidden"/>
				  <div class="mb-3">
				    <label for="message_type" class="form-label">Message Type</label>
				    <select required class="form-control" name="message_type" id="message_type">
				    	<!-- <option value="">Select One</option> -->
				    	<option value="query">Query</option>
				    	<option value="message">Message</option>
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



<!-- <div class="modal fade" data-position="0" id="viewresponseModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" >Response on query </h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				
					
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-dismiss="modal"
				>Close</button>
				
			</div>
		</div>
	</div>
</div> -->


<div class="modal fade" data-position="0" id="changequerystatusModal" tabindex="-1" role="dialog"
	aria-labelledby="sendMessageModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="changequerystatusModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<form method="post" id="update-query-form" action="SendComplianceMessage">
					<span>Do you want to set the query as inactive?</span>
					<input id="request_type" value="update_compliance_application_notice" type="hidden">
					<input id="job_number" name="job_number" type="hidden"/>
				  
				  <button type="submit" class="btn btn-primary">Yes</button>
				  <button type="button" data-dismiss="modal"class="btn btn-danger">No</button>
				</form>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" data-position="0" id="viewresponseModal" tabindex="-1" role="dialog"
	aria-labelledby="viewresponseModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" >Response on query </h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<ul id="response_list"></ul>
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


<div class="modal fade" data-position="0" id="completedapplicationsModal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="completed_date" data-data="completed_date">Completed Date</th>
										<th data-name="days_due" data-data="days_due">TAT</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" data-position="0" id="reminderAppsModal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="sendReminderMsg btn btn-primary ml-auto" data-action='DashboardAppsWithDivision' type="button">Send Message</button>
				<!-- <button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button> -->
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<!-- <th data-name="details" data-data="details">Details</th> -->
										<th data-name="receiver_name_" data-data="receiver_name_">Receiver</th>
										<th data-name="division_name" data-data="division_name">Division</th>
										<!-- <th data-name="region_name" data-data="region_name">Region</th> -->
										<th data-name="tat" data-data="tat">TAT</th>
										<th data-name="created_date" data-data="created_date">Date Created</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" data-position="0" id="warningAppsModal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="sendReminderMsg btn btn-primary ml-auto" data-action='DashboardAppsWithDivision' type="button">Send Message</button>
				<!-- <button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button> -->
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<!-- <th data-name="details" data-data="details">Details</th> -->
										<th data-name="receiver_name_" data-data="receiver_name_">Receiver</th>
										<th data-name="division_name" data-data="division_name">Division</th>
										<!-- <th data-name="region_name" data-data="region_name">Region</th> -->
										<th data-name="tat" data-data="tat">TAT</th>
										<th data-name="created_date" data-data="created_date">Date Created</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" data-position="0" id="new_modal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                    }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="job_number" data-data="job_number">Job Number</th>
										<th data-name="ar_name" data-data="ar_name">Applicant Name</th>
										<th data-name="business_process_sub_name" data-data="business_process_sub_name">Application Type</th>
										<th data-name="created_date" data-data="created_date">Submission Date</th>
										<th data-name="due_date" data-data="due_date">Date Received by Officer</th>
										<th data-name="days_due" data-data="days_due">Pending Days</th>
										<th data-name="days_since_batched" data-data="days_since_batched">Days With Officer</th>
										<th data-name="job_purpose" data-data="job_purpose">Purpose</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="col-12">
							<div class="chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<form class="generate-applications-chart form-inline">
					<div class="form-group mb-2">
					    <label for="chart_type" class="">Generate Chart</label>
				    </div>
					<div class="form-group mx-sm-3 mb-2">
						 <select class="form-control" name="chart_type">
							<option value="">Select One</option>
							<option value="pie">Pie Chart</option>
							<option value="doughnut">Doughnut Chart</option>
							<option value="bar">Bar Chart</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary mb-2">Generate</button>
					<button type="button" class="btn btn-danger mb-2 ml-2 clear-chart">Clear</button>
				</form>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" data-position="0" id="unitComplianceModal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document" style="max-width: 1100px" >
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel">${unit_name}'s Queried Applications</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- <div class="container"> -->
					<!-- <div class="row"> -->
						<div class="mt-2">
							<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-info"></i>Reminder Applications</span>
							<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-warning"></i>Warning Applications</span>
							<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-danger"></i>Queried Applications</span>
						</div>
						<div class="tab-content mt-4">
							<div id="" class="table-responsive">
								<table class="table " id="table_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
									  <thead>
										<tr>
											<th>#</th>
											<th>Job No.</th>
											<th>Details</th>
											<th>Receiver</th>
											<!-- <th>Division</th>							        
											<th>Region</th> -->
											<th>Sender</th>
											<th>TAT</th>
											<th>Date of Notice</th>
											<th class="text-end">Actions</th>
										</tr>
									  </thead>
									  <tbody id="table_body">
										
									  </tbody>
								   </table>
							</div>
					</div>
					<!-- </div> -->
				<!-- </div> -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" data-position="0" id="pending_queries_modal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabelcq"></h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<!-- <div class="row mt-2">
							<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-info"></i>Reminder Applications</span>
							<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-warning"></i>Warning Applications</span>
							<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-danger"></i>Queried Applications</span>
						</div> -->
						<!-- <div class="tab-content mt-4"> -->
							<div id="" class="col-12 table-responsive">
								<table class="table" id="pending_queries_table_list" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
									"buttons": [
										{ "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
										{ "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
										"colvis"
									]
								}' data-order='[[ 1, "desc" ]]'>
								<!-- <table class="table " cellspacing="0" style="text-transform: uppercase;"> -->
									  <thead>
										<tr>
											<th>#</th>
											<th>Job No.</th>
											<th>Details</th>
											<th>Receiver</th>
											<th>Unit</th>							        
											<!-- <th>Region</th> -->
											<th>TAT</th>
											<th>Date of Notice</th>
											<th class="text-end">Actions</th>
										</tr>
									  </thead>
									  <tbody id="table_body">
										
									  </tbody>
								   </table>
							</div>
					<!-- </div> -->
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" data-position="0" id="viewComplianceLogsModal" tabindex="-1" role="dialog"
	aria-labelledby="applicationsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document" style="max-width: 1100px" >
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applicationsModalLabel"> Compliance Notice Logs</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<!-- <div class="row mt-2">
							<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-info"></i>Reminder Applications</span>
							<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-warning"></i>Warning Applications</span>
							<span class="mb-2 mr-2 small"><i class="fas fa-dot-circle text-danger"></i>Queried Applications</span>
						</div> -->
						<div class="tab-content mt-4">
							<div id="" class="table-responsive">
								<table class="table " id="table_list_logs"  width="100%" cellspacing="0" style="text-transform: uppercase;">
									  <thead>
										<tr>
											<th>#</th>
											<th>Job No.</th>
											<th>Details</th>
											<th>Notice Type</th>
											<th>Receiver</th>
											<th>Division</th>							        
											<th>Region</th>
											<th>Date Created</th>
										</tr>
									  </thead>
									  <tbody id="table_body">
										
									  </tbody>
								   </table>
							</div>
					</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


