<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<jsp:useBean id="now" class="java.util.Date" />

<style>
    .report-card {
        transition: all 0.3s ease;
        border: none;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .report-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1) !important;
    }

    .report-card .card-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-bottom: none;
        padding: 1.25rem 1.5rem;
    }

    .report-card .card-header h4 {
        color: white;
        margin: 0;
    }

    .section-icon {
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        margin-right: 15px;
    }

    .section-icon.service {
        background: rgba(102, 126, 234, 0.1);
        color: #667eea;
    }

    .section-icon.division {
        background: rgba(40, 167, 69, 0.1);
        color: #28a745;
    }

    .section-icon.count {
        background: rgba(23, 162, 184, 0.1);
        color: #17a2b8;
    }

    .form-control-sm {
        border-radius: 8px;
        border: 1px solid #dee2e6;
        padding: 0.5rem 0.75rem;
        font-size: 0.875rem;
    }

    .form-label {
        font-weight: 600;
        color: #495057;
        margin-bottom: 0.5rem;
        font-size: 0.875rem;
    }

    .action-buttons .btn {
        border-radius: 8px;
        padding: 0.5rem 1.25rem;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .action-buttons .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    .data-table {
        border-radius: 8px;
        overflow: hidden;
    }

    .data-table thead th {
        background-color: #f8f9fa;
        border-bottom: 2px solid #dee2e6;
        font-weight: 600;
        color: #495057;
        padding: 1rem;
    }

    .data-table tbody td {
        padding: 0.75rem 1rem;
        vertical-align: middle;
    }

    .accordion-button {
        border-radius: 8px !important;
        padding: 1rem 1.25rem;
        font-weight: 600;
    }

    .accordion-button:not(.collapsed) {
        background-color: rgba(102, 126, 234, 0.1);
        color: #667eea;
        box-shadow: none;
    }

    .accordion-button:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
    }

    .stats-card {
        border-left: 4px solid transparent;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .stats-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
    }

    .stats-card.border-primary {
        border-left-color: #667eea;
    }

    .stats-card.border-success {
        border-left-color: #28a745;
    }

    .stats-card.border-danger {
        border-left-color: #dc3545;
    }

    .stats-card.border-info {
        border-left-color: #17a2b8;
    }

    .modal-header.bg-gradient-primary {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 12px 12px 0 0;
    }

    .stats-icon {
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
    }

    .stats-icon.bg-primary {
        background-color: rgba(102, 126, 234, 0.1);
        color: #667eea;
    }

    .stats-icon.bg-success {
        background-color: rgba(40, 167, 69, 0.1);
        color: #28a745;
    }

    .stats-icon.bg-danger {
        background-color: rgba(220, 53, 69, 0.1);
        color: #dc3545;
    }

    .stats-icon.bg-info {
        background-color: rgba(23, 162, 184, 0.1);
        color: #17a2b8;
    }

    @media (max-width: 768px) {
        .report-card .card-header {
            padding: 1rem;
        }
        
        .section-icon {
            width: 40px;
            height: 40px;
            margin-right: 10px;
        }
        
        .stats-icon {
            width: 40px;
            height: 40px;
        }
        
        .action-buttons {
            flex-direction: column;
            gap: 10px;
        }
        
        .action-buttons .btn {
            width: 100%;
        }
    }
</style>

