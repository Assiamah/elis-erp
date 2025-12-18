<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>



<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="rentparcelinformation" role="dialog"
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
					Transaction Informations</h4>
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
												placeholder="" id="ge_reference_number"
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
								
							
								<div class="form-group">
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
								</div>
							
							
						
							<div class="form-group">
								<label for="bl_ar_name">Locality</label> <input
									class="form-control " type="text" placeholder=""
									id="pvlmd_locality"
								>
							</div>
							
							
								<div class="form-group">
									<div class="form-row">
										<div class="col">
											<label for="pvlmd_reference_number">Sheet Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_sheet_number"
											>
										</div>
				
										<div class="col">
											<label for="pvlmd_plot_number">Plot Number</label> <input
												class="form-control " type="text"
												placeholder="" id="pvlmd_plot_number"
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
							
								<!-- <button type="button" class="btn btn-primary btn-sm"
									data-toggle="modal" data-target="#addpvlmdtransactionlong"
								>Add New Transaction</button>
								
								
								<button type="button" class="btn btn-success btn-sm"
									data-toggle="modal" data-target="#addpvlmdtransactionshort"
								>Add New Short Transaction</button> -->

							</div>


							<div class="form-group">
								<div class="table w-auto small">
									<table class="table table-bordered"
										id="pvlmd_transaction_dataTable" width="100%" cellspacing="0"
									>

										<thead>
											<tr>

												<th>Name</th>
												<th>Lessee's Name</th>
												<th>Certificate Number</th>
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






<!-- Add LRD Transaction -->


<div class="modal fade bd-example-modal-xl" tabindex="-1"
	id="lesseeAllocationDetails" role="dialog"
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
				<h4 class="modal-title custom_align" id="Heading">Lessee Allocation Details</h4>
			</div>



			<!--  Body Start -->
			<div class="modal-body">


				
				<input id="pvlmd_gid" name="pvlmd_gid" type="hidden" value="">


				<div class="container">
					
					
							
					<div class="row">
					<div class="mb-4">
						<label class="form-label">Expiry Date </label>
						<input type="text"  class="form-control" id="expiry_date"  name="expiry_date"  required="" >
					  </div>
					</div>
  
  
					<div class="col-md-4">
					  <div class="mb-4">
						<label class="form-label">After </label>
						<input type="text"  class="form-control" id="after"  name="after"  required="" >
					  </div>
					</div>
						
					</div>
  
  
  
  
					  <div class="row">
					  <div class="col-md-4">
					  <div class="mb-4">
						<label class="form-label">Consent Date</label>
						<input type="text" class="form-control" id='consent_date' name="consent_date"   required="" >
					  </div>
					</div>
  
					  <div class="col-md-4">
					  <div class="mb-4">
						<label class="form-label">Location Rate </label>
						<input type="text"  class="form-control" id="location_rate"  name="location_rate"  required="" >
					  </div>
					</div>
  
  
					<div class="col-md-4">
					  <div class="mb-4">
						<label class="form-label">Rent Category </label>
						<input type="text"  class="form-control" id="rent_category"  name="rent_category"  required="" >
					  </div>
					</div>
						
					</div>
  
  
  
  
					  <div class="row">
					  <div class="col-md-4">
					  <div class="mb-4">
						<label class="form-label">Rent Review Clause</label>
						<input type="text" class="form-control" id='rent_review_clause' name="rent_review_clause"   required="" >
					  </div>
					</div>
  
					  <div class="col-md-4">
					  <div class="mb-4">
						<label class="form-label">Rent Passing </label>
						<input type="text"  class="form-control" id="rent_passing"  name="rent_passing"  required="" >
					  </div>
					</div>
  
  
					<div class="col-md-4">
					  <div class="mb-4">
						<label class="form-label">Date Created </label>
						<input type="text"  class="form-control" id="created_id"  name="created_id"  required="" >
					  </div>
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


