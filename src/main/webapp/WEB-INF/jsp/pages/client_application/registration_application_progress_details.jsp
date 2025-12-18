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
               
              <!--   <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li> -->
                
                <!-- <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-3">Update As Undergoing Registration<br /><small>Update As Undergoing Registration</small></a></li> -->
              
              
               <!--  <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-2">File Created <br /><small>Generate LRD File Number</small></a></li> -->
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Coordinate Entry<br /><small>Coordinate Entry</small></a></li>
				<li><a href="#53ab3caa7e7d11ef98b51e576becd20e-2">Record Verification<br /><small>Record Verification</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-3">Approval/Vetting/Approve for Publication<br /><small>Approval/Vetting/Approve for Publication</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-4">Parcel Plan Preparation<br /><small>Parcel Plan Preparation</small></a></li>
             <!--    <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-4">Parcel Plan Preparation<br /><small>Parcel Plan Preparation</small></a></li>
 -->
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-5">Final Approval after Publication<br /><small>Final Approval after Publication</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-6">Preparation  Certificate and Land Register<br /><small>Entering of Root of Title</small></a></li>
            <!--     <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-6">Generate Certificate and Land Register<br /><small>Certificate and Land Register Preparation</small></a></li>
            -->     <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-7">Final Approval of Parcel<br /><small>Final Approval of Parcel</small></a></li>
              
            </ul>

            <div>
            
             
             
                <div id="53ab3caa7e7d11ef98b51e576becd20e-1" class="">
			                	<br>
			                    <h3 class="border-bottom border-gray pb-2">Coordinate Entry</h3>
			                    
			                    
			                      <div class="row">
			                     <!--   Here is the right Table -->
							        <div class="col-lg-12">
							          <!-- Example Pie Chart Card-->
							          <div class="card mb-3">
							            <div class="card-header">
							              <i class="fa fa-pie-chart"></i>Coordinate Entry</div>
							            <div class="card-body">
							               <!--  The Form starts here -->
							              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
							       
			            <!-- Maps Details Starts Here  -->
			            
			              <div class="form-group">
											        <div class="form-row">  <label for="lc_fr_bl_wkt_polygon">WKT Polygon</label>
											              <input class="form-control" id="lc_fr_bl_wkt_polygon"  name="lc_fr_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
				            
											        	<!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
											        </div>
											        
											  
										         </div>
			         
        
			            
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
        
        
        
