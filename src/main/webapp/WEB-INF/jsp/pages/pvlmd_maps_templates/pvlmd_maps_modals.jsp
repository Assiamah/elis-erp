<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>



<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="pvlmdparcelinformation" role="dialog"
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
				<h4 class="modal-title custom_align" id="Heading">PVLMD
					Parcel Info</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				<input id="pvlmd_gid" name="pvlmd_gid" type="hidden" value="">


				<div class="container">
					<div class="row">
						<div class="col">


							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_reference_number"
											readonly>
										</div>
										
										<div class="col">
											<label for="pvlmd_file_number">NT Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_nt_number"
											readonly>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">File Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_file_number"
											>
										</div>
									</div>
								</div>
								
							
							<!-- 	<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">CRO Reference</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_cro_reference"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">Property Number (GARRO)</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_property_number"
											>
										</div>
									</div>
								</div> -->
							
							
						
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Sheet Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_sheet_number"
											>
										</div>
				
										<div class="col">
											<label for="bl_ar_name">Locality</label> <input
												class="form-control " type="text" placeholder=""
												id="pvlmd_locality"
											>
										</div>
									</div>
								</div>
							

							<div class="form-group">
								<label for="bl_business_process_sub_name">Remarks</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_remarks"
								>
							</div>
							
							
							<div class="form-row">
										<div class="col">
											<label for="bl_business_process_sub_name">Last Update By</label> <input
												class="form-control " type="text" placeholder=""
												id="pvlmd_modified_by" readonly
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Date Last Updated</label> <input
														class="form-control " type="text" placeholder=""
														id="pvlmd_modified_date" readonly
													>
										</div>
										
										
										
									</div>


						
								<div class="form-group">
									<div class="form-row">
										<div class="col to_hide_on_level_1">
											
										<button type="button" class="btn btn-danger to_hide_on_level_1"  id="pvlmd_tr_btn_delete_parcel">
										<span class="glyphicon glyphicon-remove"></span>Delete
									</button>
														
									
										</div>
				
										<div class="col">
											<button class="btn btn-primary btn-block" id="btn_save_pvlmd_parcel_details">
												<span class="text" >Save</span>
										</button>
										</div>
									</div>
								</div>



						</div>
						<div class="col">
							<div class="btn-group" role="group"
								aria-label="Vertical button group"
							>
								<button type="button"
									class="btn btn-blue  btn-lg btn-md btn-sm "
								>
									<span class="fa fa-plus-circle"></span>
								</button>
							
								<button type="button" class="btn btn-primary btn-sm"
									data-toggle="modal" data-target="#addpvlmdtransactionlong"
								>Add New Transaction</button>
								
								
								<button type="button" class="btn btn-success btn-sm"
									data-toggle="modal" data-target="#addpvlmdtransactionshort"
								>Add New Short Transaction</button>

							</div>


							<div class="form-group">
								<div class="table w-auto small">
									<table class="table table-bordered"
										id="pvlmd_transaction_dataTable" width="100%" cellspacing="0"
									>

										<thead>
											<tr>

												<th>Name</th>
												<th>Grantor</th>
												<th>Reference Number</th>
												<th>Instrument Type</th>
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


							<div class="form-group">
								<div class="table w-auto small">
									<table class="table table-bordered"
										id="lrd_scanned_documents_dataTable" width="100%"
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



			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				<input type="hidden" id="lrd_ps_fid" name="lrd_ps_fid">
			</div>

		</div>
	</div>
</div>




<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="pvlmdparcelinformationfirsttimesave" role="dialog"
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
				<h4 class="modal-title custom_align" id="Heading">PVLMD
					Parcel Info</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number_fts">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_reference_number_fts"
											readonly>
										</div>
										
									</div>
								</div>
								<div class="form-group">
									<div class="form-row">
										
										<div class="col">
											<label for="pvlmd_file_number">NT Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_nt_number_fts"
											readonly>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">File Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_file_number_fts"
											>
										</div>
									</div>
								</div>
								
							
						
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Sheet Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_sheet_number_fts"
											>
										</div>
				
										<div class="col">
											<label for="bl_ar_name">Locality</label> <input
												class="form-control " type="text" placeholder=""
												id="pvlmd_locality_fts"
											>
										</div>
									</div>
								</div>
							

							<div class="form-group">
								<label for="bl_business_process_sub_name">Remarks</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_remarks_fts"
								>
							</div>
							
							
							<div class="form-group">
								<label for="bl_parcelwkt">Parcel WKT</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_parcel_wkt_to_plot_fts"
								>
							</div>


						
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											
									
									
										</div>
				
										<div class="col">
											<button class="btn btn-primary btn-block" id="btn_save_pvlmd_parcel_details_fts">
												<span class="text" >Save</span>
										</button>
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






