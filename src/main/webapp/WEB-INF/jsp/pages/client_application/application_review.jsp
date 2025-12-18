<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<link href="../assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />

<style>
    :root {
        --primary: #2563eb;
        --secondary: #6b7280;
        --success: #10b981;
        --warning: #f59e0b;
        --danger: #ef4444;
        --info: #0ea5e9;
        --background: #f9fafb;
        --card-bg: #ffffff;
        --text-primary: #1f2937;
        --text-secondary: #6b7280;
        --border: #e5e7eb;
        --specific-request: #e0f2fe;
        --general-request: #fef3c7;
    }

    .case-management-dashboard {
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        background-color: var(--background);
        min-height: 100vh;
        color: var(--text-primary);
    }

    .dashboard-header {
        background: linear-gradient(135deg, var(--primary) 0%, #1d4ed8 100%);
        color: white;
        padding: 1.5rem;
        border-radius: 12px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-bottom: 1.5rem;
    }

    .breadcrumb {
        background: transparent;
        padding: 0;
        margin: 0;
        font-size: 0.875rem;
    }

    .breadcrumb-item {
        color: rgba(255, 255, 255, 0.9);
    }

    .breadcrumb-item a {
        color: rgba(255, 255, 255, 0.9);
        text-decoration: none;
        transition: color 0.2s;
    }

    .breadcrumb-item a:hover {
        color: white;
    }

    .breadcrumb-item.active {
        color: white;
    }

    .breadcrumb-item + .breadcrumb-item::before {
        color: rgba(255, 255, 255, 0.5);
    }

    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 1rem;
        margin-bottom: 1.5rem;
    }

    .stat-card {
        background: var(--card-bg);
        border-radius: 12px;
        padding: 1.25rem;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        border: 1px solid var(--border);
        text-decoration: none !important;
        display: block;
    }

    .stat-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        border-color: var(--primary);
    }

    .stat-content {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .stat-icon {
        width: 48px;
        height: 48px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
    }

    .stat-card-primary .stat-icon { 
        background: linear-gradient(135deg, rgba(37, 99, 235, 0.1) 0%, rgba(37, 99, 235, 0.2) 100%);
        color: var(--primary);
    }
    
    .stat-card-success .stat-icon { 
        background: linear-gradient(135deg, rgba(16, 185, 129, 0.1) 0%, rgba(16, 185, 129, 0.2) 100%);
        color: var(--success);
    }
    
    .stat-card-danger .stat-icon { 
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.1) 0%, rgba(239, 68, 68, 0.2) 100%);
        color: var(--danger);
    }

    .stat-card-info .stat-icon { 
        background: linear-gradient(135deg, rgba(14, 165, 233, 0.1) 0%, rgba(14, 165, 233, 0.2) 100%);
        color: var(--info);
    }

    .stat-text h6 {
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
        color: var(--text-secondary);
        margin: 0;
        letter-spacing: 0.5px;
    }

    .stat-text h3 {
        font-size: 1.75rem;
        font-weight: 700;
        margin: 0.25rem 0 0;
        color: var(--text-primary);
    }

    .main-card {
        background: var(--card-bg);
        border-radius: 12px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        overflow: hidden;
        border: 1px solid var(--border);
    }

    .card-header {
        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        padding: 1.25rem 1.5rem;
        border-bottom: 2px solid var(--border);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .card-title {
        font-size: 1.25rem;
        font-weight: 700;
        margin: 0;
        color: var(--text-primary);
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .card-title i {
        color: var(--primary);
    }

    .btn-action-group {
        background: linear-gradient(135deg, var(--primary) 0%, #1d4ed8 100%);
        color: white;
        padding: 0.625rem 1.25rem;
        border-radius: 8px;
        border: none;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: all 0.3s ease;
    }

    .btn-action-group:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        color: white;
    }

    .modern-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }

    .modern-table thead th {
        background: #f1f5f9;
        padding: 1rem 1.25rem;
        font-size: 0.75rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: var(--text-secondary);
        border-bottom: 2px solid var(--border);
        white-space: nowrap;
    }

    .modern-table tbody td {
        padding: 1rem 1.25rem;
        font-size: 0.875rem;
        border-bottom: 1px solid var(--border);
        vertical-align: middle;
    }

    .modern-table tbody tr:last-child td {
        border-bottom: none;
    }

    .modern-table tbody tr:hover {
        background-color: #f8fafc;
    }

    .table-specific {
        background-color: var(--specific-request);
    }

    .table-general {
        background-color: var(--general-request);
    }

    .table-danger {
        background-color: #fee2e2 !important;
    }

    .status-badge {
        padding: 0.375rem 0.75rem;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
        letter-spacing: 0.3px;
        display: inline-flex;
        align-items: center;
        gap: 0.25rem;
    }

    .badge-success { 
        background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
        color: white;
    }
    
    .badge-warning { 
        background: linear-gradient(135deg, var(--warning) 0%, #d97706 100%);
        color: white;
    }
    
    .badge-primary { 
        background: linear-gradient(135deg, var(--primary) 0%, #1d4ed8 100%);
        color: white;
    }
    
    .badge-secondary { 
        background: linear-gradient(135deg, var(--secondary) 0%, #4b5563 100%);
        color: white;
    }

    .action-buttons {
        display: flex;
        gap: 0.5rem;
    }

    .btn-outline-primary {
        border: 1px solid var(--primary);
        color: var(--primary);
        padding: 0.375rem 0.75rem;
        border-radius: 6px;
        transition: all 0.2s;
    }

    .btn-outline-primary:hover {
        background: var(--primary);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(37, 99, 235, 0.2);
    }

    .modal-content {
        border-radius: 12px;
        border: none;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .modal-header {
        background: linear-gradient(135deg, var(--primary) 0%, #1d4ed8 100%);
        color: white;
        border-radius: 12px 12px 0 0;
        padding: 1.25rem 1.5rem;
    }

    .modal-title {
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .btn-close {
        filter: invert(1);
        opacity: 0.8;
    }

    .btn-close:hover {
        opacity: 1;
    }

    .toast {
        border-radius: 12px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        border: none;
    }

    .toast-header {
        background: linear-gradient(135deg, var(--primary) 0%, #1d4ed8 100%);
        color: white;
        border-radius: 12px 12px 0 0;
    }

    @media (max-width: 768px) {
        .stats-grid {
            grid-template-columns: 1fr;
        }

        .card-header {
            flex-direction: column;
            gap: 1rem;
            text-align: center;
        }

        .btn-action-group {
            width: 100%;
            justify-content: center;
        }

        .modern-table {
            display: block;
        }

        .modern-table thead {
            display: none;
        }

        .modern-table tbody tr {
            display: block;
            margin-bottom: 1rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            background: var(--card-bg);
        }

        .modern-table tbody td {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 1rem;
            border: none;
            border-bottom: 1px solid var(--border);
        }

        .modern-table tbody td:last-child {
            border-bottom: none;
        }

        .modern-table tbody td:before {
            content: attr(data-label);
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 0.75rem;
            text-transform: uppercase;
            flex: 0 0 120px;
        }

        .action-buttons {
            justify-content: center;
        }

        .table-specific, .table-general, .table-danger {
            background-color: inherit !important;
        }

        .table-specific td, .table-general td, .table-danger td {
            background-color: inherit !important;
        }
    }

    @media (max-width: 576px) {
        .dashboard-header {
            padding: 1rem;
        }

        .stat-card {
            padding: 1rem;
        }

        .stat-content {
            gap: 0.75rem;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            font-size: 1rem;
        }

        .stat-text h3 {
            font-size: 1.5rem;
        }
    }

    .applicant-name {
        font-weight: 500;
        color: var(--text-primary);
    }

    .job-number {
        font-weight: 700;
        color: var(--primary);
    }

    .badge-objection {
        display: inline-flex;
        align-items: center;
        gap: 0.25rem;
        background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%);
        color: white;
        padding: 0.25rem 0.5rem;
        border-radius: 4px;
        font-size: 0.7rem;
        font-weight: 600;
    }
</style>

<div class="container-fluid case-management-dashboard py-4">
    <!-- Header with Breadcrumb -->
    <div class="dashboard-header">
        <nav style="--bs-breadcrumb-divider: '›';" aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="#"><i class="fas fa-home me-1"></i> Dashboard</a>
                </li>
                <li class="breadcrumb-item">
                    <a href="#">Staff Case Management</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="fas fa-folder-open me-1"></i> Applications for ${fullname}
                </li>
            </ol>
        </nav>
    </div>

    <!-- Hidden Inputs -->
    <input type="hidden" id="userid" value="${sessionScope.userid}">
    <input type="hidden" id="inc_1" value="${incoming}">
    <input type="hidden" id="com_3" value="${completed}">
    <input type="hidden" id="que_2" value="${queried}">
    <input type="hidden" id="awa_4" value="${awaiting_payment}">
    <input type="hidden" id="awa_req_5" value="${awaiting_request}">
    <input type="hidden" id="req_com_6" value="${completed_request}">

    <!-- Stats Grid -->
    <div class="stats-grid">
        <a href="#" class="stat-card stat-card-primary text-decoration-none btnLoadUnitApplications" data-id="1">
            <div class="stat-content">
                <div class="stat-icon">
                    <i class="fas fa-inbox"></i>
                </div>
                <div class="stat-text">
                    <h6>Incoming Files</h6>
                    <h3>${incoming}</h3>
                </div>
            </div>
        </a>

        <a href="#" class="stat-card stat-card-success text-decoration-none btnLoadUnitApplications" data-id="2">
            <div class="stat-content">
                <div class="stat-icon">
                    <i class="fas fa-comments"></i>
                </div>
                <div class="stat-text">
                    <h6>Queried Files</h6>
                    <h3>${queried}</h3>
                </div>
            </div>
        </a>

        <a href="#" class="stat-card stat-card-danger text-decoration-none" data-bs-toggle="modal" data-bs-target="#appsPassedDueModal">
            <div class="stat-content">
                <div class="stat-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <div class="stat-text">
                    <h6>Overdue Applications</h6>
                    <h3>${queried}</h3>
                </div>
            </div>
        </a>

        <a href="#" class="stat-card stat-card-info text-decoration-none">
            <div class="stat-content">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-text">
                    <h6>Pending Review</h6>
                    <h3>${awaiting_payment + awaiting_request}</h3>
                </div>
            </div>
        </a>
    </div>

    <!-- Main Application Table -->
    <div class="main-card">
        <div class="card-header">
            <h5 class="card-title">
                <i class="fas fa-file-alt"></i>
                Application Details
            </h5>
            <button class="btn btn-action-group" id="btnViewBatchlist">
                <i class="fas fa-eye"></i>
                View Batch List
            </button>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table id="job_batchedtouserlistdataTable" class="modern-table">
                    <thead>
                        <tr>
                            <th>Received Date</th>
                            <th>Job Number</th>
                            <th>Applicant Name</th>
                            <th>Job Category</th>
                            <th>Request Type</th>
                            <th>Purpose</th>
                            <th>Comment</th>
                            <th>Sent By</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${applicationlist}" var="appfiles">
                            <c:set var="rowClass" value="" />
                            <c:choose>
                                <c:when test="${appfiles.objections > 0}">
                                    <c:set var="rowClass" value="table-danger" />
                                </c:when>
                                <c:when test="${appfiles.request_category == 'SpecificWorkRequest'}">
                                    <c:set var="rowClass" value="table-specific" />
                                </c:when>
                                <c:when test="${appfiles.request_category == 'GeneralWorkRequest'}">
                                    <c:set var="rowClass" value="table-general" />
                                </c:when>
                            </c:choose>

                            <tr class="${rowClass}">
                                <td data-label="Received Date">
                                    <span class="text-muted">${appfiles.job_datesend}</span>
                                </td>
                                <td data-label="Job Number">
                                    <span class="job-number">${appfiles.job_number}</span>
                                </td>
                                <td data-label="Applicant Name">
                                    <div class="applicant-name" title="${appfiles.ar_name}">
                                        ${fn:substring(appfiles.ar_name, 0, 20)}${fn:length(appfiles.ar_name) > 20 ? "..." : ""}
                                    </div>
                                </td>
                                <td data-label="Job Category">
                                    ${appfiles.business_process_sub_name}
                                </td>
                                <td data-label="Request Type">
                                    ${appfiles.request_category}
                                </td>
                                <td data-label="Purpose">
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="status-badge badge 
                                            ${appfiles.current_application_status == 'Completed' ? 'badge-success' : 
                                              appfiles.current_application_status == 'Queried' ? 'badge-warning' : 
                                              appfiles.current_application_status == 'In Progress' ? 'badge-primary' : 'badge-secondary'}">
                                            ${fn:substring(appfiles.job_purpose, 0, 15)}${fn:length(appfiles.job_purpose) > 15 ? "..." : ""}
                                        </span>
                                        <c:if test="${appfiles.objections > 0}">
                                            <span class="badge-objection" title="${appfiles.objections} Objection(s)">
                                                <i class="fas fa-exclamation-circle"></i>
                                                ${appfiles.objections}
                                            </span>
                                        </c:if>
                                    </div>
                                </td>
                                <td data-label="Comment">
                                    <small class="text-muted">${appfiles.job_datesend}</small>
                                </td>
                                <td data-label="Sent By">
                                    ${appfiles.job_forwarded_by}
                                </td>
                                <td data-label="Actions">
                                    <div class="action-buttons justify-content-center">
                                        <button class="btn btn-outline-primary btn-sm btn-add-batch" 
                                                id="btnAddToBatchlist-${appfiles.job_number}" 
                                                data-job_number="${appfiles.job_number}" 
                                                data-ar_name="${appfiles.ar_name}" 
                                                data-business_process_sub_name="${appfiles.business_process_sub_name}" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#askForPurposeOfBatching">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                        <form action="request_application_progress_details_ai" method="post" class="d-inline">
                                            <input type="hidden" name="rq_id" value="${appfiles.rq_id}">
                                            <input type="hidden" name="case_number" value="${appfiles.case_number}">
                                            <input type="hidden" name="transaction_number" value="${appfiles.transaction_number}">
                                            <input type="hidden" name="job_number" value="${appfiles.job_number}">
                                            <input type="hidden" name="business_process_sub_name" value="${appfiles.business_process_sub_name}">
                                            <input type="hidden" name="job_purpose" value="Final Vetting">
                                            <input type="hidden" name="review_type" value="${appfiles.request_category}">
                                            <input type="hidden" name="review_instruction" value="${appfiles.remarks}">
                                            
                                            <button type="submit" name="save" class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-folder-open"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Responded Queries Modal (Bootstrap 5) -->
<div class="modal fade" id="respondedQueriesModal" tabindex="-1" aria-labelledby="respondedQueriesModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="respondedQueriesModalLabel">
                    <i class="fas fa-comments me-2"></i> 
                    Responded Queries at Unit ${unit_name}
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="modern-table" id="tbl_responded_queries_result">
                        <thead>
                            <tr>
                                <th><input class="form-check-input" type="checkbox" id="selectAllModal"></th>
                                <th>Job Number</th>
                                <th>Applicant Name</th>
                                <th>Business Process</th>
                                <th>Locality</th>
                                <th>Approved by</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Dynamic content will be loaded here -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i> Close
                </button>
                <button type="button" class="btn btn-primary">
                    <i class="fas fa-download me-1"></i> Export Selected
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Toast Confirmation (Bootstrap 5) -->
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div id="completeRequestToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <i class="fas fa-question-circle me-2"></i>
            <strong class="me-auto">Confirm Action</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            Are you sure you want to complete this request?
            <div class="mt-3">
                <button type="button" class="btn btn-primary btn-sm me-2" id="confirmCompleteYes">
                    <i class="fas fa-check me-1"></i> Yes
                </button>
                <button type="button" class="btn btn-secondary btn-sm" id="confirmCompleteNo" data-bs-dismiss="toast">
                    <i class="fas fa-times me-1"></i> No
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize Bootstrap tooltips
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Initialize toast
        var toastEl = document.getElementById('completeRequestToast');
        var toast = new bootstrap.Toast(toastEl, {
            autohide: false
        });

        // Table row hover effects
        const tableRows = document.querySelectorAll('#job_batchedtouserlistdataTable tbody tr');
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'translateX(4px)';
                this.style.transition = 'transform 0.2s ease';
            });
            
            row.addEventListener('mouseleave', function() {
                this.style.transform = 'translateX(0)';
            });
        });

        // Load applications on stat card click
        document.querySelectorAll('.btnLoadUnitApplications').forEach(button => {
            button.addEventListener('click', function(e) {
                e.preventDefault();
                const statusId = this.getAttribute('data-id');
                // Add your loading logic here
                console.log('Loading applications for status:', statusId);
            });
        });

        // Batch view button
        document.getElementById('btnViewBatchlist').addEventListener('click', function() {
            // Add your batch view logic here
            console.log('Viewing batch list');
        });
    });
</script>

