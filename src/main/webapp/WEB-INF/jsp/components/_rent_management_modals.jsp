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



<div class="modal fade effect-scale modal-blur" id="viewLedgerModal" tabindex="-1" aria-labelledby="viewLedgerModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="viewLedgerModalLabel">
                    <i class="fas fa-file-contract me-2"></i>Lease/Ledger Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Leasee Information Card -->
                <div class="card mb-4">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">
                            <i class="fas fa-user-tie me-2 text-primary"></i>Lessee Information
                        </h6>
                        <span class="badge bg-primary" id="view_account_number"></span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small mb-1">Full Name</label>
                                <div class="form-control bg-light" id="view_leasee_name">-</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small mb-1">Email Address</label>
                                <div class="form-control bg-light" id="view_email">-</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small mb-1">Primary Mobile</label>
                                <div class="form-control bg-light" id="view_mobile1">-</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small mb-1">Secondary Mobile</label>
                                <div class="form-control bg-light" id="view_mobile2">-</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small mb-1">Residential Address</label>
                                <div class="form-control bg-light" id="view_address">-</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small mb-1">Digital Address</label>
                                <div class="form-control bg-light" id="view_digital_address">-</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Property Details Card -->
                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h6 class="mb-0">
                            <i class="fas fa-map-marker-alt me-2 text-success"></i>Property Details
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Plot Number</label>
                                <div class="form-control bg-light" id="view_plot_number">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Plot Size (sqm)</label>
                                <div class="form-control bg-light" id="view_plot_size">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Estate</label>
                                <div class="form-control bg-light" id="view_estate">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">LS Number</label>
                                <div class="form-control bg-light" id="view_ls_number">-</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small mb-1">Parcel Address</label>
                                <div class="form-control bg-light" id="view_parcel_address">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Ledger</label>
                                <div class="form-control bg-light" id="view_ledger">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Folio</label>
                                <div class="form-control bg-light" id="view_folio">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">File Number</label>
                                <div class="form-control bg-light" id="view_file_number">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Covenanted User</label>
                                <div class="form-control bg-light" id="view_convenant_user">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Current Use</label>
                                <div class="form-control bg-light" id="view_current_use">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Nature of Development</label>
                                <div class="form-control bg-light" id="view_nature_of_dev">-</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Lease Terms Card -->
                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h6 class="mb-0">
                            <i class="fas fa-calendar-alt me-2 text-warning"></i>Lease Terms
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Commencement Date</label>
                                <div class="form-control bg-light" id="view_commencement_date">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Lease Term (Years)</label>
                                <div class="form-control bg-light" id="view_term">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Expiry Date</label>
                                <div class="form-control bg-light" id="view_expiry_date">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Nature of Instrument</label>
                                <div class="form-control bg-light" id="view_nature_of_instrument">-</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Rent Information Card -->
                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h6 class="mb-0">
                            <i class="fas fa-money-bill-wave me-2 text-info"></i>Rent Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Rent Category</label>
                                <div class="form-control bg-light" id="view_rent_category">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Rent Passing</label>
                                <div class="form-control bg-light" id="view_rent_passing">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Location Rate</label>
                                <div class="form-control bg-light" id="view_location_rate">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Rent Review Clause</label>
                                <div class="form-control bg-light" id="view_rent_review_clause">-</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Payment Status Card -->
                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h6 class="mb-0">
                            <i class="fas fa-chart-line me-2 text-danger"></i>Payment Status
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Last Payment Date</label>
                                <div class="form-control bg-light" id="view_last_payment_date">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Last Payment Period</label>
                                <div class="form-control bg-light" id="view_last_payment_period">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Rent Outstanding</label>
                                <div class="form-control bg-light fw-bold" id="view_rent_outstanding">-</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label text-muted small mb-1">Periods in Arrears</label>
                                <div class="form-control bg-light" id="view_period_in_arrears">-</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Additional Information Card -->
                <div class="card">
                    <div class="card-header bg-light">
                        <h6 class="mb-0">
                            <i class="fas fa-info-circle me-2 text-secondary"></i>Additional Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small mb-1">GLPIN</label>
                                <div class="form-control bg-light" id="view_glpin">-</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small mb-1">Remarks</label>
                                <div class="form-control bg-light" id="view_remarks" style="height: 100px; overflow-y: auto;">-</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i> Close
                </button>
                <!-- <button type="button" class="btn btn-primary" id="btnPrintLedger">
                    <i class="fas fa-print me-1"></i> Print Details
                </button> -->
                <!-- <button type="button" class="btn btn-warning" id="btnEditLedger" data-bs-toggle="modal" data-bs-target="#editLedgerModal">
                    <i class="fas fa-edit me-1"></i> Edit Details
                </button> -->
            </div>
        </div>
    </div>
</div>

<!-- Transaction History Modal -->
<div class="modal fade" data-position="0" id="transactionhistory" tabindex="-1" aria-labelledby="transactionhistoryLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="transactionhistoryLabel">Transaction History</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<button class="btn btn-warning mb-2 d-none" id="xloadRt" onclick="loadTransactionHistory()"><i class="fa fa-undo"></i></button>
				<button class="btn btn-danger btn-sm mb-2 d-none" id="btnAddNewLessee" data-bs-toggle="modal" data-bs-target="#addlegder">Add New Lessee</button>
				<!-- <button class="btn btn-success btn-sm mb-2" id="btnAddTransaction" data-bs-toggle="collapse" data-bs-target="#addtransactiondiv">Add Transaction</button> -->
				 <input id="parcel_idxxxx" type="hidden" />
				<div class="row d-none" id="exDatar">
					<div class="col-md-6">
						<label for="xxr_glpin" class="form-label">GLPIN: </label>
						<input type="text" class="form-control" id="xxr_glpin" readonly>
					</div>
					<div class="col-md-6">
						<label for="xxr_plot_size" class="form-label">Land Size: </label>
						<input type="text" class="form-control" id="xxr_plot_size" readonly/>
					</div>
					<div class="col-md-6">
						<label for="xxr_locality" class="form-label">Locality: </label>
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
				<button class="btn btn-danger btn-sm" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- Rent Parcel Details Modal -->
