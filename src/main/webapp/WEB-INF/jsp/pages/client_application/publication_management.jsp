
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



<div class="content-wrapper">

	<div class="container-fluid">
		<!-- Breadcrumbs-->
		<div class="row">
			<c:if test="${published_but_not_worked_on > 0}">
	            <!-- Earnings (Monthly) Card Example -->
	            <div class="col-xl-6 col-md-6 mb-4">
	              <div class="card border-left-danger shadow h-100 py-2" data-toggle="modal" data-target="#publishedButNotWorkedOnModal">
	                <div class="card-body" style="cursor: pointer">
	                  <div class="row no-gutters align-items-center">
	                    <div class="col mr-2">
	                      <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Passed 14 days after Publication</div>
	                      <div class="h5 mb-0 font-weight-bold text-gray-800">${published_but_not_worked_on}</div>
	                    </div>
	                    <div class="col-auto">
	                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
	                    </div>
	                  </div>
	                </div>
	              </div>
	            </div>
			</c:if>
            <!-- Pending Requests Card Example -->
            <!-- <div class="col-xl-6 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pending Requests</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div> -->
          </div>

		
		<div class="row">
			<div class="col-lg-12">
				<!-- Example Bar Chart Card-->
				<div class="card mb-3">
					<div class="card-header bg-dark text-white">

						<nav class="nav nav-tabs  flex-column flex-sm-row" id="myTab"
							role="tablist"
						>
							<h3
								class=" flex-sm-fill text-sm-center nav-link  text-black active"
								id="home-tab" data-toggle="tab" href="#unpublishedList"
								role="tab" aria-controls="home" aria-selected="true"
								style="cursor: pointer"
							>Ready for Publication</h3>

							<h3 class="flex-sm-fill text-sm-center nav-link  text-black "
								id="profile-tab" data-toggle="tab" href="#publishedList"
								role="tab" aria-controls="profile" aria-selected="false"
								style="cursor: pointer"
							>Sent for Publication</h3>
							
							<h3 class="flex-sm-fill text-sm-center nav-link  text-black "
								id="profile-tab" data-toggle="tab" href="#specialPublicationList"
								role="tab" aria-controls="profile" aria-selected="false"
								style="cursor: pointer; color:#00ff21"
							>Special Publication</h3>
							
							<!-- <h3 class="flex-sm-fill text-sm-center nav-link  text-black "
								id="profile-tab" data-toggle="tab" href="#objectionManage"
								role="tab" aria-controls="profile" aria-selected="false"
								style="cursor: pointer"
							>Objection Management</h3> -->

							<!-- <li class="nav-item">
						    <a class="nav-link" id="messages-tab" data-toggle="tab" href="#messages" role="tab" aria-controls="messages" aria-selected="false">Messages</a>
						  </li>
						  <li class="nav-item">
						    <a class="nav-link" id="settings-tab" data-toggle="tab" href="#settings" role="tab" aria-controls="settings" aria-selected="false">Settings</a>
						  </li> -->
						</nav>






					</div>
					

					<div class="card-body">

						<div class="tab-content">
							<div class=" tab-pane active " id="unpublishedList" role="tabpanel"
								aria-labelledby="home-tab"
							>
								<h1 class="display-4 text-primary">
									 Ready for Publication
									 
									 
									<button class="btn btn-danger btn-lg btn-edit float-right "
										id="btnSendPublicationList" style="margin-right:10px">
										<i
											class="fas fa-2x fa-newspaper">
										</i>Send For Publication
									</button> 
									<button class="btn btn-secondary btn-lg btn-edit float-right" id="btnAddOldCase"   data-toggle="modal" data-target="#addOldCaseModal" style="margin-right:10px">
										<i class="fas fa-2x fa-plus">
										</i> 
									</button>
									<button class="btn btn-primary btn-lg btn-edit float-right " id="btnViewPublicationList" style="margin-right:10px" >
										<i class="fas fa-2x fa-print">
										</i>
									</button>
									
									
									
									
									
									

								</h1>
								<hr class="mt-5 mb-5">
								<div class="table-responsive">
									<table class="table table-bordered  table-hover" id="unpublishedDataTable" width="100%" >

										<thead class="thead-light">
											<tr>


												<th>#</th>
												<th>Job Number</th>
												<th>Applicant Name</th>
												<!--   <th>Milestones</th> -->
												<th>Case Number</th>
												<th>Application Type</th>
												<th>GLPIN</th>
												<th style="display: none">name</th>
												<th style="display: none">Location</th>
												<th style="display: none">Grantor</th>
												<th style="display: none">Extent</th>
												<th style="display: none">Type of Interest</th>
												<th style="display: none">Registry Map</th>
												<th style="display: none">Description</th>


											</tr>
										</thead>

										<tbody>									
											
											<c:forEach items="${ready_for_publication_list}" var="appfiles" varStatus="applicationLoop">
												<tr  class="text-danger">
													<td>${applicationLoop.index + 1}</td>
													<td>${appfiles.job_number}</td>

													<td title="${appfiles.ar_name}">
														${fn:substring(appfiles.ar_name, 0, 20)}
														${fn:length(appfiles.ar_name) >20 ? "..." : ""}</td>

													<td>${appfiles.case_number}</td>
													<td>${appfiles.business_process_sub_name}</td>
													<td>${appfiles.glpin}</td>
													<td style="display: none">${appfiles.ar_name}</td>
													<td style="display: none">${appfiles.locality}</td>
													<td style="display: none">${appfiles.grantors_name}</td>
													<td style="display: none">${appfiles.extent}</td>
													<td style="display: none">${appfiles.type_of_interest}</td>
													<td style="display: none">${appfiles.registry_mapref}</td>
													<td style="display: none">${appfiles.parcel_description}</td>
													

												</tr>
											</c:forEach>


										</tbody>


									</table>
								</div>



							</div>
							<div class="tab-pane fade" id="publishedList" role="tabpanel"
								aria-labelledby="publishedList"
							>
								<h1 class="display-4 text-primary">
									Awaiting Publication Date</h1>
								<div class="col-md-6 float-right">

									<form id="frmSentForPublication">
										<div class="form-group">
											<table style="width: 100%">
												<tr>
													<td><label for="main_service">Date of
															Publication : </label></td>
													<td><input class="form-control"
														id="date_sent_for_publication" name="user_to_send_to"
														type="date" aria-describedby="nameHelp" required
													></td>
													<td>
														<button class="btn btn-primary btn-edit float-right "
															id="btnPublishedListDateUpdate"
														>
															<span class="icon text-white-50"> <i
																class="fas fa-calendar-alt"
															></i></span><span class="text">Add Date</span>
														</button>
													</td>
												</tr>
											</table>
										</div>
									</form>


								</div><hr class="mt-5 mb-5">
								<div class="table-responsive">
									<table class="table table-bordered table-hover data-table" id="publishedDataTable"
										width="100%"
									>

										<thead class="thead-light">
											<tr>



												<th><input type="checkbox" id="selectAll"/></th>
												<th >Job Number</th>
												<th>Applicant Name</th>
												<th>Case Number</th>
												<th>Application Type</th>
												<th style="display: none"></th>


											</tr>
										</thead>

										<tbody>


											<c:forEach items="${awaiting_publication_date_list}" var="appfiles" varStatus="applicationLoop">
												<tr >
													<td><input type="checkbox" /><%-- ${applicationLoop.index + 1} --%></td>
													<td>${appfiles.job_number}</td>

													<td title="${appfiles.ar_name}">
														${fn:substring(appfiles.ar_name, 0, 20)}
														${fn:length(appfiles.ar_name) >20 ? "..." : ""}</td>

													<td>${appfiles.case_number}</td>
													<td>${appfiles.business_process_sub_name}</td>
													<td style="display: none">${appfiles.ar_name}</td>

												</tr>
											</c:forEach>


										</tbody>


									</table>
								</div>
							</div>	
							
							
							
							
							
							
							
							
							<div class="tab-pane fade" id="specialPublicationList" role="tabpanel" aria-labelledby="specialPublicationList">
								<h1 class="display-4 text-primary">Special Publication
							

									<button class="btn btn-secondary btn-lg btn-edit float-right" id="btnAddOldCaseSpecial" data-toggle="modal" data-target="#addOldCaseModal" style="margin-right:10px" title="Add Application to Special Publication">
										<i class="fas fa-2x fa-plus">
										</i> 
									</button>
