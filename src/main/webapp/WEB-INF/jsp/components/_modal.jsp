<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<jsp:useBean id="now" class="java.util.Date" />


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
                                    
                                   <form method="POST" enctype="multipart/form-data" id="id_formatCSAU_" class="needs-validation" novalidate>
                                        <div class="mb-3">
                                            <div class="file-upload-area border-dashed rounded p-4 text-center mb-3">
                                                <i class="fas fa-file-pdf fa-3x text-danger mb-3"></i>
                                                <h6 class="fw-semibold">Upload PDF Document</h6>
                                                <p class="text-muted small mb-3">Maximum file size: 10MB • Accepted format: PDF only</p>
                                                
                                                <input type="file" 
                                                    class="form-control d-none" 
                                                    id="fileUploadFormatCSAU" 
                                                    name="sampleFile" 
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


<div class="modal fade effect-scale modal-blur" id="addNewserviceBillModalonCase" tabindex="-1" aria-labelledby="addNewserviceBillModalLabel" data-bs-keyboard="false" data-bs-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <!-- Modal Header -->
      <div class="modal-header bg-gradient-primary text-white rounded-top">
        <div class="d-flex align-items-center w-100">
          <div class="flex-grow-1">
            <h5 class="modal-title fw-semibold mb-0" id="addNewserviceBillModalLabel">
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
            <form id="from_add_valuation">
              <input id="action_on_form_valuation" type="hidden">
              <div class="row g-3">
                <div class="col-md-6">
                  <label for="main_service_on_case" class="form-label fw-medium">Main Service <span class="text-danger">*</span></label>
                  <select name="main_service_on_case" id="main_service_on_case" class="form-select form-select-sm" data-style="btn-info" data-live-search="true">
                    <!-- Options will be populated dynamically -->
                  </select>
                </div>
                <div class="col-md-6">
                  <label for="sub_service_on_case" class="form-label fw-medium">Sub Service <span class="text-danger">*</span></label>
                  <select name="sub_service_on_case" id="sub_service_on_case" class="form-select form-select-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  </select>
                </div>
              </div>
            </form>
          </div>
        </div>

        <!-- Surveyor Information Section -->
        <div class="card border-0 shadow-sm mb-4" id="oncasereg-no-div" style="display: none;">
          <div class="card-header bg-light py-3">
            <h6 class="mb-0 fw-semibold"><i class="fas fa-user-tie me-2 text-warning"></i>Surveyor Information</h6>
          </div>
          <div class="card-body">
            <div class="row g-3">
              <div class="col-md-6">
                <label for="new_bill_application_ls_number_oncase" class="form-label fw-medium">Surveyor's Number</label>
                <div class="input-group">
                  <input class="form-control" id="new_bill_application_ls_number_oncase" name="ls_number" type="text" value="${licensed_surveyor_number}" readonly>
                  <button type="button" class="btn btn-primary" id="lc_btn_check_status_of_lincense_surveyor_oncase" data-bs-toggle="tooltip" title="Search Surveyor">
                    <i class="fas fa-search"></i>
                  </button>
                </div>
              </div>
              <div class="col-md-6">
                <label for="new_bill_application_surveyors_name_oncase" class="form-label fw-medium">Surveyor's Name</label>
                <input class="form-control" id="new_bill_application_surveyors_name_oncase" name="new_bill_application_surveyors_name_oncase" type="text" readonly>
              </div>
              <div class="col-md-6">
                <label for="new_bill_application_surveyors_status_oncase" class="form-label fw-medium">Surveyor's Status</label>
                <input class="form-control" id="new_bill_application_surveyors_status_oncase" name="new_bill_application_surveyors_status_oncase" type="text" readonly>
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
              <table class="table table-hover mb-0" id="on_case_checlist_table_billdataTable">
                <thead class="table-light">
                  <tr>
                    <th class="py-3 px-4 fw-medium">Description</th>
                    <th class="py-3 px-4 fw-medium text-center">Options</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- Checklist items will be populated here -->
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- Client and Case Information -->
        <div class="card border-0 shadow-sm mb-4">
          <div class="card-header bg-light py-3">
            <h6 class="mb-0 fw-semibold"><i class="fas fa-user me-2 text-info"></i>Client Information</h6>
          </div>
          <div class="card-body">
            <div class="row g-3">
              <div class="col-md-6">
                <label for="on_application_client_name" class="form-label fw-medium">Client Name</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-user"></i></span>
                  <input class="form-control" id="on_application_client_name" name="on_application_client_name" type="text" value="${ar_name}" readonly>
                </div>
              </div>
              <div class="col-md-6">
                <label for="new_bill_case_number_on_case" class="form-label fw-medium">Transaction Number</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                  <input class="form-control" id="new_bill_case_number_on_case" name="new_bill_case_number" type="text" value="${case_number}" readonly>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Additional Details Section -->
        <div class="card border-0 shadow-sm mb-4">
          <div class="card-header bg-light py-3">
            <h6 class="mb-0 fw-semibold"><i class="fas fa-info-circle me-2 text-secondary"></i>Additional Details</h6>
          </div>
          <div class="card-body">
            <!-- Office Region -->
            <div class="row g-3">
              <div class="col-md-6">
                <label for="new_bill_application_office_region_on_case" class="form-label fw-medium">Office Region</label>
                <select name="new_bill_application_office_region_on_case" id="new_bill_application_office_region_on_case" class="form-select form-select-sm" data-style="btn-info" data-live-search="true">
                  <option value="-1">Select Office Region</option>
                  <c:forEach items="${officeregionlist}" var="officeregion">
                    <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                  </c:forEach>
                </select>
              </div>
            </div>

            <!-- Land Size & Locality -->
            <div class="row g-3 mt-2" id="oncasereglandsize-no-div" style="display: none;">
              <div class="col-md-6">
                <label for="new_bill_land_size_on_case" class="form-label fw-medium">Land Size (Acres)</label>
                <div class="input-group">
                  <input class="form-control" id="new_bill_land_size_on_case" name="new_bill_land_size_on_case" type="text" placeholder="Enter land size">
                  <span class="input-group-text">acres</span>
                </div>
              </div>
              <div class="col-md-6">
                <label for="new_bill_locality_on_case_1" class="form-label fw-medium">Locality</label>
                <input class="form-control" id="new_bill_locality_on_case_1" name="new_bill_locality_on_case_1" type="text" placeholder="Enter locality">
              </div>
            </div>

            <!-- Stamping Details -->
            <div class="row g-3 mt-2" id="oncasestp-no-div" style="display: none;">
              <div class="col-md-6">
                <label for="new_number_of_copies_on_case" class="form-label fw-medium">Number of Copies</label>
                <input class="form-control" id="new_number_of_copies_on_case" name="new_number_of_copies_on_case" type="number" placeholder="Enter No of Copies" min="1">
              </div>
              <div class="col-md-6">
                <label for="new_bill_type_of_use_on_case" class="form-label fw-medium">Type of Use</label>
                <select name="type_of_use" id="new_bill_type_of_use_on_case" class="form-select form-select-sm" data-live-search="true">
                  <option value="-1">Select Type of Use</option>
                </select>
              </div>
              <div class="col-md-6">
                <label for="new_type_of_revenue_item_on_case" class="form-label fw-medium">Nature of Instrument</label>
                <select name="new_type_of_revenue_item_on_case" id="new_type_of_revenue_item_on_case" class="form-select form-select-sm" data-live-search="true">
                  <option value="-1">Select Nature of Interest</option>
                </select>
              </div>
            </div>

            <!-- Registration Forms -->
            <div class="row g-3 mt-2" id="oncasefreg-no-div" style="display: none;">
              <div class="col-md-6">
                <label for="new_bill_registration_forms_on_case" class="form-label fw-medium">Forms</label>
                <select name="new_bill_registration_forms_on_case" id="new_bill_registration_forms_on_case" class="form-select form-select-sm" data-live-search="true">
                  <option value="-1">Select Registration Forms</option>
                </select>
              </div>
            </div>

            <!-- Publication Type -->
            <div class="row g-3 mt-2" id="oncasefpublication-no-div" style="display: none;">
              <div class="col-md-6">
                <label for="new_bill_publication_type_on_case" class="form-label fw-medium">Publication Type</label>
                <select name="new_bill_publication_type_on_case" id="new_bill_publication_type_on_case" class="form-select form-select-sm">
                  <option value="normal_publication">Normal Publication</option>
                  <option value="special_publication">Special Publication</option>
                </select>
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
            <button type="button" class="btn btn-primary px-4" id="btn_save_to_generate_on_application">
              <i class="fas fa-arrow-right me-2"></i>Generate Bill
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="afterPaymentModalonCase" tabindex="-1" aria-labelledby="afterPaymentModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-gradient-primary text-white rounded-top-3">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-grow-1">
                        <h5 class="modal-title fw-semibold mb-0" id="afterPaymentModalLabel">
                            After Payment - Case Processing
                        </h5>
                        <small class="text-muted">Complete the post-payment workflow</small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Hidden Inputs -->
            <div class="d-none">
                <input type="hidden" id="txt_on_case_ap_main_service_id" name="txt_on_case_ap_main_service_id">
                <input type="hidden" id="txt_on_case_ap_main_service_sub_id" name="main_service_sub_id">
                <input type="hidden" id="txt_on_case_ap_jn_id" name="txt_on_case_ap_jn_id" value="jn_id">
                <input type="hidden" id="txt_on_case_ap_userid" name="txt_on_case_ap_userid" value="${userid}">
                <input type="hidden" id="txt_on_case_ap_user_fullname" name="user_fullname" value="${fullname}">
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-3">
                <!-- Summary Card -->
                <div class="card border-0 shadow-sm rounded-0 mb-3">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold"><i class="fas fa-info-circle me-2 text-primary"></i>Application Summary</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-medium text-muted">Ref Number</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-hashtag"></i></span>
                                    <input type="text" class="form-control bg-light" id="txt_on_case_ap_job_number" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium text-muted">Case Number</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-folder"></i></span>
                                    <input type="text" class="form-control bg-light" id="txt_on_case_ap_case_number" value="${case_number}" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium text-muted">Main Service</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-cog"></i></span>
                                    <input type="text" class="form-control bg-light" id="txt_on_case_ap_main_service_desc" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium text-muted">Sub Service</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-cogs"></i></span>
                                    <input type="text" class="form-control bg-light" id="txt_on_case_ap_main_service_sub_desc" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium text-muted">Client Name</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control bg-light" id="txt_on_case_ap_client_name" readonly>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium text-muted">Transaction Number</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-exchange-alt"></i></span>
                                    <input type="text" class="form-control bg-light" id="txt_on_case_ap_transaction_number" value="${transaction_number}" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Wizard Steps -->
                <div class="card border-0 shadow-sm rounded-0">
                    <div class="card-header bg-transparent border-bottom py-3">
                        <div class="wizard-steps-on-case">
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
                        <div class="step-content-on-case active" id="step-1-content-on-case">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0 fw-semibold"><i class="fas fa-clipboard-check me-2 text-warning"></i>Service Checklist</h6>
                                <span class="badge bg-primary">${main_service_desc}</span>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table table-hover table-bordered" id="tbl_on_case_ap_checklist_dataTable">
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
                        <div class="step-content-on-case" id="step-2-content-on-case">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0 fw-semibold"><i class="fas fa-money-bill-wave me-2 text-warning"></i>Bill & Payment Details</h6>
                                <button class="btn btn-warning" id="btnPrintEgcr2">
                                    <i class="fas fa-print me-2"></i>Print eGCR
                                </button>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table table-hover" id="tbl_on_case_ap_bills_payments_dataTable">
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
                        <div class="step-content-on-case" id="step-3-content-on-case">
                            <h6 class="mb-4 fw-semibold"><i class="fas fa-check-double me-2 text-warning"></i>Details Confirmation</h6>
                            
                            <!-- Client Information -->
                            <div class="card border-0 shadow-sm mb-4">
                                <div class="card-header bg-light py-3">
                                    <h6 class="mb-0 fw-semibold"><i class="fas fa-user me-2"></i>Client Information</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label fw-medium">Client Name</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                                <input type="text" class="form-control" id="txt_on_case_ap_ar_name" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Conditional Sections -->
                            <div id="additional-details-section">
                                <!-- Party Information (Conditional) -->
                                <div class="card border-0 shadow-sm mb-4" id="oncaseparty-no-div" style="display: none;">
                                    <div class="card-header bg-light py-3">
                                        <h6 class="mb-0 fw-semibold"><i class="fas fa-users me-2"></i>Party Information</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label fw-medium">Gender</label>
                                                <select name="txt_on_case_ap_ar_gender" id="txt_on_case_ap_bl_cbo_ar_gender" class="form-select">
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label fw-medium">Phone Number</label>
                                                <input type="text" class="form-control" id="txt_on_case_ap_ar_cell_phone" placeholder="Enter Phone Number">
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label fw-medium">ID Type</label>
                                                <select name="cbo_on_case_ap_ar_id_type" id="cbo_on_case_ap_ar_id_type" class="form-select">
                                                    <option value="National ID">National ID</option>
                                                    <option value="Drivers License">Drivers License</option>
                                                    <option value="NHIS">NHIS</option>
                                                    <option value="Passport">Passport</option>
                                                </select>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label fw-medium">ID Number</label>
                                                <input type="text" class="form-control" id="txt_on_case_ap_ar_id_number" placeholder="Enter ID Number">
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label fw-medium">Type of Party</label>
                                                <select name="cbo_on_case_ap_type_of_party" id="cbo_on_case_ap_type_of_party" class="form-select">
                                                    <option value="Applicant">Applicant</option>
                                                    <option value="Motgagor">Mortgagor</option>
                                                    <option value="Grantor">Grantor</option>
                                                    <option value="Objector">Objector</option>
                                                    <option value="Depositor">Depositor</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Plan Approval Details (Conditional) -->
                                <div class="card border-0 shadow-sm mb-4" id="oncasepaap-no-div" style="display: none;">
                                    <div class="card-header bg-light py-3">
                                        <h6 class="mb-0 fw-semibold"><i class="fas fa-map me-2"></i>Plan Approval Details</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label fw-medium">Land Size (Acres)</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-ruler-combined"></i></span>
                                                    <input type="text" class="form-control" id="txt_on_case_ap_land_size" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label fw-medium">Locality</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                                    <input type="text" class="form-control" id="new_ap_locality_oncase" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6" style="display: none;">
                                                <label class="form-label fw-medium">Surveyor's Name</label>
                                                <input type="text" class="form-control" id="new_ap_application_surveyors_name_oncase" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Registration Details (Conditional) -->
                                <div class="card border-0 shadow-sm mb-4" id="oncaseregap-no-div" style="display: none;">
                                    <div class="card-header bg-light py-3">
                                        <h6 class="mb-0 fw-semibold"><i class="fas fa-file-contract me-2"></i>Registration Details</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
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

                                <!-- Stamping Details (Conditional) -->
                                <div class="card border-0 shadow-sm mb-4" id="oncasestpap-no-div" style="display: none;">
                                    <div class="card-header bg-light py-3">
                                        <h6 class="mb-0 fw-semibold"><i class="fas fa-file-signature me-2"></i>Instrument Details</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label fw-medium">Nature of Instrument</label>
                                                <input type="text" class="form-control" id="txt_on_case_ap_type_of_instrument" readonly>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label fw-medium">Type of Use</label>
                                                <input type="text" class="form-control" id="txt_on_case_ap_type_of_use" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Step 4: File Upload -->
                        <div class="step-content-on-case" id="step-4-content-on-case">
                            <h6 class="mb-4 fw-semibold"><i class="fas fa-upload me-2 text-warning"></i>File Upload</h6>
                            
                            <div class="card border-dashed border-2">
                                <div class="card-body text-center p-5">
                                    <form method="POST" enctype="multipart/form-data" id="id_formatCSAU" class="needs-validation" novalidate>
                                        <div class="mb-3">
                                            <div class="file-upload-area border-dashed rounded p-4 text-center mb-3">
                                                <i class="fas fa-file-pdf fa-3x text-danger mb-3"></i>
                                                <h6 class="fw-semibold">Upload PDF Document</h6>
                                                <p class="text-muted small mb-3">Maximum file size: 10MB • Accepted format: PDF only</p>
                                                
                                                <input type="file" 
                                                    class="form-control d-none" 
                                                    id="fileUploadFormatCSAUonCase" 
                                                    name="fileUploadFormatCSAUonCase" 
                                                    accept="application/pdf"
                                                    required>
                                                
                                                <div class="d-flex flex-column align-items-center">
                                                    <button type="button" class="btn btn-outline-primary mb-3" id="btnSelectFileonCase">
                                                        <i class="fas fa-folder-open me-2"></i>Select PDF File
                                                    </button>
                                                    
                                                    <div class="file-info text-center" id="fileInfoonCase" style="display: none;">
                                                        <div class="d-flex align-items-center justify-content-center mb-2">
                                                            <i class="fas fa-file-pdf text-danger me-2"></i>
                                                            <span class="fw-medium" id="fileNameonCase"></span>
                                                        </div>
                                                        <div class="d-flex justify-content-center align-items-center">
                                                            <div class="file-size-badge bg-light rounded-pill px-3 py-1 me-3">
                                                                <i class="fas fa-weight-hanging me-1 text-muted"></i>
                                                                <span id="fileSizeonCase">0 KB</span>
                                                            </div>
                                                            <button type="button" class="btn btn-sm btn-outline-danger me-2" id="btnRemoveFileonCase">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                            <button type="button" class="btn btn-sm btn-outline-info" id="btnViewFileonCase">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                        </div>
                                                        <div class="progress mt-2" style="height: 4px; width: 200px; display: none;" id="fileSizeProgressonCase">
                                                            <div class="progress-bar" role="progressbar" style="width: 0%"></div>
                                                        </div>
                                                        <div class="alert alert-danger mt-2 py-1 px-3" id="sizeErroronCase" style="display: none;">
                                                            <i class="fas fa-exclamation-triangle me-1"></i>
                                                            <small>File exceeds 10MB limit</small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="invalid-feedback" id="fileValidationErroronCase">Please upload a valid PDF file (max 10MB).</div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Step 5: Acknowledgement -->
                        <div class="step-content-on-case" id="step-5-content-on-case">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0 fw-semibold"><i class="fas fa-file-alt me-2 text-warning"></i>Acknowledgement Slip</h6>
                                <button type="button" class="btn btn-primary" id="btn_on_case_ap_generate_acknowledgement">
                                    <i class="fas fa-download me-2"></i>Generate Acknowledgement
                                </button>
                            </div>
                            
                            <div class="card">
                                <div class="card-body p-2">
                                    <div class="embed-responsive embed-responsive-16by9">
                                        <iframe src="" id="oncaseakblobfile" class="embed-responsive-item" width="100%" height="500"></iframe>
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
                        <button type="button" class="btn btn-outline-primary me-2" id="btnPrevSteponCase">
                            <i class="fas fa-chevron-left me-2"></i>Previous
                        </button>
                        <button type="button" class="btn btn-primary" id="btnNextSteponCase">
                            Next Step <i class="fas fa-chevron-right ms-2"></i>
                        </button>
                        <button type="button" class="btn btn-success ms-2" id="btnCompleteProcessonCase" style="display: none;">
                            <i class="fas fa-check me-2"></i>Complete Process
                        </button>
                    </div>
                </div>
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
                              <option value="CORPORATE">CORPORATE</option>
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
               <button type="button" class="btn btn-outline-danger" id="remove_all_from_list">
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

