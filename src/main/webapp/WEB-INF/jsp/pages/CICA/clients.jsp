<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <jsp:include page="../CICA/includes/header.jsp"></jsp:include>
  

 <div class="content-wrapper">
    <div class="container-fluid">
       <div class="row">
	      <div class="col">
	        <div class="card mb-3 mt-3">
	        	<div class="card-header">
		        	<div class="row">
		        		<div class="col-md-9">
		        			<div class="h5 text-uppercase text-bold text-secondary col-sm-4">CLIENT DETAILS</div>
		        		</div>
		        			<div class="col-md-3 text-end">
			        			<!-- <button type="button" id="prevBtn" class="btn-sm" onclick="nextPrev(-1)"><i class="fas fa-arrow-circle-left me-2"></i>Previous</button> -->
								<!-- <button type="button" id="submitBtn" class="btn-sm btn-success" onclick="submitForm()"><span id="submit_text">Submit </span><i class="fas fa-arrow-circle-right ms-5"></i></button> -->
		        			</div> 
		        	</div>
	        	</div>
	          <form id="cicaClientForm" method="post" >
		          <div class="card-body">
		          
		         	 
		         	 	<!-- Tab 1 -->  
		            	<div class="row">
			            <div class="row col-md-6 mt-3">
			            <div class="row mb-3">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Name</b><span class="text-danger">*</span>:</label>
				           <div class="col-sm-8">
				             <input type="text" class="form-control required-input" name="complainant_name" id="complainant_name" required>
				           </div>
				       	</div>
				          <div class="row mb-3">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Phone</b><span class="text-danger">*</span>:</label>
				           <div class="col-sm-8">
				             <input type="number" class="form-control required-input" name="complainant_phone" id="complainant_phone" required>
				           </div>
				         </div>
				         <div class="row mb-3">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Email</b>:</label>
				           <div class="col-sm-8">
				             <input type="email" class="form-control required-input" name="complainant_email" id="complainant_email" >
				           </div>
				         </div>
						 <div class="row mb-5">
							<label for="inputText" class="col-sm-4 col-form-label"><b>Sex</b><span class="text-danger">*</span>:</label>
							<div class="col-sm-8">
							  <select class="form-control required-input" aria-label="Default select example" name="gender" id="gender" required>
								<option value="" disabled selected>-- select --</option>
								<option value="Male">Male</option>
								 <option value="Female">Female</option>
								 <option value="Joint">Joint</option>
								 <option value="Institution">Institution</option>	
							  </select>
							</div>
						  </div>
				         <div class="row mb-3">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Address</b>:</label>
				           <div class="col-sm-8">
				             <textarea  class="form-control" name="complainant_add" id="complainant_add"></textarea>
				           </div>
				         </div>
				         <div class="row mb-5">
				           <label for="inputText" class="col-sm-4 col-form-label"><b>Purpose</b><span class="text-danger">*</span>:</label>
				           <div class="col-sm-8">
				             <select class="form-control required-input" aria-label="Default select example" name="purpose" id="purpose" required>
				               	<option value="" disabled selected>-- select --</option>
				               	<option value="1">Service Enquiry</option>
								<option value="2">Other Enquiry</option>
								<option value="3">Service Complaint</option>
								<option value="4">Non Service Complaint</option>	
					         </select>
				           </div>
				         </div>
				         	<input type="hidden" name="request_type" value="clients_details"  />
							<input type="hidden" name="request_by_id" value="${sessionScope.userid}"  />
				         	<input type="hidden" name="request_by" value="${sessionScope.fullname}"  />
			          </div>
			          
			          <!-- col2 -->
			          <div class="col-md-6 mt-3">
			          
			            <div class="" id="tab-extra">
			          	 	
					        
					         
			          	</div>
			          	<div class="" id="tab_extra2">
			          	 	
					        
					         
			          	</div>
			          	
			          </div>
			          <!-- col2 -->
			          </div>
			          
			          
			          
		        	
		        	
		     	</div>
		     	<div class="card-footer">
		     		<div class="row">
		     			<div class="col-md-9">
			     		<!-- <button type="button" id="showEnquiryTab" class="btn-sm" onclick="showEnquiryTab()"><i class="fas fa-arrow-circle-right me-2"></i>Enquiry</button> -->
			     		</div>
			     		<div class="col-md-3 text-end">
							<button type="submit" id="submitBtn" class="btn-sm btn-success" ><span id="submit_text">Submit </span><i class="fas fa-arrow-circle-right ms-5"></i></button>
			        	</div> 
		        	</div>
		     	</div>
		     </form> 
	       </div>
	       
	       <div class="card mb-3 mt-3" id="enquiry_tab">
	        	<div class="card-header">
		        	<div class="row">
		        		<div class="col-md-9">
		        			<div class="h5 text-uppercase text-bold text-secondary col-sm-4">Enquiry</div>
		        		</div>
		        			<div class="col-md-3 text-end">
			        			<!-- <button type="button" id="prevBtn" class="btn-sm" onclick="nextPrev(-1)"><i class="fas fa-arrow-circle-left me-2"></i>Previous</button> -->
								<!-- <button type="button" id="submitBtn" class="btn-sm btn-success" onclick="submitForm()"><span id="submit_text">Submit </span><i class="fas fa-arrow-circle-right ms-5"></i></button> -->
		        			</div> 
		        	</div>
	        	</div>
	          <form id="cicaClientForm" method="post" >
		          <div class="card-body">
		          
		         	 
		         	 	<!-- Tab 1 -->  
		            	<div class="row">
								 <div class="col-md-9">
								 	
							            <div class="form-group">
						            	<label><b>Search By: </b></label>
								  	</div>
								    <div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="job_number" required>
									  <label class="custom-control-label" for="rbtn_search_type1">Job number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="case_number" required>
									  <label class="custom-control-label" for="rbtn_search_type2">Case Number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type3" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="regional_number" required>
									  <label class="custom-control-label" for="rbtn_search_type3">Regional Number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type4" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="glpin" required>
									  <label class="custom-control-label" for="rbtn_search_type4">GLPIN</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type6" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="ref_number" required>
									  <label class="custom-control-label" for="rbtn_search_type6">Ref Number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type5" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="ar_name" required>
									  <label class="custom-control-label" for="rbtn_search_type5">Applicant Name</label>
									</div>
									<br><br>
						          <div class="form-group">
						            <div class="form-row mb-4">
						              <div class="col-md-5">
						                
						                <input class="form-control" id="cc_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
						              </div>
						              <div class="col-md-3">
						              	
						                <button type="button" class="btn btn-warning" value="Search" id="btnCCJobSearch" ><i class="fas fa-search"></i> Search </button>
						                
						              </div>
						            </div>
						            </div>
						            
						            </div>
						            <div class="col-md-3">
						            
						
						        	</div>
						      </div>
						      
						      <div class="row">
						      		<div class="col">
						      			   <div class="card mb-3" style="display:none" id="cc-search-results-section">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Search Results</div>
            <div class="card-body">
            
         
            
	             <!--  Here is where the fee list comes -->
	             
	             <div class="table-responsive" >
			           <table class="table table-bordered " id="cc-search-results-table" style="min-height:500px">
			              <thead>
			                <tr>
			                 <th>Applicant Name</th>
			                <th>Case Number</th>
			                  <th>Job Number</th>
			                  <!-- <th>GLPIN</th> -->
			                  
			                  <th>Locality</th>
			                  <th>Regional Number</th>
			                  <!-- <th>Case Status</th> -->
			                  
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
						      		</div>
						      </div>
			          
			          
			          
		        	
		        	
		     	</div>
		     </form> 
	       </div>
	       
	       
	    </div>
   	  </div>
   	  
   	 
   </div>   