</h1>
									<hr class="mt-5 mb-5">
									<div class="row">
									
										<div class="col-sm-8">
								          <div class="card mb-3">
								            <div class="card-header">
								              <i class="fa fa-bar-chart"></i>Application Details</div>
								            <div class="card-body">
								            	<div class="form-group">
										            <div class="form-row">
								            			<!-- <textarea rows="" cols="" class="form-control"></textarea>
								            			 -->
								            			<textarea id="lc_search_report_summary_details" 
								            				name="lc_search_report_summary_details" 
								            				class="form-control col-sm-12" required rows=12  
								            				style="padding:50px !important;"> </textarea> 
			        	                    
			        	                    
							            			</div>
						            			</div>
								            </div>
								          </div>
								        </div>
									
									
									
									
										<div class="col-sm-4">
								          <div class="card mb-3">
								            <div class="card-header">
								              <i class="fa fa-bar-chart"></i>Application Details</div>
								            <div class="card-body">
								              	<form id="frmSPPublicationList"  method="get">
										          <div class="form-group">
										            <div class="form-row">
										            <label for="search_value">Applicant Name</label>
							         
										                <input class="form-control" id="sp_ar_name"  type="text"  readonly required >
										              
										            </div>
										            <br>
										             <div class="form-row">
										            <label for="search_value">Grantor Name</label>
							         
										                <input class="form-control" id="sp_grantor_name"  type="text"  readonly required >
										              
										            </div>
										            <br>
										            
										            
										            <div class="form-row">
										             
										              <div class="col-md-6">
										                <label for="search_value">Job number</label>
										                <input class="form-control" id="sp_job_number"  type="text" required readonly>
										              </div>
										              <div class="col-md-6">
										              	<label for="search_value">Case Number</label>
										                <input class="form-control" id="sp_case_number"  type="text" required readonly >
										                
										              </div>
										            </div>
										            <BR />
										            
										         
										             <div class="form-row">
										             
										              <div class="col-md-6">
										                <label for="search_value">Locality</label>
										                <input class="form-control" id="sp_locality"  type="text" required readonly >
										              </div>
										              
										              
										              <div class="col-md-6">
										                <label for="search_value">Type of Interest</label>
										                <input class="form-control" id="sp_type_of_interest"  type="text" required readonly>
										              </div>
										              
										            </div>
										            
										            
										            <div class="form-row">
										             
										              <div class="col-md-6">
										                <label for="search_value">Extent</label>
										                <input class="form-control" id="sp_extent"  type="text" required readonly>
										              </div>
										              <div class="col-md-6">
										              	<label for="search_value">Registry Map Ref</label>
										                <input class="form-control" id="sp_registry_mapref"  type="text" readonly required >
										                
										              </div>
										            </div>
										            <BR />
										            
										            
										            <div class="form-row" id="btnActionsSP" style="display:none">
										             
										               <div class="col-md-6">
										              <br>
										              		<button type="button" class="btn btn-success btn-block btn-xl" value="Preview" id="btnPreviewSP" > Preview</button>
										              		
										              </div> 
										                <div class="col-md-6">
										              <br>
										              		<button type="button" class="btn btn-primary btn-block btn-xl" value="Send" id="btnSaveSP" > Send Special Publication </button>
										              		
										              </div> 
										            </div>
										            <BR />
										            
										            
										            
							
										          </div>
										        </form>
								            </div>
								          </div>
								        </div>
							      	  </div>
										
										
										
									</div>
							</div>	
							
							
							
							
							
							
							
							
							
							
							
										
					   </div>
					</div>
				</div>
			</div>
		</div>