<!-- Add LRD Transaction -->


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="addpvlmdtransactionlong" role="dialog"
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
				<h4 class="modal-title custom_align" id="Heading">PVLMD Transaction Informations</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				
				<input id="pvlmd_gid" name="pvlmd_tr_gid" type="hidden" value="">
			<input id="pvlmd_tr_t_id" name="pvlmd_tr_t_id" type="hidden" value="0">


				<div class="container">
					<div class="row">
						<div class="col">


							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_reference_number"
											readonly>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">File Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_file_number"
											>
										</div>
									</div>
								</div>
								
		
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_property_number"
											>
										</div>
				
				
										<div class="col">
											<label for="pvlmd_file_number">NT Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_nt_number"
											>
										</div>
										
									</div>
								</div>
							
							
						
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Mutation Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_mutation_number"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Deed Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_deed_number"
											>
										</div>
									</div>
								</div>
								
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Serial Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_serial_number"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Sheet Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_sheet_number"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Plan Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_plan_number"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Plot Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_plot_number"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">LVD Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_lvb_number"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Document Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_doc_number"
											>
										</div>
									</div>
								</div>
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party1/Plaintiff</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plaintiff"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party1/Plaintiff Tel No</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plaintiff_tel_no"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party1/Plaintiff Address</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plantiff_add"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party1/Plaintiff E-mail</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plaintiff_email"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party2/Defendant</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party2/Defendant Tel No</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_tel_no"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party2/Defendant E-mail</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_email"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party2/Defendant Address</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_add"
											>
										</div>
									</div>
								</div>
								
								
									<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Instrument Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_instrument_date"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Instrument Type</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_instrument_type"
											>
										</div>
									</div>
								</div>
	
						</div>
						<div class="col">
									
								
								
							
							<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Term</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_term"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Commencement Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_commencement_date"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Purpose</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_purpose"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Consent Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_consent_date"
											>
										</div>
									</div>
								</div>
								
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Consideration</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_consideration"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Consideration Currency</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_consideration_currency"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Premium</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_premium"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Premium Currency</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_premium_currency"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Compensation Status</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_compensation_status"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Suit Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_suit_number"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Floor Level</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_floor_level"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Apartment Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_apartment_number"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Rent</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_rent"
											>
										</div>
										
										<div class="col">
											<label for="pvlmd_tr_submission_date">Submission Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_submission_date"
											>
										</div>
				
										
									</div>
								</div>
								
								
								
								
							<div class="form-group">
								<label for="bl_business_process_sub_name">Unit Description</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_tr_unit_description"
								>
							</div>

							<div class="form-group">
								<label for="bl_business_process_sub_name">Judgement in Favour of</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_tr_judgement_in_favour_of"
								>
							</div>
							
							
						<div class="form-group">
								<label for="bl_business_process_sub_name">Remarks</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_tr_remarks"
								>
							</div>
							
							
							
						
						<div class="form-row">
										<div class="col">
											<label for="bl_business_process_sub_name">Last Update By</label> <input
												class="form-control " type="text" placeholder=""
												id="pvlmd_tr_modified_by" readonly
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Date Last Updated</label> <input
														class="form-control " type="text" placeholder=""
														id="pvlmd_tr_modified_date" readonly
													>
										</div>
										
										
										
									</div>

					


						</div>
					</div>

				</div>

				
				

			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

	            <button type="button" class="btn btn-success"  id="pvlmd_tr_btn_save_transaction_long">
					<span class="glyphicon glyphicon-remove"></span>Save
				</button>
				
				<button type="button" class="btn btn-danger to_hide_on_level_1"  id="pvlmd_tr_btn_delete_transaction_long">
					<span class="glyphicon glyphicon-remove"></span>Delete
				</button>


				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>


			</div>

		</div>
	</div>
</div>



<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="addpvlmdtransactionlong_t" role="dialog"
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
				<h4 class="modal-title custom_align" id="Heading">PVLMD Transaction Informations</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				
				<input id="pvlmd_gid_t" name="pvlmd_tr_gid_t" type="hidden" value="0">
			<input id="pvlmd_tr_t_id_t" name="pvlmd_tr_t_id_t" type="hidden" value="0">


				<div class="container">
					<div class="row">
						<div class="col">


							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_reference_number_t"
											readonly>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">File Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_file_number_t"
											>
										</div>
									</div>
								</div>
								
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_property_number_t"
											>
										</div>
				
				
										<div class="col">
											<label for="pvlmd_file_number">NT Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_nt_number_t"
											>
										</div>
										
									</div>
								</div>
							
							
						
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Mutation Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_mutation_number_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Deed Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_deed_number_t"
											>
										</div>
									</div>
								</div>
								
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Serial Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_serial_number_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Sheet Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_sheet_number_t"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Plan Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_plan_number_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Plot Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_plot_number_t"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">LVD Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_lvb_number_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Document Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_doc_number_t"
											>
										</div>
									</div>
								</div>
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party1/Plaintiff</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plaintiff_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party1/Plaintiff Tel No</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plaintiff_tel_no_t"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party1/Plaintiff Address</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plantiff_add_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party1/Plaintiff E-mail</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plaintiff_email_t"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party2/Defendant</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party2/Defendant Tel No</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_tel_no_t"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party2/Defendant E-mail</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_email_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party2/Defendant Address</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_add_t"
											>
										</div>
									</div>
								</div>
								
								
									<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Instrument Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_instrument_date_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Instrument Type</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_instrument_type_t"
											>
										</div>
									</div>
								</div>
	
						</div>
						<div class="col">
									
								
								
							
							<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Term</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_term_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Commencement Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_commencement_date_t"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Purpose</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_purpose_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Consent Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_consent_date_t"
											>
										</div>
									</div>
								</div>
								
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Consideration</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_consideration_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Consideration Currency</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_consideration_currency_t"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Premium</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_premium_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Premium Currency</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_premium_currency_t"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Compensation Status</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_compensation_status_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Suit Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_suit_number_t"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Floor Level</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_floor_level_t"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Apartment Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_apartment_number_t"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Rent</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_rent_t"
											>
										</div>
										
										<div class="col">
											<label for="pvlmd_tr_submission_date">Submission Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_submission_date_t"
											>
										</div>
				
										
									</div>
								</div>
								
								
								
								
							<div class="form-group">
								<label for="bl_business_process_sub_name">Unit Description</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_tr_unit_description_t"
								>
							</div>

							<div class="form-group">
								<label for="bl_business_process_sub_name">Judgement in Favour of</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_tr_judgement_in_favour_of_t"
								>
							</div>
							
							
						<div class="form-group">
								<label for="bl_business_process_sub_name">Remarks</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_tr_remarks_t"
								>
							</div>
							
							
							
						
							
						<div class="form-row">
										<div class="col">
											<label for="bl_business_process_sub_name">Last Update By</label> <input
												class="form-control " type="text" placeholder=""
												id="pvlmd_tr_modified_by_t" readonly
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Date Last Updated</label> <input
														class="form-control " type="text" placeholder=""
														id="pvlmd_tr_modified_date_t" readonly
													>
										</div>
										
										
										
									</div>

					


						</div>
					</div>

				</div>

				
				

			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">
