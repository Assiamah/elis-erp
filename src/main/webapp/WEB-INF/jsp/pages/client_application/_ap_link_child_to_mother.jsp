<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


   <jsp:include page="../client_application/_application_process_header.jsp"></jsp:include>
					          
   <h3 class="border-bottom border-gray pb-2 mt-5">Link Application to Mother File</h3>

						
   <div class="row">
	  <div class="col-lg-12">
		  <!-- Example Pie Chart Card-->
		  <div class="card mb-10">
			<div class="card-header">
			  Motherfile Details</div>
			<div class="card-body">
			  <form id="linkSearchMotherfile"  method="post">
				  <div class="form-group">
				  <div class="custom-control custom-radio custom-control-inline">
					  <input type="radio" id="rbtn_search_type3" name="link_search_type" class="custom-control-input" value="job_number" required>
					  <label class="custom-control-label" for="rbtn_search_type3">Job number</label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
					  <input type="radio" id="rbtn_search_type4" name="link_search_type" class="custom-control-input" value="certificate_number" required>
					  <label class="custom-control-label" for="rbtn_search_type4">Certificate Number</label>
					</div>
				  </div>
				<br>
				<div class="form-group">
				  <div class="form-row">
				  <!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
					<div class="col-md-8">
					  
					  <input class="form-control" id="link_search_value"  name="link_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
					</div>
					<div class="col-md-4">
						
					  <button type="submit" class="btn btn-primary btn-block" value="Search" id="btnEnquiryJobSearch" > Search </button>
					  
					</div>
				  </div>
				</div>
			  </form>

			  <div class="row">
				  <div class="col-lg-12">
					   <!-- Example Bar Chart Card-->
					   <div class="card mb-3" style="display:none" id="link-search-results-section">
						 <div class="card-header">
						   <i class="fa fa-bar-chart"></i>Search Results</div>
						 <div class="card-body">
						 
					  
						 
							  <!--  Here is where the fee list comes -->
							  
							  <div class="table-responsive" >
									<table class="table table-bordered " id="link-search-results-table" style="min-height:500px">
									   <thead>
										 <tr>
										  <th>Applicant Name</th>
										   <th>Certificate Number</th>
										   <th>Job Number</th>
										   <th>Locality</th>
										   
										   <th>Actions</th>
										  </tr>
									   </thead>
									   
									   <tbody>
											
													   
										  
									   </tbody> 
									 </table>
							   </div>
						  
						   <!--  End Of Table -->
						  </div>
						 <!-- <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div> -->
					   </div>
					   
				  <!-- Example Bar Chart Card-->
					   
					 
				 
					</div>
					 
				   </div>
			
		  </div>
		 
		</div>
	  <!--   Here is the end of right table -->
  
	  </div>
  
		
		
		
		 <!--   Here is the right Table -->
		  <div class="col-lg-12">
			<!-- Example Pie Chart Card-->
			<div class="card mb-3">
			  <div class="card-header">
				<i class="fa fa-pie-chart"></i>Link Application to Mother File</div>
			  <div class="card-body">
				 <!--  The Form starts here -->
				


	  <div class="row">
		  <div class="form-group">
		<div class="custom-control custom-radio custom-control-inline">
		  <input type="radio" id="rbtn_search_type5" name="rbtn_search_type" class="custom-control-input" value="job_number" required>
		  <label class="custom-control-label" for="rbtn_search_type5">Job number</label>
		</div>
		<div class="custom-control custom-radio custom-control-inline">
		  <input type="radio" id="rbtn_search_type6" name="rbtn_search_type" class="custom-control-input" value="certificate_number" required>
		  <label class="custom-control-label" for="rbtn_search_type6">Certificate Number</label>
		</div>
		<br>
		</div>
	  </div>

		<div class="row">
														  
  <div class="col-md-6">
	  <div class="form-group">
		
	<input class="form-control" id="lrd_search_for_mother_transction_to_child"  name="lrd_search_for_mother_transction_to_child"  type="text" value="" placeholder="Job Number of the Mother File" required >
	 
	  </div>
  </div>


<!-- <div class="col-md-2">
	  <div class="form-group">
	   <button type="button" class="btn btn-primary" id="pvlmd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-retweet"></i> </button>
  
	  </div>
  </div> -->
  
  <div class="col-md-2">
	  <div class="form-group">
	   <button type="button" class="btn btn-primary" id="lrd_btn_search_for_mother_transction_to_child" data-placement="top" data-toggle="tooltip" title="Search">Link</button>
  
	  </div>
  </div>
  

</div>



<h3 class="border-bottom border-gray pb-2">Root of Title</h3>



<h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
<!-- <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
<i class="fa fa-plus-circle"></i>
</button> -->

