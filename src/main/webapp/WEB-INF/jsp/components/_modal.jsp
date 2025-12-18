<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- Remove style="display: block;" from modal -->
<div class="modal fade effect-scale modal-blur" id="inactivityModal" tabindex="-1" aria-labelledby="inactivityModalLabel" aria-modal="true" role="dialog">
    <div class="modal-dialog modal-sm modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="inactivityModalLabel">Session About to Expire</h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-danger border border-danger mb-3 p-2">
                    <div class="d-flex align-items-start">
                        <div class="me-2 svg-danger">
                            <svg class="flex-shrink-0" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="1.5rem" viewBox="0 0 24 24" width="1.5rem" fill="#000000">
                                <g><rect fill="none" height="24" width="24"></rect></g>
                                <g>
                                    <g>
                                        <g>
                                            <path d="M15.73,3H8.27L3,8.27v7.46L8.27,21h7.46L21,15.73V8.27L15.73,3z M19,14.9L14.9,19H9.1L5,14.9V9.1L9.1,5h5.8L19,9.1V14.9z"></path>
                                            <rect height="6" width="2" x="11" y="7"></rect>
                                            <rect height="2" width="2" x="11" y="15"></rect>
                                        </g>
                                    </g>
                                </g>
                            </svg>
                        </div>
                        <div class="text-danger w-100">
                            <div class="fs-12 op-8 mb-1">Your session will expire due to inactivity</div>
                        </div>
                    </div>
                </div>
                <div class="h3 fw-semibold text-center" id="countdownTimer">05:00</div>
                <p class="fw-light small">Click "Stay Active" to continue your session</p>
                <div class="progress-container mt-3">
                    <div class="progress" style="height: 5px;">
                        <div class="progress-bar bg-gradient" id="progressFill" style="width: 100%; transition: width 1s linear;"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-between">
                <button id="stayActiveBtn" class="btn btn-primary w-100">
                    Stay Active
                </button>
                <button id="logoutNowBtn" class="btn btn-danger w-100">
                    Logout Now
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Add this overlay div -->
<div class="modal-backdrop fade" id="inactivityBackdrop" style="display: none;"></div>


