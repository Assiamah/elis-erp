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
              <i class="fas fa-bar-chart"></i><h3>Application for Mortgage - ${case_number} </h3>    
              <form action="${pageContext.request.contextPath}/case_movement_module" >
	 			<input type="submit" class="btn btn-primary btn-block" value="Back to File Movement" />  
	          </form>
        	</div>
            <div class="card-body">
	            <div class="row">

 
      
      
				      
				       <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-10">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i> Summary of the case</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              <form action="${pageContext.request.contextPath}/download_pdf"  method="post">
				
						          <div class="form-group">
				            
				            
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">case_number</label>
								   <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Case Number" value="${case_number}" >
        													
				                </div>
				                 <div class="col-md-4">
				                <label for="search_value">Regional Number</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Case Number" value="${regional_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Locality</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Case Number" value="${locality}" >
				              </div>
				             
				            </div>
				            
				            
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">district</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${district}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Region</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Nature of Instrument" value="${region}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Size of Land</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${size_of_land}" >
				              </div>
				             
				            </div>
				            
				              <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">date_of_document</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${date_of_document}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">nature_of_instrument</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Nature of Instrument" value="${nature_of_instrument}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">type_of_interest</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${type_of_interest}" >
				              </div>
				             
				            </div>
				            
				            
				             <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">type_of_use</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${type_of_use}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">term</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Nature of Instrument" value="${term}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">commencement_date</label>
				                <input class="form-control" id="search_value"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${commencement_date}" >
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


		

        <!-- SmartWizard html -->
        <div id="smartwizard">
            <ul>
               
                 <!-- <li><a href="#step-1">Inspection<br /><small>Inspection</small></a></li> -->
                  <li><a href="#step-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li>
          		 <li><a href="#step-2">Vetting/Approval<br /><small>Vetting of Application</small></a></li>
          		 <li><a href="#step-3">Certificate Preparation<br /><small>Certificate Preparation</small></a></li>
          		 <li><a href="#step-4">Batch To Cabinet<br /><small>Batch To Cabinet</small></a></li>
          		 <li><a href="#step-5">Collection<br /><small>Collection Process</small></a></li>
            </ul>

            <div>
                
               
               
               
                 <div id="step-1" class="">
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
               
                <div id="step-2" class="">
                	<br>
                    <h3 class="border-bottom border-gray pb-2">Mortgage Vetting/Approval</h3>
						          
					   
	                
	                Application Details
	                   <ul class="list-group col-md-8">
	                       <li class="list-group-item "><b>Name of Applicant:</b> Yaw Adonteng</li>
	                       <li class="list-group-item "><b>Case Number:</b> PVLMD00000000</li>
	                       <li class="list-group-item"><b>Job Number</b> PVLMD7777777</li>
	                       <li class="list-group-item"><b>Address:</b> P. O. Box 3</li>
	                       <li class="list-group-item "><b>Type of Transaction:</b> Assignment</li>
	                       <li class="list-group-item"><b>Presentation Fees:</b> GHC300.00</li>
	                       <li class="list-group-item"><b>Consent Fees:</b> GHC300.00</li>  
	                   </ul><hr class=" col-md-8">
	                   Mortgagee Details
	                   <ul class="list-group col-md-8">
	                       <li class="list-group-item "><b>Name of Mortgagee:</b> Yaw Adonteng</li>
	                       <li class="list-group-item"><b>Name of Grantor:</b> Nii Odai Ntow</li>
	                       <li class="list-group-item"><b>Address:</b> P. O. Box 3</li>
	                       <li class="list-group-item "><b>Name of Grantee:</b> Kwame Osei</li>
	                       <li class="list-group-item"><b>Address:</b> P. O. Box 3</li>    
	                   </ul><hr class=" col-md-8">
	                   Mortgagor Details
	                   <ul class="list-group col-md-8">
	                       <li class="list-group-item "><b>Name of Mortgagor:</b> Kwame Osei</li>
	                       <li class="list-group-item"><b>Mobile Contact:</b> 0244444777</li>
	                       <li class="list-group-item"><b>Address:</b> P. O. Box 3</li>
	                       <li class="list-group-item"><b>E-mail:</b> grantee@gmail.com</li>    
	                   </ul><hr class=" col-md-8">
	                   Property Details
	                   <ul class="list-group col-md-8">
	                       <li class="list-group-item "><b>Section:</b>4</li>
	                       <li class="list-group-item "><b>Block:</b> 12</li>
	                       <li class="list-group-item "><b>Parcel No.:</b>25A</li>
	                       <li class="list-group-item"><b>Location:</b>Airport Residential Area</li>
	                       <li class="list-group-item"><b>Plot Size:</b> 0.4</li>  
	                   </ul><hr class=" col-md-8">
	                <button type="button" class="btn btn-primary">Generate Mortgage Certificate</button>
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> 
               
				</div>
                
                <div id="step-3">
                	<h2 class="StepTitle">Complete Application</h2> 
	                Display Final Certificate
	                <img src="http://web-buttons.com/posts/data/upload/2017/04/responsive_images.jpg" width="100%" class="img-fluid" >
	                <button type="button" class="btn btn-primary">Approve Application</button>
	                <button type="button" class="btn btn-danger">Query</button>
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> 
                </div>
               
                <div id="step-4" class="">
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
                <div id="step-5" class="">
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
							
          
            
          
            </div>
            <div class="card-footer small text-muted">Registration Process Movement</div>
          </div>
          
         
        
    
   
        
      </div>
      
      
      
      
       <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i> Jobs Related to Case</div>
            <div class="card-body">
          
          
               	  <div  class="table w-auto small">
           <table class="table table-bordered" id="lrd_scanned_documents_dataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>

                 <th>job_number</th>
                 <th>business_process_sub_name</th>
                 <th>current_application_status</th>
                
                  </tr>
              </thead>
              
                <tbody>
				     <c:forEach items="${job_details}" var="job_row">
				                <tr>
				                    <td>${job_row.job_number}</td>
				                    <td>${job_row.business_process_sub_name}</td>
				                    <td>${job_row.current_application_status}</td>
				                   
				                    	
				                    
				                     
				                    
				                    </tr>
				            </c:forEach>
  				</tbody>
    
            
            </table>
          </div>
            
          </div>
              
        </div>
      <!--   Here is the end of right table -->
      
      
  
  
   <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i> Munites On Application</div>
            <div class="card-body">
          
          
               	  <div  class="table w-auto small">
           <table class="table table-bordered" id="lrd_scanned_documents_dataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>

                 <th>am_description</th>
                 <th>am_from_officer</th>
                 <th>am_to_officer</th>
                 <th>am_activity_date</th>
                 <th>am_activity_date</th>
                  </tr>
              </thead>
              
                <tbody>
				     <c:forEach items="${application_munites}" var="application_munites_row">
				                <tr>
				                    <td>${application_munites_row.am_description}</td>
				                    <td>${application_munites_row.ar_name}</td>
				                    <td>${application_munites_row.am_to_officer}</td>
				                    <td>${application_munites_row.am_activity_date}</td>
				                    <td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${application_munites_row.am_id}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Batch</span></button></p></td>
				                    
				                    	
				                    
				                     
				                    
				                    </tr>
				            </c:forEach>
  				</tbody>
    
            
            </table>
          </div>
            
          </div>
              
        </div>
      <!--   Here is the end of right table -->
      
      
        <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i>Documents On Application</div>
            <div class="card-body">
          
          
               	  <div  class="table w-auto small">
           <table class="table table-bordered" id="lrd_scanned_documents_dataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>

                 <th>Document Name</th>
                 <th>Document Type</th>
                 <th>Document Path</th>
                 <th>Open File</th>
                  </tr>
              </thead>
              
                <tbody>
			     <c:forEach items="${applicationlist}" var="appfiles">
			                <tr>
			                    <td>${appfiles.job_number}</td>
			                    <td>${appfiles.ar_name}</td>
			                    <td>${appfiles.current_application_status}</td>
			                    <td>${appfiles.case_number}</td>
			                    <td><p data-placement="top" data-toggle="tooltip" title="Batch"><button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#edit" data-target-id="${appfiles.job_number}"><span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Batch</span></button></p></td>
			                   <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm"><input type="hidden" name="case_numer" id="case_number" value="${appfiles.case_number}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
			                    
			                    	
			                    
			                     
			                    
			                    </tr>
			            </c:forEach>
  				</tbody>
    
            
            </table>
          </div>
            
          </div>
              
        </div>
      <!--   Here is the end of right table -->
  
  
  
     
       <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i> Comments Or Tracking Information</div>
            <div class="card-body">
         
         
               	  <div  class="table w-auto small">
           <table class="table table-bordered" id="lrd_scanned_documents_dataTable" width="100%" cellspacing="0">
           
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
      <!--   Here is the end of right table -->
      
       <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i>Bill and  Payments</div>
            <div class="card-body">
           
               	  <div  class="table w-auto small">
           <table class="table table-bordered" id="lrd_scanned_documents_dataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>

                 <th>bill_number</th>
                 <th>bill_amount</th>
                 <th>payment_slip_number</th>
                 <th>payment_date</th>
                  </tr>
              </thead>
              
				    <tbody>
				     <c:forEach items="${payment_bill}" var="payment_bill_row">
				                <tr>
				                    <td>${payment_bill_row.bill_number}</td>
				                    <td>${payment_bill_row.bill_amount}</td>
				                    <td>${payment_bill_row.payment_slip_number}</td>
				                    <td>${payment_bill_row.payment_date}</td>
				                    
				                    	
				                    
				                     
				                    
				                    </tr>
				            </c:forEach>
  				</tbody>
    
            
            </table>
          </div>
          
          
          </div>
              
        </div>
      <!--   Here is the end of right table -->
      
       <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i> Parties</div>
            <div class="card-body">
           
               	  <div  class="table w-auto small">
           <table class="table table-bordered" id="lrd_scanned_documents_dataTable" width="100%" cellspacing="0">
           
              <thead>
                <tr>

                 <th>ar_name</th>
                 <th>ar_gender</th>
                 <th>ar_cell_phone</th>
                 <th>type_of_party</th>
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
      <!--   Here is the end of right table -->
  
  
  
  
      </div>
      
      
     </div>
      
      
   
      
    </div>
  

 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