<!-- 
	<button type="button" class="btn btn-success"  id="pvlmd_tr_btn_save_transaction_long_t">
					<span class="glyphicon glyphicon-remove"></span>Save
				</button>
				
				<button type="button" class="btn btn-danger to_hide_on_level_1"  id="pvlmd_tr_btn_delete_transaction_long_t">
					<span class="glyphicon glyphicon-remove"></span>Delete
				</button>
 -->

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>


			</div>

		</div>
	</div>
</div>





<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="addpvlmdtransactionlong_e" role="dialog"
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
				<h4 class="modal-title custom_align" id="Heading">PVLMD Transaction Informations Edit</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				
				<input id="pvlmd_tr_gid_e" name="pvlmd_tr_gid_e" type="hidden" value="0">
		    	<input id="pvlmd_tr_t_id_e" name="pvlmd_tr_t_id_e" type="hidden" value="0">


				<div class="container">
					<div class="row">
						<div class="col">


							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_reference_number_e"
											readonly>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">File Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_file_number_e"
											>
										</div>
									</div>
								</div>
								
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_property_number_e"
											>
										</div>
				
				
										<div class="col">
											<label for="pvlmd_file_number">NT Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_nt_number_e"
											>
										</div>
										
									</div>
								</div>
							
							
						
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Mutation Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_mutation_number_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Deed Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_deed_number_e"
											>
										</div>
									</div>
								</div>
								
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Serial Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_serial_number_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Sheet Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_sheet_number_e"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Plan Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_plan_number_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Plot Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_plot_number_e"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">LVD Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_lvb_number_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Document Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_doc_number_e"
											>
										</div>
									</div>
								</div>
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party1/Plaintiff</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plaintiff_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party1/Plaintiff Tel No</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plaintiff_tel_no_e"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party1/Plaintiff Address</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plantiff_add_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party1/Plaintiff E-mail</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party1_plaintiff_email_e"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party2/Defendant</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party2/Defendant Tel No</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_tel_no_e"
											>
										</div>
									</div>
								</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party2/Defendant E-mail</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_email_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party2/Defendant Address</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_party2_defendant_add_e"
											>
										</div>
									</div>
								</div>
								
								
									<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Instrument Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_instrument_date_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Instrument Type</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_instrument_type_e"
											>
										</div>
									</div>
								</div>
	
						</div>
						<div class="col">
									
								
								
							
							<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Term</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_term_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Commencement Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_commencement_date_e"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Purpose</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_purpose_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Consent Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_consent_date_e"
											>
										</div>
									</div>
								</div>
								
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Consideration</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_consideration_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Consideration Currency</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_consideration_currency_e"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Premium</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_premium_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Premium Currency</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_premium_currency_e"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Compensation Status</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_compensation_status_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Suit Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_suit_number_e"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Floor Level</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_floor_level_e"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Apartment Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_apartment_number_e"
											>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Rent</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_rent_e"
											>
										</div>
										
										<div class="col">
											<label for="pvlmd_tr_submission_date">Submission Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_submission_date_e"
											>
										</div>
				
										
									</div>
								</div>
								
								
								
								
							<div class="form-group">
								<label for="bl_business_process_sub_name">Unit Description</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_tr_unit_description_e"
								>
							</div>

							<div class="form-group">
								<label for="bl_business_process_sub_name">Judgement in Favour of</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_tr_judgement_in_favour_of_e"
								>
							</div>
							
							
						<div class="form-group">
								<label for="bl_business_process_sub_name">Remarks</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_tr_remarks_e"
								>
							</div>
							
							
							
							
						<div class="form-row">
										<div class="col">
											<label for="bl_business_process_sub_name">Last Update By</label> <input
												class="form-control " type="text" placeholder=""
												id="pvlmd_tr_modified_by_e" readonly
											>
										</div>
										
										<div class="col">
											<label for="bl_job_number">Date Last Updated</label> <input
														class="form-control " type="text" placeholder=""
														id="pvlmd_tr_modified_date_e" readonly
													>
										</div>
										
										
										
									</div>
						

					


						</div>
					</div>

				</div>

				
				

			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">
<!-- 
		
	-->
			
 
				 <button type="button" class="btn btn-success"  id="pvlmd_tr_btn_save_transaction_long_e">
					<span class="glyphicon glyphicon-remove"></span>Save
				</button>
				
				<button type="button" class="btn btn-danger to_hide_on_level_1"  id="pvlmd_tr_btn_delete_transaction_long_e">
					<span class="glyphicon glyphicon-remove"></span>Delete
				</button>

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>


			</div>

		</div>
	</div>
</div>