</div>



 
 <!-- <div class="modal fade" id="enquiryModal" tabindex="-1">
   <div class="modal-dialog modal-xl">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title text-uppercase">Enquiry</h5>
         <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
       </div>
       		enquiry
			          		<div id="contents_enquiry">
			          		<div class="card-body">
			          			<div class="row">
								 <div class="col-md-9">
								 	
							            <div class="form-group">
						            	<label><b>Search By: </b></label>
								  	</div>
								    <div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="job_number" required>
									  <label class="custom-control-label" for="rbtn_search_type1">Job number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="case_number" required>
									  <label class="custom-control-label" for="rbtn_search_type2">Case Number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type3" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="regional_number" required>
									  <label class="custom-control-label" for="rbtn_search_type3">Regional Number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type4" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="glpin" required>
									  <label class="custom-control-label" for="rbtn_search_type4">GLPIN</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type6" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="ref_number" required>
									  <label class="custom-control-label" for="rbtn_search_type6">Ref Number</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type5" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="ar_name" required>
									  <label class="custom-control-label" for="rbtn_search_type5">Applicant Name</label>
									</div>
									<br><br>
						          <div class="form-group">
						            <div class="form-row mb-4">
						              <div class="col-md-5">
						                
						                <input class="form-control" id="cc_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
						              </div>
						              <div class="col-md-3">
						              	
						                <button type="button" class="btn btn-warning" value="Search" id="btnCCJobSearch" ><i class="fas fa-search"></i> Search </button>
						                
						              </div>
						            </div>
						            </div>
						            
						            </div>
						            <div class="col-md-3">
						            
						
						        	</div>
						      </div>
						      
						      <div class="row">
						      		<div class="col">
						      			   <div class="card mb-3" style="display:none" id="cc-search-results-section">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Search Results</div>
            <div class="card-body">
            
         
            
	              Here is where the fee list comes
	             
	             <div class="table-responsive" >
			           <table class="table table-bordered " id="cc-search-results-table" style="min-height:500px">
			              <thead>
			                <tr>
			                 <th>Applicant Name</th>
			                  <th>Case Number</th>
			                  <th>Job Number</th>
			                  <th>GLPIN</th>
			                  
			                  <th>Locality</th>
			                  <th>Regional Number</th>
			                  <th>Case Status</th>
			                  
			                  <th>Actions</th>
			                  
			                  
			                
			                 </tr>
			              </thead>
			              
			              <tbody>
			               	
			                              
						     
			              </tbody> 
			            </table>
	          	</div>
             
               End Of Table
             </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>
						      		</div>
						      </div>
						      
						      
						      
						      
						   </div>   
						 </div>
       
     </div>
   </div>
 </div> -->
 
 <!-- Track Job Modal -->
 <div class="modal fade" id="trackingModal" tabindex="-1" role="dialog"
	aria-labelledby="addInspectionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addMinutesModalLabel">Application
					Tracking History</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container px-5">
					<h3>Details</h3>
					
					</div>
					<hr class="mt-2 mb-3">
					<div class="row  px-5">
					<br>
					
					
								<div class="col-sm-4"><b>Date Created</b><br><div id="date_created_text"></div>
								
								</div>
								<div class="col-sm-4"><b>Job Number</b><br><div id="job_number_text"></div>
								</div>
								<div class="col-sm-4"><b>Submitted By</b><br><div id="submitted_by_text"></div>
								</div>
							</div>
							<br>
					<div class="row  px-5">
							
								<div class="col-sm-4"><b>Main Service</b><br><div id="main_service_text"></div>
								</div>
								<div class="col-sm-4"><b>Sub Service</b><br><div id="sub_service_text"></div>
								</div>
								<div class="col-sm-4"><b>Status</b><br><div id="status_text"></div>
								</div>
							
								<!-- <br><br> -->
				</div>
				<hr>
				<div class="row mt-3  px-5">
							
					<div class="col-sm-4"><b>Enquiry Status</b><br><div id="app_status"></div>
					</div>
					<div class="col-sm-4"><b>Days Created</b><br><div id="days_passed"></div>
					</div>
					<!-- <div class="col-sm-4"><b>Status</b><br><div id="status_text"></div> -->
					<!-- </div> -->
				
			
				</div>
				<br><br>
				<hr class="mt-2 mb-3">
				<div class="row  px-2">
					<!--<div class="col-md-6">
						<div class="card">
							<div class="card-header">Milestones</div>
							<div class="card-body">
								<table class="table table-bordered" id="app-tracking">
									<thead>
										<tr>
											<th>SN</th>
											<th>Milestone Status</th>
											<th>Status</th>
											<th>TAT</th>
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>


						<div class="card mt-3">
							<div class="card-header">Comments</div>
							<div class="card-body">
								<table class="table table-bordered" id="cabinet-tracking">
									<thead>
										<tr>
											<th>Comments</th>
											<th>Division/Unit</th>
											<th>Batching Officer</th>
											<th>Date</th>
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>

					</div>
					 <div class="col-md-6">
						<div class="card">
							<div class="card-header">SMS Messages/ Notifications</div>
							<div class="card-body">
								<table class="table table-bordered" id="sms-tracking">
									<thead>
										<tr>
											<th>SN</th>
											<th>Message</th>
											<th>Date Sent</th>
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>

						<div class="card mt-3">
							<div class="card-header">Queried</div>
							<div class="card-body">
								<table class="table table-bordered" id="case-query">
									<thead>
										<tr>
											<th>SN</th>
											<th>Reason</th>
											<th>Response</th>
											<th>Date</th>
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>
					</div> -->



					<div class="accordion" id="accordionExample">
						<div class="card">
						  <div class="card-header" id="headingOne">
							<h2 class="mb-0">
							  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								Milestone
							  </button>
							</h2>
						  </div>
					  
						  <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
							<div class="card-body">
								<table class="table table-bordered" id="app-tracking">
									<thead>
										<tr>
											<th>SN</th>
											<th>Milestone Status</th>
											<th>Status</th>
											<th>TAT</th>
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						  </div>
						</div>
						<div class="card">
						  <div class="card-header" id="headingTwo">
							<h2 class="mb-0">
							  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
								Comments
							  </button>
							</h2>
						  </div>
						  <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
							<div class="card-body">
								<table class="table table-bordered" id="cabinet-tracking">
									<thead>
										<tr>
											<th>Comments</th>
											<th>Division/Unit</th>
											<th>Batching Officer</th>
											<th>Date</th>
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						  </div>
						</div>
						<div class="card d-none" id="case_query">
						  <div class="card-header" id="headingThree">
							<h2 class="mb-0">
							  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
								Queried
							  </button>
							</h2>
						  </div>
						  <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
							<div class="card-body">
								<div class="row">
									<div class="col-md-6">
										<table class="table table-bordered" id="case-query">
											<thead>
												<tr>
													<th>SN</th>
													<th>Reason</th>
													<th>Response</th>
													<th>Date</th>
												</tr>
											</thead>
											<tbody></tbody>
		
										</table>
									</div>
									<div class="col-md-6">
										<div class="card card-body">
											<div class="text-left">
												<button type="button" class="btn btn-success btn-sm mb-2" id="btn_load_scanned_documents_public" data-placement="top"  title="Load Docs">
													<i class="fas fa-eye"></i> Load Documents
												</button>
											</div>
											
											<input type="hidden" id="cs_main_case_number" class="form-control" />
											
											<div  class="table-responsive">
												<table class="table table-bordered  table-hover table-sm data-table" id="lc_public_documents_dataTable" width="100%" class="display" cellspacing="0">
												
													<thead>
														<tr>
										
														<th>Document Name</th>
														<th>Document Type</th>
													</tr>
													</thead>
													
													<tbody>				
													
													</tbody>
												</table>
										 	 </div>
										</div>
									</div>
								</div>
								
							</div>
						  </div>
						</div>
						<div class="card">
							<div class="card-header" id="headingFour">
							  <h2 class="mb-0">
								<button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
									SMS Messages/ Notifications
								</button>
							  </h2>
							</div>
							<div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordionExample">
							  <div class="card-body">
								<table class="table table-bordered" id="sms-tracking">
									<thead>
										<tr>
											<th>SN</th>
											<th>Message</th>
											<th>Date Sent</th>
											<!-- <th>Date</th> -->
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							  </div>
							</div>
						  </div>
					  </div>

				</div>


			</div>
		</div>
	</div>
