<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="d" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.*" %>

<!-- Begin Page Content -->
 

<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Ticket Details</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>View and manage ticket details</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">CAC</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Tickets</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Ticket Details</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->


 <c:forEach items="${ticket_details}" var="ticket"  varStatus="appfiles_loop"> 
    <div class="pagetitle">
      <!-- <h4>DUC - CAC TICKETS</h4> --><br>
	   <div class="btn-group">
       <button data-bs-toggle="modal" data-bs-target="#editModal" class="btn btn-success ${edit_ticket}" >
			<i class="fas fa-edit me-1"></i>Edit Ticket
			</button>
			<button data-bs-toggle="modal" data-bs-target="#requestModal" class="btn btn-warning ${update_status}" >
			<i class="fas fa-print me-1"></i>Print Request
			</button>
			<button data-bs-toggle="modal" data-bs-target="#updateStatusModal" class="btn btn-primary ${update_status}" >
						<i class="fas fa-edit me-1"></i>Update Status
						</button>
			<button data-bs-toggle="modal" data-bs-target="#requestModal" class="btn btn-warning ${print_request}" href="#requestModal">
			<i class="fas fa-print me-1"></i>Print Request
			</button>
			<button  class="btn btn-danger" 
					><a style=" text-decoration: none" class="text-white" href="${pageContext.request.contextPath}/${cica_route}">
				<i class="fas fa-arrow-left me-1"></i>Go Back</a>
					</button>
	   </div>
    </div>  

    <section class="section mt-4">
      <div class="row">
  
       <div class="col-lg-8">
    <!-- Ticket Details Card -->
    <div class="card border-0 shadow-sm">
        <!-- Card Header with Ticket Info -->
        <div class="card-header bg-white border-bottom py-3">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="bg-primary bg-opacity-10 rounded-circle p-2">
                        <i class="fas fa-ticket-alt text-primary fa-lg"></i>
                    </div>
                    <div>
                        <h5 class="mb-1 fw-semibold">
                            Ticket #<span class="text-primary">${ticket.ticket_no}</span>
                        </h5>
                        <span class="badge bg-${ticket.purpose == 1 ? 'info' : ticket.purpose == 3 ? 'warning' : 'secondary'} bg-opacity-10 text-${ticket.purpose == 1 ? 'info' : ticket.purpose == 3 ? 'warning' : 'secondary'} px-3 py-2 rounded-pill">
                            <c:choose>
                                <c:when test="${ticket.purpose == 1}">
                                    <i class="fas fa-question-circle me-1"></i>Service Enquiry
                                </c:when>
                                <c:when test="${ticket.purpose == 3}">
                                    <i class="fas fa-exclamation-triangle me-1"></i>Service Complaint
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-file-alt me-1"></i>Non-Service Complaint
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                
                <!-- Status Badge -->
                <div class="d-flex align-items-center gap-2">
                    <span class="text-muted small">Current Status:</span>
                    <c:choose>
                        <c:when test="${ticket.status == 0}">
                            <span class="badge bg-info rounded-pill px-3 py-2">
                                <i class="fas fa-folder-open me-1"></i>Open
                            </span>
                        </c:when>
                        <c:when test="${ticket.status == 2}">
                            <span class="badge bg-warning text-dark rounded-pill px-3 py-2">
                                <i class="fas fa-clock me-1"></i>Pending
                            </span>
                        </c:when>
                        <c:when test="${ticket.status == 1}">
                            <span class="badge bg-danger rounded-pill px-3 py-2">
                                <i class="fas fa-pause-circle me-1"></i>On Hold
                            </span>
                        </c:when>
                        <c:when test="${ticket.status == 3}">
                            <span class="badge bg-success rounded-pill px-3 py-2">
                                <i class="fas fa-check-circle me-1"></i>Resolved
                            </span>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Card Body with Accordion -->
        <div class="card-body p-4">
            <!-- Modern Accordion -->
            <div class="accordion modern-accordion" id="accordionTicketDetails">
                
                <!-- Client Details Accordion -->
                <div class="accordion-item border-0 mb-3">
                    <h2 class="accordion-header" id="clientDetailsHeading">
                        <button class="accordion-button collapsed bg-light rounded-3" type="button" 
                                data-bs-toggle="collapse" data-bs-target="#clientDetails" 
                                aria-expanded="false" aria-controls="clientDetails">
                            <div class="d-flex align-items-center gap-3">
                                <div class="bg-primary bg-opacity-10 rounded-circle p-2">
                                    <i class="fas fa-user text-primary"></i>
                                </div>
                                <span class="fw-semibold">Client Information</span>
                            </div>
                        </button>
                    </h2>
                    <div id="clientDetails" class="accordion-collapse collapse" 
                         aria-labelledby="clientDetailsHeading" data-bs-parent="#accordionTicketDetails">
                        <div class="accordion-body pt-4">
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Full Name</span>
                                        <span class="info-value">${ticket.client_name}</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Email Address</span>
                                        <span class="info-value">${ticket.client_email}</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Phone Number</span>
                                        <span class="info-value">
                                            <i class="fas fa-phone-alt me-1 text-muted small"></i>
                                            ${ticket.client_phone}
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Preferred Contact</span>
                                        <span class="info-value">
                                            <span class="badge bg-light text-dark rounded-pill px-3">
                                                <i class="fas fa-${ticket.contact_type == 'Email' ? 'envelope' : 'comment'} me-1"></i>
                                                ${ticket.contact_type}
                                            </span>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="info-item">
                                        <span class="info-label">Address</span>
                                        <span class="info-value">${ticket.client_address}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Complaint Details Accordion -->
                <div class="accordion-item border-0 mb-3">
                    <h2 class="accordion-header" id="complaintDetailsHeading">
                        <button class="accordion-button collapsed bg-light rounded-3" type="button" 
                                data-bs-toggle="collapse" data-bs-target="#complaintDetails" 
                                aria-expanded="false" aria-controls="complaintDetails">
                            <div class="d-flex align-items-center gap-3">
                                <div class="bg-warning bg-opacity-10 rounded-circle p-2">
                                    <i class="fas fa-file-alt text-warning"></i>
                                </div>
                                <span class="fw-semibold">Complaint Details</span>
                            </div>
                        </button>
                    </h2>
                    <div id="complaintDetails" class="accordion-collapse collapse" 
                         aria-labelledby="complaintDetailsHeading" data-bs-parent="#accordionTicketDetails">
                        <div class="accordion-body pt-4">
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Subject</span>
                                        <span class="info-value">${ticket.subject}</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Priority</span>
                                        <span class="info-value">
                                            <span class="badge bg-${ticket.priority == 'High' ? 'danger' : ticket.priority == 'Medium' ? 'warning' : 'info'} rounded-pill px-3">
                                                ${ticket.priority}
                                            </span>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Division</span>
                                        <span class="info-value">${ticket.division}</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Region</span>
                                        <span class="info-value">${ticket.region_name}</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Related Service</span>
                                        <span class="info-value">${ticket.related_service}</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Reference Number</span>
                                        <span class="info-value">
                                            <span class="badge bg-light text-dark rounded-pill px-3">
                                                <i class="fas fa-hashtag me-1"></i>
                                                ${ticket.reference_id}
                                            </span>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="info-item">
                                        <span class="info-label">Description</span>
                                        <span class="info-value ">${ticket.description}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Notes Timeline Accordion -->
                <div class="accordion-item border-0 mb-3">
                    <h2 class="accordion-header" id="notesHeading">
                        <button class="accordion-button collapsed bg-light rounded-3" type="button" 
                                data-bs-toggle="collapse" data-bs-target="#notesTimeline" 
                                aria-expanded="false" aria-controls="notesTimeline">
                            <div class="d-flex align-items-center gap-3">
                                <div class="bg-info bg-opacity-10 rounded-circle p-2">
                                    <i class="fas fa-sticky-note text-info"></i>
                                </div>
                                <span class="fw-semibold">Notes Timeline</span>
                                <span class="badge bg-info rounded-pill ms-2" id="notesCount">0</span>
                            </div>
                        </button>
                    </h2>
                    <div id="notesTimeline" class="accordion-collapse collapse" 
                         aria-labelledby="notesHeading" data-bs-parent="#accordionTicketDetails">
                        <div class="accordion-body">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle" id="status_note" width="100%">
                                    <thead class="bg-light">
                                        <tr>
                                            <th>Note</th>
                                            <th>Status</th>
                                            <th>Updated By</th>
                                            <th>Updated On</th>
                                            <th class="text-center">Attachment</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Replies Accordion -->
                <div class="accordion-item border-0 mb-3">
                    <h2 class="accordion-header" id="repliesHeading">
                        <button class="accordion-button collapsed bg-light rounded-3" type="button" 
                                data-bs-toggle="collapse" data-bs-target="#repliesSection" 
                                aria-expanded="false" aria-controls="repliesSection">
                            <div class="d-flex align-items-center gap-3">
                                <div class="bg-success bg-opacity-10 rounded-circle p-2">
                                    <i class="fas fa-reply text-success"></i>
                                </div>
                                <span class="fw-semibold">Replies</span>
                                <span class="badge bg-success rounded-pill ms-2" id="repliesCount">0</span>
                            </div>
                        </button>
                    </h2>
                    <div id="repliesSection" class="accordion-collapse collapse" 
                         aria-labelledby="repliesHeading" data-bs-parent="#accordionTicketDetails">
                        <div class="accordion-body">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle" id="replies_tbl" width="100%">
                                    <thead class="bg-light">
                                        <tr>
                                            <th>Note</th>
                                            <th class="text-center">Attachment</th>
                                            <th>Region</th>
                                            <th>Division</th>
                                            <th>Replied By</th>
                                            <th>Replied On</th>
                                            <th class="text-end">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- SMS Messages Accordion -->
                <div class="accordion-item border-0 mb-3">
                    <h2 class="accordion-header" id="smsHeading">
                        <button class="accordion-button collapsed bg-light rounded-3" type="button" 
                                data-bs-toggle="collapse" data-bs-target="#smsSection" 
                                aria-expanded="false" aria-controls="smsSection">
                            <div class="d-flex align-items-center gap-3">
                                <div class="bg-primary bg-opacity-10 rounded-circle p-2">
                                    <i class="fas fa-sms text-primary"></i>
                                </div>
                                <span class="fw-semibold">SMS History</span>
                                <span class="badge bg-primary rounded-pill ms-2" id="smsCount">0</span>
                            </div>
                        </button>
                    </h2>
                    <div id="smsSection" class="accordion-collapse collapse" 
                         aria-labelledby="smsHeading" data-bs-parent="#accordionTicketDetails">
                        <div class="accordion-body">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle" id="sms_message" width="100%">
                                    <thead class="bg-light">
                                        <tr>
                                            <th>Message</th>
                                            <th>Contact</th>
                                            <th>Sent By</th>
                                            <th>Sent Date</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
   <div class="col-lg-4 ${add_reply}">
    <!-- Add Reply Card -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white border-bottom py-3">
            <h5 class="card-title mb-0 fw-semibold">
                <i class="fas fa-reply me-2 text-primary"></i>
                Add Reply
            </h5>
        </div>
        
        <form id="reply_to_ticket" method="post" enctype="multipart/form-data">
            <div class="card-body">
                <!-- Hidden Fields -->
                <c:forEach items="${ticket_details}" var="ticket" varStatus="appfiles_loop">
                    <input type="hidden" name="ticket_id" id="ticket_id" value="${ticket._id}">
                    <input type="hidden" name="ticket_no" id="ticket_no" value="${ticket.ticket_no}">
                </c:forEach>
                <input type="hidden" name="request_type" id="request_type" value="reply_to_ticket">
                <input type="hidden" name="replied_by_id" id="replied_by_id" value="${sessionScope.userid}">
                <input type="hidden" name="replied_by" id="replied_by" value="${sessionScope.fullname}">
                <input type="hidden" name="view_by" id="view_by" value="${sessionScope.view_by}">

                <!-- Move To Dropdown -->
                <div class="mb-4 ${move_to}">
                    <label class="form-label fw-semibold">
                        <i class="fas fa-arrow-right me-1 text-muted"></i>
                        Move To: <span class="text-danger">*</span>
                    </label>
                    <select class="form-select" id="move_to" name="move_to" >
                        <option value="" disabled selected>-- Select Destination --</option>
                        <option value="1" class="py-2">
                            <i class="fas fa-building me-2"></i>DCU
                        </option>
                        <option value="0" class="py-2">
                            <i class="fas fa-landmark me-2"></i>CAC Center
                        </option>
                    </select>
                    <div class="form-text text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Choose where this reply should be sent
                    </div>
                </div>

                <!-- Note/Reply Textarea -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">
                        <i class="fas fa-sticky-note me-1 text-muted"></i>
                        Note: <span class="text-danger">*</span>
                    </label>
                    <textarea class="form-control" 
                              id="reply_desc" 
                              name="reply_desc" 
                              rows="5" 
                              placeholder="Type your reply here..."
                              required></textarea>
                    <div class="form-text text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Maximum 500 characters
                    </div>
                </div>

                <!-- Attachment Section -->
                <div class="mb-4" id="reply_attached_doc">
                    <div class="form-check mb-3">
                        <input type="checkbox" 
                               class="form-check-input" 
                               name="attach_file" 
                               id="attach_file" 
                               checked>
                        <label class="form-check-label fw-semibold" for="attach_file">
                            <i class="fas fa-paperclip me-1 text-muted"></i>
                            Attach a file to this reply
                        </label>
                    </div>

                    <div id="attach_doc" class="ps-4 border-start border-2">
                        <label class="form-label fw-semibold">
                            <i class="fas fa-file-pdf me-1 text-danger"></i>
                            Select Document:
                        </label>
                        <div class="input-group">
                            <input type="file" 
                                   class="form-control" 
                                   id="file" 
                                   name="file" 
                                   accept="application/pdf"
                                   aria-describedby="fileHelp">
                            <span class="input-group-text bg-light">
                                <i class="fas fa-upload text-muted"></i>
                            </span>
                        </div>
                        <div id="fileHelp" class="form-text text-muted small">
                            <i class="fas fa-info-circle me-1"></i>
                            Accepted format: PDF only. Max size: 5MB
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="fas fa-paper-plane me-2"></i>
                        Submit Reply
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
          <!-- End Recent Activity -->
			<!-- End Recent Activity -->
         


        </div><!-- End Right side columns -->
  </div>
