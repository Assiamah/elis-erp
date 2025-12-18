<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="../includes/_header.jsp"></jsp:include>



<div class="container-fluid">
	<!-- Breadcrumbs-->
	<ol class="breadcrumb d-flex">
		<li class="breadcrumb-item"><a href="">Unit Registry Case Management</a></li>
		<li class="breadcrumb-item active">${unit_name}</li>
		
		${(view_all_offices == "Yes") ? "<li class='breadcrumb-item active text-danger'>/ Showing for all Office Locations</li>" : ""}

		<!-- <input type="hidden" id="sel_change_region_compliance" value="${regional_code}" /> -->
		 <li class="ml-auto p-2">
			<div class="btn-group" role="group" aria-label="Basic example">

				<button class="btn btn-primary mr-2 showOfficerModal"
					style="border-radius: 50px; text-align: center; box-shadow: 2px 2px 3px #999;"
					data-method="apps_with_division" data-url="DashboardAppsWithDivision"
					data-type="${unit_name}" data-title="Applications With Divisions"
					data-toggle="tooltip" data-placement="top" title="Unit Monitoring"
					data-date="" data-unit-id="${unit_id}" data-division="${division}">
					<i class="fas fa-eye"></i></button>
					
				<button class="btn btn-primary mr-2" id="btn_load_resolved_queries"
					style="border-radius: 50px; text-align: center; box-shadow: 2px 2px 3px #999;"
					data-toggle="tooltip" data-placement="top" title="Responded Queries"
					>
					<i class="fas fa-comment"></i> [${query_response}]</button>
		
				<button class="btn btn-info mr-2 loadReminderApps"
					style="border-radius: 50px; text-align: center; box-shadow: 2px 2px 3px #999;"
					data-method="reminder_apps" data-url="DashboardAppsWithDivision"
					data-type="${unit_name}" data-title="Applications"
					data-toggle="tooltip" data-placement="top" title="Reminder Queries"
					data-date="" data-unit-id="${unit_id}" data-division="${division}">
					<i class="fas fa-clock"></i> [${reminders}]
			</button>
		
				<button class="btn btn-warning mr-2 loadWarningApps"
					style="border-radius: 50px; text-align: center; box-shadow: 2px 2px 3px #999;"
					data-method="warning_apps" data-url="DashboardAppsWithDivision"
					data-type="${unit_name}" data-title="Applications"
					data-toggle="tooltip" data-placement="top" title="Warning Queries"
					data-date="" data-unit-id="${unit_id}" data-division="${division}">
					<i class="fas fa-exclamation-triangle"></i> [${warnings}]
				</button>
		
				<button class="btn btn-danger mr-2 loadComplianceQueriesApps"
					style="border-radius: 50px; text-align: center; box-shadow: 2px 2px 3px #999;"
					data-method="reminder_apps" data-url="DashboardAppsWithDivision"
					data-type="${unit_name}" data-title="Applications"
					data-toggle="tooltip" data-placement="top" title="Compliance Queries"
					data-date="" data-unit-id="${unit_id}" data-division="${division}">
					<i class="fas fa-question-circle"></i>  [${compliance_queries}]
				</button>
			</div>
		 </li>
		
		<input id='userid' type='hidden' value='${sessionScope.userid}'/>


	</ol>

	<input type="hidden" class="form-control" id="inc_1" value="${incoming}" />
	<input type="hidden" class="form-control" id="com_3" value="${completed}" />
	<input type="hidden" class="form-control" id="que_2" value="${queried}" />
	<input type="hidden" class="form-control" id="awa_4" value="${awaiting_payment}" />	


	<!-- Content Row -->
	<div class="row">

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-primary shadow h-100 py-2"
				id="body-dg-1">
				<div class="card-body">
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="1">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-primary text-uppercase mb-1">Incoming
									Files</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800"
									id="number-text-1">${incoming}</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-calendar fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-success shadow h-100 py-2"
				id="body-dg-3">
				<div class="card-body">
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="3">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-success text-uppercase mb-1">Completed
									within unit</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800"
									id="number-text-3">${completed}</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-info shadow h-100 py-2" id="body-dg-2">
				<div class="card-body">
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="2">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-info text-uppercase mb-1">Queried</div>
								<div class="row no-gutters align-items-center">
									<div class="col-auto">
										<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"
											id="number-text-2">${queried}</div>
									</div>
									<!-- <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                        </div> -->
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-comments fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>

		<!-- Pending Requests Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-warning shadow h-100 py-2"
				id="body-dg-4">
				<div class="card-body">
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="4">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-warning text-uppercase mb-1">Awaiting
									Payment</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800"
									id="number-text-4">${awaiting_payment}</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-coins fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Content Row -->
	<div class="mb-3">
		<a href="#" style="text-decoration: underline;" data-id="5" data-toggle="modal" data-target="#incoming_advanced_search">Advanced Filter</a>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<!-- Example Bar Chart Card-->
			<div class="card mb-3">
				<div class="card-header bg-dark text-white">
					<i class="fa fa-bar-chart"></i>Application Details <span
						class="col-md-3 float-right ">
						<button class="btn btn-success btn-icon-split float-right "
							id="btnViewBatchlist">
							<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span
								class="text">View Batch List</span>
						</button>
					</span>




				</div>

				<div class="card-body">


					<div class="row">
						<div class="col-sm-3">
							<!-- <div class="col-sm-6">
								<input type="text" class="form-control col"
									id="txt_general_job_purpose" value=""
									placeholder="Purpose for Batching" />
							</div>
							<div class="col-sm-6">
								<label for="search_btn">&nbsp;</label>
								<button class="btn btn-primary btn-icon-split"
									id="btnAddAlltoBatchlist">
									<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span
										class="text">Add All to Batch List</span>
								</button>
							</div> -->
							<div class="form-group">
								<div class="form-row">
								  <div class="col">
								  <!-- <label for="search_btn">Purpose</label>  -->
								  <input type="text" class="form-control col" id="txt_general_job_purpose"  value="" placeholder="Purpose for Bactching" /> 
								  </div>
								</div>
								<div class="form-row mt-2">
								  <div class="col">
								  <!-- <label for="search_btn">Purpose</label>  -->
								  <textarea type="text" class="form-control col" id="txt_general_remarks_notes"  value="" placeholder="Remarks/Notes"></textarea>
								  </div>
								</div>
								<div class="form-row mt-2">
								  <div class="col">
								  <!-- <label for="search_btn">&nbsp;</label>  -->
									<button class="btn btn-primary btn-icon-split w-100"  id="btnAddAlltoBatchlist">
								  <span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text">Add All to Batch List</span>
								</button>
								  </div>
								</div>
							  </div>
							<!-- <div class="col-sm-6">
								<label for="search_btn">&nbsp;</label>
								<button class="btn btn-primary btn-icon-split"
									id="btn_set_application_as_required_client_attention">
									<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span
										class="text">Add All to Batch List</span>
								</button>
							</div> -->
						</div>
						<!-- <button class="btn btn-primary btn-icon-split"
									id="btn_set_application_as_required_client_attention">
									<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span
										class="text">Add All to Batch List</span>
								</button> -->
						<div class="col-sm-6">&nbsp;</div>
					</div>
					<br>
					<br>

					<!--  Here is where the fee list comes -->

					<div class="table-responsive">
						<table class="table table-bordered table-hover display "
							id="job_casemgtdetailsdataTable" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th></th>
									<th><input type="checkbox" id="selectAll" /></th>
									<th>Created Date</th>
									<th>Job Number</th>
									<th>Applicant Name</th>
									<th>Application Type</th>
									<th>Status</th>
									<th>Sent By</th>
									<th>Locality</th>
									<th>Type of Plotting</th>
									<th>Add to BatchList</th>
									<th>View</th>
									<th class="to_hide_on_level_1">Work</th>

								</tr>
							</thead>

							<tbody>


								<c:forEach items="${applicationlist}" var="appfiles">
									<tr
										${appfiles.objections > 0 ? "class='bg-danger text-white red-tooltip' title='Application has pending Objections'  data-toggle='tooltip' data-placement='left' ":""}>

										<td><input type="checkbox" />
										<%-- ${applicationLoop.index + 1} --%></td>
										<td>${appfiles.job_number}</td>




										<td data-toggle="tooltip" data-placement="top"
											title="${fn:length(appfiles.ar_name) >20 ? appfiles.ar_name : ''}">
											${fn:substring(appfiles.ar_name, 0, 20)}
											${fn:length(appfiles.ar_name) >20 ? "..." : ""}</td>

										<td>${appfiles.business_process_sub_name}</td>

										<td data-toggle="tooltip" data-placement="top"
											title="${fn:length(appfiles.current_application_status) >20 ? appfiles.current_application_status : ''}">${fn:substring(appfiles.current_application_status, 0, 20)}
											${fn:length(appfiles.current_application_status) >20 ? "..." : ""}
										</td>

										<td>
											<button class="btn btn-info btn-icon-split"
												data-title="Delete"
												id="btnAddToBatchlist-${appfiles.job_number}"
												data-job_number="${appfiles.job_number}"
												data-ar_name="${appfiles.ar_name}"
												data-business_process_sub_name="${appfiles.business_process_sub_name}"
												data-target="#askForPurposeOfBatching" data-toggle="modal">
												<span class="icon text-white-50"> <i
													class="fas fa-list"></i></span> <span class="text">Add to
													Batch</span>
											</button>


										</td>


										<td>
											<form action="registration_application_progress_details"
												method="post">
												<input type="hidden" name="case_number" id="case_number"
													value="${appfiles.transaction_number}"> <input
													type="hidden" name="job_number" id="job_number"
													value="${appfiles.job_number}"> <input
													type="hidden" name="business_process_sub_name"
													id="business_process_sub_name"
													value="${appfiles.business_process_sub_name}">

												<button type="submit" name="save"
													class="btn btn-info btn-icon-split">
													<span class="icon text-white-50"> <i
														class="fas fa-folder-open"></i></span><span class="text">Work</span>
												</button>
											</form>

										</td>


									</tr>
								</c:forEach>


							</tbody>


						</table>
					</div>

					<!--  End Of Table -->
				</div>

			</div>

		</div>
	</div>



<div class="modal fade" id="respondedQueriesModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-fullscreen ">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Responded Queries at Unit ${unit_name}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="table-responsive" >
					<table class="table table-bordered table-hover table-sm data-table_" id="tbl_responded_queries_result">
						<thead>
							<tr>
								<th><input type="checkbox"/>Select All</th>
								<th>Job Number</th>
								<th>Applicant Name</th>
								<th>Business Process</th>
								<th>Locality</th>
								<th>Approved by</th>
								<th>&nbsp;</th>
								<th>&nbsp;</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
			
			                 
		

			</div>
			   <div class="modal-footer"><button type="button" class="btn btn-google btn-user btn-block" data-dismiss="modal">Close</button></div>
	     </div>
	</div>
</div>


</div>






	<jsp:include page="../includes/_footer.jsp"></jsp:include>