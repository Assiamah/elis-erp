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
   
    <div class="pagetitle">
	    <h4 class="">Case Management</h4>
	     <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item "><a href="${pageContext.request.contextPath}/legal_case_management">Legal Case Management</a></li>
				                  <li class="breadcrumb-item active">Work
				                 	 <a href="${pageContext.request.contextPath}/legal_case_management">
					                  <button  class="btn btn-danger float-right"  onclick="history.back()"
					                    style="position:absolute; right:310px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
					      				Back
					      			  </button>
					      			  </a>
					                  <button data-toggle="modal" href="#updateStatusModal" class="btn btn-success float-right" 
					                    style="position:absolute; right:170px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
					      				Update Status
					      			  </button>
					                  <button data-toggle="modal" href="#letterAttachmentModal" class="btn btn-primary float-right" 
					                    style="position:absolute; right:50px; border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
					      				Attachment
					      			  </button>
				      			  </li>
				                </ol>
			               </nav>
       
	 
 	</div><!-- End Page Title -->
 	</div>
	<section class="section dashboard">
	 <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
	    <input type="text" value="${cases.suit_number}" name="suit_number" id="suit_number" hidden>
	    <input type="text" value="${cases.status_of_case}" name="status_of_case" id="status_of_case" hidden>
	<c:choose>
 		 <c:when test="${cases.nature_of_case == 'Writ of Summons'}">
	 <nav>
        <ol class="breadcrumb">
            <li class=" me-2" style="padding: 5px; border-radius: 10px" id="5">LC File Appearance</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
            <li class=" me-2" style="padding: 5px; border-radius: 10px" id="6">Statement of Defence and/or Counter Claim</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
            <li class=" me-2" style="padding: 5px; border-radius: 10px" id="7">Receive Plaintiff Response</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
			<li class=" me-2" style="padding: 5px; border-radius: 10px" id="8">Receive Application for Direction</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
			<li class=" me-2" style="padding: 5px; border-radius: 10px" id="9">File Witness Statement and other documents </li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
			<li class=" me-2" style="padding: 5px; border-radius: 10px" id="10">Case Management</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
			<li class=" me-2" style="padding: 5px; border-radius: 10px" id="11">Trial</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
			<li class=" me-2" style="padding: 5px; border-radius: 10px" id="12">Judgement</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
			<li class=" me-2" style="padding: 5px; border-radius: 10px" id="4">Appeal</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
        </ol>
      </nav>
      </c:when>
      <c:otherwise>
   
       <nav>
        <ol class="breadcrumb">
          <li class=" me-2" style="padding: 5px; border-radius: 10px" id="1">File Affidavit in Response</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
          <li class=" me-2" style="padding: 5px; border-radius: 10px" id="2">Statement of Case By Applicant</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
          <li class=" me-2" style="padding: 5px; border-radius: 10px" id="3">Ruling</li><i class="fas fa-dot-circle small" style="padding-top: 15px;"></i>
		  <li class=" me-2" style="padding: 5px; border-radius: 10px" id="4">Appeal</li>
        </ol>
      </nav>
	   
      </c:otherwise>
     </c:choose>
	   </c:forEach> 
    	<div class="row">	
      		<!-- Case Details -->
      		<div class="col-lg-8">
				 <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
	              <div class="card-header bg-dark text-white">
				  <h5 class="card-title">Suit No:<strong> ${cases.suit_number} </strong> - [<span class="text-warning me-2 ms-2">${cases.nature_of_case}</span>]</h5>		
			 </div>
				</c:forEach>
              <!-- Accordion without outline borders -->
              <div class="accordion" id="accordionCaseDetails">
              <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
              <div class="accordion-item">
	                 <h2 class="accordion-header" id="parties">
		                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse7" aria-expanded="true" aria-controls="collapse1">
	            			Remarks
		                </button>
	                 </h2>
	                  <div id="collapse7" class="accordion-collapse collapse" aria-labelledby="parties" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                     <%--  <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop"> --%>
	                    	<div class="row mb-4">
	                    		<div class="col-md-12">
	                    			<input class="form-control" name="request_type" value="update_releifs_and_summary" readonly="readonly" hidden="" />
						              <input class="form-control" name="case_id" value="${cases.id}" readonly="readonly" hidden="" />
									
			                    	<label>Note</label>
			                    	<textarea rows="" cols="" readonly class="form-control">${cases.assigned_reasons}</textarea>
		                    	</div>
	                    	</div>
						  	<%-- </c:forEach> --%>
	                    </div>
	                  </div>
	                </div>
	                <div class="accordion-item">
	                 <h2 class="accordion-header" id="parties">
		                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="true" aria-controls="collapse1">
	            			Parties
		                </button>
	                 </h2>
	                  <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="parties" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                      <div class="row ">
	                      	<div class="col-sm-12">
	                      	<h5>Parties(Imported)</h5>
	                			<p id="display_parties" >${cases.display_parties}<p><br/>
	                			<div class="table-responsive card card-body">
	                      		<table class="table table-striped" id="parties_tbl_main"  width="100%" cellspacing="0">
								  <thead>
								    <tr>
										<th scope="col">#</th>
								      <th scope="col">Type</th>
								      <th scope="col">Name</th>
								      <th scope="col">Address</th>
								      <th scope="col">Lawyer</th>
								      <th scope="col">Lawyer's Tel</th>
								      <th scope="col">Lawyer's Address</th>
								      <th scope="col">Chambers</th>
								     <th scope="col">Action</th>
								    </tr>
								  </thead>
								  <tbody id="parties_tbl">
									
								   	<!-- <d:forEach items="${cases.parties}" var="parties" varStatus="appfiles_loop">

			                      			<td>${parties.party_type}</td>
			                      			<td>${parties.party_name}</td>
			                      			<td>${parties.party_address}</td>
			                      			<td>${parties.party_lawyer}</td>
			                      			<td>${parties.lawyer_tel}</td>
			                      			<td>${parties.lawyer_address}</td>
			                      			<td>${parties.lawyer_chamber}</td>
			                      			<td>  -->
												<!-- <button type="button" class="btn btn-danger btn-sm" onclick="deleteRow(this)" id="${parties.party_name}" data_id="${parties.party_name}" data_type="${parties.party_type}">
										          <span class="fas fa-trash"></span> Delete
										        </button> -->
										     <!--  <button type="button" class="btn-edit" data-toggle="modal" href="#editPartyModal" -->
										      <!-- <button type="button" class="btn-edit"
										        data-party_type="${parties.party_type}" 
										        data-party_name="${parties.party_name}" 
										        data-party_address="${parties.party_address}" 
										        data-party_lawyer="${parties.party_lawyer}" 
										        data-lawyer_tel="${parties.lawyer_tel}"
										        data-lawyer_address="${parties.lawyer_address}"
										        data-lawyer_chamber="${parties.lawyer_chamber}">
													<span class="me-2 ms-2">Edit</span>
												</button>  -->
												<!-- <input type="button" id="edit_button2" value="Edit" class="edit" onclick="edit_row(this)">
												<input type="button" id="save_button2" value="Save" class="save" onclick="save_row(this)"> -->
										     <!-- </td>
			                      		</tr>
			                      	</d:forEach> -->
								  </tbody>
								</table>
								</div>
	                       </div>
	                       <div class="d-flex justify-content-end mt-4">
		                       <button type="button" class="btn btn-success btn-sm me-2" id="add_new_party">
						          <span class="fas fa-plus-circle"></span> Add
						        </button>
						      <button type="submit" class="btn btn-primary btn-sm btn-update-table btn_update_parties" id="">
						          <span class="fas fa-check-circle"></span> Updates
						        </button>
						  </div>
	                      </div>
	                    </div>
	                  </div>
	                </div>
                <div class="accordion-item">
	                  <h2 class="accordion-header" id="reliefs">
	                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2">
	                      Reliefs / Summary
	                    </button>
	                  </h2>
	                  <div id="collapse2" class="accordion-collapse collapse" aria-labelledby="reliefs" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    <form action="case_work" method="post">
	                    	<c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
	                    	<div class="row mb-4">
	                    		<div class="col-md-12">
	                    			<input class="form-control" name="request_type" value="update_releifs_and_summary" readonly="readonly" hidden="" />
						              <input class="form-control" name="case_id" value="${cases.id}" readonly="readonly" hidden="" />
									
			                    	<label>Relief</label>
			                    	<textarea rows="" cols="" name="releifs" id="rs_releifs" class="form-control">${cases.releifs}</textarea>
		                    	</div>
	                    	</div>
	                    	<div class="row mb-4">
	                    		<div class="col-md-12">
			                    	<label>Summary</label>
			                    	<textarea rows="" cols="" name="summary" id="rs_summary" class="form-control">${cases.summary}</textarea>
		                    	</div>
	                    	</div>
	                    	 <div class="d-flex justify-content-end">
		                       <button type="button" class="btn btn-primary btn-sm" id="btnEditReliefnSummary">
						          <span class="fas fa-edit"></span> Updates
						        </button>
						  	</div>
						  	</c:forEach>
	                    </form>
	                    </div>
	                  </div>
	                </div>
                
                </c:forEach>
	                 <div class="accordion-item">
		                  <h2 class="accordion-header" id="documents">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3">
		                       Documents
		                    </button>
		                  </h2>
	                  <div id="collapse3" class="accordion-collapse collapse" aria-labelledby="documents" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive card card-body">
		                    	<table class="table table-striped" id="attachments"  width="100%" cellspacing="0">
						 		 	<thead>
						 				<tr>
						 					<th>Document Name</th><th>Document Type</th>
						 				</tr>
						 			</thead>
						 			<tbody>
						 		  	</tbody>    
		 		  				</table>
		 		  			</div>
		 		  			<%-- <div class="d-flex justify-content-end">
		                       <button type="button" class="btn btn-default btn-sm">
						          <span class="fas fa-edit"></span> Attach
						        </button>
						  	</div> --%>
	                    </div>
	                  </div>
	                </div>
              
	                 <div class="accordion-item">
		                  <h2 class="accordion-header" id="related_motions">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
		                      Processes on Suits
		                    </button>
		                  </h2>
	                  <div id="collapse4" class="accordion-collapse collapse" aria-labelledby="related_motions" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    <div class="table-responsive card card-body">
	                    	<table class="table table-striped" id="process_tbl"  width="100%" cellspacing="0">
								  <thead>
								    <tr>
								      <th scope="col">Court Process</th>
								      <th scope="col">Court</th>
								      <th scope="col">Filing Date</th>
								      <th scope="col">Date Received</th>
								      <th scope="col">Action</th>
								    </tr>
								  </thead>
								  <tbody>
								   	<d:forEach items="${suit_cases}" var="suit_cases"  varStatus="appfiles_loop">
			                      		<tr>
			                      			<td>${suit_cases.court_process}</td>
			                      			<td>${suit_cases.court_name}</td>
			                      			<td>${suit_cases.date_of_document}</td>
			                      			<td>${suit_cases.date_received}</td>
			                      			 <td> 
			                      			<%--	<div class="dropdown no-arrow">
							              	  <a class="icon dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							               	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-menu-down" viewBox="0 0 16 16">
							                <path d="M7.646.146a.5.5 0 0 1 .708 0L10.207 2H14a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h3.793L7.646.146zM1 7v3h14V7H1zm14-1V4a1 1 0 0 0-1-1h-3.793a1 1 0 0 1-.707-.293L8 1.207l-1.5 1.5A1 1 0 0 1 5.793 3H2a1 1 0 0 0-1 1v2h14zm0 5H1v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zM2 4.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5z"/>
							              </svg>
						              	  </a>
						              	  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">--%>
						              	  	<form  action="case_details_post" method="post">
						              	  		<input type="hidden" name="case_id" value="${suit_cases.id}">
												<input type="hidden"  name="suit_number" value="${suit_cases.suit_number}">
												<input type="hidden"  name="request_type" value="case_details_case">
						              	    	<button type="submit" class="btn btn-success btn-sm">
						          <span class="fas fa-info-circle"></span> Details</button>
						              	    </form>	   
						              	   <%-- <form  action="case_work" method="post">
						              	  		<input type="hidden" name="case_id" value="${suit_cases.id}">
												<input type="hidden"  name="suit_number" value="${suit_cases.suit_number}">
												<input type="hidden"  name="request_type" value="case_work_case">
						              	    	<button type="submit" class="dropdown-item" >Work</button>
						              	    </form>           	    
						              	  </div>
						              	</div> --%>
			                      			</td>
			                      		</tr>
			                      	</d:forEach>
								  </tbody>
								</table>
								</div>
	                  
	                 <!--  	<div class="d-flex justify-content-end">
		                       <button type="button" class="btn btn-default btn-sm">
						          <span class="fas fa-edit"></span> Link
						        </button>
						         <button type="button" class="btn btn-default btn-sm">
						          <span class="fas fa-edit"></span> Unlink
						        </button>
						  </div> -->
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
	                    	<div class="table-responsive card card-body">
		                    	<table class="table table-striped" id="notes_table"  width="100%" cellspacing="0">
						 		 	<thead>
						 				<tr>
						 					<th>Subject</th><th>Notes</th><th>Action</th>
						 				</tr>
						 			</thead>
						 			<tbody>
						 		  	</tbody>    
		 		  				</table>
	 		  				</div>
	 		  				<div class="d-flex justify-content-end">
		                       <button type="button" class="btn btn-success btn-sm" id="make_note">
						          <span class="fas fa-edit"></span> New
						        </button>
						  	</div>
	                    </div>
	                  </div>
	                </div>
	                
	                <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse6" aria-expanded="false" aria-controls="collapse5">
							Records Info Requests
		                    </button>
		                  </h2>
	                  <div id="collapse6" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive card card-body">
				                    	<table class="table table-striped" id="requested_info"  width="100%" cellspacing="0">
								 		 	<thead>
								 				<tr>
								 					<th>Subject</th><th>Description</th><th>Deadline</th><th>Status</th><th>Requested Date</th>
								 				</tr>
								 			</thead>
								 			<tbody>
								 		  	</tbody>    
				 		  				</table>
				 		  			</div>
				 		  			
				 		  		<div class="d-flex justify-content-end mt-4">
		                       <!-- <a type="button" class="btn btn-success btn-sm" href="">
						          <span class="fas fa-edit"></span> New
						        </a> -->
						        
						        <c:forEach items="${case_detail}" var="cases"  varStatus="appfiles_loop">
						        <form  action="request_record_info" method="post">
						              	  		<input type="hidden" name="case_id" value="${cases.id}">
												<input type="hidden"  name="suit_number" value="${cases.suit_number}">
												<input type="hidden"  name="request_type" value="record_info">
						              	    	<button type="submit" class="btn btn-success btn-sm">
						          <span class="fas fa-edit"></span> New Request</button>
						        
						              	    </form> 
						              	    </c:forEach>
						  	</div>
	                    </div>
	                  </div>
	                </div>
	                
	                <div class="accordion-item">
		                  <h2 class="accordion-header" id="notes">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse8" aria-expanded="false" aria-controls="collapse5">
		                      Records Information
		                    </button>
		                  </h2>
	                  <div id="collapse8" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive card card-body">
				                    	<table class="table table-striped" id="provided_docs"  width="100%" cellspacing="0">
								 		 	<thead>
								 				<tr>
								 					<th>Info. Provided</th>
								 					<!-- <th>Attachment</th> -->
								 					<th>Division</th><th>Provided By</th><th>Date</th><th>Action</th>
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
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse9" aria-expanded="false" aria-controls="collapse5">
		                      Minutes
		                    </button>
		                  </h2>
	                  <div id="collapse9" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	<div class="table-responsive card card-body">
				                    	<table style="width:100%" class="table table-striped"  id="minutes_tbl"  width="100%" cellspacing="0">
								 		 	<thead>
								 				<tr>
								 					<th style="width:70%">Note</th>
								 					<th style="width:15%">Minuted By</th>
								 					<th style="width:15%">Date</th>
								 					<!-- <th>Action</th> -->
								 				</tr>
								 			</thead>
								 			<tbody>
								 			<%--  <c:forEach items="${minute_detail}" var="minutes"  varStatus="appm_loop"> 
											   <d:forEach items="${minutes.data}" var="mdata"  varStatus="appd_loop"> 
											   	 <tr>
											   		<td>${mdata.minutes}</td>
											   		<td>${mdata.added_by_name}</td>
											   		<td>${mdata.date_created}</td>
											   		<td></td>
											   	 </tr>
											   </d:forEach>
								 			</c:forEach> --%>
											  </tbody>   
				 		  				</table>
				 		  			</div>
	 		  				<div class="d-flex justify-content-end mt-4">
		                       <button type="button" class="btn btn-success btn-sm" id="make_minute">
						          <span class="fas fa-edit"></span>Add New
						        </button>
						  	</div>
	                    </div>
	                  </div>
	                </div>
	                
	                
	                  <%-- <div class="accordion-item">
		                  <h2 class="accordion-header" id="templates">
		                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
		                      Templates
		                    </button>
		                  </h2>
	                  <div id="collapse5" class="accordion-collapse collapse" aria-labelledby="notes" data-bs-parent="#accordionCaseDetails">
	                    <div class="accordion-body">
	                    	
	                    	
	 		  			
	                    </div>
	                  </div>
	                </div> --%>
                
			</div> <!-- Accordion -->
           </div><!-- col6 -->
            <!-- Right side columns -->
        <div class="col-lg-4">

          <!-- Recent Activity -->
          <div class="card">
          
            <div class="card-body">
              <h5 class="card-title">Upcoming <span>| Timeline </span></h5>
				<ul class="timeline-3" id="upcoming">
			       
			       
			      </ul>
            </div>
          </div><!-- End Recent Activity -->

         <!-- Recent Activity -->
          <div class="card mt-4">
            <div class="filter">
              <a class="icon" href="#" ><i class="bi bi-three-dots"></i></a>
            </div>

            <div class="card-body">
              <h5 class="card-title">Past <span>| Timeline</span></h5>
				<ul class="timeline-3" id="past">
			       
			      </ul>
           

            </div>
          </div><!-- End Recent Activity -->
         


        </div><!-- End Right side columns -->

 		</div>
 		
 	<%-- 	<div class="row">
 				<div class="col-lg-4">
	 			<div class="card">
	 				<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Generate Template 
					</div>
	 				<div class="card-body">
			 			
			           <form id="generate_letter">
			              <div class="row mb-3">
							<label for="inputNumber" class="col-sm-4 col-form-label">Letter Template</label>
						 </div> 
						 <div class="row mb-3">   
			             		<select class="form-control" id="letter_template" required>
			             			<option value="default" selected>Default</option>
			             			<option value="appearance">File Appearance</option>
			             			<option value="statement">State of Defendence</option>
			             		</select>
			             </div> 
			 			  <div class="row mb-3">
							<label for="inputNumber" class="col-sm-4 col-form-label">Letter Body</label>
						 </div> 
						 <div class="row mb-3">   
			              <textarea rows="10" style="height:100%;" type="text" class="form-control" id="text-area-first" name="text-area-first" required placeholder="text">
			                 
			              </textarea>
			             </div> 
			             <div class="row mb-3">
			             		<div class="d-flex justify-content-center">
			             			<button class="btn btn-primary"  type="submit" id="generateLetterBtn"
				                    style="border-radius:50px; text-align:center; box-shadow:2px 2px 3px #999;">
				      				Generate Letter
				      			  </button>
			             		</div> 		
			             </div>
			             </form>
			        </div>
				</div>
      		</div>
 				
 		
 		
 		</div> --%>
 		
	</section>
 
 	</div>