<!-- Add LRD Transaction -->


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="addpvlmdtransactionshort" role="dialog"
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
				<h4 class="modal-title custom_align" id="Heading">PVLMD Transaction Informations (Short)</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				
				<input id="pvlmd_tr_st_gid" name="pvlmd_tr_st_gid" type="hidden" value="">

            	<input id="pvlmd_tr_st_t_id" name="pvlmd_tr_st_t_id" type="hidden" value="0">
				
				<div class="container">
					
					
												
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_reference_number"
											readonly>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">File Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_file_number"
											>
										</div>
									</div>
								</div>
								
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_property_number"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">Submission Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_st_submission_date"
											>
										</div>
									</div>
								</div>
							
							
							
							<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Instrument Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_st_instrument_date"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_file_number">Instrument Type</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_instrument_type"
											>
										</div>
									</div>
								</div>
							
							
						
							
							
								<div class="form-group">
									<div class="form-row">
									<div class="col">
											<label for="pvlmd_plot_number">Plot Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_plot_number"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Document Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_document_number"
											>
										</div>
									</div>
								</div>
							
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party1/Plaintiff</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_party1_plaintiff"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party1/Plaintiff Tel No</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_party1_plaintiff_tel_no"
											>
										</div>
									</div>
								</div>
							
							
								
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Party2/Defendant</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_party2_defendant"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Party2/Defendant Tel No</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_party2_defendant_tel_no"
											>
										</div>
									</div>
								</div>
							
							<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Term</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_term"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Commencement Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_st_commencement_date"
											>
										</div>
									</div>
								</div>
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Purpose</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_tr_st_purpose"
											>
										</div>
				
										 <div class="col">
											<label for="pvlmd_plot_number">Consent Date</label> <input
												class="form-control " type="text"
												placeholder="Date format (eg. DD-MM-YYYY)" id="pvlmd_tr_st_consent_date"
											>
										</div> 
									</div>
								</div>
								
											
							
						<div class="form-group">
								<label for="bl_business_process_sub_name">Remarks</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_tr_st_remarks"
								>
							</div>
							
				

				</div>

				
				

			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

		<button type="button" class="btn btn-success" data-dismiss="modal" id="btn_save_pvlmd_transaction_short">
					<span class="glyphicon glyphicon-remove"></span>Save
				</button>


				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>


			</div>

		</div>
	</div>
</div>




<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="pvlmdnumbergenerationtemplatesaveupdate" role="dialog"
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
				<h4 class="modal-title custom_align" id="Heading">PVLMD Number Generation Form</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

 			<input type="hidden" id="pvlmd_id_ngf" name="pvlmd_id_ngf" value="0">
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number_fts">Reference Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_reference_number_ngf"
											>
										</div>
										
									</div>
								</div>
								<div class="form-group">
									<div class="form-row">
										
										<div class="col">
											<label for="pvlmd_file_number">Applicant Name</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_applicant_name_ngf"
											>
										</div>
				
										
									</div>
								</div>
								
							
						
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Locality</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_locality_ngf"
											>
										</div>
				
										<div class="col">
											<label for="bl_ar_name">Number Format</label> 
											<select class="form-control selectpicker " id="pvlmd_number_format_ngf" name="pvlmd_number_format_ngf" required>
		                                       <option value="">Select Number Format</option>
		                                       <option value="NT">NT</option>
		                                       <option value="PNGA">PNGA</option> 
		                                       <option value="GCL">GCL</option>
		                                       <option value="GSL">GSL</option>
		                                       <option value="LS">LS</option>
		                                    </select>
										</div>
									</div>
								</div>
							

							<div class="form-group">
								<label for="bl_business_process_sub_name">Generated Number</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_old_ref_number_ngf"
								readonly>
							</div>
							
							
						
						
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											
									
									
										</div>
				
										<div class="col">
											<button class="btn btn-primary btn-block" id="btn_generate_pvlmd_transaction_no_fts">
												<span class="text" >Generate</span>
										</button>
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
	id="plvmd_initiate_delete_request" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog" style="max-width: 700px">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Initiate Amendment Request</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

						<input type="hidden" id="pvlmd_id_idr" name="pvlmd_id_idr" value="0">
						<input type="hidden" id="pvlmd_deleteion_type" name="pvlmd_deleteion_type" value="">

								 <input type="hidden" id="initiate_type" name="initiate_type" value="0">
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number_fts">Reference Number <span class="text-danger">*</span></label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_reference_number_idr"
												readonly
											>
										</div>
										
									</div>

									<div class="form-row mt-2 d-none">

										<div class="col">
											<label for="pvlmd_reference_number_fts">Send To <span class="text-danger">*</span></label> 
											
											<select class="form-control" type="text" id="pvlmd_send_request_to_idr">
												<option disabled selected value="">-- select --</option>
												<option value="19">REGIONAL LAND OFFICER</option>
												<option value="9">REGIONAL HEAD</option>
											</select>
										</div>
										
									</div>
								</div>

								<div class="form-group ">
									<div class="form-row">
										
										<div class="col">
											<label for="pvlmd_reference_number_fts">Layer <span class="text-danger">*</span></label> 
											
											<input
												class="form-control " type="text"
												placeholder="" id="pvlmd_layer_type_idr"
												readonly
											>
										</div>
				
										
									</div>
								</div>	
								<div class="form-group">
									<div class="form-row">
										
										<div class="col">
											<label for="pvlmd_file_number">Request Note <span class="text-danger">*</span></label> 
											<textarea
												class="form-control " type="text" rows="6"
												placeholder="" id="pvlmd_delete_note_idr"
											></textarea>
										</div>
				
										
									</div>
								</div>		


								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number_fts">Attachment <span class="text-danger">*</span></label> <input
												class="form-control " type="file"
												placeholder="" id="pvlmd_attachment_location_idr"
												onchange="PreviewImage();" 
											>
										</div>
										
									</div>
								</div>

								<div class="card card-body d-none" id="viewer_id">
									<div style="clear:both">
										<iframe id="viewer" frameborder="0" scrolling="no" width="100%" height="400"></iframe>
									 </div>
								</div>
					
 								

								
			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				<button class="btn btn-danger" id="btn_verify_otp_for_initiate_delete"
					<span class="text" >Confirm Request</span>
				</button>
				<button class="btn btn-success d-none" id="confrim_verify_otp_for_initiate_delete"
					<span class="text" >Send Request</span>
				</button>
			</div>

		</div>
	</div>
</div>


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="plvmd_cancel_delete_request" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Cancel Amendment Request</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

 								<input type="hidden" id="pvlmd_id_cdr" name="pvlmd_id_cdr" value="0">
								 <input type="hidden" id="initiate_type_cdr" name="initiate_type_cdr" value="0">
								 <input type="hidden" id="pvlmd_reference_number_cdr" name="pvlmd_reference_number_cdr" value="0">
								 <input type="hidden" id="layer_type_cdr" name="layer_type_cdr" value="0">
								
								 <h6>Are you sure to cancel the request? </h6>
			</div>

			<!--Body End -->



			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				<button class="btn btn-danger" id="btn_cancel_pvlmd_delete_request">
					<span class="text" >Confirm</span>
			</button>
			</div>

		</div>
	</div>
