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

<input type="text" name="regional_code" value="${sessionScope.regional_code}"  hidden/> 

<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Compliance Focal Person</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Manage client tickets and monitor ticket status</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">CAC</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Compliance Focal Person</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->
				 

	
     	<!-- Tickets Overview Cards -->
<div class="row g-4 mb-4">
    <!-- Incoming Tickets Card -->
    <div class="col-xl-4 col-md-6" id="tickets_incoming" style="cursor: pointer;">
        <div class="card h-100 border-0 shadow-sm hover-lift" id="body-bg-1">
            <div class="card-body">
                <div class="d-flex align-items-center mb-3">
                    <div class="flex-shrink-0">
                        <div class="bg-info bg-opacity-10 rounded-circle p-3">
                            <i class="fas fa-sign-in-alt fa-2x text-info"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-uppercase fw-semibold text-muted mb-1">Tickets</h6>
                        <h5 class="card-title mb-0">Incoming</h5>
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                    <span class="text-muted small">Total Tickets</span>
                    <h3 class="mb-0 fw-bold text-info" id="incoming_count">
                        <c:out value="${incoming}"></c:out>
                    </h3>
                </div>
                <!-- <div class="progress mt-3" style="height: 4px;">
                    <div class="progress-bar bg-info" style="width: 75%"></div>
                </div> -->
            </div>
        </div>
    </div>

    <!-- Outgoing Tickets Card -->
    <div class="col-xl-4 col-md-6" id="tickets_outgoing" style="cursor: pointer;">
        <div class="card h-100 border-0 shadow-sm hover-lift" id="body-bg-2">
            <div class="card-body">
                <div class="d-flex align-items-center mb-3">
                    <div class="flex-shrink-0">
                        <div class="bg-danger bg-opacity-10 rounded-circle p-3">
                            <i class="fas fa-sign-out-alt fa-2x text-danger"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-uppercase fw-semibold text-muted mb-1">Tickets</h6>
                        <h5 class="card-title mb-0">Outgoing</h5>
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                    <span class="text-muted small">Total Tickets</span>
                    <h3 class="mb-0 fw-bold text-danger" id="total_count">
                        <c:out value="${outgoing}"></c:out>
                    </h3>
                </div>
                <!-- <div class="progress mt-3" style="height: 4px;">
                    <div class="progress-bar bg-danger" style="width: 45%"></div>
                </div> -->
            </div>
        </div>
    </div>

</div>

<!-- Search Section -->
<div class="row mb-4" style="display: none;" id="focal_person_archived_search">
    <div class="col-md-8">
        <div class="card border-0 shadow-sm">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-12 mb-3">
                        <div class="d-flex gap-4">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                       id="rbtn_search_type1" value="client_name" checked>
                                <label class="form-check-label" for="rbtn_search_type1">
                                    <i class="fas fa-user me-1 text-muted"></i>Name
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                       id="rbtn_search_type2" value="ticket_id">
                                <label class="form-check-label" for="rbtn_search_type2">
                                    <i class="fas fa-ticket-alt me-1 text-muted"></i>Ticket No.
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-12">
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0">
                                <i class="fas fa-search text-muted"></i>
                            </span>
                            <input class="form-control border-start-0 ps-0" 
                                   id="cc_search_value" 
                                   type="text" 
                                   placeholder="Enter search keywords..."
                                   aria-label="Search">
                            <button class="btn btn-primary" type="button" id="btnFPJobSearch">
                                <i class="fas fa-search me-2"></i>Search
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Tickets Details Table -->
<div class="row mb-4">
    <div class="col-md-12">
        <div class="card border-0 shadow-sm">
            <!-- Card Header -->
            <div class="card-header bg-white border-bottom py-3">
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center gap-2">
                        <i class="fas fa-ticket-alt fa-lg text-primary"></i>
                        <h5 class="mb-0 fw-semibold">Tickets Details</h5>
                        <span class="badge bg-light text-dark ms-2" id="card_title"></span>
                    </div>
                    <button class="btn btn-outline-primary btn-sm" id="btnViewRequestlist">
                        <i class="fas fa-print me-2"></i>Print Request
                    </button>
                </div>
            </div>

            <!-- Card Body -->
            <div class="card-body">
                <!-- Legend/Status Indicators -->
                <div class="d-flex flex-wrap gap-4 mb-4 p-3 bg-light rounded-3">
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-white border border-secondary rounded-circle p-2"></span>
                        <small class="text-muted">No replies from DCU/Focal Person</small>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-info rounded-circle p-2"> </span>
                        <small class="text-muted">Sent to CAC Center</small>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-warning rounded-circle p-2"> </span>
                        <small class="text-muted">Sent to DCU</small>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-success rounded-circle p-2"> </span>
                        <small class="text-muted">Replies sent to client</small>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="table table-hover align-middle" id="table_list" width="100%" cellspacing="0">
                        <thead class="bg-light">
                            <tr>
                                <th class="fw-semibold text-muted">#</th>
                                <th class="fw-semibold text-muted">Ticket No.</th>
                                <th class="fw-semibold text-muted">Name</th>
                                <th class="fw-semibold text-muted">Purpose</th>
                                <th class="fw-semibold text-muted">Subject</th>
                                <th class="fw-semibold text-muted text-center">Status</th>
                                <th class="fw-semibold text-muted text-center">Priority</th>
                                <th class="fw-semibold text-muted">Job Number</th>
                                <th class="fw-semibold text-muted">Date Created</th>
                                <th class="fw-semibold text-muted">Noted On</th>
                                <th class="fw-semibold text-muted text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="table_body">
                            <!-- Table data will be populated here -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>


