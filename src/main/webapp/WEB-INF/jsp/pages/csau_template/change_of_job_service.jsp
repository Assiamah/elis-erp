<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<div class="main-content app-content">
    <div class="container-fluid page-container">

      <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Change of Job Service</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Editing of Application Details</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Change of Job Service</li>
                </ol>
            </div>
        </div>

        <div class="row g-4">
          <!-- Left Column - Main Content -->
          <div class="col-lg-8">
              <!-- Main Card -->
              <div class="card shadow-sm border-0">
                  <div class="card-body p-4">         
                    <!-- Search Section -->
                    <div class="card border-0 bg-light mb-4">
                        <div class="card-header bg-white border-bottom-0 py-3">
                            <h6 class="mb-0 fw-semibold">
                                <i class="fas fa-search me-2 text-primary"></i>Search Job
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-8">
                                    <input type="text" 
                                          class="form-control form-control-lg text-uppercase" 
                                          id="txt_job_number_for_adding_case_and_status" 
                                          name="txt_job_number_for_adding_case_and_status" 
                                          placeholder="Enter Job Number" 
                                          style="text-transform: uppercase;">
                                </div>
                                <div class="col-md-4">
                                    <button class="btn btn-primary btn-lg w-100" id="btn_job_number_for_change_of_job_service">
                                        <i class="fas fa-search me-2"></i>Search
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Job Details Table -->
                    <div class="table-responsive mb-4">
                        <table class="table table-hover align-middle" id="tbl_job_detail_dataTable">
                            <thead class="table-light">
                                <tr>
                                    <th class="fw-semibold">Job Number</th>
                                    <th class="fw-semibold">Case Number</th>
                                    <th class="fw-semibold">Applicant Name</th>
                                    <th class="fw-semibold text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Dynamic content -->
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Change of Service Form -->
                    <form id="frmChangeofService" method="post">
                        <div class="card border-0 bg-light">
                            <div class="card-header bg-white border-bottom-0 py-3">
                                <h6 class="mb-0 fw-semibold">
                                    <i class="fas fa-edit me-2 text-primary"></i>Service Change Details
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold small">Job Number</label>
                                        <input type="text" class="form-control bg-white" name="chs_job_number" id="chs_job_number" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold small">Applicant Name</label>
                                        <input type="text" class="form-control bg-white" name="chs_ar_name" id="chs_ar_name" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold small">Main Service</label>
                                        <input type="text" class="form-control bg-white" name="chs_business_process_name" id="chs_business_process_name" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold small">Sub Service <span class="text-danger">*</span></label>
                                        <select class="form-select" name="chs_business_process_sub_name" id="chs_business_process_sub_name">
                                            <option value="">Select sub service...</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-semibold small">Comment <span class="text-danger">*</span></label>
                                        <textarea class="form-control" name="chs_comment" id="chs_comment" rows="3" placeholder="Please provide details for the service change..."></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer bg-white border-top-0 pb-4">
                                <button class="btn btn-primary btn-lg px-5" id="btnSaveChangeOfService" style="display:none">
                                    <i class="fas fa-save me-2"></i>Save Changes
                                </button>
                            </div>
                        </div>
                    </form>
                    
                </div>
              </div>
          </div>
          
          <!-- Right Column - Sidebar -->
          <div class="col-lg-4">
              
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
                                    <h6 class="mb-1 fw-semibold">Step 2: Load Details</h6>
                                    <p class="text-muted small mb-0">Load details for application changes</p>
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
                                    <h6 class="mb-1 fw-semibold">Step 3: Update Records</h6>
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
        <!-- /.container-fluid -->

    

  
  
  