</div>

<div class="modal fade" id="publishedButNotWorkedOnModal" tabindex="-1"
	role="dialog" aria-labelledby="publishedButNotWorkedOnModal" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Applications Published &amp; Over-due List</h4>
			</div>
			<div class="modal-body">
				
				<div class="table-responsive">
		           <table class="table table-bordered " id="jobs_publishedButNotWorkedOnTable" width="100%" cellspacing="0">
		           
		              <thead>
		                <tr>
		                 
		                 
		                 
		                 <th>Job Number</th>
		                 <th>Applicant Name</th>
		                 <th>Application Type</th>
		               <!--   <th style="display:none">Status</th> -->
		                 <!-- <th>Status</th> -->
		                
		                 <th>Date Published</th>
		                
		                 <th >Action</th>
		                 
		                 
		                 
		                 
		                 
		                 <!-- 	<th data-field="customer.name" data-align="center" data-sortable="true">customer</th>
		                    <th data-field="type" data-align="center" data-sortable="true">type</th>
		                    <th data-field="description" data-align="center" data-sortable="true">description</th>
		                    <th data-field="cutter" data-align="center" data-sortable="true">cutter</th> 
		                    <th data-field="valid_s" data-align="center" data-sortable="true">valid</th>
		                  -->
		                 
		                 </tr>
		              </thead>
		              
	                  <tbody>
	                  </tbody>
	               </table>
		         </div>


			</div>
			<div class="modal-footer ">

				
				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->



			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>




