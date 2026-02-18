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

<!-- Begin Page Content -->
 <c:forEach items="${ticket_details}" var="ticket"  varStatus="appfiles_loop"> 
    <div class="pagetitle">
      <button  class="btn btn-danger" 
					><a style=" text-decoration: none" class="text-white" href="${pageContext.request.contextPath}/cica_replies">
				<i class="fas fa-arrow-left me-1"></i>Go Back</a>
					</button>	
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
  <div class="col-lg-4">
    <!-- Send Message Card -->
    <div class="card border-0 shadow-sm sticky-message-card">
        <div class="card-header bg-white border-bottom py-3">
            <div class="d-flex align-items-center gap-2">
                <div class="bg-primary bg-opacity-10 rounded-circle p-2">
                    <i class="fas fa-comment-dots text-primary"></i>
                </div>
                <h5 class="card-title mb-0 fw-semibold">
                    Send Message to Client
                </h5>
            </div>
        </div>

        <form id="send_reply_to_client" method="post" class="needs-validation" novalidate>
            <div class="card-body">
                <c:forEach items="${ticket_details}" var="ticket" varStatus="appfiles_loop">
                    <!-- Hidden Fields -->
                    <input type="hidden" name="ticket_id" value="${ticket._id}">
                    <input type="hidden" name="ticket_no" value="${ticket.ticket_no}">
                    <input type="hidden" name="request_type" value="reply_to_ticket">
                    <input type="hidden" name="sent_by_id" value="${sessionScope.userid}">
                    <input type="hidden" name="sent_by" value="${sessionScope.fullname}">

                    <!-- Contact Type Selection -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold">
                            <i class="fas fa-address-card me-1 text-muted"></i>
                            Contact Type <span class="text-danger">*</span>
                        </label>
                        <select class="form-select" id="contact_by" name="client_contact" required>
                            <option value="" selected disabled>-- Select contact method --</option>
                            <option value="SMS" class="py-2">
                                <i class="fas fa-sms me-2 text-primary"></i>SMS
                            </option>
                            <!-- <option value="Email">
                                <i class="fas fa-envelope me-2 text-danger"></i>Email
                            </option> -->
                        </select>
                        <div class="invalid-feedback">Please select a contact method.</div>
                    </div>

                    <!-- Phone Input (Visible by default) -->
                    <div class="mb-4" id="phone_div">
                        <label class="form-label fw-semibold">
                            <i class="fas fa-phone-alt me-1 text-muted"></i>
                            Phone Number
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="fas fa-phone text-primary"></i>
                            </span>
                            <input class="form-control border-start-0 ps-0 bg-light" 
                                   type="tel" 
                                   id="client_phone" 
                                   name="client_phone" 
                                   value="${ticket.client_phone}" 
                                   readonly>
                        </div>
                        <div class="form-text text-muted small">
                            <i class="fas fa-info-circle me-1"></i>
                            Client's registered phone number
                        </div>
                    </div>

                    <!-- Email Input (Hidden by default) -->
                    <div class="mb-4 d-none" id="email_div">
                        <label class="form-label fw-semibold">
                            <i class="fas fa-envelope me-1 text-muted"></i>
                            Email Address
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="fas fa-envelope text-danger"></i>
                            </span>
                            <input class="form-control border-start-0 ps-0 bg-light" 
                                   type="email" 
                                   id="client_email" 
                                   name="client_email" 
                                   value="${ticket.client_email}" 
                                   readonly>
                        </div>
                        <div class="form-text text-muted small">
                            <i class="fas fa-info-circle me-1"></i>
                            Client's registered email address
                        </div>
                    </div>

                    <!-- Message Composition -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold">
                            <i class="fas fa-pencil-alt me-1 text-muted"></i>
                            Message <span class="text-danger">*</span>
                        </label>
                        <div class="position-relative">
                            <textarea class="form-control" 
                                      id="message" 
                                      name="message" 
                                      rows="8" 
                                      placeholder="Type your message here..."
                                      required
                                      maxlength="500"></textarea>
                            <div class="invalid-feedback">Please enter a message.</div>
                            <div class="form-text text-muted small position-absolute bottom-0 end-0 mb-2 me-3">
                                <span id="charCount">0</span>/500
                            </div>
                        </div>
                        
                        <!-- Message Templates (Quick Replies) -->
                        <!-- <div class="mt-2">
                            <span class="small text-muted me-2">Quick templates:</span>
                            <button type="button" class="btn btn-sm btn-outline-primary me-1 mb-1 quick-reply" data-template="Thank you for reaching out. Your ticket has been received and will be processed shortly.">
                                Acknowledgement
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-warning me-1 mb-1 quick-reply" data-template="Your ticket is currently being processed. We will update you shortly.">
                                In Progress
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-success mb-1 quick-reply" data-template="Your issue has been resolved. Thank you for your patience.">
                                Resolved
                            </button>
                        </div> -->
                    </div>

                   

                    <!-- Submit Button -->
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg" id="sendMessageBtn">
                            <i class="fas fa-paper-plane me-2"></i>
                            Send Message
                            <span class="spinner-border spinner-border-sm d-none ms-2" role="status" aria-hidden="true"></span>
                        </button>
                    </div>

                    <!-- Success Message (Hidden by default) -->
                    <!-- <div class="alert alert-success mt-3 d-none" id="successMessage">
                        <i class="fas fa-check-circle me-2"></i>
                        Message sent successfully!
                    </div> -->
                </c:forEach>
            </div>
        </form>
    </div>
