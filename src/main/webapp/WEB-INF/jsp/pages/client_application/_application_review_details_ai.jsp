<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<jsp:include page="../includes/_header.jsp"></jsp:include>
  
<div class="container-fluid">
    <!-- Breadcrumbs-->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="index.jsp">Application Processing</a></li>
        <li class="breadcrumb-item active">Case Details</li>
    </ol>

    <div class="row">
        <div class="col-lg-8">
            <!-- Main Case Card -->
            <div class="card">
                <div class="card-header bg-info d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">
                        <i class="fas fa-file-alt mr-2"></i>${case_number} - ${ar_name}
                    </h6>
                    <button type="button" onclick="javascript:history.go(-1)"
                        class="btn btn-light btn-icon-split">
                        <span class="icon text-dark"> 
                            <i class="fas fa-arrow-left"></i>
                        </span>
                        <span class="text">Back</span>
                    </button>
                </div>
                
                <div class="card-body">
                    <!-- Case Summary Section -->
             <div class="card mb-4">
                        <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsemaincase">
                            <h5 class="mb-0">
                                <i class="fas fa-file-alt mr-2"></i>Case Summary
                            </h5>
                        </div>

  <div id="collapsemaincase" class="collapse-show">
    <div class="card-body">
      
      <!-- Hidden fields -->
      <input type="hidden" id="cs_main_business_process_id" value="${business_process_id}">
      <input type="hidden" id="cs_main_business_process_name" value="${business_process_name}">
      <input type="hidden" id="cs_main_business_process_sub_id" value="${business_process_sub_id}">
      <input type="hidden" id="cs_main_business_process_sub_name" value="${business_process_sub_name}">
      <input type="hidden" id="cs_main_client_number" value="${phone_number}">
      <input type="hidden" id="cs_main_case_number" value="${case_number}">

      <!-- Parcel Info -->
      <h6 class="text-uppercase text-muted mt-2 mb-3 border-bottom pb-1">Parcel Information</h6>
      <div class="row">
        <div class="col-md-6"><strong>Date Created:</strong> ${created_date}</div>
        <div class="col-md-6"><strong>Last Modified:</strong> ${modified_date}</div>
      </div>

      <div class="row mt-2">
        <div class="col-md-4"><strong>Case Number:</strong> ${case_number}</div>
        <div class="col-md-4"><strong>Regional Number:</strong> ${regional_number}</div>
        <div class="col-md-4"><strong>Locality:</strong> ${locality}</div>
      </div>

      <div class="row mt-2">
        <div class="col-md-4"><strong>District:</strong> ${district}</div>
        <div class="col-md-4"><strong>Region:</strong> ${region}</div>
        <div class="col-md-4"><strong>Size of Land (Acres):</strong> ${size_of_land}</div>
      </div>

      <div class="row mt-2">
        <div class="col-md-4"><strong>GLPIN:</strong> ${glpin}</div>
      </div>

      <!-- Transaction Details -->
      <h6 class="text-uppercase text-muted mt-4 mb-3 border-bottom pb-1">Transaction Details</h6>
      <div class="row">
        <div class="col-md-4"><strong>Transaction Number:</strong> ${transaction_number}</div>
        <div class="col-md-4"><strong>Applicant Name:</strong> ${ar_name}</div>
        <div class="col-md-4"><strong>Nature of Instrument:</strong> ${nature_of_instrument}</div>
      </div>

      <div class="row mt-2">
        <div class="col-md-4"><strong>Date of Document:</strong> ${date_of_document}</div>
        <div class="col-md-4"><strong>Date of Registration:</strong> ${date_of_registration}</div>
        <div class="col-md-4"><strong>Type of Interest:</strong> ${type_of_interest}</div>
      </div>

      <div class="row mt-2">
        <div class="col-md-4"><strong>Type of Use:</strong> ${type_of_use}</div>
        <div class="col-md-4"><strong>Term:</strong> ${term}</div>
        <div class="col-md-4"><strong>Commencement Date:</strong> ${commencement_date}</div>
      </div>

      <div class="row mt-2">
        <div class="col-md-4"><strong>Assessed Value:</strong> ${assessed_value}</div>
        <div class="col-md-4"><strong>Stamp Duty Payable:</strong> ${stamp_duty_payable}</div>
        <div class="col-md-4"><strong>Certificate Number:</strong> ${certificate_number}</div>
      </div>
      
    </div>
  </div>
