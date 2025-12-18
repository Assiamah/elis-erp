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




<div class="modal fade" data-position="0" id="transactionhistory" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rtModalLabel">Transaction History</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<button class="btn btn-warning mb-2 d-none" id="xloadRt" onclick="loadTransactionHistory()"><i class="fa fa-undo"></i></button>
				<button class="btn btn-danger btn-sm mb-2 d-none" id="btnAddNewLessee" data-toggle="modal" data-target="#addlegder">Add New Lessee</button>
				<!-- <button class="btn btn-success btn-sm mb-2" id="btnAddTransaction" data-toggle="collapse" data-target="#addtransactiondiv">Add Transaction</button> -->
				 <input id="parcel_idxxxx" type="hidden" />
				<div class="form-row d-none" id="exDatar">
					<div class="col-md-6">
						<label for="">GLPIN: </label>
						<input type="text" class="form-control" id="xxr_glpin" readonly>
					</div>
					<div class="col-md-6">
						<label for="">Land Size: </label>
						<input type="text" class="form-control" id="xxr_plot_size" readonly/>
					</div>
					<div class="col-md-6">
						<label for="">Locality: </label>
						<input type="text" class="form-control" id="xxr_locality" readonly/>
					</div>
				</div>
				<div class="table-responsive small mt-2">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_parcel_transaction_history" width="100%" cellspacing="0">
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

<div class="modal fade" data-position="0" id="rentParcelDetails" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel">Parcel Details</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				
				<button class="btn btn-success btn-sm mb-2" data-toggle="collapse" data-target="#addlegder">Add New Lessee</button>
				<div class="collapse mb-2" id="">
					<div class="card card-body">
						

						<input id="rt_rent_id" value="0" type="hidden"/>
							<div class="row">
								<div class="col-6">
									<div class="form-row mb-2">
										<label for="">Developed: <span class="text-danger">*</span></label>
										<!-- <input type="text" class="form-control" id="rt_leasee_name" required /> -->
										 <input type="text" class="form-control" id="pd_gep_glpin" required/>
									</div>
									<div class="form-row mb-2">
										<label for="">GLPIN.: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="pd_gep_glpin" required/>
									</div>
								
								</div>
								<div class="col-6">
										<div class="form-row mb-2">
										<label for="">Locality: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="pd_gep_locality" required />
									</div>
									<div class="form-row mb-2">
										<label for="">Land Size: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="pd_gep_land_size" required/>
									</div>
								</div>
							</div>

						
					</div>
				</div>
				<div class="table-responsive small">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_parcel_details" width="100%" cellspacing="0">
						  <thead class="small">
                            <tr>
                                <th>Plot Number</th>
                                <th>Name of Lessee</th>
                                <th>File Number</th>
                                <th>Commencement Date</th>
                                <th>Consent Date</th>
                                <th>Term</th>
                                <th>Plot Size</th>
                                <th>Rent Review Period</th>
                                <th>Last Payment Period</th>
                                <th>Rent Outstanding</th>
                                <th>Unexpired Term</th>
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




