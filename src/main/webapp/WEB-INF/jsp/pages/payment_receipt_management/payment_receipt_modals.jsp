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


 <div class="modal fade" data-position="0" id="md_prm_payment_details" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel">Bill Details</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
					<!-- <button class="btn btn-success btn-sm mb-2" data-toggle="collapse" data-target="#addpaymentdiv">Add Payment</button> -->
				
				<input id="prm_pd_pt_id" value="0" type="hidden"/>
				<!-- <input id="rdn_account_number" value="0" type="hidden"/> -->
				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Applicant Name: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_applicant_name" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Applicant Email: </label>
							<input type="tel" class="form-control" id="prm_pd_applicant_email"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Phone Number: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_applicant_phone_number" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Ref Number: </label>
							<input type="tel" class="form-control" id="prm_pd_ref_number"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Bill Date: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_bill_date" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Bill Amount: </label>
							<input type="tel" class="form-control" id="prm_pd_bill_amount"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Is Payment Made: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_is_payment_made" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Date: </label>
							<input type="tel" class="form-control" id="prm_pd_payment_date"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Confiration Status: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_payment_confiration_status" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank Branch: </label>
							<input type="tel" class="form-control" id="prm_pd_payment_bank_branch"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_payment_bank" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Status: </label>
							<input type="tel" class="form-control" id="prm_pd_payment_status"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Mode: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_payment_mode" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Remarks: </label>
							<input type="tel" class="form-control" id="prm_pd_payment_remarks"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Amount: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_payment_amount" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Is EGCR Issued: </label>
							<input type="tel" class="form-control" id="prm_pd_is_egcr_issued"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">EGCR Issued Date: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_egcr_issued_date" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">EGCR Number: </label>
							<input type="tel" class="form-control" id="prm_pd_egcr_number"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Submission Type: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_submission_type" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Business Process Sub Name: </label>
							<input type="tel" class="form-control" id="prm_pd_business_process_sub_name"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Business Process Name: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_business_process_name" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank Branch: </label>
							<input type="tel" class="form-control" id="prm_pd_payment_bank_branch"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Generated By: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_pd_created_by" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">GOG Invoice Number: </label>
							<input type="tel" class="form-control" id="prm_pd_gog_invoice_number"/>
						</div>
					</div>
				</div>

				<!-- <button class="btn btn-primary btn-sm mb-2" id="btn_generate_rent_demand_note">Generate Rent Demand Notie</button>
			 -->

			</div>
			<div class="modal-footer">
				<!-- <button class="btn btn-success btn-sm" id="btn_print_rent_demand_note">Print Rent Demand Note</button> -->
				<button class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>



<div class="modal fade" data-position="0" id="md_prm_check_and_pull_payment" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="divisionModalLabel">Check and Pull Payment</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
					<!-- <button class="btn btn-success btn-sm mb-2" data-toggle="collapse" data-target="#addpaymentdiv">Add Payment</button> -->
				
					<input id="prm_cpp_pt_id" value="0" type="hidden"/>
				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Applicant Name: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_applicant_name" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Applicant Email: </label>
							<input type="tel" class="form-control" id="prm_cpp_applicant_email"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Phone Number: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_applicant_phone_number" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Ref Number: </label>
							<input type="tel" class="form-control" id="prm_cpp_ref_number"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Bill Date: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_bill_date" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Bill Amount: </label>
							<input type="tel" class="form-control" id="prm_cpp_bill_amount"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Is Payment Made: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_is_payment_made" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Date: </label>
							<input type="tel" class="form-control" id="prm_cpp_payment_date"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Confiration Status: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_payment_confiration_status" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank Branch: </label>
							<input type="tel" class="form-control" id="prm_cpp_payment_bank_branch"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_payment_bank" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Status: </label>
							<input type="tel" class="form-control" id="prm_cpp_payment_status"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Mode: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_payment_mode" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Remarks: </label>
							<input type="tel" class="form-control" id="prm_cpp_payment_remarks"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Amount: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_payment_amount" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Is EGCR Issued: </label>
							<input type="tel" class="form-control" id="prm_cpp_is_egcr_issued"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">EGCR Issued Date: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_egcr_issued_date" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">EGCR Number: </label>
							<input type="tel" class="form-control" id="prm_cpp_egcr_number"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Submission Type: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_submission_type" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Business Process Sub Name: </label>
							<input type="tel" class="form-control" id="prm_cpp_business_process_sub_name"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Business Process Name: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_business_process_name" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank Branch: </label>
							<input type="tel" class="form-control" id="prm_cpp_payment_bank_branch"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Generated By: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_cpp_created_by" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">GOG Invoice Number: </label>
							<input type="tel" class="form-control" id="prm_cpp_gog_invoice_number"/>
						</div>
					</div>
				</div>

				<!-- <button class="btn btn-primary btn-sm mb-2" id="btn_generate_rent_demand_note">Generate Rent Demand Notie</button>
			 -->

			</div>
			<div class="modal-footer">
				<button class="btn btn-success btn-sm" id="btn_check_and_pull_details_from_gog">Check and Pull Details from GOG</button>
				<button class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>



