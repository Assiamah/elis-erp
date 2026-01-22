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
    .dashboard-card {
        border-radius: 15px !important;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border: none;
        margin-bottom: 30px;
        cursor: pointer;
    }
    
    .dashboard-card:hover {
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
    
    .bg-c-blue { 
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
        color: white; 
    }
    
    .bg-c-green { 
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%); 
        color: white; 
    }
    
    .bg-c-yellow { 
        background: linear-gradient(135deg, #ffc107 0%, #ffb347 100%); 
        color: white; 
    }
    
    .bg-c-orange { 
        background: linear-gradient(135deg, #fd7e14 0%, #ff9a3d 100%); 
        color: white; 
    }
    
    .bg-c-purple { 
        background: linear-gradient(135deg, #6f42c1 0%, #a370f7 100%); 
        color: white; 
    }
    
    .bg-c-pink { 
        background: linear-gradient(135deg, #e83e8c 0%, #ff4d4d 100%); 
        color: white; 
    }
    
    .bg-c-teal { 
        background: linear-gradient(135deg, #20c997 0%, #17a2b8 100%); 
        color: white; 
    }
    
    .bg-c-red { 
        background: linear-gradient(135deg, #dc3545 0%, #ff4d4d 100%); 
        color: white; 
    }

    .bg-c-completed { 
        background: linear-gradient(135deg, #2E8B57 0%, #4CAF50 100%); 
        color: white; 
    }

    .dashboard-title { 
        font-size: 1.75rem; 
        font-weight: 700; 
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }
    
    .dashboard-subtitle { 
        color: #6c757d; 
        font-size: 1rem; 
        line-height: 1.6;
    }

    .modal-glass {
        backdrop-filter: blur(10px);
        background: rgba(255, 255, 255, 0.95);
    }

    .bg-light-gray { 
        background-color: #f8f9fa; 
    }

    .icon-container {
        width: 48px;
        height: 48px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 12px;
    }

    .bg-opacity-20 { 
        background-color: rgba(255, 255, 255, 0.2); 
    }
    
    .hover-bg-opacity-30:hover { 
        background-color: rgba(255, 255, 255, 0.3); 
    }

    .chart-container {
        width: 100%;
        height: 300px;
        position: relative;
    }

    .division-performance-card {
        border-left: 4px solid transparent;
        transition: all 0.3s ease;
    }

    .division-performance-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1) !important;
    }

    .border-left-primary { border-left-color: #667eea !important; }
    .border-left-success { border-left-color: #28a745 !important; }
    .border-left-info { border-left-color: #17a2b8 !important; }
    .border-left-warning { border-left-color: #ffc107 !important; }

    .progress-thin {
        height: 8px;
        border-radius: 4px;
    }

    .stat-icon {
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        background: rgba(255, 255, 255, 0.2);
    }

    .dropdown-menu {
        border: none;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    .dropdown-item {
        border-radius: 5px;
        margin: 2px 8px;
        width: auto;
    }

    .dropdown-item:hover {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .dashboard-header {
            flex-direction: column;
            align-items: flex-start !important;
        }
        
        .stat-card .value {
            font-size: 1.5rem;
        }
        
        .chart-container {
            height: 250px;
        }
    }
    .dashboard-stat-card {
    border-radius: 16px;
    border: none;
    background: white;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    overflow: hidden;
    position: relative;
    height: 100%;
}

.dashboard-stat-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
}

.dashboard-stat-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, var(--card-color) 0%, rgba(var(--card-color-rgb), 0.7) 100%);
}

/* Card Color Variants */
.stat-card-primary {
    --card-color: #667eea;
    --card-color-rgb: 102, 126, 234;
    --card-bg: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
}

.stat-card-success {
    --card-color: #28a745;
    --card-color-rgb: 40, 167, 69;
    --card-bg: linear-gradient(135deg, rgba(40, 167, 69, 0.05) 0%, rgba(23, 162, 184, 0.05) 100%);
}

/* Icon Container */
.stat-icon-container {
    width: 60px;
    height: 60px;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(var(--card-color-rgb), 0.1);
    color: var(--card-color);
    font-size: 26px;
    margin-bottom: 20px;
    position: relative;
    overflow: hidden;
}

.stat-icon-container::before {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    background: rgba(var(--card-color-rgb), 0.05);
    border-radius: 50%;
    transform: scale(0);
    transition: transform 0.3s ease;
}

.stat-icon-container:hover::before {
    transform: scale(2);
}

/* Stat Content */
.stat-content {
    position: relative;
}

.stat-label {
    font-size: 0.875rem;
    color: #6c757d;
    font-weight: 500;
    letter-spacing: 0.5px;
    margin-bottom: 8px;
    line-height: 1.4;
}

.stat-value {
    font-size: 2.75rem;
    font-weight: 700;
    line-height: 1;
    color: #1e293b;
    margin-bottom: 12px;
    position: relative;
    display: inline-block;
}

.stat-value::after {
    content: '';
    position: absolute;
    bottom: -6px;
    left: 0;
    width: 40px;
    height: 3px;
    background: var(--card-color);
    border-radius: 2px;
}

.stat-meta {
    font-size: 0.875rem;
    color: #6c757d;
    display: flex;
    align-items: center;
    margin-top: 12px;
}

.stat-meta i {
    font-size: 0.75rem;
    color: var(--card-color);
}

/* Trend Indicator */
.trend-indicator {
    display: inline-flex;
    align-items: center;
    padding: 4px 10px;
    border-radius: 20px;
    background: rgba(var(--card-color-rgb), 0.1);
    color: var(--card-color);
    font-size: 0.75rem;
    font-weight: 500;
    margin-left: 12px;
    vertical-align: middle;
}

.trend-indicator.positive {
    background: rgba(40, 167, 69, 0.1);
    color: #28a745;
}

.trend-indicator.negative {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545;
}

.trend-indicator i {
    margin-right: 4px;
    font-size: 0.625rem;
}

/* Optional: Add a subtle background pattern */
.dashboard-stat-card .card-body {
    background-image: 
        radial-gradient(circle at 90% 10%, rgba(var(--card-color-rgb), 0.03) 0%, transparent 50%),
        radial-gradient(circle at 10% 90%, rgba(var(--card-color-rgb), 0.03) 0%, transparent 50%);
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .stat-value {
        font-size: 2.25rem;
    }
    
    .stat-icon-container {
        width: 50px;
        height: 50px;
        font-size: 22px;
        margin-bottom: 16px;
    }
}

@media (max-width: 576px) {
    .dashboard-stat-card {
        text-align: center;
    }
    
    .stat-icon-container {
        margin-left: auto;
        margin-right: auto;
    }
    
    .stat-value::after {
        left: 50%;
        transform: translateX(-50%);
    }
}

/* Animation for count updates */
@keyframes countUp {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.stat-value.updated {
    animation: countUp 0.5s ease-out;
}
  #sub_service_modal {
    z-index: 1080 !important;
}
  #apps_modal {
    z-index: 1085 !important;
}
  #cabinetModal {
    z-index: 1090 !important;
}

  #completed_apps_modal {
    z-index: 1085 !important;
}
  #regional_modal {
    z-index: 1085 !important;
}
  #units_modal {
    z-index: 1086 !important;
}
  #officers_modal
 {
    z-index: 1087 !important;
}
  #staffapps_modal
 {
    z-index: 1088 !important;
}
  #sendMessageModal_FocalCompliance
 {
    z-index: 1090 !important;
}
  #sendMessageModal
 {
    z-index: 1090 !important;
}




</style>





<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <!-- <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-24 mb-1">
                        <i class="ri-dashboard-line me-2"></i>Executive Management Dashboard
                    </h1>
                    <p class="dashboard-subtitle">
                        Strategic overview of key operational metrics and performance indicators for data-driven decision making.
                    </p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Executive Dashboard</li>
                </ol>
            </div>
        </div> -->

        <!-- Hidden date fields -->
        <input type="hidden" id="startdate">
        <input type="hidden" id="start_date">
        <input type="hidden" id="enddate">
        <input type="hidden" id="end_date">

        <!-- Dashboard Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <div>
                <h1 class="h4 mb-1 dashboard-title">Executive Performance Dashboard</h1>
                <p class="dashboard-subtitle fw-light">
                    Monitor application trends, assess divisional efficiency, and make data-driven decisions 
                    that enhance performance and service delivery.
                </p>
            </div>
        </div>

        <!-- All Time Summary -->
        <div class="row mb-4 g-4">

            <!-- <div class="col-xl-2 col-lg-4 col-md-6" id="received_apps">
                                <div class="dashboard-card bg-c-blue shadow h-100 py-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-xs fw-bold text-uppercase mb-1">Received</div>
                                                <div class="h4 mb-0 fw-bold counter" id="app-received">0</div>
                                            </div>
                                            <i class="fas fa-file-import fa-2x text-white opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div> -->



           <div class="row mb-4">
            <div class="col-md-6 mb-4 mb-md-0">
                <div class="dashboard-stat-card stat-card-primary">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-start justify-content-between">
                            <div class="flex-grow-1">
                                <div class="stat-icon-container mb-3">
                                    <i class="fas fa-file-import"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-label text-uppercase small fw-semibold text-muted mb-1">
                                        Total Applications Received
                                    </div>
                                    <div class="stat-value text-dark mb-2" id="alltime-app-received">0</div>
                                    <div class="stat-meta text-muted small">
                                        <i class="fas fa-clock me-1"></i> All Time
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="dashboard-stat-card stat-card-success">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-start justify-content-between">
                            <div class="flex-grow-1">
                                <div class="stat-icon-container mb-3">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-label text-uppercase small fw-semibold text-muted mb-1">
                                        Applications Completed
                                    </div>
                                    <div class="stat-value text-dark mb-2" id="alltime-app-completed">0</div>
                                    <div class="stat-meta text-muted small">
                                        <i class="fas fa-clock me-1"></i> All Time
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        </div>

        <!-- Date Filters -->
        <div class="row mb-4">
            <div class="col-md-6" >
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <label class="form-label fw-semibold">Date From</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light">
                                <i class="fas fa-calendar-alt text-primary"></i>
                            </span>
                            <input type="text" id="datefrom" class="form-control" placeholder="Select Date From">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <label class="form-label fw-semibold">Date To</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light">
                                <i class="fas fa-calendar-alt text-primary"></i>
                            </span>
                            <input type="text" id="dateto" class="form-control" placeholder="Select Date To">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Applications Summary Cards -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-gradient-primary text-white py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <h6 class="m-0 fw-bold">Applications Summary - <span id="displayDateRange">All Time</span></h6>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-light dropdown-toggle" type="button" 
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="#" id="refresh-summary"><i class="fas fa-sync-alt me-2"></i>Refresh</a></li>
                                    <li><a class="dropdown-item" href="#" id="export-summary"><i class="fas fa-download me-2"></i>Export</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row g-4">
                            <!-- Received -->
                            <div class="col-xl-2 col-lg-4 col-md-6" id="received_apps">
                                <div class="dashboard-card bg-c-blue shadow h-100 py-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-xs fw-bold text-uppercase mb-1">Received</div>
                                                <div class="h4 mb-0 fw-bold counter" id="app-received">0</div>
                                            </div>
                                            <i class="fas fa-file-import fa-2x text-white opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pending -->
                            <div class="col-xl-2 col-lg-4 col-md-6" id="pending_apps">
                                <div class="dashboard-card bg-c-yellow shadow h-100 py-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-xs fw-bold text-uppercase mb-1">Pending</div>
                                                <div class="h4 mb-0 fw-bold counter" id="app-pending">0</div>
                                            </div>
                                            <i class="fas fa-hourglass-half fa-2x text-white opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Received & Completed -->
                            <div class="col-xl-2 col-lg-4 col-md-6" id="received_completed_apps">
                                <div class="dashboard-card bg-c-completed shadow h-100 py-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-xs fw-bold text-uppercase mb-1">Received & Completed</div>
                                                <div class="h4 mb-0 fw-bold counter" id="app-received-completed">0</div>
                                            </div>
                                            <i class="fas fa-calendar-check fa-2x text-white opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Completed -->
                            <div class="col-xl-2 col-lg-4 col-md-6" id="completed_apps">
                                <div class="dashboard-card bg-c-green shadow h-100 py-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-xs fw-bold text-uppercase mb-1">Completed</div>
                                                <div class="h4 mb-0 fw-bold counter" id="app-completed">0</div>
                                            </div>
                                            <i class="fas fa-check-circle fa-2x text-white opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Past Due -->
                            <div class="col-xl-2 col-lg-4 col-md-6" id="pastdue_apps">
                                <div class="dashboard-card bg-c-red shadow h-100 py-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-xs fw-bold text-uppercase mb-1">Past Due</div>
                                                <div class="h4 mb-0 fw-bold counter" id="app-pastdue">0</div>
                                            </div>
                                            <i class="fas fa-exclamation-triangle fa-2x text-white opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Completion Rate -->
                            <div class="col-xl-2 col-lg-4 col-md-6">
                                <div class="dashboard-card bg-c-purple shadow h-100 py-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-xs fw-bold text-uppercase mb-1">Completion Rate</div>
                                                <div class="h4 mb-0 fw-bold" id="completion-rate">0%</div>
                                            </div>
                                            <i class="fas fa-chart-line fa-2x text-white opacity-75"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts Section -->
        <div class="row mb-4 g-4">
            <!-- Top Services Trend -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-gradient-info text-white py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <h6 class="m-0 fw-bold">Top Services Trend</h6>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-light dropdown-toggle" type="button" 
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="#" id="toggle-line"><i class="fas fa-chart-line me-2"></i>Line Chart</a></li>
                                    <li><a class="dropdown-item" href="#" id="toggle-bar"><i class="fas fa-chart-bar me-2"></i>Bar Chart</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="#" id="export-trend-chart"><i class="fas fa-download me-2"></i>Export PNG</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="monthlyTrendChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Status Distribution -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-gradient-success text-white py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <h6 class="m-0 fw-bold">Status Distribution</h6>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-light dropdown-toggle" type="button" 
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="#" id="toggle-doughnut"><i class="fas fa-chart-pie me-2"></i>Doughnut</a></li>
                                    <li><a class="dropdown-item" href="#" id="toggle-pie"><i class="fas fa-circle me-2"></i>Pie Chart</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="#" id="export-pie-chart"><i class="fas fa-download me-2"></i>Export</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="statusPieChart"></canvas>
                        </div>
                        <div class="mt-3 text-center small">
                            <div class="d-flex justify-content-center flex-wrap gap-3">
                                <span><i class="fas fa-circle text-primary me-1"></i> Received</span>
                                <span><i class="fas fa-circle text-warning me-1"></i> Pending</span>
                                <span><i class="fas fa-circle text-success me-1"></i> Completed</span>
                                <span><i class="fas fa-circle text-danger me-1"></i> Past Due</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Division Performance -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-gradient-primary text-white py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <h6 class="m-0 fw-bold">Division Performance</h6>
                            <small class="opacity-75">Updated: <fmt:formatDate value="${now}" pattern="hh:mm a" /></small>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row g-4">
                            <!-- PVLMD -->
                            <div class="col-xl-3 col-lg-6">
                                <div class="card division-performance-card border-left-primary h-100">
                                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                                        <h6 class="m-0 fw-bold text-primary">PVLMD</h6>
                                        <i class="fas fa-landmark text-primary"></i>
                                    </div>
                                    <div class="card-body">
                                        <div class="text-center mb-3">
                                            <h4 class="fw-bold text-dark counter" id="pvlmdtotal_rec">0</h4>
                                            <small class="text-muted">Total Applications</small>
                                        </div>
                                        <div class="progress progress-thin mb-3">
                                            <div id="pvlmdPendingBar" class="progress-bar bg-warning" style="width:0%">0%</div>
                                            <div id="pvlmdCompletedBar" class="progress-bar bg-success" style="width:0%">0%</div>
                                        </div>
                                        <div class="row text-center">
                                            <div class="col-6">
                                                <small class="text-muted d-block">Pending</small>
                                                <h6 class="fw-bold text-dark counter" id="pvlmdtotal_pending">0</h6>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted d-block">Completed</small>
                                                <h6 class="fw-bold text-dark counter" id="pvlmdtotal_completed">0</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- LRD -->
                            <div class="col-xl-3 col-lg-6">
                                <div class="card division-performance-card border-left-success h-100">
                                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                                        <h6 class="m-0 fw-bold text-success">LRD</h6>
                                        <i class="fas fa-map-marked-alt text-success"></i>
                                    </div>
                                    <div class="card-body">
                                        <div class="text-center mb-3">
                                            <h4 class="fw-bold text-dark counter" id="lrdtotal_rec">0</h4>
                                            <small class="text-muted">Total Applications</small>
                                        </div>
                                        <div class="progress progress-thin mb-3">
                                            <div id="lrdPendingBar" class="progress-bar bg-warning" style="width:0%">0%</div>
                                            <div id="lrdCompletedBar" class="progress-bar bg-success" style="width:0%">0%</div>
                                        </div>
                                        <div class="row text-center">
                                            <div class="col-6">
                                                <small class="text-muted d-block">Pending</small>
                                                <h6 class="fw-bold text-dark counter" id="lrdtotal_pending">0</h6>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted d-block">Completed</small>
                                                <h6 class="fw-bold text-dark counter" id="lrdtotal_completed">0</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- LVD -->
                            <div class="col-xl-3 col-lg-6">
                                <div class="card division-performance-card border-left-info h-100">
                                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                                        <h6 class="m-0 fw-bold text-info">LVD</h6>
                                        <i class="fas fa-file-contract text-info"></i>
                                    </div>
                                    <div class="card-body">
                                        <div class="text-center mb-3">
                                            <h4 class="fw-bold text-dark counter" id="lvdtotal_rec">0</h4>
                                            <small class="text-muted">Total Applications</small>
                                        </div>
                                        <div class="progress progress-thin mb-3">
                                            <div id="lvdPendingBar" class="progress-bar bg-warning" style="width:0%">0%</div>
                                            <div id="lvdCompletedBar" class="progress-bar bg-success" style="width:0%">0%</div>
                                        </div>
                                        <div class="row text-center">
                                            <div class="col-6">
                                                <small class="text-muted d-block">Pending</small>
                                                <h6 class="fw-bold text-dark counter" id="lvdtotal_pending">0</h6>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted d-block">Completed</small>
                                                <h6 class="fw-bold text-dark counter" id="lvdtotal_completed">0</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- SMD -->
                            <div class="col-xl-3 col-lg-6">
                                <div class="card division-performance-card border-left-warning h-100">
                                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                                        <h6 class="m-0 fw-bold text-warning">SMD</h6>
                                        <i class="fas fa-search-location text-warning"></i>
                                    </div>
                                    <div class="card-body">
                                        <div class="text-center mb-3">
                                            <h4 class="fw-bold text-dark counter" id="smdtotal_rec">0</h4>
                                            <small class="text-muted">Total Applications</small>
                                        </div>
                                        <div class="progress progress-thin mb-3">
                                            <div id="smdPendingBar" class="progress-bar bg-warning" style="width:0%">0%</div>
                                            <div id="smdCompletedBar" class="progress-bar bg-success" style="width:0%">0%</div>
                                        </div>
                                        <div class="row text-center">
                                            <div class="col-6">
                                                <small class="text-muted d-block">Pending</small>
                                                <h6 class="fw-bold text-dark counter" id="smdtotal_pending">0</h6>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted d-block">Completed</small>
                                                <h6 class="fw-bold text-dark counter" id="smdtotal_completed">0</h6>
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

        <!-- Regional Performance -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-gradient-info text-white py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <h6 class="m-0 fw-bold">Regional Performance Analysis</h6>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-light dropdown-toggle" type="button" 
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-download me-1"></i> Export
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="#" id="export-regional-png"><i class="fas fa-image me-2"></i>PNG</a></li>
                                    <li><a class="dropdown-item" href="#" id="export-regional-pdf"><i class="fas fa-file-pdf me-2"></i>PDF</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="regionalReceivedChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
 <!-- Start::app-content -->


<!-- Repeat similar updates for other modals: newactivityDetailsModal, addParcelDetailsModal, transactionUpdateModal, etc. -->
<!-- They follow the same structure: btn-close-white, data-bs-dismiss, proper flex utilities, etc. -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

    <jsp:include page="../../components/_executive_modal.jsp"></jsp:include>

<!-- <script>
    document.addEventListener('DOMContentLoaded', function () {
        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Initialize date pickers
        $('#datefrom, #dateto').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayHighlight: true
        });

        // Refresh button functionality
        $('#refresh-summary').on('click', function(e) {
            e.preventDefault();
            location.reload();
        });

        // Export functionality
        $('#export-summary').on('click', function(e) {
            e.preventDefault();
            // Add export logic here
            alert('Export functionality to be implemented');
        });
    });
</script> -->