<!-- Begin Page Content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div class="d-flex align-center gap-2">
                    <div>
                        <h1 class="page-title fw-medium fs-20 mb-1"><i class="ri-bar-chart-line me-2 text-primary"></i>Reports Dashboard</h1>
                        <p class="text-muted fs-14 mb-0">Comprehensive reporting and analytics for ELIS system</p>
                    </div>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS Report</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Report User - ${fullname}</li>
                </ol>
            </div>
        </div>

        <div class="row">
            <!-- Report by Service Types -->
            <div class="col-lg-6 mb-4">
                <div class="card report-card h-100">
                    <div class="card-header d-flex align-items-center">
                        <div class="section-icon service">
                            <i class="ri-database-line fs-4"></i>
                        </div>
                        <h4 class="mb-0">Report by Service Types</h4>
                    </div>
                    
                    <div class="card-body">
                        <div class="accordion" id="serviceReportAccordion">
                            <div class="accordion-item border-0">
                                <h2 class="accordion-header" id="serviceReportHeading">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#serviceReportCollapse">
                                        <i class="ri-filter-line me-2"></i>Filter Options
                                    </button>
                                </h2>
                                <div id="serviceReportCollapse" class="accordion-collapse collapse show" data-bs-parent="#serviceReportAccordion">
                                    <div class="accordion-body p-0 pt-3">
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label class="form-label">Application Status</label>
                                                <select name="type_of_report_name" id="type_of_report_name" class="form-select form-select-sm">
                                                    <option value="All" selected>All</option>
                                                    <option value="Completed">Completed</option>
                                                    <option value="Pending">Pending</option>
                                                    <option value="KEEP IN VIEW">Keep In View</option>
                                                    <option value="gra_stamp_duty_report">GRA Stamp Duty Report</option>
                                                    <option value="lrd_plotting_report">LRD Plotting Report</option>
                                                </select>
                                            </div>
                                            
                                            <div class="col-12">
                                                <label class="form-label">Select Region</label>
                                                <select id="sel_change_region_compliance" class="form-select form-select-sm">
                                                    <option selected value="0">All Regions</option>
                                                    <c:forEach items="${officeregionlist}" var="officeregion">
                                                        <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            
                                            <div class="col-12">
                                                <label class="form-label">Main Service</label>
                                                <select name="main_service_rpt" id="main_service_rpt" class="form-select form-select-sm">
                                                    <option selected value="-1">Select Main Service</option>
                                                    <option value="0">All Services</option>
                                                    <c:forEach items="${main_services}" var="main_service">
                                                        <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            
                                            <div class="col-12" id="subServ">
                                                <label class="form-label">Sub Service</label>
                                                <select name="sub_service_rpt" id="sub_service_rpt" class="form-select form-select-sm">
                                                    <option value="-1">Select Sub Service</option>
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">Date From</label>
                                                <input type="date" name="date_from" id="date_from" class="form-control form-control-sm">
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">Date To</label>
                                                <input type="date" name="date_to" id="date_to" class="form-control form-control-sm">
                                            </div>
                                        </div>
                                        
                                        <div class="action-buttons mt-4 d-flex gap-2">
                                            <button type="button" class="btn btn-primary" id="btn_generate_details_reports_new">
                                                <i class="ri-eye-line me-1"></i>View Report Result
                                            </button>
                                            <button type="button" class="btn btn-success" id="btn_generate_details_reports_new_csv">
                                                <i class="ri-download-line me-1"></i>Download Report
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Report by Division/Users -->
            <div class="col-lg-6 mb-4">
                <div class="card report-card h-100">
                    <div class="card-header d-flex align-items-center">
                        <div class="section-icon division">
                            <i class="ri-user-line fs-4"></i>
                        </div>
                        <h4 class="mb-0">Report by Division/Users</h4>
                    </div>
                    
                    <div class="card-body">
                        <div class="accordion" id="divisionReportAccordion">
                            <div class="accordion-item border-0">
                                <h2 class="accordion-header" id="divisionReportHeading">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#divisionReportCollapse">
                                        <i class="ri-filter-line me-2"></i>Filter Options
                                    </button>
                                </h2>
                                <div id="divisionReportCollapse" class="accordion-collapse collapse show" data-bs-parent="#divisionReportAccordion">
                                    <div class="accordion-body p-0 pt-3">
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label class="form-label">Report Type</label>
                                                <select name="type_of_report_name_rpt" id="type_of_report_name_rpt" class="form-select form-select-sm">
                                                    <option value="Unit">Unit</option>
                                                    <option value="Staff" selected>Staff</option>
                                                </select>
                                            </div>
                                            
                                            <div class="col-12">
                                                <label class="form-label">Select Region</label>
                                                <select id="get_change_region_compliance" class="form-select form-select-sm" required>
                                                    <option selected disabled>Please Select</option>
                                                    <c:forEach items="${officeregionlist}" var="officeregion">
                                                        <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            
                                            <div class="col-12">
                                                <label class="form-label">Division</label>
                                                <select id="unit_division_to_send_to_rpt" class="form-select form-select-sm">
                                                    <option value="none">---Select Division---</option>
                                                    <option value="LVD">LVD</option>
                                                    <option value="LRD">LRD</option>
                                                    <option value="PVLMD">PVLMD</option>
                                                    <option value="SMD">SMD</option>
                                                    <option value="RLO">RLO</option>
                                                </select>
                                            </div>
                                            
                                            <div class="col-12">
                                                <label class="form-label">Unit</label>
                                                <input autocomplete="off" class="form-control form-control-sm" id="unit_to_send_to_rpt" type="text" list="listofunitsbatching_rpt" placeholder="Select/Enter Unit" required>
                                                <datalist id="listofunitsbatching_rpt"></datalist>
                                            </div>
                                            
                                            <div class="col-12" id="userSelect">
                                                <label class="form-label">User</label>
                                                <input class="form-control form-control-sm" id="user_to_send_to_rpt" name="user_to_send_to_rpt" type="text" autocomplete="off" list="listofusersbatching_rpt" placeholder="Enter Username" required>
                                                <datalist id="listofusersbatching_rpt"></datalist>
                                            </div>
                                        </div>
                                        
                                        <div class="action-buttons mt-4 d-flex gap-2">
                                            <button type="button" class="btn btn-primary" id="btn_generate_details_based_on_users">
                                                <i class="ri-eye-line me-1"></i>View Report
                                            </button>
                                            <button type="button" class="btn btn-success" id="btn_generate_details_based_on_users_csv">
                                                <i class="ri-download-line me-1"></i>Download Report
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Review and Audit Reports Section -->
        <div class="row">
            <div class="col-12">
                <!-- Review Report -->
                <div class="card report-card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center">
                            <div class="section-icon service">
                                <i class="ri-eye-line fs-4"></i>
                            </div>
                            <h4 class="mb-0">Application Review</h4>
                        </div>
                        <button class="btn btn-sm btn-outline-primary" type="button" data-bs-toggle="collapse" data-bs-target="#reviewCollapse">
                            <i class="ri-arrow-down-s-line"></i> Toggle
                        </button>
                    </div>
                    
                    <div class="collapse show" id="reviewCollapse">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover data-table" id="job_casemgtdetailsdataTable_elis_reports">
                                    <thead>
                                        <tr>
                                            <th>Job Number</th>
                                            <th>Applicant Name</th>
                                            <th>Application Type</th>
                                            <th>Date Received</th>
                                            <th>Job Status</th>
                                            <th>Case Number</th>
                                            <th>Days (Received)</th>
                                            <th>Days (Batched)</th>
                                            <th>Date (Completed)</th>
                                            <th>Days (Completed)</th>
                                            <th>Date (Collected)</th>
                                            <th>View</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Data will be populated here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Audit Report -->
                
            </div>
        </div>

        <!-- Report Count by Service Types -->
        <div class="row">
            <div class="col-12">
                <div class="card report-card">
                    <div class="card-header d-flex align-items-center">
                        <div class="section-icon count">
                            <i class="ri-bar-chart-2-line fs-4"></i>
                        </div>
                        <h4 class="mb-0">Report Count by Service Types</h4>
                    </div>
                    
                    <div class="card-body">
                        <div class="accordion" id="countReportAccordion">
                            <div class="accordion-item border-0">
                                <h2 class="accordion-header" id="countReportHeading">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#countReportCollapse">
                                        <i class="ri-filter-line me-2"></i>Filter Options
                                    </button>
                                </h2>
                                <div id="countReportCollapse" class="accordion-collapse collapse show" data-bs-parent="#countReportAccordion">
                                    <div class="accordion-body p-0 pt-3">
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label class="form-label">Select Region</label>
                                                <select id="report_count_sel_change_region_compliance" class="form-select form-select-sm">
                                                    <option selected value="0">All Regions</option>
                                                    <c:forEach items="${officeregionlist}" var="officeregion">
                                                        <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">Main Service</label>
                                                <select name="main_service_rpt" id="report_count_main_service_rpt" class="form-select form-select-sm">
                                                    <option value="-1">Select Main Service</option>
                                                    <option value="0">All Services</option>
                                                    <c:forEach items="${main_services}" var="main_service">
                                                        <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-6" id="countSubServ">
                                                <label class="form-label">Sub Service</label>
                                                <select name="sub_service_rpt" id="report_count_sub_service_rpt" class="form-select form-select-sm">
                                                    <option value="-1">Select Sub Service</option>
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">Date From</label>
                                                <input type="date" name="date_from" id="report_count_date_from" class="form-control form-control-sm">
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">Date To</label>
                                                <input type="date" name="date_to" id="report_count_date_to" class="form-control form-control-sm">
                                            </div>
                                        </div>
                                        
                                        <div class="action-buttons mt-4 d-flex gap-2">
                                            <button type="button" class="btn btn-info" id="btn_generate_count_reports">
                                                <i class="ri-eye-line me-1"></i>View Report Count Result
                                            </button>
                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#reportCountModal">
                                                <i class="ri-dashboard-line me-1"></i>View Statistics
                                            </button>
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