<!-- End Page Content -->

<%-- <div class="modal fade" id="view_notes" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Suit Number: <span class="text-danger" id="n_suit_number"></span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <b>Notes:</b> <span class="ms-2" id="n_notes"></span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div> --%>

 <!-- Attachment Modal -->
  <div class="modal fade" id="letterAttachmentModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Attach Document</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="letter_upload" method="post" enctype="multipart/form-data">
        
        <div class="modal-body" style="font-size: small;">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
			<div class="col-sm-8">
			<input class="form-control" type="text" id="case_id" name="case_id" value='<c:out value="${case_detail[0].id}"></c:out>' hidden="" readonly required>
              <input class="form-control" type="text" id="suit_number" name="suit_number" value='<c:out value="${case_detail[0].suit_number}"></c:out>' readonly required>
            </div>
		  </div>
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Type of Document:</label>
			<div class="col-sm-8">
               <!-- <select name="a_type_of_document" id="a_type_of_document" class="form-control" required>
	 				<option value="app">Letter of Appearance</option>
	 				<option value="stod">State of Defence</option>
	 				<option value="oth">other</option>
			  </select> -->
			  <input class="form-control" type="text" id="a_type_of_document" name="a_type_of_document" required>
            </div>
		  </div>
		   <div class="row mb-3">
            <label for="inputNumber" class="col-sm-4 col-form-label">Select Document:</label>
            <div class="col-sm-8">
              <input class="form-control" type="file" id="file" name="file" accept="application/pdf" required>
            </div>
          </div>

        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Upload</button>
        </div>
       </form>
      </div>
    </div>
  </div>
  
  <!-- Notes Modal  -->
   <!-- Attachment Modal -->
  <div class="modal fade" id="notesModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Make Note</h5>
           <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="case_note" method="post" enctype="multipart/form-data">
        
        <div class="modal-body" style="font-size: small;">
         
          <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
			<div class="col-sm-12">
              <input class="form-control" type="text" id="n_suit_number" name="n_suit_number" value='<c:out value="${case_detail[0].suit_number}"></c:out>' readonly required>
            </div>
		  </div>
		  <div class="row mb-3">
		  	<label for="inputNumber" class="col-sm-4 col-form-label">Subject</label>
		  
			<div class="col-sm-12">
              <input class="form-control" type="text" id="subject" name="subject"  required>
            </div>
		  </div>
		  <div class="row mb-3">
		  <label for="inputNumber" class="col-sm-4 col-form-label">Notes</label>
		   
            <div class="col-sm-12">
              <textarea class="form-control"  id="notes_text" name="notes" required></textarea>
            </div>
          </div>
          <input class="form-control" type="text" id="n_case_id" name="n_case_id" hidden>
			<input type="text" name="created_by" id="created_by" value="${sessionScope.userid}" hidden>
        </div>
        <div class="modal-footer">
          <button type="submit" id="save_note" class="btn btn-primary">Save</button>
        </div>
       </form>
      </div>
    </div>
  </div>
  
  <!-- Notes Modal  -->
  <!-- Attachment Modal  -->
 <%--  <div class="modal fade" id="elisDocumentPreview" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true"> --%>
	<div class="modal fade" id="elisDocumentPreviewx" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Suit Number: <span class="text-danger" id="p_suit_number"></span></h5>
				<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
				<div class="card card-body mb-4">
					<div class="row">
						<div class="col-md-6">
							<b>Report:</b>
							<textarea class="form-control mt-2" rows="7" readonly id="n_notes"></textarea>
						</div>
						<div class="col-md-6">
							<div class="pt-2 mt-2">
								<iframe src=""  id="elisdovumentpreviewblobfile" width="100%" height="600"></iframe>
							</div>
						</div>
					</div>
				</div>
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>
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
												
												<iframe src=""  id="fedocumentPreviewblobfile" width="100%" height="600"></iframe>
							
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>
  <!-- Parties Modal  -->
