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


      
        <jsp:include page="../client_application/_application_process_header.jsp"></jsp:include>

        <div id="smartwizardfirstregistration">
            <ul class="d-none">
               
              <li><a href="#link-1">Vetting/Approval<br /><small>Vetting of Application</small></a></li>
             <li><a href="#link-2">Certificate Preparation<br /><small>Certificate Preparation</small></a></li>
             
            </ul>

            <div>
            
             
                  <div id="link-1" class="">
                    <h3 class="border-bottom border-gray pb-2">Approval/Vetting</h3>
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
							<i class="fa fa-pie-chart"></i>Verify Site (If Inspection is needed)
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
								<option value="Inspection Letter">Inspection Letter</option>
								<option value="Physical Planning Letter">Physical Planning Letter</option>
								

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
				                 <th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							      <c:forEach items="${application_notes}" var="application_notes_row">
						                <tr>
								                    <td class="text-truncate" style="max-width:100px;">${application_notes_row.an_description}</td>
								                    <td>${application_notes_row.created_by}</td>
								                    <td>${application_notes_row.created_date}</td>
								                    
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
                </div>
               
               
                <div id="link-2" class="">
                 <h3 class="border-bottom border-gray pb-2">Root of Title</h3>
                
                
                
                  <h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
                    <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
			            <i class="fa fa-plus-circle"></i>
			        </button>
                     
               	  <div  class="table w-auto small">
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
			                    <th>Action</th>
			                    <th>Approve</th>
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


				                    <td>
				                    	<p data-placement="top" data-toggle="tooltip" title="Batch">
					                    	<button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
					                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
					                    	</button>
				                    	</p>
				                    </td>
				                    
				                    	
				                    
				                     
				                    
				                    </tr>
				            	</c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
			          
			          
			          
			           <h5 class="border-bottom border-gray pb-2">Memorial Details</h5>
			              <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newMemorialsModal" data-toggle="tooltip" title="Add New Memorial">
		            <i class="fa fa-plus-circle"></i>
		        </button>
                     
               	  <div  class="table w-auto small">
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
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_valuation_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>vs_date_of_valuation</th>
			                 <th>vs_amount</th>
			                 <th>vs_remarks</th>
			                 <th>Edit</th>
			                  
			                  </tr>
			              </thead>
			              
			                <tbody>
			     <c:forEach items="${lrd_valuation_section}" var="valuation_section">
                <tr>
                    <td>${valuation_section.vs_date_of_valuation}</td>
                    <td>${valuation_section.vs_amount}</td>
                    <td>${valuation_section.vs_remarks}</td>
                    
                    <td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${valuation_section.vs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p></td>
                   
                   
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
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_certificate_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>cs_date_of_registration</th>
			                 <th>cs_to_whom_issued</th>
			                 <th>cs_serial_number</th>
			                 <th>cs_official_notes</th>
			                 
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
                    <td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${certificate_section.cs_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span></button></p></td>
                  
                <%--    <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm"><input type="hidden" name="case_numer" id="case_number" value="${certificate_section.cs_id}"> <input type="hidden" name="job_number" id="job_number" value="${certificate_section.cs_id}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
                  --%>   
                    	
                    
                     
                    
                    </tr>
            </c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
                
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
							
			<!-- 	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            		
	            		
	          			<select
								name="type_of_letter_new" id="type_of_letter_new"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="Select_Letter_Template">Select Letter Template</option>
								<option value="Inspection Letter">Inspection Letter</option>
								<option value="Physical Planning Letter">Physical Planning Letter</option>
								

							</select>
	          		</div>
	          		
	          	</div> -->
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            	
	            		
	            		<button type="button"
								class="btn btn-primary"
								id="lc_btn_generate_memo_for_certificate" data-placement="top" 
							>
								<span class="icon text-white-50"> <i
									class="fa fa-plus-circle"
								></i></span><span class="text">Generate Memo</span>
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
                
                
					 </div>
                
               
         			     
               
                
            </div>
        </div>
							
          
            
          
       
        <jsp:include page="../client_application/_application_process_footer.jsp"></jsp:include>
     
