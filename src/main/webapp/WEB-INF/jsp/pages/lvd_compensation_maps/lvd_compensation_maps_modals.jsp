<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>






<!-- Add LRD Transaction -->


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="compparcelinformation" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">LVD Compensation Claim</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">



				<form method="POST" action="Maps" target="_blank" id="downloadForm">
					<input type="hidden" name="cc_id" id="cc_id"
						
					> 

					
					<div class="container">
						<div class="row">
							<div class="col">
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="bl_job_number">Claim No</label> 
											<input
										class="form-control " type="text" placeholder=""
										id="cc_claim_no">
										</div>
										
										<div class="col">
											<label for="bl_ar_name">Claimant</label>
							
											<input
												class="form-control " type="text" placeholder=""
												id="cc_claimant"
											>
										</div>
									</div>
								</div>
								
								
								
									<div class="form-group">
									<div class="form-row">
										<div class="col">
												<label for="bl_business_process_sub_name">File No</label>
									
											
											<input
												class="form-control " type="text" placeholder=""
												id="cc_file_no"
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Plan No</label> <input
										class="form-control " type="text" placeholder=""
										id="cc_plan_no"
										>
										</div>
									</div>
								</div>
								
								
								
									<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="bl_ar_name">Locality</label>
								
												<input
													class="form-control " type="text" placeholder=""
													id="cc_locality"
												>
										</div>
										
										<div class="col">
											<label for="cbl_source_data">Land Size</label>
							
											<input
												class="form-control " type="text" placeholder=""
												id="cc_land_size"
											>
										</div>
									</div>
								</div>
								
								
								
								<div class="form-group">
									<label for="bl_ar_name">Remarks</label>
									<textarea rows="2" class="form-control" placeholder=""
										id="cc_remarks"
									></textarea>
								</div>
								
								
			


							</div>



						


						


						</div>

					</div>

				</form>

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




<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="newcomparableconstructionaldetails" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">LVD
					Constructional Details</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">



				<form method="POST" action="Maps" target="_blank" id="downloadForm">
					<input type="hidden" name="cbl_parcel_uuid" id="cbl_parcel_uuid"
						
					> 
					
					
					<th>Floor Details</th>
												<th>Walls Details</th>
												<th>Doors Details</th>
												<th>Windows Details</th>


					<div class="container">
						<div class="row">
							<div class="col">

				
				
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="bl_job_number">Job Number </label> <input
										class="form-control " type="text" placeholder=""
										id="cbl_job_no">
										</div>
										
										<!-- <div class="col">
											<label for="bl_ar_name">Transaction Date</label>
							
											<input
												class="form-control " type="text" placeholder=""
												id="cbl_transaction_date"
											>
										</div> -->
									</div>
								</div>
								
								
								
									<div class="form-group">
									<div class="form-row">
										<div class="col">
												<label for="bl_business_process_sub_name">Floor Details</label>
									
											
											<input
												class="form-control " type="text" placeholder=""
												id="cbl_accreage_size_of_land"
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Walls Details</label> <input
										class="form-control " type="text" placeholder=""
										id="cbl_confirmed_acre_size"
										>
										</div>
									</div>
								</div>
								
								
								
									<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="bl_ar_name">Doors Details</label>
								
												<input
													class="form-control " type="text" placeholder=""
													id="cbl_unexpired_term"
												>
										</div>
										
										<div class="col">
											<label for="cbl_source_data">Windows Details</label>
							
											<input
												class="form-control " type="text" placeholder=""
												id="cbl_source_data"
											>
										</div>
									</div>
								</div>
								
												
								<div class="form-group">
									<label for="bl_ar_name">ceiling_details</label>
									<textarea rows="2" class="form-control" placeholder=""
										id="cbl_prominent_landmarks"
									></textarea>
								</div>
								
								
								
									<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="bl_job_number">roof_details</label> <input
												class="form-control " type="text" placeholder=""
												id="cbl_value_of_property"
											>
										</div>
										
										<div class="col">
											<label for="cbl_type_of_house">other_details</label>
												
													
													<input
														class="form-control " type="text" placeholder=""
														id="cbl_type_of_house"
													>
										</div>
									</div>
								</div>
								
								
								

							</div>



							<!--  Second Column-->

							<div class="col">

												
												
								
								
									<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="bl_job_number">house_type </label> <input
														class="form-control " type="text" placeholder=""
														id="cbl_locality"
													>
										</div>
										
										<div class="col">
											<label for="bl_ar_name">external_works</label>
													
													<input
														class="form-control " type="text" placeholder=""
														id="cbl_type_of_use"
													>
										</div>
									</div>
								</div>
								
								
												<div class="form-group">
													<label for="bl_business_process_sub_name">gross_external_area</label>
													<textarea rows="2" class="form-control" placeholder=""
														id="cbl_property_owner"
													></textarea>
												</div>
												
								
				
												
											
											
												
												<div class="form-group">
													<label for="bl_business_process_sub_name">General Comment</label>
													<textarea rows="2" class="form-control" placeholder=""
														id="cbl_general_omment"
													></textarea>
												</div>
												
												<div class="form-group">
													<div class="form-row">
														<div class="col">
															
														</div>
														
														<div class="col">
															
														</div>
													</div>
												</div>
								
												
												
												
												<div class="form-group">
													
													<button type="button"
									id="btn_save_constructional_comparable_main_changes"
									class="btn btn-primary"
								>Save Changes</button>
												</div>
												
												
						
								
																

							</div>



						


						</div>

					</div>

				</form>

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





