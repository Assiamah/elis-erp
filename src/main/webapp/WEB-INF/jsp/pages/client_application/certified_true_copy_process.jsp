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
     
        <!-- SmartWizard html -->
			        <div id="smartwizardfirstregistration">
            <ul class="d-none">
               
                <li><a href="#link-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li>
                 <li><a href="#link-1">Vetting/Approval<br /><small>Vetting/Approval</small></a></li> 
          		 <li><a href="#link-2">Final Approval<br /><small>Final Approval</small></a></li>
				<li><a href="#link-3">Batch To Cabinet<br /><small>Batch To Cabinet</small></a></li>
          		 <li><a href="#link-4">Collection<br /><small>Collection Process</small></a></li>
            </ul>

            <div>
            
             
                    
                  
      
                  <div id="link-1" class="">
                    <h3 class="border-bottom border-gray pb-2">Upload Scan Documents</h3>
                    
                    
		     	
				      <button type="button" class="btn btn-primary" id="lrd_btn_add_docs" data-toggle="modal" data-target="#fileUploadModal" title="Upload Documents">
		            <i class="fa fa-plus-circle"></i>
		        </button>
		         <button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
		        
		        <!--     <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Documents On Application
		            </a>
		        </h5>
		        <div id="collapseThree" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                -->
		               
			         		
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_scanned_documents_dataTable" width="100%" cellspacing="0">
				           
				              <thead>
				                <tr>
				
				                 <th>Document Name</th>
				                 <th>Document Type</th>
				                 <th>Document Path</th>
				                 <th>Open File</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							    <c:forEach items="${casescanneddocuments}" var="casescanneddocuments_row">
				                <tr>
				                    <td>${casescanneddocuments_row.document_name}</td>
				                    <td>${casescanneddocuments_row.document_type}</td>
				                    <td>${casescanneddocuments_row.document_extention}</td>
				                 
					                    <td>
											<form action="registration_application_progress_details" method="post">
												<input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
													<button type="submit" name="save" class="btn btn-info btn-icon-split" >
													<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Work</span>
													</button>
											</form>
										</td>
	
				                    </tr>
			           			 </c:forEach>
				  		</tbody>
				    
				            
				            </table>
				          </div>
		  <!--           </div>
		        </div>
		    </div> -->
                     
               	
                    </div>
                
                <div id="link-1" class="">
                	<br>
                    <h3 class="border-bottom border-gray pb-2">Stamp Duty Assessment</h3>
                   	<div class="row">

 						 <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-10">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Stamp Duty</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              <form action="${pageContext.request.contextPath}/download_pdf"  method="post">
				
						          
									  <div class="form-group row"> 
									    <label for="stamp_duty" class="col-sm-3 col-form-label" style="text-align:right">Stamp Duty Payable <span class="text-danger">*</span>:</label>
									    <div class="col-sm-5">
									    
									    <div class="input-group mb-2">
									        <div class="input-group-prepend">
									          <div class="input-group-text">GHS</div>
									        </div>
									        <input type="number" id="stamp_duty" name="stamp_duty" class=" form-control" required placeholder="Stamp Duty Payable">
									      </div>
									      
									     
									    </div>
									  </div>
									  <div class="form-group row">
									    <label for="assessed_value" class="col-sm-3 col-form-label" style="text-align:right">Assessed Value <span class="text-danger">*</span>:</label>
									    <div class="col-sm-5">
									    	 <div class="input-group mb-2">
										        <div class="input-group-prepend">
										          <div class="input-group-text">GHS</div>
										        </div>
									       		<input type="number" name="assessed_value" id="assessed_value" class=" form-control" required placeholder="Assessed Value"> 
										      </div>
									    
									    
									    </div>
									  </div>
									  <div class="form-group row">
									    <label for="assessed_comment" class="col-sm-3 col-form-label " style="text-align:right">Comments <span class="text-danger">*</span>:</label>
									    <div class="col-sm-5">
									       <textarea type="number" name="assessed_comment" id="assessed_comment" class=" form-control"  required> </textarea>
									    </div>
									  </div>
									  <div class="form-group row">
									  <label for="assessed_value" class="col-sm-5 col-form-label"> </label>
									    <div class="col-sm-4 form-row float-right">
									    	<div class="col-sm-6">
									    		<button type="submit" name="submit_assessment" id="submit_assessment" class="btn  btn-primary btn-icon-split"  >
									    			<span class="icon text-white-50"> <i class="fas fa-check col-sm-12"></i></span><span class="text">Save</span>
									    		</button>
									    	</div>
									    	<div class="col-sm-6">
									    		
						                   			<a  href="${pageContext.request.contextPath}/landed_inspection_application"  class="btn btn-info btn-icon-split" >
						                   				<span class="icon text-white-50"> <i class="fas fa-print col-sm-12"></i></span><span class="text">Print</span>
						                   			</a>
									    	</div>
									        
									    </div>
									  </div>
											  
										
						          
						        </form>
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>

 </div>
                </div>
                
                
                
                
                <div id="link-2" class="">
                	<br>
                    <h3 class="border-bottom border-gray pb-2">Embossment after Payment</h3>
						          
						 <div class="row">
						 
						       <!--   Here is the right Table -->
						        <div class="col-lg-8">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Embossment after Payment</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank" class="form-inline">
										<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
										<input type="hidden" id="job_number" name="job_number" value="${job_number}" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_inspection_letter">
								          
								              
								              
								              	<input type="text"  class="form-control form-control-plaintext" id="staticEmail" value="Is document embossed?">
								                <button type="submit" name="submit_assessment" id="submit_assessment" class="btn  btn-primary btn-icon-split form-control"  >
									    			<span class="icon text-white-50"> <i class="fas fa-check col-sm-12"></i></span><span class="text">Comfirmed</span>
									    		</button>
									    		
								             
								            
								        </form>
						            
						            <!-- The form Ends Hers -->
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						        <!--   Here is the right Table -->
						        
						      
						        <!--   Here is the right Table -->
						        
						
						 </div>
               
  </div>
                
                
                <div id="link-3" class="">
                    <h3 class="border-bottom border-gray pb-2">Batch To Cabinet</h3>
              
              
        
				         <!--   Here is the right Table -->
				        <div class="col-lg-8">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Batch To Cabinet</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				
						          <div class="form-group">
				            <div class="form-row">
				              <div class="col-md-6">
				                <label for="job_number">Cabinet Number</label>
				                <input class="form-control" id="file_number"  name="file_number"  type="text" aria-describedby="nameHelp" placeholder="Generated File Number" required >
				              </div>
				              <div class="col-md-6">
				              <label for="search_btn">-</label>
				                <input type="submit" class="btn btn-primary btn-block" value="Generate" />  
				                
				                </div>
				            </div>
				          </div>
				        </form>
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
                
              
                 </div>
                <div id="link-4" class="">
                    <h3 class="border-bottom border-gray pb-2">Collection of Application</h3>
              
              
               
				         <!--   Here is the right Table -->
				        <div class="col-lg-8">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Batch To Cabinet</div>
				            <div class="card-body">
				            
				             	  <div  class="table w-auto small">
						           <table class="table table-bordered" id="lrd_scanned_documents_dataTable" width="100%" cellspacing="0">
						           
						              <thead>
						                <tr>
						
						                 <th>Description</th>
						                 <th>Option</th>
						             
						                  </tr>
						              </thead>
						              
						                <tbody>
													     <c:forEach items="${collection_checklist}" var="collection_checklist_row">
							                <tr>
							                    <td>${collection_checklist_row.collection_of_application_checklist_name}</td>
							                    <td>${collection_checklist_row.collection_of_application_checklist_option}</td>
							                   
							                    
							                    	
							                    
							                     
							                    
							                    </tr>
							            </c:forEach>
						  				</tbody>
						    
						            
						            </table>
						          </div>
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
				      
				       
				         <!--   Here is the right Table -->
				        <div class="col-lg-8">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Batch To Cabinet</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				
						          <div class="form-group">
				            <div class="form-row">
				              <div class="col-md-6">
				                <label for="job_number">Cabinet Number</label>
				                <input class="form-control" id="file_number"  name="file_number"  type="text" aria-describedby="nameHelp" placeholder="Generated File Number" required >
				              </div>
				              <div class="col-md-6">
				              <label for="search_btn">-</label>
				                <input type="submit" class="btn btn-primary btn-block" value="Generate" />  
				                
				                </div>
				            </div>
				          </div>
				        </form>
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
                </div>
               
                
            </div>
        </div>
							
          
          
          
          
             <jsp:include page="../client_application/_application_process_footer.jsp"></jsp:include>
     