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
                <div>
				<h1 class="page-title fw-medium fs-18 mb-0">File Tracking</h1>
				<p class="text-muted mb-0 small">Track and manage document files across cases</p>
				</div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">File Tracking</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->
  


   <!-- <div class="container-fluid py-4"> -->
    
    <!-- Page Header with Actions -->
    <div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
        <div class="d-flex align-items-center mb-2 mb-sm-0">
            <div class="bg-primary bg-opacity-10 p-3 rounded-3 me-3">
                <i class="fas fa-folder-open text-primary fa-2x"></i>
            </div>
            <div>
                <h4 class="mb-1 fw-bold">File History & Search</h4>
            </div>
        </div>
        <button class="btn btn-success px-4 py-2 shadow-sm" id="btnViewFilelist">
            <i class="fas fa-list me-2"></i>
            <span class="fw-semibold">View Prepared File List</span>
        </button>
    </div>

    <!-- Search Cards Row -->
    <div class="row g-4 mb-4">
        <!-- Job Number Search Card -->
        <div class="col-lg-6">
            <div class="card h-100 border-0 shadow-sm hover-shadow transition">
                <div class="card-header bg-white border-0 pt-4 pb-0">
                    <div class="d-flex align-items-center">
                        <div class="bg-primary bg-opacity-10 p-2 rounded-circle me-2">
                            <i class="fas fa-briefcase text-primary"></i>
                        </div>
                        <h6 class="fw-bold mb-0">Search by Job Number</h6>
                        <span class="badge bg-light text-dark ms-2 px-3 py-2">
                            <i class="fas fa-search me-1"></i> Quick Search
                        </span>
                    </div>
                </div>
                <div class="card-body pt-3">
                    <form id="frmFileJobSearch" method="post" class="needs-validation" novalidate>
                        <div class="d-flex flex-column flex-md-row gap-3">
                            <div class="flex-grow-1">
                                <label class="form-label text-muted small fw-semibold mb-1">
                                    <i class="fas fa-hashtag me-1"></i> Enter Job Number
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0">
                                        <i class="fas fa-briefcase text-muted"></i>
                                    </span>
                                    <input type="text" 
                                           class="form-control border-start-0 ps-0" 
                                           id="file_search_value" 
                                           name="file_search_value"
                                           placeholder="e.g., LRDGAR61145672021" 
                                           aria-label="Job Number"
                                           required>
                                    <span class="input-group-text bg-white border-start-0">
                                        <i class="fas fa-asterisk text-danger" style="font-size: 8px;"></i>
                                    </span>
                                </div>
                                <div class="invalid-feedback">
                                    Please enter a job number to search.
                                </div>
                                <small class="text-muted mt-2 d-block">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Enter full or partial job number
                                </small>
                            </div>
                            <div class="d-flex align-items-end mb-4">
                                <button type="submit" 
                                        class="btn btn-primary px-5 py-2" 
                                        id="btnFileJobSearch">
                                    <i class="fas fa-search me-2"></i>
                                    <span class="fw-semibold">Search</span>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- File Batch Search Card -->
        <div class="col-lg-6">
            <div class="card h-100 border-0 shadow-sm hover-shadow transition">
                <div class="card-header bg-white border-0 pt-4 pb-0">
                    <div class="d-flex align-items-center">
                        <div class="bg-info bg-opacity-10 p-2 rounded-circle me-2">
                            <i class="fas fa-layer-group text-info"></i>
                        </div>
                        <h6 class="fw-bold mb-0">Search by Batch Number</h6>
                        <span class="badge bg-light text-dark ms-2 px-3 py-2">
                            <i class="fas fa-file-alt me-1"></i> Bulk Search
                        </span>
                    </div>
                </div>
                <div class="card-body pt-3">
                    <form id="frmEnquiryBatchlist" method="post" class="needs-validation" novalidate>
                        <div class="d-flex flex-column flex-md-row gap-3">
                            <div class="flex-grow-1">
                                <label class="form-label text-muted small fw-semibold mb-1">
                                    <i class="fas fa-hashtag me-1"></i> Enter Batch Number
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0">
                                        <i class="fas fa-layer-group text-muted"></i>
                                    </span>
                                    <input type="text" 
                                           class="form-control border-start-0 ps-0" 
                                           id="enq_batchlist" 
                                           name="enq_batchlist"
                                           placeholder="e.g., BATCH-2024-001" 
                                           aria-label="Batch Number"
                                           required>
                                    <span class="input-group-text bg-white border-start-0">
                                        <i class="fas fa-asterisk text-danger" style="font-size: 8px;"></i>
                                    </span>
                                </div>
                                <div class="invalid-feedback">
                                    Please enter a batch number to search.
                                </div>
                                <small class="text-muted mt-2 d-block">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Find all files in a specific batch
                                </small>
                            </div>
                            <div class="d-flex align-items-end mb-4">
                                <button type="submit" 
                                        class="btn btn-info px-5 py-2 text-white" 
                                        id="btnEnquiryBatchlist">
                                    <i class="fas fa-file-alt me-2"></i>
                                    <span class="fw-semibold">Find Files</span>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Search Results Section -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm" id="file-search-results-section">
                <!-- Card Header with Stats -->
                <div class="card-header bg-white border-0 pt-4 pb-0">
                    <div class="d-flex flex-wrap align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                            <div class="bg-success bg-opacity-10 p-2 rounded-circle me-2">
                                <i class="fas fa-list text-success"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1">Search Results</h6>
                                <p class="text-muted small mb-0" id="result-summary">
                                    <span id="result-count">0</span> records found
                                </p>
                            </div>
                        </div>
                        <div class="d-flex gap-2 mt-2 mt-sm-0">
                            <span class="badge bg-light text-dark py-2 px-3">
                                <i class="fas fa-clock me-1"></i>
                                Last search: <span id="last-search-time">Never</span>
                            </span>
                            <button class="btn btn-outline-secondary btn-sm" id="btnRefreshResults" style="display: none;">
                                <i class="fas fa-sync-alt me-1"></i> Refresh
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Results Body -->
                <div class="card-body">
                    <!-- Loading Skeleton (Hidden by default) -->
                    <div id="loading-skeleton" class="text-center py-5" style="display: none;">
                        <div class="spinner-border text-primary mb-3" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <p class="text-muted mb-0">Searching files...</p>
                        <small class="text-muted">Please wait while we fetch the results</small>
                    </div>

                    <!-- No Results Message (Hidden by default) -->
                    <div id="no-results-message" class="text-center py-5" style="display: none;">
                        <div class="bg-light bg-opacity-50 rounded-circle p-4 d-inline-block mb-3">
                            <i class="fas fa-folder-open text-muted fa-3x"></i>
                        </div>
                        <h6 class="fw-bold mb-2">No Files Found</h6>
                        <p class="text-muted mb-2">No records match your search criteria</p>
                        <small class="text-muted d-block mb-3">Try adjusting your search terms or check the batch number</small>
                        <button class="btn btn-outline-primary btn-sm" onclick="clearSearch()">
                            <i class="fas fa-undo me-1"></i> Clear Search
                        </button>
                    </div>

                    <!-- Results Table -->
                    <div id="results-table-container">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="file-search-results-table">
                                <thead class="table-light">
                                    <tr>
                                        <th class="border-0 rounded-start py-3">
                                            <i class="fas fa-user me-1 text-muted"></i> Applicant Name
                                        </th>
                                        <th class="border-0 py-3">
                                            <i class="fas fa-file-invoice me-1 text-muted"></i> Case Number
                                        </th>
                                        <th class="border-0 py-3">
                                            <i class="fas fa-briefcase me-1 text-muted"></i> Job Number
                                        </th>
                                        <th class="border-0 py-3">
                                            <i class="fas fa-tag me-1 text-muted"></i> Application Type
                                        </th>
                                        <th class="border-0 py-3">
                                            <i class="fas fa-map-marker-alt me-1 text-muted"></i> Locality
                                        </th>
                                        <th class="border-0 rounded-end py-3 text-center">
                                            <i class="fas fa-cog me-1 text-muted"></i> Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Dynamic content will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Card Footer with Pagination -->
                <div class="card-footer bg-white border-0 pb-4" id="table-footer" style="display: none;">
                    <div class="d-flex flex-wrap align-items-center justify-content-between">
                        <div class="text-muted small mb-2 mb-sm-0">
                            Showing <span id="showing-start">0</span> to <span id="showing-end">0</span> of 
                            <span id="total-records">0</span> entries
                        </div>
                        <nav aria-label="Table navigation">
                            <ul class="pagination pagination-sm mb-0" id="table-pagination">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Searches Section (Hidden by default) -->
    <div class="row mt-4" id="recent-searches-section" style="display: none;">
        <div class="col-12">
            <div class="card border-0 shadow-sm bg-light">
                <div class="card-body py-3">
                    <div class="d-flex flex-wrap align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-history text-muted me-2"></i>
                            <span class="small fw-semibold text-muted me-2">Recent Searches:</span>
                            <div class="d-flex gap-2" id="recent-search-tags">
                                <!-- Recent search tags will be added here -->
                            </div>
                        </div>
                        <button class="btn btn-link btn-sm text-muted" onclick="clearRecentSearches()">
                            <i class="fas fa-trash-alt me-1"></i> Clear
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- </div> -->
    

 
  </div>
</div>
 
 
 