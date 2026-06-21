<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>

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
                        <span class="frrv-hero-chip"><i class="fas fa-circle-check"></i><span id="fullyCompleted">${fully_completed}</span> completed</span>
                        <span class="frrv-hero-chip"><i class="fas fa-hourglass-half"></i><span id="partiallyCompleted">${partially_completed}</span> partial</span>
                    </div>
                </div>
            </div>
        </div>

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
                                <h5 class="fw-semibold mb-1 text-success" id="fullyCompletedDisplay">${fully_completed}</h5>
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
                                <h5 class="fw-semibold mb-1" style="color:#065f46;" id="partiallyCompletedDisplay">${partially_completed}</h5>
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
                                <h5 class="fw-semibold mb-1 text-danger" id="notStartedDisplay">${not_started}</h5>
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
                            <c:forEach var="division" items="${division_summary_details_list}">
                                <div class="col-md-4">
                                    <div class="card frrv-metric h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                                <div>
                                                    <span class="d-block text-muted small">Division</span>
                                                    <h6 class="fw-bold mb-0">${division.division}</h6>
                                                </div>
                                                <span class="badge text-bg-light border">${division.division}</span>
                                            </div>
                                            <div class="d-flex justify-content-between mb-1">
                                                <span class="small text-muted">Completed</span>
                                                <span class="small fw-bold">${division.completed_jobs}</span>
                                            </div>
                                            <div class="d-flex justify-content-between mb-2">
                                                <span class="small text-muted">Pending</span>
                                                <span class="small fw-bold">${division.pending_jobs}</span>
                                            </div>
                                            <div class="progress frrv-progress">
                                                <div class="progress-bar bg-success" role="progressbar" 
                                                    
                                                     aria-valuenow="${division.completion_percentage}" 
                                                     aria-valuemin="0" 
                                                     aria-valuemax="100">
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-between mt-2">
                                                <span class="small text-muted">Total: ${division.total_jobs}</span>
                                                <span class="small fw-bold text-success">${division.completion_percentage}%</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
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
                            <button class="btn btn-success" type="button" onclick="loadData()">
                                <i class="fas fa-arrows-rotate me-1"></i> Reload FRRV Data
                            </button>
                            <button class="btn btn-outline-secondary" type="button" onclick="filterData('all')">
                                <i class="fas fa-layer-group me-1"></i> Show All Jobs
                            </button>

                         <button class="btn btn-outline-secondary" type="button" id="btn_load_details_applications">
                                <i class="fas fa-layer-group me-1"></i> Show Details
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
                            <span class="badge text-bg-light border" id="recordCountTable">
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
                                    <!-- Data will be populated via AJAX -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Initialize DataTable for surveyor_dataTable
        if ($.fn.DataTable.isDataTable('#surveyor_dataTable')) {
            $('#surveyor_dataTable').DataTable().destroy();
        }
        $('#surveyor_dataTable').DataTable({
            pageLength: 10,
            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
            responsive: true,
            columnDefs: [
                { orderable: false, targets: [11] }
            ]
        });

        // Initialize DataTable for frrvTable
        initializeFRRVDataTable();

        // Search button click handler
        $('#btn_load_details_applications').on('click', function() {
            const btn = $(this);
            const request_type = 'get_frrv_jobs_status_json';
            
            btn.prop('disabled', true);
            btn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...');
            
            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                    request_type: request_type,
                    division: localStorage.getItem('division') || ''
                },
                cache: false,
                success: function(response) {
                      console.log("Response:", response);

  
      //  const jsonData = JSON.parse(response);

      
                    
                    
                    try {
                        const jsonData = JSON.parse(response);
                          console.log("Parsed Data:", jsonData);
                        
                        if (!Array.isArray(jsonData)) {
                            Swal.fire({
                                title: 'Error',
                                text: 'Invalid data format received',
                                icon: 'error',
                                confirmButtonText: 'OK'
                            });
                            return;
                        }
                        
                        // Clear existing table data
                        const table = $('#frrvTable').DataTable();
                        table.clear().draw();
                        
                        if (jsonData.length === 0) {
                            $('#frrvTableBody').html(`
                                <tr>
                                    <td colspan="8" class="text-center py-4 text-muted">
                                        <i class="fas fa-inbox fa-2x mb-2 d-block"></i>
                                        No FRRV jobs found
                                    </td>
                                </tr>
                            `);
                            // Reinitialize DataTable
                            initializeFRRVDataTable();
                            return;
                        }
                        
                        // Process each job and add to table
                  //   const table1 = $('#frrvTable').DataTable();

table.clear();

jsonData.forEach(function(item) {

    const statusColor =

        item.completion_status === 'Fully Completed' ? 'success' :

        item.completion_status === 'Partially Completed' ? 'warning' :

        'danger';

    table.row.add([

        item.job_number,

        item.smd_completed

            ? '<span class="badge bg-success">Completed</span>'

            : '<span class="badge bg-warning text-dark">Pending</span>',

        item.pvlmd_completed

            ? '<span class="badge bg-success">Completed</span>'

            : '<span class="badge bg-warning text-dark">Pending</span>',

        item.lrd_completed

            ? '<span class="badge bg-success">Completed</span>'

            : '<span class="badge bg-warning text-dark">Pending</span>',

        `

        <div class="progress">

            <div class="progress-bar bg-${statusColor}"

                 style="width:${item.completion_percentage}%">

                 ${item.completion_percentage}%

            </div>

        </div>

        `,

        `<span class="badge bg-${statusColor}">

            ${item.completion_status}

        </span>`,

        item.last_updated,

        `

        <button class="btn btn-sm btn-primary view-details"

                data-job="${item.job_number}">

            View

        </button>

        `

    ]);

});

table.draw();
                        
                        // Update record count
                        const recordCount = jsonData.length;
                        $('#recordCount').html(`<i class="fas fa-file-alt me-1"></i>Total: ${recordCount}`);
                        $('#recordCountTable').html(`<i class="fas fa-file me-1"></i>Total: ${recordCount}`);
                        
                        // Redraw DataTable to ensure proper rendering
                        table.draw();
                        
                        Swal.fire({
                            title: 'Success',
                            text: `Loaded ${recordCount} FRRV job(s) successfully`,
                            icon: 'success',
                            timer: 2000,
                            showConfirmButton: false
                        });
                        
                    } catch (e) {
                        console.error("Error parsing response:", e);
                        Swal.fire({
                            title: 'Error',
                            text: 'An error occurred while processing the data',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX Error:", error);
                    Swal.fire({
                        title: 'Request Failed',
                        text: 'An error occurred while loading FRRV data. Please try again.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                },
                complete: function() {
                    btn.prop('disabled', false);
                    btn.html('<i class="fas fa-sync-alt me-1"></i> Load FRRV Data');
                }
            });
        });

        // View details button click (event delegation)
        $(document).on('click', '.view-details', function() {
            const jobNumber = $(this).data('job');
            viewJobDetails(jobNumber);
        });
        
        // View progress button click (event delegation)
        $(document).on('click', '.view-progress', function() {
            const jobNumber = $(this).data('job');
            window.location.href = 'frrv_progress.jsp?job=' + jobNumber;
        });
    });

    // Helper function to initialize FRRV DataTable
    function initializeFRRVDataTable() {
        if ($.fn.DataTable.isDataTable('#frrvTable')) {
            $('#frrvTable').DataTable().destroy();
        }
        
        return $('#frrvTable').DataTable({
            pageLength: 10,
            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
            responsive: true,
            ordering: true,
            order: [[5, 'asc']],
            columnDefs: [
                { orderable: false, targets: [1, 2, 3, 4, 7] }
            ],
            language: {
                search: "<i class='fas fa-search me-1'></i>Search:",
                searchPlaceholder: "Search jobs...",
                lengthMenu: "Show _MENU_ entries",
                info: "Showing _START_ to _END_ of _TOTAL_ jobs",
                infoEmpty: "No jobs available",
                infoFiltered: "(filtered from _MAX_ total jobs)",
                zeroRecords: "No matching jobs found"
            },
            // Ensure the table is properly initialized with empty data
            data: [],
            columns: [
                { title: "Job Number" },
                { title: "SMD" },
                { title: "PVLMD" },
                { title: "LRD" },
                { title: "Progress" },
                { title: "Status" },
                { title: "Last Updated" },
                { title: "Action" }
            ]
        });
    }

    // Function to view job details
    function viewJobDetails(jobNumber) {
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'get_frrv_job_details',
                job_number: jobNumber
            },
            dataType: 'json',
            success: function(response) {
                showJobDetailsModal(response);
            },
            error: function() {
                Swal.fire({
                    title: 'Error',
                    text: 'Could not load job details',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            }
        });
    }

    // Function to show job details modal
    function showJobDetailsModal(job) {
        const modalHTML = `
            <div class="modal fade" id="jobDetailsModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header" style="background: linear-gradient(135deg, #047857 0%, #065f46 100%); color: #fff;">
                            <h5 class="modal-title text-white">
                                <i class="fas fa-info-circle me-2"></i>FRRV Details - ${job.job_number}
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-body text-center">
                                            <h6 class="text-muted">SMD</h6>
                                            <span class="badge text-bg-${job.smd_completed ? 'success' : 'warning'} fs-6">
                                                ${job.smd_status || 'Not Started'}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-body text-center">
                                            <h6 class="text-muted">PVLMD</h6>
                                            <span class="badge text-bg-${job.pvlmd_completed ? 'success' : 'warning'} fs-6">
                                                ${job.pvlmd_status || 'Not Started'}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-body text-center">
                                            <h6 class="text-muted">LRD</h6>
                                            <span class="badge text-bg-${job.lrd_completed ? 'success' : 'warning'} fs-6">
                                                ${job.lrd_status || 'Not Started'}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card">
                                       
                                    </div>
                                </div>
                            </div>
                            <div class="mt-3 text-center">
                                <small class="text-muted">Last Updated: ${job.last_updated || 'N/A'}</small>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        $('#jobDetailsModal').remove();
        $('body').append(modalHTML);
        const modal = new bootstrap.Modal(document.getElementById('jobDetailsModal'));
        modal.show();
    }
</script>