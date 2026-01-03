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



<div class="modal fade effect-scale modal-blur" id="newactivityDetailsModal" tabindex="-1"
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





<div class="modal fade effect-scale modal-blur" id="addParcelDetailsModal" tabindex="-1"
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






<div class="modal fade effect-scale modal-blur" id="transactionUpdateModal" tabindex="-1"
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






<div class="modal fade effect-scale modal-blur" id="transactionDeleteModal"
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