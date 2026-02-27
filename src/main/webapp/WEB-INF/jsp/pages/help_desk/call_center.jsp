 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


 
<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Call Center</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Search across all application records</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Call Center</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

       <!-- Search Section Row -->
    <div class="row g-4">
        <!-- Left Column - Search Applications -->
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-0">
                    <div class="d-flex align-items-center">
                        <div class="icon-circle bg-primary bg-opacity-10 px-2 py-1 rounded-circle me-3">
                            <i class="bi bi-search text-primary fs-5"></i>
                        </div>
                        <div>
                            <h5 class="mb-1 fw-semibold">Search Applications</h5>
                            <p class="text-muted small mb-0">Find applications by various criteria</p>
                        </div>
                    </div>
                </div>
                
                <div class="card-body pt-0">
                    <form id="frmCCJobSearch" method="post">
                        <!-- Search Type Radio Group -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-muted small text-uppercase mb-3">
                                <i class="bi bi-filter-circle me-1"></i>
                                Search By:
                            </label>
                            
                            <div class="d-flex flex-wrap gap-4">
                                <!-- Job Number -->
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" 
                                           name="rbtn_search_type" id="rbtn_search_type1" 
                                           value="job_number" required>
                                    <label class="form-check-label" for="rbtn_search_type1">
                                        <!-- <i class="bi bi-briefcase me-1 text-primary"></i> -->
                                        Job Number
                                    </label>
                                </div>
                                
                                <!-- Case Number -->
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" 
                                           name="rbtn_search_type" id="rbtn_search_type2" 
                                           value="case_number" required>
                                    <label class="form-check-label" for="rbtn_search_type2">
                                        <!-- <i class="bi bi-folder-symlink me-1 text-success"></i> -->
                                        Case Number
                                    </label>
                                </div>
                                
                                <!-- Regional Number -->
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" 
                                           name="rbtn_search_type" id="rbtn_search_type3" 
                                           value="regional_number" required>
                                    <label class="form-check-label" for="rbtn_search_type3">
                                        <!-- <i class="bi bi-geo-alt me-1 text-info"></i> -->
                                        Regional Number
                                    </label>
                                </div>
                                
                                <!-- GLPIN -->
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" 
                                           name="rbtn_search_type" id="rbtn_search_type4" 
                                           value="glpin" required>
                                    <label class="form-check-label" for="rbtn_search_type4">
                                        <!-- <i class="bi bi-upc-scan me-1 text-warning"></i> -->
                                        GLPIN
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Search Input Group -->
                        <div class="row g-2 align-items-end">
                            <div class="col-md-8">
                                <label for="cc_search_value" class="form-label fw-semibold text-muted small">
                                    <i class="bi bi-pencil-square me-1"></i>
                                    Search Value
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0">
                                        <i class="bi bi-search"></i>
                                    </span>
                                    <input class="form-control form-control-lg border-0 bg-light" 
                                           id="cc_search_value" type="text" 
                                           placeholder="Enter job number, case number, etc..." 
                                           required>
                                </div>
                                <!-- <div class="form-text mt-2">
                                    <i class="bi bi-info-circle text-primary me-1"></i>
                                    Minimum 3 characters required
                                </div> -->
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-primary btn-lg w-100" 
                                        id="btnCCJobSearch">
                                    <i class="bi bi-search me-2"></i>
                                    Search
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                
                <!-- <div class="card-footer bg-white border-0 py-3">
                    <div class="d-flex align-items-center text-muted small">
                        <i class="bi bi-clock-history me-2"></i>
                        Search across all application records
                    </div>
                </div> -->
            </div>

			<!-- Search Results Section (Hidden by default) -->
			<div class="row mt-4">
				<div class="col-12">
					<div class="card border-0 shadow-sm"  style="display:none" id="cc-search-results-section">
						<div class="card-header bg-white py-3 d-flex align-items-center justify-content-between">
							<div>
								<h5 class="mb-1 fw-semibold">
									<i class="bi bi-table text-primary me-2"></i>
									Search Results
								</h5>
								<p class="text-muted small mb-0" id="result_count">
									Found 0 matching applications
								</p>
							</div>
							
							<!-- Export Options -->
							<!-- <div class="btn-group" role="group">
								<button type="button" class="btn btn-outline-secondary btn-sm" id="exportExcel">
									<i class="bi bi-file-excel me-1 text-success"></i>
									Excel
								</button>
								<button type="button" class="btn btn-outline-secondary btn-sm" id="exportPDF">
									<i class="bi bi-file-pdf me-1 text-danger"></i>
									PDF
								</button>
								<button type="button" class="btn btn-outline-secondary btn-sm" id="printTable">
									<i class="bi bi-printer me-1"></i>
									Print
								</button>
							</div> -->
						</div>

						<div class="card-body p-0">
							<div class="table-responsive">
								<table class="table table-hover align-middle mb-0" id="cc-search-results-table">
									<thead class="bg-light">
										<tr>
											<th class="px-3 py-3">Applicant Name</th>
											<th class="px-3 py-3">Job Number</th>
											<th class="px-3 py-3">Locality</th>
											<th class="px-3 py-3">Regional Number</th>
											<th class="px-3 py-3">Case Status</th>
											<th class="px-3 py-3 text-center">Actions</th>
										</tr>
									</thead>
									<tbody>
										<!-- Results will be loaded dynamically -->
										<tr>
											<td colspan="6" class="text-center text-muted py-5">
												<i class="bi bi-search fs-1 d-block mb-3"></i>
												<h6>No Results Found</h6>
												<p class="small">Use the search form to find applications</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>

						<!-- Pagination -->
						<div class="card-footer bg-white py-3">
							<div class="d-flex justify-content-between align-items-center">
								<div class="small text-muted">
									Showing <span id="start_record">0</span> to <span id="end_record">0</span> of <span id="total_records">0</span> entries
								</div>
								<nav aria-label="Table navigation">
									<ul class="pagination pagination-sm mb-0">
										<li class="page-item disabled">
											<a class="page-link" href="#" tabindex="-1">Previous</a>
										</li>
										<li class="page-item active"><a class="page-link" href="#">1</a></li>
										<li class="page-item"><a class="page-link" href="#">2</a></li>
										<li class="page-item"><a class="page-link" href="#">3</a></li>
										<li class="page-item">
											<a class="page-link" href="#">Next</a>
										</li>
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
			</div>
        </div>

        <!-- Right Column - Applicant Details -->
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-0">
                    <div class="d-flex align-items-center">
                        <div class="icon-circle bg-success bg-opacity-10 p-2 rounded-circle me-3">
                            <i class="bi bi-person-badge text-success fs-5"></i>
                        </div>
                        <div>
                            <h5 class="mb-1 fw-semibold">Applicant Details</h5>
                            <p class="text-muted small mb-0">Load specific applicant information</p>
                        </div>
                    </div>
                </div>

                <div class="card-body pt-0">
                    <form id="frmEnquiryApplicantDetails" method="post">
                        <!-- Job Number Input -->
                        <div class="mb-4">
                            <label for="hpl_job_number" class="form-label fw-semibold text-muted small text-uppercase">
                                <i class="bi bi-briefcase me-1"></i>
                                Job Number
                            </label>
                            <div class="row g-2">
                                <div class="col-8">
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-0">
                                            <i class="bi bi-hash"></i>
                                        </span>
                                        <input class="form-control border-0 bg-light" 
                                               id="hpl_job_number" type="text" 
                                               placeholder="Enter job number" required>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <button type="submit" class="btn btn-success w-100">
                                        <i class="bi bi-download me-1"></i>
                                        Load
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>

                    <!-- Applicant Details Section (Hidden by default) -->
                    <div class="mt-4 d-none" id="tbl_applicant_details_section">
                        <div class="card bg-light border-0">
                            <div class="card-body">
                                <h6 class="border-bottom pb-2 mb-3">
                                    <i class="bi bi-person-circle me-2 text-primary"></i>
                                    Applicant Information
                                </h6>
                                
                                <!-- Applicant Details Table -->
                                <table class="table table-sm table-borderless" id="tbl_applicant_details">
                                    <tr>
                                        <th width="40" class="text-muted ps-0">Name:</th>
                                        <td class="fw-semibold d-flex justify-content-end" id="applicant_name">-</td>
                                    </tr>
                                    <tr>
                                        <th class="text-muted ps-0">Phone:</th>
                                        <td class="d-flex justify-content-end" id="applicant_phone">-</td>
                                    </tr>
                                    <tr>
                                        <th class="text-muted ps-0">Email:</th>
                                        <td class="d-flex justify-content-end" id="applicant_email">-</td>
                                    </tr>
                                    <tr>
                                        <th class="text-muted ps-0">Job No.:</th>
                                        <td class="d-flex justify-content-end" id="applicant_job">-</td>
                                    </tr>
                                </table>
                                
                                <div class="mt-3">
                                    <button class="btn btn-sm btn-outline-primary" id="refreshDetails">
                                        <i class="bi bi-arrow-repeat me-1"></i>
                                        Refresh
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Empty State (shown when no details loaded) -->
                    <div class="text-center py-4" id="applicant_empty_state">
                        <div class="mb-3">
                            <i class="bi bi-person-circle text-muted" style="font-size: 3rem;"></i>
                        </div>
                        <h6 class="text-muted mb-1">No Applicant Loaded</h6>
                        <p class="text-muted small">Enter a job number to load details</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    
     </div>
     
     
    
 </div>
 
 