</div>
</div>
 <!-- Reply Modal-->
   <div class="modal fade" id="replyModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Replies</h5>           
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
          </div>
          <form id="replyForm">
          <div class="modal-body">
          
          	<ul class="" id="all_replies">
			      
	             		       
			 </ul>
			 <div class="row m-4">
			 	
				 <label>Reply</label>
				 <textarea rows="5" cols="" class="form-control" name="reply_input" id="reply_input"></textarea>
				 <input type="text" name="ticket_id" hidden />
				 <input type="text" name="userid" value="${sessionScope.userid}" hidden />
				 <input type="text" name="fullname" value="${sessionScope.fullname}" hidden />
				 <input type="text" name="unit_name" value="${sessionScope.unit_name}" hidden />
				 <input type="text" name="unit_id" value="${sessionScope.unit_id}" hidden /> 
 			 </div>
          	</div>
          	<div class="modal-footer">
          		 <button  class="btn btn-success" type="submit" id="reply_ticket" >Reply </button>
            	<button type="button" class="btn btn-secondary"  data-dismiss="modal">Close</button>
          	</div>
          	</form>
        </div>
      </div>
    </div>
<!-- Reply Modal-->


 <div class="modal fade" id="showBatchlist" tabindex="-1" role="dialog"
	aria-labelledby="showBatchlist" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Forward Tickets</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			<div class="card card-body mt-2">
               		<div class="mt-2" id="batch_list"></div>
               	</div>
			</div>
			 	<div class="modal-footer">
			 	<button type="button" class="btn btn-primary" id="btn_focal_print" >Forward</button>
			 	
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>

 <!-- Reply Client Modal-->
   <div class="modal fade" id="replyClientModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Replies To Client</h5>           
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
          </div>
          <form id="clientReplyForm">
          <div class="modal-body">
          
          	<ul class="" id="all_client_replies">
			      
	             		       
			 </ul>
			 <div class="row m-4">
			 	
				 <label>Message to Client</label>
				 <textarea rows="5" cols="" class="form-control" name="reply_input_client" id="reply_input_client"></textarea>
				 <input type="text" name="ticket_id_client" hidden />
				 <input type="text" name="userid_client" value="${sessionScope.userid}" hidden />
				 <input type="text" name="fullname_client" value="${sessionScope.fullname}" hidden />
				 <input type="text" name="unit_name_client" value="${sessionScope.unit_name}" hidden />
				 <input type="text" name="unit_id_client" value="${sessionScope.unit_id}" hidden /> 
 			 </div>
          	</div>
          	<div class="modal-footer">
          		 <button  class="btn btn-success" type="submit" id="client_reply_ticket" >Send </button>
            	<button type="button" class="btn btn-secondary"  data-dismiss="modal">Close</button>
          	</div>
          	</form>
        </div>
      </div>
    </div>
