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
<jsp:include page="../includes/_header.jsp"></jsp:include>
<input type="text" name="regional_code" value="${sessionScope.regional_code}"  hidden/> 
				 
<!-- Begin Page Content -->
   <div class="container-fluid">
	<section class="section dashboard">
		 <!-- Page Heading -->
                <div class="row mb-4">
                	 <div class="col-md-12">
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item active">APPLICATION REQUESTS - TICKETS </li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
	
	
     	<div class="row mb-4">
      		<!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">
            <!-- Assigned Cases Card -->
            <div class="col-xl-4 col-md-6">
              <div class="card border-left-info shadow h-100 py-2 btnLoadRequest" data-id="1" id="body-bg-1">

                <div class="card-body">
	                  		<h5 class="card-title  text-info">Requests <span>| Incoming </span></h5>
							
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<i class="fas fa-sign-in-alt fa-2x text-gray-200"></i>
								</div>
								 <div class="ps-3">	
		                     	 	<h4 id="incoming_count"><c:out value="${incoming}"></c:out></h4>
								 </div>
		                    </div>
                </div>

              </div>
            </div><!-- Assigned Cases Card -->

            
            
            <div class="col-xl-4 col-md-6">			 
              <div class="card border-left-danger shadow h-100 py-2 btnLoadRequest" data-id="2" id="body-bg-2">

                <div class="card-body">
        
                    <h5 class="card-title text-danger">Requests <span>| Outgoing</span></h5>

	                <div class="d-flex align-items-center">
	                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
	                      <i class="fas fa-sign-out-alt fa-2x text-gray-200"></i>
	                    </div>
	                    <div class="ps-3">
	                      <h4 id="outgoing_count"><c:out value="${outgoing}"></c:out></h4>
	
	                    </div>
	                  </div>
					
                </div>
              </div>
			 
            </div><!-- Archived Cases Card -->
     	
     
     </div>
    </div>
  </div>
			
		 <!-- <div class="row mb-4" id="focal_person_archived_search">
		 		<div class="col-md-9">
								 	
							    
								    <div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="client_name" required>
									  <label class="custom-control-label" for="rbtn_search_type1">Name</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="ticket_id" required>
									  <label class="custom-control-label" for="rbtn_search_type2">Ticket No.</label>
									</div>
									<br><br>
						          <div class="form-group">
						            <div class="form-row mb-4">
						              <div class="col-md-5">
						                
						                <input class="form-control" id="cc_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
						              </div>
						              <div class="col-md-3">
						              	
						                <button type="button" class="btn btn-warning" value="Search" id="btnFPJobSearch" ><i class="fas fa-search"></i> Search </button>
						                
						              </div>
						            </div>
						            </div>
						            
						            </div>
		 </div>	 -->
			
	      <div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i><span class="h5">Request Details</span> <span
						class="col-md-3 float-right ">
						 <button class="btn btn-success btn-icon-split float-right"
							data-toggle="modal" data-target="#make_app_request_modal" style="margin-right: -15px">
							<span class="icon text-white-50"> <i class="fas fa-angle-double-right"></i></span><span
								class="text">Make Request</span>
						</button>
					</span>
					</div>
	                <div class="card-body">
	                	  <h5 class="card-title"><span id="card_title"> </span></h5>
<!-- 	                	  
	                	  <div class="row mt-2">
							<span class="mb-2 small"><i class="fas fa-dot-circle text-white" style="border: 1px solid black; border-radius: 50%"></i>Tickets with no replies from either DCU or Focal Person.</span>
							<span class="mb-2 small"><i class="fas fa-dot-circle text-info"></i>Tickets sent to CAC Center.</span>
							<span class="mb-2 small"><i class="fas fa-dot-circle text-warning"></i>Tickets sent to DCU.</span>
							<span class="mb-2 small"><i class="fas fa-dot-circle text-success"></i>Message (Replies) sent to client.</span>
						</div> -->
	                  <div class="tab-content mt-4">
					            <div id="" class="table-responsive">
					                <table class="table table-bordered table-hover" id="job_casemgtdetailsdataTable_req" width="100%" cellspacing="0" style="text-transform: uppercase;">
	              						<thead>
										    <tr>
										        <th>#</th>
										        <th>Requested On</th>
										        <th>Job Number</th>
                                                <th>Sent By</th>
										        <th>Sent To</th>
										        <th class="text-center">Status</th>											        
										        <!-- <th class="text-center">Priority</th>								        
										        <th>Job Number</th>
										        <th>Date Created</th>
												<th>Noted On</th> -->
												<th class="text-center">Actions</th>
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
	          </div>

     </section>

	</div>