</section>

</c:forEach>
</div>
</div>
<!-- End::app-content -->
<!-- End Page Content -->

<!-- Attachment Modal -->
<!-- Update Status Modal -->
<c:forEach items="${ticket_details}" var="ticket" varStatus="appfiles_loop">
    <div class="modal fade modal-blur" id="updateStatusModal" tabindex="-1" aria-labelledby="updateStatusModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-semibold" id="updateStatusModalLabel">
                        <i class="fas fa-edit me-2 text-primary"></i>Update Status
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <form id="update_status_form" method="post">
                    <div class="modal-body">
                        <!-- Hidden Fields -->
                        <input type="hidden" class="form-control" name="req_client_phone" id="req_client_phone" value="${ticket.client_phone}">
                        <input type="hidden" name="updated_by_id" value="${sessionScope.userid}">
                        <input type="hidden" name="updated_by" value="${sessionScope.fullname}">
                        
                        <!-- Ticket No -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Ticket No:</label>
                            <div class="col-sm-8">
                                <input class="form-control bg-light" type="text" id="ticket_no" 
                                       name="ticket_no" value='<c:out value="${ticket.ticket_no}"/>' readonly required>
                            </div>
                        </div>
                        
                        <!-- Hidden Case ID -->
                        <div class="row mb-3 d-none">
                            <label class="col-sm-4 col-form-label">Case ID:</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="ticket_id" name="ticket_id" 
                                       value='<c:out value="${ticket._id}"/>' readonly required>
                            </div>
                        </div>
                        
                        <!-- Status Dropdown -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Status:</label>
                            <div class="col-sm-8">
                                <select class="form-select" name="status_id" id="status_id" required>
                                    <option selected disabled value="">-- select status --</option>
                                    <c:choose>
                                        <c:when test="${ticket.message == 1}">
                                            <option value="2">Pending</option>
                                            <option value="1">On Hold</option>
                                            <option value="3">Resolved</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="2">Pending</option>
                                            <option value="1">On Hold</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>
                        </div>
                        
                        <!-- Note -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Note:</label>
                            <div class="col-sm-8">
                                <textarea rows="5" class="form-control" name="txt_note" id="txt_note" 
                                          placeholder="Enter your note here..." required></textarea>
                                <div class="form-text text-muted">Add any additional information about this status update</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Cancel
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Update Status
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:forEach>