</div>

                   <!-- Process Status and Actions Card -->
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">
                                <i class="fas fa-tasks mr-2"></i>Process Status & Actions
                            </h5>
                            <div class="action-buttons">
                                <!-- <button class="btn btn-info btn-icon-split btn-sm mr-2" data-toggle="modal" data-target="#reviewApplicationModal">
                                    <span class="icon text-white-50">
                                        <i class="fas fa-eye"></i>
                                    </span>
                                    <span class="text">Review Application</span>
                                </button> -->
                                <!-- <button class="btn btn-warning btn-icon-split btn-sm" id="continueNextProcess">
                                    <span class="icon text-white-50">
                                        <i class="fas fa-arrow-right"></i>
                                    </span>
                                    <span class="text">Continue</span>
                                </button> -->
                                 <button class="btn btn-success btn-icon-split btn-sm" data-job_number="${job_number}" data-ar_name="${ar_name}"
				data-business_process_sub_name="${business_process_sub_name}" data-toggle="modal" data-target="#askForPurposeOfBatching" >
                                    <span class="icon text-white-50">
                                        <i class="fas fa-arrow-right"></i>
                                    </span>
                                    <span class="text">Add to batch List</span>
                                </button>
                                 <button class="btn btn-primary btn-icon-split btn-sm" data-job_number="${job_number}" data-ar_name="${ar_name}" data-req_id="${rq_id}"
				                                data-business_process_sub_name="${business_process_sub_name}" data-toggle="modal" data-target="#askArchiveRequest" >
                                    <span class="icon text-white-50">
                                        <i class="fas fa-arrow-right"></i>
                                    </span>
                                    <span class="text">Complete Request</span>
                                </button>

                            </div>
                        </div>
                        <div id="collapseprocess" class="collapse show">
                            <div class="card-body">
                                <!-- Actions to be Taken -->
                                <div class="col-md-12 mb-4">
                                    <div class="section-title">Actions to be Taken</div>
                                    <ul class="mt-2 ps-3">
                                    <c:forEach var="babyStep" items="${active_digital_workflow_step_list}">
                                        <li class="d-flex flex-column mb-4">
                                            <!-- Baby Step Description and Status -->
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <c:choose>
                                                        <c:when test="${babyStep.bse_status == 'Pending'}">
                                                            <span class="badge badge-danger">${babyStep.bse_status}</span>
                                                        </c:when>
                                                        <c:when test="${babyStep.bse_status == 'Ongoing'}">
                                                            <span class="badge badge-warning">${babyStep.bse_status}</span>
                                                        </c:when>
                                                        <c:when test="${babyStep.bse_status == 'Completed'}">
                                                            <span class="badge badge-success">${babyStep.bse_status}</span>
                                                        </c:when>
                                                    </c:choose>
                                                    <span class="ms-2">${babyStep.bse_description}</span>
                                                </div>
                                                
                                                <!-- Action Buttons -->
                                                <div class="btn-group ms-3">
                                                    <button 
                                                        class="btn btn-warning btn-sm text-white" 
                                                        data-toggle="modal" 
                                                        data-target="#${babyStep.bse_description_key}"
                                                        data-bs-id="${babyStep.bse_id}" 
                                                        data-bse-id="${babyStep.bse_id}" 
                                                        data-bs-desc="${babyStep.bse_description}" 
                                                        data-bs-username="${babyStep.username}" 
                                                        data-bs-date="${babyStep.date}" 
                                                        data-bs-time="${babyStep.time}"
                                                        data-workflow_type="${babyStep.workflow_type}" 
                                                        data-job_number="${job_number}" 
                                                        data-ar_name="${ar_name}" 
                                                    >
                                                        View Details
                                                    </button>
                                                    <button 
                                                        class="btn btn-success btn-sm text-white" 
                                                        onclick="reviewStep(`${babyStep.bse_id}`,`${job_number}`)" 
                                                        <c:if test="${babyStep.bse_status == 'Pending' || babyStep.bse_status == 'Completed'}">disabled</c:if>
                                                    >
                                                        Approve
                                                    </button>
                                                    <button 
                                                        class="btn btn-primary btn-sm text-white" 
                                                        data-toggle="modal" 
                                                        data-job_number="${job_number}" 
                                                        data-ar_name="${ar_name}" 
                                                        data-business_process_sub_name="${business_process_sub_name}" 
                                                        data-locality="${locality}" 
                                                        data-target="#askForPurposeOfSendingRequest" 
                                                        data-bs-desc="${babyStep.bse_description}" 
                                                        id="btnAddRequest"
                                                        <c:if test="${babyStep.bse_status == 'Pending' || babyStep.bse_status == 'Completed'}">disabled</c:if>
                                                    >
                                                        Send Request
                                                    </button>
                                                    <button 
                                                        class="btn btn-danger btn-sm text-white" 
                                                        data-toggle="modal" 
                                                        data-job_number="${job_number}" 
                                                        data-ar_name="${ar_name}" 
                                                        data-business_process_sub_name="${business_process_sub_name}" 
                                                        data-locality="${locality}" 
                                                        data-target="#newQueryModal" 
                                                        <c:if test="${babyStep.bs_status == 'Pending' || babyStep.bs_status == 'Completed'}">disabled</c:if>
                                                    >
                                                        Query
                                                    </button>
                                                </div>
                                            </div>
                                            
                                            <!-- Additional Details -->
                                            <div class="text-muted ms-4 mt-1">
                                                <small>
                                                    <!-- <strong>Username:</strong> <c:out value="${babyStep.username}" default="N/A" /> |
                                                    <strong>Date:</strong> <c:out value="${babyStep.date}" default="N/A" /> | -->
                                                    <strong>Status:</strong> <c:out value="${babyStep.bse_status}" default="Not Approved" /> |
                                                    <strong>Start Date:</strong> <c:out value="${babyStep.start_date}" default="Not Sent" /> |
                                                    <strong>Approved By:</strong> <c:out value="${babyStep.completed_by}" default="N/A" /> |
                                                    <strong>Approved Date:</strong> <c:out value="${babyStep.complete_by_date}" default="Not Sent" />
                                                </small>
                                            </div>

                                        
                                        </li>
                                    </c:forEach>
                                </ul>
                                </div>
                                <!-- Process Status List -->
                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Sidebar -->
        <div class="col-lg-4">
            <div id="accordion">
                <!-- Map (Parcel) -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsejobs">
                        <h5 class="mb-0">
                            <i class="fas fa-map mr-2"></i>Map (Parcel)
                        </h5>
                    </div>
                    <div id="collapsejobs" class="collapse show">
                        <div class="card-body">
                            <div id="parcelMap"></div>
                        </div>
                    </div>
                </div>

                <!-- Parties Involved -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapseparties">
                        <h5 class="mb-0">
                            <i class="fas fa-users mr-2"></i>Parties Involved
                        </h5>
                    </div>
                    <div id="collapseparties" class="collapse">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Name</th>
                                            <th>Gender</th>
                                            <th>Contact</th>
                                            <th>Role</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${parties}" var="parties_row">
                                            <tr>
                                                <td>${parties_row.ar_name}</td>
                                                <td>${parties_row.ar_gender}</td>
                                                <td>${parties_row.ar_cell_phone}</td>
                                                <td>${parties_row.type_of_party}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bills and Payments -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsebills">
                        <h5 class="mb-0">
                            <i class="fas fa-receipt mr-2"></i>Bills & Payments
                        </h5>
                    </div>
                    <div id="collapsebills" class="collapse">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Action</th>
                                            <th>Payment Mode</th>
                                            <th>Amount</th>
                                            <th>Receipt #</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${payment_invoice}" var="payment_bill_row">
                                            <tr>
                                                <td>
                                                    <button class="btn btn-sm btn-success" 
                                                        data-toggle="modal" 
                                                        data-target="#viewBillModal"
                                                        data-egcr_id="${payment_bill_row.payment_slip_number}"
                                                        data-ref_number="${payment_bill_row.ref_number}">
                                                        View
                                                    </button>
                                                </td>
                                                <td>${payment_bill_row.payment_mode}</td>
                                                <td>${payment_bill_row.bill_amount}</td>
                                                <td>${payment_bill_row.payment_slip_number}</td>
                                                <td>${payment_bill_row.payment_date}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Case Minutes -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapseminutes">
                        <h5 class="mb-0">
                            <i class="fas fa-clipboard-list mr-2"></i>Case Minutes
                        </h5>
                    </div>
                    <div id="collapseminutes" class="collapse">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Description</th>
                                            <th>From</th>
                                            <th>To</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${application_munites}" var="application_munites_row">
                                            <tr>
                                                <td>${application_munites_row.am_description}</td>
                                                <td>${application_munites_row.ar_name}</td>
                                                <td>${application_munites_row.am_to_officer}</td>
                                                <td>${application_munites_row.am_activity_date}</td>
                                                <td>
                                                    <button class="btn btn-sm btn-info" 
                                                        data-toggle="modal"
                                                        data-target="#addMinutesModal"
                                                        data-target-id="${application_munites_row.am_id}">
                                                        <i class="fas fa-eye"></i> View
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Case Documents -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsedocs">
                        <h5 class="mb-0">
                            <i class="fas fa-file-contract mr-2"></i>Case Documents
                        </h5>
                    </div>
                    <div id="collapsedocs" class="collapse">
                        <div class="card-body">
                            <div class="action-buttons mb-3">
                                <button class="btn btn-primary btn-sm mr-2" id="btn_load_scanned_documents">
                                    <i class="fas fa-sync-alt mr-1"></i> Refresh
                                </button>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Document Name</th>
                                            <th>Type</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${casescanneddocuments}" var="casescanneddocuments_row">
                                            <tr>
                                                <td>${casescanneddocuments_row.document_name}</td>
                                                <td>${casescanneddocuments_row.document_type}</td>
                                                <td>
                                                    <form action="open_pdffile" method="post">
                                                        <input type="hidden" name="document_path" value="${casescanneddocuments_row.document_file}">
                                                        <button type="submit" class="btn btn-sm btn-success">
                                                            <i class="fas fa-file-download mr-1"></i> Download
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

                <!-- Public Documents -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsepudocs">
                        <h5 class="mb-0">
                            <i class="fas fa-file-alt mr-2"></i>Public Documents
                        </h5>
                    </div>
                    <div id="collapsepudocs" class="collapse">
                        <div class="card-body">
                            <div class="action-buttons mb-3">
                                <button class="btn btn-primary btn-sm mr-2" id="btn_load_scanned_documents_public">
                                    <i class="fas fa-sync-alt mr-1"></i> Refresh
                                </button>
                                <button class="btn btn-success btn-sm" id="btn_add_public_document" data-toggle="modal" data-target="#publicFileUploadModal">
                                    <i class="fas fa-plus mr-1"></i> Add Document
                                </button>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Document Name</th>
                                            <th>Type</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_row">
                                            <tr>
                                                <td>${casescanneddocuments_row.document_name}</td>
                                                <td>${casescanneddocuments_row.document_type}</td>
                                                <td>
                                                    <form action="registration_application_progress_details" method="post">
                                                        <input type="hidden" name="document_path" value="${casescanneddocuments_row.document_file}">
                                                        <button type="submit" class="btn btn-sm btn-success">
                                                            <i class="fas fa-file-download mr-1"></i> Download
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

                <!-- Case Queries -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsequeries">
                        <h5 class="mb-0">
                            <i class="fas fa-question-circle mr-2"></i>Case Queries
                        </h5>
                    </div>
                    <div id="collapsequeries" class="collapse">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Job #</th>
                                            <th>Reasons</th>
                                            <th>Remarks</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${case_query}" var="case_query_row">
                                            <tr>
                                                <td>${case_query_row.job_number}</td>
                                                <td>${case_query_row.reasons}</td>
                                                <td>${case_query_row.remarks}</td>
                                                <td>${case_query_row.created_date}</td>
                                                <td>
                                                    <button class="btn btn-sm ${case_query_row.status == 1 ? 'btn-warning' : 'btn-info'}" 
                                                        data-toggle="modal" 
                                                        data-target="#newQueryModal"
                                                        data-id="${case_query_row.qid}"
                                                        data-job_number="${case_query_row.am_description}"
                                                        data-reasons="${case_query_row.reasons}"
                                                        data-remarks="${case_query_row.remarks}"
                                                        data-status="${case_query_row.status}">
                                                        ${case_query_row.status == 1 ? '<i class="fas fa-edit mr-1"></i> Edit' : '<i class="fas fa-eye mr-1"></i> View'}
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                 <!-- Case Queries -->
                <div class="card mb-3">
                    <div class="card-header accordion-toggle" data-toggle="collapse" data-target="#collapsecasesteps">
                        <h5 class="mb-0">
                            <i class="fas fa-question-circle mr-2"></i>Case Steps
                        </h5>
                    </div>
                    <div id="collapsecasesteps" class="collapse">
                        <div class="card-body">
                           

  <ul class="process-list">
                                      
                       
        
                                   <c:forEach items="${baby_step_milestone_list}" var="milestone">
    <div class="milestone">
        <h5>${milestone.milestone_description} (Status: ${milestone.mile_stone_status})</h5>
        <ul>
            <c:forEach items="${milestone.baby_steps}" var="process">
                <li>
                    <i class="fas ${process.bse_status == 'Completed' ? 'fa-check-circle text-success' : process.bse_status == 'Ongoing' ? 'fa-spinner text-warning' : 'fa-times-circle text-danger'}"></i>
                    <div>
                        <div class="process-item">${process.bse_description}</div>
                        <div class="process-details">
                            <span>Performed by: ${process.completed_by != null ? process.completed_by : 'Pending'}</span>
                            <span>Date: 
                                <c:choose>
                                    <c:when test="${process.complete_by_date != null}">
                                        <fmt:parseDate value="${process.complete_by_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                                        <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
                                    </c:when>
                                    <c:otherwise>N/A</c:otherwise>
                                </c:choose>
                            </span>
                            <span>Time: 
                                <c:choose>
                                    <c:when test="${process.complete_by_date != null}">
                                        <fmt:parseDate value="${process.complete_by_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                                        <fmt:formatDate value="${parsedDate}" pattern="HH:mm:ss" />
                                    </c:when>
                                    <c:otherwise>N/A</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