<!--        
        <button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-print"></i>
        </button> -->
		 
		  
   
   
        
		 
				   </div> 
			    
			    
			
			   
			  
			    
			    
			
			</div>
			
			
			       
			            
			            
			            
			             <div id="lcfrs-map"></div>
			             
			                 <!--  Here is where the fee list comes -->
             
           
									          
							              </form>
							            
							            <!-- The form Ends Hers -->
							            
							          </div>
							          
							          
							             <!--  Scanned Maps -->
          
                  
			                 <!--  Here is where the fee list comes -->
             <div class="card card-body">
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
							      

							     </div>
			                </div>
                


							 
							<div id="53ab3caa7e7d11ef98b51e576becd20e-2" class="">
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
			            
			              <div class="form-group">
											        <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
											              <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
				            
											        	<!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
											        </div>
											        
											  
										         </div>
			         
        
			            
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
        
        
        
        
        
        
        
        
       
				
				<div class="col-md-6">
	                <div class="form-group">
		                 <button class="btn btn-primary btn-icon-split" id="add_records_information_notes">
						<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Add New Records Information Notes</span>
						</button>
	                </div>
          	  </div>
             
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Note</th>
				                 <th>Note By</th>
				                 <th>Note Date</th>
				                 <th>Division</th>
				                 <th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							      <c:forEach items="${application_notes}" var="application_notes_row">
						                <tr>
								                    <td class="text-truncate" style="max-width:100px;">${application_notes_row.an_description}</td>
								                    <td>${application_notes_row.created_by}</td>
								                    <td>${application_notes_row.created_date}</td>
								                    <td>${application_notes_row.division}</td>
								                    
								                    <td><p data-placement="top" data-toggle="tooltip" title="View/Edit">
								                    	<button class="btn btn-info btn-icon-split"  data-toggle="modal" data-target="#addNotesModal" 
								                    	data-target-id="${application_notes_row.an_id}" 
								                    	data-an_description="${application_notes_row.an_description}" 
								                    	data-created_by="${application_notes_row.created_by}"  
								                    	data-created_date="${application_notes_row.created_date}" 
								                    	data-modified_by="${application_notes_row.created_by}"  
								                    	data-modified_date="${application_notes_row.created_date}" 
								                    	
								                    	
								                    	
								                    	>
								                    	<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">View</span>
								                    	</button></p></td>
								                 </tr>
						            </c:forEach> 
			  					</tbody>
				  			</table>
				          </div>
        
        
        
							         
							        </div>
							      <!--   Here is the end of right table -->
							  
							      </div>
							      

							     </div>
			                </div>
                
                
                <div id="53ab3caa7e7d11ef98b51e576becd20e-3" class="">
                    <h3 class="border-bottom border-gray pb-2">Approval/Vetting/Approve for Publication</h3>
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
								<option value="Inspection_Letter">Inspection Letter</option>
								<option value="Physical_Planning_Letter">Physical Planning Letter</option>
								<option value="Query_Letter">Query_Letter</option>
								<option value="Objection_Letter">Objection_Letter</option>
								

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
				            
				            
				            
				            
				            
				                 
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable" >
				           
				              <thead>
				                <tr>
				
				                 <th>Note</th>
				                 <th>Note By</th>
				                 <th>Note Date</th>
				                 <th>Division</th>
				                 <th>Action</th>
				                  </tr>
				              </thead>
				              
				                <tbody>
							      <c:forEach items="${application_notes}" var="application_notes_row">
						                <tr>
								                    <td class="text-truncate" style="max-width:100px;">${application_notes_row.an_description}</td>
								                    <td>${application_notes_row.created_by}</td>
								                    <td>${application_notes_row.created_date}</td>
								                    <td>${application_notes_row.division}</td>
								                    
								                    <td><p data-placement="top" data-toggle="tooltip" title="View/Edit">
								                    	<button class="btn btn-info btn-icon-split"  data-toggle="modal" data-target="#addNotesModal" 
								                    	data-target-id="${application_notes_row.an_id}" 
								                    	data-an_description="${application_notes_row.an_description}" 
								                    	data-created_by="${application_notes_row.created_by}"  
								                    	data-created_date="${application_notes_row.created_date}" 
								                    	data-modified_by="${application_notes_row.created_by}"  
								                    	data-modified_date="${application_notes_row.created_date}" 
								                    	
								                    	
								                    	
								                    	>
								                    	<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">View</span>
								                    	</button></p></td>
								                 </tr>
						            </c:forEach> 
			  					</tbody>
				  			</table>
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
						        <div class="col-lg-8">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						          <!--   <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Approve for Publicatio</div> -->
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
						       <div class="form-row">
				              
				                <!-- <div class="col-md-4">
				                 <label for="search_value">Date of Publication</label>
								  <input type="text" name="lc_txt_publicity_date" id="lc_txt_publicity_date"   class="form-control" value="${publicity_date}"required> </div> -->
				                <div class="col-md-4">
				               <input type="button" id="lc_btn_add_to_publication_list" class="btn btn-primary btn-block" value="Send for Publication"/> 
				               <!-- <input type="button" id="lc_btn_update_publication_date" class="btn btn-primary btn-block" value="Set Date Published" />  -->