<!-- Generate Request Modal -->
<c:forEach items="${ticket_details}" var="ticket" varStatus="appfiles_loop">
    <div class="modal fade modal-blur" id="requestModal" tabindex="-1" aria-labelledby="requestModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-semibold" id="requestModalLabel">
                        <i class="fas fa-file-alt me-2 text-primary"></i>Generate Request
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <form id="requestForm" method="post">
                    <div class="modal-body">
                        <!-- Hidden Fields -->
                        <input type="hidden" name="req_ticket_no" id="req_ticket_no" value="${ticket.ticket_no}">
                        <input type="hidden" name="req_subject" id="req_subject" value="${ticket.subject}">
                        <input type="hidden" name="req_description" id="req_description" value="${ticket.description}">
                        
                        <!-- Ticket No -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Ticket No:</label>
                            <div class="col-sm-8">
                                <input class="form-control bg-light" type="text" name="ticket_no" 
                                       value='<c:out value="${ticket.ticket_no}"/>' readonly required>
                            </div>
                        </div>
                        
                        <!-- Reference No -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Reference No:</label>
                            <div class="col-sm-8">
                                <input class="form-control bg-light" type="text" name="reference_no" 
                                       value='<c:out value="${ticket.reference_id}"/>' readonly required>
                            </div>
                        </div>
                        
                        <!-- To Field -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">
                                To: <span class="text-danger">*</span>
                            </label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="request_to" name="request_to" 
                                       placeholder="Enter recipient" required>
                            </div>
                        </div>
                        
                        <!-- Hidden Case ID -->
                        <div class="row mb-3 d-none">
                            <label class="col-sm-4 col-form-label">Case ID:</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="ticket_id" name="ticket_id" 
                                       value='<c:out value="${ticket._id}"/>' readonly required>
                            </div>
                        </div>
                        
                        <!-- Request Textarea -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">
                                Request: <span class="text-danger">*</span>
                            </label>
                            <div class="col-sm-8">
                                <textarea rows="8" class="form-control" name="duc_request" id="duc_request" 
                                          placeholder="Type your request here..." required></textarea>
                                <div class="form-text text-muted">Maximum 500 characters</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                        <button type="button" id="print_request" class="btn btn-primary">
                            <i class="fas fa-print me-2"></i>Generate
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:forEach>

