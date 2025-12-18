<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>



<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="smdparcelinformationfirst" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">SMD Parcel</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				<input id="smd_gid_f" name="smd_gid_f" type="hidden" value="0">


				<div class="container">
					<div class="row">
						<div class="col">


							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="smd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_ref_no_f"
											readonly>
										</div>
										
									
										<div class="col">
											<label for="bl_ar_name">Locality</label> <input
											class="form-control " type="text" placeholder=""
											id="smd_locality_f"
										>
										</div>
									</div>
								</div>
								
							
							
						
							<div class="form-group">
								<label for="bl_business_process_sub_name">WKT polygon</label> <input
									class="form-control " type="text" placeholder=""
									id="smd_wkt_polygon_f"
								>
							</div>


						
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											
									
										 <input
											class="form-control " type="text" placeholder=""
											id="smd_land_size_f"
										>
									
									
										</div>
				
										<div class="col">
											<button class="btn btn-primary btn-block" id="btn_save_smd_parcel_details_f">
												<span class="text" >Save</span>
										</button>
										</div>
									</div>
								</div>

						</div>
				
					</div>

				</div>



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
	id="smdparcelinformation" role="dialog"
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
				<h4 class="modal-title custom_align" id="Heading">SMD Transaction Informations</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				<input id="smd_gid_p" name="smd_gid_p" type="hidden" value="0">


				<div class="container">
					<div class="row">
						<div class="col">


							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="smd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_ref_no"
											readonly>
										</div>
										
										<div class="col">
											<label for="bl_ar_name">Locality</label> <input
											class="form-control " type="text" placeholder=""
											id="smd_locality"
										>
										</div>
				
										
									</div>
									
									<div class="form-row">
										<div class="col">
											<label for="bl_business_process_sub_name">Plotted By</label> <input
												class="form-control " type="text" placeholder="" readonly
												id="smd_plotted_by"
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Date Plotted</label> <input
														class="form-control " type="text" placeholder=""
														id="smd_date_plott" readonly
													>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Multiple Claim</label> <input
														class="form-control " type="text" placeholder=""
														id="smd_mul_claim" readonly
													>
										</div>
				
										
									</div>
									
									<div class="form-row">
										<div class="col">
											<label for="bl_business_process_sub_name">Last Update By</label> <input
												class="form-control " type="text" placeholder=""
												id="smd_modified_by" readonly
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Date Last Updated</label> <input
														class="form-control " type="text" placeholder=""
														id="smd_modified_date" readonly
													>
										</div>
										
										
										
									</div>
								</div>
								
							
								
							
							
							
							
					
							
							


						
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											
									
									
										</div>
				
										<div class="col">
											<button class="btn btn-primary btn-block" id="btn_save_smd_parcel_details">
												<span class="text" >Save</span>
										</button>
										</div>
									</div>
								</div>

						</div>
						<div class="col">
						
						<button type="button" class="btn btn-primary btn-sm"
									data-toggle="modal" data-target="#addsmdtransaction"
								>Add New Transaction</button>



							<div class="form-group">
								<div class="table w-auto small">
									<table class="table table-bordered"
										id="smd_transaction_dataTable" width="100%" cellspacing="0"
									>

										<thead>
											<tr>

												<th>Name</th>
												<th>Grantor</th>
												<th>Multiple Claim</th>
												<th>Remarks</th>
												<th>Details</th>
											</tr>
										</thead>

										<tbody>

										</tbody>
									

									</table>
								</div>
							</div>



							<div class="form-group">
								<div class="table w-auto small">
									<table class="table table-bordered"
										id="smd_scanned_documents_dataTable" width="100%"
										cellspacing="0"
									>

										<thead>
											<tr>

												<th>Document Name</th>
												<th>Document Type</th>
												<!-- <th>Document Path</th>
												<th>Open File</th> -->
											</tr>
										</thead>

										<tbody>

										</tbody>
										

									</table>
								</div>
							</div>


						</div>
					</div>

				</div>



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
	id="addsmdtransaction" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">SMD Transaction Informations</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				
				<input id="smd_tr_gid" name="smd_tr_gid" type="hidden" value="">

            	<input id="smd_tr_t_id" name="smd_tr_t_id" type="hidden" value="0">
				
				<div class="container">
					
					
												
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_tr_reference_number"
											readonly>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">CC Number</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_tr_cc_number"
											>
										</div>
									</div>
								</div>
								
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Regional Number</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_tr_regional_number"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">Job Number</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_tr_job_number"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Applicant Name</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_tr_applicant_name"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Grantor Name</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_tr_grantor_name"
											>
										</div>
									</div>
								</div>
							
							
				
											
					
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Purpose</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_tr_purpose"
											>
										</div>
				
										 <div class="col">
											<label for="pvlmd_plot_number">Plan Number</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_tr_plan_number"
											>
										</div> 
									</div>
								</div>
								
							
							
							
								
							
							
								
								<div class="form-group">
									<div class="form-row">
									<div class="col">
											<label for="pvlmd_plot_number">Old Ref Number</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_tr_old_ref_number"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Multiple Claim Status</label> <input
												class="form-control " type="text"
												placeholder="" id="smd_tr_mul_claim"
											>
										</div>
									</div>
								</div>
							
						
											
							
						<div class="form-group">
								<label for="bl_business_process_sub_name">Remarks</label> <input
									class="form-control " type="text" placeholder=""
									id="smd_tr_remarks"
								>
							</div>
							
							
								<div class="form-row">
										<div class="col">
											<label for="bl_business_process_sub_name">Last Update By</label> <input
												class="form-control " type="text" placeholder=""
												id="smd_tr_modified_by" readonly
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Date Last Updated</label> <input
														class="form-control " type="text" placeholder=""
														id="smd_tr_modified_date" readonly
													>
										</div>
										
										
										
									</div>
							
				

				</div>

				
				

			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-success" data-dismiss="modal" id="btn_save_smd_transaction">
					<span class="glyphicon glyphicon-remove"></span>Save
				</button>


				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>


			</div>

		</div>
	</div>
</div>





