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
					          
   <h3 class="border-bottom border-gray pb-2">Approval/Vetting/Approve for Publication</h3>
   <div class="row">




	  
	   <!--   Here is the right Table -->
		<div class="col-lg-12">
		  <!-- Example Pie Chart Card-->
		  <div class="card mb-10">
			<div class="card-header">
			  <i class="fa fa-pie-chart"></i> Approval/Vetting</div>
			<div class="card-body">
			   <!--  The Form starts here -->
		   

				  <div class="form-group">
		   
			
				   
<!--  WKT row here -->
<!--   <div class="form-group">

<div class="form-row">  <label for="bl_job_purpose">Inspection Report Description</label>
<textarea rows="2" class="form-control" placeholder="" id="lc_bl_inspection_report" ></textarea>
</div>
</div>
-->
			
		   
				<div class="row">
<div class="col-lg-12">
	<!-- Example Pie Chart Card-->
	<div class="card mb-3">
		<div class="card-header">
			<i class="fa fa-pie-chart"></i>Verify Site (If Inspection is
			needed)
		</div>
		<div class="card-body">
			<!--  The Form starts here -->
			<!--   <form action="" > -->
			<div class="form-group">
			
			
			
			</div>
			
			
			<div class="row">
			
<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	  <div class="form-group">
		
		
		  <select
				name="type_of_letter_new" id="type_of_letter_new"
				data-live-search="true" class="form-control selectpicker"
			>
				<option value="Select_Letter_Template">Select Letter Template</option>
				<option value="Inspection_Letter">Inspection Letter</option>
				<option value="Physical_Planning_Letter">Physical Planning Letter</option>
				<option value="Query_Letter">Query_Letter</option>
				<option value="Objection_Letter">Objection_Letter</option>
				

			</select>
	  </div>
	  
  </div>
  <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	  <div class="form-group">
	
		
		<button type="button"
				class="btn btn-primary"
				id="lc_btn_add_update_letters" data-placement="top" 
			>
				<span class="icon text-white-50"> <i
					class="fa fa-plus-circle"
				></i></span><span class="text">Add New Letter Template</span>
			</button>
	  
	  </div>
	  
  </div>
			
			
			</div>


			<!-- </form> -->

			<!-- The form Ends Hers -->

		</div>

	</div>
	<!--   Here is the end of right table -->

</div>
</div>


<div class="row">
<!--   Here is the right Table -->


<div class="col-lg-12">
	<!-- Example Pie Chart Card-->
	<div class="card mb-3">
		<div class="card-header">
			<i class="fas fa-file-o"></i>Letters on Job

		</div>
		<div class="card-body">
			<!--  The Form starts here -->
			<div id="alert-display-space"></div>


			<table class="table">
				<thead>
					<tr>
						<th>Date</th>
						<th>Letter Type</th>
						<th>Created By</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${case_letters}" var="case_letters_row">
									<tr>
										<td>${case_letters_row.created_date}</td>
										<td>${case_letters_row.letter_type}</td>
										<td>${case_letters_row.created_by}</td>
									  
										
										<td>
												  <button type="button" id="btn-view-letters"  
												  data-id="${case_letters_row.id}"
												  data-letter_type = "${case_letters_row.letter_type}" 
												  data-letter_template="${fn:escapeXml(case_letters_row.letter_template)}" 
												  data-carbon_copy="${case_letters_row.carbon_copy}" 
												  class="btn btn-primary btn-icon-split edit_letter_modal_open"  title="View Letter" >
													<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
												</button> 
										</td>
									 </tr>
								 </c:forEach>
				</tbody>
			</table>

		

		</div>
	</div>
</div>
</div>
			
			
			
			
			
				 
		<div  class="table-responsive">
		   <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable" >
		   
			  <thead>
				<tr>

				 <th>Note</th>
				 <th>Note By</th>
				 <th>Note Date</th>
				 <th>Division</th>
				 <th>Action</th>
				  </tr>
			  </thead>
			  
				<tbody>
				  <c:forEach items="${application_notes}" var="application_notes_row">
						<tr>
									<td class="text-truncate" style="max-width:100px;">${application_notes_row.an_description}</td>
									<td>${application_notes_row.created_by}</td>
									<td>${application_notes_row.created_date}</td>
									<td>${application_notes_row.division}</td>
									
									<td><p data-placement="top" data-toggle="tooltip" title="View/Edit">
										<button class="btn btn-info btn-icon-split"  data-toggle="modal" data-target="#addNotesModal" 
										data-target-id="${application_notes_row.an_id}" 
										data-an_description="${application_notes_row.an_description}" 
										data-created_by="${application_notes_row.created_by}"  
										data-created_date="${application_notes_row.created_date}" 
										data-modified_by="${application_notes_row.created_by}"  
										data-modified_date="${application_notes_row.created_date}" 
										
										
										
										>
										<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">View</span>
										</button></p></td>
								 </tr>
					</c:forEach> 
				  </tbody>
			  </table>
		  </div>
			
			
			 
			
			
		  </div>
		  
		  
		  
		  
		 
		  
		  
		  
	   
			<!-- The form Ends Hers -->
			
		  </div>
		 
		</div>
	  <!--   Here is the end of right table -->
  
	  </div>
	  
	  

</div>

  <div class="row">
		
		
			  
			  
			  
			   <!--   Here is the right Table -->
				<div class="col-lg-8">
				  <!-- Example Pie Chart Card-->
				  <div class="card mb-3">
				  <!--   <div class="card-header">
					  <i class="fa fa-pie-chart"></i>Approve for Publicatio</div> -->
					<div class="card-body">
					   <!--  The Form starts here -->
					  
			   <div class="form-row">
			  
				<!-- <div class="col-md-4">
				 <label for="search_value">Date of Publication</label>
				  <input type="text" name="lc_txt_publicity_date" id="lc_txt_publicity_date"   class="form-control" value="${publicity_date}"required> </div> -->
				<div class="col-md-4">
			   <input type="button" id="lc_btn_add_to_publication_list" class="btn btn-primary btn-block" value="Send for Publication"/> 
			   <!-- <input type="button" id="lc_btn_update_publication_date" class="btn btn-primary btn-block" value="Set Date Published" />  -->
<!-- 				               
			   <c:if test="${publicity_date != 'null' }">
				disabled="disabled" 
			</c:if> -->

				</div>
			 
			</div>
					  
				   
				   
					  
					  
					
					<!-- The form Ends Hers -->
					
				  </div>
				 
				</div>
			  <!--   Here is the end of right table -->
		  
			  </div>
			  
			  
			 
			  
			  
			 
		
		 </div>
		 
		 <input type="hidden" id="ars_job_purpose" class="form-control" value="${job_purpose}">
		 
		 <div class="mt-5">
			<button class="btn btn-success btn-icon-split float-left"  data-job_number="${job_number}" id="btnApproveJob">
				<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve Request</span>
			</button>

			<button class="btn btn-danger btn-icon-split float-left ml-3"  data-job_number="${job_number}" id="btnQueryJob">
				<span class="icon text-white-50"> <i class="fas fa-times fa-2x"></i></span><span class="text">Query Request</span>
			</button>
		 </div>

          
            
		<jsp:include page="../client_application/_application_process_footer_ar.jsp"></jsp:include>
  
  