<div class="modal fade" data-position="0" id="rentParcelDetails" tabindex="-1" aria-labelledby="rentParcelDetailsLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rentParcelDetailsLabel">Parcel Details</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<button class="btn btn-success btn-sm mb-2" data-bs-toggle="collapse" data-bs-target="#addlegderCollapse">Add New Lessee</button>
				<div class="collapse mb-2" id="addlegderCollapse">
					<div class="card card-body">
						<input id="rt_rent_id" value="0" type="hidden"/>
						<div class="row">
							<div class="col-6">
								<div class="mb-2">
									<label for="pd_gep_glpin" class="form-label">Developed: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="pd_gep_glpin" required/>
								</div>
								<div class="mb-2">
									<label for="pd_gep_glpin2" class="form-label">GLPIN.: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="pd_gep_glpin2" required/>
								</div>
							</div>
							<div class="col-6">
								<div class="mb-2">
									<label for="pd_gep_locality" class="form-label">Locality: <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="pd_gep_locality" required />
								</div>
								<div class="mb-2">
									<label for="pd_gep_land_size" class="form-label">Land Size: <span class="text-danger">*</span></label>
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
				<button class="btn btn-danger btn-sm" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- Add Lessee Modal -->
<div class="modal fade effect-fade modal-blur" id="addlegder" tabindex="-1" aria-labelledby="addlegderLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="addlegderLabel">
                    <i class="fas fa-plus-circle me-2"></i>Add Lease Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <form id="addlegderForm" class="needs-validation" novalidate>
                    <input type="hidden" id="rt_rent_id" class="rt_rent_id" value="0">
                    <input type="hidden" id="rt_parcel_id" value="0">
                    
                    <!-- Lessee's Details Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-primary bg-opacity-10">
                            <h6 class="mb-0 text-primary">
                                <i class="fas fa-user-tie me-2"></i>Lessee's Details
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="rt_leasee_name" class="form-label">
                                        <i class="fas fa-user-circle me-1"></i>Full Name <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rt_leasee_name" required>
                                    <div class="invalid-feedback">Please enter lessee's full name.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_email" class="form-label">
                                        <i class="fas fa-envelope me-1"></i>Email Address
                                    </label>
                                    <input type="email" class="form-control" id="rt_email">
                                    <div class="invalid-feedback">Please enter a valid email address.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_leasee_address" class="form-label">
                                        <i class="fas fa-map-marker-alt me-1"></i>Postal Address <span class="text-danger">*</span>
                                    </label>
                                    <textarea class="form-control" id="rt_leasee_address" rows="2" required></textarea>
                                    <div class="invalid-feedback">Please enter postal address.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_leasee_digital_address" class="form-label">
                                        <i class="fas fa-qrcode me-1"></i>Digital Address
                                    </label>
                                    <input type="text" class="form-control" id="rt_leasee_digital_address">
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_mobile_phone_1" class="form-label">
                                        <i class="fas fa-phone me-1"></i>Primary Mobile <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">+233</span>
                                        <input type="tel" class="form-control" id="rt_mobile_phone_1" pattern="[0-9]{10}" required>
                                    </div>
                                    <div class="invalid-feedback">Please enter a valid 9-digit mobile number.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_mobile_phone_2" class="form-label">
                                        <i class="fas fa-phone-alt me-1"></i>Secondary Mobile
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">+233</span>
                                        <input type="tel" class="form-control" id="rt_mobile_phone_2" pattern="[0-9]{10}">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Parcel's Details Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-success bg-opacity-10">
                            <h6 class="mb-0 text-success">
                                <i class="fas fa-map-marked-alt me-2"></i>Property Details
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="rt_plot_number" class="form-label">
                                        <i class="fas fa-hashtag me-1"></i>Plot Number <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rt_plot_number" required>
                                    <div class="invalid-feedback">Please enter plot number.</div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_plot_size" class="form-label">
                                        <i class="fas fa-arrows-alt me-1"></i>Plot Size (Acres) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="rt_plot_size" step="0.01" min="0" required>
                                        <span class="input-group-text">acres</span>
                                    </div>
                                    <div class="invalid-feedback">Please enter plot size.</div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_parcel_address" class="form-label">
                                        <i class="fas fa-location-dot me-1"></i>Parcel Address
                                    </label>
                                    <input type="text" class="form-control" id="rt_parcel_address">
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_convenant_user" class="form-label">
                                        <i class="fas fa-users me-1"></i>Covenanted User
                                    </label>
                                    <select class="form-select" id="rt_convenant_user">
                                        <option value="">-- Select --</option>
                                        <c:forEach items="${user_category_list}" var="usercategorylist">
                                            <option value="${usercategorylist.us_name}">${usercategorylist.us_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_current_use" class="form-label">
                                        <i class="fas fa-building me-1"></i>Current Use
                                    </label>
                                    <select class="form-select" id="rt_current_use" >
                                        <option value="">-- Select --</option>
                                        <c:forEach items="${user_category_list}" var="usercategorylist">
                                            <option value="${usercategorylist.us_name}">${usercategorylist.us_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_nature_of_dev" class="form-label">
                                        <i class="fas fa-hammer me-1"></i>Nature of Development
                                    </label>
                                    <select class="form-select" id="rt_nature_of_dev">
                                        <option value="">Loading...</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_file_number" class="form-label">
                                        <i class="fas fa-folder me-1"></i>File Number <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rt_file_number" required>
                                    <div class="invalid-feedback">Please enter file number.</div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_ledger" class="form-label">
                                        <i class="fas fa-book me-1"></i>Ledger <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rt_ledger" required>
                                    <div class="invalid-feedback">Please enter ledger number.</div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_folio" class="form-label">
                                        <i class="fas fa-book-open me-1"></i>Folio
                                    </label>
                                    <input type="text" class="form-control" id="rt_folio">
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_ls_number" class="form-label">
                                        <i class="fas fa-file-contract me-1"></i>LS Number
                                    </label>
                                    <input type="text" class="form-control" id="rt_ls_number">
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_glpin" class="form-label">
                                        <i class="fas fa-fingerprint me-1"></i>GLPIN
                                    </label>
                                    <input type="text" class="form-control" id="rt_glpin">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Tenure Information Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-warning bg-opacity-10">
                            <h6 class="mb-0 text-warning">
                                <i class="fas fa-calendar-alt me-2"></i>Tenure Information
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="rt_estate" class="form-label">
                                        <i class="fas fa-warehouse me-1"></i>Estate <span class="text-danger">*</span>
                                    </label>
                                    <select id="rt_estate" class="form-select" required>
                                        <option value="">Loading estates...</option>
                                    </select>
                                    <div class="invalid-feedback">Please select an estate.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_nature_of_instrument" class="form-label">
                                        <i class="fas fa-file-signature me-1"></i>Nature of Instrument
                                    </label>
                                    <select class="form-select" id="rt_nature_of_instrument">
                                        <option value="">Loading instruments...</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_commencement_date" class="form-label">
                                        <i class="fas fa-play-circle me-1"></i>Commencement Date <span class="text-danger">*</span>
                                    </label>
                                    <input type="date" class="form-control" id="rt_commencement_date" required>
                                    <div class="invalid-feedback">Please select commencement date.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_term" class="form-label">
                                        <i class="fas fa-clock me-1"></i>Term (Years) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="rt_term" required>
                                        <span class="input-group-text">years</span>
                                    </div>
                                    <div class="invalid-feedback">Please enter lease term.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_expiry_date" class="form-label">
                                        <i class="fas fa-stop-circle me-1"></i>Expiry Date
                                    </label>
                                    <input type="date" class="form-control" id="rt_expiry_date" readonly style="background-color: #e9ecef;">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Rent Terms Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-info bg-opacity-10">
                            <h6 class="mb-0 text-info">
                                <i class="fas fa-money-bill-wave me-2"></i>Rent Terms
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="rt_rent_category" class="form-label">
                                        <i class="fas fa-tags me-1"></i>Rent Category
                                    </label>
                                    <select class="form-select" id="rt_rent_category">
                                        <option value="">-- Select --</option>
                                        <option value="Economic Rent">Economic Rent</option>
                                        <option value="Subsidized Rent">Subsidized Rent</option>
                                        <option value="Peppercorn Rent">Peppercorn Rent</option>
                                        <!-- <option value="Ground Rent">Ground Rent</option> -->
                                        <option value="Commercial Rent">Commercial Rent</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_rent_passing" class="form-label">
                                        <i class="fas fa-money-bill me-1"></i>Rent Passing (GHS)
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">GHS</span>
                                        <input type="number" class="form-control" id="rt_rent_passing" value="0">
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_rent_review_clause" class="form-label">
                                        <i class="fas fa-sync-alt me-1"></i>Rent Review Period (Years) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="rt_rent_review_clause" min="0" value="0" required>
                                        <span class="input-group-text">years</span>
                                    </div>
                                    <div class="invalid-feedback">Please enter rent review period.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_location_rate" class="form-label">
                                        <i class="fas fa-map-pin me-1"></i>Location Rate (GHS) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">GHS</span>
                                        <input type="number" class="form-control" id="rt_location_rate" step="0.01" min="0" value="0.00" required>
                                    </div>
                                    <div class="invalid-feedback">Please enter location rate.</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Payment History Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-danger bg-opacity-10">
                            <h6 class="mb-0 text-danger">
                                <i class="fas fa-history me-2"></i>Payment History
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="rt_last_payment_date" class="form-label">
                                        <i class="fas fa-calendar-check me-1"></i>Last Payment Date <span class="text-danger">*</span>
                                    </label>
                                    <input type="date" class="form-control" id="rt_last_payment_date" required>
                                    <div class="invalid-feedback">Please select last payment date.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_last_payment_period" class="form-label">
                                        <i class="fas fa-calendar-week me-1"></i>Last Payment Period <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rt_last_payment_period" value="0" required>
                                    <div class="invalid-feedback">Please enter last payment period.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_rent_outstanding" class="form-label">
                                        <i class="fas fa-money-bill-wave me-1"></i>Rent Outstanding (GHS)
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">GHS</span>
                                        <input type="number" class="form-control" id="rt_rent_outstanding" step="0.01" min="0" value="0">
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_period_in_arrears" class="form-label">
                                        <i class="fas fa-exclamation-triangle me-1"></i>Periods in Arrears <span class="text-danger">*</span>
                                    </label>
                                    <input type="number" class="form-control" id="rt_period_in_arrears" min="0" value="0" required>
                                    <div class="invalid-feedback">Please enter periods in arrears.</div>
                                </div>
                                
                                <div class="col-md-12">
                                    <label for="rt_remarks" class="form-label">
                                        <i class="fas fa-comment-dots me-1"></i>Remarks
                                    </label>
                                    <textarea class="form-control" id="rt_remarks" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i> Cancel
                </button>
                <button type="button" class="btn btn-primary" id="btn_save_rent_client_details">
                    <i class="fas fa-save me-1"></i> Save Changes
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Lessee Modal -->
<div class="modal fade effect-fade modal-blur" id="editlegder" tabindex="-1" aria-labelledby="editlegderLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="editlegderLabel">
                    <i class="fas fa-edit me-2"></i>Edit Lease Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <form id="editlegderForm" class="needs-validation" novalidate>
                    <input type="hidden" id="rt_e_rent_id" class="rt_e_rent_id" value="0">
                    <input type="hidden" id="rt_parcel_id" value="0">
                    
                    <!-- Lessee's Details Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-primary bg-opacity-10">
                            <h6 class="mb-0 text-primary">
                                <i class="fas fa-user-tie me-2"></i>Lessee's Details
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="rt_e_leasee_name" class="form-label">
                                        <i class="fas fa-user-circle me-1"></i>Full Name <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rt_e_leasee_name" required>
                                    <div class="invalid-feedback">Please enter lessee's full name.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_email" class="form-label">
                                        <i class="fas fa-envelope me-1"></i>Email Address
                                    </label>
                                    <input type="email" class="form-control" id="rt_e_email">
                                    <div class="invalid-feedback">Please enter a valid email address.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_leasee_address" class="form-label">
                                        <i class="fas fa-map-marker-alt me-1"></i>Postal Address <span class="text-danger">*</span>
                                    </label>
                                    <textarea class="form-control" id="rt_e_leasee_address" rows="2" required></textarea>
                                    <div class="invalid-feedback">Please enter postal address.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_leasee_digital_address" class="form-label">
                                        <i class="fas fa-qrcode me-1"></i>Digital Address
                                    </label>
                                    <input type="text" class="form-control" id="rt_e_leasee_digital_address">
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_mobile_phone_1" class="form-label">
                                        <i class="fas fa-phone me-1"></i>Primary Mobile <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">+233</span>
                                        <input type="tel" class="form-control" id="rt_e_mobile_phone_1" pattern="[0-9]{10}" required>
                                    </div>
                                    <div class="invalid-feedback">Please enter a valid 9-digit mobile number.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_mobile_phone_2" class="form-label">
                                        <i class="fas fa-phone-alt me-1"></i>Secondary Mobile
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">+233</span>
                                        <input type="tel" class="form-control" id="rt_e_mobile_phone_2" pattern="[0-9]{10}">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Parcel's Details Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-success bg-opacity-10">
                            <h6 class="mb-0 text-success">
                                <i class="fas fa-map-marked-alt me-2"></i>Property Details
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="rt_e_plot_number" class="form-label">
                                        <i class="fas fa-hashtag me-1"></i>Plot Number <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rt_e_plot_number" required>
                                    <div class="invalid-feedback">Please enter plot number.</div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_e_plot_size" class="form-label">
                                        <i class="fas fa-arrows-alt me-1"></i>Plot Size (Acres) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="rt_e_plot_size" step="0.01" min="0" required>
                                        <span class="input-group-text">acres</span>
                                    </div>
                                    <div class="invalid-feedback">Please enter plot size.</div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_e_parcel_address" class="form-label">
                                        <i class="fas fa-location-dot me-1"></i>Parcel Address
                                    </label>
                                    <input type="text" class="form-control" id="rt_e_parcel_address">
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_e_convenant_user" class="form-label">
                                        <i class="fas fa-users me-1"></i>Covenanted User
                                    </label>
                                    <select class="form-select" id="rt_e_convenant_user">
                                        <option value="">-- Select --</option>
                                        <c:forEach items="${user_category_list}" var="usercategorylist">
                                            <option value="${usercategorylist.us_name}">${usercategorylist.us_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_e_current_use" class="form-label">
                                        <i class="fas fa-building me-1"></i>Current Use
                                    </label>
                                    <select class="form-select" id="rt_e_current_use" >
                                        <option value="">-- Select --</option>
                                        <c:forEach items="${user_category_list}" var="usercategorylist">
                                            <option value="${usercategorylist.us_name}">${usercategorylist.us_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_e_nature_of_dev" class="form-label">
                                        <i class="fas fa-hammer me-1"></i>Nature of Development
                                    </label>
                                    <select class="form-select" id="rt_e_nature_of_dev">
                                        <option value="">Loading...</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_e_file_number" class="form-label">
                                        <i class="fas fa-folder me-1"></i>File Number <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rt_e_file_number" required>
                                    <div class="invalid-feedback">Please enter file number.</div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_e_ledger" class="form-label">
                                        <i class="fas fa-book me-1"></i>Ledger <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rt_e_ledger" required>
                                    <div class="invalid-feedback">Please enter ledger number.</div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_e_folio" class="form-label">
                                        <i class="fas fa-book-open me-1"></i>Folio
                                    </label>
                                    <input type="text" class="form-control" id="rt_e_folio">
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_e_ls_number" class="form-label">
                                        <i class="fas fa-file-contract me-1"></i>LS Number
                                    </label>
                                    <input type="text" class="form-control" id="rt_e_ls_number">
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="rt_e_glpin" class="form-label">
                                        <i class="fas fa-fingerprint me-1"></i>GLPIN
                                    </label>
                                    <input type="text" class="form-control" id="rt_e_glpin">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Tenure Information Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-warning bg-opacity-10">
                            <h6 class="mb-0 text-warning">
                                <i class="fas fa-calendar-alt me-2"></i>Tenure Information
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="rt_e_estate" class="form-label">
                                        <i class="fas fa-warehouse me-1"></i>Estate <span class="text-danger">*</span>
                                    </label>
                                    <select id="rt_e_estate" class="form-select" required>
                                        <option value="">Loading estates...</option>
                                    </select>
                                    <div class="invalid-feedback">Please select an estate.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_nature_of_instrument" class="form-label">
                                        <i class="fas fa-file-signature me-1"></i>Nature of Instrument
                                    </label>
                                    <select class="form-select" id="rt_e_nature_of_instrument">
                                        <option value="">Loading instruments...</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_commencement_date" class="form-label">
                                        <i class="fas fa-play-circle me-1"></i>Commencement Date <span class="text-danger">*</span>
                                    </label>
                                    <input type="date" class="form-control" id="rt_e_commencement_date" required>
                                    <div class="invalid-feedback">Please select commencement date.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_term" class="form-label">
                                        <i class="fas fa-clock me-1"></i>Term (Years) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="rt_e_term" min="1" max="999" required>
                                        <span class="input-group-text">years</span>
                                    </div>
                                    <div class="invalid-feedback">Please enter lease term.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_expiry_date" class="form-label">
                                        <i class="fas fa-stop-circle me-1"></i>Expiry Date
                                    </label>
                                    <input type="date" class="form-control" id="rt_e_expiry_date" readonly style="background-color: #e9ecef;">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Rent Terms Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-info bg-opacity-10">
                            <h6 class="mb-0 text-info">
                                <i class="fas fa-money-bill-wave me-2"></i>Rent Terms
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="rt_e_rent_category" class="form-label">
                                        <i class="fas fa-tags me-1"></i>Rent Category
                                    </label>
                                    <select class="form-select" id="rt_e_rent_category">
                                        <option value="">-- Select --</option>
                                        <option value="Economic Rent">Economic Rent</option>
                                        <option value="Subsidized Rent">Subsidized Rent</option>
                                        <option value="Peppercorn Rent">Peppercorn Rent</option>
                                        <option value="Ground Rent">Ground Rent</option>
                                        <option value="Commercial Rent">Commercial Rent</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_rent_passing" class="form-label">
                                        <i class="fas fa-money-bill me-1"></i>Rent Passing (GHS)
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">GHS</span>
                                        <input type="number" class="form-control" id="rt_e_rent_passing" step="0.01" min="0" value="0">
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_rent_review_clause" class="form-label">
                                        <i class="fas fa-sync-alt me-1"></i>Rent Review Period (Years) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="rt_e_rent_review_clause" min="0" value="0" required>
                                        <span class="input-group-text">years</span>
                                    </div>
                                    <div class="invalid-feedback">Please enter rent review period.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_location_rate" class="form-label">
                                        <i class="fas fa-map-pin me-1"></i>Location Rate (GHS) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">GHS</span>
                                        <input type="number" class="form-control" id="rt_e_location_rate" step="0.01" min="0" value="0.00" required>
                                    </div>
                                    <div class="invalid-feedback">Please enter location rate.</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Payment History Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-danger bg-opacity-10">
                            <h6 class="mb-0 text-danger">
                                <i class="fas fa-history me-2"></i>Payment History
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="rt_e_last_payment_date" class="form-label">
                                        <i class="fas fa-calendar-check me-1"></i>Last Payment Date <span class="text-danger">*</span>
                                    </label>
                                    <input type="date" class="form-control" id="rt_e_last_payment_date" required>
                                    <div class="invalid-feedback">Please select last payment date.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_last_payment_period" class="form-label">
                                        <i class="fas fa-calendar-week me-1"></i>Last Payment Period <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rt_e_last_payment_period" value="0" required>
                                    <div class="invalid-feedback">Please enter last payment period.</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_rent_outstanding" class="form-label">
                                        <i class="fas fa-money-bill-wave me-1"></i>Rent Outstanding (GHS)
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">GHS</span>
                                        <input type="number" class="form-control" id="rt_e_rent_outstanding" step="0.01" min="0" value="0">
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="rt_e_period_in_arrears" class="form-label">
                                        <i class="fas fa-exclamation-triangle me-1"></i>Periods in Arrears <span class="text-danger">*</span>
                                    </label>
                                    <input type="number" class="form-control" id="rt_e_period_in_arrears" min="0" value="0" required>
                                    <div class="invalid-feedback">Please enter periods in arrears.</div>
                                </div>
                                
                                <div class="col-md-12">
                                    <label for="rt_e_remarks" class="form-label">
                                        <i class="fas fa-comment-dots me-1"></i>Remarks
                                    </label>
                                    <textarea class="form-control" id="rt_e_remarks" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i> Cancel
                </button>
                <button type="button" class="btn btn-primary" id="btn_save_edit_rent_client_details">
                    <i class="fas fa-save me-1"></i> Save Changes
                </button>
            </div>
        </div>
    </div>
</div>

<!-- View Ledger Modal -->
<div class="modal fade" id="viewLedger" tabindex="-1" aria-labelledby="viewLedgerLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="viewLedgerLabel">Lessee Details</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- Lessee Details -->
				<div class="card mb-3">
					<div class="card-header bg-secondary text-white">
						Lessee's Details
					</div>
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
					<div class="card-header bg-secondary text-white">
						Parcel's Details
					</div>
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
					<div class="card-header bg-secondary text-white">
						Tenure Information
					</div>
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
					<div class="card-header bg-secondary text-white">
						Rent Terms
					</div>
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
					<div class="card-header bg-secondary text-white">
						Payment History
					</div>
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
			<div class="modal-footer">
				<button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- Payment History Modal -->
<div class="modal fade effect-scale modal-blur" id="paymenthistory" tabindex="-1" aria-labelledby="paymenthistoryLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="paymenthistoryLabel">
                    <i class="fas fa-history me-2"></i>Payment History
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Hidden Input -->
                <input type="hidden" id="rt_rent_id" value="0">
                
                <!-- Action Buttons -->
                <div class="d-flex justify-content-between mb-4">
                    <div>
                        <button class="btn btn-warning px-4" id="btn_load_payments">
                            <i class="fas fa-sync-alt me-2"></i>Load Payments
                        </button>
                    </div>
                    <div>
                        <button class="btn btn-success px-4" data-bs-toggle="collapse" data-bs-target="#addpaymentdiv">
                            <i class="fas fa-plus-circle me-2"></i>Add New Payment
                        </button>
                    </div>
                </div>
                
                <!-- Add Payment Form -->
                <div class="collapse mb-4" id="addpaymentdiv">
                    <div class="card">
                        <div class="card-header bg-primary bg-opacity-10">
                            <h6 class="mb-0 text-primary">
                                <i class="fas fa-money-check-alt me-2"></i>Record New Payment
                            </h6>
                        </div>
                        <div class="card-body">
                            <form id="addPaymentForm" class="needs-validation" novalidate>
                                <div class="row g-3">
                                    <!-- Left Column -->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="py_payment_mode" class="form-label fw-semibold">
                                                <i class="fas fa-credit-card me-1"></i>Payment Mode <span class="text-danger">*</span>
                                            </label>
                                            <select class="form-select" id="py_payment_mode" required>
                                                <option value="" selected disabled>-- Select Payment Mode --</option>
                                                <option value="Cash">Cash</option>
                                                <option value="Cheque">Cheque</option>
                                                <option value="Bank Transfer">Bank Transfer</option>
                                                <option value="Mobile Money">Mobile Money</option>
                                                <option value="Online Payment">Online Payment</option>
                                            </select>
                                            <div class="invalid-feedback">Please select payment mode.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="receipt_no" class="form-label fw-semibold">
                                                <i class="fas fa-receipt me-1"></i>Receipt Number <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control" id="receipt_no" required>
                                            <div class="invalid-feedback">Please enter receipt number.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="arrears_amount" class="form-label fw-semibold">
                                                <i class="fas fa-exclamation-triangle me-1"></i>Arrears Amount (GHS) <span class="text-danger">*</span>
                                            </label>
                                            <div class="input-group">
                                                <span class="input-group-text">GHS</span>
                                                <input type="number" class="form-control" id="arrears_amount" step="0.01" min="0" required>
                                            </div>
                                            <div class="invalid-feedback">Please enter arrears amount.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="period_in_arrears" class="form-label fw-semibold">
                                                <i class="fas fa-calendar-times me-1"></i>Periods in Arrears <span class="text-danger">*</span>
                                            </label>
                                            <div class="input-group">
                                                <input type="number" class="form-control" id="period_in_arrears" min="0" required>
                                                <span class="input-group-text">periods</span>
                                            </div>
                                            <div class="invalid-feedback">Please enter periods in arrears.</div>
                                        </div>
                                    </div>
                                    
                                    <!-- Right Column -->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="payment_amount" class="form-label fw-semibold">
                                                <i class="fas fa-money-bill-wave me-1"></i>Payment Amount (GHS) <span class="text-danger">*</span>
                                            </label>
                                            <div class="input-group">
                                                <span class="input-group-text">GHS</span>
                                                <input type="number" class="form-control" id="payment_amount" step="0.01" min="0" required>
                                            </div>
                                            <div class="invalid-feedback">Please enter payment amount.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="last_payment_period" class="form-label fw-semibold">
                                                <i class="fas fa-calendar-check me-1"></i>Last Payment Period <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control" id="last_payment_period" placeholder="e.g., 2024-Q1" required>
                                            <div class="invalid-feedback">Please enter last payment period.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="payment_date" class="form-label fw-semibold">
                                                <i class="fas fa-calendar-day me-1"></i>Payment Date <span class="text-danger">*</span>
                                            </label>
                                            <input type="date" class="form-control" id="payment_date" required>
                                            <div class="invalid-feedback">Please select payment date.</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="payment_remarks" class="form-label fw-semibold">
                                                <i class="fas fa-comment-dots me-1"></i>Remarks
                                            </label>
                                            <textarea class="form-control" id="payment_remarks" rows="3" placeholder="Optional notes about this payment..."></textarea>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Form Actions -->
                                <div class="d-flex justify-content-end mt-4 pt-3 border-top">
                                    <button type="button" class="btn btn-outline-secondary me-2" data-bs-toggle="collapse" data-bs-target="#addpaymentdiv">
                                        <i class="fas fa-times me-1"></i> Cancel
                                    </button>
                                    <button type="submit" class="btn btn-success" id="btn_save_payment">
                                        <i class="fas fa-save me-1"></i> Save Payment
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Quick Stats -->
                    <div class="row mt-3">
                        <div class="col-md-4">
                            <div class="card bg-light border">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-money-bill-wave fa-2x text-success"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-0">Current Balance</h6>
                                            <p class="mb-0 fw-bold text-success" id="currentBalance">GHS 0.00</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card bg-light border">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-clock fa-2x text-warning"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-0">Last Payment</h6>
                                            <p class="mb-0 fw-bold" id="lastPaymentDate">-</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card bg-light border">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-calendar-alt fa-2x text-primary"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-0">Period Status</h6>
                                            <p class="mb-0 fw-bold" id="periodStatus">-</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Payment History Table -->
                <div class="card border-warning">
                    <div class="card-header bg-warning bg-opacity-10 border-warning d-flex justify-content-between align-items-center">
                        <h6 class="mb-0 text-warning">
                            <i class="fas fa-list-ol me-2"></i>Payment History Records
                        </h6>
                        <div>
                            <span class="badge bg-warning text-dark me-2" id="paymentCount">0 payments</span>
                            <span class="badge bg-success" id="totalPaid">GHS 0.00</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered align-middle mb-0" id="tbl_rent_payment_history" width="100%">
                                <thead class="table-light">
                                    <tr>
                                        <th width="80px" class="text-center">
                                            <i class="fas fa-cog"></i>
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-credit-card me-1"></i>Payment Mode
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-exclamation-triangle me-1"></i>Arrears Amount
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-receipt me-1"></i>Receipt No.
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-calendar-day me-1"></i>Date
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-money-bill-wave me-1"></i>Payment Amount
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-clipboard-check me-1"></i>Status
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-user-check me-1"></i>Recorded By
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="paymentHistoryBody">
                                    <!-- Data will be populated here -->
                                    <tr id="noPaymentData">
                                        <td colspan="8" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="fas fa-history fa-2x mb-3"></i>
                                                <p class="mb-2 fw-semibold">No Payment History Available</p>
                                                <small>Click "Load Payments" to fetch payment records</small>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                                <tfoot class="table-light" id="paymentSummary" style="display: none;">
                                    <tr>
                                        <td colspan="5" class="text-end fw-bold">Total Paid Amount:</td>
                                        <td colspan="3" class="text-start fw-bold text-success" id="summaryTotalPaid">GHS 0.00</td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" class="text-end fw-bold">Total Payments:</td>
                                        <td colspan="3" class="text-start fw-bold text-primary" id="summaryPaymentCount">0 payments</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        
                        <!-- Filter and Export Options -->
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-search"></i>
                                    </span>
                                    <input type="text" class="form-control" id="paymentSearch" placeholder="Search payments...">
                                    <button class="btn btn-outline-secondary" type="button" id="clearSearch">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6 text-end">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-outline-primary btn-sm dropdown-toggle" data-bs-toggle="dropdown">
                                        <i class="fas fa-download me-1"></i> Export
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li><a class="dropdown-item" href="#" id="exportPDF">
                                            <i class="fas fa-file-pdf text-danger me-2"></i> Export as PDF
                                        </a></li>
                                        <li><a class="dropdown-item" href="#" id="exportExcel">
                                            <i class="fas fa-file-excel text-success me-2"></i> Export as Excel
                                        </a></li>
                                        <li><a class="dropdown-item" href="#" id="exportCSV">
                                            <i class="fas fa-file-csv text-info me-2"></i> Export as CSV
                                        </a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Statistics Summary -->
                <div class="row mt-4" id="paymentStatistics" style="display: none;">
                    <div class="col-md-3">
                        <div class="card bg-success bg-opacity-10 border-success">
                            <div class="card-body text-center p-3">
                                <i class="fas fa-money-check-alt fa-2x text-success mb-2"></i>
                                <h5 class="mb-1" id="totalPaymentsCount">0</h5>
                                <small class="text-muted">Total Payments</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-info bg-opacity-10 border-info">
                            <div class="card-body text-center p-3">
                                <i class="fas fa-cash-register fa-2x text-info mb-2"></i>
                                <h5 class="mb-1" id="avgPaymentAmount">GHS 0.00</h5>
                                <small class="text-muted">Average Payment</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning bg-opacity-10 border-warning">
                            <div class="card-body text-center p-3">
                                <i class="fas fa-calendar-minus fa-2x text-warning mb-2"></i>
                                <h5 class="mb-1" id="lastPaymentDays">-</h5>
                                <small class="text-muted">Days Since Last</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-primary bg-opacity-10 border-primary">
                            <div class="card-body text-center p-3">
                                <i class="fas fa-chart-line fa-2x text-primary mb-2"></i>
                                <h5 class="mb-1" id="paymentFrequency">-</h5>
                                <small class="text-muted">Payment Frequency</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="d-flex justify-content-between w-100">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        <span id="recordInfo">No lease selected</span>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i> Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Single Rent Demand Notice Modal - Bootstrap 5 -->
<div class="modal fade effect-scale modal-blur" id="singlerentdemandnotice" tabindex="-1" aria-labelledby="singlerentdemandnoticeLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="singlerentdemandnoticeLabel">
                    <i class="fas fa-file-invoice-dollar me-2"></i>Single Rent Demand Notice
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Hidden Inputs -->
                <input type="hidden" id="rdn_rent_id" value="0">
                <input type="hidden" id="rdn_account_number" value="0">
				<input type="hidden" id="rdn_plot_number" value="0">
				<input type="hidden" id="rdn_estate" value="0">
                
                <!-- Lessee Information Card -->
                <div class="card mb-4">
                    <div class="card-header bg-primary bg-opacity-10">
                        <h6 class="mb-0 text-primary">
                            <i class="fas fa-user-circle me-2"></i>Lessee Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="rdn_leasee_name" class="form-label fw-semibold">
                                        <i class="fas fa-user me-1"></i>Full Name <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="rdn_leasee_name" required>
                                    <div class="invalid-feedback">Please enter lessee name.</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="rdn_email" class="form-label fw-semibold">
                                        <i class="fas fa-envelope me-1"></i>Email Address
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-at"></i>
                                        </span>
                                        <input type="email" class="form-control" id="rdn_email">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="rdn_leasee_address" class="form-label fw-semibold">
                                        <i class="fas fa-map-marker-alt me-1"></i>Postal Address <span class="text-danger">*</span>
                                    </label>
                                    <textarea class="form-control" id="rdn_leasee_address" rows="2" required></textarea>
                                    <div class="invalid-feedback">Please enter lessee address.</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="rdn_mobile_phone_1" class="form-label fw-semibold">
                                        <i class="fas fa-phone me-1"></i>Primary Mobile
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-mobile-alt"></i>
                                        </span>
                                        <input type="tel" class="form-control" id="rdn_mobile_phone_1">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="rdn_mobile_phone_2" class="form-label fw-semibold">
                                        <i class="fas fa-phone-alt me-1"></i>Secondary Mobile
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-mobile"></i>
                                        </span>
                                        <input type="tel" class="form-control" id="rdn_mobile_phone_2">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Action Button -->
                <div class="text-center mb-4">
                    <button class="btn btn-primary btn-lg px-5 py-2" id="btn_generate_rent_demand_note">
                        <i class="fas fa-cogs me-2"></i>Generate Rent Demand Notice
                    </button>
                    <div class="mt-2 text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Click to calculate rent assessment based on current rates
                    </div>
                </div>

                 <div class="text-center mb-4">
                    <button class="btn btn-primary btn-lg px-5 py-2" id="btn_generate_rent_demand_note_current_year">
                        <i class="fas fa-cogs me-2"></i>Generate Rent Demand Notice(Current Year)
                    </button>
                    <div class="mt-2 text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Click to calculate rent assessment based on current rates
                    </div>
                </div>
                
                <!-- Assessment Details Card -->
                <div class="card">
                    <div class="card-header bg-warning bg-opacity-10 d-flex justify-content-between align-items-center">
                        <h6 class="mb-0 text-warning">
                            <i class="fas fa-calculator me-2"></i>Rent Assessment Details
                        </h6>
                        <span class="badge bg-warning text-dark" id="assessmentCount">0 items</span>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover table-bordered align-middle mb-0" id="tbl_rent_assessment_details">
                                <thead class="table-light">
                                    <tr>
                                        <th>Period</th>
                                        <th>A-1Cedi</th>
                                        <th>A-1Cedi PA</th>
                                        <th>Annual Rent</th>
                                        <th>Amount Assessed </th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody id="assessmentTableBody">
                                    <!-- Data will be populated here -->
                                    <tr id="noAssessmentData">
                                        <td colspan="6" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="fas fa-calculator fa-2x mb-3"></i>
                                                <p class="mb-0">No assessment data available.</p>
                                                <small>Click "Generate Rent Demand Notice" to calculate</small>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                                <tfoot class="table-light">
                                    <tr id="assessmentTotalRow" style="display: none;">
                                        <td colspan="3" class="text-end fw-bold">Total Amount Due:</td>
                                        <td colspan="3" class="text-start fw-bold text-success" id="totalAmountDue">GHS 0.00</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        
                        <!-- Summary Information -->
                        <div class="row mt-4" id="assessmentSummary" style="display: none;">
                            <div class="col-md-6">
                                <div class="alert alert-info py-2">
                                    <small>
                                        <i class="fas fa-info-circle me-1"></i>
                                        <strong>Generated:</strong> <span id="generationDate">-</span>
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="alert alert-warning py-2">
                                    <small>
                                        <i class="fas fa-clock me-1"></i>
                                        <strong>Assessment Period:</strong> <span id="assessmentPeriod">-</span>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Notes Section -->
                <div class="alert alert-light border mt-4">
                    <div class="d-flex">
                        <div class="flex-shrink-0">
                            <i class="fas fa-sticky-note text-primary"></i>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <small class="text-muted">
                                <strong>Note:</strong> This demand notice is generated based on current rent rates and outstanding amounts. 
                                Please review all details before printing or sending to the lessee.
                            </small>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="d-flex justify-content-between w-100">
                    <div>
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i> Close
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-warning me-2" id="btn_print_rent_demand_note" disabled>
                            <i class="fas fa-print me-1"></i> View & Print
                        </button>
                        <button type="button" class="btn btn-primary" id="btn_send_email" disabled>
                            <i class="fas fa-paper-plane me-1"></i> Send Email
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Rent Transaction History Modal -->
<div class="modal fade modal-blur effect-scale" data-position="0" id="rentTransactionhistory" tabindex="-1" aria-labelledby="rentTransactionhistoryLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white" id="rentTransactionhistoryLabel">
                    <i class="fas fa-history me-2"></i>Transaction History
                </h5>
                <button class="btn-close btn-close-white" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body p-0">
                <!-- Action Buttons Section -->
                <div class="bg-light px-4 py-3 border-bottom">
                    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-warning d-none" id="xloadRt" onclick="loadTransactionHistory()">
                                <i class="fas fa-redo me-2"></i>Reload
                            </button>
                            <button class="btn btn-outline-danger d-none" id="btnAddNewLessee" 
                                    data-bs-toggle="modal" data-bs-target="#addlegder">
                                <i class="fas fa-user-plus me-2"></i>Add New Lessee
                            </button>
                        </div>
                        <div>
                            <button class="btn btn-success px-4" id="btnAddTransaction">
                                <i class="fas fa-plus-circle me-2"></i>Add Transaction
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Hidden Inputs -->
                <div class="d-none">
                    <input id="rth_m_idxxx" type="hidden" />
                    <input id="rth_plot_numberxxx" type="hidden" />
                </div>
                
                <!-- Table Section -->
                <div class="p-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white border-bottom py-3">
                            <h6 class="mb-0 text-primary fw-semibold">
                                <i class="fas fa-table me-2"></i>Transaction Records
                            </h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0" id="tbl_rent_transaction_history" 
                                       width="100%" cellspacing="0">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-4">
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-hashtag text-primary"></i>
                                                    <span>Plot Number</span>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-user text-primary"></i>
                                                    <span>Name of Lessee</span>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-file-contract text-primary"></i>
                                                    <span>Nature of Interest</span>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-calendar-alt text-primary"></i>
                                                    <span>Consent Date</span>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-clock text-primary"></i>
                                                    <span>Term</span>
                                                </div>
                                            </th>
                                            <th class="text-center pe-4">
                                                <div class="d-flex align-items-center gap-2">
                                                    <i class="fas fa-cogs text-primary"></i>
                                                    <span>Actions</span>
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="border-top-0">
                                        <!-- Data will be populated here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Empty State -->
                        <div class="text-center py-5 d-none" id="emptyTableState">
                            <div class="mb-3">
                                <i class="fas fa-inbox fa-3x text-muted opacity-25"></i>
                            </div>
                            <h5 class="text-muted mb-2">No Transactions Found</h5>
                            <p class="text-muted mb-4">Add your first transaction to get started</p>
                            <button class="btn btn-primary" id="btnAddTransactionEmpty">
                                <i class="fas fa-plus me-2"></i>Add First Transaction
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Showing <span id="recordCount">0</span> records
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Transaction Modal -->
<div class="modal fade effect-scale modal-blur" data-position="0" id="addtransactionModal" tabindex="-1" aria-labelledby="addtransactionModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white" id="addtransactionModalLabel">
                    <i class="fas fa-plus-circle me-2"></i>Add New Transaction
                </h5>
                <button class="btn-close btn-close-white" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body p-0">
                <div class="p-4">
                    <form id="transactionhistoryForm">
                        <input type="hidden" id="rht_is_edit" value="0"/>
                        <!-- Hidden Inputs -->
                        <div class="d-none">
                            <input id="rth_rent_id" value="0" type="hidden"/>
                            <input id="rth_m_id" value="0" type="hidden"/>
                            <input id="rth_account_number" value="0" type="hidden"/>
                        </div>
                        
                        <!-- Lessee's Details Card -->
                        <div class="card mb-4">
                            <div class="card-header bg-primary bg-opacity-10 border-success text-primary py-3">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-user me-2"></i>Lessee's Details
                                </h6>
                            </div>
                            <div class="card-body p-4">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="rth_lessee_name" 
                                                   placeholder="Full Name" required />
                                            <label for="rth_lessee_name">
                                                Name <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="rth_lessee_address" 
                                                   placeholder="Complete Address" required />
                                            <label for="rth_lessee_address">
                                                Address <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="tel" class="form-control" id="rth_mobile_phone_1" 
                                                   placeholder="Primary Mobile Number" required />
                                            <label for="rth_mobile_phone_1">
                                                Mobile Phone <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="tel" class="form-control" id="rth_mobile_phone_2" 
                                                   placeholder="Secondary Mobile Number" />
                                            <label for="rth_mobile_phone_2">Mobile Phone 2</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating">
                                            <input type="email" class="form-control" id="rth_email" 
                                                   placeholder="Email Address" />
                                            <label for="rth_email">Email Address</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Parcel's Details Card -->
                        <div class="card mb-4">
                            <div class="card-header bg-primary bg-opacity-10 border-success text-primary py-3">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-map me-2"></i>Parcel's Details
                                </h6>
                            </div>
                            <div class="card-body p-4">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="rth_plot_number" 
                                                   placeholder="Plot Number" required />
                                            <label for="rth_plot_number">
                                                Plot Number <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="rth_plot_size" 
                                                   placeholder="Plot Size" required />
                                            <label for="rth_plot_size">
                                                Plot Size <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <select class="form-select" id="rth_nature_of_instrument" required>
                                                <option selected disabled value="">-- Select Nature of Instrument --</option>
                                                <c:forEach items="${nature_of_instrument_list}" var="natureofinstrumentlist">
                                                    <option value="${natureofinstrumentlist.nt_name}">${natureofinstrumentlist.nt_name}</option>
                                                </c:forEach>
                                            </select>
                                            <label for="rth_nature_of_instrument">
                                                Nature of Instrument <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="rth_term" 
                                                   placeholder="Term" required />
                                            <label for="rth_term">
                                                Term <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating">
                                            <textarea class="form-control" id="rth_remarks" 
                                                      placeholder="Additional Remarks" 
                                                      style="height: 100px"></textarea>
                                            <label for="rth_remarks">Remarks</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <!-- <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            
                        </div> -->
                    </form>
                </div>
            </div>
            
            <div class="modal-footer bg-light">
                <button class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
                <button type="submit" class="btn btn-success px-4 py-2" id="rth_save_btn">
                    <i class="fas fa-save me-2"></i>Save Details
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Rent Documents Modal -->
<div class="modal fade effect-scale modal-blur" id="rentdocuments" tabindex="-1" aria-labelledby="rentdocumentsLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="rentdocumentsLabel">
                    <i class="fas fa-folder me-2"></i>Lease Documents
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Action Buttons -->
                <div class="d-flex gap-2 mb-4 flex-wrap">
                    <button class="btn btn-warning" id="btn_load_scanned_documents_rent">
                        <i class="fas fa-sync-alt me-2"></i>Load Documents
                    </button>
                    <button class="btn btn-primary fileUploadModal">
                        <i class="fas fa-cloud-upload-alt me-2"></i>Upload Document
                    </button>
                </div>
                
                <!-- Documents Table -->
                <div class="card">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">
                            <i class="fas fa-list me-2"></i>Document List
                        </h6>
                        <div>
                            <span class="badge bg-primary" id="documentCount">0 documents</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="lc_rent_scanned_documents_dataTable">
                                <thead class="table-light">
                                    <tr>
                                        <th class="text-start">
                                            <i class="fas fa-file me-1"></i>Document
                                        </th>
                                        <th class="text-center">
                                            <i class="fas fa-tag me-1"></i>Type
                                        </th>
                                        <th class="text-center" style="width: 150px;">
                                            <i class="fas fa-cog me-1"></i>Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Dynamic content will be loaded here -->
                                    <tr id="noDocumentsRow">
                                        <td colspan="6" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="fas fa-folder-open fa-2x mb-3"></i>
                                                <p class="mb-2 fw-semibold">No Documents Found</p>
                                                <small>Upload documents using the "Upload Document" button above</small>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <div class="d-flex justify-content-between w-100">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        <span id="documentInfo">Documents are stored securely</span>
                    </div>
                    <div>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i> Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Rent Remarks Modal -->
<div class="modal fade" data-position="0" id="rentremarks" tabindex="-1" aria-labelledby="rentremarksLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rentremarksLabel">Remarks</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<button class="btn btn-warning btn-sm mb-2" onclick="loadTransactionRemarks()">Load Remarks</button>
				<button class="btn btn-success btn-sm mb-2" data-bs-toggle="collapse" data-bs-target="#addremarkdiv">Add Remark</button>
				<div class="collapse mb-2" id="addremarkdiv">
					<div class="card card-body">
						<form id="transactionremarksForm">
							<input id="rnt_id" type="hidden" value="0" />
							<input id="rnt_m_id" type="hidden" value="0" />
							<div class="mb-3">
								<label for="rnt_remarks" class="form-label">Remarks <span class="text-danger">*</span></label>
								<textarea class="form-control" id="rnt_remarks"></textarea>
								<button class="btn btn-primary btn-sm mt-2" id="submitRemark">Save</button>
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
				<button class="btn btn-danger btn-sm" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- File Upload Modal -->
<div class="modal fade" id="fileRentUploadModal" tabindex="-1" aria-labelledby="fileRentUploadModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="fileRentUploadModalLabel">Upload New File</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" method="POST" enctype="multipart/form-data" id="id_form_rent_data">
					<label for="fileUploadFormrentdata" class="form-label">File:</label>
					<input id="fileUploadFormrentdata" class="form-control" type="file" name="fileUploadFormrentdata" />
					<input type="button" id="btn_upload_rent_data_file" class="btn btn-primary mt-2" value="Click to upload">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>