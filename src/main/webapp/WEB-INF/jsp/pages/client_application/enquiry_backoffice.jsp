 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


<div class="main-content app-content">
    <div class="container-fluid page-container">

      <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Enquiry Backoffice</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Enquiry Backoffice</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->
           
        <div class="row g-3">
			<!-- Main Search Card -->
			<div class="col-lg-8 col-xl-9">
				<div class="card border-0 shadow-sm">
					<div class="card-header bg-danger py-3">
						<div class="d-flex align-items-center">
							<i class="fas fa-search me-3 fs-4 text-warning"></i>
							<div>
								<h5 class="mb-0 fw-semibold">Search Applications</h5>
								<small class="opacity-75">Search applications by various criteria</small>
							</div>
						</div>
					</div>
					
					<div class="card-body">
						<form id="frmEnquiryJobSearch" method="post" class="needs-validation" novalidate>
							<!-- Search Type Selection -->
							<div class="mb-4">
								<label class="form-label fw-medium mb-3"><i class="fas fa-filter me-2"></i>Search By:</label>
								<div class="search-type-selector">
								<div class="row g-2 row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5">
										<div class="col">
											<input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="btn-check" value="job_number" required>
											<label class="btn btn-outline-primary w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type1">
												<i class="fas fa-hashtag me-2"></i>
												<span>Job Number</span>
											</label>
										</div>

										<div class="col">
											<input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="btn-check" value="case_number" required>
											<label class="btn btn-outline-primary w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type2">
												<i class="fas fa-folder me-2"></i>
												<span>Case Number</span>
											</label>
										</div>

										<div class="col">
											<input type="radio" id="rbtn_search_type3" name="rbtn_search_type" class="btn-check" value="regional_number" required>
											<label class="btn btn-outline-primary w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type3">
												<i class="fas fa-map-marker-alt me-2"></i>
												<span>Regional Number</span>
											</label>
										</div>

										<div class="col">
											<input type="radio" id="rbtn_search_type4" name="rbtn_search_type" class="btn-check" value="glpin" required>
											<label class="btn btn-outline-primary w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type4">
												<i class="fas fa-fingerprint me-2"></i>
												<span>GLPIN</span>
											</label>
										</div>

										<div class="col">
											<input type="radio" id="rbtn_search_type6" name="rbtn_search_type" class="btn-check" value="ref_number" required>
											<label class="btn btn-outline-primary w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type6">
												<i class="fas fa-file-alt me-2"></i>
												<span>Ref Number</span>
											</label>
										</div>
									</div>
								</div>
							</div>

							<!-- Search Input -->
							<div class="mb-4">
								<label for="enq_search_value" class="form-label fw-medium"><i class="fas fa-keyboard me-2"></i>Search Value</label>
								<div class="input-group input-group-lg">
									<span class="input-group-text bg-light border-end-0">
										<i class="fas fa-search text-muted"></i>
									</span>
									<input type="text" 
										class="form-control border-start-0" 
										id="enq_search_value" 
										name="enq_search_value" 
										placeholder="Enter search term..." 
										oninput="this.value = this.value.toUpperCase()"
										required>
									<button type="submit" 
											class="btn btn-warning px-4" 
											id="btnEnquiryJobSearch">
										<i class="fas fa-search me-2"></i>Search
									</button>
								</div>
								<div class="invalid-feedback">
									Please select a search type and enter a search term.
								</div>
							</div>
						</form>

						<!-- Alert Message -->

						<div class="alert alert-danger border border-danger mb-0 p-2 d-none" id="enquiry_alert">
							<div class="d-flex align-items-start">
								<div class="me-2 svg-danger">
									<svg class="flex-shrink-0" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="1.5rem" viewBox="0 0 24 24" width="1.5rem" fill="#000000"><g><rect fill="none" height="24" width="24"></rect></g><g><g><g><path d="M15.73,3H8.27L3,8.27v7.46L8.27,21h7.46L21,15.73V8.27L15.73,3z M19,14.9L14.9,19H9.1L5,14.9V9.1L9.1,5h5.8L19,9.1V14.9z"></path><rect height="6" width="2" x="11" y="7"></rect><rect height="2" width="2" x="11" y="15"></rect></g></g></g></svg>
								</div>
								<div class="text-danger w-100">
									<div class="fw-medium d-flex justify-content-between">No Results Found<button type="button" class="btn-close p-0" data-bs-dismiss="alert" aria-label="Close"><i class="bi bi-x"></i></button></div>
									<div class="fs-12 op-8 mb-1">Try using a different search term or criteria.</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="card border-0 shadow-sm" id="enq-search-results-section" style="display: none;">
					<div class="card-header bg-primary py-3">
						<div class="d-flex justify-content-between align-items-center">
							<div class="d-flex align-items-center">
								<i class="fas fa-table me-3 fs-4 text-primary"></i>
								<div>
									<h5 class="mb-0 fw-semibold">Search Results</h5>
									<small class="opacity-75" id="resultsCount">0 applications found</small>
								</div>
							</div>
							<div class="d-flex gap-2">
								<button type="button" class="btn btn-light btn-sm" id="btnExportResults">
									<i class="fas fa-download me-2"></i>Export
								</button>
								<button type="button" class="btn btn-light btn-sm" id="btnPrintResults">
									<i class="fas fa-print me-2"></i>Print
								</button>
							</div>
						</div>
					</div>
					
					<div class="card-body p-0">
						<div class="table-responsive">
							<table class="table table-hover table-striped mb-0" id="enq-search-results-table">
								<thead class="table-light">
									<tr>
										<th class="py-3 px-4 fw-medium text-nowrap">
											<i class="fas fa-user me-2"></i>Applicant
										</th>
										<th class="py-3 px-4 fw-medium text-nowrap">
											<i class="fas fa-folder me-2"></i>Case Number
										</th>
										<th class="py-3 px-4 fw-medium text-nowrap">
											<i class="fas fa-hashtag me-2"></i>Job Number
										</th>
										<th class="py-3 px-4 fw-medium text-nowrap">
											<i class="fas fa-fingerprint me-2"></i>GLPIN
										</th>
										<th class="py-3 px-4 fw-medium text-nowrap">
											<i class="fas fa-map-marker-alt me-2"></i>Locality
										</th>
										<th class="py-3 px-4 fw-medium text-nowrap">
											<i class="fas fa-map-pin me-2"></i>Regional Number
										</th>
										<th class="py-3 px-4 fw-medium text-center text-nowrap">
											<i class="fas fa-cogs me-2"></i>Actions
										</th>
									</tr>
								</thead>
								<tbody class="align-middle">
									<!-- Results will be populated here -->
									<tr id="noResultsRow" style="display: none;">
										<td colspan="7" class="text-center py-5">
											<div class="d-flex flex-column align-items-center">
												<i class="fas fa-search fa-3x text-muted mb-3"></i>
												<h6 class="fw-semibold mb-2">No applications found</h6>
												<p class="text-muted small mb-0">Try adjusting your search criteria</p>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="card-footer bg-light py-3">
						<div class="d-flex justify-content-between align-items-center">
							<div class="text-muted small" id="tableInfo">
								Showing <span id="currentCount">0</span> of <span id="totalCount">0</span> applications
							</div>
							<div class="d-flex gap-2" id="paginationControls" style="display: none;">
								<button class="btn btn-sm btn-outline-primary" id="btnPrevPage">
									<i class="fas fa-chevron-left"></i>
								</button>
								<span class="align-self-center small fw-medium">Page <span id="currentPage">1</span></span>
								<button class="btn btn-sm btn-outline-primary" id="btnNextPage">
									<i class="fas fa-chevron-right"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Batchlist Preview Card -->
			<div class="col-lg-4 col-xl-3">
				<div class="card border-0 shadow-sm">
					<div class="card-header bg-info py-3">
						<div class="d-flex align-items-center">
							<i class="fas fa-list-alt me-3 fs-4 text-info"></i>
							<div>
								<h5 class="mb-0 fw-semibold">Batchlist Preview</h5>
								<small class="opacity-75">Search batch processing details</small>
							</div>
						</div>
					</div>
					
					<div class="card-body d-flex flex-column">
						<form id="frmEnquiryBatchlist" method="post" class="needs-validation" novalidate>
							<div class="mb-3">
								<label for="enq_batchlist" class="form-label fw-medium">
									<i class="fas fa-layer-group me-2"></i>Batch Number
								</label>
								<div class="input-group">
									<span class="input-group-text bg-light">
										<i class="fas fa-hashtag"></i>
									</span>
									<input type="text" 
										class="form-control" 
										id="enq_batchlist" 
										placeholder="Enter batch number" 
										required>
								</div>
								<div class="invalid-feedback">
									Please enter a batch number.
								</div>
							</div>
							
							<button type="submit" class="btn btn-info w-100 mt-auto">
								<i class="fas fa-search me-2"></i>Find Batchlist
							</button>
						</form>
						
						<!-- Batchlist Info -->
						<div class="mt-4 pt-3 border-top">
							<h6 class="fw-semibold mb-3"><i class="fas fa-info-circle me-2"></i>Quick Info</h6>
							<div class="d-flex justify-content-between mb-2">
								<span class="text-muted">Last Search:</span>
								<span class="fw-medium" id="lastBatchSearch">-</span>
							</div>
							<div class="d-flex justify-content-between">
								<span class="text-muted">Results Found:</span>
								<span class="fw-medium" id="batchResultsCount">0</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>  
 </div>