<!-- Division Modal-->
<div class="modal fade addlegder" data-position="0" id="addlegder" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modal_label">Add New Lessee</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="addlegderForm">
					<div class="mb-4">
						<a href="javascript:void(0)" style="text-decoration: underline;"  data-toggle="collapse" data-target="#linkExistingTrans">Link Existing Transaction</a>
						<div class="collapse mb-2" id="linkExistingTrans">
						<div class="card card-body">
							
								<label for="">File Number: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="fileNumberForExistingTransac" required/>
							
							<button type="button" class="btn btn-success btn-sm mt-2" id="btnLinkExistingTrans">Load</button>
						</div>
					</div>
					</div>
					<div class="card">
						<span class="card-label bg-secondary">Lesee's Details</span>
						<div class="card-body">
						<input id="rt_rent_id" class="rt_rent_id" value="0" type="hidden"/>
						<input id="rt_parcel_id" value="0" type="hidden"/>
							<div class="row">
								<div class="col-12">
									<div class="form-row mb-2">
										<label for="">Name: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_leasee_name" required />
								</div>
							</div>


								<div class="col-6">
									
									<div class="form-row mb-2">
										<label for="">Postal Address: <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="rt_leasee_address" required />
									</div>
									<div class="form-row mb-2">
										<label for="">Digital Address: </label>
										<input type="text" class="form-control" id="rt_leasee_digital_address" required />
									</div>
									<div class="form-row mb-2">
										<label for="">Email: </label>
										<input type="email" class="form-control" id="rt_email" />
									</div>
									
								</div>
								<div class="col-6">
									<div class="form-row mb-2">
										<label for="">Mobile Phone 2: </label>
										<input type="tel" class="form-control" id="rt_mobile_phone_2"/>
									</div>
									<div class="form-row mb-2">
										<label for="">Mobile Phone:</label>
										<input type="tel" class="form-control" id="rt_mobile_phone_1" required/>
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
									<label for="">Convenanted User: </label>
									<!-- <input type="text" class="form-control" id="rt_convenant_user" /> -->
									<select class="form-control input-sm" name="" id="rt_convenant_user">
									<option selected disabled value="">-- select --</option>
									
									<c:forEach items="${user_category_list}" var="usercategorylist">
										<option  value="${usercategorylist.us_name}">${usercategorylist.us_name}</option>
									</c:forEach>
									</select>
								</div>
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
									<label for="">Plot Number: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="rt_plot_number" required/>
								</div>
								<div class="form-row mb-2">
									<label for="">Plot Size (Acres): <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="rt_plot_size" required/>
								</div>
								<!-- <div class="form-row mb-2">
									<label for="">Block Number: </label>
									<input type="text" class="form-control" id="rt_block_number" />
								</div> -->
								
							</div>
							<div class="col-6">
								<div class="form-row mb-2">
									<label for="">Parcel Address: </label>
									<input type="tel" class="form-control" id="rt_parcel_address"/>
								</div>
								
								<!-- <div class="form-row mb-2">
									<label for="">Orginal Use: </label>
									<select class="form-control input-sm" name="" id="rt_original_use">
										<option selected disabled value="">-- select --</option>
									</select>
								</div> -->
								
								
								<div class="form-row mb-2">
									<label for="">File Number: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="rt_file_number" required/>
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
								<!-- <div class="form-row mb-2">
									<label for="">GLPIN: </label>
									<input type="text" class="form-control" id="rt_glpin" />
								</div> -->
								
							</div>
						</div>
						</div>
					</div>

					<div class="card mt-4">
						<span class="card-label bg-secondary">Tenure Information</span>
						<div class="card-body">
						<div class="row">
							<div class="col-6">
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
							</div>
							<div class="col-6">
								<div class="form-row mb-2">
									<label for="">Commencement Date: <span class="text-danger">*</span></label>
									<input type="date" class="form-control" id="rt_commencement_date" required/>
								</div>
								<div class="form-row mb-2">
									<label for="">Term: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="rt_term" required/>
								</div>
							</div>
							
						</div>
						</div>
					</div>

					<div class="card mt-4">
						<span class="card-label bg-secondary">Rent Terms</span>
						<div class="card-body">
						<div class="row">
							<div class="col-6">
								<div class="form-row mb-2">
									<label for="">Rent Category: </label>
									<!-- <input type="text" class="form-control" id="rt_rent_category" /> -->
									<select class="form-control input-sm" name="" id="rt_rent_category">
										<option selected disabled value="">-- select --</option>
										<option  value="Economic Rent">Economic Rent</option>
										<option  value="Subsidized Rent">Subsidized Rent</option>
										<option  value="Peppercorn Rent">Peppercorn Rent</option>
										<!-- <option  value="Economic rent">Economic rent</option> -->
									</select>
								</div>
								<div class="form-row mb-2">
									<label for="">Rent Revision Period: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" value="0" id="rt_rent_review_clause" />
								</div>
							</div>
							<div class="col-6">
								<div class="form-row mb-2">
									<label for="">Rent Passing: </label>
									<input type="text" class="form-control"  value="0" id="rt_rent_passing"  />
								</div>
								<div class="form-row mb-2">
									<label for="">Location Rate: <span class="text-danger">*</span></label>
									<input type="text" class="form-control"  id="rt_location_rate" value="0.00" required />
								</div>
							</div>
							
						</div>
						</div>
					</div>

					<div class="card mt-3">
						<span class="card-label bg-secondary">Payment History</span>
						<div class="card-body">
						<div class="row">
							<div class="col-6">
								
								
								<div class="form-row mb-2">
									<label for="">Last Payment Date: <span class="text-danger">*</span></label>
									<input type="date" class="form-control" id="rt_last_payment_date" required />
								</div>
								<div class="form-row mb-2">
									<label for="">Last Payment Period: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" value="0" id="rt_last_payment_period" required/>
								</div>
								<div class="form-row mb-2">
									<label for="">Rent Outstanding: </label>
									<input type="text" class="form-control" value="0" id="rt_rent_outstanding"/>
								</div>
							</div>
							<div class="col-6">

								
								
								<!-- <div class="form-row mb-2">
									<label for="">Classification of Arrears: </label>
									<input type="text" class="form-control" id="rt_classification_of_arrears"/>
								</div> -->
								<div class="form-row mb-2">
									<label for="">Period In Arrears:</label>
									<input type="text" class="form-control" value="0" id="rt_period_in_arrears" value="-"  required/>
								</div>
								<div class="form-row mb-2">
									<label for="">Remarks: </label>
									<input type="text" class="form-control" id="rt_remarks"/>
								</div>
								
							</div>
						</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-danger" data-dismiss="modal">Close</button>
				<button class="btn btn-success" id="btn_save_rent_client_details">Save</button>
			</div>
		</div>
	</div>
