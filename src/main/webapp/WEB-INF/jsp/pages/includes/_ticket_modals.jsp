<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
 <jsp:useBean id="now" class="java.util.Date"/>  

  <!-- New Ticket Modal -->
<div class="modal" tabindex="-1" id="newTicket">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Service Ticket</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
              <p>Please provide the details of problem</p><hr>
        <form action="" method="post" enctype="multipart/form-data" id="addTicket" class="needs-validation" novalidate >
					
					<input type="text" name="userId" id="userId" hidden="">
					<input type="text" name="ticketId" id="ticketId"  hidden="">
					
					<div class="form-row mb-3">
						<div class="col-4">
							<label for="priority">Priority</label> 
							<select id="priority" name="priority" class="form-control">
								<option value="Low">Choose...</option>
								<option value="High">High</option>
								<option value="Medium">Medium</option>
								<option value="Low">Low</option>
							</select>
						</div>
						<div class="col-6">
                        	<label for="unit">Unit</label> 
                        	<select name="unit" id="unit" class="form-control" required>
								<c:forEach items="${issues}" var="modalunit"> 
								<option value="${modalunit}">${modalunit}</option>
								</c:forEach>
							</select>
						</div>
					</div>
						
					<div class="form-row mb-3">
							<label for="subject">Subject</label> 
							<input type="text" class="form-control" id="subject" name="subject" placeholder="Subject" required>
					</div>
					
					<div class="form-row mb-3">
							<label for="related_service">Related Service</label> 
							<select name="related_service" id="related_service" class="form-control" required>
								<c:forEach items="${jobs}" var="job"> 
								<option value="${job}">${job}</option>
								</c:forEach>
								<option value="none">None</option>
							</select>
					</div>
					
					<div class="form-row mb-3">
						<label for="unit_message">Message</label> 
						<textarea class="form-control" rows="5" id="unit_message" required></textarea>
					</div>
					<div class="form-row mb-3">
						<label for="formFileMultiple" class="form-label">Attachments
						<p>Allowed file types: jpg, jpeg, png, pdf, zip</p>
						</label>
						<input class="form-control" type="file" id="formFileMultiple" name="file" multiple />
					</div>
 
					<div class="col-md-6 offset-md-3">
						<button type="submit" class="btn btn-primary btn-sm btn-block" id="addTicketBtn">Create Ticket</button>
					</div>
				</form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<!-- End of Modal -->

<!-- Open Reply Modal -->
<div class="modal" tabindex="-1" id="replyModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Service Ticket</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form action="" method="post" enctype="multipart/form-data" id="addTicket" class="needs-validation" novalidate >
					<div class="form-row mb-3">
					    <div class="col-4">
					      <label for="ticketId">Ticket</label>
					      <input type="text" class="form-control" name="ticketId" id="ticketId"  disabled>
					    </div>
					    <div class="col-5">
					    	<label for="related_service">Related Service</label>
					      <input type="text" class="form-control" id="related_service"  name="related_service" disabled>
					    </div>		 
					
						<div class="col-3">
							<label for="priority">Priority</label> 
							<select id="priority" name="priority" class="form-control">
								<option value="Low">Choose...</option>
								<option value="High">High</option>
								<option value="Medium">Medium</option>
								<option value="Low">Low</option>
							</select>
						</div>
					</div>
						
					<div class="form-row mb-3">
							<label for="subject">Subject</label> 
							<input type="text" class="form-control" id="subject" name="subject" placeholder="Subject" disabled>
					</div>
					
					<div class="form-row mb-3">
						<label for="issue_message">Message</label> 
						<textarea class="form-control" rows="5" id="issue_message" disabled></textarea>
					</div>
					<div class="form-row mb-3">
						<label for="reply_message">Reply</label> 
						<textarea class="form-control" rows="5" id="reply_message"></textarea>
					</div>	
					<div class="form-row mb-3">
						</label>
						<input class="form-control" type="file" id="formFileMultiple" name="file" multiple />
					</div>	
				</form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary" id="reply">Reply</button>		
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<!-- End of Modal -->
