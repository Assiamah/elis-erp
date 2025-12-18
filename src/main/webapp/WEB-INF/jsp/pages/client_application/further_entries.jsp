
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="../includes/_header.jsp"></jsp:include>


<%
	
%>




<input type="hidden" id="cs_main_case_number" value="${case_number}">
<div class="container-fluid">
	<!-- Breadcrumbs-->


	<!--      <div class="row">
        <div class="panel-body-map">
                <div id="map" style="height:380px;"></div>
                
              </div>
              
              
                </div>
        -->
	<%-- <div class="row">
		<!--   Here is the right Table -->



		<!--   Here is the right Table -->
		<div class="col">
			<!-- Example Pie Chart Card-->
			<div class="card mb-3">
				<div class="card-header bg-dark text-white">
					<i class="fas fa-search"></i> Search By Job Number
				</div>
				<div class="card-body">
					<!--  The Form starts here -->
					<form action="${pageContext.request.contextPath}/search_"
						method="post" id="frmSearchbyJobNumber"
					>

						<div class="form-group">
							<div class="form-row">
								<div class="col-md-8">
									<label for="search_job_number">Job Number</label> <input
										class="form-control" id="search_job_number" 
										type="text" aria-describedby="nameHelp"
										placeholder="Enter Job Number" required
									>
									
								</div>
								<div class="col-md-4">
									<label for="search_btn"> &nbsp;</label> <input type="button"
										id="btnJobNumberSearch" class="btn btn-primary btn-block"
										value="Search"
									/>

								</div>
							</div>
						</div>
					</form>

					<!-- The form Ends Hers -->

				</div>

			</div>
			<!--   Here is the end of right table -->

		</div>






	</div> --%>

	<!--          </div> -->







	<div class="row">
		<div class="col-lg-6">
		<div class="col-lg-12">
		<button class="btn btn-primary btn-icon-split  pull-right" onclick="javascript:history.go(-1)">
			<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
		</button>
		</div>
		<br><br>
			<div id="accordion" role="tablist" aria-multiselectable="true">
				
				
					<div class="card">
					<div class="card-header bg-dark text-white " role="tab"
						id="headingThree"
					>
						<a class="collapsed d-block  text-white " data-toggle="collapse"
							data-parent="#accordion" href="#collapsechecklist"
							aria-expanded="false" aria-controls="collapseFive"
							style="text-decoration: none !important"
						> <i class="fa fa-chevron-down pull-right"></i> <i
							class="fa fa-users"
						></i>Check List
						</a>
					</div>
					<div id="collapsechecklist" class="" role="tabpanel"
						aria-labelledby="headingThree"
					>
						<div class="card-body">


							
							
							<button type="button" class=" float-left btn btn-primary"
								id="lrd_btn_add_grantee" data-placement="top"
								data-toggle="modal" data-target="#approveChecklist"
								data-toggle="tooltip" title="Add party"
							>
								<i class="fa fa-plus-circle"></i>Approved Checklist
							</button>
							<br>
							<div class="table-responsive">
								<table class="table table-bordered  table-hover table-sm"
									id="checklist_details_datatable"
								>

									<thead>
										<tr>

											<th>Name</th>
											<!-- <th>Checked Option</th> -->
											
										
										</tr>
									</thead>

									<tbody>
										<c:forEach items="${recieving_checklist}" var="recieving_checklist_row">
						                <tr>
						                    <td>${recieving_checklist_row.business_process_checklist_name}</td>
						                    <%-- <td>${recieving_checklist_row.business_process_checklist_option}</td> --%>
						                 
						                   
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
							data-parent="#accordion" href="#collapseparties"
							aria-expanded="false" aria-controls="collapseFive"
							style="text-decoration: none !important"
						> <i class="fa fa-chevron-down pull-right"></i> <i
							class="fa fa-users"
						></i>Parties
						</a>
					</div>
					<div id="collapseparties" class="" role="tabpanel"
						aria-labelledby="headingThree"
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
				
				<div class="card">
					
					<div id="collapseparties" class="" role="tabpanel"
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
						class="collapse card-body  show" role="tabpanel"
						aria-labelledby="headingTwo"
					>
						<div class="card-body">

							<form id='frmFurtherEntries_only'>
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
												class="form-control" id="fe_extent" placeholder="" required value="${extent}"
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

									</div>


								</div>



								<div class="dropdown-divider"></div>
								<div id="alert-display-space"></div>
								<div class="form-group float-right">


									<button type="reset" id="btnclearFurtherDetails"
										class="btn btn-secondary float-right"
									>Clear Changes</button>
									<span class="float-right">&nbsp;&nbsp;&nbsp;&nbsp;</span>
									<button type="submit" id="btnAddFurtherDetails"
										class="btn btn-success float-right"
									>Save Changes</button>

								</div>

							</form>

							
						</div>
						
					</div>
				</div>
				<br>
				

				<!-- Example Bar Chart Card-->




			</div>




		</div>
	