<div class="modal fade" id="addPartyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Add Party</h5>
	        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <form method="post" id="addPartyForm">
	      <div class="modal-body">
	     
	      	<div class="text-start">
				<label for="basic-url">Party Type</label>
			</div>
			<div class="input-group mb-3">
			  <select class="form-control" aria-label="Default select example" name="party_type" id="party_type" required>
                <option disabled selected>-- select --</option>
                <option value="Plaintiff">Plaintiff</option>
				<option value="Defendant">Defendant</option>	
              </select>
			</div>
			<div class="text-start">
				<label for="basic-url">Party Name</label>
			</div>
			<div class="input-group mb-3">
			  <input type="text" class="form-control " name="party_name" id="party_name" required />
			</div>
			<div class="text-start">
				<label for="basic-url">Party's Address</label>
			</div>
			<div class="input-group mb-3">
			  <textarea  class="form-control " name="party_address" id="party_address" ></textarea>
			</div>
			<div class="text-start">
				<label for="basic-url">Party's Lawyer</label>
			</div>
			<div class="input-group mb-3">
			  <input type="text" class="form-control " name="party_lawyer" id="party_lawyer"  />
			</div>
			<div class="text-start">
				<label for="basic-url">Lawyer's Telephone</label>
			</div>
			<div class="input-group mb-3">
			  <input type="number" class="form-control " name="lawyer_tel"  id="lawyer_tel" />
			</div>
			<div class="text-start">
				<label for="basic-url">Laywer's Address</label>
			</div>
			<div class="input-group mb-3">
			  <textarea  class="form-control " name="lawyer_address" id="lawyer_address" ></textarea>
			</div>
			<div class="text-start">
				<label for="basic-url">Laywer's Chamber</label>
			</div>
			<div class="input-group mb-3">
			  <input type="text" class="form-control " name="lawyer_chamber" id="lawyer_chamber"  />
			</div>
			
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-success" id="add_party">Add</button>
	      </div>
	     </form>
	    </div>
	  </div>
	</div>
	
 <!-- Attachment Modal -->
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
			<label for="inputNumber" class="col-sm-4 col-form-label">Suit Number:</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="suit_number" name="suit_number" value='<c:out value="${case_detail[0].suit_number}"></c:out>' readonly required>
            </div>
		  </div>
		  
		  <div class="row mb-3" hidden="">
			<label for="inputNumber" class="col-sm-4 col-form-label">Case ID:</label>
			<div class="col-sm-8">
              <input class="form-control" type="text" id="case_id" name="case_id" value='<c:out value="${case_detail[0].id}"></c:out>' readonly required>
            </div>
		  </div>
		  
		  <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Status</label>
			<div class="col-sm-8">
               <select class="form-control" aria-label="Default select example" name="status_case" id="status_case"  required>
                 <c:forEach items="${cases_status}" var="status"  varStatus="typeslist_loop">
                     <option value="${status.id}" >${status.description}</option>
                 </c:forEach>
			  </select>
            </div>
		  </div>
		    <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">Start Date</label>
			<div class="col-sm-8">
		        <input type="date" class="form-control " name="start_date" id="start_date" required />
            </div>
		  </div>
		   <div class="row mb-3">
			<label for="inputNumber" class="col-sm-4 col-form-label">End Date</label>
			<div class="col-sm-8">
		        <input type="date" class="form-control " name="end_date" id="end_date" required />
            </div>
		  </div>
		   <input type="text" name="updated_by" value="${sessionScope.userid}" hidden />

        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Update</button>
        </div>
       </form>
      </div>
    </div>
  </div>
  
  
  <div class="modal fade" id="viewTimelineDetails" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Update Status</h5>
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
               <textarea class="form-control" rows="5" id="up_notes"></textarea>
            </div>
		  </div>
		   <input type="text" name="updated_by" value="${sessionScope.userid}" hidden />

        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Update</button>
        </div>
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
          <input class="form-control" type="text" id="m_case_id" name="m_case_id" value="${case_detail[0].id}" hidden>
			<input type="text" name="m_created_by" id="m_created_by" value="${sessionScope.fullname}" hidden>
			<input type="text" name="m_created_by_id" id="m_created_by_id" value="${sessionScope.userid}" hidden>
        </div>
        <div class="modal-footer">
          <button type="submit" id="save_minute" class="btn btn-primary">Submit</button>
        </div>
       </form>
      </div>
    </div>
  </div>

  <!-- <div class="modal fade" id="editPartyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	  <div class="modal-content">
		<div class="modal-header"> -->
  <div class="modal fade" id="editPartyModal" tabindex="-1">
	  <div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
		<div class="modal-header">
		  <h5 class="modal-title" id="exampleModalLabel">Edit Party</h5>
		  <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		  </button>
		</div>
		<form action="" method="POST" enctype="multipart/form-data" id="edit_party_form">
		<div class="modal-body">
			<!-- <input type="" id="party_id" value=""> -->
			<input type="hidden" id="row_num" value="">
			<div class="text-start">
			  <label for="basic-url">Party Type <span class="text-danger">*</span></label>
		  </div>
		  <div class="input-group mb-3">
			<select class="form-control" aria-label="Default select example" name="party_type" id="e_party_type" required>
				
			</select>
		  </div>
		  <div class="text-start">
			  <label for="basic-url">Party Name <span class="text-danger">*</span></label>
		  </div>
		  <div class="input-group mb-3">
			<input type="text" class="form-control " name="party_name" id="e_party_name" required />
		  </div>
		  <div class="text-start">
			  <label for="basic-url">Party's Address</label>
		  </div>
		  <div class="input-group mb-3">
			<textarea  class="form-control " name="party_address" id="e_party_address" ></textarea>
		  </div>
		  <div class="text-start">
			  <label for="basic-url">Party's Lawyer</label>
		  </div>
		  <div class="input-group mb-3">
			<input type="text" class="form-control " name="party_lawyer" id="e_party_lawyer"  />
		  </div>
		  <div class="text-start">
			  <label for="basic-url">Lawyer's Telephone</label>
		  </div>
		  <div class="input-group mb-3">
			<input type="number" class="form-control " name="lawyer_tel"  id="e_lawyer_tel" />
		  </div>
		  <div class="text-start">
			  <label for="basic-url">Lawyer's Address</label>
		  </div>
		  <div class="input-group mb-3">
			<textarea  class="form-control " name="lawyer_address" id="e_lawyer_address" ></textarea>
		  </div>
		  <div class="text-start">
			  <label for="basic-url">Lawyer's Chamber</label>
		  </div>
		  <div class="input-group mb-3">
			<input type="text" class="form-control " name="lawyer_chamber" id="e_lawyer_chamber"  />
		  </div>
		</div>
		<div class="modal-footer">
		  <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		  <button type="button" class="btn btn-success" data-bs-dismiss="modal" id="btn-update-party">Update</button>
		</div>
	   </form>
	  </div>
	</div>
  </div> 
  
  <!-- Notes Modal  -->
