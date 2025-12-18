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
					          
					          
					      
							   <!-- wizard start wizard end -->
		

        <!-- smartwizardfirstregistration html -->
        <div id="smartwizardfirstregistration">
            <ul class="d-none">
               
                  <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Coordinate Entry and Record Verification<br /><small>Coordinate Entry and Record Verification</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-2">Approval/Vetting<br /><small>Approval/Vetting</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-3">Entering of Root of Title<br /><small>Entering of Root of Title</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-4">Certificate and Land Register Preparation<br /><small>Certificate and Land Register Preparation</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-5">Final Approval<br /><small>Final Approval</small></a></li>
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
							        
							          <button type="button" class="btn btn-primary"  id="lc_btn_visualise_coordinate" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
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
			                
                
                <div id="53ab3caa7e7d11ef98b51e576becd20e-2" class="">
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
				            
				            
				            
				            
				            
				             
				            
				            
				          </div>
				          
				          
				          
				          
				         
				          
				          
				          
				       
				            <!-- The form Ends Hers -->
				            
				          </div>
				         
				        </div>
				      <!--   Here is the end of right table -->
				  
				      </div>

 </div>
                </div>
               
                
              
               
                  <div id="53ab3caa7e7d11ef98b51e576becd20e-3" class="">
                 <h3 class="border-bottom border-gray pb-2">Root of Title</h3>
                
                
                
                  <h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
                    <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
			            <i class="fa fa-plus-circle"></i>
			        </button>
                     
               	  <div  class="table w-auto small">
			           <table class="table table-bordered" id="lrd_proprietorship_details_dataTable" >
			           
						<thead>
			                <tr>
								<!-- <th>approval_status</th> -->
				                 <th>Registered No.</th>
				                 <th>Proprietors</th>
				                 <th>Date of Instrument</th>
				                 <th>Nature of Instrument</th>
								 <th>Date of Regsitration</th>
								 <th>Parties</th>
								 <th>Price Paid</th>
								 <th>Remarks</th>
			                    <th>Action</th>
			                    <th>Approve</th>
			                  </tr>
			              </thead>
			              
			                <tbody>
							     <c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
				               		 <tr>
				               		<!-- <td>${proprietorship_section.approval_status}</td> -->
				                    <td>${proprietorship_section.ps_registration_number}</td>
				                    <td>${proprietorship_section.ps_proprietor}</td>
				                    <td>${proprietorship_section.ps_date_of_instrument}</td>
				                    <td>${proprietorship_section.ps_nature_of_instrument}</td>
									<td>${proprietorship_section.ps_date_of_registration}</td>
				                    <td>${proprietorship_section.ps_transferor} - ${proprietorship_section.ps_transferee}</td>
									<td>${proprietorship_section.ps_price_paid}</td>
									<td>${proprietorship_section.ps_remarks}</td>


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
			          
			          
					  <h5 class="border-bottom border-gray pb-2">Reservation Details</h5>
			      	<button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newReservationModal" data-toggle="tooltip" title="Add New">
		            <i class="fa fa-plus-circle"></i>
		        	</button>
                     <div class= "clear"></div><br>
               	  <div  class="table w-auto small table-responsive">
			           <table class="table table-bordered" id="lrd_reservation_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>Reservation Description</th>
			                 <th>Created By</th>
			                 <th>Created On</th>
			                 
			                   <th>Action</th>
			                  </tr>
			              </thead>
			              
			                <tbody>
			     <c:forEach items="${lrd_reservation_section}" var="reservation_section">
                <tr>
                    <td>${reservation_section.reservation_description}</td>
                    <td>${reservation_section.modified_by}</td>
                    <td>${reservation_section.created_date}</td>
                    <!-- <td>${certificate_section.cs_official_notes}</td> -->
                    <td>
						                    
						                    <p data-placement="top"  title="Edit">  
			          							<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
			          								 data-target="#newReservationModal"
			          								 data-rs_id="${reservation_section.rs_id}"
			          								 data-rs_reservation_description="${reservation_section.reservation_description}"  
			          								 data-rs_case_number="${reservation_section.case_number}"
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
                
               
               
               
               
                <div id="53ab3caa7e7d11ef98b51e576becd20e-4" class="">
                  

					<h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
					<button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
						<i class="fa fa-plus-circle"></i>
					</button>
					<div id="" class="table-responsive">
				<div  class="table w-auto small">
					<table class="table table-bordered" id="lrd_proprietorship_details_dataTable_final_approval" >
					
						<thead>
							<tr>
								<!-- <th>approval_status</th> -->
								<th>Registered No.</th>
								<th>Proprietors</th>
								<th>Date of Instrument</th>
								<th>Nature of Instrument</th>
								<th>Date of Regsitration</th>
								<th>Parties</th>
								<th>Price Paid</th>
								<th>Remarks</th>
								<th>Action</th>
								<th>Approve</th>
							</tr>
						</thead>
						
							<tbody>
								<c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
									<tr>
									<!-- <td>${proprietorship_section.approval_status}</td> -->
									<td>${proprietorship_section.ps_registration_number}</td>
									<td>${proprietorship_section.ps_proprietor}</td>
									<td>${proprietorship_section.ps_date_of_instrument}</td>
									<td>${proprietorship_section.ps_nature_of_instrument}</td>
									<td>${proprietorship_section.ps_date_of_registration}</td>
									<td>${proprietorship_section.ps_transferor} - ${proprietorship_section.ps_transferee}</td>
									<td>${proprietorship_section.ps_price_paid}</td>
									<td>${proprietorship_section.ps_remarks}</td>


								
									<td>
										<p data-placement="top" data-toggle="tooltip" title="Batch">
											<button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
												<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
											</button>
										</p>
									</td>
									
										
									<td>
										<p data-placement="top" data-toggle="tooltip" title="Batch">
											<button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#lrdtransactionapprovalmodal" 
											data-target-id="${proprietorship_section.ps_id}" 
											data-ps_proprietor="${proprietorship_section.ps_proprietor}"
											data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
											data-case_number="${proprietorship_section.case_number}"
											data-transaction_id="${proprietorship_section.ps_id}"
											data-whatever="edit">
												<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Approve</span>
											</button>
										</p>
									</td>
									
									
									</tr>
								</c:forEach>
							</tbody>
				
						
						</table>
					</div>
					
					</div>  
					

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
												<div class="col-md-3">
												<label for="job_number">Certificte Type</label>
												<select name="lc_txt_type_of_certificate" id="lc_txt_type_of_certificate" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
													<option value="${certificate_type}" selected="true">${certificate_type}</option>
													<option value="Provisional Certificate">Provisional Certificate</option>
													<option value="Land Certificate">Land Certificate</option>
												</select> 

												</div>
												<div class="col-md-3">
													<label for="job_number">Certificate Number</label>
													<input class="form-control" id="lc_txt_certificate_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${certificate_number}" >
													</div>
												<div class="col-md-3">
												<label for="job_number">Volume</label>
												<input class="form-control" id="lc_txt_volume_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${volume_number}" >
												</div>
												
												<div class="col-md-3">
													<label for="job_number">Folio</label>
												<input class="form-control" id="lc_txt_folio_number"  name="file_number"  type="text" aria-describedby="nameHelp"  value="${folio_number}" >
												
													
												</div>
													<div class="col-md-3">
													<label for="job_number">.</label>
													<input type="button" id="lc_btn_generate_certificate_volume_folio" class="btn btn-primary btn-block to_hide_on_level_1" value="Generate Cert/Volume/Folio" />  
												</div>
												
											</div>
											
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
												<i class="fa fa-pie-chart"></i>Final Approvals</div>
											<div class="card-body">
												<!--  The Form starts here -->
												<input class="form-control" id="txt_certificete_approval_status"  name="txt_certificete_approval_status"  type="hidden" aria-describedby="nameHelp" readonly value="${certificete_approval_status}" >
												<input class="form-control" id="txt_final_approval_status"  name="txt_final_approval_status"  type="hidden" aria-describedby="nameHelp" readonly value="${final_approval_status}" >
						
												<div class="form-row">
																<div class="col-md-3">
																	<input type="button" id="lc_btn_approve_certicate_for_signature" class="btn btn-danger btn-block" value="Approve Certificate" />  
							
																</div>
																<div class="col-md-3">
																	<input type="button" id="lc_btn_generate_activation_code" class="btn btn-danger btn-block" value="Final Approval of Title" />  
							
																</div>
																
																<div class="col-md-3">

																	<input type="button" id="lc_btn_activate_final_certificate" class="btn btn-primary btn-block" value="Generate Final Certificate" />  
							
																	<!-- 																	 
																	<input type="button" id="lc_btn_activate_provisional_certificate" class="btn btn-warning btn-block" value="Generate Provisional Certificate" />  
																	-->
																</div>
																<div class="col-md-3">
																	<input type="button" id="lc_btn_activate_final_register" class="btn btn-primary btn-block" value="Generate Final Register" />  
						
																</div>
												
											</div>
											
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
							<i class="fa fa-pie-chart"></i>Final Approval of Registration</div>
							<div class="card-body">
							<!--  The Form starts here -->
							<form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
					
			<!-- Maps Details Starts Here  -->
			<div class="bs-example">
			
		
			
			
			
	<div class="btn-group mr-2">
	<button type="button" class="btn btn-primary"  id="btn_lcfrfa_lc_btn_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
			<i class="fa fa-map"></i>
		</button>
	
		<!--  
		<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
			<i class="fa fa-save"></i>
		</button>
		-->
	
		<button type="button" class="btn btn-primary" id="btn_lcfrfa_lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
			<i class="fa fa-object-ungroup"></i>
		</button>
		
	
		<button type="button" class="btn btn-primary" id="btn_lcfrfa_lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
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
					
					
					</div>
					
                  
                </div>
               
                
            </div>
        </div>
							
          
            
           <jsp:include page="../client_application/_application_process_footer.jsp"></jsp:include>