</div>


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="plvmd_review_delete_request" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Review Amendment Request</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

				<input type="hidden" id="pvlmd_id_cda" name="pvlmd_id_cda" value="0">
				<input type="hidden" id="initiate_type_cda" name="initiate_type_cda" value="0">
				<input type="hidden" id="pvlmd_layer_type_cda" name="pvlmd_layer_type_cda">

				<!-- <div class="accordion" id="accordionExample">
					<div class="steps">
						<progress id="progress" value=0 max=100 ></progress>
						<div class="step-item">
							<button class="step-button text-center" type="button" data-bs-toggle="collapse"
								data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								1
							</button>
							<div class="step-title">
								Request Initiated
							</div>
						</div>
						<div class="step-item">
							<button class="step-button text-center collapsed" type="button" data-bs-toggle="collapse"
								data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
								2
							</button>
							<div class="step-title">
								Request Reviewed
							</div>
						</div>
						<div class="step-item">
							<button class="step-button text-center collapsed" type="button" data-bs-toggle="collapse"
								data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
								3
							</button>
							<div class="step-title">
								Request Approved
							</div>
						</div>
					</div>
					
				</div> -->

				<div class="card card-body">
				<div class="row">
					<div class="col-lg-6">
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Reference Number</label> <input
										class="form-control " type="text"
										placeholder="" id="pvlmd_reference_number_cda"
										readonly
									>
								</div>
								
							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Layer</label> <input
										class="form-control " type="text"
										placeholder="" id="pvlmd_layer_type_cda"
										readonly
									>
								</div>
								
							</div>
						</div>

						<div class="form-row mt-2 d-none">

							<div class="col">
								<label for="pvlmd_reference_number_fts">Send To <span class="text-danger">*</span></label> 
								
								<select class="form-control" type="text" id="pvlmd_send_request_to_cda">
									<option value="">-- select --</option>
									<option selected value="19">REGIONAL LAND OFFICER</option>
									<option value="9">REGIONAL HEAD</option>
								</select>
							</div>
							
						</div>

						<div class="form-group">
							<div class="form-row">
								
								<div class="col">
									<label for="pvlmd_file_number">Request Note</label> 
									<textarea
										class="form-control " type="text" rows="5"
										placeholder="" id="pvlmd_delete_note_cda"
										readonly
									></textarea>
								</div>
		
								
							</div>
						</div>	
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Requested By</label> <input
										class="form-control " type="text"
										placeholder="" id="pvlmd_delete_requested_by_cda"
										readonly
									>
								</div>
								
							</div>
						</div>

						<button class="btn btn-warning mt-1 mb-1" data-toggle="modal" data-target="#load_requested_application_details">
							Load More Details
						</button>

						<div class="form-group mt-5">
							<div class="form-row">
								
								<div class="col">
									<label for="pvlmd_file_number">Review Note <span class="text-danger">*</span></label> 
									<textarea
										class="form-control " type="text" rows="5"
										placeholder="" id="pvlmd_review_note_cda"
										
									></textarea>
								</div>
		
								
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						  <div class="text-small" id="accordion_l">
							<div class="card">
							  <div class="card-header" id="headingOne">
								<h5 class="mb-0">
								  <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne-l" aria-expanded="true" aria-controls="collapseOne">
									Load PDF
								  </button>
								</h5>
							  </div>
						  
							  <div id="collapseOne-l" class="collapse" aria-labelledby="headingOne" data-parent="#accordion_l">
								<div class="card-body">
									<iframe src=""  id="elisdovumentpreviewblobfile_cda" width="100%" height="600"></iframe>
								</div>
							  </div>
							</div>
							<div class="card">
							  <div class="card-header" id="headingTwo">
								<h5 class="mb-0">
								  <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo-l" aria-expanded="false" aria-controls="collapseTwo">
									Load Map
								  </button>
								</h5>
							  </div>
							  <div id="collapseTwo-l" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion_l">
								<div class="card-body">

									<button class="btn btn-danger btn-sm">View</button>

									<div></div>
									
								</div>
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

				<!-- <button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button> -->
				<button class="btn btn-warning" data-toggle="modal" data-target="#decline_request">
					<span class="text" >Decline Review</span>
				</button>
				<button class="btn btn-danger" id="btn_review_pvlmd_delete_request">
					<span class="text" >Confrim Review</span>
				</button>
				<button class="btn btn-success d-none" id="btn_send_review_pvlmd_delete_request">
					<span class="text" >Send Review</span>
				</button>
			</div>

		</div>
	</div>
</div>


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="verify_otp_for_initiate_delete" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Verify OTP</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

				<p class="fxt-description">Please enter the OTP (one time password) to verify your account. A Code has been sent to <span id="phone_number">${user_phone}</span></p>
				<form  name="verifydeleteform" method="post" action="Login"  autocomplete="off" id="verifydeleteform">
					<label for="reset" class="fxt-label">Enter OTP Code Here</label>
					<div class="container_dotp">

						<div class="otp-input mb-5">
							<input type="number" step="1" id="vc_1" name="vc_1" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="vc_2" name="vc_2" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="vc_3" name="vc_3" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="vc_4" name="vc_4" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="vc_5" name="vc_5" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="vc_6" name="vc_6" min="0" max="9" autocomplete="no" pattern="\d*">
						  </div>
						  <input type="hidden" name="otp">
					</div>
				</form>		
			</div>

		</div>
	</div>
</div>

