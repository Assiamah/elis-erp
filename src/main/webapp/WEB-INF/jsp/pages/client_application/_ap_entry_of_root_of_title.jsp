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
					          
   <h3 class="border-bottom border-gray pb-2">Root of Title</h3>
   <div class="row">
	<div class="col-6">
		<div class="card card-body mt-3">
			
			<label for="" class="col-form-label">Interest Number:</label>
			   <input type="text" class="form-control" readonly value="${interest_number}" id="lc_txt_interest_number" />
			   <div class="mt-3">
				<button 
				class="btn btn-primary w-100" id="lc_btn_generate_interest_number"
				<c:if test="${not empty interest_number and interest_number ne 'null'}">
					disabled
				</c:if>
			 >
	 
			<i class="fas fa-check-circle mr-1"></i>
				Generate
			</button>
			   </div> 
		</div>
	</div>
	<div class="col-6">

		<div class="card card-body mt-3">
			<label for="" class="col-form-label">Sub Interest Number:</label>
		   <input type="text" class="form-control" readonly value="${sub_interest_number}" id="lc_txt_sub_interest_number" />

		   <div class="mt-3">
			<button 
			class="btn btn-primary w-100" id="lc_btn_generate_sub_interest_number"
			<c:if test="${not empty sub_interest_number and sub_interest_number ne 'null'}">
				disabled
			</c:if>
		 >
 
		<i class="fas fa-check-circle mr-1"></i>
			Generate
		</button>
		   </div> 
		</div>
	</div>
</div>
<br><br> 
                
                
<div id="accordion" role="tablist" aria-multiselectable="true">
	
	<div class="card mb-3">
	
	
		<div class="card">
		<div class="card-header bg-dark text-white " role="tab"
			id="headingThree"
		>
			<a class="collapsed d-block  text-white " data-toggle="collapse"
				data-parent="#accordion" href="#collapseaddcertregis"
				aria-expanded="false" aria-controls="collapseFive"
				style="text-decoration: none !important"
			> <i class="fa fa-chevron-down pull-right"></i> <i
				class="fa fa-users"
			></i>Root of Title
			</a>
		</div>
		<div id="collapseaddcertregis" class="collapse" role="tabpanel"
			aria-labelledby="headingThree"
		>
			<div class="card-body">

		 <h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
		<button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
			<i class="fa fa-plus-circle"></i>
		</button>
		 
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
					 <th>Term</th>
					<th>Action</th>
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
						<td>${proprietorship_section.ps_term}</td>
	
					
						<td>
							<p data-placement="top" data-toggle="tooltip" title="Batch">
								<!-- <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
									<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
								</button> -->
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
							data-ps_term="${proprietorship_section.ps_term}"
							data-whatever="edit">
								<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
							</button>
							</p>
						</td>
						
							
						<!-- <td>
							<p data-placement="top" data-toggle="tooltip" title="Batch">
								<button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#lrdtransactionapprovalmodal" 
								data-target-id="${proprietorship_section.ps_id}" 
								data-ps_proprietor="${proprietorship_section.ps_proprietor}"
								data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
								data-case_number="${proprietorship_section.case_number}"
								data-transaction_id="${proprietorship_section.ps_id}"
								data-whatever="edit">
									<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Approve</span>
								</button>
							</p>
						</td> -->
						 
						
						</tr>
					</c:forEach>
				  </tbody>
	
			
			</table>
		  </div>
		  
		  
		  
		  
		   <h5 class="border-bottom border-gray pb-2">Memorial Details</h5>
			  <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newMemorialsModal" data-toggle="tooltip" title="Add New Memorial">
		<i class="fa fa-plus-circle"></i>
	</button>
		 
		 <div  class="table w-auto small table-responsive">
		<table class="table table-bordered" id="lrd_memorial_details_dataTable" >
		   
			<thead>
			  <tr>

			   <th>Registered No</th>
			   <th>Memorials</th>
			   <th>Date of Instrument</th>
			   <th>Date of Registration</th>
			   <th>Entry No</th>
			   <th>Edit</th>
			  
			   </tr>
			</thead>
			
			  <tbody>
			   <c:forEach items="${lrd_memorials_section}" var="memorials_section">
				  <tr>
					  <td>${memorials_section.m_registered_no}</td>
					  <td>${memorials_section.m_memorials}</td>
					  <td>${memorials_section.m_date_of_instrument}</td>
					  <td>${memorials_section.m_date_of_registration}</td>
					  <td>${memorials_section.m_entry_number}</td>
					   <td>
							  
							  <p data-placement="top"  title="Edit">  
									<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
										 data-target="#newMemorialsModal"
										 data-target-id="${memorials_section.mid}"
										 data-mid="${memorials_section.mid}"  
										 data-m_case_number="${memorials_section.m_case_number}"
										 data-m_registered_no="${memorials_section.m_registered_no}"
										 data-m_memorials="${memorials_section.m_memorials}"
										 data-m_date_of_registration="${memorials_section.m_date_of_registration}"
										 data-m_date_of_instrument="${memorials_section.m_date_of_instrument}"
										 data-m_back="${memorials_section.m_back}"
										 data-m_remarks="${memorials_section.m_remarks}"
										 data-m_entry_number="${memorials_section.m_entry_number}"
										 > 
												 
												 
										<span class="icon text-white-50"> 
										<i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
								</p>
							  
							  </td>
			  
	  
	   
	  
	  </tr>
			  </c:forEach>
				</tbody>
  
		  
		  </table>
		  </div>
		  
		  
		  <h5 class="border-bottom border-gray pb-2">Valuation Details</h5>
	   <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newValuationModal" data-toggle="tooltip" title="Add New Valuation Records">
		<i class="fa fa-plus-circle"></i>
	</button>
		 
		 <div  class="table w-auto small table-responsive">
		   <table class="table table-bordered" id="lrd_valuation_details_dataTable">
		   
			  <thead>
				<tr>

				 <th>Date of Valuation</th>
				 <th>Amount</th>
				 <th>Remarks</th>
				 <th>Edit</th>
				  
				  </tr>
			  </thead>
			  
				<tbody>
	 <c:forEach items="${lrd_valuation_section}" var="valuation_section">
	<tr>
		<td>${valuation_section.vs_date_of_valuation}</td>
		<td>${valuation_section.vs_amount}</td>
		<td>${valuation_section.vs_remarks}</td>
		
		 <td>
								
								<p data-placement="top"  title="Edit">  
									  <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
										   data-target="#newValuationModal"
										   data-target-id="${valuation_section.vs_id}"
										   data-vs_id="${valuation_section.vs_id}"  
										   data-vs_case_number="${valuation_section.vs_case_number}"
										   data-vs_date_of_valuation="${valuation_section.vs_date_of_valuation}"
										   data-vs_amount="${valuation_section.vs_amount}"
 
										   data-vs_remarks="${valuation_section.vs_remarks}"
										   > 
												   
												   
										  <span class="icon text-white-50"> 
										  <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
								  </p>
								
								</td>
	   
	  <%--  <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm"><input type="hidden" name="case_numer" id="case_number" value="${valuation_section.vs_id}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
		--%> 
			
		
		 
		
		</tr>
