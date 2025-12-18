
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
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


<%
	
%>





<div class="container-fluid">
	<!-- Breadcrumbs-->


	<!--      <div class="row">
        <div class="panel-body-map">
                <div id="map" style="height:380px;"></div>
                
              </div>
              
              
                </div>
        -->
	<div class="row">
		<!--   Here is the right Table -->



		<!--   Here is the right Table -->
		<div class="col">
			<!-- Example Pie Chart Card-->
			<div class="card mb-3">
				<div class="card-header bg-dark text-white">
					<i class="fas fa-search"></i> Search By Job Number
				</div>
				<div class="card-body">
					<!--  The Form starts here -->
					<form action="${pageContext.request.contextPath}/search_"
						method="post" id="frmSearchbyJobNumber"
					>

						<div class="form-group">
							<div class="form-row">
								<div class="col-md-8">
									<label for="search_job_number">Job Number</label> <input
										class="form-control" id="search_job_number" 
										type="text" aria-describedby="nameHelp"
										placeholder="Enter Job Number" required
									>
									
								</div>
								<div class="col-md-4">
									<label for="search_btn"> &nbsp;</label> <input type="button"
										id="btnJobNumberSearch_mm" class="btn btn-primary btn-block"
										value="Search"
									/>

								</div>
								
								
							</div>
						</div>
					</form>

					<!-- The form Ends Hers -->

				</div>

			</div>
			<!--   Here is the end of right table -->

		</div>






	</div>

	<!--          </div> -->

	<div class="row mile_stone_details" style="display: none;">

		<div class="col-lg-12">
			<div class="card">
					<div class="card-header bg-dark text-white " role="tab"
						id="headingThree"
					>
						<a class="collapsed d-block  text-white " data-toggle="collapse"
							data-parent="#accordion" href="#collapseparties"
							aria-expanded="false" aria-controls="collapseFive"
							style="text-decoration: none !important"
						> <i class="fa fa-chevron-down pull-right"></i> <i
							class="fa fa-users"
						></i>Appplication Details
						</a>
					</div>
					<div class="card-body">

						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="bl_job_number">Job Number</label> <input
										class="form-control " type="text" placeholder=""
										id="bl_job_number_msu" readonly
									>
								</div>
							
							
								<div class="form-group">
									<label for="bl_ar_name">Applicant Name</label>
									<textarea rows="2" class="form-control" placeholder=""
										id="bl_ar_name_msu" readonly
									></textarea>
								</div>
							
								<div class="form-group">
									<label for="bl_business_process_sub_name">Application Type</label>
									<textarea rows="2" class="form-control" placeholder=""
										id="bl_business_process_sub_name_msu" readonly
									></textarea>
								</div>
							</div>
							<div class="col-md-6">
								<div class="row">
									<div class="col-lg-12">
										<!-- Example Bar Chart Card-->
										<div class="card mb-3">
											<div class="card-header">
												<i class="fa fa-bar-chart"></i>Application Milestone
											</div>
											<div class="card-body">
							
							
							
												<!--  Here is where the fee list comes -->
							
												<div class="table-responsive">
													<table class="table table-bordered"
														id="tbl_list_of_milestone_stone_dataTable"
														width="100%" cellspacing="0"
													>
														<thead>
															<tr>
																<th>Milestone Dsec</th>
																<th>Status</th>
																<th>Option</th>
							
															</tr>
														</thead>
														<!-- <tfoot>
								<tr>
								  <th>uid</th>
								  <th>User Name</th>
								</tr>
							  </tfoot> -->
														<tbody>
							
							
							
														</tbody>
													</table>
												</div>
							
												<!--  End Of Table -->
											</div>
										</div>
							
							
									</div>
								</div>
							</div>
						</div>
						<button type="button" id="btn_update_milestone_status_for_application_mm" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Update Status</button>
					</div>

			</div>
		</div>
	</div>