</div>
 <!-- End Job Modal -->
 
 
 <!-- CABINET DETAILS============================= -->

<div class="modal fade" id="cabinetModal" tabindex="-1" role="dialog"
	aria-labelledby="addInspectionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addMinutesModalLabel">Application
					Tracking History</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-8">
						<div class="card">
							<div class="card-header">History</div>
							<div class="card-body">
								<table class="table table-bordered" id="cabinet-tracking">
									<thead>
										<tr>
											<th>Comments</th>
											<th>Division/Unit</th>
											<th>Batching Officer</th>
											<th>Date</th>
										</tr>
									</thead>
									<tbody></tbody>

								</table>
							</div>
						</div>




					</div>
					<div class="col-md-4">
						<div class="card">
							<div class="card-header">Details</div>
							<div class="card-body">
								<form >
									<fieldset>
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Applicant
												Name</label>

											<textarea readonly class="form-control"
												id="enq_applicant_name"></textarea>

										</div>

										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Applicant type</label> 
											<input type="text" readonly class="form-control" id="enq_applicant_type">

										</div>
									</fieldset>
									<hr>
									<fieldset>
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Cabinet
												Name</label> <input type="text" readonly class="form-control"
												id="enq_cabinet_name">
										</div>
										<hr>
										<!-- <div class="form-group ">
									    <label for="staticEmail" class=" col-form-label">Shelve Number</label>
									      <input type="text" readonly class="form-control" id="shelve_number" value="3C">
									 </div> -->
										 <div class="form-group ">
									    <label for="staticEmail" class=" col-form-label">Job Purpose</label>
									      <textarea  readonly class="form-control" id="enq_job_purpose" rows="4"></textarea>
									 </div> 
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Job
												Status</label> 
												<textarea readonly class="form-control"
												id="enq_job_status" rows="4"></textarea>
												
										</div>
										<div class="form-group ">
											<label for="staticEmail" class=" col-form-label">Application Status
												</label> 
												<textarea  readonly class="form-control" id="enq_current_application_status" rows="4"></textarea>
												
										</div>
									</fieldset>


								</form>
							</div>
						</div>
					</div>

				</div>


			</div>
		</div>
	</div>
</div>


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
												
					<iframe src=""  id="elisdovumentpreviewblobfile" width="100%" height="600"></iframe>
							
				</div>

			</div>
			 	<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				
			</div>
			
		</div>
	</div>
</div>

<!-- <div class="modal fade" id="elisDocumentPreview" role="dialog">
    <div class="modal-dialog">
    
      Modal content
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div> -->

<script type="text/javascript" src="CICA/includes/pages_script/clients.js"></script>

    
 <jsp:include page="../CICA/includes/footer.jsp"></jsp:include>
 <script src="CICA/includes/bootstrap/js/bootstrap.bundle.js"></script>
  
<script>

/* $(document).ready(function(){
	  $("#myBtn").click(function(){
		  console.log('ok')
	    $("#elisDocumentPreview").modal('show');
	  });
	}); */
	