<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="decline_request" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Are you sure to decline request?</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="pvlmd_reference_number_fts">Reference Number</label> <input
								class="form-control " type="text"
								placeholder="" id="pvlmd_reference_number_decline"
								readonly
							>
						</div>
						
					</div>
				</div>
				<div class="form-group">
					<div class="form-row">
						<div class="col">
							<label for="pvlmd_reference_number_fts">Decline Note: <span class="text-danger">*</span></label> 
							<textarea class="form-control" id="plvmd_decline_note"  rows="5"></textarea>
						</div>
						
					</div>
				</div>
			</div>

			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
				<button class="btn btn-danger" id="btn_decline_pvlmd_delete_request">
					<span class="text" >Confirm</span>
				</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="plvmd_confirm_approve_delete_request" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Confirm Amendment Request</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

				<input type="hidden" id="pvlmd_id_aadr" name="pvlmd_id_cda" value="0">
				<input type="hidden" id="initiate_type_aadr" name="initiate_type_aadr" value="0">
				<input type="hidden" id="layer_type_aadr" name="layer_type_aadr">

				<div class="row">
					<div class="col-lg-6">
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Reference Number</label> <input
										class="form-control " type="text"
										placeholder="" id="pvlmd_reference_number_aadr"
										readonly
									>
								</div>
								
							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Layer</label> <input
										class="form-control " type="text"
										placeholder="" id="pvlmd_layer_type_aadr"
										readonly
									>
								</div>
								
							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								
								<div class="col">
									<label for="pvlmd_file_number">Request Note</label> 
									<textarea
										class="form-control " type="text" rows="5"
										placeholder="" id="pvlmd_delete_note_aadr"
										readonly
									></textarea>
								</div>
		
								
							</div>
						</div>	
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Reviewed By</label> <input
										class="form-control " type="text"
										placeholder="" id="pvlmd_reviewed_by_aadr"
										readonly
									>
								</div>
								
							</div>
						</div>
						
						<div class="form-group">
							<div class="form-row">
								
								<div class="col">
									<label for="pvlmd_file_number">Review Note</label> 
									<textarea
										class="form-control " type="text" rows="5"
										placeholder="" id="pvlmd_review_note_aadr"
										readonly
									></textarea>
								</div>
		
								
							</div>
						</div>	
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Approved By</label> <input
										class="form-control " type="text"
										placeholder="" id="pvlmd_deleted_approved_by_aadr"
										readonly
									>
								</div>
								
							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								
								<div class="col">
									<label for="pvlmd_file_number">Approve/Decline Note <span class="text-danger">*</span></label> 
									<textarea
										class="form-control " type="text" rows="5"
										placeholder="" id="pvlmd_deleted_approve_note_aadr"
										readonly
										
									></textarea>
								</div>
		
								
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div id="accordion_c">
							<div class="card">
							  <div class="card-header" id="headingOne">
								<h5 class="mb-0">
								  <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne-c" aria-expanded="true" aria-controls="collapseOne">
									Load PDF
								  </button>
								</h5>
							  </div>
						  
							  <div id="collapseOne-c" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion_c">
								<div class="card-body">
									<iframe src=""  id="elisdovumentpreviewblobfile_aadr" width="100%" height="600"></iframe>
								</div>
							  </div>
							</div>
							<div class="card">
							  <div class="card-header" id="headingTwo">
								<h5 class="mb-0">
								  <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo-c" aria-expanded="false" aria-controls="collapseTwo">
									Load Map
								  </button>
								</h5>
							  </div>
							  <div id="collapseTwo-c" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion_c">
								<div class="card-body">
									<button class="btn btn-danger btn-sm">View</button>

									<div></div>

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

				<!-- <button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button> -->
				<button class="btn btn-warning" data-toggle="modal" data-target="#decline_request">
					<span class="text" >Cancel Request</span>
				</button>
				<button class="btn btn-danger" id="btn_confirm_approve_pvlmd_delete_request">
					<span class="text">Confirm</span>
				</button>

				<button class="btn btn-success d-none" id="btn_pvlmd_delete_request">
					<span class="text">Delete</span>
				</button>
			</div>

		</div>
	</div>
</div>


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="verify_otp_for_initiate_delete" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Verify OTP</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

				<p class="fxt-description">Please enter the OTP (one time password) to verify your account. A Code has been sent to <span id="phone_number">${user_phone}</span></p>
				<form  name="verifydeleteform" method="post" action="Login"  autocomplete="off" id="verifydeleteform">
					<label for="reset" class="fxt-label">Enter OTP Code Here</label>
					<div class="container_dotp">

						<div class="otp-input mb-5">
							<input type="number" step="1" id="vc_1" name="vc_1" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="vc_2" name="vc_2" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="vc_3" name="vc_3" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="vc_4" name="vc_4" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="vc_5" name="vc_5" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="vc_6" name="vc_6" min="0" max="9" autocomplete="no" pattern="\d*">
						  </div>
						  <input type="hidden" name="otp">
					</div>
				</form>		
			</div>
		</div>
	</div>
</div>


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="verify_otp_for_review_delete" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Verify OTP</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

				<p class="fxt-description">Please enter the OTP (one time password) to verify your account. A Code has been sent to <span id="phone_number_a">${user_phone}</span></p>
				<form  name="verifydeleteform" method="post" action="Login"  autocomplete="off" id="verifydeleteform">
					<label for="reset" class="fxt-label">Enter OTP Code Here</label>
					<div class="container_dotp">
						<div class="otp-input mb-5">
							<input type="number" step="1" id="ac_1" name="ac_1" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="ac_2" name="ac_2" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="ac_3" name="ac_3" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="ac_4" name="ac_4" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="ac_5" name="ac_5" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="ac_6" name="ac_6" min="0" max="9" autocomplete="no" pattern="\d*">
						  </div>
						  <!-- <input type="hidden" name="otp"> -->
					</div>
				</form>		
			</div>

		</div>
	</div>
