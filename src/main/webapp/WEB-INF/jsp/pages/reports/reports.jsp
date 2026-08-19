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
        background: linear-gradient(135deg, #6c757d 0%, #212529 100%);
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

    .report-table-toolbar {
        border: 1px solid #e9ecef;
        background: #f8f9fa;
        border-radius: 8px;
        padding: 0.75rem;
    }

    .report-table-toolbar .view-presets .btn.active {
        color: #fff;
        background: #0d6efd;
        border-color: #0d6efd;
    }

    #job_casemgtdetailsdataTable_elis_reports_wrapper.report-density-compact td,
    #job_casemgtdetailsdataTable_elis_reports_wrapper.report-density-compact th {
        padding: 0.45rem 0.6rem;
        font-size: 0.78rem;
    }

    #job_casemgtdetailsdataTable_elis_reports_wrapper.report-density-comfortable td,
    #job_casemgtdetailsdataTable_elis_reports_wrapper.report-density-comfortable th {
        padding: 0.9rem 1rem;
    }

    .report-row-details td {
        background: #f8f9fa !important;
        white-space: normal !important;
    }

    .report-detail-label {
        color: #6c757d;
        font-size: 0.72rem;
        font-weight: 600;
        text-transform: uppercase;
    }

    .report-detail-value {
        overflow-wrap: anywhere;
    }

    div.dt-button-collection.report-column-chooser {
        width: min(90vw, 380px) !important;
        max-height: 70vh;
        overflow-y: auto;
        color: #212529;
        border-radius: 8px;
    }

    div.dt-button-collection.report-column-chooser .dt-button-collection-title {
        color: #212529;
        font-weight: 600;
    }

    div.dt-button-collection.report-column-chooser .buttons-columnVisibility {
        display: grid !important;
        grid-template-columns: 1rem minmax(0, 1fr);
        align-items: center;
        gap: 0.75rem;
        width: 100% !important;
        min-width: 0 !important;
        padding: 0.65rem 0.75rem !important;
        color: #495057;
        text-align: left;
        white-space: normal;
        overflow: visible;
    }

    div.dt-button-collection.report-column-chooser .buttons-columnVisibility::before {
        content: "";
        position: static;
        width: 1rem;
        height: 1rem;
        box-sizing: border-box;
        border: 2px solid #6c757d;
        border-radius: 3px;
        background: #fff;
    }

    div.dt-button-collection.report-column-chooser .buttons-columnVisibility.active {
        color: #0d6efd;
        background: #e7f1ff;
        font-weight: 600;
    }

    div.dt-button-collection.report-column-chooser .buttons-columnVisibility.active::before {
        content: "\2713";
        color: #fff;
        border-color: #0d6efd;
        background: #0d6efd;
        font-size: 0.75rem;
        line-height: 0.75rem;
        text-align: center;
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

    .other-report-summary-card {
        min-height: 118px;
        border: 1px solid #edf0f4;
        border-radius: 8px;
        background: #ffffff;
        box-shadow: 0 8px 20px rgba(17, 24, 39, 0.05);
    }

    .other-report-summary-card[data-filter] {
        cursor: pointer;
        transition: border-color 0.2s ease, box-shadow 0.2s ease, transform 0.2s ease;
    }

    .other-report-summary-card[data-filter]:hover,
    .other-report-summary-card[data-filter]:focus {
        border-color: #667eea;
        box-shadow: 0 12px 26px rgba(102, 126, 234, 0.14);
        outline: none;
        transform: translateY(-2px);
    }

    .other-report-summary-card.active {
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.14), 0 10px 24px rgba(17, 24, 39, 0.06);
    }

    .other-report-summary-card .metric-label {
        color: #6c757d;
        font-size: 0.78rem;
        font-weight: 700;
        letter-spacing: 0;
        text-transform: uppercase;
    }

    .other-report-summary-card .metric-value {
        color: #212529;
        font-size: 1.65rem;
        font-weight: 800;
        line-height: 1.1;
    }

    .other-report-summary-card .metric-subtext {
        color: #6c757d;
        font-size: 0.82rem;
    }

    .other-report-summary-card .metric-icon {
        align-items: center;
        border-radius: 8px;
        display: flex;
        height: 42px;
        justify-content: center;
        width: 42px;
    }

    .metric-icon.total {
        background: rgba(102, 126, 234, 0.12);
        color: #667eea;
    }

    .metric-icon.completed {
        background: rgba(40, 167, 69, 0.12);
        color: #28a745;
    }

    .metric-icon.pending {
        background: rgba(255, 193, 7, 0.18);
        color: #a66f00;
    }

    .metric-icon.rate {
        background: rgba(23, 162, 184, 0.13);
        color: #14879a;
    }

    .other-report-progress {
        height: 7px;
        border-radius: 999px;
        background: #eef1f5;
        overflow: hidden;
    }

    .other-report-progress span {
        display: block;
        height: 100%;
        border-radius: inherit;
        background: linear-gradient(90deg, #28a745 0%, #17a2b8 100%);
    }

    .purpose-card {
        border: 1px solid #edf0f4;
        border-radius: 8px;
        background: #ffffff;
        height: 100%;
    }

    .purpose-card-title {
        color: #212529;
        font-weight: 700;
        line-height: 1.25;
    }

    .purpose-card-number {
        color: #212529;
        font-size: 1.2rem;
        font-weight: 800;
    }

    .purpose-card-label {
        color: #6c757d;
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
    }

    .other-report-empty-state {
        border: 1px dashed #ced4da;
        border-radius: 8px;
        color: #6c757d;
        padding: 1.25rem;
        text-align: center;
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
                                                    <!-- <option value="gra_stamp_duty_report">GRA Stamp Duty Report</option>
                                                    <option value="lrd_plotting_report">LRD Plotting Report</option> -->
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
                                                    <option value="0">All Subservices</option>
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
                                                 <i class="ri-file-chart-line me-1"></i>Generate Report
                                            </button>
                                            <!-- <button type="button" class="btn btn-success" id="btn_generate_details_reports_new_csv">
                                                <i class="ri-download-line me-1"></i>Download Report
                                            </button> -->
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
                        <h4 class="mb-0">Report by Unit/Users</h4>
                    </div>
                    
                    <div class="card-body">
                        <div class="accordion" id="unitReportAccordion">
                            <div class="accordion-item border-0">
                                <h2 class="accordion-header" id="divisionReportHeading">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#unitReportCollapse">
                                        <i class="ri-filter-line me-2"></i>Filter Options
                                    </button>
                                </h2>
                                <div id="unitReportCollapse" class="accordion-collapse collapse show" data-bs-parent="#unitReportAccordion">
                                    <div class="accordion-body p-0 pt-3">
                                         <input type="hidden" value="${userid}" id="user_id">
                                        <input type="hidden" value="${unit_id}" id="user_unit">
                                        <input type="hidden" value="${division}" id="user_division">
                                        <input type="hidden" value="${unit_name}" id="unit_name">
                                        <input type="hidden" value="${region_id}" id="region_id">
                                        <input type="hidden" id="select-user">
                                        <input type="hidden" id="startdate">
                                        <input type="hidden" id="enddate">
                                        <input type="hidden" id="start_date" name="start_date">
                                        <input type="hidden" id="end_date" name="end_date">
                                        <input type="hidden" id="survey_select" name="survey_select">

                                        <div class="row g-3">
                                            <div class="col-12">
                                                 <label class="form-label">Status Type</label>
                                                <select name="type_of_report_name_1" id="type_of_report_name_1" class="form-select form-select-sm" required>
                                                    <option value="Received">Received</option>
                                                    <option value="Batched">Batched</option>
                                                </select>
                                            </div>

                                            <div class="col-12">
                                                <label class="form-label">Select Region</label>
                                                <select id="sel_change_region_compliance_1" class="form-select form-select-sm">
                                                    <option selected value="0">Select</option>
                                                    <c:forEach items="${officeregionlist}" var="officeregion">
                                                        <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            
                                            <div class="col-12">
                                                <label class="form-label">Division</label>
                                                <select id="ur_division" class="form-select form-select-sm">
                                                    <!-- Options will be loaded dynamically -->
                                                </select>
                                            </div>
                                            
                                            <div class="col-12">
                                                <label class="form-label">Unit</label>
                                                <select id="ur_units" class="form-select form-select-sm">
                                                    <!-- Options will be loaded dynamically -->
                                                </select>
                                            </div>
                                            
                                            <div class="col-12">
                                               <label class="form-label">User</label>
                                                <select name="by_batched" id="by_batched" class="form-select form-select-sm" required>
                                                    <!-- Options will be loaded dynamically -->
                                                </select>
                                            </div>
                                        
                                           <div class="col-md-6">
                                                <label class="form-label">Date From</label>
                                                <input type="text" id="datefrom" class="form-control form-control-sm" placeholder="Select Start Date" required>
                                            </div>
                                            
                                            <div class="col-md-6">
                                                <label class="form-label">Date To</label>
                                                <input type="text" id="dateto" class="form-control form-control-sm" placeholder="Select End Date" required>
                                            </div>

                                        </div>
                                        
                                        <div class="action-buttons mt-4 d-flex gap-2">
                                            <button type="button" class="btn btn-primary" id="btn_generate_details_reports_1">
                                                 <i class="ri-file-chart-line me-1"></i>Generate Report
                                            </button>
                                            <!-- <button type="button" class="btn btn-success" id="btn_generate_details_based_on_users_csv">
                                                <i class="ri-download-line me-1"></i>Download Report
                                            </button> -->
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
                            <div id="general_reporting_summary_cards" class="row g-3 mb-3"></div>
                            <div id="general_reporting_breakdown" class="accordion mb-3 d-none">
                                <div class="accordion-item border-0">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#generalReportingGroups" aria-expanded="true">
                                            <i class="ri-pie-chart-2-line me-2"></i> Report Breakdown
                                        </button>
                                    </h2>
                                    <div id="generalReportingGroups" class="accordion-collapse collapse show">
                                        <div class="accordion-body bg-light rounded-bottom">
                                            <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
                                                <div>
                                                    <h6 class="mb-1">Grouped report summary</h6>
                                                    <small class="text-muted">Choose one category to keep the report focused.</small>
                                                </div>
                                                <div class="d-flex flex-wrap align-items-center gap-2">
                                                    <label for="general_reporting_group_by" class="form-label mb-0 text-nowrap">Group by</label>
                                                    <select id="general_reporting_group_by" class="form-select form-select-sm">
                                                        <option value="business_process_sub_name">Application Type</option>
                                                        <option value="regional_name">Region</option>
                                                        <option value="locality">Locality</option>
                                                        <option value="district">Registration District</option>
                                                        <option value="nature_of_instrument">Nature of Instrument</option>
                                                    </select>
                                                    <button type="button" id="export_general_group_image" class="btn btn-sm btn-outline-primary text-nowrap">
                                                        <i class="ri-image-line me-1"></i>Image
                                                    </button>
                                                    <button type="button" id="export_general_group_pdf" class="btn btn-sm btn-outline-danger text-nowrap">
                                                        <i class="ri-file-pdf-2-line me-1"></i>PDF
                                                    </button>
                                                </div>
                                            </div>
                                            <div id="general_reporting_breakdown_cards" class="row g-3"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="report-table-toolbar d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
                                <div>
                                    <div class="small fw-semibold mb-2">Table view</div>
                                    <div class="btn-group btn-group-sm view-presets flex-wrap" role="group" aria-label="Report column presets">
                                        <button type="button" class="btn btn-outline-primary active" data-report-view="overview">Overview</button>
                                        <button type="button" class="btn btn-outline-primary" data-report-view="applicant">Applicant</button>
                                        <button type="button" class="btn btn-outline-primary" data-report-view="property">Property</button>
                                        <button type="button" class="btn btn-outline-primary" data-report-view="registration">Registration</button>
                                        <button type="button" class="btn btn-outline-primary" data-report-view="timeline">Timeline</button>
                                        <button type="button" class="btn btn-outline-primary" data-report-view="all">All Columns</button>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <label for="report_table_density" class="form-label mb-0 text-nowrap">Row density</label>
                                    <select id="report_table_density" class="form-select form-select-sm">
                                        <option value="standard">Standard</option>
                                        <option value="compact">Compact</option>
                                        <option value="comfortable">Comfortable</option>
                                    </select>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover data-table text-nowrap w-100" id="job_casemgtdetailsdataTable_elis_reports">
                                    <thead>
                                        <tr>
                                            <th class="no-export" aria-label="Expand details"></th>
                                            <th>Job Number</th>
                                            <th>Applicant Name</th>
                                            <th>Application Type</th>
                                            <th>Date Received</th>
                                            <th>Job Status</th>
                                            <th>Locality</th>
                                            <th>Region</th>
                                            <th>Certificate Number</th>
                                            <th>Registration District</th>
                                            <th>Date of Instrument</th>
                                            <th>Grantor</th>
                                            <th>Nature of Instrument</th>
                                             <th>Date of Registration</th>
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


<!-- Reporting Modal (Bootstrap 5) -->
<div class="modal fade effect-scale modal-blur" id="reporting_modal" tabindex="-1" aria-labelledby="reportingModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header bg-gradient-primary">
                <div class="d-flex align-items-center w-100">
                    <div class="modal-icon-container me-3">
                        <div class="avatar avatar-lg bg-dark">
                            <i class="ri-file-list-line text-primary fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title text-dark" id="reportingModalLabel">
                            <span id="reportheading"></span>
                        </h5>
                        <p class="text-dark-50 mb-0">Application Report Details</p>
                    </div>
                    <button type="button" class="btn-close btn-close-dark" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover data-table" id="reporting_table" width="100%" cellspacing="0">
                        <thead class="table-light">
                            <tr>
                                <th>Applicant Name</th>
                                <th>Job Number</th>
                                <th>Application Type</th>
                                <th>Application Destination</th>
                                <th>Date Batched</th>
                                <th>Job Purpose</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Data will be populated here -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Other Reporting Modal (Bootstrap 5) -->
<div class="modal fade effect-scale modal-blur" id="other_reporting_modal" tabindex="-1" aria-labelledby="otherReportingModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-gradient-primary">
                <div class="d-flex align-items-center w-100">
                    <div class="modal-icon-container me-3">
                        <div class="avatar avatar-lg bg-dark">
                            <i class="ri-file-list-line text-primary fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="modal-title text-dark" id="otherReportingModalLabel">
                            <span id="reportheading2"></span>
                        </h5>
                        <p class="text-dark-50 mb-0">Application Report Details</p>
                    </div>
                    <button type="button" class="btn-close btn-close-dark" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            <div class="modal-body">
                <div id="other_reporting_summary_cards" class="row g-3 mb-3"></div>
                <div class="accordion mb-3" id="otherReportingAccordion">
                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="otherReportingBreakdownHeading">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#otherReportingBreakdown" aria-expanded="true" aria-controls="otherReportingBreakdown">
                                <i class="ri-pie-chart-2-line me-2"></i> Report Summary
                            </button>
                        </h2>
                        <div id="otherReportingBreakdown" class="accordion-collapse collapse show" aria-labelledby="otherReportingBreakdownHeading" data-bs-parent="#otherReportingAccordion">
                            <div class="accordion-body bg-light rounded-bottom">
                                <div id="other_reporting_breakdown_cards" class="row g-3"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover data-table" id="other_reporting_table" width="100%" cellspacing="0">
                        <thead class="table-light">
                            <tr>
                                <th>Applicant Name</th>
                                <th>Job Number</th>
                                <th>Application Type</th>
                                <th>Received By</th>
                                <th>Date Received</th>
                                <th>Job Purpose</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Data will be populated here -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Cabinet Modal (Bootstrap 5) -->
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
                                    <button type="button" class="btn btn-sm btn-outline-primary" id="btnExportHistory">
                                        <i class="fas fa-download me-2"></i>Export
                                    </button>
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

<script>
    // Initialize Select2 for better dropdown styling
    $(document).ready(function() {
        $('#by_batched').select2({
            placeholder: "Select User",
            allowClear: true,
            width: '100%',
            dropdownParent: $('#unitReportCollapse')
        });
        
        // Initialize date pickers
        initializeDatePickers();
    });
    
    function initializeDatePickers() {
        // You can use flatpickr or any other date picker here
        // For example:
        // flatpickr("#datefrom", { dateFormat: "Y-m-d" });
        // flatpickr("#dateto", { dateFormat: "Y-m-d" });
    }
    
    // Update the existing apps_report.js to use Bootstrap 5
    // Make sure to change data-dismiss to data-bs-dismiss
    // and data-toggle to data-bs-toggle in your JavaScript file
</script>



<script>
    function printStatistics() {
        // Implementation for printing statistics
        window.print();
    }
</script>
