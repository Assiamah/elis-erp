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
			               
			               <li><a href="#link-1">Record Verification<br /><small>Record Verification</small></a></li>
			                <!--  <li><a href="#link-2">Record Verification<br /><small>Record Verification</small></a></li> -->
			          		 <li><a href="#link-2">Search Report Preparation<br /><small>Search Report Preparation</small></a></li>
			          		 <li><a href="#link-3">Quality Control<br /><small>Signing</small></a></li>
							
			            </ul>
			
			            <div>
			                

			      
			                <div id="link-1" class="">
			                	<br>
			                    <h3 class="border-bottom border-gray pb-2">Records Information Search</h3>
			                    
			                    
			                      <div class="row">
			                     <!--   Here is the right Table -->
							        <div class="col-lg-12">
							          <!-- Example Pie Chart Card-->
							          <div class="card mb-3">
							            <div class="card-header">
							              <i class="fa fa-pie-chart"></i>Records Information</div>
							            <div class="card-body">
						
			       
     
     
     
     
             
				               <div class="form-group">
								<!-- <label for="main_service">Main Service</label> -->
								<input placeholder="Job Number or Certificat Number" id="scm_job_number_search" class="form-control input-sm" data-style="btn-info" type="text" />
									
									
							</div>
							<div class="form-group">
								<div class="form-row">
									<div class="col">
										<button class="btn btn-secondary btn-icon-split float-left " id="btn_scm_job_number_search_csp" data-backdrop="static" data-keyboard="false" >
												<span class="icon text-white-50"> <i class="fas fa-plus"></i></span><span class="text"> Search </span>
											</button>
										
									</div>
									<div class="col">
										<!-- <button class="btn btn-success btn-icon-split float-right  btn-lg" id="btnFindClientDetails"  >
												<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">Search </span>
											</button>
											 -->
											
											
									</div>
								</div>
								
									
							</div>
     
         <div class="row">
     <div class="col-lg-12">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header bg-dark text-white">
              <i class="fa fa-bar-chart"></i>Application Details
              	<!-- <span class="col-md-3 float-right ">
              <button class="btn btn-success btn-icon-split float-right "  id="btnViewBatchlist">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Batch List</span>
				</button></span> -->
              
              </div>
              
            <div class="card-body">
            
         
            
             <!--  Here is where the fee list comes -->
             
             <div class="table-responsive">
           <table class="table table-bordered data-table" id="tbl_search_for_job_details_datatable" width="100%" cellspacing="0">
           
              <thead>
                <tr>
                 
                 
                 
                 <th>Job Number</th>
				 <th>Certificate Number</th>
                 <th>Applicant Name</th>
                 <th>Application Type</th>
				 <th>Details</th>
               <!--   <th style="display:none">Status</th> -->
                 <!-- <th>Status</th> -->
                
                 <!-- <th>Status</th> -->
                
                 <!-- <th >Add to BatchList</th> -->
                  <!-- <th>Work</th> -->
                 
                 
                 
                 
                 <!-- 	<th data-field="customer.name" data-align="center" data-sortable="true">customer</th>
                    <th data-field="type" data-align="center" data-sortable="true">type</th>
                    <th data-field="description" data-align="center" data-sortable="true">description</th>
                    <th data-field="cutter" data-align="center" data-sortable="true">cutter</th> 
                    <th data-field="valid_s" data-align="center" data-sortable="true">valid</th>
                  -->
                 
                 </tr>
              </thead>
              
                <tbody>
    
            		
                
            
             </tbody>
            
            
            </table>
          </div>
             


			                
		  <div class="row">
								                                                        
			<div class="col-md-5">
				<div class="form-group">
				  
			  <input class="form-control" id="csd_job_number"  name="csd_job_number"  type="text"  placeholder="Job Number" required >
			   
				</div>
			</div>

		  					                                                        
			<div class="col-md-5">
				<div class="form-group">
				  
			  <input class="form-control" id="csd_certificate_number"  name="csd_certificate_number"  type="text"  placeholder="Certificate Number" required >
			   
				</div>
			</div>
		
			
			<div class="col-md-2">
				<div class="form-group">
				 <button type="button" class="btn btn-primary" id="btn_csd_save_details" data-placement="top" data-toggle="tooltip" title="Search"><i class="fa fa-save"></i> Save </button>
			
				</div>
			</div>
			

		</div>


              <!--  End Of Table -->
            </div>
            
          </div>
      </div>
     </div>
     
     
     
							            
							            
							            
							            </div>
							          
							          
							          
							          
							     
							         
							        </div>
							      <!--   Here is the end of right table -->
							  
							      </div>
							      

							     </div>
			                </div>
			                
			                <div id="link-2" class=""><br>
			                    <h3 class="border-bottom border-gray pb-2">Search Report Preparation</h3>
			                   <div class="row form-group ">
			
			 
			      
			      
							      
							       <!--   Here is the right Table -->
							        <div class="col-lg-12">
							          <!-- Example Pie Chart Card-->
							          <div class="card mb-10">
							            <div class="card-header">
							              <i class="fa fa-pie-chart"></i>Summarize Search Reports</div>
							            <div class="card-body">
							               <!--  The Form starts here -->
							           
							
									          <div class="form-group">
							            
							            
							            <div class="form-row">
							              <div class="col-md-12">
							                <label for="search_value">Report Summary</label>
											 
											
											 
											    <textarea id="lc_search_report_summary_details" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
			        	                    
			        	                    
			        	                   <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
				             --%>
			        													
							                </div>
							                
							               
							             
							            </div>
							            
							            
							            
							             
							            <div class="form-row">
							               <div class="col-auto">
									              <br><br>									                 
						               				
						               					<button type="button" name="btn_compose_certificate_template" id="btn_compose_certificate_template" class="btn  btn-primary btn-icon-split "  >
										    			<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
										    		</button>
										    		
										    	
							                </div>
							              <div class="col-auto">
									              <br><br>									                 
						               				<button type="button" name="lc_btn_save_search_report" id="lc_btn_save_search_report" 
						               				class="btn btn-block btn-secondary btn-icon-split "  >
												    	 <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save Report</span>
										    		</button>
							                </div>
							                
							                 <div class="col">
							              			<br><br>
							                		<button type="button" name="btn_preview_search_report" id="btn_preview_search_report" class="btn  btn-primary btn-icon-split "  >
										    			<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview Search Report</span>
										    		</button>
							                
							                </div>
							              </div>
							            
							          </div>
							          
							          
							          
							          
							         
							          
							          
							          
							      
							            
							            <!-- The form Ends Hers -->
							            
							          </div>
							         
							        </div>
							      <!--   Here is the end of right table -->
							  
							      </div>
			
			 </div>
			                </div>
			                           
			                <div id="link-3" class=""><br>
			                    <h3 class="border-bottom border-gray pb-2">Signing and Generate Report</h3>
									          
									 
									  <div class="row">
						 
						       			<!--   Here is the right Table -->
								       
								         
							            
								       
								        <div class="col-lg-12">
								          <!-- Example Pie Chart Card-->
								          <div class="card mb-3">
								            <div class="card-header">
								              <i class="fa fa-pie-chart"></i>Proof Reading of Search Report</div>
								            <div class="card-body">
								                 <textarea id="lc_search_report_summary_details_final" 
								                 name="lc_search_report_summary_details_final" 
								                 class="form-control col-sm-12" required rows=10 style="padding:150px !important">${remark_or_comment} </textarea> 
			        	                    
								             <div class="form-row">
							              
							              <div class="col-auto">
							              		<br>
							                    <button type="button" name="lc_btn_save_search_report_final" id="lc_btn_save_search_report_final" 
							                    class="btn btn-block btn-secondary btn-icon-split "  >
											    	 <span class="icon text-white-50"> <i class="fas fa-upload fa-2x"></i></span><span class="text">Update Report</span>
									    		</button>
							               </div>
							               <div class="col-auto">
							               		<br>
							               		<button type="button" name="btn_preview_final_search_report" id="btn_preview_final_search_report" 
							               		class="btn  btn-primary btn-icon-split "  >
										    		<span class="icon text-white-50"> <i class="fas fa-print fa-2x"></i></span><span class="text">Preview Search Report</span>
										    	</button>
							               </div>
							               <div class="col-auto">
							               		<br>
							               		<button type="button" name="btn_generate_pvlmd_search_report" id="btn_generate_pvlmd_search_report" 
							               		class="btn  btn-success btn-icon-split "  >
									    			<span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Signed</span>
									    		</button>
							               </div>
							               
							               
							               
							            </div>
								          </div>
								         
								        </div>
								      <!--   Here is the end of right table -->
								  
								      </div>
								      
								      
								       <div class="col-lg-4">
								          <!-- Example Pie Chart Card-->
								          <div class="card mb-3">
								            
								            <div class="card-body">
								               <!--  The Form starts here -->
								           
								              	  <div class="form-group row"> 
												   <!--  <div class="col-sm-12">
												    
												      <figure class="figure">
														  <img src="https://dummyimage.com/595%20x%20842/accc93/000000.png&text=Sample+Final+Report" class="figure-img img-fluid rounded" alt="A generic square placeholder image with rounded corners in a figure.">
														  <figcaption class="figure-caption text-right">Please Confirm Report</figcaption>
														</figure>
												      
												    </div> -->
												  </div>
												  
												  
											<input type="text"  class="form-control form-control-plaintext" id="staticEmail" value="Is document Signed">
									                
										    		
								          </div>
								         
								        </div>
								      <!--   Here is the end of right table -->
								  
								      </div>
								      
								 </div>
			               
			  					</div>
			                
			                
			     
			               
			                
			            </div>
			        </div>
							
          
          
          
          
             <jsp:include page="../client_application/_application_process_footer.jsp"></jsp:include>
     