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
                        <div class="card custom-card dashboard-main-card medical-main-card info">
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
                        <div class="card custom-card dashboard-main-card medical-main-card danger">
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
                        <div class="card custom-card dashboard-main-card medical-main-card warning">
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
                        <div class="card custom-card dashboard-main-card medical-main-card primary">
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

                <!-- <div class="card custom-card"> <div class="card-header justify-content-between"> <div class="card-title"> Sales Overview </div> <div class="btn-group btn-group-sm" role="group" aria-label="Basic example"> <button type="button" class="btn btn-primary btn-wave waves-effect waves-light">Day</button> <button type="button" class="btn btn-primary-light btn-wave waves-effect waves-light">Week</button> <button type="button" class="btn btn-primary-light btn-wave waves-effect waves-light">Month</button> <button type="button" class="btn btn-primary-light btn-wave waves-effect waves-light">Year</button> </div> </div> <div class="card-body pb-0 pt-5"> <div id="sales-overview" style="min-height: 380px;" class=""><div id="apexchartskt3nblepk" class="apexcharts-canvas apexchartskt3nblepk apexcharts-theme-light" style="width: 628px; height: 365px;"><svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" class="apexcharts-svg apexcharts-zoomable hovering-zoom" xmlns:data="ApexChartsNS" transform="translate(0, 0)" width="628" height="365"><foreignObject x="0" y="0" width="628" height="365"><style type="text/css">
      .apexcharts-flip-y {
        transform: scaleY(-1) translateY(-100%);
        transform-origin: top;
        transform-box: fill-box;
      }
      .apexcharts-flip-x {
        transform: scaleX(-1);
        transform-origin: center;
        transform-box: fill-box;
      }
      .apexcharts-legend {
        display: flex;
        overflow: auto;
        padding: 0 10px;
      }
      .apexcharts-legend.apexcharts-legend-group-horizontal {
        flex-direction: column;
      }
      .apexcharts-legend-group {
        display: flex;
      }
      .apexcharts-legend-group-vertical {
        flex-direction: column-reverse;
      }
      .apexcharts-legend.apx-legend-position-bottom, .apexcharts-legend.apx-legend-position-top {
        flex-wrap: wrap
      }
      .apexcharts-legend.apx-legend-position-right, .apexcharts-legend.apx-legend-position-left {
        flex-direction: column;
        bottom: 0;
      }
      .apexcharts-legend.apx-legend-position-bottom.apexcharts-align-left, .apexcharts-legend.apx-legend-position-top.apexcharts-align-left, .apexcharts-legend.apx-legend-position-right, .apexcharts-legend.apx-legend-position-left {
        justify-content: flex-start;
        align-items: flex-start;
      }
      .apexcharts-legend.apx-legend-position-bottom.apexcharts-align-center, .apexcharts-legend.apx-legend-position-top.apexcharts-align-center {
        justify-content: center;
        align-items: center;
      }
      .apexcharts-legend.apx-legend-position-bottom.apexcharts-align-right, .apexcharts-legend.apx-legend-position-top.apexcharts-align-right {
        justify-content: flex-end;
        align-items: flex-end;
      }
      .apexcharts-legend-series {
        cursor: pointer;
        line-height: normal;
        display: flex;
        align-items: center;
      }
      .apexcharts-legend-text {
        position: relative;
        font-size: 14px;
      }
      .apexcharts-legend-text *, .apexcharts-legend-marker * {
        pointer-events: none;
      }
      .apexcharts-legend-marker {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        margin-right: 1px;
      }

      .apexcharts-legend-series.apexcharts-no-click {
        cursor: auto;
      }
      .apexcharts-legend .apexcharts-hidden-zero-series, .apexcharts-legend .apexcharts-hidden-null-series {
        display: none !important;
      }
      .apexcharts-inactive-legend {
        opacity: 0.45;
      }

    </style></foreignObject><rect width="0" height="0" x="0" y="0" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fefefe"></rect><g class="apexcharts-datalabels-group" transform="translate(0, 0) scale(1)"></g><g class="apexcharts-datalabels-group" transform="translate(0, 0) scale(1)"></g><g class="apexcharts-yaxis" rel="0" transform="translate(-8, 0)"><g class="apexcharts-yaxis-texts-g"></g><line x1="25" y1="56" x2="31" y2="56" stroke="rgba(119, 119, 142, 0.05)" stroke-dasharray="0" stroke-linecap="butt"></line><line x1="25" y1="100.89133333333334" x2="31" y2="100.89133333333334" stroke="rgba(119, 119, 142, 0.05)" stroke-dasharray="0" stroke-linecap="butt"></line><line x1="25" y1="145.78266666666667" x2="31" y2="145.78266666666667" stroke="rgba(119, 119, 142, 0.05)" stroke-dasharray="0" stroke-linecap="butt"></line><line x1="25" y1="190.674" x2="31" y2="190.674" stroke="rgba(119, 119, 142, 0.05)" stroke-dasharray="0" stroke-linecap="butt"></line><line x1="25" y1="235.56533333333334" x2="31" y2="235.56533333333334" stroke="rgba(119, 119, 142, 0.05)" stroke-dasharray="0" stroke-linecap="butt"></line><line x1="25" y1="280.4566666666667" x2="31" y2="280.4566666666667" stroke="rgba(119, 119, 142, 0.05)" stroke-dasharray="0" stroke-linecap="butt"></line><line x1="25" y1="325.34800000000007" x2="31" y2="325.34800000000007" stroke="rgba(119, 119, 142, 0.05)" stroke-dasharray="0" stroke-linecap="butt"></line></g><g class="apexcharts-inner apexcharts-graphical" transform="translate(50.329971590909096, 56)"><defs><clipPath id="gridRectMaskkt3nblepk"><rect width="534.6681818181818" height="278.348" x="-4.5" y="-4.5" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fff"></rect></clipPath><clipPath id="gridRectBarMaskkt3nblepk"><rect width="611.3281249999999" height="278.348" x="-42.829971590909096" y="-4.5" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fff"></rect></clipPath><clipPath id="gridRectMarkerMaskkt3nblepk"><rect width="525.6681818181818" height="269.348" x="0" y="0" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fff"></rect></clipPath><clipPath id="forecastMaskkt3nblepk"></clipPath><clipPath id="nonForecastMaskkt3nblepk"></clipPath><filter id="SvgjsFilter1013" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1012" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1015" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1014" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1017" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1016" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1019" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1018" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1021" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1020" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1023" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1022" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1025" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1024" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1027" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1026" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1029" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1028" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1031" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1030" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1033" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1032" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1035" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1034" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1037" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1036" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1039" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1038" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1041" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1040" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1043" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1042" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1045" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1044" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1047" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1046" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1049" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1048" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1051" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1050" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1053" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1052" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1055" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1054" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1057" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1056" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1059" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1058" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1061" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1060" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1063" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1062" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1065" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1064" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1067" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1066" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1069" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1068" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1071" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1070" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1073" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1072" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1075" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1074" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1077" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1076" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1079" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1078" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1081" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1080" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1083" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1082" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1085" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1084" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1087" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1086" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1089" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1088" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1091" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1090" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1093" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1092" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1095" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1094" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1097" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1096" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1099" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1098" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1101" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1100" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1103" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1102" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1105" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1104" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1107" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1106" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1109" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1108" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1111" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1110" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1113" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1112" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1115" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1114" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1117" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1116" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1119" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1118" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1121" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1120" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1123" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1122" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1125" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1124" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1127" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1126" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1129" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1128" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1131" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1130" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1133" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1132" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1135" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1134" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1137" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1136" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1139" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1138" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1141" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1140" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1143" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1142" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1145" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1144" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1147" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1146" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1149" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1148" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1151" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1150" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1153" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1152" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1155" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1154" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1157" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1156" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1159" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1158" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1161" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1160" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1163" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1162" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1165" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1164" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter><filter id="SvgjsFilter1167" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feColorMatrix id="SvgjsFeColorMatrix1166" result="brightness" in="SourceGraphic" type="matrix" values="
          2 0 0 0 0
          0 2 0 0 0
          0 0 2 0 0
          0 0 0 1 0
        "></feColorMatrix></filter></defs><line x1="238.4400826446281" y1="0" x2="238.4400826446281" y2="269.348" stroke="#b6b6b6" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-xcrosshairs" x="238.4400826446281" y="0" width="1" height="269.348" fill="#b1b9c4" filter="none" fill-opacity="0.9" stroke-width="1"></line><line x1="0" y1="269.348" x2="0" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="47.78801652892562" y1="269.348" x2="47.78801652892562" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="95.57603305785123" y1="269.348" x2="95.57603305785123" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="143.36404958677684" y1="269.348" x2="143.36404958677684" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="191.15206611570247" y1="269.348" x2="191.15206611570247" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="238.9400826446281" y1="269.348" x2="238.9400826446281" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="286.7280991735537" y1="269.348" x2="286.7280991735537" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="334.5161157024793" y1="269.348" x2="334.5161157024793" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="382.3041322314049" y1="269.348" x2="382.3041322314049" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="430.0921487603305" y1="269.348" x2="430.0921487603305" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="477.88016528925607" y1="269.348" x2="477.88016528925607" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><line x1="525.6681818181817" y1="269.348" x2="525.6681818181817" y2="275.348" stroke="#e0e0e0" stroke-dasharray="0" stroke-linecap="butt" class="apexcharts-xaxis-tick"></line><g class="apexcharts-grid"><g class="apexcharts-gridlines-horizontal"></g><g class="apexcharts-gridlines-vertical"><line x1="0" y1="0" x2="0" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="47.78801652892562" y1="0" x2="47.78801652892562" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="95.57603305785123" y1="0" x2="95.57603305785123" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="143.36404958677684" y1="0" x2="143.36404958677684" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="191.15206611570247" y1="0" x2="191.15206611570247" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="238.9400826446281" y1="0" x2="238.9400826446281" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="286.7280991735537" y1="0" x2="286.7280991735537" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="334.5161157024793" y1="0" x2="334.5161157024793" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="382.3041322314049" y1="0" x2="382.3041322314049" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="430.0921487603305" y1="0" x2="430.0921487603305" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="477.88016528925607" y1="0" x2="477.88016528925607" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line><line x1="525.6681818181817" y1="0" x2="525.6681818181817" y2="269.348" stroke="#f1f1f1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line></g><line x1="0" y1="269.348" x2="525.6681818181818" y2="269.348" stroke="transparent" stroke-dasharray="0" stroke-linecap="butt"></line><line x1="0" y1="1" x2="0" y2="269.348" stroke="transparent" stroke-dasharray="0" stroke-linecap="butt"></line></g><g class="apexcharts-grid-borders"><line x1="-38.329971590909096" y1="269.348" x2="563.9981534090908" y2="269.348" stroke="rgba(119, 119, 142, 0.05)" stroke-dasharray="0" stroke-width="1" stroke-linecap="butt"></line></g><g class="apexcharts-bar-series apexcharts-plot-series"><g class="apexcharts-series" rel="1" seriesName="TotalxOrders" data:realIndex="0"><path d="M -14.225805785123967 264.849 L -14.225805785123967 107.75106666666667 C -14.225805785123967 106.75106666666667 -13.225805785123967 105.75106666666667 -12.225805785123967 105.75106666666667 L -4.5 105.75106666666667 C -3.5 105.75106666666667 -2.5 106.75106666666667 -2.5 107.75106666666667 L -2.5 264.849 C -2.5 265.849 -3.5 266.849 -4.5 266.849 L -12.225805785123967 266.849 C -13.225805785123967 266.849 -14.225805785123967 265.849 -14.225805785123967 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M -14.225805785123967 264.849 L -14.225805785123967 107.75106666666667 C -14.225805785123967 106.75106666666667 -13.225805785123967 105.75106666666667 -12.225805785123967 105.75106666666667 L -4.5 105.75106666666667 C -3.5 105.75106666666667 -2.5 106.75106666666667 -2.5 107.75106666666667 L -2.5 264.849 C -2.5 265.849 -3.5 266.849 -4.5 266.849 L -12.225805785123967 266.849 C -13.225805785123967 266.849 -14.225805785123967 265.849 -14.225805785123967 264.849 Z " pathFrom="M -14.059194214876033 264.849 L -14.059194214876033 107.75106666666667 C -14.059194214876033 106.75106666666667 -13.059194214876033 105.75106666666667 -12.059194214876033 105.75106666666667 L -4.5 105.75106666666667 C -3.5 105.75106666666667 -2.5 106.75106666666667 -2.5 107.75106666666667 L -2.5 264.849 C -2.5 265.849 -3.5 266.849 -4.5 266.849 L -12.059194214876033 266.849 C -13.059194214876033 266.849 -14.059194214876033 265.849 -14.059194214876033 264.849 Z  L -14.225805785123967 266.849 L -2.5 266.849 L -2.5 266.849 L -2.5 266.849 L -2.5 266.849 L -2.5 266.849 L -14.225805785123967 266.849 Z" cy="103.25006666666667" cx="-2.5" j="0" val="74" barHeight="166.09793333333334" barWidth="16.725805785123967"></path><path d="M 33.56221074380165 264.849 L 33.56221074380165 83.06083333333333 C 33.56221074380165 82.06083333333333 34.56221074380165 81.06083333333333 35.56221074380165 81.06083333333333 L 43.28801652892562 81.06083333333333 C 44.28801652892562 81.06083333333333 45.28801652892562 82.06083333333333 45.28801652892562 83.06083333333333 L 45.28801652892562 264.849 C 45.28801652892562 265.849 44.28801652892562 266.849 43.28801652892562 266.849 L 35.56221074380165 266.849 C 34.56221074380165 266.849 33.56221074380165 265.849 33.56221074380165 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 33.56221074380165 264.849 L 33.56221074380165 83.06083333333333 C 33.56221074380165 82.06083333333333 34.56221074380165 81.06083333333333 35.56221074380165 81.06083333333333 L 43.28801652892562 81.06083333333333 C 44.28801652892562 81.06083333333333 45.28801652892562 82.06083333333333 45.28801652892562 83.06083333333333 L 45.28801652892562 264.849 C 45.28801652892562 265.849 44.28801652892562 266.849 43.28801652892562 266.849 L 35.56221074380165 266.849 C 34.56221074380165 266.849 33.56221074380165 265.849 33.56221074380165 264.849 Z " pathFrom="M 33.252789256198355 264.849 L 33.252789256198355 83.06083333333333 C 33.252789256198355 82.06083333333333 34.252789256198355 81.06083333333333 35.252789256198355 81.06083333333333 L 42.811983471074385 81.06083333333333 C 43.811983471074385 81.06083333333333 44.811983471074385 82.06083333333333 44.811983471074385 83.06083333333333 L 44.811983471074385 264.849 C 44.811983471074385 265.849 43.811983471074385 266.849 42.811983471074385 266.849 L 35.252789256198355 266.849 C 34.252789256198355 266.849 33.252789256198355 265.849 33.252789256198355 264.849 Z  L 33.56221074380165 266.849 L 45.28801652892562 266.849 L 45.28801652892562 266.849 L 45.28801652892562 266.849 L 45.28801652892562 266.849 L 45.28801652892562 266.849 L 33.56221074380165 266.849 Z" cy="78.55983333333333" cx="45.28801652892562" j="1" val="85" barHeight="190.78816666666668" barWidth="16.725805785123967"></path><path d="M 81.35022727272727 264.849 L 81.35022727272727 145.9087 C 81.35022727272727 144.9087 82.35022727272727 143.9087 83.35022727272727 143.9087 L 91.07603305785123 143.9087 C 92.07603305785123 143.9087 93.07603305785123 144.9087 93.07603305785123 145.9087 L 93.07603305785123 264.849 C 93.07603305785123 265.849 92.07603305785123 266.849 91.07603305785123 266.849 L 83.35022727272727 266.849 C 82.35022727272727 266.849 81.35022727272727 265.849 81.35022727272727 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 81.35022727272727 264.849 L 81.35022727272727 145.9087 C 81.35022727272727 144.9087 82.35022727272727 143.9087 83.35022727272727 143.9087 L 91.07603305785123 143.9087 C 92.07603305785123 143.9087 93.07603305785123 144.9087 93.07603305785123 145.9087 L 93.07603305785123 264.849 C 93.07603305785123 265.849 92.07603305785123 266.849 91.07603305785123 266.849 L 83.35022727272727 266.849 C 82.35022727272727 266.849 81.35022727272727 265.849 81.35022727272727 264.849 Z " pathFrom="M 80.56477272727274 264.849 L 80.56477272727274 145.9087 C 80.56477272727274 144.9087 81.56477272727274 143.9087 82.56477272727274 143.9087 L 90.12396694214877 143.9087 C 91.12396694214877 143.9087 92.12396694214877 144.9087 92.12396694214877 145.9087 L 92.12396694214877 264.849 C 92.12396694214877 265.849 91.12396694214877 266.849 90.12396694214877 266.849 L 82.56477272727274 266.849 C 81.56477272727274 266.849 80.56477272727274 265.849 80.56477272727274 264.849 Z  L 81.35022727272727 266.849 L 93.07603305785123 266.849 L 93.07603305785123 266.849 L 93.07603305785123 266.849 L 93.07603305785123 266.849 L 93.07603305785123 266.849 L 81.35022727272727 266.849 Z" cy="141.4077" cx="93.07603305785123" j="2" val="57" barHeight="127.94030000000001" barWidth="16.725805785123967"></path><path d="M 129.1382438016529 264.849 L 129.1382438016529 148.15326666666667 C 129.1382438016529 147.15326666666667 130.1382438016529 146.15326666666667 131.1382438016529 146.15326666666667 L 138.86404958677687 146.15326666666667 C 139.86404958677687 146.15326666666667 140.86404958677687 147.15326666666667 140.86404958677687 148.15326666666667 L 140.86404958677687 264.849 C 140.86404958677687 265.849 139.86404958677687 266.849 138.86404958677687 266.849 L 131.1382438016529 266.849 C 130.1382438016529 266.849 129.1382438016529 265.849 129.1382438016529 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 129.1382438016529 264.849 L 129.1382438016529 148.15326666666667 C 129.1382438016529 147.15326666666667 130.1382438016529 146.15326666666667 131.1382438016529 146.15326666666667 L 138.86404958677687 146.15326666666667 C 139.86404958677687 146.15326666666667 140.86404958677687 147.15326666666667 140.86404958677687 148.15326666666667 L 140.86404958677687 264.849 C 140.86404958677687 265.849 139.86404958677687 266.849 138.86404958677687 266.849 L 131.1382438016529 266.849 C 130.1382438016529 266.849 129.1382438016529 265.849 129.1382438016529 264.849 Z " pathFrom="M 127.87675619834714 264.849 L 127.87675619834714 148.15326666666667 C 127.87675619834714 147.15326666666667 128.87675619834712 146.15326666666667 129.87675619834712 146.15326666666667 L 137.43595041322317 146.15326666666667 C 138.43595041322317 146.15326666666667 139.43595041322317 147.15326666666667 139.43595041322317 148.15326666666667 L 139.43595041322317 264.849 C 139.43595041322317 265.849 138.43595041322317 266.849 137.43595041322317 266.849 L 129.87675619834715 266.849 C 128.87675619834715 266.849 127.87675619834714 265.849 127.87675619834714 264.849 Z  L 129.1382438016529 266.849 L 140.86404958677687 266.849 L 140.86404958677687 266.849 L 140.86404958677687 266.849 L 140.86404958677687 266.849 L 140.86404958677687 266.849 L 129.1382438016529 266.849 Z" cy="143.65226666666666" cx="140.86404958677687" j="3" val="56" barHeight="125.69573333333334" barWidth="16.725805785123967"></path><path d="M 176.9262603305785 264.849 L 176.9262603305785 103.26193333333336 C 176.9262603305785 102.26193333333336 177.9262603305785 101.26193333333336 178.9262603305785 101.26193333333336 L 186.65206611570244 101.26193333333336 C 187.65206611570244 101.26193333333336 188.65206611570244 102.26193333333336 188.65206611570244 103.26193333333336 L 188.65206611570244 264.849 C 188.65206611570244 265.849 187.65206611570244 266.849 186.65206611570244 266.849 L 178.9262603305785 266.849 C 177.9262603305785 266.849 176.9262603305785 265.849 176.9262603305785 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 176.9262603305785 264.849 L 176.9262603305785 103.26193333333336 C 176.9262603305785 102.26193333333336 177.9262603305785 101.26193333333336 178.9262603305785 101.26193333333336 L 186.65206611570244 101.26193333333336 C 187.65206611570244 101.26193333333336 188.65206611570244 102.26193333333336 188.65206611570244 103.26193333333336 L 188.65206611570244 264.849 C 188.65206611570244 265.849 187.65206611570244 266.849 186.65206611570244 266.849 L 178.9262603305785 266.849 C 177.9262603305785 266.849 176.9262603305785 265.849 176.9262603305785 264.849 Z " pathFrom="M 175.1887396694215 264.849 L 175.1887396694215 103.26193333333336 C 175.1887396694215 102.26193333333336 176.1887396694215 101.26193333333336 177.1887396694215 101.26193333333336 L 184.74793388429754 101.26193333333336 C 185.74793388429754 101.26193333333336 186.74793388429754 102.26193333333336 186.74793388429754 103.26193333333336 L 186.74793388429754 264.849 C 186.74793388429754 265.849 185.74793388429754 266.849 184.74793388429754 266.849 L 177.1887396694215 266.849 C 176.1887396694215 266.849 175.1887396694215 265.849 175.1887396694215 264.849 Z  L 176.9262603305785 266.849 L 188.65206611570244 266.849 L 188.65206611570244 266.849 L 188.65206611570244 266.849 L 188.65206611570244 266.849 L 188.65206611570244 266.849 L 176.9262603305785 266.849 Z" cy="98.76093333333336" cx="188.65206611570244" j="4" val="76" barHeight="170.58706666666666" barWidth="16.725805785123967"></path><path d="M 224.71427685950414 264.849 L 224.71427685950414 195.2891666666667 C 224.71427685950414 194.2891666666667 225.71427685950414 193.2891666666667 226.71427685950414 193.2891666666667 L 234.4400826446281 193.2891666666667 C 235.4400826446281 193.2891666666667 236.4400826446281 194.2891666666667 236.4400826446281 195.2891666666667 L 236.4400826446281 264.849 C 236.4400826446281 265.849 235.4400826446281 266.849 234.4400826446281 266.849 L 226.71427685950414 266.849 C 225.71427685950414 266.849 224.71427685950414 265.849 224.71427685950414 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 224.71427685950414 264.849 L 224.71427685950414 195.2891666666667 C 224.71427685950414 194.2891666666667 225.71427685950414 193.2891666666667 226.71427685950414 193.2891666666667 L 234.4400826446281 193.2891666666667 C 235.4400826446281 193.2891666666667 236.4400826446281 194.2891666666667 236.4400826446281 195.2891666666667 L 236.4400826446281 264.849 C 236.4400826446281 265.849 235.4400826446281 266.849 234.4400826446281 266.849 L 226.71427685950414 266.849 C 225.71427685950414 266.849 224.71427685950414 265.849 224.71427685950414 264.849 Z " pathFrom="M 222.5007231404959 264.849 L 222.5007231404959 195.2891666666667 C 222.5007231404959 194.2891666666667 223.5007231404959 193.2891666666667 224.5007231404959 193.2891666666667 L 232.05991735537194 193.2891666666667 C 233.05991735537194 193.2891666666667 234.05991735537194 194.2891666666667 234.05991735537194 195.2891666666667 L 234.05991735537194 264.849 C 234.05991735537194 265.849 233.05991735537194 266.849 232.05991735537194 266.849 L 224.5007231404959 266.849 C 223.5007231404959 266.849 222.5007231404959 265.849 222.5007231404959 264.849 Z  L 224.71427685950414 266.849 L 236.4400826446281 266.849 L 236.4400826446281 266.849 L 236.4400826446281 266.849 L 236.4400826446281 266.849 L 236.4400826446281 266.849 L 224.71427685950414 266.849 Z" cy="190.78816666666668" cx="236.4400826446281" j="5" val="35" barHeight="78.55983333333333" barWidth="16.725805785123967"></path><path d="M 272.5022933884298 264.849 L 272.5022933884298 136.93043333333335 C 272.5022933884298 135.93043333333335 273.5022933884298 134.93043333333335 274.5022933884298 134.93043333333335 L 282.22809917355374 134.93043333333335 C 283.22809917355374 134.93043333333335 284.22809917355374 135.93043333333335 284.22809917355374 136.93043333333335 L 284.22809917355374 264.849 C 284.22809917355374 265.849 283.22809917355374 266.849 282.22809917355374 266.849 L 274.5022933884298 266.849 C 273.5022933884298 266.849 272.5022933884298 265.849 272.5022933884298 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 272.5022933884298 264.849 L 272.5022933884298 136.93043333333335 C 272.5022933884298 135.93043333333335 273.5022933884298 134.93043333333335 274.5022933884298 134.93043333333335 L 282.22809917355374 134.93043333333335 C 283.22809917355374 134.93043333333335 284.22809917355374 135.93043333333335 284.22809917355374 136.93043333333335 L 284.22809917355374 264.849 C 284.22809917355374 265.849 283.22809917355374 266.849 282.22809917355374 266.849 L 274.5022933884298 266.849 C 273.5022933884298 266.849 272.5022933884298 265.849 272.5022933884298 264.849 Z " pathFrom="M 269.8127066115703 264.849 L 269.8127066115703 136.93043333333335 C 269.8127066115703 135.93043333333335 270.8127066115703 134.93043333333335 271.8127066115703 134.93043333333335 L 279.37190082644634 134.93043333333335 C 280.37190082644634 134.93043333333335 281.37190082644634 135.93043333333335 281.37190082644634 136.93043333333335 L 281.37190082644634 264.849 C 281.37190082644634 265.849 280.37190082644634 266.849 279.37190082644634 266.849 L 271.8127066115703 266.849 C 270.8127066115703 266.849 269.8127066115703 265.849 269.8127066115703 264.849 Z  L 272.5022933884298 266.849 L 284.22809917355374 266.849 L 284.22809917355374 266.849 L 284.22809917355374 266.849 L 284.22809917355374 266.849 L 284.22809917355374 266.849 L 272.5022933884298 266.849 Z" cy="132.42943333333335" cx="284.22809917355374" j="6" val="61" barHeight="136.91856666666666" barWidth="16.725805785123967"></path><path d="M 320.2903099173554 264.849 L 320.2903099173554 53.881466666666675 C 320.2903099173554 52.881466666666675 321.2903099173554 51.881466666666675 322.2903099173554 51.881466666666675 L 330.01611570247934 51.881466666666675 C 331.01611570247934 51.881466666666675 332.01611570247934 52.881466666666675 332.01611570247934 53.881466666666675 L 332.01611570247934 264.849 C 332.01611570247934 265.849 331.01611570247934 266.849 330.01611570247934 266.849 L 322.2903099173554 266.849 C 321.2903099173554 266.849 320.2903099173554 265.849 320.2903099173554 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 320.2903099173554 264.849 L 320.2903099173554 53.881466666666675 C 320.2903099173554 52.881466666666675 321.2903099173554 51.881466666666675 322.2903099173554 51.881466666666675 L 330.01611570247934 51.881466666666675 C 331.01611570247934 51.881466666666675 332.01611570247934 52.881466666666675 332.01611570247934 53.881466666666675 L 332.01611570247934 264.849 C 332.01611570247934 265.849 331.01611570247934 266.849 330.01611570247934 266.849 L 322.2903099173554 266.849 C 321.2903099173554 266.849 320.2903099173554 265.849 320.2903099173554 264.849 Z " pathFrom="M 317.1246900826447 264.849 L 317.1246900826447 53.881466666666675 C 317.1246900826447 52.881466666666675 318.1246900826447 51.881466666666675 319.1246900826447 51.881466666666675 L 326.6838842975207 51.881466666666675 C 327.6838842975207 51.881466666666675 328.6838842975207 52.881466666666675 328.6838842975207 53.881466666666675 L 328.6838842975207 264.849 C 328.6838842975207 265.849 327.6838842975207 266.849 326.6838842975207 266.849 L 319.1246900826447 266.849 C 318.1246900826447 266.849 317.1246900826447 265.849 317.1246900826447 264.849 Z  L 320.2903099173554 266.849 L 332.01611570247934 266.849 L 332.01611570247934 266.849 L 332.01611570247934 266.849 L 332.01611570247934 266.849 L 332.01611570247934 266.849 L 320.2903099173554 266.849 Z" cy="49.38046666666668" cx="332.01611570247934" j="7" val="98" barHeight="219.96753333333334" barWidth="16.725805785123967"></path><path d="M 368.078326446281 264.849 L 368.078326446281 193.04460000000003 C 368.078326446281 192.04460000000003 369.078326446281 191.04460000000003 370.078326446281 191.04460000000003 L 377.80413223140494 191.04460000000003 C 378.80413223140494 191.04460000000003 379.80413223140494 192.04460000000003 379.80413223140494 193.04460000000003 L 379.80413223140494 264.849 C 379.80413223140494 265.849 378.80413223140494 266.849 377.80413223140494 266.849 L 370.078326446281 266.849 C 369.078326446281 266.849 368.078326446281 265.849 368.078326446281 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 368.078326446281 264.849 L 368.078326446281 193.04460000000003 C 368.078326446281 192.04460000000003 369.078326446281 191.04460000000003 370.078326446281 191.04460000000003 L 377.80413223140494 191.04460000000003 C 378.80413223140494 191.04460000000003 379.80413223140494 192.04460000000003 379.80413223140494 193.04460000000003 L 379.80413223140494 264.849 C 379.80413223140494 265.849 378.80413223140494 266.849 377.80413223140494 266.849 L 370.078326446281 266.849 C 369.078326446281 266.849 368.078326446281 265.849 368.078326446281 264.849 Z " pathFrom="M 364.43667355371906 264.849 L 364.43667355371906 193.04460000000003 C 364.43667355371906 192.04460000000003 365.43667355371906 191.04460000000003 366.43667355371906 191.04460000000003 L 373.9958677685951 191.04460000000003 C 374.9958677685951 191.04460000000003 375.9958677685951 192.04460000000003 375.9958677685951 193.04460000000003 L 375.9958677685951 264.849 C 375.9958677685951 265.849 374.9958677685951 266.849 373.9958677685951 266.849 L 366.43667355371906 266.849 C 365.43667355371906 266.849 364.43667355371906 265.849 364.43667355371906 264.849 Z  L 368.078326446281 266.849 L 379.80413223140494 266.849 L 379.80413223140494 266.849 L 379.80413223140494 266.849 L 379.80413223140494 266.849 L 379.80413223140494 266.849 L 368.078326446281 266.849 Z" cy="188.54360000000003" cx="379.80413223140494" j="8" val="36" barHeight="80.8044" barWidth="16.725805785123967"></path><path d="M 415.86634297520663 264.849 L 415.86634297520663 161.62066666666666 C 415.86634297520663 160.62066666666666 416.86634297520663 159.62066666666666 417.86634297520663 159.62066666666666 L 425.5921487603306 159.62066666666666 C 426.5921487603306 159.62066666666666 427.5921487603306 160.62066666666666 427.5921487603306 161.62066666666666 L 427.5921487603306 264.849 C 427.5921487603306 265.849 426.5921487603306 266.849 425.5921487603306 266.849 L 417.86634297520663 266.849 C 416.86634297520663 266.849 415.86634297520663 265.849 415.86634297520663 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 415.86634297520663 264.849 L 415.86634297520663 161.62066666666666 C 415.86634297520663 160.62066666666666 416.86634297520663 159.62066666666666 417.86634297520663 159.62066666666666 L 425.5921487603306 159.62066666666666 C 426.5921487603306 159.62066666666666 427.5921487603306 160.62066666666666 427.5921487603306 161.62066666666666 L 427.5921487603306 264.849 C 427.5921487603306 265.849 426.5921487603306 266.849 425.5921487603306 266.849 L 417.86634297520663 266.849 C 416.86634297520663 266.849 415.86634297520663 265.849 415.86634297520663 264.849 Z " pathFrom="M 411.7486570247935 264.849 L 411.7486570247935 161.62066666666666 C 411.7486570247935 160.62066666666666 412.7486570247935 159.62066666666666 413.7486570247935 159.62066666666666 L 421.3078512396695 159.62066666666666 C 422.3078512396695 159.62066666666666 423.3078512396695 160.62066666666666 423.3078512396695 161.62066666666666 L 423.3078512396695 264.849 C 423.3078512396695 265.849 422.3078512396695 266.849 421.3078512396695 266.849 L 413.7486570247935 266.849 C 412.7486570247935 266.849 411.7486570247935 265.849 411.7486570247935 264.849 Z  L 415.86634297520663 266.849 L 427.5921487603306 266.849 L 427.5921487603306 266.849 L 427.5921487603306 266.849 L 427.5921487603306 266.849 L 427.5921487603306 266.849 L 415.86634297520663 266.849 Z" cy="157.11966666666666" cx="427.5921487603306" j="9" val="50" barHeight="112.22833333333334" barWidth="16.725805785123967"></path><path d="M 463.65435950413223 264.849 L 463.65435950413223 166.10980000000004 C 463.65435950413223 165.10980000000004 464.65435950413223 164.10980000000004 465.65435950413223 164.10980000000004 L 473.3801652892562 164.10980000000004 C 474.3801652892562 164.10980000000004 475.3801652892562 165.10980000000004 475.3801652892562 166.10980000000004 L 475.3801652892562 264.849 C 475.3801652892562 265.849 474.3801652892562 266.849 473.3801652892562 266.849 L 465.65435950413223 266.849 C 464.65435950413223 266.849 463.65435950413223 265.849 463.65435950413223 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 463.65435950413223 264.849 L 463.65435950413223 166.10980000000004 C 463.65435950413223 165.10980000000004 464.65435950413223 164.10980000000004 465.65435950413223 164.10980000000004 L 473.3801652892562 164.10980000000004 C 474.3801652892562 164.10980000000004 475.3801652892562 165.10980000000004 475.3801652892562 166.10980000000004 L 475.3801652892562 264.849 C 475.3801652892562 265.849 474.3801652892562 266.849 473.3801652892562 266.849 L 465.65435950413223 266.849 C 464.65435950413223 266.849 463.65435950413223 265.849 463.65435950413223 264.849 Z " pathFrom="M 459.06064049586786 264.849 L 459.06064049586786 166.10980000000004 C 459.06064049586786 165.10980000000004 460.06064049586786 164.10980000000004 461.06064049586786 164.10980000000004 L 468.6198347107439 164.10980000000004 C 469.6198347107439 164.10980000000004 470.6198347107439 165.10980000000004 470.6198347107439 166.10980000000004 L 470.6198347107439 264.849 C 470.6198347107439 265.849 469.6198347107439 266.849 468.6198347107439 266.849 L 461.06064049586786 266.849 C 460.06064049586786 266.849 459.06064049586786 265.849 459.06064049586786 264.849 Z  L 463.65435950413223 266.849 L 475.3801652892562 266.849 L 475.3801652892562 266.849 L 475.3801652892562 266.849 L 475.3801652892562 266.849 L 475.3801652892562 266.849 L 463.65435950413223 266.849 Z" cy="161.60880000000003" cx="475.3801652892562" j="10" val="48" barHeight="107.7392" barWidth="16.725805785123967"></path><path d="M 511.4423760330578 264.849 L 511.4423760330578 208.75656666666669 C 511.4423760330578 207.75656666666669 512.4423760330578 206.75656666666669 513.4423760330578 206.75656666666669 L 521.1681818181818 206.75656666666669 C 522.1681818181818 206.75656666666669 523.1681818181818 207.75656666666669 523.1681818181818 208.75656666666669 L 523.1681818181818 264.849 C 523.1681818181818 265.849 522.1681818181818 266.849 521.1681818181818 266.849 L 513.4423760330578 266.849 C 512.4423760330578 266.849 511.4423760330578 265.849 511.4423760330578 264.849 Z " fill="var(--primary-color)" fill-opacity="1" stroke="var(--primary-color)" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="0" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 511.4423760330578 264.849 L 511.4423760330578 208.75656666666669 C 511.4423760330578 207.75656666666669 512.4423760330578 206.75656666666669 513.4423760330578 206.75656666666669 L 521.1681818181818 206.75656666666669 C 522.1681818181818 206.75656666666669 523.1681818181818 207.75656666666669 523.1681818181818 208.75656666666669 L 523.1681818181818 264.849 C 523.1681818181818 265.849 522.1681818181818 266.849 521.1681818181818 266.849 L 513.4423760330578 266.849 C 512.4423760330578 266.849 511.4423760330578 265.849 511.4423760330578 264.849 Z " pathFrom="M 506.37262396694223 264.849 L 506.37262396694223 208.75656666666669 C 506.37262396694223 207.75656666666669 507.37262396694223 206.75656666666669 508.37262396694223 206.75656666666669 L 515.9318181818182 206.75656666666669 C 516.9318181818182 206.75656666666669 517.9318181818182 207.75656666666669 517.9318181818182 208.75656666666669 L 517.9318181818182 264.849 C 517.9318181818182 265.849 516.9318181818182 266.849 515.9318181818182 266.849 L 508.37262396694223 266.849 C 507.37262396694223 266.849 506.37262396694223 265.849 506.37262396694223 264.849 Z  L 511.4423760330578 266.849 L 523.1681818181818 266.849 L 523.1681818181818 266.849 L 523.1681818181818 266.849 L 523.1681818181818 266.849 L 523.1681818181818 266.849 L 511.4423760330578 266.849 Z" cy="204.25556666666668" cx="523.1681818181818" j="11" val="29" barHeight="65.09243333333333" barWidth="16.725805785123967"></path><g class="apexcharts-bar-goals-markers"><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g></g><g class="apexcharts-bar-shadows apexcharts-hidden-element-shown"></g></g><g class="apexcharts-series" rel="2" seriesName="TotalxSales" data:realIndex="1"><path d="M 2.5 264.849 L 2.5 170.59893333333335 C 2.5 169.59893333333335 3.5 168.59893333333335 4.5 168.59893333333335 L 12.225805785123967 168.59893333333335 C 13.225805785123967 168.59893333333335 14.225805785123967 169.59893333333335 14.225805785123967 170.59893333333335 L 14.225805785123967 264.849 C 14.225805785123967 265.849 13.225805785123967 266.849 12.225805785123967 266.849 L 4.5 266.849 C 3.5 266.849 2.5 265.849 2.5 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 2.5 264.849 L 2.5 170.59893333333335 C 2.5 169.59893333333335 3.5 168.59893333333335 4.5 168.59893333333335 L 12.225805785123967 168.59893333333335 C 13.225805785123967 168.59893333333335 14.225805785123967 169.59893333333335 14.225805785123967 170.59893333333335 L 14.225805785123967 264.849 C 14.225805785123967 265.849 13.225805785123967 266.849 12.225805785123967 266.849 L 4.5 266.849 C 3.5 266.849 2.5 265.849 2.5 264.849 Z " pathFrom="M 2.5 264.849 L 2.5 170.59893333333335 C 2.5 169.59893333333335 3.5 168.59893333333335 4.5 168.59893333333335 L 12.059194214876033 168.59893333333335 C 13.059194214876033 168.59893333333335 14.059194214876033 169.59893333333335 14.059194214876033 170.59893333333335 L 14.059194214876033 264.849 C 14.059194214876033 265.849 13.059194214876033 266.849 12.059194214876033 266.849 L 4.5 266.849 C 3.5 266.849 2.5 265.849 2.5 264.849 Z  L 2.5 266.849 L 14.225805785123967 266.849 L 14.225805785123967 266.849 L 14.225805785123967 266.849 L 14.225805785123967 266.849 L 14.225805785123967 266.849 L 2.5 266.849 Z" cy="166.09793333333334" cx="14.225805785123967" j="0" val="46" barHeight="103.25006666666667" barWidth="16.725805785123967"></path><path d="M 50.28801652892562 264.849 L 50.28801652892562 195.2891666666667 C 50.28801652892562 194.2891666666667 51.28801652892562 193.2891666666667 52.28801652892562 193.2891666666667 L 60.01382231404958 193.2891666666667 C 61.01382231404958 193.2891666666667 62.01382231404958 194.2891666666667 62.01382231404958 195.2891666666667 L 62.01382231404958 264.849 C 62.01382231404958 265.849 61.01382231404958 266.849 60.01382231404958 266.849 L 52.28801652892562 266.849 C 51.28801652892562 266.849 50.28801652892562 265.849 50.28801652892562 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 50.28801652892562 264.849 L 50.28801652892562 195.2891666666667 C 50.28801652892562 194.2891666666667 51.28801652892562 193.2891666666667 52.28801652892562 193.2891666666667 L 60.01382231404958 193.2891666666667 C 61.01382231404958 193.2891666666667 62.01382231404958 194.2891666666667 62.01382231404958 195.2891666666667 L 62.01382231404958 264.849 C 62.01382231404958 265.849 61.01382231404958 266.849 60.01382231404958 266.849 L 52.28801652892562 266.849 C 51.28801652892562 266.849 50.28801652892562 265.849 50.28801652892562 264.849 Z " pathFrom="M 49.811983471074385 264.849 L 49.811983471074385 195.2891666666667 C 49.811983471074385 194.2891666666667 50.811983471074385 193.2891666666667 51.811983471074385 193.2891666666667 L 59.371177685950414 193.2891666666667 C 60.371177685950414 193.2891666666667 61.371177685950414 194.2891666666667 61.371177685950414 195.2891666666667 L 61.371177685950414 264.849 C 61.371177685950414 265.849 60.371177685950414 266.849 59.371177685950414 266.849 L 51.811983471074385 266.849 C 50.811983471074385 266.849 49.811983471074385 265.849 49.811983471074385 264.849 Z  L 50.28801652892562 266.849 L 62.01382231404958 266.849 L 62.01382231404958 266.849 L 62.01382231404958 266.849 L 62.01382231404958 266.849 L 62.01382231404958 266.849 L 50.28801652892562 266.849 Z" cy="190.78816666666668" cx="62.01382231404958" j="1" val="35" barHeight="78.55983333333333" barWidth="16.725805785123967"></path><path d="M 98.07603305785123 264.849 L 98.07603305785123 47.147766666666676 C 98.07603305785123 46.147766666666676 99.07603305785123 45.147766666666676 100.07603305785123 45.147766666666676 L 107.8018388429752 45.147766666666676 C 108.8018388429752 45.147766666666676 109.8018388429752 46.147766666666676 109.8018388429752 47.147766666666676 L 109.8018388429752 264.849 C 109.8018388429752 265.849 108.8018388429752 266.849 107.8018388429752 266.849 L 100.07603305785123 266.849 C 99.07603305785123 266.849 98.07603305785123 265.849 98.07603305785123 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 98.07603305785123 264.849 L 98.07603305785123 47.147766666666676 C 98.07603305785123 46.147766666666676 99.07603305785123 45.147766666666676 100.07603305785123 45.147766666666676 L 107.8018388429752 45.147766666666676 C 108.8018388429752 45.147766666666676 109.8018388429752 46.147766666666676 109.8018388429752 47.147766666666676 L 109.8018388429752 264.849 C 109.8018388429752 265.849 108.8018388429752 266.849 107.8018388429752 266.849 L 100.07603305785123 266.849 C 99.07603305785123 266.849 98.07603305785123 265.849 98.07603305785123 264.849 Z " pathFrom="M 97.12396694214877 264.849 L 97.12396694214877 47.147766666666676 C 97.12396694214877 46.147766666666676 98.12396694214877 45.147766666666676 99.12396694214877 45.147766666666676 L 106.6831611570248 45.147766666666676 C 107.6831611570248 45.147766666666676 108.6831611570248 46.147766666666676 108.6831611570248 47.147766666666676 L 108.6831611570248 264.849 C 108.6831611570248 265.849 107.6831611570248 266.849 106.6831611570248 266.849 L 99.12396694214877 266.849 C 98.12396694214877 266.849 97.12396694214877 265.849 97.12396694214877 264.849 Z  L 98.07603305785123 266.849 L 109.8018388429752 266.849 L 109.8018388429752 266.849 L 109.8018388429752 266.849 L 109.8018388429752 266.849 L 109.8018388429752 266.849 L 98.07603305785123 266.849 Z" cy="42.64676666666668" cx="109.8018388429752" j="2" val="101" barHeight="226.70123333333333" barWidth="16.725805785123967"></path><path d="M 145.86404958677687 264.849 L 145.86404958677687 53.881466666666675 C 145.86404958677687 52.881466666666675 146.86404958677687 51.881466666666675 147.86404958677687 51.881466666666675 L 155.58985537190085 51.881466666666675 C 156.58985537190085 51.881466666666675 157.58985537190085 52.881466666666675 157.58985537190085 53.881466666666675 L 157.58985537190085 264.849 C 157.58985537190085 265.849 156.58985537190085 266.849 155.58985537190085 266.849 L 147.86404958677687 266.849 C 146.86404958677687 266.849 145.86404958677687 265.849 145.86404958677687 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 145.86404958677687 264.849 L 145.86404958677687 53.881466666666675 C 145.86404958677687 52.881466666666675 146.86404958677687 51.881466666666675 147.86404958677687 51.881466666666675 L 155.58985537190085 51.881466666666675 C 156.58985537190085 51.881466666666675 157.58985537190085 52.881466666666675 157.58985537190085 53.881466666666675 L 157.58985537190085 264.849 C 157.58985537190085 265.849 156.58985537190085 266.849 155.58985537190085 266.849 L 147.86404958677687 266.849 C 146.86404958677687 266.849 145.86404958677687 265.849 145.86404958677687 264.849 Z " pathFrom="M 144.43595041322317 264.849 L 144.43595041322317 53.881466666666675 C 144.43595041322317 52.881466666666675 145.43595041322317 51.881466666666675 146.43595041322317 51.881466666666675 L 153.9951446280992 51.881466666666675 C 154.9951446280992 51.881466666666675 155.9951446280992 52.881466666666675 155.9951446280992 53.881466666666675 L 155.9951446280992 264.849 C 155.9951446280992 265.849 154.9951446280992 266.849 153.9951446280992 266.849 L 146.43595041322317 266.849 C 145.43595041322317 266.849 144.43595041322317 265.849 144.43595041322317 264.849 Z  L 145.86404958677687 266.849 L 157.58985537190085 266.849 L 157.58985537190085 266.849 L 157.58985537190085 266.849 L 157.58985537190085 266.849 L 157.58985537190085 266.849 L 145.86404958677687 266.849 Z" cy="49.38046666666668" cx="157.58985537190085" j="3" val="98" barHeight="219.96753333333334" barWidth="16.725805785123967"></path><path d="M 193.65206611570244 264.849 L 193.65206611570244 175.08806666666666 C 193.65206611570244 174.08806666666666 194.65206611570244 173.08806666666666 195.65206611570244 173.08806666666666 L 203.3778719008264 173.08806666666666 C 204.3778719008264 173.08806666666666 205.3778719008264 174.08806666666666 205.3778719008264 175.08806666666666 L 205.3778719008264 264.849 C 205.3778719008264 265.849 204.3778719008264 266.849 203.3778719008264 266.849 L 195.65206611570244 266.849 C 194.65206611570244 266.849 193.65206611570244 265.849 193.65206611570244 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 193.65206611570244 264.849 L 193.65206611570244 175.08806666666666 C 193.65206611570244 174.08806666666666 194.65206611570244 173.08806666666666 195.65206611570244 173.08806666666666 L 203.3778719008264 173.08806666666666 C 204.3778719008264 173.08806666666666 205.3778719008264 174.08806666666666 205.3778719008264 175.08806666666666 L 205.3778719008264 264.849 C 205.3778719008264 265.849 204.3778719008264 266.849 203.3778719008264 266.849 L 195.65206611570244 266.849 C 194.65206611570244 266.849 193.65206611570244 265.849 193.65206611570244 264.849 Z " pathFrom="M 191.74793388429754 264.849 L 191.74793388429754 175.08806666666666 C 191.74793388429754 174.08806666666666 192.74793388429754 173.08806666666666 193.74793388429754 173.08806666666666 L 201.30712809917358 173.08806666666666 C 202.30712809917358 173.08806666666666 203.30712809917358 174.08806666666666 203.30712809917358 175.08806666666666 L 203.30712809917358 264.849 C 203.30712809917358 265.849 202.30712809917358 266.849 201.30712809917358 266.849 L 193.74793388429754 266.849 C 192.74793388429754 266.849 191.74793388429754 265.849 191.74793388429754 264.849 Z  L 193.65206611570244 266.849 L 205.3778719008264 266.849 L 205.3778719008264 266.849 L 205.3778719008264 266.849 L 205.3778719008264 266.849 L 205.3778719008264 266.849 L 193.65206611570244 266.849 Z" cy="170.58706666666666" cx="205.37787190082642" j="4" val="44" barHeight="98.76093333333334" barWidth="16.725805785123967"></path><path d="M 241.4400826446281 264.849 L 241.4400826446281 150.39783333333335 C 241.4400826446281 149.39783333333335 242.4400826446281 148.39783333333335 243.4400826446281 148.39783333333335 L 251.16588842975204 148.39783333333335 C 252.16588842975204 148.39783333333335 253.16588842975204 149.39783333333335 253.16588842975204 150.39783333333335 L 253.16588842975204 264.849 C 253.16588842975204 265.849 252.16588842975204 266.849 251.16588842975204 266.849 L 243.4400826446281 266.849 C 242.4400826446281 266.849 241.4400826446281 265.849 241.4400826446281 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 241.4400826446281 264.849 L 241.4400826446281 150.39783333333335 C 241.4400826446281 149.39783333333335 242.4400826446281 148.39783333333335 243.4400826446281 148.39783333333335 L 251.16588842975204 148.39783333333335 C 252.16588842975204 148.39783333333335 253.16588842975204 149.39783333333335 253.16588842975204 150.39783333333335 L 253.16588842975204 264.849 C 253.16588842975204 265.849 252.16588842975204 266.849 251.16588842975204 266.849 L 243.4400826446281 266.849 C 242.4400826446281 266.849 241.4400826446281 265.849 241.4400826446281 264.849 Z " pathFrom="M 239.05991735537194 264.849 L 239.05991735537194 150.39783333333335 C 239.05991735537194 149.39783333333335 240.05991735537194 148.39783333333335 241.05991735537194 148.39783333333335 L 248.61911157024798 148.39783333333335 C 249.61911157024798 148.39783333333335 250.61911157024798 149.39783333333335 250.61911157024798 150.39783333333335 L 250.61911157024798 264.849 C 250.61911157024798 265.849 249.61911157024798 266.849 248.61911157024798 266.849 L 241.05991735537194 266.849 C 240.05991735537194 266.849 239.05991735537194 265.849 239.05991735537194 264.849 Z  L 241.4400826446281 266.849 L 253.16588842975204 266.849 L 253.16588842975204 266.849 L 253.16588842975204 266.849 L 253.16588842975204 266.849 L 253.16588842975204 266.849 L 241.4400826446281 266.849 Z" cy="145.89683333333335" cx="253.16588842975207" j="5" val="55" barHeight="123.45116666666667" barWidth="16.725805785123967"></path><path d="M 289.22809917355374 264.849 L 289.22809917355374 145.9087 C 289.22809917355374 144.9087 290.22809917355374 143.9087 291.22809917355374 143.9087 L 298.9539049586777 143.9087 C 299.9539049586777 143.9087 300.9539049586777 144.9087 300.9539049586777 145.9087 L 300.9539049586777 264.849 C 300.9539049586777 265.849 299.9539049586777 266.849 298.9539049586777 266.849 L 291.22809917355374 266.849 C 290.22809917355374 266.849 289.22809917355374 265.849 289.22809917355374 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 289.22809917355374 264.849 L 289.22809917355374 145.9087 C 289.22809917355374 144.9087 290.22809917355374 143.9087 291.22809917355374 143.9087 L 298.9539049586777 143.9087 C 299.9539049586777 143.9087 300.9539049586777 144.9087 300.9539049586777 145.9087 L 300.9539049586777 264.849 C 300.9539049586777 265.849 299.9539049586777 266.849 298.9539049586777 266.849 L 291.22809917355374 266.849 C 290.22809917355374 266.849 289.22809917355374 265.849 289.22809917355374 264.849 Z " pathFrom="M 286.37190082644634 264.849 L 286.37190082644634 145.9087 C 286.37190082644634 144.9087 287.37190082644634 143.9087 288.37190082644634 143.9087 L 295.93109504132235 143.9087 C 296.93109504132235 143.9087 297.93109504132235 144.9087 297.93109504132235 145.9087 L 297.93109504132235 264.849 C 297.93109504132235 265.849 296.93109504132235 266.849 295.93109504132235 266.849 L 288.37190082644634 266.849 C 287.37190082644634 266.849 286.37190082644634 265.849 286.37190082644634 264.849 Z  L 289.22809917355374 266.849 L 300.9539049586777 266.849 L 300.9539049586777 266.849 L 300.9539049586777 266.849 L 300.9539049586777 266.849 L 300.9539049586777 266.849 L 289.22809917355374 266.849 Z" cy="141.4077" cx="300.95390495867775" j="6" val="57" barHeight="127.94030000000001" barWidth="16.725805785123967"></path><path d="M 337.01611570247934 264.849 L 337.01611570247934 148.15326666666667 C 337.01611570247934 147.15326666666667 338.01611570247934 146.15326666666667 339.01611570247934 146.15326666666667 L 346.7419214876033 146.15326666666667 C 347.7419214876033 146.15326666666667 348.7419214876033 147.15326666666667 348.7419214876033 148.15326666666667 L 348.7419214876033 264.849 C 348.7419214876033 265.849 347.7419214876033 266.849 346.7419214876033 266.849 L 339.01611570247934 266.849 C 338.01611570247934 266.849 337.01611570247934 265.849 337.01611570247934 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 337.01611570247934 264.849 L 337.01611570247934 148.15326666666667 C 337.01611570247934 147.15326666666667 338.01611570247934 146.15326666666667 339.01611570247934 146.15326666666667 L 346.7419214876033 146.15326666666667 C 347.7419214876033 146.15326666666667 348.7419214876033 147.15326666666667 348.7419214876033 148.15326666666667 L 348.7419214876033 264.849 C 348.7419214876033 265.849 347.7419214876033 266.849 346.7419214876033 266.849 L 339.01611570247934 266.849 C 338.01611570247934 266.849 337.01611570247934 265.849 337.01611570247934 264.849 Z " pathFrom="M 333.6838842975207 264.849 L 333.6838842975207 148.15326666666667 C 333.6838842975207 147.15326666666667 334.6838842975207 146.15326666666667 335.6838842975207 146.15326666666667 L 343.2430785123967 146.15326666666667 C 344.2430785123967 146.15326666666667 345.2430785123967 147.15326666666667 345.2430785123967 148.15326666666667 L 345.2430785123967 264.849 C 345.2430785123967 265.849 344.2430785123967 266.849 343.2430785123967 266.849 L 335.6838842975207 266.849 C 334.6838842975207 266.849 333.6838842975207 265.849 333.6838842975207 264.849 Z  L 337.01611570247934 266.849 L 348.7419214876033 266.849 L 348.7419214876033 266.849 L 348.7419214876033 266.849 L 348.7419214876033 266.849 L 348.7419214876033 266.849 L 337.01611570247934 266.849 Z" cy="143.65226666666666" cx="348.74192148760335" j="7" val="56" barHeight="125.69573333333334" barWidth="16.725805785123967"></path><path d="M 384.80413223140494 264.849 L 384.80413223140494 150.39783333333335 C 384.80413223140494 149.39783333333335 385.80413223140494 148.39783333333335 386.80413223140494 148.39783333333335 L 394.5299380165289 148.39783333333335 C 395.5299380165289 148.39783333333335 396.5299380165289 149.39783333333335 396.5299380165289 150.39783333333335 L 396.5299380165289 264.849 C 396.5299380165289 265.849 395.5299380165289 266.849 394.5299380165289 266.849 L 386.80413223140494 266.849 C 385.80413223140494 266.849 384.80413223140494 265.849 384.80413223140494 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 384.80413223140494 264.849 L 384.80413223140494 150.39783333333335 C 384.80413223140494 149.39783333333335 385.80413223140494 148.39783333333335 386.80413223140494 148.39783333333335 L 394.5299380165289 148.39783333333335 C 395.5299380165289 148.39783333333335 396.5299380165289 149.39783333333335 396.5299380165289 150.39783333333335 L 396.5299380165289 264.849 C 396.5299380165289 265.849 395.5299380165289 266.849 394.5299380165289 266.849 L 386.80413223140494 266.849 C 385.80413223140494 266.849 384.80413223140494 265.849 384.80413223140494 264.849 Z " pathFrom="M 380.9958677685951 264.849 L 380.9958677685951 150.39783333333335 C 380.9958677685951 149.39783333333335 381.9958677685951 148.39783333333335 382.9958677685951 148.39783333333335 L 390.5550619834711 148.39783333333335 C 391.5550619834711 148.39783333333335 392.5550619834711 149.39783333333335 392.5550619834711 150.39783333333335 L 392.5550619834711 264.849 C 392.5550619834711 265.849 391.5550619834711 266.849 390.5550619834711 266.849 L 382.9958677685951 266.849 C 381.9958677685951 266.849 380.9958677685951 265.849 380.9958677685951 264.849 Z  L 384.80413223140494 266.849 L 396.5299380165289 266.849 L 396.5299380165289 266.849 L 396.5299380165289 266.849 L 396.5299380165289 266.849 L 396.5299380165289 266.849 L 384.80413223140494 266.849 Z" cy="145.89683333333335" cx="396.52993801652894" j="8" val="55" barHeight="123.45116666666667" barWidth="16.725805785123967"></path><path d="M 432.5921487603306 264.849 L 432.5921487603306 197.53373333333334 C 432.5921487603306 196.53373333333334 433.5921487603306 195.53373333333334 434.5921487603306 195.53373333333334 L 442.31795454545454 195.53373333333334 C 443.31795454545454 195.53373333333334 444.31795454545454 196.53373333333334 444.31795454545454 197.53373333333334 L 444.31795454545454 264.849 C 444.31795454545454 265.849 443.31795454545454 266.849 442.31795454545454 266.849 L 434.5921487603306 266.849 C 433.5921487603306 266.849 432.5921487603306 265.849 432.5921487603306 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 432.5921487603306 264.849 L 432.5921487603306 197.53373333333334 C 432.5921487603306 196.53373333333334 433.5921487603306 195.53373333333334 434.5921487603306 195.53373333333334 L 442.31795454545454 195.53373333333334 C 443.31795454545454 195.53373333333334 444.31795454545454 196.53373333333334 444.31795454545454 197.53373333333334 L 444.31795454545454 264.849 C 444.31795454545454 265.849 443.31795454545454 266.849 442.31795454545454 266.849 L 434.5921487603306 266.849 C 433.5921487603306 266.849 432.5921487603306 265.849 432.5921487603306 264.849 Z " pathFrom="M 428.3078512396695 264.849 L 428.3078512396695 197.53373333333334 C 428.3078512396695 196.53373333333334 429.3078512396695 195.53373333333334 430.3078512396695 195.53373333333334 L 437.8670454545455 195.53373333333334 C 438.8670454545455 195.53373333333334 439.8670454545455 196.53373333333334 439.8670454545455 197.53373333333334 L 439.8670454545455 264.849 C 439.8670454545455 265.849 438.8670454545455 266.849 437.8670454545455 266.849 L 430.3078512396695 266.849 C 429.3078512396695 266.849 428.3078512396695 265.849 428.3078512396695 264.849 Z  L 432.5921487603306 266.849 L 444.31795454545454 266.849 L 444.31795454545454 266.849 L 444.31795454545454 266.849 L 444.31795454545454 266.849 L 444.31795454545454 266.849 L 432.5921487603306 266.849 Z" cy="193.03273333333334" cx="444.31795454545454" j="9" val="34" barHeight="76.31526666666667" barWidth="16.725805785123967"></path><path d="M 480.3801652892562 264.849 L 480.3801652892562 96.52823333333336 C 480.3801652892562 95.52823333333336 481.3801652892562 94.52823333333336 482.3801652892562 94.52823333333336 L 490.10597107438014 94.52823333333336 C 491.10597107438014 94.52823333333336 492.10597107438014 95.52823333333336 492.10597107438014 96.52823333333336 L 492.10597107438014 264.849 C 492.10597107438014 265.849 491.10597107438014 266.849 490.10597107438014 266.849 L 482.3801652892562 266.849 C 481.3801652892562 266.849 480.3801652892562 265.849 480.3801652892562 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 480.3801652892562 264.849 L 480.3801652892562 96.52823333333336 C 480.3801652892562 95.52823333333336 481.3801652892562 94.52823333333336 482.3801652892562 94.52823333333336 L 490.10597107438014 94.52823333333336 C 491.10597107438014 94.52823333333336 492.10597107438014 95.52823333333336 492.10597107438014 96.52823333333336 L 492.10597107438014 264.849 C 492.10597107438014 265.849 491.10597107438014 266.849 490.10597107438014 266.849 L 482.3801652892562 266.849 C 481.3801652892562 266.849 480.3801652892562 265.849 480.3801652892562 264.849 Z " pathFrom="M 475.6198347107439 264.849 L 475.6198347107439 96.52823333333336 C 475.6198347107439 95.52823333333336 476.6198347107439 94.52823333333336 477.6198347107439 94.52823333333336 L 485.1790289256199 94.52823333333336 C 486.1790289256199 94.52823333333336 487.1790289256199 95.52823333333336 487.1790289256199 96.52823333333336 L 487.1790289256199 264.849 C 487.1790289256199 265.849 486.1790289256199 266.849 485.1790289256199 266.849 L 477.6198347107439 266.849 C 476.6198347107439 266.849 475.6198347107439 265.849 475.6198347107439 264.849 Z  L 480.3801652892562 266.849 L 492.10597107438014 266.849 L 492.10597107438014 266.849 L 492.10597107438014 266.849 L 492.10597107438014 266.849 L 492.10597107438014 266.849 L 480.3801652892562 266.849 Z" cy="92.02723333333336" cx="492.10597107438014" j="10" val="79" barHeight="177.32076666666666" barWidth="16.725805785123967"></path><path d="M 528.1681818181818 264.849 L 528.1681818181818 170.59893333333335 C 528.1681818181818 169.59893333333335 529.1681818181818 168.59893333333335 530.1681818181818 168.59893333333335 L 537.8939876033057 168.59893333333335 C 538.8939876033057 168.59893333333335 539.8939876033057 169.59893333333335 539.8939876033057 170.59893333333335 L 539.8939876033057 264.849 C 539.8939876033057 265.849 538.8939876033057 266.849 537.8939876033057 266.849 L 530.1681818181818 266.849 C 529.1681818181818 266.849 528.1681818181818 265.849 528.1681818181818 264.849 Z " fill="rgba(255,73,205,0.85)" fill-opacity="1" stroke="#ff49cd" stroke-opacity="1" stroke-linecap="round" stroke-width="5" stroke-dasharray="0" class="apexcharts-bar-area undefined" index="1" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 528.1681818181818 264.849 L 528.1681818181818 170.59893333333335 C 528.1681818181818 169.59893333333335 529.1681818181818 168.59893333333335 530.1681818181818 168.59893333333335 L 537.8939876033057 168.59893333333335 C 538.8939876033057 168.59893333333335 539.8939876033057 169.59893333333335 539.8939876033057 170.59893333333335 L 539.8939876033057 264.849 C 539.8939876033057 265.849 538.8939876033057 266.849 537.8939876033057 266.849 L 530.1681818181818 266.849 C 529.1681818181818 266.849 528.1681818181818 265.849 528.1681818181818 264.849 Z " pathFrom="M 522.9318181818182 264.849 L 522.9318181818182 170.59893333333335 C 522.9318181818182 169.59893333333335 523.9318181818182 168.59893333333335 524.9318181818182 168.59893333333335 L 532.4910123966943 168.59893333333335 C 533.4910123966943 168.59893333333335 534.4910123966943 169.59893333333335 534.4910123966943 170.59893333333335 L 534.4910123966943 264.849 C 534.4910123966943 265.849 533.4910123966943 266.849 532.4910123966943 266.849 L 524.9318181818182 266.849 C 523.9318181818182 266.849 522.9318181818182 265.849 522.9318181818182 264.849 Z  L 528.1681818181818 266.849 L 539.8939876033057 266.849 L 539.8939876033057 266.849 L 539.8939876033057 266.849 L 539.8939876033057 266.849 L 539.8939876033057 266.849 L 528.1681818181818 266.849 Z" cy="166.09793333333334" cx="539.8939876033057" j="11" val="46" barHeight="103.25006666666667" barWidth="16.725805785123967"></path><g class="apexcharts-bar-goals-markers"><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g><g className="apexcharts-bar-goals-groups" class="apexcharts-hidden-element-shown" clip-path="url(#gridRectMarkerMaskkt3nblepk)"></g></g><g class="apexcharts-bar-shadows apexcharts-hidden-element-shown"></g></g></g><g class="apexcharts-line-series apexcharts-plot-series"><g class="apexcharts-series" zIndex="2" seriesName="Revenue" data:longestSeries="true" rel="1" data:realIndex="2"><path d="M 0 210.98926666666668C 16.725805785123963 210.98926666666668 31.062210743801653 168.34250000000003 47.78801652892562 168.34250000000003C 64.51382231404958 168.34250000000003 78.85022727272727 177.32076666666669 95.57603305785123 177.32076666666669C 112.3018388429752 177.32076666666669 126.63824380165289 94.27180000000001 143.36404958677687 94.27180000000001C 160.08985537190082 94.27180000000001 174.42626033057851 193.03273333333334 191.15206611570247 193.03273333333334C 207.87787190082645 193.03273333333334 222.21427685950414 123.45116666666667 238.9400826446281 123.45116666666667C 255.66588842975207 123.45116666666667 270.0022933884298 208.74470000000002 286.72809917355374 208.74470000000002C 303.4539049586777 208.74470000000002 317.7903099173554 166.09793333333334 334.51611570247934 166.09793333333334C 351.2419214876033 166.09793333333334 365.578326446281 186.29903333333334 382.30413223140494 186.29903333333334C 399.0299380165289 186.29903333333334 413.36634297520663 123.45116666666667 430.0921487603306 123.45116666666667C 446.81795454545454 123.45116666666667 461.15435950413223 159.36423333333335 477.8801652892562 159.36423333333335C 494.60597107438014 159.36423333333335 508.9423760330578 217.72296666666668 525.6681818181818 217.72296666666668" fill="none" fill-opacity="1" stroke="rgba(50,212,132,0.85)" stroke-opacity="1" stroke-linecap="round" stroke-width="2.5" stroke-dasharray="0" class="apexcharts-line" index="2" clip-path="url(#gridRectBarMaskkt3nblepk)" pathTo="M 0 210.98926666666668C 16.725805785123963 210.98926666666668 31.062210743801653 168.34250000000003 47.78801652892562 168.34250000000003C 64.51382231404958 168.34250000000003 78.85022727272727 177.32076666666669 95.57603305785123 177.32076666666669C 112.3018388429752 177.32076666666669 126.63824380165289 94.27180000000001 143.36404958677687 94.27180000000001C 160.08985537190082 94.27180000000001 174.42626033057851 193.03273333333334 191.15206611570247 193.03273333333334C 207.87787190082645 193.03273333333334 222.21427685950414 123.45116666666667 238.9400826446281 123.45116666666667C 255.66588842975207 123.45116666666667 270.0022933884298 208.74470000000002 286.72809917355374 208.74470000000002C 303.4539049586777 208.74470000000002 317.7903099173554 166.09793333333334 334.51611570247934 166.09793333333334C 351.2419214876033 166.09793333333334 365.578326446281 186.29903333333334 382.30413223140494 186.29903333333334C 399.0299380165289 186.29903333333334 413.36634297520663 123.45116666666667 430.0921487603306 123.45116666666667C 446.81795454545454 123.45116666666667 461.15435950413223 159.36423333333335 477.8801652892562 159.36423333333335C 494.60597107438014 159.36423333333335 508.9423760330578 217.72296666666668 525.6681818181818 217.72296666666668" pathFrom="M 0 210.98926666666668C 16.559194214876033 210.98926666666668 30.75278925619835 168.34250000000003 47.311983471074385 168.34250000000003C 63.871177685950414 168.34250000000003 78.06477272727274 177.32076666666669 94.62396694214877 177.32076666666669C 111.18316115702481 177.32076666666669 125.37675619834712 94.27180000000001 141.93595041322317 94.27180000000001C 158.49514462809918 94.27180000000001 172.68873966942152 193.03273333333334 189.24793388429754 193.03273333333334C 205.80712809917358 193.03273333333334 220.0007231404959 123.45116666666667 236.55991735537194 123.45116666666667C 253.11911157024798 123.45116666666667 267.3127066115703 208.74470000000002 283.87190082644634 208.74470000000002C 300.43109504132235 208.74470000000002 314.6246900826447 166.09793333333334 331.1838842975207 166.09793333333334C 347.7430785123967 166.09793333333334 361.93667355371906 186.29903333333334 378.4958677685951 186.29903333333334C 395.05506198347115 186.29903333333334 409.24865702479343 123.45116666666667 425.8078512396695 123.45116666666667C 442.3670454545455 123.45116666666667 456.56064049586786 159.36423333333335 473.1198347107439 159.36423333333335C 489.6790289256199 159.36423333333335 503.87262396694223 217.72296666666668 520.4318181818182 217.72296666666668" fill-rule="evenodd"></path><g class="apexcharts-series-markers-wrap apexcharts-hidden-element-shown" data:realIndex="2"><g class="apexcharts-series-markers"><path d="M0,0" fill="#32d484" fill-opacity="1" stroke="#ffffff" stroke-opacity="0.9" stroke-linecap="round" stroke-width="2" stroke-dasharray="0" cx="238.9400826446281" cy="0" shape="circle" class="apexcharts-marker wz2vamhp9" default-marker-size="0"></path></g></g></g><g class="apexcharts-datalabels apexcharts-hidden-element-shown" data:realIndex="0"></g><g class="apexcharts-datalabels apexcharts-hidden-element-shown" data:realIndex="1"></g><g class="apexcharts-datalabels" data:realIndex="2"></g></g><line x1="-38.329971590909096" y1="0" x2="563.9981534090908" y2="0" stroke="#b6b6b6" stroke-dasharray="0" stroke-width="1" stroke-linecap="butt" class="apexcharts-ycrosshairs"></line><line x1="-38.329971590909096" y1="0" x2="563.9981534090908" y2="0" stroke="#b6b6b6" stroke-dasharray="0" stroke-width="0" stroke-linecap="butt" class="apexcharts-ycrosshairs-hidden"></line><g class="apexcharts-xaxis" transform="translate(0, 0)"><g class="apexcharts-xaxis-texts-g" transform="translate(0, -4)"><text x="0" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Jan</tspan><title>Jan</title></text><text x="47.78801652892561" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Feb</tspan><title>Feb</title></text><text x="95.57603305785123" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Mar</tspan><title>Mar</title></text><text x="143.36404958677687" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Apr</tspan><title>Apr</title></text><text x="191.1520661157025" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>May</tspan><title>May</title></text><text x="238.9400826446281" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Jun</tspan><title>Jun</title></text><text x="286.7280991735537" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Jul</tspan><title>Jul</title></text><text x="334.5161157024793" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Aug</tspan><title>Aug</title></text><text x="382.3041322314049" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Sep</tspan><title>Sep</title></text><text x="430.0921487603305" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Oct</tspan><title>Oct</title></text><text x="477.88016528925607" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Nov</tspan><title>Nov</title></text><text x="525.6681818181817" y="297.348" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-family="Helvetica, Arial, sans-serif" font-weight="400" fill="#373d3f" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;"><tspan>Dec</tspan><title>Dec</title></text></g></g><g class="apexcharts-yaxis-annotations"></g><g class="apexcharts-xaxis-annotations"></g><g class="apexcharts-point-annotations"></g></g><rect width="0" height="0" x="0" y="0" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fefefe" class="apexcharts-zoom-rect"></rect><rect width="0" height="0" x="0" y="0" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fefefe" class="apexcharts-selection-rect"></rect></svg><div class="apexcharts-legend apexcharts-align-left apx-legend-position-top" style="right: 0px; position: absolute; left: 0px; top: 4px; max-height: 182.5px;"><div class="apexcharts-legend-series" rel="1" seriesname="TotalxOrders" data:collapsed="false" style="margin: 4px 5px;"><span class="apexcharts-legend-marker" rel="1" data:collapsed="false" style="height: 8px; width: 8px; left: 0px; top: 0px;"><svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" height="100%"><path d="M 0, 0 
           m -4, 0 
           a 4,4 0 1,0 8,0 
           a 4,4 0 1,0 -8,0" fill="var(--primary-color)" fill-opacity="1" stroke="#ffffff" stroke-opacity="0.9" stroke-linecap="round" stroke-width="0" stroke-dasharray="0" cx="0" cy="0" shape="circle" class="apexcharts-legend-marker apexcharts-marker apexcharts-marker-circle" style="transform: translate(50%, 50%);"></path></svg></span><span class="apexcharts-legend-text" rel="1" i="0" data:default-text="Total%20Orders" data:collapsed="false" style="color: rgb(55, 61, 63); font-size: 12px; font-weight: 400; font-family: Helvetica, Arial, sans-serif;">Total Orders</span></div><div class="apexcharts-legend-series" rel="2" seriesname="TotalxSales" data:collapsed="false" style="margin: 4px 5px;"><span class="apexcharts-legend-marker" rel="2" data:collapsed="false" style="height: 8px; width: 8px; left: 0px; top: 0px;"><svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" height="100%"><path d="M 0, 0 
           m -4, 0 
           a 4,4 0 1,0 8,0 
           a 4,4 0 1,0 -8,0" fill="#ff49cd" fill-opacity="1" stroke="#ffffff" stroke-opacity="0.9" stroke-linecap="round" stroke-width="0" stroke-dasharray="0" cx="0" cy="0" shape="circle" class="apexcharts-legend-marker apexcharts-marker apexcharts-marker-circle" style="transform: translate(50%, 50%);"></path></svg></span><span class="apexcharts-legend-text" rel="2" i="1" data:default-text="Total%20Sales" data:collapsed="false" style="color: rgb(55, 61, 63); font-size: 12px; font-weight: 400; font-family: Helvetica, Arial, sans-serif;">Total Sales</span></div><div class="apexcharts-legend-series" rel="3" seriesname="Revenue" data:collapsed="false" style="margin: 4px 5px;"><span class="apexcharts-legend-marker" rel="3" data:collapsed="false" style="height: 8px; width: 8px; left: 0px; top: 0px;"><svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" height="100%"><path d="M 0, 0 
           m -4, 0 
           a 4,4 0 1,0 8,0 
           a 4,4 0 1,0 -8,0" fill="#32d484" fill-opacity="1" stroke="#ffffff" stroke-opacity="0.9" stroke-linecap="round" stroke-width="0" stroke-dasharray="0" cx="0" cy="0" shape="circle" class="apexcharts-legend-marker apexcharts-marker apexcharts-marker-circle" style="transform: translate(50%, 50%);"></path></svg></span><span class="apexcharts-legend-text" rel="3" i="2" data:default-text="Revenue" data:collapsed="false" style="color: rgb(55, 61, 63); font-size: 12px; font-weight: 400; font-family: Helvetica, Arial, sans-serif;">Revenue</span></div></div><div class="apexcharts-tooltip apexcharts-theme-light" style="left: 300.27px; top: 126.451px;"><div class="apexcharts-tooltip-title" style="font-family: Helvetica, Arial, sans-serif; font-size: 12px;">Jun</div><div class="apexcharts-tooltip-series-group apexcharts-tooltip-series-group-0 apexcharts-active" style="order: 1; display: flex;"><span class="apexcharts-tooltip-marker" shape="circle" style="color: var(--primary-color);"></span><div class="apexcharts-tooltip-text" style="font-family: Helvetica, Arial, sans-serif; font-size: 12px;"><div class="apexcharts-tooltip-y-group"><span class="apexcharts-tooltip-text-y-label">Total Orders: </span><span class="apexcharts-tooltip-text-y-value">35</span></div><div class="apexcharts-tooltip-goals-group"><span class="apexcharts-tooltip-text-goals-label"></span><span class="apexcharts-tooltip-text-goals-value"></span></div><div class="apexcharts-tooltip-z-group"><span class="apexcharts-tooltip-text-z-label"></span><span class="apexcharts-tooltip-text-z-value"></span></div></div></div><div class="apexcharts-tooltip-series-group apexcharts-tooltip-series-group-1 apexcharts-active" style="order: 2; display: flex;"><span class="apexcharts-tooltip-marker" shape="circle" style="color: rgb(255, 73, 205);"></span><div class="apexcharts-tooltip-text" style="font-family: Helvetica, Arial, sans-serif; font-size: 12px;"><div class="apexcharts-tooltip-y-group"><span class="apexcharts-tooltip-text-y-label">Total Sales: </span><span class="apexcharts-tooltip-text-y-value">55</span></div><div class="apexcharts-tooltip-goals-group"><span class="apexcharts-tooltip-text-goals-label"></span><span class="apexcharts-tooltip-text-goals-value"></span></div><div class="apexcharts-tooltip-z-group"><span class="apexcharts-tooltip-text-z-label"></span><span class="apexcharts-tooltip-text-z-value"></span></div></div></div><div class="apexcharts-tooltip-series-group apexcharts-tooltip-series-group-2 apexcharts-active" style="order: 3; display: flex;"><span class="apexcharts-tooltip-marker" shape="circle" style="color: rgb(50, 212, 132);"></span><div class="apexcharts-tooltip-text" style="font-family: Helvetica, Arial, sans-serif; font-size: 12px;"><div class="apexcharts-tooltip-y-group"><span class="apexcharts-tooltip-text-y-label">Revenue: </span><span class="apexcharts-tooltip-text-y-value">65</span></div><div class="apexcharts-tooltip-goals-group"><span class="apexcharts-tooltip-text-goals-label"></span><span class="apexcharts-tooltip-text-goals-value"></span></div><div class="apexcharts-tooltip-z-group"><span class="apexcharts-tooltip-text-z-label"></span><span class="apexcharts-tooltip-text-z-value"></span></div></div></div></div><div class="apexcharts-xaxistooltip apexcharts-xaxistooltip-bottom apexcharts-theme-light" style="left: 268.094px; top: 327.348px;"><div class="apexcharts-xaxistooltip-text" style="font-family: Helvetica, Arial, sans-serif; font-size: 12px; min-width: 17.7422px;">Jun</div></div><div class="apexcharts-yaxistooltip apexcharts-yaxistooltip-0 apexcharts-yaxistooltip-left apexcharts-theme-light"><div class="apexcharts-yaxistooltip-text"></div></div></div></div> </div> <div class="card-footer bg-light p-0"> <div class="row g-0 w-100"> <div class="col-sm-4 border-sm-end"> <div class="p-3 text-center"> <span class="d-block text-muted mb-1">Total Orders</span> <h6 class="fw-semibold mb-0">15,535</h6> </div> </div> <div class="col-sm-4 border-sm-end"> <div class="p-3 text-center"> <span class="d-block text-muted mb-1">Total Sales</span> <h6 class="fw-semibold mb-0">21,754</h6> </div> </div> <div class="col-sm-4"> <div class="p-3 text-center"> <span class="d-block text-muted mb-1">Revenue Earned</span> <h6 class="fw-semibold mb-0">$1.8M</h6> </div> </div> </div> </div> </div> -->
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
                                        <div
                                            class="stat-card bg-gradient-success text-white rounded-lg p-4 h-100 shadow-sm">
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