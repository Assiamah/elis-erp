<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Compliance Advisory Center</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Manage client details and monitor client interactions</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">CAC</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Client Details</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <div class="content-wrapper">
            <div class="row">
                <!-- Main Form Section -->
                <div class="col-12">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header bg-light">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="card-title text-uppercase text-warning mb-0">
                                    <i class="fas fa-user-circle me-2"></i>CLIENT DETAILS
                                </h5>
                            </div>
                        </div>
                        
                        <form id="cicaClientForm" method="post">
                            <div class="card-body">
                                <div class="row">
                                    <!-- Left Column - Basic Information -->
                                    <div class="col-lg-6">
                                        <div class="border-end border-2 pe-lg-3">
                                            <h6 class="text-primary mb-4"><i class="fas fa-info-circle me-2"></i>Basic Information</h6>
                                            
                                            <div class="mb-3 row">
                                                <label class="col-sm-4 col-form-label fw-semibold">
                                                    Name <span class="text-danger">*</span>
                                                </label>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control required-input" 
                                                           name="complainant_name" id="complainant_name" required>
                                                </div>
                                            </div>
                                            
                                            <div class="mb-3 row">
                                                <label class="col-sm-4 col-form-label fw-semibold">
                                                    Phone <span class="text-danger">*</span>
                                                </label>
                                                <div class="col-sm-8">
                                                    <input type="tel" class="form-control required-input" 
                                                           name="complainant_phone" id="complainant_phone" required>
                                                </div>
                                            </div>
                                            
                                            <div class="mb-3 row">
                                                <label class="col-sm-4 col-form-label fw-semibold">
                                                    Email
                                                </label>
                                                <div class="col-sm-8">
                                                    <input type="email" class="form-control" 
                                                           name="complainant_email" id="complainant_email">
                                                </div>
                                            </div>
                                            
                                            <div class="mb-3 row">
                                                <label class="col-sm-4 col-form-label fw-semibold">
                                                    Sex <span class="text-danger">*</span>
                                                </label>
                                                <div class="col-sm-8">
                                                    <select class="form-select required-input" 
                                                            name="gender" id="gender" required >
                                                        <option value="" disabled selected>-- select --</option>
                                                        <option value="Male">Male</option>
                                                        <option value="Female">Female</option>
                                                        <option value="Joint">Joint</option>
                                                        <option value="Institution">Institution</option>
                                                    </select>
                                                </div>
                                            </div>
                                            
                                            <div class="mb-3 row">
                                                <label class="col-sm-4 col-form-label fw-semibold">
                                                    Address
                                                </label>
                                                <div class="col-sm-8">
                                                    <textarea class="form-control" rows="3" 
                                                              name="complainant_add" id="complainant_add"></textarea>
                                                </div>
                                            </div>
                                            
                                            <div class="mb-3 row">
                                                <label class="col-sm-4 col-form-label fw-semibold">
                                                    Purpose <span class="text-danger">*</span>
                                                </label>
                                                <div class="col-sm-8">
                                                    <select class="form-select required-input" 
                                                            name="purpose" id="purpose" required >
                                                        <option value="" disabled selected>-- select --</option>
                                                        <option value="1">Service Enquiry</option>
                                                        <option value="2">Other Enquiry</option>
                                                        <option value="3">Service Complaint</option>
                                                        <option value="4">Non Service Complaint</option>
                                                    </select>
                                                </div>
                                            </div>
                                            
                                            <input type="hidden" name="request_type" value="clients_details">
                                            <input type="hidden" name="request_by_id" value="${sessionScope.userid}">
                                            <input type="hidden" name="request_by" value="${sessionScope.fullname}">
                                        </div>
                                    </div>
                                    
                                    <!-- Right Column - Dynamic Fields -->
                                    <div class="col-lg-6">
                                        <div id="dynamic-fields-container">
                                            <!-- Dynamic content will be loaded here based on purpose selection -->
                                            <div class="text-center text-muted py-5" id="empty-state">
                                                <i class="fas fa-arrow-left fa-2x mb-3"></i>
                                                <p class="mb-0">Select a purpose to see additional fields</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card-footer bg-light">
                                <div class="d-flex justify-content-end">
                                    <button type="button" id="resetBtn" class="btn btn-outline-secondary me-2">
                                        <i class="fas fa-redo me-2"></i>Reset
                                    </button>
                                    <button type="submit" id="submitBtn" class="btn btn-success">
                                        <span id="submit_text">Submit</span>
                                        <i class="fas fa-paper-plane ms-2"></i>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Enquiry Section -->
                <div class="col-12" id="enquiry-section">
                    <div class="card shadow-sm">
                        <div class="card-header bg-light">
                            <h5 class="card-title text-uppercase text-warning mb-0">
                                <i class="fas fa-search me-2"></i>ENQUIRY
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="mb-4">
                                        <label class="fw-semibold mb-3"><i class="fas fa-filter me-2"></i>Search By:</label>
                                        <div class="d-flex flex-wrap gap-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                                       id="rbtn_search_type1" value="job_number" required>
                                                <label class="form-check-label" for="rbtn_search_type1">
                                                    Job Number
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                                       id="rbtn_search_type2" value="case_number" required>
                                                <label class="form-check-label" for="rbtn_search_type2">
                                                    Case Number
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                                       id="rbtn_search_type3" value="regional_number" required>
                                                <label class="form-check-label" for="rbtn_search_type3">
                                                    Regional Number
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                                       id="rbtn_search_type4" value="glpin" required>
                                                <label class="form-check-label" for="rbtn_search_type4">
                                                    GLPIN
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                                       id="rbtn_search_type6" value="ref_number" required>
                                                <label class="form-check-label" for="rbtn_search_type6">
                                                    Ref Number
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                                       id="rbtn_search_type5" value="ar_name" required>
                                                <label class="form-check-label" for="rbtn_search_type5">
                                                    Applicant Name
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row g-3 align-items-end">
                                        <div class="col-md-8">
                                            <label for="cc_search_value" class="form-label fw-semibold">
                                                Search Value <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control" id="cc_search_value" 
                                                   placeholder="Enter search value" required>
                                        </div>
                                        <div class="col-md-4">
                                            <button type="button" class="btn btn-warning w-100" id="btnCCJobSearch">
                                                <i class="fas fa-search me-2"></i>Search
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <div class="alert alert-info">
                                        <h6 class="alert-heading"><i class="fas fa-lightbulb me-2"></i>Search Tips</h6>
                                        <ul class="mb-0 ps-3">
                                            <li>Enter 8 or more characters for better results</li>
                                            <li>Select the search type before searching</li>
                                            <li>Use specific reference numbers when available</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Search Results -->
                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="card border-0 d-none" id="cc-search-results-section">
                                        <div class="card-header bg-info text-white">
                                            <i class="fas fa-list-alt me-2"></i>Search Results
                                        </div>
                                        <div class="card-body">
                                            <div class="table-responsive">
                                                <table class="table table-hover" id="cc-search-results-table">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th>Applicant Name</th>
                                                            <th>Case Number</th>
                                                            <th>Job Number</th>
                                                            <th>Locality</th>
                                                            <th>Regional Number</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <!-- Results will be populated here -->
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="trackingModal" tabindex="-1" aria-labelledby="trackingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-light">
                <h5 class="modal-title text-primary" id="trackingModalLabel">
                    <i class="fas fa-history me-2"></i>Application Tracking History
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <!-- Application Details Summary -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-info text-white">
                        <h6 class="card-title mb-0">
                            <i class="fas fa-info-circle me-2"></i>Application Details
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="border rounded p-3 h-100">
                                    <small class="text-muted d-block mb-1">
                                        <i class="fas fa-calendar me-1"></i>Date Created
                                    </small>
                                    <div class="fw-bold text-primary" id="date_created_text">-</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="border rounded p-3 h-100">
                                    <small class="text-muted d-block mb-1">
                                        <i class="fas fa-file-alt me-1"></i>Job Number
                                    </small>
                                    <div class="fw-bold text-primary" id="job_number_text">-</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="border rounded p-3 h-100">
                                    <small class="text-muted d-block mb-1">
                                        <i class="fas fa-user me-1"></i>Submitted By
                                    </small>
                                    <div class="fw-bold text-primary" id="submitted_by_text">-</div>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="border rounded p-3 h-100">
                                    <small class="text-muted d-block mb-1">
                                        <i class="fas fa-tasks me-1"></i>Main Service
                                    </small>
                                    <div class="fw-bold text-primary" id="main_service_text">-</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="border rounded p-3 h-100">
                                    <small class="text-muted d-block mb-1">
                                        <i class="fas fa-tasks me-1"></i>Sub Service
                                    </small>
                                    <div class="fw-bold text-primary" id="sub_service_text">-</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="border rounded p-3 h-100">
                                    <small class="text-muted d-block mb-1">
                                        <i class="fas fa-check-circle me-1"></i>Status
                                    </small>
                                    <div class="fw-bold text-primary" id="status_text">-</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tracking Status -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-warning text-dark">
                        <h6 class="card-title mb-0">
                            <i class="fas fa-chart-line me-2"></i>Tracking Status
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="border rounded p-3 h-100">
                                    <small class="text-muted d-block mb-1">
                                        <i class="fas fa-question-circle me-1"></i>Enquiry Status
                                    </small>
                                    <div class="fw-bold" id="app_status">
                                        <span class="badge bg-secondary">-</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="border rounded p-3 h-100">
                                    <small class="text-muted d-block mb-1">
                                        <i class="fas fa-clock me-1"></i>Days Created
                                    </small>
                                    <div class="fw-bold" id="days_passed">
                                        <span class="badge bg-info">0</span> days
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="border rounded p-3 h-100">
                                    <small class="text-muted d-block mb-1">
                                        <i class="fas fa-exclamation-triangle me-1"></i>Priority
                                    </small>
                                    <div class="fw-bold" id="priority_status">
                                        <span class="badge bg-secondary">-</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tracking Details Accordion -->
                <div class="accordion" id="trackingAccordion">
                    <!-- Milestones Card -->
                    <div class="accordion-item mb-3 border-0 shadow-sm">
                        <h2 class="accordion-header" id="milestonesHeading">
                            <button class="accordion-button bg-primary text-white collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#milestonesCollapse" 
                                    aria-expanded="false" aria-controls="milestonesCollapse">
                                <i class="fas fa-flag-checkered me-2"></i>Milestones
                                <span class="badge bg-light text-primary ms-2" id="milestonesCount">0</span>
                            </button>
                        </h2>
                        <div id="milestonesCollapse" class="accordion-collapse collapse" 
                             aria-labelledby="milestonesHeading" data-bs-parent="#trackingAccordion">
                            <div class="accordion-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0" id="app-tracking">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="5%">SN</th>
                                                <th width="50%">Milestone Status</th>
                                                <th width="25%">Status</th>
                                                <th width="20%">TAT (Days)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Milestones will be populated here -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Comments Card -->
                    <div class="accordion-item mb-3 border-0 shadow-sm">
                        <h2 class="accordion-header" id="commentsHeading">
                            <button class="accordion-button bg-info text-white collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#commentsCollapse" 
                                    aria-expanded="false" aria-controls="commentsCollapse">
                                <i class="fas fa-comments me-2"></i>Comments & History
                                <span class="badge bg-light text-info ms-2" id="commentsCount">0</span>
                            </button>
                        </h2>
                        <div id="commentsCollapse" class="accordion-collapse collapse" 
                             aria-labelledby="commentsHeading" data-bs-parent="#trackingAccordion">
                            <div class="accordion-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0" id="cabinet-tracking">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="40%">Comments</th>
                                                <th width="25%">Division/Unit</th>
                                                <th width="20%">Batching Officer</th>
                                                <th width="15%">Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Comments will be populated here -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Queried Card -->
                    <div class="accordion-item mb-3 border-0 shadow-sm d-none" id="case_query">
                        <h2 class="accordion-header" id="queriedHeading">
                            <button class="accordion-button bg-danger text-white collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#queriedCollapse" 
                                    aria-expanded="false" aria-controls="queriedCollapse">
                                <i class="fas fa-exclamation-circle me-2"></i>Queries & Responses
                                <span class="badge bg-light text-danger ms-2" id="queriesCount">0</span>
                            </button>
                        </h2>
                        <div id="queriedCollapse" class="accordion-collapse collapse" 
                             aria-labelledby="queriedHeading" data-bs-parent="#trackingAccordion">
                            <div class="accordion-body">
                                <div class="row g-3">
                                    <div class="col-lg-6">
                                        <div class="card border-0 shadow-sm h-100">
                                            <div class="card-header bg-danger text-white">
                                                <h6 class="card-title mb-0">
                                                    <i class="fas fa-question-circle me-2"></i>Query History
                                                </h6>
                                            </div>
                                            <div class="card-body p-0">
                                                <div class="table-responsive">
                                                    <table class="table table-hover mb-0" id="case-query">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th width="10%">SN</th>
                                                                <th width="30%">Reason</th>
                                                                <th width="40%">Response</th>
                                                                <th width="20%">Date</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <!-- Queries will be populated here -->
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="card border-0 shadow-sm h-100">
                                            <div class="card-header bg-success text-white">
                                                <h6 class="card-title mb-0">
                                                    <i class="fas fa-file-alt me-2"></i>Related Documents
                                                </h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <button type="button" class="btn btn-success btn-sm" 
                                                            id="btn_load_scanned_documents_public">
                                                        <i class="fas fa-eye me-1"></i>Load Documents
                                                    </button>
                                                    <small class="text-muted">
                                                        <i class="fas fa-info-circle me-1"></i>
                                                        Case: <span id="case_number_display">-</span>
                                                    </small>
                                                </div>
                                                
                                                <input type="hidden" id="cs_main_case_number" />
                                                
                                                <div class="table-responsive">
                                                    <table class="table table-sm table-hover" id="lc_public_documents_dataTable">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th width="60%">Document Name</th>
                                                                <th width="40%">Document Type</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <!-- Documents will be populated here -->
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- SMS Notifications Card -->
                    <div class="accordion-item mb-3 border-0 shadow-sm">
                        <h2 class="accordion-header" id="smsHeading">
                            <button class="accordion-button bg-success text-white collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#smsCollapse" 
                                    aria-expanded="false" aria-controls="smsCollapse">
                                <i class="fas fa-sms me-2"></i>SMS Notifications
                                <span class="badge bg-light text-success ms-2" id="smsCount">0</span>
                            </button>
                        </h2>
                        <div id="smsCollapse" class="accordion-collapse collapse" 
                             aria-labelledby="smsHeading" data-bs-parent="#trackingAccordion">
                            <div class="accordion-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0" id="sms-tracking">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="10%">SN</th>
                                                <th width="70%">Message</th>
                                                <th width="20%">Date Sent</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- SMS notifications will be populated here -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <div class="d-flex justify-content-between w-100">
                    <div>
                        <button type="button" class="btn btn-outline-info btn-sm" 
                                onclick="expandAllSections()">
                            <i class="fas fa-expand-alt me-1"></i>Expand All
                        </button>
                        <button type="button" class="btn btn-outline-secondary btn-sm ms-2" 
                                onclick="collapseAllSections()">
                            <i class="fas fa-compress-alt me-1"></i>Collapse All
                        </button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>Close
                        </button>
                        <!-- <button type="button" class="btn btn-primary ms-2" onclick="printTrackingReport()">
                            <i class="fas fa-print me-1"></i>Print Report
                        </button> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include SweetAlert2 CSS & JS -->
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/choices.js/public/assets/styles/choices.min.css">
<script src="https://cdn.jsdelivr.net/npm/choices.js/public/assets/scripts/choices.min.js"></script>