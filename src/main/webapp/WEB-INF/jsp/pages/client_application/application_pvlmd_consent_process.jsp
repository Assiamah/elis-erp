 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
               
               <!--  <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li> -->
                <!--  <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Generate File Number<br /><small>Generate File Number</small></a></li> -->
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Coordinate Entry and Record Verification<br /><small>Coordinate Entry and Record Verification</small></a></li>
             <!--    <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-2">Record Verification<br /><small>Record Verification</small></a></li> -->
                  <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-2">Vetting and Approval<br /><small>Vetting and Approval</small></a></li>
              <!--   <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-3">Plan Preparation and Plotting<br /><small>Plan Preparation and Plotting</small></a></li> -->
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-3">Check Ground Rent Payment<br /><small>Check Ground Rent Payment</small></a></li>
               
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-4">Link Application to Mother File<br /><small>Link Application to Mother File</small></a></li>
                 <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-5">Preparation of Certificate<br /><small>Preparation of Certificate</small></a></li>
                 <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-6">Assessment and Payment of Consent Fees<br /><small>Assessment and Payment of Consent Fees</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-7">Final Approval<br /><small>Final Approval</small></a></li>
             
            </ul>

            <div>
            
           
         			                <div id="53ab3caa7e7d11ef98b51e576becd20e-1" class="">
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
                
                
                                           <div id="53ab3caa7e7d11ef98b51e576becd20e-4" class="">
                    <h3 class="border-bottom border-gray pb-2">Link Application to Mother File</h3>
						          
						
					                  <div class="row">
								                                                        
			            <div class="col-md-6">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="pvlmd_search_by_text"  name="pvlmd_search_by_text"  type="text" value="${case_file_number}" placeholder="Search by Ref Number" required >
						   
			                </div>
			            </div>
			
			          
			          <!-- <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div> -->
			            
			            <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_by_transaction_reference_number" data-placement="top" data-toggle="tooltip" title="Search"><i class="fa fa-search"></i> </button>
			            
			                </div>
			            </div>
			            
			
			        </div>
     
						
						
						
						 <div class="row">
						
						
						      
						      
						      
						       <!--   Here is the right Table -->
						        <div class="col-lg-12">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Transaction Details</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
		
					
						       <div class="table-responsive">
					           <table class="table table-bordered data-table" id="pvlmd_transaction_detailsdataTable" width="100%" cellspacing="0">
					           
					              <thead>
					               <tr>
										<th>Document Number</th>
										<th>Instrument Type</th>
										<th>Instrument Date</th>
										<th>Consent Date</th>
										<th>Grantor</th>
										<th>Grantee</th>
										<th>Reference Number</th>					
										<th>Remarks</th>
									
																	
										
									</tr>
					              </thead>
					              
					                <tbody>
					    
					     
					             </tbody>
					            
					            
					            </table>
					          </div>
						              
						    
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						     
			
						      
						     
						
						 </div>
						 
				
               
			  </div>
               
                
                
                 <div id="53ab3caa7e7d11ef98b51e576becd20e-2" class="">
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

				
				<div class="col-sm-6">
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
				
					<div class="col-sm-6">
					<div class="card mb-3">
						<div class="card-header">
							
	<i class="fa fa-pie-chart"></i>Ground Rent For Certificate
						</div>
						<div class="card-body">
						
						<div class="form-group">
												<div class="form-row">
													<div class="col-md-12">
														<label for="bl_job_purpose">Ground Rent</label>
													</div>

													<div class="col-md-8">
     											 <input   class="form-control" id="txt_certificate_ground_rent" type="text" aria-describedby="nameHelp"  value="${annual_rent}" >
				         
														
													</div>

													<div class="col-md-4">
														<button type="button" name="btn_save_certificate_ground_rent_revised"
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

			<!-- <div class="row">
			
			</div> -->
			
			
			<div class="row">
			<div class="col-lg-12">
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
							
							
							
							</div>
							
							
							<div class="row">
							
				<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            		
	            		
	          			<select
								name="type_of_letter_new" id="type_of_letter_new"
								data-live-search="true" class="form-control selectpicker"
							>
								<option value="Select_Letter_Template">Select Letter Template</option>
								<option value="Inspection Letter">Inspection Letter</option>
								<option value="Physical Planning Letter">Physical Planning Letter</option>
								

							</select>
	          		</div>
	          		
	          	</div>
	          	<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 list-to-hide">
	          		<div class="form-group">
	            	
	            		
	            		<button type="button"
								class="btn btn-primary"
								id="lc_btn_add_update_letters" data-placement="top" 
							>
								<span class="icon text-white-50"> <i
									class="fa fa-plus-circle"
								></i></span><span class="text">Add New Letter Template</span>
							</button>
	          		
	          		</div>
	          		
	          	</div>
							
							
							</div>

			
							<!-- </form> -->

							<!-- The form Ends Hers -->

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
							<i class="fas fa-file-o"></i>Letters on Job

						</div>
						<div class="card-body">
							<!--  The Form starts here -->
							<div id="alert-display-space"></div>


							<table class="table">
								<thead>
									<tr>
										<th>Date</th>
										<th>Letter Type</th>
										<th>Created By</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${case_letters}" var="case_letters_row">
									                <tr>
									                    <td>${case_letters_row.created_date}</td>
									                    <td>${case_letters_row.letter_type}</td>
									                    <td>${case_letters_row.created_by}</td>
									                  
									                    
									                    <td>
										      					<button type="button" id="btn-view-letters"  
										      					data-id="${case_letters_row.id}"
										      					data-letter_type = "${case_letters_row.letter_type}" 
										      					data-letter_template="${fn:escapeXml(case_letters_row.letter_template)}" 
										      					data-carbon_copy="${case_letters_row.carbon_copy}" 
										      					class="btn btn-primary btn-icon-split edit_letter_modal_open"  title="View Letter" >
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
                 
                 
      
                </div>
               
                
      
               
                
                
                <div id="53ab3caa7e7d11ef98b51e576becd20e-3" class="">
                    <h3 class="border-bottom border-gray pb-2">Check Ground Rent Payment</h3>
						          
						
					             
						
						
						
						 <div class="row">
						
						
						      
						      
						      
						       <!--   Here is the right Table -->
						        <div class="col-lg-10">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Check Ground Rent Payment</div>
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
				                <label for="search_value">Amount in Arrears</label>
				                <input class="form-control" id="txt_lc_rent_passing_per_acre"   type="text" aria-describedby="nameHelp"  >
				              </div>
				              
				                <div class="col-md-4">
				                <label for="search_value">Rent Period</label>
				                <input class="form-control" id="txt_lc_rent_period_for_demand_note"   type="text" aria-describedby="nameHelp"  >
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
               
               
             
               
                               <div id="53ab3caa7e7d11ef98b51e576becd20e-5" class="">
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
               
               
                     <div id="53ab3caa7e7d11ef98b51e576becd20e-6" class="">
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
				                <label for="search_value">Consent Fee</label>
				                <input class="form-control" id="txt_lc_consent_fee"   type="text" aria-describedby="nameHelp"  >
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
						              <i class="fa fa-pie-chart"></i>Generate Bill</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
						       <div class="form-row">
				              
							 <div class="col-md-12">
				              <!--  <input type="button" id="lc_btn_assess_rent_demand_notice" class="btn btn-primary btn-block" value="Assess Ground Rent" />  -->
				               <input type="button" id="lc_btn_save_print_consent_fees" class="btn btn-primary btn-block" value="Generate Consent Fee Bill" /> 
				               
				                </div>
				             
				            </div>
						              
						           
						           
						              
						              
						            
						            <!-- The form Ends Hers -->
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						      
						     
						
						 </div>
						 
						 
						 
						 
					
               
  </div>
               
               
               
            
                <div id="53ab3caa7e7d11ef98b51e576becd20e-7" class="">
                    <h3 class="border-bottom border-gray pb-2">Final Approval of Application</h3>
               
   <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-8">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Final Approval of Title</div>
				            <div class="card-body">
				               <!--  The Form starts here -->
				         <%--      <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post"> --%>
				       
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
   
    
		</div>

             <div id="lcfrs-map" ></div>
             
             
						          
				           <!--    </form> -->
				            
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
				              
				                <input type="button" id="lc_btn_generate_activation_code" class="btn btn-primary btn-block" value="Generate Code" />  
				                
				                </div>
				            </div>
				            
				          <!--     
				            <div class="form-row">
				              
				              <div class="col-md-12">
				              
				                <input type="button" id="lc_btn_activate_final_registration" class="btn btn-primary btn-block" value="Actiavte Confirm" />  
				                
				                </div>
				            </div> -->
				            
				        <!--     <div class="form-row">
				              <div class="col-md-12">
				               <label for="job_number">Activation Code</label>
				                <input class="form-control" id="lc_txt_certificate_number"  name="file_number"  type="text" aria-describedby="nameHelp"   placeholder="Enter ACtivation Code">
				               </div>
				            </div>
				          
				          <div class="form-row">
				              
				              <div class="col-md-12">
				              
				                <input type="button" id="lc_btn_activate_final_registration_confirm" class="btn btn-primary btn-block" value="Confirm Activation" />  
				                
				                </div>
				            </div> -->
				            
				            
				          <!--    <div class="form-row">
				              
				              <div class="col-md-12">
				              
				                <input type="button" id="lc_btn_activate_final_certificate" class="btn btn-primary btn-block" value="Generate Final Certificate" />  
				                
				                </div>
				            </div>
				            
				            
				            
				             <div class="form-row">
				              
				              <div class="col-md-12">
				              
				                <input type="button" id="lc_btn_activate_final_register" class="btn btn-primary btn-block" value="Generate Final Register" />  
				                
				                </div>
				            </div>
				             -->
				            
				            
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
     