<div class="modal fade effect-scale modal-blur" id="viewQueryModal" tabindex="-1" aria-labelledby="viewQueryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div>
                        <h5 class="modal-title text-white mb-0" id="viewQueryModalLabel">
                            <i class="bi bi-question-circle me-2"></i>Query Details
                        </h5>
                        <p class="mb-0 small opacity-75">Viewing query information</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <!-- Query Header Info -->
                <div class="row mb-4">
                    <div class="col-md-8">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-md bg-warning text-white rounded-circle me-3">
                                <i class="bi bi-file-text fs-20"></i>
                            </div>
                            <div>
                                <h6 class="mb-1" id="queryCaseTitle">
                                    <span id="queryCaseNumberDisplay"></span> - Query
                                </h6>
                                <p class="text-muted mb-0 small">
                                    <i class="bi bi-calendar me-1"></i>
                                    Created: <span id="queryCreatedDateDisplay"></span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 text-end">
                        <div class="d-flex flex-column align-items-end">
                            <span class="badge fs-6 px-3 py-2 mb-1" id="queryStatusBadge">
                                <i class="bi bi-circle-fill me-1"></i>
                                <span id="queryStatusText"></span>
                            </span>
                            <!-- <small class="text-muted">ID: <span id="queryIdDisplay"></span></small> -->
                        </div>
                    </div>
                </div>

                <!-- Query Content -->
                <div class="row">
                    <!-- Left Column - Query Details -->
                    <div class="col-lg-7">
                        <!-- General Reason Card -->
                        <div class="card border mb-4">
                            <div class="card-header bg-light">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="bi bi-exclamation-triangle me-2"></i>General Issue
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="bg-light rounded p-3">
                                    <p class="mb-0 text-dark" id="queryGeneralReasonDisplay"></p>
                                </div>
                            </div>
                        </div>

                        <!-- Query Details Card -->
                        <div class="card border mb-4">
                            <div class="card-header bg-light">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="bi bi-chat-left-text me-2"></i>Query Details
                                </h6>
                            </div>
                            <div class="card-body">
                                <!-- Reasons -->
                                <div class="mb-4">
                                    <label class="form-label small fw-medium text-muted mb-2">
                                        <i class="bi bi-chat-quote me-1"></i>Reasons for Applicant
                                    </label>
                                    <div class="bg-light rounded p-3">
                                        <p class="mb-0 text-dark" id="queryReasonsDisplay"></p>
                                    </div>
                                </div>

                                <!-- Remarks -->
                                <div class="mb-4">
                                    <label class="form-label small fw-medium text-muted mb-2">
                                        <i class="bi bi-lightbulb me-1"></i>Remarks & Recommendations
                                    </label>
                                    <div class="bg-light rounded p-3">
                                        <p class="mb-0 text-dark" id="queryRemarksDisplay"></p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card border mb-4">
                            <div class="card-header bg-light">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="bi bi-chat-square-quote me-2"></i>Query Response
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="bg-light rounded p-3">
                                    <p class="mb-0 text-dark" id="queryResponseDisplay"></p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column - Side Info -->
                    <div class="col-lg-5">
                        <!-- Quick Info Card -->
                        <div class="card border mb-4">
                            <div class="card-header bg-light">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="bi bi-info-circle me-2"></i>Quick Information
                                </h6>
                            </div>
                            <div class="card-body">
                                <!-- Job Number -->
                                <div class="mb-3">
                                    <label class="form-label small fw-medium text-muted mb-1">
                                        <i class="bi bi-briefcase me-1"></i>Job Number
                                    </label>
                                    <div class="input-group input-group-sm">
                                        <input type="text" class="form-control bg-light" 
                                               id="queryJobNumberDisplay" readonly>
                                        <button class="btn btn-outline-dark" type="button"
                                                onclick="copyToClipboard('queryJobNumberDisplay')">
                                            <i class="bi bi-clipboard"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Case Number -->
                                <div class="mb-3">
                                    <label class="form-label small fw-medium text-muted mb-1">
                                        <i class="bi bi-file-text me-1"></i>Case Number
                                    </label>
                                    <div class="input-group input-group-sm">
                                        <input type="text" class="form-control bg-light" 
                                               id="queryCaseNumberDisplay" readonly>
                                        <button class="btn btn-outline-dark" type="button"
                                                onclick="copyToClipboard('queryCaseNumberDisplay')">
                                            <i class="bi bi-clipboard"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Attachment Required -->
                                <div class="mb-3">
                                    <label class="form-label small fw-medium text-muted mb-1">
                                        <i class="bi bi-paperclip me-1"></i>Attachment Required
                                    </label>
                                    <div class="d-flex align-items-center">
                                        <div id="attachmentIcon" class="me-2"></div>
                                        <span id="attachmentText" class="fw-medium"></span>
                                    </div>
                                </div>

                                <!-- Audit Info -->
                                <div class="border-top pt-3 mt-3">
                                    <small class="text-muted d-block mb-1">
                                        <i class="bi bi-person-plus me-1"></i>
                                        Created by: <span id="queryCreatedByDisplay" class="fw-medium"></span>
                                    </small>
                                    <small class="text-muted d-block mb-1">
                                        <i class="bi bi-calendar-event me-1"></i>
                                        Created: <span id="queryCreatedDateDisplay2" class="fw-medium"></span>
                                    </small>
                                    <small class="text-muted d-block mb-1">
                                        <i class="bi bi-person-check me-1"></i>
                                        Modified by: <span id="queryModifiedByDisplay" class="fw-medium"></span>
                                    </small>
                                    <small class="text-muted d-block">
                                        <i class="bi bi-calendar2-event me-1"></i>
                                        Modified: <span id="queryModifiedDateDisplay" class="fw-medium"></span>
                                    </small>
                                </div>
                            </div>
                        </div>

                        <!-- Status Timeline -->
                        <div class="card border">
                            <div class="card-header bg-light">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="bi bi-clock-history me-2"></i>Status Timeline
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="timeline-simple">
                                    <!-- Created -->
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-primary"></div>
                                        <div class="timeline-content">
                                            <small class="d-block fw-medium">Query Created</small>
                                            <small class="text-muted" id="timelineCreated"></small>
                                        </div>
                                    </div>

                                    <!-- Modified (if exists) -->
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-info"></div>
                                        <div class="timeline-content">
                                            <small class="d-block fw-medium">Last Modified</small>
                                            <small class="text-muted" id="timelineModified"></small>
                                        </div>
                                    </div>

                                    <!-- Status -->
                                    <div class="timeline-item">
                                        <div class="timeline-marker" id="timelineStatusMarker"></div>
                                        <div class="timeline-content">
                                            <small class="d-block fw-medium">Current Status</small>
                                            <small class="text-muted" id="timelineStatus"></small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-1"></i>Close
                </button>
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
<div class="modal fade" id="applicationsModal" tabindex="-1" aria-labelledby="applicationsModalLabel" aria-hidden="true" data-bs-backdrop="static">
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
<div class="modal fade" id="viewresponseModal" tabindex="-1" aria-labelledby="viewresponseModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-primary text-white">
                <div>
                    <h5 class="modal-title text-white mb-1">
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

<div class="modal fade effect-scale modal-blur" id="addMinutesModal" tabindex="-1" aria-labelledby="addMinutesModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-primary text-white">
                <div>
                    <h5 class="modal-title text-white mb-0" id="addMinutesModalLabel">
                        <i class="bi bi-journal-text me-2"></i>Add Minutes
                    </h5>
                    <p class="mb-0 small opacity-75">Record minutes for case ${case_number}</p>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <form id="form_add_minutes" novalidate>
                    <input type="hidden" id="am_id" name="am_id" value="0">
                    
                    <!-- Two Column Layout -->
                    <div class="row g-4">
                        <!-- Left Column -->
                        <div class="col-lg-6">
                            <!-- Case Number -->
                            <div class="form-floating">
                                <input type="text" 
                                       class="form-control" 
                                       id="am_case_number" 
                                       name="am_case_number" 
                                       value="${case_number}" 
                                       readonly 
                                       placeholder="Case Number">
                                <label for="am_case_number" class="form-label">
                                    <i class="bi bi-file-text me-1"></i>Case Number
                                </label>
                            </div>
                            
                            <!-- Job Number -->
                            <div class="form-floating mt-3">
                                <input type="text" 
                                       class="form-control" 
                                       id="am_job_number" 
                                       name="am_job_number" 
                                       value="${job_number}" 
                                       readonly 
                                       placeholder="Job Number">
                                <label for="am_job_number" class="form-label">
                                    <i class="bi bi-briefcase me-1"></i>Job Number
                                </label>
                            </div>
                            
                            <!-- Description -->
                            <div class="mt-3">
                                <label for="am_description" class="form-label fw-medium">
                                    <i class="bi bi-chat-text me-1"></i>Description
                                    <span class="text-danger">*</span>
                                </label>
                                <textarea class="form-control" 
                                          id="am_description" 
                                          name="am_description" 
                                          rows="4" 
                                          placeholder="Enter minute details..."
                                          required></textarea>
                                <div class="invalid-feedback">
                                    Please enter a description for the minutes.
                                </div>
                                <div class="form-text">
                                    Provide detailed information about the minute entry
                                </div>
                            </div>
                        </div>
                        
                        <!-- Right Column -->
                        <div class="col-lg-6">
                            <!-- From Officer -->
                            <div class="form-floating">
                                <input type="text" 
                                       class="form-control" 
                                       id="am_from_officer" 
                                       name="am_from_officer" 
                                       value="${fullname}" 
                                       readonly 
                                       placeholder="From Officer">
                                <label for="am_from_officer" class="form-label">
                                    <i class="bi bi-person me-1"></i>From Officer
                                </label>
                            </div>
                            
                            <!-- To Officer -->
                            <div class="mt-3">
                                <label for="am_to_officer" class="form-label fw-medium">
                                    <i class="bi bi-person-plus me-1"></i>To Officer
                                    <span class="text-danger">*</span>
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-search"></i>
                                    </span>
                                    <input type="text" 
                                           class="form-control" 
                                           id="am_to_officer" 
                                           name="am_to_officer" 
                                           list="listofusers"
                                           placeholder="Search or select officer..."
                                           autocomplete="off"
                                           required>
                                    <datalist id="listofusers">
                                        <c:forEach items="${userlist}" var="user">
                                            <option data-value="${user.userid}" value="${user.fullname}"></option>
                                        </c:forEach>
                                    </datalist>
                                </div>
                                <div class="invalid-feedback">
                                    Please select an officer.
                                </div>
                                <div class="form-text">
                                    Type to search from available officers
                                </div>
                            </div>
                            
                            <!-- Additional Fields (Optional - you can add more if needed) -->
                            <div class="mt-4">
                                <div class="alert alert-light border">
                                    <h6 class="alert-heading mb-2">
                                        <i class="bi bi-info-circle me-1"></i>Information
                                    </h6>
                                    <p class="mb-0 small">
                                        Minutes will be recorded in the system and visible to assigned officers.
                                        Make sure all information is accurate before saving.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Modal Footer -->
                    <div class="modal-footer mt-4 pt-3 border-top">
                        <div class="d-flex justify-content-between w-100">
                            <button type="button" 
                                    class="btn btn-outline-secondary d-flex align-items-center gap-2" 
                                    data-bs-dismiss="modal">
                                <i class="bi bi-x-circle"></i>
                                Cancel
                            </button>
                            <div class="d-flex gap-2">
                                <button type="reset" 
                                        class="btn btn-outline-warning d-flex align-items-center gap-2"
                                        id="btn_reset_minutes">
                                    <i class="bi bi-arrow-clockwise"></i>
                                    Reset
                                </button>
                                <button type="submit" 
                                        class="btn btn-primary d-flex align-items-center gap-2" 
                                        id="btn_add_minutes">
                                    <i class="bi bi-save"></i>
                                    Save Minutes
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- View Minutes Modal -->
<div class="modal fade effect-scale modal-blur" id="viewMinutesModal" tabindex="-1" aria-labelledby="viewMinutesModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-primary text-white">
                <div>
                    <h5 class="modal-title text-white mb-0" id="viewMinutesModalLabel">
                        <i class="bi bi-journal-text me-2"></i>View Minute Details
                    </h5>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                
                <div class="d-flex align-items-center mb-3">
                    <div class="me-3">
                        <div class="avatar avatar-lg bg-primary text-white rounded-circle">
                            <i class="bi bi-journal-text fs-4"></i>
                        </div>
                    </div>
                    <div>
                        <h6 class="mb-1" id="minuteTitle">Minute Entry</h6>
                        <p class="text-muted mb-0 small">
                            <i class="bi bi-calendar-event me-1"></i>
                            Created on: <span id="minuteDate" class="fw-medium"></span>
                        </p>
                    </div>
                </div>
                
                <!-- Minute Description -->
                <div class="border-start border-3 border-primary ps-3 py-2 mb-4">
                    <h6 class="text-muted mb-2">
                        <i class="bi bi-chat-square-text me-1"></i>Description
                    </h6>
                    <p class="mb-0" id="minuteDescription"></p>
                </div>
                
                <!-- Minute Participants -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <div class="card h-100">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted small">
                                    <i class="bi bi-person-up me-1"></i>From Officer
                                </h6>
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-sm bg-primary text-white rounded-circle me-2">
                                        <i class="bi bi-person"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0" id="minuteFromOfficer"></h6>
                                        <small class="text-muted">Sender</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="card h-100">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted small">
                                    <i class="bi bi-person-down me-1"></i>To Officer
                                </h6>
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-sm bg-success text-white rounded-circle me-2">
                                        <i class="bi bi-person"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0" id="minuteToOfficer"></h6>
                                        <small class="text-muted">Recipient</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-1"></i> Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="generateEGCRModal" tabindex="-1" aria-labelledby="generateEGCRModalLabel" aria-hidden="true" data-bs-backdrop="static">
	<div class="modal-dialog modal-lg modal-dialog-centered">
	  <div class="modal-content">
		<div class="modal-header">
		  <h5 class="modal-title" id="pdfPreviewModalLabel">EGCR Receipt</h5>
		  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
		<div class="modal-body">
		  <div class="preview-container" style="height: 800px;">
			<!-- PDF will be shown here -->
			<iframe src="" id="egcrblobinnerfile" width="100%" height="100%"></iframe>
		  </div>
		</div>
		<div class="modal-footer">
		  <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
			<i class="bi bi-x-circle me-1"></i> Close
		  </button>
		</div>
	  </div>
	</div>
  </div>

  <!-- Upload Public Document Modal -->
