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
               
                <!-- <li><a href="#link-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li>
                 <li><a href="#link-2">Generate File Number<br /><small>Generate File Number</small></a></li> -->
                <li><a href="#link-1">Coordinate Entry<br /><small>Coordinate Entry</small></a></li>
                <li><a href="#link-2">Record Verification<br /><small>Record Verification</small></a></li>
                 <li><a href="#link-3">Vetting and Approval<br /><small>Vetting and Approval</small></a></li>
                <li><a href="#link-4">Ground Rent<br /><small>Ground Rent</small></a></li>
                 <li><a href="#link-5">Preparation of Certificate<br /><small>Preparation of Certificate</small></a></li>
                <li><a href="#link-6">Final Approval<br /><small>Final Approval</small></a></li>
             
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

                 </div>  --%>    
                    <div id="link-1" class="">
                    <h3 class="border-bottom border-gray pb-2">Coordinate Entry</h3>
                    
            				             
                      <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-8">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Coordinate Entry</div>
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
					            <i class="fa fa-print"></i>
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
            
            
      
                <div id="link-2" class="">
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
                
                
                
                               	<div id="link-3" class="">
			<br>
			<h3 class="border-bottom border-gray pb-2">Vetting and Approval</h3>

			<div class="row">
				<!--   Here is the right Table -->
				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Verify Site (If Inspection is
							needed)
						</div>
						<div class="card-body">
							<!--  The Form starts here -->
							<form
								action="${pageContext.request.contextPath}/processing_after_payment"
								method="post"
							>

								<!-- Maps Details Starts Here  -->
								<div class="bs-example">





									<div class="btn-group mr-2">
										<button type="button" class="btn btn-primary"
											id="btn_lcfrfa_lc_btn_visualise_wkt" data-placement="top"
											data-toggle="tooltip" title="Visualise Polygon"
										>
											<i class="fa fa-map"></i>
										</button>
										<!--  
          <button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
            <i class="fa fa-save"></i>
        </button>
        -->

										<button type="button" class="btn btn-primary"
											id="btn_lcfrfa_lc_btn_visualise_search" data-placement="top"
											data-toggle="tooltip" title="Visualise Search"
											style="display: none"
										>
											<i class="fa fa-object-ungroup"></i>
										</button>


										<button type="button" class="btn btn-primary"
											id="btn_lcfrfa_lc_btnprintmap" data-placement="top"
											data-toggle="tooltip" title="Visualise Polygon"
											style="display: none"
										>
											<i class="fa fa-print"></i>
										</button>
									</div>











								</div>






								<div id="lcfrfa-map"></div>



							</form>

							<!-- The form Ends Hers -->

						</div>

					</div>
					<!--   Here is the end of right table -->

				</div>

				<div class="col-lg-8">
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


								<div class="form-row" style="display: none;">

									<div class="col-md-12">

										<label for="bl_job_purpose">WKT Polygon</label>


									</div>
								</div>
								<input class="form-control" id="lc_fr_bl_wkt_polygon"
									name="lc_fr_bl_wkt_polygon" type="hidden"
									aria-describedby="nameHelp" placeholder="Enter Consideration"
									value="${parcel_wkt}"
								>

								<!--   <div class="form-row">
				              
				              <div class="col-md-12">
				              
				                <input type="button" id="lc_btn_activate_final_registration_confirm" class="btn btn-primary btn-block" value="Request Surveyor's Signature" />  
				                
				                </div>
				            </div>
				             -->

								<div class="form-row">

									<div class="col-md-12">

										<form
											action="${pageContext.request.contextPath}/GenerateCaseReports"
											method="post" target="_blank"
										>
											<input type="hidden" id="case_number" name="case_number"
												value="${transaction_number}"
											> 
											<input type="hidden" id="job_number" name="job_number"
												value="${job_number}"
											> <input type="hidden" id="ir_business_process_id"
												value="${business_process_id}"
											> <input type="hidden" id="ir_business_process_name"
												value="${business_process_name}"
											> <input type="hidden" id="ir_business_process_sub_id"
												value="${business_process_sub_id}"
											> <input type="hidden" id="ir_business_process_sub_name"
												value="${business_process_sub_name}"
											> <input type="hidden" id="request_type" name="request_type"
												value="request_to_generate_inspection_letter"
											>
											<div class="form-group">
												<div class="form-row">
													<div class="col-md-12">
														<label for="bl_job_purpose">Select Type of Letter</label>
													</div>

													<div class="col-md-8">

														<select name="lc_letter_type" id="lc_letter_type"
															data-live-search="true"
															data-none-results-text="I found no results"
															title="Please select Letter type"
															class="form-control  selectpicker"
														>
															<option value="Inspection Lette">Inspection
																Letter</option>
															<!-- <option value="Discussion Letter">Discussion
																Letter</option> -->
														</select>
													</div>

													<div class="col-md-4">
														<button type="submit" name="save"
															class="btn btn-info btn-icon-split"
														>
															<span class="icon text-white-50"> <i
																class="fas file-alt"
															></i></span><span class="text">Generate</span>
														</button>
													</div>


												</div>


											</div>

										</form>

									</div>
								</div>




							</div>
							<!-- </form> -->

							<!-- The form Ends Hers -->

						</div>

					</div>
					<!--   Here is the end of right table -->

				</div>
				<div class="col-sm-4">
					<div class="card mb-3">
						<div class="card-header">
							<i class="fas fa-file-o"></i> &nbsp;

						</div>
						<div class="card-body">
							<br>
							<button type="button"
								class="btn btn-primary btn-icon-split float-right"
								id="lrd_btn_add_querys" data-placement="top" data-toggle="modal"
								data-target="#assignInspectionModal"
							>
								<span class="icon text-white-50"> <i
									class="fa fa-plus-circle"
								></i></span><span class="text">Assign For Inspection</span>
							</button>
							<br>
							<br> &nbsp;
						</div>
					</div>
				</div>
			</div>



			<div class="row">
				<!--   Here is the right Table -->


				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fas fa-file-o"></i>Inspection Reports

						</div>
						<div class="card-body">
							<!--  The Form starts here -->
							<div id="alert-display-space"></div>


							<table class="table">
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

							<%--  <form action=""  method="post" id="form_inspection">
										<input type="hidden" id="case_number" name="case_number" value="${case_number}" >
										<input type="hidden" id="job_number" name="job_number" value="${job_number}">
										<input type="hidden" id="fullname" name="case_number" value="${fullname}" >
										<input type="hidden" id="userid" name="job_number" value="${userid}">	
										
										<div class="form-group">
									        <div class="form-row">  <label for="report_title">Report Title</label>
									        	<input class="form-control" placeholder="" id="report_title" name="report_title" required>
									        </div>
								        </div>
										<div class="form-group">
									        <div class="form-row">  <label for="inspection_report">Inspection Report Description</label>
									        	<textarea required rows="7" class="form-control" placeholder="" id="inspection_report" name="inspection_report"></textarea>
									        </div>
								        </div>
										
								        <div class="form-group">
							          		<div class="col-md-4 float-right">
							          			<button type="submit" name="save" class="btn btn-info btn-icon-split" id="btninsert_report_details" >
					                   				<span class="icon text-white-50"> <i class="fas fa-check"></i></span><span class="text">Save</span>
					                   			</button>
							                </div>
							            </div>
						            
						        </form> --%>

						</div>
					</div>
				</div>
			</div>
		</div>

      
               
                
               
                <div id="link-4" class="">
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
						      
						      
						     
						       
						 
						        <!-- <div class="col-lg-4">
						     
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Prepare Ground rent</div>
						            <div class="card-body">
						            
						              
						       <div class="form-row">
				              
				 <div class="col-md-12">
				           
				               <input type="button" id="lc_btn_print_rent_demand_notice" class="btn btn-primary btn-block" value="Print Rent Demand Note" /> 
				               
				                </div>
				             
				            </div>
		
						          </div>
						         
						        </div>

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
               
               
             
               
                               <div id="link-5" class="">
                    <h3 class="border-bottom border-gray pb-2">Preparation of Certificate</h3>
						          
						
					             
						
						
						
						 <div class="row">
						
						
						      
						      
						      
						       <!--   Here is the right Table -->
						        <div class="col-lg-8">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Preparation of Certificate</div>
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
						              <i class="fa fa-pie-chart"></i>Concurrence Certificate</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
						       <div class="form-row">
				              
				 				<div class="col-md-12">
				               <input type="button" id="lc_btn_preview_concurrence_certificate" class="btn btn-primary btn-block" value="Preview Concurrence Certificate" /> 
				              
				               
				                </div>
				             
				           	 </div>
						              
						           
						           
						              
						              
						            
						            <!-- The form Ends Hers -->
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						      
						     
						
						 </div>
						 
				
               
			  </div>
               
               
            
                <div id="step-8" class="">
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
				              
				                <input type="button" id="lc_btn_activate_final_registration" class="btn btn-primary btn-block" value="Confirm Transaction" />  
				                
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
     
