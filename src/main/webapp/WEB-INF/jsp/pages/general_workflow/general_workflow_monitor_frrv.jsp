<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>


    <style>
        .card-header {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            padding: 1rem 1.5rem;
        }
        
        .card-header h5 {
            font-weight: 600;
            letter-spacing: 0.3px;
        }
        
        .stat-card {
            cursor: pointer;
            transition: all 0.3s ease;
            border: 1px solid #f0f2f5;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
        }
        
        .stat-card.active {
            border-left: 5px solid #0d6efd;
            background-color: #f8f9fa;
        }
        
        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .progress-thin {
            height: 6px;
            border-radius: 3px;
        }
        
        .completion-badge {
            font-size: 0.75rem;
            padding: 0.35rem 0.75rem;
        }
        
        .status-indicator {
            display: inline-block;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin-right: 6px;
        }
        
        .status-indicator.completed {
            background-color: #28a745;
        }
        
        .status-indicator.pending {
            background-color: #ffc107;
        }
        
        .status-indicator.not-started {
            background-color: #dc3545;
        }
        
        .breadcrumb {
            background: transparent;
            padding: 0.75rem 0;
        }
        
        .breadcrumb-item a {
            text-decoration: none;
            color: #0d6efd;
            font-weight: 500;
        }
        
        .breadcrumb-item a:hover {
            color: #0a58ca;
            text-decoration: underline;
        }
        
        .division-card {
            border-left: 4px solid #0d6efd;
            transition: all 0.3s ease;
        }
        
        .division-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }
        
        .division-card .progress {
            height: 8px;
        }
    </style>

    <div class="main-content app-content">
        <div class="container-fluid page-container">
            
            <!-- Breadcrumbs -->
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="dashboard.jsp"><i class="fas fa-home me-1"></i>Dashboard</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">
                        <i class="fas fa-clipboard-check me-1"></i>FRRV Monitoring
                    </li>
                </ol>
            </nav>

            <!-- Statistics Cards -->
            <div class="row g-4 mb-4" id="statsContainer">
                <div class="col-xl-3 col-md-6">
                    <div class="card stat-card h-100" data-filter="all">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="small text-uppercase fw-bold text-muted">Total FRRV Jobs</div>
                                    <h3 class="fw-bold mt-2" id="totalJobs">${total_jobs}</h3>
                                    <span class="badge bg-secondary">All Jobs</span>
                                </div>
                                <div class="stat-icon bg-primary bg-opacity-10">
                                    <i class="fas fa-tasks fa-2x text-primary"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6">
                    <div class="card stat-card h-100" data-filter="Fully Completed">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="small text-uppercase fw-bold text-muted">Fully Completed</div>
                                    <h3 class="fw-bold mt-2 text-success" id="fullyCompleted">0</h3>
                                    <span class="badge bg-success">3/3 Divisions</span>
                                </div>
                                <div class="stat-icon bg-success bg-opacity-10">
                                    <i class="fas fa-check-circle fa-2x text-success"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6">
                    <div class="card stat-card h-100" data-filter="Partially Completed">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="small text-uppercase fw-bold text-muted">Partially Completed</div>
                                    <h3 class="fw-bold mt-2 text-warning" id="partiallyCompleted">0</h3>
                                    <span class="badge bg-warning text-dark">1-2/3 Divisions</span>
                                </div>
                                <div class="stat-icon bg-warning bg-opacity-10">
                                    <i class="fas fa-clock fa-2x text-warning"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6">
                    <div class="card stat-card h-100" data-filter="Not Started">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="small text-uppercase fw-bold text-muted">Not Started</div>
                                    <h3 class="fw-bold mt-2 text-danger" id="notStarted">0</h3>
                                    <span class="badge bg-danger">0/3 Divisions</span>
                                </div>
                                <div class="stat-icon bg-danger bg-opacity-10">
                                    <i class="fas fa-hourglass-start fa-2x text-danger"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Division Summary Cards -->
            <div class="row g-4 mb-4" id="divisionSummaryContainer">
                <div class="col-12">
                    <h6 class="text-muted mb-3"><i class="fas fa-layer-group me-2"></i>Division Summary</h6>
                </div>
                <div class="col-md-4" id="smdCard">
                    <div class="card division-card h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h6 class="fw-bold mb-0">SMD</h6>
                                <span class="badge bg-info">Division</span>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span class="small text-muted">Completed</span>
                                <span class="small fw-bold" id="smdCompleted">0</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="small text-muted">Pending</span>
                                <span class="small fw-bold" id="smdPending">0</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 0%" id="smdProgress"></div>
                            </div>
                            <div class="d-flex justify-content-between mt-1">
                                <span class="small text-muted">Total: <span id="smdTotal">0</span></span>
                                <span class="small fw-bold text-success" id="smdPercentage">0%</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4" id="pvlmdCard">
                    <div class="card division-card h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h6 class="fw-bold mb-0">PVLMD</h6>
                                <span class="badge bg-info">Division</span>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span class="small text-muted">Completed</span>
                                <span class="small fw-bold" id="pvlmdCompleted">0</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="small text-muted">Pending</span>
                                <span class="small fw-bold" id="pvlmdPending">0</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 0%" id="pvlmdProgress"></div>
                            </div>
                            <div class="d-flex justify-content-between mt-1">
                                <span class="small text-muted">Total: <span id="pvlmdTotal">0</span></span>
                                <span class="small fw-bold text-success" id="pvlmdPercentage">0%</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4" id="lrdCard">
                    <div class="card division-card h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h6 class="fw-bold mb-0">LRD</h6>
                                <span class="badge bg-info">Division</span>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span class="small text-muted">Completed</span>
                                <span class="small fw-bold" id="lrdCompleted">0</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="small text-muted">Pending</span>
                                <span class="small fw-bold" id="lrdPending">0</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 0%" id="lrdProgress"></div>
                            </div>
                            <div class="d-flex justify-content-between mt-1">
                                <span class="small text-muted">Total: <span id="lrdTotal">0</span></span>
                                <span class="small fw-bold text-success" id="lrdPercentage">0%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Table Section -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="card mb-4 shadow-sm">
                        <div class="card-header text-white">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">
                                    <i class="fas fa-list me-2"></i>FRRV Job Status
                                </h5>
                                <div>
                                    <span class="badge bg-light text-dark me-2" id="recordCount">
                                        <i class="fas fa-file me-1"></i>Total: 0
                                    </span>
                                    <button class="btn btn-light btn-sm" onclick="loadData()">
                                        <i class="fas fa-sync-alt"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover display" id="frrvTable" width="100%">
                                    <thead>
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
                                        <!-- Data will be populated here -->
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
        let frrvData = [];
        let dataTable = null;
        let currentFilter = 'all';

        // Load data from server
        function loadData() {
            // Show loading state
            $('#totalJobs').text('...');
            $('#fullyCompleted').text('...');
            $('#partiallyCompleted').text('...');
            $('#notStarted').text('...');
            
            $.ajax({
                type: "POST",
                url: "FRRVMonitoringServ",
                data: {
                    action: 'get_frrv_summary'
                },
                dataType: 'json',
                success: function(response) {
                    // Update summary stats
                    if (response.summary) {
                        updateStats(response.summary);
                    }
                    
                    // Update division summary
                    if (response.division_summary) {
                        updateDivisionSummary(response.division_summary);
                    }
                    
                    // Load job details separately
                    loadJobDetails();
                },
                error: function(xhr, status, error) {
                    console.error('Error loading data:', error);
                    // Set default values on error
                    $('#totalJobs').text('0');
                    $('#fullyCompleted').text('0');
                    $('#partiallyCompleted').text('0');
                    $('#notStarted').text('0');
                    loadSampleData();
                }
            });
        }

        // Load job details from separate function
        function loadJobDetails() {
            $.ajax({
                type: "POST",
                url: "FRRVMonitoringServ",
                data: {
                    action: 'get_frrv_jobs'
                },
                dataType: 'json',
                success: function(response) {
                    frrvData = response;
                    renderTable(response);
                },
                error: function() {
                    loadSampleData();
                }
            });
        }

        // Sample data for testing
        function loadSampleData() {
            // Sample summary data
            const summaryData = {
                total_jobs: 10,
                fully_completed: 5,
                partially_completed: 3,
                not_started: 2
            };
            updateStats(summaryData);
            
            // Sample division data
            const divisionData = [
                { division: 'SMD', total_jobs: 10, completed_jobs: 7, pending_jobs: 3, completion_percentage: 70 },
                { division: 'PVLMD', total_jobs: 10, completed_jobs: 6, pending_jobs: 4, completion_percentage: 60 },
                { division: 'LRD', total_jobs: 10, completed_jobs: 8, pending_jobs: 2, completion_percentage: 80 }
            ];
            updateDivisionSummary(divisionData);
            
            // Sample job data
            frrvData = [
                {
                    job_number: 'LRDGAR137795962022',
                    smd_completed: true,
                    pvlmd_completed: true,
                    lrd_completed: true,
                    completion_status: 'Fully Completed',
                    completion_percentage: 100,
                    last_updated: '2026-01-20 14:30:00'
                },
                {
                    job_number: 'LRDGAR6942182020',
                    smd_completed: true,
                    pvlmd_completed: false,
                    lrd_completed: false,
                    completion_status: 'Partially Completed',
                    completion_percentage: 33,
                    last_updated: '2026-01-18 10:15:00'
                },
                {
                    job_number: 'LRDGAR75042882021',
                    smd_completed: false,
                    pvlmd_completed: false,
                    lrd_completed: false,
                    completion_status: 'Not Started',
                    completion_percentage: 0,
                    last_updated: '2026-01-15 09:00:00'
                }
            ];
            renderTable(frrvData);
        }

        // Update statistics cards
        function updateStats(summary) {
            $('#totalJobs').text(summary.total_jobs || 0);
            $('#fullyCompleted').text(summary.fully_completed || 0);
            $('#partiallyCompleted').text(summary.partially_completed || 0);
            $('#notStarted').text(summary.not_started || 0);
            $('#recordCount').text('Total: ' + (summary.total_jobs || 0));
        }

        // Update division summary
        function updateDivisionSummary(divisions) {
            if (!divisions || divisions.length === 0) {
                return;
            }
            
            divisions.forEach(function(div) {
                const divisionName = div.division.toLowerCase();
                const total = div.total_jobs || 0;
                const completed = div.completed_jobs || 0;
                const pending = div.pending_jobs || 0;
                const percentage = div.completion_percentage || 0;
                
                // Update card values
                $(`#${divisionName}Total`).text(total);
                $(`#${divisionName}Completed`).text(completed);
                $(`#${divisionName}Pending`).text(pending);
                $(`#${divisionName}Percentage`).text(percentage + '%');
                $(`#${divisionName}Progress`).css('width', percentage + '%');
                
                // Update progress bar color based on percentage
                const progressBar = $(`#${divisionName}Progress`);
                if (percentage >= 80) {
                    progressBar.removeClass('bg-warning bg-danger').addClass('bg-success');
                } else if (percentage >= 50) {
                    progressBar.removeClass('bg-success bg-danger').addClass('bg-warning');
                } else {
                    progressBar.removeClass('bg-success bg-warning').addClass('bg-danger');
                }
            });
        }

        // Render table with data
        function renderTable(data) {
            const tbody = $('#frrvTableBody');
            tbody.empty();

            // Apply filter
            let filteredData = data;
            if (currentFilter !== 'all') {
                filteredData = data.filter(d => d.completion_status === currentFilter);
            }

            if (!filteredData || filteredData.length === 0) {
                tbody.html(`
                    <tr>
                        <td colspan="8" class="text-center py-4 text-muted">
                            <i class="fas fa-inbox fa-2x mb-2 d-block"></i>
                            No FRRV jobs found
                        </td>
                    </tr>
                `);
                // Initialize DataTable with empty data
                if (dataTable) {
                    dataTable.destroy();
                    dataTable = null;
                }
                return;
            }

            filteredData.forEach(function(item) {
                const statusColor = item.completion_status === 'Fully Completed' ? 'success' :
                                   item.completion_status === 'Partially Completed' ? 'warning' : 'danger';
                
                const statusIcon = item.completion_status === 'Fully Completed' ? 'fa-check-circle' :
                                  item.completion_status === 'Partially Completed' ? 'fa-clock' : 'fa-hourglass-start';

                const row = `
                    <tr>
                        <td>
                            <span class="badge bg-secondary">${item.job_number}</span>
                        </td>
                        <td class="text-center">
                            <span class="status-indicator ${item.smd_completed ? 'completed' : 'pending'}"></span>
                            ${item.smd_completed ? 
                                '<span class="badge bg-success"><i class="fas fa-check"></i></span>' : 
                                '<span class="badge bg-warning"><i class="fas fa-times"></i></span>'}
                        </td>
                        <td class="text-center">
                            <span class="status-indicator ${item.pvlmd_completed ? 'completed' : 'pending'}"></span>
                            ${item.pvlmd_completed ? 
                                '<span class="badge bg-success"><i class="fas fa-check"></i></span>' : 
                                '<span class="badge bg-warning"><i class="fas fa-times"></i></span>'}
                        </td>
                        <td class="text-center">
                            <span class="status-indicator ${item.lrd_completed ? 'completed' : 'pending'}"></span>
                            ${item.lrd_completed ? 
                                '<span class="badge bg-success"><i class="fas fa-check"></i></span>' : 
                                '<span class="badge bg-warning"><i class="fas fa-times"></i></span>'}
                        </td>
                        <td>
                            <div class="d-flex align-items-center">
                                <div class="progress flex-grow-1 me-2 progress-thin" style="width: 100px;">
                                    <div class="progress-bar bg-${statusColor}" 
                                         role="progressbar" 
                                         style="width: ${item.completion_percentage}%;" 
                                         aria-valuenow="${item.completion_percentage}" 
                                         aria-valuemin="0" 
                                         aria-valuemax="100">
                                    </div>
                                </div>
                                <span class="small fw-bold">${item.completion_percentage}%</span>
                            </div>
                        </td>
                        <td>
                            <span class="badge bg-${statusColor} completion-badge">
                                <i class="fas ${statusIcon} me-1"></i>
                                ${item.completion_status}
                            </span>
                        </td>
                        <td>
                            <small class="text-muted">${item.last_updated || 'N/A'}</small>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-info view-details" 
                                    data-job="${item.job_number}"
                                    title="View Details">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="btn btn-sm btn-primary view-progress" 
                                    data-job="${item.job_number}"
                                    title="View Progress">
                                <i class="fas fa-chart-line"></i>
                            </button>
                        </td>
                    </tr>
                `;
                tbody.append(row);
            });

            // Initialize DataTable
            if (dataTable) {
                dataTable.destroy();
            }
            
            dataTable = $('#frrvTable').DataTable({
                pageLength: 10,
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
                responsive: true,
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
                }
            });
        }

        // Filter data by status
        function filterData(status) {
            currentFilter = status;
            
            // Update active state on cards
            $('.stat-card').removeClass('active');
            if (status === 'all') {
                $('.stat-card[data-filter="all"]').addClass('active');
            } else {
                $(`.stat-card[data-filter="${status}"]`).addClass('active');
            }
            
            renderTable(frrvData);
        }

        // View job details
        function viewJobDetails(jobNumber) {
            if (!frrvData || frrvData.length === 0) {
                return;
            }
            
            const job = frrvData.find(d => d.job_number === jobNumber);
            if (!job) return;
            
            const modalHTML = `
                <div class="modal fade" id="jobDetailsModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title">
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
                                                <span class="badge bg-${job.smd_completed ? 'success' : 'warning'} fs-6">
                                                    ${job.smd_completed ? 'Completed' : 'Pending'}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-body text-center">
                                                <h6 class="text-muted">PVLMD</h6>
                                                <span class="badge bg-${job.pvlmd_completed ? 'success' : 'warning'} fs-6">
                                                    ${job.pvlmd_completed ? 'Completed' : 'Pending'}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-body text-center">
                                                <h6 class="text-muted">LRD</h6>
                                                <span class="badge bg-${job.lrd_completed ? 'success' : 'warning'} fs-6">
                                                    ${job.lrd_completed ? 'Completed' : 'Pending'}
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

        // Event handlers
        $(document).ready(function() {
            loadData();

            $('.stat-card').on('click', function() {
                const filter = $(this).data('filter');
                filterData(filter);
            });

            $(document).on('click', '.view-details', function() {
                const jobNumber = $(this).data('job');
                viewJobDetails(jobNumber);
            });

            $(document).on('click', '.view-progress', function() {
                const jobNumber = $(this).data('job');
                window.location.href = 'frrv_progress.jsp?job=' + jobNumber;
            });
        });
    </script>