<jsp:include page="../legal/includes/footer.jsp"></jsp:include>

<script type="text/javascript" src="legal/includes/pages_script/case_work.js"></script>
<script src="https://mozilla.github.io/pdf.js/build/pdf.js"></script>
 <script src="legal/includes/bootstrap/js/bootstrap.min.js"></script>
 
 
 <script>

  document.addEventListener('DOMContentLoaded', function() {
	  
	  let suit_number =  $('#suit_number').val();
	  let case_id =  $('#case_id').val();

	  console.log(suit_number, case_id)
	  
	  let dataSet =[];
	  let num = "";
		
		$.ajax({
			type:"POST",
			url:"case_details_serv",
			data:{"request_type":"load_minutes_on_case",
				  "suit_number":suit_number,
				  "case_id":case_id,
			},
			success:function(response){
				console.log(response);
				let json_result = JSON.parse(response);
				
				 if(json_result.success){
						if(json_result.data !== null){
							
							for(let i=0; i<json_result.data.length; i++){
				                let html=[];
				                //num = (+num + 1);
				                let minutes= json_result.data[i].minutes;
				                let added_by_name= json_result.data[i].added_by_name;
				               	let date_created=json_result.data[i].date_created.split('.')[0];;
				               	let action="";
				                
				               html.push("<span style='width: 70%'>"+minutes+"</span>");
				               html.push(added_by_name);
				               html.push(date_created); 
				               //html.push(action); 
			
				                dataSet.push(html);
		            		}

						}
							
						$('#minutes_tbl').DataTable().clear().destroy();
							
						$('#minutes_tbl').DataTable({ 
							data: dataSet
						}).draw();
						
						//document.getElementById("minutes_tbl").style.width = "1000px";
							
					}

				}
		})
	  
	  $("#make_minute").on('click',function(e){
		  $("#minuteModal").modal('show');
	  })
	  
	  $("#save_minute").on('click',function(e){
		  e.preventDefault();
		  
			let suit_number =  $('#m_suit_number').val();
			let case_id =  $('#m_case_id').val();
			let created_by =  $('input[name="m_created_by"]').val();
			let created_by_id =  $('#m_created_by_id').val();
			let minutes =  $('#minutes').val();
			
			console.log(created_by);
			
			if(!minutes) {
				toastr["error"]("Please the required field is empty", "Error");
			}
			else {
				$.ajax({
					type:"POST",
					url:"case_work_serv",
					data:{"request_type":"add_minutes_on_case",
						  "suit_number":suit_number,
						  "created_by_id":created_by_id,
						  "minutes":minutes,
						  "created_by":created_by,
						  "case_id":case_id,
					},
					success:function(response){
						console.log(response);
						
						let json_results=JSON.parse(response);
						
						if(json_results.success){
							 toastr["success"]("Munite saved successfully", "Success");
							 
							  setInterval(function(){
			                       location.reload();
			                 },1000); 
			                 
			                 $("#minuteModal").modal('hide');
		                } 
		              else {
		                        toastr["error"]("Error occurred saving munite", "Error");
		                 }

		                    $("#minuteModal").find('form').trigger('reset');
		                    
		                    $("#make_minute").prop('disabled', false);
						}
				})
			}
			
	  })
  
	  
		
		
	})

			
	

 </script> 