<div class="modal fade effect-scale modal-blur" id="addNewserviceBillModal" tabindex="-1" aria-labelledby="newServiceBillModalLabel" data-bs-keyboard="false" data-bs-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Modal Header -->
            <div class="modal-header bg-gradient-primary text-white rounded-top">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-grow-1">
                        <h5 class="modal-title fw-semibold mb-0" id="newServiceBillModalLabel">
                            <i class="fas fa-file-invoice me-2"></i>New Service Bill
                        </h5>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- Service Selection Section -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold"><i class="fas fa-cog me-2 text-primary"></i>Service Selection</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="main_service_cp" class="form-label fw-medium">Main Service <span class="text-danger">*</span></label>
                                <select name="main_service_cp" id="main_service_cp" class="form-select form-select-sm" data-style="btn-info" data-live-search="true">
                                    <option value="" selected disabled>Select Main Service</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="sub_service_cp" class="form-label fw-medium">Sub Service <span class="text-danger">*</span></label>
                                <select name="sub_service_cp" id="sub_service_cp" class="form-select form-select-sm" data-style="btn-info" data-live-search="true">
                                    <option value="" selected disabled>Select Sub Service</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Surveyor Information (Conditional) -->
                <div class="card border-0 shadow-sm mb-4" id="checksigs-no-div" style="display: none;">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold"><i class="fas fa-user-tie me-2 text-warning"></i>Surveyor Information</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="new_bill_application_ls_number" class="form-label fw-medium">Surveyor's Number</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="new_bill_application_ls_number" name="ls_number" placeholder="Enter number">
                                    <button type="button" class="btn btn-primary" id="lc_btn_check_status_of_lincense_surveyor" data-bs-toggle="tooltip" title="Search Surveyor">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="new_bill_application_surveyors_name" class="form-label fw-medium">Surveyor's Name</label>
                                <input type="text" class="form-control" id="new_bill_application_surveyors_name" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="new_bill_application_surveyors_status" class="form-label fw-medium">Surveyor's Status</label>
                                <input type="text" class="form-control" id="new_bill_application_surveyors_status" readonly>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Checklist Section -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-light py-3 d-flex justify-content-between align-items-center">
                        <h6 class="mb-0 fw-semibold"><i class="fas fa-tasks me-2 text-success"></i>Service Checklist</h6>
                        <span class="badge bg-primary">${main_service_desc}</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0" id="new_checlist_table_billdataTable">
                                <thead class="table-light">
                                    <tr>
                                        <th class="py-3 px-4 fw-medium">Description</th>
                                        <th class="py-3 px-4 fw-medium text-center">Options</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Client Information -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold"><i class="fas fa-user me-2 text-info"></i>Client Information</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="new_bill_application_client_name" class="form-label fw-medium">Client Name</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control" id="new_bill_application_client_name" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="new_bill_application_client_id" class="form-label fw-medium">Client Reference</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                    <input type="text" class="form-control" id="new_bill_application_client_id" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Additional Details Section -->
                <div style="display: block;">
                    <!-- Gender & Region -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-light py-3">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-info-circle me-2 text-secondary"></i>Additional Details</h6>
                        </div>
                        <div class="card-body">
                            <div id="reg-no-div" style="display: none">
                                <div class="row g-3 mb-2">
                                    <div class="col-md-6">
                                        <label for="new_bill_application_gender" class="form-label fw-medium">Gender</label>
                                        <select name="new_bill_application_gender" id="new_bill_application_gender" class="form-select">
                                            <option value="" selected disabled>Select Gender</option>
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
                                    <div class="col-md-6">
                                        <label for="new_bill_application_region" class="form-label fw-medium">Region</label>
                                        <select name="new_bill_application_region" id="new_bill_application_region" class="form-select">
                                            <option value="" selected disabled>Select Region</option>
                                            <c:forEach items="${regionlist}" var="region">
                                                <option value="${region.region_id}">${region.region_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="new_bill_application_district" class="form-label fw-medium">District</label>
                                        <select name="new_bill_application_district" id="new_bill_application_district" class="form-select">
                                            <option value="" selected disabled>Select District</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Region & District -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="new_bill_application_office_region" class="form-label fw-medium">Office Region</label>
                                    <select name="new_bill_application_office_region" id="new_bill_application_office_region" class="form-select">
                                        <option value="" selected disabled>Select Office Region</option>
                                        <c:forEach items="${officeregionlist}" var="officeregion">
                                            <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6" id="selectlocality-no-div" style="display: none;">
                                    <label for="new_bill_application_locality" class="form-label fw-medium">Locality</label>
                                    <select name="new_bill_application_locality" id="new_bill_application_locality" class="form-select">
                                        <option value="" selected disabled>Select Locality</option>
                                        <c:forEach items="${localitylist}" var="locality">
                                            <option value="${locality.locality_name}">${locality.locality_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <!-- Copies & Revenue Type -->
                            <div class="row g-3 mt-2" id="stp-no-div" style="display: none;">
                                <div class="col-md-6">
                                    <label for="new_number_of_copies" class="form-label fw-medium">Number of Copies</label>
                                    <input type="number" class="form-control" id="new_number_of_copies" min="1" value="1">
                                </div>
                                <div class="col-md-6">
                                    <label for="new_type_of_revenue_item" class="form-label fw-medium">Type of Revenue Item</label>
                                    <select name="new_type_of_revenue_item" id="new_type_of_revenue_item" class="form-select">
                                        <option value="" selected disabled>Select Revenue Type</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Land Details -->
                            <div class="row g-3 mt-2" id="fsearches-no-div" style="display: none;">
                                <div class="col-md-6">
                                    <label for="new_bill_land_size" class="form-label fw-medium">Land Size (Acres)</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="new_bill_land_size" step="0.01" min="0" value="0.00">
                                        <span class="input-group-text">acres</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="new_bill_type_of_use" class="form-label fw-medium">Type of Use</label>
                                    <select name="type_of_use" id="new_bill_type_of_use" class="form-select">
                                        <option value="" selected disabled>Select Type of Use</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Registration & Publication -->
                            <div class="row g-3 mt-2" id="freg-no-div" style="display: none;">
                                <div class="col-md-6">
                                    <label for="new_bill_registration_forms" class="form-label fw-medium">Registration Forms</label>
                                    <select name="new_bill_registration_forms" id="new_bill_registration_forms" class="form-select">
                                        <option value="" selected disabled>Select Registration Forms</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="new_bill_publication_type" class="form-label fw-medium">Publication Type</label>
                                    <select name="new_bill_publication_type" id="new_bill_publication_type" class="form-select">
                                        <option value="normal_publication">Normal Publication</option>
                                        <option value="special_publication">Special Publication</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light rounded-bottom p-3">
                <div class="d-flex justify-content-between w-100">
                    <div>
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-primary px-4" id="btn_save_to_generate_new_bill_not_on_case">
                            <i class="fas fa-arrow-right me-2"></i>Generate Bill
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="NotoncaseafterPaymentModalonCase" tabindex="-1" aria-labelledby="afterPaymentModalLabel" aria-hidden="true"  data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-gradient-primary text-white rounded-top-3">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-grow-1">
                        <h5 class="modal-title fw-semibold mb-0" id="afterPaymentModalLabel">
                            After Payment - New Case Processing
                        </h5>
                        <small class="text-muted">Complete the post-payment workflow</small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Hidden Inputs -->
            <div class="d-none">
                <input type="hidden" id="txt_not_on_case_ap_main_service_id" name="txt_not_on_case_ap_main_service_id">
                <input type="hidden" id="txt_not_on_case_ap_main_service_sub_id" name="txt_not_main_service_sub_id">
                <input type="hidden" id="txt_not_on_case_ap_jn_id" name="txt_not_on_case_ap_jn_id" value="jn_id">
                <input type="hidden" id="txt_not_on_case_ap_userid" name="txt_not_on_case_ap_userid" value="${userid}">
                <input type="hidden" id="txt_not_on_case_ap_user_fullname" name="user_fullname" value="${fullname}">
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-3">
                <!-- Summary Card -->
                <div class="card border-0 shadow-sm rounded-0">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold"><i class="fas fa-info-circle me-2 text-primary"></i>Application Summary</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-medium text-muted">Main Service</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-cog"></i></span>
                                    <input type="text" class="form-control bg-light" id="txt_not_on_case_ap_main_service_desc" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium text-muted">Sub Service</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-cogs"></i></span>
                                    <input type="text" class="form-control bg-light" id="txt_not_on_case_ap_main_service_sub_desc" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium text-muted">Client Name</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control bg-light" id="txt_not_on_case_ap_client_name" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium text-muted">Land Size</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-ruler-combined"></i></span>
                                    <input type="text" class="form-control bg-light" id="txt_not_on_case_ap_land_size" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Wizard Steps -->
                <div class="card border-0 shadow-sm rounded-0 mt-3">
                    <div class="card-header bg-transparent border-bottom py-3">
                        <div class="wizard-steps">
                            <div class="step active" data-step="1">
                                <div class="step-icon">1</div>
                                <div class="step-label">Checklist</div>
                            </div>
                            <div class="step" data-step="2">
                                <div class="step-icon">2</div>
                                <div class="step-label">Bills</div>
                            </div>
                            <div class="step" data-step="3">
                                <div class="step-icon">3</div>
                                <div class="step-label">Confirmation</div>
                            </div>
                            <div class="step" data-step="4">
                                <div class="step-icon">4</div>
                                <div class="step-label">Upload</div>
                            </div>
                            <div class="step" data-step="5">
                                <div class="step-icon">5</div>
                                <div class="step-label">Acknowledgement</div>
                            </div>
                        </div>
                    </div>

                    <div class="card-body">
                        <!-- Step 1: Checklist -->
                        <div class="step-content active" id="step-1-content">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0 fw-semibold"><i class="fas fa-clipboard-check me-2 text-warning"></i>Service Checklist</h6>
                                <span class="badge bg-primary">${main_service_desc}</span>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table table-hover table-bordered" id="tbl_not_on_case_after_payment_ap_checklist_dataTable">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="fw-medium py-3">Description</th>
                                            <th class="fw-medium py-3 text-center">Options</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Step 2: Bills Details -->
                        <div class="step-content" id="step-2-content">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0 fw-semibold"><i class="fas fa-money-bill-wave me-2 text-warning"></i>Bill & Payment Details</h6>
                                <button class="btn btn-warning" id="btnPrintEgcr">
                                    <i class="fas fa-print me-2"></i>Print eGCR
                                </button>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table table-hover" id="tbl_not_on_case_ap_bills_payments_dataTable">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="fw-medium">Bill Number</th>
                                            <th class="fw-medium">Description</th>
                                            <th class="fw-medium text-end">Amount</th>
                                            <th class="fw-medium text-end">Paid</th>
                                            <th class="fw-medium">Payment Mode</th>
                                            <th class="fw-medium">Division</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Step 3: Details Confirmation -->
                        <div class="step-content" id="step-3-content">
                            <h6 class="mb-4 fw-semibold"><i class="fas fa-check-double me-2 text-warning"></i>Details Confirmation</h6>
                            
                            <!-- Parties Information -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-light py-3">
                                    <h6 class="mb-0 fw-semibold"><i class="fas fa-users me-2"></i>Parties to Transaction</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium">Client Name</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                                <input type="text" class="form-control" id="txt_not_on_case_bl_txt_ar_name" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium">Reference Number</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                                <input type="text" class="form-control" id="txt_not_on_case_ap_job_number" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Conditional Sections -->
                            <div id="additional-details-section">
                                <!-- Type of Use (Conditional) -->
                                <div class="card border-0 shadow-sm mb-4" id="ap-typeofuse-no-div" style="display: none;">
                                    <div class="card-header bg-light py-3">
                                        <h6 class="mb-0 fw-semibold"><i class="fas fa-tag me-2"></i>Type of Use</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label fw-medium">Select Type of Use</label>
                                                <select name="type_of_use" id="txt_not_on_case_ap_type_of_use" class="form-select">
                                                    <option value="-1">Select Type of Use</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Locality (Conditional) -->
                                <div class="card border-0 shadow-sm mb-4" id="ap-selectlocality-no-div" style="display: none;">
                                    <div class="card-header bg-light py-3">
                                        <h6 class="mb-0 fw-semibold"><i class="fas fa-map-marker-alt me-2"></i>Locality Details</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label fw-medium">Parcel Locality</label>
                                                <input type="text" class="form-control" id="txt_not_on_case_ap_locality_of_parcel" placeholder="Enter locality">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Registration Details (Conditional) -->
                                <div class="card border-0 shadow-sm mb-4" id="ap-reg-no-div" style="display: none;">
                                    <div class="card-header bg-light py-3">
                                        <h6 class="mb-0 fw-semibold"><i class="fas fa-file-contract me-2"></i>Registration Details</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-4">
                                                <label class="form-label fw-medium">Region</label>
                                                <input type="text" class="form-control" id="txt_not_on_case_ap_region" readonly>
                                            </div>
                                            <div class="col-md-8">
                                                <label class="form-label fw-medium">District</label>
                                                <input type="text" class="form-control" id="txt_not_on_case_ap_district" readonly>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label fw-medium">LS Number</label>
                                                <input type="text" class="form-control" id="txt_not_on_case_ap_licensed_surveyor_number" readonly>
                                            </div>
                                            <div class="col-md-9">
                                                <label class="form-label fw-medium">Surveyor's Name</label>
                                                <input type="text" class="form-control" id="txt_not_on_case_ap_licensed_surveyor_name" readonly>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label fw-medium">Application Type</label>
                                                <select name="txt_not_on_case_ap_application_type" id="txt_not_on_case_ap_application_type" class="form-select">
                                                    <option value="Individual">Individual</option>
                                                    <option value="Joint">Joint</option>
                                                    <option value="Company">Company</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Instrument Type (Conditional) -->
                                <div class="card border-0 shadow-sm" id="ap-stp-no-divn" style="display: none;">
                                    <div class="card-header bg-light py-3">
                                        <h6 class="mb-0 fw-semibold"><i class="fas fa-file-signature me-2"></i>Instrument Details</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label fw-medium">Type of Instrument</label>
                                                <select name="txt_not_on_case_ap_type_of_instrument" id="txt_not_on_case_ap_type_of_instrument" class="form-select">
                                                    <option value="-1">Select Type of Instrument</option>
                                                    <option value="LEASEHOLD">LEASEHOLD</option>
                                                    <option value="FREEHOLD">FREEHOLD</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Step 4: File Upload -->
                        <div class="step-content" id="step-4-content">
                            <h6 class="mb-4 fw-semibold"><i class="fas fa-upload me-2 text-warning"></i>File Upload</h6>
                            
                            <div class="card border-dashed border-2">
                                <div class="card-body text-center p-5">
                                    <!-- <div class="mb-4">
                                        <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                                        <h5 class="fw-semibold">Upload Required Documents</h5>
                                        <p class="text-muted">Supported format: PDF only</p>
                                    </div> -->
                                    
                                   <form id="id_formatCSAU_" class="needs-validation" novalidate>
                                        <div class="mb-3">
                                            <div class="file-upload-area border-dashed rounded p-4 text-center mb-3">
                                                <i class="fas fa-file-pdf fa-3x text-danger mb-3"></i>
                                                <h6 class="fw-semibold">Upload PDF Document</h6>
                                                <p class="text-muted small mb-3">Maximum file size: 10MB • Accepted format: PDF only</p>
                                                
                                                <input type="file" 
                                                    class="form-control d-none" 
                                                    id="fileUploadFormatCSAU" 
                                                    name="UploadFileFile" 
                                                    accept="application/pdf"
                                                    required>
                                                
                                                <div class="d-flex flex-column align-items-center">
                                                    <button type="button" class="btn btn-outline-primary mb-3" id="btnSelectFile">
                                                        <i class="fas fa-folder-open me-2"></i>Select PDF File
                                                    </button>
                                                    
                                                    <div class="file-info text-center" id="fileInfo" style="display: none;">
                                                        <div class="d-flex align-items-center justify-content-center mb-2">
                                                            <i class="fas fa-file-pdf text-danger me-2"></i>
                                                            <span class="fw-medium" id="fileName"></span>
                                                        </div>
                                                        <div class="d-flex justify-content-center align-items-center">
                                                            <div class="file-size-badge bg-light rounded-pill px-3 py-1 me-3">
                                                                <i class="fas fa-weight-hanging me-1 text-muted"></i>
                                                                <span id="fileSize">0 KB</span>
                                                            </div>
                                                            <button type="button" class="btn btn-sm btn-outline-danger me-2" id="btnRemoveFile">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                            <button type="button" class="btn btn-sm btn-outline-info" id="btnViewFile">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                        </div>
                                                        <div class="progress mt-2" style="height: 4px; width: 200px; display: none;" id="fileSizeProgress">
                                                            <div class="progress-bar" role="progressbar" style="width: 0%"></div>
                                                        </div>
                                                        <div class="alert alert-danger mt-2 py-1 px-3" id="sizeError" style="display: none;">
                                                            <i class="fas fa-exclamation-triangle me-1"></i>
                                                            <small>File exceeds 10MB limit</small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="invalid-feedback" id="fileValidationError">Please upload a valid PDF file (max 10MB).</div>
                                        </div>
                                        
                                        <!-- <div class="mt-4" id="uploadButtonContainer" style="display: none;">
                                            <button type="button" class="btn btn-primary" id="btnUploadFile">
                                                <i class="fas fa-upload me-2"></i>Upload File
                                            </button>
                                        </div> -->
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Step 5: Acknowledgement -->
                        <div class="step-content" id="step-5-content">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0 fw-semibold"><i class="fas fa-file-alt me-2 text-warning"></i>Acknowledgement Slip</h6>
                                <button type="button" class="btn btn-primary" id="btn_not_on_case_ap_generate_acknowledgement">
                                    <i class="fas fa-download me-2"></i>Generate Acknowledgement
                                </button>
                            </div>
                            
                            <div class="card">
                                <div class="card-body p-2">
                                    <div class="embed-responsive embed-responsive-16by9">
                                        <iframe src="" id="notoncaseakblobfile" class="embed-responsive-item" width="100%" height="500"></iframe>
                                    </div>
                                </div>
                                <div class="card-footer bg-light">
                                    <small class="text-muted">Acknowledgement slip will be generated after completing all previous steps.</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light rounded-bottom-3">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div>
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                    </div>
                    <div class="d-flex">
                        <button type="button" class="btn btn-outline-primary me-2" id="btnPrevStep">
                            <i class="fas fa-chevron-left me-2"></i>Previous
                        </button>
                        <button type="button" class="btn btn-primary" id="btnNextStep">
                            Next Step <i class="fas fa-chevron-right ms-2"></i>
                        </button>
                        <button type="button" class="btn btn-success ms-2" id="btnCompleteProcess" style="display: none;">
                            <i class="fas fa-check me-2"></i>Complete Process
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade effect-scale modal-blur" id="addNewserviceBillModalonCase" tabindex="-1" aria-labelledby="addNewserviceBillModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addNewserviceBillModal">
            <i class="fas fa-file-invoice me-2"></i>
            New Service Bill
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="from_add_valuation">
          <input id="action_on_form_valuation" type="hidden">
          
          <div class="row g-3">
            <!-- Main Service Selection -->
            <div class="col-md-6">
              <label for="main_service_on_case" class="form-label">Main Service</label>
              <select name="main_service_on_case" id="main_service_on_case" class="form-select" data-live-search="true">
                <!-- Options will be populated dynamically -->
              </select>
            </div>
            
            <!-- Sub Service Selection -->
            <div class="col-md-6">
              <label for="sub_service_on_case" class="form-label">Sub Service</label>
              <select name="sub_service_on_case" id="sub_service_on_case" class="form-select" data-live-search="true">
                <option value="-1">Select Sub Service</option>
              </select>
            </div>
          </div>
          
          <!-- Registration Number Section -->
          <div id="oncasereg-no-div" class="d-none mt-3">
            <div class="card border-0">
              <div class="card-body p-3 bg-light rounded">
                <h6 class="card-title mb-3">Surveyor Information</h6>
                <div class="row g-3">
                  <div class="col-md-4">
                    <label for="new_bill_application_ls_number_oncase" class="form-label">Surveyor's Number</label>
                    <input class="form-control" id="new_bill_application_ls_number_oncase" name="ls_number" type="text" value="${licensed_surveyor_number}" readonly>
                  </div>
                  <div class="col-md-8">
                    <label for="new_bill_application_surveyors_name_oncase" class="form-label">Surveyor's Name</label>
                    <input class="form-control" id="new_bill_application_surveyors_name_oncase" name="new_bill_application_surveyors_name_oncase" type="text" readonly>
                  </div>
                  <div class="col-md-6">
                    <label for="new_bill_application_surveyors_status_oncase" class="form-label">Surveyor's Status</label>
                    <input class="form-control" id="new_bill_application_surveyors_status_oncase" name="new_bill_application_surveyors_status_oncase" type="text" readonly>
                  </div>
                  <div class="col-md-6 d-flex align-items-end">
                    <button type="button" class="btn btn-primary" id="lc_btn_check_status_of_lincense_surveyor_oncase" data-bs-toggle="tooltip" title="Search for Surveyor">
                      <i class="fas fa-search me-1"></i> Check Status
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Checklist Section -->
          <div class="mt-4">
            <div class="card">
              <div class="card-header">
                <i class="fas fa-list-check me-2"></i>Check List
              </div>
              <div class="card-body p-0">
                <div class="table-responsive">
                  <table class="table table-hover mb-0" id="on_case_checlist_table_billdataTable">
                    <thead class="table-light">
                      <tr>
                        <th width="80%">Description</th>
                        <th width="20%" class="text-center">Option</th>
                      </tr>
                    </thead>
                    <tbody>
                      <!-- Checklist items will be populated here -->
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Client and Case Information -->
          <div class="row g-3 mt-3">
            <div class="col-md-6">
              <label for="on_application_client_name" class="form-label">Client Name</label>
              <input class="form-control" id="on_application_client_name" name="on_application_client_name" type="text" value="${ar_name}" readonly>
            </div>
            <div class="col-md-6">
              <label for="new_bill_case_number" class="form-label">Transaction Number</label>
              <input class="form-control" id="new_bill_case_number_on_case" name="new_bill_case_number" type="text" value="${case_number}" readonly>
            </div>
          </div>

          <div class="row g-3 mt-3">
            <div class="col-md-6">
              <label for="on_application_client_name" class="form-label">Office Region</label>
              <select name="new_bill_application_office_region_on_case" id="new_bill_application_office_region_on_case" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                <option value="-1">Select Office Region</option>
                <c:forEach items="${officeregionlist}" var="officeregion">
                  <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                </c:forEach>
              </select>
            </div>
          </div>
          
          <!-- Land Size Section -->
          <div id="oncasereglandsize-no-div" class="mt-3">
            <div class="row g-3">
              <div class="col-md-6">
                <label for="new_bill_land_size_on_case" class="form-label">Land Size (Acre(s))</label>
                <input class="form-control" id="new_bill_land_size_on_case" name="new_bill_land_size_on_case" type="text" placeholder="Enter land Size" required>
              </div>
              <div class="col-md-6">
                <label for="new_bill_locality_on_case_1" class="form-label">Locality</label>
                <input class="form-control" id="new_bill_locality_on_case_1" name="new_bill_locality_on_case_1" type="text" placeholder="Enter locality" required>
              </div>
            </div>
          </div>
          
          <!-- Stamping Section -->
          <div id="oncasestp-no-div" style="display: none" class="mt-3">
            <div class="row g-3">
              <div class="col-md-6">
                <label for="new_number_of_copies_on_case" class="form-label">Number of Copies</label>
                <input class="form-control" id="new_number_of_copies_on_case" name="new_number_of_copies_on_case" type="number" placeholder="Enter No of Copies" required>
              </div>
              <div class="col-md-6">
                <label for="new_bill_type_of_use_on_case" class="form-label">Type of Use</label>
                <select name="type_of_use" id="new_bill_type_of_use_on_case" class="form-select" data-live-search="true">
                  <option value="-1">Select Type of Use</option>
                </select>
              </div>
              <div class="col-md-6">
                <label for="new_type_of_revenue_item_on_case" class="form-label">Nature of Instrument</label>
                <select name="new_type_of_revenue_item_on_case" id="new_type_of_revenue_item_on_case" class="form-select" data-live-search="true">
                  <option value="-1">Select Nature of Interest</option>
                  
                </select>
              </div>
            </div>
          </div>
          
          <!-- Registration Forms Section -->
          <div id="oncasefreg-no-div" style="display: none" class="mt-3">
            <div class="row g-3">
              <div class="col-md-6">
                <label for="new_bill_registration_forms_on_case" class="form-label">Forms</label>
                <select name="new_bill_registration_forms_on_case" id="new_bill_registration_forms_on_case" class="form-select" data-live-search="true">
                  <option value="-1">Select Registration Forms</option>
                </select>
              </div>
            </div>
          </div>
          
          <!-- Publication Type Section -->
          <div id="oncasefpublication-no-div" style="display: none" class="mt-3">
            <div class="row g-3">
              <div class="col-md-6">
                <label for="new_bill_publication_type_on_case" class="form-label">Publication Type</label>
                <select name="new_bill_publication_type_on_case" id="new_bill_publication_type_on_case" class="form-select">
                  <option value="normal_publication">Normal Publication</option>
                  <option value="special_publication">Special Publication</option>
                </select>
              </div>
            </div>
          </div>
        </form>
      </div>
          
          <!-- Modal Footer -->
          <div class="modal-footer mt-4">
            <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">Close</button>
            <button type="button" id="btn_save_to_generate_on_application" class="btn btn-primary">Generate Bill</button>
          </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="viewBatchlistModal" tabindex="-1" aria-labelledby="viewBatchlistModalLabel" aria-hidden="true" data-bs-backdrop="static">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <!-- Header - Clean and professional -->
         <div class="modal-header border-bottom">
            <h5 class="modal-title fw-semibold fs-5" id="viewBatchlistModalLabel">
               <i class="ri-group-line me-2"></i>Batch List Processing
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
         <div class="modal-body">
            <input id="lbl_batch_type" name="lbl_batch_type" type="hidden" value="">
            
            <!-- Batch Type Selection Card -->
            <div class="card mb-4 shadow-sm border">
               <div class="card-body">
                  <div class="row align-items-center mb-3">
                     <div class="col-md-4">
                        <label class="form-label fw-semibold mb-2">
                           <i class="ri-share-forward-line me-1"></i>Batch To:
                        </label>
                        <div class="btn-group w-100" role="group" aria-label="Batch type selection">
                           <input type="radio" class="btn-check" name="batch_type_radio" id="batch_type_unit" autocomplete="off" value="Unit">
                           <label class="btn btn-outline-primary" for="batch_type_unit">
                              <i class="ri-building-2-line me-1"></i>Unit
                           </label>
                           
                           <input type="radio" class="btn-check" name="batch_type_radio" id="batch_type_individual" autocomplete="off" value="Individual">
                           <label class="btn btn-outline-primary" for="batch_type_individual">
                              <i class="ri-user-line me-1"></i>Individual
                           </label>
                           
                           <c:if test="${unit_name == 'CSAU' || unit_name == 'CORPORATE CSAU UNIT'}">
                                <input type="radio" class="btn-check" name="batch_type_radio"
                                        id="batch_type_cabinet" autocomplete="off" value="Cabinet">
                                <label class="btn btn-outline-primary" for="batch_type_cabinet">
                                    <i class="ri-archive-line me-1"></i>Cabinet
                                </label>
                            </c:if>
                        </div>
                        <input type="hidden" name="batch_type" id="batch_type">
                        <div class="text-muted small mt-3">
                           <i class="ri-information-line me-1"></i>
                           Select where to batch the selected applications
                        </div>
                     </div>
                  </div>
                  
                  <!-- Unit Batching Section -->
                  <div class="batch-section bg-primary-transparent border rounded p-3 mb-3" id="unit-batching-section" style="display: none;">
                     <h6 class="fw-semibold mb-3 text-primary">
                        <i class="ri-building-2-fill me-2"></i>Batching to a Unit
                     </h6>
                     <div class="row g-3">
                        <div class="col-md-6">
                           <label for="unit_division_to_send_to" class="form-label fw-medium">
                              Division <span class="text-danger">*</span>
                           </label>
                           <select id="unit_division_to_send_to" data-trigger class="form-select">
                              <option value="" selected disabled>Select Division</option>
                              <option value="LVD">LVD</option>
                              <option value="LRD">LRD</option>
                              <option value="PVLMD">PVLMD</option>
                              <option value="SMD">SMD</option>
                              <option value="RLO">RLO</option>
                           </select>
                        </div>
                        <div class="col-md-6">
                            <label for="unit_to_send_to" class="form-label fw-medium">
                                Unit <span class="text-danger">*</span>
                                <small class="text-muted ms-1" id="unit-count">(0 units)</small>
                            </label>
                            <div class="datalist-container">
                                <div class="input-group">
                                    <select class="form-select" 
                                        id="unit_to_send_to" 
                                        aria-describedby="unit-help">
                                        <option value="" selected disabled>Select a unit</option>
                                        <!-- Options will be populated dynamically -->
                                    </select>
                                    <span class="input-group-text">
                                        <i class="ri-building-2-line" id="unit-icon"></i>
                                    </span>
                                </div>
                            </div>
                            <div id="unit-help" class="form-text">
                                <i class="ri-information-line me-1"></i>
                                Select a unit from the dropdown list
                            </div>
                        </div>
                     </div>
                  </div>
                  
                  <!-- Individual Batching Section -->
                  <div class="batch-section bg-primary-transparent border rounded p-3 mb-3" id="individual-batching-section" style="display: none;">
                     <h6 class="fw-semibold mb-3 text-primary">
                        <i class="ri-user-fill me-2"></i>Batching to an Individual
                     </h6>
                     <div class="row g-3">
                       <div class="col-md-6">
                            <label for="division_to_send_to" class="form-label fw-medium">
                                Division/Unit
                            </label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="division_to_send_to" 
                                    value="${unit_name}" readonly>
                                <span class="input-group-text">
                                    <i class="ri-lock-line text-muted"></i>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="user_to_send_to" class="form-label fw-medium">
                                User <span class="text-danger">*</span>
                                <small class="text-muted ms-1" id="user-count">(0 users)</small>
                            </label>
                            <div class="datalist-container">
                                <div class="input-group">
                                    <select class="form-select" id="user_to_send_to" required>
                                        <option value="" selected disabled>Select a user</option>
                                        <!-- Options will be populated dynamically -->
                                    </select>
                                    <span class="input-group-text">
                                        <i class="ri-user-line" id="user-icon"></i>
                                    </span>
                                </div>
                            </div>
                            <div id="user-help" class="form-text">
                                <i class="ri-information-line me-1"></i>
                                Select a user from the dropdown list
                            </div>
                        </div>
                     </div>
                  </div>
                  
                  <!-- Cabinet Batching Section -->
                  <div class="batch-section bg-primary-transparent border rounded p-3 mb-3" id="cabinet-batching-section" style="display: none;">
                     <h6 class="fw-semibold mb-3 text-primary">
                        <i class="ri-archive-fill me-2"></i>Batching to Cabinet
                     </h6>
                     <form id="frmBatchToCabinet" class="row g-3">
                        <div class="col-md-8">
                           <label for="cabinet_to_send_to" class="form-label fw-medium">
                              Cabinet Name <span class="text-danger">*</span>
                           </label>
                           <div class="input-group">
                              <input type="text" class="form-control" id="cabinet_to_send_to" 
                                     placeholder="Enter cabinet name" required>
                              <span class="input-group-text">
                                 <i class="ri-archive-drawer-line"></i>
                              </span>
                           </div>
                        </div>
                        <div class="col-md-4">
                           <label class="form-label">&nbsp;</label>
                           <button type="submit" class="btn btn-primary w-100">
                              <i class="ri-send-plane-line me-1"></i>Batch to Cabinet
                           </button>
                        </div>
                     </form>
                  </div>
               </div>
            </div>
            
            <!-- Batch List Table Card -->
            <div class="card shadow-sm border">
               <div class="card-header border-bottom bg-light">
                  <h6 class="mb-0 fw-semibold">
                     <i class="ri-list-check-2 me-2"></i>Batch List Items
                     <span class="badge bg-primary ms-2" id="batch-count">0</span>
                  </h6>
               </div>
               <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped mb-0" id="batchlistTable">
                            <thead class="table-light">
                                <tr>
                                    <th class="border-bottom">
                                        <i class="ri-hashtag me-1 text-muted"></i>Reference No.
                                    </th>
                                    <th class="border-bottom">
                                        <i class="ri-file-text-line me-1 text-muted"></i>Application Name
                                    </th>
                                    <th class="border-bottom">
                                        <i class="ri-file-list-3-fill me-1 text-muted"></i>Application Type
                                    </th>
                                    <th class="border-bottom">
                                        <i class="ri-chat-quote-line me-1 text-muted"></i>Purpose
                                    </th>
                                    <th class="border-bottom">
                                        <i class="ri-sticky-note-line me-1 text-muted"></i>Remarks
                                    </th>
                                    <th class="border-bottom text-center">
                                        <i class="ri-settings-3-line me-1 text-muted"></i>Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="batchlistdataTable">
                                <!-- Data will be populated here -->
                            </tbody>
                        </table>
                    </div>
                  
                  <!-- Empty State -->
                  <div class="text-center py-5" id="empty-batch-state">
                        <div class="mb-3">
                            <i class="ri-inbox-line fs-1 text-muted"></i>
                        </div>
                        <h6 class="text-muted mb-2">No items in batch list</h6>
                        <p class="text-muted small">Select applications from the table to add them to the batch</p>
                    </div>
                </div>
            </div>
         </div>
         
         <!-- Footer - Clean and professional -->
         <div class="modal-footer border-top">
            <div class="me-auto">
               <button type="button" class="btn btn-outline-danger" id="remove_all_from_list" onclick="remove_all_from_list();">
                  <i class="ri-delete-bin-line me-1"></i>Clear All
               </button>
            </div>
            <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
               <i class="ri-close-line me-1"></i>Cancel
            </button>
            <button type="button" id="btn_process_batchlist_ft" class="btn btn-primary" style="display: none">
               <i class="ri-send-plane-fill me-1"></i>Process Batch
            </button>
         </div>
      </div>
   </div>
</div>

<div class="modal fade effect-scale modal-blur" id="askForPurposeOfBatching" tabindex="-1" aria-labelledby="askForPurposeOfBatchingLabel" aria-hidden="true" data-bs-backdrop="static">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content border-0 shadow">
			<!-- Header -->
			<div class="modal-header border-bottom bg-light">
				<h5 class="modal-title fw-semibold" id="askForPurposeOfBatchingLabel">
					<i class="ri-add-circle-line me-2 text-primary"></i>Add to Batch List
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>

			<!-- Body -->
			<div class="modal-body">
				<input type="hidden" id="bl_application_stage" name="bl_application_stage">
				<input type="hidden" id="bl_application_stage_baby_step" name="bl_application_stage_baby_step">

				<!-- Job Number -->
				<div class="mb-3">
					<label for="bl_job_number_new" class="form-label fw-medium">
						<i class="ri-hashtag me-1 text-muted"></i>Job Number
					</label>
					<div class="input-group">
						<input type="text" class="form-control bg-light" id="bl_job_number_new" readonly>
						<span class="input-group-text bg-light">
							<i class="ri-file-copy-line text-muted"></i>
						</span>
					</div>
				</div>

				<!-- Applicant Name -->
				<div class="mb-3">
					<label for="bl_ar_name_new" class="form-label fw-medium">
						<i class="ri-user-line me-1 text-muted"></i>Applicant Name
					</label>
					<div class="input-group">
						<textarea class="form-control bg-light" id="bl_ar_name_new" rows="2" readonly></textarea>
						<span class="input-group-text bg-light align-items-start">
							<i class="ri-user-3-line text-muted"></i>
						</span>
					</div>
				</div>

				<!-- Application Type -->
				<div class="mb-3">
					<label for="bl_business_process_sub_name_new" class="form-label fw-medium">
						<i class="ri-file-text-line me-1 text-muted"></i>Application Type
					</label>
					<div class="input-group">
						<textarea class="form-control bg-light" id="bl_business_process_sub_name_new" rows="2" readonly></textarea>
						<span class="input-group-text bg-light align-items-start">
							<i class="ri-draft-line text-muted"></i>
						</span>
					</div>
				</div>

				<!-- Two Column Layout for Milestone and Baby Step -->
				<div class="row g-3 mb-3">
					<!-- Main Milestone -->
					<div class="col-md-6">
						<label for="bl_application_stage_name" class="form-label fw-medium">
							<i class="ri-flag-line me-1 text-muted"></i>Main Milestone
						</label>
						<div class="input-group">
							<textarea class="form-control bg-light" id="bl_application_stage_name" rows="2" readonly></textarea>
						</div>
					</div>
					
					<!-- Baby Step -->
					<div class="col-md-6">
						<label for="bl_application_stage_name_baby_step" class="form-label fw-medium">
							<i class="ri-footprint-line me-1 text-muted"></i>Baby Step
						</label>
						<div class="input-group">
							<textarea class="form-control bg-light" id="bl_application_stage_name_baby_step" rows="2" readonly></textarea>
						</div>
					</div>
				</div>

				<!-- Sent Purpose -->
				<div class="mb-3">
					<label for="bl_job_purpose_new" class="form-label fw-medium">
						<i class="ri-send-plane-line me-1 text-muted"></i>Sent Purpose
						<span class="text-danger">*</span>
					</label>
					<select name="bl_job_purpose_new" id="bl_job_purpose_new" class="form-select" required>
						<option value="" selected disabled>Select purpose</option>
						<!-- Options will be populated dynamically -->
					</select>
					<div class="form-text">
						<i class="ri-information-line me-1"></i>Select why this application is being batched
					</div>
				</div>

				<!-- Remarks/Notes -->
				<div class="mb-4">
					<label for="bl_remarks_notes" class="form-label fw-medium">
						<i class="ri-sticky-note-line me-1 text-muted"></i>Remarks/Notes
					</label>
					<div class="input-group">
						<textarea class="form-control" id="bl_remarks_notes" rows="3" 
							placeholder="Add any additional notes or remarks..."></textarea>
						<span class="input-group-text bg-light align-items-start">
							<i class="ri-chat-1-line text-muted"></i>
						</span>
					</div>
					<div class="form-text">
						<i class="ri-information-line me-1"></i>Optional notes for reference
					</div>
				</div>

				<!-- Hidden Inputs -->
				<input type="hidden" id="bl_jn_id" name="jn_id">
				<input type="hidden" id="bl_send_by_id" name="send_by_id">
				<input type="hidden" id="bl_userid" name="userid">
			</div>

			<!-- Footer -->
			<div class="modal-footer border-top">
				<button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
					<i class="ri-close-line me-1"></i>Cancel
				</button>
				<button type="button" id="btnaddjobtolistFinal" class="btn btn-primary">
					<i class="ri-add-circle-fill me-1"></i>Add to List
				</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade effect-scale modal-blur" id="incoming_advanced_search" tabindex="-1" aria-labelledby="incomingAdvancedSearchLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <h5 class="modal-title fw-semibold" id="incomingAdvancedSearchLabel">
                    <i class="ri-filter-3-line me-2 text-primary"></i>Advanced Filter
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <input type="hidden" id="adv_inbox_type" class="form-control">

                <!-- Filter Type Selection -->
                <div class="card border mb-4">
                    <div class="card-body">
                        <h6 class="card-title fw-semibold mb-3">
                            <i class="ri-search-eye-line me-2"></i>Filter By
                        </h6>
                        <div class="row g-2">
                            <div class="col-md-6 col-lg-4">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="adv_search_type" 
                                           id="adv_filter_type_1" value="f_job_number" checked>
                                    <label class="form-check-label fw-medium" for="adv_filter_type_1">
                                        <i class="ri-hashtag me-1"></i>Job Number
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-4">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="adv_search_type" 
                                           id="adv_filter_type_2" value="f_app_type">
                                    <label class="form-check-label fw-medium" for="adv_filter_type_2">
                                        <i class="ri-file-text-line me-1"></i>Application Type
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-4">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="adv_search_type" 
                                           id="adv_filter_type_3" value="f_date_range">
                                    <label class="form-check-label fw-medium" for="adv_filter_type_3">
                                        <i class="ri-calendar-line me-1"></i>Date Range
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-4">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="adv_search_type" 
                                           id="adv_filter_type_4" value="f_job_purpose">
                                    <label class="form-check-label fw-medium" for="adv_filter_type_4">
                                        <i class="ri-send-plane-line me-1"></i>Job Purpose
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-4">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="adv_search_type" 
                                           id="adv_filter_type_5" value="f_limit">
                                    <label class="form-check-label fw-medium" for="adv_filter_type_5">
                                        <i class="ri-bar-chart-line me-1"></i>Set Limit
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Status Display -->
                <div class="card border mb-4">
                    <div class="card-body">
                        <h6 class="card-title fw-semibold mb-3">
                            <i class="ri-information-line me-2"></i>Current Status
                        </h6>
                        <div class="alert alert-light border d-flex align-items-center" role="alert">
                            <i class="ri-checkbox-circle-line text-primary me-2"></i>
                            <span id="adv_status" class="fw-medium">No status selected</span>
                        </div>
                    </div>
                </div>

                <!-- Filter Sections -->
                <div class="filter-sections">
                    <!-- Job Number Filter -->
                    <div class="card border mb-3 include_job_search exclude_job_purpose exclude_app_type exclude_date_range exclude_limit">
                        <div class="card-body">
                            <h6 class="card-title fw-semibold mb-3">
                                <i class="ri-hashtag me-2 text-primary"></i>Job Number
                            </h6>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="ri-search-line"></i>
                                </span>
                                <input type="text" class="form-control" id="adv_job_number" 
                                       placeholder="Enter job number(s) separated by commas">
                                <button class="btn btn-outline-dark" type="button" id="btn_clear_job_number">
                                    <i class="ri-close-line"></i>
                                </button>
                            </div>
                            <div class="form-text mt-2">
                                <i class="ri-information-line me-1"></i>
                                Enter one or more job numbers, separated by commas
                            </div>
                        </div>
                    </div>

                    <!-- Application Type Filter -->
                    <div class="card border mb-3 include_app_type exclude_job_purpose exclude_job_search exclude_date_range exclude_limit">
                        <div class="card-body">
                            <h6 class="card-title fw-semibold mb-3">
                                <i class="ri-file-text-line me-2 text-primary"></i>Application Type
                            </h6>
                            <select class="form-select" id="adv_application_type">
                                <option value="" selected>Select application type</option>
                                <!-- Options will be populated dynamically -->
                            </select>
                            <div class="form-text mt-2">
                                <i class="ri-information-line me-1"></i>
                                Filter by specific application type
                            </div>
                        </div>
                    </div>

                    <!-- Job Purpose Filter -->
                    <div class="card border mb-3 include_job_purpose include_app_type exclude_job_search exclude_date_range exclude_limit">
                        <div class="card-body">
                            <h6 class="card-title fw-semibold mb-3">
                                <i class="ri-send-plane-line me-2 text-primary"></i>Job Purpose
                            </h6>
                            <select class="form-select" id="adv_job_purpose">
                                <option value="" selected>Select job purpose</option>
                                <!-- Options will be populated dynamically -->
                            </select>
                            <div class="form-text mt-2">
                                <i class="ri-information-line me-1"></i>
                                Filter by specific job purpose
                            </div>
                        </div>
                    </div>

                    <!-- Date Range Filter -->
                    <div class="card border mb-3 include_date_range exclude_job_search exclude_job_purpose exclude_app_type exclude_limit">
                        <div class="card-body">
                            <h6 class="card-title fw-semibold mb-3">
                                <i class="ri-calendar-line me-2 text-primary"></i>Date Range
                            </h6>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="adv_from_date" class="form-label fw-medium">
                                        <i class="ri-calendar-event-line me-1"></i>From Date
                                    </label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" id="adv_from_date">
                                        <span class="input-group-text">
                                            <i class="ri-calendar-2-line"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="adv_to_date" class="form-label fw-medium">
                                        <i class="ri-calendar-event-line me-1"></i>To Date
                                    </label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" id="adv_to_date">
                                        <span class="input-group-text">
                                            <i class="ri-calendar-2-line"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-text mt-2">
                                <i class="ri-information-line me-1"></i>
                                Select date range to filter applications
                            </div>
                        </div>
                    </div>

                    <!-- Limit and Sorting Section -->
                    <div class="row g-3 mb-3 include_app_type include_job_purpose include_date_range exclude_job_search include_limit">
                        <!-- Limit -->
                        <div class="col-md-6">
                            <div class="card border h-100">
                                <div class="card-body">
                                    <h6 class="card-title fw-semibold mb-3">
                                        <i class="ri-bar-chart-line me-2 text-primary"></i>Record Limit
                                    </h6>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="adv_limit" 
                                               placeholder="Enter limit" min="1" max="1000" value="50">
                                        <span class="input-group-text">records</span>
                                    </div>
                                    <div class="form-text mt-2">
                                        <i class="ri-information-line me-1"></i>
                                        Maximum 1000 records allowed
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Sorting -->
                        <div class="col-md-6">
                            <div class="card border h-100">
                                <div class="card-body">
                                    <h6 class="card-title fw-semibold mb-3">
                                        <i class="ri-sort-asc me-2 text-primary"></i>Sort Order
                                    </h6>
                                    <select class="form-select" id="adv_sorting">
                                        <option value="" selected>Default sorting</option>
                                        <option value="asc">Ascending (Oldest First)</option>
                                        <option value="desc">Descending (Newest First)</option>
                                    </select>
                                    <div class="form-text mt-2">
                                        <i class="ri-information-line me-1"></i>
                                        Sort results by creation date
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer border-top">
                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Cancel
                </button>
                <button type="button" class="btn btn-outline-danger" id="btn_reset_filters">
                    <i class="ri-refresh-line me-1"></i>Reset
                </button>
                <button type="button" class="btn btn-primary" id="btn_load_adv_filter">
                    <i class="ri-search-line me-1"></i>Apply Filters
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="warningAppsModal" tabindex="-1" aria-labelledby="warningAppsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="warningAppsModalLabel">
                        <i class="ri-alert-line me-2 text-warning"></i>
                        <span id="modalTitleText">Applications Overview</span>
                    </h5>
                    <button type="button" class="btn btn-primary ms-auto sendReminderMsg" 
                            data-action='DashboardAppsWithDivision'>
                        <i class="ri-send-plane-line me-1"></i>Send Message
                    </button>
                </div>
                <button type="button" class="btn-close ms-2" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Body -->
            <div class="modal-body p-0">

                <!-- Table Container -->
                <div class="p-4">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped mb-0" id="warningAppsTable" style="width: 100%">
                            <thead class="table-light">
                                <tr>
                                    <th>Job Number</th>
                                    <th>Application Type</th>
                                    <th>Receiver</th>
                                    <th>Division</th>
                                    <th>TAT</th>
                                    <th>Date Created</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Data will be populated by DataTables -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer border-top">
                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="reminderAppsModal" tabindex="-1" aria-labelledby="reminderAppsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="reminderAppsModalLabel">
                        <i class="ri-alert-line me-2 text-info"></i>
                        <span id="modalTitleText">Applications Overview</span>
                    </h5>
                    <button type="button" class="btn btn-primary ms-auto sendReminderMsg" 
                            data-action='DashboardAppsWithDivision'>
                        <i class="ri-send-plane-line me-1"></i>Send Message
                    </button>
                </div>
                <button type="button" class="btn-close ms-2" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Body -->
            <div class="modal-body p-0">

                <!-- Table Container -->
                <div class="p-4">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped mb-0" id="reminderAppsTable" style="width: 100%">
                            <thead class="table-light">
                                <tr>
                                    <th>Job Number</th>
                                    <th>Application Type</th>
                                    <th>Receiver</th>
                                    <th>Division</th>
                                    <th>TAT</th>
                                    <th>Date Created</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Data will be populated by DataTables -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer border-top">
                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="sendMessageModal" tabindex="-1" aria-labelledby="sendMessageModalLabel" style="z-index: 1029;" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="sendMessageModalLabel">
                        <i class="ri-message-2-line me-2 text-primary"></i>
                        <span id="modalTitleText">Send Message</span>
                    </h5>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <!-- Recipient Info Card -->
                <div class="card border mb-4">
                    <div class="card-body py-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-md bg-primary bg-opacity-10 rounded-circle me-3">
                                <i class="ri-user-line text-primary fs-4"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-0 fw-semibold" id="recipientNameDisplay">Select a recipient</h6>
                                <small class="text-muted" id="recipientInfo">No recipient selected</small>
                            </div>
                            <div class="badge bg-light text-dark" id="jobCountBadge">0 jobs</div>
                        </div>
                    </div>
                </div>

                <!-- Message Form -->
                <form method="post" id="message-form" action="SendComplianceMessage" class="needs-validation" novalidate>
                    <input id="officer_id" name="officer_id" type="hidden"/>
                    <input id="request_type" name="request_type" value="send_compliance_message" type="hidden">
                    <input id="officer_name" name="officer_name" type="hidden"/>
                    <input id="job_numbers" name="job_numbers[]" type="hidden"/>

                    <!-- Message Type -->
                    <div class="mb-4">
                        <label for="message_type" class="form-label fw-medium">
                            <i class="ri-chat-1-line me-1 text-muted"></i>
                            Message Type
                            <span class="text-danger">*</span>
                        </label>
                        <div class="btn-group w-100" role="group" aria-label="Message type selection">
                            <input type="radio" class="btn-check" name="message_type" id="message_type_query" value="query" autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="message_type_query">
                                <i class="ri-question-line me-1"></i>Query
                            </label>
                            
                            <input type="radio" class="btn-check" name="message_type" id="message_type_message" value="message" autocomplete="off">
                            <label class="btn btn-outline-primary" for="message_type_message">
                                <i class="ri-message-2-line me-1"></i>Message
                            </label>
                            
                            <input type="radio" class="btn-check" name="message_type" id="message_type_reminder" value="reminder" autocomplete="off">
                            <label class="btn btn-outline-primary" for="message_type_reminder">
                                <i class="ri-alarm-warning-line me-1"></i>Reminder
                            </label>
                        </div>
                        <div class="form-text">
                            <i class="ri-information-line me-1"></i>
                            Select the type of message you want to send
                        </div>
                    </div>

                    <!-- Message Content -->
                    <div class="mb-4">
                        <label for="message" class="form-label fw-medium">
                            <i class="ri-chat-quote-line me-1 text-muted"></i>
                            Message Content
                            <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <textarea class="form-control" name="message" id="message" 
                                      rows="5" placeholder="Type your message here..." 
                                      required style="resize: none;"></textarea>
                            <span class="input-group-text bg-light align-items-start">
                                <i class="ri-pencil-line text-muted"></i>
                            </span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-2">
                            <div class="form-text">
                                <i class="ri-information-line me-1"></i>
                                Write your message to the recipient
                            </div>
                            <small class="text-muted" id="charCount">0/1000 characters</small>
                        </div>
                    </div>

                    <!-- Template Suggestions (Optional) -->
                    <div class="mb-4">
                        <label class="form-label fw-medium">
                            <i class="ri-stack-line me-1 text-muted"></i>
                            Quick Templates
                        </label>
                        <div class="d-flex flex-wrap gap-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="query">
                                <i class="ri-question-line me-1"></i>Urgent Query
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="followup">
                                <i class="ri-time-line me-1"></i>Follow-up Required
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="reminder">
                                <i class="ri-alarm-warning-line me-1"></i>TAT Reminder
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="update">
                                <i class="ri-refresh-line me-1"></i>Status Update
                            </button>
                        </div>
                    </div>

                    <!-- Preview Section -->
                    <div class="card border mb-4" id="previewCard" style="display: none;">
                        <div class="card-header bg-light">
                            <h6 class="mb-0 fw-semibold">
                                <i class="ri-eye-line me-2"></i>Message Preview
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-light border" id="messagePreview">
                                <small class="text-muted">Preview will appear here</small>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="ri-close-line me-1"></i>Cancel
                        </button>
                        <button type="reset" class="btn btn-outline-warning" id="btnResetForm">
                            <i class="ri-refresh-line me-1"></i>Reset
                        </button>
                        <button type="submit" class="btn btn-primary flex-grow-1" id="btnSubmitMessage">
                            <i class="ri-send-plane-line me-1"></i>
                            <span id="submitButtonText">Send Message</span>
                            <span class="spinner-border spinner-border-sm ms-2 d-none" id="loadingSpinner" role="status" aria-hidden="true"></span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="unitComplianceModal" tabindex="-1" aria-labelledby="unitComplianceModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="unitComplianceModalLabel">
                        <i class="ri-alert-line me-2 text-danger"></i>
                        ${unit_name}'s Compliance Applications
                    </h5>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <!-- Status Legend -->
                <div class="card border mb-4">
                    <div class="card-body py-3">
                        <h6 class="card-title fw-semibold mb-3">
                            <i class="ri-information-line me-2"></i>Status Legend
                        </h6>
                        <div class="row g-3">
                            <div class="col-md-3 col-sm-6">
                                <div class="d-flex align-items-center">
                                    <div class="legend-dot bg-info me-2"></div>
                                    <span class="small">Reminder Applications</span>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="d-flex align-items-center">
                                    <div class="legend-dot bg-warning me-2"></div>
                                    <span class="small">Warning Applications</span>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="d-flex align-items-center">
                                    <div class="legend-dot bg-danger me-2"></div>
                                    <span class="small">Queried Applications</span>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="d-flex align-items-center">
                                    <div class="legend-dot bg-success me-2"></div>
                                    <span class="small">Messages</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Table Container -->
                <div class="table-responsive">
                    <table class="table table-hover mb-0" id="complianceTable" style="width: 100%">
                        <thead class="table-light">
                            <tr>
                                <th width="5%">#</th>
                                <th width="10%">Job No.</th>
                                <th width="20%">Details</th>
                                <th width="15%">Receiver</th>
                                <th width="15%">Sender</th>
                                <th width="10%">TAT</th>
                                <th width="15%">Date of Notice</th>
                                <th width="10%" class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Data will be populated by DataTables -->
                        </tbody>
                    </table>
                </div>
                
                <!-- Loading State -->
                <div class="text-center py-5" id="complianceLoading">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-2">Loading compliance applications...</p>
                </div>
                
                <!-- Empty State -->
                <div class="text-center py-5" id="complianceEmpty" style="display: none;">
                    <div class="mb-3">
                        <i class="ri-inbox-line fs-1 text-muted"></i>
                    </div>
                    <h6 class="text-muted mb-2">No Compliance Applications</h6>
                    <p class="text-muted small">No compliance applications found for this unit</p>
                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer border-top">
                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
                <button type="button" class="btn btn-primary" id="btnRefreshCompliance">
                    <i class="ri-refresh-line me-1"></i>Refresh
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="respondedQueriesModal" tabindex="-1" aria-labelledby="respondedQueriesModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="respondedQueriesModalLabel">
                        <i class="ri-checkbox-circle-line me-2 text-success"></i>
                        Responded Queries - ${unit_name}
                    </h5>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body p-0">
                <!-- Toolbar -->
                <div class="d-flex justify-content-between align-items-center p-4 border-bottom bg-white">
                    <div class="d-flex align-items-center gap-2">
                        <button type="button" class="btn btn-outline-primary btn-sm" id="btnSelectAll">
                            <i class="ri-checkbox-multiple-line me-1"></i>Select All
                        </button>
                        <button type="button" class="btn btn-outline-success btn-sm" id="btnBatchSelected">
                            <i class="ri-list-check-2 me-1"></i>Batch Selected
                        </button>
                        <button type="button" class="btn btn-outline-secondary btn-sm" id="btnExportData">
                            <i class="ri-download-line me-1"></i>Export
                        </button>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <div class="input-group input-group-sm" style="width: 300px;">
                            <span class="input-group-text bg-transparent">
                                <i class="ri-search-line"></i>
                            </span>
                            <input type="text" class="form-control" id="searchQueries" placeholder="Search applications...">
                        </div>
                        <div class="badge bg-primary" id="queryCount">0 queries</div>
                    </div>
                </div>

                <!-- Table Container -->
                <div class="table-responsive p-4">
                    <table class="table table-hover table-striped mb-0" id="tbl_responded_queries_result" style="width: 100%">
                        <thead class="table-light">
                            <tr>
                                <th width="5%">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="selectAllCheckbox">
                                    </div>
                                </th>
                                <th width="10%">
                                    <i class="ri-hashtag me-1 text-muted"></i>Job Number
                                </th>
                                <th width="20%">
                                    <i class="ri-user-line me-1 text-muted"></i>Applicant Name
                                </th>
                                <th width="15%">
                                    <i class="ri-file-text-line me-1 text-muted"></i>Business Process
                                </th>
                                <th width="15%">
                                    <i class="ri-map-pin-line me-1 text-muted"></i>Locality
                                </th>
                                <th width="15%">
                                    <i class="ri-user-check-line me-1 text-muted"></i>Approved By
                                </th>
                                <th width="20%" class="text-center">
                                    <i class="ri-settings-3-line me-1 text-muted"></i>Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Data will be populated by DataTables -->
                        </tbody>
                    </table>
                    
                    <!-- Loading State -->
                    <div class="text-center py-5" id="loadingQueries">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <p class="text-muted mt-2">Loading responded queries...</p>
                    </div>
                    
                    <!-- Empty State -->
                    <div class="text-center py-5" id="emptyQueries" style="display: none;">
                        <div class="mb-3">
                            <i class="ri-inbox-line fs-1 text-muted"></i>
                        </div>
                        <h6 class="text-muted mb-2">No Responded Queries</h6>
                        <p class="text-muted small">No responded queries found for this unit</p>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer border-top">
                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
                <button type="button" class="btn btn-primary" id="btnRefreshQueries">
                    <i class="ri-refresh-line me-1"></i>Refresh
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="newQueryModal" tabindex="-1" aria-labelledby="newQueryModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="newQueryModalLabel">
                        <i class="ri-questionnaire-line me-2 text-primary"></i>
                        Query Management
                    </h5>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <!-- Alert Display -->
                <div id="alert-display-space-query" class="mb-4"></div>

                <!-- Query Form -->
                <form id="form_add_query" class="needs-validation" novalidate>
                    <!-- Hidden Inputs -->
                    <input type="hidden" id="qid" name="qid" value="0">
                    <input type="hidden" id="query_job_number" class="form-control" required readonly value="${job_number}">
                    <input type="hidden" name="query_case_number" id="query_case_number" class="form-control" required readonly value="${case_number}">

                    <div class="row g-4">
                        <!-- Left Column -->
                        <div class="col-lg-6 col-md-6">
                            <!-- General Reasons -->
                            <div class="mb-4">
                                <label for="query_general_reason" class="form-label fw-medium">
                                    <i class="ri-alert-line me-1 text-muted"></i>
                                    General Reasons
                                    <span class="text-danger">*</span>
                                    <small class="text-muted d-block mt-1">What is wrong with this Application</small>
                                </label>
                                <textarea name="query_general_reason" id="query_general_reason" 
                                          class="form-control" rows="3" required
                                          placeholder="Describe the general issues with this application..."></textarea>
                            </div>

                            <!-- For Higher Level Users -->
                            <div class="to_hide_on_level_1">
                                <!-- Reasons for Applicant -->
                                <div class="mb-4">
                                    <label for="query_reasons" class="form-label fw-medium">
                                        <i class="ri-chat-quote-line me-1 text-muted"></i>
                                        Reasons for Applicant
                                        <span class="text-danger">*</span>
                                        <small class="text-muted d-block mt-1">Reason for Query that will be displayed to Applicant</small>
                                    </label>
                                    <textarea name="query_reasons" id="query_reasons" 
                                              class="form-control" rows="3" required
                                              placeholder="Enter reason to be shown to applicant..."></textarea>
                                </div>

                                <!-- Remarks/Recommendations -->
                                <div class="mb-4">
                                    <label for="query_remarks" class="form-label fw-medium">
                                        <i class="ri-lightbulb-line me-1 text-muted"></i>
                                        Remarks & Recommendations
                                        <span class="text-danger">*</span>
                                        <small class="text-muted d-block mt-1">What do you recommend to be done</small>
                                    </label>
                                    <textarea name="query_remarks" id="query_remarks" 
                                              class="form-control" rows="3" required
                                              placeholder="Provide recommendations for resolution..."></textarea>
                                </div>

                                <!-- Document Attachment Required -->
                                <div class="mb-4">
                                    <label class="form-label fw-medium">
                                        <i class="ri-attachment-line me-1 text-muted"></i>
                                        Document Attachment Required
                                        <span class="text-danger">*</span>
                                    </label>
                                    <div class="btn-group w-100" role="group" aria-label="Attachment requirement">
                                        <input type="radio" class="btn-check" name="query_attachement_requried" 
                                               id="query_attachement_requried1" value="1" autocomplete="off" required>
                                        <label class="btn btn-outline-primary" for="query_attachement_requried1">
                                            <i class="ri-check-line me-1"></i>YES
                                        </label>
                                        
                                        <input type="radio" class="btn-check" name="query_attachement_requried" 
                                               id="query_attachement_requried2" value="0" autocomplete="off" required>
                                        <label class="btn btn-outline-primary" for="query_attachement_requried2">
                                            <i class="ri-close-line me-1"></i>NO
                                        </label>
                                    </div>
                                    <div class="form-text">
                                        <i class="ri-information-line me-1"></i>
                                        Does the applicant need to provide additional documents?
                                    </div>
                                </div>
                            </div>

                            <!-- Status -->
                            <div class="mb-4">
                                <label for="query_status" class="form-label fw-medium">
                                    <i class="ri-toggle-line me-1 text-muted"></i>
                                    Status
                                    <span class="text-danger">*</span>
                                </label>
                                <select name="query_status" id="query_status" class="form-select" required>
                                    <option value="1" selected>Active</option>
                                    <option value="0">Inactive</option>
                                </select>
                                <div class="form-text">
                                    <i class="ri-information-line me-1"></i>
                                    Active queries require response, Inactive queries are closed
                                </div>
                            </div>
                        </div>

                        <!-- Right Column -->
                        <div class="col-lg-6 col-md-6">
                            <!-- Audit Information Card -->
                            <div class="card border mb-4">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0 fw-semibold">
                                        <i class="ri-history-line me-2"></i>Audit Information
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <!-- Queried By -->
                                    <div class="mb-3">
                                        <label class="form-label small fw-medium text-muted">Queried By</label>
                                        <div class="input-group">
                                            <input type="text" id="query_created_by" class="form-control bg-light" readonly>
                                            <span class="input-group-text bg-light">
                                                <i class="ri-user-line text-muted"></i>
                                            </span>
                                        </div>
                                    </div>

                                    <!-- Queried Date -->
                                    <div class="mb-3">
                                        <label class="form-label small fw-medium text-muted">Queried Date</label>
                                        <div class="input-group">
                                            <input type="text" id="query_created_date" class="form-control bg-light" readonly>
                                            <span class="input-group-text bg-light">
                                                <i class="ri-calendar-line text-muted"></i>
                                            </span>
                                        </div>
                                    </div>

                                    <!-- Modified By -->
                                    <div class="mb-3">
                                        <label class="form-label small fw-medium text-muted">Modified By</label>
                                        <div class="input-group">
                                            <input type="text" id="query_modified_by" class="form-control bg-light" readonly>
                                            <span class="input-group-text bg-light">
                                                <i class="ri-user-settings-line text-muted"></i>
                                            </span>
                                        </div>
                                    </div>

                                    <!-- Modified Date -->
                                    <div class="mb-3">
                                        <label class="form-label small fw-medium text-muted">Modified Date</label>
                                        <div class="input-group">
                                            <input type="text" id="query_modified_date" class="form-control bg-light" readonly>
                                            <span class="input-group-text bg-light">
                                                <i class="ri-calendar-event-line text-muted"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Response Section -->
                            <div class="card border">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0 fw-semibold">
                                        <i class="ri-reply-line me-2"></i>Applicant Response
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <label for="query_response" class="form-label fw-medium">
                                            Response From Applicant
                                        </label>
                                        <div class="input-group">
                                            <textarea name="query_response" id="query_response" 
                                                      class="form-control bg-light" rows="3" 
                                                      disabled readonly placeholder="No response yet"></textarea>
                                            <span class="input-group-text bg-light align-items-start">
                                                <i class="ri-message-2-line text-muted"></i>
                                            </span>
                                        </div>
                                        <div class="form-text mt-2">
                                            <i class="ri-information-line me-1"></i>
                                            This field is populated when the applicant responds
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer -->
                    <div class="modal-footer border-top mt-4 pt-3">
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="ri-close-line me-1"></i>Close
                        </button>
                        <button type="submit" id="btn_query_section" class="btn btn-primary">
                            <i class="ri-save-line me-1"></i>
                            <span id="submitButtonText">Save Changes</span>
                            <span class="spinner-border spinner-border-sm ms-2 d-none" id="loadingSpinner" role="status" aria-hidden="true"></span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="officerModal" tabindex="-1" aria-labelledby="officerModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="officerModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-striped table-hover" style="width: 100%">
                                <thead class="table-light">
                                    <tr>
                                        <th>Officer</th>
                                        <th>Count</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody class="text-small">
                                    <!-- Data will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type" id="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Completed Applications Modal -->
<div class="modal fade" id="completedapplicationsModal" tabindex="-1" aria-labelledby="completedApplicationsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completedApplicationsModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-hover" id="completedApplicationsTable" style="width: 100%">
                                <thead class="table-light">
                                    <tr>
                                        <th>Job Number</th>
                                        <th>Applicant Name</th>
                                        <th>Application Type</th>
                                        <th>Submission Date</th>
                                        <th>Completed Date</th>
                                        <th>TAT</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- New Applications Modal -->
<div class="modal fade" id="newApplicationModal" tabindex="-1" aria-labelledby="newApplicationsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="newApplicationsModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-hover" id="newApplicationsTable" style="width: 100%">
                                <thead class="table-light">
                                    <tr>
                                        <th>Job Number</th>
                                        <th>Applicant Name</th>
                                        <th>Application Type</th>
                                        <th>Submission Date</th>
                                        <th>Date Received by Officer</th>
                                        <th>Pending Days</th>
                                        <th>Days With Officer</th>
                                        <th>Purpose</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Applications Modal (General) -->
<div class="modal fade" id="applicationsModal" tabindex="-1" aria-labelledby="applicationsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="applicationsModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-hover" id="applicationsTable" style="width: 100%">
                                <thead class="table-light">
                                    <tr>
                                        <th>Job Number</th>
                                        <th>Applicant Name</th>
                                        <th>Application Type</th>
                                        <th>Submission Date</th>
                                        <th>Date Received by Officer</th>
                                        <th>Pending Days</th>
                                        <th>Days With Officer</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                        <div class="col-12">
							<div class="chart"></div>
						</div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100 align-items-center">
                    <div class="col-md-6">
                        <form class="generate-applications-chart row g-2 align-items-center">
                            <div class="col-auto">
                                <label for="chart_type" class="col-form-label">Generate Chart: <span class="text-danger">*</span></label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" name="chart_type">
                                    <option value="">Select Chart Type</option>
                                    <option value="pie">Pie Chart</option>
                                    <option value="doughnut">Doughnut Chart</option>
                                    <option value="bar">Bar Chart</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Generate</button>
                                <button type="button" class="btn btn-outline-danger clear-chart ms-2">Clear</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- View Responses Modal -->
<div class="modal fade" id="viewresponseModal" tabindex="-1" aria-labelledby="viewresponseModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-primary text-white">
                <div>
                    <h5 class="modal-title mb-1">
                        <i class="bi bi-chat-text-fill me-2"></i>Query Responses
                    </h5>
                    <p class="mb-0 small opacity-75">Responses on compliance application notice</p>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body p-0">
                <!-- Loading State -->
                <div id="responseLoading" class="text-center py-5">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-3 text-muted">Loading responses...</p>
                </div>
                
                <!-- Empty State -->
                <div id="responseEmpty" class="text-center py-5 d-none">
                    <div class="mb-3">
                        <i class="bi bi-chat-square-text display-4 text-muted"></i>
                    </div>
                    <h6 class="text-muted mb-2">No Responses Yet</h6>
                    <p class="text-muted small">No responses have been submitted for this query.</p>
                </div>
                
                <!-- Responses Container -->
                <div id="responseContainer" class="d-none p-3">
                    <ul class="list-unstyled projects-recent-activity-list" id="response_list">
                        
                    </ul>
                </div>
            </div>
            
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="response-count">
                        <span id="responseCount" class="badge bg-primary">0 responses</span>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-dark me-2" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i> Close
                        </button>
                        <!-- <button type="button" class="btn btn-primary" id="printResponses">
                            <i class="bi bi-printer me-1"></i> Print
                        </button> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>