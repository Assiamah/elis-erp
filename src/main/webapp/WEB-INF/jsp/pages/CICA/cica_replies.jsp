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
                    <h1 class="page-title fw-medium fs-18 mb-1">CAC Replies</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Manage CAC replies and monitor reply status</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">CAC</a></li>
                    <li class="breadcrumb-item active" aria-current="page">CAC Replies</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->
				 
<!-- Begin Page Content -->
  
		
	
	<!-- Stats Cards Section -->
<div class="row g-4 mb-4">
    <!-- Replies Tickets Card -->
    <div class="col-xl-4 col-md-6" id="tickets_replies" style="cursor: pointer;">
        <div class="card border-0 shadow-sm hover-lift h-100" id="body-bg-1">
            <div class="card-body">
                <div class="d-flex align-items-center mb-3">
                    <div class="flex-shrink-0">
                        <div class="bg-info bg-opacity-10 rounded-3 p-3">
                            <i class="fas fa-reply fa-2x text-info"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-uppercase fw-semibold text-muted mb-1">Tickets</h6>
                        <h5 class="card-title mb-0">Replies</h5>
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                    <span class="text-muted small">Pending Replies</span>
                    <h3 class="mb-0 fw-bold text-info" id="incoming_count">
                        <c:out value="${replies}"/>
                    </h3>
                </div>
                <!-- <div class="progress mt-3" style="height: 6px;">
                    <div class="progress-bar bg-info" style="width: 75%"></div>
                </div> -->
            </div>
        </div>
    </div>

    <!-- Archived Tickets Card -->
    <div class="col-xl-4 col-md-6" id="tickets_archived" style="cursor: pointer;">
        <div class="card border-0 shadow-sm hover-lift h-100" id="body-bg-2">
            <div class="card-body">
                <div class="d-flex align-items-center mb-3">
                    <div class="flex-shrink-0">
                        <div class="bg-danger bg-opacity-10 rounded-3 p-3">
                            <i class="fas fa-archive fa-2x text-danger"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-uppercase fw-semibold text-muted mb-1">Tickets</h6>
                        <h5 class="card-title mb-0">Archived</h5>
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                    <span class="text-muted small">Total Archived</span>
                    <h3 class="mb-0 fw-bold text-danger" id="total_count">
                        <c:out value="${archived}"/>
                    </h3>
                </div>
                <!-- <div class="progress mt-3" style="height: 6px;">
                    <div class="progress-bar bg-danger" style="width: 45%"></div>
                </div> -->
            </div>
        </div>
    </div>

    <!-- Add a third card for balance or additional stats -->
    <!-- <div class="col-xl-4 col-md-6" id="tickets_stats">
        <div class="card border-0 shadow-sm hover-lift h-100 bg-gradient-primary">
            <div class="card-body text-white">
                <div class="d-flex align-items-center mb-3">
                    <div class="flex-shrink-0">
                        <div class="bg-white bg-opacity-20 rounded-3 p-3">
                            <i class="fas fa-chart-line fa-2x"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-white-50 text-uppercase fw-semibold mb-1">Overview</h6>
                        <h5 class="mb-0">Resolution Rate</h5>
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                    <span class="text-white-50 small">Last 30 days</span>
                    <h3 class="mb-0 fw-bold">85%</h3>
                </div>
                <div class="progress mt-3 bg-white bg-opacity-25" style="height: 6px;">
                    <div class="progress-bar bg-white" style="width: 85%"></div>
                </div>
            </div>
        </div>
    </div> -->
</div>

<!-- Search Section -->
<div class="row mb-4" id="replies_archived_search" style="display: none;">
    <div class="col-8">
        <div class="card border-0 shadow-sm">
            <div class="card-body">
                <div class="row g-4">
                    <!-- Search Type Radio Buttons -->
                    <div class="col-12">
                        <label class="fw-semibold text-muted mb-3 d-block">Search by:</label>
                        <div class="d-flex flex-wrap gap-4">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                       id="rbtn_search_type1" value="client_name" checked>
                                <label class="form-check-label" for="rbtn_search_type1">
                                    <i class="fas fa-user me-1 text-primary"></i>
                                    Client Name
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                       id="rbtn_search_type2" value="ticket_id">
                                <label class="form-check-label" for="rbtn_search_type2">
                                    <i class="fas fa-ticket-alt me-1 text-success"></i>
                                    Ticket No.
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                       id="rbtn_search_type3" value="job_no">
                                <label class="form-check-label" for="rbtn_search_type3">
                                    <i class="fas fa-briefcase me-1 text-warning"></i>
                                    Job No.
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Search Input -->
                    <div class="col-12">
                        <div class="row g-3">
                            <div class="col-md-7">
                                <div class="input-group">
                                    <span class="input-group-text bg-transparent border-end-0">
                                        <i class="fas fa-search text-muted"></i>
                                    </span>
                                    <input class="form-control border-start-0 ps-0" 
                                           id="cc_search_value" 
                                           type="text" 
                                           placeholder="Enter search keywords..."
                                           aria-label="Search">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-primary w-100" id="btnRRJobSearch">
                                    <i class="fas fa-search me-2"></i>Search
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Tickets Details Table -->
<div class="row mb-4">
    <div class="col-12">
        <div class="card border-0 shadow-sm">
            <!-- Card Header -->
            <div class="card-header bg-white border-bottom py-3">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
                    <div class="d-flex align-items-center gap-3">
                        <div class="bg-primary bg-opacity-10 rounded-3 p-2">
                            <i class="fas fa-ticket-alt text-primary fa-lg"></i>
                        </div>
                        <div>
                            <h5 class="mb-1 fw-semibold">Tickets Management</h5>
                            <span class="badge bg-light text-dark rounded-pill" id="card_title"></span>
                        </div>
                    </div>
                    
                    <!-- Archive Button -->
                    <button class="btn btn-outline-danger btn-sm" id="btnViewBatchlist">
                        <i class="fas fa-archive me-2"></i>
                        Archive Selected
                    </button>
                </div>
            </div>

            <!-- Card Body -->
            <div class="card-body">
                <!-- Status Legend -->
                <div class="d-flex flex-wrap gap-4 mb-4 p-3 bg-light rounded-3">
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-success rounded-circle p-2"></span>
                        <small class="text-muted">Replies sent to client</small>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="table table-hover align-middle" id="table_list" width="100%">
                        <thead class="bg-light">
                            <tr>
                                <th class="fw-semibold text-muted" style="width: 50px;">#</th>
                                <th class="fw-semibold text-muted">Ticket No.</th>
                                <th class="fw-semibold text-muted">Client Name</th>
                                <th class="fw-semibold text-muted">Purpose</th>
                                <th class="fw-semibold text-muted">Subject</th>
                                <th class="fw-semibold text-muted text-center">Status</th>
                                <th class="fw-semibold text-muted text-center">Priority</th>
                                <th class="fw-semibold text-muted">Region</th>
                                <th class="fw-semibold text-muted">Date Created</th>
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

    
<!-- End Page Content -->
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
				<h5 class="modal-title" id="">Archive Replies</h5>
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
			 	<button type="button" class="btn btn-primary" id="btn_archive_replies" >Archive</button>
			 	
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
<!-- Status Client Modal-->

<script>
	function deleteRow(r) {
	  var i = r.parentNode.parentNode.rowIndex;
	  document.getElementById("batchTable").deleteRow(i);
	}
</script>


<script type="text/javascript" src="CICA/includes/pages_script/cica_tickets.js"></script>