<div class="modal fade effect-scale modal-blur" id="publicFileUploadModal" tabindex="-1" aria-labelledby="publicFileUploadModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center">
                    <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
                        <i class="bi bi-cloud-upload fs-4"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white mb-1" id="publicFileUploadModalLabel">
                            Upload Public Document
                        </h5>
                        <p class="mb-0 small opacity-75">
                            <i class="bi bi-info-circle me-1"></i>
                            Upload documents accessible to authorized users
                        </p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- Upload Progress Indicator -->
                <div id="uploadProgress" class="d-none mb-4">
                    <div class="d-flex align-items-center mb-2">
                        <div class="spinner-border spinner-border-sm text-primary me-2" role="status">
                            <span class="visually-hidden">Uploading...</span>
                        </div>
                        <div class="flex-grow-1">
                            <small class="text-muted" id="uploadStatus">Uploading document...</small>
                            <div class="progress" style="height: 4px;">
                                <div class="progress-bar progress-bar-striped progress-bar-animated" 
                                     id="uploadProgressBar" style="width: 0%"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Document Type Selection -->
                <div class="mb-4">
                    <label for="file_type_pu" class="form-label fw-semibold">
                        <i class="bi bi-file-earmark-text me-1"></i>
                        Document Type
                        <span class="text-danger">*</span>
                    </label>
                    <select name="file_name_pu" data-trigger id="file_type_pu" class="form-select" required>
                        <option value="" selected disabled>-- Select document type --</option>
                        <optgroup label="Personal Documents">
                            <option value="Birth Certificate">Birth Certificate</option>
                            <option value="Identification Card">Identification Card</option>
                            <option value="Statutory Declaration">Statutory Declaration</option>
                        </optgroup>
                        <optgroup label="Legal Documents">
                            <option value="Acknowledge Slip">Acknowledge Slip</option>
                            <option value="Consent Letter">Consent Letter</option>
                            <option value="Headlease">Headlease</option>
                            <option value="Indenture">Indenture</option>
                            <option value="Plotted Indenture">Plotted Indenture</option>
                            <option value="Power of Attorney">Power of Attorney</option>
                            <option value="Letters of Administration">Letters of Administration</option>
                            <option value="Judgement">Judgement</option>
                        </optgroup>
                        <optgroup label="Company Documents">
                            <option value="Company Certificate">Company Certificate</option>
                        </optgroup>
                        <optgroup label="Property Documents">
                            <option value="Site Plan">Site Plan</option>
                            <option value="Hatched Site Plan">Hatched Site Plan</option>
                        </optgroup>
                        <optgroup label="Financial Documents">
                            <option value="Receipts">Receipts</option>
                        </optgroup>
                        <optgroup label="Other Documents">
                            <option value="Others">Other Documents</option>
                        </optgroup>
                    </select>
                    <div class="form-text">
                        <i class="bi bi-info-circle me-1"></i>
                        Select the type of document you are uploading
                    </div>
                </div>

                <!-- File Upload Area -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <label class="form-label fw-semibold">
                            <i class="bi bi-paperclip me-1"></i>
                            Document File(s)
                            <span class="text-danger">*</span>
                        </label>
                        <button type="button" class="btn btn-sm btn-outline-primary" id="addFile">
                            <i class="bi bi-plus-circle me-1"></i>Add More Files
                        </button>
                    </div>
                    
                    <!-- File Upload Container -->
                    <div class="file-upload-container" id="fileContainer">
                        <!-- Initial File Upload -->
                        <div class="file-upload-card mb-3">
                            <div class="card border">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar avatar-md bg-light rounded-circle me-3">
                                            <i class="bi bi-file-earmark-arrow-up text-primary"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-1 fw-semibold">Select Document</h6>
                                            <p class="text-muted small mb-2">Supported formats: PDF, DOC, DOCX, JPG, PNG (Max 10MB)</p>
                                            <div class="input-group">
                                                <input type="file" 
                                                       class="form-control file-input" 
                                                       name="samplePublicFile"
                                                       accept=".pdf,.doc,.docx,.jpg,.jpeg,.png"
                                                       data-max-size="10">
                                                <button class="btn btn-outline-secondary preview-btn" type="button" disabled>
                                                    <i class="bi bi-eye"></i> Preview
                                                </button>
                                            </div>
                                        </div>
                                        <button class="btn btn-sm btn-outline-danger remove-file-btn ms-2 mt-5 d-none">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                    
                                    <!-- File Info -->
                                    <div class="file-info mt-2 d-none">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted">
                                                <span class="file-name"></span>
                                                (<span class="file-size"></span>)
                                            </small>
                                            <span class="badge bg-success file-status">
                                                <i class="bi bi-check-circle me-1"></i>Ready
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Case Information -->
                <div class="card border mb-4">
                    <div class="card-header bg-light">
                        <h6 class="mb-0 fw-semibold">
                            <i class="bi bi-info-circle me-2"></i>Case Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-medium text-muted mb-1">
                                    <i class="bi bi-file-text me-1"></i>Case Number
                                </label>
                                <div class="input-group">
                                    <input type="text" 
                                           class="form-control bg-light" 
                                           id="public_file_upload_case_number" 
                                           value="${case_number}" 
                                           readonly>
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="copyToClipboard('public_file_upload_case_number')">
                                        <i class="bi bi-clipboard"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-medium text-muted mb-1">
                                    <i class="bi bi-person me-1"></i>Applicant Name
                                </label>
                                <input type="text" 
                                       class="form-control bg-light" 
                                       value="${ar_name}" 
                                       readonly>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Upload Button -->
                <div class="text-center">
                    <button type="button" 
                            id="btn_upload_public_case_file" 
                            class="btn btn-primary btn-lg px-5"
                            disabled>
                        <i class="bi bi-cloud-upload me-2"></i>
                        Upload Public Document
                        <span class="spinner-border spinner-border-sm ms-2 d-none" id="uploadSpinner" role="status"></span>
                    </button>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100">
                    <div>
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i>Cancel
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-info" id="btnClearForm">
                            <i class="bi bi-arrow-clockwise me-1"></i>Clear Form
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Preview Modal -->
<div class="modal fade effect-scale modal-blur" id="previewModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Document Preview</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="text-center py-5" id="previewLoading">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading preview...</span>
                    </div>
                    <p class="mt-3 text-muted">Loading document preview...</p>
                </div>
                <div id="previewContent" class="d-none"></div>
                <div class="text-center py-5 d-none" id="previewError">
                    <i class="bi bi-file-earmark-x display-4 text-danger mb-3"></i>
                    <h6 class="text-danger mb-2">Preview Not Available</h6>
                    <p class="text-muted">This file type cannot be previewed in the browser.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="fileUploadModal" tabindex="-1" aria-labelledby="fileUploadModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center">
                    <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
                        <i class="bi bi-cloud-upload fs-4"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white mb-1" id="fileUploadModalLabel">
                            Upload Application Document
                        </h5>
                        <p class="mb-0 small opacity-75">
                            <i class="bi bi-info-circle me-1"></i>
                            Upload documents accessible to authorized users
                        </p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- Upload Progress Indicator -->
                <div id="fileUploadProgress" class="d-none mb-4">
                    <div class="d-flex align-items-center mb-2">
                        <div class="spinner-border spinner-border-sm text-primary me-2" role="status">
                            <span class="visually-hidden">Uploading...</span>
                        </div>
                        <div class="flex-grow-1">
                            <small class="text-muted" id="fileUploadStatus">Uploading document...</small>
                            <div class="progress" style="height: 4px;">
                                <div class="progress-bar progress-bar-striped progress-bar-animated" 
                                     id="fileUploadProgressBar" style="width: 0%"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Document Type Selection -->
                <div class="mb-4">
                    <label for="file_type_au" class="form-label fw-semibold">
                        <i class="bi bi-file-earmark-text me-1"></i>
                        Document Type
                        <span class="text-danger">*</span>
                    </label>
                    <select name="file_type_au" data-trigger id="file_type_au" class="form-select" required>
                        <option value="" selected disabled>-- Select document type --</option>
                        <optgroup label="Personal Documents">
                            <option value="Birth Certificate">Birth Certificate</option>
                            <option value="Identification Card">Identification Card</option>
                            <option value="Statutory Declaration">Statutory Declaration</option>
                        </optgroup>
                        <optgroup label="Legal Documents">
                            <option value="Acknowledge Slip">Acknowledge Slip</option>
                            <option value="Consent Letter">Consent Letter</option>
                            <option value="Headlease">Headlease</option>
                            <option value="Indenture">Indenture</option>
                            <option value="Plotted Indenture">Plotted Indenture</option>
                            <option value="Power of Attorney">Power of Attorney</option>
                            <option value="Letters of Administration">Letters of Administration</option>
                            <option value="Judgement">Judgement</option>
                        </optgroup>
                        <optgroup label="Company Documents">
                            <option value="Company Certificate">Company Certificate</option>
                        </optgroup>
                        <optgroup label="Property Documents">
                            <option value="Site Plan">Site Plan</option>
                            <option value="Hatched Site Plan">Hatched Site Plan</option>
                        </optgroup>
                        <optgroup label="Financial Documents">
                            <option value="Receipts">Receipts</option>
                        </optgroup>
                        <optgroup label="Other Documents">
                            <option value="Others">Other Documents</option>
                        </optgroup>
                    </select>
                    <div class="form-text">
                        <i class="bi bi-info-circle me-1"></i>
                        Select the type of document you are uploading
                    </div>
                </div>

                <!-- File Upload Area -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <label class="form-label fw-semibold">
                            <i class="bi bi-paperclip me-1"></i>
                            Document File(s)
                            <span class="text-danger">*</span>
                        </label>
                        <button type="button" class="btn btn-sm btn-outline-primary" id="apAddFile">
                            <i class="bi bi-plus-circle me-1"></i>Add More Files
                        </button>
                    </div>
                    
                    <!-- File Upload Container -->
                    <div class="file-upload-container" id="apFileContainer">
                        <!-- Initial File Upload -->
                        <div class="file-upload-card mb-3">
                            <div class="card border">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar avatar-md bg-light rounded-circle me-3">
                                            <i class="bi bi-file-earmark-arrow-up text-primary"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-1 fw-semibold">Select Document</h6>
                                            <p class="text-muted small mb-2">Supported formats: PDF, DOC, DOCX, JPG, PNG (Max 10MB)</p>
                                            <div class="input-group">
                                                <input type="file" 
                                                       class="form-control file-input" 
                                                       name="sampleApplicationFile"
                                                       accept=".pdf,.doc,.docx,.jpg,.jpeg,.png"
                                                       data-max-size="10">
                                                <button class="btn btn-outline-secondary preview-btn" type="button" disabled>
                                                    <i class="bi bi-eye"></i> Preview
                                                </button>
                                            </div>
                                        </div>
                                        <button class="btn btn-sm btn-outline-danger remove-file-btn ms-2 mt-5 d-none">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                    
                                    <!-- File Info -->
                                    <div class="file-info mt-2 d-none">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted">
                                                <span class="file-name"></span>
                                                (<span class="file-size"></span>)
                                            </small>
                                            <span class="badge bg-success file-status">
                                                <i class="bi bi-check-circle me-1"></i>Ready
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Case Information -->
                <div class="card border mb-4">
                    <div class="card-header bg-light">
                        <h6 class="mb-0 fw-semibold">
                            <i class="bi bi-info-circle me-2"></i>Case Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-medium text-muted mb-1">
                                    <i class="bi bi-file-text me-1"></i>Case Number
                                </label>
                                <div class="input-group">
                                    <input type="text" 
                                           class="form-control bg-light" 
                                           id="application_file_upload_case_number" 
                                           value="${case_number}" 
                                           readonly>
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="copyToClipboard('application_file_upload_case_number')">
                                        <i class="bi bi-clipboard"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-medium text-muted mb-1">
                                    <i class="bi bi-person me-1"></i>Applicant Name
                                </label>
                                <input type="text" 
                                       class="form-control bg-light" 
                                       value="${ar_name}" 
                                       readonly>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Upload Button -->
                <div class="text-center">
                    <button type="button" 
                            id="btn_upload_application_case_file" 
                            class="btn btn-primary btn-lg px-5"
                            disabled>
                        <i class="bi bi-cloud-upload me-2"></i>
                        Upload Application Document
                        <span class="spinner-border spinner-border-sm ms-2 d-none" id="apUploadSpinner" role="status"></span>
                    </button>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100">
                    <div>
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i>Cancel
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-info" id="apBtnClearForm">
                            <i class="bi bi-arrow-clockwise me-1"></i>Clear Form
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Past due application modal Section============================= -->
<div class="modal fade effect-scale modal-blur" id="appsPassedDueModal" tabindex="-1" aria-labelledby="appsPassedDueModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-xl">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-danger text-light">
        <h5 class="modal-title" id="appsPassedDueModalLabel">Applications Passed Due Dates</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table id="report_dashboard_apps_past_due_date_by_user_table" class="table table-striped table-hover" style="width: 100%">
          <thead>
            <tr>
              <th>Job Number</th>
              <th>Application Type</th>
              <th>Applicant Name</th>
              <th>Date Received</th>
              <!-- <th>Action</th> -->
            </tr>
          </thead>
          <tbody>
            <!-- Data will be loaded here -->
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
            <i class="bi bi-x-circle me-1"></i>Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="batchedApplicationsModal" tabindex="-1" aria-labelledby="batchedApplicationsModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-xl">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-info text-light">
        <h5 class="modal-title" id="batchedApplicationsModalLabel">Batched Applications</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table id="report_dashboard_batched_apps_by_user_table" class="table table-striped table-hover" style="width: 100%">
          <thead>
            <tr>
              <th>Job Number</th>
              <th>Application Type</th>
              <th>Applicant Name</th>
              <th>Date Received</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <!-- Data will be loaded here -->
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
            <i class="bi bi-x-circle me-1"></i>Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="appsReceivedMonthModal" tabindex="-1" aria-labelledby="appsReceivedMonthModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-xl">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-warning text-light">
        <h5 class="modal-title" id="appsReceivedMonthModalLabel">Applications Received This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table id="report_dashboard_apps_rec_month_by_user_table" class="table table-striped table-hover" style="width: 100%">
          <thead>
            <tr>
              <th>Job Number</th>
              <th>Application Type</th>
              <th>Applicant Name</th>
              <th>Date Received</th>
              <th>Sent By</th>
            </tr>
          </thead>
          <tbody>
            <!-- Data will be loaded here -->
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
            <i class="bi bi-x-circle me-1"></i>Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="appsCompletedMonthModal" tabindex="-1" aria-labelledby="appsCompletedMonthModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-xl">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-primary text-light">
        <h5 class="modal-title text-white" id="appsCompletedMonthModalLabel">Applications Completed This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table id="report_dashboard_apps_comp_month_by_user_table" class="table table-striped table-hover" style="width: 100%">
          <thead>
            <tr>
              <th>Job Number</th>
              <th>Application Type</th>
              <th>Applicant Name</th>
              <th>Date Completed</th>
            </tr>
          </thead>
          <tbody>
            <!-- Data will be loaded here -->
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
            <i class="bi bi-x-circle me-1"></i>Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="linkaccounttoJobsModal" tabindex="-1" aria-labelledby="linkAccountModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-gradient-primary text-white rounded-top">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-grow-1">
                        <h5 class="modal-title fw-semibold mb-0" id="linkAccountModalLabel">
                            <i class="fas fa-link me-2"></i>Link Job to Account
                        </h5>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <form method="post" class="needs-validation" novalidate>
                    <!-- Account Details Section -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-light py-3">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-user-circle me-2 text-primary"></i>Account Details</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="lja_applicant_name" class="form-label fw-medium">Applicant Name <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" class="form-control" id="lja_applicant_name" placeholder="Enter applicant name" required>
                                        <div class="invalid-feedback">
                                            Please enter applicant name.
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="lja_applicant_id" class="form-label fw-medium">Applicant E-mail/Phone <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                        <input type="text" class="form-control" id="lja_applicant_id" placeholder="Enter email or phone number" required>
                                        <div class="invalid-feedback">
                                            Please enter applicant email or phone number.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Job Details Section -->
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-light py-3">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-briefcase me-2 text-success"></i>Job Details</h6>
                        </div>
                        <div class="card-body">
                            <!-- Job Search -->
                            <div class="row g-3 mb-4">
                                <div class="col-md-8">
                                    <label for="lja_job_number" class="form-label fw-medium">Job Number</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                                        <input type="text" class="form-control" id="lja_job_number" placeholder="Enter job number">
                                    </div>
                                </div>
                                <div class="col-md-4 d-flex align-items-end">
                                    <button type="button" id="btn_lja_search_for_job_number_details" class="btn btn-primary w-100">
                                        <i class="fas fa-search me-2"></i>Search Job
                                    </button>
                                </div>
                            </div>

                            <!-- Job Results -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="lja_job_number_result" class="form-label fw-medium">Job Number</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                        <input type="text" class="form-control bg-light" id="lja_job_number_result" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="lja_case_number" class="form-label fw-medium">Case Number</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-folder"></i></span>
                                        <input type="text" class="form-control bg-light" id="lja_case_number" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="lja_transaction_number" class="form-label fw-medium">Transaction Number</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-exchange-alt"></i></span>
                                        <input type="text" class="form-control bg-light" id="lja_transaction_number" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="lja_ar_name" class="form-label fw-medium">Transaction Applicant Name</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user-check"></i></span>
                                        <input type="text" class="form-control bg-light" id="lja_ar_name" readonly>
                                    </div>
                                </div>
                            </div>

                            <!-- Validation Status -->
                            <div class="alert alert-info mt-4 d-none" id="jobValidationStatus">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-info-circle me-3"></i>
                                    <div>
                                        <small class="fw-medium">Job details loaded successfully</small>
                                        <p class="mb-0 small">Please verify the information before linking.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
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
                        <button type="button" id="btn_save_link_job_to_account" class="btn btn-primary px-4">
                            <i class="fas fa-link me-2"></i>Link Job
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="generateTransitionalBillModal" tabindex="-1" aria-labelledby="transitionalBillModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-gradient-primary text-white rounded-top">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-grow-1">
                        <h5 class="modal-title fw-semibold mb-0" id="transitionalBillModalLabel">
                            <i class="fas fa-file-invoice-dollar me-2"></i>Generate Transitional Bill
                        </h5>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <form method="post" class="needs-validation" novalidate>
                    <!-- Job & Case Details -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-light py-3">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-file-alt me-2 text-primary"></i>Application Details</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="tb_job_number" class="form-label fw-medium">Job Number <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                        <input type="text" class="form-control bg-light" id="tb_job_number" placeholder="Enter job number" readonly required>
                                        <div class="invalid-feedback">
                                            Please enter job number.
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="tb_case_number" class="form-label fw-medium">Case Number <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-folder"></i></span>
                                        <input type="text" class="form-control bg-light" id="tb_case_number" placeholder="Enter case number" readonly required>
                                        <div class="invalid-feedback">
                                            Please enter case number.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Applicant & Bill Type -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-light py-3">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-user-tie me-2 text-success"></i>Applicant & Bill Information</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="tb_applicant_name" class="form-label fw-medium">Applicant Name</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" class="form-control" id="tb_applicant_name" placeholder="Enter applicant name">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="tb_bill_type" class="form-label fw-medium">Bill Type <span class="text-danger">*</span></label>
                                    <select class="form-select" data-trigger id="tb_bill_type" name="tb_bill_type" required>
                                        <option value="" selected disabled>Select Bill Type</option>
                                        <option value="Supplementary Lodgement">Supplementary Lodgement</option>
                                        <option value="Normal Publication">Normal Publication</option>
                                        <option value="Special Publication">Special Publication</option>
                                        <option value="Official Cadastral Plan Preparation">Official Cadastral Plan Preparation</option>
                                        <option value="Title Search (Registration)">Title Search (Registration)</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a bill type.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bill Amount & Client Details -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-light py-3">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-money-bill-wave me-2 text-warning"></i>Bill Amount & Client Details</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="tb_bill_amount" class="form-label fw-medium">Bill Amount <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
                                        <input type="text" class="form-control" id="tb_bill_amount" name="tb_bill_amount" placeholder="0.00" required>
                                        <div class="invalid-feedback">
                                            Please enter bill amount.
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="tb_created_for_id" class="form-label fw-medium">Client E-mail/Phone <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                        <input type="text" class="form-control" id="tb_created_for_id" name="tb_created_for_id" placeholder="Enter email or phone" required>
                                        <div class="invalid-feedback">
                                            Please enter client email or phone.
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 d-flex align-items-end">
                                    <button type="button" id="btn_generate_transitional_bill" class="btn btn-primary w-100">
                                        <i class="fas fa-file-invoice me-2"></i>Generate Bill
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bill Preview -->
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-light py-3 d-flex justify-content-between align-items-center">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-file-pdf me-2 text-danger"></i>Bill Preview</h6>
                            <small class="text-muted">PDF will appear here after generation</small>
                        </div>
                        <div class="card-body p-0">
                            <div class="embed-responsive embed-responsive-16by9">
                                <iframe src="" id="transitionalbillblobfile" class="embed-responsive-item" width="100%" height="300"></iframe>
                            </div>
                            <div class="card-footer bg-light">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle me-1"></i>
                                    The generated bill will appear in the preview area above.
                                </small>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light rounded-bottom p-3">
                <!-- <div class="d-flex justify-content-between w-100">
                    <div>
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-secondary" id="btnClearForm">
                            <i class="fas fa-redo me-2"></i>Clear Form
                        </button>
                    </div>
                </div> -->
                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="generateManualBillModal" tabindex="-1" aria-labelledby="manualBillModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-gradient-primary text-white rounded-top">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-grow-1">
                        <h5 class="modal-title fw-semibold mb-0" id="manualBillModalLabel">
                            <i class="fas fa-file-invoice me-2"></i>Generate Manual Bill
                        </h5>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <form method="post" id="generateManualBillModalForm" class="needs-validation" novalidate>
                    <!-- Client Information -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-light py-3">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-user-circle me-2 text-primary"></i>Client Information</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="new_bill_application_client_name_mb" class="form-label fw-medium">Client Name <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" class="form-control" id="new_bill_application_client_name_mb" name="new_bill_application_client_name_mb" placeholder="Enter Client Name" required readonly>
                                        <div class="invalid-feedback">
                                            Please enter client name.
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="new_bill_application_client_id_mb" class="form-label fw-medium">Client Reference <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                        <input type="text" class="form-control" id="new_bill_application_client_id_mb" name="new_bill_application_client_id_mb" placeholder="Enter Client email/phone" required readonly>
                                        <div class="invalid-feedback">
                                            Please enter client reference.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Service Selection -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-light py-3">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-cog me-2 text-success"></i>Service Selection</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="mbm_main_service_cp" class="form-label fw-medium">Service Type <span class="text-danger">*</span></label>
                                    <select name="mbm_main_service_cp" id="mbm_main_service_cp" class="form-select form-select-sm" data-live-search="true" required>
                                        <option value="" selected disabled>Select Main Service</option>
                                        <c:forEach items="${main_services}" var="main_service">
                                            <c:if test="${main_service.business_process_on_case == 'No'}"> 
                                                <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option> 
                                            </c:if>  
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a service type.
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="mbm_sub_service_cp" class="form-label fw-medium">Sub Service</label>
                                    <select name="mbm_sub_service_cp" id="mbm_sub_service_cp" class="form-select form-select-sm">
                                        <option value="" selected disabled>Select Sub Service</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bill Details -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-light py-3">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-money-bill-wave me-2 text-warning"></i>Bill Details</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="mbm_bill_amount" class="form-label fw-medium">Bill Amount <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
                                        <input type="text" class="form-control" id="mbm_bill_amount" name="mbm_bill_amount" placeholder="0.00" required>
                                        <div class="invalid-feedback">
                                            Please enter a valid bill amount.
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="mbm_bill_description" class="form-label fw-medium">Description</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-align-left"></i></span>
                                        <input type="text" class="form-control" id="mbm_bill_description" name="mbm_bill_description" placeholder="Enter bill description">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Generate Button -->
                            <div class="row g-3 mt-3">
                                <div class="col-12">
                                    <button type="button" id="btn_generate_manual_bill" class="btn btn-primary w-100 py-3">
                                        <i class="fas fa-file-invoice me-2"></i>Generate Manual Bill
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bill Preview -->
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-light py-3 d-flex justify-content-between align-items-center">
                            <h6 class="mb-0 fw-semibold"><i class="fas fa-file-pdf me-2 text-danger"></i>Bill Preview</h6>
                            <small class="text-muted">PDF will appear here after generation</small>
                        </div>
                        <div class="card-body p-0">
                            <div class="embed-responsive embed-responsive-16by9">
                                <iframe src="" id="manualbillblobfile" class="embed-responsive-item" width="100%" height="300"></iframe>
                            </div>
                            <div class="card-footer bg-light">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle me-1"></i>
                                    The generated bill will appear in the preview area above.
                                </small>
                            </div>
                        </div>
                    </div>
                </form>
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
                        <button type="button" class="btn btn-outline-secondary" id="btnClearManualBillForm">
                            <i class="fas fa-redo me-2"></i>Clear Form
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="cabinetModal" tabindex="-1" aria-labelledby="cabinetModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header rounded-top">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-grow-1">
                        <h5 class="modal-title fw-semibold mb-0" id="cabinetModalLabel">
                            <i class="fas fa-history me-2"></i>Application Tracking History
                        </h5>
                        <small class="opacity-75">View complete application tracking and cabinet details</small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <div class="row g-4">
                    <!-- Left Column: Tracking History -->
                    <div class="col-lg-8">
                        <div class="card border-0 shadow">
                            <div class="card-header bg-light py-3 d-flex justify-content-between align-items-center">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-stream me-2 text-primary"></i>Tracking History
                                </h6>
                                <span class="badge bg-primary" id="historyCount">0 entries</span>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-comment me-2"></i>Comments
                                                </th>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-building me-2"></i>Division/Unit
                                                </th>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-user-tie me-2"></i>Officer
                                                </th>
                                                <th class="py-3 px-4 fw-medium">
                                                    <i class="fas fa-calendar me-2"></i>Date
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="cabinet-tracking">
                                            <!-- Tracking data will be populated here -->
                                            <tr id="noTrackingData" class="d-none">
                                                <td colspan="4" class="text-center py-5">
                                                    <div class="d-flex flex-column align-items-center">
                                                        <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                                        <h6 class="fw-semibold mb-2">No tracking history found</h6>
                                                        <p class="text-muted small">No tracking entries available for this application</p>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer bg-light py-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="text-muted small">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Shows all tracking activities for this application
                                    </div>
                                    <!-- <button type="button" class="btn btn-sm btn-outline-primary" id="btnExportHistory">
                                        <i class="fas fa-download me-2"></i>Export
                                    </button> -->
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Application Details -->
                    <div class="col-lg-4">
                        <div class="card border-0 shadow">
                            <div class="card-header bg-light py-3">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-info-circle me-2 text-success"></i>Application Details
                                </h6>
                            </div>
                            <div class="card-body">
                                <form id="cabinetDetailsForm">
                                    <!-- Applicant Information Section -->
                                    <div class="mb-4">
                                        <h6 class="fw-semibold mb-3 text-primary">
                                            <i class="fas fa-user-circle me-2"></i>Applicant Information
                                        </h6>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="enq_applicant_name" class="form-label fw-medium">
                                                    Applicant Name
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-user"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_applicant_name" rows="2"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="enq_applicant_type" class="form-label fw-medium">
                                                    Application Type
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-file-alt"></i>
                                                    </span>
                                                    <input type="text" readonly class="form-control bg-light" 
                                                           id="enq_applicant_type">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Cabinet Information Section -->
                                    <div class="mb-4">
                                        <h6 class="fw-semibold mb-3 text-success">
                                            <i class="fas fa-archive me-2"></i>Cabinet Information
                                        </h6>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="enq_cabinet_name" class="form-label fw-medium">
                                                    Cabinet/File Reference
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-hashtag"></i>
                                                    </span>
                                                    <input type="text" readonly class="form-control bg-light" 
                                                           id="enq_cabinet_name">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Status Information Section -->
                                    <div class="mb-4">
                                        <h6 class="fw-semibold mb-3 text-warning">
                                            <i class="fas fa-tasks me-2"></i>Status Information
                                        </h6>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="enq_job_purpose" class="form-label fw-medium">
                                                    Job Purpose
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-bullseye"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_job_purpose" rows="3"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="enq_job_status" class="form-label fw-medium">
                                                    Job Status
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-spinner"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_job_status" rows="3"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="enq_current_application_status" class="form-label fw-medium">
                                                    Current Application Status
                                                </label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-flag"></i>
                                                    </span>
                                                    <textarea readonly class="form-control bg-light" 
                                                              id="enq_current_application_status" rows="3"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Quick Stats -->
                                    <div class="card border-dashed border-2 mt-4">
                                        <div class="card-body p-3">
                                            <h6 class="fw-semibold mb-3">
                                                <i class="fas fa-chart-bar me-2"></i>Quick Stats
                                            </h6>
                                            <div class="row g-2">
                                                <div class="col-6">
                                                    <div class="d-flex flex-column align-items-center p-2 bg-light rounded">
                                                        <span class="text-muted small">Tracking Entries</span>
                                                        <small class="fw-bold" id="trackingEntriesCount">0</small>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="d-flex flex-column align-items-center p-2 bg-light rounded">
                                                        <span class="text-muted small">Last Update</span>
                                                        <small class="fw-bold" id="lastUpdateDate">-</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="card-footer bg-light py-3">
                                <div class="text-muted small">
                                    <i class="fas fa-clock me-1"></i>
                                    Last refreshed: <span id="lastRefreshTime">-</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light rounded-bottom p-3">
                <!-- <div class="d-flex justify-content-between w-100">
                    <div>
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-primary me-2" id="btnRefreshCabinet">
                            <i class="fas fa-sync-alt me-2"></i>Refresh
                        </button>
                        <button type="button" class="btn btn-primary" id="btnPrintHistory">
                            <i class="fas fa-print me-2"></i>Print History
                        </button>
                    </div>
                </div> -->
                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade effect-scale modal-blur" id="collectionForPayment" tabindex="-1" aria-labelledby="collectionForPaymentLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="collectionForPaymentLabel">
                    <i class="fas fa-money-bill-wave me-2"></i>Collection for Payment
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <form id="frmCollectionForPayment">
                    <div class="row g-3">
                        <!-- Job Number -->
                        <div class="col-md-6">
                            <label for="cfp_job_number" class="form-label fw-bold">
                                <i class="fas fa-file-alt me-1"></i>Job Number
                            </label>
                            <input type="text" class="form-control bg-light" id="cfp_job_number" readonly style="cursor: not-allowed;">
                        </div>
                        
                        <!-- Applicant Name -->
                        <div class="col-md-6">
                            <label for="cfp_ar_name" class="form-label fw-bold">
                                <i class="fas fa-user me-1"></i>Applicant Name
                            </label>
                            <input type="text" class="form-control bg-light" id="cfp_ar_name" readonly style="cursor: not-allowed;">>
                        </div>
                        
                        <!-- Collector's Name -->
                        <div class="col-md-6">
                            <label for="cfp_collectors_name" class="form-label fw-bold">
                                <i class="fas fa-user-tie me-1"></i>Collector's Name
                                <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" id="cfp_collectors_name" required>
                            <div class="invalid-feedback">
                                Please enter collector's name
                            </div>
                        </div>
                        
                        <!-- ID Type -->
                        <div class="col-md-6">
                            <label for="cfp_id_type" class="form-label fw-bold">
                                <i class="fas fa-id-card me-1"></i>ID Type
                                <span class="text-danger">*</span>
                            </label>
                            <select class="form-select" id="cfp_id_type" name="cfp_id_type" required>
                                <option value="" selected disabled>Select ID Type</option>
                                <option value="Ghana Card">Ghana Card</option>
                                <option value="Passport">Passport</option>
                                <option value="Drivers License">Driver's License</option>
                                <option value="Voters ID">Voter's ID</option>
                                <option value="NHIS">NHIS</option>
                            </select>
                            <div class="invalid-feedback">
                                Please select ID type
                            </div>
                        </div>
                        
                        <!-- ID Number -->
                        <div class="col-md-6">
                            <label for="cpf_id_number" class="form-label fw-bold">
                                <i class="fas fa-id-badge me-1"></i>ID Number
                                <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" id="cpf_id_number" required>
                            <div class="invalid-feedback">
                                Please enter ID number
                            </div>
                        </div>
                        
                        <!-- Phone Number -->
                        <div class="col-md-6">
                            <label for="cpf_collectors_phone" class="form-label fw-bold">
                                <i class="fas fa-phone me-1"></i>Phone Number
                                <span class="text-danger">*</span>
                            </label>
                            <input type="tel" class="form-control" id="cpf_collectors_phone" required>
                            <div class="invalid-feedback">
                                Please enter phone number
                            </div>
                        </div>
                        
                        <!-- Purpose -->
                        <div class="col-12">
                            <label for="cpf_collection_purpose" class="form-label fw-bold">
                                <i class="fas fa-bullseye me-1"></i>Purpose
                                <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" id="cpf_collection_purpose" required>
                            <div class="invalid-feedback">
                                Please enter collection purpose
                            </div>
                        </div>
                        
                        <!-- Additional Notes (Optional) -->
                        <div class="col-12">
                            <label for="cfp_additional_notes" class="form-label fw-bold">
                                <i class="fas fa-sticky-note me-1"></i>Additional Notes (Optional)
                            </label>
                            <textarea class="form-control" id="cfp_additional_notes" rows="2" placeholder="Any additional information..."></textarea>
                        </div>
                    </div>
                </form>
                
                <!-- Status Messages -->
                <div class="alert alert-info mt-3 mb-0 d-none" id="cfp_status_message">
                    <i class="fas fa-info-circle me-2"></i>
                    <span id="cfp_message_text"></span>
                </div>
            </div>
            
            <div class="modal-footer">
                <div class="d-flex w-100 justify-content-between align-items-center">
                    <!-- Status Indicator -->
                    <div>
                        <div class="status-indicator d-none" id="cfp_processing_indicator">
                            <div class="spinner-border spinner-border-sm text-primary me-2" role="status">
                                <span class="visually-hidden">Processing...</span>
                            </div>
                            <small class="text-muted">Processing...</small>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="btn-group">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>Cancel
                        </button>
                        <button type="button" class="btn btn-primary btn-sm" id="btn_cpf_save_comment">
                            <i class="fas fa-save me-1"></i>Save Collection
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="filelistModal" tabindex="-1" aria-labelledby="filelistModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <div class="modal-title text-white d-flex align-items-center w-100">
                    <i class="fas fa-history fa-lg me-3"></i>
                    <div>
                        <h5 class="mb-0 fw-bold" id="filelistModalLabel">File Tracking History</h5>
                        <small class="text-white-50 d-block mt-1">Physical file movement and location history</small>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body p-0">
                <!-- Summary Card -->
                <div class="card rounded-0 border-0 border-bottom rounded-top">
                    <div class="card-body py-3">
                        <div class="row g-3">
                            <div class="col-auto">
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary bg-opacity-10 p-2 rounded me-3">
                                        <i class="fas fa-file-alt text-primary fa-lg"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Tracking For</small>
                                        <span class="fw-bold" id="fileTrackingJobNumber">N/A</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-auto">
                                <div class="d-flex align-items-center">
                                    <div class="bg-success bg-opacity-10 p-2 rounded me-3">
                                        <i class="fas fa-exchange-alt text-success fa-lg"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Total Movements</small>
                                        <span class="fw-bold" id="totalMovements">0</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-auto">
                                <div class="d-flex align-items-center">
                                    <div class="bg-info bg-opacity-10 p-2 rounded me-3">
                                        <i class="fas fa-map-marker-alt text-info fa-lg"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Current Location</small>
                                        <span class="fw-bold" id="currentLocation">Unknown</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-auto ms-auto">
                                <div class="d-flex align-items-center">
                                    <div class="bg-warning bg-opacity-10 p-2 rounded me-3">
                                        <i class="fas fa-sync-alt text-warning fa-lg"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Last Updated</small>
                                        <span class="fw-bold" id="lastUpdated">Just now</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- History Table -->
                <div class="table-responsive" style="max-height: 500px;">
                    <table class="table table-hover table-sm align-middle mb-0" id="tbl_file_history">
                        <thead class="table-light sticky-top">
                            <tr>
                                <th scope="col" class="ps-4">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-calendar me-2 text-muted"></i>
                                        <span>Date & Time</span>
                                    </div>
                                </th>
                                <th scope="col">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-building me-2 text-muted"></i>
                                        <span>Division/Department</span>
                                    </div>
                                </th>
                                <th scope="col">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-user-check me-2 text-muted"></i>
                                        <span>Received By</span>
                                    </div>
                                </th>
                                <th scope="col">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-user-tie me-2 text-muted"></i>
                                        <span>Sent By</span>
                                    </div>
                                </th>
                                <!-- <th scope="col" class="text-center">
                                    <div class="d-flex align-items-center justify-content-center">
                                        <i class="fas fa-info-circle me-2 text-muted"></i>
                                        <span>Status</span>
                                    </div>
                                </th> -->
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Rows will be populated dynamically -->
                            <tr id="noRecordsRow" class="d-none">
                                <td colspan="5" class="text-center py-5">
                                    <div class="text-muted">
                                        <i class="fas fa-inbox fa-3x mb-3 opacity-25"></i>
                                        <h6 class="mb-2">No tracking history found</h6>
                                        <p class="small mb-0">No file movement records available for this application</p>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Legend -->
                <!-- <div class="card border-0 rounded-0 border-top">
                    <div class="card-body py-2">
                        <div class="d-flex flex-wrap align-items-center gap-3">
                            <small class="text-muted me-2">Status Legend:</small>
                            <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25">
                                <i class="fas fa-check-circle me-1"></i>Received
                            </span>
                            <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25">
                                <i class="fas fa-paper-plane me-1"></i>Sent
                            </span>
                            <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25">
                                <i class="fas fa-clock me-1"></i>Pending
                            </span>
                            <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25">
                                <i class="fas fa-exclamation-circle me-1"></i>Delayed
                            </span>
                        </div>
                    </div>
                </div> -->
            </div>
            
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div>
                        <small class="text-muted">
                            <i class="fas fa-info-circle me-1"></i>
                            Showing <span id="showingCount">0</span> of <span id="totalCount">0</span> records
                        </small>
                    </div>
                    <div class="btn-group">
                        <!-- <button type="button" class="btn btn-outline-secondary btn-sm" id="btnExportHistory">
                            <i class="fas fa-download me-1"></i>Export
                        </button> -->
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>Close
                        </button>
                        <button type="button" class="btn btn-primary btn-sm" id="btnRefreshHistory">
                            <i class="fas fa-sync-alt me-1"></i>Refresh
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="collectionModal" tabindex="-1" aria-labelledby="collectionModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <div class="modal-title text-white">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-hand-holding fa-2x me-2"></i>
                        <div>
                            <h5 class="mb-0 fw-bold text-white" id="collectionModalLabel">
                                </i>Collection of Completed Application
                            </h5>
                            <small class="text-white-50 opacity-75">Complete the collection process for issued applications</small>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body p-0">
                <!-- Application Header Info -->
                <div class="card rounded-0 border-0 border-bottom">
                    <div class="card-body py-3">
                        <div class="row g-4">
                            <div class="col-lg-6">
                                <div class="form-floating">
                                    <input class="form-control bg-light" placeholder="Applicant Name" 
                                              id="col_applicant_name" readonly style="cursor: not-allowed;">
                                    <label for="col_applicant_name" class="fw-semibold">
                                        <i class="fas fa-user me-1"></i>Applicant Name
                                    </label>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-floating">
                                    <input type="text" class="form-control bg-light" id="col_application_type" readonly style="cursor: not-allowed;">
                                    <label for="col_application_type" class="fw-semibold">
                                        <i class="fas fa-file-alt me-1"></i>Application Type
                                    </label>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-floating">
                                    <input type="text" class="form-control bg-light fw-bold" id="col_job_number" readonly style="cursor: not-allowed;">
                                    <label for="col_job_number" class="fw-semibold">
                                        <i class="fas fa-hashtag me-1"></i>Job Number
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Wizard Steps -->
                <div class="card border-0 shadow-sm rounded-0">
                    <div class="card-header bg-transparent border-bottom py-3">
                        <div class="wizard-steps-collection">
                            <div class="step active" data-step="1">
                                <div class="step-icon">1</div>
                                <div class="step-label">Application Details</div>
                            </div>
                            <div class="step" data-step="2">
                                <div class="step-icon">2</div>
                                <div class="step-label">Identity Verification</div>
                            </div>
                            <div class="step" data-step="3">
                                <div class="step-icon">3</div>
                                <div class="step-label">Confirmation</div>
                            </div>
                        </div>
                    </div>

                    <div class="card-body">
                        <!-- Step 1: Application Details -->
                        <div class="step-content-collection active" id="step-1-content-collection">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0 fw-semibold"><i class="fas fa-info-circle me-2 text-primary"></i>Application Details</h6>
                                <span class="badge bg-primary">Complete</span>
                            </div>
                            
                            <div class="row g-4">
                                <!-- Left Column -->
                                <div class="col-lg-6">
                                    <div class="card border h-100">
                                        <div class="card-header bg-light">
                                            <h6 class="mb-0"><i class="fas fa-exchange-alt me-2"></i>Tracking Information</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Current Division</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-building text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_division" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Job Status</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-tasks text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_job_status" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Collection Status</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-hand-holding text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_collection_status" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Current Officer</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-user-tie text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_current_officer" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label small fw-bold text-muted">Forwarded By</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-paper-plane text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_forwarded_by" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Date Forwarded</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-calendar text-primary"></i>
                                                        </span>
                                                        <input type="date" class="form-control bg-light" id="col_date_forwarded" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Received By</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-user-check text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_received_by" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label small fw-bold text-muted">Received Date</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-calendar-check text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_received_date" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Right Column -->
                                <div class="col-lg-6">
                                    <div class="card border h-100">
                                        <div class="card-header bg-light">
                                            <h6 class="mb-0"><i class="fas fa-archive me-2"></i>File & Batch Information</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Cabinet Name</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-folder text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_carbinet" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Shelve Number</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-layer-group text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_shelve" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Filed Status</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-file-archive text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_filed" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Filed Date</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-calendar-alt text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_filed_date" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label small fw-bold text-muted">Batch Number</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-boxes text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_batchnumber" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Date Batched</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-calendar-day text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_batched_date" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold text-muted">Batched By</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light border-0">
                                                            <i class="fas fa-user-cog text-primary"></i>
                                                        </span>
                                                        <input type="text" class="form-control bg-light" id="col_batched_by" readonly style="cursor: not-allowed;">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Step 2: Identity Verification -->
                        <div class="step-content-collection" id="step-2-content-collection">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0 fw-semibold"><i class="fas fa-user-check me-2 text-primary"></i>Identity Verification</h6>
                                <span class="badge bg-primary" id="partyCount">0 Parties</span>
                            </div>
                            
                            <div class="card border">
                                <div class="card-header bg-light">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0"><i class="fas fa-users me-2"></i>Application Parties</h6>
                                        <span class="badge bg-primary" id="partyCount">0 Parties</span>
                                    </div>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle mb-0" id="collection-parties">
                                            <thead class="table-light">
                                                <tr>
                                                    <th class="ps-4">
                                                        <i class="fas fa-user me-1"></i>Name
                                                    </th>
                                                    <th>
                                                        <i class="fas fa-venus-mars me-1"></i>Gender
                                                    </th>
                                                    <th>
                                                        <i class="fas fa-phone me-1"></i>Contact
                                                    </th>
                                                    <th>
                                                        <i class="fas fa-id-card me-1"></i>ID Type
                                                    </th>
                                                    <th>
                                                        <i class="fas fa-fingerprint me-1"></i>ID Number
                                                    </th>
                                                    <th class="pe-4">
                                                        <i class="fas fa-tag me-1"></i>Applicant Type
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Rows will be populated dynamically -->
                                                <tr id="noPartiesRow">
                                                    <td colspan="6" class="text-center py-5">
                                                        <div class="text-muted">
                                                            <i class="fas fa-users-slash fa-2x mb-3 opacity-25"></i>
                                                            <p class="mb-0">No party information available</p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Step 3: Confirm & Complete -->
                        <div class="step-content-collection" id="step-3-content-collection">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0 fw-semibold"><i class="fas fa-clipboard-check me-2 text-primary"></i>Confirm & Complete Collection</h6>
                                <span class="badge bg-success" id="checklistCount">0 Items</span>
                            </div>
                            
                            <form id="frmSaveCollection" class="needs-validation" novalidate>
                                <div class="row g-4">
                                    <!-- Checklist -->
                                    <div class="col-lg-6">
                                        <div class="card border h-100">
                                            <div class="card-header bg-light">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <h6 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Collection Checklist</h6>
                                                    <span class="badge bg-success" id="checklistCount">0 Items</span>
                                                </div>
                                            </div>
                                            <div class="card-body p-0">
                                                <div class="table-responsive">
                                                    <table class="table table-borderless align-middle mb-0" id="collection-checklist">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th class="ps-4 fw-medium py-3">Description</th>
                                                                <th class="pe-4 fw-medium py-3 text-center">Confirm</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <!-- Rows will be populated dynamically -->
                                                            <tr id="noChecklistRow">
                                                                <td colspan="2" class="text-center py-5">
                                                                    <div class="text-muted">
                                                                        <i class="fas fa-clipboard fa-2x mb-3 opacity-25"></i>
                                                                        <p class="mb-0">No checklist items available</p>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Collection Details Form -->
                                    <div class="col-lg-6">
                                        <div class="card border h-100">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-user-cog me-2"></i>Collector Information</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="row g-3">
                                                    <div class="col-12">
                                                        <label for="col_collected_by" class="form-label fw-semibold">
                                                            <i class="fas fa-user-tie me-1 text-primary"></i>Collected By
                                                            <span class="text-danger">*</span>
                                                        </label>
                                                        <input type="text" class="form-control" id="col_collected_by" 
                                                               placeholder="Enter collector's full name" required>
                                                        <div class="invalid-feedback">
                                                            Please enter collector's name
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-6">
                                                        <label for="col_id_type" class="form-label fw-semibold">
                                                            <i class="fas fa-id-card me-1 text-primary"></i>ID Type
                                                            <span class="text-danger">*</span>
                                                        </label>
                                                        <select class="form-select" id="col_id_type" required>
                                                            <option value="" selected disabled>Select ID Type</option>
                                                            <option value="NATIONAL ID">National ID</option>
                                                            <option value="PASSPORT">Passport</option>
                                                            <option value="DRIVERS LICENSE">Driver's License</option>
                                                            <option value="NHIS CARD">NHIS Card</option>
                                                            <option value="VOTERS ID">Voter's ID</option>
                                                            <option value="SSNIT ID CARD">SSNIT ID Card</option>
                                                        </select>
                                                        <div class="invalid-feedback">
                                                            Please select ID type
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-6">
                                                        <label for="col_id_number" class="form-label fw-semibold">
                                                            <i class="fas fa-fingerprint me-1 text-primary"></i>ID Number
                                                            <span class="text-danger">*</span>
                                                        </label>
                                                        <input type="text" class="form-control" id="col_id_number" 
                                                               placeholder="ID Number" required>
                                                        <div class="invalid-feedback">
                                                            Please enter ID number
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-12">
                                                        <label for="col_phone_number" class="form-label fw-semibold">
                                                            <i class="fas fa-phone me-1 text-primary"></i>Phone Number
                                                            <span class="text-danger">*</span>
                                                        </label>
                                                        <input type="tel" class="form-control" id="col_phone_number" 
                                                               placeholder="+233 XX XXX XXXX" required>
                                                        <div class="invalid-feedback">
                                                            Please enter phone number
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-12">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" 
                                                                   id="col_confirm_terms" required>
                                                            <label class="form-check-label small" for="col_confirm_terms">
                                                                I confirm that all information provided is accurate and I have verified the collector's identity
                                                            </label>
                                                            <div class="invalid-feedback">
                                                                You must confirm before submitting
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
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
                        <button type="button" class="btn btn-warning me-2" id="btnPrevStepCollection">
                            <i class="fas fa-chevron-left me-2"></i>Previous
                        </button>
                        <button type="button" class="btn btn-primary" id="btnNextStepCollection">
                            Next Step <i class="fas fa-chevron-right ms-2"></i>
                        </button>
                        <button type="button" class="btn btn-success ms-2" id="btnCompleteProcessCollection" style="display: none;">
                            <i class="fas fa-check me-2"></i>Complete Collection
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="viewRequestlistModal" tabindex="-1" aria-labelledby="viewBatchlistModalLabel" aria-hidden="true" data-bs-backdrop="static">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <!-- Header - Clean and professional -->
         <div class="modal-header border-bottom">
            <h5 class="modal-title fw-semibold fs-5" id="viewRequestlistModalLabel">
               <i class="ri-group-line me-2"></i>Request List Processing
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
         <div class="modal-body">
            <input id="lbl_request_type" name="lbl_request_type" type="hidden" value="">
            
            <!-- Request Type Selection Card -->
            <div class="card mb-4 shadow-sm border">
               <div class="card-body">
                  <div class="row align-items-center mb-3">
                     <div class="col-md-4">
                        <label class="form-label fw-semibold mb-2">
                           <i class="ri-share-forward-line me-1"></i>Request To:
                        </label>
                        <div class="btn-group w-100" role="group" aria-label="Request type selection">
                           <input type="radio" class="btn-check" name="request_type_radio" id="request_type_unit" autocomplete="off" value="Unit">
                           <label class="btn btn-outline-primary" for="request_type_unit">
                              <i class="ri-building-2-line me-1"></i>Unit
                           </label>
                           
                           <input type="radio" class="btn-check" name="request_type_radio" id="request_type_individual" autocomplete="off" value="Individual">
                           <label class="btn btn-outline-primary" for="request_type_individual">
                              <i class="ri-user-line me-1"></i>Individual
                           </label>
                           
                           <c:if test="${unit_name == 'CSAU' || unit_name == 'CORPORATE CSAU UNIT'}">
                                <input type="radio" class="btn-check" name="request_type_radio"
                                        id="request_type_cabinet" autocomplete="off" value="Cabinet">
                                <label class="btn btn-outline-primary" for="request_type_cabinet">
                                    <i class="ri-archive-line me-1"></i>Cabinet
                                </label>
                            </c:if>
                        </div>
                        <input type="hidden" name="request_type" id="request_type">
                        <div class="text-muted small mt-3">
                           <i class="ri-information-line me-1"></i>
                           Select where to request the selected applications
                        </div>
                     </div>
                  </div>
                  
                  <!-- Unit Requesting Section -->
                  <div class="batch-section bg-primary-transparent border rounded p-3 mb-3" id="unit-requesting-section" style="display: none;">
                     <h6 class="fw-semibold mb-3 text-primary">
                        <i class="ri-building-2-fill me-2"></i>Requesting to a Unit
                     </h6>
                     <div class="row g-3">
                        <div class="col-md-6">
                           <label for="req_unit_division_to_send_to" class="form-label fw-medium">
                              Division <span class="text-danger">*</span>
                           </label>
                           <select id="req_unit_division_to_send_to" data-trigger class="form-select">
                              <option value="" selected disabled>Select Division</option>
                              <option value="LVD">LVD</option>
                              <option value="LRD">LRD</option>
                              <option value="PVLMD">PVLMD</option>
                              <option value="SMD">SMD</option>
                              <option value="RLO">RLO</option>
                              <option value="CORPORATE">CORPORATE</option>
                           </select>
                        </div>
                        <div class="col-md-6">
                            <label for="unit_to_send_to" class="form-label fw-medium">
                                Unit <span class="text-danger">*</span>
                                <small class="text-muted ms-1" id="req_unit-count">(0 units)</small>
                            </label>
                            <div class="datalist-container">
                                <div class="input-group">
                                    <select class="form-select" 
                                        id="req_unit_to_send_to" 
                                        aria-describedby="unit-help">
                                        <option value="" selected disabled>Select a unit</option>
                                        <!-- Options will be populated dynamically -->
                                    </select>
                                    <span class="input-group-text">
                                        <i class="ri-building-2-line" id="unit-icon"></i>
                                    </span>
                                </div>
                            </div>
                            <div id="req_unit-help" class="form-text">
                                <i class="ri-information-line me-1"></i>
                                Select a unit from the dropdown list
                            </div>
                        </div>
                     </div>
                  </div>
                  
                  <!-- Individual Requesting Section -->
                  <div class="batch-section bg-primary-transparent border rounded p-3 mb-3" id="individual-requesting-section" style="display: none;">
                     <h6 class="fw-semibold mb-3 text-primary">
                        <i class="ri-user-fill me-2"></i>Requesting to an Individual
                     </h6>
                     <div class="row g-3">
                       <div class="col-md-6">
                            <label for="division_to_send_to" class="form-label fw-medium">
                                Division/Unit
                            </label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="req_division_to_send_to" 
                                    value="${unit_name}" readonly>
                                <span class="input-group-text">
                                    <i class="ri-lock-line text-muted"></i>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="user_to_send_to" class="form-label fw-medium">
                                User <span class="text-danger">*</span>
                                <small class="text-muted ms-1" id="req_user-count">(0 users)</small>
                            </label>
                            <div class="datalist-container">
                                <div class="input-group">
                                    <select class="form-select" id="req_user_to_send_to" required>
                                        <option value="" selected disabled>Select a user</option>
                                        <!-- Options will be populated dynamically -->
                                    </select>
                                    <span class="input-group-text">
                                        <i class="ri-user-line" id="req_user-icon"></i>
                                    </span>
                                </div>
                            </div>
                            <div id="req_user-help" class="form-text">
                                <i class="ri-information-line me-1"></i>
                                Select a user from the dropdown list
                            </div>
                        </div>
                     </div>
                  </div>
                  
                  <!-- Cabinet Batching Section -->
                  <div class="batch-section bg-primary-transparent border rounded p-3 mb-3" id="cabinet-requesting-section" style="display: none;">
                     <h6 class="fw-semibold mb-3 text-primary">
                        <i class="ri-archive-fill me-2"></i>Requesting to Cabinet
                     </h6>
                     <form id="frmRequestToCabinet" class="row g-3">
                        <div class="col-md-8">
                           <label for="cabinet_to_send_to" class="form-label fw-medium">
                              Cabinet Name <span class="text-danger">*</span>
                           </label>
                           <div class="input-group">
                              <input type="text" class="form-control" id="req_cabinet_to_send_to" 
                                     placeholder="Enter cabinet name" required>
                              <span class="input-group-text">
                                 <i class="ri-archive-drawer-line"></i>
                              </span>
                           </div>
                        </div>
                        <div class="col-md-4">
                           <label class="form-label">&nbsp;</label>
                           <button type="submit" class="btn btn-primary w-100">
                              <i class="ri-send-plane-line me-1"></i>Request to Cabinet
                           </button>
                        </div>
                     </form>
                  </div>
               </div>
            </div>
            
            <!-- Request List Table Card -->
            <div class="card shadow-sm border">
               <div class="card-header border-bottom bg-light">
                  <h6 class="mb-0 fw-semibold">
                     <i class="ri-list-check-2 me-2"></i>Request List Items
                     <span class="badge bg-primary ms-2" id="request-count">0</span>
                  </h6>
               </div>
               <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped mb-0" id="requestlistTable">
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
                            <tbody id="requestlistdataTable">
                                <!-- Data will be populated here -->
                            </tbody>
                        </table>
                    </div>
                  
                  <!-- Empty State -->
                  <div class="text-center py-5" id="empty-request-state">
                        <div class="mb-3">
                            <i class="ri-inbox-line fs-1 text-muted"></i>
                        </div>
                        <h6 class="text-muted mb-2">No items in request list</h6>
                        <p class="text-muted small">Select applications from the table to add them to the request</p>
                    </div>
                </div>
            </div>
         </div>
         
         <!-- Footer - Clean and professional -->
         <div class="modal-footer border-top">
            <div class="me-auto">
               <button type="button" class="btn btn-outline-danger" id="remove_all_from_request_list">
                  <i class="ri-delete-bin-line me-1"></i>Clear All
               </button>
            </div>
            <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
               <i class="ri-close-line me-1"></i>Cancel
            </button>
            <button type="button" id="btn_process_requestlist_ft" class="btn btn-primary" style="display: none">
               <i class="ri-send-plane-fill me-1"></i>Process Request
            </button>
         </div>
      </div>
   </div>