</c:forEach>
				  </tbody>
	
			
			</table>
		  </div>
		  
		  
		  
	  <h5 class="border-bottom border-gray pb-2">Certificate Details</h5>
		  <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newCertificateModal" data-toggle="tooltip" title="Add New">
		<i class="fa fa-plus-circle"></i>
		</button>
		 <div class= "clear"></div><br>
		 <div  class="table w-auto small table-responsive">
		   <table class="table table-bordered" id="lrd_certificate_details_dataTable">
		   
			  <thead>
				<tr>

				 <th>Date of Issue</th>
				 <th>To Whom Issued</th>
				 <th>Serial Number</th>
				 <th>Official Notes</th>
				 
				   <th>Remove</th>
				  </tr>
			  </thead>
			  
				<tbody>
	 <c:forEach items="${lrd_certificate_section}" var="certificate_section">
	<tr>
		<td>${certificate_section.cs_date_of_registration}</td>
		<td>${certificate_section.cs_to_whom_issued}</td>
		<td>${certificate_section.cs_serial_number}</td>
		<td>${certificate_section.cs_official_notes}</td>
		<td>
								
								<p data-placement="top"  title="Edit">  
									  <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
										   data-target="#newCertificateModal"
										   data-target-id="${certificate_section.cs_id}"
										   data-cs_id="${certificate_section.cs_id}"  
										   data-cs_case_number="${certificate_section.cs_case_number}"
										   data-cs_date_of_registration="${certificate_section.cs_date_of_registration}"
										   data-cs_to_whom_issued="${certificate_section.cs_to_whom_issued}"
										   data-cs_serial_number="${certificate_section.cs_serial_number}"

										   data-cs_official_notes="${certificate_section.cs_official_notes}"
										   > 
												   
												   
										  <span class="icon text-white-50"> 
										  <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
								  </p>
								
								</td>   
			
		
		 
		
		</tr>
