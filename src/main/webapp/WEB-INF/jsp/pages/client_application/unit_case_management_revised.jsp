<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<div class="main-content app-content">
    <div class="container-fluid page-container">
        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Unit Case Management</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Unit Case Management</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <!-- Hidden Inputs -->
        <input type="hidden" id="userid" value="${sessionScope.userid}">
        <input type="hidden" class="form-control" id="inc_1" value="${incoming}">
        <input type="hidden" class="form-control" id="com_3" value="${completed}">
        <input type="hidden" class="form-control" id="que_2" value="${queried}">
        <input type="hidden" class="form-control" id="awa_4" value="${awaiting_payment}">
        <input type="hidden" class="form-control" id="awa_req_5" value="${awaiting_request}">
        <input type="hidden" class="form-control" id="req_com_6" value="${completed_request}">
        <input type="hidden" class="form-control" id="req_com_7" value="${attention_required}">

        <!-- Stats Cards -->

        <!-- Start:: row-1 -->
        <div class="row">
            <div class="col-xxl-9">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="card custom-card stat-card dashboard-main-card primary" id="card-incoming">
                            <a href="javascript:void(0);" class="btnLoadUnitApplications" data-id="1">
                                <div class="card-body" id="body-bg-1">
                                    <div class="d-flex align-items-start gap-3">
                                        <div>
                                            <span class="avatar avatar-md bg-primary svg-white">
                                                <i class="ri-download-2-line fs-20"></i>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="d-block text-muted">Incoming Files</span>
                                            <h5 class="fw-semibold mb-1">${incoming}</h5>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card custom-card stat-card dashboard-main-card danger" id="card-queried">
                            <a href="javascript:void(0);" class="btnLoadUnitApplications" data-id="2">
                                <div class="card-body" id="body-bg-2">
                                    <div class="d-flex align-items-start gap-3">
                                        <div>
                                            <span class="avatar avatar-md bg-danger svg-white">
                                                <i class="ri-error-warning-line fs-20"></i>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="d-block text-muted">Queried</span>
                                            <h5 class="fw-semibold mb-1">${queried}</h5>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card custom-card stat-card dashboard-main-card warning" id="card-awaiting_payments">
                            <a href="javascript:void(0);" class="btnLoadUnitApplications" data-id="4">
                                <div class="card-body" id="body-bg-4">
                                    <div class="d-flex align-items-start gap-3">
                                        <div>
                                            <span class="avatar avatar-md bg-warning svg-white">
                                              <i class="ri-hand-coin-line fs-20"></i>
                                            </span>
                                        </div>  
                                        <div>
                                            <span class="d-block text-muted">Awaiting Payments</span>
                                            <h5 class="fw-semibold mb-1">${awaiting_payment}</h5>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card custom-card stat-card dashboard-main-card info" id="card-awaiting_request">
                            <a href="javascript:void(0);" class="btnLoadUnitApplications" data-id="5">
                                <div class="card-body" id="body-bg-5">
                                    <div class="d-flex align-items-start gap-3">
                                        <div>
                                            <span class="avatar avatar-md bg-info svg-white">
                                             <i class="ri-time-line fs-20"></i>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="d-block text-muted">Awaiting Request</span>
                                            <h5 class="fw-semibold mb-1">${awaiting_request}</h5>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card custom-card stat-card dashboard-main-card success" id="card-request_completed">
                            <a href="javascript:void(0);" class="btnLoadUnitApplications" data-id="6">
                                <div class="card-body" id="body-bg-6">
                                    <div class="d-flex align-items-start gap-3">
                                        <div>
                                            <span class="avatar avatar-md bg-success svg-white">
                                             <i class="ri-checkbox-circle-line fs-20"></i>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="d-block text-muted">Request Completed</span>
                                            <h5 class="fw-semibold mb-1">${completed_request}</h5>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card custom-card stat-card dashboard-main-card secondary" id="card-attention_required">
                            <a href="javascript:void(0);" class="btnLoadUnitApplications" data-id="7">
                                <div class="card-body" id="body-bg-7">
                                    <div class="d-flex align-items-start gap-3">
                                        <div>
                                            <span class="avatar avatar-md bg-secondary svg-white">
                                             <i class="ri-question-line fs-20"></i>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="d-block text-muted">Attention Required</span>
                                            <h5 class="fw-semibold mb-1">${attention_required}</h5>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-xl-12">
                        <div class="card custom-card overflow-hidden">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div class="card-title">
                                    Application Details
                                </div>
                                <div>
                                    <button class="btn btn-warning label-btn" id="btnViewBatchlist">
                                        <i class="ri-list-check label-btn-icon"></i>
                                        View Batch List
                                    </button>
                                    <button class="btn btn-primary label-btn" data-bs-toggle="modal" data-bs-target="#incoming_advanced_search">
                                        <i class="ri-filter-line label-btn-icon"></i>
                                        Advanced Filter
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-3">
                                <div class="row d-none" id="allBatchList">
                                    <div class="col-xl-3 col-lg-4 col-md-4 col-sm-12">
                                        <div class="card card-body">
                                            <div class="form-group mb-2">
                                                <label for="">Purpose for Bactching</label>
                                                <input type="text" class="form-control form-control-sm" id="txt_general_job_purpose">
                                            </div>
                                            <div class="form-group mb-2">
                                                <label for="">Remarks/Notes</label>
                                                <textarea type="text" class="form-control col" id="txt_general_remarks_notes"  value="" placeholder="Remarks/Notes"></textarea>
                                            </div>
                                            <button class="btn btn-sm w-100 btn-primary"  id="btnAddAlltoBatchlist">Add All to Batch List</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-striped"  id="job_casemgtdetailsdataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th>
                                                    <input type="checkbox" class="form-check-input" id="selectAll">
                                                </th>
                                                <th>Created Date</th>
                                                <th>Job Number</th>
                                                <th>Applicant Name</th>
                                                <th>Application Type</th>
                                                <th>Status</th>
                                                <th>Sent By</th>
                                                <th>Locality</th>
                                                <th>Type of Plotting</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xxl-3">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card custom-card overflow-hidden custom-hrm-list">
                            <div class="card-body p-0">
                                <div class="row g-0">
                                    <div class="col-xl-6 ">
                                        <div class="card custom-card stat-card dashboard-main-card border-0 shadow-none border-lg-end border-bottom mb-0 rounded-0">
                                            <a href="javascript:void(0);" id="btn_load_resolved_queries">
                                                 <div class="card-body">
                                                    <div class="mb-3">
                                                        <span class="avatar avatar-lg avatar-rounded bg-primary-transparent svg-primary">
                                                            <i class="ri-discuss-fill fs-20"></i>
                                                        </span>
                                                    </div>
                                                    <div class="text-muted mb-2">
                                                        Responded Queries
                                                    </div>
                                                    <div class="d-flex align-items-end gap-2 flex-wrap">
                                                        <h5 class="fw-semibold mb-0 lh-1">${query_response}</h5>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="card custom-card stat-card dashboard-main-card border-0 shadow-none border-bottom mb-0 rounded-0">
                                            <a href="javascript:void(0);" class="loadReminderApps"
                                                data-method="reminder_apps" 
                                                data-url="DashboardAppsWithDivision" 
                                                data-type="${unit_name}" 
                                                data-title="Applications" 
                                            >
                                                <div class="card-body">
                                                    <div class="mb-3">
                                                        <span class="avatar avatar-lg avatar-rounded bg-info-transparent svg-info">
                                                            <i class="ri-24-hours-fill fs-20"></i>
                                                        </span>
                                                    </div>
                                                    <div class="text-muted mb-2">
                                                        Reminder Queries
                                                    </div>
                                                    <div class="d-flex align-items-end gap-2 flex-wrap">
                                                        <h5 class="fw-semibold mb-0 lh-1">${reminders}</h5>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="card custom-card stat-card dashboard-main-card dashboard-main-border border-0 shadow-none border-lg-end mb-0 rounded-0">
                                            <a href="javascript:void(0);" class="loadWarningApps"
                                                data-method="warning_apps" 
                                                data-url="DashboardAppsWithDivision" 
                                                data-type="${unit_name}" 
                                                data-title="Applications" 
                                            >
                                                <div class="card-body">
                                                    <div class="mb-3">
                                                        <span class="avatar avatar-lg avatar-rounded bg-warning-transparent svg-warning">
                                                            <i class="ri-alarm-warning-line fs-20"></i>
                                                        </span>
                                                    </div>
                                                    <div class="text-muted mb-2">
                                                        Warning Queries
                                                    </div>
                                                    <div class="d-flex align-items-end gap-2 flex-wrap">
                                                        <h5 class="fw-semibold mb-0 lh-1">${warnings}</h5>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="card custom-card stat-card dashboard-main-card border-0 shadow-none mb-0 rounded-0">
                                            <a href="javascript:void(0);" class="loadComplianceQueriesApps"
                                                data-method="compliance_queries_apps" 
                                                data-url="DashboardAppsWithDivision" 
                                                data-type="${unit_name}" 
                                                data-title="Applications" 
                                            >
                                                <div class="card-body">
                                                    <div class="mb-3">
                                                        <span class="avatar avatar-lg avatar-rounded bg-danger-transparent svg-danger">
                                                            <i class="ri-questionnaire-fill fs-20"></i>
                                                        </span>
                                                    </div>
                                                    <div class="text-muted mb-2">
                                                        Compliance Queries
                                                    </div>
                                                    <div class="d-flex align-items-end gap-2 flex-wrap">
                                                        <h5 class="fw-semibold mb-0 lh-1">${compliance_queries}</h5>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-12">
                        <div class="card custom-card">
                            <div class="card-header d-flex justify-content-between">
                                <div class="card-title">
                                    Unit Monitoring
                                </div>
                                <div>
                                    <button class="btn btn-sm btn-warning showOfficerList"
                                        data-method="apps_with_division" 
                                        data-url="DashboardAppsWithDivision"
                                        data-type="${unit_name}" 
                                        data-title="Applications With Divisions"
                                        data-date="" 
                                        data-unit-id="${unit_id}" 
                                        data-division="${division}"
                                    >
                                        <i class="ri-refresh-line"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-info showOfficerModal"
                                        data-method="apps_with_division" 
                                        data-url="DashboardAppsWithDivision"
                                        data-type="${unit_name}" 
                                        data-title="Applications With Divisions"
                                        data-date="" 
                                        data-unit-id="${unit_id}" 
                                        data-division="${division}"
                                    >
                                        View All
                                    </button>
                                </div>
                            </div>
                            <div class="card-body">
                                <ul class="pt-2 list-unstyled top-country-sales-list">
                                    <div class="alert alert-dark border mb-0 p-2">
                                        <div class="d-flex align-items-start">
                                            <div class="me-2 svg-dark">
                                                <svg class="flex-shrink-0" xmlns="http://www.w3.org/2000/svg" height="1.5rem" viewBox="0 0 24 24" width="1.5rem" fill="#000000">
                                                    <path d="M0 0h24v24H0V0z" fill="none"></path>
                                                    <path d="M11 7h2v2h-2zm0 4h2v6h-2zm1-9C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z"></path>
                                                </svg>
                                            </div>
                                            <div class="text-dark w-100">
                                                <div class="fw-medium d-flex justify-content-between">Unit Monitoring Dashboard</div>
                                                <div class="fs-12 op-8 mb-1">
                                                    <strong>Refresh Button</strong> <span class="text-muted">(Yellow)</span> - Click to load/update the top 10 officers with their application counts.
                                                </div>
                                                <div class="fs-12 op-8 mb-1">
                                                    <strong>View All Button</strong> <span class="text-muted">(Blue)</span> - Click to open detailed view showing all officers in a modal.
                                                </div>
                                                <div class="fs-12 op-8">
                                                    This dashboard shows officer performance metrics for the <strong>${unit_name}</strong> unit.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End:: row-1 -->
    </div>
</div>
