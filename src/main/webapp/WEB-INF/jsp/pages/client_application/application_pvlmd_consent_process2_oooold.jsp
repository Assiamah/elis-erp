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

        <div id="smartwizardfirstregistration">
            <ul class="d-none">
               
               
                
                <li><a href="#link-1">Record Verification<br /><small>Record Verification</small></a></li>
                 <li><a href="#link-2">Vetting and Approval<br /><small>Vetting and Approval</small></a></li>
               
              <!--   <li><a href="#link-3">Plan Preparation and Plotting<br /><small>Plan Preparation and Plotting</small></a></li> -->
                <li><a href="#link-3">Ground Rent<br /><small>Ground Rent</small></a></li>
                 <li><a href="#link-4">Preparation of Certificate<br /><small>Preparation of Certificate</small></a></li>
                <li><a href="#link-5">Final Approval<br /><small>Final Approval</small></a></li>
             
            </ul>

            <div>
            
             
               <%--  <div id="link-1" class="">
                    <h3 class="border-bottom border-gray pb-2">Upload Scan Documents</h3>
                    
                    
		     	
				      <button type="button" class="btn btn-primary" id="lrd_btn_add_docs" data-toggle="modal" data-target="#fileUploadModal" title="Upload Documents">
		            <i class="fa fa-plus-circle"></i>
		        </button>
		         <button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
		        
			         		
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
		
                     
               	
                    </div>
                     --%>
                      
      
                <div id="link-1" class="">
                    <h3 class="border-bottom border-gray pb-2">Records Information Search</h3>
                    
                    
                      <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Records Information</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				       
            <!-- Maps Details Starts Here  -->
            <div class="bs-example">
            
         
            
            
            
    <div class="btn-group mr-2">
      <button type="button" class="btn btn-primary"  id="lc_btn_fr_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-map"></i>
        </button>
       <!--  
          <button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
            <i class="fa fa-save"></i>
        </button>
        -->
       
         <button type="button" class="btn btn-primary" id="lc_btn_fr_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
            <i class="fa fa-object-ungroup"></i>
        </button>
        
       
        <button type="button" class="btn btn-primary" id="lc_btn_fr_printmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-print"></i>
        </button>
    </div>
   

    
    
  
   
   <div class="btn-group">

						 
					         
					         <input readonly class="form-control" id="lc_fr_bl_wkt_polygon"  name="lc_fr_bl_wkt_polygon"  type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${parcel_wkt}" >
				             
					       
					         
      		 
    </div>
    
    

   
      
    
</div>


       
            
            
            
             <div id="lcfrs-map" ></div>
             
             
						          
				              </form>
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
				     </div>
                </div>
                
                
                
                               <div id="link-2" class="">
                    <h3 class="border-bottom border-gray pb-2">Physical Planning Approval</h3>
                   <div class="row">

 
      
      
				      
				       <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-10">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Planning Comments</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				           
				
						          <div class="form-group">

         
           					<div class="form-group">
					       
					        <div class="form-row">  <label for="bl_job_purpose">Type of Letter</label>
					       <select name="lc_letter_type" id="lc_letter_type" data-live-search="true" data-none-results-text="I found no results" title="Please select Letter type" class="form-control selectpicker">
							<option value="Planning Comments Letter">Planning Comments Letter</option>

						</select>
       			 </div>
        		 </div>
				            
				           
				            
				            <div class="form-row">
				              
				              
				             <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
									<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
										<input type="hidden" id="job_number" name="job_number" value="${job_number}" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_planning_letter">
								          <div class="form-group">
						          
						          <div class="col-md-12">
						              
						                <input type="submit" class="btn btn-primary btn-block" value="Generate Planning Comments Letter" />  
						                
						                </div>
						            </div>
						            
						        </form>
				            </div>
				            
				            
				            
				            
				            
				             
				            
				            
				          </div>
				          
				          
				          
				          
				         
				          
				          
				          
				       
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>

 </div>
                </div>
               
                
      
               
                
             <%--    <div id="link-3" class="">
                    <h3 class="border-bottom border-gray pb-2">Plotting</h3>
                       <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Plan Preparation</div>
				            <div class="card-body">
				
				
							              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				
						    
						         
						         <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Land size</label>
				                <input class="form-control" id="txt_lc_size_of_land"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${size_of_land}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Plan Number</label>
				                <input class="form-control" id="txt_lc_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Nature of Instrument" value="${plan_no}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Registration District</label>
				                <input class="form-control" id="txt_lc_registration_district_number"  name="txt_lc_registration_district_number"  type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${registration_district_number}" >
				              </div>
				             
				            </div>
				            
				              
						         <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Section Number</label>
				                <input class="form-control" id="txt_lc_registration_section_number"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${registration_section_number}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Block Number</label>
				                <input class="form-control" id="txt_lc_registration_block_number"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Nature of Instrument" value="${registration_block_number}" >
				              </div>
				              
				               <div class="col-md-4">
				                   <label for="search_value">ltr_plan_no</label>
				                <input class="form-control" id="txt_lc_ltr_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${ltr_plan_no}" >
				              
				                 
				               </div>
				             
				            </div>
				            
				                <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Registry Map No</label>
				                <input class="form-control" id="txt_lc_registry_mapref"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${registry_mapref}" >
				              </div>
				              
				               <div class="col-md-4">
				                <label for="search_value">cc_no</label>
				                <input class="form-control" id="txt_lc_cc_no"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${cc_no}" >
				              </div>
				              
				            <!--    <div class="col-md-4">
				            
				                  <button type="button" class="btn btn-primary" id="lc_btn_save_details_at_title_plan" data-placement="top" data-toggle="tooltip" title="Save">
						            <i class="fa fa-object-ungroup"></i>
						        </button>
				               </div> -->
				               
				             
				            </div>
				            
						         
						        
				        </form>
				
				            
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
				              <i class="fa fa-pie-chart"></i>Title Plan Preparation</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				       
            <!-- Maps Details Starts Here  -->
            <div class="bs-example">
            
         
            
            
            
    <div class="btn-group mr-2">
      <button type="button" class="btn btn-primary"  id="smdfrtp_lc_btn_fr_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-map"></i>
        </button>
  
       
        <button type="button" class="btn btn-primary" id="btn_print_new_title_plan" data-placement="top" data-toggle="tooltip" title="Print Plan">
            <i class="fa fa-print"></i>
        </button>
    </div>
   

    
    
  
      
    

      
    