</c:forEach>
				  </tbody>
	
			
			</table>
		  </div>
		  
	
	
	
		  <h5 class="border-bottom border-gray pb-2">Reservation Details</h5>
		  <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newReservationModal" data-toggle="tooltip" title="Add New">
		<i class="fa fa-plus-circle"></i>
		</button>
		 <div class= "clear"></div><br>
		 <div  class="table w-auto small table-responsive">
		   <table class="table table-bordered" id="lrd_reservation_details_dataTable">
		   
			  <thead>
				<tr>

				 <th>Reservation Description</th>
				 <th>Created By</th>
				 <th>Created On</th>
				 
				   <th>Action</th>
				  </tr>
			  </thead>
			  
				<tbody>
	 <c:forEach items="${lrd_reservation_section}" var="reservation_section">
	<tr>
		<td>${reservation_section.reservation_description}</td>
		<td>${reservation_section.modified_by}</td>
		<td>${reservation_section.created_date}</td>
		<!-- <td>${certificate_section.cs_official_notes}</td> -->
		<td>
								
								<p data-placement="top"  title="Edit">  
									  <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
										   data-target="#newReservationModal"
										   data-rs_id="${reservation_section.rs_id}"
										   data-rs_reservation_description="${reservation_section.reservation_description}"  
										   data-rs_case_number="${reservation_section.case_number}"
										   > 
												   
												   
										  <span class="icon text-white-50"> 
										  <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
								  </p>
								
								</td>   
			
		
		 
		
		</tr>
</c:forEach>
				  </tbody>
	
			
			</table>
		  </div>
	
		   
	
	
	

			</div>
		</div>
	</div>
	<br>
	

<div class="card">
		<div class="card-header bg-dark text-white " role="tab"
			id="headingThree"
		>
			<a class="collapsed d-block  text-white " data-toggle="collapse"
				data-parent="#accordion" href="#collapseencumbrances"
				aria-expanded="false" aria-controls="collapseFive"
				style="text-decoration: none !important"
			> <i class="fa fa-chevron-down pull-right"></i> <i
				class="fa fa-users"
			></i>Encumberances Details
			</a>
		</div>
		<div id="collapseencumbrances" class="collapse" role="tabpanel"
			aria-labelledby="headingThree"
		>
			<div class="card-body">

<h5 class="border-bottom border-gray pb-2">Encumberances Details</h5>
		  <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newEncumberancesModal" data-toggle="tooltip" title="Add New">
		<i class="fa fa-plus-circle"></i>
		</button>
		 <div class= "clear"></div><br>
				  <div  class="able w-auto small table-responsive">
				<table class="table table-bordered" id="lrd_registration_encumbrance_dataTable">
					   
					<thead>
					  <tr>
  <!-- 	es_id -->
					   <th>Registered Number</th>
					   <th>Date of Instrument</th>
					   <th>Date of Registration</th>
					   <th>Memorials</th>
					   <th>Remarks</th>
					   <th>Entry No.</th>
					   <th>Action</th>
						</tr>
					</thead>
					

					  <tbody>
					   <c:forEach items="${lrd_encumbrances_section}" var="lrd_encumbrances_section_row">
						  <tr>
							  <td>${lrd_encumbrances_section_row.es_registered_number}</td>
							  <td>${lrd_encumbrances_section_row.es_date_of_instrument}</td>
							  <td>${lrd_encumbrances_section_row.es_date_of_registration}</td>
							  <td>${lrd_encumbrances_section_row.es_memorials}</td>
							  <td>${lrd_encumbrances_section_row.es_remarks}</td>
							  <td>${lrd_encumbrances_section_row.es_entry_number}</td>
							  <td>
								  <button class="btn btn-secondary btn-icon-split" 
								  data-toggle="modal"
								  data-target="#newEncumberancesModal"
								  data-es_id="${lrd_encumbrances_section_row.es_id}"
								  data-es_case_number="${lrd_encumbrances_section_row.es_case_number}"
								  data-es_registered_number="${lrd_encumbrances_section_row.es_registered_number}"
								  data-es_date_of_registration="${lrd_encumbrances_section_row.es_date_of_registration}"
								  data-es_date_of_instrument="${lrd_encumbrances_section_row.es_date_of_instrument}"
								  data-es_back="${lrd_encumbrances_section_row.es_back}"
								  data-es_forward="${lrd_encumbrances_section_row.es_forward}"
								  data-es_remarks="${lrd_encumbrances_section_row.es_remarks}"
								  data-es_memorials="${lrd_encumbrances_section_row.es_memorials}"
								  data-es_signature="${lrd_encumbrances_section_row.es_signature}"
								  data-es_entry_number="${lrd_encumbrances_section_row.es_entry_number}"
								  data-es_action_on_form_encumbrances="edit"
								  >
								  <span class="icon text-white-50"> 
									  <i class="fas fa-pen"></i></span> <span class="text">Edit</span>
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


	
	<!-- <div class="card">
		
		<div id="collapseparties" class="collapse" role="tabpanel"
			aria-labelledby="headingThree"
		>
			<div class="card-body">

				<button class="btn btn-success btn-icon-split pull-right " id="btnViewBatchlist">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span>
					<span class="text">View Batch List</span>
				</button>
				
				<button class="btn btn-info btn-icon-split pull-left" id="btnLinktoExistingCaselist">
					<span class="icon text-white-50"> <i class="fas fa-plus"></i></span>
					<span class="text" >Link Existing Case</span>
				</button>
			</div>
		</div>
	</div>
	<br> -->
	
		
		<br>
						
		<div class="card">
		<div class="card-header bg-dark text-white " role="tab"
			id="headingThree"
		>
			<a class="collapsed d-block  text-white " data-toggle="collapse"
				data-parent="#accordion" href="#collapseprecertregis"
				aria-expanded="false" aria-controls="collapseFive"
				style="text-decoration: none !important"
			> <i class="fa fa-chevron-down pull-right"></i> <i
				class="fa fa-users"
			></i>Generate Certificate and Land Register
			</a>
		</div>
		<div id="collapseprecertregis" class="collapse" role="tabpanel"
			aria-labelledby="headingThree"
		>
			<div class="card-body">

		

