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
               
               <!--  <li><a href="#link-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li> -->
                <!--  <li><a href="#link-1">Generate File Number<br /><small>Generate File Number</small></a></li> -->
                <li><a href="#link-1">Coordinate Entry and Record Verification<br /><small>Coordinate Entry and Record Verification</small></a></li>
             <!--    <li><a href="#link-2">Record Verification<br /><small>Record Verification</small></a></li> -->
                 <li><a href="#link-2">Vetting and Approval<br /><small>Vetting and Approval</small></a></li>
               
              <!--   <li><a href="#link-3">Plan Preparation and Plotting<br /><small>Plan Preparation and Plotting</small></a></li> -->
                <li><a href="#link-3">Check Ground Rent Payment<br /><small>Check Ground Rent Payment</small></a></li>
                 <li><a href="#link-4">Preparation of Certificate<br /><small>Preparation of Certificate</small></a></li>
                 <li><a href="#link-5">Assessment and Payment of Consent Fees<br /><small>Assessment and Payment of Consent Fees</small></a></li>
                <li><a href="#link-6">Final Approval<br /><small>Final Approval</small></a></li>
             
            </ul>

            <div>
            
             
             <%--    <div id="link-1" class="">
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
		 
                     
               	
                    </div> --%>
                    <%-- 
                                 <div id="link-1" class="">
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

                 </div> --%>     
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
							               <!--  The Form starts here -->
							              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
							       
			            <!-- Maps Details Starts Here  -->
			            <div class="bs-example">
			            
			         
			            
			            
			            
			  
					                <div class="btn-group mr-2">
								    
        
		
		   <button type="button" class="btn btn-primary"  id="lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-map"></i>
        </button>
       <!--  
          <button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
            <i class="fa fa-save"></i>
        </button>
        -->
       
         <button type="button" class="btn btn-primary" id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
            <i class="fa fa-object-ungroup"></i>
        </button>
        
        
        
       
        <button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-print"></i>
        </button>
		 
		  
      <div class="btn-group">
       Scale:
    </div>
    <div class="btn-group">
        <input class="form-control" id="lc_scale_value_e"  name="lc_scale_value_e" type="text" class="autocomplat" />
   
       
       <select name="lc_scale_value" id="lc_scale_value">
  <option value="500">500</option>
  <option value="1107">1107</option>
  <option value="1250">1250</option>
  <option value="2500">2500</option>
  <option value="2140">2140</option>
  <option value="2670">2670</option>
  <option value="2215">2215</option>
  <option value="2825">2825</option>
  <option value="5000">5000</option>
  <option value="10000">10000</option>
  <option value="15000">15000</option>
  <option value="20000">20000</option>
 
