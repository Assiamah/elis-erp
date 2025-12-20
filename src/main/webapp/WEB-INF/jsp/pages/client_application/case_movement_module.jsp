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
                <h1 class="page-title fw-medium fs-18 mb-1">Staff Case Management</h1>
                <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Manage and monitor application workflows</p>
              </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Staff Case Management</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

            <!-- Start::row-1 -->
            <div class="row">
                <div class="col-xl-3">
                    <!-- <div class="card border-0 shadow-sm">
                      <div class="card-body">
                          <div class="">
                              <div>
                                  <h5 class="card-title mb-1">Quick Actions</h5>
                                  <p class="card-text text-muted small mb-0">Manage your application workflow</p>
                              </div>
                              <div class="d-flex flex-wrap gap-2">
                                  <button class="btn btn-success w-100" id="btnViewCompetedQueriedList">
                                      <i class="fas fa-eye me-2"></i>
                                      View Completed/Queried
                                  </button>
                                  
                                  <button class="btn btn-danger w-100" data-bs-toggle="modal" data-bs-target="#appsPassedDueModal">
                                      <i class="fas fa-exclamation-triangle me-2"></i>
                                      Overdue Applications
                                  </button>
                                  
                                  <button class="btn btn-warning w-100" id="btnViewRequestAppList">
                                      <i class="fas fa-clock me-2"></i>
                                      Request Applications 
                                      <span class="badge bg-danger ms-2">${applicationCount}</span>
                                  </button>
                                  
                                  
                              </div>
                          </div>
                      </div>
                  </div> -->
                  <div class="card custom-card bg-info-transparent border-0 shadow-none">
                      <div class="card-body">
                          <div class="d-flex align-items-start gap-3 flex-wrap">
                              <div class="lh-1">
                                  <span class="avatar avatar-lg avatar-rounded bg-info svg-white">
                                      <i class="ri-download-2-line fs-5"></i>
                                  </span>
                              </div>
                              <div>
                                  <span class="d-block mb-1">
                                      Request Applications
                                  </span>
                                  <div class="d-flex align-items-center gap-2">
                                      <h5 class="fw-semibold mb-0">${applicationCount}</h5>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
                </div>
                <div class="col-xl-9">
                    <div class="card custom-card">
                        <div class="card-header justify-content-between">
                            <div> 
                              <h5 class="card-title mb-0">My Applications</h5>
                              <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Applications assigned to you</p>
                            </div> 
                            <div class="d-flex flex-wrap gap-2">
                            
                              <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#appsPassedDueModal">
                                  <i class="ri-error-warning-line fs-13"></i>
                                  Overdue Applications
                              </button>
                              
                              <!-- Additional Action Buttons -->
                              <div class="dropdown">
                                  <button class="btn btn-sm btn-outline-dark dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                      <i class="fas fa-ellipsis-v me-2"></i>
                                      More
                                  </button>
                                  <ul class="dropdown-menu" style="min-width: 250px;">
                                      <li>
                                          <a class="dropdown-item small" href="#" data-bs-toggle="modal" data-bs-target="#appsReceivedMonthModal">
                                              <i class="fas fa-inbox me-2"></i>
                                              This Month's Received
                                          </a>
                                      </li>
                                      <li>
                                          <a class="dropdown-item small" href="#" data-bs-toggle="modal" data-bs-target="#appsCompletedMonthModal">
                                              <i class="fas fa-check-circle me-2"></i>
                                              This Month's Completed
                                          </a>
                                      </li>
                                  </ul>
                              </div>
                          </div>
                          </div>
                        <div class="card-body p-3 position-relative" id="todo-content">
                            <div class="table-responsive">
                              <table class="table table-hover align-middle mb-0" id="applicationTable">
                                  <thead class="bg-light">
                                      <tr>
                                          <!-- <th class="ps-4" width="40">
                                              <div class="form-check">
                                                  <input class="form-check-input" type="checkbox" id="selectAll">
                                              </div>
                                          </th> -->
                                          <th>Job Details</th>
                                          <th>Applicant</th>
                                          <th>Type</th>
                                          <th>Status</th>
                                          <th>Timeline</th>
                                          <th class="text-center">Actions</th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      <c:forEach items="${applicationlist}" var="appfiles" varStatus="loop">
                                        <fmt:parseDate value="${appfiles.job_datesend}" pattern="yyyy-MM-dd" var="jobSentDate" />
                                        <c:set var="daysDiff" value="${(now.time - jobSentDate.time) / (1000 * 60 * 60 * 24)}" />
                                        <tr class="${appfiles.objections > 0 ? 'table-warning' : ''}" 
                                            ${appfiles.objections > 0 ? "data-bs-toggle='tooltip' data-bs-placement='left' title='Application has pending Objections'" : ""}>
                                            
                                            <!-- Checkbox -->
                                            <!-- <td class="ps-4">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="${appfiles.job_number}">
                                                </div>
                                            </td> -->
                                            
                                            <!-- Job Details -->
                                            <td>
                                                <div class="d-flex flex-column">
                                                    <span class="fw-bold text-primary small">${appfiles.job_number}</span>
                                                    <small class="text-muted">Created: ${appfiles.created_date}</small>
                                                </div>
                                            </td>
                                            
                                            <!-- Applicant -->
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle me-2">
                                                        <i class="ri-user-line text-muted"></i>
                                                    </div>
                                                    <div>
                                                        <div class="fw-medium small" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" title="${appfiles.ar_name}">${fn:substring(appfiles.ar_name, 0, 20)}${fn:length(appfiles.ar_name) > 20 ? '...' : ''}</div>
                                                        <small class="text-muted small">Sent by: ${appfiles.job_forwarded_by}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            
                                            <!-- Application Type -->
                                            <td>
                                                <span class="small">
                                                    ${appfiles.business_process_sub_name}
                                                </span>
                                            </td>
                                            
                                            <!-- Status -->
                                            <td>
                                                <div class="d-flex flex-column">
                                                    <span class="small" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" title="${appfiles.current_application_status}">
                                                        ${fn:substring(appfiles.current_application_status, 0, 20)}${fn:length(appfiles.current_application_status) > 20 ? '...' : ''}
                                                    </span>
                                                    ${appfiles.objections > 0 ? 
                                                        '<small class="text-danger mt-1"><i class="fas fa-exclamation-circle me-1"></i>Has Objections</small>' : ''}
                                                </div>
                                            </td>
                                            
                                            <!-- Timeline -->
                                            <td>
                                               <div class="d-flex flex-column">
                                                <small>
                                                    <i class="fas fa-calendar-alt me-1 text-muted"></i>
                                                    Received: ${appfiles.job_datesend}
                                                </small>

                                                <small>
                                                    <i class="fas fa-history me-1 text-muted"></i>
                                                    Days: <fmt:formatNumber value="${daysDiff}" maxFractionDigits="0" />
                                                </small>
                                              </div>
                                            </td>
                                            
                                            <!-- Actions -->
                                            <td class="text-center">
                                                <form action="registration_application_progress_details" method="post" class="d-inline">
                                                    <input type="hidden" name="case_number" value="${appfiles.case_number}">
                                                    <input type="hidden" name="transaction_number" value="${appfiles.transaction_number}">
                                                    <input type="hidden" name="job_number" value="${appfiles.job_number}">
                                                    <input type="hidden" name="business_process_sub_name" value="${appfiles.business_process_sub_name}">
                                                    <button type="submit" class="btn btn-warning label-btn">
                                                        <i class="ri-folder-open-line label-btn-icon me-2"></i>
                                                        Work
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                      </c:forEach>
                                  </tbody>
                              </table>
                        </div>
                    </div>
                    
                </div>
            </div>
            <!--End::row-1 -->

    </div>
</div>
<!-- End::app-content -->

<script>
  $(document).ready(function() {
	  var datatable = $("#applicationTable").DataTable( {
		  stateSave: true, 
		  dom: 'Bfrtip',						
      buttons: [
        'pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'
      ]
		});

    // Reinitialize tooltips after a brief delay
    setTimeout(function() {
      window.initializeTooltips();
    }, 50);
  });
</script>
     

 