let currentTab =0;
//showTab(currentTab);
$("#submitBtn").prop('disabled', true);
let purpose=document.getElementById("purpose");
let tab_extra=document.getElementById("tab-extra");
//let cicaClientForm=document.getElementById("cicaClientForm");

//Divs


purpose.addEventListener("change",function () {
	 tab_extra.innerHTML ="";
	 document.getElementById("tab_extra2").innerHTML ="";
	 let x=purpose.value;
	 let html="";
	if(x=="1"){
		html=`
			<div class="row mb-3 d-none" id="withinDiv">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Within Time Frame?</b>:</label>
	           <div class="col-sm-8">
				<input class="form-control" name="within_time_frame" id="within_time_frame" readonly />
	           </div>
     		</div>`;
     		tab_extra.innerHTML =html;
     		//$("#enquiryModal").modal('show');
     		$("#submitBtn").prop('disabled', true);
     		$("#submit_text").text("Submit");
     		$("#enquiry_tab").show(); 
		
	}
	else if(x=="2"){
		html=`
			<div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Nature of enquiry</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <select class="form-control" aria-label="Default select example" name="nature_of_enquiry" id="nature_of_enquiry"  required="required">
	               <optio value="" disabled selected>-- select --</option>
	               <option value="Registration">Registration</option>
					<option value="Plan">Plan</option>
					<option value="Search">Search</option>	
					<option value="State Land management">State Land management</option>
					<option value="Stool Land Issues">Stool Land Issues</option>
					<option value="Stamping">Stamping</option>
					<option value="Land Ownership/Acquisition">Land Ownership/Acquisition</option>
					<option value="Others">Others</option>
	             </select>
	           </div>
	         </div>

			 <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Response provided</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <textarea class="form-control" name="reference_source" id="reference_source"  required="required"></textarea>
	           </div>
	         </div>
	         `;
		tab_extra.innerHTML =html;
		$("#submitBtn").prop('disabled', false);
		$("#submit_text").text("Submit");
		$("#enquiry_tab").hide();
		
	}
	else if(x=="3"){
		html=`
		<div  id="service_complainant_div">
			 <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	                    
				<select class="form-control" aria-label="Default select example" name="subject" id="subject"  required="required" >
					
					<option value="" disabled selected>--select--</option>
					<option value="Payment Issues">Payment Issues</option>
					<option value="Delayed">Delayed</option>
					<option value="Upload issues">Upload issues</option>
					<option value="Queried">Queried</option>
					<option value="Other Issues">Other Issues</option>
				  </select>
	           </div>
	         </div>
	         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <textarea class="form-control" name="description" id="description"  required="required"></textarea>
	           </div>
	         </div>
	       
	         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Contact Client by</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <select class="form-control" aria-label="Default select example" name="contact_type" id="contact_type"  required="required">
	               <option value="" disabled selected>-- select --</option>
	               <option value="SMS">SMS</option>
					<option value="Email">Email</option>	
	             </select>
	           </div>
	         </div>
	        
	         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Priority</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
				 <input class="form-control" type="text"  name="priority" id="priority"  required="required" readonly>
	           </div>
	         </div>
	         <div class="row mb-3">
             <label for="inputText" class="col-sm-4 col-form-label"><b>Division</b><span class="text-danger">*</span>:</label>	
			<div class="col-sm-8">
				<select class="form-control" aria-label="Default select example" name="division" id="division"  required="required">
	                <option value="" disabled selected>-- select --</option>
	                <option value="PVLMD">PVLMD</option>
					<option value="LRD">LRD</option>
					<option value="LVD">LVD</option>	
					<option value="SMD">SMD</option>	
					<option value="CORPORATE">CORPORATE</option>		
	              </select>
			</div>
		</div>
		
		<div class="row mb-3">
		    <label for="inputText" class="col-sm-4 col-form-label"><b>Region</b><span class="text-danger">*</span>:</label>
			<div class="col-sm-8">
				<select class="form-control" aria-label="Default select example" name="region" id="region" onchange="regionChange()"  required="required">
	                <option value="" disabled selected>-- select --</option>
	                <option value="11">Greater Accra</option>
					<option value="14">Western</option>
					<option value="19">Volta</option>	
					<option value="12">Eastern</option>	
					<option value="13">Ashanti</option>	
					<option value="15">Central</option>	
					<option value="18">Northern</option>	
					<option value="16">Upper East</option>	
					<option value="17">Upper West</option>	
					<option value="10">Tema</option>
					<option value="22">Oti</option>	
					<option value="23">Bono East</option>	
					<option value="24">Ahafo</option>	
					<option value="20">Bono</option>	
					<option value="25">North East </option>	
					<option value="26">Savannah</option>
					<option value="21">Western North</option>	
	              </select>
			</div>
		</div></div>
		
	         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Related Service</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <select class="form-control" id="related_service" name="related_service"  required="required">
				    <option value="" disabled selected>-- select --</option>
				    <option value="Search">Search</option>
				    <option value="Stamp Duty">Stamp Duty</option>
				    <option value="Concurrence">Concurrence</option>
				    <option value="Consent">Consent</option>
					<option value="Plan Approval">Plan Approval</option>
				    <option value="Title Registration">Title Registration</option>
				    <option value="PVLMD Plotting">PVLMD Plotting</option>
				    <option value="Reguralization">Reguralization</option>
					<option value="Certified True Copy">Certified True Copy</option>
				    <option value="Dispute">Dispute</option>
				    <option value="Composite Plan">Composite Plan</option>
					<option value="General Valuation">General Valuation</option>
				    <option value="Compensation">Compensation</option>
				    <option value="Deed Registration">Deed Registration</option>
				    <option value="Substituted Certificate">Substituted Certificate</option>
					<option value="State Land Rent">State Land Rent</option>
					<option value="Other Services">Other Services</option>
			    </select>
	           </div>
	         </div>
	         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Reference No.</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <input type="text" class="form-control required-input" name="reference_id" id="reference_id" required="required">
	           </div>
	         </div>
			 </div>
	         `;
		tab_extra.innerHTML =html;
		$("#submitBtn").prop('disabled', false);
		$("#submit_text").text("Submit");
		$("#enquiry_tab").show();
	}
	else{
		html=`
			 <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
				<select class="form-control" aria-label="Default select example" name="subject" id="subject"  required="required" >
					
						<option value="" disabled selected>--select--</option>
						<option value="Staff Misconduct">Staff Misconduct</option>
						<option value="Work Environment">Work Environment</option>
						<option value="Security">Security</option>
						<option value="Others">Others</option>
					</select>
	           </div>
	         </div>
	         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <textarea class="form-control" name="description" id="description"  required="required"></textarea>
	           </div>
	         </div>
	         
	         <div class="row mb-3">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Contact Client by</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <select class="form-control" aria-label="Default select example" name="contact_type" id="contact_type"  required="required">
	               <option value="" disabled selected>-- select --</option>
				   <option value="SMS">SMS</option>
					<option value="Email">Email</option>	
	             </select>
	           </div>
	         </div>
	         
	         <div class="row mb-3 d-none">
	           <label for="inputText" class="col-sm-4 col-form-label"><b>Priority</b><span class="text-danger">*</span>:</label>
	           <div class="col-sm-8">
	             <input type="text" class="form-control" value="----">
	           </div>
	         </div>
	         <div class="row mb-3">
	              <label for="inputText" class="col-sm-4 col-form-label"><b>Division</b><span class="text-danger">*</span>:</label>	
				<div class="col-sm-8">
					<select class="form-control" aria-label="Default select example" name="division" id="division"  required="required">
		                
						<option value="CORPORATE" selected>CORPORATE</option>		
		              </select>
				</div>
			</div>
			
			<div class="row mb-3">
			    <label for="inputText" class="col-sm-4 col-form-label"><b>Region</b><span class="text-danger">*</span>:</label>
				<div class="col-sm-8">
					<select class="form-control" aria-label="Default select example" name="region" id="region" onchange="regionChange()"  required="required">
		                <option value="" disabled selected>-- select --</option>
		                <option value="11">Greater Accra</option>
					<option value="14">Western</option>
					<option value="19">Volta</option>	
					<option value="12">Eastern</option>	
					<option value="13">Ashanti</option>	
					<option value="15">Central</option>	
					<option value="18">Northern</option>	
					<option value="16">Upper East</option>	
					<option value="17">Upper West</option>	
					<option value="10">Tema</option>
					<option value="22">Oti</option>	
					<option value="23">Bono East</option>	
					<option value="24">Ahafo</option>	
					<option value="20">Bono</option>	
					<option value="25">North East </option>	
					<option value="26">Savannah</option>
					<option value="21">Western North</option>
		              </select>
				</div>
			</div>
			
		
	         `;
		tab_extra.innerHTML =html;
		$("#submitBtn").prop('disabled', false);
		$("#submit_text").text("Submit");
		$("#enquiry_tab").hide();
		
	}
	
		
	})


			document.getElementById("btnCCJobSearch").addEventListener("click", function () {
			  // Check if radio button and input field filled
			  if(checkInput()){
				  // Submit Search
				  var enq_search_type = "";
					var selected_rbtn = $("input[name='rbtn_search_type']:checked");
					if (selected_rbtn.length > 0) {
						enq_search_type = selected_rbtn.val();
						//console.log("selected " + enq_search_type);
					}

					var enq_search_value = $(
							"#cc_search_value").val();
					console.log('Search Value: '
							+ enq_search_value);
					
					if (!(enq_search_value.length >= 8)) {
						$
								.notify(
										{
											message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please enter 8 or more characters to search </span>',
										}, {
											type : 'danger' , z_index: 9999 
										});
					}else if (enq_search_type.length <= 0){
						$.notify({
							message : '<i class="fa fa-exclamation  fa-3x fa-fw"></i><span class="text-bold">Please select the type of field for your search</span>',
						}, { type : 'danger' , z_index: 9999  });
						
					} else {

						$("#cc-search-results-section")
								.hide();
						
						$.ajax({
				            type : "POST",
				            url : "Case_Management_Serv",
				            data : {
				                request_type : 'load_application_details_for_enquiries',
				                job_number : enq_search_value,
				                search_type: enq_search_type
				            },
				            cache : false,
				                    success : function(
				                            jobdetails) {

				                        console.log(jobdetails);
				                        $(
				                                "#cc-search-results-section")
				                                .show();

				                        var table = $('#cc-search-results-table');
				                        table.find(
				                                "tbody tr")
				                                .remove();

				                        // console.log(jobdetails);
				                        var json_p = JSON
				                                .parse(jobdetails);

				                        $(json_p)
				                                .each(
				                                        function() {
				                                            //console.log(this);
				                                            table
				                                                    .append("<tr><td>"
				                                                            + this.ar_name
				                                                            + "</td><td>"
				                                                            + this.case_number
				                                                            + "</td><td>"
				                                                            + this.job_number
				                                                            + "</td><td>"
				                                                            /*+ this.glpin
				                                                            + "</td><td>"*/
				                                                            + this.locality
				                                                            + "</td><td>"
				                                                            + this.regional_number
				                                                            + "</td>"
				                                                            //<td>"
				                                                           // + this.current_application_status
				                                                           // + "</td>"

				                                                            + '<td> <div class="dropdown"> <button class="btn btn-secondary dropdown-toggle" type="button"'
				                                                            + ' id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Actions</button>'
				                                                            + ' <div class="dropdown-menu" aria-labelledby="dropdownMenu2">'
				                                                            
				                                                            // + '<button type="button" class="btn btn-primary dropdown-item" id="btn_cabinet" title="View Application Progress" data-toggle="modal" data-target="#cabinetModal"'
																			// + ' data-target-id="'
																			// + this.job_number
																			// + '"> '
																			// + '<span class="icon text-black-50"> <i class="fas fa-hdd"></i> </span><span  class="text">Cabinet</span> </button>'
																			
																			// + '<div class="dropdown-divider"></div>'

				                                                            + '<button type="button" class="btn btn-primary dropdown-item" id="btn_cabinet" title="View Application Progress" data-toggle="modal" data-target="#trackingModal"'
				                                                            + ' data-target-id="'
				                                                            + this.job_number
				                                                            + '"> '
				                                                            + '<span class="icon text-black-50"> <i class="fas fa-hdd"></i> </span><span  class="text">Track Application</span> </button>'
				                                                            /*<div class="dropdown-divider"></div>'

				                                                            + '<button type="button" class="btn btn-primary dropdown-item" id="track_file" title="Physical File History" data-toggle="modal" data-target="#filelistModal"'
				                                                            + ' data-target-id="'
				                                                            + this.job_number
				                                                            + '"> '*/
				                                                            /*+ '<span class="icon text-black-50"> <i class="fas fa-archive"></i> </span><span  class="text">Track Physical File </span> </button><div class="dropdown-divider"></div>'

				                                

				                                                            
				                                                            + '<form action="front_office_view_application" method="post">'
				                                                            + '<input type="hidden" name="case_number" id="case_number" value="'+ this.transaction_number +'">'
				                                                            + '<input type="hidden" name="job_number" id="job_number" value="'+ this.job_number +'">'
				                                                            + '<input id="search_text" name="search_text" type="hidden" value="'+ this.case_number +'">'
				                                                            + '<input type="hidden" name="business_process_sub_name" id="business_process_sub_name" value="'+ this.case_number +'}">'
				                                                            
				                                                            
				                                                            + '<button type="submit" class="btn btn-primary dropdown-item" id="btn_application_details" title="View Application Details" > '
				                                                            + '<span class="icon text-black-50"> <i class="fas fa-info-circle"></i>  </span><span  class="text">Application Details</span></button>'
				                                                            
				                                                            
				                                                            
				                                                            
				                                                            + '</form>'
				                                                            */
				                                                            /*+ '<div class="dropdown-divider"></div>'

				                                                            + '<button type="button" class="btn btn-primary dropdown-item" id="btn_collection"  title="Issue out Application" data-toggle="modal" data-target="#collectionModal" '
				                                                            + ' data-target-id="'
				                                                            + this.job_number
				                                                            + '"> '
				                                                            + '<span class="icon text-black-50"> <i class="fas fa-hand-holding"></i> </span><span  class="text">Collection</span></button>'
				                                                            + '<div class="dropdown-divider"></div>'*/

				                                                            /*
				                                                                * + '<button
				                                                                * type="button"
				                                                                * class="btn
				                                                                * btn-primary
				                                                                * dropdown-item"
				                                                                * id="btn_file_number"
				                                                                * title="File
				                                                                * Number" ' + '
				                                                                * data-target-id="' +
				                                                                * this.job_number +
				                                                                * '"> ' + '
				                                                                * <span
				                                                                * class="icon
				                                                                * text-black-50">
				                                                                * <i
				                                                                * class="fas
				                                                                * fa-file-alt"></i>
				                                                                * </span><span
				                                                                * class="text">File
				                                                                * number :
				                                                                * LRD565
				                                                                * </span></button>' + '
				                                                                * <div
				                                                                * class="dropdown-divider"></div>'
				                                                                */

				                                                            /*+ '<button type="button" class="btn btn-primary  dropdown-item" id="btn_add_fees"   title="Add Fees">'
				                                                            + '<span class="icon text-black"> <i class="fa fa-dollar-sign"></i>  </span> <span  class="text">Add Fees</span></button>'
				*/
				                                                            + '</div></div></td></tr>');

				                                        });

				                    }
				                });
	
                        }
                        
                       }

                       })
			 
