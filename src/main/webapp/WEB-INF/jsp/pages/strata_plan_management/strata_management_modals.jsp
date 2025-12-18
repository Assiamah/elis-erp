<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
 <jsp:useBean id="now" class="java.util.Date"/>    

<!-- Division Modal-->
<div class="modal fade" data-position="0" id="addlegder" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel">Add New Lesee/Assignee</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="card">
					<span class="card-label bg-secondary">Lesee/Assignee's Details</span>
					<div class="card-body">
					<input id="rt_rent_id" value="0" type="hidden"/>
					<div class="row">
						<div class="col-6">
							<div class="form-row mb-2">
								<label for="">Name: <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="rt_leasee_name" required />
							</div>
							<div class="form-row mb-2">
								<label for="">Address: <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="rt_leasee_address" required />
							</div>
							<div class="form-row mb-2">
								<label for="">Mobile Phone: <span class="text-danger">*</span></label>
								<input type="tel" class="form-control" id="rt_mobile_phone_1" required/>
							</div>
						</div>
						<div class="col-6">
							<div class="form-row mb-2">
								<label for="">Mobile Phone 2: </label>
								<input type="tel" class="form-control" id="rt_mobile_phone_2"/>
							</div>
							<div class="form-row mb-2">
								<label for="">Email: </label>
								<input type="email" class="form-control" id="rt_email" />
							</div>
						</div>
					</div>
					</div>
				</div>
				<div class="card mt-4">
					<span class="card-label bg-secondary">Parcel's Details</span>
					<div class="card-body">
					<div class="row">
						<div class="col-6">
							<!-- <div class="form-row mb-2">
								<label for="">Region: <span class="text-danger">*</span></label>
								<select id="rt_region_code" class="form-control">
									<option selected disabled value="">-- select --</option>
																
									<c:forEach items="${officeregionlist}" var="officeregion">
										<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
									  </c:forEach>
							
								</select>
							</div> -->
							<!-- <div class="form-row mb-2">
								<label for="">Locality: <span class="text-danger">*</span></label>
								<select
									name="rt_locality"
									id="rt_locality"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
								<option value="-1">-- select --</option>
								<c:forEach items="${localitylist}" var="locality">
									<option  value="${locality.locality_name}">${locality.locality_name}</option>
								 </c:forEach>
									
								</select>
							</div> -->
							
							<div class="form-row mb-2">
								<label for="">Estate: <span class="text-danger">*</span></label>
								<!-- <input type="email" class="form-control" required/> -->
								<select
								name="rt_estate"
								id="rt_estate"
								class="form-control input-sm" data-style="btn-info"
								data-live-search="true"
							>
								<option selected disabled value="">-- select --</option>
																
								<c:forEach items="${estate_list}" var="estateList">
									<option  value="${estateList.ge_id}">${estateList.ge_location_name}</option>
								  </c:forEach>
								</select>
							</div>
							<div class="form-row mb-2">
								<label for="">Plot Number: <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="rt_plot_number" required/>
							</div>
							<div class="form-row mb-2">
								<label for="">Plot Size: <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="rt_plot_size" required/>
							</div>
							<!-- <div class="form-row mb-2">
								<label for="">Block Number: </label>
								<input type="text" class="form-control" id="rt_block_number" />
							</div> -->
							<div class="form-row mb-2">
								<label for="">Convenanted User: </label>
								<!-- <input type="text" class="form-control" id="rt_convenant_user" /> -->
								<select class="form-control input-sm" name="" id="rt_convenant_user">
								<option selected disabled value="">-- select --</option>
								 
								 <c:forEach items="${user_category_list}" var="usercategorylist">
									<option  value="${usercategorylist.us_name}">${usercategorylist.us_name}</option>
								  </c:forEach>
								</select>
							</div>
						</div>
						<div class="col-6">
							
							<!-- <div class="form-row mb-2">
								<label for="">Orginal Use: </label>
								<select class="form-control input-sm" name="" id="rt_original_use">
									<option selected disabled value="">-- select --</option>
								 </select>
							</div> -->
							<div class="form-row mb-2">
								<label for="">Current User: </label>
								<!-- <input type="text" class="form-control" /> -->
								 <select class="form-control input-sm" name="" id="rt_current_use">
									<option selected disabled value="">-- select --</option>
									<c:forEach items="${user_category_list}" var="usercategorylist">
										<option  value="${usercategorylist.us_name}">${usercategorylist.us_name}</option>
									  </c:forEach>
								 </select>
							</div>
							<div class="form-row mb-2">
								<label for="">Nature of Development: </label>
								<!-- <input type="tel" class="form-control" /> -->
								<select class="form-control input-sm" name="" id="rt_nature_of_dev">
									<option selected disabled value="">-- select --</option>
									<c:forEach items="${nature_of_development_list}" var="natureofdevelopmentlist">
										<option  value="${natureofdevelopmentlist.na_name}">${natureofdevelopmentlist.na_name}</option>
									  </c:forEach>
								 </select>
							</div>
							<div class="form-row mb-2">
								<label for="">Parcel Address: </label>
								<input type="tel" class="form-control" id="rt_parcel_address"/>
							</div>
						</div>
					</div>
					</div>
				</div>

				<div class="card mt-3">
					<!-- <span class="card-label">Parcel's Details</span> -->
					<div class="card-body">
					<div class="row">
						<div class="col-6">
							<div class="form-row mb-2">
								<label for="">File Number: <span class="text-danger">*</span></label>
								<input type="email" class="form-control" id="rt_file_number" required/>
							</div>
							<div class="form-row mb-2">
								<label for="">Ledger: <span class="text-danger">*</span></label>
								<input type="email" class="form-control" id="rt_ledger" required/>
							</div>
							<div class="form-row mb-2">
								<label for="">Folio:</label>
								<input type="email" class="form-control" id="rt_folio"/>
							</div>
							<div class="form-row mb-2">
								<label for="">LS Number: </label>
								<input type="text" class="form-control" id="rt_ls_number" />
							</div>
							<div class="form-row mb-2">
								<label for="">GLPIN: </label>
								<input type="text" class="form-control" id="rt_glpin" />
							</div>
							<div class="form-row mb-2">
								<label for="">Commencement Date: <span class="text-danger">*</span></label>
								<input type="date" class="form-control" id="rt_commencement_date" required/>
							</div>
							<div class="form-row mb-2">
								<label for="">Term: <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="rt_term" required/>
							</div>
							<div class="form-row mb-2">
								<label for="">Nature of Instrument: </label>
								<!-- <input type="tel" class="form-control" /> -->
								<select class="form-control input-sm" name="" id="rt_nature_of_instrument">
									<option selected disabled value="">-- select --</option>
									<!-- <option value="Lease">Lease</option>
									<option value="Sub-Lease">Sub-Lease</option>
									<option value="Assignment">Assignment</option>
									<option value="Vesting Assent">Vesting Assent</option> -->
									<c:forEach items="${nature_of_instrument_list}" var="natureofinstrumentlist">
										<option  value="${natureofinstrumentlist.nt_name}">${natureofinstrumentlist.nt_name}</option>
									  </c:forEach>
								 </select>
							</div>
							<!-- <div class="form-row mb-2">
								<label for="">Expiry Date: <span class="text-danger">*</span></label>
								<input type="date" class="form-control" id="rt_expiry_date" required/>
							</div> -->
							<div class="form-row mb-2">
								<label for="">Consent Date: </label>
								<input type="date" class="form-control" id="rt_consent_date"/>
							</div>
						</div>
						<div class="col-6">
							<div class="form-row mb-2">
								<label for="">Location Rate: <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="rt_location_rate" required/>
							</div>
							<div class="form-row mb-2">
								<label for="">Last Payment Period: <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="rt_last_payment_period" required/>
							</div>
							<div class="form-row mb-2">
								<label for="">Last Payment Date: <span class="text-danger">*</span></label>
								<input type="date" class="form-control" id="rt_last_payment_date" required />
							</div>
							<div class="form-row mb-2">
								<label for="">Rent Category: </label>
								<!-- <input type="text" class="form-control" id="rt_rent_category" /> -->
								<select class="form-control input-sm" name="" id="rt_rent_category">
									<option selected disabled value="">-- select --</option>
								 </select>
							</div>
							<div class="form-row mb-2">
								<label for="">Rent Revision Period: <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="rt_rent_review_clause" />
							</div>
							<div class="form-row mb-2">
								<label for="">Period In Arrears: <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="rt_period_in_arrears" required/>
							</div>
							<!-- <div class="form-row mb-2">
								<label for="">Last Review Date: <span class="text-danger">*</span></label>
								<input type="date" class="form-control" id="rt_last_review_date" required />
							</div> -->
							<div class="form-row mb-2">
								<label for="">Rent Passing: </label>
								<input type="text" class="form-control" id="rt_rent_passing" />
							</div>
							<!-- <div class="form-row mb-2">
								<label for="">Adjoining Plots: </label>
								<input type="text" class="form-control" id="rt_adjoining_plots" />
							</div> -->
							<!-- <div class="form-row mb-2">
								<label for="">Amount Due: </label>
								<input type="text" class="form-control" id="rt_amount_due" />
							</div> -->
							<div class="form-row mb-2">
								<label for="">Rent Outstanding: </label>
								<input type="text" class="form-control" id="rt_rent_outstanding"/>
							</div>
							<!-- <div class="form-row mb-2">
								<label for="">Classification of Arrears: </label>
								<input type="text" class="form-control" id="rt_classification_of_arrears"/>
							</div> -->
							<div class="form-row mb-2">
								<label for="">Remarks: </label>
								<input type="text" class="form-control" id="rt_remarks"/>
							</div>
						</div>
					</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-danger" data-dismiss="modal">Close</button>
				<button class="btn btn-success" id="btn_save_rent_client_details">Save</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" data-position="0" id="paymenthistory" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel">Payment History</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<button class="btn btn-warning btn-sm mb-2" >Load Payments</button>
				<button class="btn btn-success btn-sm mb-2" data-toggle="collapse" data-target="#addpaymentdiv">Add Payment</button>
				<div class="collapse mb-2" id="addpaymentdiv">
					<div class="card card-body">
						<div class="card">
							<span class="card-label bg-secondary">Particulars of Payment</span>
							<div class="card-body">
								<input id="rt_rent_id" value="0" type="hidden"/>
							<div class="row">
								<div class="col-6">
									<div class="form-row mb-2">
										<label for="">Payment Mode: <span class="text-danger">*</span></label>
										<!-- <input type="text" class="form-control" id="rt_leasee_name" required /> -->
										 <select class="form-control" id="py_payment_mode">
											<option disabled selected value="">-- select --</option>
											<option value="Cash">Cash</option>
											
										 </select>
									</div>
									<div class="form-row mb-2">
										<label for="">Receipt No.: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_mobile_phone_1" required/>
									</div>
									<div class="form-row mb-2">
										<label for="">Arrears Amount: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_leasee_address" required />
									</div>
									<div class="form-row mb-2">
										<label for="">Period In Arrears: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_mobile_phone_1" required/>
									</div>
								</div>
								<div class="col-6">
									<div class="form-row mb-2">
										<label for="">Payment Amount:  <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_email" required/>
									</div>
									<div class="form-row mb-2">
										<label for="">Period of Last Payment: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_mobile_phone_1" required/>
									</div>
									<div class="form-row mb-2">
										<label for="">Date:  <span class="text-danger">*</span></label>
										<input type="date" class="form-control" id="rt_mobile_phone_2" required/>
									</div>
									<div class="form-row mb-2">
										<label for="">Remarks: </label>
										<input type="text" class="form-control" id="rt_email" />
									</div>
								</div>
							</div>
							</div>
						</div>
						<button class="btn btn-success btn-sm mt-2">Save Details</button>
					</div>
				</div>
				<div class="table-responsive small">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_rent_payment_history" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Action</th>
								<th>Payment Mode</th>
								<th>Arrears Amount</th>
								<th>Receipt No.</th>
								<th>Date</th>
								<th>Payment Amount</th>

							</tr>
						</thead>
						<tbody>



						</tbody>


					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>