</div>


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="verify_otp_for_confirm_delete" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Verify OTP</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

				<p class="fxt-description">Please enter the OTP (one time password) to verify your account. A Code has been sent to <span id="phone_number_c">${user_phone}</span></p>
				<form  name="verifydeleteform" method="post" action="Login"  autocomplete="off" id="verifydeleteform">
					<label for="reset" class="fxt-label">Enter OTP Code Here</label>
					<div class="container_dotp">

						<div class="otp-input mb-5">
							<input type="number" step="1" id="cc_1" name="cc_1" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="cc_2" name="cc_1" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="cc_3" name="cc_3" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="cc_4" name="cc_4" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="cc_5" name="cc_5" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="cc_6" name="cc_6" min="0" max="9" autocomplete="no" pattern="\d*">
						  </div>
						  <input type="hidden" name="otp">
					</div>
				</form>		
			</div>
		</div>
	</div>
</div>


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="plvmd_approve_delete_request" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Approve Amendment Request</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

				<input type="hidden" id="pvlmd_id_radr" name="pvlmd_id_radr" value="0">
				<input type="hidden" id="initiate_type_radr" name="initiate_type_radr" value="0">
				<input type="hidden" id="pvlmd_layer_type_cda" name="pvlmd_layer_type_cda">

				<!-- <div class="accordion" id="accordionExample">
					<div class="steps">
						<progress id="progress" value=0 max=100 ></progress>
						<div class="step-item">
							<button class="step-button text-center" type="button" data-bs-toggle="collapse"
								data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								1
							</button>
							<div class="step-title">
								Request Initiated
							</div>
						</div>
						<div class="step-item">
							<button class="step-button text-center collapsed" type="button" data-bs-toggle="collapse"
								data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
								2
							</button>
							<div class="step-title">
								Request Reviewed
							</div>
						</div>
						<div class="step-item">
							<button class="step-button text-center collapsed" type="button" data-bs-toggle="collapse"
								data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
								3
							</button>
							<div class="step-title">
								Request Approved
							</div>
						</div>
					</div>
					
				</div> -->

				<div class="card card-body">
				<div class="row">
					<div class="col-lg-6">
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Reference Number</label> <input
										class="form-control " type="text"
										placeholder="" id="pvlmd_reference_number_radr"
										readonly
									>
								</div>
								
							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Layer</label> <input
										class="form-control " type="text"
										placeholder="" id="layer_type_radr"
										readonly
									>
								</div>
								
							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								
								<div class="col">
									<label for="pvlmd_file_number">Request Note</label> 
									<textarea
										class="form-control " type="text" rows="5"
										placeholder="" id="pvlmd_delete_note_radr"
										readonly
									></textarea>
								</div>
		
								
							</div>
						</div>	
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Requested By</label> <input
										class="form-control " type="text"
										placeholder="" id="pvlmd_deleted_requested_by_radr"
										readonly
									>
								</div>
								
							</div>
						</div>

						<div class="form-group">
							<div class="form-row">
								
								<div class="col">
									<label for="pvlmd_file_number">Review Note</label> 
									<textarea
										class="form-control " type="text" rows="5"
										placeholder="" id="pvlmd_review_note_radr"
										readonly
									></textarea>
								</div>
		
								
							</div>
						</div>	
						<div class="form-group">
							<div class="form-row">
								<div class="col">
									<label for="pvlmd_reference_number_fts">Reviewed By</label> <input
										class="form-control " type="text"
										placeholder="" id="pvlmd_reviewed_by_radr"
										readonly
									>
								</div>
								
							</div>
						</div>

						<button class="btn btn-warning mt-1 mb-1" data-toggle="modal" data-target="#load_requested_application_details">
							Load More Details
						</button>

						<div class="form-group mt-5">
							<div class="form-row">
								
								<div class="col">
									<label for="pvlmd_file_number">Approve Note <span class="text-danger">*</span></label> 
									<textarea
										class="form-control " type="text" rows="5"
										placeholder="" id="pvlmd_approve_note_radr"
										
									></textarea>
								</div>
		
								
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						  <div class="text-small" id="accordion_a">
							<div class="card">
							  <div class="card-header" id="headingOne">
								<h5 class="mb-0">
								  <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne-a" aria-expanded="true" aria-controls="collapseOne">
									Load PDF
								  </button>
								</h5>
							  </div>
						  
							  <div id="collapseOne-a" class="collapse" aria-labelledby="headingOne" data-parent="#accordion_a">
								<div class="card-body">
									<iframe src=""  id="elisdovumentpreviewblobfile_radr" width="100%" height="600"></iframe>
								</div>
							  </div>
							</div>
							<div class="card">
							  <div class="card-header" id="headingTwo">
								<h5 class="mb-0">
								  <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo-a" aria-expanded="false" aria-controls="collapseTwo">
									Load Map
								  </button>
								</h5>
							  </div>
							  <div id="collapseTwo-a" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion_a">
								<div class="card-body">

									<button class="btn btn-danger btn-sm">View</button>

									<div></div>

								</div>
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

				<!-- <button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button> -->
				<button class="btn btn-warning" data-toggle="modal" data-target="#decline_request">
					<span class="text" >Decline</span>
				</button>
				<button class="btn btn-danger" id="btn_approve_pvlmd_delete_request">
					<span class="text" >Approve</span>
				</button>
				<button class="btn btn-success d-none" id="btn_confirm_approval_delete_request">
					<span class="text" >Confirm Approval</span>
				</button>
			</div>

		</div>
	</div>
