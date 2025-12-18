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
 
					          
					      
							   <!-- wizard start wizard end -->
		

        <!-- smartwizardfirstregistration html -->
        <div id="smartwizardfirstregistration">
            <ul class="d-none">
               
                <li><a href="#link-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li>
                <li><a href="#link-2">Generate File Number<br /><small>Generate File Number</small></a></li>
                <li><a href="#link-3">Add Parcel to Case<br /><small>Add Parcel to Case</small></a></li>
                <li><a href="#link-4">Record Veriification<br /><small>Record Veriification</small></a></li>
                <li><a href="#link-5">Approval/Vetting<br /><small>Approval/Vetting</small></a></li>
                <li><a href="#link-6">Plan Preparation<br /><small>Plan Preparation</small></a></li>

                <li><a href="#link-7">Final Vetting/Approval<br /><small>Final Vetting/Approval</small></a></li>
                <li><a href="#link-8">Rent Position/Assessment/Consent Fees<br /><small>Rent Position/Assessment/Consent Fees</small></a></li>
                <li><a href="#link-9">Preparation of Consent Certificate<br /><small>Preparation of Consent Certificate</small></a></li>
                <li><a href="#link-10">Activte Parcel<br /><small>Activting Parcel</small></a></li>
               
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
                    
                     <div id="link-2" class="">
                    <h3 class="border-bottom border-gray pb-2">Generate File Number</h3>
      				         <!--   Here is the right Table -->
				        <div class="col-lg-8">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Generate File Number</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
						          <div class="form-group">
				            <div class="form-row">
				              <div class="col-md-6">
				                <label for="job_number">File Number</label>
				                <input class="form-control" id="case_file_number"  name="case_file_number"  type="text" aria-describedby="nameHelp"  value="${case_file_number}" required >
				              </div>
				              <div class="col-md-6">
				              <label for="search_btn">-</label>
				                <button type="button" class="btn btn-info" id="btn_generate_case_file_number" data-placement="top"  data-toggle="tooltip" title="Draw a Line">
					            <i class="fa fa-plus-circle"></i>
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
                 
                    <div id="link-3" class="">
                    <h3 class="border-bottom border-gray pb-2">Plot Parcel</h3>
                    
            				             
                      <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-8">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Add Parcel to undergoing  Registration Layer</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				           
				             
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				       



       
            
            
            
             <div id="lrdfp-map" ></div>
             
             
						          
				              </form>
				            
				            <!-- The form Ends Hers -->
				            
           
					                <div class="btn-group mr-2">
								      <button type="button" class="btn btn-primary" id="lc_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addcoordinatetoplot" data-toggle="tooltip" title="Add Coordinate">
						            <i class="fa fa-plus-circle"></i>
						        </button>
						        
						          <button type="button" class="btn btn-primary"  id="lrd_btn_add_coordinate_by_csv" data-placement="top" data-toggle="modal" data-target="#uploadcoordiantecsv" data-toggle="tooltip" title="Upload CSV">
						            <i class="fa fa-upload"></i>
						        </button>
											        
								   <button type="button" class="btn btn-primary"  id="lc_btn_fr_visualise_coordinate" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
						            <i class="fa fa-eye"></i>
						        </button>
						        
						        <button type="button" class="btn btn-primary" id="btn_lc_save_parcel_undergoing_registration" data-placement="top" data-toggle="tooltip" title="Save wkt">
					            <i class="fa fa-save"></i>
					        </button>
											        
							</div> 
						             <div  class="table w-auto small">
						           <table class="table table-bordered" id="coordinatelis_Table" width="100%" cellspacing="0">
						           
						              <thead>
						                <tr>
						                 
						                 
						                 
						                 <th>name</th>
						                 <th>x_coordinate</th>
						                 <th>y_coordinate</th>
						                 <th>Remove</th>
						                  </tr>
						              </thead>
						              
						                <tbody>
						    
						  </tbody>
						             <!--  <tfoot>
						                <tr>
						                  <th>Job Number</th>
						                  <th>Applicant Name</th>
						                  <th>Status</th>
						                  <th>Case Details</th>
						                      
						                       <th>Add To List</th>
						                </tr>
						              </tfoot> -->
						            
						            </table>
						          </div>
										      
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				      
				       <div class="col-lg-4">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Records Information</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              
				      
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				
						          <div class="form-group">
				            
				            
				                 <!--  Here is where the fee list comes -->
          
				            
				            
				        <!--     <div class="form-group">
							       
							        <div class="form-row">  <label for="bl_job_purpose">Job Number(Plan Approval)</label>
							        <input class="form-control" id="txt_glpin"  name="txt_cs_main_plan_approval_job_number"  type="text" aria-describedby="nameHelp"  >
							              
							        </div>
							        <button type="button" class="btn btn-info" id="btn_search_with_plan_approval_job_number" data-placement="top"  data-toggle="tooltip" title="Draw a Line">
					            <i class="fa fa-plus-circle"></i>
					        </button>
							         </div> -->
					         
									            
					     <!--  WKT row here -->
					        <div class="form-group">
					       
					        <div class="form-row">  <label for="bl_job_purpose">WKT Polygon</label>
					         
					         <input class="form-control" id="lc_fr_bl_wkt_polygon"  name="lc_fr_bl_wkt_polygon"  type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${parcel_wkt}" >
				             
					        </div>
					         </div>
					         
					         
					         
				                <%--   <div class="form-group">
							       
							        <div class="form-row">  <label for="bl_job_purpose">GLPIN</label>
							        <input class="form-control" id="txt_glpin"  name="txt_glpin"  type="text" aria-describedby="nameHelp"  value="${glpin}">
							              
							        </div>
							         </div>
					          --%>
					        
				            
				           
				          </div>
				        </form>
				            
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>
				     </div>
			          
                    </div>
            
            
      
                <div id="link-4" class="">
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
       Layers:
    </div>
   
   <div class="btn-group">

						<select name="lc_layer_type" id="lc_layer_type" data-live-search="true" data-none-results-text="I found no results" title="Please select fruit" class="form-control selectpicker">
							<option value="Existing GARRO Layer">Existing GARRO Layer</option>
							<option value="Existing CRO Layer">Existing CRO Layer</option>
							<option value="PVLMD Current Layer">PVLMD Current Layer</option>
							<option value="LRD Layer">LRD Layer</option>
							<option value="SMD Parcel Layer">SMD Parcel Layer</option>
							<option value="SMD Cadastral Layer">SMD Cadastral Layer</option>
							
						</select>
      		 
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
                
                <div id="link-5" class="">
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
         
           <div class="form-group">
       
        <div class="form-row">  <label for="bl_job_purpose">Type of Letter</label>
       <select name="lc_letter_type" id="lc_letter_type" data-live-search="true" data-none-results-text="I found no results" title="Please select Letter type" class="form-control selectpicker">
							<option value="Existing GARRO Layer">Inspection Letter</option>
							<option value="Existing CRO Layer">Discussion Letter</option>
							<option value="Existing CRO Layer">Inspection Report Template</option>
						
							
						</select>
        </div>
         </div>
				            
				           
				            
				            <div class="form-row">
				              
				              
				             <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
										<input type="hidden" id="case_number" name="case_number" value="${case_number}" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_inspection_letter">
								          <div class="form-group">
						          
						          <div class="col-md-12">
						              
						                <input type="submit" class="btn btn-primary btn-block" value="Generate Letter" />  
						                
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
               
                
                <div id="link-6" class="">
                    <h3 class="border-bottom border-gray pb-2">Title Plan</h3>
                       <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Title Plan Update</div>
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
  
       
        <button type="button" class="btn btn-primary" id="smdfrtp_lc_btn_fr_printmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
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
				     
				     
				     
                   </div>

             
               
                <div id="link-7" class="">
                    <h3 class="border-bottom border-gray pb-2">Final Approval After Publication</h3>
               
               
                   	 <div class="row">
						
						 <!--   Here is the right Table -->
						        <div class="col-lg-12">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Objection Status And Management</div>
						            <div class="card-body">
						            
							            <!-- <table class="table table-bordered table-hover table-sm">
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
									      					
									      					<button type="button" data-toggle="modal" id="btn_objection_modal" data-target="#newObjectionModal" data-action="edit"  class="btn  btn-danger btn-icon-split "  title="edit objection" >
												    			<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
												    		</button> 
												    		
												    	</td>
									      			</tr>	
									      		</tbody>
									      	</table> -->
						            
						            
						            
						            
						               <!--  The Form starts here -->
						              <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
										<input type="hidden" id="case_number" name="case_number" value="LCGARGAPCN716053920190" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_inspection_letter">
								          <!-- <div class="form-group">
								            <div class="form-row">
								              <div class="col-md-10">
								                <input type="submit" class="btn btn-primary btn-block" value="Objection Letter" />  
								              </div>
								            </div>
								          </div> -->
								        </form>
						            <!-- The form Ends Hers -->
						          </div>
						        </div>
						      <!--   Here is the end of right table -->
						      </div>
						
						 </div>
        
				        
				        
				        
				     
                
                 
               
                   </div>
               
               
                  <div id="link-8" class="">
                 <h3 class="border-bottom border-gray pb-2">Root of Title</h3>
                
                
                
                  <h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
                    <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
			            <i class="fa fa-plus-circle"></i>
			        </button>
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_proprietorship_details_dataTable" >
			           
			              <thead>
			                <tr>
			
				                 <th>registration_number</th>
				                 <th>proprietor</th>
				                 <th>date_of_instrument</th>
				                 <th>nature_of_instrument</th>
			                    <th>Action</th>
			                  </tr>
			              </thead>
			              
			                <tbody>
							     <c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
				               		 <tr>
				                    <td>${proprietorship_section.ps_registration_number}</td>
				                    <td>${proprietorship_section.ps_proprietor}</td>
				                    <td>${proprietorship_section.ps_date_of_instrument}</td>
				                    <td>${proprietorship_section.ps_nature_of_instrument}</td>
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
			          
                
			          
                
                
					 </div>
                
               
               
               
               
                <div id="link-9" class="">
                    <h3 class="border-bottom border-gray pb-2">Prepare Certificate and Register</h3>
                  
                            
          
 <div class="row">
 
     <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Generate Certificate, Volume and Folio</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				               
				                <div class="form-row">
				              <div class="col-md-4">
				               <label for="job_number">Certificate Number</label>
				                <input class="form-control" id="lc_txt_certificate_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${certificate_number}" >
				               </div>
				                <div class="col-md-4">
				               <label for="job_number">Volume</label>
				                <input class="form-control" id="lc_txt_volume_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${volume_number}" >
				              </div>
				              
				               <div class="col-md-4">
				                   <label for="job_number">Folio</label>
				                <input class="form-control" id="lc_txt_folio_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${folio_number}" >
				             
				                 
				               </div>
				             
				            </div>
				          
				                 <div class="form-row">
				              <div class="col-md-4">
				                   <input type="button" id="lc_btn_generate_certificate_volume_folio" class="btn btn-primary btn-block" value="Generate Cert/Volume/Folio" />  
				                </div>
				                <div class="col-md-4">
								   <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
								<input type="hidden" id="case_number" name="case_number" value="${case_number}" >
								<input type="hidden" id="cert_type" name="cert_type" value="LEASEHOLD" >
								<input type="hidden" id="registration_district_number" name="registration_district_number" value="${registration_district_number}" >
								<input type="hidden" id="registration_section_number" name="registration_section_number" value="${registration_section_number}" >
								<input type="hidden" id="request_type" name="request_type" value="request_to_generate_certificate">
						          <div class="form-group">
				           
				             
				            
				             
				                <input type="submit" class="btn btn-primary btn-block" value="Generate Certificate" />  
				                
				           
				          </div>
				        </form>
				              </div>
				              
				               <div class="col-md-4">
				                
				                 <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
										<input type="hidden" id="case_number" name="case_number" value="${case_number}" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_register">
								          <div class="form-group">
						           
						            
						              
						                <input type="submit" class="btn btn-primary btn-block" value="Generate Register" />  
						           
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
                <div id="link-10" class="">
                    <h3 class="border-bottom border-gray pb-2">Final Approval of Title</h3>
               
                      <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-8">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Final Approval of Title</div>
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
				              <i class="fa fa-pie-chart"></i>Records Information</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				
						          <div class="form-group">
				            
				            
     
				            
				            <div class="form-row">
				              
				              <div class="col-md-12">
				              
				                <input type="button" id="lc_btn_activate_final_registration" class="btn btn-primary btn-block" value="Title Actiavtion" />  
				                
				                </div>
				            </div>
				            
				            <div class="form-row">
				              <div class="col-md-12">
				               <label for="job_number">Activation Code</label>
				                <input class="form-control" id="lc_txt_certificate_number"  name="file_number"  type="text" aria-describedby="nameHelp"   placeholder="Enter ACtivation Code">
				               </div>
				            </div>
				          
				          <div class="form-row">
				              
				              <div class="col-md-12">
				              
				                <input type="button" id="lc_btn_activate_final_registration_confirm" class="btn btn-primary btn-block" value="Confirm Activation" />  
				                
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
							
          
             <jsp:include page="../client_application/_application_process_footer.jsp"></jsp:include>
  
  
