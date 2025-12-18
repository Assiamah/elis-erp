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
		<li class="breadcrumb-item"><a href="">General Request Management</a></li>
		<li class="breadcrumb-item active">${unit_name}</li>
		
		${(view_all_offices == "Yes") ? "<li class='breadcrumb-item active text-danger'>/ Showing for all Office Locations</li>" : ""}

		<!-- <input type="hidden" id="sel_change_region_compliance" value="${regional_code}" /> -->
		 <!-- <li class="ml-auto p-2">
			<div class="btn-group" role="group" aria-label="Basic example">

				<a class="btn btn-primary"
					style="border-radius: 50px; text-align: center; box-shadow: 2px 2px 3px #999;"
					href="/new_general_request">
					<i class="fas fa-plus-circle"></i>New Request</a>
			</div>
		 </li> -->
		
		<input id='userid' type='hidden' value='${sessionScope.userid}'/>


	</ol>




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
									Request</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800"
									id="number-text-1">${incoming}</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-sign-in-alt fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-2 col-md-6 mb-4">
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

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-2 col-md-6 mb-4">
			<div class="card border-left-info shadow h-100 py-2" id="body-dg-2">
				<div class="card-body">
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="2">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-info text-uppercase mb-1">Requests with Officers </div>
								<div class="row no-gutters align-items-center">
									<div class="col-auto">
										<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"
											id="number-text-2">${with_officers}</div>
									</div>
									<!-- <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                        </div> -->
								</div>
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
		<div class="col-xl-2 col-md-6 mb-4">
			<div class="card border-left-danger shadow h-100 py-2" id="body-dg-5">
				<div class="card-body">
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="5">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div
									class="text-xs font-weight-bold text-danger text-uppercase mb-1">Queried Request </div>
								<div class="row no-gutters align-items-center">
									<div class="col-auto">
										<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"
											id="number-text-5">${queried}</div>
									</div>
									<!-- <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                        </div> -->
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-exclamation-circle fa-2x text-gray-300"></i>
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
									Response</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800"
									id="number-text-4">${awaiting}</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-clock fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<!-- Example Bar Chart Card-->
			<div class="card mb-3">
				<div class="card-header bg-dark text-white">
					<i class="fa fa-bar-chart"></i>Request Details <span
						class="col-md-3 float-right ">
						<button class="btn btn-success float-right "
							id="btnViewRequestsList"><i class="fas fa-eye"></i>View Batch List
						</button>
					</span>




				</div>

				<div class="card-body">


					<div class="row">
						<div class="col-sm-3 d-none" id="sendbulkrequest">
							<div class="form-group">
								<!-- <div class="form-row">
								  <div class="col">
								   <select class="form-control col" id="txt_general_job_purpose">
										<option value="">-- select --</option>
										<option value="Reverification Search">Reverification Search</option>
										<option value="Notting Parcel">Notting Parcel</option>
										<option value="Plotting Parcel">Plotting Parcel</option>
								   </select>
								  </div>
								</div> -->
								<div class="form-row mt-2">
								  <div class="col">
								  <textarea type="text" class="form-control col" id="txt_general_remarks_notes"  value="" placeholder="Remarks"></textarea>
								  </div>
								</div>
								<div class="form-row mt-2">
								  <div class="col">
									<button class="btn btn-danger w-100"  id="btnAddAlltoRequestlist">
								  <i class="fas fa-plus"></i>Add All to Request List
								</button>
								  </div>
								</div>
							  </div>


						<div class="col-sm-6">&nbsp;</div>
					</div>

					<div class="col-sm-3 d-none" id="archivebulkrequest">
						<div class="form-group">
							<!-- <div class="form-row">
							  <div class="col">
							   <select class="form-control col" id="txt_general_job_purpose">
									<option value="">-- select --</option>
									<option value="Reverification Search">Reverification Search</option>
									<option value="Notting Parcel">Notting Parcel</option>
									<option value="Plotting Parcel">Plotting Parcel</option>
							   </select>
							  </div>
							</div> -->
							<div class="form-row mt-2">
							  <div class="col">
							  <textarea type="text" class="form-control col" id="txt_general_archive_notes"  value="" placeholder="Notes"></textarea>
							  </div>
							</div>
							<div class="form-row mt-2">
							  <div class="col">
								<button class="btn btn-danger w-100"  id="btnAddAlltoArchivelist">
							  <i class="fas fa-plus"></i>Add All to Archive List
							</button>
							  </div>
							</div>
						  </div>


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
									<th><input type="checkbox" id="selectAll" /></th>
									<th>Requested Date</th>
									<th>Job Number</th>
									<th>Applicant Name</th>
									<th>Application Type</th>
									<th>Purpose</th>
									<th>Comments</th>
									<th>Status</th>
									<th id="inbox_text">Requested By</th>
									<th id="send_text">Send Request</th>
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