function within_time_frame_change(){
	let x= document.getElementById("within_time_frame").value;
	 let html="";
		if(x=="1"){
			html=`<div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Provide Milestone Status To Enquirer</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <textarea class="form-control" name="milestone_status" id="milestone_status" required></textarea>
		           </div>
		         </div>`;
			
			document.getElementById("tab_extra2").innerHTML =html;
			$("#submitBtn").prop('disabled', false);
			
		}
		else{
			html=`
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Subject</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		            <input type="text" class="form-control" name="subject" id="subject" value="Delay"  required="required" readonly>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Description</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <textarea class="form-control" name="description" id="description"  required="required"></textarea>
		           </div>
		         </div>
		       
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Contact Client by</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" aria-label="Default select example" name="contact_type" id="contact_type"  required="required">
		               <option value="" disabled selected>-- select --</option>
					   <option value="SMS">SMS</option>
					<option value="Email">Email</option>	
		             </select>
		           </div>
		         </div>
		        
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Priority</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
					<input class="form-control" type="text"  name="priority" id="priority"  required="required" readonly>
		           </div>
		         </div>
		         <div class="row mb-3">
	              <label for="inputText" class="col-sm-4 col-form-label"><b>Division</b><span class="text-danger">*</span>:</label>	
				<div class="col-sm-8">
					<select class="form-control" aria-label="Default select example" name="division" id="division"  required="required">
		                <option value="" disabled selected>-- select --</option>
		                <option value="PVLMD">PVLMD</option>
						<option value="LRD">LRD</option>
						<option value="LVD">LVD</option>	
						<option value="SMD">SMD</option>	
						<option value="CORPORATE">CORPORATE</option>		
		              </select>
				</div>
			</div>
			
			<div class="row mb-3">
			    <label for="inputText" class="col-sm-4 col-form-label"><b>Region</b><span class="text-danger">*</span>:</label>
				<div class="col-sm-8">
					<select class="form-control" aria-label="Default select example" name="region" id="region" onchange="regionChange()"  required="required">
		                <option value="" disabled selected>-- select --</option>
		                <option value="11">Greater Accra</option>
					<option value="14">Western</option>
					<option value="19">Volta</option>	
					<option value="12">Eastern</option>	
					<option value="13">Ashanti</option>	
					<option value="15">Central</option>	
					<option value="18">Northern</option>	
					<option value="16">Upper East</option>	
					<option value="17">Upper West</option>	
					<option value="10">Tema</option>
					<option value="22">Oti</option>	
					<option value="23">Bono East</option>	
					<option value="24">Ahafo</option>	
					<option value="20">Bono</option>	
					<option value="25">North East </option>	
					<option value="26">Savannah</option>
					<option value="21">Western North</option>	
		              </select>
				</div>
			</div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Related Service</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <select class="form-control" id="related_service" name="related_service"  required="required">
					    <option value="" disabled selected>-- select --</option>
					    <option value="Search">Search</option>
				    <option value="Stamp Duty">Stamp Duty</option>
				    <option value="Concurrence">Concurrence</option>
				    <option value="Consent">Consent</option>
					<option value="Plan Approval">Plan Approval</option>
				    <option value="Title Registration">Title Registration</option>
				    <option value="PVLMD Plotting">PVLMD Plotting</option>
				    <option value="Reguralization">Reguralization</option>
					<option value="Certified True Copy">Certified True Copy</option>
				    <option value="Dispute">Dispute</option>
				    <option value="Composite Plan">Composite Plan</option>
					<option value="General Valuation">General Valuation</option>
				    <option value="Compensation">Compensation</option>
				    <option value="Deed Registration">Deed Registration</option>
				    <option value="Substituted Certificate">Substituted Certificate</option>
					<option value="State Land Rent">State Land Rent</option>
					<option value="Other Services">Other Services</option>
				    </select>
		           </div>
		         </div>
		         <div class="row mb-3">
		           <label for="inputText" class="col-sm-4 col-form-label"><b>Reference No.</b><span class="text-danger">*</span>:</label>
		           <div class="col-sm-8">
		             <input type="text" class="form-control required-input" name="reference_id" id="reference_id"  required="required">
		           </div>
		         </div>`;
		         
			document.getElementById("tab_extra2").innerHTML =html;
			$("#submitBtn").prop('disabled', false);
		}

}
		

