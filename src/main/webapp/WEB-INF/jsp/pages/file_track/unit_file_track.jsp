<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>


<jsp:include page="../file_track/includes/header.jsp"></jsp:include>

<!-- Begin Page Content -->
   <div class="container-fluid">
	<section class="section dashboard">
		 <!-- Page Heading -->
              
	
	
		 
		 <!-- Content Row -->
		<div class="row">

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-primary shadow h-100 py-2"
				id="body-dg-1">
				<div class="card-body">
				<!-- <c:forEach items="${all_apps}" var="appl"  varStatus="appl_loop"> -->
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="1">
						<div class="row no-gutters align-items-center">
							<div class="col px-2">
								<div
									class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total
									Application(s)</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800">
										<fmt:parseNumber var="a" type="number" value="${appl.count}" />
										<c:out value="${a}"/>
									</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-file-alt fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
				<!-- </c:forEach> -->
				</div>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-success shadow h-100 py-2"
				id="body-bg-3">
				<div class="card-body">
				<!-- <c:forEach items="${incoming_app}" var="appl"  varStatus="appl_loop"> -->
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="3" id="3">
						<div class="row no-gutters align-items-center">
							<div class="col px-2">
								<div
									class="text-xs font-weight-bold text-success text-uppercase mb-1">
									Incoming Application(s)</div>
									<div class="h5 mb-0 font-weight-bold text-gray-800" id="text-3">
										<fmt:parseNumber var="a" type="number" value="${appl.count}" />
										<c:out value="${a}"/>
									</div>
								</div>
							<div class="col-auto">
								<i class="fas fa-sign-in fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
					<!-- </c:forEach> -->
				</div>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-info shadow h-100 py-2" id="body-bg-2">
				<div class="card-body">
				<!-- <c:forEach items="${outgoing_app}" var="appl"  varStatus="appl_loop"> -->
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="2" id="2">
						<div class="row no-gutters align-items-center">
							<div class="col px-2">
								<div
									class="text-xs font-weight-bold text-info text-uppercase mb-1">Outgoing Application(s)</div>
								
										<div class="h5 mb-0 font-weight-bold text-gray-800" id="text-2">
										<fmt:parseNumber var="a" type="number" value="${appl.count}" />
										<c:out value="${a}"/>
									</div>
								
							</div>
							<div class="col-auto">
								<i class="fas fa-sign-out fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
					<!-- </c:forEach> -->
				</div>
			</div>
		</div>

		<!-- Pending Requests Card Example -->
		<div class="col-xl-3 col-md-6 mb-4">
			<div class="card border-left-warning shadow h-100 py-2"
				id="body-bg-4">
				<div class="card-body">
				<!-- <c:forEach items="${within_unit_app}" var="appl"  varStatus="appl_loop"> -->
					<a href="#" class="text-decoration-none btnLoadUnitApplications"
						data-id="4" id="4">
						<div class="row no-gutters align-items-center">
							<div class="col px-2">
								<div
									class="text-xs font-weight-bold text-warning text-uppercase mb-1">Total
									Application(s) Within Unit</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800" id="text-4">
										<fmt:parseNumber var="a" type="number" value="${appl.count}" />
										<c:out value="${a}"/>
									</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-building fa-2x text-gray-300"></i>
							</div>
						</div>
					</a>
					<!-- </c:forEach> -->
				</div>
			</div>
		</div>
	</div>

	<!-- Content Row -->
	
	<div class="row mb-4" id="archived_search">
 		<div class="col-md-12">
 			<div class="card">
 				<div class="card-body">
 					<div class="col-md-9">
			          <div class="form-group">
			            <div class="form-row mt-4 mb-4">
			              <div class="col-md-5">
			                
			                <input class="form-control" id="search_keyword"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
			              </div>
			              <div class="col-md-3">
			              	
			                <button type="button" class="btn btn-warning" value="Search" id="btn-search" ><i class="fas fa-search"></i>Search </button>
			                
			              </div>
			            </div>
			            </div>
			          </div>
 				</div>
 			</div>
 		</div>
		 		
		 </div>	

	      <div class="row mb-4">
	            <div class="col-md-12">
	              <div class="card">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i>Enquiry Details <span
						class="col-md-6 text-right">
						<button class="btn btn-success btn-pill float-right mr-n-2" data-toggle="modal" data-target="#add_new_file">
							<span class="icon text-white"> <i class="fas fa-plus-circle"></i></span><span
								class="text">Add Application</span>
						</button>
						<!-- <button class="btn btn-success btn-pill float-right mr-2 " data-toggle="modal" data-target="#generate_report">
							<span class="icon text-white"> <i class="fas fa-chart-pie"></i></span><span
								class="text">Generate Report</span>
						</button> -->
						<!-- <button id="add_selected_files" onclick="batch_selected_files();" class="btn btn-danger btn-pill float-right mr-2 " data-toggle="modal" data-target="#viewBatchlistModal"> -->
						<button id="add_selected_files" class="btn btn-danger btn-pill float-right mr-2 " data-toggle="modal" data-target="#batch_purpose">
							<span class="icon text-white"> <i class="fas fa-paper-plane"></i></span><span
								class="text">Batch Selected Files</span>
						</button>
					</span>
					</div>
	                <div class="card-body">
	                	<div class="card card-body">
	                		<div class="tab-content mt-5" id="search_tab">
					            <div id="" class="table-responsive">
					                <table class="table table-fixed" id="table_list">
	              						<thead>
										    <tr>
										        <th class="text-start">#
										        	<!-- <input type="checkbox" onclick="toggle(this);" id="check_all" class="form-check-label check-item" style="margin: -20px 0px 2px 0px" /> -->
										      	</th>
										        <th>Reference No.</th>
										        <th>Application Type</th>
										        <th>Application Name</th>
										        <th>Subject/Location</th>
										        <th>Purpose</th>
												<th class="text-center">Actions</th>
										    </tr>
										  </thead>
										  <tbody>
										    
										  </tbody>
		                   	        </table>
					            </div>
					    	</div>
					    	
					    	<div class="tab-content mt-5" id="incoming_tab">
					            <div id="" class="table-responsive">
					                <table class="table table-fixed" id="incoming_list">
	              						<thead>
										    <tr>
										        <th class="text-start">#
										        	<!-- <input type="checkbox" onclick="toggle(this);" id="check_all" class="form-check-label check-item" style="margin: -20px 0px 2px 0px" /> -->
										      	</th>
										        <th>Reference No.</th>
										        <th>Application Type</th>
										        <th>Application Name</th>
										        <th>Subject/Location</th>
										        <th>Purpose</th>
												<th class="text-center">Actions</th>
										    </tr>
										  </thead>
										  <tbody>
										    
										  </tbody>
		                   	        </table>
					            </div>
					    	</div>
					    	
					    	<div class="tab-content mt-5" id="outgoing_tab">
					            <div id="" class="table-responsive">
					                <table class="table table-fixed" id="outgong_list">
	              						<thead>
										    <tr>
										        <th class="text-start">#
										        	<!-- <input type="checkbox" onclick="toggle(this);" id="check_all" class="form-check-label check-item" style="margin: -20px 0px 2px 0px" /> -->
										      	</th>
										        <th>Reference No.</th>
										        <th>Application Type</th>
										        <th>Application Name</th>
										        <th>Subject/Location</th>
										        <th>Purpose</th>
												<th class="text-center">Actions</th>
										    </tr>
										  </thead>
										  <tbody>
										    
										  </tbody>
		                   	        </table>
					            </div>
					    	</div>
					    	
					    	
					    	<div class="tab-content mt-5" id="within_unit_tab">
					            <div id="" class="table-responsive">
					                <table class="table table-fixed" id="within_unit_list">
	              						<thead>
										    <tr>
										        <th class="text-start">#
										        	<!-- <input type="checkbox" onclick="toggle(this);" id="check_all" class="form-check-label check-item" style="margin: -20px 0px 2px 0px" /> -->
										      	</th>
										        <th>Reference No.</th>
										        <th>Application Type</th>
										        <th>Application Name</th>
										        <th>Subject/Location</th>
										        <th>Purpose</th>
												<th class="text-center">Actions</th>
										    </tr>
										  </thead>
										  <tbody>
										    
										  </tbody>
		                   	        </table>
					            </div>
					    	</div>
	                	</div>
	                </div>
	              </div>
	            </div>
	          </div>

     </section>

	</div>
<!-- End Page Content -->

<jsp:include page="../file_track/includes/footer.jsp"></jsp:include>