<!-- Report Count Statistics Modal -->
<div class="modal fade" id="reportCountModal" tabindex="-1" aria-labelledby="reportCountModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header bg-gradient-primary">
                <div class="d-flex align-items-center w-100">
                    <div class="modal-icon-container me-3">
                        <div class="avatar avatar-lg bg-white">
                            <i class="ri-bar-chart-2-line text-primary fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title text-white" id="reportCountModalLabel">Report Statistics Summary</h5>
                        <p class="text-white-50 mb-0">Application count overview</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <div class="modal-body">
                <div class="row">
                    <!-- Total Applications -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stats-card border-info h-100">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon bg-info me-3">
                                        <i class="ri-file-list-line fs-4"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small fw-semibold mb-1">Total Applications</div>
                                        <div id="totalApps" class="h4 fw-bold text-info mb-0">0</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Applications Pending -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stats-card border-primary h-100">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon bg-primary me-3">
                                        <i class="ri-time-line fs-4"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small fw-semibold mb-1">Applications Pending</div>
                                        <div id="app-pending" class="h4 fw-bold text-primary mb-0">0</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Applications Completed -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stats-card border-success h-100">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon bg-success me-3">
                                        <i class="ri-checkbox-circle-line fs-4"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small fw-semibold mb-1">Applications Completed</div>
                                        <div id="app-completed" class="h4 fw-bold text-success mb-0">0</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Applications Queried -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stats-card border-danger h-100">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon bg-danger me-3">
                                        <i class="ri-question-line fs-4"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small fw-semibold mb-1">Applications Queried</div>
                                        <div id="app-queried" class="h4 fw-bold text-danger mb-0">0</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
                <button type="button" class="btn btn-primary" onclick="printStatistics()">
                    <i class="ri-printer-line me-1"></i>Print Report
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    function printStatistics() {
        // Implementation for printing statistics
        window.print();
    }
</script>