
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


<jsp:include
	page="../client_application/_application_process_header.jsp"
></jsp:include>




<!-- wizard start wizard end -->


<!-- smartwizardfirstregistration html -->
<div id="smartwizardfirstregistration">
	<ul class="d-none">

		<!-- <li><a href="#link-1">Inspection<br /> <small>Inspection</small></a></li> -->
		<li><a href="#link-1">Assessment<br /> <small>Assessment</small></a></li>
		<li><a href="#link-2">Embossment after Payment<br /> <small>Embossment after Payment</small></a></li>

	</ul>
	<div>





		<%-- <div id="link-1" class="">
			<br>
			<h3 class="border-bottom border-gray pb-2">Inspection
				Information</h3>

			<div class="row">
				<!--   Here is the right Table -->
				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Verify Site (If Inspection is
							needed)
						</div>
						<div class="card-body">
							<!--  The Form starts here -->
							<form
								action="${pageContext.request.contextPath}/processing_after_payment"
								method="post"
							>

								<!-- Maps Details Starts Here  -->
								<div class="bs-example">





									<div class="btn-group mr-2">
										<button type="button" class="btn btn-primary"
											id="btn_lcfrfa_lc_btn_visualise_wkt" data-placement="top"
											data-toggle="tooltip" title="Visualise Polygon"
										>
											<i class="fa fa-map"></i>
										</button>
										<!--  
          <button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
            <i class="fa fa-save"></i>
        </button>
        -->

										<button type="button" class="btn btn-primary"
											id="btn_lcfrfa_lc_btn_visualise_search" data-placement="top"
											data-toggle="tooltip" title="Visualise Search"
											style="display: none"
										>
											<i class="fa fa-object-ungroup"></i>
										</button>


										<button type="button" class="btn btn-primary"
											id="btn_lcfrfa_lc_btnprintmap" data-placement="top"
											data-toggle="tooltip" title="Visualise Polygon"
											style="display: none"
										>
											<i class="fa fa-print"></i>
										</button>
									</div>











								</div>






								<div id="lcfrfa-map"></div>



							</form>

							<!-- The form Ends Hers -->

						</div>

					</div>
					<!--   Here is the end of right table -->

				</div>

				<div class="col-lg-8">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Verify Site (If Inspection is
							needed)
						</div>
						<div class="card-body">
							<!--  The Form starts here -->
							<!--   <form action="" > -->

							<div class="form-group">


								<div class="form-row" style="display: none;">

									<div class="col-md-12">

										<label for="bl_job_purpose">WKT Polygon</label>


									</div>
								</div>
								<input class="form-control" id="lc_fr_bl_wkt_polygon"
									name="lc_fr_bl_wkt_polygon" type="hidden"
									aria-describedby="nameHelp" placeholder="Enter Consideration"
									value="${parcel_wkt}"
								>

								<!--   <div class="form-row">
				              
				              <div class="col-md-12">
				              
				                <input type="button" id="lc_btn_activate_final_registration_confirm" class="btn btn-primary btn-block" value="Request Surveyor's Signature" />  
				                
				                </div>
				            </div>
				             -->

								<div class="form-row">

									<div class="col-md-12">

										<form
											action="${pageContext.request.contextPath}/GenerateCaseReports"
											method="post" target="_blank"
										>
											<input type="hidden" id="case_number" name="case_number"
												value="${transaction_number}"
											> 
											<input type="hidden" id="job_number" name="job_number"
												value="${job_number}"
											> <input type="hidden" id="ir_business_process_id"
												value="${business_process_id}"
											> <input type="hidden" id="ir_business_process_name"
												value="${business_process_name}"
											> <input type="hidden" id="ir_business_process_sub_id"
												value="${business_process_sub_id}"
											> <input type="hidden" id="ir_business_process_sub_name"
												value="${business_process_sub_name}"
											> <input type="hidden" id="request_type" name="request_type"
												value="request_to_generate_inspection_letter"
											>
											<div class="form-group">
												<div class="form-row">
													<div class="col-md-12">
														<label for="bl_job_purpose">Select Type of Letter</label>
													</div>

													<div class="col-md-8">

														<select name="lc_letter_type" id="lc_letter_type"
															data-live-search="true"
															data-none-results-text="I found no results"
															title="Please select Letter type"
															class="form-control  selectpicker"
														>
															<option value="Inspection Lette">Inspection
																Letter</option>
															<option value="Discussion Letter">Discussion
																Letter</option>
														</select>
													</div>

													<div class="col-md-4">
														<button type="submit" name="save"
															class="btn btn-info btn-icon-split"
														>
															<span class="icon text-white-50"> <i
																class="fas file-alt"
															></i></span><span class="text">Generate</span>
														</button>
													</div>


												</div>


											</div>

										</form>

									</div>
								</div>




							</div>
							<!-- </form> -->

							<!-- The form Ends Hers -->

						</div>

					</div>
					<!--   Here is the end of right table -->

				</div>
				<div class="col-sm-4">
					<div class="card mb-3">
						<div class="card-header">
							<i class="fas fa-file-o"></i> &nbsp;

						</div>
						<div class="card-body">
							<br>
							<button type="button"
								class="btn btn-primary btn-icon-split float-right"
								id="lrd_btn_add_querys" data-placement="top" data-toggle="modal"
								data-target="#assignInspectionModal"
							>
								<span class="icon text-white-50"> <i
									class="fa fa-plus-circle"
								></i></span><span class="text">Assign For Inspection</span>
							</button>
							<br>
							<br> &nbsp;
						</div>
					</div>
				</div>
			</div>



			<div class="row">
				<!--   Here is the right Table -->


				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fas fa-file-o"></i>Inspection Reports

						</div>
						<div class="card-body">
							<!--  The Form starts here -->
							<div id="alert-display-space"></div>


							<table class="table">
								<thead>
									<tr>
										<th>Date</th>
										<th>Officer (Requested)</th>
										<th>Officer (Inspection)</th>
										<th>Purpose</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${case_inspections}" var="case_inspections_row">
									                <tr>
									                    <td>${case_inspections_row.inspection_date}</td>
									                    <td>${case_inspections_row.requested_by}</td>
									                    <td>${case_inspections_row.created_by}</td>
									                    <td>${case_inspections_row.inspection_purpose}</td>
									                    
									                    <td>
										      					<button type="button" id="btn-view-inpection-report"  data-toggle="modal" data-target="#viewInspectionReportModal"  class="btn btn-primary btn-icon-split "  title="View Inspection Report" >
													    			<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
													    		</button> 
											    		</td>
									                 </tr>
									             </c:forEach>
								</tbody>
							</table>

							 <form action=""  method="post" id="form_inspection">
										<input type="hidden" id="case_number" name="case_number" value="${case_number}" >
										<input type="hidden" id="job_number" name="job_number" value="${job_number}">
										<input type="hidden" id="fullname" name="case_number" value="${fullname}" >
										<input type="hidden" id="userid" name="job_number" value="${userid}">	
										
										<div class="form-group">
									        <div class="form-row">  <label for="report_title">Report Title</label>
									        	<input class="form-control" placeholder="" id="report_title" name="report_title" required>
									        </div>
								        </div>
										<div class="form-group">
									        <div class="form-row">  <label for="inspection_report">Inspection Report Description</label>
									        	<textarea required rows="7" class="form-control" placeholder="" id="inspection_report" name="inspection_report"></textarea>
									        </div>
								        </div>
										
								        <div class="form-group">
							          		<div class="col-md-4 float-right">
							          			<button type="submit" name="save" class="btn btn-info btn-icon-split" id="btninsert_report_details" >
					                   				<span class="icon text-white-50"> <i class="fas fa-check"></i></span><span class="text">Save</span>
					                   			</button>
							                </div>
							            </div>
						            
						        </form>

						</div>
					</div>
				</div>
			</div>
		</div> --%>

		<div id="link-1" class="">
			<br>
			<h3 class="border-bottom border-gray pb-2">Stamp Duty Assessment</h3>
			<div class="row">




				<!--   Here is the right Table -->
				

				<!--   Here is the right Table -->
				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-10">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Stamp Duty
						</div>
						<div class="card-body">
							<!--  The Form starts here -->
							<div id="alert-display-space"></div>
							<form action="" method="post" id="form_assessment">


								<div id="alert-display-space1"></div>
								<!-- <div class="form-group row">

									<label for="adopted_value" class="col-sm-4 col-form-label"
										style="text-align: right"
									>Adopted Land Value /acre :</label>
									<div class="col-sm-5">

										<div class="input-group mb-2">
											<div class="input-group-prepend">
												<div class="input-group-text">GHS</div>
											</div>
											<input value="" step="0.1" type="text" id="adopted_value"
												name="adopted_value" class=" form-control  " 
												required placeholder="Adopted Value"
											>
										</div>


									</div>
								</div> -->
								<div class="form-group row">
									<label for="assessed_value" class="col-sm-4 col-form-label"
										style="text-align: right"
									>Assessed Value <span class="text-danger">*</span>:</label>
									<div class="col-sm-5">
										<div class="input-group mb-2">
											<div class="input-group-prepend">
												<div class="input-group-text">GHS</div>
											</div>
											<input value="${assessed_value}" step="0.1" type="text"
												name="assessed_value" id="assessed_value"
												class=" form-control  "  required
												placeholder="Assessed Value"
											>
										</div>


									</div>
								</div>

								<div class="form-group row">
									<label for="stamp_duty" class="col-sm-4 col-form-label"
										style="text-align: right"
									>Stamp Duty Payable <span class="text-danger">*</span>:</label>
									<div class="col-sm-5">

										<div class="input-group mb-2">
											<div class="input-group-prepend">
												<div class="input-group-text">GHS</div>
											</div>
											<input value="${stamp_duty_payable}"  type="text"
												id="stamp_duty" name="stamp_duty" class=" form-control  "
												 required placeholder="Stamp Duty Payable"
											>
										</div>


									</div>
								</div>
								<div class="form-group row">
									<label for="assessed_comment" class="col-sm-4 col-form-label "
										style="text-align: right"
									>Comments <span class="text-danger">*</span>:</label>
									<div class="col-sm-5">
										<textarea name="assessed_comment" id="assessed_comment"
											class=" form-control  " required
										>   </textarea>
									</div>
								</div>
								<div class="form-group row">
									<label for="assessed_value" class="col-sm-5 col-form-label">
									</label>
									<div class="form-row ">
										<div class="col-sm-6">
											<button type="submit" name="submit_assessment"
												id="submit_assessment"
												class="btn  btn-primary btn-icon-split"
											>
												<span class="icon text-white-50"> <i
													class="fas fa-check col-sm-12"
												></i></span><span class="text">Save</span>
											</button>
										</div>
										<div class="col-sm-6">
											<button type="button" name="submit_print_stamp_bill"
												id="submit_print_stamp_bill"
												class="btn  btn-warning btn-icon-split"
											>
												<span class="icon text-white-50"> <i
													class="fas fa-print col-sm-12"
												></i></span><span class="text">Print</span>
											</button>


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
		</div>

		<div id="link-2" class="">
			<br>
			<h3 class="border-bottom border-gray pb-2">Embossment after
				Payment</h3>

			<div class="row">

				<!--   Here is the right Table -->
				<div class="col-lg-8">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Embossment after Payment
						</div>
						<div class="card-body">
							<div id="alert-display-space2"></div>
							<!--  The Form starts here -->
							<!--   <form   method="post" class="form-inline" id="form_embossment">
										<input type="hidden" id="case_number" name="case_number" value="LCGARGAPCN716053920190" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_inspection_letter">
								          
								              
								              
								              	<input type="text"  class="form-control form-control-plaintext" id="staticEmail" value="Is document embossed?">
								                <button type="submit" name="submit_embossment" id="submit_embossment" class="btn  btn-primary btn-icon-split form-control"  >
									    			<span class="icon text-white-50"> <i class="fas fa-check col-sm-12"></i></span><span class="text">Confirmed</span>
									    		</button>
									    		
								             
								            
								        </form>
								         -->


							<button type="button" name="btn_submit_embossment"
								id="btn_submit_embossment"
								class="btn  btn-primary btn-icon-split form-control"
							>
								<span class="icon text-white-50"> <i
									class="fas fa-check col-sm-12"
								></i></span><span class="text">Confirmed</span>
							</button>

							<!-- The form Ends Hers -->

						</div>

					</div>
					<!--   Here is the end of right table -->

				</div>


				<!--   Here is the right Table -->


				<!--   Here is the right Table -->


			</div>

		</div>






	</div>

</div>



<jsp:include
	page="../client_application/_application_process_footer.jsp"
></jsp:include>