</div>



<!-- Division Modal-->
<div class="modal fade editlegder" id="editlegder" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      
      <div class="modal-header">
        <h5 class="modal-title" id="modal_label">Add New Lessee</h5>
        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">X</span>
        </button>
      </div>
      
      <div class="modal-body">
        <form id="editlegderForm">

          <!-- Lessee's Details -->
          <div class="card">
            <span class="card-label bg-secondary">Lessee's Details</span>
            <div class="card-body">
              <input id="rt_e_rent_id" class="rt_e_rent_id" value="0" type="hidden"/>
              <input id="rt_parcel_id" value="0" type="hidden"/>

              <div class="row">
                <div class="col-12">
                  <div class="form-row mb-2">
                    <label for="">Name: <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="rt_e_leasee_name" required />
                  </div>
                </div>

                <div class="col-6">
                  <div class="form-row mb-2">
                    <label for="">Postal Address: <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="rt_e_leasee_address" required />
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Digital Address: </label>
                    <input type="text" class="form-control" id="rt_e_leasee_digital_address" />
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Email: </label>
                    <input type="email" class="form-control" id="rt_e_email" />
                  </div>
                </div>

                <div class="col-6">
                  <div class="form-row mb-2">
                    <label for="">Mobile Phone:</label>
                    <input type="tel" class="form-control" id="rt_e_mobile_phone_1" required/>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Mobile Phone 2: </label>
                    <input type="tel" class="form-control" id="rt_e_mobile_phone_2"/>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Parcel's Details -->
          <div class="card mt-4">
            <span class="card-label bg-secondary">Parcel's Details</span>
            <div class="card-body">
              <div class="row">
                <div class="col-6">
                  <div class="form-row mb-2">
                    <label for="">Convenanted User: </label>
                    <select class="form-control input-sm" id="rt_e_convenant_user">
                      <option selected disabled value="">-- select --</option>
                      <c:forEach items="${user_category_list}" var="usercategorylist">
                        <option value="${usercategorylist.us_name}">${usercategorylist.us_name}</option>
                      </c:forEach>
                    </select>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Current User: </label>
                    <select class="form-control input-sm" id="rt_e_current_use">
                      <option selected disabled value="">-- select --</option>
                      <c:forEach items="${user_category_list}" var="usercategorylist">
                        <option value="${usercategorylist.us_name}">${usercategorylist.us_name}</option>
                      </c:forEach>
                    </select>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Nature of Development: </label>
                    <select class="form-control input-sm" id="rt_e_nature_of_dev"></select>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Plot Number: <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="rt_e_plot_number" required/>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Plot Size (Acres): <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="rt_e_plot_size" required/>
                  </div>
                </div>

                <div class="col-6">
                  <div class="form-row mb-2">
                    <label for="">Parcel Address: </label>
                    <input type="text" class="form-control" id="rt_e_parcel_address"/>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">File Number: <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="rt_e_file_number" required/>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Ledger: <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="rt_e_ledger" required/>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Folio:</label>
                    <input type="text" class="form-control" id="rt_e_folio"/>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">LS Number: </label>
                    <input type="text" class="form-control" id="rt_e_ls_number" />
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Tenure Information -->
          <div class="card mt-4">
            <span class="card-label bg-secondary">Tenure Information</span>
            <div class="card-body">
              <div class="row">
                <div class="col-6">
                  <div class="form-row mb-2">
                    <label for="">Estate: <span class="text-danger">*</span></label>
                    <select id="rt_e_estate" class="form-control input-sm" data-live-search="true">
                      <option selected disabled value="">-- select --</option>
                    </select>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Nature of Instrument: </label>
                    <select class="form-control input-sm" id="rt_e_nature_of_instrument"></select>
                  </div>
                </div>
                <div class="col-6">
                  <div class="form-row mb-2">
                    <label for="">Commencement Date: <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" id="rt_e_commencement_date" required/>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Term: <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="rt_e_term" required/>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Rent Terms -->
          <div class="card mt-4">
            <span class="card-label bg-secondary">Rent Terms</span>
            <div class="card-body">
              <div class="row">
                <div class="col-6">
                  <div class="form-row mb-2">
                    <label for="">Rent Category: </label>
                    <select class="form-control input-sm" id="rt_e_rent_category">
                      <option selected disabled value="">-- select --</option>
                      <option value="Economic Rent">Economic Rent</option>
                      <option value="Subsidized Rent">Subsidized Rent</option>
                      <option value="Peppercorn Rent">Peppercorn Rent</option>
                    </select>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Rent Revision Period: <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" value="0" id="rt_e_rent_review_clause" />
                  </div>
                </div>
                <div class="col-6">
                  <div class="form-row mb-2">
                    <label for="">Rent Passing: </label>
                    <input type="text" class="form-control" value="0" id="rt_e_rent_passing" />
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Location Rate: <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="rt_e_location_rate" value="0.00" required />
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Payment History -->
          <div class="card mt-3">
            <span class="card-label bg-secondary">Payment History</span>
            <div class="card-body">
              <div class="row">
                <div class="col-6">
                  <div class="form-row mb-2">
                    <label for="">Last Payment Date: <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" id="rt_e_last_payment_date" required />
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Last Payment Period: <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" value="0" id="rt_e_last_payment_period" required/>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Rent Outstanding: </label>
                    <input type="text" class="form-control" value="0" id="rt_e_rent_outstanding"/>
                  </div>
                </div>

                <div class="col-6">
                  <div class="form-row mb-2">
                    <label for="">Period In Arrears:</label>
                    <input type="text" class="form-control" value="0" id="rt_e_period_in_arrears" required/>
                  </div>
                  <div class="form-row mb-2">
                    <label for="">Remarks: </label>
                    <input type="text" class="form-control" id="rt_e_remarks"/>
                  </div>
                </div>
              </div>
            </div>
          </div>

        </form>
      </div>

      <div class="modal-footer">
        <button class="btn btn-danger" data-dismiss="modal">Close</button>
        <button class="btn btn-success" id="btn_save_edit_rent_client_details">Save</button>
      </div>

    </div>
  </div>