<div class="form-row">
							  <div class="col-md-12">
								<label for="search_value">Register:Description of Land</label>
								 
								
								 
									<textarea id="lc_description_of_land_lrd" name="lc_description_of_land_lrd" class="form-control col-sm-12" required rows=3  style="padding:50px !important;">${smd_region} </textarea> 
								
								
							   <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
				 --%>
															
								</div>
								
							   
							 
							</div>


<div class="form-row">
							  
							  <div class="col-6">
									  <br><br>									                 
										   
											   <button type="button" name="btn_compose_register_description" id="btn_compose_register_description" class="btn  btn-primary btn-icon-split w-100"  >
											<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
										</button>
										
									
								</div>
								
								 <div class="col-6">
										  <br><br>
										
										   <button type="button" name="lc_btn_save_register_description" id="lc_btn_save_register_description" 
										   class="btn btn-block btn-secondary btn-icon-split w-100"  >
											 <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save</span>
										</button>
								
								</div>
								
							  
							  </div>
							


<div class="form-row mt-5">
							  <div class="col-md-12">
								<label for="search_value">Certificate Summary</label>
								 
								
								 
									<textarea id="lc_search_report_summary_details" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
								
								
							   <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
				 --%>
															
								</div>
								
							   
							 
							</div>
							
							
							
							 
							<div class="form-row">
							  
							  <div class="col-6">
									  <br><br>									                 
										   
											   <button type="button" name="btn_compose_certificate_template" id="btn_compose_certificate_template" class="btn  btn-primary btn-icon-split w-100 "  >
											<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
										</button>
										
									
								</div>
								
								 <div class="col-6">
										  <br><br>
										
										   <button type="button" name="lc_btn_save_search_report" id="lc_btn_save_search_report" 
										   class="btn btn-block btn-secondary btn-icon-split w-100"  >
											 <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save Certificate</span>
										</button>
								
								</div>
								
								<!-- <div class="col-6">
										  <br><br>
										<button type="button" name="lc_btn_activate_final_certificate" id="lc_btn_activate_final_certificate" class="btn  btn-warning w-100 btn-icon-split "  >
											<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview Certificate</span>
										</button>
								
								</div>
								
								  
								<div class="col-6">
										  <br><br>
						<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
							<input type="hidden" id="job_number" name="job_number" value="${job_number}" >
							<input type="hidden" id="request_type" name="request_type" value="lc_btn_activate_final_register_">
							 <div class="form-group">
					   
						
						  
							   <input type="button" id="lc_btn_activate_final_register" class="btn btn-success btn-block w-100" value="Generate Register" /> 
					   
					  </div>
								</div> -->
								
								
								 
								
							  </div>
							


			</div>
		</div>
	</div>
	<br>
	</div>

	<!-- Example Bar Chart Card-->




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
  
  