</div>

	<div class="row" style="display: none;">
		<div class="col-lg-12">
			<div id="accordion" role="tablist" aria-multiselectable="true">

				<div class="card">
					<div class="card-header bg-dark text-white " role="tab"
						id="headingThree"
					>
						<a class="collapsed d-block  text-white " data-toggle="collapse"
							data-parent="#accordion" href="#collapseparties"
							aria-expanded="false" aria-controls="collapseFive"
							style="text-decoration: none !important"
						> <i class="fa fa-chevron-down pull-right"></i> <i
							class="fa fa-users"
						></i>Parties
						</a>
					</div>
					<div id="collapseparties" class="" role="tabpanel"
						aria-labelledby="headingThree"
					>
						<div class="card-body">


							<button type="button" class="btn btn-primary"
								id="lrd_btn_add_parties" data-placement="top"
								data-toggle="modal" data-target="#addeditpartyGeneral"
								data-toggle="tooltip" title="Add party"
							>
								<i class="fa fa-plus-circle"></i>
							</button>

							<div class="table-responsive">
								<table class="table table-bordered  table-hover table-sm"
									id="party_details_datatable"
								>

									<thead>
										<tr>

											<th>Name</th>
											<th>Sex</th>
											<th>Contact</th>
											<th>Role</th>
											<th>Action</th>
										</tr>
									</thead>

									<tbody>
										
									</tbody>


								</table>
							</div>
						</div>
					</div>
				</div>
				<br>

				<div class="card mb-3">

					<div class="card-header bg-dark text-white " role="tab"
						id="headingTwo"
					>
						<a class="collapsed d-block  text-white " data-toggle="collapse"
							data-parent="#accordion" href="#collapsedetails"
							aria-expanded="false" aria-controls="collapseTwo"
							style="text-decoration: none !important"
						> <i class="fa fa-chevron-down pull-right"></i> <i
							class="fas fa-list"
						></i>Application Details <span id="job_number_placeholder"></span>
						</a> 
						
						
						
											
						
						
						
						<span class="col-md-3 float-right ">
							<button class="btn btn-success btn-icon-split float-right "
								id="btnViewBatchlist"
							>
								<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span
									class="text"
								>View Batch List</span>
							</button>
							
							
						</span>
					</div>
					<div select_update_case_information id="collapsedetails"
						class="collapse card-body  show" role="tabpanel"
						aria-labelledby="headingTwo"
					>
						<div class="card-body">

							<form id='frmFurtherEntries'>
								<div class="form-row"></div>
								<div class="form-row">
									
									
									
							
									<input type="hidden" id="main_service_id_fe" name="main_service_id_fe" value=""> 
									<input type="hidden" id="main_service_sub_id_fe" name="main_service_sub_id_fe" value="">
									
									
									
									
									
									
									<div class="col-md-6">
										<div class="form-group">
											<label for="inputEmail4">Job Number</label> <input
												type="text" class="form-control" id="fe_job_number"
												placeholder="Case number" required readonly
											>
										</div>
										
										
										<input id="fe_client_name" type=hidden value="" >
										<input id="febusiness_process_sub_name" type=hidden value="" >
										
										
										<div class="form-group">
											<label for="">Surveyors Number</label> <input type="text"
												class="form-control" id="fe_surveyor_number"
												placeholder="Surveyors Number"  readonly
											>
										</div>
										<div class="form-group">
											<label for="">Regional Number</label> <input type="text"
												class="form-control" id="fe_regional_number"
												placeholder="Regional Number"  
											>
										</div>


										<div class="form-group">
											<label for="">Land Size</label> 
											
											<div class="input-group">
										        <div class="input-group-prepend">
										          <span class="input-group-text" id="inputGroupPrepend">Acre</span>
										        </div>
										        <input  type="number" step=".001" class="form-control" id="fe_land_size" placeholder="size in Acreage" aria-describedby="inputGroupPrepend">
										        <div class="invalid-feedback">
										          Please enter Land Size.
										        </div>
										      </div>
										</div>

										<div class="form-group">
											
											
											<label for="">Nature of Instrument</label> <input type="text"
												class="form-control" id="fe_nature_of_instrument"
												  
											>
										</div>

							<div class="form-group">
											


										<label for="">Type of Use</label> <input type="text"
												class="form-control" id="fe_type_of_use"
												  
											>

										</div>


										<div class="form-group">
											<label for="">Type of Interest</label> <select
												class="form-control" id="fe_type_of_interest" 
											>
												<option>Select Type of Interest</option>
												<option value="LEASEHOLD">LEASEHOLD</option>
												<option value="FREEHOLD">FREEHOLD</option>
											</select>


										</div>

										
										<div class="form-group">
											<label for="">Consideration Fee</label> 
											<div class="input-group">
										        <div class="input-group-prepend">
										          <span class="input-group-text" id="inputGroupPrepend">GHS</span>
										        </div>
										        <input type="number" step=".001" class="form-control" id="fe_consideration_fee"  placeholder="amount in GHS" aria-describedby="inputGroupPrepend" value="0.00">
										        <div class="invalid-feedback">
										          Please enter Consideration.
										        </div>
										      </div>
											
											
											
										</div>
										<div class="form-group">
											<label for="">Date of Document </label> <input type="date"
												class="form-control " id="fe_date_of_document" placeholder=""
												required
											>
										</div>
										<div class="form-group">
											<label for="">Commencement Date</label> <input type="date"
												class="form-control " id="fe_commencement_date"
												placeholder="" required
											>
										</div>
										<div class="form-group">
											<label for="">Registry Map Ref.</label> 
											<input type="text" class="form-control" id="fe_registry_mapref" placeholder="">
										</div>
									</div>

									<div class="col-md-6">
										<div class="form-group">
											<label for="inputEmail4">Case Number</label> <input
												type="text" class="form-control" id="fe_case_number"
												placeholder="Case number" required readonly 
											>
										</div>

										<div class="form-group">
											<label for="">Locality</label> <input type="text" class="form-control"
												id="fe_locality"  
											>
												

										</div>
										<div class="form-group">
											<label for="">District</label> <input type="text" class="form-control"
												id="fe_district"  
											>
												

										</div>
										<div class="form-group">
											<label for="">Region</label> <input type="text" class="form-control"
												id="fe_region"  
											>
												

										</div>


										<div class="form-group">
											<label for="inputEmail4">Term </label> <input type="number"
												step=".001" class="form-control" id="fe_term" placeholder="Term"
												
											>
										</div>
										<div class="form-group">
											<label for="">Option to Renew</label> <input type="text"
												class="form-control" id="fe_renewal_term" placeholder=""
												
											>
										</div>
										<!-- <div class="form-group">
											<label for="">Lessee's Name</label> <input
												type="text"
												class="form-control"
												id="fe_lessee_name"
												placeholder=""
												required
											>
										</div>
										<div class="form-group">
											<label for="">Lesse's Address</label> <input
												type="text"
												class="form-control"
												id="fe_lessee_address"
												placeholder=""
												required
											>
										</div>
										<div class="form-group">
											<label for="">Grantor's Name</label> <input
												type="text"
												class="form-control"
												id="fe_grantor_name"
												placeholder=""
												required
											>
										</div>
										<div class="form-group">
											<label for="">Grantor's Address</label> <input
												type="text"
												class="form-control"
												id="fe_grantor_address"
												placeholder=""
												required
											> 
										</div>-->

										<input type="hidden"
												class="form-control" id="fe_family_name"
												placeholder="Stool/Family Name"  
											>
										

										<input type="hidden"
												class="form-control" id="fe_grantor_family" placeholder=""
												
											>

										<div class="form-group">
											<label for="">Extent</label> <input type="text"
												class="form-control" id="fe_extent" placeholder=""  
											>
										</div>


										<div class="form-group">
											<label for="">Annual Rent</label> 
											
											<div class="input-group">
										        <div class="input-group-prepend">
										          <span class="input-group-text" id="inputGroupPrepend">GHS</span>
										        </div>
										        <input value="0" type="number" step=".001" class="form-control" id="fe_annual_rent"  placeholder="amount in GHS" aria-describedby="inputGroupPrepend" value="o0.00">
										        <div class="invalid-feedback">
										          Please enter Rent.
										        </div>
										      </div>
										</div>
										
										
										<div class="form-group">
											<label for="inputEmail4">Transaction Number</label> <input
												type="text" class="form-control" id="fe_transaction_number"
												placeholder="Case number" required readonly
											>
										</div>
										
										<div class="form-group">
											<label for="inputEmail4">File Number</label> <input
												type="text" class="form-control" id="fe_file_number"
												placeholder="File number" required 
											>
										</div>
										
										

									</div>


								</div>



								<div class="dropdown-divider"></div>
								<div id="alert-display-space"></div>
								<div class="form-group float-right">


									<button type="reset" id="btnclearFurtherDetails"
										class="btn btn-secondary float-right"
									>Clear Changes</button>
									
									
									
									<span class="float-right">&nbsp;&nbsp;&nbsp;&nbsp;</span>
									<button type="submit" id="btnAddFurtherDetails"
										class="btn btn-success float-right"
									>Save Changes</button>
									
									
									<span class="float-right">&nbsp;&nbsp;&nbsp;&nbsp;</span>
									

										<button type="button" id="btn_Update_existing_milestone" 
										class="btn btn-primary float-right btn_Update_existing_milestone"  
										data-placement="top"
										data-toggle="modal" 
										data-target="#applicationStatusupdate"
										data-toggle="tooltip" 
										title="Update Existing Milestone"
										>Update Existing Milestone</button> 
									
									

								</div>

							</form>

							
						</div>
						
					</div>
				</div>

				<!-- Example Bar Chart Card-->




			</div>




		</div>
	</div>
















	<jsp:include page="../includes/_footer.jsp"></jsp:include>