<div  class="table w-auto small table-responsive">
 <table class="table table-bordered" id="lrd_proprietorship_details_dataTable" >
 
  <thead>
	  <tr>
		  <!-- <th>approval_status</th> -->
		   <th>Registered No.</th>
		   <th>Proprietors</th>
		   <th>Date of Instrument</th>
		   <th>Nature of Instrument</th>
		   <th>Date of Regsitration</th>
		   <th>Parties</th>
		   <th>Price Paid</th>
		   <th>Remarks</th>
		  <!-- <th>Action</th> -->
		  <!-- <th>Approve</th> -->
		</tr>
	</thead>
	
	  <tbody>
		   <c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
				  <tr>
				 <!-- <td>${proprietorship_section.approval_status}</td> -->
			  <td>${proprietorship_section.ps_registration_number}</td>
			  <td>${proprietorship_section.ps_proprietor}</td>
			  <td>${proprietorship_section.ps_date_of_instrument}</td>
			  <td>${proprietorship_section.ps_nature_of_instrument}</td>
			  <td>${proprietorship_section.ps_date_of_registration}</td>
			  <td>${proprietorship_section.ps_transferor} - ${proprietorship_section.ps_transferee}</td>
			  <td>${proprietorship_section.ps_price_paid}</td>
			  <td>${proprietorship_section.ps_remarks}</td>


			  

			  <!-- <td class="${proprietorship_section.edit == 1 ? 'd-none' : ''}">
				  <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" 
				  data-target-id="${proprietorship_section.ps_id}" 
				  data-ps_id="${proprietorship_section.ps_id}"
				  data-ps_case_number="${proprietorship_section.ps_case_number}"
				  data-ps_registration_number="${proprietorship_section.ps_registration_number}"
				  data-ps_date_of_instrument="${proprietorship_section.ps_date_of_instrument}"
				  data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
				  data-ps_date_of_registration="${proprietorship_section.ps_date_of_registration}"
				  data-ps_transferor="${proprietorship_section.ps_transferor}"
				  data-ps_transferee="${proprietorship_section.ps_transferee}"
				  data-ps_price_paid="${proprietorship_section.ps_price_paid}"
				  data-ps_remarks="${proprietorship_section.ps_remarks}"
				  data-ps_signature="${proprietorship_section.ps_signature}"
				  data-ps_proprietor="${proprietorship_section.ps_proprietor}"
				  data-whatever="edit">
					  <span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
				  </button>
			  </td> -->
			  
				  
			  
			   
			  
			  </tr>
		  </c:forEach>
		</tbody>

  
  </table>
</div>






<!-- <h5 class="border-bottom border-gray pb-2">Valuation Details</h5>
<button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newValuationModal" data-toggle="tooltip" title="Add New Valuation Records">
<i class="fa fa-plus-circle"></i>
</button>

<div  class="table table-responsive w-auto small">
 <table class="table table-bordered" id="lrd_valuation_details_dataTable">
 
	<thead>
	  <tr>

	   <th>Date of Valuation</th>
	   <th>Amount</th>
	   <th>Remarks</th>
	   <th>Action</th>
		
		</tr>
	</thead>
	
	  <tbody>
<c:forEach items="${lrd_valuation_section}" var="valuation_section">
<tr>
<td>${valuation_section.vs_date_of_valuation}</td>
<td>${valuation_section.vs_amount}</td>
<td>${valuation_section.vs_remarks}</td>

<td class="${valuation_section.edit == 1 ? 'd-none' : ''}">
  <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newValuationModal" 
  data-target-id="${valuation_section.vs_id}" 
  data-vs_id="${valuation_section.vs_id}"
  data-vs_case_number="${valuation_section.vs_case_number}"
  data-vs_date_of_valuation="${valuation_section.vs_date_of_valuation}"
  data-vs_amount="${valuation_section.vs_amount}"
  data-vs_remarks="${valuation_section.vs_remarks}"
  data-whatever="edit">
	  <span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
  </button>
</td>



</tr>
</c:forEach>
		</tbody>

  
  </table>
</div> -->



<!-- <h5 class="border-bottom border-gray pb-2">Certificate Details</h5>
<button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newCertificateModal" data-toggle="tooltip" title="Add New">
<i class="fa fa-plus-circle"></i>
</button>

<div  class="table table-responsive w-auto small">
 <table class="table table-bordered" id="lrd_certificate_details_dataTable">
 
	<thead>
	  <tr>

	   <th>Date of Registration</th>
	   <th>To Whom Issued</th>
	   <th>Serial Number</th>
	   <th>Official Notes</th>
	   <th>Action</th>
		</tr>
	</thead>
	
	  <tbody>
<c:forEach items="${lrd_certificate_section}" var="certificate_section">
<tr>
<td>${certificate_section.cs_date_of_registration}</td>
<td>${certificate_section.cs_to_whom_issued}</td>
<td>${certificate_section.cs_serial_number}</td>
<td>${certificate_section.cs_official_notes}</td>
<td class="${certificate_section.edit == 1 ? 'd-none' : ''}">
  <p data-placement="top" data-toggle="tooltip" title="Batch">
	  <button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newCertificateModal" 
	  data-target-id="${certificate_section.cs_id}"
	  data-cs_id="${certificate_section.cs_id}"
	  data-cs_case_number="${certificate_section.cs_case_number}"
	  data-cs_official_notes="${certificate_section.cs_official_notes}"
	  data-cs_date_of_registration="${certificate_section.cs_date_of_registration}"
	  data-cs_to_whom_issued="${certificate_section.cs_to_whom_issued}"
	  data-cs_serial_number="${certificate_section.cs_serial_number}"
	  >
		  <span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span>
	  </button>
	  </p>
</td>




</tr>
</c:forEach>
		</tbody>

  
  </table>
</div> -->


	
				
	  
			  
			</div>
		   
		  </div>
		<!--   Here is the end of right table -->
	
		</div>
		
		
	   

		
	   
  
   </div>

   <input type="hidden" id="ars_job_purpose" class="form-control" value="${job_purpose}">

   <div class="mt-5">
	<button class="btn btn-success btn-icon-split float-left "  data-job_number="${job_number}" id="btnApproveJob">
		<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve Request</span>
	</button>

	<button class="btn btn-danger btn-icon-split float-left ml-3"  data-job_number="${job_number}" id="btnQueryJob">
		<span class="icon text-white-50"> <i class="fas fa-times fa-2x"></i></span><span class="text">Query Request</span>
	</button>
 </div>
	
            
		<jsp:include page="../client_application/_application_process_footer_ar.jsp"></jsp:include>
  
  