</div>


       
            
            
            
             <div id="smdfrtp-map" ></div>
             
             
						          
				              </form>
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      

				     </div>
				     
				     
				     
                   </div> --%>
                <div id="link-3" class="">
                    <h3 class="border-bottom border-gray pb-2">Ground rent</h3>
						          
						
					             
						
						
						
						 <div class="row">
						
						
						      
						      
						      
						       <!--   Here is the right Table -->
						        <div class="col-lg-10">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Ground rent</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
		
						           
						              	
						    <div class="form-row">
				              <!-- <div class="col-md-6">
				                <label for="search_value">Estate Name</label>
				                
				             <select
									name="txt_on_case_ap_list_of_lc_estates" id="txt_on_case_ap_list_of_lc_estates"
									class="form-control input-sm" data-style="btn-info"
									data-live-search="true">
									<option value="-1">Select LC Estates</option>

								</select>
				              </div> -->
				              
				              
				               <div class="col-md-6">
				                <label for="search_value">Annual Equivalent Land Value</label>
				                <input class="form-control" id="txt_lc_land_value_annual_equivalent" placeholder="Enter  Anuual Equivalent of Land Value"  type="text" aria-describedby="nameHelp"  >
				              </div>
				              
				             <div class="col-md-2">
				                <label for="search_value">''</label>
				                  <input type="button" id="lc_btn_load_lc_estate" class="btn btn-primary btn-block" value="Calculate"  /> 
				               
				              </div> 
				               
				                <div class="col-md-2">
				                <label for="search_value">Interest Rate</label>
				                <input class="form-control" id="txt_lc_interest_rate"  name="txt_lc_interest_rate"  type="text" aria-describedby="nameHelp"  value="10.00%" >
				              </div>
				             
				              <div class="col-md-2">
				                <label for="search_value">Rent Per Acre</label>
				                <input class="form-control" id="txt_lc_rent_passing_per_acre"   type="text" aria-describedby="nameHelp" readonly >
				              </div>
				            </div>
						              
						              
						              
						              
						        <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Land size</label>
				                <input class="form-control" id="txt_lc_size_of_land"   type="text" aria-describedby="nameHelp"  value="${size_of_land}" >
				              </div>
				               
				             
				            </div>
						           
						              
						            
						            <!-- The form Ends Hers -->
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						     
						    <!--    
						         Here is the right Table
						        <div class="col-lg-4">
						          Example Pie Chart Card
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Prepare Ground rent</div>
						            <div class="card-body">
						                The Form starts here
						              
						       <div class="form-row">
				              
				 <div class="col-md-12">
				               <input type="button" id="lc_btn_assess_rent_demand_notice" class="btn btn-primary btn-block" value="Assess Ground Rent" /> 
				               <input type="button" id="lc_btn_print_rent_demand_notice" class="btn btn-primary btn-block" value="Print Rent Demand Note" /> 
				               
				                </div>
				             
				            </div>
						              
						           
						           
						              
						              
						            
						            The form Ends Hers
						            
						          </div>
						         
						        </div>
						        Here is the end of right table
						  
						      </div> -->
						      
						      
						      
						     
						
						 </div>
						 
						 
						 
						 
						<!--  <div class="col-md-12">
						      	<div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Objections List</div>
						            <div class="card-body">
								      	<table class="table table-bordered table-hover table-sm">
								      		<thead>
								      			<tr>
								      				<th>Objector </th>
								      				<th>Address</th>
								      				<th>Contact</th>
								      				<th>Date </th>
								      				<th>Action </th>
								      			</tr>
								      		</thead>
								      		<tbody>	
								      			<tr>
								      				<td>Objector </td>
								      				<td>Address</td>
								      				<td>Contact</td>
								      				<td>Date </td>
								      				<td>
								      					
								      					<button type="button" id="editOjectionModal"  data-toggle="modal" data-target="#newObjectionModal"  data-action="edit"  class="btn btn-danger btn-icon-split "  title="edit objection" >
											    			<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
											    		</button> 
											    		
											    	</td>
								      			</tr>	
								      		</tbody>
								      	</table>
								      </div>
								      </div>
						      </div> -->
               
  </div>
               
               
             
               
                               <div id="link-4" class="">
                    <h3 class="border-bottom border-gray pb-2">Consent Certificate</h3>
						          
						
					             
						
						
						
						 <div class="row">
						
						
						      
						      
						      
						       <!--   Here is the right Table -->
						        <div class="col-lg-8">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Consent Certificate Preparation</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
						    
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>

						       
						       <!--   Here is the right Table -->
						        <div class="col-lg-4">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Consent Certificate</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
						       <div class="form-row">
				              
				 				<div class="col-md-12">
				               <input type="button" id="lc_btn_preview_consent_certificate" class="btn btn-primary btn-block" value="Preview Consent Certificate" /> 
				              
				               
				                </div>
				             
				           	 </div>
						              
						           
						           
						              
						              
						            
						            <!-- The form Ends Hers -->
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						      
						     
						
						 </div>
						 
				
               
			  </div>
               
               
            
                <div id="link-5" class="">
                    <h3 class="border-bottom border-gray pb-2">Final Approval of Application</h3>
               
                      <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-8">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Final Approval of Application</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				       
            <!-- Maps Details Starts Here  -->
            <div class="bs-example">
            
         
            
            
            
    <div class="btn-group mr-2">
      <button type="button" class="btn btn-primary"  id="lcfrfa_lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-map"></i>
        </button>
       <!--  
          <button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
            <i class="fa fa-save"></i>
        </button>
        -->
       
         <button type="button" class="btn btn-primary" id="lcfrfa_lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
            <i class="fa fa-object-ungroup"></i>
        </button>
        
       
        <button type="button" class="btn btn-primary" id="lcfrfa_lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-print"></i>
        </button>
    </div>
   

    
    
   
    
    

     
      
    
</div>


       
            
            
            
             <div id="lcfrfa-map" ></div>
             
             
						          
				              </form>
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
				       <div class="col-lg-4">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Final Records Information</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				
						          <div class="form-group">
				            
				            
     
				            
				            <div class="form-row">
				              
				              <div class="col-md-12">
				              
				                <input type="button" id="lc_btn_activate_final_registration" class="btn btn-primary btn-block" value="Consent Actiavtion" />  
				                
				                </div>
				            </div>
				            
				      <!--       <div class="form-row">
				              <div class="col-md-12">
				               <label for="job_number">Activation Code</label>
				                <input class="form-control" id="lc_txt_certificate_number"  name="file_number"  type="text" aria-describedby="nameHelp"   placeholder="Enter Activation Code">
				               </div>
				            </div>
				          
				          <div class="form-row">
				              
				              <div class="col-md-12">
				              
				                <input type="button" id="lc_btn_activate_final_registration_confirm" class="btn btn-primary btn-block" value="Confirm Activation" />  
				                
				                </div>
				            </div> -->
				            
				            
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
							
          
            
          
       
        <jsp:include page="../client_application/_application_process_footer.jsp"></jsp:include>
     
