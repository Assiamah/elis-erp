<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- <%@ page import="com.report_class.cls_reports" %> --%>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<jsp:useBean id="now" class="java.util.Date" />

<style>
.order-card {
    color: #fff;
}

.card {
    border-radius: 15px !important;
    overflow: hidden;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    border: none;
    margin-bottom: 30px;
    -webkit-transition: all 0.3s ease-in;
}

.card:hover {
    transform: translateY(-10px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}

.stat-card {
    transition: all 0.3s ease;
    border: none;
    position: relative;
    overflow: hidden;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
}

.stat-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: rgba(255, 255, 255, 0.4);
}

/* Softer Gradients */
.bg-c-blue {
    background: linear-gradient(135deg, #3a7bd5, #3a6073);
    color: white;
}

.bg-c-green {
    background: linear-gradient(135deg, #A8E063, #56AB2F);
    color: white;
}

.bg-c-yellow {
    background: linear-gradient(135deg, #ffb347, #ffcc33);
    color: white;
}

.bg-c-pink {
    background: linear-gradient(135deg, #4CAF50, #2E8B57);
    color: white;
}

.bg-c-red {
    background: linear-gradient(135deg, #ff6b6b, #ee5a52);
    color: white;
}

.bg-c-completed {
    background: linear-gradient(135deg, #00b09b, #96c93d);
    color: white;
}

/* .dashboard-main-card.primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
.dashboard-main-card.secondary { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
.dashboard-main-card.success { background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); }
.dashboard-main-card.warning { background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); }
.dashboard-main-card.danger { background: linear-gradient(135deg, #ff6b6b, #ee5a52); } */

.avatar {
    width: 50px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.avatar svg {
    width: 24px;
    height: 24px;
}

.svg-white {
    background-color: rgba(255, 255, 255, 0.2) !important;
}

#performance-alerts {
    max-height: 350px;
    overflow-y: auto;
}

#service-type-breakdown {
    max-height: 350px;
    overflow-y: auto;
    padding-right: 5px;
    scrollbar-width: thin;
    scrollbar-color: #999 #f1f1f1;
}

#service-type-breakdown::-webkit-scrollbar {
    width: 6px;
}

#service-type-breakdown::-webkit-scrollbar-thumb {
    background-color: #999;
    border-radius: 3px;
}

#service-type-breakdown::-webkit-scrollbar-track {
    background-color: #f1f1f1;
}

#regionComparisonChart {
    height: 400px;
}

.card-title {
    font-size: 14px;
    font-weight: 600;
    color: #495057;
    margin-bottom: 0.5rem;
}

.text-muted.fs-12 {
    font-size: 12px;
    opacity: 0.8;
}

.badge.bg-primary-transparent {
    background-color: rgba(102, 126, 234, 0.1) !important;
    color: #667eea !important;
    border: 1px solid rgba(102, 126, 234, 0.2);
}

.progress-stacked {
    height: 8px;
    border-radius: 4px;
    overflow: hidden;
}

.progress-animate {
    animation: progressAnimation 2s ease-in-out;
}

@keyframes progressAnimation {
    0% { width: 0%; }
}

.top-referral-pages li {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 8px 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.top-referral-pages li:last-child {
    border-bottom: none;
}

  #cabinetModal {
    z-index: 1040 !important;
}

/* Progress bar customization */
.progress-bar.bg-primary { background-color: #667eea !important; }
.progress-bar.bg-success { background-color: #28a745 !important; }
.progress-bar.bg-warning { background-color: #ffc107 !important; }
.progress-bar.bg-danger { background-color: #dc3545 !important; }

/* Responsive adjustments */
@media (max-width: 768px) {
    .modal-header .d-flex {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .modal-header .modal-icon-container {
        margin-bottom: 10px;
    }
    
    .modal-footer .d-flex {
        flex-direction: column;
        gap: 10px;
    }
    
    .modal-footer .text-muted {
        text-align: center;
    }
}

.region-name {
    max-width: 65%;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

  #repliesModal {
    z-index: 1045 !important;
}


</style>


<!-- Begin Page Content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div class="d-flex align-center gap-2">
                    <div>
                        <h1 class="page-title fw-medium fs-20 mb-1">
                            <i class="ri-dashboard-line me-2 text-primary"></i>Director Compliance Dashboard - ${division}
                        </h1>
                    </div>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Director</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Compliance Dashboard</li>
                </ol>
            </div>
        </div>

        <input type="hidden" id="director_regional_code" value="${regional_code}" />
        <input type="hidden" id="director_division" value="${division}" />
        <input type="hidden" id="startdate">
        <input type="hidden" id="start_date">
        <input type="hidden" id="enddate">
        <input type="hidden" id="end_date">

        <div class="row">
            <!-- Left Column: Quick Stats Cards -->
            <div class="col-xl-2">
                <div class="row">
                    <!-- Applications Received Today -->
                    <div class="col-xl-12 col-md-6 mb-4">
                        <a href="#" id="apps_received_today" data-toggle="tooltip" 
                           title="Applications Received Today. Click to view more details">
                            <div class="card stat-card custom-card dashboard-main-card primary">
                                <div class="card-body">
                                    <div class="d-flex align-items-start gap-3">
                                        <div>
                                            <span class="avatar avatar-md bg-primary svg-white">
                                                <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24" fill="currentColor">
                                                    <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-5h2v5zm4 0h-2v-3h2v3zm0-5h-2v-2h2v2zm4 5h-2V7h2v10z"></path>
                                                </svg>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="d-block text-muted">Applications Received</span>
                                            <h5 class="fw-semibold mb-1" id="app-received-today">0</h5>
                                            <div class="text-muted fs-14">
                                                <span class="text-success">as at today</span>
                                                ( <fmt:formatDate value="${now}" type="date" /> )
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>

                    <!-- Applications Pending As At Today -->
                    <div class="col-xl-12 col-md-6 mb-4">
                        <a href="#" id="apps_received_this_month" data-toggle="tooltip" 
                           title="Applications Pending as at Today. Click to view more details">
                            <div class="card stat-card custom-card dashboard-main-card warning">
                                <div class="card-body">
                                    <div class="d-flex align-items-start gap-3">
                                        <div>
                                            <span class="avatar avatar-md bg-warning svg-white">
                                                <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24" fill="currentColor">
                                                    <path d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm.5-13H11v6l5.25 3.15.75-1.23-4.5-2.67z"></path>
                                                </svg>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="d-block text-muted">Applications Pending</span>
                                            <h5 class="fw-semibold mb-1" id="app-received-month">0</h5>
                                            <div class="text-muted fs-14">
                                                <span class="text-warning">as at today</span>
                                                ( <fmt:formatDate value="${now}" type="date" /> )
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>

                    <!-- Applications Completed Today -->
                    <div class="col-xl-12 col-md-6 mb-4">
                        <a href="#" id="apps_completed_today_division" data-toggle="tooltip" 
                           title="Applications Completed Today. Click to view more details">
                            <div class="card stat-card custom-card dashboard-main-card success">
                                <div class="card-body">
                                    <div class="d-flex align-items-start gap-3">
                                        <div>
                                            <span class="avatar avatar-md bg-success svg-white">
                                                <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24" fill="currentColor">
                                                    <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"></path>
                                                </svg>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="d-block text-muted">Applications Completed</span>
                                            <h5 class="fw-semibold mb-1" id="app-completed-today">0</h5>
                                            <div class="text-muted fs-14">
                                                <span class="text-success">as at today</span>
                                                ( <fmt:formatDate value="${now}" type="date" /> )
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>

                    <!-- Applications Past Due -->
                    <!-- <div class="col-xl-12 col-md-6 mb-4">
                        <a href="#" id="pastdue_apps" data-toggle="tooltip" 
                           title="Applications Past Due. Click to view more details">
                            <div class="card stat-card custom-card dashboard-main-card danger">
                                <div class="card-body">
                                    <div class="d-flex align-items-start gap-3">
                                        <div>
                                            <span class="avatar avatar-md bg-danger svg-white">
                                                <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24" fill="currentColor">
                                                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"></path>
                                                </svg>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="d-block text-muted">Past Due Applications</span>
                                            <h5 class="fw-semibold mb-1" id="app-pastdue">0</h5>
                                            <div class="text-muted fs-12">
                                                <span class="text-danger">requires attention</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div> -->
                </div>
            </div>

            <!-- Right Column: Main Dashboard Content -->
            <div class="col-xl-10">
                <!-- Dashboard Header with Filters -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                            <!-- Title -->
                            <div>
                                <h4 class="mb-2 text-gray-800">Director Dashboard Overview</h4>
                                <p class="text-muted mb-0">Real-time application tracking and analytics for ${division}</p>
                            </div>

                            <!-- Filters -->
                            <div class="d-flex align-items-center flex-wrap gap-3">
                                <!-- Region Selector -->
                                <div class="card border shadow-sm flex-grow-1" style="min-width: 260px; max-width: 300px;">
                                    <div class="card-body py-2 px-3">
                                        <div class="d-flex align-items-center gap-3">
                                            <i class="ri-map-pin-2-fill text-primary fs-5"></i>
                                            <div class="flex-grow-1">
                                                <label class="form-label small text-muted mb-1">Region</label>
                                                <select id="sel_change_region_compliance" 
                                                    class="form-select form-select-sm border-0 p-0 bg-transparent fw-semibold text-dark">
                                                    <option value="${regional_code}">${regional_name}</option>
                                                    <c:forEach items="${officeregionlist}" var="officeregion">
                                                        <option value="${officeregion.ord_region_code}">
                                                            ${officeregion.ord_region_name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Date Range -->
                                <div class="d-flex align-items-center flex-wrap gap-3 flex-grow-1 flex-md-grow-0">
                                    <!-- Date From -->
                                    <div class="card border shadow-sm flex-grow-1" style="min-width: 180px; max-width: 220px;">
                                        <div class="card-body py-2 px-3">
                                            <div class="d-flex align-items-center gap-2">
                                                <i class="ri-calendar-event-line text-primary"></i>
                                                <div class="flex-grow-1">
                                                    <label class="form-label small text-muted mb-1">Date From</label>
                                                    <input type="text" id="datefrom" 
                                                        class="form-control form-control-sm border-0 p-0 fw-semibold w-100"
                                                        placeholder="Select start date" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Date Separator -->
                                    <div class="text-muted d-none d-md-block">
                                        <i class="ri-arrow-right-line"></i>
                                    </div>

                                    <!-- Date To -->
                                    <div class="card border shadow-sm flex-grow-1" style="min-width: 180px; max-width: 220px;">
                                        <div class="card-body py-2 px-3">
                                            <div class="d-flex align-items-center gap-2">
                                                <i class="ri-calendar-event-fill text-primary"></i>
                                                <div class="flex-grow-1">
                                                    <label class="form-label small text-muted mb-1">Date To</label>
                                                    <input type="text" id="dateto" 
                                                        class="form-control form-control-sm border-0 p-0 fw-semibold w-100"
                                                        placeholder="Select end date" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Application Types Breakdown & Performance Alerts -->
                <div class="row mb-4">
                    <!-- Application Types Breakdown -->
                    <div class="col-lg-7 mb-4" data-toggle="tooltip" 
                         title="Provides a breakdown of application Service types Received">
                        <div class="card shadow">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">APPLICATION TYPES BREAKDOWN</h6>
                            </div>
                            <div class="card-body">
                                <div class="service-type-breakdown" id="service-type-breakdown"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Performance Alerts -->
                    <div class="col-lg-5 mb-4" data-toggle="tooltip" 
                         title="Displays a summary of regional offices with high to low completion rates">
                        <div class="card shadow">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-black">Performance Alerts</h6>
                            </div>
                            <div class="card-body">
                                <div id="performance-alerts" class="alert-list"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Metrics Cards -->
                <div class="row mb-4">
                    <!-- Applications Received -->
                    <div id="app-received-year" class="col-lg-4 mb-4">
                        <div class="card custom-card">
                            <div class="card-header">
                                <div class="card-title" id="RecTitle">
                                    Applications Received from <span id="displayDateRange"></span>
                                </div>
                            </div>
                            <div class="card-body"
                                data-method="apps_created"
                                data-period="year"
                                data-url="DashboardAppsReceived"
                                data-next-level-modal="showServiceTypeModal_apps_recieved"
                                data-title="Applications Received"
                                data-date='This Year (<fmt:formatDate value="${now}" pattern="Y" />)'>
                                
                                <div class="d-flex align-items-center mb-3 flex-wrap">
                                    <h4 class="fw-bold mb-0"><span class="count">0</span></h4>
                                    <div class="ms-2">
                                        <span class="badge bg-primary-transparent">Applications</span>
                                    </div>
                                </div>
                                
                                <div class="progress-stacked progress-animate progress-sm mb-4">
                                    <!-- Progress bars will be dynamically generated -->
                                </div>
                                
                                <ul class="list-unstyled mb-0 pt-2 top-referral-pages">
                                    <!-- List items will be dynamically generated -->
                                </ul>
                                <div class="text-center mt-3">
                                <button type="button" 
                                        class="btn btn-sm btn-outline-primary show-more-btn d-none">
                                    Show More
                                </button>
                            </div>
                            </div>
                        </div>
                    </div>

                    <!-- Applications Received and Completed -->
                    <div id="app-received-completed-year" class="col-lg-4 mb-4">
                        <div class="card custom-card">
                            <div class="card-header">
                                <div class="card-title" id="RecComp">
                                    Applications Received and Completed from <span id="displayDateRange1"></span>
                                </div>
                            </div>
                            <div class="card-body"
                                data-method="apps_received_completed"
                                data-period="year"
                                data-url="DashboardAppsReceivedAndCompleted"
                                data-next-level-modal="showServiceTypeModal_apps_recieved_and_completed"
                                data-title="Applications Received and Completed"
                                data-date='This Year (<fmt:formatDate value="${now}" pattern="Y" />)'>
                                
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <div class="d-flex align-items-center">
                                        <h4 class="fw-bold mb-0 me-2"><span class="count">0</span></h4>
                                        <span class="badge bg-primary-transparent">Applications</span>
                                    </div>
                                    <div class="text-end">
                                        <div class="text-muted fs-11 mb-1">Completion Rate 
                                            <span class="fw-bold text-success" id="pec_id">0%</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="progress-stacked progress-animate progress-sm mb-4">
                                    <!-- Progress bars will be dynamically generated -->
                                </div>
                                
                                <ul class="list-unstyled mb-0 pt-2 top-referral-pages">
                                    <!-- List items will be dynamically generated -->
                                </ul>
                                 <div class="text-center mt-3">
                                <button type="button" 
                                        class="btn btn-sm btn-outline-primary show-more-btn d-none">
                                    Show More
                                </button>
                            </div>
                            </div>
                        </div>
                    </div>

                    <!-- Applications Completed -->
                    <div id="app-completed-year" class="col-lg-4 mb-4">
                        <div class="card custom-card">
                            <div class="card-header">
                                <div class="card-title" id="CompTitle">
                                    Applications Completed from <span id="displayDateRange2"></span>
                                </div>
                            </div>
                            <div class="card-body"
                                data-method="apps_completed"
                                data-period="year"
                                data-url="DashboardAppsCompleted"
                                data-next-level-modal="showServiceTypeModal_apps_completed"
                                data-title="Applications Completed"
                                data-date='This Year (<fmt:formatDate value="${now}" pattern="Y" />)'>
                                
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <div class="d-flex align-items-center">
                                        <h4 class="fw-bold mb-0 me-2"><span class="count">0</span></h4>
                                        <span class="badge bg-primary-transparent">Applications</span>
                                    </div>
                                </div>
                                
                                <div class="progress-stacked progress-animate progress-sm mb-4">
                                    <!-- Progress bars will be dynamically generated -->
                                </div>
                                
                                <ul class="list-unstyled mb-0 pt-2 top-referral-pages">
                                    <!-- List items will be dynamically generated -->
                                </ul>
                                 <div class="text-center mt-3">
                                <button type="button" 
                                        class="btn btn-sm btn-outline-primary show-more-btn d-none">
                                    Show More
                                </button>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Secondary Metrics Cards -->
                <div class="row mb-4">
                    <!-- Applications Past Due Date -->
                    <div id="app-past-due-year" class="col-lg-6 mb-4">
                        <div class="card custom-card">
                            <div class="card-header">
                                <div class="card-title">
                                    Applications Past Due Date from <span id="displayDateRange4"></span>
                                </div>
                            </div>
                            <div class="card-body"
                                data-method="apps_past_due"
                                data-period="year"
                                data-url="DashboardAppsPastDueDate"
                                data-next-level-modal="showServiceTypeModal_apps_pastdue"
                                data-title="Applications Past Due Date"
                                data-date='This Year (<fmt:formatDate value="${now}" pattern="Y" />)'>
                                
                                <div class="d-flex align-items-center mb-3 flex-wrap">
                                    <h4 class="fw-bold mb-0"><span class="count">0</span></h4>
                                    <div class="ms-2">
                                        <span class="badge bg-danger-transparent">Past Due</span>
                                    </div>
                                </div>
                                
                                <div class="progress-stacked progress-animate progress-sm mb-4">
                                    <!-- Progress bars will be dynamically generated -->
                                </div>
                                
                                <ul class="list-unstyled mb-0 pt-2 top-referral-pages">
                                    <!-- List items will be dynamically generated -->
                                </ul>
                                 <div class="text-center mt-3">
                                <button type="button" 
                                        class="btn btn-sm btn-outline-primary show-more-btn d-none">
                                    Show More
                                </button>
                            </div>
                            </div>
                        </div>
                    </div>

                    <!-- Applications With Regions -->
                    <div id="app-with-divisions" class="col-lg-6 mb-4">
                        <div class="card custom-card">
                            <div class="card-header">
                                <div class="card-title">
                                    Applications With Regions from <span id="displayDateRange5"></span>
                                </div>
                            </div>
                            <div class="card-body"
                                data-method="apps_with_division"
                                data-url="DashboardAppsWithDivision"
                                data-next-level-modal="showServiceTypeModal_apps_with_divisions"
                                data-title="Applications With Divisions">
                                
                                <div class="d-flex align-items-center mb-3 flex-wrap">
                                    <h4 class="fw-bold mb-0"><span class="count">0</span></h4>
                                    <div class="ms-2">
                                        <span class="badge bg-primary-transparent">With Regions</span>
                                    </div>
                                </div>
                                
                                <div class="progress-stacked progress-animate progress-sm mb-4">
                                    <!-- Progress bars will be dynamically generated -->
                                </div>
                                
                                <ul class="list-unstyled mb-0 pt-2 top-referral-pages">
                                    <!-- List items will be dynamically generated -->
                                </ul>
                                 <div class="text-center mt-3">
                                <button type="button" 
                                        class="btn btn-sm btn-outline-primary show-more-btn d-none">
                                    Show More
                                </button>
                            </div
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Regional Performance Comparison -->
                <div class="row">
                    <div class="col-lg-12 mb-4">
                        <div class="card shadow">
                            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                                <h6 class="m-0 font-weight-bold text-black text-uppercase">Regional Performance Comparison</h6>
                                <select id="region-comparison-metric" class="form-control form-control-sm w-auto">
                                    <option value="completion_rate">Completion Rate</option>
                                    <option value="avg_processing_days">Processing Time</option>
                                    <option value="total_received">Application Volume</option>
                                </select>
                            </div>
                            <div class="card-body">
                                <div id="regionComparisonChart" style="height: 450px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

 <jsp:include page="../../components/_director_modals.jsp"></jsp:include>

<script>
	const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl);
});
</script>