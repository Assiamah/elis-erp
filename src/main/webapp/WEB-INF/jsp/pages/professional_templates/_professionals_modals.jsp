<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>








<!--  Service Bill============================= -->
<div class="modal fade" data-bs-backdrop="static" id="addNewserviceBillModalProfessional" tabindex="-1"
	role="dialog" aria-labelledby="newValuationModalLabel"
	aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addNewserviceBillModalProfessional">New Service
					Bill</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- <form id="from_add_valuation"> -->

				<input id="action_on_form_valuation" type="hidden"> <input
					type="hidden" id="main_service_id_pf" name="main_service_id_pf"
					value="${main_service_id}"
				> <input type="hidden" id="main_service_sub_id_pf"
					name="main_service_sub_id_pf" value="${main_service_sub_id}"
				> <input type="hidden" id="request_type" name="request_type"
					value="process_online_select_bill_for_registration"
				>


				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="main_service_desc">Main Service</label> <input
								class="form-control" id="main_service_desc_pf"
								name="main_service_desc_pf" type="text" aria-describedby="nameHelp"
								value="${main_service_desc}" readonly
							>
						</div>
						<div class="col-md-6">
							<label for="main_service_sub_desc">Sub Service</label> 
							 <select name="sub_service_on_case_pf" id="sub_service_on_case_pf" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  
                </select>
						</div>
						
						
						
		
					</div>
				</div>


				<div id="checksigs-no-div_pf" style="display: none">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-3">
								<label for="new_bill_application_ls_number_pf">Surveyor's
									Number</label> <input class="form-control"
									id="new_bill_application_ls_number_pf" name="ls_number"
									type="text" aria-describedby="nameHelp" required
								>
							</div>
							<div class="col-md-1">
								<label for="new_bill_application_ls_number_pf">-</label>
								<!--  <input type="button" id="lc_btn_check_status_of_lincense_surveyor" class="btn btn-primary btn-block" value="C" /> -->
								<button type="button" class="btn btn-primary pull-right"
									style="margin-bottom: 5px"
									id="lc_btn_check_status_of_lincense_surveyor_pf"
									data-placement="top" data-toggle="tooltip"
									title="Search for Surveyor"
								>
									<i class="fa fa-search"></i>
								</button>
							</div>
							<div class="col-md-8">
								<label for="qty">Surveyor's Name</label> <input
									class="form-control" id="new_bill_application_surveyors_name_pf"
									name="new_bill_application_surveyors_name_pf" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>
						</div>
					</div>


					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="new_bill_application_ls_number_pf">Surveyor's
									Status</label> <input class="form-control"
									id="new_bill_application_surveyors_status_pf"
									name="new_bill_application_surveyors_status_pf" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>
							<!-- <div class="col-md-6">
                <label for="qty">Quantity Required</label>
                <input class="form-control" id="new_bill_application_qty" name="new_bill_application_qty"  type="number" min="0" step="1"aria-describedby="nameHelp" placeholder="Enter Quantity" required>
              </div> -->
						</div>
					</div>

				</div>

				<div class="row">
					<div class="col-lg-8">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>${main_service_desc} Check List
							</div>
							<div class="card-body">



								<!--  Here is where the fee list comes -->

								<div class="table-responsive">
									<table class="table table-bordered"
										id="new_checlist_pf_table_billdataTable" width="100%"
										cellspacing="0"
									>
										<thead>
											<tr>
												<th>Description</th>
												<th>Option</th>

											</tr>
										</thead>
										<tfoot>
											<tr>
												<th>Description</th>
												<th>Option</th>
											</tr>
										</tfoot>
										<tbody>



										</tbody>
									</table>
								</div>

								<!--  End Of Table -->
							</div>
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>


				<div class="form-group">
					<div class="form-row">
						<label for="client_name">Client Name</label> <input
							class="form-control" id="new_bill_application_client_name_pf"
							name="new_bill_application_client_name_pf" type="text"
							aria-describedby="nameHelp" placeholder="Enter Client Name"
							required
						>
					</div>
				</div>




				<div id="reg-no-div_pf" style="display: none">






					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="gender">Gender</label> <select
									name="new_bill_application_gender_pf"
									id="new_bill_application_gender_pf" class="form-control input-sm"
									data-style="btn-info" data-live-search="true"
								>
									<option value="-1">Select Gender</option>
									<c:forEach items="${genderlist}" var="gender">
										<option value="${gender.gender_name}">${gender.gender_name}</option>
									  </c:forEach>
							  
									<option value="Male">Male</option>
								<option value="Female">Female</option>
								
								<option value="Couple">Couple</option>
								<option value="Company">Company</option>
								<option value="Multiple">Multiple</option>
								</select>

							</div>

						</div>
					</div>


					<div class="form-group">
						<div class="form-row">

							<div class="col-md-6">
								<label for="region">Region</label> <select
									name="new_bill_application_region_pf"
									id="new_bill_application_region_pf" class="form-control input-sm"
									data-style="btn-info" data-live-search="true"
								>
									<option value="-1">Select Region</option>
									<c:forEach items="${regionlist}" var="region">
										<option  value="${region.region_name}">value="${region.region_name}</option>
							  </c:forEach>
			 
								</select>

							</div>

							<div class="col-md-6">
								<label for="disitrict">District</label> <select
									name="new_bill_application_district_pf"
									id="new_bill_application_district_pf"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select District</option>
									
								</select>

							</div>

						</div>
					</div>



				</div>

				<div id="selectlocality-no-div_pf" style="display: none">
					<div class="form-group">
						<div class="form-row">

							<div class="col-md-6">
								<label for="locality">Locality</label> <select
									name="new_bill_application_locality_pf"
									id="new_bill_application_locality_pf"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select Locality</option>
									<c:forEach items="${localitylist}" var="locality">
										<option  value="${locality.locality_name}">${locality.locality_name}</option>
							 </c:forEach>
			 
								</select> 

							</div>
						</div>
					</div>
				</div>



				<div id="stp-no-div_pf" style="display: none">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">

								<label for="client_name">Number of Copies</label> <input
									class="form-control" id="new_number_of_copies_pf"
									name="new_number_of_copies_pf" type="text"
									aria-describedby="nameHelp" placeholder="Enter No of Copies"
									required
								>
							</div>
							<div class="col-md-6">
								<label for="new_type_of_revenue_item">Type of Revenue
									Item</label> 
									<select name="new_type_of_revenue_item_pf"
									id="new_type_of_revenue_item_pf" class="form-control input-sm"
									data-style="btn-info" data-live-search="true"
								>
									<option value="-1">Select Type of Revenue</option>
									<c:forEach items="${lvdrevenuelist}" var="lvdrevenue">
										<option  value="${lvdrevenue.rv_item_id}-${lvdrevenue.revenue_items_name}">${lvdrevenue.revenue_items_name}</option>
							 </c:forEach>
			 
								</select>

							</div>
						</div>
					</div>
				</div>



				<div id="fsearches-no-div_pf" style="display: none">

					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">

								<label for="client_name">Land Size(Acres)</label> <input
									class="form-control" id="new_bill_land_size_pf"
									name="new_bill_land_size_pf" type="text"
									aria-describedby="nameHelp" placeholder="Enter land Size"
									required
								>
							</div>
							<div class="col-md-6">
								<label for="new_bill_type_of_use_pf">Type of Use</label> <select
									name="type_of_use" id="new_bill_type_of_use_pf"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select Type of Use</option>

								</select>

							</div>
						</div>
					</div>



				</div>



				<div id="freg-no-div_pf" style="display: none">


					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="registration_forms">Forms</label> <select
									name="new_bill_registration_forms_pf"
									id="new_bill_registration_forms_pf" class="form-control input-sm"
									data-style="btn-info" data-live-search="true"
								>
									<option value="-1">Select Registration Forms</option>

								</select>

							</div>
							<div class="col-md-6">

								<label for="publication_type">Publication Type</label> <select
									name="new_bill_publication_type_pf" id="new_bill_publication_type_pf"
									data-live-search="true"
									data-none-results-text="I found no results"
									title="Please select fruit" class="form-control selectpicker"
								>
									<option value="normal_publication">Normal Publication</option>
									<option value="special_publication">Special
										Publication</option>
								</select>

							</div>
						</div>
					</div>
				</div>
				
				
				
									<div class="form-group">
						<div class="form-row">

							<div class="col-md-6">
								<label for="locality">Office Region</label>
								 <select
									name="new_bill_application_office_region_pf"
									id="new_bill_application_office_region_pf"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select Office Region</option>
									
									<c:forEach items="${officeregionlist}" var="officeregion">
										<option  value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
							  </c:forEach>
			 
								</select>

							</div>
						</div>
					</div>


				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal"
					>Close</button>
					<button type="button"
						id="btn_save_to_generate_new_bill_not_on_case_pf"
						class="btn btn-primary"
					>Generate Bill</button>
				</div>
				<!-- </form> -->
			</div>
		</div>
	</div>
