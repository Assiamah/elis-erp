<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">
                        <i class="ri-file-code-fill text-warning me-1"></i>Manage Application Steps
                    </h1>
                    <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>View, manage and remove duplicate steps from job applications</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Manage Application Steps</li>
                </ol>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left Column - Step Management -->
            <div class="col-lg-8">
                <!-- Search Section -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4">
                            <div class="flex-shrink-0">
                                <div class="icon-circle bg-primary bg-opacity-10 rounded p-2">
                                    <i class="bi bi-search text-primary fs-4"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="mb-1 fw-semibold">Search Application</h5>
                                <p class="text-muted small mb-0">Enter job number and select workflow type</p>
                            </div>
                        </div>

                        <!-- Search Form -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-5">
                                <label class="form-label fw-semibold small">
                                    <i class="bi bi-hash me-1"></i>Job Number
                                </label>
                                <input type="text" 
                                    class="form-control" 
                                    id="jobNumberSearch" 
                                    placeholder="Enter Job Number"
                                    value="">
                            </div>
                            <div class="col-md-5">
                                <label class="form-label fw-semibold small">
                                    <i class="bi bi-diagram-3 me-1"></i>Workflow Type
                                </label>
                                <select class="form-select" id="workflowType">
                                    <option value="">Select Workflow Type</option>
                                    <option value="main_application_workflow">Main Application Workflow</option>
                                    <option value="general_request_workflow">General Request Workflow</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-semibold small">&nbsp;</label>
                                <button class="btn btn-primary w-100" id="searchButton">
                                    <i class="bi bi-search me-2"></i>Load
                                </button>
                            </div>
                        </div>

                        <div class="alert alert-info alert-sm mb-0">
                            <i class="bi bi-info-circle me-2"></i>
                            <small>This tool helps identify and remove duplicate steps in the application workflow.</small>
                        </div>
                    </div>
                </div>

                <!-- Tabs for Tables -->
                <div class="card border-0 shadow-sm" id="resultsCard" style="display: none;">
                    <div class="card-header bg-white border-bottom p-0">
                        <ul class="nav nav-tabs card-header-tabs" id="stepTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="milestones-tab" data-bs-toggle="tab" 
                                        data-bs-target="#milestones" type="button" role="tab">
                                    <i class="bi bi-check2-circle me-2"></i>
                                    Milestone Steps
                                    <span class="badge bg-primary ms-2" id="milestoneCount">0</span>
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="babysteps-tab" data-bs-toggle="tab" 
                                        data-bs-target="#babysteps" type="button" role="tab">
                                    <i class="bi bi-grid-3x3-gap me-2"></i>
                                    Baby Steps
                                    <span class="badge bg-info ms-2" id="babystepCount">0</span>
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="card-body p-0">
                        <div class="tab-content" id="stepTabsContent">
                            <!-- Milestones Tab -->
                            <div class="tab-pane fade show active" id="milestones" role="tabpanel">
                                <div class="p-3">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <div>
                                            <h6 class="mb-1">Milestone Steps</h6>
                                            <small class="text-muted" id="milestoneStats"></small>
                                        </div>
                                        <button class="btn btn-danger btn-sm" id="removeDuplicateMilestonesBtn" style="display: none;">
                                            <i class="bi bi-trash3 me-1"></i>
                                            Remove Duplicates
                                        </button>
                                    </div>
                                    <div class="table-responsive" style="max-height: 500px; overflow-y: auto;">
                                        <table class="table table-hover table-sm" id="milestonesTable">
                                            <thead class="table-light sticky-top">
                                                <tr>
                                                    <th width="40">
                                                        <input type="checkbox" id="selectAllMilestones">
                                                    </th>
                                                    <th>ID</th>
                                                    <th>Description</th>
                                                    <th>Status</th>
                                                    <th>Priority</th>
                                                    <th>Days Required</th>
                                                    <th>Created Date</th>
                                                </tr>
                                            </thead>
                                            <tbody id="milestonesTableBody">
                                                <tr>
                                                    <td colspan="7" class="text-center text-muted">No data loaded</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Baby Steps Tab -->
                            <div class="tab-pane fade" id="babysteps" role="tabpanel">
                                <div class="p-3">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <div>
                                            <h6 class="mb-1">Baby Steps</h6>
                                            <small class="text-muted" id="babystepStats"></small>
                                        </div>
                                        <button class="btn btn-danger btn-sm" id="removeDuplicateBabystepsBtn" style="display: none;">
                                            <i class="bi bi-trash3 me-1"></i>
                                            Remove Duplicates
                                        </button>
                                    </div>
                                    <div class="table-responsive" style="max-height: 500px; overflow-y: auto;">
                                        <table class="table table-hover table-sm" id="babystepsTable">
                                            <thead class="table-light sticky-top">
                                                <tr>
                                                    <th width="40">
                                                        <input type="checkbox" id="selectAllBabysteps">
                                                    </th>
                                                    <th>ID</th>
                                                    <th>Description</th>
                                                    <th>Status</th>
                                                    <th>Priority</th>
                                                    <th>Days Required</th>
                                                    <th>Completed By</th>
                                                </tr>
                                            </thead>
                                            <tbody id="babystepsTableBody">
                                                <tr>
                                                    <td colspan="7" class="text-center text-muted">No data loaded</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Loading Indicator -->
                <div id="loadingIndicator" style="display: none;" class="text-center py-5">
                    <div class="spinner-border text-primary mb-3" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <h6 class="text-muted">Loading application steps...</h6>
                    <p class="text-muted small">Fetching milestone and baby step data</p>
                </div>

                <!-- No Results Message -->
                <div id="noResults" style="display: none;" class="text-center py-5">
                    <div class="mb-3">
                        <i class="bi bi-database-slash text-muted" style="font-size: 3rem;"></i>
                    </div>
                    <h6 class="text-muted mb-2">No Application Found</h6>
                    <p class="text-muted small mb-3">No records found for the provided job number and workflow type</p>
                    <button class="btn btn-outline-primary btn-sm" onclick="resetSearch()">
                        <i class="bi bi-search me-1"></i>Try Again
                    </button>
                </div>
            </div>

            <!-- Right Column - Instructions & Info Panel -->
            <div class="col-lg-4">
                <!-- Instructions Card -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-white border-0 pt-4 px-4">
                        <h5 class="mb-1 fw-semibold">
                            <i class="bi bi-info-circle-fill text-primary me-2"></i>
                            How to Remove Duplicates
                        </h5>
                    </div>
                    <div class="card-body px-4">
                        <div class="mb-4">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                    <span class="fw-bold text-primary">1</span>
                                </div>
                                <div>
                                    <h6 class="mb-0">Search Application</h6>
                                    <small class="text-muted">Enter job number and select workflow type</small>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                    <span class="fw-bold text-primary">2</span>
                                </div>
                                <div>
                                    <h6 class="mb-0">Identify Duplicates</h6>
                                    <small class="text-muted">Duplicate steps are highlighted in yellow</small>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                    <span class="fw-bold text-primary">3</span>
                                </div>
                                <div>
                                    <h6 class="mb-0">Select & Remove</h6>
                                    <small class="text-muted">Check boxes and click remove duplicates</small>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                    <span class="fw-bold text-primary">4</span>
                                </div>
                                <div>
                                    <h6 class="mb-0">Confirm Action</h6>
                                    <small class="text-muted">Review and confirm deletion</small>
                                </div>
                            </div>
                        </div>

                        <div class="alert alert-warning alert-sm">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <small><strong>Note:</strong> Removing steps is permanent. Please ensure you're removing the correct duplicate entries.</small>
                        </div>
                    </div>
                </div>

                <!-- Duplicate Detection Info -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white border-0 pt-4 px-4">
                        <h5 class="mb-0 fw-semibold">
                            <i class="bi bi-diagram-3 text-primary me-2"></i>
                            Duplicate Detection Rules
                        </h5>
                    </div>
                    <div class="card-body px-4">
                        <div class="mb-3">
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-tag text-primary me-2"></i>
                                <span class="fw-semibold small">Milestone Steps</span>
                            </div>
                            <p class="text-muted small ms-4">Duplicate if same <code>milestone_description</code> and <code>workflow_type</code></p>
                        </div>
                        <div>
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-tag text-info me-2"></i>
                                <span class="fw-semibold small">Baby Steps</span>
                            </div>
                            <p class="text-muted small ms-4">Duplicate if same <code>bse_description_key</code> and <code>workflow_type</code></p>
                        </div>
                        <hr>
                        <div class="small text-muted">
                            <i class="bi bi-palette me-1"></i>
                            <span class="badge bg-warning bg-opacity-25 text-dark me-1">Yellow highlight</span> = Duplicate entry
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    let currentData = {
        jobNumber: null,
        workflowType: null,
        milestones: [],
        babysteps: []
    };

    $(document).ready(function() {
        // Search button click
        $('#searchButton').on('click', function() {
            const jobNumber = $('#jobNumberSearch').val().trim();
            const workflowType = $('#workflowType').val();
            
            if (!jobNumber || jobNumber.length < 6) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Invalid Input',
                    text: 'Please enter a valid job number (minimum 6 characters)',
                    confirmButtonColor: '#667eea'
                });
                return;
            }
            
            if (!workflowType) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Select Workflow Type',
                    text: 'Please select a workflow type',
                    confirmButtonColor: '#667eea'
                });
                return;
            }
            
            loadApplicationSteps(jobNumber, workflowType);
        });

        // Select all checkboxes
        $('#selectAllMilestones').on('change', function() {
            $('.milestone-checkbox').prop('checked', $(this).is(':checked'));
            updateRemoveButtonVisibility();
        });
        
        $('#selectAllBabysteps').on('change', function() {
            $('.babystep-checkbox').prop('checked', $(this).is(':checked'));
            updateRemoveButtonVisibility();
        });

        // Remove duplicates buttons
        $('#removeDuplicateMilestonesBtn').on('click', function() {
            removeSelectedSteps('milestones');
        });
        
        $('#removeDuplicateBabystepsBtn').on('click', function() {
            removeSelectedSteps('babysteps');
        });
    });

    function loadApplicationSteps(jobNumber, workflowType) {
        $('#loadingIndicator').show();
        $('#resultsCard').hide();
        $('#noResults').hide();
        
        // Simulate AJAX call - Replace with your actual servlet URL
        setTimeout(function() {
            $.ajax({
                type: "POST",
                url: "Case_Management_Serv",
                data: {
                    request_type: 'get_application_steps',
                    job_number: jobNumber,
                    workflow_type: workflowType
                },
                dataType: 'json',
                success: function(response) {
                    //console.log(response);
                    $('#loadingIndicator').hide();
                    
                    if (response && response.success) {
                        currentData = {
                            jobNumber: jobNumber,
                            workflowType: workflowType,
                            milestones: response.milestones || [],
                            babysteps: response.babysteps || []
                        };
                        
                        displayMilestones(currentData.milestones);
                        displayBabysteps(currentData.babysteps);
                        
                        $('#resultsCard').show();
                        
                        Swal.fire({
                            icon: 'success',
                            title: 'Data Loaded',
                            text: `Found ${currentData.milestones.length} milestones and ${currentData.babysteps.length} baby steps`,
                            timer: 2000,
                            showConfirmButton: false
                        });
                    } else {
                        $('#noResults').show();
                    }
                },
                error: function(xhr, status, error) {
                    $('#loadingIndicator').hide();
                    $('#noResults').show();
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to load application steps',
                        confirmButtonColor: '#667eea'
                    });
                    console.error('Error:', error);
                }
            });
        }, 500);
    }

    function displayMilestones(milestones) {
        const tbody = $('#milestonesTableBody');
        const duplicateMap = new Map();
        
        // Find duplicates based on milestone_description
        milestones.forEach((milestone, index) => {
            const key = milestone.milestone_description;
            if (!duplicateMap.has(key)) {
                duplicateMap.set(key, []);
            }
            duplicateMap.get(key).push(index);
        });
        
        // Mark duplicates (keep first, mark others)
        const isDuplicate = new Array(milestones.length).fill(false);
        duplicateMap.forEach((indices) => {
            if (indices.length > 1) {
                for (let i = 1; i < indices.length; i++) {
                    isDuplicate[indices[i]] = true;
                }
            }
        });
        
        tbody.empty();
        
        if (milestones.length === 0) {
            tbody.html('<tr><td colspan="7" class="text-center text-muted">No milestone steps found</td></tr>');
            $('#milestoneCount').text('0');
            $('#milestoneStats').text('0 total steps');
            return;
        }
        
        milestones.forEach((milestone, index) => {
            const rowClass = isDuplicate[index] ? 'table-warning' : '';
            const row = '<tr class="' + rowClass + '">' +
                '<td>' +
                    '<input type="checkbox" class="milestone-checkbox" data-id="' + milestone.ms_id + '" data-description="' + milestone.milestone_description + '">' +
                '</td>' +
                '<td>' + milestone.ms_id + '</td>' +
                '<td>' + escapeHtml(milestone.milestone_description || '-') + '</td>' +
                '<td><span class="badge ' + getStatusBadgeClass(milestone.mile_stone_status) + '">' + (milestone.mile_stone_status || 'Pending') + '</span></td>' +
                '<td>' + (milestone.priority_value || 0) + '</td>' +
                '<td>' + (milestone.working_day_required || '-') + '</td>' +
                '<td>' + formatDate(milestone.start_date) + '</td>' +
            '</tr>';
            tbody.append(row);
        });
        
        const duplicateCount = isDuplicate.filter(d => d).length;
        $('#milestoneCount').text(milestones.length);
        $('#milestoneStats').text(`${milestones.length} total steps (${duplicateCount} duplicates found)`);
        
        // Show remove button if duplicates exist
        if (duplicateCount > 0) {
            $('#removeDuplicateMilestonesBtn').show();
        } else {
            $('#removeDuplicateMilestonesBtn').hide();
        }
    }

    function displayBabysteps(babysteps) {
        const tbody = $('#babystepsTableBody');
        const duplicateMap = new Map();
        
        // Find duplicates based on bse_description_key
        babysteps.forEach((step, index) => {
            const key = step.bse_description_key;
            if (!duplicateMap.has(key)) {
                duplicateMap.set(key, []);
            }
            duplicateMap.get(key).push(index);
        });
        
        // Mark duplicates (keep first, mark others)
        const isDuplicate = new Array(babysteps.length).fill(false);
        duplicateMap.forEach((indices) => {
            if (indices.length > 1) {
                for (let i = 1; i < indices.length; i++) {
                    isDuplicate[indices[i]] = true;
                }
            }
        });
        
        tbody.empty();
        
        if (babysteps.length === 0) {
            tbody.html('<tr><td colspan="7" class="text-center text-muted">No baby steps found</td></tr>');
            $('#babystepCount').text('0');
            $('#babystepStats').text('0 total steps');
            return;
        }
        
        babysteps.forEach((step, index) => {
            const rowClass = isDuplicate[index] ? 'table-warning' : '';
            const row = '<tr class="' + rowClass + '">' +
                '<td>' +
                    '<input type="checkbox" class="babystep-checkbox" data-id="' + step.bse_id + '" data-description="' + step.bse_description_key + '">' +
                '</td>' +
                '<td>' + step.bse_id + '</td>' +
                '<td>' + escapeHtml(step.bse_description || step.bse_description_key || '-') + '</td>' +
                '<td><span class="badge ' + getStatusBadgeClass(step.bse_status) + '">' + (step.bse_status || 'Pending') + '</span></td>' +
                '<td>' + (step.bse_priority_value || 0) + '</td>' +
                '<td>' + (step.bse_working_day_required || '-') + '</td>' +
                '<td>' + (step.completed_by || '-') + '</td>' +
            '</tr>';
            tbody.append(row);
        });
        
        const duplicateCount = isDuplicate.filter(d => d).length;
        $('#babystepCount').text(babysteps.length);
        $('#babystepStats').text(`${babysteps.length} total steps (${duplicateCount} duplicates found)`);
        
        if (duplicateCount > 0) {
            $('#removeDuplicateBabystepsBtn').show();
        } else {
            $('#removeDuplicateBabystepsBtn').hide();
        }
    }

    function removeSelectedSteps(type) {
        let selectedIds = [];
        
        if (type === 'milestones') {
            $('.milestone-checkbox:checked').each(function() {
                selectedIds.push($(this).data('id'));
            });
        } else {
            $('.babystep-checkbox:checked').each(function() {
                selectedIds.push($(this).data('id'));
            });
        }
        
        if (selectedIds.length === 0) {
            Swal.fire({
                icon: 'warning',
                title: 'No Selection',
                text: 'Please select at least one step to remove',
                confirmButtonColor: '#667eea'
            });
            return;
        }
        
        Swal.fire({
            title: 'Confirm Removal',
            text: `Are you sure you want to remove ${selectedIds.length} step(s)? This action cannot be undone.`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, remove them!'
        }).then((result) => {
            if (result.isConfirmed) {
                performRemoval(type, selectedIds);
            }
        });
    }

    function performRemoval(type, ids) {
        $('#loadingIndicator').show();
        
        $.ajax({
            type: "POST",
            url: "Case_Management_Serv",
            data: {
                request_type: 'remove_application_steps',
                step_type: type,
                step_ids: JSON.stringify(ids),
                job_number: currentData.jobNumber,
                workflow_type: currentData.workflowType
            },
            dataType: 'json',
            success: function(response) {
                console.log(response);
                $('#loadingIndicator').hide();
                
                if (response && response.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Removed Successfully',
                        text: `${ids.length} step(s) have been removed`,
                        confirmButtonColor: '#667eea'
                    });
                    
                    // Reload the data
                    loadApplicationSteps(currentData.jobNumber, currentData.workflowType);
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Removal Failed',
                        text: response.message || 'Failed to remove steps',
                        confirmButtonColor: '#667eea'
                    });
                }
            },
            error: function() {
                $('#loadingIndicator').hide();
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Failed to communicate with server',
                    confirmButtonColor: '#667eea'
                });
            }
        });
    }

    function updateRemoveButtonVisibility() {
        const anyMilestoneChecked = $('.milestone-checkbox:checked').length > 0;
        const anyBabystepChecked = $('.babystep-checkbox:checked').length > 0;
        
        if ($('#milestones-tab').hasClass('active')) {
            $('#removeDuplicateMilestonesBtn').prop('disabled', !anyMilestoneChecked);
        } else {
            $('#removeDuplicateBabystepsBtn').prop('disabled', !anyBabystepChecked);
        }
    }
    
    $(document).on('change', '.milestone-checkbox, .babystep-checkbox', function() {
        updateRemoveButtonVisibility();
    });

    function getStatusBadgeClass(status) {
        if (!status) return 'bg-secondary';
        const s = status.toLowerCase();
        if (s === 'completed' || s === 'done') return 'bg-success';
        if (s === 'in progress' || s === 'pending') return 'bg-warning';
        if (s === 'cancelled' || s === 'rejected') return 'bg-danger';
        return 'bg-info';
    }

    function formatDate(dateString) {
        if (!dateString) return '-';
        try {
            const date = new Date(dateString);
            return date.toLocaleDateString();
        } catch(e) {
            return '-';
        }
    }

    function escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    function resetSearch() {
        $('#jobNumberSearch').val('');
        $('#workflowType').val('');
        $('#resultsCard').hide();
        $('#noResults').hide();
        $('#jobNumberSearch').focus();
    }
</script>

<style>
    .table-warning {
        background-color: #fff3cd !important;
    }
    .sticky-top {
        position: sticky;
        top: 0;
        z-index: 10;
    }
    .btn:disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }
    .table-responsive::-webkit-scrollbar {
        width: 8px;
        height: 8px;
    }
    .table-responsive::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 4px;
    }
    .table-responsive::-webkit-scrollbar-thumb {
        background: #888;
        border-radius: 4px;
    }
    .table-responsive::-webkit-scrollbar-thumb:hover {
        background: #555;
    }
</style>