<!-- Tracking Modal - Bootstrap 5 -->
<div class="modal fade effect-scale modal-blur" id="trackingModal" tabindex="-1" 
     aria-labelledby="trackingModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <!-- Modal Header -->
            <div class="modal-header bg-gradient-primary text-white py-3">
                <h5 class="modal-title fw-semibold" id="trackingModalLabel">
                    <i class="bi bi-diagram-3 me-2"></i>
                    Application Tracking History
                </h5>
                <button type="button" class="btn-close" 
                        data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- Application Details Section -->
                <div class="application-details mb-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="icon-circle bg-primary bg-opacity-10 p-2 rounded-circle me-2">
                            <i class="bi bi-info-circle-fill text-primary"></i>
                        </div>
                        <h6 class="fw-semibold mb-0">Application Details</h6>
                        <span class="badge bg-light text-dark ms-3 px-3 py-2" id="status_text"></span>
                    </div>
                    
                    <div class="row g-4">
                        <!-- Date Created -->
                        <div class="col-sm-6 col-lg-3">
                            <div class="detail-card p-3 bg-light rounded-3">
                                <small class="text-muted text-uppercase fw-semibold">
                                    <i class="bi bi-calendar3 me-1"></i>Date Created
                                </small>
                                <div class="h6 mb-0 fw-normal mt-2" id="date_created_text">-</div>
                            </div>
                        </div>
                        
                        <!-- Job Number -->
                        <div class="col-sm-6 col-lg-3">
                            <div class="detail-card p-3 bg-light rounded-3">
                                <small class="text-muted text-uppercase fw-semibold">
                                    <i class="bi bi-briefcase me-1"></i>Job Number
                                </small>
                                <div class="h6 mb-0 fw-normal mt-2" id="job_number_text">-</div>
                            </div>
                        </div>
                        
                        <!-- Submitted By -->
                        <div class="col-sm-6 col-lg-3">
                            <div class="detail-card p-3 bg-light rounded-3">
                                <small class="text-muted text-uppercase fw-semibold">
                                    <i class="bi bi-person-circle me-1"></i>Submitted By
                                </small>
                                <div class="h6 mb-0 fw-normal mt-2" id="submitted_by_text">-</div>
                            </div>
                        </div>
                        
                        <!-- Main Service -->
                        <div class="col-sm-6 col-lg-3">
                            <div class="detail-card p-3 bg-light rounded-3">
                                <small class="text-muted text-uppercase fw-semibold">
                                    <i class="bi bi-grid me-1"></i>Main Service
                                </small>
                                <div class="h6 mb-0 fw-normal mt-2" id="main_service_text">-</div>
                            </div>
                        </div>
                        
                        <!-- Sub Service -->
                        <div class="col-sm-6 col-lg-6">
                            <div class="detail-card p-3 bg-light rounded-3">
                                <small class="text-muted text-uppercase fw-semibold">
                                    <i class="bi bi-diagram-2 me-1"></i>Sub Service
                                </small>
                                <div class="h6 mb-0 fw-normal mt-2" id="sub_service_text">-</div>
                            </div>
                        </div>
                        
                        <!-- Current Status (already displayed in header) -->
                        <div class="col-sm-6 col-lg-6">
                            <div class="detail-card p-3 bg-light rounded-3">
                                <small class="text-muted text-uppercase fw-semibold">
                                    <i class="bi bi-flag me-1"></i>Current Stage
                                </small>
                                <div class="h6 mb-0 fw-normal mt-2" id="current_stage_text">-</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Progress Timeline (Optional) -->
                <!-- <div class="progress-timeline mb-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="icon-circle bg-success bg-opacity-10 p-2 rounded-circle me-2">
                            <i class="bi bi-graph-up-arrow text-success"></i>
                        </div>
                        <h6 class="fw-semibold mb-0">Progress Timeline</h6>
                    </div>
                    <div class="progress" style="height: 8px;">
                        <div class="progress-bar bg-success" role="progressbar" 
                             style="width: 45%;" aria-valuenow="45" 
                             aria-valuemin="0" aria-valuemax="100">45%</div>
                    </div>
                </div> -->

                <!-- Tracking Tables Row -->
                <div class="row g-4">
                    <!-- Milestones Table -->
                    <div class="col-lg-6">
                        <div class="card border-0 shadow-sm h-100">
                            <div class="card-header bg-white py-3 d-flex align-items-center">
                                <i class="bi bi-list-check text-primary me-2 fs-5"></i>
                                <h6 class="fw-semibold mb-0">Milestone Progress</h6>
                                <span class="badge bg-primary ms-3" id="milestone_count">0</span>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0" id="cabinet-tracking">
                                        <thead class="bg-light">
                                            <tr>
                                                <th class="px-3 py-3" width="60">#</th>
                                                <th class="px-3 py-3">Milestone Description</th>
                                                <th class="px-3 py-3 text-center" width="120">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="3" class="text-center text-muted py-4">
                                                    <i class="bi bi-arrow-repeat spin me-2"></i>
                                                    Loading milestones...
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer bg-white py-2">
                                <small class="text-muted">
                                    <i class="bi bi-info-circle me-1"></i>
                                    Green = Completed | Blue = In Progress | Red = Pending
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- SMS Notifications Table -->
                    <div class="col-lg-6">
                        <div class="card border-0 shadow-sm h-100">
                            <div class="card-header bg-white py-3 d-flex align-items-center">
                                <i class="bi bi-chat-dots text-info me-2 fs-5"></i>
                                <h6 class="fw-semibold mb-0">SMS Notifications</h6>
                                <span class="badge bg-info ms-3" id="notification_count">0</span>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive" style="max-height: 300px;">
                                    <table class="table table-hover align-middle mb-0" id="sms-tracking">
                                        <thead class="bg-light">
                                            <tr>
                                                <th class="px-3 py-3" width="60">#</th>
                                                <th class="px-3 py-3">Message</th>
                                                <th class="px-3 py-3 text-center" width="150">Date Sent</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="3" class="text-center text-muted py-4">
                                                    <i class="bi bi-arrow-repeat spin me-2"></i>
                                                    Loading notifications...
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer bg-white py-2">
                                <small class="text-muted">
                                    <i class="bi bi-clock me-1"></i>
                                    Showing all notifications
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg me-1"></i>
                    Close
                </button>
                <!-- <button type="button" class="btn btn-primary" id="refreshTracking">
                    <i class="bi bi-arrow-repeat me-1"></i>
                    Refresh Data
                </button> -->
            </div>
        </div>
    </div>
</div>
 
