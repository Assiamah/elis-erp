<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
                <h1 class="page-title fw-medium fs-18 mb-1">
        <i class="ri-file-text-fill text-warning me-1"></i>Generate Acknowledgement Slip
      </h1>
                <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Regenerate unsaved acknowledgement slips</p>
            </div>
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                <li class="breadcrumb-item active" aria-current="page">Generate Acknowledgement Slip</li>
            </ol>
        </div>
    </div>  

    <div class="row g-3">
      <!-- Main Content Column - 8 columns -->
      <div class="col-lg-8">
          <!-- Generate Acknowledgement Slip Card -->
          <div class="card shadow-sm mb-3">
              <div class="card-header bg-white">
                  <h5 class="mb-0">
                      <i class="fas fa-file-alt me-2"></i>Generate Acknowledgement Slip
                  </h5>
              </div>
              
              <div class="card-body">
                  <!-- Search Form -->
                  <div class="row g-2 mb-4">
                      <div class="col">
                          <input type="text" 
                                class="form-control text-uppercase" 
                                id="txt_job_number_for_adding_case_and_status" 
                                name="txt_job_number_for_adding_case_and_status" 
                                placeholder="Enter Job Number" 
                                required>
                      </div>
                      <div class="col-auto">
                          <button class="btn btn-success" 
                                  id="btn_search_job_number_for_acknowledgement_slip">
                              <i class="fa fa-search me-2"></i>Search
                          </button>
                      </div>
                  </div>

                  <!-- Jobs Table -->
                  <div class="table-responsive">
                      <table class="table table-bordered table-hover" 
                            id="tbl_job_detail_dataTable">
                          <thead class="table-light">
                              <tr>
                                  <th>Job Number</th>
                                  <th>Case Number</th>
                                  <th>Applicant Name</th>
                                  <th>Action</th>
                              </tr>
                          </thead>
                          <tbody>
                              <!-- Table content will be loaded dynamically -->
                          </tbody>
                      </table>
                  </div>
              </div>
          </div>
      </div>

      <!-- Sidebar Column - 4 columns -->
      <div class="col-lg-4">
          <!-- Instructions Card -->
          <div class="card shadow-sm mb-3">
              <div class="card-header bg-white">
                  <h5 class="mb-0">
                      <i class="fa fa-info-circle text-danger me-2"></i>Instructions
                  </h5>
              </div>
             <div class="card-body">
                <!-- Step-by-step instructions -->
                <div class="d-flex align-items-start mb-3">
                    <span class="badge bg-primary rounded-circle me-2" style="width: 20px; height: 20px;">1</span>
                    <div>
                        <h6 class="mb-1">Search for Job</span></h6>
                        <p class="text-muted small mb-0">Enter a valid Job Number (minimum 6 characters) in the search field and click the Search button.</p>
                    </div>
                </div>
                
                <div class="d-flex align-items-start mb-3">
                    <span class="badge bg-primary rounded-circle me-2" style="width: 20px; height: 20px;">2</span>
                    <div>
                        <h6 class="mb-1">Generate Acknowledgement Slip</span></h6>
                        <p class="text-muted small mb-0">Once the job details appear in the table, click the "Generate" button to download the acknowledgement slip.</p>
                    </div>
                </div>

                <!-- Additional Tips -->
                <div class="alert alert-info mt-3 mb-0 py-2">
                    <i class="fa fa-info-circle me-2"></i>
                    <small>The acknowledgement slip will open in a new tab as a PDF document.</small>
                </div>
            </div>
          </div>
      </div>
  </div>
       
  </div>
</div>
  
  
  
  
  

