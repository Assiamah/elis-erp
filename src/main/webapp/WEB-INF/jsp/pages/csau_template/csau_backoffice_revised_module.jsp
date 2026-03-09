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
        <div class="page-header-breadcrumb">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                <h1 class="page-title fw-medium fs-18 mb-0">
                    <i class="fas fa-folder-open text-danger me-2"></i>Open Application</h1>
                    <p class="text-muted small mb-0"><i class="ri-information-line me-1 mt-2"></i>View and manage job applications.</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="#">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Open Application</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <div class="row">
            <!-- Main Content Area -->
            <div class="col-lg-8">
                <!-- Job Search Card -->
                <div class="card shadow-sm border-0 mb-4">
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
                                                <button class="btn btn-warning w-100" id="btn_scm_job_number_search_open">
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
                        <!-- <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2">
                            <i class="fas fa-file-alt me-1"></i>
                            Total: ${fn:length(applicationlist)} Applications
                        </span> -->
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
                                        <th class="fw-semibold text-center">Action</th>
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
                                            
                                            <!-- <td class="text-center">
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
                                            </td> -->
                                            
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
                                            
                                            <!-- <td class="text-center">
                                                <button class="btn btn-outline-secondary btn-sm" disabled>
                                                    <i class="fas fa-plus-circle"></i>
                                                </button>
                                            </td> -->
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
                    <div class="card-header bg-transparent py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="fas fa-info-circle text-primary me-2"></i>
                            Instructions
                        </h5>
                    </div>
                    <div class="card-body">
                        <!-- Quick Guide -->
                        <div class="mb-4">
                            <div class="list-group list-group-flush">
                                <div class="list-group-item border-0 px-0 py-2">
                                    <i class="bi bi-check-circle-fill text-success me-2 small"></i>
                                    <span class="small">Enter Job Number in the search field and click Search</span>
                                </div>
                                <div class="list-group-item border-0 px-0 py-2">
                                    <i class="bi bi-check-circle-fill text-success me-2 small"></i>
                                    <span class="small">Click "Work" button to open the application</span>
                                </div>
                            </div>
                        </div>

                        
                    </div>
                </div>

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