</div>


<div class="modal fade effect-scale modal-blur" id="askForPurposeOfSendingRequest" tabindex="-1" 
     data-bs-backdrop="static" data-bs-keyboard="false"
     aria-labelledby="askForPurposeOfSendingRequestLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content border-0">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="askForPurposeOfSendingRequestLabel">
                    <i class="fas fa-plus-circle me-2"></i>
                    Add To Request List
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" 
                        aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Info Alert -->
                <div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-info-circle fa-lg text-info me-3"></i>
                        <div>
                            <h6 class="mb-1">Select Purpose for Request</h6>
                            <p class="mb-0">Choose the appropriate purpose and add remarks before sending this request.</p>
                        </div>
                    </div>
                </div>
                
                <input type="hidden" id="bl_application_stage" name="bl_application_stage">
                <input type="hidden" id="bl_application_stage_baby_step" name="bl_application_stage_baby_step">

                <!-- Job Number -->
                <div class="mb-4">
                    <label for="bl_job_number" class="form-label fw-bold">
                        <i class="fas fa-hashtag me-2 text-primary"></i>
                        Job Number
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-barcode text-muted"></i>
                        </span>
                        <input class="form-control bg-light" type="text" placeholder="" 
                               id="req_job_number" readonly style="cursor: not-allowed;">
                    </div>
                </div>

                <!-- Applicant Name -->
                <div class="mb-4">
                    <label for="bl_ar_name" class="form-label fw-bold">
                        <i class="fas fa-user me-2 text-primary"></i>
                        Applicant Name
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-user-tag text-muted"></i>
                        </span>
                        <textarea rows="2" class="form-control bg-light" placeholder="" 
                                  id="req_ar_name" readonly style="cursor: not-allowed;"></textarea>
                    </div>
                </div>

                <!-- Application Type -->
                <div class="mb-4">
                    <label for="bl_business_process_sub_name" class="form-label fw-bold">
                        <i class="fas fa-file-alt me-2 text-primary"></i>
                        Application Type
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-file-signature text-muted"></i>
                        </span>
                        <textarea rows="2" class="form-control bg-light" placeholder="" 
                                  id="req_business_process_sub_name" readonly style="cursor: not-allowed;"></textarea>
                    </div>
                </div>

                <!-- Locality -->
                <div class="mb-4">
                    <label for="bl_application_stage_name" class="form-label fw-bold">
                        <i class="fas fa-map-marker-alt me-2 text-primary"></i>
                        Locality
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-map-pin text-muted"></i>
                        </span>
                        <textarea rows="2" class="form-control bg-light" placeholder="" 
                                  id="req_locality" readonly style="cursor: not-allowed;"></textarea>
                    </div>
                </div>

                <!-- Sent Purpose -->
                <div class="mb-4">
                    <label for="bl_job_purpose" class="form-label fw-bold">
                        <i class="fas fa-bullseye me-2 text-primary"></i>
                        Sent Purpose
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-tasks text-muted"></i>
                        </span>
                        <select name="req_job_purpose" id="req_job_purpose" 
                                class="form-select">
                            <!-- Options will be populated dynamically -->
                            <option value="">-- select Purpose --</option>
                        </select>
                    </div>
                    <small class="text-muted mt-1 d-block">
                        <i class="fas fa-lightbulb me-1"></i>
                        Select the purpose for sending this request
                    </small>
                </div>

                <!-- Remarks -->
                <div class="mb-4">
                    <label for="bl_application_stage_name_baby_step" class="form-label fw-bold">
                        <i class="fas fa-comment-dots me-2 text-primary"></i>
                        Remarks
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-sticky-note text-muted"></i>
                        </span>
                        <textarea rows="3" class="form-control" placeholder="Add any additional remarks or instructions..." 
                                  id="req_remarks"></textarea>
                    </div>
                    <small class="text-muted mt-1 d-block">
                        <i class="fas fa-info-circle me-1"></i>
                        Optional: Add any special instructions or notes
                    </small>
                </div>

            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <!-- Action Buttons -->
                <div class="d-flex gap-2 w-100">
                    <!-- Add to List Button -->
                    <a href="#" id="btnaddreqtolistFinal" 
                       class="btn btn-success btn-lg px-4 d-none flex-fill">
                        <span class="d-flex align-items-center justify-content-center">
                            <i class="fas fa-check-circle me-2"></i>
                            <span class="fw-bold">Add to List</span>
                        </span>
                    </a>
                    
                    <!-- Close Button -->
                    <button type="button" class="btn btn-danger btn-lg px-4 flex-fill" 
                            data-bs-dismiss="modal">
                        <span class="d-flex align-items-center justify-content-center">
                            <i class="fas fa-times me-2"></i>
                            <span class="fw-bold">Cancel</span>
                        </span>
                    </button>
                </div>
                
                <!-- Hidden Inputs -->
                <input type="hidden" id="bl_jn_id" name="jn_id">
                <input type="hidden" id="bl_send_by_id" name="send_by_id">
                <input type="hidden" id="bl_userid" name="userid">
                
                <!-- Status Message -->
                <div class="w-100 mt-3">
                    <div class="alert alert-warning bg-warning bg-opacity-10 border-warning py-2 mb-0 text-center">
                        <small>
                            <i class="fas fa-exclamation-triangle me-1"></i>
                            All fields except Remarks are read-only
                        </small>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="profileUpdate" tabindex="-1"
     aria-labelledby="profileUpdateLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="profileUpdateLabel">
                    <i class="fas fa-user-edit me-2"></i>
                    My Profile
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" 
                        aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <form id="frmUdateProfile">
                    
                    <!-- Personal Information Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-primary bg-opacity-10">
                            <h6 class="mb-0">
                                <i class="fas fa-id-card me-2"></i>
                                Personal Information
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <!-- Full Name -->
                                <div class="col-md-6">
                                    <label for="pr_fullname" class="form-label fw-bold">
                                        <i class="fas fa-user me-1 text-primary"></i>
                                        Full Name
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-signature text-muted"></i>
                                        </span>
                                        <textarea id="pr_fullname" class="form-control" rows="2" readonly disabled>${fullname}</textarea>
                                    </div>
                                </div>
                                
                                <!-- Address -->
                                <div class="col-md-6">
                                    <label for="pr_address" class="form-label fw-bold">
                                        <i class="fas fa-home me-1 text-primary"></i>
                                        Address
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-map-marker-alt text-muted"></i>
                                        </span>
                                        <textarea id="pr_address" class="form-control" rows="2" 
                                                  placeholder="Enter your current address"></textarea>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Contact Information Row -->
                            <div class="row g-3 mt-2">
                                <!-- Phone #1 -->
                                <div class="col-md-4">
                                    <label for="pr_phone" class="form-label fw-bold">
                                        <i class="fas fa-phone me-1 text-primary"></i>
                                        Primary Phone
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-phone-alt text-muted"></i>
                                        </span>
                                        <input type="tel" class="form-control" id="pr_phone" 
                                               placeholder="Enter phone number" value="${user_phone}">
                                    </div>
                                </div>
                                
                                <!-- Phone #2 -->
                                <div class="col-md-4">
                                    <label for="pr_mobile" class="form-label fw-bold">
                                        <i class="fas fa-mobile-alt me-1 text-primary"></i>
                                        Mobile Phone
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-mobile text-muted"></i>
                                        </span>
                                        <input type="tel" class="form-control" id="pr_mobile" 
                                               placeholder="Enter mobile number" value="${user_phone2}">
                                    </div>
                                </div>
                                
                                <!-- Email -->
                                <div class="col-md-4">
                                    <label for="pr_emailaddress" class="form-label fw-bold">
                                        <i class="fas fa-envelope me-1 text-primary"></i>
                                        E-Mail Address
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-at text-muted"></i>
                                        </span>
                                        <input type="email" class="form-control" id="pr_emailaddress" 
                                               readonly disabled value="${emailaddress}">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Employment Information Card -->
                    <div class="card mb-4">
                        <div class="card-header bg-success bg-opacity-10">
                            <h6 class="mb-0">
                                <i class="fas fa-briefcase me-2"></i>
                                Employment Information
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <!-- Staff Number -->
                                <div class="col-md-4">
                                    <label for="pr_staffnumber" class="form-label fw-bold">
                                        <i class="fas fa-id-badge me-1 text-success"></i>
                                        Staff Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-hashtag text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control" id="pr_staffnumber" readonly disabled value="${staffnumber}">
                                    </div>
                                </div>
                                
                                <!-- Designation -->
                                <div class="col-md-4">
                                    <label for="pr_designation" class="form-label fw-bold">
                                        <i class="fas fa-user-tie me-1 text-success"></i>
                                        Designation
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-briefcase text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control" id="pr_designation" readonly disabled value="${designation}">
                                    </div>
                                </div>
                                
                                <!-- Department -->
                                <div class="col-md-4">
                                    <label for="pr_department" class="form-label fw-bold">
                                        <i class="fas fa-building me-1 text-success"></i>
                                        Unit/Department
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-sitemap text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control" id="pr_department" readonly disabled value="${unit_name}">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Location Information Row -->
                            <div class="row g-3 mt-2">
                                <!-- Region -->
                                <div class="col-md-4">
                                    <label for="pr_region" class="form-label fw-bold">
                                        <i class="fas fa-globe-africa me-1 text-success"></i>
                                        Region
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-map text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control" id="pr_region" readonly disabled value="${region_name}">
                                    </div>
                                </div>
                                
                                <!-- District -->
                                <div class="col-md-4">
                                    <label for="pr_district" class="form-label fw-bold">
                                        <i class="fas fa-map-marked-alt me-1 text-success"></i>
                                        Office District
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-location-dot text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control" id="pr_district" readonly disabled value="${regional_name}">
                                    </div>
                                </div>
                                
                                <!-- Division -->
                                <div class="col-md-4">
                                    <label for="pr_division" class="form-label fw-bold">
                                        <i class="fas fa-code-branch me-1 text-success"></i>
                                        Division
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-network-wired text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control" id="pr_division" readonly disabled value="${division}">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Account Security Card -->
                    <div class="card">
                        <div class="card-header bg-warning bg-opacity-10">
                            <h6 class="mb-0">
                                <i class="fas fa-lock me-2"></i>
                                Account Security
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <!-- Username -->
                                <div class="col-md-4">
                                    <label for="pr_username" class="form-label fw-bold">
                                        <i class="fas fa-user-circle me-1 text-warning"></i>
                                        Username
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-user text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control" id="pr_username" readonly disabled value="${username}">
                                    </div>
                                </div>
                                
                                <!-- Password -->
                                <div class="col-md-4">
                                    <label for="pr_web_pass" class="form-label fw-bold">
                                        <i class="fas fa-key me-1 text-warning"></i>
                                        Password
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-lock text-muted"></i>
                                        </span>
                                        <input type="password" class="form-control" id="pr_web_pass" 
                                               placeholder="Enter new password" required>
                                        <button class="btn btn-outline-secondary" type="button" 
                                                onclick="togglePassword_('pr_web_pass', this)">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                    <small class="text-muted">Minimum 14 characters with letters and numbers</small>
                                </div>
                                
                                <!-- Confirm Password -->
                                <div class="col-md-4">
                                    <label for="pr_web_pass_confirm" class="form-label fw-bold">
                                        <i class="fas fa-key me-1 text-warning"></i>
                                        Confirm Password
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-lock text-muted"></i>
                                        </span>
                                        <input type="password" class="form-control" id="pr_web_pass_confirm" 
                                               placeholder="Confirm new password" required>
                                        <button class="btn btn-outline-secondary" type="button" 
                                                onclick="togglePassword_('pr_web_pass_confirm', this)">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                    <div id="passwordMatchFeedback" class="form-text"></div>
                                </div>
                            </div>
                            
                            <!-- Password Strength Indicator -->
                            <div class="mt-3">
                                <div class="progress mb-2" style="height: 5px;">
                                    <div id="passwordStrengthBar" class="progress-bar" 
                                         role="progressbar" style="width: 0%"></div>
                                </div>
                                <small id="passwordStrengthText" class="text-muted">Password strength</small>
                            </div>
                        </div>
                    </div>
                    
                </form>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <!-- Update Profile Button -->
                <button type="submit" class="btn btn-primary px-4" id="pr_save_updates">
                    <i class="fas fa-save me-2"></i>
                    Update Profile
                </button>
                
                <!-- Cancel Button -->
                <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>
                    Cancel
                </button>
                
                <!-- Logout Button -->
                <a class="btn btn-outline-danger px-4"
                   href="#"
                  onclick="logout()">
                    <i class="fas fa-sign-out-alt me-2"></i>
                    Logout
                </a>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="viewNotificationModal" tabindex="-1" 
     aria-labelledby="viewNotificationModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0">
            
            <!-- Modal Header -->
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title text-white" id="viewNotificationModalLabel">
                    <i class="fas fa-bell me-2"></i>
                    Notification on Application
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Notification Details Card -->
                <div class="card mb-4">
                    <div class="card-header bg-primary bg-opacity-10">
                        <h6 class="mb-0">
                            <i class="fas fa-info-circle me-2"></i>
                            Notification Details
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <!-- Job Number -->
                            <div class="col-md-6">
                                <div class="d-flex align-items-start mb-3">
                                    <div class="me-3 text-primary">
                                        <i class="fas fa-hashtag fa-lg"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small mb-1">Job Number</div>
                                        <div class="fw-medium text-dark fs-13" id="notice-frm-jobnumber-text">-</div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Date -->
                            <div class="col-md-6">
                                <div class="d-flex align-items-start mb-3">
                                    <div class="me-3 text-primary">
                                        <i class="fas fa-calendar-alt fa-lg"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small mb-1">Date</div>
                                        <div class="fw-medium text-dark fs-13" id="notice-frm-date-text">-</div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Sent By -->
                            <div class="col-md-6">
                                <div class="d-flex align-items-start mb-3">
                                    <div class="me-3 text-primary">
                                        <i class="fas fa-user-tag fa-lg"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small mb-1">Sent By</div>
                                        <div class="fw-medium text-dark fs-13" id="notice-frm-by-text">-</div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Type -->
                            <div class="col-md-6">
                                <div class="d-flex align-items-start mb-3">
                                    <div class="me-3 text-primary">
                                        <i class="fas fa-tag fa-lg"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small mb-1">Type</div>
                                        <div class="fw-medium text-dark fs-13" id="notice-frm-type-text">-</div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Details -->
                            <div class="col-12">
                                <div class="d-flex align-items-start mb-3">
                                    <div class="me-3 text-primary">
                                        <i class="fas fa-comment-dots fa-lg"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small mb-1">Details</div>
                                        <div class="p-3 bg-light text-dark rounded border" id="notice-frm-details-text" style="min-height: 80px;">
                                            -
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Status -->
                            <div class="col-md-6">
                                <div class="d-flex align-items-start mb-3">
                                    <div class="me-3 text-primary">
                                        <i class="fas fa-flag fa-lg"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small mb-1">Status</div>
                                        <div>
                                            <span class="badge bg-info" id="notice-frm-status-text">-</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Replies Section -->
                <div class="card mb-4">
                    <div class="card-header bg-success bg-opacity-10 d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">
                            <i class="fas fa-reply-all me-2"></i>
                            Replies
                        </h6>
                        <span class="badge bg-success" id="replyCountBadge">0</span>
                    </div>
                    <div class="card-body">
                        <div id="notificationReplies" class="replies-container">
                            <!-- Empty state -->
                            <div class="empty-replies text-center py-5">
                                <i class="fas fa-comment-slash fa-3x text-muted mb-3"></i>
                                <p class="text-muted mb-0">No replies yet</p>
                                <p class="small text-muted">Be the first to reply to this notification</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Reply Form (Hidden by default) -->
                <div class="card" id="replyFormContainer" style="display: none;">
                    <div class="card-header bg-warning bg-opacity-10">
                        <h6 class="mb-0">
                            <i class="fas fa-edit me-2"></i>
                            Add Reply
                        </h6>
                    </div>
                    <div class="card-body">
                        <form id="frmNotificationReply">
                            <div class="mb-3">
                                <label for="reply-frm-details" class="form-label fw-bold">
                                    <i class="fas fa-comment-medical me-1 text-warning"></i>
                                    Reply Message
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light align-items-start">
                                        <i class="fas fa-pen text-muted mt-1"></i>
                                    </span>
                                    <textarea rows="3" class="form-control" id="reply-frm-details" 
                                              placeholder="Type your reply here..." required></textarea>
                                </div>
                                <small class="text-muted">Enter your response to this notification</small>
                                <input type="hidden" id="reply-frm-notice-id">
                            </div>
                            
                            <div class="d-flex justify-content-end gap-2">
                                <button type="button" class="btn btn-secondary" id="btnCancelReply">
                                    <i class="fas fa-times me-1"></i>
                                    Cancel
                                </button>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-paper-plane me-1"></i>
                                    Submit Reply
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <!-- Open Application Button -->
                <form action="request_application_progress_details_advance" method="post" class="me-auto">
                    <input type="hidden" name="case_number" id="nt_case_number" value="${appfiles.case_number}">
                    <input type="hidden" name="transaction_number" id="nt_transaction_number" value="${appfiles.transaction_number}">
                    <input type="hidden" name="job_number" id="nt_job_number" value="${appfiles.job_number}">
                    <input type="hidden" name="review_type" value="GeneralWorkRequest">
                    <button type="submit" name="save" class="btn btn-primary">
                        <i class="fas fa-folder-open me-2"></i>
                        Open/Work on Application
                    </button>
                </form>
                
                <!-- Reply Button -->
                <button type="button" class="btn btn-warning" id="btnReplyNotification">
                    <i class="fas fa-reply me-2"></i>
                    Reply Notification
                </button>
                
                <!-- Close Button -->
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>
                    Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="queriedNotificationModal" tabindex="-1" aria-labelledby="queriedNotificationModalLabel" aria-modal="true" role="dialog" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body p-5">
                <div id="eventDetails">
                    <div class="d-flex align-items-center gap-2 mb-2">
                    <h6 class="fw-semibold mb-0"><i class="fas fa-bell text-danger opacity-10 me-2"></i>Notifications</h6>
                    <!-- <span class="badge bg-success-transparent">Full Day</span> -->
                    </div>
                    <div id="queried_list">

                    </div>
                </div>
                <div class="btn-list float-end mt-3">
                <button type="button" class="btn btn-danger border" data-bs-dismiss="modal"><i class="ti ti-x me-2 align-middle"></i>Close</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 Modal -->