<div class="col-lg-6">
          <!-- Example Pie Chart Card-->
          
          
          
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		    <%-- <div class="card">
		        <h5 class="card-header" role="tab" id="headingOne">
		            <a data-toggle="collapse" data-parent="#accordion" href="#collapsejobs" aria-expanded="true" aria-controls="collapseOne" class="d-block">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-info-circle"></i>Jobs Related to Case
		            </a>
		        </h5>
		
		        <div id="collapsejobs" class="collapse show" role="tabpanel" aria-labelledby="headingOne">
		            <div class="card-body">
		               
		               <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#addNewserviceBillModal" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Add New Service</span>
                    	</button>
                    	
                    	 
		               <button  data-action="edit"  class="btn btn-info btn-icon-split" data-title="Delete" data-toggle="modal" data-target="#afterPaymentModalonCase" data-target-id="${proprietorship_section.ps_id}" data-whatever="edit">
                    		<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Acknowledge</span>
                    	</button>
                    	
                    	
                    	
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
								                    <td>${job_row.current_application_status}</td>
								                </tr>
								     </c:forEach>
				  				</tbody>
				    		 </table>
				        </div>
		            </div>
		        </div>
		    </div>
		    <br> --%>
		    		    <%-- <div class="card">
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
		    </div> --%>
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
				           <table class="table table-bordered  table-hover table-sm" id="lc_main_scanned_documents_dataTable" width="100%" class="display" cellspacing="0">
				           
				              <thead>
				                <tr>
				
				                 <th>Document Name</th>
				                 <th>Document Type</th>
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
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsepudocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Public Documents
		            </a>
		        </h5>
		        <div id="collapsepudocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
			         		  <button type="button" class="btn btn-primary" id="btn_load_scanned_documents_public" data-placement="top"  title="Load Docs">
					            <i class="fas fa-eye"></i>
					        </button>
					        
					        <button type="button" class="btn btn-primary" id="btn_add_public_document" data-toggle="modal" data-target="#publicFileUploadModal" title="Add Public Documents">
					            <i class="fa fa-plus-circle"></i>
					        </button> 
					        
					        
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lc_public_documents_dataTable" width="100%" class="display" cellspacing="0">
				           
				              <thead>
				                <tr>
				
				                 <th>Document Name</th>
				                 <th>Document Type</th>
				               </tr>
				              </thead>
				              
				                <tbody>				
							    <c:forEach items="${casescanneddocuments_public}" var="casescanneddocuments_public_row">
				                <tr>
				                    <td>${casescanneddocuments_row.document_name}</td>
				                    <td>${casescanneddocuments_row.document_type}</td>
					                    <td>
											<form action="registration_application_progress_details" method="post">
												<input type="hidden" name="document_path" id="document_path" value="${casescanneddocuments_row.document_file}">
													<button type="submit" name="save" class="btn btn-info btn-icon-split" >
													<span class="icon text-white-50"> <i class="fas fa-folder-open"></i></span><span class="text">Open</span>
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
				           <table class="table table-bordered  table-hover table-sm" id="bill_payment_dataTable">
				           
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
							<!-- <table class="table table-bordered  table-hover table-sm" id="bill_payment_dataTable">
				           
								<thead>
								  <tr>
									   <th>Action</th>
									   <th>Payment Mode</th>
									   <th>Amount</th>
									   <th>Receipt Number</th>
									   <th>Payment Date</th>
									   <th>Payment Amount</th>
								   </tr>
								</thead>
								
								  <tbody>
								   <c:forEach items="${payment_invoice}" var="payment_bill_row">
									  <tr>
										  <td><button 
														
														data-toggle="modal" 
														data-target="#viewBillModal"  
													  
													  data-egcr_id= "${payment_bill_row.payment_slip_number}"
													  data-ref_number= "${payment_bill_row.ref_number}"
														class="btn btn-success viewBillModalBtn"  
														title="View Bill Details" >
												  View
											  </button> 
										  </td>
										  <td>${payment_bill_row.payment_mode}</td>
										  <td>${payment_bill_row.bill_amount}</td>
										  <td>${payment_bill_row.payment_slip_number}</td>
										  <td>${payment_bill_row.payment_date}</td>
										  <td>${payment_bill_row.payment_amount}</td>
										  
									   </tr>
								   </c:forEach>
									</tbody>
					  
							  
							  </table> -->
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
		              
		               <button type="button" class="btn btn-primary" id="lrd_btn_add_querys" data-placement="top" data-toggle="modal" data-target="#newQueryModal" data-toggle="tooltip" title="Add Query">
					            <i class="fa fa-plus-circle"></i>
					        </button>
		              
		                <div  class="table-responsive">
				           <table class="table table-bordered  table-hover table-sm" id="lrd_scanned_documents_dataTable">
				           
				              <thead>
								      			<tr>
								      				<th>Job Number </th>
								      				<th>Reasons</th>
								      				<th>Remarks</th>
								      				<th>Created_date </th>
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
										      					<button type="button" id="editQueryModal"  data-toggle="modal" 
										      					data-target="#newQueryModal"  data-action="edit"  
										      					class="btn btn-icon-split  ${case_query_row.status == 1 ? 'btn-danger' : 'btn-info'}"  title="Edit Query" 
										      					
										      					data-id="${case_query_row.qid}" 
										                    	data-job_number="${case_query_row.am_description}" 
										                    	data-reasons="${case_query_row.reasons}" 
										                    	data-remarks="${case_query_row.remarks}" 
										                    	data-status="${case_query_row.status}" 
																data-query_response="${case_query_row.query_response}" 
										                    	data-created_by="${case_query_row.created_by}" 
										                    	data-created_date="${case_query_row.created_date}" 
										                    	data-modified_by="${case_query_row.modified_by}" 
										                    	data-modified_date="${case_query_row.modified_date}" 

								                    	
										      					
										      					>
													    			<span class="icon text-white-50"> 
													    			
													    			
													    			${case_query_row.status == 1 ? '<i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>' : '<i class="fas fa-eye"></i></span><span class="text">View</span>'}
													    			
													    			
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
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsecoordinateentry" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-edit"></i>Coordinate Entry
		            </a>
		        </h5>
		        <div id="collapsecoordinateentry" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
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
								   <i class="fa fa-pie-chart"></i>Coordinate Entry</div>
								 <div class="card-body">
									<!--  The Form starts here -->
								   <form action="${pageContext.request.contextPath}/processing_after_payment"  method="post">
							
						<!-- Maps Details Starts Here  -->
						
						<div class="form-group">
											 <div class="form-row">  <label for="lc_bl_wkt_polygon">WKT Polygon</label>
												   <input class="form-control" id="lc_bl_wkt_polygon"  name="lc_bl_wkt_polygon"  type="text" aria-describedby="nameHelp"  value="${parcel_wkt}" readonly >
						
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
						
						
						
						<!--        
						<button type="button" class="btn btn-primary" id="lc_btnprintmap" data-placement="top" data-toggle="tooltip" title="Visualise Polygon">
						<i class="fa fa-print"></i>
						</button> -->
						
						
						
						
						
						
						</div> 
						
						
						
						
						
						
						
						
						</div>
						
						
						
						
						
						
						<div id="lc-map"></div>
						
						<!--  Here is where the fee list comes -->
						
						
									   
								   </form>
								 
								 <!-- The form Ends Hers -->
								 
							   </div>
							   
							   
								  <!--  Scanned Maps -->
						
						
						
						
						
						
						
						
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
							 
							  <button type="button" class="btn btn-primary" id="btn_lc_save_parcel_for_general_noting" data-placement="top" data-toggle="tooltip" title="Save">
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
									  
						
						
						
						
						
						
						
						
						
						
						
							  
							 </div>
						   <!--   Here is the end of right table -->
						
						   </div>
						   
						
						  </div>
		               
		            </div>
		        </div>
		    </div>
		    <br>

	<div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsefedocumentpreview" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Document Preview
		            </a>
		        </h5>
		        <div id="collapsefedocumentpreview" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		              
		              <iframe src=""  id="fedocumentPreviewblobfile" width="100%" height="800"></iframe>
		              
		               
		            </div>
		        </div>
		    </div>
		    
		    
		</div>

      </div>
      
      
      <!-- ----------------- -->		




	</div>

</div>














	<jsp:include page="../includes/_footer.jsp"></jsp:include>