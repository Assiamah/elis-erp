 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="now" class="java.util.Date" />


           
  <!-- Start::app-content -->
<div class="main-content app-content">
  <div class="container-fluid page-container">

      <!-- Start::page-header -->
      <div class="page-header-breadcrumb mb-3">
          <div class="d-flex align-center justify-content-between flex-wrap">
              <div>
                  <h1 class="page-title fw-medium fs-18 mb-1">Regularization Further Entries</h1>
                  <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Manage and track work requests and applications</p>
              </div>
              <ol class="breadcrumb mb-0">
                  <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Regularization Further Entries</li>
              </ol>
          </div>
      </div>
      <!-- End::page-header -->        

    
    <div class="row">
    <!-- Information Alert -->
    <div class="col-12 mb-4">
        <div class="alert alert-info" role="alert">
            <div class="d-flex">
                <div class="me-3">
                    <i class="fas fa-info-circle fa-2x"></i>
                </div>
                <div>
                    <h5 class="alert-heading mb-1">Please Note</h5>
                    <p class="mb-0">There are <strong>${applicationlistcount}</strong> applications in this console.</p>
                    <c:if test="${applicationlistcount > 20}">
                        <p class="mt-2 mb-0">
                            Only the first <strong class="text-danger">3000 applications</strong> are displayed for immediate action. 
                            As applications are processed and moved out, new ones will be added to the list.
                        </p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Card -->
    <div class="col-12">
        <div class="card shadow border-0">
            <!-- Card Header -->
            <div class="card-header bg-gradient-primary text-white py-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fas fa-tasks fa-lg me-2"></i>
                        <span class="h5 mb-0">Application Dashboard</span>
                    </div>
                    <div>
                   
                        <button class="btn btn-light" id="btnViewBatchlist">
                            <i class="ri-list-check"></i> View Batch List
                        </button>
                      
                      <!-- <c:if test="${division != 'SMD'}">
                        <button class="btn btn-light" id="btnViewRequestlist">
                            <i class="ri-list-check"></i>
                            View Request List
                        </button>
                      </c:if> -->
                    </div>
                </div>
                
                <!-- Stats Cards -->
                <div class="row mt-3 g-2">
                    <div class="col-md-4">
                        <div class="card bg-dark bg-opacity-25 border-0">
                            <div class="card-body py-2">
                                <div class="d-flex align-items-center">
                                    <div class="bg-danger bg-opacity-25 p-2 rounded me-3">
                                        <i class="fas fa-list text-white"></i>
                                    </div>
                                    <div>
                                        <small class="text-white-50">Total Applications</small>
                                        <h5 class="mb-0 text-white">${applicationlistcount}</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Optional: Add more stat cards here -->
                </div>
            </div>

            <!-- Card Body -->
            <div class="card-body p-4">
                <!-- Batch Actions Section -->
             
                    <div class="row d-none" id="allBatchList">
                        <div class="col-xl-3 col-lg-4 col-md-4 col-sm-12">
                            <div class="card card-body">
                                <div class="form-group mb-2">
                                    <label for="">Purpose for Bactching</label>
                                    <input type="text" class="form-control form-control-sm" id="txt_general_job_purpose">
                                </div>
                                <div class="form-group mb-2">
                                    <label for="">Remarks/Notes</label>
                                    <textarea type="text" class="form-control col" id="txt_general_remarks_notes"  value="" placeholder="Remarks/Notes"></textarea>
                                </div>
                                <button class="btn btn-sm w-100 btn-primary"  id="btnAddAlltoBatchlist">Add All to Batch List</button>
                            </div>
                        </div>
                    </div>
                

                 <!-- <c:if test="${division != 'SMD'}">
                    <div class="row d-none" id="allBatchList">
                          <div class="col-xl-3 col-lg-4 col-md-4 col-sm-12">
                              <div class="card card-body">
                                  <div class="form-group mb-2">
                                      <label for="">Purpose for Sending Request</label>
                                      <input type="text" class="form-control form-control-sm bg-light" value="Further Entries" readonly id="txt_general_job_purpose" style="cursor: not-allowed">
                                  </div>
                                  <div class="form-group mb-2">
                                      <label for="">Remarks/Notes</label>
                                      <textarea type="text" class="form-control col" id="txt_general_remarks_notes"  value="" placeholder="Remarks/Notes"></textarea>
                                  </div>
                                  <button class="btn btn-sm w-100 btn-primary"  id="btnAddAlltoRequestlist">Add All to Request List</button>
                              </div>
                          </div>
                      </div>

                 </c:if> -->

                <!-- Applications Table -->
                <div class="table-responsive">
                    <table class="table table-hover align-middle" id="job_casemgtdetailsdataTable">
                        <thead class="table-light">
                            <tr>
                                <th width="40">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="selectAll">
                                    </div>
                                </th>
                                <th>Created Date</th>
                                <th>Job Number</th>
                                <th>Applicant Name</th>
                                <th>Application Type</th>
                                <th>Status</th>
                                <th>Age</th>
                                <th width="120">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${applicationlist}" var="appfiles">
                                <tr class="${appfiles.objections > 0 ? 'table-danger' : ''}" 
                                    ${appfiles.objections > 0 ? 'data-bs-toggle="tooltip" title="Application has pending Objections"' : ''}>
                                    
                                    <!-- Checkbox -->
                                    <td>
                                        <div class="form-check">
                                            <input class="form-check-input row-checkbox" type="checkbox">
                                        </div>
                                    </td>
                                    
                                    <!-- Created Date -->
                                    <td>
                                      <fmt:parseDate value="${appfiles.created_date}" pattern="yyyy-MM-dd" var="parsedCreatedDate"/>
                                      <fmt:formatDate value="${parsedCreatedDate}" pattern="dd MMM yyyy" var="formattedParsedCreatedDate"/>
                                      <small class="text-muted">${formattedParsedCreatedDate}</small>
                                    </td>
                                    
                                    <!-- Job Number -->
                                    <td>
                                        <span class="fw-bold text-primary">${appfiles.job_number}</span>
                                    </td>
                                    
                                    <!-- Applicant Name -->
                                    <td>
                                        <div class="text-truncate" style="max-width: 150px;" 
                                             data-bs-toggle="tooltip" title="${appfiles.ar_name}">
                                            ${appfiles.ar_name}
                                        </div>
                                    </td>
                                    
                                    <!-- Application Type -->
                                    <td>
                                        <span class="">
                                            ${appfiles.business_process_sub_name}
                                        </span>
                                    </td>
                                    
                                    <!-- Status -->
                                    <td>
                                        <div class="text-truncate" style="max-width: 200px;"
                                             data-bs-toggle="tooltip" title="${appfiles.current_application_status}">
                                            ${appfiles.current_application_status}
                                        </div>
                                    </td>
                                    
                                    <!-- Age -->
                                    <td>
                                        <span class="badge ${appfiles.age_of_application > '7' ? 'bg-warning' : 'bg-danger'}">
                                            ${appfiles.age_of_application} days
                                        </span>
                                    </td>
                                    
                                   
                                    <td>
                                      <div class="d-flex justify-content-center align-items-center gap-2">
                                      
                                          <!-- View Details -->
                                          
                                          <form action="front_office_view_application" method="post" class="d-inline">
                                              <input type="hidden" name="case_number" value="${appfiles.transaction_number}">
                                              <input type="hidden" name="job_number" value="${appfiles.job_number}">
                                              <input type="hidden" name="search_text" value="${appfiles.case_number}">
                                              <input type="hidden" name="business_process_sub_name" value="${appfiles.business_process_sub_name}">
                                              
                                              <button type="submit" class="btn btn-outline-primary btn-sm w-100">
                                                  <i class="fas fa-eye me-1"></i> View
                                              </button>
                                          </form>
                                          
                                          
                                          <!-- Further Entries -->

                                           <!-- <form action="request_application_progress_details_ai" method="post" class="d-inline">
                                                <input type="hidden" name="case_number" value="${appfiles.case_number}">
                                                <input type="hidden" name="transaction_number" value="${appfiles.transaction_number}">
                                                <input type="hidden" name="job_number" value="${appfiles.job_number}">
                                                <input type="hidden" name="business_process_sub_name" value="${appfiles.business_process_sub_name}">
                                                <input type="hidden" name="review_type" value="${appfiles.request_category}">
                                                <input type="hidden" name="rq_id" value="${appfiles.rq_id}">
                                                <button type="submit" class="btn btn-outline-warning btn-sm w-100">
                                                    <i class="fas fa-edit me-1"></i> Request
                                                </button>
                                            </form> -->


                                           
                                              <button class="btn btn-outline-info btn-sm w-100"
                                                      data-bs-toggle="modal" 
                                                      data-bs-target="#askForPurposeOfBatching"
                                                      data-job_number="${appfiles.job_number}"
                                                      data-ar_name="${appfiles.ar_name}"
                                                      data-business_process_sub_name="${appfiles.business_process_sub_name}">
                                                  <i class="fas fa-plus me-1"></i> Add To Batch
                                              </button>
                                            

                                            <!-- <c:if test="${division != 'SMD'}">
                                              <button class="btn btn-sm btn-outline-danger w-100" data-job_number="${appfiles.job_number}" data-ar_name="${appfiles.ar_name}" data-business_process_sub_name="${appfiles.business_process_sub_name}" data-locality="undefined" id="btnGeneralWorkRequest">
                                                <i class="bi bi-send"></i>
                                                Send Request
                                            </button>
                                            </c:if> -->
                                      
                                          <!-- <div class="dropdown">
                                              <button class="btn btn-outline-danger btn-sm dropdown-toggle w-100" 
                                                      type="button" data-bs-toggle="dropdown">
                                                  <i class="fas fa-pen me-1"></i> Actions
                                              </button>
                                              <ul class="dropdown-menu">
                                                  <li>
                                                      <form action="further_entries" method="post" class="d-inline">
                                                          <input type="hidden" name="transaction_number" value="${appfiles.transaction_number}">
                                                          <input type="hidden" name="job_number" value="${appfiles.job_number}">
                                                          <input type="hidden" name="case_number" value="${appfiles.case_number}">
                                                          <input type="hidden" name="business_process_sub_name" value="${appfiles.business_process_sub_name}">
                                                          
                                                          <button type="submit" class="dropdown-item">
                                                              <i class="fas fa-pen text-danger me-2"></i> Further Entries
                                                          </button>
                                                      </form>
                                                  </li>
                                                  <c:choose>
                                                      <c:when test="${appfiles.business_process_sub_name == 'APPLICATION FOR FIRST REGISTRATION' || 
                                                                      appfiles.business_process_sub_name == 'APPLICATION FOR PART TRANSFER' || 
                                                                      appfiles.business_process_sub_name == 'APPLICATION FOR WHOLE TRANFER'}">
                                                          <li>
                                                              <form action="request_application_progress_details" method="post">
                                                                  <input type="hidden" name="case_number" value="">
                                                                  <input type="hidden" name="transaction_number" value="">
                                                                  <input type="hidden" name="job_number" value="${appfiles.job_number}">
                                                                  <input type="hidden" name="job_purpose" value="Noting of parcels">
                                                                  <input type="hidden" name="business_process_sub_name" value="${appfiles.business_process_sub_name}">
                                                                  
                                                                  <button type="submit" class="dropdown-item">
                                                                      <i class="fas fa-edit text-warning me-2"></i> Coordinate Entry
                                                                  </button>
                                                              </form>
                                                          </li>
                                                      </c:when>
                                                  </c:choose>
                                              </ul>
                                          </div> -->
                                      </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Card Footer -->
            <!-- <div class="card-footer bg-light py-3">
                <div class="d-flex justify-content-between align-items-center">
                    <small class="text-muted">
                        Showing <strong>${applicationlist.size()}</strong> of <strong>${applicationlistcount}</strong> applications
                    </small>
                    <div>
                        <c:if test="${applicationlistcount > 3000}">
                            <span class="badge bg-warning text-dark">
                                <i class="fas fa-exclamation-triangle me-1"></i> Displaying first 3000 records only
                            </span>
                        </c:if>
                    </div>
                </div>
            </div> -->
        </div>
    </div>
</div>

  </div>
</div>

<!-- CSS for custom styling -->
<style>
    .border-dashed {
        border: 2px dashed #dee2e6;
    }
    .bg-gradient-primary {
        background: linear-gradient(135deg,  rgb(9 ,124, 103) 0%, rgb(9 ,124, 103) 100%);
    }
    .table-hover tbody tr:hover {
        background-color: rgba(0, 123, 255, 0.05);
    }
    .table > :not(:first-child) {
        border-top: 2px solid #dee2e6;
    }
</style>