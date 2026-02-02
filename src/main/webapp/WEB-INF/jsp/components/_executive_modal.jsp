<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
 <jsp:useBean id="now" class="java.util.Date"/>    

<!-- Division Modal-->

<!-- <div class="modal fade effect-scale modal-blur" id="cabinetModal" tabindex="-1" aria-labelledby="addInspectionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addMinutesModalLabel">Application Tracking History</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">History</div>
                            <div class="card-body">
                                <table class="table table-bordered" id="cabinet-tracking">
                                    <thead>
                                        <tr>
                                            <th>Comments</th>
                                            <th>Division/Unit</th>
                                            <th>Batching Officer</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">Details</div>
                            <div class="card-body">
                                <form>
                                    <fieldset>
                                        <div class="form-group mb-3">
                                            <label for="staticEmail" class="col-form-label">Applicant Name</label>
                                            <textarea readonly class="form-control" id="enq_applicant_name"></textarea>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="staticEmail" class="col-form-label">Applicant type</label> 
                                            <input type="text" readonly class="form-control" id="enq_applicant_type">
                                        </div>
                                    </fieldset>
                                    <hr>
                                    <fieldset>
                                        <div class="form-group mb-3">
                                            <label for="staticEmail" class="col-form-label">Cabinet Name</label> 
                                            <input type="text" readonly class="form-control" id="enq_cabinet_name">
                                        </div>
                                        <hr>
                                        <div class="form-group mb-3">
                                            <label for="staticEmail" class="col-form-label">Job Purpose</label>
                                            <textarea readonly class="form-control" id="enq_job_purpose" rows="4"></textarea>
                                        </div> 
                                        <div class="form-group mb-3">
                                            <label for="staticEmail" class="col-form-label">Job Status</label> 
                                            <textarea readonly class="form-control" id="enq_job_status" rows="4"></textarea>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="staticEmail" class="col-form-label">Application Status</label> 
                                            <textarea readonly class="form-control" id="enq_current_application_status" rows="4"></textarea>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> -->


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





<div class="modal fade effect-scale modal-blur" id="recieved_reporting_modal" tabindex="-1" aria-labelledby="recievedReportingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="recieved_applications_title"><span id="reportheading"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications</h6>
                                            <h3 class="stat-value" id="totalServices">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-info text-white p-3 rounded">
                                            <h6 class="stat-title">Total Services</h6>
                                            <h3 class="stat-value" id="totalApplications">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRange">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="main_service_table" width="100%" cellspacing="0" data-order='[[1, "desc"]]'>
                        <thead>
                            <tr>
                                <th>Service Name</th>
                                <th>Count</th>
                                <th>Percentage</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="sub_service_modal" tabindex="-1" aria-labelledby="subServiceModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sub_service_modalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications</h6>
                                            <h3 class="stat-value" id="totalServicesSub">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-info text-white p-3 rounded">
                                            <h6 class="stat-title">Total Sub Services</h6>
                                            <h3 class="stat-value" id="totalApplicationsSub">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRangeSub">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="sub_service_table" width="100%" cellspacing="0" data-order='[[1, "desc"]]'>
                        <thead>
                            <tr>
                                <th>Sub Service Name</th>
                                <th>Count</th>
                                <th>Percentage</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="apps_modal" tabindex="-1" aria-labelledby="appsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="apps_modalLabel">Applications Received</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications</h6>
                                            <h3 class="stat-value" id="totalApplicationsRecApps">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRangeSubRecApps">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="apps_table" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Job Number</th>
                                <th>Applicant Name</th>
                                <th>Application Type</th>
                                <th>Submission Date</th>
                                <th>Pending Days</th>
                                <th>Current Stage</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="completed_apps_modal" tabindex="-1" aria-labelledby="completedAppsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completed_apps_modalLabel">Applications Received</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications</h6>
                                            <h3 class="stat-value" id="completed_totalApplicationsRecApps">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="completed_dateRangeSubRecApps">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="completed_apps_table" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Job Number</th>
                                <th>Applicant Name</th>
                                <th>Application Type</th>
                                <th>Submission Date</th>
                                <th>Completed Date</th>
                                <th>TAT</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<!-- <div class="modal fade effect-scale modal-blur" id="sendMessageModal_FocalCompliance" tabindex="-1" aria-labelledby="sendMessageModalLabelFocalCompliance" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sendMessageModalLabel_FocalCompliance"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="previousMessages" class="mb-3">
                    <h6 class="text-dark font-weight-bold mb-2">Previous Notices</h6>
                    <div id="messagesContainer" class="border rounded p-2 bg-light" style="max-height: 200px; overflow-y: auto;">
                        <p class="text-muted mb-0">Loading previous messages...</p>
                    </div>
                </div>
                <hr>
                <form method="post" id="message-form_focal_complaince" action="SendComplianceMessage">
                    <input id="focal_officer_id" name="officer_id" type="hidden"/>
                    <input id="request_type" value="send_compliance_focal_person_message" type="hidden">
                    <input id="officer_name" name="officer_name" type="hidden"/>
                    <input id="job_numbers" name="job_numbers[]" type="hidden"/>
                    <div class="mb-3">
                        <label for="message_type" class="form-label">Message Type</label>
                        <select required class="form-control" name="message_type" id="message_type">
                            <option value="">Select One</option>
                            <option value="query">Query</option>
                            <option value="Warning">Warning</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label">Message</label>
                        <textarea required class="form-control" name="message" id="message"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div> -->