<div class="modal fade" id="addOldCaseModal" tabindex="-1"
	role="dialog" aria-labelledby="publishedButNotWorkedOnModal" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<h4 class="modal-title custom_align" id="Heading">Add Application to Publication List</h4>
			</div>
			<div class="modal-body">
				
				<div class="row">
	        <div class="col-sm-6">
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bar-chart"></i>Find Application</div>
	            <div class="card-body">
	              	<form id="frmFindJobForPublication"  method="get">
	
			          <div class="form-group">
			            <div class="form-row">
			            
			              <div class="col-md-8">
			                
			                <input class="form-control" id="job_search_value"  type="text" required  placeholer = "Enter Job number for search">
			              </div>
			              <div class="col-md-4">
			              	
			                <button type="submit" class="btn btn-primary btn-block" value="Search" id="" > Search </button>
			                
			              </div>
			            </div>
			          </div>
			        </form>
	            
	
	            </div>
	          </div>
	
	        </div>
	        
	        <div class="col-sm-6">
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fa fa-bar-chart"></i>Application Details
				  <button class="btn btn-warning btn-icon-split float-right" data-toggle="modal" data-target="#edit_application_for_publication"
				  > <span class="icon text-white-50"> <i class="fas fa-edit"></i>
				  </span> <span class="text">Edit</span>
				  </button>
				</div>
	            <div class="card-body">
	              	<form id="frmAddToPublicationList"  method="get">
			          <div class="form-group">
			            <div class="form-row">
			            <label for="search_value">Applicant Name</label>
         
			                <input class="form-control" id="rs_ar_name"  type="text"  readonly required >
			              
			            </div>
			            <br>
			             <div class="form-row">
			            <label for="search_value">Grantor Name</label>
         
			                <input class="form-control" id="rs_grantor_name"  type="text"  readonly required >
			              
			            </div>
			            <br>
			            
			            
			            <div class="form-row">
			             
			              <div class="col-md-6">
			                <label for="search_value">Job number</label>
			                <input class="form-control" id="rs_job_number"  type="text" required readonly>
			              </div>
			              <div class="col-md-6">
			              	<label for="search_value">Case Number</label>
			                <input class="form-control" id="rs_case_number"  type="text" required readonly >
			                
			              </div>
			            </div>
			            <BR />
			            
			         
			             <div class="form-row">
			             
			              <div class="col-md-6">
			                <label for="search_value">Locality</label>
			                <input class="form-control" id="rs_locality"  type="text" required readonly >
			              </div>
			              
			              
			              <div class="col-md-6">
			                <label for="search_value">Type of Interest</label>
			                <input class="form-control" id="rs_type_of_interest"  type="text" required readonly>
			              </div>
			              
			            </div>
			            
			            
			            <div class="form-row">
			             
			              <div class="col-md-6">
			                <label for="search_value">Extent</label>
			                <input class="form-control" id="rs_extent"  type="text" required readonly>
			              </div>
			              <div class="col-md-6">
			              	<label for="search_value">Registry Map Ref</label>
			                <input class="form-control" id="rs_registry_mapref"  type="text" readonly required >
			                
			              </div>
			            </div>
			            <BR />
			            
			            
			            <div class="form-row">
			             
			              <div class="col-md-6">
			              <br>
			              		<button type="submit" class="btn btn-success btn-block btn-xl" value="Search" id="btnBarcoder"  data-btn_name="NP"> Add to Publication List </button>
			              		
			              </div>
			               <div class="col-md-6">
			              <br>
			              		<button type="button" class="btn btn-primary btn-block btn-xl" value="Search" id="btnAddToSP" data-btn_name="SP" > Send for Special Publication</button>
			              		
			              </div>
			            </div>
			            <BR />
			            
			            
			            

			          </div>
			        </form>
	            </div>
	          </div>
	        </div>
      	  </div>


			</div>
			<div class="modal-footer ">

				
				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>






				<!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-warning btn-lg" ><span class="glyphicon glyphicon-ok-sign"></span>Add to List</button>
       -->



			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<div class="modal fade" id="edit_application_for_publication" tabindex="-1"
	role="dialog" aria-labelledby="publishedButNotWorkedOnModal" aria-hidden="true"
