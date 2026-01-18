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
   /* ============================
   ENHANCED KPI COLOR THEMES
   ============================ */

/* 🔴 RED – Risk / Overdue */
.bg-gradient-danger {
    background: linear-gradient(
        135deg,
        #dc2626 0%,
        #ef4444 45%,
        #f97316 100%
    );
}

/* 🔵 BLUE – Information / Activity */
.bg-gradient-info {
    background: linear-gradient(
        135deg,
        #2563eb 0%,
        #3b82f6 50%,
        #60a5fa 100%
    );
}

/* 🟢 GREEN – Success / Completion */
.bg-gradient-success {
    background: linear-gradient(
        135deg,
        #059669 0%,
        #10b981 50%,
        #34d399 100%
    );
}

/* 🟡 YELLOW – Warning / In-progress */
.bg-gradient-warning {
    background: linear-gradient(
        135deg,
        #d97706 0%,
        #f59e0b 50%,
        #fde68a 100%
    );
}

/* ============================
   STAT CARD ENHANCEMENTS
   ============================ */

.stat-card {
    border-radius: 14px;
    box-shadow: 0 8px 22px rgba(0,0,0,0.12);
}

.stat-card::before {
    height: 5px;
    background: rgba(255, 255, 255, 0.55);
}

/* Icon polish */
.stat-icon {
    backdrop-filter: blur(6px);
    box-shadow: inset 0 0 0 1px rgba(255,255,255,0.25);
}

/* Progress bar enhancement */
.progress {
    background: rgba(255,255,255,0.25);
}

.progress-bar {
    background: linear-gradient(
        to right,
        rgba(255,255,255,0.85),
        rgba(255,255,255,1)
    );
}

/* KPI numbers pop */
.display-4 {
    letter-spacing: -1px;
    text-shadow: 0 3px 12px rgba(0,0,0,0.25);
}

/* Badges refinement */
.badge-success {
    background-color: #16a34a;
}
.badge-warning {
    background-color: #f59e0b;
    color: #1f2937;
}
.badge-danger {
    background-color: #dc2626;
}
.badge-light {
    background-color: rgba(255,255,255,0.85);
    color: #1f2937;
}
.overdue-card {
    background: linear-gradient(
        135deg,
        #b91c1c 0%,
        #dc2626 50%,
        #ef4444 100%
    ) !important;
    color: #ffffff !important;
}

