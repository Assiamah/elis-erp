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
               
              <!--   <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Upload file at CSAU Back Office<br /><small>Upload file at CSAU Back Office</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-2">Generate LRD File Number<br /><small>Generate LRD File Number</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-3">Update As Undergoing Registration<br /><small>Update As Undergoing Registration</small></a></li> -->
				<li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Coordinate Entry<br /><small>Coordinate Entry</small></a></li>
				<li><a href="#53ab3caa7e7d11ef98b51e576becd20e-2">Record Verification<br /><small>Record Verification</small></a></li>
            
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-3">Approval/Vetting<br /><small>Approval/Vetting</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-4">Parcel Plan Preparation<br /><small>Parcel Plan Preparation</small></a></li>
				<li><a href="#53ab3caa7e7d11ef98b51e576becd20e-5">Link Application to Mother File<br /><small>Link Application to Mother File</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-6">Entering of Root of Title<br /><small>Entering of Root of Title</small></a></li>
                <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-7">Final Approval of Registration<br /><small>Fnmal Approval of Registration</small></a></li>
               
               
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


	   
			
			
			
			 <div id="lcfrs-map" ></div>
			 
				 <!--  Here is where the fee list comes -->
 

								  
							  </form>
							
							<!-- The form Ends Hers -->
							
						  </div>
						  
						  
							 <!--  Scanned Maps -->








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
                    <h3 class="border-bottom border-gray pb-2">Approval/Vetting</h3>
                   <div class="row">


					<div class="col-lg-12">
						<!-- Example Pie Chart Card-->
						<div class="card mb-10">
						  <div class="card-header">
							Motherfile Details</div>
						  <div class="card-body">
							<form id="frmSearchMotherfile"  method="post">
								<div class="custom-control custom-radio custom-control-inline">
								  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input" value="job_number" required>
								  <label class="custom-control-label" for="rbtn_search_type1">Job number/Certificate Number</label>
								</div>
							  
							  <br><br>
							  <div class="form-group">
								<div class="form-row">
								<!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
								  <div class="col-md-8">
									
									<input class="form-control" id="enq_search_value"  name="enq_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
								  </div>
								  <div class="col-md-4">
									  
									<button type="submit" class="btn btn-primary btn-block" value="Search" id="btnEnquiryJobSearch" > Search </button>
									
								  </div>
								</div>
							  </div>
							</form>

							<div class="row">
								<div class="col-lg-12">
									 <!-- Example Bar Chart Card-->
									 <div class="card mb-3" style="display:none" id="enq-search-results-section">
									   <div class="card-header">
										 <i class="fa fa-bar-chart"></i>Search Results</div>
									   <div class="card-body">
									   
									
									   
											<!--  Here is where the fee list comes -->
											
											<div class="table-responsive" >
												  <table class="table table-bordered " id="enq-search-results-table" style="min-height:500px">
													 <thead>
													   <tr>
														<th>Applicant Name</th>
														 <th>Case Number</th>
														 <th>Job Number</th>
														 <th>Locality</th>
														 
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
									 
								<!-- Example Bar Chart Card-->
									 
								   
							   
								  </div>
								   
								 </div>
						  
						</div>
					   
					  </div>
					<!--   Here is the end of right table -->
				
					</div>

 
					<div class="col-lg-12">
						<!-- Example Pie Chart Card-->
						<div class="card mb-10">
						  <div class="card-header">
							Land/Interest Transfer</div>
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
	 

		  <div class="form-row">  <label for="bl_job_purpose">Extent Interest</label>

		 <select name="lc_intended_interest" id="lc_intended_interest" data-live-search="true" data-none-results-text="I found no results" title="Please select Letter type" class="form-control selectpicker">
			  <option disabled selected value="">-- select --</option>
			  <option value="Whole Interest">Whole Interest</option>
			  <option value="Part of Interest">Part of Interest</option>
						  
							  
						  </select>
		  </div>
		   </div>

		   <div class="form-group">
	 

			  <div class="form-row">  <label for="bl_job_purpose">Extent Land</label>
			 <select name="lc_intended_land" id="lc_intended_land" data-live-search="true" data-none-results-text="I found no results" title="Please select Letter type" class="form-control selectpicker">
				  <option disabled selected value="">-- select --</option>					
				  <option value="Whole Parcel">Whole Parcel</option>
				  <option value="Part of parcel">Part of parcel</option>
							  
								  
							  </select>
			  </div>
			   </div>
						  
						 
						  
						  <div class="form-row">
							
							
						   <form action=""  method="post">
									  <input type="hidden" id="ip_case_number" name="case_number" value="${transaction_number}" >
									  <input type="hidden" id="ip_job_number" name="job_number" value="${job_number}" >
									  <!-- <input type="hidden" id="request_type" name="request_type" value="request_to_generate_inspection_letter"> -->
										<div class="form-group">
								
								<!-- <div class="col-md-12"> -->
									
									  <button type="button" id="add_intended_interest_and_parcel_to_transaction" class="btn btn-primary btn-block"><i class="fa fa-save mr-1"></i>Save</button>
									  
									  <!-- </div> -->
								  </div>
								  
							  </form>
						  </div>
						  
						  
						  
						  
						  
						   
						  
						  
						</div>
						
						
						
						
					   
						
						
						
					 
						  <!-- The form Ends Hers -->
						  
						</div>
					   
					  </div>
					<!--   Here is the end of right table -->
				
					</div>
      
				      
				       <!--   Here is the right Table -->

					   <div class="col-lg-12">
						<!-- Example Pie Chart Card-->
						<div class="card mb-10">
						  <div class="card-header">
							Approval/Vetting</div>
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
									  <input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
									  <input type="hidden" id="job_number" name="job_number" value="${job_number}" >
									  <input type="hidden" id="request_type" name="request_type" value="request_to_generate_inspection_letter">
										<div class="form-group">
								
								<!-- <div class="col-md-12"> -->
									
									  <input type="submit" class="btn btn-primary btn-block" value="Generate Letter" />  
									  
									  <!-- </div> -->
								  </div>
								  
							  </form>
						  </div>
						  
						  
						  
						  
						  
						   
						  
						  
						</div>
						
						
						
						
					   
						
						
						
					 
						  <!-- The form Ends Hers -->
						  
						</div>
					   
					  </div>
					<!--   Here is the end of right table -->
				
					</div>

					<!-- <div class="row mt-3"> -->
						<div class="col-lg-12">
								<!-- Example Pie Chart Card-->
								<div class="card mb-3">
									<div class="card-header">
										<i class="fa fa-pie-chart"></i>Polygon
									</div>
									<div class="card-body">
										<!--  The Form starts here -->
										   <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
								
											<!-- Maps Details Starts Here  -->
											
											<div class="form-group">
												<div class="form-row">  <label for="lc_fr_bl_wkt_polygon">WKT Polygon</label>
													<input class="form-control" id="lc_ap_bl_wkt_polygon"  name="lc_fr_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" >
													<!-- <textarea rows="2" class="form-control" placeholder="" id="lc_bl_wkt_polygon" ></textarea> -->
												</div>
											</div>
											<div class="bs-example">
												<div class="btn-group mr-2">
													<button type="button" class="btn btn-primary"  id="lc_btn_ap_visualise_wkt" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
														<i class="fa fa-map"></i>
													</button>
													<!--  
													<button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
													<i class="fa fa-save"></i>
													</button>
													-->
			
													<button type="button" class="btn btn-primary" id="lc_btn_ap_visualise_search" data-placement="top" data-toggle="tooltip" title="Visualise Search">
													<i class="fa fa-object-ungroup"></i>
													</button>
													<!--        
													<button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
													<i class="fa fa-print"></i>
													</button> -->
												</div> 
											</div>
											<div id="lcfap-map"></div> 
										   </form>
									 
										 <!-- The form Ends Hers -->
									 
									  </div>
			
								</div>
								<!--   Here is the end of right table -->
			
							</div>
						<!-- </div> -->

 </div>
                </div>
               
                
                <!-- <div id="53ab3caa7e7d11ef98b51e576becd20e-3" class="">
                    <h3 class="border-bottom border-gray pb-2">Title Plan</h3>
                       <div class="row">
				        <div class="col-lg-12">
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
				                   <label for="search_value">LTR Plan No.</label>
				                <input class="form-control" id="txt_lc_ltr_plan_no"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${ltr_plan_no}" >
				              
				                 
				               </div>
				             
				            </div>
				            
				                <div class="form-row">
				              <div class="col-md-4">
				                <label for="search_value">Registry Map No</label>
				                <input class="form-control" id="txt_lc_registry_mapref"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${registry_mapref}" >
				              </div>
				              
				               <div class="col-md-4">
				                <label for="search_value">CC No.</label>
				                <input class="form-control" id="txt_lc_cc_no"  name="search_value"  type="text" aria-describedby="nameHelp" placeholder="Enter Term" value="${cc_no}" >
				              </div>
				              
				             
				            </div>
				            
						         
						        
				        </form>
				
				            
				          </div>
				         
				        </div>
				  
				      </div>
				      
				     
				     </div>
				     
				     
				                     <div class="row">
				        <div class="col-lg-12">
				          <div class="card mb-3">
				            <div class="card-header">
				              <i class="fa fa-pie-chart"></i>Title Plan Preparation</div>
				            <div class="card-body">
				              <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
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
				            
				          </div>
				         
				        </div>
				  
				      </div>
				      

				     </div>
				     
				     
				     
                   </div> -->


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
               
				   <div id="53ab3caa7e7d11ef98b51e576becd20e-5" class="">
                    <h3 class="border-bottom border-gray pb-2 mt-5">Link Application to Mother File</h3>

						
						 <div class="row">
							<div class="col-lg-12">
								<!-- Example Pie Chart Card-->
								<div class="card mb-10">
								  <div class="card-header">
									Motherfile Details</div>
								  <div class="card-body">
									<form id="linkSearchMotherfile"  method="post">
										<div class="form-group">
										<div class="custom-control custom-radio custom-control-inline">
											<input type="radio" id="rbtn_search_type3" name="link_search_type" class="custom-control-input" value="job_number" required>
											<label class="custom-control-label" for="rbtn_search_type3">Job number</label>
										  </div>
										  <div class="custom-control custom-radio custom-control-inline">
											<input type="radio" id="rbtn_search_type4" name="link_search_type" class="custom-control-input" value="certificate_number" required>
											<label class="custom-control-label" for="rbtn_search_type4">Certificate Number</label>
										  </div>
										</div>
									  <br>
									  <div class="form-group">
										<div class="form-row">
										<!-- <label for="search_value">Search  by Case Number / Regional Number / Applicant Name / Job number /GLPIN</label> -->
										  <div class="col-md-8">
											
											<input class="form-control" id="link_search_value"  name="link_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
										  </div>
										  <div class="col-md-4">
											  
											<button type="submit" class="btn btn-primary btn-block" value="Search" id="btnEnquiryJobSearch" > Search </button>
											
										  </div>
										</div>
									  </div>
									</form>
		
									<div class="row">
										<div class="col-lg-12">
											 <!-- Example Bar Chart Card-->
											 <div class="card mb-3" style="display:none" id="53ab3caa7e7d11ef98b51e576becd20e-search-results-section">
											   <div class="card-header">
												 <i class="fa fa-bar-chart"></i>Search Results</div>
											   <div class="card-body">
											   
											
											   
													<!--  Here is where the fee list comes -->
													
													<div class="table-responsive" >
														  <table class="table table-bordered " id="53ab3caa7e7d11ef98b51e576becd20e-search-results-table" style="min-height:500px">
															 <thead>
															   <tr>
																<th>Applicant Name</th>
																 <th>Case Number</th>
																 <th>Job Number</th>
																 <th>Locality</th>
																 
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
											 
										<!-- Example Bar Chart Card-->
											 
										   
									   
										  </div>
										   
										 </div>
								  
								</div>
							   
							  </div>
							<!--   Here is the end of right table -->
						
							</div>
						
						      
						      
						      
						       <!--   Here is the right Table -->
						        <div class="col-lg-12">
						          <!-- Example Pie Chart Card-->
						          <div class="card mb-3">
						            <div class="card-header">
						              <i class="fa fa-pie-chart"></i>Link Application to Mother File</div>
						            <div class="card-body">
						               <!--  The Form starts here -->
						              
		
					
					        <div class="row">
								<div class="form-group">
							  <div class="custom-control custom-radio custom-control-inline">
								<input type="radio" id="rbtn_search_type5" name="rbtn_search_type" class="custom-control-input" value="job_number" required>
								<label class="custom-control-label" for="rbtn_search_type5">Job number</label>
							  </div>
							  <div class="custom-control custom-radio custom-control-inline">
								<input type="radio" id="rbtn_search_type6" name="rbtn_search_type" class="custom-control-input" value="certificate_number" required>
								<label class="custom-control-label" for="rbtn_search_type6">Certificate Number</label>
							  </div>
							  <br>
							  </div>
							</div>

							  <div class="row">
						                                                        
			            <div class="col-md-6">
			                <div class="form-group">
			                  
			        	  <input class="form-control" id="lrd_search_for_mother_transction_to_child"  name="lrd_search_for_mother_transction_to_child"  type="text" value="" placeholder="Job Number of the Mother File" required >
						   
			                </div>
			            </div>
			
			          
			          <!-- <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="pvlmd_btn_search_by_certificate_number" data-placement="top" data-toggle="tooltip" title="Show Location"><i class="fa fa-retweet"></i> </button>
			            
			                </div>
			            </div> -->
			            
			            <div class="col-md-2">
			                <div class="form-group">
			                 <button type="button" class="btn btn-primary" id="lrd_btn_search_for_mother_transction_to_child" data-placement="top" data-toggle="tooltip" title="Search">Link</button>
			            
			                </div>
			            </div>
			            
			
			        </div>
			        
			        
			        
			          <h3 class="border-bottom border-gray pb-2">Root of Title</h3>
                
                
                
                  <h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
				  <!-- <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
					<i class="fa fa-plus-circle"></i>
				</button> -->
                     
               	  <div  class="table w-auto small table-responsive">
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
			                    <!-- <th>Action</th> -->
			                    <!-- <th>Approve</th> -->
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


				                    

									<!-- <td class="${proprietorship_section.edit == 1 ? 'd-none' : ''}">
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
									</td> -->
				                    
				                    	
				                    
				                     
				                    
				                    </tr>
				            	</c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div>
			          
			          
			          
			          
			      
			          
			          <!-- <h5 class="border-bottom border-gray pb-2">Valuation Details</h5>
			       <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newValuationModal" data-toggle="tooltip" title="Add New Valuation Records">
		            <i class="fa fa-plus-circle"></i>
		        </button>
                     
               	  <div  class="table table-responsive w-auto small">
			           <table class="table table-bordered" id="lrd_valuation_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>Date of Valuation</th>
			                 <th>Amount</th>
			                 <th>Remarks</th>
			                 <th>Action</th>
			                  
			                  </tr>
			              </thead>
			              
			                <tbody>
			     <c:forEach items="${lrd_valuation_section}" var="valuation_section">
                <tr>
                    <td>${valuation_section.vs_date_of_valuation}</td>
                    <td>${valuation_section.vs_amount}</td>
                    <td>${valuation_section.vs_remarks}</td>
                    
                    <td class="${valuation_section.edit == 1 ? 'd-none' : ''}">
						<button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newValuationModal" 
						data-target-id="${valuation_section.vs_id}" 
						data-vs_id="${valuation_section.vs_id}"
						data-vs_case_number="${valuation_section.vs_case_number}"
						data-vs_date_of_valuation="${valuation_section.vs_date_of_valuation}"
						data-vs_amount="${valuation_section.vs_amount}"
						data-vs_remarks="${valuation_section.vs_remarks}"
						data-whatever="edit">
							<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
						</button>
					</td>
                
                     
                    
                    </tr>
            </c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div> -->
			          
			          
			          
			      <!-- <h5 class="border-bottom border-gray pb-2">Certificate Details</h5>
			      <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newCertificateModal" data-toggle="tooltip" title="Add New">
		            <i class="fa fa-plus-circle"></i>
		        </button>
                     
               	  <div  class="table table-responsive w-auto small">
			           <table class="table table-bordered" id="lrd_certificate_details_dataTable">
			           
			              <thead>
			                <tr>
			
			                 <th>Date of Registration</th>
			                 <th>To Whom Issued</th>
			                 <th>Serial Number</th>
			                 <th>Official Notes</th>
			                 <th>Action</th>
			                  </tr>
			              </thead>
			              
			                <tbody>
			     <c:forEach items="${lrd_certificate_section}" var="certificate_section">
                <tr>
                    <td>${certificate_section.cs_date_of_registration}</td>
                    <td>${certificate_section.cs_to_whom_issued}</td>
                    <td>${certificate_section.cs_serial_number}</td>
                    <td>${certificate_section.cs_official_notes}</td>
                    <td class="${certificate_section.edit == 1 ? 'd-none' : ''}">
						<p data-placement="top" data-toggle="tooltip" title="Batch">
							<button class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newCertificateModal" 
							data-target-id="${certificate_section.cs_id}"
							data-cs_id="${certificate_section.cs_id}"
							data-cs_case_number="${certificate_section.cs_case_number}"
							data-cs_official_notes="${certificate_section.cs_official_notes}"
							data-cs_date_of_registration="${certificate_section.cs_date_of_registration}"
							data-cs_to_whom_issued="${certificate_section.cs_to_whom_issued}"
							data-cs_serial_number="${certificate_section.cs_serial_number}"
							>
								<span class="icon text-white-50"> <i class="fas fa-info-circle"></i></span><span class="text">Edit</span>
							</button>
							</p>
					</td>
				   
                    
                     
                    
                    </tr>
            </c:forEach>
			  				</tbody>
			    
			            
			            </table>
			          </div> -->
			          
                
						  
						              
						    
						            
						          </div>
						         
						        </div>
						      <!--   Here is the end of right table -->
						  
						      </div>
						      
						      
						     
			
						      
						     
						
						 </div>
						 
				
               
			  </div>
                
                  <div id="53ab3caa7e7d11ef98b51e576becd20e-6" class="">
                    <h3 class="border-bottom border-gray pb-2">Root of Title</h3>
                
                
                
					<div id="accordion" role="tablist" aria-multiselectable="true">
				
						<div class="card">
							<div class="card-header bg-dark text-white " role="tab"
								id="headingThree"
							>
								<a class="collapsed d-block  text-white " data-toggle="collapse"
									data-parent="#accordion" href="#collapseparties"
									aria-expanded="false" aria-controls="collapseFive"
									style="text-decoration: none !important"
								> <i class="fa fa-chevron-down pull-right"></i> <i
									class="fa fa-users"
								></i>Parties
								</a>
							</div>
							<div id="collapseparties" class="collapse" role="tabpanel"
								aria-labelledby="headingThree" data-parent="#accordion"
							>
								<div class="card-body">
		
		
									<button type="button" class=" float-right btn btn-primary"
										id="lrd_btn_add_grantor" data-placement="top"
										data-toggle="modal" data-target="#addeditpartyGeneral"
										data-toggle="tooltip" title="Add party"
									>
										<i class="fa fa-plus-circle"></i>Add Grantor
									</button>
									
									<button type="button" class=" float-left btn btn-primary"
										id="lrd_btn_add_grantee" data-placement="top"
										data-toggle="modal" data-target="#addeditpartyGeneral"
										data-toggle="tooltip" title="Add party"
									>
										<i class="fa fa-plus-circle"></i>Add Applicant
									</button>
									<br>
									<div class="table-responsive">
										<table class="table table-bordered  table-hover table-sm"
											id="party_details_datatable"
										>
		
											<thead>
												<tr>
		
													<th>Name</th>
													<th>Sex</th>
													<th>Contact</th>
													<th>Role</th>
													<th>Action</th>
												</tr>
											</thead>
		
											<tbody>
												<c:forEach items="${parties}" var="parties_row">
												<tr>
													<td>${parties_row.ar_name}</td>
													<td>${parties_row.ar_gender}</td>
													<td>${parties_row.ar_cell_phone}</td>
													<td>${parties_row.type_of_party}</td>
													<td>
													
													<p data-placement="top"  title="Edit Party">  
														  <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
															   data-target="#addeditpartyGeneral"
															   data-target-id="${parties_row.ar_client_id}"  
															   data-ar_name="${parties_row.ar_name}"
															   data-ar_gender="${parties_row.ar_gender}"
															   data-ar_address="${parties_row.ar_address}"
															   data-ar_cell_phone="${parties_row.ar_cell_phone}"
															   data-ar_cell_phone2="${parties_row.ar_cell_phone2}"
															   data-ar_tin_no="${parties_row.ar_tin_no}"
															   data-ar_id_type="${parties_row.ar_id_type}"
															   data-ar_id_number="${parties_row.ar_id_number}"
															   data-ar_location="${parties_row.ar_location}"
															   data-ar_district="${parties_row.ar_district}"
															   data-type_of_party="${parties_row.type_of_party}"
															   data-ar_region="${parties_row.ar_region}"
															   data-ar_person_type="${parties_row.ar_person_type}"
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
								</div>
							</div>
						</div>
						
						
						<br>
						<div class="card mb-3">
		
							<div class="card-header bg-dark text-white " role="tab"
								id="headingTwo"
							>
								<a class="collapsed d-block  text-white " data-toggle="collapse"
									data-parent="#accordion" href="#collapsedetails"
									aria-expanded="false" aria-controls="collapseTwo"
									style="text-decoration: none !important"
								> <i class="fa fa-chevron-down pull-right"></i> <i
									class="fas fa-list"
								></i>Application Details<span id="job_number_placeholder"></span>
								</a> <span class="col-md-3 float-right ">
									
								</span>
							</div>
							<div select_update_case_information id="collapsedetails"
								class="collapse card-body" role="tabpanel"
								aria-labelledby="headingTwo"  data-parent="#accordion"
							>
								<div class="card-body">
		
									<form id='frmFurtherEntries_only_certificate'>
										<div class="form-row"></div>
										<div class="form-row">
											<div class="col-md-6">
												<div class="form-group">
													<label for="inputEmail4">Job Number</label> <input
														type="text" class="form-control" id="fe_job_number"
														placeholder="Job number" required readonly value="${job_number}"
													>
												</div>
												
												
												<input id="fe_client_name" type=hidden value="${ar_name}" >
												<input id="fe_business_process_sub_name" type=hidden value="${business_process_sub_name}" >
												
												
												<div class="form-group">
													<label for="">Surveyors Number</label> <input type="text"
														class="form-control" id="fe_surveyor_number"
														placeholder="Surveyors Number"    value="${surveyor_number}"
													>
												</div>
												<div class="form-group">
													<label for="">Regional Number</label> <input type="text"
														class="form-control" id="fe_regional_number"
														placeholder="Regional Number"   value="${regional_number}"
													>
												</div>
		
		
												<div class="form-group">
													<label for="">Land Size</label> 
													
													<div class="input-group">
														<div class="input-group-prepend">
														  <span class="input-group-text" id="inputGroupPrepend">Acre</span>
														</div>
														<input value="${size_of_land}" step="0.111" type="text" class="form-control" id="fe_land_size" placeholder="size in Acreage" aria-describedby="inputGroupPrepend" >
														<div class="invalid-feedback">
														  Please enter Land Size.
														</div>
													  </div>
												</div>
		
												<div class="form-group">
													
													
													<label for="">Nature of Instrument</label> <input type="text"
														class="form-control" id="fe_nature_of_instrument"
														   value="${nature_of_instrument}"
													>
												</div>
		
											 <div class="form-group">
					
												<label for="">Type of Use</label> <input type="text"
														class="form-control" id="fe_type_of_use"
														   value="${type_of_use}"
													>
		
												</div>
		
		
												<div class="form-group">
													<label for="">Type of Interest</label> <select value="${type_of_interest}"
														class="form-control" id="fe_type_of_interest" required
													>
														<option >Select Type of Interest</option>
														<option ${type_of_interest=="LEASEHOLD" ? "selected" : ""}>LEASEHOLD</option>
														<option ${type_of_interest=="FREEHOLD" ? "selected" : ""}>FREEHOLD</option>
													</select>
		
		
												</div>
		
												
												<div class="form-group">
													<label for="">Consideration Currency</label> 
													<select class="form-control" id="fe_consideration_currency" required>
														<option value="GHS" ${consideration_fee_currency=="GHS" ? "selected":"" }>Ghana Cedis</option>
														<option value="USD" ${consideration_fee_currency=="USD" ? "selected":"" }>US Dollars</option>
														<option value="GBP" ${consideration_fee_currency=="GBP" ? "selected":"" }>Pound sterling</option>
														<option value="EUR" ${consideration_fee_currency=="EUR" ? "selected":"" }>Euro</option>
													</select>
													
													
												</div>
												<div class="form-group">
													<label for="">Date of Document </label> <input type="date"
														class="form-control " id ="fe_date_of_document" placeholder=""
														required value="${date_of_document}"
													>
												</div>
												<div class="form-group">
													<label for="">Commencement Date</label> <input type="date"
														class="form-control " id ="fe_commencement_date"
														placeholder="" required value="${commencement_date}"
													>
												</div>
												
												<div class="form-group">
													<label for="">Registration Date</label> <input type="date"
														class="form-control " id ="fe_date_of_registration"
														placeholder="" required value="${date_of_registration}"
													>
												</div>
													
												<!-- <div class="form-group">
													<label for="">Date of Issue</label> <input type="date"
														class="form-control " id ="fe_date_of_issue"
														placehoRegilder="" required value="${date_of_issue}"
													>
												</div> -->
												<div class="form-group">
													<label for="">Registered Number</label> <input type="text"
															class="form-control" id="fe_registered_number"
															   value="${registered_number}"
														>
													</div>
											</div>
		
											<div class="col-md-6">
												<div class="form-group">
													<label for="inputEmail4">Case Number</label> <input
														type="text" class="form-control" id="fe_case_number"
														placeholder="Case number" required readonly  value="${case_number}"
													>
												</div>
		
												<div class="form-group">
													<label for="">Locality</label> <input type="text" class="form-control"
														id="fe_locality" required  value="${locality}"
													>
														
		
												</div>
												<div class="form-group">
													<label for="">District</label> <input type="text" class="form-control"
														id="fe_district" required  value="${district}"
													>
														
		
												</div>
												<div class="form-group">
													<label for="">Region</label> <input type="text" class="form-control"
														id="fe_region" required  value="${region}"
													>
														
		
												</div>
		
		
												<div class="form-group">
													<label for="inputEmail4">Term </label> <input type="number"
														class="form-control" id="fe_term" placeholder="Term" value="${term}"
														required
													>
												</div>
												<div class="form-group">
													<label for="">Option to Renew</label> <input type="text"
														class="form-control" id="fe_renewal_term" placeholder=""
														required value="${renewal_term}"
													>
												</div>
												<!-- <div class="form-group">
													<label for="">Lessee's Name</label> <input
														type="text"
														class="form-control"
														id="fe_lessee_name"
														placeholder=""
														required
													>
												</div>
												<div class="form-group">
													<label for="">Lesse's Address</label> <input
														type="text"
														class="form-control"
														id="fe_lessee_address"
														placeholder=""
														required
													>
												</div>
												<div class="form-group">
													<label for="">Grantor's Name</label> <input
														type="text"
														class="form-control"
														id="fe_grantor_name"
														placeholder=""
														required
													>
												</div>
												<div class="form-group">
													<label for="">Grantor's Address</label> <input
														type="text"
														class="form-control"
														id="fe_grantor_address"
														placeholder=""
														required
													> 
												</div>-->
		
												<input type="hidden"
														class="form-control" id="fe_family_name"
														placeholder="Stool/Family Name" required 
													>
												
		
												<input type="hidden"
														class="form-control" id="fe_grantor_family" placeholder=""
														required
													>
		
												<div class="form-group">
													<label for="">Extent</label> <input type="text"
														class="form-control" id="fe_extent" placeholder="" required readonly value="${extent}"
													> 
												</div>
		
		
												<div class="form-group">
												
												
													<label for="">Consideration Fee</label> 
													  <div class="input-group">
														<div class="input-group-prepend">
														  <span class="input-group-text" id="inputGroupPrependConsideration">${consideration_fee_currency}</span>
														</div>
														<input value="${consideration_fee}" type="number" class="form-control" id="fe_consideration_fee"  placeholder="amount in GHS" aria-describedby="inputGroupPrepend" required>
														<div class="invalid-feedback">
														  Please enter Consideration.
														</div>
													  </div>
													
												
												
												</div>
												<div class="form-group">
													
													<label for="">Annual Rent</label> 
													
													<div class="input-group">
														<div class="input-group-prepend">
														  <span class="input-group-text" id="inputGroupPrepend">GHS</span>
														</div>
														<input value="${annual_rent}" type="number" class="form-control" id="fe_annual_rent"  placeholder="amount in GHS" aria-describedby="inputGroupPrepend" required>
														<div class="invalid-feedback">
														  Please enter Rent.
														</div>
													  </div>
												</div>
												
												
												<div class="form-group">
													<label for="inputEmail4">Transaction Number</label> <input
														type="text" class="form-control" id="fe_transaction_number"
														placeholder="Case number" required readonly value="${transaction_number}"
													>
												</div>
		
												<div class="form-group">
													<label for="">File Number</label> <input type="text"
															class="form-control" id="fe_file_number"
															   value="${case_file_number}"
														>
												</div>
		
												<div class="form-group">
													<label for="">Registry Map Ref Number</label> <input type="text"
															class="form-control" id="fe_registry_mapref"
															   value="${registry_mapref}"
														>
												</div>
		
												<div class="form-group">
													<label for="">Certificate Type</label> <input type="text"
															class="form-control" id="fe_certificate_type"
															   value="${certificate_type == 'Individual' ? '' : certificate_type}"
														>
												</div>
		
		
		
											</div>
		
		
										</div>
		
		
		
										<div class="dropdown-divider"></div>
										<div id="alert-display-space"></div>
										<div class="form-group float-right">
		
		
											<button type="reset" id="btnclearFurtherDetails"
												class="btn btn-secondary float-right"
											>Clear Changes</button>
											<span class="float-right">&nbsp;&nbsp;&nbsp;&nbsp;</span>
											<button type="button" id="btnupdateCaseDetailsForCertificate"
												class="btn btn-success float-right"
											>Save Changes</button>
		
										</div>
		
									</form>
		
									
								</div>
								
							</div>
							
						
						<br>
						
						
							<div class="card">
							<div class="card-header bg-dark text-white " role="tab"
								id="headingThree"
							>
								<a class="collapsed d-block  text-white " data-toggle="collapse"
									data-parent="#accordion" href="#collapseaddcertregis"
									aria-expanded="false" aria-controls="collapseFive"
									style="text-decoration: none !important"
								> <i class="fa fa-chevron-down pull-right"></i> <i
									class="fa fa-users"
								></i>Root of Title
								</a>
							</div>
							<div id="collapseaddcertregis" class="collapse" role="tabpanel"
								aria-labelledby="headingThree" data-parent="#accordion"
							>
								<div class="card-body">
		
							 <h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
							<!-- <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
								<i class="fa fa-plus-circle"></i>
							</button> -->
							 
							 <div  class="table w-auto small table-responsive">
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
		
		
										   
											  <!-- <td class="${proprietorship_section.edit == 1 ? 'd-none' : ''}">
													
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
													
											   
										   
										  <%--   <td>
												<p data-placement="top" data-toggle="tooltip" title="Batch">
													<button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#newProprietorshipModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
														<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
													</button>
												</p>
											</td> --%>
											
												
											
											 
											
											</tr>
										</c:forEach>
									  </tbody>
						
								
								</table>
							  </div>
							  
							  
							  
							  
							   <h5 class="border-bottom border-gray pb-2">Memorial Details</h5>
								  <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newMemorialsModal" data-toggle="tooltip" title="Add New Memorial">
							<i class="fa fa-plus-circle"></i>
						</button>
							 
							 <div  class="table w-auto small table-responsive">
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
							  
							  
							  <!-- <h5 class="border-bottom border-gray pb-2">Valuation Details</h5>
						   <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newValuationModal" data-toggle="tooltip" title="Add New Valuation Records">
							<i class="fa fa-plus-circle"></i>
						</button>
							 
							 <div  class="table w-auto small table-responsive">
							   <table class="table table-bordered" id="lrd_valuation_details_dataTable">
							   
								  <thead>
									<tr>
					
									 <th>Date of Valuation</th>
									 <th>Amount</th>
									 <th>Remarks</th>
									 <th>Action</th>
									  
									  </tr>
								  </thead>
								  
									<tbody>
						 <c:forEach items="${lrd_valuation_section}" var="valuation_section">
						<tr>
							<td>${valuation_section.vs_date_of_valuation}</td>
							<td>${valuation_section.vs_amount}</td>
							<td>${valuation_section.vs_remarks}</td>
							
							 <td>
													
													<p data-placement="top"  title="Edit">  
														  <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
															   data-target="#newValuationModal"
															   data-target-id="${valuation_section.vs_id}"
															   data-vs_id="${valuation_section.vs_id}"  
															   data-vs_case_number="${valuation_section.vs_case_number}"
															   data-vs_date_of_valuation="${valuation_section.vs_date_of_valuation}"
															   data-vs_amount="${valuation_section.vs_amount}"
					 
															   data-vs_remarks="${valuation_section.vs_remarks}"
															   > 
																	   
																	   
															  <span class="icon text-white-50"> 
															  <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
													  </p>
													
													</td>
						   
						  <%--  <td><form  action="${pageContext.request.contextPath}/registration_application_progress_details"   method="post" target="_blank" id="downloadForm"><input type="hidden" name="case_numer" id="case_number" value="${valuation_section.vs_id}"> <input type="hidden" name="job_number" id="job_number" value="${appfiles.job_number}"><input type="submit" name="save" class="btn btn-info btn-icon-split" value="Work"/></form></td>
							--%> 
								
							
							 
							
							</tr>
					</c:forEach>
									  </tbody>
						
								
								</table>
							  </div> -->
							  
							  
							  
						  <!-- <h5 class="border-bottom border-gray pb-2">Certificate Details</h5>
							  <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newCertificateModal" data-toggle="tooltip" title="Add New">
							<i class="fa fa-plus-circle"></i>
							</button>
							 <div class= "clear"></div><br>
							 <div  class="table w-auto small table-responsive">
							   <table class="table table-bordered" id="lrd_certificate_details_dataTable">
							   
								  <thead>
									<tr>
					
									 <th>Date of Issue</th>
									 <th>To Whom Issued</th>
									 <th>Serial Number</th>
									 <th>Official Notes</th>
									 
									   <th>Action</th>
									  </tr>
								  </thead>
								  
									<tbody>
						 <c:forEach items="${lrd_certificate_section}" var="certificate_section">
						<tr>
							<td>${certificate_section.cs_date_of_registration}</td>
							<td>${certificate_section.cs_to_whom_issued}</td>
							<td>${certificate_section.cs_serial_number}</td>
							<td>${certificate_section.cs_official_notes}</td>
							<td class="${certificate_section.edit == 1 ? 'd-none' : ''}">
													
													<p data-placement="top"  title="Edit">  
														  <button class="btn btn-secondary btn-icon-split" data-title="Edit"  data-toggle="modal"
															   data-target="#newCertificateModal"
															   data-target-id="${certificate_section.cs_id}"
															   data-cs_id="${certificate_section.cs_id}"  
															   data-cs_case_number="${certificate_section.cs_case_number}"
															   data-cs_date_of_registration="${certificate_section.cs_date_of_registration}"
															   data-cs_to_whom_issued="${certificate_section.cs_to_whom_issued}"
															   data-cs_serial_number="${certificate_section.cs_serial_number}"
		
															   data-cs_official_notes="${certificate_section.cs_official_notes}"
															   > 
																	   
																	   
															  <span class="icon text-white-50"> 
															  <i class="fas fa-pen"></i></span> <span class="text">Edit</span>  </button>
													  </p>
													
													</td>   
								
							
							 
							
							</tr>
					</c:forEach>
									  </tbody>
						
								
								</table>
							  </div> -->
							  
						
						
						
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
						
							   
						
						
						
		
								</div>
							</div>
						</div>
						<br>
						
		
			<div class="card">
							<div class="card-header bg-dark text-white " role="tab"
								id="headingThree"
							>
								<a class="collapsed d-block  text-white " data-toggle="collapse"
									data-parent="#accordion" href="#collapseencumbrances"
									aria-expanded="false" aria-controls="collapseFive"
									style="text-decoration: none !important"
								> <i class="fa fa-chevron-down pull-right"></i> <i
									class="fa fa-users"
								></i>Encumberances Details
								</a>
							</div>
							<div id="collapseencumbrances" class="collapse" role="tabpanel"
								aria-labelledby="headingThree"  data-parent="#accordion"
							>
								<div class="card-body">
		
		  <h5 class="border-bottom border-gray pb-2">Encumberances Details</h5>
							  <button type="button" class="btn btn-primary pull-right" style="margin-bottom:5px"  data-placement="top" data-toggle="modal" data-target="#newEncumberancesModal" data-toggle="tooltip" title="Add New">
							<i class="fa fa-plus-circle"></i>
							</button>
							 <div class= "clear"></div><br>
									  <div  class="able w-auto small table-responsive">
								   <table class="table table-bordered" id="lrd_registration_encumbrance_dataTable">
								   
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
												<td>
													<button class="btn btn-secondary btn-icon-split" 
													data-toggle="modal"
													data-target="#newEncumberancesModal"
													data-es_id="${lrd_encumbrances_section_row.es_id}"
													data-es_case_number="${lrd_encumbrances_section_row.es_case_number}"
													data-es_registered_number="${lrd_encumbrances_section_row.es_registered_number}"
													data-es_date_of_registration="${lrd_encumbrances_section_row.es_date_of_registration}"
													data-es_date_of_instrument="${lrd_encumbrances_section_row.es_date_of_instrument}"
													data-es_back="${lrd_encumbrances_section_row.es_back}"
													data-es_forward="${lrd_encumbrances_section_row.es_forward}"
													data-es_remarks="${lrd_encumbrances_section_row.es_remarks}"
													data-es_memorials="${lrd_encumbrances_section_row.es_memorials}"
													data-es_signature="${lrd_encumbrances_section_row.es_signature}"
													data-es_entry_number="${lrd_encumbrances_section_row.es_entry_number}"
													data-es_action_on_form_encumbrances="edit"
													>
													<span class="icon text-white-50"> 
														<i class="fas fa-pen"></i></span> <span class="text">Edit</span>
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
		
		
						
						<!-- <div class="card">
							
							<div id="collapseparties" class="collapse" role="tabpanel"
								aria-labelledby="headingThree"
							>
								<div class="card-body">
		
									<button class="btn btn-success btn-icon-split pull-right " id="btnViewBatchlist">
										<span class="icon text-white-50"> <i class="fas fa-eye"></i></span>
										<span class="text">View Batch List</span>
									</button>
									
									<button class="btn btn-info btn-icon-split pull-left" id="btnLinktoExistingCaselist">
										<span class="icon text-white-50"> <i class="fas fa-plus"></i></span>
										<span class="text" >Link Existing Case</span>
									</button>
								</div>
							</div>
						</div>
						<br> -->
						
							
							<br>
											
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
								></i>Generate Certificate and Land Register
								</a>
							</div>
							<div id="collapseprecertregis" class="collapse" role="tabpanel"
								aria-labelledby="headingThree" data-parent="#accordion"
							>
								<div class="card-body">
		
							
				  
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
										<label for="search_value">Registration District</label>
										<input class="form-control" id="txt_new_lc_registration_district_number" type="text" aria-describedby="nameHelp"  value="${registration_district_number}" >
									  </div>
										<div class="col-md-4">
										<label for="search_value">Registration Section</label>
										<input class="form-control"  id="txt_new_lc_registration_section_number" type="text" aria-describedby="nameHelp"  value="${registration_section_number}" >
									  </div>
										<div class="col-md-4">
										<label for="search_value">Registration Block</label>
										<input class="form-control" id="txt_new_lc_registration_block_number"  type="text" aria-describedby="nameHelp"  value="${registration_block_number}" >
									  </div>
									 
									</div>
									