<div class="modal fade effect-scale modal-blur" id="changequerystatusModal" tabindex="-1" aria-labelledby="changequerystatusModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom-0 pb-0">
                <div class="w-100">
                    <div class="d-flex align-items-center mb-2">
                        <div class="flex-shrink-0">
                            <div class="bg-warning bg-opacity-10 p-2 rounded-3">
                                <i class="ri-alert-line text-warning fs-4"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <h5 class="modal-title fw-semibold mb-0" id="changequerystatusModalLabel">Confirmation Required</h5>
                            <p class="text-muted small mb-0 mt-1">Set query status to inactive</p>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Body -->
            <div class="modal-body pt-0">
                <div class="alert alert-warning border-warning border-opacity-25 d-flex align-items-start mb-4" role="alert">
                    <i class="ri-information-line me-2 mt-1"></i>
                    <div>
                        <strong class="d-block mb-1">Warning</strong>
                        <small class="text-muted">This action will archive the query and move it to inactive status.</small>
                    </div>
                </div>
                
                <div class="d-flex align-items-center gap-2 mb-3 p-3 bg-light-subtle rounded-2">
                    <i class="ri-file-list-3-line text-primary"></i>
                    <span class="text-muted">Job Number:</span>
                    <span id="displayJobNumber" class="fw-bold text-dark ms-1"></span>
                </div>
                
                <form method="post" id="update-query-form" action="SendComplianceMessage" class="needs-validation" novalidate>
                    <input type="hidden" name="request_type" value="update_compliance_application_notice">
                    <input type="hidden" id="job_number" name="job_number">
                    
                    <div class="form-check mb-4">
                        <input class="form-check-input" type="checkbox" id="confirmInactive" required>
                        <label class="form-check-label small" for="confirmInactive">
                            I confirm that I want to set this query as inactive. This action can be reversed by an administrator.
                        </label>
                        <div class="invalid-feedback">
                            You must confirm this action to proceed.
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="d-flex gap-2 justify-content-end pt-3 border-top">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="ri-close-line me-1"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-warning" id="confirmSubmit" disabled>
                            <i class="ri-check-line me-1"></i> Yes, Set as Inactive
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- Optional Footer -->
            <div class="modal-footer border-top-0 pt-0">
                <small class="text-muted">
                    <i class="ri-information-line me-1"></i>
                    Inactive queries will be moved to archive and won't appear in active lists.
                </small>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 Modal -->
