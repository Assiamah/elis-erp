<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>


<!-- COLLECTION DETAILS============================= -->

<div class="modal fade" id="collectionModal" tabindex="-1" role="dialog"
	aria-labelledby="collectionModal" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Collection of Completed Application</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card">

							<div class="card-body">
								<form >
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Applicant Name</label>
											<textarea readonly class="form-control" id="col_applicant_name"></textarea>
										</div>
										<div class="form-row ">
											
											<div class="col">
												<label for="col_application_type" class=" col-form-label">Application Type</label> 
												<input type="text" readonly class="form-control" id="col_application_type">
											</div>
											<div class="col">
												<label for="col_application_type" class=" col-form-label">Job Number</label> 
												<input type="text" readonly class="form-control" id="col_job_number">
											</div>
											
										</div>
								</form>
							</div>
						</div>
					</div>
					
					
					<div class="col-md-12">
						<div class="card">

							<div class="card-body">
								<div id="smartwizardcollection">
									<ul>

										<li><a href="#step-1">Application Details<br /> </a></li>
										
										<li><a href="#step-2">Identity Verification<br /></a></li>
										<!-- <li><a href="#step-2">Checklist<br /></a></li> -->
										<li><a href="#step-3">Details Confirmation<br /></a></li>
										<!-- <li><a href="#step-5">Acknowledgment Slip<br /></a></li> -->

									</ul>

									<div>

										<div id="step-1" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">Application Details</h3>
											<br><br>
											<div class="row">
											
												<div class="col">
													<form>
													  <div class="form-group row">
													    <label for="staticEmail" class="col-sm-5 col-form-label">Current Division</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_division">
													    </div>
													  </div>
													  <!-- <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Job Purpose</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_job_purpose" >
													    </div>
													  </div> -->
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Job Status</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_job_status">
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Collection Status</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_collection_status" >
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Forwarded by</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_forwarded_by" >
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Date Forwarded</label>
													    <div class="col-sm-7">
													      <input type="date" readonly  class="form-control" id="col_date_forwarded" >
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Current Officer</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_current_officer" >
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Received By</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_received_by" >
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Received Date</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_received_date" >
													    </div>
													  </div>
													</form>
												</div>
												
												<div class="col">
													<form>
													  <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Cabinet Name</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_carbinet">
													    </div>
													  </div>
													  <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Shelve Number</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_shelve" >
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Is Filed</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_filed">
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Filed Date</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_filed_date" >
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Batch Number</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_batchnumber" >
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Date Batched</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_batched_date" >
													    </div>
													  </div>
													   <div class="form-group row">
													    <label class="col-sm-5 col-form-label">Batched By</label>
													    <div class="col-sm-7">
													      <input type="text" readonly  class="form-control" id="col_batched_by" >
													    </div>
													  </div>
													   
													</form>
												</div>
												
											
											</div>
										</div>
										
										
										<div id="step-2" class="">
											<br>
											<h3 class="border-bottom border-gray pb-2">Confirm Identity</h3>
											<div class="">
												<table class="table table-bordered text-center" id="collection-parties">
													<thead>
														<tr>
															<th>Name</th>
															<th>Gender</th>
															<th>Contact</th>
															<th>ID Type</th>
															<th>ID Number</th>
															<th>Applicant Type</th>
														</tr>
													</thead>
													<tbody></tbody>
				
												</table>
											
											</div>
										</div>
										
										<div id="step-3" class="">
											<br>
											<form id="frmSaveCollection" class="col-7">
												<h3 class="border-bottom border-gray pb-2">Collection Checklist</h3>
												<div class="">
													<table class="table table-bordered" id="collection-checklist"  >
														<thead>
															<tr>
																<th>Description</th>
																<th>Confirm</th>
															</tr>
														</thead>
														<tbody></tbody>
					
													</table>
												
												</div>
												<br>
												
												<br>
												<h3 class="border-bottom border-gray pb-2">Details Confirmation</h3>
												 <div class="form-group row">
												    <label class="col-sm-3 col-form-label">Collected by: </label>
												    <div class="col-sm-9">
												      <input type="text"  required class="form-control" id="col_collected_by">
												    </div>
												  </div>
												  <div class="form-group row">
												    <label class="col-sm-3 col-form-label">ID Type: </label>
												    <div class="col-sm-9">
												    	<select id="col_id_type" required  class="form-control" >
												    		<option value="NATIONAL ID">NATIONAL ID</option>
												    		<option value="PASSPORT">PASSPORT</option>
												    		<option value="DRIVERS LICENSE">DRIVERS LICENSE</option>
												    		<option value="NHIS CARD">NHIS CARD</option>
												    		<option value="VOTERS ID">VOTERS ID</option>
												    		<option value="SSNIT ID CARD">SSNIT ID CARD</option>
												    	</select>
												    </div>
												  </div>
												  <div class="form-group row">
												    <label class="col-sm-3 col-form-label">ID Number: </label>
												    <div class="col-sm-9">
												      <input type="text" required  class="form-control" id="col_id_number">
												    </div>
												  </div>
												  <div class="form-group row">
												    <label class="col-sm-3 col-form-label">Phone Number: </label>
												    <div class="col-sm-9">
												      <input type="text" required  class="form-control" id="col_phone_number">
												    </div>
												  </div>
												  
												  <div class="form-group row">
												    <label class="col-sm-5 col-form-label">&nbsp; </label>
												    <div class="col-sm-7">
												      <input type="submit" value="Save" class="btn btn-lg btn-primary" style="width:100%">
												    </div>
												  </div>
												  
												
											</form>
										</div>
										
										
										
									</div>
								</div>
							</div>
						</div>




					</div>
					
					



				</div>


			</div>
		</div>
	</div>