</div>





<!-- After Payment Summary============================= -->
<div class="modal fade" data-bs-backdrop="static" id="NotoncaseafterPaymentModalonCaseProfessional"
	tabindex="-1" role="dialog" aria-labelledby="afterPaymentModalLabel"
	aria-hidden="true"
>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="afterPaymentModalLabel">After
					Payment(New Case)</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close"
				>
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">

				<input type="hidden" id="txt_not_on_case_ap_main_service_id_pf"
					name="txt_not_on_case_ap_main_service_id_pf"
				> <input type="hidden" id="txt_not_on_case_ap_main_service_sub_id_pf"
					name="txt_not_main_service_sub_id_pf"
				> <input type="hidden" id="txt_not_on_case_ap_jn_id_pf"
					name="txt_not_on_case_ap_jn_id_pf" value="jn_id"
				> <input type="hidden" id="txt_not_on_case_ap_userid_pf"
					name="txt_not_on_case_ap_userid_pf" value="${userid}"
				> <input type="hidden" id="txt_not_on_case_ap_user_fullname_pf"
					name="user_fullname_pf" value="${fullname}"
				>






				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="main_service_desc">Main Service</label> <input
								class="form-control" id="txt_not_on_case_ap_main_service_desc_pf"
								name="txt_not_on_case_ap_main_service_desc_pf" type="text"
								aria-describedby="nameHelp" readonly
							>
						</div>
						<div class="col-md-6">
							<label for="main_service_sub_desc">Sub Service</label> <input
								class="form-control"
								id="txt_not_on_case_ap_main_service_sub_desc_pf"
								name="txt_not_on_case_ap_main_service_sub_desc_pf" type="text"
								aria-describedby="nameHelp" readonly
							>
						</div>
					</div>
				</div>


				<div class="form-group">
					<div class="form-row">
						<div class="col-md-6">
							<label for="client_name">Client Name</label> <input
								class="form-control" id="txt_not_on_case_ap_client_name_pf"
								name="txt_not_on_case_ap_client_name_pf" type="text"
								aria-describedby="nameHelp" readonly
							>
						</div>
						<div class="col-md-6">
							<label for="main_service_sub_desc">Land Size</label> <input
								class="form-control" id="txt_not_on_case_ap_land_size_pf"
								name="txt_not_on_case_ap_land_size" type="text"
								aria-describedby="nameHelp" readonly
							>
						</div>
					</div>
				</div>


		<div id="checksigs-no-div_afp_pf" style="display: none">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-3">
								<label for="new_bill_application_ls_number_pf">Surveyor's
									Number</label> <input class="form-control"
									id="new_bill_application_ls_number_afp_pf" name="ls_number"
									type="text" aria-describedby="nameHelp" readonly
								>
							</div>
							<div class="col-md-1">
								<label for="new_bill_application_ls_number_pf">-</label>
								<!--  <input type="button" id="lc_btn_check_status_of_lincense_surveyor" class="btn btn-primary btn-block" value="C" /> -->
								<button type="button" class="btn btn-primary pull-right"
									style="margin-bottom: 5px"
									id="lc_btn_check_status_of_lincense_surveyor_afp_pf"
									data-placement="top" data-toggle="tooltip"
									title="Search for Surveyor"
								>
									<i class="fa fa-search"></i>
								</button>
							</div>
							<div class="col-md-8">
								<label for="qty">Surveyor's Name</label> <input
									class="form-control" id="new_bill_application_surveyors_name_afp_pf"
									name="new_bill_application_surveyors_name_pf" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>
						</div>
					</div>


					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="new_bill_application_ls_number_pf">Surveyor's
									Status</label> <input class="form-control"
									id="new_bill_application_surveyors_status_afp_pf"
									name="new_bill_application_surveyors_status_afp_pf" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>
							<!-- <div class="col-md-6">
                <label for="qty">Quantity Required</label>
                <input class="form-control" id="new_bill_application_qty" name="new_bill_application_qty"  type="number" min="0" step="1"aria-describedby="nameHelp" placeholder="Enter Quantity" required>
              </div> -->
						</div>
					</div>

				</div>


				<div class="row">
					<div class="col-lg-12">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>${main_service_desc} Check List
							</div>
							<div class="card-body">



								<!--  Here is where the fee list comes -->

								<div class="table-responsive">
									<table class="table table-bordered"
										id="tbl_not_on_case_after_payment_ap_checklist_dataTable_pf"
										width="100%" cellspacing="0"
									>
										<thead>
											<tr>
												<th>Description</th>
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
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>






				<div class="row">
					<div class="col-lg-12">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>Bill And Payments
							</div>
							<div class="card-body">



								<!--  Here is where the fee list comes -->

								<div class="table-responsive">
									<table class="table table-bordered"
										id="tbl_not_on_case_ap_bills_payments_dataTable_pf" width="100%"
										cellspacing="0"
									>
										<thead>
											<tr>
												<th>Bill Number</th>
												<th>Bill Description</th>
												<th>Bill Amount</th>
												<th>Amount Paid</th>
												<th>Payment Mode</th>
												<th>Division</th>


											</tr>
										</thead>

										<tbody>


										</tbody>
									</table>
								</div>

								<!--  End Of Table -->
							</div>
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>



				<div class="row">
					<div class="col-lg-12">
						<!-- Example Bar Chart Card-->
						<div class="card mb-3">
							<div class="card-header">
								<i class="fa fa-bar-chart"></i>Parties to Transaction
							</div>
							<div class="card-body">










								<div class="form-row">
									<div class="col-md-10">
										<label for="search_value">Client Name</label> <input readonly
											class="form-control" id="txt_not_on_case_bl_txt_ar_name_pf"
											name="txt_not_on_case_bl_txt_ar_name_pf" type="text"
											aria-describedby="nameHelp"
										>
									</div>





									<div class="col-md-2">
										<label for="bl_job_number">Gender</label> 
										
										
										<input class="form-control" id="txt_not_on_case_bl_txt_ar_gender_pf"
											name="txt_not_on_case_bl_txt_ar_gender_pf" type="text"
											aria-describedby="nameHelp" readonly>
							
										
										
									</div>

								</div>



								<div id="ap-partysearch-no-div_pf" style="display: none">
									<div class="form-group">
										<div class="form-row">
											<%-- <div class="col-md-3">
										<label for="search_value">ID Card Number</label> <input
											class="form-control" id="id_card_number_search"
											name="id_card_number_search" type="text"
											aria-describedby="nameHelp"
											placeholder="Enter ID Card Number" value="${case_number}">

									</div>

									<div class="col-md-1">
										<label for="search_value">-</label>
										<button class="form-control" type="button"
											id="btn_card_number_search" class="btn btn-primary">
											<i class="fa fa-object-group"></i>
										</button>
									</div> --%>

											<div class="col-md-8">
												<label for="search_value">Client Address</label> <input
													class="form-control"
													id="txt_not_on_case_bl_txt_client_address_pf"
													name="txt_not_on_case_bl_txt_client_address_pf" type="text"
													aria-describedby="nameHelp"
												>
											</div>

											<div class="col-md-4">
												<label for="bl_job_number">Phone #</label> <input
													class="form-control " type="text"
													placeholder="Enter Phone Number"
													id="txt_not_on_case_bl_txt_ar_cell_phone_pf"
												>
											</div>

										</div>

									</div>
								</div>



								<div class="form-row">



									<div class="col-md-4">
										<label for="job_number">Ref No</label> <input
											class="form-control" id="txt_not_on_case_ap_job_number_pf"
											name="txt_not_on_case_ap_job_number_pf" type="text"
											aria-describedby="nameHelp" readonly
										>
									</div>




									<!-- <div class="col-md-4">
										<label for="bl_job_number">ID Type</label> <select
											name="txt_not_on_case_bl_cbo_ar_id_type"
											id="txt_not_on_case_bl_cbo_ar_id_type"
											data-live-search="true"
											data-none-results-text="I found no results"
											title="Please select fruit" class="form-control selectpicker">
											<option value="National ID">National ID</option>
											<option value="Drivers License">Drivers License</option>
											<option value="NHIS">NHIS</option>
											<option value="Passport">Passport</option>

										</select>
									</div>

									<div class="col-md-4">
										<label for="bl_job_number">ID Number</label> <input
											class="form-control " type="text" placeholder=""
											id="txt_not_on_case_bl_txt_ar_id_number">
									</div> -->

								</div>



								<div class="form-row">
									<!-- <div class="col-md-4">
										<label for="bl_job_number">Type of Party</label> <select
											name="txt_not_on_case_bl_cbo_type_of_party"
											id="txt_not_on_case_bl_cbo_type_of_party"
											data-live-search="true"
											data-none-results-text="I found no results"
											title="Please select fruit" class="form-control selectpicker">
											<option value="Applicant">Applicant</option>
											<option value="Grantor">Grantor</option>
											<option value="Depositor">Depositor</option>
										</select>
									</div> -->
									<!-- 	<div class="col-md-4">
										<label for="search_value">Save New Party</label>
										<button id="btn_not_on_case_add_new_party"
											class="form-control" class="btn">
											<i class="fa fa-home"></i>Save New Party
										</button>
									</div> -->
									<!-- 	<div class="col-md-4">
											<label for="job_number">Ref No</label> <input
												class="form-control" id="txt_not_on_case_ap_job_number"
												name="txt_not_on_case_ap_job_number" type="text"
												aria-describedby="nameHelp" readonly>
										</div>
										
										<div class="col-md-4">
											<label for="job_number">LS Number</label> <input
												class="form-control" id="txt_not_on_case_ap_licensed_surveyor_number"
												name="txt_not_on_case_ap_licensed_surveyor_number" type="text"
												aria-describedby="nameHelp" readonly>
										</div> -->
								</div>





								<div class="form-group"></div>







								<!--  End Of Table -->
							</div>
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>


				<div id="ap-typeofuse-no-div_pf" style="display: none">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">

								<label for="client_name">Type of Use</label> <input
									class="form-control" id="txt_not_on_case_ap_type_of_use_pf"
									name="txt_not_on_case_ap_type_of_use_pf" type="text"
									aria-describedby="nameHelp" required
								>
							</div>

						</div>
					</div>
				</div>

				<div id="ap-selectlocality-no-div_pf" style="display: none">
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<br> <label for="client_name">locality</label> <input
									class="form-control" id="txt_not_on_case_ap_locality_of_parcel_pf"
									name="txt_not_on_case_ap_locality_of_parcel_pf" type="text"
									aria-describedby="nameHelp"
									placeholder="Enter locality_of_parcel" required readonly
								>
							</div>

						</div>
					</div>
				</div>


				<div id="ap-reg-no-div_pf" style="display: none">

					<div class="form-row">
						<div class="col-md-4">
							<label for="region">Region</label> <input class="form-control"
								id="txt_not_on_case_ap_region_pf" name="txt_not_on_case_ap_region_pf"
								type="text" aria-describedby="nameHelp" readonly
							>
						</div>
						<div class="col-md-8">
							<label for="district">District</label> <input
								class="form-control" id="txt_not_on_case_ap_district_pf"
								name="txt_not_on_case_ap_district_pf" type="text"
								aria-describedby="nameHelp" readonly
							> <br>
							<br>
						</div>


					</div>



					<div class="form-group">
						<div class="form-row">

							<div class="col-md-2">
								<label for="job_number">LS Number</label> <input
									class="form-control"
									id="txt_not_on_case_ap_licensed_surveyor_number_pf"
									name="txt_not_on_case_ap_licensed_surveyor_number_pf" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>

							<div class="col-md-10">
								<label for="job_number">Surveyor's Name</label> <input
									class="form-control"
									id="txt_not_on_case_ap_licensed_surveyor_name_pf"
									name="txt_not_on_case_ap_licensed_surveyor_name_pf" type="text"
									aria-describedby="nameHelp" readonly
								>
							</div>


						</div>

					</div>

					<div class="form-group">
						<div class="form-row">

							<div class="col-md-6">

								<label for="application_type">Application Type</label> <select
									name="txt_not_on_case_ap_application_type_pf"
									id="txt_not_on_case_ap_application_type_pf"
									data-live-search="true"
									data-none-results-text="I found no results"
									title="Please select fruit" class="form-control selectpicker"
								>
									<option value="Individual">Individual</option>
									<option value="Joint">Joint</option>
									<option value="Company">Company</option>

								</select>

							</div>

						</div>
					</div>

				</div>


				<div id="ap-stp-no-div_pf" style="display: none">
					<div class="form-group">
						<div class="form-row">



							<div class="col-md-6">
								<label for="type_of_interest">Type of Instrument</label> <select
									name="txt_not_on_case_ap_type_of_instrument_pf"
									id="txt_not_on_case_ap_type_of_instrument_pf"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true"
								>
									<option value="-1">Select Type of Instrument</option>
									<option value="LEASEHOLD">LEASEHOLD</option>
									<option value="FREEHOLD">FREEHOLD</option>

								</select>

							</div>



						</div>
					</div>
				</div>


			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button"
					id="btn_not_on_case_ap_generate_acknowledgement_pf"
					class="btn btn-primary"
				>Generate Acknowledgement Slip</button>
			</div>

		</div>
	</div>
