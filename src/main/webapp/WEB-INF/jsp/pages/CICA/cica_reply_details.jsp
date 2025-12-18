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
<jsp:include page="../legal/includes/header.jsp"></jsp:include>

<!-- Begin Page Content -->
<div class="container-fluid">
 <c:forEach items="${ticket_details}" var="ticket"  varStatus="appfiles_loop"> 
    <div class="pagetitle">
      <!-- <h4>DUC - CAC TICKETS</h4> --><br>
      <div class=" ">
		                   
			         <nav>
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
		         
		                  <li class="breadcrumb-item active">Reply Details</li>
		                  <button  class="btn btn-danger float-right" 
				                    style="position:absolute; right:30px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;"
				                    ><a style=" text-decoration: none" class="text-white" href="${pageContext.request.contextPath}/cica_replies">
				      				Go Back</a>
				      			  </button>
		                  
		                </ol>
	               </nav>
                    
		                    
		</div>	
    </div>  

    <section class="section">
      <div class="row">
  
        <div class="col-lg-8">

          <div class="card">
            <div class="card-body">
             
              <div class="card-header bg-dark text-white">
				  <h6 class="card-title">Ticket No.:<strong> ${ticket.ticket_no} </strong> - [<span class="text-warning me-2 ms-2">
				  <c:choose>
					    <c:when test="${ticket.purpose == 1}">
					        Service Enquiry 
					    </c:when>   
					    <c:when test="${ticket.purpose == 3}">
					        Service Complaint
					    </c:when>  
					    <c:otherwise>
					        Non-Service Complaint
					    </c:otherwise>
					</c:choose>
				  </span>]</h6>		
			 </div>
				<input type="text" class="form-control" name="suit_number" id="suit_number" value="${cases.suit_number}" hidden>
				<input type="text" class="form-control" name="case_id" id="case_id" value="${cases.id}" hidden>
              <!-- Accordion without outline borders -->
              
              <div class="accordion" id="accordionCaseDetails">
               <div class="accordion-item">
	                 <h2 class="accordion-header" id="parties">
		                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse8" aria-expanded="true" aria-controls="collapse1">
	            			Client Details
		                </button>
	                 </h2>
	                  <div id="collapse8" class="accordion-collapse collapse" aria-labelledby="parties" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                     <%--  <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop"> --%>
	                     <div class="card">
	                		<div class="card-body">
	                    	<div class="row mb-4">
	                    		<div class="col-md-12">
	                    			<div class="row">
			                    		<div class="col-md-5">
			                    			<span>Name:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.client_name}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Email:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.client_email}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Phone:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.client_phone}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Address:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.client_address}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Contact Client By:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.contact_type}</span>
				                    	</div>
			                    	</div>
		                    	</div>
	                    	</div>
						  	<%-- </c:forEach> --%>
						  	</div>
	                    	</div>
	                    </div>
	                  </div>
	                </div>
                <div class="accordion-item">
                
	                   <h2 class="accordion-header" id="parties">
		                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="true" aria-controls="collapse1">
	            			Complaint Details
		                </button>
	                 </h2>
                 
                  <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="parties" data-bs-parent="#accordionCaseDetails" >
                    <div class="accordion-body">
	              <div class="card">
	                <div class="card-body">
	                	 <div class="row mb-4">
	                    		<div class="col-md-12">
	                    			<div class="row">
			                    		<div class="col-md-5">
			                    			<span>Purpose:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<%-- <span>${ticket.purpose == 1 ? 'Service Enquiry' : 'Service Complaint'}</span> --%>
			                    			<c:choose>
											    <c:when test="${ticket.purpose == 1}">
											        Service Enquiry 
											    </c:when>   
											    <c:when test="${ticket.purpose == 3}">
											        Service Complaint
											    </c:when>  
											    <c:otherwise>
											        Non-Service Complaint
											    </c:otherwise>
											</c:choose>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Subject:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.subject}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Description:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.description}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Priority:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.priority}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Division:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.division}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Region:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.region_name}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Related Service:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.related_service}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Reference Number:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${ticket.reference_id}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Status:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<%-- <span>${ticket.purpose == 1 ? 'Service Enquiry' : 'Service Complaint'}</span> --%>
			                    			<c:choose>
											    <c:when test="${ticket.status == 0}">
											       <button class="btn btn-info disabled" style="border-radius: 25px"> Open </button>
											    </c:when>   
											    <c:when test="${ticket.status == 2}">
											        <button class="btn btn-warning disabled" style="border-radius: 25px"> Pending </button>
											    </c:when>
											     <c:when test="${ticket.status == 1}">
											        <button class="btn btn-danger disabled" style="border-radius: 25px"> On Hold </button>
											    </c:when>   
											    <c:when test="${ticket.status == 3}">
											        <button class="btn btn-success disabled" style="border-radius: 25px"> Resolved </button>
											    </c:when>
											</c:choose>
				                    	</div>
			                    	</div>
		                    	</div>
	                    	</div>
	                  
	                </div>
	              </div>
                    </div>
                  </div>
                </div>
                
                <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
		                      Notes
		                    </button>
		                  </h2>
	                  <div id="collapse5" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive">
		                    	<table class="table" id="status_note" width="100%" cellspacing="0" width="100%" cellspacing="0">
						 		 	<thead>
						 				<tr>
						 					<th>Note</th>
						 					<th>Updated Status</th>
						 					<th>Updated By</th>
						 					<th>Updated On</th>
						 				</tr>
						 			</thead>
						 			<tbody>
						 		  	</tbody>    
		 		  				</table>
	 		  				</div>
	 		  				
	                    </div>
	                  </div>
	                </div>
	                
	                <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse6" aria-expanded="false" aria-controls="collapse5">
		                      Replies
		                    </button>
		                  </h2>
	                  <div id="collapse6" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive">
				                    	<table class="table table-striped" id="one_replies_tbl" width="100%" cellspacing="0">
								 		 	<thead>
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
								 			<tbody>
								 		  	</tbody>    
				 		  				</table>
				 		  			</div>
	                    </div>
	                  </div>
	                </div>   
	                
	                <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse10" aria-expanded="false" aria-controls="collapse5">
		                      Sent SMS
		                    </button>
		                  </h2>
	                  <div id="collapse10" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive">
				                    	<table class="table table-striped" id="sms_message" width="100%" cellspacing="0">
								 		 	<thead>
								 				<tr>
								 					<th>Message</th>
								 					<!-- <th class="text-center">Attachment</th> -->
								 					<th>Client Contact</th>
								 					<th>Sent By</th>
								 					<th>Sent Date</th>
								 					<!-- <th>Replied On</th>
								 					<th class="text-end">Action</th> -->
								 				</tr>
								 			</thead>
								 			<tbody>
								 		  	</tbody>    
				 		  				</table>
				 		  			</div>
	                    </div>
	                  </div>
	                </div> 

            </div>
     	   <!-- End Accordion without outline borders  this is just a test that i'm just doing-->

        </div>
      </div>
    </div>
   <div class="col-lg-4">

          <!-- Recent Activity -->
          <form id="send_reply_to_client" method="post">
           <div class="card">
          	<div class="card-header"><h5>Send Message To Client</h5></div>
            <div class="card-body">
             <c:forEach items="${ticket_details}" var="ticket"  varStatus="appfiles_loop">
             <div class="row mb-4">
            
            <label>Contact Type:</label>
            <div class="col-md-12">
              <select class="form-control" id="contact_by" name="client_contact">
              	<option selected disabled value="">-- select --</option>
              	<option value="SMS">SMS</option>
              	<!-- <option value="Email">Email</option> -->
              </select>
            </div>

		 </div>
            <div class="row mb-4" id="phone_div">
            
            <label>Phone:</label>
            <div class="col-md-12">
              <input class="form-control" type="tel" id="client_phone" name="client_phone" readonly value="${ticket.client_phone}" >
            </div>

		 </div>
		 <div class="row mb-4" id="email_div">
     
            <label>Email:</label>
            <div class="col-md-12">
              <input class="form-control" type="email" id="client_email" name="client_email" readonly value="${ticket.client_email}" >
            </div>

		 </div>
				  <label>Message:</label>
				   <div class="row mb-3">
				  
				   <input type="text" class="form-control" id="ticket_id" name="ticket_id" value="${ticket._id}" hidden />
	                      	<input type="text" id="ticket_no" name="ticket_no" value="${ticket.ticket_no}" hidden />
	                      	<input type="text" id="request_type" name="request_type" value="reply_to_ticket" hidden />
				   
				   
		            <div class="col-sm-12">
		              <textarea class="form-control" rows="10" id="message" name="message" readonly required></textarea>
		            </div>
		          </div>
		          <%-- <label>Attachment</label>
				  <div class="row mb-3">
					<div class="col-sm-12">
		              <input class="form-control" type="file" id="note_attachment" name="note_attachment">
		            </div>
				  </div> --%>
				  
				  <%-- <div class="row mt-4">
		                				<div class="col-md-12">
		                					<span>Would a file be attached ?:</span>
		                					<input type="checkbox" class="form-check-input ml-4" name="attach_file" id="attach_file"  />
		                				</div>
		                				
		                			</div> --%>
		                			
									 <input type="text" name="sent_by_id" value="${sessionScope.userid}" hidden />
			<input type="text" name="sent_by" value="${sessionScope.fullname}" hidden />
									 
				  
				  <div class="d-flex justify-content-end">
		                 <button type="submit" class="btn btn-success"><i class="fas fa-envelope"></i>Send</button>
		             </div>
		             
            </c:forEach>
            </div>
          </div>
          </form>
          <!-- End Recent Activity -->
			<!-- End Recent Activity -->
         


        </div><!-- End Right side columns -->
  </div>