<div class="modal fade effect-scale modal-blur" id="pending_queries_modal" tabindex="-1" aria-labelledby="pendingQueriesModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header border-bottom-0">
                <div class="w-100">
                    <h5 class="modal-title fw-semibold mb-1" id="pendingQueriesModalLabel">Pending Queries</h5>
                    <p class="text-muted small mb-0" id="modalSubtitle"></p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- Status Legend -->
                <div class="d-flex flex-wrap justify-content-start gap-3 mb-4">
                    <div class="d-flex align-items-center">
                        <span class="badge bg-info-subtle text-info me-2"><i class="fas fa-circle fa-xs"></i></span>
                        <small class="text-muted">Reminder Applications</small>
                    </div>
                    <div class="d-flex align-items-center">
                        <span class="badge bg-warning-subtle text-warning me-2"><i class="fas fa-circle fa-xs"></i></span>
                        <small class="text-muted">Warning Applications</small>
                    </div>
                    <div class="d-flex align-items-center">
                        <span class="badge bg-danger-subtle text-danger me-2"><i class="fas fa-circle fa-xs"></i></span>
                        <small class="text-muted">Queried Applications</small>
                    </div>
                </div>
                
                <!-- DataTable -->
                <div class="table-responsive">
                    <table id="pending_queries_table_list" class="table table-hover align-middle" style="width: 100%">
                        <thead class="table-light">
                            <tr class="text-uppercase small">
                                <th width="40">#</th>
                                <th width="100">Job No.</th>
                                <th>Details</th>
                                <th width="120">Receiver</th>
                                <th width="100">Unit</th>
                                <th width="80">TAT</th>
                                <th width="120">Date of Notice</th>
                                <th width="100" class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Data will be loaded here -->
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer border-top-0">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div>
                        <span class="badge bg-primary rounded-pill" id="queryCountQR">0</span>
                        <small class="text-muted ms-2">queries found</small>
                    </div>
                    <button type="button" class="btn btn-outline-danger btn-sm" data-bs-dismiss="modal">
                        <i class="ri-close-line me-1"></i> Close
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" data-position="0" id="divisionModal" tabindex="-1" aria-labelledby="divisionModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white border-0">
                <div class="d-flex align-items-center w-100">
                    <div class="modal-icon-container me-3">
                        <div class="icon-wrapper bg-white bg-opacity-25 rounded-circle px-2 py-1">
                            <i class="ri-bar-chart-2-fill fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title mb-0" id="divisionModalLabel"></h5>
                        <div class="small opacity-75" id="divisionModalSubtitle"></div>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Stats Summary -->
                <div class="row mb-4" id="divisionStats">
                    <!-- Stats will be loaded here -->
                </div>
                
                <!-- Filter Bar -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-body py-3">
                                <div class="row align-items-center g-3">
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-center">
                                            <i class="ri-filter-3-line text-primary me-2"></i>
                                            <span class="fw-medium text-dark">Showing results for: </span>
                                            <span class="ms-2 badge bg-primary" id="currentPeriod"></span>
                                        </div>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="text-muted small">
                                            <i class="ri-information-line me-1"></i>
                                            Click on any division card for detailed breakdown
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Divisions Grid -->
                <div class="row g-4" id="divisionGrid">
                    <!-- Division cards will be loaded here -->
                </div>
                
                <!-- Empty State -->
                <div class="text-center py-5 d-none" id="emptyDivisionState">
                    <div class="mb-4">
                        <i class="ri-folder-open-line display-1 text-muted opacity-25"></i>
                    </div>
                    <h4 class="text-muted mb-3">No Data Available</h4>
                    <p class="text-muted mb-0">There are no applications recorded for the selected period.</p>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer border-top bg-light">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="text-muted small">
                        <i class="ri-refresh-line me-1"></i>
                        Data loaded: <span id="dataLoadTime">Just now</span>
                    </div>
                    <div>
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="ri-close-line me-1"></i> Close
                        </button>
                        <button type="button" class="btn btn-primary" id="exportDivisionData">
                            <i class="ri-download-line me-1"></i> Export
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-fade modal-blur" data-position="0" id="serviceTypeModal" tabindex="-1" aria-labelledby="serviceTypeModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="serviceTypeModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover w-100" 
                                       id="serviceTypeTable"
                                       data-responsive="true"
                                       data-order='[[1, "desc"]]'
                                       data-dom="<'row'<'col-sm-4 text-start'l><'col-sm-4 text-start'B><'col-sm-4 text-end'f>>
                                                 <'row'<'col-sm-12'tr>>
                                                 <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>">
                                    <thead class="table-light">
                                        <tr>
                                            <th data-data="name" data-name="name">Service Name</th>
                                            <th data-data="total" data-name="total">Count</th>
                                            <th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
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