</c:forEach>


                                    </ul>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>






<script>
    // Define EPSG:2136 projection
 //   proj4.defs('EPSG:2136', '+proj=utm +zone=36 +south +ellps=clrk80 +units=m +no_defs');

  function editStep(stepId) {
        alert('Editing step with ID: '+stepId);
    }

    // Function to handle deleting a step
    function deleteStep(stepId) {
        const confirmation = confirm('Are you sure you want to delete the step with ID: '+stepId+'?');
        if (confirmation) {
            alert('Deleted step with ID: '+stepId);
            // Replace the alert with your logic for deleting
        }
    }

    function reviewStep(bse_id,job_number) {
        const confirmation = confirm('Are you sure you want to approve the step?');
        if (confirmation) {
            
           // var bs_id = stepId;
            var bse_id = bse_id;
            
            var job_number = job_number;

            if(!bse_id || !job_number){
                alert('Sorry! An error occurred, try again.');
                return;
            }

            $.ajax({
                type : "POST",
                url : "Case_Management_Serv",
                data : {
                    request_type : 'select_review_baby_steps_check_for_completion',
                    //bs_id: parseInt(bs_id),
                    bse_id: parseInt(bse_id),
                    
                    job_number: job_number
                },
                cache: false,
                success: function(response) {

                    console.log(response)
                   
                    var json_result = JSON.parse(response);
                    
                    
                   if (json_result.success){
                    alert(json_result.msg)
                    location.reload()
                   }else{
                    alert(json_result.msg)
                   }

               

                }
            })

        }
    }


      // Initialize the map when the DOM is fully loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Placeholder coordinates (longitude, latitude) for the parcel
        // In a real implementation, these should be dynamically fetched based on GLPIN or other parcel data
     var parcel_lrd_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:lc_spatial_objects',
		'TILED' : true
	},

	serverType : 'geoserver',
	transition : 0
})