</div>


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="verify_otp_for_approve_delete" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Verify OTP</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>



			<!--  Body Start -->
			<div class="modal-body">

				<p class="fxt-description">Please enter the OTP (one time password) to verify your account. A Code has been sent to <span id="phone_number_b">${user_phone}</span></p>
				<form  name="verifydeleteform" method="post" action="Login"  autocomplete="off" id="verifydeleteform">
					<label for="reset" class="fxt-label">Enter OTP Code Here</label>
					<div class="container_dotp">

						<div class="otp-input mb-5">
							<input type="number" step="1" id="aac_1" name="aac_1" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="aac_2" name="aac_2" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="aac_3" name="aac_3" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="aac_4" name="aac_4" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="aac_5" name="aac_5" min="0" max="9" autocomplete="no" pattern="\d*">
							<input type="number" step="1" id="aac_6" name="aac_6" min="0" max="9" autocomplete="no" pattern="\d*">
						  </div>
						  <!-- <input type="hidden" name="otp"> -->
					</div>
				</form>		
			</div>
		</div>
	</div>
</div>


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="load_requested_application_details" role="dialog"
	aria-labelledby="myExtraLargeModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!--Header -->
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Application Details</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">x</span>
				</button>
			</div>
			<!--  Body Start -->
			<div class="modal-body">

				<div class="text-small" id="accordion_d">
					<div id="delete_application_details"></div>
				</div>
			</div>
			<!-- Footer -->
			<div class="modal-footer ">

				<button type="button" class="btn btn-default" data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>Close
				</button>
			</div>

		</div>
	</div>
</div>

<script>

	function PreviewImage() {
		$('#viewer_id').removeClass('d-none');

		pdffile=document.getElementById("pvlmd_attachment_location_idr").files[0];
		pdffile_url=URL.createObjectURL(pdffile);
		$('#viewer').attr('src',pdffile_url);
	}
</script>

<script>

	let str = document.getElementById("phone_number").innerHTML;
	let res = str.replace(/\d(?=\d{3})/g, "*");
	document.getElementById("phone_number").innerHTML = res;

	let str_a = document.getElementById("phone_number_a").innerHTML;
	let res_a = str_a.replace(/\d(?=\d{3})/g, "*");
	document.getElementById("phone_number_a").innerHTML = res_a;


	let str_b = document.getElementById("phone_number_b").innerHTML;
	let res_b = str_b.replace(/\d(?=\d{3})/g, "*");
	document.getElementById("phone_number_b").innerHTML = res_b;

	let str_c = document.getElementById("phone_number_c").innerHTML;
	let res_c = str_c.replace(/\d(?=\d{3})/g, "*");
	document.getElementById("phone_number_c").innerHTML = res_c;

</script>

<!-- <script>
	// script.js
const inputs = document.getElementById("inputs_dotp");
 
 inputs.addEventListener("input_dotp", function (e) {
	 const target = e.target;
	 const val = target.value;
  
	 if (isNaN(val)) {
		 target.value = "";
		 return;
	 }
  
	 if (val != "") {
		 const next = target.nextElementSibling;
		 if (next) {
			 next.focus();
		 }
	 }
 });
  
 inputs.addEventListener("keyup", function (e) {
	 const target = e.target;
	 const key = e.key.toLowerCase();
  
	 if (key == "backspace" || key == "delete") {
		 target.value = "";
		 const prev = target.previousElementSibling;
		 if (prev) {
			 prev.focus();
		 }
		 return;
	 }
 });
</script> -->

<script>
(function () {
  const inputs = document.querySelectorAll(".otp-input input");
  //inputs = document.querySelectorAll("#otp-input-a input");

  for (let i = 0; i < inputs.length; i++) {
    const input = inputs[i];

    input.addEventListener("input", function () {
      // handling normal input
      if (input.value.length == 1 && i+1 < inputs.length) {
        inputs[i+1].focus();
      }

      // if a value is pasted, put each character to each of the next input
      if (input.value.length > 1) {
        // sanitise input
        if (isNaN(input.value)) {
          input.value = "";
          updateInput();
          return;
        }

        // split characters to array
        const chars = input.value.split('');

        for (let pos = 0; pos < chars.length; pos++) {
          // if length exceeded the number of inputs, stop
          if (pos + i >= inputs.length) break;

          // paste value
          let targetInput = inputs[pos + i];
          targetInput.value = chars[pos];
        }

        // focus the input next to the last pasted character
        let focus_index = Math.min(inputs.length - 1, i + chars.length);
        inputs[focus_index].focus();
      }
      updateInput();
    });

    input.addEventListener("keydown", function (e) {
      // backspace button
      if (e.keyCode == 8 && input.value == '' && i != 0) {
        // shift next values towards the left
        for (let pos = i; pos < inputs.length - 1; pos++) {
          inputs[pos].value = inputs[pos + 1].value;
        }

        // clear previous box and focus on it
        inputs[i-1].value = '';
        inputs[i-1].focus();
        updateInput();
        return;
      }

      // delete button
      if (e.keyCode == 46 && i != inputs.length - 1) {
        // shift next values towards the left
        for (let pos = i; pos < inputs.length - 1; pos++) {
          inputs[pos].value = inputs[pos + 1].value;
        }

        // clear the last box
        inputs[inputs.length - 1].value = '';
        input.select();
        e.preventDefault();
        updateInput();
        return;
      }

      // left button
      if (e.keyCode == 37) {
        if (i > 0) {
          e.preventDefault();
          inputs[i-1].focus();
          inputs[i-1].select();
        }
        return;
      }

      // right button
      if (e.keyCode == 39) {
        if (i+1 < inputs.length) {
          e.preventDefault();
          inputs[i+1].focus();
          inputs[i+1].select();
        }
        return;
      }
    });
  }
  
  function updateInput() {
    let inputValue = Array.from(inputs).reduce(function (otp, input) {
      otp += (input.value.length) ? input.value : ' ';
      return otp;
    }, "");
    document.querySelector("input[name=otp]").value = inputValue;
  }
})();
</script>

