
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>


<jsp:include
	page="../client_application/_application_process_header.jsp"></jsp:include>
<!-- wizard start wizard end -->


<!-- smartwizardfirstregistration html -->
<div id="smartwizardfirstregistration">
	<ul class="d-none">

		<!-- <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Upload file at CSAU Back Office<br />
			<small>Upload file at CSAU Back Office</small></a></li> -->
		<li><a href="#53ab3caa7e7d11ef98b51e576becd20e-1">Quality Control at EX (Generate polygon and GLPIN)<br />
			<small>Quality Control at EX (Generate polygon and GLPIN)</small>
		</a></li>
		<li><a href="#53ab3caa7e7d11ef98b51e576becd20e-2">Quality Control at Cartographic and GIS Section<br />
			<small>Quality Control at Cartographic and GIS Section</small>
		</a></li>
		<!-- <li><a href="#53ab3caa7e7d11ef98b51e576becd20e-4">Request Surveyor's Signature<br />
			<small>Request Surveyor's Signature</small></a></li> -->
		<li><a href="#53ab3caa7e7d11ef98b51e576becd20e-3">Signature by the Regional Head<br />
			<small>Signature by the Regional Head</small></a></li>
		<li><a href="#53ab3caa7e7d11ef98b51e576becd20e-4">Generate Barcode on Plan<br />
			<small>Generate Barcode on Plan</small></a></li>


	</ul>

	<div>


		<%-- <div id="53ab3caa7e7d11ef98b51e576becd20e-1" class="">
			<h3 class="border-bottom border-gray pb-2">Upload Scan Documents</h3>



			<button type="button" class="btn btn-primary" data-placement="top"
				data-toggle="modal" data-target="#fileUploadModal"
				data-toggle="tooltip" title="Add Files">
				<i class="fa fa-plus-circle"></i>
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


			<div class="table-responsive">
				<table class="table table-bordered  table-hover table-sm"
					id="lc_scanned_documents_dataTable" width="100%" cellspacing="0">

					<thead>
						<tr>

							<th>Document Name</th>
							<th>Document Type</th>
							<th>Document Path</th>
							<th>Open File</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${casescanneddocuments}"
							var="casescanneddocuments_row">
							<tr>
								<td>${casescanneddocuments_row.document_name}</td>
								<td>${casescanneddocuments_row.document_type}</td>
								<td>${casescanneddocuments_row.document_extention}</td>

								<td>
									<form action="registration_application_progress_details"
										method="post">
										<input type="hidden" name="document_path" id="document_path"
											value="${casescanneddocuments_row.document_file}">
										<button type="submit" name="save"
											class="btn btn-info btn-icon-split">
											<span class="icon text-white-50"> <i
												class="fas fa-folder-open"></i></span><span class="text">Work</span>
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


		</div> --%>



		<div id="53ab3caa7e7d11ef98b51e576becd20e-1" class="">
			<h3 class="border-bottom border-gray pb-2">Quality Control at EX
				(Generate polygon and GLPIN)</h3>


			<div class="row">
				<!--   Here is the right Table -->
				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Quality Control at EX (Generate
							polygon and GLPIN)
						</div>
						<div class="card-body">
							<!--  The Form starts here -->


							<form
								action="${pageContext.request.contextPath}/processing_after_payment"
								method="post">




	            
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

							</form>

							<!-- The form Ends Hers -->


							<div class="btn-group mr-2">
								<button type="button" class="btn btn-primary"
									id="lc_btn_add_coordinate" data-placement="top"
									data-toggle="modal" data-target="#addcoordinatetoplot"
									data-toggle="tooltip" title="Add New Coordinate">
									<i class="fa fa-plus-circle"></i>
								</button>


								<button type="button" class="btn btn-primary"
									id="lrd_btn_add_coordinate_by_csv" data-placement="top"
									data-toggle="modal" data-target="#uploadcoordiantecsv"
									data-toggle="tooltip" title="Upload CSV">
									<i class="fa fa-upload"></i>
								</button>


								<button type="button" class="btn btn-primary"
									id="lc_btn_visualise_coordinate" data-placement="top"
									data-toggle="tooltip" title="Visualise Polygon">
									<i class="fa fa-object-group"></i>
								</button>

								<button type="button" class="btn btn-primary"
									id="btn_lc_save_parcel_for_search"
									data-placement="top" data-toggle="tooltip" title="Save Polygon">
									<i class="fa fa-save"></i>
								</button>

							</div>
							<div class="table w-auto small">
								<table class="table table-bordered" id="coordinatelis_Table"
									width="100%" cellspacing="0">

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

				<div class="col-lg-8">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Records Information
						</div>
						<div class="card-body">
							<!--  The Form starts here -->


							<form
								action="${pageContext.request.contextPath}/processing_after_payment"
								method="post">

								<div class="form-group">


									<!--  Here is where the fee list comes -->






									<!--  WKT row here -->
									<div class="form-group">

										<div class="form-row">
											<label for="bl_job_purpose">WKT Polygon</label> <input
												class="form-control" id="lc_bl_wkt_polygon"
												name="lc_bl_wkt_polygon" type="text"
												aria-describedby="nameHelp"
												placeholder="Enter Consideration" value="${parcel_wkt}">

										</div>
									</div>



									<div class="form-group">

										<div class="form-row">
											<label for="bl_job_purpose">GLPIN</label> <input readonly
												class="form-control" id="txt_glpin" name="txt_glpin"
												type="text" aria-describedby="nameHelp" value="${glpin}">

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



		<div id="53ab3caa7e7d11ef98b51e576becd20e-2" class="">
			<h3 class="border-bottom border-gray pb-2">Quality Control (Geo
				Visualisation)</h3>


			<div class="row">
				<!--   Here is the right Table -->
				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Map Interface
						</div>
						<div class="card-body">




							<div class="bs-example">





								<div class="btn-group mr-2">
									<button type="button" class="btn btn-primary"
										id="smdfrtp_lc_btn_fr_visualise_wkt" data-placement="top"
										data-toggle="tooltip" title="Visualise Polygon">
										<i class="fa fa-map"></i>
									</button>
									<!--  
								          <button type="button" class="btn btn-primary"  id="lc_btn_visualise_search" data-placement="top" data-toggle="tooltip" title="Plot Parcels">
								            <i class="fa fa-save"></i>
								        </button>
								        -->

									<button type="button" class="btn btn-primary"
										id="lc_btn_fr_visualise_search" data-placement="top"
										data-toggle="tooltip" title="Visualise Search"
										style="display: none">
										<i class="fa fa-object-ungroup"></i>
									</button>


									<button type="button" class="btn btn-primary"
										id="lc_btn_fr_printmap" data-placement="top"
										data-toggle="tooltip" title="Visualise Polygon"
										style="display: none">
										<i class="fa fa-print"></i>
									</button>
								</div>




								<!--   <div class="btn-group">
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
									     -->





							</div>




									<!--  WKT row here -->
									<div class="form-group">

										<div class="form-row">
											<label for="bl_job_purpose">WKT Polygon</label> <input
												class="form-control" id="lc_fr_bl_wkt_polygon"
												name="lc_fr_bl_wkt_polygon" type="text"
												aria-describedby="nameHelp"
												placeholder="Enter Consideration" value="${parcel_wkt}">

										</div>
									</div>


							<div id="smdfrtp-map" ></div>







						</div>

					</div>
					<!--   Here is the end of right table -->

				</div>

			</div>
		</div>



		<%-- <div id="53ab3caa7e7d11ef98b51e576becd20e-4" class="">
			<h3 class="border-bottom border-gray pb-2">Request Surveyor's
				Signature</h3>

			<div class="row">
				<!--   Here is the right Table -->
				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">

						<div class="card-body">
							<!--  The Form starts here -->
							<form
								action="${pageContext.request.contextPath}/processing_after_payment"
								method="post">

								<!-- Maps Details Starts Here  -->
								<div class="bs-example">





									<div class="btn-group mr-2">
										<button type="button" class="btn btn-primary"
											id="btn_lcfrfa_lc_btn_visualise_wkt" data-placement="top"
											data-toggle="tooltip" title="Visualise Polygon">
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
											style="display: none">
											<i class="fa fa-object-ungroup"></i>
										</button>


										<button type="button" class="btn btn-primary"
											id="btn_lcfrfa_lc_btnprintmap" data-placement="top"
											data-toggle="tooltip" title="Visualise Polygon"
											style="display: none">
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


						<div class="card-body">
							<!--  The Form starts here -->
							<form
								action="${pageContext.request.contextPath}/processing_after_payment"
								method="post">

								<div class="form-group">




									<div class="form-row">

										<div class="col-md-12">

											<input type="button"
												id="lc_btn_activate_final_registration_confirm"
												class="btn btn-primary btn-block" value="Request Signature" />

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

		</div> --%>
		<div id="53ab3caa7e7d11ef98b51e576becd20e-3" class="">
			<h3 class="border-bottom border-gray pb-2">Signature by Regional
				Head</h3>


			<div class="row">

				<!--   Here is the right Table -->
				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i>Update that Regional Surveyor has
							signed
						</div>
						<div class="card-body">


							<button type="button" name="btn_update_parcel_as_approved_draft"
								id="btn_update_parcel_as_approved_draft"
								class="btn  btn-primary btn-icon-split form-control">
								<span class="icon text-white-50"> <i
									class="fas fa-check col-sm-12"></i></span><span class="text">
									Approved</span>
							</button>


							<%--  <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
										<input type="hidden" id="case_number" name="case_number" value="${case_number}" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_inspection_letter">
								          <div class="form-group">
								            <div class="form-row">
								              <div class="col-md-10">
								                <input type="submit" class="btn btn-primary btn-block" value="Update Reional Surveyor has signed" />  
								              </div>
								            </div>
								          </div>
								        </form> --%>
							<!-- The form Ends Hers -->
						</div>
					</div>
					<!--   Here is the end of right table -->
				</div>

			</div>








		</div>






		<div id="53ab3caa7e7d11ef98b51e576becd20e-4" class="">
			<h3 class="border-bottom border-gray pb-2">Generate Barcode</h3>



			<div class="row">

				<!--   Here is the right Table -->
				<div class="col-lg-12">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header"></div>
						<div class="card-body">
							<!--  The Form starts here -->



							<div class="form-row">


								<div class="col-md-4">
									<%-- 
				                 <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank">
										<input type="hidden" id="case_number" name="case_number" value="${case_number}" >
										<input type="hidden" id="request_type" name="request_type" value="request_to_generate_smd_barcode">
								          <div class="form-group">
						           
						            
						              
						                <input type="submit" class="btn btn-primary btn-block" value="Generate Barcode" />  

										
						           
						          </div>
						        </form> --%>



									<button type="button" name="btn_generate_smd_barcode"
										id="btn_generate_smd_barcode"
										class="btn  btn-primary btn-icon-split form-control">
										<span class="icon text-white-50"> <i
											class="fas fa-check col-sm-12"></i></span><span class="text">
											Generate Barcode</span>
									</button>



									<button type="button" name="btn_generate_smd_barcode_new_address_code"
										id="btn_generate_smd_barcode_new_address_code"
										class="btn  btn-primary btn-icon-split form-control">
										<span class="icon text-white-50"> <i
											class="fas fa-check col-sm-12"></i></span><span class="text">
											Generate Barcode New</span>
									</button>

								</div>

							</div>




							<!-- The form Ends Hers -->

						</div>

					</div>
					<!--   Here is the end of right table -->

				</div>







			</div>



		</div>





	</div>
</div>




<jsp:include
	page="../client_application/_application_process_footer.jsp"></jsp:include>

