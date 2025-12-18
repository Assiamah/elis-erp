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
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="">Vetting and Approval</a></li>
		<li class="breadcrumb-item active">${unit_name}</li>
		
		${(view_all_offices == "Yes") ? "<li class='breadcrumb-item active text-danger'>/ Showing for all Office Locations</li>" : ""}

		<!-- <input type="hidden" id="sel_change_region_compliance" value="${regional_code}" /> -->

		
		<input id='userid' type='hidden' value='${sessionScope.userid}'/>


	</ol>



	<div class="row">
		<div class="col-lg-12">
			<!-- Example Bar Chart Card-->
			<div class="card mb-3">
				<div class="card-header bg-dark text-white">
					<i class="fa fa-bar-chart"></i>Application Details <span
						class="col-md-3 float-right ">
						<!-- <button class="btn btn-success btn-icon-split float-right "
							id="btnViewBatchlist">
							<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span
								class="text">View Batch List</span>
						</button> -->
					</span>




				</div>

				<div class="card-body">


					<!-- <div class="row">
						<div class="col-sm-6 form-row">
							<div class="col-sm-6">
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
							</div>
							<div class="col-sm-6">
								<label for="search_btn">&nbsp;</label>
								<button class="btn btn-primary btn-icon-split"
									id="btn_set_application_as_required_client_attention">
									<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span
										class="text">Add All to Batch List</span>
								</button>
							</div>
						</div>
						<div class="col-sm-6">&nbsp;</div>

					</div>
					<br>
					<br> -->

					<!--  Here is where the fee list comes -->

					<div class="table-responsive">
						<table class="table table-bordered table-hover display "
							id="job_casemgtdetailsdataTable" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>Created Date</th>
									<th>Job Number</th>
									<th>Applicant Name</th>
									<th>Application Type</th>
									<th>Status</th>
									<th>Sent By</th>
									<th>Locality</th>
									<!-- <th>View</th> -->
									<th class="to_hide_on_level_1">Work</th>

								</tr>
							</thead>

							<tbody>


								<c:forEach items="${applicationlist}" var="appfiles">
									<tr
										${appfiles.objections > 0 ? "class='bg-danger text-white red-tooltip' title='Application has pending Objections'  data-toggle='tooltip' data-placement='left' ":""}>

										<!-- <td><input type="checkbox" />
										<%-- ${applicationLoop.index + 1} --%></td> -->
                                        <td>${appfiles.created_date}</td>
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

                                        <td>${appfiles.job_forwarded_by}</td>
                                        <td>${appfiles.plot_location}</td>

										<td>
											<form action="map_plotting_application_progress_details"
												method="post">
												<input type="hidden" name="case_number" id="case_number"
													value="${appfiles.transaction_number}"> 
                                                 <input type="hidden" name="transaction_number" id="transaction_number"
													value="${appfiles.transaction_number}">
                                                <input
													type="hidden" name="job_number" id="job_number"
													value="${appfiles.job_number}"> 
                                                <input
													type="hidden" name="business_process_sub_name"
													id="business_process_sub_name"
													value="${appfiles.business_process_sub_name}">

                                                <input type="hidden" name="plotting_page_name" value="plot_vetting_and_approval" />

												<button type="submit" name="save"
													class="btn btn-danger btn-icon-split">
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
</div>

	<jsp:include page="../includes/_footer.jsp"></jsp:include>