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

<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">ELIS Reports</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Comprehensive reporting system for ${fullname}</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Reports</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <!-- Start::row-1 -->
        <div class="row">
            <!-- Service Type Reports -->
            <div class="col-xl-6 col-lg-6 mb-4">
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="d-flex align-items-center">
                            <i class="ri-database-2-line text-primary me-2"></i>
                            <h5 class="card-title mb-0">Report by Service Types</h5>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="accordion custom-accordion" id="serviceReportsAccordion">
                            <div class="accordion-item">
                                <div class="accordion-header" id="serviceHeading">
                                    <button class="accordion-button" type="button" 
                                            data-bs-toggle="collapse" 
                                            data-bs-target="#serviceCollapse">
                                        <i class="ri-settings-3-line me-2"></i>Service Reports Configuration
                                    </button>
                                </div>
                                <div id="serviceCollapse" class="accordion-collapse collapse show">
                                    <div class="accordion-body">
                                        <div class="mb-3">
                                            <label class="form-label">Application Status</label>
                                            <select name="type_of_report_name" id="type_of_report_name" 
                                                    class="form-select">
                                                <option value="All" selected>All</option>
                                                <option value="Completed">Completed</option>
                                                <option value="Pending">Pending</option>
                                                <option value="KEEP IN VIEW">Keep In View</option>
                                                <option value="gra_stamp_duty_report">GRA Stamp Duty Report</option>
                                                <option value="lrd_plotting_report">LRD Plotting Report</option>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Select Region</label>
                                            <select id="sel_change_region_compliance" class="form-select">
                                                <option selected value="0">All Regions</option>
                                                <c:forEach items="${officeregionlist}" var="officeregion">
                                                    <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Main Service</label>
                                            <select name="main_service_rpt" id="main_service_rpt" class="form-select">
                                                <option selected value="-1">Select Main Service</option>
                                                <option value="0">All Services</option>
                                                <c:forEach items="${main_services}" var="main_service">
                                                    <option value="${main_service.business_process_id}-${main_service.business_process_name}">
                                                        ${main_service.business_process_name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Sub Service</label>
                                            <select name="sub_service_rpt" id="sub_service_rpt" class="form-select">
                                                <option value="-1">Select Sub Service</option>
                                            </select>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label class="form-label">Date From</label>
                                                <input type="date" name="date_from" id="date_from" 
                                                       class="form-control">
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Date To</label>
                                                <input type="date" name="date_to" id="date_to" 
                                                       class="form-control">
                                            </div>
                                        </div>

                                        <div class="d-flex gap-2">
                                            <button type="button" class="btn btn-info flex-fill" 
                                                    id="btn_generate_details_reports_new">
                                                <i class="ri-eye-line me-1"></i>View Report Result
                                            </button>
                                            <button type="button" class="btn btn-success flex-fill" 
                                                    id="btn_generate_details_reports_new_csv">
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

            <!-- Division/User Reports -->
            <div class="col-xl-6 col-lg-6 mb-4">
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="d-flex align-items-center">
                            <i class="ri-user-line text-primary me-2"></i>
                            <h5 class="card-title mb-0">Report by Division/Users</h5>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="accordion custom-accordion" id="divisionReportsAccordion">
                            <div class="accordion-item">
                                <div class="accordion-header" id="divisionHeading">
                                    <button class="accordion-button" type="button" 
                                            data-bs-toggle="collapse" 
                                            data-bs-target="#divisionCollapse">
                                        <i class="ri-group-line me-2"></i>Division Reports Configuration
                                    </button>
                                </div>
                                <div id="divisionCollapse" class="accordion-collapse collapse show">
                                    <div class="accordion-body">
                                        <div class="mb-3">
                                            <label class="form-label">Report Type</label>
                                            <select name="type_of_report_name_rpt" id="type_of_report_name_rpt" 
                                                    class="form-select">
                                                <option value="individual_audit_trails">Individual Audit Trails</option>
                                                <option value="Division">Division</option>
                                                <option value="Unit" selected>Unit</option>
                                                <option value="Staff">Staff</option>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Select Region</label>
                                            <select id="get_change_region_compliance" class="form-select" required>
                                                <option selected disabled>Please Select Region</option>
                                                <c:forEach items="${officeregionlist}" var="officeregion">
                                                    <option value="${officeregion.ord_region_code}">
                                                        ${officeregion.ord_region_name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Division</label>
                                            <select id="unit_division_to_send_to_rpt" class="form-select">
                                                <option value="none">---Select Division---</option>
                                                <option value="LVD">LVD</option>
                                                <option value="LRD">LRD</option>
                                                <option value="PVLMD">PVLMD</option>
                                                <option value="SMD">SMD</option>
                                                <option value="RLO">RLO</option>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Unit</label>
                                            <input autocomplete="off" class="form-control" 
                                                   id="unit_to_send_to_rpt" type="text" 
                                                   list="listofunitsbatching_rpt" 
                                                   placeholder="Select/Enter Unit" required>
                                            <datalist id="listofunitsbatching_rpt"></datalist>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">User</label>
                                            <input class="form-control" id="user_to_send_to_rpt" 
                                                   name="user_to_send_to_rpt" type="text" autocomplete="off"
                                                   list="listofusersbatching_rpt" 
                                                   placeholder="Enter Username" required>
                                            <datalist id="listofusersbatching_rpt"></datalist>
                                        </div>

                                        <div class="d-flex gap-2">
                                            <button type="button" class="btn btn-primary flex-fill" 
                                                    id="btn_generate_details_based_on_users">
                                                <i class="ri-eye-line me-1"></i>View Report
                                            </button>
                                            <button type="button" class="btn btn-success flex-fill" 
                                                    id="btn_generate_details_based_on_users_csv">
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
        <!--End::row-1 -->

        <!-- Start::row-2 - Report Results -->
        <div class="row">
            <div class="col-xl-12">
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="d-flex align-items-center">
                            <i class="ri-file-list-line text-primary me-2"></i>
                            <h5 class="card-title mb-0">Report Results</h5>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="accordion custom-accordion" id="resultsAccordion">
                            <!-- Review Section -->
                            <div class="accordion-item">
                                <div class="accordion-header" id="reviewHeading">
                                    <button class="accordion-button" type="button" 
                                            data-bs-toggle="collapse" 
                                            data-bs-target="#reviewCollapse">
                                        <i class="ri-search-line me-2"></i>Review Results
                                    </button>
                                </div>
                                <div id="reviewCollapse" class="accordion-collapse collapse show">
                                    <div class="accordion-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0" 
                                                   id="job_casemgtdetailsdataTable_elis_reports">
                                                <thead class="bg-light">
                                                    <tr>
                                                        <th>Job Number</th>
                                                        <th>Applicant Name</th>
                                                        <th>Application Type</th>
                                                        <th>Date Received</th>
                                                        <th>Job Status</th>
                                                        <th>Case Number</th>
                                                        <th>Days(Received)</th>
                                                        <th>Days(Batched)</th>
                                                        <th>Date(Completed)</th>
                                                        <th>Days(Completed)</th>
                                                        <th>Date(Collected)</th>
                                                        <th width="80">View</th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Audit Report Section -->
                            <div class="accordion-item mt-3">
                                <div class="accordion-header" id="auditHeading">
                                    <button class="accordion-button collapsed" type="button" 
                                            data-bs-toggle="collapse" 
                                            data-bs-target="#auditCollapse">
                                        <i class="ri-history-line me-2"></i>Audit Report
                                    </button>
                                </div>
                                <div id="auditCollapse" class="accordion-collapse collapse">
                                    <div class="accordion-body">
                                        <div class="d-flex gap-2 mb-3">
                                            <button type="button" class="btn btn-primary" 
                                                    id="btn_generate_details_based_on_users_audit">
                                                <i class="ri-eye-line me-1"></i>View Report
                                            </button>
                                            <button type="button" class="btn btn-success" 
                                                    id="btn_generate_details_based_on_users_csv_audit">
                                                <i class="ri-download-line me-1"></i>Download Report
                                            </button>
                                        </div>
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0" 
                                                   id="job_casemgtdetailsdataTable_elis_reports_audit">
                                                <thead class="bg-light">
                                                    <tr>
                                                        <th>Job Number</th>
                                                        <th>Applicant Name</th>
                                                        <th>Application Type</th>
                                                        <th>Date Received</th>
                                                        <th>Job Status</th>
                                                        <th>Case Number</th>
                                                        <th>Days(Received)</th>
                                                        <th>Days(Batched)</th>
                                                        <th>Date(Completed)</th>
                                                        <th>Days(Completed)</th>
                                                        <th>Date(Collected)</th>
                                                        <th width="80">View</th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
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
        <!--End::row-2 -->

        <!-- Start::row-3 - Count Reports -->
        <div class="row mt-4">
            <div class="col-xl-12">
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="d-flex align-items-center">
                            <i class="ri-bar-chart-line text-primary me-2"></i>
                            <h5 class="card-title mb-0">Report Count by Service Types</h5>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="accordion custom-accordion" id="countReportsAccordion">
                            <div class="accordion-item">
                                <div class="accordion-header" id="countHeading">
                                    <button class="accordion-button" type="button" 
                                            data-bs-toggle="collapse" 
                                            data-bs-target="#countCollapse">
                                        <i class="ri-settings-3-line me-2"></i>Count Report Configuration
                                    </button>
                                </div>
                                <div id="countCollapse" class="accordion-collapse collapse show">
                                    <div class="accordion-body">
                                        <div class="row">
                                            <div class="col-md-12 mb-3">
                                                <label class="form-label">Select Region</label>
                                                <select id="report_count_sel_change_region_compliance" 
                                                        class="form-select">
                                                    <option selected value="0">All Regions</option>
                                                    <c:forEach items="${officeregionlist}" var="officeregion">
                                                        <option value="${officeregion.ord_region_code}">
                                                            ${officeregion.ord_region_name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Main Service</label>
                                                <select name="main_service_rpt" id="report_count_main_service_rpt" 
                                                        class="form-select">
                                                    <option value="-1">Select Main Service</option>
                                                    <c:forEach items="${main_services}" var="main_service">
                                                        <option value="${main_service.business_process_id}-${main_service.business_process_name}">
                                                            ${main_service.business_process_name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Sub Service</label>
                                                <select name="sub_service_rpt" id="report_count_sub_service_rpt" 
                                                        class="form-select">
                                                    <option value="-1">Select Sub Service</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Date From</label>
                                                <input type="date" name="date_from" id="report_count_date_from" 
                                                       class="form-control">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Date To</label>
                                                <input type="date" name="date_to" id="report_count_date_to" 
                                                       class="form-control">
                                            </div>
                                        </div>

                                        <div class="d-flex gap-2">
                                            <button type="button" class="btn btn-info flex-fill" 
                                                    id="btn_generate_count_reports">
                                                <i class="ri-eye-line me-1"></i>View Report Count Result
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
        <!--End::row-3 -->

    </div>
</div>

<!-- Report Count Modal -->
<div class="modal fade" id="report_count_modal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reportCountModalLabel">Report Count Summary</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <!-- Applications Pending -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card custom-card bg-primary-transparent border-0 shadow-none">
                            <div class="card-body">
                                <div class="d-flex align-items-start gap-3 flex-wrap">
                                    <div class="lh-1">
                                        <span class="avatar avatar-lg avatar-rounded bg-primary svg-white">
                                            <i class="ri-time-line fs-5"></i>
                                        </span>
                                    </div>
                                    <div class="flex-fill">
                                        <span class="d-block mb-1">Applications Pending</span>
                                        <div class="d-flex align-items-center gap-2">
                                            <h5 class="fw-semibold mb-0" id="app-pending">0</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Applications Completed -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card custom-card bg-success-transparent border-0 shadow-none">
                            <div class="card-body">
                                <div class="d-flex align-items-start gap-3 flex-wrap">
                                    <div class="lh-1">
                                        <span class="avatar avatar-lg avatar-rounded bg-success svg-white">
                                            <i class="ri-checkbox-circle-line fs-5"></i>
                                        </span>
                                    </div>
                                    <div class="flex-fill">
                                        <span class="d-block mb-1">Applications Completed</span>
                                        <div class="d-flex align-items-center gap-2">
                                            <h5 class="fw-semibold mb-0" id="app-completed">0</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Applications Queried -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card custom-card bg-danger-transparent border-0 shadow-none">
                            <div class="card-body">
                                <div class="d-flex align-items-start gap-3 flex-wrap">
                                    <div class="lh-1">
                                        <span class="avatar avatar-lg avatar-rounded bg-danger svg-white">
                                            <i class="ri-error-warning-line fs-5"></i>
                                        </span>
                                    </div>
                                    <div class="flex-fill">
                                        <span class="d-block mb-1">Applications Queried</span>
                                        <div class="d-flex align-items-center gap-2">
                                            <h5 class="fw-semibold mb-0" id="app-queried">0</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Keep In View Applications -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card custom-card bg-warning-transparent border-0 shadow-none">
                            <div class="card-body">
                                <div class="d-flex align-items-start gap-3 flex-wrap">
                                    <div class="lh-1">
                                        <span class="avatar avatar-lg avatar-rounded bg-warning svg-white">
                                            <i class="ri-eye-line fs-5"></i>
                                        </span>
                                    </div>
                                    <div class="flex-fill">
                                        <span class="d-block mb-1">Keep In View Applications</span>
                                        <div class="d-flex align-items-center gap-2">
                                            <h5 class="fw-semibold mb-0" id="app-kiv">0</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<style>
    /* Custom Accordion Styles */
    .custom-accordion .accordion-item {
        border: 1px solid #e9ecef;
        border-radius: 0.375rem;
        margin-bottom: 1rem;
        background-color: #fff;
    }
    
    .custom-accordion .accordion-header .accordion-button {
        background-color: #f9fafc;
        color: #3c4d62;
        font-weight: 500;
        padding: 1rem 1.25rem;
        border: none;
        border-radius: 0.375rem;
        box-shadow: none;
    }
    
    .custom-accordion .accordion-header .accordion-button:not(.collapsed) {
        background-color: #f0f7ff;
        color: #3a7bd5;
        border-bottom-left-radius: 0;
        border-bottom-right-radius: 0;
    }
    
    .custom-accordion .accordion-header .accordion-button:focus {
        box-shadow: 0 0 0 0.2rem rgba(58, 123, 213, 0.25);
    }
    
    /* Form Styles */
    .form-label {
        font-weight: 500;
        color: #3c4d62;
        font-size: 0.875rem;
        margin-bottom: 0.5rem;
    }
    
    .form-select, .form-control {
        border-radius: 0.375rem;
        border: 1px solid #e9ecef;
        font-size: 0.875rem;
        padding: 0.5rem 0.75rem;
    }
    
    .form-select:focus, .form-control:focus {
        border-color: #3a7bd5;
        box-shadow: 0 0 0 0.2rem rgba(58, 123, 213, 0.25);
    }
    
    /* Table Styles */
    .table {
        font-size: 0.875rem;
    }
    
    .table th {
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: #6c757d;
        background-color: #f9fafc;
        border-bottom: 2px solid #e9ecef;
        padding: 0.75rem 1rem;
    }
    
    .table td {
        padding: 0.75rem 1rem;
        vertical-align: middle;
        border-color: #e9ecef;
    }
    
    .table-hover tbody tr:hover {
        background-color: #f8f9fa;
    }
    
    /* Button Styles */
    .btn {
        font-weight: 500;
        padding: 0.5rem 1rem;
        border-radius: 0.375rem;
        font-size: 0.875rem;
        transition: all 0.2s ease;
    }
    
    .btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    
    .btn-primary {
        background-color: #3a7bd5;
        border-color: #3a7bd5;
    }
    
    .btn-info {
        background-color: #0dcaf0;
        border-color: #0dcaf0;
    }
    
    .btn-success {
        background-color: #198754;
        border-color: #198754;
    }
    
    /* Card Styles */
    .card.custom-card {
        border: none;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        border-radius: 0.5rem;
    }
    
    .card-header {
        background-color: #fff;
        border-bottom: 1px solid #e9ecef;
        padding: 1rem 1.25rem;
    }
    
    .card-title {
        color: #3c4d62;
        font-weight: 600;
        font-size: 1rem;
    }
    
    /* Modal Styles */
    .modal-content {
        border-radius: 0.5rem;
        border: none;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }
    
    .modal-header {
        background-color: #f9fafc;
        border-bottom: 1px solid #e9ecef;
        padding: 1rem 1.5rem;
    }
    
    .modal-body {
        padding: 1.5rem;
    }
    
    .modal-footer {
        border-top: 1px solid #e9ecef;
        padding: 1rem 1.5rem;
    }
    
    /* Stat Cards */
    .bg-primary-transparent {
        background-color: rgba(58, 123, 213, 0.1) !important;
    }
    
    .bg-success-transparent {
        background-color: rgba(25, 135, 84, 0.1) !important;
    }
    
    .bg-danger-transparent {
        background-color: rgba(220, 53, 69, 0.1) !important;
    }
    
    .bg-warning-transparent {
        background-color: rgba(255, 193, 7, 0.1) !important;
    }
    
    .svg-white {
        color: white;
    }
    
    /* Responsive Adjustments */
    @media (max-width: 768px) {
        .row {
            flex-direction: column;
        }
        
        .d-flex.gap-2 {
            flex-direction: column;
        }
        
        .btn {
            width: 100%;
            margin-bottom: 0.5rem;
        }
        
        .modal-dialog.modal-xl {
            margin: 0.5rem;
        }
        
        .table-responsive {
            font-size: 0.8125rem;
        }
    }
</style>

<script>
    // Initialize Bootstrap components
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize all tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
        
        // Initialize all popovers
        var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
        var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
            return new bootstrap.Popover(popoverTriggerEl);
        });
        
        // Modal instances
        var reportCountModal = new bootstrap.Modal(document.getElementById('report_count_modal'));
        
        // You can add your JavaScript functionality here
        console.log('ELIS Reports page loaded');
    });
</script>