 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

 
  
				
				<br>
      			<button class="btn btn-warning btn-icon-split float-left to_hide_on_level_2 ${compliance_query_status == 'yes' ? 'd-none' : ''}"  data-job_number="${job_number}" id="btnCompleteJob">
					<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Complete My Work</span>
				</button>
				<br>
				<div class="to_hide_on_level_2">
					${compliance_query_status == 'yes' ? '<h6 class="text-danger">Respond to query to complete work.</h6>' : ''}
				</div>
      
           </div>
           
            <div class="card-footer small text-muted to_hide_on_level_1 ${compliance_query_status == 'yes' ? 'd-none' : ''}" >

				 <button class="btn btn-success btn-icon-split float-right "  id="btnViewBatchlist">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Batch List</span>
				</button>
				<button class="btn btn-secondary btn-icon-split float-right btnAddToBatchlist"  data-job_number="${job_number}" data-ar_name="${ar_name}"
				data-business_process_sub_name="${business_process_sub_name}" data-toggle="modal" data-target="#askForPurposeOfBatching">
					<span class="icon text-white-50"> <i class="fas fa-list"></i></span><span class="text">Add to Batch List</span>
				</button>
			</div> 
          </div>
          

      </div>
      
    <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          
          
          
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingOne">
		            <a data-toggle="collapse" data-parent="#accordion" href="#collapsejobs" aria-expanded="true" aria-controls="collapseOne" class="d-block">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-info-circle"></i>Jobs Related to Case
		            </a>
		        </h5>
		
		        <div id="collapsejobs" class="collapse show" role="tabpanel" aria-labelledby="headingOne">
		            <div class="card-body">
		               
		              <%--  <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#addNewserviceBillModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Add New Service</span>
                    	</button>
                    	
                    	 
		               <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#afterPaymentModalonCase" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Acknowledge</span>
                    	</button> --%>
                    	
                    	<button class="btn btn-success mb-2" id="btnloadjobsrelatedtocase"><i class="fas fa-eye"></i>Load</button>
                    	
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm " id="jobsrelatedtocase_dataTable" >
				              <thead  class="table-success">
				                <tr >
				                 <th>Job Number</th>
				                 <th>Application Type</th>
				                <!--  <th>Current Status</th> -->
				                
				                  </tr>
				              </thead>
				              
				                <tbody>
								     <c:forEach items="${job_details}" var="job_row">
								                <tr>
								                    <td>${job_row.job_number}</td>
								                    <td>${job_row.business_process_sub_name}</td>
								                   <%--  <td>${job_row.current_application_status}</td> --%>
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
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseparties" aria-expanded="false" aria-controls="collapseFive">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-users"></i>Parties
		            </a>
		        </h5>
		        <div id="collapseparties" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                 
					         <!-- <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addeditparty" data-toggle="tooltip" title="Draw a Line">
					            <i class="fa fa-plus-circle"></i>
					        </button> -->

							<button class="btn btn-success mb-2" id="btnloadparties"><i class="fas fa-eye"></i>Load</button>
		                
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="parties_dataTable" >
				           
				              <thead>
				                <tr>
				
				                <th>Name</th>
				                <th>Sex</th>
				                <th>Contact</th>
				                <th>Role</th>
								<th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							        <c:forEach items="${parties}" var="parties_row">
						                <tr>
						                    <td>${parties_row.ar_name}</td>
						                    <td>${parties_row.ar_gender}</td>
						                    <td>${parties_row.ar_cell_phone}</td>
						                    <td>${parties_row.type_of_party}</td>
						                    <td class="to_hide_on_level_1">
						                    
						                    <p data-placement="top"  title="Edit Party">  
			          							<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
			          								 data-target="#addeditpartyGeneral"
			          								 data-target-id="${parties_row.ar_client_id}"  
			          								 data-ar_name="${parties_row.ar_name}"
			          								 data-ar_gender="${parties_row.ar_gender}"
			          								 data-ar_address="${parties_row.ar_address}"
			          								 data-ar_cell_phone="${parties_row.ar_cell_phone}"
			          								 data-ar_cell_phone2="${parties_row.ar_cell_phone2}"
			          								 data-ar_tin_no="${parties_row.ar_tin_no}"
			          								 data-ar_id_type="${parties_row.ar_id_type}"
			          								 data-ar_id_number="${parties_row.ar_id_number}"
			          								 data-ar_location="${parties_row.ar_location}"
			          								 data-ar_district="${parties_row.ar_district}"
			          								 data-type_of_party="${parties_row.type_of_party}"
			          								 data-ar_region="${parties_row.ar_region}"
			          								 data-ar_person_type="${parties_row.ar_person_type}"
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
		        <h5 class="card-header" role="tab" id="headingTwo">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseminutes" aria-expanded="false" aria-controls="collapseTwo">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-clipboard"></i>Minutes On Application
		            </a>
		        </h5>
		        <div id="collapseminutes" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
		            <div class="card-body">
		                
		                 <button type="button" class="btn btn-primary mb-2" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" 
		                 data-target="#addMinutesModal" data-am_edit="0" data-toggle="tooltip" >
		            		<i class="fa fa-plus-circle"></i>
		       			 </button>
							<button class="btn btn-success mb-2" id="btnloadminutesonapplication"><i class="fas fa-eye"></i></button>
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm data-table" id="minutesonapplication_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Description</th>
				                 <th>From</th>
				                 <th>To</th>
				                 <th>Date</th>
				                 <th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
								     <c:forEach items="${application_munites}" var="application_munites_row">
								                <tr>
								                    <td>${application_munites_row.am_description}</td>
								                    <td>${application_munites_row.am_from_officer}</td>
								                    <td>${application_munites_row.am_to_officer}</td>
								                    <td>${application_munites_row.am_activity_date}</td>
								                    <td><p data-placement="top" data-toggle="tooltip" title="View">
								                    	<button class="btn btn-info btn-icon-split"  data-toggle="modal" data-target="#addMinutesModal" 
								                    	data-target-id="${application_munites_row.am_id}" 
								                    	data-am_description="${application_munites_row.am_description}" 
								                    	data-am_from_officer="${application_munites_row.am_from_officer}" 
								                    	data-am_to_officer="${application_munites_row.am_to_officer}" 
								                    	data-am_activity_date="${application_munites_row.am_activity_date}"
														data-am_edit="1"
								                    	
								                    	
								                    	>
								                    	<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
								                    	</button></p></td>
								                 </tr>
								            </c:forEach>
				  				</tbody>
				    
				            
				            </table>
				          </div>
		            </div>
		        </div>
		    </div>
		    <br>
			
			<div class="card ${user_level == '2' && division == 'CORPORATE' ? '' : 'd-none'}">
		        <h5 class="card-header" role="tab" id="headingTwo">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsms" aria-expanded="false" aria-controls="collapseTwo">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-envelope"></i>Send Message (SMS)
		            </a>
		        </h5>
		        <div id="collapsms" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
		            <div class="card-body">
		                
		                 <button type="button" class="btn btn-primary mb-2" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addSMSModal" data-toggle="tooltip" title="Draw a Line">
		            		<i class="fa fa-plus-circle"></i>
		       			 </button>
							<button class="btn btn-success mb-2" id="btnloadsmsonapp"><i class="fas fa-eye"></i></button>
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="smsonapp_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Description</th>
				                 <th>From</th>
				                 <th>Sender</th>
				                 <!-- <th>Applicant</th> -->
				                 <!-- <th>Action</th> -->
				                  </tr>
				              </thead>
				              
				                <tbody>
								     <c:forEach items="${outgoing_sms}" var="outgoing_sms">
								                <tr>
								                    <td>${outgoing_sms.sms_message}</td>
								                    <td>${outgoing_sms.sms_created_by}</td>
								                    <!-- <td>${outgoing_sms.sms_client_name}</td> -->
								                    <td>${outgoing_sms.sms_created_date}</td>
								                    <!-- <td><p data-placement="top" data-toggle="tooltip" title="Batch">
								                    	<button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${outgoing_sms.sms_id}">
								                    	<span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">View</span>
								                    	</button></p></td> -->
								                 </tr>
								            </c:forEach>
				  				</tbody>
				    
				            
				            </table>
				          </div>
		            </div>
		        </div>
		    </div>
		    ${user_level == '2' && division == 'CORPORATE' ? '<br>' : ''}
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsedocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Documents On Application
		            </a>
		        </h5>
		        <div id="collapsedocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		  <button type="button" class="btn btn-success" id="btn_load_scanned_documents" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
					        
					         <button type="button" class="btn btn-primary" id="btn_add_document" data-toggle="modal" data-target="#fileUploadModal" title="Add Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button>
					        
					      
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable" width="100%" class="display" cellspacing="0">
				           
				              <thead>
				                <tr>
				
				                 <th>Document Name</th>
				                 <th>Document Type</th>
				               </tr>
				              </thead>
				              
				                <tbody>				
							    <c:forEach items="${casescanneddocuments}" var="casescanneddocuments_row">
				                <tr>
				                    <td>${casescanneddocuments_row.document_name}</td>
				                    <td>${casescanneddocuments_row.document_type}</td>
					                    <td>
											<form action="registration_application_progress_details" method="post">
												<input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
													<button type="submit" name="save" class="btn btn-info btn-icon-split" >
													<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Open</span>
													</button>
											</form>
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
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsepudocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-import"></i>Public Documents
		            </a>
		        </h5>
		        <div id="collapsepudocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		  <button type="button" class="btn btn-success" id="btn_load_scanned_documents_public" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
					        
					        <button type="button" class="btn btn-primary" id="btn_add_public_document" data-toggle="modal" data-target="#publicFileUploadModal" title="Add Public Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button> 
					        
					        
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm data-table" id="lc_public_documents_dataTable" width="100%" class="display" cellspacing="0">
				           
				              <thead>
				                <tr>
				
				                 <th>Document Name</th>
				                 <th>Document Type</th>
				               </tr>
				              </thead>
				              
				                <tbody>				
							    <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
				                <tr>
				                    <td>${casescanneddocuments_row.document_name}</td>
				                    <td>${casescanneddocuments_row.document_type}</td>
					                    <td>
											<form action="registration_application_progress_details" method="post">
												<input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
													<button type="submit" name="save" class="btn btn-info btn-icon-split" >
													<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Open</span>
													</button>
											</form>
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
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsenotes" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-comment-dots"></i>Notes Or Reports
		            </a>
		        </h5>
		        <div id="collapsenotes" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		            	<button type="button" class="btn btn-primary mb-2" id="lc_btn_add_note_on_application_all" data-placement="top"  data-toggle="tooltip" >
		            		<i class="fa fa-plus-circle"></i>
		       			 </button>
							<button class="btn btn-success mb-2" id="btnloadnotesorreports"><i class="fas fa-eye"></i></button>
		                 <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Note Or Reports Information</div>
				            <div class="card-body">
				         
		                
		                 
		                
		                
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="notesorreports_dataTable" >
				           
				              <thead>
				                <tr>
								<!-- <th></th> -->
				                 <th>Note</th>
				                 <th>Note By</th>
				                 <th>Note Date</th>
				                 <th>Division</th>
				                 <th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							      <c:forEach items="${application_notes}" var="application_notes_row">
						                <tr ${application_notes_row.an_status =="false" ? "class='bg-danger'  data-toggle='tooltip' title='Note has been disabled'":""}>
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
								                    	data-note_edit="1"
								                    	${application_notes_row.an_status =="false" ? "disabled ":""}
								                    	
								                    	>
								                    	<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">View</span>
								                    	</button></p></td>
								                 </tr>
								          <%-- <tr ${application_notes_row.an_status ==false ? "class='bg-danger'  data-toggle='tooltip' title='Note has been disabled'":""}>
								                    <td class="text-truncate" style="max-width:100px;">${application_notes_row.an_description}</td>
								                    <td>${application_notes_row.created_by} ${application_notes_row.an_status}</td>
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
								                    	
								                    	${application_notes_row.an_status ==false ? "disabled ":""}
								                    	
								                    	>
								                    	<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">View</span>
								                    	</button></p></td>
								                 </tr> --%>
						            </c:forEach> 
			  					</tbody>
				  			</table>
				          </div>
		            </div>
		        </div>
		    </div>
		  </div>
		    <br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsecomments" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-list-alt"></i>History Or Tracking Information
		            </a>
		        </h5>
		        <div id="collapsecomments" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                 <div class="card-header">
				              <i class="fa fa-pie-chart"></i> Comments Or Tracking Information</div>
				            <div class="card-body">
				         
		                
		                 
								<button class="btn btn-success mb-2" id="btnloadcommentsinfo"><i class="fas fa-eye"></i>Load</button>
		                
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="commentsinfo_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Comment</th>
				                 <th>Comment By</th>
				                 <th>Comment Date</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							     <c:forEach items="${comments_on_application}" var="comments_on_application_row">
						                <tr>
						                    <td>${comments_on_application_row.officers_general_comments}</td>
						                    <td>${comments_on_application_row.created_by}</td>
						                    <td>${comments_on_application_row.created_date}</td>
						                 </tr>
						            </c:forEach>
			  					</tbody>
				  			</table>
				          </div>
		            </div>
		        </div>
		    </div>
		  </div>
		    <br>
		    
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsebills" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Bill and Payments
		            </a>
		        </h5>
		        <div id="collapsebills" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
						<button class="btn btn-success mb-2" id="btnloadbillnpayments"><i class="fas fa-eye"></i>Load</button>
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="billnpayments_dataTable">
				           
				              <thead>
				                <tr>
				                	 <th>Action</th>
					                 <th>Payment Mode</th>
					                 <th>Amount</th>
					                 <th>Receipt Number</th>
					                 <th>Payment Date</th>
					                 <th>Payment Amount</th>
				                 </tr>
				              </thead>
				              
				                <tbody>
							     <c:forEach items="${payment_invoice}" var="payment_bill_row">
					                <tr>
					                	<td><button 
							      					
							      					data-toggle="modal" 
							      					data-target="#viewBillModal"  
							    					
							    					data-egcr_id= "${payment_bill_row.payment_slip_number}"
							    					data-ref_number= "${payment_bill_row.ref_number}"
							      					class="btn btn-success viewBillModalBtn"  
							      					title="View Bill Details" >
								    			View
								    		</button> 
					                    </td>
					                    <td>${payment_bill_row.payment_mode}</td>
					                    <td>${payment_bill_row.bill_amount}</td>
					                    <td>${payment_bill_row.payment_slip_number}</td>
					                    <td>${payment_bill_row.payment_date}</td>
					                    <td>${payment_bill_row.payment_amount}</td>
					                    
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
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseencumbrance" aria-expanded="false" aria-controls="collapseencumbrance">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-unlock-alt"></i>Encumbrances
		            </a>
		        </h5>
		        <div id="collapseencumbrance" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		              
		                <button type="button" class="btn btn-primary mb-2" id="lrd_btn_add_encumbrance" data-placement="top" data-toggle="modal" data-target="#newEncumberancesModal" data-toggle="tooltip" title="Add Encumbrance">
					            <i class="fa fa-plus-circle"></i>
					        </button>
							<button class="btn btn-success mb-2" id="btnloadencumbrances"><i class="fas fa-eye"></i></button>
					        
					     <!--    <a href="#myModal" class="btn btn-lg btn-primary" data-toggle="modal">Launch Demo Modal</a> -->
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="encumbrances_dataTable">
				           
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
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseobjections" aria-expanded="false" aria-controls="collapseobjections">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-ban"></i>Objections
		            </a>
		        </h5>
		        <div id="collapseobjections" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <button type="button" class="btn btn-primary mb-2" id="lrd_btn_add_objections" data-placement="top" data-toggle="modal" data-target="#newObjectionModal" data-toggle="tooltip" title="Add Objection">
					            <i class="fa fa-plus-circle"></i>
					    </button>
						<button class="btn btn-success mb-2" id="btnloadobjections"><i class="fas fa-eye"></i></button>
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="objections_dataTable">
								      		<thead>
								      			<tr>
								      				<th>Objector </th>
								      				<th>Address</th>
								      				<th>Contact</th>
								      				<th>Reasons </th>
								      				<th>Remarks </th>
								      				<th>Action</th>
								      			</tr>
								      		</thead>
								      		
								      		<tbody>
											     <c:forEach items="${case_objection}" var="case_objection_row">
									                <tr>
									                    <td>${case_objection_row.objector_name}</td>
									                    <td>${case_objection_row.objector_address}</td>
									                    <td>${case_objection_row.objector_contact}</td>
									                    <td>${case_objection_row.reasons}</td>
									                    <td>${case_objection_row.remarks}</td>
									                    
									                    <td>
										      					<button type="button" 
										      					
										      					id="editOjectionModal"  
										      					data-toggle="modal" 
										      					data-target="#newObjectionModal"  
										      					data-action="edit"  
    								    						data-target-id= ${case_objection_row.id} 
      								    	 					data-objector_name= ${case_objection_row.objector_name}  
      								    	  					data-objector_address=${case_objection_row.objector_address} 
      								    	  					data-objector_contact=${case_objection_row.objector_contact} 
      								    	  					data-reasons= ${case_objection_row.reasons} 
      								    	 					data-remarks=${case_objection_row.remarks} 
      								    	 					data-status=${case_objection_row.status} 
      								    	 					

										      					class="btn btn-danger btn-icon-split "  
										      					title="edit objection" >
													    			<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
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
		    <br>
		    
		    
		      <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsequeries" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-question-circle"></i>Queries
		            </a>
		        </h5>
		        <div id="collapsequeries" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <button type="button" class="btn btn-primary mb-2" id="lrd_btn_add_querys" data-action="new"
		               data-placement="top" data-toggle="modal" data-target="#newQueryModal" data-toggle="tooltip" title="Add Query">
					            <i class="fa fa-plus-circle"></i>
					        </button>
							<button class="btn btn-success mb-2" id="btnloadqueries"><i class="fas fa-eye"></i></button>
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="queries_dataTable">
				           
				              <thead>
								      			<tr>
								      				<th>Job Number </th>
								      				<th>Reasons</th>
								      				<th>Remarks</th>
								      				<th>Created_date </th>
								      				<th>Action </th>
								      			
								      			</tr>
								      		</thead>
								      		
								      		<tbody>
											     <c:forEach items="${case_query}" var="case_query_row">
									                <tr>
									                    <td>${case_query_row.job_number}</td>
									                    <td>${case_query_row.reasons}</td>
									                    <td>${case_query_row.remarks}</td>
									                    <td>${case_query_row.created_date}</td>
									                    
									                    
									                    <td>
										      					<button type="button" id="editQueryModal"  data-toggle="modal" 
										      					data-target="#newQueryModal"  data-action="edit"  
										      					class="btn btn-icon-split  ${case_query_row.status == 1 ? 'btn-danger' : 'btn-info'}"  title="Edit Query" 
										      					
										      					data-id="${case_query_row.qid}" 
										                    	data-job_number="${case_query_row.am_description}" 
										                    	data-reasons="${case_query_row.reasons}" 
										                    	data-remarks="${case_query_row.remarks}" 
										                    	data-status="${case_query_row.status}" 
										                    	data-query_response="${case_query_row.query_response}" 
										                    	data-created_by="${case_query_row.created_by}" 
										                    	data-created_date="${case_query_row.created_date}" 
										                    	data-modified_by="${case_query_row.modified_by}" 
										                    	data-modified_date="${case_query_row.modified_date}" 
										                    	data-general_reason="${case_query_row.query_general_reason}"
																data-attachment_required="${case_query_row.attachment_required}"
								                    	
										      					
										      					>
													    			<span class="icon text-white-50"> 
													    			
													    			
													    			${case_query_row.status == 1 ? '<i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>' : '<i class="fas fa-eye"></i></span><span class="text">View</span>'}
													    			
													    			
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
		    <br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseletters" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-envelope-open-text"></i>Letters on Case
		            </a>
		        </h5>
		        <div id="collapseletters" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
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
						            ></i></span><span class="text">Add New</span>
						         </button>
								 <button class="btn btn-success mb-2" id="btnloadlettersoncase"><i class="fas fa-eye"></i>Load</button>
						      </div>
						   </div>
						</div>
								              
		              
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lettersoncase_dataTable">
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
		    <br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collainspections" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-search-location"></i>Inspection Reports
		            </a>
		        </h5>
		        <div id="collainspections" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <button type="button" class="btn btn-primary" id="lrd_btn_add_inspection" data-placement="top" data-toggle="modal" data-target="#newInspection" data-toggle="tooltip" title="Add ind">
					            <i class="fa fa-plus-circle"></i>
					        </button>
							<button class="btn btn-success mb-2"><i class="fas fa-eye" id="btnloadinspectionsreports"></i></button>
					        <button type="button" class="btn btn-primary btn-icon-split float-right " id="lrd_btn_add_querys" data-placement="top" data-toggle="modal" data-target="#assignInspectionModal">
								<span class="icon text-white-50"> <i class="fa fa-plus-circle"></i></span><span class="text">Assign For Inspection</span>
							</button>
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="inspectionsreports_dataTable">
								<thead>
									<tr>
										<th>Date</th>
										<th>Officer (Requested)</th>
										<th>Officer (Inspection)</th>
										<th>Purpose</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${case_inspections}" var="case_inspections_row">
									                <tr>
									                    <td>${case_inspections_row.inspection_date}</td>
									                    <td>${case_inspections_row.requested_by}</td>
									                    <td>${case_inspections_row.created_by}</td>
									                    <td>${case_inspections_row.inspection_purpose}</td>
									                    
									                    <td>
										      					<button type="button" id="btn-view-inpection-report"  data-toggle="modal" data-target="#viewInspectionReportModal"  class="btn btn-primary btn-icon-split "  title="View Inspection Report" >
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
		    <br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collamotherchilddetails" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-search-location"></i>Link Details
		            </a>
		        </h5>
		        <div id="collamotherchilddetails" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <!-- <button type="button" class="btn btn-primary" id="lrd_btn_add_inspection" data-placement="top" data-toggle="modal" data-target="#newInspection" data-toggle="tooltip" title="Add ind">
					            <i class="fa fa-plus-circle"></i>
					        </button>
					        <button type="button" class="btn btn-primary btn-icon-split float-right " id="lrd_btn_add_querys" data-placement="top" data-toggle="modal" data-target="#assignInspectionModal">
								<span class="icon text-white-50"> <i class="fa fa-plus-circle"></i></span><span class="text">Assign For Inspection</span>
							</button> -->
							<button class="btn btn-success mb-2"id="btnloadlinkdetails"><i class="fas fa-eye" ></i>Load</button>
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="linkdetails_dataTable">
								<thead>
									<tr>
										
										<th>Job Number</th>
										<th>Case Number</th>
										<th>Type of Relationship</th>
										<th>Date</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${mother_to_child_link_list}" var="mother_to_child_link_row">
									                <tr>
									                    
									                    <td>${mother_to_child_link_row.job_number}</td>
									                    <td>${mother_to_child_link_row.mc_case_number}</td>
									                    <td>${mother_to_child_link_row.mc_type_of_relationship}</td>
									                    <td>${mother_to_child_link_row.created_date}</td>
									                    <td>
										      					<button type="button" id="btn-view-mother-Child-details"  data-job_number="${mother_to_child_link_row.mc_job_number}" data-case_number="${mother_to_child_link_row.mc_case_number}" data-transaction_number="[0, 0]" business_process_sub_name="-" data-toggle="modal" data-target="#transitional_certificate_template"  class="btn btn-primary btn-icon-split "  title="View Case Details" >
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
		   
			<br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collacertificatesearchrelationdetails" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-search-location"></i>Certificate and Search Details
		            </a>
		        </h5>
		        <div id="collacertificatesearchrelationdetails" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <!-- <button type="button" class="btn btn-primary" id="lrd_btn_add_inspection" data-placement="top" data-toggle="modal" data-target="#newInspection" data-toggle="tooltip" title="Add ind">
					            <i class="fa fa-plus-circle"></i>
					        </button>
					        <button type="button" class="btn btn-primary btn-icon-split float-right " id="lrd_btn_add_querys" data-placement="top" data-toggle="modal" data-target="#assignInspectionModal">
								<span class="icon text-white-50"> <i class="fa fa-plus-circle"></i></span><span class="text">Assign For Inspection</span>
							</button> -->

							<button class="btn btn-success mb-2" id="btnloadcertnsearchdetails"><i class="fas fa-eye"></i>Load</button>
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="certnsearchdetails_dataTable">
								<thead>
									<tr>
										
										<th>Job Number</th>
										<th>Case Number</th>

										<th>Date</th>
										<!-- <th>Action</th> -->
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${certificate_search_relation_list}" var="certificate_search_relation_row">
									                <tr>
									                    
									                    <td>${mother_to_child_link_row.mc_job_number}</td>
									                    <td>${mother_to_child_link_row.mc_certificate_number}</td>
									        
									                    <td>${mother_to_child_link_row.created_date}</td>
									                    <!-- <td>
										      					<button type="button" id="btn-view-mother-Child-details"  data-job_number="${mother_to_child_link_row.mc_job_number}" data-case_number="${mother_to_child_link_row.mc_case_number}" data-transaction_number="[0, 0]" business_process_sub_name="-" data-toggle="modal" data-target="#transitional_certificate_template"  class="btn btn-primary btn-icon-split "  title="View Case Details" >
													    			<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View</span>
													    		</button> 
											    		</td> -->
									                 </tr>
									             </c:forEach>
								</tbody>
							</table>
				          </div>
		            </div>
		        </div>
		    </div>
		    
		</div>

      </div>
      
     </div>
      
      
   
      
    </div>
  

 
 
 
 
 
 
 
   <!-- Objection Section============================= -->
	<div class="modal fade" id="newObjectionModal" tabindex="-1" role="dialog" aria-labelledby="newObjectionModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="newObjectionModalLabel">Objection Section</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div id="alert-display-space-objection"></div>
	        <form id="form_add_objection">
	        		
	        	<input  id="action_on_form" type="hidden" >
	        	
	        	<input  id="obj_id" name="obj_id" type="hidden" value="${userid}">
	          <div class="row">
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="obj_job_number" class="col-form-label">Job Number</label>
	            		<input type="text" name="obj_job_number" id="obj_job_number" class="form-control" required readonly value="${job_number}">
	          		</div>
	          		<div class="form-group">
	            		<label for="obj_case_number" class="col-form-label">Case Number</label>
	            		<input type="text" name="obj_case_number" id="obj_case_number" class="form-control" required readonly value="${case_number}">
	          		</div>
	          		<div class="form-group">
	            		<label for="obj_objector_name" class="col-form-label">Objector Name</label>
	            		<input type="text" name="obj_objector_name" id="obj_objector_name" class="form-control" required>
	          		</div>
	          		<div class="form-group">
	            		<label for="obj_objector_address" class="col-form-label">Objector Address</label>
	            		<input type="text" name="obj_objector_address" id="obj_objector_address" class="form-control" required>
	          		</div>
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="obj_object_contact" class="col-form-label">Objector Contact</label>
	            		<input type="text" name="obj_object_contact" id="obj_object_contact" class="form-control" required>
	          		</div>
	          		<div class="form-group">
	            		<label for="cs_to_whom_issued" class="col-form-label">Reasons</label>
	            		<textarea name="obj_reasons" id="obj_reasons" class="form-control" required></textarea>
	          		</div>
	          		<div class="form-group">
	            		<label for="obj_remarks" class="col-form-label">Remarks</label>
	            		<textarea name="obj_remarks" id="obj_remarks" class="form-control" required></textarea>
	          		</div>
	          		<div class="form-group">
	            		<label for="obj_remarks" class="col-form-label">Status</label>
	            		<select name="obj_status" id="obj_status" class="form-control" required>
	            			<option value=true>Active</option>
	            			<option value=false>Inactive</option>
	            		</select>
	          		</div>
	          	</div>
	          </div>
	           <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" id="btn_objection_section" class="btn btn-primary d-none to_show_on_level_3">Save Changes</button>
		      </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>

	
 
 
  <!-- Add Minutes============================= -->
	<div class="modal fade" id="addMinutesModal" tabindex="-1" role="dialog" aria-labelledby="addMinutesModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="addMinutesModalLabel">Add Minutes</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="form_add_minutes" >
	        
	        	<input  id="am_id" name="am_id" type="hidden" value="0"> 
	        	
	          <div class="row">
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="query_case_number" class="col-form-label">Case Number</label>
	            		<input type="text" name="am_case_number" id="am_case_number" value="${case_number}" class="form-control" required readonly>
	          		</div>
	          		<div class="form-group">
	            		<label for="query_job_number" class="col-form-label">Job Number</label>
	            		<input type="text" name="am_job_number" id="am_job_number" value="${job_number}" class="form-control" required readonly>
	          		</div>
	          		<div class="form-group">
	            		<label for="mt_reasons" class="col-form-label">Description</label>
	            		<textarea name="am_description" id="am_description" class="form-control" required></textarea>
	          		</div>
	          		
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="mt_reasons" class="col-form-label">From</label>
	            		<input type="text" name="am_from_officer" id="am_from_officer" value="${fullname}" class="form-control" required readonly>
	          		
	          		</div>
	          		<!-- <div class="form-group">
	            		<label for="mt_to" class="col-form-label">To</label>
	            		     <input class="form-control" id="am_to_officer"  name="am_to_officer"  type="text" aria-describedby="nameHelp" list="listofusers"  class="autocomplat" placeholder="Enter Username" required >
                <datalist id="listofusers">
					<c:forEach items="${userlist}" var="user">
						<option data-value="${user.userid}" value="${user.fullname}"></option>
			  </c:forEach>
               </datalist>
                
	          		</div> -->
					<div id="division_div">

						<div class="form-group">
							<label for="" class="col-form-label">Division :</label>
							  <select id="unit_division_to_send_to_2" class="form-control" >
								 <option value="none">---Select Division---</option>
								 <option value="LVD">LVD</option>
								 <option value="LRD">LRD</option>
								 <option value="PVLMD">PVLMD</option>
								 <option value="SMD">SMD</option>
								  <option value="RLO">RLO</option>
							  </select>
							  </div>
	
							  <div class="form-group">
								<label for="" class="col-form-label">Unit :</label>
							  <input autocomplete="off" class="form-control" id="unit_to_send_to_2"  type="text"  list="listofunitsbatching" class=""  placeholder="Select/Enter Unit" required  >
							  <datalist id="listofunitsbatching"></datalist>
							</div>
					</div>
					
						<div class="form-group">
							<label for="" class="col-form-label">User:</label>
							<input class="form-control" id="am_to_officer"  name="am_to_officer" type="text" autocomplete="off" 
							list="listofusersbatching" class="autocomplat"  placeholder="Enter Username" required  onmousedown="value = '';" >
						 	<datalist id="listofusersbatching">
								<c:forEach items="${userlist}" var="user">
										<option data-value="${user.userid}" value="${user.fullname}"></option>
							</c:forEach>
							</datalist>
						</div>
	          	</div>
	          </div>
	           <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" id="btn_add_minutes" class="btn btn-primary">Save Changes</button>
		      </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- Add Minutes============================= -->
	<div class="modal fade" id="addSMSModal" tabindex="-1" role="dialog" aria-labelledby="addSMSModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
		  <div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title" id="addSMSModalLabel">Send Message (SMS)</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  <form id="form_add_sms" >
			  
				  <input  id="sms_id" name="sms_id" type="hidden" value="0"> 
				  
				<div class="row">
					<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
						<div class="form-group">
						  <label for="query_case_number" class="col-form-label">Case Number</label>
						  <input type="text" name="sms_case_number" id="sms_case_number" value="${case_number}" class="form-control" required readonly>
						</div>
						<div class="form-group">
							<label for="mt_reasons" class="col-form-label">From</label>
							<input type="text" name="sms_from_officer" id="sms_from_officer" value="${fullname}" class="form-control" required readonly>
						  
						  </div>
					</div>
					<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
						

						<div class="form-group">
							<label for="query_job_number" class="col-form-label">Job Number</label>
							<input type="text" name="sms_job_number" id="sms_job_number" value="${job_number}" class="form-control" required readonly>
						  </div>
					</div>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="form-group">
						<label for="mt_reasons" class="col-form-label">Description</label>
						<textarea name="sms_description" id="sms_description" rows="6" class="form-control" required></textarea>
					  </div>
					</div>
				</div>
				 <div class="modal-footer">
				  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				  <button type="submit" id="btn_add_sms" class="btn btn-primary">send</button>
				</div>
			  </form>
			</div>
		  </div>
		</div>
	  </div>
 
 
  <!-- Add Note============================= -->
	<div class="modal fade" id="addNotesModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="addMinutesModalLabel">Add Note or Reports</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="form_add_notes" >
	        	
	        	<input  id="an_id" type="hidden" value="0">
	        	<input type="hidden" id="an_job_number" value="${job_number}" class="form-control" required >
	        	<input type="hidden" id="an_case_number" value="${case_number}" class="form-control" required >
	        	<input type="hidden" id="an_type" value="Normal" class="form-control" required >
	        	
	          <div class="row">
	          	<div class="col-sm-12">
	          		
	          		<div class="form-group">
	            		<label for="mt_reasons" class="col-form-label">Description</label>
	            		<textarea id="an_description" class="form-control" required rows=10></textarea>
	          		</div>
	          		
	          		
	          	</div>
	          	
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            		<label  class="col-form-label">Created By:</label>
	            		<input type="text"  id="an_created_by"  class="form-control" required readonly>
	          		
	          		</div>
	          		
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            		<label for="mt_reasons" class="col-form-label">Created Date:</label>
	            		<input type="text"  id="an_created_date" class="form-control" required readonly>
	          		
	          		</div>
	          		
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            		<label  class="col-form-label">Modified By:</label>
	            		<input type="text"id="an_modified_by" class="form-control" required readonly>
	          		
	          		</div>
	          		
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            		<label for="mt_reasons" class="col-form-label">Modified Date:</label>
	            		<input type="text"  id="an_modified_date"  class="form-control" required readonly>
	          		
	          		</div>
	          		
	          	</div>
	          	
	          	<%-- <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
	          		<div class="form-group">
	            		<label for="mt_reasons" class="col-form-label">From</label>
	            		<input type="text" name="am_from_officer" id="am_from_officer" value="${fullname}" class="form-control" required readonly>
	          		
	          		</div>
	          		<div class="form-group">
	            		<label for="mt_to" class="col-form-label">To</label>
	            		     <input class="form-control" id="am_to_officer"  name="am_to_officer"  type="text" aria-describedby="nameHelp" list="listofusers"  class="autocomplat" placeholder="Enter Username" required >
                
                
	          		</div>
	          	</div> --%>
	          </div>
	           <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" id="btn_add_notes" class="btn btn-primary ">Save Changes</button>
		      </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
 
 
 
 
 
   <!-- Add Note============================= -->
	<div class="modal fade" id="addUpdateLetterModal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="addUpdateLetterModalLabel">Add/Update Letter</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="form_add_letters" >
	        	<input  id="lt_id" type="hidden" value="0">
	        	
	          <div class="row">
	          	
	          	
	          	 	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            		<label  class="col-form-label">Job Number:</label>
	            		<input type="text"  id="lt_job_number"  class="form-control" value="${job_number}"  required readonly>
	          		
	          		</div>
	          		
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            		<label for="mt_reasons" class="col-form-label">Case Number:</label>
	            		<input type="text"  id="lt_case_number" class="form-control" value="${case_number}" required readonly>
	          		
	          		</div>
	          		
	          	</div>
	          	
	          	
	          	<div class="col-sm-12">
	          		
	          		<div class="form-group">
	            		<label for="mt_reasons" class="col-form-label">Description</label>
	            		<textarea id="lc_letter_template_description" class="form-control" required rows=10></textarea>
	          		</div>
	          		
	          		
	          	</div>
	          	<div class="col-sm-12">
	          		
	          		<div class="form-group">
	            		<label for="lc_letter_template_cc" class="col-form-label">Copy (Put each CC on a new line)</label>
	            		<textarea id="lc_letter_template_cc" class="form-control" required rows=3></textarea>
	          		</div>
	          		
	          		
	          	</div>
	          	
	       
	          	 	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            		<label  class="col-form-label">Letter Type:</label>
	            		<input type="text"  id="lt_letter_type"  class="form-control"   required readonly>
	          		
	          		</div>
	          		
	          	</div>
	          	
	     
	          </div>
	           <div class="modal-footer">
		        <button type="button" id="btn_compose_letters" class="btn btn-primary ">Preview Letter</button>
		        <button type="button" id="btn_save_letters" class="btn btn-primary ">Save Letter</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      
		      </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
 
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