<div class="modal fade effect-fade modal-blur" data-position="0" id="unitModal" tabindex="-1" role="dialog"
	aria-labelledby="unitModalLabel" aria-hidden="true" data-bs-backdrop="static">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="unitModalLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col-12 table-responsive">
							<table class="table" data-dom="<'row'<'col-sm-4 text-left'l><'col-sm-4 text-left'B><'col-sm-4 text-right'f>>\n\t\t\t<'row'<'col-sm-12'tr>>\n\t\t\t<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>" style="width: 100%" data-responsive="true" data-buttons='{
                        "buttons": [
                            { "extend": "excel", "exportOptions": { "columns": [ ":visible" ] } },
                            { "extend": "print", "exportOptions": { "columns": [ ":visible" ] } },
                            "colvis"
                        ]
                   }' data-order='[[ 1, "desc" ]]'>
								<thead>
									<tr>
										<th data-name="name" data-data="name">Unit</th>
										<th data-name="total" data-data="total">Count</th>
										<th data-data="action" data-name="action" data-orderable="false" data-searchable="false">Action</th>
									</tr>
								</thead>
								<tbody>
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

<div class="modal fade effect-scale modal-blur" id="user_divisionModal" tabindex="-1" aria-labelledby="userDivisionModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="icon-wrapper bg-white bg-opacity-25 rounded-circle px-2 py-1">
                            <i class="ri-calendar-event-line fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title mb-0" id="userDivisionModalLabel">
                            Applications Received
                        </h5>
                        <small class="opacity-75">Today (<fmt:formatDate value="${now}" type="date" />)</small>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Loading State -->
                <div id="loadingState" class="text-center py-5">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-3">Loading division data...</p>
                </div>
                
                <!-- Error State -->
                <div id="errorState" class="text-center py-5 d-none">
                    <div class="mb-4">
                        <i class="ri-error-warning-line display-1 text-danger opacity-50"></i>
                    </div>
                    <h5 class="text-danger mb-3">Unable to Load Data</h5>
                    <p class="text-muted">Please try again later.</p>
                    <button class="btn btn-primary mt-2" id="retryButton">
                        <i class="ri-refresh-line me-2"></i>Retry
                    </button>
                </div>
                
                <!-- Data Content -->
                <div id="dataContent" class="d-none">
                    <div class="row">
                        <!-- Main Division Card -->
                        <div class="col-xl-12 mb-4">
                            <div class="card border-start-primary border-start-4 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <div class="text-muted small text-uppercase fw-semibold mb-1">
                                                Your Division
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <h2 class="mb-0 me-3 fw-bold" id="div_count">0</h2>
                                                <div>
                                                    <div class="h5 mb-0 fw-bold" id="user_division">-</div>
                                                    <div class="text-muted small">Applications received today</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <div class="bg-primary bg-opacity-10 rounded-circle p-3">
                                                <i class="ri-building-2-line text-primary fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- All Divisions Section -->
                        <div class="col-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-bar-chart-2-line text-primary me-2"></i>
                                        All Divisions Today
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3" id="allDivisionsGrid">
                                        <!-- All division cards will be loaded here -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="text-muted small">
                        <i class="ri-time-line me-1"></i>
                        Last updated: <span id="lastUpdated">Just now</span>
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">
                            <i class="ri-close-line me-2"></i>Close
                        </button>
                        <button class="btn btn-primary ms-2" type="button" id="refreshButton">
                            <i class="ri-refresh-line me-2"></i>Refresh
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="user_divisionModal_this_month" tabindex="-1" aria-labelledby="userDivisionMonthModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="icon-wrapper bg-white bg-opacity-25 rounded-circle px-2 py-1">
                            <i class="ri-calendar-2-line fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title mb-0" id="userDivisionMonthModalLabel">
                            Applications Received
                        </h5>
                        <small class="opacity-75">This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)</small>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Loading State -->
                <div id="loadingStateMonth" class="text-center py-5">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-3">Loading monthly division data...</p>
                </div>
                
                <!-- Error State -->
                <div id="errorStateMonth" class="text-center py-5 d-none">
                    <div class="mb-4">
                        <i class="ri-error-warning-line display-1 text-danger opacity-50"></i>
                    </div>
                    <h5 class="text-danger mb-3">Unable to Load Monthly Data</h5>
                    <p class="text-muted">Please try again later.</p>
                    <button class="btn btn-primary mt-2" id="retryButtonMonth">
                        <i class="ri-refresh-line me-2"></i>Retry
                    </button>
                </div>
                
                <!-- Data Content -->
                <div id="dataContentMonth" class="d-none">
                    <div class="row">
                        <!-- Main Division Card -->
                        <div class="col-xl-12 mb-4">
                            <div class="card border-start-primary border-start-4 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="row align-items-center mb-2">
                                        <div class="col">
                                            <div class="text-muted small text-uppercase fw-semibold mb-1">
                                                Your Division - This Month
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <h2 class="mb-0 me-3 fw-bold" id="div_count_month">0</h2>
                                                <div>
                                                    <div class="h5 mb-0 fw-bold" id="user_division_month">-</div>
                                                    <div class="text-muted small">Applications received this month</div>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                                <div class="text-muted small mb-1">
                                                    <i class="ri-calendar-line me-1"></i>
                                                    Month of <span class="fw-medium"><fmt:formatDate value="${now}" pattern="MMMM yyyy" /></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <div class="bg-primary bg-opacity-10 rounded-circle py-x px-3">
                                                <i class="ri-calendar-2-line text-primary fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="position-absolute bottom-0 start-0 m-3 mt-3" id="user_division_this_month" style="cursor: pointer;">
                                        <span class="btn btn-sm btn-warning px-3">
                                            View Details <i class="ri-arrow-right-line ms-1"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Monthly Stats -->
                        <div class="col-12 mb-4">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-info bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-arrow-up-down-line text-info fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Monthly Trend</div>
                                                    <h4 class="mb-0 fw-bold" id="monthlyTrend">--</h4>
                                                    <div class="text-success small">
                                                        <i class="ri-arrow-up-line me-1"></i>
                                                        <span>Compared to last month</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-success bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-file-chart-line text-success fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Daily Average</div>
                                                    <h4 class="mb-0 fw-bold" id="dailyAverage">--</h4>
                                                    <div class="text-muted small">Applications per day</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- All Divisions Section -->
                        <div class="col-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-bar-chart-horizontal-line text-primary me-2"></i>
                                        All Divisions This Month
                                    </h6>
                                    <small class="text-muted">Comparison across all divisions</small>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3" id="allDivisionsGridMonth">
                                        <!-- All division cards will be loaded here -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="text-muted small">
                        <i class="ri-calendar-event-line me-1"></i>
                        Month: <span class="fw-medium"><fmt:formatDate value="${now}" pattern="MMMM yyyy" /></span>
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">
                            <i class="ri-close-line me-2"></i>Close
                        </button>
                        <button class="btn btn-primary ms-2" type="button" id="refreshButtonMonth">
                            <i class="ri-refresh-line me-2"></i>Refresh
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="user_completed_divison_today" tabindex="-1" aria-labelledby="userCompletedDivisionTodayLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="icon-wrapper bg-white bg-opacity-25 rounded-circle px-2 py-1">
                            <i class="ri-checkbox-circle-line fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title mb-0" id="userCompletedDivisionTodayLabel">
                            Applications Completed
                        </h5>
                        <small class="opacity-75">Today (<fmt:formatDate value="${now}" type="date" />)</small>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Loading State -->
                <div id="loadingStateCompletedToday" class="text-center py-5">
                    <div class="spinner-border text-success" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-3">Loading completed applications data...</p>
                </div>
                
                <!-- Error State -->
                <div id="errorStateCompletedToday" class="text-center py-5 d-none">
                    <div class="mb-4">
                        <i class="ri-error-warning-line display-1 text-danger opacity-50"></i>
                    </div>
                    <h5 class="text-danger mb-3">Unable to Load Completed Data</h5>
                    <p class="text-muted">Please try again later.</p>
                    <button class="btn btn-success mt-2" id="retryButtonCompletedToday">
                        <i class="ri-refresh-line me-2"></i>Retry
                    </button>
                </div>
                
                <!-- Data Content -->
                <div id="dataContentCompletedToday" class="d-none">
                    <div class="row">
                        <!-- Main Division Card -->
                        <div class="col-xl-12 mb-4">
                            <div class="card border-start-success border-start-4 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <div class="text-muted small text-uppercase fw-semibold mb-1">
                                                <i class="ri-checkbox-circle-line text-success me-1"></i>
                                                Your Division - Completed Today
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <h2 class="mb-0 me-3 fw-bold" id="div_count_completed_today">0</h2>
                                                <div>
                                                    <div class="h5 mb-0 fw-bold" id="user_division_completed_today">-</div>
                                                    <div class="text-muted small">Applications completed today</div>
                                                </div>
                                            </div>
                                            <!-- Completion Rate (if available) -->
                                            <div class="mt-3" id="completionRateSection">
                                                <div class="d-flex align-items-center">
                                                    <div class="progress flex-grow-1 me-3" style="height: 8px;">
                                                        <div class="progress-bar bg-success" role="progressbar" 
                                                             style="width: 0%" 
                                                             id="completionProgress"
                                                             aria-valuenow="0" 
                                                             aria-valuemin="0" 
                                                             aria-valuemax="100"></div>
                                                    </div>
                                                    <div class="text-end">
                                                        <div class="text-success fw-bold" id="completionPercentage">0%</div>
                                                        <div class="text-muted x-small">Completion Rate</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <div class="bg-success bg-opacity-10 rounded-circle p-3">
                                                <i class="ri-checkbox-circle-line text-success fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Performance Stats -->
                        <div class="col-12 mb-4">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-success bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-time-line text-success fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Processing Time</div>
                                                    <h4 class="mb-0 fw-bold" id="avgProcessingTime">--</h4>
                                                    <div class="text-muted small">Average days</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-info bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-timer-flash-line text-info fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Fastest Completion</div>
                                                    <h4 class="mb-0 fw-bold" id="fastestCompletion">--</h4>
                                                    <div class="text-muted small">Days taken</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-warning bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-alarm-warning-line text-warning fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">On-Time Rate</div>
                                                    <h4 class="mb-0 fw-bold" id="onTimeRate">--</h4>
                                                    <div class="text-muted small">Completed on time</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- All Divisions Completed Today -->
                        <div class="col-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-check-double-line text-success me-2"></i>
                                        All Divisions - Completed Today
                                    </h6>
                                    <small class="text-muted">Completion performance across divisions</small>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3" id="allDivisionsCompletedGrid">
                                        <!-- All division completion cards will be loaded here -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Service Type Breakdown -->
                        <div class="col-12 mt-4">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-file-list-line text-success me-2"></i>
                                        Completed by Service Type
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-sm">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Service Type</th>
                                                    <th class="text-center">Completed</th>
                                                    <th class="text-center">Avg. Days</th>
                                                    <th class="text-center">Status</th>
                                                </tr>
                                            </thead>
                                            <tbody id="serviceTypeCompletedTable">
                                                <!-- Service type data will be loaded here -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="text-muted small">
                        <i class="ri-bar-chart-box-line me-1"></i>
                        Performance metrics for completed applications
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">
                            <i class="ri-close-line me-2"></i>Close
                        </button>
                        <button class="btn btn-success ms-2" type="button" id="refreshButtonCompletedToday">
                            <i class="ri-refresh-line me-2"></i>Refresh
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="user_completed_divison_month" tabindex="-1" aria-labelledby="userCompletedDivisionMonthLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="icon-wrapper bg-white bg-opacity-25 rounded-circle px-2 py-1">
                            <i class="ri-calendar-check-line fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title mb-0" id="userCompletedDivisionMonthLabel">
                            Applications Completed
                        </h5>
                        <small class="opacity-75">This Month (<fmt:formatDate value="${now}" pattern="MMMM" />)</small>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Loading State -->
                <div id="loadingStateCompletedMonth" class="text-center py-5">
                    <div class="spinner-border text-success" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-3">Loading monthly completion data...</p>
                </div>
                
                <!-- Error State -->
                <div id="errorStateCompletedMonth" class="text-center py-5 d-none">
                    <div class="mb-4">
                        <i class="ri-error-warning-line display-1 text-danger opacity-50"></i>
                    </div>
                    <h5 class="text-danger mb-3">Unable to Load Monthly Completion Data</h5>
                    <p class="text-muted">Please try again later.</p>
                    <button class="btn btn-success mt-2" id="retryButtonCompletedMonth">
                        <i class="ri-refresh-line me-2"></i>Retry
                    </button>
                </div>
                
                <!-- Data Content -->
                <div id="dataContentCompletedMonth" class="d-none">
                    <div class="row">
                        <!-- Main Division Card -->
                        <div class="col-xl-12 mb-4">
                            <div class="card border-start-success border-start-4 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <div class="text-muted small text-uppercase fw-semibold mb-1">
                                                <i class="ri-calendar-check-line text-success me-1"></i>
                                                Your Division - Completed This Month
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <h2 class="mb-0 me-3 fw-bold" id="div_count_completed_month">0</h2>
                                                <div>
                                                    <div class="h5 mb-0 fw-bold" id="user_division_completed_month">-</div>
                                                    <div class="text-muted small">
                                                        Applications completed in <span class="fw-medium"><fmt:formatDate value="${now}" pattern="MMMM" /></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Monthly Completion Trend -->
                                            <div class="mt-3">
                                                <div class="d-flex align-items-center">
                                                    <div class="progress flex-grow-1 me-3" style="height: 8px;">
                                                        <div class="progress-bar bg-success" role="progressbar" 
                                                             style="width: 0%" 
                                                             id="monthlyCompletionProgress"
                                                             aria-valuenow="0" 
                                                             aria-valuemin="0" 
                                                             aria-valuemax="100"></div>
                                                    </div>
                                                    <div class="text-end">
                                                        <div class="text-success fw-bold" id="monthlyCompletionPercentage">0%</div>
                                                        <div class="text-muted x-small">of monthly target</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <div class="bg-success bg-opacity-10 rounded-circle p-3">
                                                <i class="ri-calendar-check-line text-success fs-1"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Monthly Performance Stats -->
                        <div class="col-12 mb-4">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-success bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-bar-chart-2-line text-success fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Monthly Trend</div>
                                                    <h4 class="mb-0 fw-bold" id="monthlyCompletionTrend">--</h4>
                                                    <div class="text-success small">
                                                        <i class="ri-arrow-up-line me-1"></i>
                                                        <span>vs last month</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-info bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-calendar-schedule-line text-info fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Daily Average</div>
                                                    <h4 class="mb-0 fw-bold" id="monthlyDailyAverage">--</h4>
                                                    <div class="text-muted small">Per working day</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-warning bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-speed-line text-warning fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Completion Rate</div>
                                                    <h4 class="mb-0 fw-bold" id="monthlyCompletionRate">--</h4>
                                                    <div class="text-muted small">vs received</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                                    <i class="ri-timer-line text-primary fs-3"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Avg. Time</div>
                                                    <h4 class="mb-0 fw-bold" id="monthlyAvgTime">--</h4>
                                                    <div class="text-muted small">Days per app</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Monthly Chart Section -->
                        <div class="col-12 mb-4">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0 fw-bold">
                                            <i class="ri-line-chart-line text-success me-2"></i>
                                            Monthly Completion Trend
                                        </h6>
                                        <div class="btn-group btn-group-sm" role="group">
                                            <button type="button" class="btn btn-outline-success active" data-chart-type="line">
                                                <i class="ri-line-chart-line me-1"></i>Line
                                            </button>
                                            <button type="button" class="btn btn-outline-success" data-chart-type="bar">
                                                <i class="ri-bar-chart-2-line me-1"></i>Bar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="chart-container" style="position: relative; height: 250px; width: 100%">
                                        <canvas id="monthlyCompletionChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- All Divisions Monthly Completion -->
                        <div class="col-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-building-2-line text-success me-2"></i>
                                        All Divisions - Monthly Completion
                                    </h6>
                                    <small class="text-muted">Performance comparison for <fmt:formatDate value="${now}" pattern="MMMM" /></small>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-sm align-middle">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Division</th>
                                                    <th class="text-center">Completed</th>
                                                    <th class="text-center">Monthly Target</th>
                                                    <th class="text-center">Achievement</th>
                                                    <th class="text-center">Trend</th>
                                                    <th class="text-center">Status</th>
                                                </tr>
                                            </thead>
                                            <tbody id="monthlyDivisionsTable">
                                                <!-- Monthly division data will be loaded here -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Weekly Breakdown -->
                        <div class="col-12 mt-4">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-transparent border-bottom py-3">
                                    <h6 class="mb-0 fw-bold">
                                        <i class="ri-calendar-2-line text-success me-2"></i>
                                        Weekly Completion Breakdown
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3" id="weeklyBreakdownGrid">
                                        <!-- Weekly breakdown cards will be loaded here -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div class="text-muted small">
                        <i class="ri-calendar-2-line me-1"></i>
                        Month: <span class="fw-medium"><fmt:formatDate value="${now}" pattern="MMMM yyyy" /></span>
                        <span class="mx-2">•</span>
                        <i class="ri-pie-chart-line me-1"></i>
                        <span id="totalMonthlyCompleted">0</span> total completed
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">
                            <i class="ri-close-line me-2"></i>Close
                        </button>
                        <button class="btn btn-success ms-2" type="button" id="refreshButtonCompletedMonth">
                            <i class="ri-refresh-line me-2"></i>Refresh
                        </button>
                        <button class="btn btn-outline-success ms-2" type="button" id="exportMonthlyData">
                            <i class="ri-download-line me-2"></i>Export
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="filefileRegionalNumberUploadModal" tabindex="-1"
     aria-labelledby="filefileRegionalNumberUploadModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="fileRegionalNumberUploadModalLabel">
                    <i class="fas fa-file-upload me-2"></i>Upload Regional Numbers CSV File
                </h5>
                <button type="button" class="btn-close btn-close-white" 
                        data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- File Upload Form -->
                <form class="row g-3" method="POST" enctype="multipart/form-data" id="id_formeb">
                    <!-- File Upload Section -->
                    <div class="col-12">
                        <div class="card border">
                            <div class="card-body">
                                <div class="mb-3">
                                    <label for="fileUploadFormregionalnumber" class="form-label fw-bold">
                                        <i class="fas fa-file-csv me-1"></i>Select CSV File
                                    </label>
                                    <div class="input-group">
                                        <input type="file" class="form-control" 
                                               id="fileUploadFormregionalnumber" 
                                               name="fileUploadFormregionalnumber"
                                               accept=".csv, .xlsx, .xls"
                                               required>
                                        <button class="btn btn-outline-secondary" type="button" 
                                                onclick="document.getElementById('fileUploadFormregionalnumber').value=''">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="form-text">
                                        Supported formats: CSV, Excel (.xlsx, .xls). Max size: 10MB
                                    </div>
                                </div>
                                
                                <!-- File Preview (optional) -->
                                <div class="mt-3 d-none" id="filePreviewSection">
                                    <div class="alert alert-info d-flex align-items-center">
                                        <i class="fas fa-file-excel fa-2x me-3 text-success"></i>
                                        <div>
                                            <strong id="fileName">No file selected</strong>
                                            <div class="text-muted small" id="fileSize">-</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Upload Instructions -->
                    <div class="col-12">
                        <div class="card border">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-info-circle me-2"></i>Instructions</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="text-primary">Required Columns:</h6>
                                        <ul class="list-unstyled">
                                            <li><i class="fas fa-check-circle text-success me-2"></i>Applicant Name</li>
                                            <li><i class="fas fa-check-circle text-success me-2"></i>Locality</li>
                                            <li><i class="fas fa-check-circle text-success me-2"></i>Gender</li>
                                            <li><i class="fas fa-check-circle text-success me-2"></i>District</li>
                                            <li><i class="fas fa-check-circle text-success me-2"></i>Region</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-primary">Format Guidelines:</h6>
                                        <ul class="list-unstyled">
                                            <li><i class="fas fa-exclamation-triangle text-warning me-2"></i>UTF-8 encoding</li>
                                            <li><i class="fas fa-exclamation-triangle text-warning me-2"></i>No empty rows</li>
                                            <li><i class="fas fa-exclamation-triangle text-warning me-2"></i>First row as headers</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Upload Button -->
                    <div class="col-12 text-center mt-4">
                        <button type="button" id="btn_upload_rn_file" 
                                class="btn btn-primary btn-lg px-5">
                            <i class="fas fa-cloud-upload-alt me-2"></i>Upload File
                        </button>
                        <div class="mt-2">
                            <small class="text-muted">
                                <i class="fas fa-sync-alt me-1"></i>Processing may take a few moments
                            </small>
                        </div>
                    </div>
                </form>
                
                <!-- Progress Bar (optional) -->
                <div class="mt-4 d-none" id="uploadProgressSection">
                    <div class="progress" style="height: 10px;">
                        <div id="uploadProgressBar" class="progress-bar progress-bar-striped progress-bar-animated" 
                             role="progressbar" style="width: 0%" 
                             aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <div class="text-center mt-2">
                        <small class="text-muted" id="uploadProgressText">Uploading...</small>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-outline-secondary" 
                        data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Cancel
                </button>
                <button type="button" class="btn btn-outline-primary" 
                        id="btnDownloadTemplate">
                    <i class="fas fa-download me-2"></i>Download Template
                </button>
            </div>
        </div>
    </div>
</div>

