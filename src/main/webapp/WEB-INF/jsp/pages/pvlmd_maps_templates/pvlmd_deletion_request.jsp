<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="d" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.*" %>
<jsp:include page="../includes/_header.jsp"></jsp:include>
<input type="text" name="regional_code" value="${sessionScope.regional_code}"  hidden/> 
				 
<!-- Begin Page Content -->
   <div class="container-fluid">
	<section class="section dashboard">
		 <!-- Page Heading -->
                <div class="row mb-4">
                	 <div class="col-md-12">
		                <div class=" ">
		                   
					         <nav>
				                <ol class="breadcrumb">
				                  <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-fw fa-home"></i></a></li>
				                  <li class="breadcrumb-item active">PVLMD Amendment Request </li>
				                </ol>
			               </nav>
		                    
		                    
		                </div>	
	                </div>
				</div>
	
	
     	<div class="row mb-4">
      		<!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">
            <!-- Assigned Cases Card -->
            <div class="col-xl-3 col-md-6" id="parcel_deletion_requested">
              <div class="card border-left-info shadow h-100 py-2" id="body-bg-1">

                <div class="card-body">
	                  		<h5 class="card-title">Parcel [<small>Amendment Request</small>]</h5>
							
							<div class="d-flex align-items-center">
								<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
									<i class="fas fa-tasks fa-2x text-info"></i>
								</div>
								 <div class="ml-2">	
		                     	 	<h4 id="deletion_request_count"><c:out value="${parcel_delete_request_count}"></c:out></h4>
								 </div>
		                    </div>
                </div>

              </div>
            </div><!-- Assigned Cases Card -->

            
            
            <!-- <div class="col-xl-3 col-md-6" id="parcel_deletion_approved">			 
              <div class="card border-left-danger shadow h-100 py-2" id="body-bg-2">

                <div class="card-body">
        
                    <h5 class="card-title">Parcel [<small>Deletion Approval</small>]</h5>

	                <div class="d-flex align-items-center">
	                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
	                      <i class="fas fa-check-circle fa-2x text-danger"></i>
	                    </div>
	                    <div class="ml-2">
	                      <h4 id="deletion_approved_count"><c:out value="${parcel_delete_approved_count}"></c:out></h4>
	
	                    </div>
	                  </div>
					
                </div>
              </div>
			 
            </div> -->
			<!-- Archived Cases Card -->

			<div class="col-xl-3 col-md-6" id="transaction_deletion_requested">			 
				<div class="card border-left-warning shadow h-100 py-2" id="body-bg-3">
  
				  <div class="card-body">
		  
					  <h5 class="card-title">Transaction [<small>Amendment Request</small>]</h5>
  
					  <div class="d-flex align-items-center">
						  <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
							<i class="fas fa-tasks fa-2x text-warning"></i>
						  </div>
						  <div class="ml-2">
							<h4 id="deletion_approved_count"><c:out value="${transaction_delete_request_count}"></c:out></h4>
	  
						  </div>
						</div>
					  
				  </div>
				</div>
			   
			  </div><!-- Archived Cases Card -->

			  <div class="col-xl-3 col-md-6" id="parcel_deletion_approved">			 
				<div class="card border-left-success shadow h-100 py-2" id="body-bg-2">
  
				  <div class="card-body">
		  
					  <h5 class="card-title">Parcel [<small>Amendment Approval</small>]</h5>
  
					  <div class="d-flex align-items-center">
						  <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
							<i class="fas fa-check-circle fa-2x text-success"></i>
						  </div>
						  <div class="ml-2">
							<h4 id="deletion_approved_count"><c:out value="${parcel_delete_approved_count}"></c:out></h4>
	  
						  </div>
						</div>
					  
				  </div>
				</div>
			   
			  </div>
		   

			  <div class="col-xl-3 col-md-6" id="transaction_deletion_approved">			 
				<div class="card border-left-success shadow h-100 py-2" id="body-bg-4">
  
				  <div class="card-body">
		  
					  <h5 class="card-title">Transaction [<small>Amendment Approval</small>]</h5>
  
					  <div class="d-flex align-items-center">
						  <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
							<i class="fas fa-check-circle fa-2x text-success"></i>
						  </div>
						  <div class="ml-2">
							<h4 id="deletion_approved_count"><c:out value="${transaction_delete_approved_count}"></c:out></h4>
	  
						  </div>
						</div>
					  
				  </div>
				</div>
			   
			  </div>
			  <!-- Archived Cases Card -->
		   
     	
     
     </div>
    </div>
  </div>
			
		 <div class="row mb-4 d-none" id="parcel_search">
		 		<div class="col-md-9">
								 	
							    
								    <div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="pvlmd_layer" required>
									  <label class="custom-control-label" for="rbtn_search_type1">PVLMD</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
									  <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="garro_layer" required>
									  <label class="custom-control-label" for="rbtn_search_type2">GARRO</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
										<input type="radio" id="rbtn_search_type3" name="rbtn_search_type" class="custom-control-input rbtn_search_type" value="cro_layer" required>
										<label class="custom-control-label" for="rbtn_search_type3">CRO</label>
									  </div>
									<br><br>
						          <div class="form-group">
						            <div class="form-row mb-4">
						              <div class="col-md-5">
						                
						                <input class="form-control" id="pd_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
						              </div>
						              <div class="col-md-3">
						              	
						                <button type="button" class="btn btn-warning" value="Search" id="btnPJobSearch" ><i class="fas fa-search"></i> Search </button>
						                
						              </div>
						            </div>
						            </div>
						            
						            </div>
		 </div>	


		 <!-- <div class="row mb-4 d-none" id="transaction_search">
			<div class="col-md-9">
								
							 <div class="form-group">
							   <div class="form-row mb-4">
								 <div class="col-md-5">
								   
								   <input class="form-control" id="td_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
								 </div>
								 <div class="col-md-3">
									 
								   <button type="button" class="btn btn-warning" value="Search" id="btnTJobSearch" ><i class="fas fa-search"></i> Search </button>
								   
								 </div>
							   </div>
							   </div>
							   
							   </div>
			</div>	 -->

			<div class="row mb-4 d-none" id="transaction_search">
				<div class="col-md-9">
									
							   
								   <!-- <div class="custom-control custom-radio custom-control-inline">
									 <input type="radio" id="rbtn_search_type4" name="rbtn_search_type_t" class="custom-control-input rbtn_search_type" value="pvlmd_layer" required>
									 <label class="custom-control-label" for="rbtn_search_type1">PVLMD</label>
								   </div>
								   <div class="custom-control custom-radio custom-control-inline">
									 <input type="radio" id="rbtn_search_type5" name="rbtn_search_type_t" class="custom-control-input rbtn_search_type" value="garro_layer" required>
									 <label class="custom-control-label" for="rbtn_search_type2">GARRO</label>
								   </div>
								   <div class="custom-control custom-radio custom-control-inline">
									   <input type="radio" id="rbtn_search_type6" name="rbtn_search_type_t" class="custom-control-input rbtn_search_type" value="cro_layer" required>
									   <label class="custom-control-label" for="rbtn_search_type3">CRO</label>
									 </div> -->

									 <div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="rbtn_search_type" id="inlineRadio1" value="pvlmd_layer">
										<label class="form-check-label" for="inlineRadio1">PVLMD</label>
									  </div>
									  <div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="rbtn_search_type" id="inlineRadio2" value="garro_layer">
										<label class="form-check-label" for="inlineRadio2">GARRO</label>
									  </div>
									  <div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="rbtn_search_type" id="inlineRadio3" value="cro_layer">
										<label class="form-check-label" for="inlineRadio3">CRO</label>
									  </div>
								   <br><br>
								 <div class="form-group">
								   <div class="form-row mb-4">
									 <div class="col-md-5">
									   
									   <input class="form-control" id="pt_search_value"  type="text" aria-describedby="" placeholder="Enter search inputs" required >
									 </div>
									 <div class="col-md-3">
										 
									   <button type="button" class="btn btn-warning" value="Search" id="btnTJobSearch" ><i class="fas fa-search"></i> Search </button>
									   
									 </div>
								   </div>
								   </div>
								   
								   </div>
		</div>	
			
	      <div class="row mb-4" id="parcel_table_tab">
	            <div class="col-md-12">
	              <div class="card">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i><span class="h5">Parcel Details</span> <span
						class="col-md-3 float-right ">
						 <!-- <button class="btn btn-success btn-icon-split float-right "
							id="btnViewBatchlist" style="margin-right: -15px">
							<span class="icon text-white-50"> <i class="fas fa-angle-double-right"></i></span><span
								class="text">Archive</span>
						</button> -->
					</span>
					</div>
	                <div class="card-body">
						<h5 class="card-title"><span id="card_title"> </span></h5>

						<div class="d-none text-small" id="accordion_p">
							<div class="card">
							  <div class="card-header" id="headingOne">
								<h5 class="mb-0">
								  <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
									PVLMD Parcel
								  </button>
								</h5>
							  </div>
						  
							  <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion_p">
								<div class="card-body">
									<div class="tab-content mt-4" id="pvlmd_parcel_tab">
										<div id="" class="table-responsive">
											<table class="table " id="table_pvlmd_parcel_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
												  <thead>
													<tr>
														<th>#</th>
														<th>Reference No.</th>
														<th>Job No.</th>
														 <th>Locality</th>
														<th>Plotting Date</th>						        
														<th>Plotted By</th>
														<th class="text-center">Status</th>	
														<th class="text-center">Actions</th>
													</tr>
												  </thead>
												  <tbody id="table_body">
													
												  </tbody>
											   </table>
										</div>
									</div>
								</div>
							  </div>
							</div>
							<div class="card">
							  <div class="card-header" id="headingTwo">
								<h5 class="mb-0">
								  <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
									GARRO Parcel
								  </button>
								</h5>
							  </div>
							  <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion_p">
								<div class="card-body">
									<div class="tab-content mt-4" id="garro_parcel_tab">
										<div id="" class="table-responsive">
											<table class="table " id="table_garro_parcel_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
												  <thead>
													<tr>
														<th>#</th>
														<th>GID</th>
														<th>Reference No.</th>
														<!-- <th>Document No.</th> -->
														<!-- <th>Grantee</th>					        
														<th>Location</th>
														<th>Plotting Date</th>	 -->
														<th class="text-center">Status</th>	
														<th class="text-center">Actions</th>
													</tr>
												  </thead>
												  <tbody id="table_body">
													
												  </tbody>
											   </table>
										</div>
									</div>
								</div>
							  </div>
							</div>
							<div class="card">
							  <div class="card-header" id="headingThree">
								<h5 class="mb-0">
								  <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
									CRO Parcel
								  </button>
								</h5>
							  </div>
							  <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion_p">
								<div class="card-body">
									<div class="tab-content mt-4" id="cro_parcel_tab">
										<div id="" class="table-responsive">
											<table class="table " id="table_cro_parcel_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
												  <thead>
													<tr>
														<th>#</th>
														<th>Reference No.</th>
														<th>LS No.</th>
														<th>Plan No.</th>		
														<th>Plot No.</th>				        
														<th>Location</th>
														<th class="text-center">Status</th>	
														<th class="text-center">Actions</th>
													</tr>
												  </thead>
												  <tbody id="table_body">
													
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
	            </div>
	          </div>



			  <div class="row mb-4 d-none" id="transaction_table_tab">
	            <div class="col-md-12">
	              <div class="card">
	              	<div class="card-header bg-dark text-white">
						<i class="fa fa-bar-chart"></i><span class="h5">Transaction Details</span> <span
						class="col-md-3 float-right ">
						 <!-- <button class="btn btn-success btn-icon-split float-right "
							id="btnViewBatchlist" style="margin-right: -15px">
							<span class="icon text-white-50"> <i class="fas fa-angle-double-right"></i></span><span
								class="text">Archive</span>
						</button> -->
					</span>
					</div>

					<div class="card-body">
						<h5 class="card-title"><span id="card_title"> </span></h5>

					  <div class="d-none text-small" id="accordion_t">
						<div class="card">
						  <div class="card-header" id="headingOne">
							<h5 class="mb-0">
							  <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne_t" aria-expanded="true" aria-controls="collapseOne">
								PVLMD Transaction
							  </button>
							</h5>
						  </div>
					  
						  <div id="collapseOne_t" class="collapse" aria-labelledby="headingOne" data-parent="#accordion_t">
							<div class="card-body">
								<div class="tab-content mt-4" id="pvlmd_parcel_tab">
									<div id="" class="table-responsive">
										<table class="table " id="table_pvlmd_transaction_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
											  <thead>
												<tr>
													<th>#</th>
													<th>Reference No.</th>
													<!-- <th>Job No.</th>						        
													<th>Applicant Name</th>
													 <th>Property No.</th>
													<th>Instrument Type</th> -->

													<th>Document Number</th>
													<th>Instrument Type</th>
													<th>Instrument Date</th>
													<th>Consent Date</th>
													<th>Grantor</th>
													<th>Grantee</th>
													<th>Remarks</th>

													<th class="text-center">Status</th>	
													<th class="text-center">Actions</th>
												</tr>
											  </thead>
											  <tbody id="table_body">
												
											  </tbody>
										   </table>
									</div>
								</div>
							</div>
						  </div>
						</div>
						<div class="card">
						  <div class="card-header" id="headingTwo">
							<h5 class="mb-0">
							  <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo_t" aria-expanded="false" aria-controls="collapseTwo">
								GARRO Transaction
							  </button>
							</h5>
						  </div>
						  <div id="collapseTwo_t" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion_t">
							<div class="card-body">
								<div class="tab-content mt-4" id="garro_parcel_tab">
									<div id="" class="table-responsive">
										<table class="table " id="table_garro_transaction_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
											  <thead>
												<tr>
													<th>#</th>
													<th>Document No.</th>
													<th>Property No.</th>				        
													<th>Location</th>
													<th>Applicant Name</th>	
													<th>Nature of Interest</th>
													<th>Date of Instrument</th>
													<th class="text-center">Status</th>	
													<th class="text-center">Actions</th>
												</tr>
											  </thead>
											  <tbody id="table_body">
												
											  </tbody>
										   </table>
									</div>
								</div>
							</div>
						  </div>
						</div>
						<div class="card">
						  <div class="card-header" id="headingThree">
							<h5 class="mb-0">
							  <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree_t" aria-expanded="false" aria-controls="collapseThree">
								CRO Transaction
							  </button>
							</h5>
						  </div>
						  <div id="collapseThree_t" class="collapse" aria-labelledby="headingThree" data-parent="#accordion_t">
							<div class="card-body">
								<div class="tab-content mt-4" id="cro_parcel_tab">
									<div id="" class="table-responsive">
										<table class="table " id="table_cro_transaction_list"  width="100%" cellspacing="0" style="text-transform: uppercase;">
											  <thead>
												<tr>
													<th>#</th>
													<th>Document No.</th>
													<th>Document Type</th>
													<th>Purpose</th>	
													<th>Applicant Name</th>	
													<th>Commencement Date</th>
													<th class="text-center">Status</th>	
													<th class="text-center">Actions</th>
												</tr>
											  </thead>
											  <tbody id="table_body">
												
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
	            </div>
	          </div>

     </section>

	</div>
<!-- End Page Content -->


<jsp:include page="../includes/_footer.jsp"></jsp:include>
<script type="text/javascript" src="pvlmd_maps_templates/_function.js"></script>