<!-- View Batchlist============================= -->
<div class="modal fade" id="viewFileListModal" tabindex="-1"
   role="dialog" aria-labelledby="viewFileListModal" aria-hidden="true">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="">Request List Processing</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         </div>
         <div class="modal-body">
            <form >
               <%-- <input id="bl_modified_by" name="bl_modified_by" type="hidden" value="${fullname}"> 
               <input id="bl_modified_by_id" name="bl_modified_by_id" type="hidden" value="${userid}"> --%>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                     
                     	<div class="form-group row">
							
							<div class="col-sm-4">
							<label class="col-form-label" style="text-align: right"><h2>Send Request To :</h2></label>
								<div class="input-group">
									<div id="radioBtnBatching" class="btn-group ">
										<!-- <a class="btn btn-primary btn-sm notActive" data-toggle="batch_type" data-title="Unit"><h2>A Unit</h2></a>  -->
										<a class="btn btn-primary btn-sm notActive" data-toggle="batch_type" data-title="Individual"><h2>An Individual</h2></a>
									</div>
									<input type="hidden" name="batch_type" id="batch_type">
								</div>
							</div>
							<div class="col">
								<div class="form-row" id="rs_unit-batching" style="background-color:#123456; padding:15px; display:none">
									<div class="col-12"><h4 style="" class="text-white">Sending to a Unit</h4></div>
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
								
								<div class="form-row"  style="background-color:#654321; padding:15px; display:none" id="rs_individual-batching" >
                                    <div class="col-12"><h4 style="" class="text-white">Sending to an Individual</h4></div>
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
								
								
							  &nbsp;
							</div>
						</div>
                     	
                        
                        
                     </div>
                  </div>
               </div>
               <BR>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                        <table id="FileListdataTable"
                           class="table table-bordered table-hover"></table>
                     </div>
                  </div>
               </div>
               <br> <br> <br>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary d-none"
                     data-dismiss="modal">Close</button>
                  <button type="button" id="btn_process_request_list_to_user"  class="btn btn-primary" >Process List</button>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>

<div class="modal fade" id="viewArchiveListModal" tabindex="-1"
   role="dialog" aria-labelledby="viewArchiveListModal" aria-hidden="true">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="">Move Requests To Archive</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         </div>
         <div class="modal-body">
            <form >
               <%-- <input id="bl_modified_by" name="bl_modified_by" type="hidden" value="${fullname}"> 
               <input id="bl_modified_by_id" name="bl_modified_by_id" type="hidden" value="${userid}"> --%>
               <div class="container">
                  <div class="col-sm-12 col-xs-12">
                     <div class="form-group">
                        <table id="ArchiveListdataTable"
                           class="table table-bordered table-hover"></table>
                     </div>
                  </div>
               </div>
               <br> <br> <br>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary d-none"
                     data-dismiss="modal">Close</button>
                  <button type="button" id="btn_process_to_arachive_request_list"  class="btn btn-primary" >Archive List</button>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>
</div>

</div>




	<jsp:include page="../includes/_footer.jsp"></jsp:include>