</div>



<div class="modal fade viewLedger" id="viewLedger" tabindex="-1" role="dialog" aria-labelledby="viewLedgerLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title" id="viewLedgerLabel">Lessee Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>


      <div class="modal-body">
        <!-- Lessee Details -->
        <div class="card mb-3">
          <span class="card-label bg-secondary">Lessee's Details</span>
          <div class="card-body">
            <div class="row">
              <div class="col-6 mb-2">
                <strong>Name:</strong> <span id="view_leasee_name"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Email:</strong> <span id="view_email"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Postal Address:</strong> <span id="view_address"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Digital Address:</strong> <span id="view_digital_address"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Mobile 1:</strong> <span id="view_mobile1"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Mobile 2:</strong> <span id="view_mobile2"></span>
              </div>
            </div>
          </div>
        </div>

        <!-- Parcel Details -->
        <div class="card mb-3">
          <span class="card-label bg-secondary">Parcel's Details</span>
          <div class="card-body">
            <div class="row">
              <div class="col-6 mb-2">
                <strong>Plot Number:</strong> <span id="view_plot_number"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Plot Size:</strong> <span id="view_plot_size"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>File Number:</strong> <span id="view_file_number"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Ledger:</strong> <span id="view_ledger"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Folio:</strong> <span id="view_folio"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>LS Number:</strong> <span id="view_ls_number"></span>
              </div>

			  <div class="col-6 mb-2">
                <strong>Convenanted User:</strong> <span id="view_convenant_user"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Parcel Address:</strong> <span id="view_parcel_address"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Current User:</strong> <span id="view_current_use"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Nature of Development:</strong> <span id="view_nature_of_dev"></span>
              </div>
            </div>
          </div>
        </div>

        <!-- Tenure Information -->
        <div class="card mb-3">
          <span class="card-label bg-secondary">Tenure Information</span>
          <div class="card-body">
            <div class="row">
              <div class="col-6 mb-2">
                <strong>Estate:</strong> <span id="view_estate"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Commencement Date:</strong> <span id="view_commencement_date"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Term:</strong> <span id="view_term"></span>
              </div>
			  <div class="col-6 mb-2">
                <strong>Nature of Instrument:</strong> <span id="view_nature_of_instrument"></span>
              </div>
			   <div class="col-6 mb-2">
                <strong>Expire Date:</strong> <span id="view_expiry_date"></span>
              </div>
            </div>
          </div>
        </div>

        <!-- Rent Terms -->
        <div class="card mb-3">
          <span class="card-label bg-secondary">Rent Terms</span>
          <div class="card-body">
            <div class="row">
              <div class="col-6 mb-2">
                <strong>Rent Category:</strong> <span id="view_rent_category"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Rent Passing:</strong> <span id="view_rent_passing"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Location Rate:</strong> <span id="view_location_rate"></span>
              </div>
			  <div class="col-6 mb-2">
                <strong>Rent Revision Period:</strong> <span id="view_rent_review_clause"></span>
              </div>
            </div>
          </div>
        </div>

        <!-- Payment History -->
        <div class="card mb-3">
          <span class="card-label bg-secondary">Payment History</span>
          <div class="card-body">
            <div class="row">
              <div class="col-6 mb-2">
                <strong>Last Payment Date:</strong> <span id="view_last_payment_date"></span>
              </div>
			  <div class="col-6 mb-2">
                <strong>Last Payment Period:</strong> <span id="view_last_payment_period"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Outstanding Rent:</strong> <span id="view_rent_outstanding"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Period In Arrears:</strong> <span id="view_period_in_arrears"></span>
              </div>
              <div class="col-6 mb-2">
                <strong>Remarks:</strong> <span id="view_remarks"></span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <div class="modal-footer">
        <button class="btn btn-secondary" data-dismiss="modal">Close</button>
		<!-- <button type="button" class="btn btn-primary" id="editLedgerBtn">Edit</button> -->
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

				<button class="btn btn-primary btn-sm mb-2" id="btn_generate_rent_demand_note">Generate Rent Demand Notice</button>
			


				<div class="table-responsive small">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_rent_assessment_details" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Period</th>
								<th>A-1Cedi</th>
								<th>A-1Cedi PA</th>
								<th>Annual Rent</th>
								<th>Amount Assessed </th>
								<th>Description</th>
							

							</tr>
						</thead>
						<tbody>



						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-success btn-sm" id="btn_print_rent_demand_note">View Rent Demand Note</button>
				<button class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>



