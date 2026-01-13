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
                <h1 class="page-title fw-medium fs-18 mb-0">Bulk Collection</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Bulk Collection</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->
         <div class="row g-4">
			<!-- Search Section -->
			<div class="col-lg-6">
				<div class="card border-0 shadow-sm h-100">
				<div class="card-header bg-primary text-white d-flex align-items-center">
					<i class="fas fa-search text-warning me-2"></i>
					<h5 class="mb-0">Search Section</h5>
				</div>
				<div class="card-body">
					<form id="frmEnquiryJobSearch" method="post">
					<!-- Search Type -->
					<div class="mb-4">
						<label class="form-label fw-bold">Search By:</label>
						<div class="d-flex flex-wrap gap-3">
						<div class="form-check">
							<input class="form-check-input" type="radio" name="rbtn_search_type" id="rbtn_search_type1" value="job_number" required>
							<label class="form-check-label" for="rbtn_search_type1"><i class="fas fa-hashtag me-1"></i>Job Number</label>
						</div>
						<!-- Add more radio buttons here if needed -->
						</div>
					</div>

					<!-- Search Input -->
					<div class="mb-3">
						<div class="input-group">
						<input type="text" class="form-control form-control-lg" id="enq_search_value" name="enq_search_value" placeholder="Enter search term" required>
						<button type="submit" class="btn btn-primary btn-lg" id="btnEnquiryJobSearch">
							<i class="fas fa-search me-2"></i>Search
						</button>
						</div>
						<div class="form-text">Enter at least 8 characters for better results</div>
					</div>
					</form>

					<!-- Alert -->
					<div class="alert alert-danger d-none mt-3" id="enquiry_alert" role="alert">
					<i class="fas fa-exclamation-circle me-2"></i>No Results Found
					</div>
				</div>
				</div>
			</div>

			<!-- Batch List Section -->
			<div class="col-lg-6">
				<div class="card border-0 shadow-sm h-100">
				<div class="card-header bg-info text-white d-flex align-items-center">
					<i class="fas fa-list-check text-warning me-2"></i>
					<h5 class="mb-0">Batch List & Collector's Details</h5>
				</div>
				<div class="card-body">
					<form id="frmEnquiryBatchlist" method="post">
					<!-- Collector's Name -->
					<div class="row g-2 mb-3">
						<label class="form-label fw-bold">Collector's Information</label>
						<div class="col-md-6">
							<div class="input-group">
						<span class="input-group-text bg-light"><i class="fas fa-user"></i></span>
						<input type="text" class="form-control" id="bcd_collected_by" 
								placeholder="Enter collector's full name" required>
						</div>
						</div>
						<div class="col-md-6">
							<div class="input-group">
							<span class="input-group-text bg-light"><i class="fas fa-phone"></i></span>
							<input type="text" class="form-control" id="bcd_phone_number" 
								placeholder="Enter phone number" required>
						</div>
						</div>
					</div>

					<!-- ID Type and Number -->
					<div class="row g-2 mb-3">
						<div class="col-md-6">
						<select class="form-select" id="bcd_id_type" required data-trigger>
							<option value="" disabled selected>Select ID Type</option>
							<option value="NATIONAL ID">National ID</option>
							<option value="PASSPORT">Passport</option>
							<option value="DRIVERS LICENSE">Driver's License</option>
							<option value="NHIS CARD">NHIS Card</option>
							<option value="VOTERS ID">Voter's ID</option>
							<option value="SSNIT ID CARD">SSNIT ID Card</option>
						</select>
						</div>
						<div class="col-md-6">
						<div class="input-group">
							<span class="input-group-text bg-light"><i class="fas fa-id-card"></i></span>
							<input type="text" class="form-control" id="bcd_id_number" 
								placeholder="Enter ID number" required>
						</div>
						</div>
					</div>

					<!-- Phone Number and Process Button -->
					<div class="row g-2">
						<div class="col-md-12">
						<button type="button" class="btn btn-lg btn-danger w-100" id="btn_process_bulk_collection">
							<i class="fas fa-play-circle me-2"></i>Process List
						</button>
						</div>
					</div>
					</form>
				</div>
				</div>
			</div>
			</div>

			<!-- Search Results Section -->
			<div class="row mt-4">
			<div class="col-12">
				<div class="card border-0 shadow-sm" id="enq-search-results-section" style="display: none">
				<div class="card-header bg-secondary text-white d-flex justify-content-between align-items-center">
					<div>
					<i class="fas fa-table me-2"></i>
					<h5 class="mb-0">Search Results</h5>
					</div>
					<span class="badge bg-light text-dark">Showing 10 records</span>
				</div>
				<div class="card-body p-0">
					<div class="table-responsive">
					<table class="table table-hover table-striped mb-0" id="tbl-bulk-collection-table">
						<thead class="table-light">
						<tr>
							<th>Applicant Name</th>
							<th>Case Number</th>
							<th>Job Number</th>
							<th>GLPIN</th>
							<th>Locality</th>
							<th>Regional Number</th>
						</tr>
						</thead>
						<tbody>
						<!-- Results will be populated here -->
						</tbody>
					</table>
					</div>
				</div>
				<div class="card-footer bg-light border-top">
					<small class="text-muted">Click on a row to select for batch processing</small>
				</div>
				</div>
			</div>
			</div>
    </div>
     
     
    
 </div>
 