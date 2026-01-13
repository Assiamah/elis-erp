<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


  <!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Bulk Regional Number</h1>
                    <!-- <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Search and verify stamp duty payment</p> -->
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Bulk Regional Number</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->
        
       <div class="row g-4">
			<!-- Main Content Area -->
			<div class="col-lg-8">
				<div class="card border-0 shadow-sm">
				<div class="card-body p-4">
					<!-- Bulk Regional Number Section -->
					<div class="card border-0 shadow-sm mb-4">
					<div class="card-header bg-primary bg-gradient text-white d-flex justify-content-between align-items-center" 
						data-bs-toggle="collapse" data-bs-target="#collapseBulkRegional" 
						aria-expanded="true" aria-controls="collapseBulkRegional">
						<h5 class="mb-0">
						<i class="fas fa-file-alt me-2"></i>Bulk Regional Number Processing
						</h5>
						<i class="fas fa-chevron-down transition-rotate"></i>
					</div>
					<div id="collapseBulkRegional" class="collapse show">
						<div class="card-body p-4">
						<!-- Service Selection Card -->
						<div class="card border mb-4">
							<div class="card-header bg-dark bg-opacity-10 border-bottom">
							<h6 class="mb-0"><i class="fas fa-cogs me-2"></i>Service Selection</h6>
							</div>
							<div class="card-body">
							<div class="row g-3">
								<div class="col-md-6">
								<label class="form-label fw-bold">Main Service</label>
								<select id="main_service_cp" class="form-select" disabled>
									<option value="1.0-APPLICATION FOR REGIONAL NUMBER" selected>
									APPLICATION FOR REGIONAL NUMBER
									</option>
								</select>
								</div>
								<div class="col-md-6">
								<label class="form-label fw-bold">Sub Service</label>
								<select name="sub_service_cp" id="sub_service_cp" class="form-select" disabled>
									<option value="1-APPLICATION FOR REGIONAL NUMBER" selected>
									APPLICATION FOR REGIONAL NUMBER
									</option>
								</select>
								</div>
							</div>
							</div>
						</div>

						<!-- Two Column Layout -->
						<div class="row g-4">
							<!-- License Surveyor's Details -->
							<div class="col-lg-6">
							<div class="card border h-100">
								<div class="card-header bg-dark bg-opacity-10 border-bottom">
								<h6 class="mb-0"><i class="fas fa-user-tie me-2"></i>License Surveyor's Details</h6>
								</div>
								<div class="card-body">
								<!-- Search Input -->
								<div class="mb-3">
									<label class="form-label fw-bold">License Number Search</label>
									<div class="input-group">
									<input type="text" class="form-control" id="txt_brn_licenced_number" 
											placeholder="Enter license number" required>
									<button class="btn btn-primary" type="button" id="btn_brn_licenced_number_search">
										<i class="fas fa-search"></i>
									</button>
									</div>
								</div>
								
								<!-- Surveyor Details -->
								<div class="row g-3">
									<div class="col-md-6">
									<label class="form-label fw-bold">Name</label>
									<input type="text" class="form-control bg-light" id="txt_brn_licenced_name" style="cursor: not-allowed;" readonly>
									</div>
									<div class="col-md-6">
									<label class="form-label fw-bold">Status</label>
									<input type="text" class="form-control bg-light" id="txt_brn_licenced_status_new" style="cursor: not-allowed;" readonly>
									</div>
								</div>
								</div>
							</div>
							</div>

							<!-- Bill Generation -->
							<div class="col-lg-6">
							<div class="card border h-100">
								<div class="card-header bg-dark bg-opacity-10 border-bottom">
								<h6 class="mb-0"><i class="fas fa-file-invoice-dollar me-2"></i>Bill Generation</h6>
								</div>
								<div class="card-body">
								<!-- Quantity Input -->
								<div class="mb-3">
									<label class="form-label fw-bold">Application Quantity</label>
									<div class="input-group">
									<input type="number" class="form-control" id="txt_brn_bill_application_qty" 
											placeholder="Enter quantity" min="1" required>
									<button class="btn btn-primary" type="button" id="btn_brn_generate_bill">
										<i class="fas fa-file-invoice me-2"></i>Generate Bill
									</button>
									</div>
								</div>
								
								<!-- Office Region Selection -->
								<div class="mb-3">
									<label class="form-label fw-bold">Office Region</label>
									<select name="new_bill_application_office_region_reg_no" 
											id="new_bill_application_office_region_reg_no" 
											class="form-select" data-style="btn-info">
									<option value="-1">Select Office Region</option>
									<c:forEach items="${officeregionlist}" var="officeregion">
										<option value="${officeregion.ord_region_code}">
										${officeregion.ord_region_name}
										</option>
									</c:forEach>
									</select>
								</div>
								</div>
							</div>
							</div>
						</div>

						<!-- Process Acknowledgement Section -->
						<div class="row g-4 mt-3">
							<div class="col-12">
							<div class="card border">
								<div class="card-header bg-dark bg-opacity-10 border-bottom">
								<h6 class="mb-0"><i class="fas fa-check-circle me-2"></i>Process Acknowledgement</h6>
								</div>
								<div class="card-body">
								<!-- Reference Number Input -->
								<div class="mb-4">
									<label class="form-label fw-bold">Reference Number Check</label>
									<div class="input-group">
									<input type="text" class="form-control" id="txt_ref_number_for_brn" 
											placeholder="Enter reference number" required>
									<button class="btn btn-primary" type="button" 
											id="btn_load_bill_details_after_payment_bulk_regional_number"
											data-bs-toggle="tooltip" title="Check Bill Status">
										<i class="fas fa-search"></i> Check Status
									</button>
									</div>
								</div>
								
								<!-- Action Buttons -->
								<div class="d-flex flex-wrap gap-3">
									<button type="button" class="btn btn-info btn-lg px-4" 
											id="btn_upload_regional_by_csv"
											data-bs-toggle="modal" data-bs-target="#filefileRegionalNumberUploadModal"
											data-bs-tooltip="tooltip" title="Upload CSV File">
									<i class="fas fa-file-upload me-2"></i>Upload CSV
									</button>
									<button class="btn btn-success btn-lg px-4 ms-auto" 
											id="btn_process_bulk_regional_number">
									<i class="fas fa-play-circle me-2"></i>Process Data
									</button>
								</div>
								</div>
							</div>
							</div>
						</div>

						<!-- Data Table Section -->
						<div class="mt-4">
							<div class="card border">
							<div class="card-header bg-dark bg-opacity-10 border-bottom d-flex justify-content-between align-items-center">
								<h6 class="mb-0"><i class="fas fa-table me-2"></i>Applications List</h6>
								<span class="badge bg-primary rounded-pill" id="tableCount">0</span>
							</div>
							<div class="card-body p-0">
								<div class="table-responsive">
								<table class="table table-hover table-striped mb-0" id="bulk_regional_number_list_dataTable_smd">
									<thead class="table-light">
									<tr>
										<th>ID</th>
										<th>Applicant Name</th>
										<th>Locality</th>
										<th>Gender</th>
										<th>District</th>
										<th>Region</th>
									</tr>
									</thead>
									<tbody>
									<!-- Data will be populated here -->
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

			<!-- Right Sidebar -->
			<div class="col-lg-4">
				<!-- Instructions Card -->
				<div class="card border-0 shadow-sm mb-4">
				<div class="card-header bg-info bg-gradient text-white d-flex justify-content-between align-items-center"
					data-bs-toggle="collapse" data-bs-target="#collapseInstructions" 
					aria-expanded="true" aria-controls="collapseInstructions">
					<h5 class="mb-0">
					<i class="fas fa-info-circle me-2"></i>Instructions
					</h5>
					<i class="fas fa-chevron-down transition-rotate"></i>
				</div>
				<div id="collapseInstructions" class="collapse show">
					<div class="card-body">
					<div class="alert alert-info mb-3">
						<i class="fas fa-lightbulb me-2"></i>
						<strong>Quick Guide:</strong> Follow these steps to process bulk regional numbers.
					</div>
					
					<ol class="list-group list-group-numbered list-group-flush">
						<li class="list-group-item d-flex align-items-start">
						<div class="ms-2 me-auto">
							<div class="fw-bold">Search License Surveyor</div>
							Enter license number to verify surveyor details
						</div>
						</li>
						<li class="list-group-item d-flex align-items-start">
						<div class="ms-2 me-auto">
							<div class="fw-bold">Generate Bill</div>
							Specify quantity and select office region
						</div>
						</li>
						<li class="list-group-item d-flex align-items-start">
						<div class="ms-2 me-auto">
							<div class="fw-bold">Upload Data</div>
							Upload CSV file with applicant details
						</div>
						</li>
						<li class="list-group-item d-flex align-items-start">
						<div class="ms-2 me-auto">
							<div class="fw-bold">Process Applications</div>
							Verify reference number and process data
						</div>
						</li>
					</ol>
					
					<!-- Important Notes -->
					<div class="alert alert-warning mt-3">
						<h6><i class="fas fa-exclamation-triangle me-2"></i>Important Notes:</h6>
						<ul class="mb-0 ps-3">
						<li>Ensure all data is validated before processing</li>
						<li>Keep reference numbers for tracking</li>
						<li>Verify bill status before final processing</li>
						</ul>
					</div>
					</div>
				</div>
				</div>

				<!-- Quick Actions Card -->
				<div class="card border-0 shadow-sm">
				<div class="card-header bg-secondary bg-gradient text-white">
					<h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
				</div>
				<div class="card-body">
					<div class="d-grid gap-2">
					<button class="btn btn-outline-primary btn-lg d-flex align-items-center justify-content-start">
						<i class="fas fa-file-export me-3"></i>
						<div class="text-start">
						<div class="fw-bold">Export Data</div>
						<small class="text-muted">Download current list</small>
						</div>
					</button>
					<button class="btn btn-outline-success btn-lg d-flex align-items-center justify-content-start">
						<i class="fas fa-history me-3"></i>
						<div class="text-start">
						<div class="fw-bold">Recent Processes</div>
						<small class="text-muted">View last 10 operations</small>
						</div>
					</button>
					<button class="btn btn-outline-info btn-lg d-flex align-items-center justify-content-start">
						<i class="fas fa-question-circle me-3"></i>
						<div class="text-start">
						<div class="fw-bold">Help & Support</div>
						<small class="text-muted">Get assistance</small>
						</div>
					</button>
					</div>
				</div>
				</div>
			</div>
			</div>

	</div>
</div>
  
  