/*function get_related_service(val){
    var related_service = val;
    let html = '';
    if (related_service == 'Job Number'){
        html = "<div class='row mb-3'><label for='inputText' class='col-sm-4 col-form-label'><b>Job Number</b><span class='text-danger'>*</span>:</label><div class='col-sm-8'><input type='text' class='form-control' name='service_number' required></div></div>";
    }
    
    else if (related_service == 'Bill Number'){
        html = "<div class='row mb-3'><label for='inputText' class='col-sm-4 col-form-label'><b>Bill Number</b><span class='text-danger'>*</span>:</label><div class='col-sm-8'><input type='number' class='form-control' name='service_number' required></div></div>";
    }
    else if(related_service == 'Name'){
        html = "<div class='row mb-3'><label for='inputText' class='col-sm-4 col-form-label'><b>Name of Applicant</b><span class='text-danger'>*</span>:</label><div class='col-sm-8'><input type='text' class='form-control' name='service_number' required></div></div>";
    }

    document.getElementById('related_services').innerHTML = html;        
}
*/

//Function Checks if radio button and input field filled
function checkInput(){
	 let checkedList=[];
    let checkBoxes =document.getElementsByClassName('rbtn_search_type');
    for (let i=0;i<checkBoxes.length;i++){
        if(checkBoxes[i].checked){
            checkedValue=checkBoxes[i].value;
            checkedList.push(checkedValue);
        }
    }
    
    if(checkedList.length === 0){
        toastr["error"]("Nothing selected ", "Job Search");
        return false;
    }
    else{
   	 
   	 
   	 return true;
    }
}

