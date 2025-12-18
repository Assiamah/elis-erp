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


<jsp:include page="../includes/_header.jsp"></jsp:include>



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
			<div class="row">
				<div class="col-lg-12">
				<button class="btn btn-primary btn-icon-split  pull-right" onclick="javascript:history.go(-1)">
					<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				</div>
			</div>
			<div class="row">
				<div class="col-6">
					<div class="card card-body mt-3">
						
						<label for="" class="col-form-label">Interest Number:</label>
						   <input type="text" class="form-control" readonly value="${interest_number}" id="lc_txt_interest_number" />
						   <div class="mt-3">
							<button 
							class="btn btn-primary w-100" id="lc_btn_generate_interest_number"
							<c:if test="${not empty interest_number and interest_number ne 'null'}">
								disabled
							</c:if>
						 >
				 
						<i class="fas fa-check-circle mr-1"></i>
							Generate
						</button>
						   </div> 
					</div>
				</div>
				<div class="col-6">

					<div class="card card-body mt-3">
						<label for="" class="col-form-label">Sub Interest Number:</label>
					   <input type="text" class="form-control" readonly value="${sub_interest_number}" id="lc_txt_sub_interest_number" />
			
					   <div class="mt-3">
						<button 
						class="btn btn-primary w-100" id="lc_btn_generate_sub_interest_number"
						<c:if test="${not empty sub_interest_number and sub_interest_number ne 'null'}">
							disabled
						</c:if>
					 >
			 
					<i class="fas fa-check-circle mr-1"></i>
						Generate
					</button>
					   </div> 
					</div>
				</div>
			</div>
		<br><br>
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
						aria-labelledby="headingTwo"
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
											
										<div class="form-group">
											<label for="">Date of Issue</label> <input type="date"
												class="form-control " id ="fe_date_of_issue"
												placehoRegilder="" required value="${date_of_issue}"
											>
										</div>
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
													   value="${certificate_type}"
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
						aria-labelledby="headingThree"
					>
						<div class="card-body">

 					<h5 class="border-bottom border-gray pb-2">Proprietorship Details</h5>
                    <button  type="button" class="btn btn-primary pull-right" style="margin-bottom:5px" data-placement="top" data-toggle="modal" data-target="#newProprietorshipModal" data-toggle="tooltip" title="Add New ">
			            <i class="fa fa-plus-circle"></i>
			        </button>
                     
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
								 <th>Term</th>
								<th>Action</th>
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
									<td>${proprietorship_section.ps_term}</td>
				
								
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
										data-ps_term="${proprietorship_section.ps_term}"
										data-whatever="edit">
											<span class="icon text-white-50"> <i class="fas fa-pencil-alt"></i></span><span class="text">Edit</span>
										</button>
										</p>
									</td>
									
										
									<!-- <td>
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
			          
			          
			          <h5 class="border-bottom border-gray pb-2">Valuation Details</h5>
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
			                 <th>Edit</th>
			                  
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
			          </div>
			          
			          
			          
			      <h5 class="border-bottom border-gray pb-2">Certificate Details</h5>
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
                    <td>
						                    
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
						aria-labelledby="headingThree"
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
						aria-labelledby="headingThree"
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
							                
							                <div class="col">
							              			<br><br>
							                		<button type="button" name="lc_btn_preview_consent_certificate" id="lc_btn_preview_consent_certificate" class="btn  btn-primary btn-icon-split "  >
										    			<span class="icon text-white-50"> <i class="fas fa-print "></i></span><span class="text">Preview Certificate</span>
										    		</button>
							                
							                </div>
							                
							                  
							                <div class="col">
							              			<br><br>
							                		 <!-- <form action="${pageContext.request.contextPath}/GenerateCaseReports"  method="post" target="_blank"> -->
									<input type="hidden" id="case_number" name="case_number" value="${transaction_number}" >
										<input type="hidden" id="job_number" name="job_number" value="${job_number}" >
										<input type="hidden" id="request_type" name="request_type" value="lc_btn_activate_final_register_">
								         <div class="form-group">
						           
						            
						              
						                   <input type="button" id="lc_btn_activate_final_register" class="btn btn-primary btn-block w-100" value="Generate Register" /> 
						           
						          </div>
						        <!-- </form> -->
							                
							                </div>
							                
							                
							                 
							                
							              </div>
							            


						</div>
					</div>
				</div>
				<br>
				</div>

				<!-- Example Bar Chart Card-->




			</div>




            <input type="hidden" id="ars_job_purpose" class="form-control" value="${job_purpose}">
		 
            <div class="mt-5">
               <button class="btn btn-success btn-icon-split float-left "  data-job_number="${job_number}" id="btnApproveJob">
                   <span class="icon text-white-50"> <i class="fas fa-check fa-2x"></i></span><span class="text">Approve Request</span>
               </button>
            
               <button class="btn btn-danger btn-icon-split float-left ml-3"  data-job_number="${job_number}" id="btnQueryJob">
                   <span class="icon text-white-50"> <i class="fas fa-times fa-2x"></i></span><span class="text">Query Request</span>
               </button>
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
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsefedocumentpreview" aria-expanded="false" aria-controls="collapseFour">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Document Preview
		            </a>
		        </h5>
		        <div id="collapsefedocumentpreview" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
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