</select>
       

		<!-- <datalist id="scalelist">
		  <option>500</option>
		  <option>1107</option>
		  <option>1250</option>
		  <option>2500</option>
		   <option>2140</option>
		  <option>2670</option>
		  <option>2215</option>
		  <option>2825</option>
		   <option>5000</option>
		  <option>10000</option>
		  <option>15000</option>
		  <option>20000</option>
		</datalist> -->
    </div>
    
   <div class="btn-group mr-2">
         <input type="checkbox" checked="checked" id="lc_lockmapscale">
          <button type="button" class="btn btn-primary" id="lc_btn_scale_zoom" data-placement="top" data-toggle="tooltip" title="Zoom to Scale">
            <i class="fa fa-search"></i>
        </button>
    </div>
   
        
		 
				   </div> 
			    
			    
			
			   
			  
			    
			    
			
			</div>
			
			
			       
			            
			            
			            
			             <div id="lc-map" ></div>
			             
			                 <!--  Here is where the fee list comes -->
             
           
									          
							              </form>
							            
							            <!-- The form Ends Hers -->
							            
							          </div>
							          
							          
							             <!--  Scanned Maps -->
          
          
                      <!--  Zoom to cooedinate -->
         <div class="row">
					                                                        
            <div class="col-md-4">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="lc_x_coordinate" placeholder="X-Coordinate" id="lc_x_coordinate"> 
                </div>
            </div>
            
            
            <div class="col-md-4">
                <div class="form-group">
                  
                    <input class="form-control" type="text" name="lc_y_coordinate" placeholder="Y-Coordinate"  id="lc_y_coordinate"> 
                  
            
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_show_location" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-map-marker"></i> </button>
            
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_load_for_scanned_maps_by_point" data-placement="top" data-toggle="tooltip" title="Search Scanned Map"><i class="fa fa-check-circle"></i> </button>
            
                </div>
            </div>

        </div>
        
          
            <div class="row">
					                                                        
            <div class="col-md-8">
                <div class="form-group">
                  
                       		 
			
              <select name="geoserverscannedimages_list" id="geoserverscannedimages_list" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
              <option value="-1">No Scanned Image</option>
              </select> 
                </div>
            </div>

            <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_search_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="search_for_scanned_maps"><i class="fa fa-search"></i> </button>
            
                </div>
            </div>
             <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="lc_btn_load_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="Load"><i class="fa fa-check-circle"></i> </button>
            
                </div>
            </div>

        </div>
        
        
        
        
        
                    <div class="bs-example">
			            
			         
			            
			            
			            
			  
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
							        
							         <button type="button" class="btn btn-primary" id="btn_lc_save_parcel_for_search" data-placement="top" data-toggle="tooltip" title="Save">
							            <i class="fa fa-save"></i>
							        </button>

							   </div> 
			
						</div>
						
			
			       
			            
			            
			          
			             
			                 <!--  Here is where the fee list comes -->
             
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
									         
        
          <div class="form-group">
											        <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
											              <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
				            
											        	<!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
											        </div>
											        
											  
										         </div>
			         
        
        
        
        
							         
							        </div>
							      <!--   Here is the end of right table -->
							  
							      </div>
							      

							     </div>
			                </div>
                
                
                               <div id="link-2" class="">
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

				<div class="col-lg-6">
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
															<option value="Discussion Letter">Discussion
																Letter</option>
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
				<div class="col-sm-3">
					<div class="card mb-3">
						<div class="card-header">
							<i class="fas fa-file-o"></i>Assign Inspection to Officer

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
				
					<div class="col-sm-3">
					<div class="card mb-3">
						<div class="card-header">
							
	<i class="fa fa-pie-chart"></i>Check Ground Rent Payment
						</div>
						<div class="card-body">
						
						<div class="form-group">
												<div class="form-row">
													<div class="col-md-12">
														<label for="bl_job_purpose">Check Ground Rent Payment</label>
													</div>

													<div class="col-md-8">
     											 <input   class="form-control" id="txt_certificate_ground_rent" type="text" aria-describedby="nameHelp"  value="${annual_rent}" >
				         
														
													</div>

													<div class="col-md-4">
														<button type="button" name="btn_save_certificate_ground_rent"
															class="btn btn-info btn-icon-split"
														>
															<span class="icon text-white-50"> <i
																class="fas file-alt"
															></i></span><span class="text">Save Rent</span>
														</button>
													</div>


												</div>


											</div>
						
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

						

						</div>
					</div>
				</div>
			</div>
                 
                 
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
				            <!--    <div class="col-md-6">
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
				              </div> -->
				             
				              <div class="col-md-4">
				                <label for="search_value">Rent Per Acre</label>
				                <input class="form-control" id="txt_lc_rent_passing_per_acre"   type="text" aria-describedby="nameHelp"  >
				              </div>
				            </div>
						              
				             
				            
						              
						              
						              
						      <%--         
						        <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Land size</label>
				                <input class="form-control" id="txt_lc_size_of_land"   type="text" aria-describedby="nameHelp"  value="${size_of_land}" >
				              </div>
				               
				             
				            </div>
						            --%>
						              
						            
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
				              <!--  <input type="button" id="lc_btn_assess_rent_demand_notice" class="btn btn-primary btn-block" value="Assess Ground Rent" />  -->
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
               
               
             
               
                               <div id="link-4" class="">
                    <h3 class="border-bottom border-gray pb-2">Certificate Preparation</h3>
						          
						
					             
						
						
						
						 <div class="row">
						
						
						      
						      
						      
						       <!--   Here is the right Table -->
						        <div class="col-lg-12">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Certificate Preparation</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
		
					
						              
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
							                
							                 <div class="col">
							              			<br><br>
							                		
						               				<button type="button" name="lc_btn_save_search_report" id="lc_btn_save_search_report" 
						               				class="btn btn-block btn-secondary btn-icon-split "  >
												    	 <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save Certificate</span>
										    		</button>
							                
							                </div>
							                
							                <div class="col">
							              			<br><br>
							                		<button type="button" name="lc_btn_preview_consent_certificate" id="lc_btn_preview_consent_certificate" class="btn  btn-primary btn-icon-split "  >
										    			<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview</span>
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
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						     
			
						      
						     
						
						 </div>
						 
				
               
			  </div>
               
               
                     <div id="link-5" class="">
                    <h3 class="border-bottom border-gray pb-2">Assessment and Payment of Consent Fees</h3>
						          
						
					             
						
						
						
						 <div class="row">
						
						
						      
						      
						      
						       <!--   Here is the right Table -->
						        <div class="col-lg-10">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Assessment and Payment of Consent Fees</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
		
						           
						              	
						    <div class="form-row">
				            <!--    <div class="col-md-6">
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
				              </div> -->
				             
				              <div class="col-md-4">
				                <label for="search_value">Rent Per Acre</label>
				                <input class="form-control" id="txt_lc_rent_passing_per_acre"   type="text" aria-describedby="nameHelp"  >
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
				              <!--  <input type="button" id="lc_btn_assess_rent_demand_notice" class="btn btn-primary btn-block" value="Assess Ground Rent" />  -->
				               <input type="button" id="lc_btn_print_rent_demand_notice" class="btn btn-primary btn-block" value="Print Rent Demand Note" /> 
				               
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
				              
				                <input type="button" id="lc_btn_activate_final_registration" class="btn btn-primary btn-block" value="Activate Application" />  
				                
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
     