$('#cicaClientForm').on('submit',function(e){
	e.preventDefault();
	$("#submitBtn").prop('disabled', true);
	$("#submit_text").text("Please wait ...");

	let complainant_name=$('input[name="complainant_name"]').val();
	let complainant_phone=$('input[name="complainant_phone"]').val();
	let complainant_email=$('input[name="complainant_email"]').val();
	let complainant_add=$('#complainant_add').val();
	let gender=$('#gender').val();
	let purpose=parseInt($('#purpose').find(":selected").val());
	let request_type=$('input[name="request_type"]').val();
	let request_by_id=$('input[name="request_by_id"]').val();
	let request_by=$('input[name="request_by"]').val();
	let within_time_frame=null;
	let milestone_status=null;
	let reference_source=null;
	let subject=null;
	let description=null;
	let division=null;
	let region=null;
	//let unit=null;
	let related_service=null;
	let reference_id=null;
	let contact_type=null;
	let priority=null;
	let nature_of_enquiry=null;


	console.log(complainant_add)
	
	switch (purpose) {
	  case 1:
			 within_time_frame = parseInt($('#within_time_frame').val());
			 milestone_status = within_time_frame ? $('#milestone_status').val() : null;
			 subject = !within_time_frame ? $('#subject').find(":selected").text() : null;
			 description = !within_time_frame ? $('#description').val() : null;
			 contact_type = !within_time_frame?$('#contact_type').find(":selected").text() : null;			
			 priority = !within_time_frame ? $('input[name="priority"]').val() : null;
			 related_service = !within_time_frame?$('#related_service').find(":selected").text() : null;
			 reference_id =!within_time_frame?$('input[name="reference_id"]').val():null;
			 division =!within_time_frame?$('#division').find(":selected").val():null;
			 region =!within_time_frame?$('#region').find(":selected").val():null;
		break;
	  case 3:
			 subject=$('#subject').find(":selected").text();
			 description=$('#description').val();
			 contact_type=$('#contact_type').find(":selected").text();
			 priority=$('input[name="priority"]').val();
			 related_service=$('#related_service').find(":selected").text();
			 reference_id=$('input[name="reference_id"]').val();
			 division=$('#division').find(":selected").val();
			 region=$('#region').find(":selected").val();
	    break;
	  case 2:
		  reference_source=$('#reference_source').val();
		  nature_of_enquiry=$('#nature_of_enquiry').val();
		  break;
	  default:
		   	 description=$('#description').val();
	  		 priority=$('input[name="priority"]').val();
			 division=$('#division').find(":selected").val();
			 region=$('#region').find(":selected").val();
			 purpose=4;
			 contact_type=$('#contact_type').find(":selected").text();
			 subject=$('#subject').find(":selected").text();
	}
	
	
	
	$.ajax({
	type:"POST",
	url:"cica_clients_serv",
	data:{"request_type":"save_client_details",
		  "complainant_name":complainant_name,
		  "complainant_phone":complainant_phone,
		  "complainant_email":complainant_email,
		  "complainant_add":complainant_add,
		  "gender":gender,
		  "subject":subject,
		  "description":description,
		  "contact_type":contact_type,
		  "purpose":purpose,
		  "priority":priority,
		  "related_service":related_service,
		  "reference_id":reference_id,
		  "milestone_status":milestone_status,
		  "within_time_frame":within_time_frame,
		  "request_by_id":request_by_id,
		  "request_by":request_by,
		  "reference_source":reference_source,
		  "region":region,
		  "division":division,
		  "nature_of_enquiry":nature_of_enquiry
	},
	cache : false,
					xhrFields : {
						responseType : 'blob'
					},
					beforeSend : function() {
						// $('#district').html('<img
						// src="img/loading.gif"
						// alt="" width="24"
						// height="24">');
					},
	success:function(jobdetails){
		
	  	console.log(jobdetails);
             
	      if(jobdetails !== null) {
	    	  	toastr["success"]("Ticket Added successfully", "CICA");
	  			//showbatchlist(response);

				  $('#elisDocumentPreview')
								.modal('show',
										{
											backdrop : 'static',
										});

						var blob = new Blob(
								[ jobdetails ],
								{
									type : "application/pdf"
								});
						var objectUrl = URL
								.createObjectURL(blob);
						// window.open(objectUrl);

						$(
								'#elisdovumentpreviewblobfile')
								.attr('src',
										objectUrl);

						$(
								'#fedocumentPreviewblobfile')
								.attr('src',
										objectUrl);

						// $('#NotoncaseafterPaymentModalonCase').modal('hide');
	      } else {
	    	  toastr["error"]("Sorry! Something happened, please try again", "Error");
	      }
             
		}	
	})
	
	
	function showbatchlist(response){
		
		
		var file_path =response;
		console.log(file_path);
		
		$.ajax({
					type : "POST",
					url : "cica_clients_serv",
					// target:'_blank',
					data : {
						request_type : 'open_pdf',
						file_path : file_path
					},
					cache : false,
					xhrFields : {
						responseType : 'blob'
					},
					beforeSend : function() {
						// $('#district').html('<img
						// src="img/loading.gif"
						// alt="" width="24"
						// height="24">');
					},
					success : function(jobdetails) {
						console.log(jobdetails);
						// const arrayBuffer =
						// _base64ToArrayBuffer(jobdetails);
					

						$('#elisDocumentPreview')
								.modal('show',
										{
											backdrop : 'static',
										});

						var blob = new Blob(
								[ jobdetails ],
								{
									type : "application/pdf"
								});
						var objectUrl = URL
								.createObjectURL(blob);
						// window.open(objectUrl);

						$(
								'#elisdovumentpreviewblobfile')
								.attr('src',
										objectUrl);

						$(
								'#fedocumentPreviewblobfile')
								.attr('src',
										objectUrl);

						// $('#NotoncaseafterPaymentModalonCase').modal('hide');

					}
				});


			}
$('#elisDocumentPreview').on('hidden.bs.modal',function(){
setTimeout(function(){
                location.reload();
            },1000); 
})
		
	
/*	let complainant_name=$('input[name="complainant_name"]').val();
	let complainant_phone=$('input[name="complainant_phone"]').val();
	let complainant_email=$('input[name="complainant_email"]').val();
	let complainant_add=$('#complainant_add').val();
	let selected_purpose=$('#purpose').find(":selected").val();
	let request_by=$('input[name="request_by"]').val();
	let request_by_id=$('input[name="request_by_id"]').val();
	let within_time_frame="";
	let milestone_status="";
	if(complainant_name !="" || complainant_phone !="" ){
		
	switch(selected_purpose){
	  case "1":
		  	
		  		within_time_frame=$('#within_time_frame').find(":selected").val();
		  		milestone_status=$('#milestone_status').val();
		  		console.log(milestone_status);
		  		if(within_time_frame !="" ){
		  			
		  			$("#submitBtn").prop('disabled', false);
		  			$("#submit_text").text("Submit");
		  			
		  			
		  		}else{
			  		 toastr["error"]("There are empty required fields ", "CICA");
			  	}
		  
		  	
		  break;
	  case "2":
	  		let reference_source=$('#reference_source').val();
	  		if(reference_source !=""){
	  			$("#submitBtn").prop('disabled', false);
	  			$("#submit_text").text("Submit");
	  					
	  		}else{
		  		 toastr["error"]("There are empty required fields ", "CICA");
		  	}
		  break;
	  case "3":
		    within_time_frame=$('#within_time_frame').find(":selected").val();
	  		milestone_status=$('#milestone_status').val();
	  		console.log(milestone_status);
	  		if(within_time_frame !=""){
	  			
	  			$("#submitBtn").prop('disabled', false);
	  			$("#submit_text").text("Submit");
	  			
	  			
	  		}else{
		  		 toastr["error"]("There are empty required fields ", "CICA");
		  	}
		  break;
	   case "4":
		   let subject=$('#subject').val();
		   let description=$('#description').val();
	  		if(subject !="" || description !=""){
	  			$("#submitBtn").prop('disabled', false);
	  			$("#submit_text").text("Submit");
	  			
	  			
	  		}else{
		  		 toastr["error"]("There are empty required fields ", "CICA");
		  	}
		  break;
	default:
		console.log("no criteria");
	}

	}
	else{
 		 toastr["error"]("There are empty required fields ", "CICA");
 	}
	
	let complaint_subject=$('input[name="complaint_subject"]').val();
	let complaint_description=$('#complaint_description').val();
	let results=$('#results').val(); */

})

