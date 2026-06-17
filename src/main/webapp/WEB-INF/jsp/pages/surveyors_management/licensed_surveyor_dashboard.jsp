<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <!-- Breadcrumbs -->
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="index.jsp"><i class="fas fa-home me-1"></i>Licensed Surveyors Dashboard</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">${fullname}</li>
                </ol>
            </nav>

            <!-- Content Row - Statistics Cards -->
            <div class="row g-4 mb-4">
                <!-- Total Licensed Surveyors Card -->
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-primary text-white shadow h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small text-uppercase fw-bold text-white-50">Total Licensed Surveyors</div>
                                    <div class="h3 fw-bold mt-2">${total_surveyors}</div>
                                </div>
                                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                                    <i class="fas fa-users fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Inactive Surveyors Card -->
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-danger text-white shadow h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small text-uppercase fw-bold text-white-50">Inactive Surveyors</div>
                                    <div class="h3 fw-bold mt-2">${inactive_surveyors}</div>
                                </div>
                                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                                    <i class="fas fa-user-slash fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Surveyors Due for Renewal Card -->
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-warning text-dark shadow h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small text-uppercase fw-bold text-dark">Due for Renewal</div>
                                    <div class="h3 fw-bold mt-2">${renewal_due}</div>
                                </div>
                                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                                    <i class="fas fa-exclamation-triangle fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Active Surveyors Card -->
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-success text-white shadow h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small text-uppercase fw-bold text-white-50">Active Surveyors (This Year)</div>
                                    <div class="h3 fw-bold mt-2">0</div>
                                </div>
                                <div class="bg-white bg-opacity-25 rounded-circle p-3">
                                    <i class="fas fa-check-circle fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search and Table Row -->
            <div class="row g-4">
                <div class="col-lg-8">
                    <!-- Search and Action Section -->
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <div class="card card-body bg-light p-3" style="flex: 1;">
                                <label class="col-form-label fw-bold"><i class="fas fa-search me-2"></i>Search Section:</label>
                                <div class="row g-2">
                                    <div class="col-md-4">
                                        <select class="form-select" id="surveyor_select_type">
                                            <option disabled selected value="-1">-- select type --</option>
                                            <option value="License Number">License Number</option>
                                            <option value="Name">Name</option>
                                            <option value="Email">Email</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 d-none" id="div_surveyor_keyword">
                                        <input class="form-control" id="surveyor_keyword" placeholder="Enter keyword..." />
                                    </div>
                                    <div class="col-md-4">
                                        <button class="btn btn-success w-100" id="btn_surveyor_search">
                                            <i class="fas fa-search me-1"></i>Search
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="ms-3">
                                <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#addSurveyor">
                                    <i class="fas fa-plus-circle me-1"></i>Add Surveyor
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover display" id="surveyor_dataTable" width="100%" cellspacing="0">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>License Number</th>
                                            <th>Name</th>
                                            <th>Mobile</th>
                                            <th>Email</th>
                                            <th>Capacity</th>
                                            <th>Level</th>
                                            <th>Jobs Assigned</th>
                                            <th>Outstanding Jobs</th>
                                            <th>Last Job Date</th>
                                            <th>Status</th>
                                            <th>Inception Year</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="surveyor" items="${surveyorList}">
                                            <tr>
                                                <td><span class="badge bg-secondary">${surveyor.licensed_surveyor_number}</span></td>
                                                <td>${surveyor.licensed_surveyor_name}</td>
                                                <td>${surveyor.licensed_surveyor_mobile}</td>
                                                <td>${surveyor.licensed_surveyor_email}</td>
                                                <td><span class="badge bg-info">${surveyor.ls_capacity}</span></td>
                                                <td><span class="badge bg-primary">${surveyor.ls_level}</span></td>
                                                <td>${surveyor.no_of_jobs_assigned}</td>
                                                <td>${surveyor.outstanding_jobs_to_assign}</td>
                                                <td>${surveyor.last_date_job_was_assigned}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${surveyor.licensed_surveyor_status == 'Active'}">
                                                            <span class="badge bg-success">Active</span>
                                                        </c:when>
                                                        <c:when test="${surveyor.licensed_surveyor_status == 'Inactive'}">
                                                            <span class="badge bg-danger">Inactive</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">${surveyor.licensed_surveyor_status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${surveyor.licensed_surveyor_inception_year != null ? surveyor.licensed_surveyor_inception_year : 'N/A'}</td>
                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <button class="btn btn-info btn-sm" 
                                                                data-bs-toggle="modal" 
                                                                data-bs-target="#list_surveyor_determinants_modal" 
                                                                data-target-id="${surveyor.scd_id}"
                                                                title="View Details">
                                                            <i class="fas fa-info-circle"></i>
                                                        </button>
                                                        <button class="btn btn-danger btn-sm" title="Delete">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Panel - Accordion -->
                <div class="col-lg-4">
                    <div class="accordion" id="accordion">
                        <!-- Capacity Assessment Criteria -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingOne">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    <i class="fas fa-calculator me-2"></i>Capacity Assessment Criteria
                                </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordion">
                                <div class="accordion-body">
                                    <div class="d-grid gap-2 mb-3">
                                        <button class="btn btn-primary" onclick="reassessAllSurveyors()">
                                            <i class="fas fa-sync-alt me-1"></i>Re-assess All Surveyors
                                        </button>
                                    </div>
                                    <c:forEach var="item" items="${capacityList}">
                                        <div class="card mb-2">
                                            <div class="card-body py-2">
                                                <strong>${item.cd_deterterminant_factor}</strong><br />
                                                <small class="text-muted">Value: ${item.cd_value} | Min: ${item.min_values}</small>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- License History -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingTwo">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    <i class="fas fa-history me-2"></i>License History
                                </button>
                            </h2>
                            <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordion">
                                <div class="accordion-body">
                                    <div class="row g-2 mb-3">
                                        <div class="col-8">
                                            <input class="form-control form-control-sm" placeholder="Enter License Number" />
                                        </div>
                                        <div class="col-4">
                                            <button class="btn btn-success btn-sm w-100" id="btn_license_search">
                                                <i class="fas fa-search me-1"></i>Search
                                            </button>
                                        </div>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-striped table-sm" id="license_history_table">
                                            <thead>
                                                <tr>
                                                    <th>Action</th>
                                                    <th>Status Change</th>
                                                    <th>Date</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td colspan="3" class="text-center text-muted">No history available</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Reports -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                    <i class="fas fa-file-alt me-2"></i>Reports
                                </button>
                            </h2>
                            <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordion">
                                <div class="accordion-body">
                                    <div class="list-group">
                                        <a href="#" class="list-group-item list-group-item-action">
                                            <i class="fas fa-file-pdf me-2 text-danger"></i>Surveyors Report
                                        </a>
                                        <a href="#" class="list-group-item list-group-item-action">
                                            <i class="fas fa-file-pdf me-2 text-danger"></i>Renewal Report
                                        </a>
                                        <a href="#" class="list-group-item list-group-item-action">
                                            <i class="fas fa-file-excel me-2 text-success"></i>Capacity Assessment Report
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Initialize DataTable
            $('#surveyor_dataTable').DataTable({
                pageLength: 10,
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
                responsive: true,
                columnDefs: [
                    { orderable: false, targets: [11] } // Disable sorting on Action column
                ]
            });

            // Show/hide keyword input based on search type selection
            $('#surveyor_select_type').on('change', function() {
                if ($(this).val() !== '-1') {
                    $('#div_surveyor_keyword').removeClass('d-none');
                } else {
                    $('#div_surveyor_keyword').addClass('d-none');
                }
            });

            // Search button click handler
            $('#btn_surveyor_search').on('click', function() {
                var searchType = $('#surveyor_select_type').val();
                var keyword = $('#surveyor_keyword').val();
                if (searchType && keyword) {
                    // Perform search - you can implement AJAX call here
                    console.log('Searching for ' + searchType + ': ' + keyword);
                    alert('Search functionality: ' + searchType + ' - ' + keyword);
                } else {
                    alert('Please select search type and enter keyword');
                }
            });

            // License search handler
            $('#btn_license_search').on('click', function() {
                var licenseNo = $(this).closest('.row').find('input').val();
                if (licenseNo) {
                    console.log('Searching license: ' + licenseNo);
                    alert('Searching license history for: ' + licenseNo);
                } else {
                    alert('Please enter a license number');
                }
            });

            // Re-assess all surveyors
            window.reassessAllSurveyors = function() {
                if (confirm('Are you sure you want to re-assess all surveyors?')) {
                    console.log('Re-assessing all surveyors...');
                    alert('Re-assessment initiated for all surveyors.');
                }
            };
        });
    </script>