</section>

</c:forEach>
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

<div class="modal fade" id="viewTimelineDetails" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Updated Info.</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="update_status_form_with_note" method="post" >
        
        <div class="modal-body" style="font-size: small;">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-3 col-form-label">Suit Number:</label>
			<div class="col-sm-9">
              <input class="form-control" type="text" id="up_suit_number" name="up_suit_number" value='<c:out value="${case_detail[0].suit_number}"></c:out>' readonly required>
            </div>
		  </div>
		  
		  <div class="row mb-3" hidden="">
			<label for="inputNumber" class="col-sm-3 col-form-label">Case ID:</label>
			<div class="col-sm-9">
              <input class="form-control" type="text" id="up_case_id" name="up_case_id" readonly required>
            </div>
		  </div>
		  
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-3 col-form-label">Note:</label>
			<div class="col-sm-9">
               <textarea class="form-control" rows="5" id="up_notes" readonly></textarea>
            </div>
		  </div>
		   <input type="text" name="updated_by" value="${sessionScope.userid}" hidden />

        </div>
        <%-- <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Update</button>
        </div> --%>
       </form>
      </div>
    </div>
  </div>
  
   <div class="modal fade" id="minuteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Add Minute</h5>
           <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="case_note" method="post" enctype="multipart/form-data">
        
        <div class="modal-body" style="font-size: small;">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
			<div class="col-sm-12">
              <input class="form-control" type="text" id="m_suit_number" name="m_suit_number" value='<c:out value="${case_detail[0].suit_number}"></c:out>' readonly required>
            </div>
		  </div>
		  <%-- <div class="row mb-3">
		  	<label for="inputNumber" class="col-sm-4 col-form-label">Subject</label>
		  
			<div class="col-sm-12">
              <input class="form-control" type="text" id="subject" name="subject"  required>
            </div>
		  </div> --%>
		  <div class="row mb-3">
		  <label for="inputNumber" class="col-sm-4 col-form-label">Notes</label>
		   
            <div class="col-sm-12">
              <textarea class="form-control" rows="5"  id="minutes" name="minutes" required></textarea>
            </div>
          </div>
          <input class="form-control" type="text" id="m_case_id" name="m_case_id" value="${case_detail[0].id}" hidden >
			<input type="text" name="created_by" id="created_by" value="${sessionScope.fullname}" hidden>
			<input type="text" name="created_by_id" id="created_by_id" value="${sessionScope.userid}" hidden>
        </div>
        <div class="modal-footer">
          <button type="submit" id="save_minute" class="btn btn-primary">Submit</button>
        </div>
       </form>
      </div>
    </div>
  </div>

 
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>
 <script src="legal/includes/bootstrap/js/bootstrap.bundle.js"></script>
 <script type="text/javascript" src="CICA/includes/pages_script/cica_reply_details.js"></script>
 
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
  
  