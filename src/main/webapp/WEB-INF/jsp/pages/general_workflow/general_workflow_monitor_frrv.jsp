<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>

<style>
    .frrv-shell {
        position: relative;
    }

    .frrv-shell::before {
        content: "";
        position: fixed;
        inset: 0;
        pointer-events: none;
        background:
            radial-gradient(circle at top left, rgba(4, 120, 87, 0.12), transparent 28%),
            radial-gradient(circle at top right, rgba(4, 120, 87, 0.08), transparent 22%),
            linear-gradient(180deg, #f8fbf9 0%, #eef6f2 100%);
        z-index: -1;
    }

    .frrv-hero-card {
        border: 0;
        overflow: hidden;
        border-radius: 1rem;
        background:
            radial-gradient(circle at top right, rgba(255, 255, 255, 0.10), transparent 22%),
            linear-gradient(135deg, #047857 0%, #065f46 55%, #064e3b 100%);
        box-shadow: 0 18px 40px rgba(17, 24, 39, 0.16);
    }

    .frrv-hero-card .card-body {
        position: relative;
    }

    .frrv-hero-chip {
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        padding: 0.4rem 0.75rem;
        border-radius: 999px;
        background: rgba(255, 255, 255, 0.12);
        color: rgba(255, 255, 255, 0.92);
        font-size: 0.84rem;
        font-weight: 600;
        border: 1px solid rgba(255, 255, 255, 0.12);
        backdrop-filter: blur(10px);
    }

    .frrv-stat-card {
        cursor: pointer;
        transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.2s ease;
        border-left-width: 4px;
    }

    .frrv-stat-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 24px rgba(17, 24, 39, 0.09);
    }

    .frrv-stat-card.active {
        transform: translateY(-4px);
        box-shadow: 0 12px 24px rgba(17, 24, 39, 0.11);
        border-color: rgba(4, 120, 87, 0.28);
    }

    .frrv-avatar {
        width: 52px;
        height: 52px;
        border-radius: 14px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }

    .frrv-avatar.neutral {
        background: rgba(17, 24, 39, 0.06);
        color: #047857;
    }

    .frrv-avatar.success {
        background: rgba(16, 185, 129, 0.12);
        color: #047857;
    }

    .frrv-avatar.warning {
        background: rgba(245, 158, 11, 0.12);
        color: #b45309;
    }

    .frrv-avatar.danger {
        background: rgba(239, 68, 68, 0.12);
        color: #b91c1c;
    }

    .frrv-section-title {
        display: flex;
        align-items: center;
        gap: 0.55rem;
        font-weight: 700;
        color: #374151;
        margin-bottom: 0.9rem;
    }

    .frrv-summary-card,
    .frrv-table-card,
    .frrv-side-card {
        border: 1px solid rgba(17, 24, 39, 0.08);
        border-radius: 1rem;
        box-shadow: 0 10px 24px rgba(17, 24, 39, 0.06);
        overflow: hidden;
        background: rgba(255, 255, 255, 0.92);
    }

    .frrv-table-card .card-header {
        background: linear-gradient(135deg, #047857 0%, #065f46 100%);
        color: #fff;
        border-bottom: 0;
    }

    .frrv-table {
        width: 100% !important;
        margin-bottom: 0;
    }

    .frrv-table thead th {
        background: #f8f9fa;
        color: #374151;
        font-weight: 700;
        white-space: nowrap;
    }

    .frrv-table tbody tr:hover {
        background: rgba(17, 24, 39, 0.04);
    }

    .frrv-progress {
        height: 10px;
        border-radius: 999px;
        background: #ece8e1;
        overflow: hidden;
    }

    .frrv-job-badge {
        display: inline-flex;
        align-items: center;
        padding: 0.35rem 0.65rem;
        border-radius: 999px;
        background: rgba(17, 24, 39, 0.06);
        color: #047857;
        font-weight: 700;
        letter-spacing: 0.01em;
    }

    .frrv-status-dot {
        width: 10px;
        height: 10px;
        display: inline-block;
        border-radius: 50%;
        margin-right: 0.4rem;
    }

    .frrv-status-dot.completed { background: #047857; }
    .frrv-status-dot.pending { background: #f59e0b; }
    .frrv-status-dot.not-started { background: #ef4444; }

    .frrv-action-btn {
        width: 34px;
        height: 34px;
        padding: 0;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        border: 1px solid rgba(17, 24, 39, 0.12);
    }

    .frrv-action-btn.details {
        background: rgba(17, 24, 39, 0.06);
        color: #047857;
    }

    .frrv-action-btn.progress {
        background: rgba(16, 185, 129, 0.10);
        color: #047857;
    }

    .frrv-info-card {
        border: 1px solid rgba(17, 24, 39, 0.08);
        border-radius: 1rem;
        box-shadow: 0 10px 24px rgba(17, 24, 39, 0.06);
        background: rgba(255, 255, 255, 0.92);
    }

    .frrv-info-card .card-header {
        background: linear-gradient(135deg, #111827 0%, #374151 100%);
        color: #fff;
        border-bottom: 0;
    }

    .frrv-info-card .card-header .btn-outline-light {
        border-color: rgba(255, 255, 255, 0.35);
    }

    .frrv-metric {
        border: 1px solid rgba(17, 24, 39, 0.08);
        border-radius: 0.9rem;
        background: #fff;
        box-shadow: 0 8px 18px rgba(17, 24, 39, 0.04);
    }

    .frrv-empty-card {
        border: 1px dashed rgba(17, 24, 39, 0.14);
        border-radius: 0.9rem;
        background: rgba(248, 249, 250, 0.7);
    }

    @media (max-width: 767.98px) {
        .frrv-hero-card h1 {
            font-size: 1.35rem;
        }
    }
</style>

<div class="main-content app-content frrv-shell">
    <div class="container-fluid page-container">
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap gap-2">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-0">FRRV Monitoring :: <span class="text-success">Workflow</span></h1>
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                        <li class="breadcrumb-item active" aria-current="page">FRRV Monitoring</li>
                    </ol>
                </div>
                <div class="d-flex gap-2 align-items-center">
                    <span class="badge rounded-pill text-bg-success" id="recordCount">
                        <i class="fas fa-file-alt me-1"></i>Total: 0
                    </span>
                    <button class="btn btn-success btn-sm" type="button" onclick="loadData()">
                        <i class="fas fa-arrows-rotate me-1"></i>Refresh
                    </button>
                </div>
            </div>
        </div>

        <div class="card frrv-hero-card mb-4">
            <div class="card-body p-4 p-xl-5">
                <div class="d-flex flex-column flex-lg-row justify-content-between align-items-start align-items-lg-center gap-3">
                    <div class="flex-grow-1">
                        <div class="d-flex flex-wrap gap-2 mb-3">
                            <span class="frrv-hero-chip"><i class="fas fa-layer-group"></i> Workflow summary</span>
                            <span class="frrv-hero-chip"><i class="fas fa-chart-line"></i> Live status cards</span>
                            <span class="frrv-hero-chip"><i class="fas fa-table"></i> Job table below</span>
                        </div>
                        <h1 class="fw-semibold text-white mb-2">Monitor FRRV progress across SMD, PVLMD, and LRD</h1>
                        <p class="mb-0 text-white-75" style="max-width: 760px;">
                            Same UI pattern as Unit Case Management, with neutral surfaces, warm accents, and no blue-heavy styling.
                        </p>
                    </div>
                    <div class="d-flex flex-wrap gap-2">
                        <span class="frrv-hero-chip"><i class="fas fa-list-check"></i><span id="totalJobs">${total_jobs}</span> jobs</span>
                        <span class="frrv-hero-chip"><i class="fas fa-circle-check"></i><span id="fullyCompleted">0</span> completed</span>
                        <span class="frrv-hero-chip"><i class="fas fa-hourglass-half"></i><span id="partiallyCompleted">0</span> partial</span>
                    </div>
                </div>
            </div>
        </div>

        <input type="hidden" id="totalJobsValue" value="${total_jobs}">

        <div class="row g-4 mb-4" id="statsContainer">
            <div class="col-lg-3 col-md-6">
                <div class="card custom-card stat-card dashboard-main-card neutral frrv-stat-card" data-filter="all">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <span class="frrv-avatar neutral">
                                <i class="fas fa-list-check fs-4"></i>
                            </span>
                            <div>
                                <span class="d-block text-muted">Total FRRV Jobs</span>
                                <h5 class="fw-semibold mb-1" id="totalJobsValueDisplay">${total_jobs}</h5>
                                <span class="badge text-bg-light border">All jobs</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card custom-card stat-card dashboard-main-card success frrv-stat-card" data-filter="Fully Completed">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <span class="frrv-avatar success">
                                <i class="fas fa-circle-check fs-4"></i>
                            </span>
                            <div>
                                <span class="d-block text-muted">Fully Completed</span>
                                <h5 class="fw-semibold mb-1 text-success" id="fullyCompleted">0</h5>
                                <span class="badge text-bg-success">3 of 3 divisions</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card custom-card stat-card dashboard-main-card warning frrv-stat-card" data-filter="Partially Completed">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <span class="frrv-avatar warning">
                                <i class="fas fa-hourglass-half fs-4"></i>
                            </span>
                            <div>
                                <span class="d-block text-muted">Partially Completed</span>
                                <h5 class="fw-semibold mb-1" style="color:#065f46;" id="partiallyCompleted">0</h5>
                                <span class="badge text-bg-warning text-dark">1-2 of 3 divisions</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card custom-card stat-card dashboard-main-card danger frrv-stat-card" data-filter="Not Started">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3">
                            <span class="frrv-avatar danger">
                                <i class="fas fa-hourglass-start fs-4"></i>
                            </span>
                            <div>
                                <span class="d-block text-muted">Not Started</span>
                                <h5 class="fw-semibold mb-1 text-danger" id="notStarted">0</h5>
                                <span class="badge text-bg-danger">0 of 3 divisions</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-xl-9">
                <div class="card frrv-summary-card">
                    <div class="card-header d-flex justify-content-between align-items-center flex-wrap gap-2">
                        <div class="card-title mb-0">Division Summary</div>
                        <span class="badge text-bg-light border">Click a summary card to filter the table</span>
                    </div>
                    <div class="card-body p-3">
                        <div class="row g-3" id="divisionSummaryContainer">
                            <div class="col-md-4" id="smdCard">
                                <div class="card frrv-metric h-100">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <div>
                                                <span class="d-block text-muted small">Division</span>
                                                <h6 class="fw-bold mb-0">SMD</h6>
                                            </div>
                                            <span class="badge text-bg-light border">SMD</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-1">
                                            <span class="small text-muted">Completed</span>
                                            <span class="small fw-bold" id="smdCompleted">0</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="small text-muted">Pending</span>
                                            <span class="small fw-bold" id="smdPending">0</span>
                                        </div>
                                        <div class="progress frrv-progress">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 0%" id="smdProgress"></div>
                                        </div>
                                        <div class="d-flex justify-content-between mt-2">
                                            <span class="small text-muted">Total: <span id="smdTotal">0</span></span>
                                            <span class="small fw-bold text-success" id="smdPercentage">0%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4" id="pvlmdCard">
                                <div class="card frrv-metric h-100">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <div>
                                                <span class="d-block text-muted small">Division</span>
                                                <h6 class="fw-bold mb-0">PVLMD</h6>
                                            </div>
                                            <span class="badge text-bg-light border">PVLMD</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-1">
                                            <span class="small text-muted">Completed</span>
                                            <span class="small fw-bold" id="pvlmdCompleted">0</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="small text-muted">Pending</span>
                                            <span class="small fw-bold" id="pvlmdPending">0</span>
                                        </div>
                                        <div class="progress frrv-progress">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 0%" id="pvlmdProgress"></div>
                                        </div>
                                        <div class="d-flex justify-content-between mt-2">
                                            <span class="small text-muted">Total: <span id="pvlmdTotal">0</span></span>
                                            <span class="small fw-bold text-success" id="pvlmdPercentage">0%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4" id="lrdCard">
                                <div class="card frrv-metric h-100">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <div>
                                                <span class="d-block text-muted small">Division</span>
                                                <h6 class="fw-bold mb-0">LRD</h6>
                                            </div>
                                            <span class="badge text-bg-light border">LRD</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-1">
                                            <span class="small text-muted">Completed</span>
                                            <span class="small fw-bold" id="lrdCompleted">0</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="small text-muted">Pending</span>
                                            <span class="small fw-bold" id="lrdPending">0</span>
                                        </div>
                                        <div class="progress frrv-progress">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 0%" id="lrdProgress"></div>
                                        </div>
                                        <div class="d-flex justify-content-between mt-2">
                                            <span class="small text-muted">Total: <span id="lrdTotal">0</span></span>
                                            <span class="small fw-bold text-success" id="lrdPercentage">0%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3">
                <div class="card frrv-info-card h-100">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div class="card-title mb-0">Quick Guide</div>
                        <span class="badge text-bg-light border">Monitor</span>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-secondary border mb-0 p-3">
                            <div class="d-flex align-items-start">
                                <div class="me-2">
                                    <i class="fas fa-circle-info fa-lg"></i>
                                </div>
                                <div class="text-dark">
                                    <div class="fw-medium mb-2">FRRV Monitoring Dashboard</div>
                                    <div class="fs-12 mb-1">
                                        Use the status cards to filter jobs by completion state.
                                    </div>
                                    <div class="fs-12 mb-1">
                                        Division summary cards show how SMD, PVLMD, and LRD are tracking.
                                    </div>
                                    <div class="fs-12">
                                        Table actions open details or the progress view for each job.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mt-3 d-grid gap-2">
                            <button class="btn btn-success showOfficerList" type="button" onclick="loadData()">
                                <i class="fas fa-arrows-rotate me-1"></i> Reload FRRV Data
                            </button>
                            <button class="btn btn-outline-secondary" type="button" onclick="filterData('all')">
                                <i class="fas fa-layer-group me-1"></i> Show All Jobs
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="card frrv-table-card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center flex-wrap gap-2">
                        <div class="card-title mb-0">FRRV Job Status</div>
                        <div class="d-flex align-items-center gap-2">
                            <span class="badge text-bg-light border" id="recordCount">
                                <i class="fas fa-file me-1"></i>Total: 0
                            </span>
                            <button class="btn btn-sm btn-outline-light" type="button" onclick="loadData()">
                                <i class="fas fa-sync-alt"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body p-3">
                        <div class="table-responsive">
                            <table class="table table-striped align-middle frrv-table display" id="frrvTable" width="100%">
                                <thead class="table-light">
                                    <tr>
                                        <th>Job Number</th>
                                        <th>SMD</th>
                                        <th>PVLMD</th>
                                        <th>LRD</th>
                                        <th>Progress</th>
                                        <th>Status</th>
                                        <th>Last Updated</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="frrvTableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