<!-- 									   
										<div class="form-row">
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
										  
												<button type="button" class=" float-right btn btn-primary"
													id="lrd_btn_add_grantor" data-placement="top"
													data-toggle="modal" data-target="#frmlrdtitleplanupdatemodal"
													data-toggle="tooltip" data-backdrop="static" 
													data-transaction_number="${transaction_number}" 
													data-job_number="${job_number}" 
													data-case_number="${case_number}" 
													data-business_process_sub_name="${business_process_sub_name}"
												
													title="Add Other Details">
													<i class="fa fa-plus-circle"></i>Add Other Detail
												</button>
										</div> 
									 
									</div>
								  
									 -->
									   
									  
									
									<!-- The form Ends Hers -->
									
								  </div>
								 
								</div>
							  <!--   Here is the end of right table -->
						  
						</div>
		
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
												  <br><br>
												
		 
		 
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
													
													  
													<div class="col">
															  <br><br>
															 <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
											<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
												<input type="hidden" id="job_number" name="job_number" value="${job_number}" >
												<input type="hidden" id="request_type" name="request_type" value="request_to_generate_register_unsigned">
												 <div class="form-group">
										   
											
											  
												<input type="submit" class="btn btn-primary btn-block" value="Generate Register" />  
										   
										  </div>
										</form>
													
													</div>
													
													
													 
													
												  </div>
												
		
		
								</div>
							</div>
						</div>
						<br>
						</div>
		
						<!-- Example Bar Chart Card-->
		
		
		
		
					</div>
		
		
			          
                
                
				</div>
                
               
               
               
               
                <div id="53ab3caa7e7d11ef98b51e576becd20e-7" class="">
					<h3 class="border-bottom border-gray pb-2">Final Approval of Registration</h3>
               
                      
							
						<h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
						<!-- <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
							<i class="fa fa-plus-circle"></i>
						</button> -->
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


									
										<!-- <td class="${proprietorship_section.edit == 1 ? 'd-none' : ''}">
											<p data-placement="top" data-toggle="tooltip" title="Batch">
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
											</p>
										</td>
										
											
										<td class="${proprietorship_section.edit == 1 ? 'd-none' : ''}">
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
										</td> -->
										
										
										</tr>
									</c:forEach>
								</tbody>
					
							
							</table>
						</div>
						
						</div>  

						<div class="card mb-5">
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
												  
												  <div class="col-auto">
														  <br>									                 
															   
																   <button type="button" name="btn_compose_register_description" id="btn_compose_register_description_2" class="btn  btn-primary btn-icon-split "  >
																<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
															</button>
															
														
													</div>
													
													 <div class="col">
															  <br>
															
															   <button type="button" name="lc_btn_save_register_description" id="lc_btn_save_register_description_2" 
															   class="btn btn-block btn-secondary btn-icon-split "  >
																 <span class="icon text-white-50"> <i class="fas fa-upload"></i></span><span class="text">Save</span>
															</button>
													
													</div>
													
												  
												  </div>
												  <br></br>
												
		 
		 
				   <div class="form-row">
												  <div class="col-md-12">
													<label for="search_value">Certificate Summary</label>
													 
													
													 
														<textarea id="lc_search_report_summary_details_2" name="lc_search_report_summary_details" class="form-control col-sm-12" required rows=7  style="padding:50px !important;">${remark_or_comment} </textarea> 
													
													
												   <%--  <input class="form-control" id="lc_search_report_summary_details"  name="lc_search_report_summary_details"  type="text" aria-describedby="nameHelp" rows=7 value="${remark_or_comment}" >
									 --%>
																				
													</div>
													
												   
												 
												</div>
												
												
												
												 
												<div class="form-row">
												  
												  <div class="col-auto">
														  <br><br>									                 
															   
																   <button type="button" name="btn_compose_certificate_template" id="btn_compose_certificate_template_2" class="btn  btn-primary btn-icon-split "  >
																<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Compose Template</span>
															</button>
															
														
													</div>
													
													 <div class="col">
															  <br><br>
															
															   <button type="button" name="lc_btn_save_search_report" id="lc_btn_save_search_report_2" 
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
													<select name="lc_txt_type_of_certificate" id="lc_txt_type_of_certificate" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
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

		<div class="row mt-2 mb-2">
					                                                        
            <div class="col-md-8">
                <div class="form-group">
                  
                       		 
			
              <select name="geoserverscannedimages_list" id="geoserverscannedimages_list" class="form-control input-sm" data-style="btn-info"  data-live-search="true">
              <option value="-1">No Scanned Image</option>
                <!-- <option value="csau_geospatial:108_PART_1_modified:[1173152.85826898,342671.514293023,1179683.69808146,347057.607642237]">csau_geospatial:108_PART_1_modified</option> -->
                <!-- 2450;1173152.85826898;1179683.69808146;342671.514293023;347057.607642237;"EPSG:2136" -->
              </select> 
                </div>
            </div>

            <div class="col-md-1">
                <div class="form-group">
                 <button type="button" class="btn btn-primary w-100" id="lrd_btn_search_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="search_for_scanned_maps"><i class="fa fa-search"></i> </button>
            
                </div>
            </div>
             <div class="col-md-1">
                <div class="form-group">
                 <button type="button" class="btn btn-primary w-100" id="lrd_btn_load_for_scanned_maps" data-placement="top" data-toggle="tooltip" title="Show Scanned Map"><i class="fa fa-check-circle"></i> </button>
            
                </div>
            </div>

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