var lrd_parcels_dataLayer = new ol.layer.Tile({
	title : 'LRD Parcels Layer',
	source : parcel_lrd_dataSource

})


var lrd_certificate_region_dataSource = new ol.source.TileWMS({
	url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
	params : {
		'LAYERS' : 'csau_geospatial:lrd_certificate_region',
		'TILED' : true
	},

	serverType : 'geoserver',
	transition : 0
})

var lrd_certificate_region_dataLayer = new ol.layer.Tile({
	title : 'LRD Certificate Region',
	visible : false,
	source : lrd_certificate_region_dataSource

})


	var lcfrs_grid_lrd_dataSource = new ol.source.TileWMS({
					url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
					params : {
						'LAYERS' : 'csau_geospatial:gng_grid',
						'TILED' : true
					},
		
					serverType : 'geoserver',
					transition : 0
				})
				
				var lcfrs_grid_lrd_dataLayer = new ol.layer.Tile({
					title : 'Grid',
					visible : false,
					source : lcfrs_grid_lrd_dataSource
				
				})
				
				var lcfrs_registration_district_dataSource = new ol.source.TileWMS({
					url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
					params : {
						'LAYERS' : 'csau_geospatial:district',
						'TILED' : true
					},
				
					serverType : 'geoserver',
					transition : 0
				})
				
				var lcfrs_registration_district_dataLayer = new ol.layer.Tile({
					title : 'Registration District',
					visible : false,
					source : lcfrs_registration_district_dataSource
				
				})

        var googleLayerHybrid = new ol.layer.Tile({
	title : "Google Satellite & Roads",
	// 'type': 'base',
	visible : false,
	'opacity' : 1.000000,
	source : new ol.source.XYZ({
		attributions : [ new ol.Attribution({
			html : '<a href=""></a>'
		}) ],
		url : 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga'
	}),
});

		

        var projObj = new ol.proj.Projection({
	// code: 'EPSG:3857',
	code : 'EPSG:2136',
	extent : [ 80935.4497355444, 1209.0295731349593, 1711780.3060929566,
			2358523.124783509 ],
	units : 'ft',
	axisOrientation : 'enu',
	global : false,
	// worldExtent: [-199,32,322,0],
	worldExtent : [ -3.79, 1.4, 2.1, 11.16 ],
	getPointResolution : function(r) {
		return r;
	},
// worldExtent: [-118905.86588345, -1185221.57235827,
// 2011055.53818079,
// 2360318.82691170]
// extent: [32000000,5900000,33000000,6000000]
// extent: [32502277,5970203,32513486,5971984]
});