<!-- Edit Ticket Modal -->
<c:forEach items="${ticket_details}" var="ticket" varStatus="appfiles_loop">
    <div class="modal fade modal-blur" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-semibold" id="editModalLabel">
                        <i class="fas fa-pen me-2 text-primary"></i>Edit Ticket
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <form id="frmUpdateTicket" method="post">
                    <div class="modal-body">
                        <!-- Ticket No -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Ticket No:</label>
                            <div class="col-sm-8">
                                <input class="form-control bg-light" type="text" id="rt_ticket_no" name="rt_ticket_no" 
                                       value='<c:out value="${ticket.ticket_no}"/>' readonly required>
                            </div>
                        </div>
                        
                        <!-- Purpose -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Purpose:</label>
                            <div class="col-sm-8">
                                <select class="form-select" name="rt_purpose" id="rt_purpose">
                                    <option value="" disabled>-- select purpose --</option>
                                    <option value="2" ${ticket.purpose == '2' ? 'selected' : ''}>Service Enquiry</option>
                                    <option value="3" ${ticket.purpose == '3' ? 'selected' : ''}>Service Complainant</option>
                                    <option value="4" ${ticket.purpose == '4' ? 'selected' : ''}>Non-service Complainant</option>
                                </select>
                            </div>
                        </div>
                        
                        <!-- Subject -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Subject:</label>
                            <div class="col-sm-8">
                                <select class="form-select" name="rt_subject" id="rt_subject" required>
                                    <option value="" disabled>-- select subject --</option>
                                    <option value="Payment Issues" ${ticket.subject == 'Payment Issues' ? 'selected' : ''}>Payment Issues</option>
                                    <option value="Delayed" ${ticket.subject == 'Delayed' ? 'selected' : ''}>Delayed</option>
                                    <option value="Upload issues" ${ticket.subject == 'Upload issues' ? 'selected' : ''}>Upload issues</option>
                                    <option value="Queried" ${ticket.subject == 'Queried' ? 'selected' : ''}>Queried</option>
                                    <option value="Other Issues" ${ticket.subject == 'Other Issues' ? 'selected' : ''}>Other Issues</option>
                                </select>
                            </div>
                        </div>
                        
                        <!-- Description -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Description:</label>
                            <div class="col-sm-8">
                                <textarea class="form-control" id="rt_description" name="rt_description" 
                                          rows="3">${ticket.description}</textarea>
                            </div>
                        </div>
                        
                        <!-- Related Service -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Related Service:</label>
                            <div class="col-sm-8">
                                <select class="form-select" id="rt_related_service" name="rt_related_service" required>
                                    <option value="" disabled>-- select service --</option>
                                    <option value="Search" ${ticket.related_service == 'Search' ? 'selected' : ''}>Search</option>
                                    <option value="Stamp Duty" ${ticket.related_service == 'Stamp Duty' ? 'selected' : ''}>Stamp Duty</option>
                                    <option value="Concurrence" ${ticket.related_service == 'Concurrence' ? 'selected' : ''}>Concurrence</option>
                                    <option value="Consent" ${ticket.related_service == 'Consent' ? 'selected' : ''}>Consent</option>
                                    <option value="Plan Approval" ${ticket.related_service == 'Plan Approval' ? 'selected' : ''}>Plan Approval</option>
                                    <option value="Title Registration" ${ticket.related_service == 'Title Registration' ? 'selected' : ''}>Title Registration</option>
                                    <option value="PVLMD Plotting" ${ticket.related_service == 'PVLMD Plotting' ? 'selected' : ''}>PVLMD Plotting</option>
                                    <option value="Reguralization" ${ticket.related_service == 'Reguralization' ? 'selected' : ''}>Reguralization</option>
                                    <option value="Certified True Copy" ${ticket.related_service == 'Certified True Copy' ? 'selected' : ''}>Certified True Copy</option>
                                    <option value="Dispute" ${ticket.related_service == 'Dispute' ? 'selected' : ''}>Dispute</option>
                                    <option value="Composite Plan" ${ticket.related_service == 'Composite Plan' ? 'selected' : ''}>Composite Plan</option>
                                    <option value="General Valuation" ${ticket.related_service == 'General Valuation' ? 'selected' : ''}>General Valuation</option>
                                    <option value="Compensation" ${ticket.related_service == 'Compensation' ? 'selected' : ''}>Compensation</option>
                                    <option value="Deed Registration" ${ticket.related_service == 'Deed Registration' ? 'selected' : ''}>Deed Registration</option>
                                    <option value="Substituted Certificate" ${ticket.related_service == 'Substituted Certificate' ? 'selected' : ''}>Substituted Certificate</option>
                                    <option value="State Land Rent" ${ticket.related_service == 'State Land Rent' ? 'selected' : ''}>State Land Rent</option>
                                    <option value="Other Services" ${ticket.related_service == 'Other Services' ? 'selected' : ''}>Other Services</option>
                                </select>
                            </div>
                        </div>
                        
                        <!-- Reference No -->
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label fw-semibold">Reference No:</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="rt_reference_no" name="rt_reference_no" 
                                       value='<c:out value="${ticket.reference_id}"/>' required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Close
                        </button>
                        <button type="submit" id="btn_update_ticket_details" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Update Ticket
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:forEach>