<!-- Reply Client Modal-->
<!-- Forward Modal-->
   <div class="modal fade" id="forwardModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Forward</h5>           
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
          </div>
          <form id="forwardForm">
          <div class="modal-body">
			 <div class="row m-4">
			 	 <label>Ticket No.</label>
			 	 <input class="form-control" type="text" name="forward_ticket_id" id="forward_ticket_id" readonly />
 			 </div>
 			 <hr />
              			<div class="row mt-4">
              				<div class="col-md-2">
              					<span>Division<span class="text-danger">*</span>:</span>
              				</div>
              				<div class="col-md-6">
              					<select class="form-control" aria-label="Default select example" name="division" id="division" required>
				                <option value="" disabled selected>-- select --</option>
				                <option value="PVLMD">PVLMD</option>
								<option value="LRD">LRD</option>
								<option value="LVD">LVD</option>	
								<option value="SMD">SMD</option>	
								<option value="CORPORATE">CORPORATE</option>		
				              </select>
              				</div>
              			</div>
		                			
               			<div class="row mt-4">
               				<div class="col-md-2">
               					<span>Region<span class="text-danger">*</span>:</span>
               				</div>
               				<div class="col-md-6">
               					<select class="form-control" aria-label="Default select example" name="region" id="region" required>
					                <option disabled selected>-- select --</option>
					                <option value="11">Greater Accra</option>
									<option value="14">Western</option>
									<option value="19">Volta</option>	
									<option value="12">Eastern</option>	
									<option value="13">Ashanti</option>	
									<option value="15">Central</option>	
									<option value="18">Northern</option>	
									<option value="16">Upper East</option>	
									<option value="17">Upper West</option>	
									<option value="10">Tema</option>
									<option value="10">Oti</option>	
									<option value="23">Bono East</option>	
									<option value="24">Ahafo</option>	
									<option value="23">Bono</option>	
									<option value="25">North East </option>	
									<option value="26">Savannah</option>
									<option value="21">Western North</option>	
					              </select>
               				</div>
               			</div>
		                			
		                		
		                			
               			<div class="row mt-4">
               				<div class="col-md-2">
               					<span>Unit <span class="text-danger">*</span>:</span>
               				</div>
               				<div class="col-md-6">
               					   <input class="form-control" id="unit"  name="unit" type="text" autocomplete="off" 
                                list="listofunits" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
       						<datalist id="listofunits"></datalist>
               				</div>
               			</div>
          	</div>
          	<div class="modal-footer">
          		 <button  class="btn btn-success" type="submit" id="forward_ticket" >Update</button>
            	<button type="button" class="btn btn-secondary"  data-dismiss="modal">Close</button>
          	</div>
          	</form>
        </div>
      </div>
    </div>
<!-- Forward Modal-->
<!-- Status Client Modal-->
   <div class="modal fade" id="updateStatusModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Update Status</h5>           
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
          </div>
          <form id="updateStatusForm">
          <div class="modal-body">
			 <div class="row m-4">
			 	 <label>Ticket No.</label>
			 	 <input class="form-control" type="text" name="status_ticket_id" id="status_ticket_id" readonly />
 			 </div>
 			  <div class="row m-4">
			 	 <label>Status</label>
			 	 <select class="form-control" name="status_select" id="status_select">
			 	 		<option disabled selected>-- select --</option>
			 	 		<option value="open">Open</option>
			 	 		<option value="hold">Hold</option>
			 	 		<option value="pending">Pending</option>
			 	 		<option value="resolved">Resolved</option>
			 	 </select>
 			 </div>
          	</div>
          	<div class="modal-footer">
          		 <button  class="btn btn-success" type="submit" id="update_status" >Update</button>
            	<button type="button" class="btn btn-secondary"  data-dismiss="modal">Close</button>
          	</div>
          	</form>
        </div>
      </div>
    </div>


	<!-- Generate Request Modal -->
<div class="modal fade modal-blur" id="showRequestlist" tabindex="-1" aria-labelledby="showRequestlistLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-semibold" id="showRequestlistLabel">
                    <i class="fas fa-file-alt me-2 text-primary"></i>
                    Generate Request
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="container-fluid px-0">
                    <!-- To Field -->
                    <div class="row g-3 mb-3">
                        <div class="col-sm-4">
                            <label for="request_to" class="col-form-label fw-semibold">
                                To: <span class="text-danger">*</span>
                            </label>
                        </div>
                        <div class="col-sm-8">
                            <input type="text" 
                                   class="form-control" 
                                   id="request_to" 
                                   name="request_to" 
                                   placeholder="Enter recipient"
                                   required>
                            <div class="invalid-feedback">
                                Please enter the recipient.
                            </div>
                        </div>
                    </div>

                    <!-- Request Field -->
                    <div class="row g-3 mb-3">
                        <div class="col-sm-4">
                            <label for="duc_request" class="col-form-label fw-semibold">
                                Request: <span class="text-danger">*</span>
                            </label>
                        </div>
                        <div class="col-sm-8">
                            <textarea class="form-control" 
                                      id="duc_request" 
                                      name="duc_request" 
                                      rows="6" 
                                      placeholder="Type your request here..."
                                      required></textarea>
                            <div class="invalid-feedback">
                                Please enter your request.
                            </div>
                            <div class="form-text text-muted">
                                Maximum 500 characters
                            </div>
                        </div>
                    </div>

                    <!-- Request List Card -->
                    <div class="card border-0 bg-light mt-4">
                        <div class="card-body">
                            <h6 class="card-title fw-semibold mb-3">
                                <i class="fas fa-list me-2 text-muted"></i>
                                Request List
                            </h6>
                            <div id="request_list" class="p-2">
                                <!-- Request items will be dynamically added here -->
                                <p class="text-muted text-center mb-0 py-3 small">
                                    <i class="fas fa-info-circle me-1"></i>
                                    No requests added yet
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-primary" id="btn_print_bulk_request">
                    <i class="fas fa-print me-2"></i>
                    Generate
                </button>
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>
                    Close
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Status Client Modal-->

<script>
	function deleteRow(r) {
	  var i = r.parentNode.parentNode.rowIndex;
	  document.getElementById("batchTable").deleteRow(i);
	}
</script>