ol.proj.setProj4(proj4);
proj4
		.defs(
				"EPSG:2136",
				'+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs');


    const wktPolygon = '${parcel_wkt}';

          console.log('wktPolygon')
   console.log(wktPolygon)

     // Parse WKT to OpenLayers geometry
               

              //   vectorLayer.setSource(new ol.source.Vector({features : (new ol.format.WKT()).readFeatures(wktPolygon)}));
             
                

        // Initialize OpenLayers map
        const map = new ol.Map({
            target: 'parcelMap',
            controls : ol.control.defaults().extend(
			[ new ol.control.LayerSwitcher(),
			new ol.control.OverviewMap(),
			new ol.control.ZoomSlider(), new ol.control.Attribution(),
					new ol.control.MousePosition(),
					new ol.control.ZoomToExtent(), new ol.control.FullScreen()
			]),
	renderer : 'canvas',
            layers: [
                new ol.layer.Tile({
                    source: new ol.source.OSM()
                })
            ],
            view: new ol.View({
              projection : projObj,
              extent : ol.proj.get('EPSG:2136').getExtent(),
                center : [ 1187433.58822084, 327091.107070208 ],
                zoom: 12
            })
        });
       // Add the polygon to the map
                // const vectorSource = new ol.source.Vector({
                //     features: [polygonFeature]
                // });

                const vectorLayer = new ol.layer.Vector({
                    source: new ol.source.Vector(),
                    style: new ol.style.Style({
                        stroke: new ol.style.Stroke({
                            color: '#ff0000',
                            width: 2
                        }),
                        fill: new ol.style.Fill({
                            color: 'rgba(255, 0, 0, 0.2)'
                        })
                    })
                });

                map.addLayer(googleLayerHybrid);
                map.addLayer(lcfrs_registration_district_dataLayer);
                map.addLayer(lrd_parcels_dataLayer);
                map.addLayer(vectorLayer);

console.log("wktPolygon")
console.log(wktPolygon)
                vectorLayer.setSource(new ol.source.Vector({features : (new ol.format.WKT()).readFeatures(wktPolygon)}));
                map.getView().fit(vectorLayer.getSource().getExtent(),{size : map.getSize(),maxZoom : 16})

    });
</script>



<jsp:include page="../includes/_modals_gatedworkflow.jsp"></jsp:include>
<jsp:include page="../includes/_footer.jsp"></jsp:include>