<!-- Document Preview Modal -->
<div class="modal fade modal-blur" id="elisDocumentPreview" tabindex="-1" aria-labelledby="elisDocumentPreviewLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-semibold" id="elisDocumentPreviewLabel">
                    <i class="fas fa-file-pdf me-2 text-danger"></i>Document Preview
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0">
                <iframe src="" id="elisdovumentpreviewblobfilexx" width="100%" height="600" class="border-0"></iframe>
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Ticket Details Preview Modal -->
<div class="modal fade modal-blur" id="elisDocumentPreviewx" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-semibold" id="exampleModalLabel">
                    Ticket Number: <span class="text-danger" id="r_ticket_no"></span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="card bg-light border-0 mb-4">
                    <div class="card-body">
                        <h6 class="fw-semibold mb-3">
                            <i class="fas fa-sticky-note me-2 text-primary"></i>Notes:
                        </h6>
                        <p class="mb-0" id="r_description"></p>
                    </div>
                </div>
                <div id="attachment_status">
                    <iframe src="" id="elisdovumentpreviewblobfile" width="100%" height="600" class="border-0"></iframe>
                </div>
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- View Timeline Details Modal -->
<div class="modal fade modal-blur" id="viewTimelineDetails" tabindex="-1" aria-labelledby="viewTimelineDetailsLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-semibold" id="viewTimelineDetailsLabel">
                    <i class="fas fa-history me-2 text-info"></i>Updated Information
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form id="update_status_form_with_note" method="post">
                <div class="modal-body">
                    <div class="row mb-3">
                        <label class="col-sm-3 col-form-label fw-semibold">Suit Number:</label>
                        <div class="col-sm-9">
                            <input class="form-control bg-light" type="text" id="up_suit_number" name="up_suit_number" 
                                   value='<c:out value="${case_detail[0].suit_number}"/>' readonly required>
                        </div>
                    </div>
                    
                    <div class="row mb-3 d-none">
                        <label class="col-sm-3 col-form-label">Case ID:</label>
                        <div class="col-sm-9">
                            <input class="form-control" type="text" id="up_case_id" name="up_case_id" readonly required>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <label class="col-sm-3 col-form-label fw-semibold">Note:</label>
                        <div class="col-sm-9">
                            <textarea class="form-control bg-light" rows="5" id="up_notes" readonly></textarea>
                        </div>
                    </div>
                    
                    <input type="hidden" name="updated_by" value="${sessionScope.userid}">
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Add Minute Modal -->
<div class="modal fade modal-blur" id="minuteModal" tabindex="-1" aria-labelledby="minuteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-semibold" id="minuteModalLabel">
                    <i class="fas fa-clock me-2 text-primary"></i>Add Minute
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form id="case_note" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label fw-semibold">Suit Number:</label>
                        <div class="col-sm-12">
                            <input class="form-control bg-light" type="text" id="m_suit_number" name="m_suit_number" 
                                   value='<c:out value="${case_detail[0].suit_number}"/>' readonly required>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <label class="col-sm-4 col-form-label fw-semibold">Notes:</label>
                        <div class="col-sm-12">
                            <textarea class="form-control" rows="5" id="minutes" name="minutes" 
                                      placeholder="Enter your notes here..." required></textarea>
                            <div class="form-text text-muted">Add detailed notes about this case</div>
                        </div>
                    </div>
                    
                    <input type="hidden" id="m_case_id" name="m_case_id" value="${case_detail[0].id}">
                    <input type="hidden" name="created_by" id="created_by" value="${sessionScope.fullname}">
                    <input type="hidden" name="created_by_id" id="created_by_id" value="${sessionScope.userid}">
                </div>
                
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <button type="submit" id="save_minute" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Save Minute
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
  </div>

 

 <script src="legal/includes/bootstrap/js/bootstrap.bundle.js"></script>
 <script type="text/javascript" src="CICA/includes/pages_script/cica_ticket_details.js"></script>
 
  ${param.success == "true" ? "
 
 <script> 
toastr['success']('Replied successfully', 'Success');
</script>
 ":""}
 
 <script>

  document.addEventListener('DOMContentLoaded', function() {
	  const checkbox = document.querySelector("input[name=attach_file]");

	  checkbox.addEventListener("change", (e) => {
	    if (e.target.checked) {
	      document.getElementById("attach_doc").style.display="block";
	    } else {
	      document.getElementById("attach_doc").style.display="none";
	    }
	  });

	  // Function to update count badges
    function updateCountBadges() {
        // Update notes count
        const notesCount = $('#status_note tbody tr').length;
        $('#notesCount').text(notesCount);
        
        // Update replies count
        const repliesCount = $('#replies_tbl tbody tr').length;
        $('#repliesCount').text(repliesCount);
        
        // Update SMS count
        const smsCount = $('#sms_message tbody tr').length;
        $('#smsCount').text(smsCount);
    }

    // Call initially and after table updates
    updateCountBadges();
    
    // If you're using DataTables, you can hook into the draw event
    $('#status_note, #replies_tbl, #sms_message').on('draw.dt', function() {
        updateCountBadges();
    });
	  
  })

//   $('#reply_attached_doc').on('change', function(e) {

//   })

//   let move_to = document.getElementById("move_to");

//   $('#move_to').on("change",function (e) {
// 	e.preventDefault();
// 	let x = $('#move_to').find(":selected").val()

// 	if(x == 1){
// 		$('#reply_attached_doc').addClass('d-none');
// 		console.log('ok')
// 	} else {
// 		$('#reply_attached_doc').removeClass('d-none');
// 	}
//   })

  $('#print_request').on('click', function(e) {
			  e.preventDefault();
			  
			  var req_ticket_no = $('#req_ticket_no').val();
			  var req_subject = $('#req_subject').val();
			  var req_description = $('#req_description').val();
			  var duc_request = $('#duc_request').val();
			  var request_to = $('#request_to').val();
			var reference_no = $('#reference_no').val();
			  
			  $.ajax({
					type : "POST",
					//url : "open_pdffile",
					url: "cica_focal_person_serv",
					// target:'_blank',
					data : {
						//request_type : 'request_to_generate_batch_list',
						request_type: 'print_request',
						ticket_no : req_ticket_no,
						subject: req_subject,
						duc_request: duc_request,
						description: req_description,
						request_to: request_to,
						reference_no: reference_no
					},
					cache : false,
							xhrFields : {
								responseType : 'blob'
							},
							beforeSend : function() {
								// $('#district').html('<img
								// src="img/loading.gif"
								// alt="" width="24"
								// height="24">');
							},
					
					success:function(jobdetails){
						console.log(jobdetails);
					
						//showbatchlist(response);

						//console.log(jobdetails);
								// const arrayBuffer =
								// _base64ToArrayBuffer(jobdetails);
							
								$('#elisDocumentPreview').modal('show');
								$('#elisDocumentPreview')
										.modal(
												{
													backdrop : 'static',
												});

								var blob = new Blob(
										[ jobdetails ],
										{
											type : "application/pdf"
										});
								var objectUrl = URL
										.createObjectURL(blob);
								// window.open(objectUrl);

								$(
										'#elisdovumentpreviewblobfilexx')
										.attr('src',
												objectUrl);

								$(
										'#elisdovumentpreviewblobfilexx')
										.attr('src',
												objectUrl);

								// $('#NotoncaseafterPaymentModalonCase').modal('hide');
						
					}
				});
			  
		  })
		  
		  function showbatchlist(response){
				
				var ticket_no = $('#req_ticket_no').val();
				var file_path =response;
				console.log(file_path);
				
				$.ajax({
							type : "POST",
							url : "cica_focal_person_serv",
							// target:'_blank',
							data : {
								request_type : 'open_request_pdf',
								file_path : file_path,
								ticket_no: ticket_no
							},
							cache : false,
							xhrFields : {
								responseType : 'blob'
							},
							beforeSend : function() {
								// $('#district').html('<img
								// src="img/loading.gif"
								// alt="" width="24"
								// height="24">');
							},
							success : function(jobdetails) {
								console.log(jobdetails);
								// const arrayBuffer =
								// _base64ToArrayBuffer(jobdetails);
							
								$('#elisDocumentPreview').modal('show');
								$('#elisDocumentPreview')
										.modal(
												{
													backdrop : 'static',
												});

								var blob = new Blob(
										[ jobdetails ],
										{
											type : "application/pdf"
										});
								var objectUrl = URL
										.createObjectURL(blob);
								// window.open(objectUrl);

								$(
										'#elisdovumentpreviewblobfilexx')
										.attr('src',
												objectUrl);

								$(
										'#elisdovumentpreviewblobfilexx')
										.attr('src',
												objectUrl);

								// $('#NotoncaseafterPaymentModalonCase').modal('hide');

							}
						});


					}
  
  </script>

  