</div>
  </div>
</section>

</c:forEach>
</div>
</div>

<!-- End Page Content -->

<!-- Attachment Modal -->
<c:forEach items="${ticket_details}" var="ticket"  varStatus="appfiles_loop">
  <div class="modal fade" id="updateStatusModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Update Status</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="update_status_form" method="post" >
        
        <div class="modal-body" style="font-size: small;">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label"><h6>Ticket No:</h6></label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="ticket_no" name="ticket_no" value='<c:out value="${ticket.ticket_no}"></c:out>' readonly required>
            </div>
		  </div>
		  
		  <div class="row mb-3" hidden="">
			<label for="inputNumber" class="col-sm-4 col-form-label">Case ID:</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="ticket_id" name="ticket_id" value='<c:out value="${ticket._id}"></c:out>' readonly required>
            </div>
		  </div>
		  
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label"><h6>Status:</h6></label>
			<div class="col-sm-8">
               <select class="form-control" aria-label="Default select example" name="status_id" id="status_id"  required>
                 <option selected disabled>-- select --</option>
                 <option value="2">Pending</option>
                  <option value="1">On Hold</option>
                  <option value="3">Resolved</option>
			  </select>
            </div>
		  </div>
		    <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label"><h6>Note:</h6></label>
			<div class="col-sm-8">
		        <textarea rows="" cols="" class="form-control" name="txt_note" id="txt_note" required></textarea>
            </div>
		  </div>
		   <input type="text" name="updated_by_id" value="${sessionScope.userid}" hidden />
			<input type="text" name="updated_by" value="${sessionScope.fullname}" hidden />
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Update</button>
        </div>
       </form>
      </div>
    </div>
  </div>
</c:forEach>
<!-- Attachment Modal  -->
  <div class="modal fade" id="elisDocumentPreview" tabindex="-1" role="dialog"
	aria-labelledby="elisDocumentPreview" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Document Preview</h5>
				<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
												
												<iframe src=""  id="elisdovumentpreviewblobfilexx" width="100%" height="600"></iframe>
							
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>

<div class="modal fade" id="elisDocumentPreviewx" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Ticket Number: <span class="text-danger" id="r_ticket_no"></span></h5>
				<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
				<div class="card card-body mb-4">
				<b>Notes:</b>
					 <span class="" id="r_description"></span>
				</div>
				<div id="attachment_status">								
				   <iframe src=""  id="elisdovumentpreviewblobfile" width="100%" height="600"></iframe>
					</div>		
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>


 
 
  ${param.success == "true" ? "
 
 <script> 
toastr['success']('Replied successfully', 'Success');
</script>
 ":""}
 
 <!-- <script>

  document.addEventListener('DOMContentLoaded', function() {
	  const checkbox = document.querySelector("input[name=attach_file]");

	  checkbox.addEventListener("change", (e) => {
	    if (e.target.checked) {
	      document.getElementById("attach_doc").style.display="block";
	    } else {
	      document.getElementById("attach_doc").style.display="none";
	    }
	  });
	  
  })
  
  </script> -->
  
  