<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- <%@ page import="com.report_class.cls_reports" %> --%>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<jsp:useBean id="now" class="java.util.Date" />

<style>
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

    .stat-icon {
        transition: all 0.3s ease;
    }

    .stat-card:hover .stat-icon {
        transform: scale(1.1) rotate(5deg);
        background: rgba(255, 255, 255, 0.3) !important;
    }

    .bg-gradient-danger {
        background: linear-gradient(135deg, #f5365c 0%, #f56036 100%);
    }

    .bg-gradient-info {
        background: linear-gradient(135deg, #11cdef 0%, #1171ef 100%);
    }

    .bg-gradient-success {
        background: linear-gradient(135deg, #2dce89 0%, #2dcecc 100%);
    }

    .bg-white-20 {
        background: rgba(255, 255, 255, 0.2);
    }

    .display-4 {
        font-size: 2.5rem;
        font-weight: 700;
        line-height: 1;
    }

    @media (max-width: 768px) {
        .display-4 {
            font-size: 2rem;
        }
    }

    .progress {
        border-radius: 10px;
        overflow: hidden;
    }

    .progress-bar {
        border-radius: 10px;
    }
</style>

<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Dashboard</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a
                            href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">
                        Dashboard</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <!-- Start:: row-1 -->
        <!-- Welcome Header -->
<div class="row mb-4">
    <div class="col-12">
        <div class="card custom-card border-0 shadow-sm">
            <div class="card-body p-4">
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center">
                        <div class="avatar avatar-xl bg-primary bg-opacity-10 rounded-circle p-3 me-3">
                            <i class="ri-user-line fs-24 text-primary"></i>
                        </div>
                        <div>
                            <h2 class="mb-1">Welcome back, <span class="text-primary">${fullname}</span></h2>
                            <p class="text-muted mb-0">
                                <i class="ri-calendar-line me-1"></i>
                                <fmt:formatDate value="${now}" pattern="EEEE, MMMM d, yyyy" />
                                <!-- <span class="mx-2">•</span>
                                <i class="ri-time-line me-1"></i>
                                <span id="currentTime"></span> -->
                            </p>
                        </div>
                    </div>
                    <div class="d-none d-md-block">
                        <div class="d-flex align-items-center">
                            <div class="me-3 text-end">
                                <div class="text-muted small">Productivity Score</div>
                                <div class="h4 mb-0">${completion_rate}</div>
                            </div>
                            <div class="progress" style="width: 100px; height: 8px;">
                                <fmt:parseNumber value="${completion_rate}" integerOnly="true" var="completionRate" />
                                <div class="progress-bar bg-gradient-primary" role="progressbar" 
                                     style="width: ${completionRate > 100 ? 100 : completionRate}%">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Quick Stats Cards -->
<div class="row mb-4">
    <div class="col-xxl-5">
        <div class="row">
            <!-- Current Applications -->
            <div class="col-xl-6 mb-3">
                <div class="card stat-card custom-card border-0 shadow-sm hover-lift">
                    <a href="${pageContext.request.contextPath}/case_movement_module" class="text-decoration-none">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <div class="text-muted small mb-1">Current Applications</div>
                                    <h3 class="fw-bold mb-0">${apps_with_user}</h3>
                                    <div class="text-muted small mt-1">
                                        <i class="ri-calendar-event-line me-1"></i>
                                        As of today
                                    </div>
                                </div>
                                <div class="avatar avatar-lg bg-info bg-opacity-10 rounded-circle p-3">
                                    <i class="ri-file-list-3-line fs-24 text-info"></i>
                                </div>
                            </div>
                            <div class="progress mt-3" style="height: 4px;">
                                <div class="progress-bar bg-info" style="width: ${apps_with_user > 0 ? '60%' : '0%'}"></div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Overdue Applications -->
            <div class="col-xl-6 mb-3">
                <div class="card stat-card custom-card border-0 shadow-sm hover-lift">
                    <a href="javascript:void(0);" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#appsPassedDueModal">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <div class="text-muted small mb-1">Requires Attention</div>
                                    <h3 class="fw-bold mb-0 text-danger">${apps_past_due_dates}</h3>
                                    <div class="text-danger small mt-1">
                                        <i class="ri-alert-line me-1"></i>
                                        Overdue applications
                                    </div>
                                </div>
                                <div class="avatar avatar-lg bg-danger bg-opacity-10 rounded-circle p-3">
                                    <i class="ri-alert-line fs-24 text-danger"></i>
                                </div>
                            </div>
                            <c:if test="${apps_past_due_dates > 0}">
                                <div class="alert alert-danger light mt-3 py-2 small mb-0">
                                    <i class="ri-information-line me-1"></i>
                                    ${apps_past_due_dates} applications need immediate review
                                </div>
                            </c:if>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Applications Received -->
            <div class="col-xl-6 mb-3">
                <div class="card stat-card custom-card border-0 shadow-sm hover-lift">
                    <a href="javascript:void(0);" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#appsReceivedMonthModal">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <div class="text-muted small mb-1">This Month's Inflow</div>
                                    <h3 class="fw-bold mb-0 text-warning">${apps_rec_month}</h3>
                                    <div class="text-muted small mt-1">
                                        <i class="ri-arrow-down-line me-1"></i>
                                        <fmt:formatDate value="${now}" pattern="MMMM" /> applications
                                    </div>
                                </div>
                                <div class="avatar avatar-lg bg-warning bg-opacity-10 rounded-circle p-3">
                                    <i class="ri-download-2-line fs-24 text-warning"></i>
                                </div>
                            </div>
                            <div class="mt-3">
                                <span class="badge bg-warning bg-opacity-10 text-warning">
                                    <i class="ri-trending-up-line me-1"></i>
                                    Monthly intake
                                </span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Completed Applications -->
            <div class="col-xl-6 mb-3">
                <div class="card stat-card custom-card border-0 shadow-sm hover-lift">
                    <a href="javascript:void(0);" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#appsCompletedMonthModal">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <div class="text-muted small mb-1">Monthly Achievements</div>
                                    <h3 class="fw-bold mb-0 text-primary">${apps_comp_month}</h3>
                                    <div class="text-muted small mt-1">
                                        <i class="ri-checkbox-circle-line me-1"></i>
                                        Completed this month
                                    </div>
                                </div>
                                <div class="avatar avatar-lg bg-primary bg-opacity-10 rounded-circle p-3">
                                    <i class="ri-checkbox-circle-line fs-24 text-primary"></i>
                                </div>
                            </div>
                            <div class="mt-3">
                                <span class="badge bg-primary bg-opacity-10 text-primary">
                                    <i class="ri-trophy-line me-1"></i>
                                    On track
                                </span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Performance Metrics -->
    <div class="col-xxl-7">
        <div class="card custom-card border-0 shadow-sm h-100">
            <div class="card-header bg-transparent border-0 pb-0 d-flex justify-content-between align-items-center">
                <!-- <div class=""> -->
                    <div>
                        <h5 class="card-title mb-1">Performance Dashboard</h5>
                        <p class="text-muted small mb-0">Real-time metrics for <fmt:formatDate value="${now}" pattern="MMMM yyyy" /></p>
                    </div>
                    <div class="dropdown">
                        <button class="btn btn-outline-light btn-sm" type="button" data-bs-toggle="dropdown">
                            <i class="ri-more-2-line"></i>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#"><i class="ri-download-line me-2"></i>Export Report</a></li>
                            <li><a class="dropdown-item" href="#"><i class="ri-settings-3-line me-2"></i>Customize View</a></li>
                        </ul>
                    </div>
                <!-- </div> -->
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <!-- Completion Rate -->
                    <div class="col-lg-4 col-md-6">
                        <div class="card border-1 bg-gradient-primary text-white rounded overflow-hidden h-100">
                            <div class="card-body p-4 position-relative">
                                <!-- <div class="position-absolute end-0 top-0 opacity-10">
                                    <i class="ri-pie-chart-line fs-8"></i>
                                </div> -->
                                <div class="mb-4">
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="avatar avatar-sm bg-white bg-opacity-20 rounded-circle p-2 me-2">
                                            <i class="ri-checkbox-circle-line text-primary fs-24"></i>
                                        </div>
                                        <h6 class="mb-0">Completion Rate</h6>
                                    </div>
                                    <div class="small opacity-75">Year <fmt:formatDate value="${now}" pattern="YYYY" /></div>
                                </div>
                                <div class="d-flex align-items-end justify-content-between">
                                    <div>
                                        <h2 class="mb-0">${completion_rate}</h2>
                                        <div class="small mt-2">
                                            <c:choose>
                                                <c:when test="${completionRate >= 90}">
                                                    <span class="badge bg-primary text-white">Excellent</span>
                                                </c:when>
                                                <c:when test="${completionRate >= 70}">
                                                    <span class="badge bg-warning text-white">Good</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger text-white">Needs Improvement</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <div class="small opacity-75 mb-1">Target: 85%</div>
                                        <div class="progress" style="width: 80px; height: 6px;">
                                            <div class="progress-bar bg-white" style="width: ${completionRate > 100 ? 100 : completionRate}%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Turn-around Time -->
                    <div class="col-lg-4 col-md-6">
                        <div class="card bg-gradient-info text-white border-0 overflow-hidden h-100">
                            <div class="card-body p-4 position-relative">
                                <!-- <div class="position-absolute end-0 top-0 opacity-10">
                                    <i class="ri-timer-line fs-8"></i>
                                </div> -->
                                <div class="mb-4">
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="avatar avatar-sm bg-white bg-opacity-20 rounded-circle p-2 me-2">
                                            <i class="ri-time-line text-info fs-20"></i>
                                        </div>
                                        <h6 class="mb-0">Turn-around Time</h6>
                                    </div>
                                    <div class="small opacity-75">Year <fmt:formatDate value="${now}" pattern="YYYY" /></div>
                                </div>
                                <div class="d-flex align-items-end justify-content-between">
                                    <div>
                                        <h2 class="mb-0">-</h2>
                                        <div class="small mt-2">
                                            <span class="opacity-75">Calculating...</span>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <div class="small opacity-75 mb-1">Target: 5 days</div>
                                        <div class="progress" style="width: 80px; height: 6px;">
                                            <div class="progress-bar bg-white" style="width: 60%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Working Days -->
                    <div class="col-lg-4 col-md-6">
                        <div class="card bg-gradient-success text-white border-0 overflow-hidden h-100">
                            <div class="card-body p-4 position-relative">
                                <!-- <div class="position-absolute end-0 top-0 opacity-10">
                                    <i class="ri-calendar-line fs-8"></i>
                                </div> -->
                                <div class="mb-4">
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="avatar avatar-sm bg-white bg-opacity-20 rounded-circle p-2 me-2">
                                            <i class="ri-calendar-2-line text-success fs-24"></i>
                                        </div>
                                        <h6 class="mb-0">Working Days</h6>
                                    </div>
                                    <div class="small opacity-75">Year <fmt:formatDate value="${now}" pattern="YYYY" /></div>
                                </div>
                                <div class="d-flex align-items-end justify-content-between">
                                    <div>
                                        <h2 class="mb-0">-</h2>
                                        <div class="small mt-2">
                                            <span class="badge bg-white text-success">Regular</span>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <div class="small opacity-75 mb-1">Target: 260 days</div>
                                        <div class="progress" style="width: 80px; height: 6px;">
                                            <div class="progress-bar bg-white" style="width: 75%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Performance Insights -->
                    <div class="col-12 mt-3">
                        <div class="card bg-light border-0">
                            <div class="card-body p-4">
                                <div class="d-flex align-items-start">
                                    <div class="avatar avatar-lg bg-primary bg-opacity-10 rounded-circle p-3 me-3">
                                        <i class="ri-lightbulb-line fs-24 text-primary"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-2">Performance Insights</h6>
                                        <p class="text-muted small mb-3">Based on your <strong>${completion_rate}</strong> completion rate:</p>
                                        <div class="row g-2">
                                            <c:choose>
                                                <c:when test="${completionRate >= 90}">
                                                    <div class="col-md-6">
                                                        <div class="d-flex align-items-start mb-2">
                                                            <i class="ri-check-line text-success me-2 mt-1"></i>
                                                            <div class="small">Continue leveraging efficient workflow patterns</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="d-flex align-items-start mb-2">
                                                            <i class="ri-team-line text-success me-2 mt-1"></i>
                                                            <div class="small">Consider mentoring team members to share best practices</div>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:when test="${completionRate >= 70}">
                                                    <div class="col-md-6">
                                                        <div class="d-flex align-items-start mb-2">
                                                            <i class="ri-sort-asc text-warning me-2 mt-1"></i>
                                                            <div class="small">Review task prioritization for critical assignments</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="d-flex align-items-start mb-2">
                                                            <i class="ri-time-line text-warning me-2 mt-1"></i>
                                                            <div class="small">Allocate specific time blocks for complex cases</div>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="col-md-6">
                                                        <div class="d-flex align-items-start mb-2">
                                                            <i class="ri-focus-3-line text-danger me-2 mt-1"></i>
                                                            <div class="small">Focus on completing 2-3 priority tasks daily</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="d-flex align-items-start mb-2">
                                                            <i class="ri-automation-line text-danger me-2 mt-1"></i>
                                                            <div class="small">Utilize workflow automation for routine processes</div>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
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
        <!-- End:: row-1 -->

    </div>
</div>