<!-- Add LRD Transaction -->


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="newcomparabledatapoint" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">LVD
					Constructional Details</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">



				<form method="POST" action="Maps" target="_blank" id="downloadForm">
					<input type="hidden" name="cbl_parcel_uuid_point" id="cbl_parcel_uuid_point"
						
					> 


					<div class="container">
						<div class="row">
							<div class="col">

								<div class="form-group">
									<label for="bl_job_number">Job Number </label> <input
										class="form-control " type="text" placeholder=""
										id="cbl_job_no_point"
									>
								</div>
				
				
								<div class="form-group">
									<label for="bl_ar_name">Transaction Date</label>
							
									<input
										class="form-control " type="text" placeholder=""
										id="cbl_transaction_date_point"
									>
								</div>
				
								<div class="form-group">
									<label for="bl_business_process_sub_name">Land Size</label>
									
									
									<input
										class="form-control " type="text" placeholder=""
										id="cbl_accreage_size_of_land_point"
									>
								</div>
				
				
					<div class="form-group">
									<label for="bl_job_number">Confirmed Land Size </label> <input
										class="form-control " type="text" placeholder=""
										id="cbl_confirmed_acre_size_point"
									>
								</div>
				
				
								<div class="form-group">
									<label for="bl_ar_name">Unexpired Term</label>
								
									<input
										class="form-control " type="text" placeholder=""
										id="cbl_unexpired_term_point"
									>
								</div>
				
								<div class="form-group">
									<label for="cbl_source_data">Data Source</label>
							
									<input
										class="form-control " type="text" placeholder=""
										id="cbl_source_data_point"
									>
								</div>
				
				
					<div class="form-group">
									<label for="bl_job_number">Property Value</label> <input
										class="form-control " type="text" placeholder=""
										id="cbl_value_of_property_point"
									>
								</div>
				
				
								<div class="form-group">
									<label for="bl_ar_name">Prominent Landmarks</label>
									<textarea rows="2" class="form-control" placeholder=""
										id="cbl_prominent_landmarks_point"
									></textarea>
								</div>



							</div>



							<!--  Second Column-->

							<div class="col">

								
												<div class="form-group">
													<label for="cbl_type_of_house_point">Type of House</label>
												
													
													<input
														class="form-control " type="text" placeholder=""
														id="cbl_type_of_house_point"
													>
												</div>
								
								
								
									<div class="form-group">
													<label for="bl_job_number">Locality </label> <input
														class="form-control " type="text" placeholder=""
														id="cbl_locality_point"
													>
												</div>
								
								
												<div class="form-group">
													<label for="bl_ar_name">Type of Use</label>
													
													<input
														class="form-control " type="text" placeholder=""
														id="cbl_type_of_use_point"
													>
												</div>
								
												<div class="form-group">
													<label for="bl_business_process_sub_name">Property Owner</label>
													<textarea rows="2" class="form-control" placeholder=""
														id="cbl_property_owner_point"
													></textarea>
												</div>
												
												
												<div class="form-group">
													
													<button type="button"
									id="btn_save_comparable_main_changes_point"
									class="btn btn-primary"
								>Save Changes</button>
												</div>
												
												
												<div class="form-group">
							
							<label for="bl_ar_name">Constructional Details</label>
												
						<button type="button" class="btn btn-primary"  id="add_new_constructional_details_point" data-placement="top" data-toggle="modal" data-target="#newcomparabledata" data-toggle="tooltip" title="Upload CSV">
				            <i class="fa fa-map-marker"></i>
				        </button>
        
								<div class="table w-auto small">
									<table class="table table-bordered"
										id="lvd_construcctional_details_dataTable" width="100%" cellspacing="0"
									>

										<thead>
											<tr>

												<th>Floor Details</th>
												<th>Walls Details</th>
												<th>Doors Details</th>
												<th>Windows Details</th>
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
												
								
																

							</div>



						


						</div>

					</div>

				</form>

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





     



