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
				                  <li class="breadcrumb-item active">CAC - ENQUIRY </li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
	
			
		

		 <div class="card mb-3">
			<div class="card-header">
			  <i class="fa fa-bar-chart"></i>Search Ticket   <%-- ${page_name == "page_enquiry_backoffice" ? "test value" : ""} --%> </div>
			<div class="card-body">
				  <!--  The Form starts here -->
				  <div class="row mb-4">
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
											 
										   <button type="button" class="btn btn-warning" value="Search" id="btnENJobSearch" ><i class="fas fa-search"></i> Search </button>
										   
										 </div>
									   </div>
									   </div>
									   
									   </div>
			</div>	
			
			<!-- The form Ends Hers -->

			</div>
		   <!--  <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
		  </div>
			
	      <div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i><span class="h5">Tickets Details</span> <span
						class="col-md-3 float-right ">
						 <button class="btn btn-success btn-icon-split float-right "
							id="btnViewBatchlist" style="margin-right: -15px">
							<span class="icon text-white-50"> <i class="fas fa-angle-double-right"></i></span><span
								class="text">Forward</span>
						</button>
					</span>
					</div>
	                <div class="card-body">
	                	  <h5 class="card-title"><span id="card_title"> </span></h5>
	                	  
                	  	<div class="row mt-2">
							<span class="mb-2 small"><i class="fas fa-dot-circle text-white" style="border: 1px solid black; border-radius: 50%"></i>Tickets with no replies from either DCU or Focal Person.</span>
							<span class="mb-2 small"><i class="fas fa-dot-circle text-info"></i>Tickets sent to CAC Center.</span>
							<span class="mb-2 small"><i class="fas fa-dot-circle text-warning"></i>Tickets sent to DCU.</span>
							<span class="mb-2 small"><i class="fas fa-dot-circle text-success"></i>Message (Replies) sent to client.</span>
						</div>
	
	                  <div class="tab-content mt-4">
					            <div id="" class="table-responsive">
					                <table class="table " id="table_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
	              						<thead>
										    <tr>
										        <th>#</th>
										        <th>Ticket No.</th>
										        <th>Name</th>
										        <th>Purpose</th>
										        <th>Subject</th>
										        <th class="text-center">Status</th>											        
										        <th class="text-center">Priority</th>	
										        <th>Division</th>							        
										        <th>Region</th>
										        <th>Date Created</th>
												<th class="text-end">Actions</th>
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
			<div class="row mt-4">
              				<div class="col-md-2">
              					<span>Division<span class="text-danger">*</span>:</span>
              				</div>
              				<div class="col-md-6">
              					<select class="form-control" aria-label="Default select example" name="ft_division" id="ft_division" required>
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
               					<select class="form-control" aria-label="Default select example" name="ft_region" id="ft_region" required>
					                <option value="" selected>-- select --</option>
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
               	<div class="card card-body mt-4">
               		<div class="mt-2" id="batch_list"></div>
               	</div>
			</div>
			 	<div class="modal-footer">
			 	<button type="button" class="btn btn-primary" id="btn_print" >Forward</button>
			 	
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
									<option value="22">Oti</option>	
									<option value="23">Bono East</option>	
									<option value="24">Ahafo</option>	
									<option value="20">Bono</option>	
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

<jsp:include page="../CICA/includes/footer.jsp"></jsp:include>
<script type="text/javascript" src="CICA/includes/pages_script/cica_tickets.js"></script>