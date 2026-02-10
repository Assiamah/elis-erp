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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Verify Bill Payment</h1>
                    <!-- <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Search and verify stamp duty payment</p> -->
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Verify Bill Payment</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->
          
          
        
        

       <div class="row g-4">
			<!-- Main Content Area -->
			<div class="col-lg-8">
				<div class="card shadow-sm">
					<div class="card-header bg-danger py-3">
						<div class="d-flex align-items-center">
							<i class="fas fa-search me-3 fs-4 text-warning"></i>
							<div>
								<h5 class="mb-0 fw-semibold">Search Bills</h5>
								<small class="opacity-75">Search bills to verify bill payment</small>
							</div>
						</div> 
					</div>
					
					<div class="card-body">
						<div class="row align-items-end g-3 mb-4">
							<div class="col-md-7">
								<label for="txt_ref_number_for_payment_rec" class="form-label fw-semibold">
									<i class="fas fa-search me-1"></i>Reference Number
								</label>
								<div class="input-group">
									<span class="input-group-text">
										<i class="fas fa-hashtag"></i>
									</span>
									<input class="form-control form-control-lg" 
										id="txt_ref_number_for_payment_rec" 
										type="text" 
										placeholder="Enter reference or job number" 
										required>
								</div>
							</div>
							<div class="col-md-5">
								<button class="btn btn-success btn-lg w-100" 
										id="btn_load_bill_details_after_payment_stamp_duty">
									<i class="fas fa-search me-2"></i>Search Bills
								</button>
							</div>
						</div>
						
						<div class="card border-light shadow-sm">
							<div class="card-body">
								<div id="payment_details_section" class="p-3 text-center">
									<div class="text-muted mb-3">
										<i class="fas fa-inbox fa-3x opacity-25"></i>
									</div>
									<h5 class="text-muted">Bill Details Will Appear Here</h5>
									<p class="small text-muted">Enter a reference number and click search to view bill details</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Documents Sidebar -->
			<div class="col-lg-4" id="document-section" style="display: none;">
				<!-- Application Documents -->
					<div class="card mb-4 shadow-sm">
						<div class="card-header bg-light d-flex justify-content-between align-items-center py-3">
							<h5 class="mb-0">
								<i class="fas fa-file-alt text-primary me-2"></i>Application Documents
							</h5>
							<a class="btn btn-link p-0 text-decoration-none" 
							data-bs-toggle="collapse" 
							href="#collapsedocs" 
							role="button">
								<i class="fas fa-chevron-down"></i>
							</a>
						</div>
						
						<div class="collapse show" id="collapsedocs">
							<div class="card-body">
								<div class="d-flex gap-2 mb-3">
									<button type="button" 
											class="btn btn-outline-primary" 
											id="btn_load_scanned_documents"
											title="View Documents">
										<i class="fas fa-eye me-2"></i>View Docs
									</button>
								</div>
								
								<div class="table-responsive">
									<table class="table table-hover table-sm" 
										id="lc_main_scanned_documents_dataTable">
										<thead class="table-light">
											<tr>
												<th>Document Name</th>
												<th width="120">Type</th>
											</tr>
										</thead>
										<tbody class="small">
											<!-- Documents will be loaded here -->
											<tr class="text-center text-muted">
												<td colspan="2" class="py-4">
													<i class="fas fa-folder-open me-2"></i>
													No documents loaded
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

					<!-- Public Documents -->
					<div class="card mb-4 shadow-sm">
						<div class="card-header bg-light d-flex justify-content-between align-items-center py-3">
							<h5 class="mb-0">
								<i class="fas fa-users text-info me-2"></i>Public Documents
							</h5>
							<a class="btn btn-link p-0 text-decoration-none" 
							data-bs-toggle="collapse" 
							href="#collapsepudocs" 
							role="button">
								<i class="fas fa-chevron-down"></i>
							</a>
						</div>
						
						<div class="collapse" id="collapsepudocs">
							<div class="card-body">
								<div class="d-flex gap-2 mb-3">
									<button type="button" 
											class="btn btn-outline-info" 
											id="btn_load_scanned_documents_public"
											title="View Public Documents">
										<i class="fas fa-eye me-2"></i>View Public Docs
									</button>
								</div>
								
								<div class="table-responsive">
									<table class="table table-hover table-sm" 
										id="lc_public_documents_dataTable">
										<thead class="table-light">
											<tr>
												<th>Document Name</th>
												<th width="120">Type</th>
											</tr>
										</thead>
										<tbody class="small">
											<!-- Public documents will be loaded here -->
											<tr class="text-center text-muted">
												<td colspan="2" class="py-4">
													<i class="fas fa-folder-open me-2"></i>
													No public documents
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

					<!-- Print Button -->
					<div class="d-grid">
						<button class="btn btn-primary btn-lg shadow-sm" 
								id="btnPrintEgcr2">
							<i class="fas fa-print me-2"></i>Print eGCR
						</button>
					</div>
			</div>
		</div>
      
       

      </div>     
        

</div>

  
  
  
  
  