<div class="modal fade" data-position="0" id="md_prm_genarate_egcr_number" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
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
				
				<input id="prm_gen_pt_id" value="0" type="hidden"/>
				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Applicant Name: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_applicant_name" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Applicant Email: </label>
							<input type="tel" class="form-control" id="prm_gen_applicant_email"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Phone Number: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_applicant_phone_number" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Ref Number: </label>
							<input type="tel" class="form-control" id="prm_gen_ref_number"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Bill Date: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_bill_date" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Bill Amount: </label>
							<input type="tel" class="form-control" id="prm_gen_bill_amount"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Is Payment Made: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_is_payment_made" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Date: </label>
							<input type="tel" class="form-control" id="prm_gen_payment_date"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Confiration Status: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_payment_confiration_status" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank Branch: </label>
							<input type="tel" class="form-control" id="prm_gen_payment_bank_branch"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_payment_bank" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Status: </label>
							<input type="tel" class="form-control" id="prm_gen_payment_status"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Mode: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_payment_mode" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Remarks: </label>
							<input type="tel" class="form-control" id="prm_gen_payment_remarks"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Amount: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_payment_amount" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Is EGCR Issued: </label>
							<input type="tel" class="form-control" id="prm_gen_is_egcr_issued"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">EGCR Issued Date: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_egcr_issued_date" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">EGCR Number: </label>
							<input type="tel" class="form-control" id="prm_gen_egcr_number"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Submission Type: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_submission_type" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Business Process Sub Name: </label>
							<input type="tel" class="form-control" id="prm_gen_business_process_sub_name"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Business Process Name: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_business_process_name" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank Branch: </label>
							<input type="tel" class="form-control" id="prm_gen_payment_bank_branch"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Generated By: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gen_created_by" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">GOG Invoice Number: </label>
							<input type="tel" class="form-control" id="prm_gen_gog_invoice_number"/>
						</div>
					</div>
				</div>


				<!-- <button class="btn btn-primary btn-sm mb-2" id="btn_generate_rent_demand_note">Generate Rent Demand Notie</button>
			 -->

			</div>
			<div class="modal-footer">
				<button class="btn btn-success btn-sm" id="btn_generate_egcr_number">Generate EGCR Number</button>
				<button class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>



<div class="modal fade" data-position="0" id="md_prm_egcr_pdf" tabindex="-1" role="dialog" aria-labelledby="divisionModalLabel" aria-hidden="true">
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
				
				<input id="prm_gpdf_pt_id" value="0" type="hidden"/>
				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Applicant Name: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_applicant_name" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Applicant Email: </label>
							<input type="tel" class="form-control" id="prm_gpdf_applicant_email"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Phone Number: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_applicant_phone_number" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Ref Number: </label>
							<input type="tel" class="form-control" id="prm_gpdf_ref_number"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Bill Date: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_bill_date" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Bill Amount: </label>
							<input type="tel" class="form-control" id="prm_gpdf_bill_amount"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Is Payment Made: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_is_payment_made" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Date: </label>
							<input type="tel" class="form-control" id="prm_gpdf_payment_date"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Confiration Status: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_payment_confiration_status" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank Branch: </label>
							<input type="tel" class="form-control" id="prm_gpdf_payment_bank_branch"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_payment_bank" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Status: </label>
							<input type="tel" class="form-control" id="prm_gpdf_payment_status"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Mode: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_payment_mode" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Remarks: </label>
							<input type="tel" class="form-control" id="prm_gpdf_payment_remarks"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Amount: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_payment_amount" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Is EGCR Issued: </label>
							<input type="tel" class="form-control" id="prm_gpdf_is_egcr_issued"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">EGCR Issued Date: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_egcr_issued_date" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">EGCR Number: </label>
							<input type="tel" class="form-control" id="prm_gpdf_egcr_number"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Submission Type: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_submission_type" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Business Process Sub Name: </label>
							<input type="tel" class="form-control" id="prm_gpdf_business_process_sub_name"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Business Process Name: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_business_process_name" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Payment Bank Branch: </label>
							<input type="tel" class="form-control" id="prm_gpdf_payment_bank_branch"/>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">Generated By: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="prm_gpdf_created_by" required />
						</div>
					</div>
					<div class="col-6">
						<div class="form-row mb-2">
							<label for="">GOG Invoice Number: </label>
							<input type="tel" class="form-control" id="prm_gpdf_gog_invoice_number"/>
						</div>
					</div>
				</div>


				<!-- <button class="btn btn-primary btn-sm mb-2" id="btn_generate_rent_demand_note">Generate Rent Demand Notie</button>
			 -->

			</div>
			<div class="modal-footer">
				<button class="btn btn-success btn-sm" id="btn_generate_egcr_pdf">Generate EGCR PDF</button>
				<button class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
