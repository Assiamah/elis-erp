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

    .audit-dashboard-tabs {
        border-bottom: 1px solid #e9ecef;
        gap: 0.25rem;
    }

    .audit-dashboard-tabs .nav-link {
        border: 0;
        border-bottom: 3px solid transparent;
        color: #6c757d;
        font-weight: 600;
        padding: 0.85rem 1.25rem;
    }

    .audit-dashboard-tabs .nav-link:hover,
    .audit-dashboard-tabs .nav-link:focus {
        border-bottom-color: rgba(13, 110, 253, 0.35);
        color: #0d6efd;
    }

    .audit-dashboard-tabs .nav-link.active {
        background: transparent;
        border-bottom-color: #0d6efd;
        color: #0d6efd;
    }

    .user-report-card {
        border: 1px solid #e9ecef;
        border-radius: 12px;
        box-shadow: none;
        overflow: visible;
    }

    .user-report-card:hover {
        transform: none;
        border-color: rgba(13, 110, 253, 0.35);
        box-shadow: 0 5px 15px rgba(15, 23, 42, 0.08);
    }

    .user-report-avatar {
        align-items: center;
        background: #e7f1ff;
        border-radius: 50%;
        color: #0d6efd;
        display: flex;
        flex: 0 0 48px;
        font-weight: 700;
        height: 48px;
        justify-content: center;
        width: 48px;
    }

    .user-log-type {
        background: #f8f9fa;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        height: 100%;
        padding: 0.85rem;
    }

    .user-log-type-count {
        color: #212529;
        font-size: 1.25rem;
        font-weight: 700;
    }

    .user-report-toolbar-controls {
        align-items: flex-end;
        display: flex;
        flex-wrap: wrap;
        gap: 0.75rem;
    }

    .user-report-toolbar-field label {
        display: block;
        margin-bottom: 0.25rem;
        white-space: nowrap;
    }

    .user-report-page-size {
        min-width: 85px;
    }

    .user-report-sort {
        min-width: 165px;
    }

    @media (max-width: 575.98px) {
        .user-report-toolbar-controls,
        .user-report-toolbar-field {
            width: 100%;
        }

        .user-report-toolbar-field .form-select {
            width: 100%;
        }
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

    <ul class="nav nav-tabs audit-dashboard-tabs mb-4" id="auditDashboardTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="activity-overview-tab" data-bs-toggle="tab"
                    data-bs-target="#activity-overview-pane" type="button" role="tab"
                    aria-controls="activity-overview-pane" aria-selected="true">
                <i class="fas fa-chart-pie me-2"></i>Activity Overview
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="report-by-user-tab" data-bs-toggle="tab"
                    data-bs-target="#report-by-user-pane" type="button" role="tab"
                    aria-controls="report-by-user-pane" aria-selected="false">
                <i class="fas fa-user-clock me-2"></i>Report by User
            </button>
        </li>
    </ul>

    <div class="tab-content" id="auditDashboardTabContent">
        <div class="tab-pane fade show active" id="activity-overview-pane" role="tabpanel"
             aria-labelledby="activity-overview-tab" tabindex="0">

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

        <div class="tab-pane fade" id="report-by-user-pane" role="tabpanel"
             aria-labelledby="report-by-user-tab" tabindex="0">
            <div class="alert alert-info d-flex align-items-center mb-4" id="userReportStatus" role="status">
                <i class="fas fa-info-circle me-2"></i>
                <div>Select a date range to load the activity report by user.</div>
            </div>

            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center mb-4 pb-3 border-bottom">
                        <div class="icon-container bg-primary bg-opacity-10 text-primary rounded-circle me-3">
                            <i class="fas fa-user-clock"></i>
                        </div>
                        <div>
                            <h2 class="h5 fw-bold mb-1">Report by User</h2>
                            <p class="text-muted mb-0">
                                Find staff first, then review each user's activity grouped by log type.
                            </p>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-lg-4">
                            <label class="form-label fw-semibold" for="userReportSearch">Search user</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                                <input type="search" class="form-control" id="userReportSearch"
                                       placeholder="Name, Division or Unit">
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <label class="form-label fw-semibold" for="userReportRegion">Region</label>
                            <select class="form-select" id="userReportRegion">
                                <option value="">All regions</option>
                            </select>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <label class="form-label fw-semibold" for="userReportDesignation">Designation</label>
                            <select class="form-select" id="userReportDesignation">
                                <option value="">All designations</option>
                            </select>
                        </div>
                        <div class="col-lg-2 d-flex align-items-end">
                            <button type="button" class="btn btn-outline-secondary w-100" id="clearUserReportFilters">
                                <i class="fas fa-undo me-1"></i>Clear
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
                <div>
                    <h3 class="h6 fw-bold mb-1">Users and Perfomed Activities</h3>
                    <span class="text-muted small" id="userReportResultCount">No users loaded</span>
                </div>
                <div class="user-report-toolbar-controls">
                    <div class="user-report-toolbar-field">
                        <label class="small text-muted" for="userReportPageSize">Users per page</label>
                        <select class="form-select form-select-sm user-report-page-size" id="userReportPageSize">
                            <option value="5">5</option>
                            <option value="10" selected>10</option>
                            <option value="20">20</option>
                            <option value="50">50</option>
                        </select>
                    </div>
                    <div class="user-report-toolbar-field">
                        <label class="small text-muted" for="userReportSort">Sort users by</label>
                        <select class="form-select form-select-sm user-report-sort" id="userReportSort">
                            <option value="activity">Most activity</option>
                            <option value="name">User name</option>
                        </select>
                    </div>
                </div>
            </div>

            <div id="userReportList">
                <div class="card user-report-card user-report-item mb-3" data-name="Ama Mensah"
                     data-search="ama mensah la-00421 land registration land administration officer"
                     data-region="Greater Accra" data-designation="Land Administration Officer" data-total="47">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
                            <div class="d-flex align-items-center">
                                <div class="user-report-avatar me-3">AM</div>
                                <div>
                                    <h4 class="h6 fw-bold mb-1">Ama Mensah <span class="badge bg-success-subtle text-success ms-1">Active</span></h4>
                                    <div class="small text-muted">LA-00421 · Land Administration Officer</div>
                                    <div class="small text-muted"><i class="fas fa-map-marker-alt me-1"></i>Greater Accra · Land Registration Division</div>
                                </div>
                            </div>
                            <div class="text-end">
                                <div class="h4 fw-bold text-primary mb-0">47</div>
                                <small class="text-muted">total activities</small>
                            </div>
                        </div>
                        <div class="row g-2">
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Add Transaction</div><div class="user-log-type-count">18</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Update Parcel</div><div class="user-log-type-count">14</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Plot Parcel</div><div class="user-log-type-count">9</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Other</div><div class="user-log-type-count">6</div></div></div>
                        </div>
                    </div>
                </div>

                <div class="card user-report-card user-report-item mb-3" data-name="Kwame Asante"
                     data-search="kwame asante ro-00118 records senior records officer"
                     data-region="Ashanti" data-designation="Senior Records Officer" data-total="35">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
                            <div class="d-flex align-items-center">
                                <div class="user-report-avatar me-3">KA</div>
                                <div>
                                    <h4 class="h6 fw-bold mb-1">Kwame Asante <span class="badge bg-success-subtle text-success ms-1">Active</span></h4>
                                    <div class="small text-muted">RO-00118 · Senior Records Officer</div>
                                    <div class="small text-muted"><i class="fas fa-map-marker-alt me-1"></i>Ashanti · Records Department</div>
                                </div>
                            </div>
                            <div class="text-end"><div class="h4 fw-bold text-primary mb-0">35</div><small class="text-muted">total activities</small></div>
                        </div>
                        <div class="row g-2">
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Add Parcel</div><div class="user-log-type-count">16</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Update Transaction</div><div class="user-log-type-count">11</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Delete Parcel</div><div class="user-log-type-count">3</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Other</div><div class="user-log-type-count">5</div></div></div>
                        </div>
                    </div>
                </div>

                <div class="card user-report-card user-report-item mb-3" data-name="Esi Hammond"
                     data-search="esi hammond sv-00207 survey assistant surveyor"
                     data-region="Western" data-designation="Assistant Surveyor" data-total="28">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
                            <div class="d-flex align-items-center">
                                <div class="user-report-avatar me-3">EH</div>
                                <div>
                                    <h4 class="h6 fw-bold mb-1">Esi Hammond <span class="badge bg-success-subtle text-success ms-1">Active</span></h4>
                                    <div class="small text-muted">SV-00207 · Assistant Surveyor</div>
                                    <div class="small text-muted"><i class="fas fa-map-marker-alt me-1"></i>Western · Survey and Mapping Division</div>
                                </div>
                            </div>
                            <div class="text-end"><div class="h4 fw-bold text-primary mb-0">28</div><small class="text-muted">total activities</small></div>
                        </div>
                        <div class="row g-2">
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Plot Parcel</div><div class="user-log-type-count">15</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Add Parcel</div><div class="user-log-type-count">8</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Update Parcel</div><div class="user-log-type-count">4</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Other</div><div class="user-log-type-count">1</div></div></div>
                        </div>
                    </div>
                </div>

                <div class="card user-report-card user-report-item mb-3" data-name="Kojo Boateng"
                     data-search="kojo boateng ad-00036 administration regional administrator"
                     data-region="Greater Accra" data-designation="Regional Administrator" data-total="19">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
                            <div class="d-flex align-items-center">
                                <div class="user-report-avatar me-3">KB</div>
                                <div>
                                    <h4 class="h6 fw-bold mb-1">Kojo Boateng <span class="badge bg-secondary-subtle text-secondary ms-1">Inactive</span></h4>
                                    <div class="small text-muted">AD-00036 · Regional Administrator</div>
                                    <div class="small text-muted"><i class="fas fa-map-marker-alt me-1"></i>Greater Accra · Administration</div>
                                </div>
                            </div>
                            <div class="text-end"><div class="h4 fw-bold text-primary mb-0">19</div><small class="text-muted">total activities</small></div>
                        </div>
                        <div class="row g-2">
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Menu Assignment</div><div class="user-log-type-count">8</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Milestone Assignment</div><div class="user-log-type-count">6</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Update User</div><div class="user-log-type-count">4</div></div></div>
                            <div class="col-6 col-md-3"><div class="user-log-type"><div class="small text-muted">Add User</div><div class="user-log-type-count">1</div></div></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="alert alert-light border text-center d-none" id="userReportEmptyState">
                <i class="fas fa-user-slash text-muted me-2"></i>No users match the selected filters.
            </div>

            <nav class="d-flex justify-content-center mt-4" id="userReportPagination"
                 aria-label="Report by user pagination"></nav>
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

        var searchInput = document.getElementById('userReportSearch');
        var regionSelect = document.getElementById('userReportRegion');
        var designationSelect = document.getElementById('userReportDesignation');
        var sortSelect = document.getElementById('userReportSort');
        var pageSizeSelect = document.getElementById('userReportPageSize');
        var clearButton = document.getElementById('clearUserReportFilters');
        var reportList = document.getElementById('userReportList');
        var resultCount = document.getElementById('userReportResultCount');
        var emptyState = document.getElementById('userReportEmptyState');
        var pagination = document.getElementById('userReportPagination');
        var statusBox = document.getElementById('userReportStatus');
        var allUserReportRows = [];
        var loadedDateRange = '';
        var currentUserReportPage = 1;
        reportList.innerHTML = '';

        function escapeUserReportValue(value) {
            return String(value == null ? '' : value)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#039;');
        }

        function getUserInitials(name) {
            return String(name || 'Unknown User').trim().split(/\s+/).slice(0, 2)
                .map(function (part) { return part.charAt(0).toUpperCase(); }).join('');
        }

        function getUserReportLogType(activityType) {
            var activityMap = {
                'New Transaction Added': 'Add Transaction',
                'New Parcel Added': 'Add Parcel',
                'Parcel Update': 'Update Parcel',
                'Transaction Update': 'Upate Transaction',
                'New Plotting Created': 'Plot Parcel',
                'User Update': 'Upate User',
                'New User Added': 'Add User',
                'Parcel Deleted': 'Delete Parcel',
                'Menu Assignment': 'Menu-Template Assignment'
            };
            return activityMap[activityType] || activityType;
        }

        function populateUserReportFilter(select, label, values) {
            var currentValue = select.value;
            select.innerHTML = '<option value="">' + label + '</option>';
            Array.from(new Set(values.filter(Boolean))).sort(function (first, second) {
                return first.localeCompare(second);
            }).forEach(function (value) {
                var option = document.createElement('option');
                option.value = value;
                option.textContent = value;
                select.appendChild(option);
            });
            select.value = currentValue;
        }

        function renderUserReportCards(rows) {
            reportList.innerHTML = rows.map(function (user) {
                var userName = String(user.user_name || 'Unknown User').trim();
                var userId = String(user.user_id || '');
                var department = String(user.department || 'Not specified').trim();
                var region = String(user.region || 'Not specified').trim();
                var designation = String(user.designation || 'Not specified').trim();
                var division = String(user.division || 'Not specified').trim() || 'Not specified';
                var total = Number(user.total_activities) || 0;
                var activities = Array.isArray(user.activity_types) ? user.activity_types : [];
                var activityCards = activities.map(function (activity) {
                    var activityType = String(activity.activity_type || 'Other').trim();
                    var logType = getUserReportLogType(activityType);
                    var count = Number(activity.count) || 0;

                    return '<div class="col-6 col-md-4 col-xl-3">' +
                        '<a href="javascript:void(0)" class="user-log-type d-block text-decoration-none" ' +
                        'id="view_activities_By_usser" data-id="' + escapeUserReportValue(userId) + '" ' +
                        'data-name_full="' + escapeUserReportValue(userName) + '" ' +
                        'data-actv="' + escapeUserReportValue(activityType) + '" ' +
                        'data-logt="' + escapeUserReportValue(logType) + '">' +
                        '<div class="small text-muted">' + escapeUserReportValue(activityType) + '</div>' +
                        '<div class="user-log-type-count">' + count.toLocaleString() + '</div>' +
                        '<small class="text-primary">View details <i class="fas fa-arrow-right ms-1"></i></small>' +
                        '</a></div>';
                }).join('');

                return '<div class="card user-report-card user-report-item mb-3" ' +
                    'data-name="' + escapeUserReportValue(userName) + '" ' +
                    'data-search="' + escapeUserReportValue((userName + ' ' + userId + ' ' + department + ' ' + division).toLowerCase()) + '" ' +
                    'data-region="' + escapeUserReportValue(region) + '" ' +
                    'data-designation="' + escapeUserReportValue(designation) + '" data-total="' + total + '">' +
                    '<div class="card-body p-4">' +
                    '<div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">' +
                    '<div class="d-flex align-items-center">' +
                    '<div class="user-report-avatar me-3">' + escapeUserReportValue(getUserInitials(userName)) + '</div>' +
                    '<div><h4 class="h6 fw-bold mb-1">' + escapeUserReportValue(userName) + '</h4>' +
                    '<div class="small text-muted">' + escapeUserReportValue(designation) + '</div>' +
                    '<div class="small text-muted"><i class="fas fa-map-marker-alt me-1"></i>' +
                    escapeUserReportValue(region) + ' · ' + escapeUserReportValue(department) + ' · ' +
                    escapeUserReportValue(division) + '</div></div></div>' +
                    '<div class="text-end"><div class="h4 fw-bold text-primary mb-0">' +
                    total.toLocaleString() + '</div><small class="text-muted">total activities</small></div></div>' +
                    '<div class="row g-2">' + (activityCards ||
                        '<div class="col-12 text-muted small">No grouped log types returned.</div>') +
                    '</div></div></div>';
            }).join('');
        }

        function renderUserReportPagination(totalRows, pageSize) {
            var totalPages = Math.ceil(totalRows / pageSize);
            if (totalPages <= 1) {
                pagination.innerHTML = '';
                return;
            }

            var firstPage = Math.max(1, currentUserReportPage - 2);
            var lastPage = Math.min(totalPages, currentUserReportPage + 2);
            if (currentUserReportPage <= 3) lastPage = Math.min(totalPages, 5);
            if (currentUserReportPage >= totalPages - 2) firstPage = Math.max(1, totalPages - 4);

            var items = '<ul class="pagination pagination-sm mb-0">' +
                '<li class="page-item ' + (currentUserReportPage === 1 ? 'disabled' : '') + '">' +
                '<button class="page-link" type="button" data-page="' + (currentUserReportPage - 1) +
                '" aria-label="Previous"><i class="fas fa-chevron-left"></i></button></li>';

            if (firstPage > 1) {
                items += '<li class="page-item"><button class="page-link" type="button" data-page="1">1</button></li>';
                if (firstPage > 2) items += '<li class="page-item disabled"><span class="page-link">…</span></li>';
            }

            for (var page = firstPage; page <= lastPage; page += 1) {
                items += '<li class="page-item ' + (page === currentUserReportPage ? 'active' : '') + '">' +
                    '<button class="page-link" type="button" data-page="' + page + '">' + page + '</button></li>';
            }

            if (lastPage < totalPages) {
                if (lastPage < totalPages - 1) items += '<li class="page-item disabled"><span class="page-link">…</span></li>';
                items += '<li class="page-item"><button class="page-link" type="button" data-page="' +
                    totalPages + '">' + totalPages + '</button></li>';
            }

            items += '<li class="page-item ' + (currentUserReportPage === totalPages ? 'disabled' : '') + '">' +
                '<button class="page-link" type="button" data-page="' + (currentUserReportPage + 1) +
                '" aria-label="Next"><i class="fas fa-chevron-right"></i></button></li></ul>';
            pagination.innerHTML = items;
        }

        function updateUserReport() {
            var searchValue = searchInput.value.trim().toLowerCase();
            var regionValue = regionSelect.value;
            var designationValue = designationSelect.value;
            var filteredRows = allUserReportRows.filter(function (user) {
                var searchableValue = [
                    user.user_name, user.user_id, user.department, user.division
                ].join(' ').toLowerCase();
                return (!searchValue || searchableValue.indexOf(searchValue) !== -1) &&
                    (!regionValue || String(user.region || '').trim() === regionValue) &&
                    (!designationValue || String(user.designation || '').trim() === designationValue);
            });

            filteredRows.sort(function (first, second) {
                if (sortSelect.value === 'name') {
                    return String(first.user_name || '').localeCompare(String(second.user_name || ''));
                }
                return (Number(second.total_activities) || 0) - (Number(first.total_activities) || 0);
            });

            var pageSize = Number(pageSizeSelect.value) || 10;
            var totalPages = Math.max(1, Math.ceil(filteredRows.length / pageSize));
            currentUserReportPage = Math.min(currentUserReportPage, totalPages);
            var firstRowIndex = (currentUserReportPage - 1) * pageSize;
            var pagedRows = filteredRows.slice(firstRowIndex, firstRowIndex + pageSize);

            renderUserReportCards(pagedRows);
            renderUserReportPagination(filteredRows.length, pageSize);
            resultCount.textContent = filteredRows.length
                ? 'Showing ' + (firstRowIndex + 1) + '–' + (firstRowIndex + pagedRows.length) +
                    ' of ' + filteredRows.length + ' users'
                : 'Showing 0 users';
            emptyState.classList.toggle('d-none', filteredRows.length !== 0);
        }

        function loadUserReport(forceReload) {
            var startDateValue = document.getElementById('start_date').value || document.getElementById('datefrom').value;
            var endDateValue = document.getElementById('end_date').value || document.getElementById('dateto').value;
            var requestedRange = startDateValue + '|' + endDateValue;

            if (!startDateValue || !endDateValue) {
                statusBox.className = 'alert alert-warning d-flex align-items-center mb-4';
                statusBox.innerHTML = '<i class="fas fa-exclamation-triangle me-2"></i><div>Select both dates under Activity Overview first.</div>';
                return;
            }
            if (!forceReload && loadedDateRange === requestedRange && allUserReportRows.length) {
                updateUserReport();
                return;
            }

            statusBox.className = 'alert alert-info d-flex align-items-center mb-4';
            statusBox.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span><div>Loading user activity report...</div>';
            reportList.innerHTML = '';
            pagination.innerHTML = '';
            resultCount.textContent = 'Loading users...';
            emptyState.classList.add('d-none');

            $.ajax({
                type: 'POST',
                url: 'audit_reporting',
                data: {
                    request_type: 'get_advanced_activity_logs_summary_by_user',
                    start_date_ar: startDateValue,
                    end_date_ar: endDateValue
                },
                cache: false,
                success: function (response) {
                    try {
                        var result = typeof response === 'string' ? JSON.parse(response) : response;
                        if (!result || result.success !== true) {
                            throw new Error((result && result.message) || 'Unable to load the report.');
                        }

                        allUserReportRows = Array.isArray(result.data) ? result.data : [];
                        loadedDateRange = requestedRange;
                        currentUserReportPage = 1;
                        populateUserReportFilter(regionSelect, 'All regions',
                            allUserReportRows.map(function (user) { return String(user.region || '').trim(); }));
                        populateUserReportFilter(designationSelect, 'All designations',
                            allUserReportRows.map(function (user) { return String(user.designation || '').trim(); }));
                        statusBox.className = 'alert alert-success d-flex align-items-center mb-4';
                        statusBox.innerHTML = '<i class="fas fa-check-circle me-2"></i><div>Report loaded for ' +
                            escapeUserReportValue(startDateValue) + ' to ' + escapeUserReportValue(endDateValue) + '.</div>';
                        updateUserReport();
                    } catch (error) {
                        allUserReportRows = [];
                        reportList.innerHTML = '';
                        pagination.innerHTML = '';
                        resultCount.textContent = 'No users loaded';
                        statusBox.className = 'alert alert-danger d-flex align-items-center mb-4';
                        statusBox.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i><div>' +
                            escapeUserReportValue(error.message) + '</div>';
                    }
                },
                error: function () {
                    allUserReportRows = [];
                    reportList.innerHTML = '';
                    pagination.innerHTML = '';
                    resultCount.textContent = 'No users loaded';
                    statusBox.className = 'alert alert-danger d-flex align-items-center mb-4';
                    statusBox.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i><div>Could not load the user activity report. Please try again.</div>';
                }
            });
        }

        [searchInput, regionSelect, designationSelect, sortSelect, pageSizeSelect].forEach(function (control) {
            control.addEventListener(control === searchInput ? 'input' : 'change', function () {
                currentUserReportPage = 1;
                updateUserReport();
            });
        });

        clearButton.addEventListener('click', function () {
            searchInput.value = '';
            regionSelect.value = '';
            designationSelect.value = '';
            sortSelect.value = 'activity';
            pageSizeSelect.value = '10';
            currentUserReportPage = 1;
            updateUserReport();
        });

        pagination.addEventListener('click', function (event) {
            var pageButton = event.target.closest('[data-page]');
            if (!pageButton || pageButton.closest('.page-item').classList.contains('disabled')) return;
            currentUserReportPage = Number(pageButton.dataset.page) || 1;
            updateUserReport();
            document.getElementById('report-by-user-pane').scrollIntoView({ behavior: 'smooth', block: 'start' });
        });

        document.getElementById('report-by-user-tab').addEventListener('shown.bs.tab', function () {
            loadUserReport(false);
        });

        document.getElementById('dateto').addEventListener('change', function () {
            if (document.getElementById('report-by-user-tab').classList.contains('active')) {
                loadUserReport(true);
            }
        });
    });
</script>
