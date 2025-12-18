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
		<li class="breadcrumb-item"><a href="">Certificate Signing Template</a></li>
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
					<i class="fas fa-eye"></i>Unit Monitoring</button>
					
				<!-- <button class="btn btn-primary mr-2" id="btn_load_resolved_queries"
					style="border-radius: 50px; text-align: center; box-shadow: 2px 2px 3px #999;"
					data-toggle="tooltip" data-placement="top" title="Responded Queries"
					>
					<i class="fas fa-comment"></i></button>
		
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
				</button> -->
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
									class="text-xs font-weight-bold text-warning text-uppercase mb-1">Assigned To
									Officers</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800"
									id="number-text-4">${assigned_to_officers}</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-users fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-danger shadow h-100 py-2" id="body-dg-2">
				<div class="card-body">
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="2">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-danger text-uppercase mb-1">Queried</div>
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
								<i class="fas fa-exclamation-triangle fa-2x text-gray-300"></i>
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
								<i class="fas fa-check-circle fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Content Row -->
	<!-- <div class="mb-3">
		<a href="#" style="text-decoration: underline;" data-id="5" data-toggle="modal" data-target="#incoming_advanced_search">Advanced Filter</a>
	</div> -->

	<div class="row">
		<div class="col-lg-12">
			<!-- Example Bar Chart Card-->
			<div class="card mb-3">
				<div class="card-header bg-dark text-white">
					<i class="fa fa-bar-chart"></i>Application Details <span
						class="col-md-3 float-right ">
						<button class="btn btn-success btn-icon-split float-right "
							id="btnViewBatchlistCS">
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
									<button class="btn btn-primary btn-icon-split w-100"  id="btnAddAlltoBatchlistCS">
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
							id="job_casemgtdetailsdataTableCS" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th></th>
									<th><input type="checkbox" id="selectAll" /></th>
									<th>Created Date</th>
									<th>Job Number</th>
									<th>Applicant Name</th>
									<th>Application Type</th>
									<!--   <th style="display:none">Status</th> -->
									<!-- <th>Status</th> -->
									<!-- <th>Date Received</th>
                <th>Sent By</th> -->
									<th>Status</th>
									<th id="inbox_text">Sent By</th>
									<th>Locality</th>
									<th id="reminder_text">Type of Plotting</th>
									<th>Add to BatchList</th>
									<th>View</th>
									<th class="to_hide_on_level_1">Work</th>




									<!-- 	<th data-field="customer.name" data-align="center" data-sortable="true">customer</th>
                    <th data-field="type" data-align="center" data-sortable="true">type</th>
                    <th data-field="description" data-align="center" data-sortable="true">description</th>
                    <th data-field="cutter" data-align="center" data-sortable="true">cutter</th> 
                    <th data-field="valid_s" data-align="center" data-sortable="true">valid</th>
                  -->

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
												data-target="#askForPurposeOfBatchingCS" data-toggle="modal">
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


<div class="modal fade" id="viewBatchlistModalCS" tabindex="-1"
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
								<div class="form-row" id="unit-batching" style="background-color:#123456; padding:15px; display:none">
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
								
								<div class="form-row"  style="background-color:#654321; padding:15px; display:none" id="individual-batching" >
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
                        <table id="batchlistdataCSTable"
                           class="table table-bordered table-hover"></table>
                     </div>
                  </div>
               </div>
               <br/> <br/> <br/>
               <div class="modal-footer">
               		<button type="button" class="btn btn-dark float-left  mr-auto" id="btn_clear_all_batchlist_cs">Remove all from list</button>
               		<!-- <button type="button" class="btn btn-dark float-left  mr-auto" id="btn_sent_for_frrv_batchlist">Sent For FRRV</button> -->
                  <button type="button" class="btn btn-secondary"
                     data-dismiss="modal">Close</button>
                  <button type="button" id="btn_process_batchlist_cs"  class="btn btn-primary" style="display:none">Process Batch List</button>
               </div>
            
         </div>
      </div>
   </div>
</div>

<div class="modal fade" id="askForPurposeOfBatchingCS" tabindex="-1" role="dialog" data-position="10"
	aria-labelledby="askForPurposeOfBatchingCS" aria-hidden="true" style="z-index:10000000000"
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
				<a href="#" id="btnaddjobtolistFinalCS"
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


</div>






	<jsp:include page="../includes/_footer.jsp"></jsp:include>