<div class="modal fade" data-position="0" id="rentTransactionhistory" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rtModalLabel">Transaction History</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<button class="btn btn-warning mb-2 d-none" id="xloadRt" onclick="loadTransactionHistory()"><i class="fa fa-undo"></i></button>
				<button class="btn btn-danger btn-sm mb-2 d-none" id="btnAddNewLessee" data-toggle="modal" data-target="#addlegder">Add New Lessee</button>
				<button class="btn btn-success btn-sm mb-2" id="btnAddTransaction" >Add Transaction</button>
				<!-- <div class="form-row d-none" id="exDatar">
					<div class="col-md-6">
						<label for="">GLPIN: </label>
						<input type="text" class="form-control" id="xxr_glpin" readonly>
					</div>
					<div class="col-md-6">
						<label for="">Land Size: </label>
						<input type="text" class="form-control" id="xxr_plot_size" readonly/>
					</div>
					<div class="col-md-6">
						<label for="">Locality: </label>
						<input type="text" class="form-control" id="xxr_locality" readonly/>
					</div>
				</div> -->
				<input id="rth_m_idxxx" type="hidden" />
				<input id="rth_plot_numberxxx" type="hidden" />
				
				<div class="table-responsive small mt-2">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_rent_transaction_history" width="100%" cellspacing="0">
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