<!-- <div class="modal fade effect-scale modal-blur" data-position="0" id="sendMessageModal" tabindex="-1" aria-labelledby="sendMessageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sendMessageModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="post" id="message-form" action="SendComplianceMessage">
                    <input id="officer_id" name="officer_id" type="hidden"/>
                    <input id="request_type" value="send_compliance_focal_person_message" type="hidden">
                    <input id="officer_name" name="officer_name" type="hidden"/>
                    <input id="job_numbers" name="job_numbers[]" type="hidden"/>
                    <div class="mb-3">
                        <label for="message_type" class="form-label">Message Type</label>
                        <select required class="form-control" name="message_type" id="message_type">
                            <option value="">Select One</option>
                            <option value="query">Query</option>
                            <option value="Warning">Warning</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label">Message</label>
                        <textarea required class="form-control" name="message" id="message"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div> -->



<div class="modal fade effect-scale modal-blur" id="sendMessageModal" tabindex="-1" aria-labelledby="sendMessageModalLabel" style="z-index: 1029;" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="sendMessageModalLabel">
                        <i class="ri-message-2-line me-2 text-primary"></i>
                        <span id="modalTitleText">Send Message</span>
                    </h5>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <!-- Recipient Info Card -->
                <div class="card border mb-4">
                    <div class="card-body py-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-md bg-primary bg-opacity-10 rounded-circle me-3">
                                <i class="ri-user-line text-primary fs-4"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-0 fw-semibold" id="recipientNameDisplay">Select a recipient</h6>
                                <small class="text-muted" id="recipientInfo">No recipient selected</small>
                            </div>
                            <div class="badge bg-light text-dark" id="jobCountBadge">0 jobs</div>
                        </div>
                    </div>
                </div>
                
                <div class="rec-table">

                </div>
                <hr>

                <!-- Message Form -->
                <form method="post" id="message-form" action="SendComplianceMessage" class="needs-validation" novalidate>
                    <input id="officer_id" name="officer_id" type="hidden"/>
                    <input id="request_type" name="request_type" value="send_compliance_message" type="hidden">
                    <input id="officer_name" name="officer_name" type="hidden"/>
                    <input id="job_numbers" name="job_numbers[]" type="hidden"/>

                    <!-- Message Type -->
                    <div class="mb-4">
                        <label for="message_type" class="form-label fw-medium">
                            <i class="ri-chat-1-line me-1 text-muted"></i>
                            Message Type
                            <span class="text-danger">*</span>
                        </label>
                        <div class="btn-group w-100" role="group" aria-label="Message type selection">
                            <input type="radio" class="btn-check" name="message_type" id="message_type_query" value="query" autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="message_type_query">
                                <i class="ri-question-line me-1"></i>Query
                            </label>
                            
                            <input type="radio" class="btn-check" name="message_type" id="message_type_message" value="message" autocomplete="off">
                            <label class="btn btn-outline-primary" for="message_type_message">
                                <i class="ri-message-2-line me-1"></i>Message
                            </label>
                            
                            <input type="radio" class="btn-check" name="message_type" id="message_type_reminder" value="reminder" autocomplete="off">
                            <label class="btn btn-outline-primary" for="message_type_reminder">
                                <i class="ri-alarm-warning-line me-1"></i>Reminder
                            </label>
                        </div>
                        <div class="form-text">
                            <i class="ri-information-line me-1"></i>
                            Select the type of message you want to send
                        </div>
                    </div>

                    <!-- Message Content -->
                    <div class="mb-4">
                        <label for="message" class="form-label fw-medium">
                            <i class="ri-chat-quote-line me-1 text-muted"></i>
                            Message Content
                            <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <textarea class="form-control" name="message" id="message" 
                                      rows="5" placeholder="Type your message here..." 
                                      required style="resize: none;"></textarea>
                            <span class="input-group-text bg-light align-items-start">
                                <i class="ri-pencil-line text-muted"></i>
                            </span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-2">
                            <div class="form-text">
                                <i class="ri-information-line me-1"></i>
                                Write your message to the recipient
                            </div>
                            <small class="text-muted" id="charCount">0/1000 characters</small>
                        </div>
                    </div>

                    <!-- Template Suggestions (Optional) -->
                    <div class="mb-4">
                        <label class="form-label fw-medium">
                            <i class="ri-stack-line me-1 text-muted"></i>
                            Quick Templates
                        </label>
                        <div class="d-flex flex-wrap gap-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="query">
                                <i class="ri-question-line me-1"></i>Urgent Query
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="followup">
                                <i class="ri-time-line me-1"></i>Follow-up Required
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="reminder">
                                <i class="ri-alarm-warning-line me-1"></i>TAT Reminder
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary template-btn" data-template="update">
                                <i class="ri-refresh-line me-1"></i>Status Update
                            </button>
                        </div>
                    </div>

                    <!-- Preview Section -->
                    <div class="card border mb-4" id="previewCard" style="display: none;">
                        <div class="card-header bg-light">
                            <h6 class="mb-0 fw-semibold">
                                <i class="ri-eye-line me-2"></i>Message Preview
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-light border" id="messagePreview">
                                <small class="text-muted">Preview will appear here</small>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
                            <i class="ri-close-line me-1"></i>Cancel
                        </button>
                        <button type="reset" class="btn btn-outline-warning" id="btnResetForm">
                            <i class="ri-refresh-line me-1"></i>Reset
                        </button>
                        <button type="submit" class="btn btn-primary flex-grow-1" id="btnSubmitMessage">
                            <i class="ri-send-plane-line me-1"></i>
                            <span id="submitButtonText">Send Message</span>
                            <span class="spinner-border spinner-border-sm ms-2 d-none" id="loadingSpinner" role="status" aria-hidden="true"></span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="status_modal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="status_title"><span id="reportheading"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications</h6>
                                            <h3 class="stat-value" id="totalRegApps">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRangeRegApps">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="status_table" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Status Type</th>
                                <th>Count</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="regional_modal" tabindex="-1" aria-labelledby="regionalModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="region_title"><span id="reportheading"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications</h6>
                                            <h3 class="stat-value" id="totalregionApps">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-info text-white p-3 rounded">
                                            <h6 class="stat-title">Total Row Count</h6>
                                            <h3 class="stat-value" id="totalRegionalCount">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRangeRegions">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="regions_table" width="100%" cellspacing="0" data-order='[[1, "desc"]]'>
                        <thead>
                            <tr>
                                <th>Region</th>
                                <th>Count</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="divisions_modal" tabindex="-1" aria-labelledby="divisionsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="divisions_title"><span id="reportheading"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications</h6>
                                            <h3 class="stat-value" id="totalDivisionalApps">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-info text-white p-3 rounded">
                                            <h6 class="stat-title">Total Row Count</h6>
                                            <h3 class="stat-value" id="totalDivisionCount">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRangeDivision">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="divisions_table" width="100%" cellspacing="0" data-order='[[1, "desc"]]'>
                        <thead>
                            <tr>
                                <th>Division</th>
                                <th>Count</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="units_modal" tabindex="-1" aria-labelledby="unitsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="units_title"><span id="reportheading"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications With Unit(s)</h6>
                                            <h3 class="stat-value" id="totalDivisionalUnits">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-info text-white p-3 rounded">
                                            <h6 class="stat-title">Total Row Count</h6>
                                            <h3 class="stat-value" id="totalDivisionUnit">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRangeDivisionUnit">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="units_table" width="100%" cellspacing="0" data-order='[[1, "desc"]]'>
                        <thead>
                            <tr>
                                <th>Division</th>
                                <th>Count</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="officers_modal" tabindex="-1" aria-labelledby="officersModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="officers_title"><span id="reportheading"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications With Officer(s)</h6>
                                            <h3 class="stat-value" id="totalDivisionalAppsStaff">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-info text-white p-3 rounded">
                                            <h6 class="stat-title">Total Number of Officer(s)</h6>
                                            <h3 class="stat-value" id="totalDivisionCountStaff">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRangeDivisionStaff">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="officers_table" width="100%" cellspacing="0" data-order='[[1, "desc"]]'>
                        <thead>
                            <tr>
                                <th>Staff Name</th>
                                <th>Count</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="staffapps_modal" tabindex="-1" aria-labelledby="staffappsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staffapps_modalLabel">Applications Received</h5>
                <div id="sendmsg"></div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications</h6>
                                            <h3 class="stat-value" id="totalStaffApps">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRangeStaffApps">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="staffapps_table" width="100%" cellspacing="0" data-order='[[1, "desc"]]'>
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="select-all"></th>
                                <th>Job Number</th>
                                <th>Applicant Name</th>
                                <th>Application Type</th>
                                <th>Submission Date</th>
                                <th>Pending Days</th>
                                <th>Date Received by Officer</th>
                                <th>Days With Officer</th>
                                <th>Current Stage</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="regional_divisions_modal" tabindex="-1" aria-labelledby="regionalDivisionsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="regional_divisions_title"><span id="reportheading"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Report Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="stat-card bg-success text-white p-3 rounded">
                                            <h6 class="stat-title">Total Applications</h6>
                                            <h3 class="stat-value" id="totalDivisionalAppsNew">0</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <div class="stat-card bg-danger text-white p-3 rounded">
                                            <h6 class="stat-title">Date Range</h6>
                                            <h3 class="stat-value" id="dateRangeDivisionNew">-</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="regional_divisions_table" width="100%" cellspacing="0" data-order='[[1, "desc"]]'>
                        <thead>
                            <tr>
                                <th>Division</th>
                                <th>Count</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close <i class="fa fa-times"></i></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="repliesModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title">Notice Replies</h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="repliesModalBody">
                <!-- Replies will load here -->
            </div>
        </div>
    </div>
</div>





<div class="modal fade effect-scale modal-blur" id="previousNoticesModal" tabindex="-1" aria-labelledby="previousNoticesModalLabel" style="z-index: 1029;" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header border-bottom bg-light">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title fw-semibold mb-0" id="previousNoticesModalLabel">
                        <i class="ri-message-2-line me-2 text-primary"></i>
                        <!-- <span id="modalTitleText">Send Message</span> -->
                    </h5>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
				<!-- 🕓 PREVIOUS MESSAGES SECTION -->
                <div id="previousMessages" class="mb-3">
					<h6 class="text-dark font-weight-bold mb-2">Previous Notices</h6>
					<div id="messagesContainer" class="border rounded p-2 bg-light" style="max-height: 200px; overflow-y: auto;">
						<p class="text-muted mb-0">Loading previous messages...</p>
					</div>
				</div>

                <!-- Message Form -->
                
            </div>
        </div>
    </div>
</div>
