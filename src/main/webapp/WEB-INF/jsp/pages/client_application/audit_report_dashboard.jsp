<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<jsp:useBean id="now" class="java.util.Date" />

<style>
    .card {
        border-radius: 15px !important;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border: none;
        margin-bottom: 30px;
    }
    
    .card:hover {
        transform: translateY(-10px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
    }
    
    .stat-card .value {
        font-size: 2rem;
        font-weight: 700;
    }
    
    .stat-card .label {
        font-size: 0.9rem;
        color: #6c757d;
    }
    
    .bg-c-blue { background: linear-gradient(135deg, #3a7bd5, #3a6073); color: white; }
    .bg-c-green { background: linear-gradient(135deg, #A8E063, #56AB2F); color: white; }
    .bg-c-yellow { background: linear-gradient(135deg, #ffb347, #ffcc33); color: white; }
    .bg-c-orange { background: #fd7e14; color: white; }
    .bg-c-purple { background: #6f42c1; color: white; }
    .bg-c-pink { background: linear-gradient(135deg, #ff4d4d, #b30000); color: white; }
    .bg-c-teal { background: #20c997; color: white; }
    .bg-c-red { background: linear-gradient(135deg, #ff4d4d, #b30000); color: white; }
    .bg-c-indigo { background: linear-gradient(135deg, #667eea, #4c51bf); color: white; }
    .bg-c-cyan { background: linear-gradient(135deg, #36d1dc, #1e88a8); color: white; }

    .advanced-activity-logs-card {
        cursor: pointer;
    }

    .dashboard-title { font-size: 1.75rem; font-weight: 700; }
    .dashboard-subtitle { color: #6c757d; font-size: 1rem; }

    .modal-glass {
        backdrop-filter: blur(10px);
        background: rgba(255, 255, 255, 0.95);
    }

    .bg-light-gray { background-color: #f8f9fa; }

    .icon-container {
        width: 48px;
        height: 48px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .bg-opacity-20 { background-color: rgba(255, 255, 255, 0.2); }
    .hover-bg-opacity-30:hover { background-color: rgba(255, 255, 255, 0.3); }

    #activityMap, #addParcelActivityMap {
        width: 100%;
        height: 450px;
    }

    .legend-color {
        width: 15px;
        height: 8px;
        display: inline-block;
        vertical-align: middle;
        border-radius: 2px;
        margin-right: 6px;
    }

    .assignment-tabs-nav {
        flex-wrap: nowrap;
        overflow-x: auto;
        overflow-y: hidden;
        scrollbar-width: thin;
    }

    .assignment-tabs-nav .nav-link {
        white-space: nowrap;
    }

    .assignment-tab-content .tab-pane {
        min-height: 180px;
    }

    .milestone-export-footer {
        flex-wrap: wrap;
    }

    @media (max-width: 991.98px) {
        .milestone-tab-content .table {
            min-width: 850px;
        }

        .menu-template-tab-content .table {
            min-width: 600px;
        }
    }

    @media (max-width: 575.98px) {
        .milestone-export-footer .btn {
            flex: 1 1 100%;
        }
    }
</style>

 <!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
              <div>
                <h1 class="page-title fw-medium fs-18 mb-1">Audit Report Dashboard</h1>
                <!-- <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Manage and monitor application workflows</p> -->
              </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Audit Report Dashboard</li>
                </ol>
            </div>
        </div>

    <input type="hidden" id="startdate">
    <input type="hidden" id="start_date">
    <input type="hidden" id="enddate">
    <input type="hidden" id="end_date">

    <!-- Dashboard Header -->
    <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
        <div>
            <h1 class="h4 mb-1 text-gray-800 dashboard-title">User Activity Dashboard</h1>
            <p class="dashboard-subtitle fw-light">
                This Dashboard provides comprehensive visibility into user activities across all divisions. 
                Monitor staff login patterns, track changes made to land records, and analyze operational trends.
            </p>
        </div>
    </div>

    <!-- Date Filters -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <label class="form-label">Date From</label>
                    <input type="text" id="datefrom" class="form-control" placeholder="Select Date From">
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <label class="form-label">Date To</label>
                    <input type="text" id="dateto" class="form-control" placeholder="Select Date To">
                </div>
            </div>
        </div>
    </div>

    <!-- User Activity Summary Cards -->
    <div class="row mb-4 g-4">
        <div class="col-md-3">
            <div class="card bg-c-green shadow h-100 py-3 advanced-activity-logs-card" data-activity="New Transaction Added">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs fw-bold text-uppercase mb-1">New Transaction Added</div>
                            <div class="h5 mb-0 fw-bold">0</div>
                        </div>
                        <i class="fas fa-file-invoice-dollar fa-2x text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-c-blue shadow h-100 py-3 advanced-activity-logs-card" data-activity="New Parcel Added">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs fw-bold text-uppercase mb-1">New Parcel Added</div>
                            <div class="h5 mb-0 fw-bold">0</div>
                        </div>
                        <i class="fas fa-box-open fa-2x text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-c-yellow shadow h-100 py-3 advanced-activity-logs-card" data-activity="Parcel Update">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs fw-bold text-uppercase mb-1">Parcel Update</div>
                            <div class="h5 mb-0 fw-bold">0</div>
                        </div>
                        <i class="fas fa-sync fa-2x text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-c-orange shadow h-100 py-3 advanced-activity-logs-card" data-activity="Transaction Update">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs fw-bold text-uppercase mb-1">Transaction Update</div>
                            <div class="h5 mb-0 fw-bold">0</div>
                        </div>
                        <i class="fas fa-exchange-alt fa-2x text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-c-purple shadow h-100 py-3 advanced-activity-logs-card" data-activity="New Plotting Created">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs fw-bold text-uppercase mb-1">New Plotting Created</div>
                            <div class="h5 mb-0 fw-bold">0</div>
                        </div>
                        <i class="fas fa-drafting-compass fa-2x text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-c-pink shadow h-100 py-3 advanced-activity-logs-card" data-activity="User Update">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs fw-bold text-uppercase mb-1">User Update</div>
                            <div class="h5 mb-0 fw-bold">0</div>
                        </div>
                        <i class="fas fa-user-edit fa-2x text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-c-teal shadow h-100 py-3 advanced-activity-logs-card" data-activity="New User Added">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs fw-bold text-uppercase mb-1">New User Added</div>
                            <div class="h5 mb-0 fw-bold">0</div>
                        </div>
                        <i class="fas fa-user-plus fa-2x text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-c-red shadow h-100 py-3 advanced-activity-logs-card" data-activity="Parcel Deleted">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs fw-bold text-uppercase mb-1">Parcel Deleted</div>
                            <div class="h5 mb-0 fw-bold">0</div>
                        </div>
                        <i class="fas fa-trash-alt fa-2x text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-c-indigo shadow h-100 py-3 advanced-activity-logs-card" data-activity="Menu Assignment">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs fw-bold text-uppercase mb-1">Menu Assignment</div>
                            <div class="h5 mb-0 fw-bold">0</div>
                        </div>
                        <i class="fas fa-list-alt fa-2x text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-c-cyan shadow h-100 py-3 advanced-activity-logs-card" data-activity="Milestone Assignment">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs fw-bold text-uppercase mb-1">Milestone Assignment</div>
                            <div class="h5 mb-0 fw-bold">0</div>
                        </div>
                        <i class="fas fa-flag-checkered fa-2x text-white opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Advanced Activity Logs Modal -->
<div class="modal fade effect-scale modal-blur" id="activityLogsModal" tabindex="-1" aria-labelledby="activityLogsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white d-flex justify-content-between align-items-center rounded-top py-3">
                <div class="d-flex align-items-center">
                    <div class="icon-container bg-opacity-20 rounded-circle p-2 me-3">
                        <i class="fas fa-chart-line fa-lg"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-bold mb-0" id="audit_title"></h5>
                        <small class="text-white opacity-80">Comprehensive overview of system activities</small>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body bg-light-gray py-4">
                <div id="assignmentActivityControls" class="bg-white border rounded shadow-sm p-3 mb-4" style="display: none;">
                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
                        <div>
                            <h6 class="fw-bold text-primary mb-1">
                                <i class="fas fa-filter me-2"></i><span id="assignmentActivityControlsTitle">Filter and Group Assignments</span>
                            </h6>
                            <small class="text-muted">Narrow the results or group users by their organisational information.</small>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary" id="clearMenuActivityFilters">
                            <i class="fas fa-undo me-1"></i>Clear Filters
                        </button>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-4 col-xl">
                            <label class="form-label small fw-semibold" for="menuActivityRegionFilter">Region</label>
                            <select class="form-select form-select-sm" id="menuActivityRegionFilter">
                                <option value="">All regions</option>
                            </select>
                        </div>
                        <div class="col-md-4 col-xl">
                            <label class="form-label small fw-semibold" for="menuActivityDivisionFilter">Division</label>
                            <select class="form-select form-select-sm" id="menuActivityDivisionFilter">
                                <option value="">All divisions</option>
                            </select>
                        </div>
                        <div class="col-md-4 col-xl">
                            <label class="form-label small fw-semibold" for="menuActivityDepartmentFilter">Department</label>
                            <select class="form-select form-select-sm" id="menuActivityDepartmentFilter">
                                <option value="">All departments</option>
                            </select>
                        </div>
                        <div class="col-md-6 col-xl">
                            <label class="form-label small fw-semibold" for="menuActivityDesignationFilter">Designation</label>
                            <select class="form-select form-select-sm" id="menuActivityDesignationFilter">
                                <option value="">All designations</option>
                            </select>
                        </div>
                        <div class="col-md-6 col-xl">
                            <label class="form-label small fw-semibold" for="menuActivityGroupBy">Group by</label>
                            <select class="form-select form-select-sm" id="menuActivityGroupBy">
                                <option value="">No grouping</option>
                                <option value="4">Region</option>
                                <option value="1">Division</option>
                                <option value="3">Department</option>
                                <option value="2">Designation</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="activityLogsTable" width="100%">
                        <thead>
                            <tr>
                                <th>Officer</th>
                                <th>Division</th>
                                <th>Designation</th>
                                <th>Department</th>
                                <th>Region</th>
                                <th>Count</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer bg-white border-top py-3">
                <button type="button" class="btn btn-outline-danger rounded-pill px-4" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i> Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Similar modals updated for Bootstrap 5 below -->

<!-- USER Activity Logs Modal -->
<div class="modal fade effect-scale modal-blur" id="USERactivityLogsModal" tabindex="-1" aria-labelledby="USERactivityLogsModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white d-flex justify-content-between align-items-center rounded-top py-3">
                <div class="d-flex align-items-center">
                    <div class="icon-container bg-opacity-20 rounded-circle p-2 me-3">
                        <i class="fas fa-chart-line fa-lg"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-bold mb-0" id="user_audit_title"></h5>
                        <small class="text-white opacity-80">Comprehensive overview of system activities</small>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body bg-light-gray py-4">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="useractivityLogsTable" width="100%">
                        <thead>
                            <tr>
                                <th>Description</th>
                                <th>Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer bg-white border-top py-3">
                <button type="button" class="btn btn-outline-danger rounded-pill px-4" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i> Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Menu-Template Assignment Details Modal -->
<div class="modal fade effect-scale modal-blur" id="menuTemplateAssignmentDetailsModal" tabindex="-1"
     aria-labelledby="menuTemplateAssignmentTitle" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white rounded-top py-3">
                <div class="d-flex align-items-center">
                    <div class="icon-container bg-opacity-20 rounded-circle p-2 me-3">
                        <i class="fas fa-list-alt fa-lg"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-bold mb-0" id="menuTemplateAssignmentTitle"></h5>
                        <small class="text-white opacity-80">Menu assignment request</small>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body bg-light-gray py-4">
                <div class="bg-white border border-primary rounded shadow-sm p-3 mb-4">
                    <div class="row g-3 align-items-center">
                        <div class="col-lg-5">
                            <div class="small text-muted text-uppercase mb-1">Menu assigned to</div>
                            <div class="d-flex align-items-center">
                                <span class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center me-2"
                                      style="width: 38px; height: 38px; flex: 0 0 38px;">
                                    <i class="fas fa-user"></i>
                                </span>
                                <strong class="fs-5 text-primary" id="menuTemplateAssignedTo">Not available</strong>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="small text-muted text-uppercase mb-1">Action performed by</div>
                            <strong id="menuTemplatePerformedBy">Not available</strong>
                        </div>
                        <div class="col-lg-3">
                            <div class="small text-muted text-uppercase mb-1">Request date</div>
                            <strong id="menuTemplateAssignmentLogDate">Not available</strong>
                        </div>
                    </div>
                </div>

                <div class="border-start border-warning border-4 bg-white rounded shadow-sm p-3 mb-4">
                    <div class="row g-3">
                        <div class="col-lg-8">
                            <div class="d-flex align-items-start">
                                <i class="fas fa-comment-alt text-warning fs-5 me-3 mt-1"></i>
                                <div>
                                    <div class="small text-muted text-uppercase mb-1">Remarks / reason for assignment</div>
                                    <div class="fw-semibold text-dark" id="menuTemplateAssignmentRemarks">No remarks provided.</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 border-start">
                            <div class="d-flex align-items-start">
                                <i class="fas fa-clipboard-check text-primary fs-5 me-3 mt-1"></i>
                                <div>
                                    <div class="small text-muted text-uppercase mb-1">Nature of assignment</div>
                                    <div class="fw-semibold text-dark" id="menuTemplateAssignmentNature">Not specified</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="bg-white border-start border-primary border-4 rounded shadow-sm p-3 h-100">
                            <div class="small text-muted text-uppercase">Assigned templates / menus</div>
                            <div class="fs-3 fw-bold text-primary" id="menuTemplateRequestedCount">0</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="bg-white border-start border-success border-4 rounded shadow-sm p-3 h-100">
                            <div class="small text-muted text-uppercase">New assignment(s)</div>
                            <div class="fs-3 fw-bold text-success" id="menuTemplateAddedCount">0</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="bg-white border-start border-danger border-4 rounded shadow-sm p-3 h-100">
                            <div class="small text-muted text-uppercase">Removed assignment(s)</div>
                            <div class="fs-3 fw-bold text-danger" id="menuTemplateRemovedCount">0</div>
                        </div>
                    </div>
                </div>

                <div class="bg-white border rounded shadow-sm mb-4 overflow-hidden">
                    <div class="border-bottom px-3 pt-3">
                        <ul class="nav nav-tabs assignment-tabs-nav" id="menuTemplateAssignmentTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="menuTemplateAssignedTab" data-bs-toggle="tab"
                                        data-bs-target="#menuTemplateAssignedPane" type="button" role="tab"
                                        aria-controls="menuTemplateAssignedPane" aria-selected="true">
                                    <i class="fas fa-user-check me-2"></i>All Assigned Menus
                                    <span class="badge bg-primary ms-1" id="menuTemplateAssignedTabCount">0</span>
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link text-danger" id="menuTemplateRemovedTab" data-bs-toggle="tab"
                                        data-bs-target="#menuTemplateRemovedPane" type="button" role="tab"
                                        aria-controls="menuTemplateRemovedPane" aria-selected="false">
                                    <i class="fas fa-user-minus me-2"></i>Removed Assignments
                                    <span class="badge bg-danger ms-1" id="menuTemplateRemovedTabCount">0</span>
                                </button>
                            </li>
                        </ul>
                    </div>

                    <div class="tab-content assignment-tab-content menu-template-tab-content" id="menuTemplateAssignmentTabContent">
                        <div class="tab-pane fade show active" id="menuTemplateAssignedPane" role="tabpanel"
                             aria-labelledby="menuTemplateAssignedTab" tabindex="0">
                            <div class="px-3 py-3 border-bottom">
                                <small class="text-muted">Templates and menus currently selected for the recipient.</small>
                            </div>
                            <div id="menuTemplateRequestedProfiles" class="table-responsive"></div>
                        </div>

                        <div class="tab-pane fade" id="menuTemplateRemovedPane" role="tabpanel"
                             aria-labelledby="menuTemplateRemovedTab" tabindex="0">
                            <div class="px-3 py-3 border-bottom">
                                <small class="text-muted">Previously assigned profiles not selected in this request.</small>
                            </div>
                            <div id="menuTemplateRemovedProfiles" class="table-responsive"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer border-0 px-4 py-3">
                <button type="button" class="btn btn-outline-primary px-4" id="exportMenuTemplateAssignmentImage">
                    <i class="fas fa-image me-2"></i>Export Image
                </button>
                <button type="button" class="btn btn-danger px-4" id="exportMenuTemplateAssignmentPdf">
                    <i class="fas fa-file-pdf me-2"></i>Export PDF
                </button>
                <button type="button" class="btn btn-outline-danger px-4" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Milestone Assignment Details Modal -->
<div class="modal fade effect-scale modal-blur" id="milestoneAssignmentDetailsModal" tabindex="-1"
     aria-labelledby="milestoneAssignmentTitle" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white rounded-top py-3">
                <div class="d-flex align-items-center">
                    <div class="icon-container bg-opacity-20 rounded-circle p-2 me-3">
                        <i class="fas fa-flag-checkered fa-lg"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-bold mb-0" id="milestoneAssignmentTitle"></h5>
                        <small class="text-white opacity-80">Milestone assignment request</small>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body bg-light-gray py-4">
                <div class="bg-white border border-primary rounded shadow-sm p-3 mb-4">
                    <div class="row g-3 align-items-center">
                        <div class="col-lg-5">
                            <div class="small text-muted text-uppercase mb-1">Milestones assigned to</div>
                            <div class="d-flex align-items-center">
                                <span class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center me-2"
                                      style="width: 38px; height: 38px; flex: 0 0 38px;">
                                    <i class="fas fa-user"></i>
                                </span>
                                <strong class="fs-5 text-primary" id="milestoneAssignmentAssignedTo">Not available</strong>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="small text-muted text-uppercase mb-1">Action performed by</div>
                            <strong id="milestoneAssignmentPerformedBy">Not available</strong>
                        </div>
                        <div class="col-lg-3">
                            <div class="small text-muted text-uppercase mb-1">Assiged date</div>
                            <strong id="milestoneAssignmentLogDate">Not available</strong>
                        </div>
                    </div>
                </div>

                <div class="border-start border-warning border-4 bg-white rounded shadow-sm p-3 mb-4">
                    <div class="row g-3">
                        <div class="col-lg-8">
                            <div class="d-flex align-items-start">
                                <i class="fas fa-comment-alt text-warning fs-5 me-3 mt-1"></i>
                                <div>
                                    <div class="small text-muted text-uppercase mb-1">Remarks / reason for assignment</div>
                                    <div class="fw-semibold text-dark" id="milestoneAssignmentRemarks">No remarks provided.</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 border-start">
                            <div class="d-flex align-items-start">
                                <i class="fas fa-clipboard-check text-primary fs-5 me-3 mt-1"></i>
                                <div>
                                    <div class="small text-muted text-uppercase mb-1">Nature of assignment</div>
                                    <div class="fw-semibold text-dark" id="milestoneAssignmentNature">Not specified</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="bg-white border-start border-primary border-4 rounded shadow-sm p-3 h-100">
                            <div class="small text-muted text-uppercase">Assigned milestones</div>
                            <div class="fs-3 fw-bold text-primary" id="milestoneAssignmentRequestedCount">0</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="bg-white border-start border-success border-4 rounded shadow-sm p-3 h-100">
                            <div class="small text-muted text-uppercase">New assignments</div>
                            <div class="fs-3 fw-bold text-success" id="milestoneAssignmentAddedCount">0</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="bg-white border-start border-danger border-4 rounded shadow-sm p-3 h-100">
                            <div class="small text-muted text-uppercase">Removed assignments</div>
                            <div class="fs-3 fw-bold text-danger" id="milestoneAssignmentRemovedCount">0</div>
                        </div>
                    </div>
                </div>

                <div class="bg-white border rounded shadow-sm mb-4 overflow-hidden">
                    <div class="border-bottom px-3 pt-3">
                        <ul class="nav nav-tabs assignment-tabs-nav" id="milestoneAssignmentTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="milestoneRequestedTab" data-bs-toggle="tab"
                                        data-bs-target="#milestoneRequestedPane" type="button" role="tab"
                                        aria-controls="milestoneRequestedPane" aria-selected="true">
                                    <i class="fas fa-flag-checkered me-2"></i>Requested Milestone Assignments
                                    <span class="badge bg-primary ms-1" id="milestoneRequestedTabCount">0</span>
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="milestonePreviousTab" data-bs-toggle="tab"
                                        data-bs-target="#milestonePreviousPane" type="button" role="tab"
                                        aria-controls="milestonePreviousPane" aria-selected="false">
                                    <i class="fas fa-history me-2"></i>Previous Assignments
                                    <span class="badge bg-secondary ms-1" id="milestonePreviousTabCount">0</span>
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link text-danger" id="milestoneRemovedTab" data-bs-toggle="tab"
                                        data-bs-target="#milestoneRemovedPane" type="button" role="tab"
                                        aria-controls="milestoneRemovedPane" aria-selected="false">
                                    <i class="fas fa-minus-circle me-2"></i>Removed Assignments
                                    <span class="badge bg-danger ms-1" id="milestoneRemovedTabCount">0</span>
                                </button>
                            </li>
                        </ul>
                    </div>

                    <div class="tab-content assignment-tab-content milestone-tab-content" id="milestoneAssignmentTabContent">
                        <div class="tab-pane fade show active" id="milestoneRequestedPane" role="tabpanel"
                             aria-labelledby="milestoneRequestedTab" tabindex="0">
                            <div class="px-3 py-3 border-bottom">
                                <small class="text-muted">Milestones selected for the recipient, with their related main and sub-services.</small>
                            </div>
                            <div id="milestoneAssignmentRequestedItems" class="table-responsive"></div>
                        </div>

                        <div class="tab-pane fade" id="milestonePreviousPane" role="tabpanel"
                             aria-labelledby="milestonePreviousTab" tabindex="0">
                            <div class="px-3 py-3 border-bottom">
                                <small class="text-muted">Milestones assigned before this request.</small>
                            </div>
                            <div id="milestoneAssignmentOriginalItems" class="table-responsive"></div>
                        </div>

                        <div class="tab-pane fade" id="milestoneRemovedPane" role="tabpanel"
                             aria-labelledby="milestoneRemovedTab" tabindex="0">
                            <div class="px-3 py-3 border-bottom">
                                <small class="text-muted">Previously assigned milestones not selected in this request.</small>
                            </div>
                            <div id="milestoneAssignmentRemovedItems" class="table-responsive"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer milestone-export-footer border-0 px-4 py-3">
                <button type="button" class="btn btn-outline-primary px-4" id="exportMilestoneAssignmentImage">
                    <i class="fas fa-image me-2"></i>Export Image
                </button>
                <button type="button" class="btn btn-danger px-4" id="exportMilestoneAssignmentPdf">
                    <i class="fas fa-file-pdf me-2"></i>Export PDF
                </button>
                <button type="button" class="btn btn-outline-danger px-4" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- All other modals follow the same pattern — here’s one example for brevity -->

<!-- Activity Details Modal (Update Parcel) -->
<div class="modal fade effect-scale modal-blur" id="activityDetailsModal" tabindex="-1" aria-labelledby="activityDetailsLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white d-flex justify-content-between align-items-center rounded-top py-3">
                <div class="d-flex align-items-center">
                    <div class="icon-container bg-opacity-20 rounded-circle p-2 me-3">
                        <i class="fas fa-history fa-lg"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-bold mb-0" id="t_audit_title_update_parcel"></h5>
                        <small class="text-white opacity-80">Spatial and data comparison</small>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <strong><i class="fas fa-calendar"></i> Log Date:</strong> 
                        <span id="logDateDisplay" class="text-primary fw-bold"></span>
                    </div>
                </div>

                <div class="row mb-4 g-3">
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header bg-primary text-white py-2">
                                <h6 class="mb-0"><i class="fas fa-database"></i> Original Data</h6>
                            </div>
                            <div class="card-body p-0">
                                <div id="originalData" class="p-3" style="max-height: 400px; overflow-y: auto;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header bg-warning text-dark py-2">
                                <h6 class="mb-0"><i class="fas fa-edit"></i> Modifications Made</h6>
                            </div>
                            <div class="card-body p-0">
                                <div id="changesRequested" class="p-3" style="max-height: 400px; overflow-y: auto;"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header bg-success text-white py-2">
                        <h6 class="mb-0"><i class="fas fa-map"></i> Spatial Comparison</h6>
                    </div>
                    <div class="card-body p-0">
                        <div id="activityMap"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i> Close
                </button>
            </div>
        </div>
    </div>
</div>



<div class="modal fade" id="newactivityDetailsModal" tabindex="-1"
     aria-labelledby="activityDetailsLabel"
     aria-hidden="true"
     data-bs-backdrop="static"
     data-bs-keyboard="false">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg rounded-4">

            <!-- Header -->
            <div class="modal-header bg-primary text-white rounded-top-4 px-4 py-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="bg-white bg-opacity-25 rounded-circle p-2">
                        <i class="fas fa-chart-line fs-4"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-semibold mb-0" id="t_audit_title"></h5>
                        <small class="opacity-75">
                            Comprehensive overview of system activities
                        </small>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <!-- Body -->
            <div class="modal-body px-4 py-4">

                <!-- Log Date -->
                <div class="d-flex align-items-center mb-4">
                    <i class="fas fa-calendar-alt text-primary me-2"></i>
                    <span class="fw-semibold me-1">Log Date:</span>
                    <span id="logDateDisplay_6" class="text-primary fw-bold"></span>
                </div>

                <!-- Data Added -->
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-warning bg-opacity-25 fw-semibold rounded-top-4 d-flex align-items-center gap-2">
                        <i class="fas fa-edit text-warning"></i>
                        Data Added
                    </div>
                    <div class="card-body p-3">
                        <div id="changesRequestedd"
                             class="bg-body-secondary rounded-3 p-3 small"
                             style="max-height: 420px; overflow-y: auto;">
                        </div>
                    </div>
                </div>

            </div>

            <!-- Footer -->
            <div class="modal-footer border-0 px-4 py-3">
                <button type="button" class="btn btn-outline-danger px-4" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i> Close
                </button>
            </div>

        </div>
    </div>
</div>





<div class="modal fade" id="addParcelDetailsModal" tabindex="-1"
     aria-labelledby="activityDetailsLabel"
     aria-hidden="true"
     data-bs-backdrop="static"
     data-bs-keyboard="false">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg rounded-4">

            <!-- Header -->
            <div class="modal-header bg-primary text-white rounded-top-4 px-4 py-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="bg-white bg-opacity-25 rounded-circle p-2">
                        <i class="fas fa-chart-line fs-4"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-semibold mb-0" id="t_audit_title1"></h5>
                        <small class="opacity-75">
                            Comprehensive overview of system activities
                        </small>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <!-- Body -->
            <div class="modal-body px-4 py-4">

                <!-- Log Date -->
                <div class="d-flex align-items-center mb-4">
                    <i class="fas fa-calendar-alt text-primary me-2"></i>
                    <span class="fw-semibold me-1">Log Date:</span>
                    <span id="logDateDisplay_2" class="text-primary fw-bold"></span>
                </div>

                <!-- Plotting Info -->
                <div class="card border-0 shadow-sm rounded-4 mb-4">
                    <div class="card-header bg-warning bg-opacity-25 fw-semibold rounded-top-4 d-flex align-items-center gap-2">
                        <i class="fas fa-edit text-warning"></i>
                        Plotting Info
                    </div>
                    <div class="card-body p-3">
                        <div id="AddParcelchangesRequested"
                             class="bg-body-secondary rounded-3 p-3 small"
                             style="max-height: 360px; overflow-y: auto;">
                        </div>
                    </div>
                </div>

                <!-- Spatial Component -->
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-success text-white fw-semibold rounded-top-4 d-flex align-items-center gap-2">
                        <i class="fas fa-map-marked-alt"></i>
                        Spatial Component
                    </div>
                    <div class="card-body p-0 position-relative rounded-bottom-4">
                        <div id="addParcelActivityMap"
                             style="height: 450px; width: 100%;"></div>

                        <div id="addParcelMapStatus"
                             class="position-absolute bottom-0 start-0 w-100 px-3 py-2
                                    bg-white bg-opacity-90 border-top small text-muted rounded-bottom-4">
                            <i class="fas fa-sync fa-spin me-1"></i>
                            Initializing map with layer controls…
                        </div>
                    </div>
                </div>

            </div>

            <!-- Footer -->
            <div class="modal-footer border-0 px-4 py-3">
                <button type="button" class="btn btn-outline-danger px-4" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i> Close
                </button>
            </div>

        </div>
    </div>
</div>






<div class="modal fade" id="transactionUpdateModal" tabindex="-1"
     aria-labelledby="transactionUpdateModalLabel"
     aria-hidden="true"
     data-bs-backdrop="static"
     data-bs-keyboard="false">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg rounded-4">

            <!-- Header -->
            <div class="modal-header bg-primary text-white rounded-top-4 px-4 py-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="bg-white bg-opacity-25 rounded-circle p-2">
                        <i class="fas fa-chart-line fs-4"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-semibold mb-0" id="t_audit_title_update_transaction"></h5>
                        <small class="opacity-75">
                            Comprehensive overview of system activities
                        </small>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <!-- Body -->
            <div class="modal-body px-4 py-4">

                <!-- Log Date & Legend -->
                <div class="row align-items-center mb-4">
                    <div class="col-lg-6">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-calendar-alt text-primary me-2"></i>
                            <span class="fw-semibold me-1">Log Date:</span>
                            <span id="logDateDisplay_3" class="text-primary fw-bold"></span>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="d-flex justify-content-lg-end gap-3 flex-wrap small">
                            <div class="d-flex align-items-center gap-1">
                                <span class="rounded"
                                      style="background:#ffc107;width:16px;height:8px;"></span>
                                <span>🟨 Changed</span>
                            </div>

                            <div class="d-flex align-items-center gap-1">
                                <span class="rounded"
                                      style="background:#28a745;width:16px;height:8px;"></span>
                                <span>🟩 Added</span>
                            </div>

                            <div class="d-flex align-items-center gap-1">
                                <span class="rounded"
                                      style="background:#dee2e6;width:16px;height:8px;"></span>
                                <span>⬜ Unchanged</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Data Comparison -->
                <div class="row g-4">

                    <!-- Original Data -->
                    <div class="col-lg-6">
                        <div class="card border-0 shadow-sm rounded-4 h-100">
                            <div class="card-header bg-primary bg-opacity-10 fw-semibold rounded-top-4 d-flex align-items-center gap-2">
                                <i class="fas fa-trash-alt text-primary"></i>
                                Original Data
                            </div>
                            <!-- <div class="card-header bg-primary text-primary fw-semibold rounded-top-4 d-flex align-items-center gap-2">
                                <i class="fas fa-database text-primary"></i>
                                Original Data
                            </div> -->

                            <div class="card-body p-3">
                                <div id="UpdateTransactionoriginalData"
                                     class="bg-body-secondary rounded-3 p-3 small"
                                     style="max-height: 380px; overflow-y: auto;">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modified Data -->
                    <div class="col-lg-6">
                        <div class="card border-0 shadow-sm rounded-4 h-100">
                            <div class="card-header bg-warning bg-opacity-25 fw-semibold rounded-top-4 d-flex align-items-center gap-2">
                                <i class="fas fa-edit text-warning"></i>
                                Modifications Made
                            </div>
                            <div class="card-body p-3">
                                <div id="UpdateTransactionchangesRequested"
                                     class="bg-body-secondary rounded-3 p-3 small"
                                     style="max-height: 380px; overflow-y: auto;">
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

            <!-- Footer -->
            <div class="modal-footer border-0 px-4 py-3">
                <button type="button" class="btn btn-outline-danger px-4" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i> Close
                </button>
            </div>

        </div>
    </div>
</div>






<div class="modal fade" id="transactionDeleteModal"
     tabindex="-1"
     aria-labelledby="transactionDeleteeModalLabel"
     aria-hidden="true"
     data-bs-backdrop="static"
     data-bs-keyboard="false">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg rounded-4">

            <!-- Header -->
            <div class="modal-header bg-primary text-white rounded-top-4 px-4 py-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="bg-white bg-opacity-25 rounded-circle p-2">
                        <i class="fas fa-chart-line fs-4"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-semibold mb-0"
                            id="t_audit_title_delete_transaction"></h5>
                        <small class="opacity-75">
                            Comprehensive overview of system activities
                        </small>
                    </div>
                </div>
                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal"></button>
            </div>

            <!-- Body -->
            <div class="modal-body px-4 py-4">

                <!-- Log Date -->
                <div class="row mb-4">
                    <div class="col-lg-6">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-calendar-alt text-primary me-2"></i>
                            <span class="fw-semibold me-1">Log Date:</span>
                            <span id="logDateDisplay_4" class="text-primary fw-bold"></span>
                        </div>
                    </div>
                </div>

                <!-- Deleted Data -->
                <div class="row">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm rounded-4">
                            <div class="card-header bg-danger bg-opacity-10 fw-semibold rounded-top-4 d-flex align-items-center gap-2">
                                <i class="fas fa-trash-alt text-danger"></i>
                                Deleted Data
                            </div>
                            <div class="card-body p-3">
                                <div id="deleteTransactionoriginalData"
                                     class="bg-body-secondary rounded-3 p-3 small"
                                     style="max-height: 380px; overflow-y: auto;">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Footer -->
            <div class="modal-footer border-0 px-4 py-3">
                <button type="button"
                        class="btn btn-outline-danger px-4"
                        data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i> Close
                </button>
            </div>

        </div>
    </div>
</div>





</div>

<!-- Repeat similar updates for other modals: newactivityDetailsModal, addParcelDetailsModal, transactionUpdateModal, etc. -->
<!-- They follow the same structure: btn-close-white, data-bs-dismiss, proper flex utilities, etc. -->

<script>
    // Bootstrap 5 tooltips
    document.addEventListener('DOMContentLoaded', function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.forEach(function (tooltipTriggerEl) {
            new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
</script>
