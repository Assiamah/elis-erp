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
				<i class="fas fa-stamp"></i>Application for Lease Preparation and Regularisation - ${case_number} </h4>
				<form action="${pageContext.request.contextPath}/case_movement_module" >
				<!-- <input type="submit" class="btn btn-primary btn-block" value="Back to File Movement" /> -->
				<button type="submit" name="save" class="btn btn-primary btn-icon-split float-right" >
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
		        <div id="collapsemaincase" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		<!--   <button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  data-toggle="tooltip" title="Load Docs">
					            <i class="fa fa-plus-circle"></i>
					        </button> -->
					        
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
				                <input  readonly class="form-control"   type="text" aria-describedby="nameHelp" placeholder="Enter Case Number" value="${locality}" >
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
				                <label for="search_value">Size of Land</label>
				                <input  readonly class="form-control"  type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${size_of_land}" >
				              </div>
				             
				            </div>
				            
				              <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Date of Document</label>
				                <input  readonly class="form-control  date-picker" type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${date_of_document}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Nature of Instrument</label>
				                <input  readonly class="form-control"  type="text" aria-describedby="nameHelp" placeholder="Enter Nature of Instrument" value="${nature_of_instrument}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Type of Interest</label>
				                <input  readonly class="form-control"   type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${type_of_interest}" >
				              </div>
				             
				            </div>
				            
				            
				             <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Type of Use</label>
				                <input readonly  class="form-control"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${type_of_use}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">Term</label>
				                <input readonly class="form-control"  type="text" aria-describedby="nameHelp" placeholder="Enter Nature of Instrument" value="${term}" >
				              </div>
				                <div class="col-md-4">
				                <label for="search_value">commencement_date</label>
				                <input readonly class="form-control  date-picker"  type="text" aria-describedby="nameHelp" placeholder="Enter Consideration" value="${commencement_date}" >
				              </div>
				             
				            </div>
				            
				           
				             
				            
				            <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Date of Registration</label>
								  <input readonly type="date" name="bday" max="3000-12-31" min="1000-01-01" data-date-format="dd/mm/yyyy" class="date form-control   date-picker" required>
        													
				                </div>
				                <div class="col-md-4">
				                <label for="search_value">Job Number</label>
								   <input readonly class="form-control" id="cs_main_job_number"  name="cs_main_job_number"  type="text" aria-describedby="nameHelp" placeholder="Enter Case Number" value="${job_number}" >
        													
				                </div>
				                
				                
				                 <div class="col-md-4">
				                <label for="search_value">Applicant Name</label>
								   <input readonly class="form-control" id="cs_main_ar_name"  name="cs_main_ar_name"  type="text" aria-describedby="nameHelp"  value="${ar_name}" >
        													
				                </div>
				                
				                
				                
				                
				                
				               
				             
				            </div>
				             
				           
				            
				          </div>
				          
					        
		                
		            </div>
		        </div>
		    </div>
      
				  
				     


 <br>   






          
					          
					      
							   <!-- wizard start wizard end -->
		

        <!-- smartwizardfirstregistration html -->
        <div id="smartwizardfirstregistration">
            <ul class="d-none">
               
                <li><a href="#link-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li>
                <li><a href="#link-2">Plan Preparation<br /><small>Update As Undergoing Registration</small></a></li>
                <li><a href="#link-3">Record Veriification<br /><small>Record Veriification</small></a></li>
                <li><a href="#link-4">Offer Preparation<br /><small>Offer Preparation</small></a></li>
                <li><a href="#link-5">Plotting<br /><small>Plotting</small></a></li>
                <li><a href="#link-6">Ground rent<br /><small>Ground rent</small></a></li>
                <li><a href="#link-7">Activte Parcel<br /><small>Activting Parcel</small></a></li>
                <li><a href="#link-8">Completing<br /><small>Completing</small></a></li>
                <li><a href="#link-9">Collection Process<br /><small>Collection Process</small></a></li>
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
                    <h3 class="border-bottom border-gray pb-2">Plan Preparation</h3>
                    
            				             
                      <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-8">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Plan Preparation</div>
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
            
            
      
                <div id="link-3" class="">
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
                
                <div id="link-4" class="">
                    <h3 class="border-bottom border-gray pb-2">Offer Preparation</h3>
                   <div class="row">

 
      
      
				      
				       <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-10">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i> Offer Preparation</div>
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
							<option value="Existing GARRO Layer">Offer Letter</option>
							<!-- <option value="Existing CRO Layer">Discussion Letter</option>
							<option value="Existing CRO Layer">Inspection Report Template</option>
						 -->
							
						</select>
        </div>
         </div>
				            
				           
				            
				            <div class="form-row">
				              
				              
				             <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
										<input type="hidden" id="case_number" name="case_number" value="${case_number}" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_offer_letter">
								          <div class="form-group">
						          
						          <div class="col-md-12">
						              
						                <input type="submit" class="btn btn-primary btn-block" value="Generate Offer Letter" />  
						                
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
               
                
                <div id="link-5" class="">
                    <h3 class="border-bottom border-gray pb-2">Plotting</h3>
                       <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Plotting</div>
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
                <div id="link-6" class="">
                    <h3 class="border-bottom border-gray pb-2">Ground rent</h3>
						          
						 <div class="row">
						
						
						      
						      
						      
						       <!--   Here is the right Table -->
						        <div class="col-lg-8">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Ground rent</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
						              
						             
						              
						       <div class="form-row">
				              
				                               <h5 class="border-bottom border-gray pb-2">Ground Rent Preparation</h5>
                 
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_proprietorship_details_dataTable" >
			           
			              <thead>
			                <tr>
			
				               <th>Date of Payment</th>
			                     <th>Period of Payment</th>
			                     <th>Amount Paid</th>
			                     <th>Receipt Number</th>
			                     <th>Arrears</th>
			                     <th>Remarks</th>
			                  </tr>
			              </thead>
			              
			                <tbody>
							   <%--   <c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
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
				            	</c:forEach> --%>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
				               
				             
				            </div>
						              
						           
						           
						              
						              
						            
						            <!-- The form Ends Hers -->
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						     
						       
						       <!--   Here is the right Table -->
						        <div class="col-lg-4">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Prepare Ground rent</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
						       <div class="form-row">
				              
				 <div class="col-md-12">
				               <input type="button" id="lc_btn_assess_rent_demand_notice" class="btn btn-primary btn-block" value="Assess Ground Rent" /> 
				               <input type="button" id="lc_btn_print_rent_demand_notice" class="btn btn-primary btn-block" value="Print Rent Demand Note" /> 
				               
				                </div>
				             
				            </div>
						              
						           
						           
						              
						              
						            
						            <!-- The form Ends Hers -->
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						      
						     
						
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
               
               
             
               
               
               
               
            
                <div id="link-7" class="">
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
                <div id="link-8" class="">
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
                <div id="link-9" class="">
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
            <div class="card-footer small text-muted">Registration Process Movement

	            
				 <button class="btn btn-success btn-icon-split float-right "  id="btnViewBatchlist">
					<span class="icon text-white-50"> <i class="fas fa-eye"></i></span><span class="text">View Batch List</span>
				</button>
				<button class="btn btn-secondary btn-icon-split float-right "  id="btnAddToBatchlist">
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
                    	
                    	
                    	
		                <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm " id="lrd_scanned_documents_dataTable" >
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
		                
		                 
					         <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addeditparty" data-toggle="tooltip" title="Draw a Line">
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
		                
		                 <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-placement="top" data-toggle="modal" data-target="#addMinutesModal" data-toggle="tooltip" title="Draw a Line">
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
		               
		               
			         		  <button type="button" class="btn btn-primary" id="btn_load_scanned_documents" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
					        
					         <button type="button" class="btn btn-primary" id="lrd_btn_add_coordinate" data-toggle="modal" data-target="#fileUploadModal" title="Add Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button>
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable" width="100%" cellspacing="0">
				           
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
		        </div>
		    </div>
		    <br>
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsecomments" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-comment-dots"></i>Comments Or Tracking Information
		            </a>
		        </h5>
		        <div id="collapsecomments" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		                 <div class="card-header">
				              <i class="fa fa-pie-chart"></i> Comments Or Tracking Information</div>
				            <div class="card-body">
				         
		                
		                 
		                
		                
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable" >
				           
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
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Bill and  Payments
		            </a>
		        </h5>
		        <div id="collapsebills" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		              
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable">
				           
				              <thead>
				                <tr>
				
				                 <th>Bill No</th>
				                 <th>Amount</th>
				                 <th>Receipt Number</th>
				                 <th>Payment Date</th>
				                 <th>Division</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							     <c:forEach items="${payment_bill}" var="payment_bill_row">
					                <tr>
					                    <td>${payment_bill_row.bill_number}</td>
					                    <td>${payment_bill_row.bill_amount}</td>
					                    <td>${payment_bill_row.payment_slip_number}</td>
					                    <td>${payment_bill_row.payment_date}</td>
					                    <td>${payment_bill_row.division}</td>
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
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Encumbrances
		            </a>
		        </h5>
		        <div id="collapseencumbrance" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		              
		                <button type="button" class="btn btn-primary" id="lrd_btn_add_encumbrance" data-placement="top" data-toggle="modal" data-target="#newEncumberancesModal" data-toggle="tooltip" title="Draw a Line">
					            <i class="fa fa-plus-circle"></i>
					        </button>
					        
					     <!--    <a href="#myModal" class="btn btn-lg btn-primary" data-toggle="modal">Launch Demo Modal</a> -->
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_registration_encumbrance_dataTable">
				           
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
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-money-bill-alt"></i>Objections
		            </a>
		        </h5>
		        <div id="collapseobjections" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		               <button type="button" class="btn btn-primary" id="lrd_btn_add_objections" data-placement="top" data-toggle="modal" data-target="#newObjectionModal" data-toggle="tooltip" title="Draw a Line">
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
										      					<button type="button" id="editOjectionModal"  data-toggle="modal" data-target="#newObjectionModal"  data-action="edit"  class="btn btn-danger btn-icon-split "  title="edit objection" >
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
		              
		               <button type="button" class="btn btn-primary" id="lrd_btn_add_querys" data-placement="top" data-toggle="modal" data-target="#newQueryModal" data-toggle="tooltip" title="Draw a Line">
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
										      					<button type="button" id="editOjectionModal"  data-toggle="modal" data-target="#newObjectionModal"  data-action="edit"  class="btn btn-danger btn-icon-split "  title="edit objection" >
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
  

 
 
 
 
 
 
 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