</div>




<!-- CABINET DETAILS============================= -->

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




	
	<div class="modal fade" id="collectionForPayment" tabindex="-1" role="dialog"
	aria-labelledby="collectionForPayment" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Collection for  Payment</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Job Number</label> <input
						class="form-control " type="text" placeholder=""
						id="cfp_job_number" readonly
					>
				</div>


				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					
					<input
						class="form-control " type="text" placeholder=""
						id="cfp_ar_name" 
					>
					
				</div>

				
				
				<div class="form-group">
					<label for="bl_business_process_sub_name">Collector' Name</label>
					 <input
						class="form-control " type="text" placeholder=""
						id="cfp_collectors_name"
					>
				</div>
				
				
				<div class="form-group">
					
					 <label>ID Type</label>    
                                    <select class="custom-select mb-1" id="cfp_id_type" name="cfp_id_type">
                                       <option></option>
                                       <option>Ghana Card</option>
                                       <option>Passport</option>
                                       <option>Drivers License</option>
                                       <option>Voters ID</option>
                                       <option>NHIS</option>
                                    </select>
					
				</div>
				
					
				<div class="form-group">
					<label for="bl_business_process_sub_name">ID Number</label>
					 <input
						class="form-control " type="text" placeholder=""
						id="cpf_id_number"
					>
				</div>
			
				
				<div class="form-group">
					<label for="bl_business_process_sub_name">Phone Number</label>
					 <input
						class="form-control " type="text" placeholder=""
						id="cpf_collectors_phone"
					>
				</div>
			
			<div class="form-group">
					<label for="bl_business_process_sub_name">Purpose</label>
					 <input
						class="form-control " type="text" placeholder=""
						id="cpf_collection_purpose"
					>
				</div>
			
				


			<!-- 	<div class="form-group">
					
					<iframe src=""  id="cpfblobfile" width="100%" height="300"></iframe>

				</div>
 -->
				


			</div>
			<div class="modal-footer ">

					
			<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>
				
						
			<div class="my-2"></div>
				<!-- <a href="#" data-dismiss="modal"
					class="btn btn-info btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-save"></i>
				</span> <span class="text">Close</span>

				</a> -->
				<button type="button" id="btn_cpf_save_comment" class="btn btn-primary">Save</button>

			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>




<div class="modal fade" id="BachlistModal" tabindex="-1" role="dialog"aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addMinutesModalLabel">Tracking For Batchlist : <span id="batchlist_value"></span></h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-header">History</div>
							<div class="card-body">
								<table class="table table-bordered" id="tbl_batchlist_history">
									<thead>
										<tr>
											<th>Client Name</th>
											<th>Job Number</th>
											<th>Batch Purpose</th>
											<th>Sent By</th>
											<th>Received By</th>
											<th>Date</th>
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




<div class="modal fade" id="filelistModal" tabindex="-1" role="dialog"aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addMinutesModalLabel">Tracking For File History </h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-header">History</div>
							<div class="card-body">
								<table class="table table-bordered" id="tbl_file_history">
									<thead>
										<tr>
											<th>Date</th>
											<th>Division</th>
											<th>Received by</th>
											<th>Sent By</th>
											
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


	