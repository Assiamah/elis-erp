  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  <%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
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
                    <h1 class="page-title fw-medium fs-18 mb-1">Change of Name/Details</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Editing of Application Details</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Change of Name/Details</li>
                </ol>
            </div>
        </div>
        

       <div class="container-fluid py-4">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex align-items-center justify-content-between">
                <div>
                    <h2 class="h3 mb-1 text-gray-800">Payment & Processing</h2>
                    <p class="text-muted mb-0">Manage payments, acknowledgements, and application changes</p>
                </div>
                <div class="d-none d-lg-block">
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill">
                        <i class="fas fa-clock me-1"></i> Last updated: Just now
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content Row -->
    <div class="row g-4">
        <!-- Left Column - Main Content (8 cols) -->
        <div class="col-lg-8">
            
            <!-- Generate Bills Card -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white border-0 py-3">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="mb-0 fw-semibold">
                                <i class="fas fa-file-invoice-dollar text-primary me-2"></i>
                                Generate Bills for Application Changes
                            </h5>
                            <p class="text-muted small mb-0 mt-1">Create new bills for name changes, transfers, and other modifications</p>
                        </div>
                        <!-- <span class="badge bg-warning bg-opacity-10 text-warning px-3 py-2">
                            <i class="fas fa-clock me-1"></i> Pending: 3
                        </span> -->
                    </div>
                </div>
                <div class="card-body pt-0">
                    <!-- Search Section -->
                    <div class="bg-light bg-opacity-50 rounded-3 p-3 mb-4">
                        <div class="row g-3 align-items-end">
                            <div class="col-md-8">
                                <label class="form-label small fw-semibold text-uppercase text-muted mb-2">
                                    <i class="fas fa-search me-1"></i> Search Job Number
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0">
                                        <i class="fas fa-briefcase text-muted"></i>
                                    </span>
                                    <input type="text" 
                                           class="form-control border-start-0 ps-0" 
                                           id="txt_job_number_for_adding_case_and_status" 
                                           placeholder="Enter job number (e.g., LRDGAR61145672021)"
                                           style="text-transform: uppercase;">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <button class="btn btn-success w-100 py-2" id="btn_job_number_for_adding_name_change_bill">
                                    <i class="fas fa-search me-2"></i> Search & Load
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Jobs Table -->
                    <div class="table-responsive">
                        <table class="table  table-hover align-middle" id="tbl_job_detail_dataTable_nameChange">
                            <thead  class="table-light">
                                <tr>
                                    <th class="border-0 rounded-start">Job No.</th>
                                    <th class="border-0">Case No.</th>
                                    <th class="border-0">Applicant</th>
                                    <th class="border-0">Locality</th>
                                    <th class="border-0">Reg. Number</th>
                                    <th class="border-0">Status</th>
                                    <th class="border-0">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Dynamic content will be loaded here -->
                                <tr>
                                    <td colspan="8" class="text-center py-5 text-muted">
                                        <i class="fas fa-inbox fa-3x mb-3 d-block"></i>
                                        <p class="mb-0">No job records found</p>
                                        <small>Search for a job number to view details</small>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Payment Acknowledgement Card -->
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-0 py-3">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="mb-0 fw-semibold">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                Acknowledge Payment
                            </h5>
                            <p class="text-muted small mb-0 mt-1">Process and acknowledge payments for generated bills</p>
                        </div>
                        <!-- <div class="d-flex gap-2">
                            <span class="badge bg-info bg-opacity-10 text-info px-3 py-2">
                                <i class="fas fa-clock me-1"></i> Today: 5
                            </span>
                        </div> -->
                    </div>
                </div>
                <div class="card-body pt-0">
                    <!-- Payment Search -->
                    <div class="bg-light bg-opacity-50 rounded-3 p-3 mb-4">
                        <div class="row g-3 align-items-end">
                            <div class="col-md-8">
                                <label class="form-label small fw-semibold text-uppercase text-muted mb-2">
                                    <i class="fas fa-receipt me-1"></i> Reference Number
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0">
                                        <i class="fas fa-hashtag text-muted"></i>
                                    </span>
                                    <input type="text" 
                                           class="form-control border-start-0 ps-0" 
                                           id="chng_ref_number_for_payment" 
                                           placeholder="Enter payment reference number">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <button class="btn btn-success w-100 py-2" id="btn_load_bill_details_after_payment_change_of_names">
                                    <i class="fas fa-search me-2"></i> Verify Payment
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Bills Table -->
                    <div class="table-responsive mb-4">
                        <table class="table table-hover align-middle" id="bill_for_payment_list_dataTable_change_of_name">
                            <thead class="bg-light">
                                <tr>
                                    <th class="border-0 rounded-start">Ref. Number</th>
                                    <th class="border-0">Applicant Name</th>
                                    <th class="border-0">Amount</th>
                                    <th class="border-0 rounded-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="4" class="text-center py-4 text-muted">
                                        <i class="fas fa-receipt fa-2x mb-2 d-block"></i>
                                        <p class="mb-0">No payment records loaded</p>
                                        <small>Search for a reference number to view payment details</small>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Applicant Details Form -->
                    <form id="frmChangeofNames" method="post">
                        <div class="bg-white border rounded-3 p-4">
                            <input type="hidden" id="new_bill_application_transaction">
                            
                            <div class="d-flex align-items-center mb-4">
                                <div class="flex-shrink-0">
                                    <div class="bg-primary bg-opacity-10 rounded-circle p-3">
                                        <i class="fas fa-user-edit text-primary"></i>
                                    </div>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="fw-semibold mb-1">Applicant Information</h6>
                                    <p class="text-muted small mb-0">Update applicant details and location information</p>
                                </div>
                            </div>
                            
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label fw-semibold small text-uppercase text-muted">
                                            <i class="fas fa-users me-1"></i> Applicant Name(s)
                                        </label>
                                        <textarea class="form-control" 
                                                  id="ch_ar_name" 
                                                  rows="6" 
                                                  placeholder="Enter full name(s) of applicant"
                                                  required></textarea>
                                        <div class="form-text">Separate multiple names with commas</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                        <label class="form-label fw-semibold small text-uppercase text-muted">
                                            <i class="fas fa-map-marker-alt me-1"></i> Region
                                        </label>
                                        <select id="new_bill_application_region" class="form-select">
                                            <option value="-1">-- Select Region --</option>
                                            <c:forEach items="${regionlist}" var="region">
                                                <option value="${region.region_id}">${region.region_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="form-label fw-semibold small text-uppercase text-muted">
                                            <i class="fas fa-city me-1"></i> District
                                        </label>
                                        <select id="new_bill_application_district" class="form-select">
                                            <option value="-1">-- Select District --</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label fw-semibold small text-uppercase text-muted">
                                            <i class="fas fa-building me-1"></i> Locality
                                        </label>
                                        <select id="new_bill_application_locality" class="form-select">
                                            <option value="-1">-- Select Locality --</option>
                                            <c:forEach items="${localitylist}" var="locality">
                                                <option value="${locality.location_name}">${locality.location_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-between mt-4">
                                <button class="btn btn-primary px-5" id="btnSaveChangeOfNames" style="display: none;">
                                    <i class="fas fa-save me-2"></i> Save Changes
                                </button>
                                <button class="btn btn-outline-secondary px-4" type="button" onclick="resetForm()">
                                    <i class="fas fa-undo me-2"></i> Reset
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Right Column - Sidebar (4 cols) -->
        <div class="col-lg-4">
            <!-- Instructions Card -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="mb-0 fw-semibold">
                        <i class="fas fa-info-circle text-info me-2"></i>
                        Quick Instructions
                    </h5>
                </div>
                <div class="card-body">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item px-0">
                            <div class="d-flex">
                                <div class="flex-shrink-0">
                                    <span class="badge bg-primary rounded-circle p-2">
                                        <i class="fas fa-search text-white fa-sm"></i>
                                    </span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="mb-1 fw-semibold">Step 1: Search Job</h6>
                                    <p class="text-muted small mb-0">Enter the job number to load existing applications</p>
                                </div>
                            </div>
                        </div>
                        <div class="list-group-item px-0">
                            <div class="d-flex">
                                <div class="flex-shrink-0">
                                    <span class="badge bg-success rounded-circle p-2">
                                        <i class="fas fa-file-invoice text-white fa-sm"></i>
                                    </span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="mb-1 fw-semibold">Step 2: Generate Bill</h6>
                                    <p class="text-muted small mb-0">Create new bill for application changes</p>
                                </div>
                            </div>
                        </div>
                        <div class="list-group-item px-0">
                            <div class="d-flex">
                                <div class="flex-shrink-0">
                                    <span class="badge bg-warning rounded-circle p-2">
                                        <i class="fas fa-credit-card text-white fa-sm"></i>
                                    </span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="mb-1 fw-semibold">Step 3: Process Payment</h6>
                                    <p class="text-muted small mb-0">Verify and acknowledge payment using reference number</p>
                                </div>
                            </div>
                        </div>
                        <div class="list-group-item px-0">
                            <div class="d-flex">
                                <div class="flex-shrink-0">
                                    <span class="badge bg-danger rounded-circle p-2">
                                        <i class="fas fa-check-double text-white fa-sm"></i>
                                    </span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="mb-1 fw-semibold">Step 4: Update Records</h6>
                                    <p class="text-muted small mb-0">Save changes to applicant information</p>
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
  
  
  

