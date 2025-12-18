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
 <c:forEach items="${request_details}" var="request"  varStatus="appfiles_loop"> 
    <div class="pagetitle">
      <!-- <h4>DUC - CAC TICKETS</h4> --><br>
      <div class=" ">
		                   
			         <nav>
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
		         
		                  <li class="breadcrumb-item active">Request Details</li>
		                  <button  class="btn btn-danger float-right" 
				                    style="position:absolute; right:30px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;"
				                    ><a style=" text-decoration: none" class="text-white" onclick="history.back()">
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
				  <h6 class="card-title">Job Number:<strong> <sap class="text-warning">${request.job_number}</sap> </strong></h6>		
			 </div>
				
				<!-- <input type="text" class="form-control" name="req_ticket_no" id="req_ticket_no" value="${cases.id}" hidden> -->
              <!-- Accordion without outline borders -->
              
              <div class="accordion" id="accordionCaseDetails">
               <div class="accordion-item">
	                 <h2 class="accordion-header" id="parties">
		                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse8" aria-expanded="true" aria-controls="collapse1">
	            			Request Details
		                </button>
	                 </h2>
	                  <div id="collapse8" class="accordion-collapse show" aria-labelledby="parties" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                     <%--  <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop"> --%>
	                     <div class="card">
	                		<div class="card-body">
	                    	<div class="row mb-4">
	                    		<div class="col-md-12">
	                    			<div class="row">
			                    		<div class="col-md-5">
			                    			<span>From:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${request.req_from}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Note:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${request.req_note}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Requested By:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${request.modified_by}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Region:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${request.region_name}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Requested On:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${request.created_on}</span>
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
	            			Application Details
		                </button>
	                 </h2>
                 
                  <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="parties" data-bs-parent="#accordionCaseDetails" >
                    <div class="accordion-body">
	              <div class="card">
	                <div class="card-body">
	                	 <div class="row mb-4">
	                    		<div class="col-md-12">
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Applicant Name:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${request.ar_name}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Job Received By:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${request.job_recieved_by_id}</span>
				                    	</div>
			                    	</div>
			                    	<div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Job Purpose:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${request.job_purpose}</span>
				                    	</div>
			                    	</div>
			                    	
                                    <div class="row mt-2">
			                    		<div class="col-md-5">
			                    			<span>Received On:</span>
				                    	</div>
				                    	<div class="col-md-7">
			                    			<span>${request.batch_date}</span>
				                    	</div>
			                    	</div>
		                    	</div>
	                    	</div>
	                  
	                </div>
	              </div>
                    </div>
                  </div>
                </div>
                

            </div>
     	   <!-- End Accordion without outline borders  this is just a test that i'm just doing-->

        </div>
      </div>

    </div>
   <div class="col-lg-4 ${add_reply}">

          <!-- Recent Activity -->
          <form id="reply_to_ticket" method="post" enctype="multipart/form-data">
           <div class="card">
          	<div class="card-header"><h5>Add Response</h5></div>
            <div class="card-body">
				<div class="form-group mb-3  ${move_to}">
					<label>Response:</label>
					<select class="form-control" id="res_type" name="res_type" required>
						<option value=" disabled selected">--select--</option>
						<option value="decline">Decline</option>
						<option value="approve">Approve</option>
					</select>
				</div>
				  <label>Note:</label>
				   <div class="row mb-3">
				   <c:forEach items="${request_details}" var="request"  varStatus="appfiles_loop">
				   <input type="text" class="form-control" id="res_id" name="res_id" value="${request.req_id}" hidden />
	                      	<input type="text" id="res_job_number" name="res_job_number" value="${request.job_number}" hidden />
	                      	<!-- <input type="text" id="request_type" name="request_type" value="select_respond_to_app_request" hidden /> -->
				   </c:forEach>
				   
		            <div class="col-sm-12">
		              <textarea class="form-control" rows="5" id="req_response_note" name="req_response_note" required></textarea>
		            </div>
		          </div>
		                			
									 <!-- <input type="text" id="replied_by_id" value="${sessionScope.userid}" hidden />
			<input type="text" id="replied_by" value="${sessionScope.fullname}" hidden />
			<input type="text" name="view_by" value="${sessionScope.view_by}" hidden /> -->
									 
				  
				  <div class="d-flex justify-content-end">
		                 <button type="submit" class="btn btn-success" id="btn_respond_app_request"><i class="fas fa-save"></i>Submit</button>
		             </div>
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


  

 
<jsp:include page="../includes/_footer.jsp"></jsp:include>
<script src="legal/includes/bootstrap/js/bootstrap.bundle.js"></script>
 
  ${param.success == "true" ? "
 
 <script> 
toastr['success']('Replied successfully', 'Success');
</script>
 ":""}
 

  