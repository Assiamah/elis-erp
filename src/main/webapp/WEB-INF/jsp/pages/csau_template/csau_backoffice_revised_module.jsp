<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Process Batch List</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="index.jsp">Staff Case Management Revised</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Process batch List</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <div class="row">
            <!-- Main Content Area -->
            <div class="col-lg-8">
                <!-- Job Search Card -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-transparent border-0 px-4 pt-4 pb-0">
                        <div class="row nav nav-tabs g-3">
                            <!-- Card 1: Search Jobs -->
                            <div class="col-md-6">
                                <div class="card card-hover border-danger" style="cursor: pointer;" 
                                    data-bs-toggle="tab" data-bs-target="#search-jobs">
                                    <div class="card-body text-center p-3">
                                        <div class="mb-2">
                                            <i class="fas fa-search fa-2x text-danger"></i>
                                        </div>
                                        <h6 class="card-title mb-1 text-dark fw-semibold">Search Jobs</h6>
                                        <p class="card-text small text-muted">Find jobs by job number</p>
                                    </div>
                                    <div class="card-footer bg-danger bg-opacity-10 border-0 text-center py-2">
                                        <small class="text-danger fw-medium">Click to search</small>
                                    </div>
                                </div>
                            </div>

                            <!-- Card 2: View Batch List -->
                            <div class="col-md-6">
                                <div class="card card-hover border-success" style="cursor: pointer;" 
                                    data-bs-toggle="tab" data-bs-target="#view-batchlist">
                                    <div class="card-body text-center p-3">
                                        <div class="mb-2">
                                            <i class="fas fa-list fa-2x text-success"></i>
                                        </div>
                                        <h6 class="card-title mb-1 text-dark fw-semibold">View Batch List</h6>
                                        <p class="card-text small text-muted">View and manage batch lists</p>
                                    </div>
                                    <div class="card-footer bg-success bg-opacity-10 border-0 text-center py-2">
                                        <small class="text-success fw-medium">Click to view</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card-body px-4 pt-4">
                        <div class="tab-content">
                            <!-- Tab 1: Search Jobs -->
                            <div class="tab-pane fade show active" id="search-jobs" role="tabpanel">
                                <div class="card border-0 shadow-none">
                                    <div class="card-header bg-light border-0 py-3">
                                        <h5 class="mb-0 fw-semibold">
                                            <i class="fas fa-search text-danger me-2"></i>
                                            Search for Job Applications
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <div id="searchJobErrorAlert"></div>
                                        <div class="row g-3">
                                            <div class="col-md-10">
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light">
                                                        <i class="fas fa-briefcase text-muted"></i>
                                                    </span>
                                                    <input type="text" 
                                                        class="form-control border-start-0" 
                                                        id="scm_job_number_search" 
                                                        placeholder="Enter Job Number"
                                                        oninput="this.value = this.value.toUpperCase()">
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <button class="btn btn-danger w-100" id="btn_scm_job_number_search">
                                                    <i class="fas fa-search me-1"></i> Search
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tab 2: View Batch List -->
                            <div class="tab-pane fade" id="view-batchlist" role="tabpanel">
                                <div class="card border-0 shadow-none">
                                    <div class="card-header bg-light border-0 py-3">
                                        <h5 class="mb-0 fw-semibold">
                                            <i class="fas fa-list text-success me-2"></i>
                                            Batch List Management
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="text-center py-4">
                                            <i class="fas fa-list fa-3x text-success mb-3"></i>
                                            <h6 class="fw-semibold">View and manage your batch lists</h6>
                                            <p class="text-muted small mb-3">Access your saved batch lists and continue processing</p>
                                            <button class="btn btn-success" id="btnViewBatchlist">
                                                <i class="fas fa-eye me-1"></i> View Batch Lists
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Application Details Card -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-transparent border-0 py-3 d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fa fa-bar-chart text-primary me-2"></i>
                            Application Details
                        </h5>
                        <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2">
                            <i class="fas fa-file-alt me-1"></i>
                            Total: ${fn:length(applicationlist)} Applications
                        </span>
                    </div>
                    
                    <div class="card-body">
                        <!-- Table Section -->
                        <div class="table-responsive">
                            <table class="table table-hover align-middle" 
                                   id="tbl_search_for_job_details_datatable" 
                                   width="100%">
                                <thead class="table-light">
                                    <tr>
                                        <th class="fw-semibold">Job Number</th>
                                        <th class="fw-semibold">Applicant Name</th>
                                        <th class="fw-semibold">Application Type</th>
                                        <th class="fw-semibold">Status</th>
                                        <th class="fw-semibold text-center">Add to Batch</th>
                                        <th class="fw-semibold text-center">Work</th>
                                        <th class="fw-semibold text-center">Further Entries</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${applicationlist}" var="appfiles">
                                        <tr class="${appfiles.objections > 0 ? 'bg-danger bg-opacity-10' : ''}" 
                                            data-bs-toggle="${appfiles.objections > 0 ? 'tooltip' : ''}" 
                                            data-bs-placement="left" 
                                            title="${appfiles.objections > 0 ? 'Application has pending Objections' : ''}">
                                            
                                            <td>
                                                <span class="fw-medium">${appfiles.job_number}</span>
                                            </td>
                                            
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-light rounded-circle p-2 me-2">
                                                        <i class="fas fa-user text-muted small"></i>
                                                    </div>
                                                    <div>
                                                        <span data-bs-toggle="tooltip" 
                                                              data-bs-placement="top" 
                                                              title="${fn:length(appfiles.ar_name) > 20 ? appfiles.ar_name : ''}">
                                                            ${fn:substring(appfiles.ar_name, 0, 20)}
                                                            ${fn:length(appfiles.ar_name) > 20 ? "..." : ""}
                                                        </span>
                                                    </div>
                                                </div>
                                            </td>
                                            
                                            <td>
                                                <span class="badge bg-info bg-opacity-10 text-info px-3 py-2">
                                                    ${appfiles.business_process_sub_name}
                                                </span>
                                            </td>
                                            
                                            <td>
                                                <span data-bs-toggle="tooltip" 
                                                      data-bs-placement="top" 
                                                      title="${fn:length(appfiles.current_application_status) > 20 ? appfiles.current_application_status : ''}"
                                                      class="badge ${appfiles.objections > 0 ? 'bg-danger' : 'bg-success'} bg-opacity-10 text-${appfiles.objections > 0 ? 'danger' : 'success'} px-3 py-2">
                                                    <i class="fas fa-circle me-1 small"></i>
                                                    ${fn:substring(appfiles.current_application_status, 0, 20)}
                                                    ${fn:length(appfiles.current_application_status) > 20 ? "..." : ""}
                                                </span>
                                            </td>
                                            
                                            <td class="text-center">
                                                <button class="btn btn-info btn-sm d-inline-flex align-items-center" 
                                                        id="btnAddToBatchlist-${appfiles.job_number}" 
                                                        data-job_number="${appfiles.job_number}" 
                                                        data-ar_name="${appfiles.ar_name}"  
                                                        data-business_process_sub_name="${appfiles.business_process_sub_name}" 
                                                        data-bs-target="#askForPurposeOfBatching" 
                                                        data-bs-toggle="modal">
                                                    <i class="fas fa-list me-1"></i>
                                                    Add to Batch
                                                </button>
                                            </td>
                                            
                                            <td class="text-center">
                                                <form action="registration_application_progress_details" 
                                                      method="post" 
                                                      class="d-inline">
                                                    <input type="hidden" name="case_number" 
                                                           value="${appfiles.transaction_number}">
                                                    <input type="hidden" name="job_number" 
                                                           value="${appfiles.job_number}">
                                                    <input type="hidden" name="business_process_sub_name" 
                                                           value="${appfiles.business_process_sub_name}">
                                                    <button type="submit" 
                                                            name="save" 
                                                            class="btn btn-outline-primary btn-sm d-inline-flex align-items-center">
                                                        <i class="fas fa-folder-open me-1"></i>
                                                        Work
                                                    </button>
                                                </form>
                                            </td>
                                            
                                            <td class="text-center">
                                                <!-- Further Entries column -->
                                                <button class="btn btn-outline-secondary btn-sm" disabled>
                                                    <i class="fas fa-plus-circle"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    
                                    <c:if test="${empty applicationlist}">
                                        <tr>
                                            <td colspan="7" class="text-center py-5">
                                                <div class="py-4">
                                                    <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                                    <h6 class="fw-semibold text-muted">No Applications Found</h6>
                                                    <p class="text-muted small">Search for a job number to view applications</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <!-- Instructions Card -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-transparent border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-info-circle text-primary me-2"></i>
                            Batch Processing Guide
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-dark border mb-3">
                            <div class="d-flex align-items-start">
                                <div class="me-3">
                                    <i class="fas fa-lightbulb text-warning fs-5"></i>
                                </div>
                                <div class="w-100">
                                    <div class="fw-semibold mb-2">Quick Start Guide</div>
                                    <div class="text-muted fs-13">
                                        <ul class="mb-0 ps-3">
                                            <li>Search for jobs using Job Number</li>
                                            <li>Add applications to batch list</li>
                                            <li>Process multiple applications in batches</li>
                                            <li>Track batch processing status</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="alert alert-info border mb-3">
                            <div class="d-flex align-items-start">
                                <div class="me-3">
                                    <i class="fas fa-exclamation-circle text-info fs-5"></i>
                                </div>
                                <div class="w-100">
                                    <div class="fw-semibold mb-2">Important Notes</div>
                                    <div class="text-muted fs-13">
                                        <ul class="mb-0 ps-3">
                                            <li>Applications with pending objections are highlighted in red</li>
                                            <li>Review application status before adding to batch</li>
                                            <li>Complete all required fields before processing</li>
                                            <li>Save your work regularly</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="alert alert-success border">
                            <div class="d-flex align-items-start">
                                <div class="me-3">
                                    <i class="fas fa-rocket text-success fs-5"></i>
                                </div>
                                <div class="w-100">
                                    <div class="fw-semibold mb-2">Best Practices</div>
                                    <div class="text-muted fs-13">
                                        <ul class="mb-0 ps-3">
                                            <li>Process similar application types together</li>
                                            <li>Verify application details before adding to batch</li>
                                            <li>Monitor batch processing queues</li>
                                            <li>Complete batches within SLA timelines</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Statistics Card -->
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-transparent border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-chart-pie text-success me-2"></i>
                            Processing Summary
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                            <div class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary bg-opacity-10 rounded p-2 me-3">
                                        <i class="fas fa-clock text-primary"></i>
                                    </div>
                                    <span class="fw-medium">Pending Applications</span>
                                </div>
                                <span class="badge bg-primary rounded-pill px-3 py-2">${fn:length(applicationlist)}</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <div class="d-flex align-items-center">
                                    <div class="bg-danger bg-opacity-10 rounded p-2 me-3">
                                        <i class="fas fa-exclamation-triangle text-danger"></i>
                                    </div>
                                    <span class="fw-medium">With Objections</span>
                                </div>
                                <span class="badge bg-danger rounded-pill px-3 py-2">
                                    <c:set var="objectionCount" value="0" />
                                    <c:forEach items="${applicationlist}" var="app">
                                        <c:if test="${app.objections > 0}">
                                            <c:set var="objectionCount" value="${objectionCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${objectionCount}
                                </span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <div class="d-flex align-items-center">
                                    <div class="bg-success bg-opacity-10 rounded p-2 me-3">
                                        <i class="fas fa-check-circle text-success"></i>
                                    </div>
                                    <span class="fw-medium">Ready to Process</span>
                                </div>
                                <span class="badge bg-success rounded-pill px-3 py-2">
                                    ${fn:length(applicationlist) - objectionCount}
                                </span>
                            </div>
                        </div>
                        
                        <hr class="my-3">
                        
                        <div class="d-grid gap-2">
                            <button class="btn btn-outline-primary" id="btnViewBatchlistSidebar">
                                <i class="fas fa-list me-2"></i>
                                View Active Batch Lists
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Batch Purpose -->
<div class="modal fade" id="askForPurposeOfBatching" tabindex="-1" aria-labelledby="askForPurposeOfBatchingLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-semibold" id="askForPurposeOfBatchingLabel">
                    <i class="fas fa-list text-info me-2"></i>
                    Add to Batch List
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p class="text-muted mb-3">Please specify the purpose for batching this application:</p>
                <div class="mb-3">
                    <label for="batchPurpose" class="form-label fw-medium">Batch Purpose</label>
                    <input type="text" class="form-control" id="batchPurpose" placeholder="e.g., Examination, Verification, etc.">
                </div>
                <div class="mb-3">
                    <label for="batchNotes" class="form-label fw-medium">Additional Notes (Optional)</label>
                    <textarea class="form-control" id="batchNotes" rows="2" placeholder="Add any additional notes..."></textarea>
                </div>
            </div>
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-info" id="confirmAddToBatch">
                    <i class="fas fa-check me-1"></i>
                    Add to Batch
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Initialize DataTable
        if ($.fn.DataTable) {
            $('#tbl_search_for_job_details_datatable').DataTable({
                responsive: true,
                pageLength: 10,
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search...",
                    lengthMenu: "Show _MENU_ entries",
                    info: "Showing _START_ to _END_ of _TOTAL_ entries",
                    paginate: {
                        first: '<i class="fas fa-angle-double-left"></i>',
                        previous: '<i class="fas fa-angle-left"></i>',
                        next: '<i class="fas fa-angle-right"></i>',
                        last: '<i class="fas fa-angle-double-right"></i>'
                    }
                },
                dom: '<"d-flex justify-content-between align-items-center mb-3"<"d-flex"l><"d-flex"f>>rt<"d-flex justify-content-between align-items-center mt-3"<"d-flex"i><"d-flex"p>>'
            });
        }
        
        // Initialize Bootstrap tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
        
        // Search button handler
        $('#btn_scm_job_number_search').click(function() {
            var jobNumber = $('#scm_job_number_search').val();
            if (jobNumber) {
                // Add your search logic here
                console.log('Searching for job number:', jobNumber);
            } else {
                // Show error message
                $('#searchJobErrorAlert').html(
                    '<div class="alert alert-warning alert-dismissible fade show" role="alert">' +
                    '<i class="fas fa-exclamation-triangle me-2"></i>' +
                    'Please enter a job number to search.' +
                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
                    '</div>'
                );
            }
        });
        
        // View Batch List button handlers
        $('#btnViewBatchlist, #btnViewBatchlistSidebar').click(function() {
            // Add your view batch list logic here
            console.log('View Batch List clicked');
        });
        
        // Confirm Add to Batch
        $('#confirmAddToBatch').click(function() {
            var purpose = $('#batchPurpose').val();
            if (!purpose) {
                alert('Please enter a batch purpose');
                return;
            }
            // Add your add to batch logic here
            console.log('Adding to batch with purpose:', purpose);
            $('#askForPurposeOfBatching').modal('hide');
            
            // Show success message
            var successAlert = 
                '<div class="alert alert-success alert-dismissible fade show position-fixed bottom-0 end-0 m-3" role="alert" style="z-index: 9999;">' +
                '<i class="fas fa-check-circle me-2"></i>' +
                'Application successfully added to batch list.' +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
                '</div>';
            $('body').append(successAlert);
            
            // Clear input
            $('#batchPurpose').val('');
            $('#batchNotes').val('');
        });
        
        // Clear modal on hide
        $('#askForPurposeOfBatching').on('hidden.bs.modal', function() {
            $('#batchPurpose').val('');
            $('#batchNotes').val('');
        });
        
        // Enter key press for search
        $('#scm_job_number_search').keypress(function(e) {
            if (e.which === 13) {
                $('#btn_scm_job_number_search').click();
            }
        });
    });
