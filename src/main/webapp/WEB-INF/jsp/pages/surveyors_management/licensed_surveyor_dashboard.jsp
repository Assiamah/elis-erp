
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<jsp:include page="../includes/_header.jsp"></jsp:include>



<div class="container-fluid">
    <!-- Breadcrumbs -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <a href="index.jsp">Licensed Surveyors Dashboard</a>
        </li>
        <li class="breadcrumb-item active">${fullname}</li>
    </ol>

    <!-- Content Row -->
    <div class="row">
        <!-- Total Licensed Surveyors Card -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card bg-gradient-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Total Licensed Surveyors</div>
                            <div class="h5 mb-0 font-weight-bold text-white mt-2">${total_surveyors}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-users fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Inactive Surveyors Card -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card bg-gradient-danger shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Inactive Surveyors</div>
                            <div class="h5 mb-0 font-weight-bold text-white mt-2">${inactive_surveyors}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-user-slash fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Surveyors Due for Renewal Card -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card bg-gradient-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Due for Renewal</div>
                            <div class="h5 mb-0 font-weight-bold text-white mt-2">${renewal_due}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-exclamation-triangle fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Active Surveyors Card -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card bg-gradient-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-white text-uppercase mb-1">Active Surveyors (This Year)</div>
                            <div class="h5 mb-0 mr-3 font-weight-bold text-white">0</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-check-circle fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Search and Table Row -->
    <div class="row mt-4">
        <div class="col-lg-8">
            <!-- Search and Action Section -->
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <div class="card card-body col-5 p-3">
                        <label class="col-form-label">Search Section:</label>
                        <div class="form-row">
                            <select class="form-control" id="surveyor_select_type">
                                <option disabled selected value="-1">-- select type --</option>
                                <option value="License Number">License Number</option>
                                <option value="Name">Name</option>
                                <option value="Email">Email</option>
                            </select>
                        </div>
                        <div class="form-row mt-2 d-none" id="div_surveyor_keyword">
                            <input class="form-control" id="surveyor_keyword" placeholder="Enter keyword..."/>
                        </div>
                        <button class="btn btn-success btn-sm w-100 mt-3" id="btn_surveyor_search">
                            <i class="fas fa-search mr-1"></i>Search
                        </button>
                    </div>
                    <div>
                        <button class="btn btn-warning" data-toggle="modal" data-target="#addSurveyor">
                            <i class="fas fa-plus-circle mr-1"></i>Add Surveyor
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
    <table class="table table-bordered table-hover display" id="surveyor_dataTable" width="100%" cellspacing="0">
        <thead>
            <tr>
                <th>License Number</th>
                <th>Name</th>
                <th>Mobile</th>
                <th>Email</th>
                <th>Capacity</th>
                <th>Level</th>
                <th>No of Jobs Assigned</th>
                <th>Outstanding Jobs to Assign</th>
                <th>Last Date Job was Assigned</th>
                <th>Status</th>
                <th>Inception Year</th>
               
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="surveyor" items="${surveyorList}">
            <tr>
                <td>${surveyor.licensed_surveyor_number}</td>
                <td>${surveyor.licensed_surveyor_name}</td>
                <td>${surveyor.licensed_surveyor_mobile}</td>
                <td>${surveyor.licensed_surveyor_email}</td>
                <td>${surveyor.ls_capacity}</td>
                <td>${surveyor.ls_level}</td>
                <td>${surveyor.no_of_jobs_assigned}</td>
                <td>${surveyor.outstanding_jobs_to_assign}</td>
                <td>${surveyor.last_date_job_was_assigned}</td>
                <td>${surveyor.licensed_surveyor_status != null ? surveyor.licensed_surveyor_status : 'N/A'}</td>
                <td>${surveyor.licensed_surveyor_inception_year != null ? surveyor.licensed_surveyor_inception_year : 'N/A'}</td>
                <td>
                    <p data-placement="top" data-toggle="tooltip" title="Details">
                        <button class="btn btn-info btn-icon-split" 
                                data-toggle="modal" 
                                data-target="#list_surveyor_determinants_modal" 
                                data-target-id="${surveyor.scd_id}">
                            <span class="icon text-white-50">
                                <i class="fas fa-info-circle"></i>
                            </span>
                           
                        </button>
                        
                    </p>
                    <button class="btn btn-sm btn-danger">Delete</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
    </table>
</div>
                </div>
            </div>
        </div>

        <!-- Right Panel (Accordion) -->
        <div class="col-lg-4">
            <div id="accordion">
                <div class="card">
                   <div class="card-header" id="headingOne">
                        <h5 class="mb-0 d-flex justify-content-between align-items-center">
                            <button class="btn btn-link text-secondary" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                <i class="fa fa-calculator"></i> Capacity Assessment Criteria
                            </button>
                            <button class="btn btn-primary btn-icon-split" onclick="reassessAllSurveyors()">
                                <span class="icon text-white-50"><i class="fas fa-sync-alt"></i></span>
                                <span class="text">Re-assess All Surveyors</span>
                            </button>
                        </h5>

                        <div id="collapseOne" class="collapse show" aria-labelledby="headingOne">
                            <div class="card-body">
                                <c:forEach var="item" items="${capacityList}">
                                    <div class="mb-3">
                                        <strong>${item.cd_deterterminant_factor}</strong><br>
                                        Value: ${item.cd_value} | Min: ${item.min_values}
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                        <div class="card-body">
                            <!-- Add renewal calculator content here -->
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header" id="headingTwo">
                        <h5 class="mb-0">
                            <button class="btn btn-link text-secondary collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                <i class="fas fa-info-circle"></i>License History
                            </button>
                        </h5>
                    </div>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-8">
                                    <input class="form-control form-control-sm" placeholder="Enter License Number"/>
                                </div>
                                <div class="col-4">
                                    <button class="btn btn-success btn-sm w-100" id="btn_license_search">
                                        <i class="fas fa-search"></i>Search
                                    </button>
                                </div>
                            </div>
                            <div class="card card-body mt-2">
                                <div class="table-responsive small">
                                    <table class="table table-striped table-bordered table-hover" id="license_history_table" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Action</th>
                                                <th>Status Change</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header" id="headingThree">
                        <h5 class="mb-0">
                            <button class="btn btn-link text-secondary collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                <i class="fas fa-file-alt"></i>Reports
                            </button>
                        </h5>
                    </div>
                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                        <div class="card-body">
                            <!-- Add reports content here -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


 
	<jsp:include page="../includes/_footer.jsp"></jsp:include>

   