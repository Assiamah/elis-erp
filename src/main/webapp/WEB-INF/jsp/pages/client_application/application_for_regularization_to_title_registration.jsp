 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>

<<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                <!-- <li><a href="#link-1">Coordinate Entry<br /><small>Coordinate Entry</small></a></li> -->
                <li><a href="#link-1">Record Verification<br /><small>Record Verification</small></a></li> 
                <li><a href="#link-2">Vetting and Approval<br /><small>Vetting and Approval</small></a></li>
				<li><a href="#link-3">Preparation of Offer Letter and Payment<br /><small>Preparation of Offer Letter and Payment</small></a></li>
                <li><a href="#link-4">Preparation of Lease<br /><small>Preparation of Lease</small></a></li>
				<li><a href="#link-5">Execution of Lease, Sealing and Indexing<br /><small>Execution of Lease, Sealing and Indexing</small></a></li>
				<li><a href="#link-6">Stamping of Lease Document<br /><small>Stamping of Lease Document</small></a></li>
				<li><a href="#link-7">Link Application to Mother File<br /><small>Link Application to Mother File</small></a></li>
				<li><a href="#link-8">Preparation of Certificate and Register<br /><small>Preparation of Certificate and Register</small></a></li>
				<li><a href="#link-9">Signing of Certificte and Register<br /><small>Signing of Certificte and Register</small></a></li>
                <li><a href="#link-10">Final Approval and Activation<br /><small>Final Approval and Activation</small></a></li>
             
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
			

			
						<div id="link-2" class="">
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
									
											  
										   
										   
											  
											  
											
											<!-- The form Ends Hers -->
											
										  </div>
										 
										</div>
									  <!--   Here is the end of right table -->
								  
									  </div>
									  
									  
									 
									  
									  
									 
								
								 </div>
								 
								 
		 
		 
						</div>
					   

						<div id="link-3" class="">
							<h3 class="border-bottom border-gray pb-2">Offer Preparation</h3>
						   <div class="row">
		
		 
			  
			  
							  
							   <!--   Here is the right Table -->
								<div class="col-lg-12">
								  <!-- Example Pie Chart Card-->
								  <div class="card mb-10">
									<div class="card-header">
									  <i class="fa fa-pie-chart"></i> Preparation of Offer Letter and Payments</div>
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
			   
				<!-- <div class="form-row">  
					<label for="bl_job_purpose">Type of Letter</label>
			   <select name="lc_letter_type" id="lc_letter_type" data-live-search="true" data-none-results-text="I found no results" title="Please select Letter type" class="form-control selectpicker">
									<option value="Existing GARRO Layer">Offer Letter</option>
									
									
								</select>
				</div> -->
<!-- 
				<button type="button"
				class="btn btn-primary"
				id="lc_btn_generate_lease_express_offer_letter" data-placement="top" >
				<span class="icon text-white-50"> <i class="fa fa-plus-circle"
				></i></span><span class="text">Generate Offer Fees</span>
			</button> -->
				 </div>
									
								   
									
									<div class="form-row">
									  
									  
									 <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
												<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
												<input type="hidden" id="case_number" name="job_number" value="${job_number}" >
												<input type="hidden" id="request_type" name="request_type" value="request_to_generate_offer_letter_external">
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
					   
						<div id="link-4" class="">
							<h3 class="border-bottom border-gray pb-2">Preparation of Lease</h3>
						   <div class="row">
		
		 
			  
			  
							  
							   <!--   Here is the right Table -->
								<div class="col-lg-12">
								  <!-- Example Pie Chart Card-->
								  <div class="card mb-10">
									<div class="card-header">
									  <i class="fa fa-pie-chart"></i> Lease Preparation</div>
									<div class="card-body">
									   <!--  The Form starts here -->
								   
						
										  <div class="form-group">
								   
									
										   
	
				 
				 
									
								   
									
									<div class="form-row">
									  
									  
									 <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
												<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
												<input type="hidden" id="job_number" name="job_number" value="${job_number}" >
												<input type="hidden" id="request_type" name="request_type" value="request_to_generate_lease_document">
												  <div class="form-group">
										  
										  <div class="col-md-12">
											  
												<input type="submit" class="btn btn-primary btn-block" value="Generate Lease Document" />  
												
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
				<h3 class="border-bottom border-gray pb-2">Execution of Lease, Sealing and Indexing</h3>
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
		   

			  <div id="link-6" class="">
				<br>
			   <h3 class="border-bottom border-gray pb-2">Stamping of Lease Document</h3>
			  
	  
			  </div>
			 
			  <div id="link-7" class="">
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
										 <div class="card mb-3" style="display:none" id="link-search-results-section">
										   <div class="card-header">
											 <i class="fa fa-bar-chart"></i>Search Results</div>
										   <div class="card-body">
										   
										
										   
												<!--  Here is where the fee list comes -->
												
												<div class="table-responsive" >
													  <table class="table table-bordered " id="link-search-results-table" style="min-height:500px">
														 <thead>
														   <tr>
															<th>Applicant Name</th>
															 <th>Certificate Number</th>
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
			
			  <div id="link-8" class="">
				<h3 class="border-bottom border-gray pb-2">Preparation of Certificate and Register</h3>
			   
			   
			   
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
			   
			  
			 


			  <div id="link-9" class="">
				<h3 class="border-bottom border-gray pb-2">Signing of Certificte and Final Approval of Registration</h3>
		   
				  
					 
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


				  
				 
		  </div>
		   
		   
			 
			  <div id="link-10" class="">
				<br>
			   <h3 class="border-bottom border-gray pb-2">Final Approval and Activation</h3>
			  
	  
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
     