</script>

<style>
    /* Custom styles to match the design */
    .card-hover {
        transition: all 0.3s ease;
    }
    
    .card-hover:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
    }
    
    .page-header-breadcrumb {
        padding: 1rem 0;
    }
    
    .fs-18 {
        font-size: 18px;
    }
    
    .fs-13 {
        font-size: 13px;
    }
    
    .bg-opacity-10 {
        --bs-bg-opacity: 0.1;
    }
    
    .table > :not(caption) > * > * {
        padding: 1rem 0.75rem;
    }
    
    .list-group-borderless .list-group-item {
        border: none;
        padding: 0.75rem 0;
    }
    
    .dataTables_length select {
        min-width: 60px;
        margin: 0 5px;
    }
    
    .dataTables_filter input {
        border: 1px solid #dee2e6;
        border-radius: 0.375rem;
        padding: 0.375rem 0.75rem;
        margin-left: 0.5rem;
    }
    
    .dataTables_filter input:focus {
        border-color: #86b7fe;
        outline: 0;
        box-shadow: 0 0 0 0.25rem rgba(13,110,253,0.25);
    }
    
    .paginate_button {
        margin: 0 2px;
    }
    
    .paginate_button .page-link {
        border-radius: 0.375rem !important;
    }
    
    /* Alert positioning */
    .position-fixed {
        position: fixed;
        bottom: 20px;
        right: 20px;
        min-width: 300px;
        animation: slideInRight 0.3s ease;
    }
    
    @keyframes slideInRight {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
</style>