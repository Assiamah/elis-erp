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


  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 

 //int application_stage = (Integer) request.getAttribute("application_stage");
	  
%>

  
  


    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">Application Processing</a>
        </li>
        <li class="breadcrumb-item active">Entire Processing</li>
         
             
      </ol>
     
           
      
      
      
      
        
      
       <div class="row">
     
     
     
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-stamp"></i>${case_number} - ${ar_name} </h4>
				<form action="${pageContext.request.contextPath}/client_application" >
				<!-- <input type="submit" class="btn btn-primary btn-block" value="Back to File Movement" /> -->
				<button type="submit"  class="btn btn-primary btn-icon-split float-right" >
				<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				</form>
		</div>
            <div class="card-body">

 
      	    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsemaincase" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Summary of the case
		            </a>
		        </h5>
		        <div id="collapsemaincase" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		<!--   <button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="Load Docs">
					            <i class="fa fa-plus-circle"></i>
					        </button> -->
					        
					      <!--   <div class="form-row"> -->
	
				          
				         
				      
				      
				      
				      
				              <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				            Parcel Attributes
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
						         
				    
				    				        	          <div class="form-group">
				            
				            <input type="hidden" id="cs_main_business_process_id"  value="${business_process_id}">
				           <input type="hidden" id="cs_main_business_process_name"  value="${business_process_name}">
				           <input type="hidden" id="cs_main_business_process_sub_id"  value="${business_process_sub_id}">
				           <input type="hidden" id="cs_main_business_process_sub_name"  value="${business_process_sub_name}">
				            <input type="hidden" id="cs_main_client_number"  value="${phone_number}">
				           
				           
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Case Number</label>
								   <input  readonly class="form-control" id="cs_main_case_number"  name="cs_main_case_number"  type="text" aria-describedby="nameHelp" placeholder="Enter Case Number" value="${case_number}" >
        													
				                </div>
				                 <div class="col-md-4">
				                <label for="search_value">Regional Number</label>
				                <input  readonly class="form-control"    type="text" aria-describedby="nameHelp" placeholder="Enter Case Number" value="${regional_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Locality</label>
				                <input  readonly class="form-control"  id="cs_main_locality" type="text" aria-describedby="nameHelp" placeholder="Enter Case Number" value="${locality}" >
				              </div>
				             
				            </div>
				            
				            
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">District</label>
				                <input  readonly class="form-control" type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${district}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Region</label>
				                <input  readonly class="form-control"  type="text" aria-describedby="nameHelp" placeholder="Enter Nature of Instrument" value="${region}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Size of Land - Acre(s)</label>
				                <input  readonly class="form-control" id="cs_main_size_of_land" type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${size_of_land}" >
				              </div>
				             
				            </div>
				            
				            
				                <div class="form-row">
				          
				                
				                <div class="col-md-4">
				               
        						
        						   <label for="bl_job_purpose">GLPIN</label>
							        <input readonly class="form-control" id="txt_glpin"  name="txt_glpin"  type="text" aria-describedby="nameHelp"  value="${glpin}" >					
				                </div>
				                
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">New Transaction Ready</label>
								   <input readonly class="form-control" id="cs_main_need_for_new_transaction"  name="cs_main_need_for_new_transaction"  type="text" aria-describedby="nameHelp" placeholder="Enter Case Number" value="${need_for_new_transaction}" >
        													
				                </div>
				                
				               
				             
				            </div>
				            
				            
				            
				            
				            
				         
				            
				            
				              
				            
				          </div>
				          
				    
				    
				    
				    
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
				      
				      
				      
				      
				      
				      		      
				              <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				            Transaction Details
				            </div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				             
						         
				    
				    				        	          <div class="form-group">
				         
				     
				            
				            
				                <div class="form-row">
				          
				                
				                  <div class="col-md-4">
				                <label for="search_value">Transaction Number</label>
								   <input readonly class="form-control" id="cs_main_ar_name"  name="cs_main_ar_name"  type="text" aria-describedby="nameHelp"  value="${transaction_number}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Applicant Name</label>
								   <input readonly class="form-control" id="cs_main_ar_name"  name="cs_main_ar_name"  type="text" aria-describedby="nameHelp"  value="${ar_name}" >
        													
				                </div>
				                
				                
				                
				                
				              
				                
				                <div class="col-md-4">
				                <label for="search_value">Nature of Instrument</label>
				                <input  readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${nature_of_instrument}" >
				              </div>
				             
				            </div>
				            
				            
				            
				              <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Date of Document</label>
				                <input  readonly class="form-control" type="text" aria-describedby="nameHelp"  value="${date_of_document}" >
				              </div>
				              
				                  <div class="col-md-4">
				                <label for="search_value">Date of Registration</label>
								  <input readonly class="form-control"  type="text" aria-describedby="nameHelp" value="${date_of_registration}"  required>
        													
				                </div>
				              
				               
				                <div class="col-md-4">
				                <label for="search_value">Type of Interest</label>
				                <input  readonly class="form-control"   type="text" aria-describedby="nameHelp"  value="${type_of_interest}" >
				              </div>
				             
				            </div>
				            
				            
				             <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Type of Use</label>
				                <input readonly  class="form-control"  type="text" aria-describedby="nameHelp"  value="${type_of_use}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Term</label>
				                <input readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${term}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Commencement Date</label>
				                <input readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${commencement_date}" >
				              </div>
				             
				            </div>
				            
				            
				               <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Assessed Value</label>
				                <input readonly  class="form-control"  type="text" aria-describedby="nameHelp"  value="${assessed_value}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Stamp Duty Payable</label>
				                <input readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${stamp_duty_payable}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Certificate Number</label>
				                <input readonly class="form-control"  type="text" aria-describedby="nameHelp"  value="${certificate_number}" >
				              </div>
				             
				            </div>
				            
				          </div>
				          
				    
				    
				    
				    
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
				      
				      
				     <!--    </div>
				      
				       -->
				      
				      
				          
					        
		                
		            </div>
		        </div>
		    </div>
      
				  
				     


 <br>   






          
					          
					   

      
            
          
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
		               
		               <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#addNewserviceBillModalonCase" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit" data-backdrop="static" data-keyboard="false">
                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Add New Service</span>
                    	</button>
                    	
                    	 
		               <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#afterPaymentModalonCase" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit" data-backdrop="static" data-keyboard="false">
                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Acknowledge</span>
                    	</button>
                    	
                    	
                    	
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm " data-group-by="true" data-group-by-field="job_number" id="lrd_scanned_documents_dataTable" >
				              <thead  class="table-success">
				                <tr >
				                 <th>Transaction Number</th>
				                 <th>Applicant Name</th>
				                <!--  <th>Current Status</th> -->
				                
				                  </tr>
				              </thead>
				              
				                <tbody>
								     <c:forEach items="${case_details}" var="case_row">
								                <tr>
								                    <td>${case_row.transaction_number}</td>
								                    <td>${case_row.ar_name}</td>
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
		                
		                 
					         <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addeditparty" data-toggle="tooltip" title="Add New Party">
					            <i class="fa fa-plus-circle"></i>
					        </button>
		                
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable" >
				           
				              <thead>
				                <tr>
				
				                <th>Name</th>
				                <th>Gender</th>
				                <th>Contact</th>
				                <th>Role</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							        <c:forEach items="${parties}" var="parties_row">
						                <tr>
						                    <td>${parties_row.ar_name}</td>
						                    <td>${parties_row.ar_gender}</td>
						                    <td>${parties_row.ar_cell_phone}</td>
						                    <td>${parties_row.type_of_party}</td>
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
		                
		                 <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addMinutesModal" data-toggle="tooltip" title="Add Minutes" data-backdrop="static" data-keyboard="false">
		            		<i class="fa fa-plus-circle"></i>
		       			 </button>
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm" id="lrd_scanned_documents_dataTable" >
				           
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
								                    <td>${application_munites_row.ar_name}</td>
								                    <td>${application_munites_row.am_to_officer}</td>
								                    <td>${application_munites_row.am_activity_date}</td>
								                    <td><p data-placement="top" data-toggle="tooltip" title="Batch">
								                    	<button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${application_munites_row.am_id}">
								                    	<span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Batch</span>
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
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsedocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Documents On Application
		            </a>
		        </h5>
		        <div id="collapsedocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		  <button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="Load Docs">
					            <i class="fa fa-eye"></i>
					        </button>
					        
					         <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#fileUploadModal" data-toggle="tooltip" title="Upload New Documents" data-backdrop="static" data-keyboard="false">
					            <i class="fa fa-plus-circle"></i>
					        </button>
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable" width="100%" cellspacing="0">
				           
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
											<form action="open_pdffile" method="post">
												<input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
													<button type="submit" name="save" class="btn btn-info btn-icon-split" >
													<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Opn</span>
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
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseobjections" aria-expanded="false" aria-controls="collapseobjections">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Objections
		            </a>
		        </h5>
		        <div id="collapseobjections" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <button type="button" class="btn btn-primary" id="lrd_btn_add_objections" data-placement="top" data-toggle="modal" data-target="#newObjectionModal" data-toggle="tooltip" title="Add Objection" data-backdrop="static" data-keyboard="false">
					            <i class="fa fa-plus-circle"></i>
					    </button>
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm">
								      		<thead>
								      			<tr>
								      				<th>Objector </th>
								      				<th>Address</th>
								      				<th>Contact</th>
								      				<th>reasons </th>
								      				<th>remarks </th>
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
										      					<button type="button" id="editOjectionModal"  data-toggle="modal" data-target="#newObjectionModal"  data-action="edit"  class="btn btn-danger btn-icon-split "  title="edit objection" data-backdrop="static" data-keyboard="false">
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
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Queries
		            </a>
		        </h5>
		        <div id="collapsequeries" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <button type="button" class="btn btn-primary" id="lrd_btn_add_querys" data-placement="top" data-toggle="modal" data-target="#newQueryModal" data-toggle="tooltip" title="Add Query" data-backdrop="static" data-keyboard="false">
					            <i class="fa fa-plus-circle"></i>
					        </button>
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable">
				           
				              <thead>
								      			<tr>
								      				<th>job_number </th>
								      				<th>reasons</th>
								      				<th>remarks</th>
								      				<th>created_date </th>
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
										      					<button type="button" id="editOjectionModal"  data-toggle="modal" data-target="#newObjectionModal"  data-action="edit"  class="btn btn-danger btn-icon-split "  title="edit objection" data-backdrop="static" data-keyboard="false">
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

		    
		</div>

      </div>
      
     </div>
      
      
   
      
    </div>
  

 
 
 
 
 
 	   <!--  Service Bill============================= -->
	<div class="modal fade" id="addNewserviceBillModalonCase" tabindex="-1" role="dialog" aria-labelledby="newValuationModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="addNewserviceBillModal">New Service Bill</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="from_add_valuation">
	        
	        	<input id="action_on_form_valuation" type="hidden" >
	        	
	        	
	        	  <div class="form-group">
          <label for="main_service">Main Service</label>
                  <select name="main_service_on_case" id="main_service_on_case" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                 <!--  <option value="-1">Select Main Service</option> -->
                  
                  <%--  <c:forEach items="${main_services}" var="main_service">
                   --%>
                  
                  <%--  <c:if test="${(${main_service.business_process_id} == 'No')}" --%>
                          <%-- <option value="${main_service.business_process_id}-${main_service.business_process_name}">${main_service.business_process_name}</option>  --%>
                    <%-- <p>Welcome, <c:out value="${nm }"/></p> --%>
                  <%--  </c:if> --%>
                  
                    
                 <%--  </c:forEach> --%>
                </select>
          </div>
           <div class="form-group">
          <label for="sub_service">Sub Service</label>
                  <select name="sub_service_on_case" id="sub_service_on_case" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  
                </select>
         	 </div>
	         
	         
	         
	               <div id="oncasereg-no-div" style="display: none">

       <div class="form-group">
            
            
            
 			 <div class="form-group">
       <!--      <div class="form-row">
              <div class="col-md-3">
                <label for="new_bill_application_ls_number">Surveyor's Number</label>
                <input class="form-control" id="new_bill_application_ls_number" name="ls_number" type="number" aria-describedby="nameHelp" placeholder="Enter Surveyor's Number" required>
              </div>
              <div class="col-md-1">
                <label for="new_bill_application_ls_number">-</label>
                <input type="button" id="lc_btn_check_status_of_lincense_surveyor" class="btn btn-primary btn-block" value="C" />
              </div>
              <div class="col-md-8">
                <label for="qty">Surveyor's Name</label>
                <input class="form-control" id="new_bill_application_surveyors_name" name="new_bill_application_surveyors_name"  type="text" aria-describedby="nameHelp" placeholder="Surveyor's Name" required>
              </div>
            </div> -->
            
            
              <div class="form-row">
              <div class="col-md-3">
                <label for="new_bill_application_ls_number">Surveyor's Number</label>
                <input class="form-control" id="new_bill_application_ls_number_oncase" name="ls_number" type="text" aria-describedby="nameHelp" value="${licensed_surveyor_number}" readonly>
              </div>
              
              <div class="col-md-8">
                <label for="qty">Surveyor's Name</label>
                <input class="form-control" id="new_bill_application_surveyors_name_oncase" name="new_bill_application_surveyors_name_oncase"  type="text" aria-describedby="nameHelp" value=""   readonly>
              </div>
            </div>
            
          </div>
          
          
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="new_bill_application_ls_number">Surveyor's Status</label>
                <input class="form-control" id="new_bill_application_surveyors_status_oncase" name="new_bill_application_surveyors_status_oncase" type="text" aria-describedby="nameHelp" placeholder="" readonly>
              </div>
              <div class="col-md-1">
                <label for="new_bill_application_ls_number">-</label>
               <!--  <input type="button" id="lc_btn_check_status_of_lincense_surveyor" class="btn btn-primary btn-block" value="C" /> -->
                <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" id="lc_btn_check_status_of_lincense_surveyor_oncase" data-placement="top"  data-toggle="tooltip" title="Search for Surveyor">
		            <i class="fa fa-search"></i>
		        </button>
              </div>
            </div>
          </div>
          
            
           
          </div>
          
      </div>
	         
	         
	           
         	 
        <div class="row">
		     <div class="col-lg-8">
		          <!-- Example Bar Chart Card-->
		          <div class="card mb-3">
		            <div class="card-header">
		              <i class="fa fa-bar-chart"></i>${main_service_desc}  Check List</div>
		            <div class="card-body">
		            
		         
		            
		             <!--  Here is where the fee list comes -->
		             
     	    	 
		             
		             <div class="table-responsive">
		           <table class="table table-bordered" id="on_case_checlist_table_billdataTable" width="100%" cellspacing="0">
		              <thead>
		                <tr>
		                 <th>Description</th>
		                  <th>Option</th>
		                
		                 </tr>
		              </thead>
		              <tfoot>
		                <tr>
		                  <th>Description</th>
		                  <th>Option</th>
		                </tr>
		              </tfoot>
		             <tbody>
		               
		               
					     
		              </tbody> 
		            </table>
		          </div>
             
              <!--  End Of Table -->
            </div>
            <div class="card-footer small text-muted"></div>
          </div>
          
      
      </div>
     </div>
          
          
          <div class="form-group">
		            <div class="form-row">
		              
		            
		            
		            <div class="col-md-6">

					  <label for="client_name">Client Name</label>
		                <input readonly class="form-control" id="on_application_client_name"  name="on_application_client_name"  type="text" aria-describedby="nameHelp" placeholder="Enter Client Name" value="${ar_name}" readonly>
		            
			 </div>
		            
		            <div class="col-md-6">

					<label for="client_name">Case Number</label> <input
						class="form-control" id="new_bill_case_number"
						name="new_bill_case_number" type="text"
						aria-describedby="nameHelp"
						readonly value="${case_number}">
			 </div>
		            </div>
         	 </div>
         	 
         	  
      <div id="oncasereglandsize-no-div" style="display: none">

       <div class="form-group">
            
            
            
 			 
          
          
          <div class="form-group">
            <div class="form-row">
             
              <div class="col-md-6">

					<label for="client_name">Land Size (Acre(s))</label> <input
						class="form-control" id="new_bill_land_size"
						name="new_bill_land_size" type="text"
						aria-describedby="nameHelp" placeholder="Enter land Size"
						required>
			 </div>
            </div>
          </div>
          
            
           
          </div>
          
      </div>



					
		<div id="oncasestp-no-div" style="display: none">
						<div class="form-group">
						<div class="form-row">
							<div class="col-md-4">

								<label for="client_name">Number of Copies</label> <input
									class="form-control" id="new_number_of_copies"
									name="new_number_of_copies" type="number"
									aria-describedby="nameHelp" placeholder="Enter No of Copies"
									required>
							</div>
							
								
							<div class="col-md-4">
								<label for="new_bill_type_of_use">Type of Use</label> <select
									name="type_of_use" id="new_bill_type_of_use"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true">
									<option value="-1">Select Type of Use</option>

								</select>

							</div>
							
							<div class="col-md-4">
								<label for="new_type_of_revenue_item">Nature of Instrument</label> <select
									name="new_type_of_revenue_item" id="new_type_of_revenue_item"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true">
									<option value="-1">Select Natue of Interest</option>
 <% 
                  try {
                	  
                	  Ws_client_application user_web_service = new Ws_client_application();
              		
              		String jsonArrayContent =null;
              		jsonArrayContent =user_web_service.select_revenue_items_for_lvd_stamping_list();			
              		//response.setContentType("application/json");
              		//response.getWriter().print(jsonArrayContent);
              		JSONObject sub_service_obj = new JSONObject(jsonArrayContent);
				String all_list = sub_service_obj.get("data").toString();
              		JSONArray jArr;
            		
            			jArr = new JSONArray(all_list);
            			for (int i=0; i < jArr.length(); i++) {
                          JSONObject jsonObject = jArr.getJSONObject(i);
                          
                          String revenue_items_name = (String) jsonObject.getString("revenue_items_name");
                          String revenue_items_amount = (String) jsonObject.getString("revenue_items_amount");
                          String is_inspection_required = (String) jsonObject.getString("revenue_items_amount");
                          
                          String rv_item_id = (String) jsonObject.getString("id");
                          
                          
                        //  System.out.println("<option value=" + revenue_items_name + "-" + revenue_items_amount + ">"+ revenue_items_name+ "</option>");
                          
                          %>
                     <%--  <option value="<%=business_process_id%>"><%=business_process_name%></option>--%>
                     
                     
                      
                    <%--  is_inspection_required
               
                   <c:if test="${is_inspection_required == '1'}"> 
                          <option value="${revenue_items_name}-${revenue_items_amount}">${revenue_items_name}</option> 
                    <p>Welcome, <c:out value="${nm }"/></p>
                    </c:if>  

                      --%>
                 
 
   						 <option value="<%=rv_item_id + "_" + revenue_items_name%>"><%=revenue_items_name%></option> 
   						 
   						  <%--  <option value="${revenue_items_name}-${revenue_items_amount}">${revenue_items_name}</option>  --%>
 
                          <% 
                          
                          
            			}
                  }
                  catch (Exception e){
                	  e.printStackTrace();
                  }
                  
                  %>
								</select>

							</div>
						</div>
					</div>
			</div>		
					
				
				
					<div id="oncasefreg-no-div" style="display: none">
					
				
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="registration_forms">Forms</label> <select
									name="new_bill_registration_forms"
									id="new_bill_registration_forms" class="form-control input-sm"
									data-style="btn-info" data-live-search="true">
									<option value="-1">Select Registration Forms</option>

								</select>

							</div>
							
						</div>
					</div>
		</div>
		
		
		<div id="oncasefpublication-no-div" style="display: none">
					
				
					<div class="form-group">
						<div class="form-row">
							
							<div class="col-md-6">

								<label for="publication_type">Publication Type</label> <select
									name="new_bill_publication_type" id="new_bill_publication_type"
									data-live-search="true"
									data-none-results-text="I found no results"
									title="Please select fruit" class="form-control selectpicker">
									<option value="normal_publication">Normal Publication</option>
									<option value="special_publication">Special
										Publication</option>
								</select>

							</div>
						</div>
					</div>
		</div>
         	
	         
	           <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" id="btn_save_to_generate_on_application" class="btn btn-primary">Generate Bill</button>
		      </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	

	 <!-- After Payment Summary============================= -->
	<div class="modal fade" id="afterPaymentModalonCase" tabindex="-1" role="dialog" aria-labelledby="afterPaymentModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="afterPaymentModalLabel">After Payment Summary</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
					
					  	<input type="hidden" id="txt_on_case_ap_main_service_id" name="txt_on_case_ap_main_service_id" >
          <input type="hidden" id="txt_on_case_ap_main_service_sub_id" name="main_service_sub_id" >
           <input type="hidden" id="txt_on_case_ap_jn_id" name="txt_on_case_ap_jn_id" value="jn_id">
            <input type="hidden" id="txt_on_case_ap_userid" name="txt_on_case_ap_userid" value="${userid}">
            <input type="hidden" id="txt_on_case_ap_user_fullname" name="user_fullname" value="${fullname}">
            
            
             <div class="form-group">
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="job_number">Ref Number</label>
				                <input class="form-control" id="txt_on_case_ap_job_number"  name="txt_on_case_ap_job_number"  type="text" aria-describedby="nameHelp" placeholder="Enter Ref Number" required >
				              </div>
				              <div class="col-md-4">
				              <label for="search_btn">-</label>
				                <input type="button" id="btn_process_after_payment_on_case" class="btn btn-primary btn-block" value="Load Details" />  
				                
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="job_number">Case Number</label>
				                <input class="form-control" id="txt_on_case_ap_case_number"  name="txt_on_case_ap_case_number"  type="text" aria-describedby="nameHelp" value="${case_number}" readonly >
				              </div>
				            </div>
					  </div>
					  
					  
           
		<div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="main_service_desc">Main Service</label>
                <input class="form-control" id="txt_on_case_ap_main_service_desc"  name="txt_on_case_ap_main_service_desc"  type="text" aria-describedby="nameHelp"  readonly>
              </div>
              <div class="col-md-6">
                <label for="main_service_sub_desc">Sub Service</label>
                <input class="form-control" id="txt_on_case_ap_main_service_sub_desc" name="txt_on_case_ap_main_service_sub_desc" type="text" aria-describedby="nameHelp"  readonly>
              </div>
            </div>
          </div>
          
          
           <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="client_name">Client Name</label>
                <input class="form-control" id="txt_on_case_ap_client_name"  name="txt_on_case_ap_client_name"  type="text" aria-describedby="nameHelp"  readonly>
              </div>
              
                <div class="col-md-6">
				                <label for="job_number">Transaction Number</label>
				                <input class="form-control" id="txt_on_case_ap_transaction_number"  name="txt_on_case_ap_transaction_number"  type="text" aria-describedby="nameHelp" value="${transaction_number}" readonly >
				              </div>
           
          </div>
          
          
          
            
					
					
					    <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>${main_service_desc}  Check List</div>
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered" id="tbl_on_case_ap_checklist_dataTable" width="100%" cellspacing="0">
              <thead>
                <tr>
                 <th>Description</th>
                  <th>Option</th>
                
                 </tr>
              </thead>
              <!-- <tfoot>
                <tr>
                  <th>uid</th>
                  <th>User Name</th>
                </tr>
              </tfoot> -->
             <tbody>
               
  
			     
              </tbody> 
            </table>
          </div>
             
              <!--  End Of Table -->
            </div>
            <div class="card-footer small text-muted"></div>
          </div>
          
      
      </div>
     </div>
     
     
     
          
          
          
             <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Bill And Payments</div>
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered" id="tbl_on_case_ap_bills_payments_dataTable" width="100%" cellspacing="0">
              <thead>
                <tr>
                 <th>Bill Number</th>
                  <th>Bill Description</th>
                   <th>Bill Amount</th>
                  <th>Amount Paid</th>
                   
                    <th>Payment Mode</th>
                    <th>Division</th>
                 
                
                 </tr>
              </thead>
              
             <tbody>
               
               
              </tbody> 
            </table>
          </div>
             
              <!--  End Of Table -->
            </div>
            <div class="card-footer small text-muted"></div>
          </div>
          
      
      </div>
     </div>
          
          
          
               <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i></div>
            <div class="card-body">
            
        
        
        		        <div class="form-group">
			        <label for="bl_ar_name">Name</label>
			        <textarea readonly rows="2" class="form-control" placeholder="" id="txt_on_case_ap_ar_name"></textarea>
			        </div>
			        
			       
			       
			       
			       <div id="oncaseparty-no-div" style="display: none">
					
					
				            <div class="form-row">
				              <div class="col-md-6">
				                	  <label for="bl_job_number">Gender</label>
							        <select name="txt_on_case_ap_ar_gender" id="txt_on_case_ap_bl_cbo_ar_gender" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
										<option value="Male">Male</option>
										<option value="Female">Female</option>
									</select>				
				                </div>
				               
				              				               
				                 <div class="col-md-6">
				                <label for="bl_job_number">Phone #</label>
			     				<input class="form-control " type="text" placeholder="Enter Phone Number" id="txt_on_case_ap_ar_cell_phone">
			       
				               </div>
				               
				             
				            </div>
				            
				            
				            
				            <div class="form-row">
				              <div class="col-md-4">
				              			 <label for="bl_job_number">ID Type</label>
			       				 <select name="cbo_on_case_ap_ar_id_type" id="cbo_on_case_ap_ar_id_type" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
									<option value="National ID">National ID</option>
									<option value="Drivers License">Drivers License</option>
									<option value="NHIS">NHIS</option>
									<option value="Passport">Passport</option>
									
								</select>				
				                </div>
				                <div class="col-md-4">
				                <label for="bl_job_number">ID Number</label>
			       				 <input class="form-control " type="text" placeholder="" id="txt_on_case_ap_ar_id_number">
			      
								</div>
								
								 <div class="col-md-4">
								  <label for="bl_job_number">Type of Party</label>
							        <select name="cbo_on_case_ap_type_of_party" id="cbo_on_case_ap_type_of_party" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
										<option value="Applicant">Applicant</option>		
										<option value="Motgagor">Motgagor</option>
										
										<option value="Grantor">Grantor</option>
										<option value="Objector">Objector</option>
										<option value="Depositor">Depositor</option>
									</select>
				                 </div>
				                 
				             
				            </div>
				            
        			 <div class="form-group">
					<div class="form-row">
					
            
						
					</div>
				</div>
            
				
					
					</div>
			       
       
        
            					
            
             
              
                 <div id="oncasepaap-no-div" style="display: none">
		        
				<div class="form-group">
					<div class="form-row">
						
						<div class="col-md-6">
				                <label for="main_service_sub_desc">Land Size (Acre(s))</label>
				                <input class="form-control" id="txt_on_case_ap_land_size" name="txt_on_case_ap_land_size" type="text" aria-describedby="nameHelp"  readonly>
				              </div> 
              <div class="col-md-6" style="display: none">
				
				<label for="qty">Surveyor's Name</label>
                <input class="form-control" id="new_ap_application_surveyors_name_oncase" name="new_ap_application_surveyors_name_oncase"  type="text" aria-describedby="nameHelp" value=""   readonly>
          					
            </div>
						
					</div>
				</div>
				
		</div>
              
            
               <div id="oncaseregap-no-div" style="display: none">
		        
		             

				<div class="form-group">
					<div class="form-row">
						
						<div class="col-md-6">

							<label for="application_type">Application Type</label> <select
								name="txt_not_on_case_ap_application_type"
								id="txt_not_on_case_ap_application_type" data-live-search="true"
								data-none-results-text="I found no results"
								title="Please select fruit" class="form-control selectpicker">
								<option value="Individual">Individual</option>
								<option value="Joint">Joint</option>
								<option value="Company">Company</option>

							</select>

						</div>
						
					</div>
				</div>
				
		</div>


				<div id="oncasestpap-no-div" style="display: none">
							<div class="form-group">
								<div class="form-row">
			
																		
									<!-- <div class="col-md-6">
										<label for="type_of_interest">Type of Instrument</label> <select
											name="txt_on_case_ap_type_of_instrument"
											id="txt_on_case_ap_type_of_instrument"
											class="form-control input-sm" data-style="btn-info"
											data-live-search="true">
											<option value="-1">Select Type of Instrument</option>
			
										</select>
			
									</div> -->
			
						   <div class="col-md-6" style="display: none;">
				
									<label for="qty">Nature of Instrument</label>
					                <input class="form-control" id="txt_on_case_ap_type_of_instrument" name="txt_on_case_ap_type_of_instrument"  type="text" aria-describedby="nameHelp" value=""   readonly>
					          					
            				</div>
            				
            				   <div class="col-md-6" style="display: none;">
				
									<label for="qty">Type of Use</label>
					                <input class="form-control" id="txt_on_case_ap_type_of_use" name="txt_on_case_ap_type_of_use"  type="text" aria-describedby="nameHelp" value=""   readonly>
					          					
            				</div>
            				
            
            
			
								</div>
							</div>
			</div>

            
           				<!-- 	 <div class="form-row">
				              <div class="col-md-4">
				                LIst of Parties						
				                </div>
				            
				            
				             
				            </div> -->
				            
             <!--  Here is where the fee list comes -->
          <!--    
             <div class="table-responsive">
           <table class="table table-bordered" id="client_details_datatable" width="100%" cellspacing="0">
              <thead>
                <tr>
                 <th>ar_client_id</th>
                 <th>ar_name</th>
                 <th>ar_gender</th>
                 <th>ar_cell_phone</th>
                <th>type_of_party</th>
              
                 
                 </tr>
              </thead>
              
             <tbody>
              
			     
              </tbody> 
            </table>
          </div> -->
             
              <!--  End Of Table -->
            </div>
          <div class="card-footer small text-muted"></div>
          </div>
          
      
      </div>
     </div>
          
					  
	      </div>
	       <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" id="btn_on_case_ap_generate_acknowledgement" class="btn btn-primary">Generate Acknowledgement Slip</button>
		      </div>
	      
	    </div>
	  </div>
	</div>
</div>	

 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
