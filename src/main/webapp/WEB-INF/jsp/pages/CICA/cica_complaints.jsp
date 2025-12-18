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
<jsp:include page="../CICA/includes/header.jsp"></jsp:include>
<!-- Begin Page Content -->
   <div class="container-fluid">
	<section class="section dashboard">
		 <!-- Page Heading -->
               <%--  <div class="row mb-4">
                	 <div class="col-md-12">
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item active">CAC - COMPLAINTS</li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div> --%>
	
	
     	<div class="row mb-4">
      		<!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">
            <!-- Assigned Cases Card -->
            <div class="col-xl-3 col-md-6" id="open">
              <div class="card border-bottom-primary shadow h-100 py-2" id="body-bg-1">

                <div class="card-body ms-2">
		           <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="card-title text-xs font-weight-bold text-uppercase mb-1">Complaints | Open</div>
                      <div class="h5 mb-0 font-weight-bold" id="pending_count"><c:out value="${open}"></c:out></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-door-open fa-2x text-primary"></i>
                    </div>
                  </div>
                  
                </div>

              </div>
            </div><!-- Assigned Cases Card -->

            <!-- Unit Cases Card -->
            <div class="col-xl-3 col-md-6" id="archived">
              <div class="card border-bottom-danger shadow h-100 py-2" id="body-bg-2">

               <div class="card-body ms-2">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="card-title text-xs font-weight-bold text-uppercase mb-1">Complaints | Archived</div>
                      <div class="h5 mb-0 font-weight-bold" id="archived_count"><c:out value="${archived}"></c:out></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-box fa-2x text-danger"></i>
                    </div>
                  </div>
                </div>

              </div>
            </div><!-- Unit Cases Card -->

     </div>
    </div>
  </div>
  
  <div class="row mb-4" id="archived_search">
		 		<div class="col-md-9">
								 	
							    
								    <div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="client_name" required>
									  <label class="custom-control-label" for="rbtn_search_type1">Name</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="ticket_id" required>
									  <label class="custom-control-label" for="rbtn_search_type2">Ticket ID</label>
									</div>
									<br><br>
						          <div class="form-group">
						            <div class="form-row mb-4">
						              <div class="col-md-5">
						                
						                <input class="form-control" id="cc_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
						              </div>
						              <div class="col-md-3">
						              	
						                <button type="button" class="btn btn-warning" value="Search" id="btnCCJobSearch" ><i class="fas fa-search"></i> Search </button>
						                
						              </div>
						            </div>
						            </div>
						            
						            </div>
		 </div>	

	      <div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Enquiries Details - <span id="card_title"> </span> <span
						class="col-md-3 float-right ">
						<!-- <button class="btn btn-success btn-icon-split float-right "
							id="btnViewBatchlist" disabled>
							<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span
								class="text">View Batch List</span>
						</button> -->
					</span>
					</div>
	                <div class="card-body">
	                  <div class="tab-content">
					            <div id="" class="table-responsive">
					                <table class="table " id="table_list"  width="100%" cellspacing="0">
	              						<thead>
										    <tr>
										        <th>#</th>
										        <th>Enquiry ID</th>
										        <th>Complainant Name</th>										        
										        <th>Subject</th>
										        <th>Description</th>
										        <th>Phone Number</th>
										        <th>Email</th>
										        <th>Created By</th>
										        <th>Date Created</th>
												<th>Actions</th>
										    </tr>
										  </thead>
										  <tbody id="table_body">
										    
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
			 	 <label>Complaint ID</label>
			 	 <input class="form-control" type="text" name="status_ticket_id" id="status_ticket_id" readonly />
 			 </div>
 			  <div class="row m-4">
			 	 <label>Status</label>
			 	 <select class="form-control" name="status_select" id="status_select">
			 	 		<option disabled selected>-- select --</option>
			 	 		<option value="open">Open</option>
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
<jsp:include page="../CICA/includes/footer.jsp"></jsp:include>
<script type="text/javascript" src="CICA/includes/pages_script/cica_complaints.js"></script>