<!-- 				               
							   <c:if test="${publicity_date != 'null' }">
								disabled="disabled" 
							</c:if> -->

				                </div>
				             
				            </div>
						              
						           
						           
						              
						              
						            
						            <!-- The form Ends Hers -->
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						     
						      
						      
						     
						
						 </div>
						 
						 
 
 
                </div>
               
                       <div id="53ab3caa7e7d11ef98b51e576becd20e-4" class="">
                    <h3 class="border-bottom border-gray pb-2">Parcel Plan Preparation</h3>
						          
		
						 
						 
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
						      
						      
						      
						                             <div class="row">
                     <!--   Here is the right Table -->
				        <div class="col-lg-12">
				          <!-- Example Pie Chart Card-->
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Title Plan Update</div>
				            <div class="card-body">
				
				
							              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
				
						    <div class="form-group">
					       
					        <div class="form-row">  <label for="bl_job_purpose">WKT Polygon</label>
					         
					         <input class="form-control" id="lc_fr_bl_wkt_polygon"  name="lc_fr_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
				             
					        </div>
					         </div>
						      
							 <div class="form-row">
								
								<div class="col-md-4">
								   <label for="search_value">GLPIN</label>
								   <input class="form-control" id="txt_glpin"    type="text" aria-describedby="nameHelp" placeholder="GLPIN" value="${glpin}" readonly>
								 </div>
							   
								   
								 <div class="col-md-4">
								   <label for="search_value">Type of Plotting</label>
								   <input class="form-control" id="txt_lc_smd_type_of_plotting"  name="txt_lc_smd_type_of_plotting"  type="text" aria-describedby="nameHelp"  value="${smd_type_of_plotting}" readonly>
								 </div>

								   <div class="col-md-4">
								   <label for="search_value">SMD Reference Number</label>
								   <input class="form-control" id="txt_lc_smd_reference_number"  name="txt_lc_smd_reference_number"  type="text" aria-describedby="nameHelp"  value="${smd_reference_number}" readonly>
								   </div>

							 </div>
							
							
							<div class="form-row">
							
						  

							   <div class="col-md-4">
							   <label for="search_value">Registration District</label>
							   <input class="form-control" id="txt_lc_registration_district_number"  name="txt_lc_registration_district_number"  type="text" aria-describedby="nameHelp" value="${registration_district_number}" readonly >
							 </div>

							 <div class="col-md-4">
							   <label for="search_value">Section Number</label>
							   <input class="form-control" id="txt_lc_registration_section_number"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registration_section_number}" readonly>
							 </div>
							   <div class="col-md-4">
							   <label for="search_value">Block Number</label>
							   <input class="form-control" id="txt_lc_registration_block_number"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" readonly>
							 </div>
							
						   </div>
						   
							 
								<div class="form-row">
						   
								   <div class="col-md-4">
									   <label for="search_value">Land size</label>
									   <input class="form-control" id="txt_lc_size_of_land"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${size_of_land}" readonly>
									 </div>
									   <div class="col-md-4">
									   <label for="search_value">Plan Number</label>
									   <input class="form-control" id="txt_lc_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp" value="${plan_no}" readonly>
									 </div>
							  <div class="col-md-4">
								  <label for="search_value">LTR Plan Number</label>
							   <input class="form-control" id="ltr_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${ltr_plan_no}" readonly>
							 
								
							  </div>
							
						   </div>
						   
						   <div class="form-row">
							 <div class="col-md-4">
							   <label for="search_value">Registry Map No</label>
							   <input class="form-control" id="txt_lc_registry_mapref"  name="search_value"  type="text" aria-describedby="nameHelp"  value="${registry_mapref}" readonly>
							 </div>
							 
							 <div class="col-md-4">
							   <label for="search_value">CC No</label>
							   <input class="form-control" id="txt_lc_cc_no"  name="search_value"  type="text" aria-describedby="nameHelp" value="${cc_no}" readonly>
							 </div> 
							 
							
							
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
  
       
        <button type="button" class="btn btn-primary" id="btn_print_new_title_plan" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
            <i class="fa fa-print"></i>
        </button>
    </div>
   

	   <!--  Zoom to cooedinate -->
	   <div class="row">
					                                                        
		<div class="col-md-5">
			<div class="form-group">
			  
				<input class="form-control" type="text" name="name"  id="smd_x_coordinate_mak" placeholder="Eastings"> 
			</div>
		</div>
		
		
		<div class="col-md-5">
			<div class="form-group">
			  
				<input class="form-control" type="text" name="name" id="smd_y_coordinate_mak" placeholder="Northings"> 
			  
		
			</div>
		</div>
		
		<div class="col-md-2">
			<div class="form-group">
			 <button type="button" class="btn btn-primary" id="smd_btn_show_location" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-map-marker"></i> </button>
		
			</div>
		</div>
		
		
		 <div class="col-md-2">
			<div class="form-group">
			 <button type="button" class="btn btn-primary" id="smd_btn_load_for_scanned_maps_by_point" data-placement="top" data-toggle="tooltip" title="Search Scanned Map"><i class="fa fa-check-circle"></i> </button>
		
			</div>
		</div>

	</div>
	


          <!--  Scanned Maps -->
          
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
                 <button type="button" class="btn btn-primary" id="smd_btn_search_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="search_for_scanned_maps"><i class="fa fa-search"></i> </button>
            
                </div>
            </div>
             <div class="col-md-2">
                <div class="form-group">
                 <button type="button" class="btn btn-primary" id="smd_btn_load_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-check-circle"></i> </button>
            
                </div>
            </div>

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
               
               
              <!--   <div id="53ab3caa7e7d11ef98b51e576becd20e-4" class="">
                    <h3 class="border-bottom border-gray pb-2">Title Plan</h3>

				     
				     
				     
                   </div> -->
         
             
               
                <div id="53ab3caa7e7d11ef98b51e576becd20e-5" class="">
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
						               
						               
						                 <div  class="table-responsive">
				           <table class="table table-bordered table-hover table-sm">
								      		<thead>
								      			<tr>
								      				<th>Objector </th>
								      				<th>Address</th>
								      				<th>Contact</th>
								      				<th>Reasons </th>
								      				<th>Remarks </th>
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
						               
						               
						              <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
									<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
										<input type="hidden" id="job_number" name="job_number" value="${job_number}" >
										<!-- <input type="hidden" id="request_type" name="request_type" value="request_to_generate_inspection_letter">
								         -->  <!-- <div class="form-group">
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
               
               
                  <div id="53ab3caa7e7d11ef98b51e576becd20e-6" class="">
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
			                    <!-- <th>Action</th>
			                    <th>Approve</th> -->
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


				                    <!-- <td>
										<p data-placement="top"  title="Edit">  
											<button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
												 data-target="#newProprietorshipModal"
												 data-target-id="${proprietorship_section.ps_id}"
												  data-ps_id="${proprietorship_section.ps_id}"  
												 data-ps_case_number="${proprietorship_section.ps_case_number}"
												 data-ps_registration_number="${proprietorship_section.ps_registration_number}"
												 data-ps_proprietor="${proprietorship_section.ps_proprietor}"
												 data-ps_date_of_instrument="${proprietorship_section.ps_date_of_instrument}"
												 data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
												 data-ps_date_of_registration="${proprietorship_section.ps_date_of_registration}"
												 data-ps_transferor="${proprietorship_section.ps_transferor}"
												 data-ps_transferee="${proprietorship_section.ps_transferee}"
												 data-ps_price_paid="${proprietorship_section.ps_price_paid}"
												 data-ps_remarks="${proprietorship_section.ps_remarks}"
												 data-ps_signature="${proprietorship_section.ps_signature}"
												 > 
														 
														 
												<span class="icon text-white-50"> 
												<i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
										</p>
				                    </td> -->
				                    
				                    	
				                    
				                     
				                    
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
	  
			 
			          
			          
			<div class="form-row">
				<div class="col-md-12">
				  <label for="search_value">Register:Description of Land</label>
				   
				  
				   
					  <textarea id="lc_description_of_land_lrd" name="lc_description_of_land_lrd" class="form-control col-sm-12" required rows=3  style="padding:50px !important;">${smd_region} </textarea> 
				  
				  
				 <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
   --%>
											  
				  </div>
				  
				 
			   
			  </div>


    <div class="form-row">
							              
		<div class="col-auto">
				<br><br>									                 
					 
						 <button type="button" name="btn_compose_register_description" id="btn_compose_register_description" class="btn  btn-primary btn-icon-split "  >
					  <span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
				  </button>
				  
			  
		  </div>
		  
		   <div class="col">
					<br><br>
				  
					 <button type="button" name="lc_btn_save_register_description" id="lc_btn_save_register_description" 
					 class="btn btn-block btn-secondary btn-icon-split "  >
					   <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save</span>
				  </button>
		  
		  </div>
		  
		
		</div>
	  

       
 
           <div class="form-row">
							              <div class="col-md-12">
							                <label for="search_value">Certificate Summary</label>
											 
											
											 
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
							                
							                <!-- <div class="col">
							              			<br><br>
							                		<button type="button" name="lc_btn_preview_consent_certificate" id="lc_btn_preview_consent_certificate" class="btn  btn-primary btn-icon-split "  >
										    			<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview Certificate</span>
										    		</button>
							                
							                </div> -->
							                
							                  
							                <!-- <div class="col">
							              			<br><br>
							                		 <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
									<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
										<input type="hidden" id="job_number" name="job_number" value="${job_number}" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_register_unsigned">
								         <div class="form-group">
						           
						            
						              
						                <input type="submit" class="btn btn-primary btn-block" value="Generate Register" />  
						           
						          </div>
						        </form>
							                
							                </div> -->
							                
							                
							                 
							                
							              </div>
							            
                
			          
                
                
					 </div>
                
               
               
               
               
              
                <div id="53ab3caa7e7d11ef98b51e576becd20e-7" class="">
                    <h3 class="border-bottom border-gray pb-2">Final Approval of Registration</h3>
               
                      
                         
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
					                    	<!-- <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
					                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
					                    	</button> -->
											<button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" 
										data-target-id="${proprietorship_section.ps_id}" 
										data-ps_id="${proprietorship_section.ps_id}"
										data-ps_case_number="${proprietorship_section.ps_case_number}"
										data-ps_registration_number="${proprietorship_section.ps_registration_number}"
										data-ps_date_of_instrument="${proprietorship_section.ps_date_of_instrument}"
										data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
										data-ps_date_of_registration="${proprietorship_section.ps_date_of_registration}"
										data-ps_transferor="${proprietorship_section.ps_transferor}"
										data-ps_transferee="${proprietorship_section.ps_transferee}"
										data-ps_price_paid="${proprietorship_section.ps_price_paid}"
										data-ps_remarks="${proprietorship_section.ps_remarks}"
										data-ps_signature="${proprietorship_section.ps_signature}"
										data-ps_proprietor="${proprietorship_section.ps_proprietor}"
										data-whatever="edit">
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



					<!-- <div class="form-row">
						<div class="col-md-12">
						  <label for="search_value">Certificate Summary</label>
						   
						  
						   
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
						  
						</div> -->

						<div class="card">
							<div class="card-header bg-dark text-white " role="tab"
								id="headingThree"
							>
								<a class="collapsed d-block  text-white " data-toggle="collapse"
									data-parent="#accordion" href="#collapseprecertregis"
									aria-expanded="false" aria-controls="collapseFive"
									style="text-decoration: none !important"
								> <i class="fa fa-chevron-down pull-right"></i> <i
									class="fa fa-users"
								></i>Preview Certificate and Land Register
								</a>
							</div>
							<div id="collapseprecertregis" class="collapse" role="tabpanel"
								aria-labelledby="headingThree"
							>
								<div class="card-body">
		 
		 
		 
			 <div class="form-row">
												  <div class="col-md-12">
													<label for="search_value">Register:Description of Land</label>
													 
													
													 
														<textarea id="lc_description_of_land_lrd_2" name="lc_description_of_land_lrd" class="form-control col-sm-12" required rows=3  style="padding:50px !important;">${smd_region} </textarea> 
													
													
												   <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
									 --%>
																				
													</div>
													
												   
												 
												</div>
		 
		 
			<div class="form-row">
												  
												  <!-- <div class="col-auto">
														  <br><br>									                 
															   
																   <button type="button" name="btn_compose_register_description" id="btn_compose_register_description_2" class="btn  btn-primary btn-icon-split "  >
																<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
															</button>
															
														
													</div> -->
													
													 <div class="col">
															  <br><br>
															
															   <button type="button" name="lc_btn_save_register_description" id="lc_btn_save_register_description_2" 
															   class="btn btn-block btn-secondary btn-icon-split "  >
																 <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Update Register</span>
															</button>
													
													</div>
													
												  
												  </div>
												
		 
		 
				   <div class="form-row">
												  <div class="col-md-12">
													<label for="search_value">Certificate Summary</label>
													 
													
													 
														<textarea id="lc_search_report_summary_details_2" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
													
													
												   <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
									 --%>
																				
													</div>
													
												   
												 
												</div>
												
												
												
												 
												<div class="form-row">
												  
												  <!-- <div class="col-auto">
														  <br><br>									                 
															   
																   <button type="button" name="btn_compose_certificate_template" id="btn_compose_certificate_template_2" class="btn  btn-primary btn-icon-split "  >
																<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
															</button>
															
														
													</div> -->
													
													 <div class="col">
															  <br><br>
															
															   <button type="button" name="lc_btn_save_search_report" id="lc_btn_save_search_report_2" 
															   class="btn btn-block btn-secondary btn-icon-split "  >
																 <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Update Certificate</span>
															</button>
													
													</div>
													
													<!-- <div class="col">
															  <br><br>
															<button type="button" name="lc_btn_preview_consent_certificate" id="lc_btn_preview_consent_certificate" class="btn  btn-primary btn-icon-split "  >
																<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview Certificate</span>
															</button>
													
													</div> -->
													
													  
													<div class="col">
															  <br><br>
															 <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
											<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
												<input type="hidden" id="job_number" name="job_number" value="${job_number}" >
												<input type="hidden" id="request_type" name="request_type" value="request_to_generate_register_unsigned">
												 <div class="form-group">
										   
											
											  
												<input type="submit" class="btn btn-primary btn-block" value="Preview Register" />  
										   
										  </div>
										</form>
													
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
												 <i class="fa fa-pie-chart"></i>Generate Certificate, Volume and Folio</div>
											   <div class="card-body">
												  <!--  The Form starts here -->
										   
											  <div class="form-row">
												<div class="col-md-3">
												  <label for="job_number">Certificte Type</label>
												<select name="lc_txt_type_of_certificate" id="lc_txt_type_of_certificate" class="form-control input-sm" data-style="btn-info" required data-live-search="true">
													<option value="${certificate_type == 'Individual' ? '' : certificate_type}">${certificate_type == 'Individual' ? '-- select --' : certificate_type}</option>
													<option value="Provisional Certificate">Provisional Certificate</option>
													<option value="Land Certificate">Land Certificate</option>
													<option value="Substituted Certificate">Substituted Certificate</option>
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
													  <input type="button" id="lc_btn_generate_certificate_volume_folio" class="btn btn-primary btn-block to_hide_on_level_1" value="Generate Indices" />  
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
  
  
