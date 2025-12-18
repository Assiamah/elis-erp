
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


<jsp:include page="../includes/_header.jsp"></jsp:include>



<div class="container-fluid">
	<!-- Breadcrumbs-->
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="index.jsp">Application
				Processing</a></li>
		<li class="breadcrumb-item active">Entire Processing</li>


	</ol>








	<div class="row">



		<div class="col-lg-8">
			<!-- Example Bar Chart Card-->
			<div class="card mb-3">

				<div class="card-header">
					<h4 class='float-left'>
						<i class="fas fa-stamp"></i>${case_number} - ${ar_name}
					</h4>
					<button type="button" onclick="javascript:history.go(-1)"
							class="btn btn-primary btn-icon-split float-right">
							<span class="icon text-white-50"> <i
								class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
						</button>
				</div>
				<div class="card-body">


					<div class="card">
						<h5 class="card-header" role="tab" id="headingThree">
							<a class="collapsed d-block" data-toggle="collapse"
								data-parent="#accordion" href="#collapsemaincase"
								aria-expanded="false" aria-controls="collapseThree"> <i
								class="fa fa-chevron-down pull-right"></i> <i
								class="fas fa-file-alt"></i>Summary of the case
							</a>
						</h5>
						<div id="collapsemaincase" class="collapse show" role="tabpanel"
							aria-labelledby="headingThree">
							<div class="card-body">


								<div class="col-lg-12">
									<!-- Example Pie Chart Card-->
									<div class="card mb-3">
										<div class="card-header">Parcel Attributes</div>
										<div class="card-body">
											<!--  The Form starts here -->

											<div class="form-group">

												<input type="hidden" id="cs_main_business_process_id"
													value="${business_process_id}"> <input
													type="hidden" id="cs_main_business_process_name"
													value="${business_process_name}"> <input
													type="hidden" id="cs_main_business_process_sub_id"
													value="${business_process_sub_id}"> <input
													type="hidden" id="cs_main_business_process_sub_name"
													value="${business_process_sub_name}"> <input
													type="hidden" id="cs_main_client_number"
													value="${phone_number}">
													
											   <div class="form-row">
									              <div class="col-md-6">
									                <label for="search_value">Date Created </label>
													   <input  readonly class="form-control" type="text"  value="${created_date}" >       													
									              </div>
									              <div class="col-md-6">
									                <label for="search_value">Last Modified Date</label>
									                <input  readonly class="form-control"    type="text" aria-describedby="nameHelp"  value="${modified_date}" >
									              </div>				             
									            </div>


												<div class="form-row">
													<div class="col-md-4">
														<label for="search_value">Case Number</label> <input
															readonly class="form-control" id="cs_main_case_number"
															name="cs_main_case_number" type="text"
															value="${case_number}">

													</div>
													<div class="col-md-4">
														<label for="search_value">Regional Number</label> <input
															readonly class="form-control" type="text"															
															value="${regional_number}">
													</div>
													<div class="col-md-4">
														<label for="search_value">Locality</label> <input readonly
															class="form-control" id="cs_main_locality" type="text"
															value="${locality}">
													</div>

												</div>


												<div class="form-row">
													<div class="col-md-4">
														<label for="search_value">District</label> <input readonly
															class="form-control" type="text"
															value="${district}">
													</div>
													<div class="col-md-4">
														<label for="search_value">Region</label> <input readonly
															class="form-control" type="text"
															value="${region}">
													</div>
													<div class="col-md-4">
														<label for="search_value">Size of Land - Acre(s)</label> <input
															readonly class="form-control" id="cs_main_size_of_land"
															type="text" value="${size_of_land}">
													</div>

												</div>


												<div class="form-row">


													<div class="col-md-4">


														<label for="bl_job_purpose">GLPIN</label> <input readonly
															class="form-control" id="txt_glpin" name="txt_glpin"
															type="text" value="${glpin}">
													</div>



													<div class="col-md-4">
														<label for="search_value">New Transaction Ready</label> <input
															readonly class="form-control"
															id="cs_main_need_for_new_transaction"
															type="text"
															value="${need_for_new_transaction}">

													</div>



												</div>










											</div>






											<!-- The form Ends Hers -->

										</div>

									</div>
									<!--   Here is the end of right table -->

								</div>







								<div class="col-lg-12">
									<!-- Example Pie Chart Card-->
									<div class="card mb-3">
										<div class="card-header">Transaction Details</div>
										<div class="card-body">
											<!--  The Form starts here -->



											<div class="form-group">




												<div class="form-row">


													<div class="col-md-4">
														<label for="search_value">Transaction Number</label> <input
															readonly class="form-control" id="cs_main_ar_name"
															name="cs_main_ar_name" type="text"
															 value="${transaction_number}">

													</div>


													<div class="col-md-4">
														<label for="search_value">Applicant Name</label> <input
															readonly class="form-control" id="cs_main_ar_name"
															name="cs_main_ar_name" type="text"
															value="${ar_name}">

													</div>






													<div class="col-md-4">
														<label for="search_value">Nature of Instrument</label> <input
															readonly class="form-control" type="text"
															
															value="${nature_of_instrument}">
													</div>

												</div>



												<div class="form-row">
													<div class="col-md-4">
														<label for="search_value">Date of Document</label> <input
															readonly class="form-control" type="text"
															value="${date_of_document}">
													</div>

													<div class="col-md-4">
														<label for="search_value">Date of Registration</label> <input
															readonly class="form-control" type="text"
															value="${date_of_registration}" required>

													</div>


													<div class="col-md-4">
														<label for="search_value">Type of Interest</label> <input
															readonly class="form-control" type="text"
															 value="${type_of_interest}">
													</div>

												</div>


												<div class="form-row">
													<div class="col-md-4">
														<label for="search_value">Type of Use</label> <input
															readonly class="form-control" type="text"
															 value="${type_of_use}">
													</div>
													<div class="col-md-4">
														<label for="search_value">Term</label> <input readonly
															class="form-control" type="text"
															 value="${term}">
													</div>
													<div class="col-md-4">
														<label for="search_value">Commencement Date</label> <input
															readonly class="form-control" type="text"
															 value="${commencement_date}">
													</div>

												</div>


												<div class="form-row">
													<div class="col-md-4">
														<label for="search_value">Assessed Value</label> <input
															readonly class="form-control" type="text"
															 value="${assessed_value}">
													</div>
													<div class="col-md-4">
														<label for="search_value">Stamp Duty Payable</label> <input
															readonly class="form-control" type="text"
															 value="${stamp_duty_payable}">
													</div>
													<div class="col-md-4">
														<label for="search_value">Certificate Number</label> <input
															readonly class="form-control" type="text"
															 value="${certificate_number}">
													</div>

												</div>

											</div>






											<!-- The form Ends Hers -->

										</div>

									</div>
									<!--   Here is the end of right table -->

								</div>



								<!--    </div>
				      
				       -->





							</div>
						</div>
					</div>





					<br>













				</div>

			</div>






		</div>




		<!--   Here is the right Table -->
		<div class="col-lg-4">
			<!-- Example Pie Chart Card-->




			<div id="accordion" role="tablist" aria-multiselectable="true">
				
				<div class="card">
					<h5 class="card-header" role="tab" id="headingThree">
						<a class="collapsed d-block" data-toggle="collapse"
							data-parent="#accordion" href="#collapseparties"
							aria-expanded="false" aria-controls="collapseFive"> <i
							class="fa fa-chevron-down pull-right"></i> <i class="fa fa-users"></i>Parties
						</a>
					</h5>
					<div id="collapseparties" class="collapse" role="tabpanel"
						aria-labelledby="headingThree">
						<div class="card-body">


							<!-- <button type="button" class="btn btn-primary"
								id="lrd_btn_add_coordinate" data-placement="top"
								data-toggle="modal" data-target="#addeditparty"
								data-toggle="tooltip" title="Add New Party">
								<i class="fa fa-plus-circle"></i>
							</button>
 -->
							<div class="table-responsive">
								<table class="table table-bordered  table-hover table-sm"
									id="lrd_scanned_documents_dataTable">

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
				                	 <th>Action</th>
					                 <th>Payment Mode</th>
					                 <th>Amount</th>
					                 <th>Receipt Number</th>
									 <th>Invoice Number</th>
					                 <th>Payment Date</th>
					                 <th>Payment Amount</th>
				                 </tr>
				              </thead>
				              
				                <tbody>
							     <c:forEach items="${payment_invoice}" var="payment_bill_row">
					                <tr>
					                	<td><button 
							      					id="viewBillModalBtn"  
							      					data-toggle="modal" 
							      					data-target="#viewBillModal"  
							    					
							    					data-egcr_id= "${payment_bill_row.payment_slip_number}"
							    					data-ref_number= "${payment_bill_row.ref_number}"
							      					class="btn btn-success"  
							      					title="View Bill Details" >
								    			View
								    		</button> 
					                    </td>
					                    <td>${payment_bill_row.payment_mode}</td>
					                    <td>${payment_bill_row.bill_amount}</td>
					                    <td>${payment_bill_row.payment_slip_number}</td>
										<td>${payment_bill_row.client_ref}</td>
					                    <td>${payment_bill_row.payment_date}</td>
					                    <td>${payment_bill_row.payment_amount}</td>
					                    
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
					<h5 class="card-header" role="tab" id="headingTwo">
						<a class="collapsed d-block" data-toggle="collapse"
							data-parent="#accordion" href="#collapseminutes"
							aria-expanded="false" aria-controls="collapseTwo"> <i
							class="fa fa-chevron-down pull-right"></i> <i
							class="fas fa-clipboard"></i>Minutes On Application
						</a>
					</h5>
					<div id="collapseminutes" class="collapse" role="tabpanel"
						aria-labelledby="headingTwo">
						<div class="card-body">

							<!-- <button type="button" class="btn btn-primary"
								id="lrd_btn_add_coordinate" data-placement="top"
								data-toggle="modal" data-target="#addMinutesModal"
								data-toggle="tooltip" title="Add Minutes" data-backdrop="static"
								data-keyboard="false">
								<i class="fa fa-plus-circle"></i>
							</button> -->
							<div class="table-responsive">
								<table class="table table-bordered table-hover table-sm"
									id="lrd_scanned_documents_dataTable">

									<thead>
										<tr>

											<th>Description</th>
											<th>From</th>
											<th>To</th>
											<th>Date</th>
											<th>Action</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach items="${application_munites}"
											var="application_munites_row">
											<tr>
												<td>${application_munites_row.am_description}</td>
												<td>${application_munites_row.ar_name}</td>
												<td>${application_munites_row.am_to_officer}</td>
												<td>${application_munites_row.am_activity_date}</td>
												<td><p data-placement="top" data-toggle="tooltip"
														title="View">
														<button class="btn btn-info btn-icon-split"
															data-title="Delete" data-toggle="modal"
															data-target="#addMinutesModal"
															data-target-id="${application_munites_row.am_id}">
															<span class="icon text-white-50"> <i
																class="fas fa-info-circle"></i></span><span class="text">View</span>
														</button>
													</p></td>
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
						<a class="collapsed d-block" data-toggle="collapse"
							data-parent="#accordion" href="#collapsedocs"
							aria-expanded="false" aria-controls="collapseThree"> <i
							class="fa fa-chevron-down pull-right"></i> <i
							class="fas fa-file-alt"></i>Documents On Application
						</a>
					</h5>
					<div id="collapsedocs" class="collapse" role="tabpanel"
						aria-labelledby="headingThree">
						<div class="card-body">


							<button type="button" class="btn btn-primary"
								id="btn_load_scanned_documents" data-placement="top"
								data-toggle="tooltip" title="Load Docs">
								<i class="fa fa-eye"></i>
							</button>

							<!-- <button type="button" class="btn btn-primary"
								id="lrd_btn_add_coordinate" data-placement="top"
								data-toggle="modal" data-target="#fileUploadModal"
								data-toggle="tooltip" title="Upload New Documents"
								data-backdrop="static" data-keyboard="false">
								<i class="fa fa-plus-circle"></i>
							</button> -->
							<div class="table-responsive">
								<table class="table table-bordered  table-hover table-sm"
									id="lc_main_scanned_documents_dataTable" width="100%"
									cellspacing="0">

									<thead>
										<tr>

											<th>Document Name</th>
											<th>Document Type</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach items="${casescanneddocuments}"
											var="casescanneddocuments_row">
											<tr>
												<td>${casescanneddocuments_row.document_name}</td>
												<td>${casescanneddocuments_row.document_type}</td>

												<td>
													<form action="open_pdffile" method="post">
														<input type="hidden" name="document_path"
															id="document_path"
															value="${casescanneddocuments_row.document_file}">
														<button type="submit" name="save"
															class="btn btn-info btn-icon-split">
															<span class="icon text-white-50"> <i
																class="fas fa-folder-open"></i></span><span class="text">Opn</span>
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
				           <table class="table table-bordered  table-hover table-sm data-table" id="lc_public_documents_dataTable" width="100%" class="display" cellspacing="0">
				           
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
						<a class="collapsed d-block" data-toggle="collapse"
							data-parent="#accordion" href="#collapsequeries"
							aria-expanded="false" aria-controls="collapseFour"> <i
							class="fa fa-chevron-down pull-right"></i> <i
							class="fas fa-money-bill-alt"></i>Queries
						</a>
					</h5>
					<div id="collapsequeries" class="collapse" role="tabpanel"
						aria-labelledby="headingThree">
						<div class="card-body">

							<!-- <button type="button" class="btn btn-primary"
								id="lrd_btn_add_querys" data-placement="top" data-toggle="modal"
								data-target="#newQueryModal" data-toggle="tooltip"
								title="Add Query" data-backdrop="static" data-keyboard="false">
								<i class="fa fa-plus-circle"></i>
							</button> -->

							<div class="table-responsive">
								<table class="table table-bordered  table-hover table-sm"
									id="lrd_scanned_documents_dataTable">

									<thead>
										<tr>
											<th>job_number</th>
											<th>reasons</th>
											<th>remarks</th>
											<th>created_date</th>
											<th>Action</th>

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


			</div>

		</div>

	</div>




</div>













<!--  Service Bill============================= -->








<jsp:include page="../includes/_footer.jsp"></jsp:include>