function submitData(formData){
	const values = [...formData.entries()];
	 console.log(values);
	$.ajax({
		type:"POST",
		url:"clients",
		data:{formData,
		},
		success:function(response){
		  console.log(response);
		 let json_result = JSON.parse(response);

		 if(json_result.success){
			 toastr["success"]("Successfully", "CICA");
            } 
          else {
                    toastr["error"]("Error", "CICA");
             }

                $("#cicaClientForm").trigger('reset');

                $("#prevBtn").prop('disabled', false);
                $("#nextBtn").prop('disabled', false);
                
                setTimeout(function(){
                    location.reload();
                },1000); 
		}	
	})
	
	
}

			function regionChange(){
				 let x=region.value;
				 let division=$('#division').find(":selected").val();
				
				 if(division == ""){
					 toastr["warning"]("Select Division", "LEGAL");
					 $('#division').focus();
				 }
				 else{
					 
					 $.ajax({
							url:"Case_Management_Serv",
							method:"POST",
							data:{
									request_type:"get_lc_list_of_units"
							},
							success:function(response){
								//console.log(response);
								let json_p = JSON.parse(response);
								var datalist = $("#listofunits");
								datalist.empty();
								
								$(json_p.data).each(
												function() {
															
																if(this.unit_division ==division){
																datalist
																		.append('<option data-name="'
																				+ this.unit_name
																				+ '" data-id="'
																				+ this.unit_id
																				+ '" value="'
																				+ this.unit_name
																				+ '" ></option>');
																}
												
														});
							}
								
							})
				 }
	  }
	  
		function showEnquiryTab(){
			$("#enquiryModal").modal('show');
		}		
</script>