<!-- End Page Content -->

<div class="modal fade" id="view_response_details_modal" tabindex="-1" role="dialog"
	aria-labelledby="showRequestlist" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">View Details</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row mb-3">
					<div class="col-sm-12">
                        <label for="inputNumber" class="col-sm-4 col-form-label"><h6>Job Number:</h6></label>
					  <input class="form-control" type="text" id="re_job_number" name="re_job_number" readonly>
					</div>
				  </div> 
                  <div class="row mb-3">
					<div class="col-sm-12">
                        <label for="inputNumber" class="col-sm-4 col-form-label"><h6>Apporoved/Decelined By:</h6></label>
					  <input class="form-control" type="text" id="re_accepted_by" name="re_accepted_by" readonly>
					</div>
				  </div> 
                  <div class="row mb-3">
					<div class="col-sm-12">
                        <label for="inputNumber" class="col-sm-4 col-form-label"><h6>Status</h6></label>
					  <input class="form-control" type="text" id="re_status" name="re_status" readonly>
					</div>
				  </div> 
				<div class="row mb-3">
					<div class="col-sm-12">
                        <label for="" class="col-sm-4 col-form-label"><h6>Note:</h6></label>
						<textarea rows="8" class="form-control" id="res_note" readonly></textarea>
					</div>
				  </div>
                  <div class="row mb-3">
					<div class="col-sm-12">
                        <label for="inputNumber" class="col-sm-4 col-form-label"><h6>Dated On</h6></label>
					  <input class="form-control" type="text" id="res_accepted_on" name="res_accepted_on" readonly>
					</div>
				  </div> 
			</div>
			

			 	<div class="modal-footer">
                    <!-- <button type="button" class="btn btn-primary" id="btn_make_request" >Submit</button> -->
                    
                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                   
               </div>
	</div>
</div>
</div>

	<div class="modal fade" id="make_app_request_modal" tabindex="-1" role="dialog"
	aria-labelledby="showRequestlist" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">Make Request</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row mb-3">
					<label for="inputNumber" class="col-sm-4 col-form-label"><h6>Job Number:</h6></label>
					<div class="col-sm-6">
					  <input class="form-control" type="text" id="req_job_number" name="req_job_number" required>
					</div>
                    <div class="col-sm-2">
                        <button class="btn btn-warning w-100" id="btn_load_app_details_req"><i class="fas fa-refresh"></i>Load</button>
                      </div>
				  </div> 
                  <div class="row mb-3">
					<label for="inputNumber" class="col-sm-4 col-form-label"><h6>Applicant Name:</h6></label>
					<div class="col-sm-8">
					  <input class="form-control" type="text" id="req_app_name" name="req_app_name" required readonly>
					</div>
				  </div> 
                  <div class="row mb-3">
					<label for="inputNumber" class="col-sm-4 col-form-label"><h6>Unit:</h6></label>
					<div class="col-sm-8">
					  <input class="form-control" type="text" id="req_to" name="req_to" required readonly>
                      <input class="form-control" type="text" hidden id="req_to_id" name="req_to_id" required>
					</div>
				  </div> 
				<div class="row mb-3">
					<label for="inputNumber" class="col-sm-4 col-form-label"><h6>Note:</h6></label>
					<div class="col-sm-8">
						<textarea rows="8" cols="" class="form-control" name="req_note" id="req_note" required></textarea>
					</div>
				  </div>
			</div>
			

			 	<div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="btn_make_request" >Submit</button>
                    
                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                   
               </div>
	</div>
</div>
<!-- Status Client Modal-->

</div>
<script>
	function deleteRow(r) {
	  var i = r.parentNode.parentNode.rowIndex;
	  document.getElementById("batchTable").deleteRow(i);
	}
</script>

<jsp:include page="../includes/_footer.jsp"></jsp:include>