.overdue-card * {
    color: #ffffff !important;
}
/* CURRENT APPLICATIONS — GREEN */
.current-card {
    background: linear-gradient(135deg, #15803d, #22c55e);
    color: #ffffff !important;
}
.current-card * {
    color: #ffffff !important;
}

/* APPLICATIONS RECEIVED — YELLOW */
.received-card {
    background: linear-gradient(135deg, #ca8a04, #facc15);
    color: #ffffff !important;
}
.received-card * {
    color: #ffffff !important;
}

/* COMPLETED APPLICATIONS — BLUE */
.completed-card {
    background: linear-gradient(135deg, #1d4ed8, #3b82f6);
    color: #ffffff !important;
}
.completed-card * {
    color: #ffffff !important;
}

/* OVERDUE — RED */
.overdue-card {
    background: linear-gradient(135deg, #b91c1c, #ef4444);
    color: #ffffff !important;
}
.overdue-card * {
    color: #ffffff !important;
}
</style>

<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="d-flex align-items-center justify-content-between mb-3 page-header-breadcrumb flex-wrap gap-2">
            <div> <h1 class="page-title fw-medium fs-20 mb-0">Dashboard</h1> </div>
            <div class="d-flex align-items-center gap-2 flex-wrap">
                <div class="form-group">
                    <input type="text" class="form-control breadcrumb-input flatpickr-input" id="daterange" placeholder="Search By Date Range" readonly="readonly">
                </div>
                <div class="btn-list">
                    <button class="btn btn-icon btn-primary btn-wave waves-effect waves-light"> <i class="ri-refresh-line"></i> </button>
                    <button class="btn btn-icon btn-primary btn-wave me-0 waves-effect waves-light"> <i class="ri-filter-3-line"></i> </button>
                </div>
            </div>
        </div>
        <!-- End::page-header -->

        <!-- Start:: row-1 -->
        <div class="row">
            <div class="col-xxl-5">
                <div class="row">
                    <div class="col-xl-6">
                       <div class="stat-card current-card rounded-lg p-4 h-100 shadow-sm">
                            <a href="${pageContext.request.contextPath}/case_movement_module">
                                <div class="card-body">
                                    <div
                                        class="d-flex align-items-start justify-content-between mb-2">
                                        <div class="flex-fill">
                                            <div class="mb-2">Current Applications
                                            </div>
                                            <h4 class="fw-semibold text-info mb-0">
                                                ${apps_with_user}</h4>
                                        </div>
                                        <div>
                                            <span
                                                class="avatar avatar-md bg-info-transparent svg-info">
                                                <i
                                                    class="ri-file-list-3-line fs-20"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div
                                        class="d-flex fs-13 align-items-center justify-content-between">
                                        <div class="text-muted">As at today (
                                            <fmt:formatDate value="${now}"
                                                type="date" />)
                                        </div>
                                        <!-- <div class="text-success fw-medium d-inline-flex"><i class="ti ti-trending-up align-middle me-1"></i>3.24%</div> -->
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-xl-6">
                    <div class="stat-card overdue-card rounded-lg p-4 h-100 shadow-sm">
                            <a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#appsPassedDueModal">
                                <div class="card-body">
                                    <div
                                        class="d-flex align-items-start justify-content-between mb-2">
                                        <div class="flex-fill">
                                            <div class="mb-2">Overdue Applications
                                            </div>
                                            <h4
                                                class="fw-semibold text-danger mb-0">
                                                ${apps_past_due_dates}</h4>
                                        </div>
                                        <div>
                                            <span
                                                class="avatar avatar-md bg-danger-transparent svg-danger">
                                                <i class="ri-alert-line fs-20"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div
                                        class="d-flex fs-13 align-items-center justify-content-between">
                                        <div class="text-muted">As at today (
                                            <fmt:formatDate value="${now}"
                                                type="date" />)
                                        </div>
                                        <!-- <div class="text-success fw-medium d-inline-flex"><i class="ti ti-trending-up align-middle me-1"></i>15.69%</div> -->
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-xl-6">
                       <div class="stat-card received-card rounded-lg p-4 h-100 shadow-sm">
                            <a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#appsReceivedMonthModal">
                                <div class="card-body">
                                    <div
                                        class="d-flex align-items-start justify-content-between mb-2">
                                        <div class="flex-fill">
                                            <div class="mb-2">Applications Received
                                            </div>
                                            <h4
                                                class="fw-semibold text-warning mb-0">
                                                ${apps_rec_month}</h4>
                                        </div>
                                        <div>
                                            <span
                                                class="avatar avatar-md bg-warning-transparent svg-warning">
                                                <i
                                                    class="ri-download-2-line fs-20"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div
                                        class="d-flex fs-13 align-items-center justify-content-between">
                                        <div class="text-muted">This Month (
                                            <fmt:formatDate value="${now}"
                                                pattern="MMMM" />)
                                        </div>
                                        <!-- <div class="text-danger fw-medium d-inline-flex"><i class="ti ti-trending-down align-middle me-1"></i>1.07%</div> -->
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-xl-6">
                       <div class="stat-card completed-card rounded-lg p-4 h-100 shadow-sm">
                            <a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#appsCompletedMonthModal">
                                <div class="card-body">
                                    <div
                                        class="d-flex align-items-start justify-content-between mb-2">
                                        <div class="flex-fill">
                                            <div class="mb-2">Completed Applications
                                            </div>
                                            <h4
                                                class="fw-semibold text-primary mb-0">
                                                ${apps_comp_month}</h4>
                                        </div>
                                        <div>
                                            <span
                                                class="avatar avatar-md bg-primary-transparent svg-primary">
                                                <i
                                                    class="ri-checkbox-circle-line fs-20"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div
                                        class="d-flex fs-13 align-items-center justify-content-between">
                                        <div class="text-muted">This month (
                                            <fmt:formatDate value="${now}"
                                                pattern="MMMM" />)
                                        </div>
                                        <!-- <div class="fw-medium">250</div> -->
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>

                </div>

                  </div>
            <div class="col-xxl-7">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card custom-card">
                            <div class="card-header justify-content-between">
                                <div class="card-title">
                                    Performance
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <!-- Completion Rate Card -->
                                    <div class="col-lg-4 col-md-6 mb-4">
                                       <div class="stat-card bg-gradient-warning text-white rounded-lg p-4 h-100 shadow-sm">
                                            <div
                                                class="d-flex justify-content-between align-items-start mb-3">
                                                <div>
                                                    <div class="text-uppercase font-weight-bold mb-1"
                                                        style="font-size: 0.8rem; opacity: 0.9;">
                                                        Completion Rate
                                                    </div>
                                                    <div class="text-white small"
                                                        style="opacity: 0.7;">
                                                        Year
                                                        <fmt:formatDate
                                                            value="${now}"
                                                            pattern="YYYY" />
                                                    </div>
                                                </div>
                                                <div
                                                    class="stat-icon bg-white-20 rounded-circle p-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                        width="20" height="20"
                                                        viewBox="0 0 24 24"
                                                        fill="none"
                                                        stroke="currentColor"
                                                        stroke-width="2"
                                                        stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <path
                                                            d="M22 11.08V12a10 10 0 1 1-5.93-9.14">
                                                        </path>
                                                        <polyline
                                                            points="22 4 12 14.01 9 11.01">
                                                        </polyline>
                                                    </svg>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-end">
                                                <fmt:parseNumber
                                                    value="${completion_rate}"
                                                    integerOnly="true"
                                                    var="completionRate" />
                                                <div
                                                    class="display-4 font-weight-bold">
                                                    ${completionRate}</div>
                                                <div class="ml-2 mb-2"
                                                    style="font-size: 1rem;">
                                                    <c:choose>
                                                        <c:when
                                                            test="${completionRate >= 90}">
                                                            <span
                                                                class="badge badge-success">Excellent</span>
                                                        </c:when>
                                                        <c:when
                                                            test="${completionRate >= 70}">
                                                            <span
                                                                class="badge badge-warning">Good</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="badge badge-danger">Needs
                                                                Improvement</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="progress mt-3"
                                                style="height: 6px; background: rgba(255,255,255,0.2);">
                                                <div class="progress-bar bg-white"
                                                    style="--progress-width: ${completionRate}%">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Turn-around Time Card -->
                                    <div class="col-lg-4 col-md-6 mb-4">
                                        <div
                                            class="stat-card bg-gradient-danger text-white rounded-lg p-4 h-100 shadow-sm">
                                            <div
                                                class="d-flex justify-content-between align-items-start mb-3">
                                                <div>
                                                    <div class="text-uppercase font-weight-bold mb-1"
                                                        style="font-size: 0.8rem; opacity: 0.9;">
                                                        Turn-around Time
                                                    </div>
                                                    <div class="text-white small"
                                                        style="opacity: 0.7;">
                                                        Year
                                                        <fmt:formatDate
                                                            value="${now}"
                                                            pattern="YYYY" />
                                                    </div>
                                                </div>
                                                <div
                                                    class="stat-icon bg-white-20 rounded-circle p-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                        width="20" height="20"
                                                        viewBox="0 0 24 24"
                                                        fill="none"
                                                        stroke="currentColor"
                                                        stroke-width="2"
                                                        stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <circle cx="12" cy="12"
                                                            r="10"></circle>
                                                        <polyline
                                                            points="12 6 12 12 16 14">
                                                        </polyline>
                                                    </svg>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-end">
                                                <div
                                                    class="display-4 font-weight-bold">
                                                    -</div>
                                                <div class="ml-2 mb-2"
                                                    style="font-size: 1rem;">
                                                    <span
                                                        class="text-white">Calculating...</span>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                                <div
                                                    class="small text-white-50">
                                                    Avg. target: 5 days</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Working Days Card -->
                                    <div class="col-lg-4 col-md-6 mb-4">
                                        <div
                                            class="stat-card bg-gradient-info text-white rounded-lg p-4 h-100 shadow-sm">
                                            <div
                                                class="d-flex justify-content-between align-items-start mb-3">
                                                <div>
                                                    <div class="text-uppercase font-weight-bold mb-1"
                                                        style="font-size: 0.8rem; opacity: 0.9;">
                                                        Working Days
                                                    </div>
                                                    <div class="text-white-50 small"
                                                        style="opacity: 0.7;">
                                                        Year
                                                        <fmt:formatDate
                                                            value="${now}"
                                                            pattern="YYYY" />
                                                    </div>
                                                </div>
                                                <div
                                                    class="stat-icon bg-white-20 rounded-circle p-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                        width="20" height="20"
                                                        viewBox="0 0 24 24"
                                                        fill="none"
                                                        stroke="currentColor"
                                                        stroke-width="2"
                                                        stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <rect x="3" y="4"
                                                            width="18"
                                                            height="18" rx="2"
                                                            ry="2"></rect>
                                                        <line x1="16" y1="2"
                                                            x2="16" y2="6">
                                                        </line>
                                                        <line x1="8" y1="2"
                                                            x2="8" y2="6">
                                                        </line>
                                                        <line x1="3" y1="10"
                                                            x2="21" y2="10">
                                                        </line>
                                                    </svg>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-end">
                                                <div
                                                    class="display-4 font-weight-bold">
                                                    -</div>
                                                <div class="ml-2 mb-2"
                                                    style="font-size: 1rem;">
                                                    <span
                                                        class="badge badge-light">Regular</span>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                                <div
                                                    class="small text-white-50">
                                                    Target: 260 days</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-12 col-md-12">
                                        <div
                                            class="alert alert-dark border mb-3 p-2">
                                            <div
                                                class="d-flex align-items-start">
                                                <div class="me-3 svg-dark">
                                                    <svg class="flex-shrink-0"
                                                        xmlns="http://www.w3.org/2000/svg"
                                                        height="1.5rem"
                                                        viewBox="0 0 24 24"
                                                        width="1.5rem"
                                                        fill="#000000">
                                                        <path
                                                            d="M0 0h24v24H0V0z"
                                                            fill="none"></path>
                                                        <path
                                                            d="M11 7h2v2h-2zm0 4h2v6h-2zm1-9C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z">
                                                        </path>
                                                    </svg>
                                                </div>
                                                <div class="text-dark w-100">
                                                    <div
                                                        class="fw-semibold d-flex justify-content-between mb-1">
                                                        Performance
                                                        Recommendations
                                                    </div>
                                                    <div
                                                        class="fs-13 opacity-75">
                                                        Based on your
                                                        <strong>${completion_rate}</strong>
                                                        completion rate:
                                                        <ul
                                                            class="mb-0 mt-1 ps-3">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${completionRate >= 90}">
                                                                    <li>Continue
                                                                        leveraging
                                                                        your
                                                                        efficient
                                                                        workflow
                                                                        patterns
                                                                    </li>
                                                                    <li>Consider
                                                                        mentoring
                                                                        team
                                                                        members
                                                                        to share
                                                                        best
                                                                        practices
                                                                    </li>
                                                                </c:when>
                                                                <c:when
                                                                    test="${completionRate >= 75}">
                                                                    <li>Review
                                                                        task
                                                                        prioritization
                                                                        for
                                                                        critical
                                                                        assignments
                                                                    </li>
                                                                    <li>Allocate
                                                                        specific
                                                                        time
                                                                        blocks
                                                                        for
                                                                        complex
                                                                        cases
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li>Focus on
                                                                        completing
                                                                        2-3
                                                                        priority
                                                                        tasks
                                                                        daily
                                                                    </li>
                                                                    <li>Utilize
                                                                        workflow
                                                                        automation
                                                                        tools
                                                                        for
                                                                        routine
                                                                        processes
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </ul>
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
        </div>
        <!-- End:: row-1 -->

    </div>
</div>