<div class="modal fade" data-position="0" id="singlerentdemandnotice" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel">Single Rent Demand Notice</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
					<!-- <button class="btn btn-success btn-sm mb-2" data-toggle="collapse" data-target="#addpaymentdiv">Add Payment</button> -->
				
				<input id="rdn_rent_id" value="0" type="hidden"/>
				<input id="rdn_account_number" value="0" type="hidden"/>
				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Name: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="rdn_leasee_name" required />
						</div>
						<div class="form-row mb-2">
							<label for="">Address: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="rdn_leasee_address" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Mobile Phone 2: </label>
							<input type="tel" class="form-control" id="rdn_mobile_phone_2"/>
						</div>
						<div class="form-row mb-2">
							<label for="">Email: </label>
							<input type="email" class="form-control" id="rdn_email" />
						</div>
						
					</div>
				</div>

				<button class="btn btn-primary btn-sm mb-2" id="btn_generate_rent_demand_note">Generate Rent Demand Notie</button>
			


				<div class="table-responsive small">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_rent_assessment_details" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Period</th>
								<th>Interest Rate</th>
								<th>Annual Rent</th>
								<th>Amount Assessed </th>
								<th>Description</th>
								<th>Assessed by</th>

							</tr>
						</thead>
						<tbody>



						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-success btn-sm" id="btn_print_rent_demand_note">Print Rent Demand Note</button>
				<button class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" data-position="0" id="transactionhistory" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel">Transaction History</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<button class="btn btn-warning btn-sm mb-2" >Load Transaction</button>
				<button class="btn btn-success btn-sm mb-2" data-toggle="collapse" data-target="#addtransactiondiv">Add Transaction</button>
				<div class="collapse mb-2" id="addtransactiondiv">
					<div class="card card-body">
						<div class="card">
							<span class="card-label bg-secondary">Lessee's Details</span>
							<div class="card-body">
								<input id="rt_rent_id" value="0" type="hidden"/>
							<div class="row">
								<div class="col-6">
									<div class="form-row mb-2">
										<label for="">Name: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_leasee_name" required />
									</div>
									<div class="form-row mb-2">
										<label for="">Address: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_leasee_address" required />
									</div>
									<div class="form-row mb-2">
										<label for="">Mobile Phone: <span class="text-danger">*</span></label>
										<input type="tel" class="form-control" id="rt_mobile_phone_1" required/>
									</div>
								</div>
								<div class="col-6">
									<div class="form-row mb-2">
										<label for="">Mobile Phone 2: </label>
										<input type="tel" class="form-control" id="rt_mobile_phone_2"/>
									</div>
									<div class="form-row mb-2">
										<label for="">Email: </label>
										<input type="email" class="form-control" id="rt_email" />
									</div>
								</div>
							</div>
							</div>
						</div>
						<div class="card mt-4">
							<span class="card-label bg-secondary">Parcel's Details</span>
							<div class="card-body">
							<div class="row">
								<div class="col-6">
									<div class="form-row mb-2">
										<label for="">Plot Number: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_plot_number" required/>
									</div>
									<div class="form-row mb-2">
										<label for="">Plot Size: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_plot_size" required/>
									</div>
									<div class="form-row mb-2">
										<label for="">Block Number: </label>
										<input type="text" class="form-control" id="rt_block_number" />
									</div>
								</div>
								<div class="col-6">
									<div class="form-row mb-2">
										<label for="">Current Use: </label>
										<!-- <input type="text" class="form-control" /> -->
										 <select class="form-control input-sm" name="" id="rt_current_use">
											<option selected disabled value="">-- select --</option>
										 </select>
									</div>
									<div class="form-row mb-2">
										<label for="">Nature of Development: </label>
										<!-- <input type="tel" class="form-control" /> -->
										<select class="form-control input-sm" name="" id="rt_nature_of_dev">
											<option selected disabled value="">-- select --</option>
										 </select>
									</div>
									<div class="form-row mb-2">
										<label for="">Parcel Address: </label>
										<input type="tel" class="form-control" id="rt_parcel_address"/>
									</div>
								</div>
							</div>
							</div>
						</div>
						<button class="btn btn-success btn-sm mt-2">Save Details</button>
					</div>
				</div>
				<div class="table-responsive small">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_rent_payment_history" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Plot Number</th>
								<th>Name of Lessee</th>
								<th>Nature of Interest</th>
								<th>Consent Date</th>
								<th>Term</th>
								<th>Action</th>

							</tr>
						</thead>
						<tbody>



						</tbody>


					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" data-position="0" id="rentdocuments" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel">Documents</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<button class="btn btn-warning btn-sm mb-2" >Load Documents</button>
				<button class="btn btn-success btn-sm mb-2" data-toggle="collapse" data-target="#uploaddocumentdiv">Upload Document</button>
				<div class="collapse mb-2" id="uploaddocumentdiv">
					<div class="card card-body">
					  <div class="form-group">
						<div class="row">
							<div class="col-8">
							  <input type="file" id="" class="form-control" placeholder="Enter Job Number"/>
							</div>
							<div class="col-4">
							  <button class="btn btn-success" id="btn_search_submitted_job_dashboard"><i class="fas fa-upload"></i>Upload</button>
							</div>
						</div>  
					</div>
					</div>
				</div>
				<div class="table-responsive small">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_rent_payment_history" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Document Name</th>
								<th>Document Type</th>
								<th>Date Uploaded</th>

							</tr>
						</thead>
						<tbody>



						</tbody>


					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>



<!-- Add File Upload============================= -->
<div class="modal fade" id="fileRentUploadModal" tabindex="-1" role="dialog"
	aria-labelledby="fileRentUploadModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="fileRentUploadModalLabel">Upload New File</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			
			
			
			 <form class="form-horizontal" method="POST" enctype="multipart/form-data" id="id_form_rent_data">
			    <label for="file">File:</label>
			    <input id="fileUploadFormrentdata" type="file" name="fileUploadFormrentdata" />
			   

			    <input type="button" id="btn_upload_rent_data_file"
								class="btn btn-primary" value="Click to upload"
							>
			</form>
			
	
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal"
						>Close</button>
					</div>
				
				
				
			</div>
		</div>
	</div>
	