<div class="modal fade" data-position="0" id="addtransactionModal" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rtModalLabelx">Add New Transaction</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- <div class="collapse mt-2" id=""> -->
					<div class="card card-body">
						<form id="transactionhistoryForm">
							<div class="card">
								<span class="card-label bg-secondary">Lessee's Details</span>
								<div class="card-body">
									<input id="rth_rent_id" value="0" type="hidden"/>
									<input id="rth_m_id" value="0" type="hidden"/>
									<input id="rth_account_number" value="0" type="hidden"/>
									
								<div class="row">
									<div class="col-6">
										<div class="form-row mb-2">
											<label for="">Name: <span class="text-danger">*</span></label>
											<input type="text" class="form-control" id="rth_lessee_name" required />
										</div>
										<div class="form-row mb-2">
											<label for="">Address: <span class="text-danger">*</span></label>
											<input type="text" class="form-control" id="rth_lessee_address" required />
										</div>
										<div class="form-row mb-2">
											<label for="">Mobile Phone: <span class="text-danger">*</span></label>
											<input type="tel" class="form-control" id="rth_mobile_phone_1" required/>
										</div>
									</div>
									<div class="col-6">
										<div class="form-row mb-2">
											<label for="">Mobile Phone 2: </label>
											<input type="tel" class="form-control" id="rth_mobile_phone_2"/>
										</div>
										<div class="form-row mb-2">
											<label for="">Email: </label>
											<input type="email" class="form-control" id="rth_email" />
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
											<input type="text" class="form-control" id="rth_plot_number" required/>
										</div>
										<div class="form-row mb-2">
											<label for="">Plot Size: <span class="text-danger">*</span></label>
											<input type="text" class="form-control" id="rth_plot_size" required/>
										</div>
										<!-- <div class="form-row mb-2">
											<label for="">Commencement Date: </label>
											<input type="date" class="form-control" id="rth_comm_date" />
										</div> -->
										<div class="form-row mb-2">
											<label for="">Remarks:  </label>
											<textarea type="text" class="form-control" id="rth_remarks" ></textarea>
										</div>
									</div>
									<div class="col-6">
										<div class="form-row mb-2">
											<label for="">Nature of Instrument:  <span class="text-danger">*</span></label>
											<!-- <input type="tel" class="form-control" /> -->
											<select class="form-control input-sm" name="" id="rth_nature_of_instrument" required>
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
											<label for="">Consent Date:  <span class="text-danger">*</span></label>
											<input type="date" class="form-control" id="rth_consent_date" required/>
										</div> -->
										<div class="form-row mb-2">
											<label for="">Term:  <span class="text-danger">*</span></label>
											<input type="text" class="form-control" id="rth_term" required/>
										</div>
									</div>
								</div>
								</div>
							</div>
							<button class="btn btn-success btn-sm mt-2" id="rth_save_btn">Save Details</button>
						</form>
					</div>
				<!-- </div> -->
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
				<button class="btn btn-warning btn-sm mb-2" id="btn_load_scanned_documents_rent" >Load Documents</button>
				<button class="btn btn-success btn-sm mb-2" data-toggle="collapse" data-target="#uploaddocumentdiv">Upload Document</button>
				  <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-toggle="modal" data-target="#fileUploadModal" title="Add Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button>
				<div class="collapse mb-2" id="uploaddocumentdiv">
					<div class="card card-body">
					 	<div class="d-flex justify-content-between">
					<label for="file">Document on File File:</label>
					
				</div>
				<div class="card card-body fileUploadrent" id="ocfileContainer">	
			 <form class="form-horizontal" method="POST" enctype="multipart/form-data" id="id_form_rent">
			    
			    <input id="fileUploadFormrent" class="form-control" type="file" name="sampleFile" />
				<a href="#" class="ocPreviewBtn mb-3" style="text-decoration: underline;">Preview PDF</a>
			  
			</form>
			</div>
			<label for="query_case_number" class="col-form-label">File
				Number</label> <input type="text" name="file_upload_file_number_rent" id="file_upload_file_number_rent" class="form-control" required readonly 
						>
			<input type="button" id="btn_upload_case_file_rent"
						class="btn btn-primary" value="Click to upload"
		>
			
					</div>
				</div>
				<div class="table-responsive small">
					 <table class="table table-bordered  table-hover table-sm" id="lc_rent_scanned_documents_dataTable" width="100%" class="display" cellspacing="0">
				           
				              <thead>
				                <tr>
				
				                 <th>Document Name</th>
				                 <th>Document Type</th>
				                 <th>Open File</th>
				                  </tr>
				              </thead>
				              
				                <tbody>				
							    <c:forEach items="${casescanneddocuments}" var="casescanneddocuments_row">
				                <tr>
				                    <td>${casescanneddocuments_row.document_name}</td>
				                    <td>${casescanneddocuments_row.document_type}</td>
				                    <td>${casescanneddocuments_row.document_extention}</td>
				                 
					                    <td>
											<form action="registration_application_progress_details" method="post">
												<input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
													<button type="submit" name="save" class="btn btn-info btn-icon-split" >
													<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
													</button>
											</form>
										</td>
	
				                    </tr>
			           			 </c:forEach>
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


<div class="modal fade" data-position="0" id="rentremarks" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel">Remarks</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<button class="btn btn-warning btn-sm mb-2"  onclick="loadTransactionRemarks()">Load Remarks</button>
				<button class="btn btn-success btn-sm mb-2" data-toggle="collapse" data-target="#addremarkdiv">Add Remark</button>
				<div class="collapse mb-2" id="addremarkdiv">
					<div class="card card-body">
						<form id="transactionremarksForm">
							<input id="rnt_id" type="hidden" value="0" />
							<input id="rnt_m_id" type="hidden" value="0" />
							<div class="form-group">
								<div class="row">
									<label class="">Remarks <span class="text-danger">*</span></label>
									<textarea class="form-control" id="rnt_remarks"></textarea>
									<button class="btn btn-primary btn-sm mt-2" id="submitRemark" >Save</button>
								</div>  
							</div>
						</form>
					</div>
				</div>
				<div class="table-responsive small">
					<table class="table table-striped table-bordered table-hover"
						id="tbl_rent_remarks" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Remarks</th>
								<th>Created By</th>
								<th>Date</th>
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
	