</div>




<div class="modal fade" data-bs-backdrop="static" id="applicationStatusChecking" tabindex="-1" role="dialog"
	aria-labelledby="applicationStatusChecking" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Application Status And Tracking</h4>
			</div>
			<div class="modal-body">

				<div class="form-group">
					<label for="bl_job_number">Job Number</label> <input
						class="form-control " type="text" placeholder=""
						id="bl_job_number_mss" readonly
					>
				</div>


				<div class="form-group">
					<label for="bl_ar_name">Applicant Name</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_ar_name_mss" readonly
					></textarea>
				</div>

				<div class="form-group">
					<label for="bl_business_process_sub_name">Application Type</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_business_process_sub_name_mss" readonly
					></textarea>
				</div>



<!-- 
				<div class="form-group">
					<label for="bl_job_purpose">Sent Purpose</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_job_purpose_mss"
					></textarea>
				</div> -->
				
				

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
										id="tbl_list_of_milestone_stone_dataTable_pf"
										width="100%" cellspacing="0"
									>
										<thead>
											<tr>
												<th>Milestone Dsec</th>
												<th>Status</th>

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
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>



				
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->


				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>














<div class="modal fade" data-bs-backdrop="static" id="applicationStatusupdate" tabindex="-1" role="dialog"
	aria-labelledby="applicationStatusChecking" aria-hidden="true"
>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Application Status Update</h4>
			</div>
			<div class="modal-body">

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



<!-- 
				<div class="form-group">
					<label for="bl_job_purpose">Sent Purpose</label>
					<textarea rows="2" class="form-control" placeholder=""
						id="bl_job_purpose_mss"
					></textarea>
				</div> -->
				
				

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
							<div class="card-footer small text-muted"></div>
						</div>


					</div>
				</div>



				
			</div>
			<div class="modal-footer ">

				<div class="my-2"></div>
				

				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>



				 
               <button type="button" id="btn_update_milestone_status_for_application" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Update Status</button>
     


				<input type="hidden" id="bl_jn_id" name="jn_id"> <input
					type="hidden" id="bl_send_by_id" name="send_by_id"
				> <input type="hidden" id="bl_userid" name="userid">
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>




</body>

</html>