>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title custom_align" id="Heading">Update Application Details</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"
				>
					<span class="glyphicon glyphicon-remove" aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">

			<div class="row">
				<div class="col-lg-12">
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
							<div id="collapseparties" class="" role="tabpanel"
								aria-labelledby="headingThree"
							>
								<div class="card-body">
		
		
									<button type="button" class="btn btn-primary"
										id="lrd_btn_add_parties" data-placement="top"
										data-toggle="modal" data-target="#addeditpartyGeneral"
										data-toggle="tooltip" title="Add party"
									>
										<i class="fa fa-plus-circle"></i>
									</button>
		
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
								></i>Application Details <span id="job_number_placeholder"></span>
								</a> 
								
							</div>
							<div select_update_case_information id="collapsedetails"
								class="collapse card-body  show" role="tabpanel"
								aria-labelledby="headingTwo"
							>
								<div class="card-body">
		
									<form id='frmFurtherEntries_pm'>
										<div class="form-row"></div>
										<div class="form-row">
											
											
											
									
											<input type="hidden" id="main_service_id_fe" name="main_service_id_fe" value=""> 
											<input type="hidden" id="main_service_sub_id_fe" name="main_service_sub_id_fe" value="">
											
											
											
											
											
											
											<div class="col-md-6">
												<div class="form-group">
													<label for="inputEmail4">Job Number</label> <input
														type="text" class="form-control" id="fe_job_number"
														placeholder="Case number" required readonly
													>
												</div>
												
												
												<div class="form-group">
													<label for="">Type of Interest</label> <select
														class="form-control" id="fe_type_of_interest" 
													>
														<option>Select Type of Interest</option>
														<option value="LEASEHOLD">LEASEHOLD</option>
														<option value="FREEHOLD">FREEHOLD</option>
													</select>
		
		
												</div>
		
												
												
												<div class="form-group">
													<label for="">Registry Map Ref.</label> 
													<input type="text" class="form-control" id="fe_registry_mapref" placeholder="">
												</div>
												<div class="form-group">
													<label for="inputEmail4">Transaction Number</label> 
													<input
														type="text" class="form-control" id="fe_transaction_number"
														placeholder="Case number" required readonly
													>
												</div>
											</div>
		
											<div class="col-md-6">
												<div class="form-group">
													<label for="inputEmail4">Case Number</label> <input
														type="text" class="form-control" id="fe_case_number"
														placeholder="Case number" required readonly 
													>
												</div>
		
												<div class="form-group">
													<label for="">Locality</label> <input type="text" class="form-control"
														id="fe_locality"  
													>
														
		
												</div>
												
												
												<div class="form-group">
													<label for="">Extent</label> <input type="text"
														class="form-control" id="fe_extent" placeholder=""  
													>
												</div>
		
												
												
												
												
		
											</div>
		
		
										</div>
		
		
		
										<div class="dropdown-divider"></div>
										<div id="alert-display-space"></div>
										<div class="form-group float-right">
		
		
											<button type="button" data-dismiss="modal"
												class="btn btn-secondary float-right"
											>Close</button>
											
											
											<span class="float-right">&nbsp;&nbsp;&nbsp;&nbsp;</span>
											<button type="submit" id="btnAddFurtherDetails"
												class="btn btn-success float-right"
											>Save Changes</button>
											
		
										</div>
		
									</form>
		
									
								</div>
								
							</div>
						</div>
		
						<!-- Example Bar Chart Card-->
		
		
		
		
					</div>
		
		
		
		
				</div>
			</div>


			</div>
			<!-- <div class="modal-footer ">

				
				<div class="my-2"></div>
				<a href="#" data-dismiss="modal"
					class="btn btn-danger btn-icon-split"
				> <span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">Close</span>

				</a>



			</div> -->
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>



	<jsp:include page="../includes/_footer.jsp"></jsp:include>