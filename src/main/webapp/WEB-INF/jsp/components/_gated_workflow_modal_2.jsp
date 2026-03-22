<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>

<div class="modal fade effect-scale modal-blur" id="preview_memo" tabindex="-1"
     aria-labelledby="previewMemoModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="previewMemoModalLabel">
          <i class="fas fa-file-alt me-2"></i>
          Preview Memo
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body text-center p-5">
        
        <!-- Memo Icon -->
        <div class="mb-4">
          <div class="icon-circle bg-primary bg-opacity-10 text-primary mb-3 mx-auto" style="width: 80px; height: 80px; line-height: 80px;">
            <i class="fas fa-file-invoice fa-3x"></i>
          </div>
          <h5 class="mb-3">Memo Generation</h5>
          <p class="text-muted mb-4">
            Generate an official memo document for this transaction.
          </p>
        </div>
        
        <!-- Generate Memo Button -->
        <div class="mb-4">
          <button type="button" id="lc_btn_generate_memo_for_certificate_2" 
                  class="btn btn-primary btn-lg w-100 py-3 shadow-sm">
            <i class="fas fa-file-pdf me-2"></i>
            Generate Memo
          </button>
          <div class="form-text mt-2">
            <i class="fas fa-info-circle me-1"></i>
            Creates an official memo document in pdf format
          </div>
        </div>
        
        <!-- Memo Information -->
        <!-- <div class="alert alert-light border">
          <div class="d-flex">
            <i class="fas fa-check-circle text-success me-3 mt-1"></i>
            <div class="text-start">
              <strong class="text-dark">Memo Features:</strong>
              <ul class="mb-0 mt-2 ps-3">
                <li class="text-muted">Professional memo format</li>
                <li class="text-muted">Official letterhead and signatures</li>
                <li class="text-muted">Downloadable Word document</li>
                <li class="text-muted">Ready for printing and distribution</li>
              </ul>
            </div>
          </div>
        </div> -->
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="review_instruction_with_request" tabindex="-1"
     aria-labelledby="reviewInstructionModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 shadow">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white rounded-top">
                <h5 class="modal-title text-white" id="reviewInstructionModalLabel">
                    <i class="fas fa-file-alt me-2"></i>
                    Review Instruction With Request
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" 
                        aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Status Card -->
                <div class="card mb-4">
                    <div class="card-header bg-primary bg-opacity-10 py-2">
                        <h6 class="mb-0">
                            <i class="fas fa-info-circle me-2 text-primary"></i>
                            Instruction Details
                        </h6>
                    </div>
                    <div class="card-body">
                        <!-- Instructions Display -->
                        <div class="instruction-content-container">
                            <div class="instruction-header mb-3">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-clipboard-check fa-2x text-primary me-3"></i>
                                    <div>
                                        <h5 class="mb-1">Review Instructions</h5>
                                        <p class="text-muted mb-0">Please review the following instructions carefully</p>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Main Instruction Content -->
                            <div class="instruction-content p-4 bg-light rounded border">
                                ${review_instruction}
                            </div>
                            
                            <!-- Instruction Metadata (Optional) -->
                            <!-- <div class="instruction-meta mt-3">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-center text-muted small mb-2">
                                            <i class="fas fa-calendar-alt me-2"></i>
                                            <span>Last Updated: <span id="instructionDate">Just now</span></span>
                                        </div>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="d-flex align-items-center justify-content-md-end text-muted small mb-2">
                                            <i class="fas fa-user-edit me-2"></i>
                                            <span>Provided by: <span id="instructionAuthor">System</span></span>
                                        </div>
                                    </div>
                                </div>
                            </div> -->
                        </div>
                    </div>
                </div>
                
                <!-- Action Buttons (if needed) -->
                <div class="action-buttons d-none" id="instructionActions">
                    <div class="alert alert-warning bg-warning bg-opacity-10 border-warning">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-exclamation-circle fa-lg text-warning me-3"></i>
                            <div>
                                <h6 class="mb-1">Required Action</h6>
                                <p class="mb-0">Please acknowledge that you have read and understood the instructions</p>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center gap-3">
                        <button type="button" class="btn btn-success" id="btnAcknowledge">
                            <i class="fas fa-check-circle me-2"></i>
                            Acknowledge & Continue
                        </button>
                        <button type="button" class="btn btn-outline-secondary" id="btnNeedClarification">
                            <i class="fas fa-question-circle me-2"></i>
                            Need Clarification
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer">
                <!-- Close Button -->
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>
                    Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Create New Job and Case Number Modal -->
<div class="modal fade modal-blur effect-scale" id="CreateJobNumberModal" tabindex="-1"
    aria-labelledby="CreateJobNumberModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="CreateJobNumberModalLabel">
                    <i class="bi bi-file-earmark-plus me-2"></i>Create New Job and Case Number
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="form-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="main_service_on_tc" class="form-label">
                                <i class="bi bi-list-task me-1"></i>Main Service
                            </label>
                            <select name="main_service_on_case" id="main_service_on_tc" 
                                class="form-control form-select" data-style="btn-info" data-live-search="true">
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="sub_service_on_tc" class="form-label">
                                <i class="bi bi-list-nested me-1"></i>Sub Service
                            </label>
                            <select name="sub_service_on_case" id="sub_service_on_tc" 
                                class="form-control form-select" data-style="btn-info" data-live-search="true">
                                <option value="-1">Select Sub Service</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="row">
                        <div class="col-md-12">
                        <label for="applicant_name_on_tc" class="form-label">
                            <i class="bi bi-person me-1"></i>Client Name
                        </label>
                        <input class="form-control" id="applicant_name_on_tc"
                            name="applicant_name_on_tc" type="text"
                            aria-describedby="nameHelp" placeholder="Enter Client Name" required>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="office_region_on_tc" class="form-label">
                                <i class="bi bi-building me-1"></i>Office Region
                            </label>
                            <select class="form-control form-select" id="office_region_on_tc" required>
                                <option value="-1">Select Office Region</option>
                                <c:forEach items="${officeregionlist}" var="officeregion">
                                    <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="locality_on_tc" class="form-label">
                                <i class="bi bi-geo-alt me-1"></i>Locality
                            </label>
                            <select name="locality_on_tc" id="locality_on_tc"
                                class="form-control form-select" data-style="btn-info" data-live-search="true">
                                <option value="-1">-- Select --</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="land_size_on_tc" class="form-label">
                                <i class="bi bi-rulers me-1"></i>Land Size (Acre(s))
                            </label>
                            <input class="form-control" id="land_size_on_tc"
                                name="land_size_on_tcland_size_on_tc" type="text"
                                aria-describedby="nameHelp" placeholder="Enter land Size" required>
                        </div>
                        <div class="col-md-4">
                            <label for="type_of_use_on_tc" class="form-label">
                                <i class="bi bi-tags me-1"></i>Type of Use
                            </label>
                            <select name="type_of_use" id="type_of_use_on_tc"
                                class="form-control form-select" data-style="btn-info" data-live-search="true">
                                <option value="-1">-- Select --</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="type_of_interest_on_tc" class="form-label">
                                <i class="bi bi-briefcase me-1"></i>Type of Interest
                            </label>
                            <select class="form-control form-select" id="type_of_interest_on_tc" required>
                                <option>Select Type of Interest</option>
                                <option>LEASEHOLD</option>
                                <option>FREEHOLD</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="nature_of_instrument_on_tc" class="form-label">
                                <i class="bi bi-file-text me-1"></i>Nature of Instrument
                            </label>
                            <select class="form-control form-select" id="nature_of_instrument_on_tc" required>
                                <option>Nature of Instrument</option>
                                <option>Leasehold</option>
                                <option>Assignment</option>
                                <option>Sub-Lease</option>
                                <option>Conveyance</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="file_number_on_tc" class="form-label">
                                <i class="bi bi-folder me-1"></i>File Number
                            </label>
                            <input class="form-control" id="file_number_on_tc"
                                name="file_number_on_tc" type="text"
                                aria-describedby="nameHelp" placeholder="Enter File Number" required>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="job_number_on_tc" class="form-label">
                                <i class="bi bi-hash me-1"></i>Job Number
                            </label>
                            <input class="form-control" id="job_number_on_tc"
                                name="applicant_name_on_tc" type="text"
                                aria-describedby="nameHelp" placeholder="" readonly>
                        </div>
                        <div class="col-md-6">
                            <label for="case_number_on_tc" class="form-label">
                                <i class="bi bi-123 me-1"></i>Case Name
                            </label>
                            <input class="form-control" id="case_number_on_tc"
                                name="applicant_name_on_tc" type="text"
                                aria-describedby="nameHelp" placeholder="" readonly>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-1"></i>Close
                </button>
                <button type="button" id="btn_create_new_job_and_case_number" class="btn btn-primary">
                    <i class="bi bi-plus-circle me-1"></i>Generate Job Number
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Create Job Number Modal for Existing -->
<div class="modal fade modal-blur effect-scale" id="CreateJobNumberModalExisting" tabindex="-1"
    aria-labelledby="CreateJobNumberModalExistingLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0">
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title" id="CreateJobNumberModalExistingLabel">
                    <i class="bi bi-file-earmark-arrow-up me-2"></i>Insert Existing Job and New Case Number
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="form-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="main_service_on_tc_e" class="form-label">
                                <i class="bi bi-list-task me-1"></i>Main Service
                            </label>
                            <select name="main_service_on_tc_e" id="main_service_on_tc_e" 
                                class="form-control form-select" data-style="btn-info" data-live-search="true">
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="sub_service_on_tc_e" class="form-label">
                                <i class="bi bi-list-nested me-1"></i>Sub Service
                            </label>
                            <select name="sub_service_on_tc_e" id="sub_service_on_tc_e" 
                                class="form-control form-select" data-style="btn-info" data-live-search="true">
                                <option value="-1">Select Sub Service</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="row">
                        <div class="col-md-12">
                        <label for="applicant_name_on_tc_e" class="form-label">
                            <i class="bi bi-person me-1"></i>Client Name
                        </label>
                        <input class="form-control" id="applicant_name_on_tc_e"
                            name="applicant_name_on_tc_e" type="text"
                            aria-describedby="nameHelp" placeholder="Enter Client Name" required>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="office_region_on_tc_e" class="form-label">
                                <i class="bi bi-building me-1"></i>Office Region
                            </label>
                            <select class="form-control form-select" id="office_region_on_tc_e" required>
                                <option value="-1">Select Office Region</option>
                                <c:forEach items="${officeregionlist}" var="officeregion">
                                    <option value="${officeregion.ord_region_code}">${officeregion.ord_region_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="locality_on_tc_e" class="form-label">
                                <i class="bi bi-geo-alt me-1"></i>Locality
                            </label>
                            <select name="locality_on_tc_e" id="locality_on_tc_e"
                                class="form-control form-select" data-style="btn-info" data-live-search="true">
                                <option value="-1"> -- Select Locality --</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="land_size_on_tc_e" class="form-label">
                                <i class="bi bi-rulers me-1"></i>Land Size (Acre(s))
                            </label>
                            <input class="form-control" id="land_size_on_tc_e"
                                name="land_size_on_tcland_size_on_tc_e" type="text"
                                aria-describedby="nameHelp" placeholder="Enter land Size" required>
                        </div>
                        <div class="col-md-4">
                            <label for="type_of_use_on_tc_e" class="form-label">
                                <i class="bi bi-tags me-1"></i>Type of Use
                            </label>
                            <select name="type_of_use_e" id="type_of_use_on_tc_e"
                                class="form-control form-select" data-style="btn-info" data-live-search="true">
                                <option value="-1"> -- Select --</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="type_of_interest_on_tc_e" class="form-label">
                                <i class="bi bi-briefcase me-1"></i>Type of Interest
                            </label>
                            <select class="form-control form-select" id="type_of_interest_on_tc_e" required>
                                <option>Select Type of Interest</option>
                                <option>LEASEHOLD</option>
                                <option>FREEHOLD</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="nature_of_instrument_on_tc_e" class="form-label">
                                <i class="bi bi-file-text me-1"></i>Nature of Instrument
                            </label>
                            <select class="form-control form-select" id="nature_of_instrument_on_tc_e" required>
                                <option>Nature of Instrument</option>
                                <option>Leasehold</option>
                                <option>Assignment</option>
                                <option>Sub-Lease</option>
                                <option>Conveyance</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="file_number_on_tc_e" class="form-label">
                                <i class="bi bi-folder me-1"></i>File Number
                            </label>
                            <input class="form-control" id="file_number_on_tc_e"
                                name="file_number_on_tc" type="text"
                                aria-describedby="nameHelp" placeholder="Enter File number" required>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="job_number_on_tc_e" class="form-label">
                                <i class="bi bi-hash me-1"></i>Job Number
                            </label>
                            <input class="form-control" id="job_number_on_tc_e"
                                name="applicant_name_on_tc_e" type="text"
                                aria-describedby="nameHelp" placeholder="">
                        </div>
                        <div class="col-md-6">
                            <label for="case_number_on_tc_e" class="form-label">
                                <i class="bi bi-123 me-1"></i>Case Number
                            </label>
                            <input class="form-control" id="case_number_on_tc_e">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-1"></i>Close
                </button>
                <button type="button" id="btn_create_new_job_and_case_number_e" class="btn btn-info">
                    <i class="bi bi-arrow-repeat me-1"></i>Generate Existing Application
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade modal-blur effect-scale" id="lrd_initial_approval" tabindex="-1" aria-labelledby="lrd_initial_approvalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title text-white" id="lrd_initial_approvalLabel">
                        <i class="fas fa-user-tie me-2"></i>
                        Initial Approval
                    </h5>
                    <div class="ms-auto">
                        <button type="button" class="btn btn-warning btn_send_inspection_request" 
                            data-job_number="${job_number}" 
                            data-ar_name="${ar_name}" 
                            data-business_process_sub_name="${business_process_sub_name}" 
                            data-locality="${locality}" 
                            data-bs-desc="${babyStep.bse_description}">
                            <i class="ri-send-plane-line me-1"></i>Inspection Request
                        </button>
                        <button type="button" class="btn btn-info btn_ground_rent">
                            <i class="ri-coins-fill me-1"></i>Add Ground Rent
                        </button>
                    </div>
                    
                </div>
                <button type="button" class="btn btn-light btn-close-white ms-2" data-bs-dismiss="modal" aria-label="Close"><i class="ri-close-line me-1"></i></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <div class="row g-4" style="height: 100vh;">
                    
                    <!-- Left Column -->
                    <div class="col-lg-6 d-flex flex-column scrollable-col">
                        <div class="card border">
                            <div class="card-header bg-light py-2">
                                <h6 class="mb-0">
                                    <i class="fas fa-sticky-note me-2"></i>
                                    Records Information
                                </h6>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lrd_notes_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Records Info.</th>
                                                <th>Entered By</th>
                                                <th>Entered Date</th>
                                                <th>Division</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${application_notes}" var="application_notes_row">
                                            <tr class="${application_notes_row.an_status == false ? 'table-danger' : ''}" 
                                                ${application_notes_row.an_status == false ? "data-bs-toggle='tooltip' data-bs-placement='top' title='Note has been disabled'" : ""}>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-comment text-muted me-2"></i>
                                                        <span class="text-truncate" style="max-width: 200px;">
                                                            ${application_notes_row.an_description}
                                                        </span>
                                                        ${application_notes_row.an_status == false ? 
                                                            '<span class="badge bg-danger ms-2">Disabled</span>' : ''}
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-user-circle text-muted me-2"></i>
                                                        <span>${application_notes_row.created_by}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-calendar-alt text-muted me-2"></i>
                                                        <span>${application_notes_row.created_date}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="badge bg-secondary bg-opacity-10 text-dark">
                                                        ${application_notes_row.division}
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <button class="btn ${application_notes_row.an_status == false ? 'btn-outline-dark' : 'btn-outline-primary'} btn-sm open-view-notes" 
                                                            data-target-id="${application_notes_row.an_id}"
                                                            data-an_description="${application_notes_row.an_description}"
                                                            data-created_by="${application_notes_row.created_by}"
                                                            data-created_date="${application_notes_row.created_date}"
                                                            data-modified_by="${application_notes_row.created_by}"
                                                            data-modified_date="${application_notes_row.created_date}"
                                                            data-division="${application_notes_row.division}"
                                                            data-job_number="${application_notes_row.job_number}"
                                                            data-case_number="${application_notes_row.case_number}"
                                                            ${application_notes_row.an_status == false ? "disabled" : ""}>
                                                        <i class="fas fa-eye me-1"></i>
                                                        View
                                                    </button>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="_gated_workflow_view_notes">
                            <div class="card border">
                                <div class="card-header bg-light py-2">
                                    <h6 class="mb-0">
                                        <i class="fas fa-sticky-note me-2"></i>
                                        Note Details
                                    </h6>
                                </div>
                                <div class="card-body p-0">
                                    <!-- Note details will be dynamically inserted here -->
                                    <div id="noteDetailsContainer" class="p-3">
                                        <div class="text-center text-muted py-5">
                                            <i class="fas fa-sticky-note fa-3x mb-3"></i>
                                            <p class="mb-0">Select a note to view details</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Right Column -->
                    <div class="col-lg-6 d-flex flex-column scrollable-col">
                        
                        <div class="_gated_workflow_documents"></div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade modal-blur effect-scale" id="instruction_from_lrd_to_smd" tabindex="-1"
    aria-labelledby="instruction_from_lrd_to_smdLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="instruction_from_lrd_to_smdLabel">
                    <i class="bi bi-file-earmark-arrow-up me-2"></i>Title Plan Instructions
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Quill Editor Container -->
                <div class="mb-3">
                    <label for="lrd_smd_instruction" class="form-label fw-medium">
                        <i class="bi bi-chat-left-text me-1"></i>Instructions Content
                    </label>
                    <!-- Hidden input to store the HTML content -->
                    <input type="hidden" id="lrd_smd_instruction_input" name="lrd_smd_instruction">
                    
                    <!-- Quill Editor Container -->
                    <div id="lrd_smd_instruction_editor" style="height: 300px;"></div>
                    
                    <!-- Character Count -->
                    <div class="text-muted small mt-2">
                        <span id="charCount">0</span> characters
                    </div>
                </div>
                
                <!-- Preview Section (Optional) -->
                <div class="mt-4" id="instruction_preview" style="display: none;">
                    <label class="form-label fw-medium">
                        <i class="bi bi-eye me-1"></i>Preview
                    </label>
                    <div class="border rounded p-3 bg-light" id="preview_content" style="min-height: 100px;">
                        <!-- Preview will appear here -->
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-1"></i>Close
                </button>
                <button type="button" id="btn_preview_instruction" class="btn btn-outline-warning">
                    <i class="bi bi-eye me-1"></i>Preview
                </button>
                <button type="button" id="btn_instruction_from_lrd_to_smd" class="btn btn-primary">
                    <i class="bi bi-save me-1"></i>Save
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal map-modal fade modal-blur effect-scale" id="generate_smd_number" tabindex="-1"
    role="dialog" aria-labelledby="generateSMDNumberLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="generateSMDNumberLabel">
                    <i class="fas fa-hashtag me-2"></i>Generate SMD Numbers
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- Property Information Card -->
                <div class="card border mb-4">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold">
                            <i class="fas fa-info-circle me-2 text-danger"></i>Property Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <form>
                            <!-- Row 1 -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-fingerprint me-1 text-muted"></i>GLPIN
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-id-card text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_glpin" type="text" 
                                            value="${glpin}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-drafting-compass me-1 text-muted"></i>Type of Plotting
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-map-marked-alt text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_smd_type_of_plotting" 
                                            name="txt_lc_smd_type_of_plotting" type="text" 
                                            value="${smd_type_of_plotting}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-hashtag me-1 text-muted"></i>SMD Reference Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-file-signature text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_smd_reference_number" 
                                            name="txt_lc_smd_reference_number" type="text" 
                                            value="${smd_reference_number}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Row 2 -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-map-pin me-1 text-muted"></i>Registration District
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-city text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_registration_district_number" 
                                            name="txt_lc_registration_district_number" type="text" 
                                            value="${registration_district_number}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-th-large me-1 text-muted"></i>Section Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-layer-group text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_registration_section_number" 
                                            name="search_value" type="text" 
                                            value="${registration_section_number}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-cube me-1 text-muted"></i>Block Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-cubes text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_registration_block_number" 
                                            name="search_value" type="text" 
                                            value="${registration_block_number}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Row 3 -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-ruler-combined me-1 text-muted"></i>Land Size
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-expand-arrows-alt text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_size_of_land" 
                                            name="search_value" type="text" 
                                            value="${size_of_land}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-map me-1 text-muted"></i>Plan Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-map-marked text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_plan_no" 
                                            name="search_value" type="text" 
                                            value="${plan_no}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-file-alt me-1 text-muted"></i>LTR Plan Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-file-contract text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="ltr_plan_no" 
                                            name="search_value" type="text" 
                                            value="${ltr_plan_no}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Row 4 -->
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-map-signs me-1 text-muted"></i>Registry Map No
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-landmark text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_registry_mapref" 
                                            name="search_value" type="text" 
                                            value="${registry_mapref}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-file-certificate me-1 text-muted"></i>CC No
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-certificate text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_cc_no" 
                                            name="search_value" type="text" 
                                            value="${cc_no}" readonly style="cursor: not-allowed;">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Map Controls and Visualization Card -->
                <div class="card border">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold">
                            <i class="fas fa-map-marked-alt me-2 text-primary"></i>Map Visualization & Controls
                        </h6>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/processing_after_payment" method="post">
                            <!-- WKT Polygon Input -->
                            <div class="mb-4">
                                <label for="lc_bl_wkt_polygon" class="form-label fw-medium">
                                    <i class="fas fa-draw-polygon me-1 text-muted"></i>WKT Polygon
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light">
                                        <i class="fas fa-code text-primary"></i>
                                    </span>
                                    <textarea class="form-control bg-light" id="lc_bl_wkt_polygon" 
                                        name="lc_bl_wkt_polygon" rows="2" 
                                        placeholder="Enter WKT polygon coordinates" readonly style="cursor: not-allowed;">${parcel_wkt}</textarea>
                                </div>
                                <small class="text-muted mt-1 d-block">
                                    <i class="fas fa-info-circle me-1"></i>Well-Known Text format for polygon coordinates
                                </small>
                            </div>
                            
                            <!-- Map Control Buttons -->
                            <div class="mb-4">
                                <div class="d-flex flex-wrap gap-2 align-items-center mb-3">
                                    <div class="d-flex gap-2">
                                        <!-- Visualize Polygon Button -->
                                        <button type="button" class="btn btn-warning btn-sm" 
                                            id="lc_btn_visualise_wkt" 
                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                            title="Visualise Polygon">
                                            <i class="fas fa-map-marked-alt me-1"></i>
                                            Visualize Polygon
                                        </button>
                                        
                                        <!-- Plot Parcels Button -->
                                        <!-- <button type="button" class="btn btn-success btn-sm" 
                                            id="lc_btn_visualise_search" 
                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                            title="Plot Parcels">
                                            <i class="fas fa-object-ungroup me-1"></i>
                                            Plot Parcels
                                        </button> -->
                                        
                                        <!-- Print Map Button -->
                                        <!-- <button type="button" class="btn btn-info btn-sm" 
                                            id="lc_btnprintmap" 
                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                            title="Print Map">
                                            <i class="fas fa-print me-1"></i>
                                            Print
                                        </button> -->
                                    </div>
                                    
                                    <!-- Scale Controls -->
                                    <div class="ms-auto d-flex align-items-center gap-2">
                                        <span class="fw-medium text-muted">
                                            <i class="fas fa-search me-1"></i>Scale:
                                        </span>
                                        
                                        <div class="input-group input-group-sm" style="width: 150px;">
                                            <span class="input-group-text bg-light">
                                                <i class="fas fa-ruler text-secondary"></i>
                                            </span>
                                            <select class="form-select" name="lc_scale_value" id="lc_scale_value">
                                                <option value="500">1:500</option>
                                                <option value="1107">1:1,107</option>
                                                <option value="1250">1:1,250</option>
                                                <option value="2140">1:2,140</option>
                                                <option value="2215">1:2,215</option>
                                                <option value="2500">1:2,500</option>
                                                <option value="2670">1:2,670</option>
                                                <option value="2825">1:2,825</option>
                                                <option value="5000">1:5,000</option>
                                                <option value="10000">1:10,000</option>
                                                <option value="15000">1:15,000</option>
                                                <option value="20000">1:20,000</option>
                                            </select>
                                        </div>
                                        
                                        <!-- Custom Scale Input -->
                                        <div class="input-group input-group-sm" style="width: 120px;">
                                            <input type="text" class="form-control" 
                                                id="lc_scale_value_e" 
                                                placeholder="Custom scale">
                                        </div>
                                        
                                        <!-- Lock Scale & Zoom -->
                                        <div class="d-flex align-items-center gap-2">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input form-check-input-danger" type="checkbox" 
                                                    id="lc_lockmapscale" checked>
                                                <label class="form-check-label small" for="lc_lockmapscale">
                                                    Lock Scale
                                                </label>
                                            </div>
                                            
                                            <button type="button" class="btn btn-info btn-sm" 
                                                id="lc_btn_scale_zoom" 
                                                data-bs-toggle="tooltip" data-bs-placement="top" 
                                                title="Zoom to Scale">
                                                <i class="fas fa-search-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Map Container -->
                                <div class="map-container border rounded" 
                                    id="lc-map____" 
                                    style="height: 400px; min-height: 300px;">
                                    <!-- <div class="d-flex justify-content-center align-items-center h-100 bg-light">
                                        <div class="text-center text-muted">
                                            <i class="fas fa-map fa-3x mb-3"></i>
                                            <p class="mb-0">Map visualization will appear here</p>
                                        </div>
                                    </div> -->
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Generate Button -->
                <div class="mt-4">
                    <button class="btn btn-success w-100 py-3 fw-semibold" 
                        id="btn_generate_smd_title_plan_numbers">
                        <i class="fas fa-cogs me-2"></i>
                        Generate SMD Title Plan Numbers
                    </button>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade modal-blur effect-scale" id="review_plan_details" tabindex="-1"
    role="dialog" aria-labelledby="reviewPlanDetailsLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="reviewPlanDetailsLabel">
                    <i class="fas fa-search me-2"></i>Review Plan Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- Property Information Card -->
                <div class="card border mb-4">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold">
                            <i class="fas fa-info-circle me-2 text-danger"></i>Plan Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <form>
                            <!-- Row 1 -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-fingerprint me-1 text-muted"></i>GLPIN
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-id-card text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_glpin" type="text" style="cursor: not-allowed;"
                                            value="${glpin}" readonly>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-drafting-compass me-1 text-muted"></i>Type of Plotting
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-map-marked-alt text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_smd_type_of_plotting" 
                                            name="txt_lc_smd_type_of_plotting" type="text" style="cursor: not-allowed;"
                                            value="${smd_type_of_plotting}" readonly>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-hashtag me-1 text-muted"></i>SMD Reference Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-file-signature text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_smd_reference_number" 
                                            name="txt_lc_smd_reference_number" type="text" style="cursor: not-allowed;"
                                            value="${smd_reference_number}" readonly>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Row 2 -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-map-pin me-1 text-muted"></i>Registration District
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-city text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_registration_district_number" 
                                            name="txt_lc_registration_district_number" type="text" style="cursor: not-allowed;"
                                            value="${registration_district_number}" readonly>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-th-large me-1 text-muted"></i>Section Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-layer-group text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_registration_section_number" 
                                            type="text" style="cursor: not-allowed;" value="${registration_section_number}" readonly>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-cube me-1 text-muted"></i>Block Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-cubes text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_registration_block_number" 
                                            type="text" style="cursor: not-allowed;" value="${registration_block_number}" readonly>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Row 3 -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-ruler-combined me-1 text-muted"></i>Land Size
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-expand-arrows-alt text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_size_of_land" 
                                            type="text" style="cursor: not-allowed;" value="${size_of_land}" readonly>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-map me-1 text-muted"></i>Plan Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-map-marked text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_plan_no" 
                                            type="text" style="cursor: not-allowed;" value="${plan_no}" readonly>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-file-alt me-1 text-muted"></i>LTR Plan Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-file-contract text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="ltr_plan_no" 
                                            type="text" style="cursor: not-allowed;" value="${ltr_plan_no}" readonly>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Row 4 -->
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-map-signs me-1 text-muted"></i>Registry Map No
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-landmark text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_registry_mapref" 
                                            type="text" style="cursor: not-allowed;" value="${registry_mapref}" readonly>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-file-certificate me-1 text-muted"></i>CC No
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-certificate text-primary"></i>
                                        </span>
                                        <input class="form-control bg-light" id="txt_lc_cc_no" 
                                            type="text" style="cursor: not-allowed;" value="${cc_no}" readonly>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Map Controls and Visualization Card -->
                <div class="card border">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold">
                            <i class="fas fa-map-marked-alt me-2 text-primary"></i>Map Visualization
                        </h6>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/processing_after_payment" method="post">
                            <!-- WKT Polygon Input -->
                            <div class="mb-4">
                                <label for="lc_bl_wkt_polygon" class="form-label fw-medium">
                                    <i class="fas fa-draw-polygon me-1 text-muted"></i>WKT Polygon
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light">
                                        <i class="fas fa-code text-secondary"></i>
                                    </span>
                                    <textarea class="form-control bg-light" id="lc_bl_wkt_polygon" 
                                        name="lc_bl_wkt_polygon" rows="3" style="cursor: not-allowed;" 
                                        placeholder="Enter WKT polygon coordinates" readonly>${parcel_wkt}</textarea>
                                </div>
                                <small class="text-muted mt-1 d-block">
                                    <i class="fas fa-info-circle me-1"></i>Well-Known Text format for polygon coordinates
                                </small>
                            </div>
                            
                            <!-- Map Control Buttons -->
                            <div class="mb-4">
                                <div class="d-flex flex-wrap gap-2 align-items-center mb-3">
                                    <div class="d-flex gap-2">
                                        <!-- Visualize Polygon Button -->
                                        <button type="button" class="btn btn-warning btn-sm" 
                                            id="lc_btn_visualise_wkt" 
                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                            title="Visualise Polygon">
                                            <i class="fas fa-map-marked-alt me-1"></i>
                                            Visualize Polygon
                                        </button>
                                        
                                        <!-- Plot Parcels Button -->
                                        <!-- <button type="button" class="btn btn-success btn-sm" 
                                            id="lc_btn_visualise_search" 
                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                            title="Plot Parcels">
                                            <i class="fas fa-object-ungroup me-1"></i>
                                            Plot Parcels
                                        </button> -->
                                        
                                        <!-- Print Map Button -->
                                        <!-- <button type="button" class="btn btn-info btn-sm" 
                                            id="lc_btnprintmap" 
                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                            title="Print Map">
                                            <i class="fas fa-print me-1"></i>
                                            Print
                                        </button> -->
                                    </div>
                                    
                                    <!-- Scale Controls -->
                                    <div class="ms-auto d-flex align-items-center gap-2">
                                        <span class="fw-medium text-muted">
                                            <i class="fas fa-search me-1"></i>Scale:
                                        </span>
                                        
                                        <div class="input-group input-group-sm" style="width: 150px;">
                                            <span class="input-group-text bg-light">
                                                <i class="fas fa-ruler text-secondary"></i>
                                            </span>
                                            <select class="form-select" name="lc_scale_value" id="lc_scale_value">
                                                <option value="500">1:500</option>
                                                <option value="1107">1:1,107</option>
                                                <option value="1250">1:1,250</option>
                                                <option value="2140">1:2,140</option>
                                                <option value="2215">1:2,215</option>
                                                <option value="2500">1:2,500</option>
                                                <option value="2670">1:2,670</option>
                                                <option value="2825">1:2,825</option>
                                                <option value="5000">1:5,000</option>
                                                <option value="10000">1:10,000</option>
                                                <option value="15000">1:15,000</option>
                                                <option value="20000">1:20,000</option>
                                            </select>
                                        </div>
                                        
                                        <!-- Custom Scale Input -->
                                        <div class="input-group input-group-sm" style="width: 120px;">
                                            <input type="text" class="form-control" 
                                                id="lc_scale_value_e" 
                                                placeholder="Custom scale">
                                        </div>
                                        
                                        <!-- Lock Scale & Zoom -->
                                        <div class="d-flex align-items-center gap-2">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" 
                                                    id="lc_lockmapscale" checked>
                                                <label class="form-check-label small" for="lc_lockmapscale">
                                                    Lock Scale
                                                </label>
                                            </div>
                                            
                                            <button type="button" class="btn btn-info btn-sm" 
                                                id="lc_btn_scale_zoom" 
                                                data-bs-toggle="tooltip" data-bs-placement="top" 
                                                title="Zoom to Scale">
                                                <i class="fas fa-search-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Map Container -->
                                <div class="map-container border rounded" 
                                    id="lc-map_____" 
                                    style="height: 400px; min-height: 300px;">
                                    <!-- <div class="d-flex justify-content-center align-items-center h-100 bg-light">
                                        <div class="text-center text-muted">
                                            <i class="fas fa-map fa-3x mb-3"></i>
                                            <p class="mb-0">Click "Visualize Polygon" to display the map</p>
                                            <p class="small">Map will appear here after visualization</p>
                                        </div>
                                    </div> -->
                                </div>
                            </div>
                            
                            <!-- Review Actions -->
                            <!-- <div class="mt-4 pt-3 border-top">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="alert alert-info mb-0">
                                            <i class="fas fa-check-circle me-2"></i>
                                            <strong>Review Status:</strong> All plan details are loaded and ready for review.
                                        </div>
                                    </div>
                                    <div class="col-md-6 text-end">
                                        <button type="button" class="btn btn-success" id="btn_approve_plan">
                                            <i class="fas fa-check me-1"></i>
                                            Approve Plan
                                        </button>
                                        <button type="button" class="btn btn-outline-danger ms-2" id="btn_reject_plan">
                                            <i class="fas fa-times me-1"></i>
                                            Request Changes
                                        </button>
                                    </div>
                                </div>
                            </div> -->
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Close Review
                </button>
                <button type="button" class="btn btn-outline-primary" id="btn_export_plan_details">
                    <i class="fas fa-download me-1"></i>Export Details
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="upload_pdf_plan" tabindex="-1"
     aria-labelledby="review_documents_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="review_documents_label">
                    <i class="fas fa-file-alt me-2"></i>
                    Uploaf PDF Plan
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Documents Accordion -->
                <div class="accordion" id="documentsAccordion">
                    
                    <!-- Application Documents Card -->
                    <div class="accordion-item border rounded mb-3">
                        <h2 class="accordion-header" id="headingApplication">
                            <button class="accordion-button collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#collapseApplication" 
                                    aria-expanded="false" aria-controls="collapseApplication">
                                <div class="d-flex align-items-center w-100">
                                    <div class="me-3">
                                        <i class="fas fa-folder-open fa-lg text-primary"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0">Application Documents</h6>
                                        <small class="text-muted">Private application documents</small>
                                    </div>
                                    <span class="badge bg-primary rounded-pill ms-2" id="appDocsCount">0</span>
                                </div>
                            </button>
                        </h2>
                        <div id="collapseApplication" class="accordion-collapse collapse" 
                             aria-labelledby="headingApplication" data-bs-parent="#documentsAccordion">
                            <div class="accordion-body">
                                
                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <button type="button" class="btn btn-success btn-sm me-2" 
                                                onclick="loadUploadPDFApplicationDocuments()">
                                            <i class="fas fa-sync-alt me-1"></i>
                                            Refresh
                                        </button>
                                        <button type="button" class="btn btn-primary btn-sm" 
                                                data-bs-toggle="modal" data-bs-target="#fileUploadModal"
                                                data-bs-placement="top" title="Add Documents">
                                            <i class="fas fa-plus-circle me-1"></i>
                                            Add Document
                                        </button>
                                    </div>
                                    <div>
                                        <!-- <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_export_app_docs">
                                            <i class="fas fa-download me-1"></i>
                                            Export
                                        </button> -->
                                    </div>
                                </div>
                                
                                <!-- Documents Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lc_upload_pdf_scanned_documents_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="55%">Document Name</th>
                                                <th width="30%">Document Type</th>
                                                <!-- <th width="15%">Size</th> -->
                                                <th width="15%" class="text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                           
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- Empty State -->
                                <div id="appDocsEmpty" class="text-center py-5 d-none">
                                    <div class="mb-3">
                                        <i class="fas fa-file-alt fa-3x text-muted"></i>
                                    </div>
                                    <h6 class="text-muted">No Application Documents</h6>
                                    <p class="text-muted small mb-0">Click "Add Document" to upload files</p>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    
                    <!-- Public Documents Card -->
                    <div class="accordion-item border rounded">
                        <h2 class="accordion-header" id="headingPublic">
                            <button class="accordion-button collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#collapsePublic" 
                                    aria-expanded="false" aria-controls="collapsePublic">
                                <div class="d-flex align-items-center w-100">
                                    <div class="me-3">
                                        <i class="fas fa-users fa-lg text-success"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0">Public Documents</h6>
                                        <small class="text-muted">Publicly accessible documents</small>
                                    </div>
                                    <span class="badge bg-success rounded-pill ms-2" id="publicDocsCount">0</span>
                                </div>
                            </button>
                        </h2>
                        <div id="collapsePublic" class="accordion-collapse collapse" 
                             aria-labelledby="headingPublic" data-bs-parent="#documentsAccordion">
                            <div class="accordion-body">
                                
                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <button type="button" class="btn btn-success btn-sm me-2" onclick="loadUploadPDFPublicDocuments()">
                                            <i class="fas fa-sync-alt me-1"></i>
                                            Refresh
                                        </button>
                                        <button type="button" class="btn btn-primary btn-sm" 
                                                data-bs-toggle="modal" data-bs-target="#publicFileUploadModal"
                                                data-bs-placement="top" title="Add Public Documents">
                                            <i class="fas fa-plus-circle me-1"></i>
                                            Add Public Document
                                        </button>
                                    </div>
                                    <div>
                                        <!-- <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_export_public_docs">
                                            <i class="fas fa-download me-1"></i>
                                            Export
                                        </button> -->
                                    </div>
                                </div>
                                
                                <!-- Public Documents Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lc_upload_pdf_public_documents_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="55%">Document Name</th>
                                                <th width="30%">Document Type</th>
                                                <!-- <th width="15%">Size</th> -->
                                                <th width="15%" class="text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- Empty State -->
                                <div id="publicDocsEmpty" class="text-center py-5 d-none">
                                    <div class="mb-3">
                                        <i class="fas fa-users fa-3x text-muted"></i>
                                    </div>
                                    <h6 class="text-muted">No Public Documents</h6>
                                    <p class="text-muted small mb-0">Click "Add Public Document" to upload files</p>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Total Documents: 
                        <span class="fw-medium" id="totalDocumentsCount">0</span>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        <button type="button" id="btn_update_app_status_ffrv" style="display:none"
                                class="btn btn-success">
                            <i class="fas fa-check me-1"></i>
                            Confirm Final Approval
                        </button>
                    </div>
                </div>
                <input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id">
            </div>
            
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="upload_final_pdf_plan" tabindex="-1"
     aria-labelledby="review_documents_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="review_documents_label">
                    <i class="fas fa-file-alt me-2"></i>
                    Uploaf Final PDF Plan
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Documents Accordion -->
                <div class="accordion" id="documentsAccordion">
                    
                    <!-- Application Documents Card -->
                    <div class="accordion-item border rounded mb-3">
                        <h2 class="accordion-header" id="headingApplication">
                            <button class="accordion-button collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#collapseApplication" 
                                    aria-expanded="false" aria-controls="collapseApplication">
                                <div class="d-flex align-items-center w-100">
                                    <div class="me-3">
                                        <i class="fas fa-folder-open fa-lg text-primary"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0">Application Documents</h6>
                                        <small class="text-muted">Private application documents</small>
                                    </div>
                                    <span class="badge bg-primary rounded-pill ms-2" id="appDocsCount">0</span>
                                </div>
                            </button>
                        </h2>
                        <div id="collapseApplication" class="accordion-collapse collapse" 
                             aria-labelledby="headingApplication" data-bs-parent="#documentsAccordion">
                            <div class="accordion-body">
                                
                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <button type="button" class="btn btn-success btn-sm me-2" 
                                                onclick="loadUploadFinalPDFApplicationDocuments()">
                                            <i class="fas fa-sync-alt me-1"></i>
                                            Refresh
                                        </button>
                                        <button type="button" class="btn btn-primary btn-sm" 
                                                data-bs-toggle="modal" data-bs-target="#fileUploadModal"
                                                data-bs-placement="top" title="Add Documents">
                                            <i class="fas fa-plus-circle me-1"></i>
                                            Add Document
                                        </button>
                                    </div>
                                    <div>
                                        <!-- <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_export_app_docs">
                                            <i class="fas fa-download me-1"></i>
                                            Export
                                        </button> -->
                                    </div>
                                </div>
                                
                                <!-- Documents Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lc_upload_final_pdf_scanned_documents_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="55%">Document Name</th>
                                                <th width="30%">Document Type</th>
                                                <!-- <th width="15%">Size</th> -->
                                                <th width="15%" class="text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                           
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- Empty State -->
                                <div id="appDocsEmpty" class="text-center py-5 d-none">
                                    <div class="mb-3">
                                        <i class="fas fa-file-alt fa-3x text-muted"></i>
                                    </div>
                                    <h6 class="text-muted">No Application Documents</h6>
                                    <p class="text-muted small mb-0">Click "Add Document" to upload files</p>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    
                    <!-- Public Documents Card -->
                    <div class="accordion-item border rounded">
                        <h2 class="accordion-header" id="headingPublic">
                            <button class="accordion-button collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#collapsePublic" 
                                    aria-expanded="false" aria-controls="collapsePublic">
                                <div class="d-flex align-items-center w-100">
                                    <div class="me-3">
                                        <i class="fas fa-users fa-lg text-success"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0">Public Documents</h6>
                                        <small class="text-muted">Publicly accessible documents</small>
                                    </div>
                                    <span class="badge bg-success rounded-pill ms-2" id="publicDocsCount">0</span>
                                </div>
                            </button>
                        </h2>
                        <div id="collapsePublic" class="accordion-collapse collapse" 
                             aria-labelledby="headingPublic" data-bs-parent="#documentsAccordion">
                            <div class="accordion-body">
                                
                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <button type="button" class="btn btn-success btn-sm me-2" onclick="loadUploadFinalPDFPublicDocuments()">
                                            <i class="fas fa-sync-alt me-1"></i>
                                            Refresh
                                        </button>
                                        <button type="button" class="btn btn-primary btn-sm" 
                                                data-bs-toggle="modal" data-bs-target="#publicFileUploadModal"
                                                data-bs-placement="top" title="Add Public Documents">
                                            <i class="fas fa-plus-circle me-1"></i>
                                            Add Public Document
                                        </button>
                                    </div>
                                    <div>
                                        <!-- <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_export_public_docs">
                                            <i class="fas fa-download me-1"></i>
                                            Export
                                        </button> -->
                                    </div>
                                </div>
                                
                                <!-- Public Documents Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lc_upload_final_pdf_public_documents_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="55%">Document Name</th>
                                                <th width="30%">Document Type</th>
                                                <!-- <th width="15%">Size</th> -->
                                                <th width="15%" class="text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- Empty State -->
                                <div id="publicDocsEmpty" class="text-center py-5 d-none">
                                    <div class="mb-3">
                                        <i class="fas fa-users fa-3x text-muted"></i>
                                    </div>
                                    <h6 class="text-muted">No Public Documents</h6>
                                    <p class="text-muted small mb-0">Click "Add Public Document" to upload files</p>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Total Documents: 
                        <span class="fw-medium" id="totalDocumentsCount">0</span>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        <button type="button" id="btn_update_app_status_ffrv" style="display:none"
                                class="btn btn-success">
                            <i class="fas fa-check me-1"></i>
                            Confirm Final Approval
                        </button>
                    </div>
                </div>
                <input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id">
            </div>
            
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="plot_transaction_to_smd_layer" tabindex="-1" 
     aria-labelledby="confirmOtpModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title text-white" id="confirmOtpModalLabel">
          <i class="fas fa-shield-alt me-2"></i>
          Request OTP For Approval
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Information Alert -->
        <div class="alert alert-danger bg-danger bg-opacity-10 border-danger mb-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>OTP Required</strong>
              <p class="mb-0 mt-1 fw-light">You need to generate a One-Time Password to proceed with final signing.</p>
            </div>
          </div>
        </div>
        
        <!-- Optional Volume and Folio Display -->
        <!-- 
        <div class="row g-3 mb-4">
          <div class="col-md-6">
            <div class="form-group">
              <label for="" class="form-label fw-medium">
                <i class="fas fa-book me-1"></i>
                Volume Number
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="fas fa-hashtag"></i>
                </span>
                <input type="text" class="form-control" readonly value="${volume_number}">
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label for="" class="form-label fw-medium">
                <i class="fas fa-file-alt me-1"></i>
                Folio Number
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="fas fa-hashtag"></i>
                </span>
                <input type="text" class="form-control" readonly value="${folio_number}">
              </div>
            </div>
          </div>
        </div>
        -->
        
        <!-- Generate OTP Button -->
        <div class="text-center py-3">
          <button type="button" id="lc_btn_approve_for_plot_transaction_to_smd_layer" 
                  class="btn btn-danger btn-lg w-100 py-3">
            <i class="fas fa-key me-2"></i>
            Generate OTP
          </button>
          <div class="form-text mt-2">
            <i class="fas fa-lock me-1"></i>
            Secure one-time password will be sent for verification
          </div>
        </div>
        
        <!-- OTP Instructions -->
        <div class="alert alert-light border mt-4">
          <div class="d-flex">
            <i class="fas fa-lightbulb text-warning me-3 mt-1"></i>
            <div>
              <strong class="text-dark">How it works:</strong>
              <ul class="mb-0 mt-2 ps-3 fw-light">
                <li class="text-muted">Click "Generate OTP" to create a one-time password</li>
                <li class="text-muted">The OTP will be sent to authorized personnel</li>
                <li class="text-muted">Use the OTP to complete certificate approval</li>
              </ul>
            </div>
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="review_application_against_fifo" tabindex="-1" 
     aria-labelledby="confirmOtpModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-xl">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="confirmOtpModalLabel">
          <i class="fas fa-eye me-2"></i>
          First In Time Review
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <div class="row">
            <div class="col-md-8">
                <div class="card border">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold">
                            <i class="fas fa-map-marked-alt me-2 text-primary"></i>Map Visualization & Controls
                        </h6>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/processing_after_payment" method="post">
                            <!-- WKT Polygon Input -->
                            <div class="mb-4">
                                <label for="lc_bl_wkt_polygon" class="form-label fw-medium">
                                    <i class="fas fa-draw-polygon me-1 text-muted"></i>WKT Polygon
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light">
                                        <i class="fas fa-code text-primary"></i>
                                    </span>
                                    <textarea class="form-control bg-light" id="lc_bl_wkt_polygon" 
                                        name="lc_bl_wkt_polygon" rows="2" 
                                        placeholder="Enter WKT polygon coordinates" readonly style="cursor: not-allowed;">${parcel_wkt}</textarea>
                                </div>
                                <small class="text-muted mt-1 d-block">
                                    <i class="fas fa-info-circle me-1"></i>Well-Known Text format for polygon coordinates
                                </small>
                            </div>
                            
                            <!-- Map Control Buttons -->
                            <div class="mb-4">
                                <div class="mb-3">
                                    <div class="d-flex gap-2">
                                        <!-- Visualize Polygon Button -->
                                        <button type="button" class="btn btn-warning btn-sm" 
                                            id="lc_btn_visualise_wkt">
                                            <i class="fas fa-map-marked-alt me-1"></i>
                                            Visualize Polygon
                                        </button>
                                        
                                        <!-- Plot Parcels Button -->
                                        <!-- <button type="button" class="btn btn-success btn-sm" 
                                            id="lc_btn_visualise_search">
                                            <i class="fas fa-object-ungroup me-1"></i>
                                            Plot Parcels
                                        </button> -->
                                        
                                        <!-- Print Map Button -->
                                        <!-- <button type="button" class="btn btn-info btn-sm" 
                                            id="lc_btnprintmap">
                                            <i class="fas fa-print me-1"></i>
                                            Print
                                        </button> -->

                                        <button type="button" class="btn btn-danger btn-sm" 
                                            id="lc_btn_check_related_jobs">
                                            <i class="fas fa-eye me-1"></i>
                                            Check Related Jobs
                                        </button>
                                    </div>
                                    
                                    <!-- Scale Controls -->
                                    <div class="mt-3 d-flex align-items-center gap-2">
                                        <span class="fw-medium text-muted">
                                            <i class="fas fa-search me-1"></i>Scale:
                                        </span>
                                        
                                        <div class="input-group input-group-sm" style="width: 150px;">
                                            <span class="input-group-text bg-light">
                                                <i class="fas fa-ruler text-secondary"></i>
                                            </span>
                                            <select class="form-select" name="lc_scale_value" id="lc_scale_value">
                                                <option value="500">1:500</option>
                                                <option value="1107">1:1,107</option>
                                                <option value="1250">1:1,250</option>
                                                <option value="2140">1:2,140</option>
                                                <option value="2215">1:2,215</option>
                                                <option value="2500">1:2,500</option>
                                                <option value="2670">1:2,670</option>
                                                <option value="2825">1:2,825</option>
                                                <option value="5000">1:5,000</option>
                                                <option value="10000">1:10,000</option>
                                                <option value="15000">1:15,000</option>
                                                <option value="20000">1:20,000</option>
                                            </select>
                                        </div>
                                        
                                        <!-- Custom Scale Input -->
                                        <div class="input-group input-group-sm" style="width: 120px;">
                                            <input type="text" class="form-control" 
                                                id="lc_scale_value_e" 
                                                placeholder="Custom scale">
                                        </div>
                                        
                                        <!-- Lock Scale & Zoom -->
                                        <div class="d-flex align-items-center gap-2">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input form-check-input-danger" type="checkbox" 
                                                    id="lc_lockmapscale" checked>
                                                <label class="form-check-label small" for="lc_lockmapscale">
                                                    Lock Scale
                                                </label>
                                            </div>
                                            
                                            <button type="button" class="btn btn-info btn-sm" 
                                                id="lc_btn_scale_zoom" 
                                                data-bs-toggle="tooltip" data-bs-placement="top" 
                                                title="Zoom to Scale">
                                                <i class="fas fa-search-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Map Container -->
                                <div class="map-container border rounded" 
                                    id="lc-map______" 
                                    style="height: 400px; min-height: 300px;">
                                    <!-- <div class="d-flex justify-content-center align-items-center h-100 bg-light">
                                        <div class="text-center text-muted">
                                            <i class="fas fa-map fa-3x mb-3"></i>
                                            <p class="mb-0">Map visualization will appear here</p>
                                        </div>
                                    </div> -->
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 fw-semibold">
                            <i class="fas fa-list-alt me-2 text-primary"></i>Related Jobs
                        </h6>
                    </div>
                    <div class="card-body">
                        <table class="table table-hover table-sm table-striped" id="lc_fit_related_jobs_table">
                            <thead class="table-light">
                                <tr>
                                    <th>Job Number</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>LRDGAR61145672021</td>
                                    <td>
                                        <button type="button" class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-eye me-1"></i>
                                            View
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade modal-blur effect-scale" id="compose_search_report" tabindex="-1"
	role="dialog" aria-labelledby="compose_search_reportmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-fullscreen modal-dialog-centered">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="review_records_verification_label">
                    <i class="fas fa-edit me-2"></i>
                    Compose Search Report
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			<div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="card border">
                            <div class="card-header bg-light py-2">
                                <h6 class="mb-0">
                                    <i class="fas fa-sticky-note me-2"></i>
                                    Records Information
                                </h6>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lrd_notes_dataTable_2">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Records Info.</th>
                                                <th>Entered By</th>
                                                <th>Entered Date</th>
                                                <th>Division</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${application_notes}" var="application_notes_row">
                                            <tr class="${application_notes_row.an_status == false ? 'table-danger' : ''}" 
                                                ${application_notes_row.an_status == false ? "data-bs-toggle='tooltip' data-bs-placement='top' title='Note has been disabled'" : ""}>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-comment text-muted me-2"></i>
                                                        <span class="text-truncate" style="max-width: 200px;">
                                                            ${application_notes_row.an_description}
                                                        </span>
                                                        ${application_notes_row.an_status == false ? 
                                                            '<span class="badge bg-danger ms-2">Disabled</span>' : ''}
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-user-circle text-muted me-2"></i>
                                                        <span>${application_notes_row.created_by}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-calendar-alt text-muted me-2"></i>
                                                        <span>${application_notes_row.created_date}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="badge bg-secondary bg-opacity-10 text-dark">
                                                        ${application_notes_row.division}
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <button class="btn btn-outline-primary btn-sm  open-view-notes-2" 
                                                            data-target-id="${application_notes_row.an_id}"
                                                            data-an_description="${application_notes_row.an_description}"
                                                            data-created_by="${application_notes_row.created_by}"
                                                            data-created_date="${application_notes_row.created_date}"
                                                            data-modified_by="${application_notes_row.created_by}"
                                                            data-modified_date="${application_notes_row.created_date}"
                                                            data-division="${application_notes_row.division}"
                                                            ${application_notes_row.an_status == false ? "disabled" : ""}>
                                                        <i class="fas fa-eye me-1"></i>
                                                        View
                                                    </button>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="_gated_workflow_view_notes">
                            <div class="card border">
                                <div class="card-header bg-light py-2">
                                    <h6 class="mb-0">
                                        <i class="fas fa-sticky-note me-2"></i>
                                        Note Details
                                    </h6>
                                </div>
                                <div class="card-body p-0">
                                    <!-- Note details will be dynamically inserted here -->
                                    <div id="noteDetailsContainer_2" class="p-3">
                                        <div class="text-center text-muted py-5">
                                            <i class="fas fa-sticky-note fa-3x mb-3"></i>
                                            <p class="mb-0">Select a note to view details</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-edit"></i> Summarize Search Reports
                            </div>
                            <div class="card-body">
                                <!-- The Form starts here -->
                                <div class="form-group">
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label for="lc_search_report_summary_details_2" class="form-label">Report Summary</label>
                                            <!-- <textarea id="lc_search_report_summary_details_2" 
                                                name="lc_search_report_summary_details" 
                                                class="form-control" 
                                                required 
                                                rows="7" 
                                                style="padding:50px !important;">${remark_or_comment}</textarea>
                                            </div> -->
                                            <div class="position-relative">
                                                <!-- <textarea id="lc_search_report_summary_details" 
                                                            name="lc_search_report_summary_details" 
                                                            class="form-control" 
                                                            required 
                                                            rows="7"
                                                            style="min-height: 200px; padding: 1.5rem !important;"
                                                            placeholder="Enter certificate summary and details...">${remark_or_comment}
                                                </textarea> -->
                                                <!-- <div id="lc_search_report_summary_details_2" class="quill-editor" style="height: 300px;">
                                                    ${remark_or_comment}
                                                </div> -->
                                                <textarea id="lc_search_report_summary_details_2">
                                                    ${remark_or_comment}
                                                </textarea>
                                                <div class="position-absolute top-0 end-0 p-3 text-muted">
                                                    <i class="fas fa-file-signature"></i>
                                                </div>
                                            </div>
                                        </div>
                                    
                                    <div class="row g-3 mt-2">
                                        <div class="col-auto">
                                        <!-- <button type="button" 
                                            name="btn_compose_certificate_template_2" 
                                            id="btn_compose_certificate_template_2" 
                                            class="btn btn-warning btn-icon-split">
                                            <span class="icon text-white-50"> 
                                            <i class="fas fa-edit"></i>
                                            </span>
                                            <span class="text">Compose Template</span>
                                        </button> -->
                                        </div>
                                        
                                        <div class="col-auto">
                                        <button type="button" 
                                            name="lc_btn_save_search_report_2" 
                                            id="lc_btn_save_search_report_2" 
                                            class="btn btn-success btn-icon-split">
                                            <span class="icon text-white-50"> 
                                            <i class="fas fa-upload"></i>
                                            </span>
                                            <span class="text">Save Report</span>
                                        </button>
                                        </div>
                                        
                                        <div class="col">
                                        <button type="button" 
                                            name="btn_preview_search_report" 
                                            id="btn_preview_search_report" 
                                            class="btn btn-info btn-icon-split">
                                            <span class="icon text-white-50"> 
                                            <i class="fas fa-print"></i>
                                            </span>
                                            <span class="text">Preview Search Report</span>
                                        </button>
                                        </div>
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
			
			<div class="modal-footer">
				<button type="button" 
					class="btn btn-danger btn-icon-split"
					data-bs-dismiss="modal">
					<span class="icon text-white-50"> 
						<i class="fas fa-times"></i>
					</span>
					<span class="text">Close</span>
				</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade modal-blur effect-scale" id="check_search_report_details" tabindex="-1"
	role="dialog" aria-labelledby="check_search_report_details" aria-hidden="true"
>
	<div class="modal-dialog modal-fullscreen modal-dialog-centered">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="check_search_report_details">
                    <i class="fas fa-edit me-2"></i>
                    Check Search Report Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			<div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="card border">
                            <div class="card-header bg-light py-2">
                                <h6 class="mb-0">
                                    <i class="fas fa-sticky-note me-2"></i>
                                    Records Information
                                </h6>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lrd_notes_dataTable_3">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Records Info.</th>
                                                <th>Entered By</th>
                                                <th>Entered Date</th>
                                                <th>Division</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${application_notes}" var="application_notes_row">
                                            <tr class="${application_notes_row.an_status == false ? 'table-danger' : ''}" 
                                                ${application_notes_row.an_status == false ? "data-bs-toggle='tooltip' data-bs-placement='top' title='Note has been disabled'" : ""}>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-comment text-muted me-2"></i>
                                                        <span class="text-truncate" style="max-width: 200px;">
                                                            ${application_notes_row.an_description}
                                                        </span>
                                                        ${application_notes_row.an_status == false ? 
                                                            '<span class="badge bg-danger ms-2">Disabled</span>' : ''}
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-user-circle text-muted me-2"></i>
                                                        <span>${application_notes_row.created_by}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-calendar-alt text-muted me-2"></i>
                                                        <span>${application_notes_row.created_date}</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="badge bg-secondary bg-opacity-10 text-dark">
                                                        ${application_notes_row.division}
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <button class="btn btn-outline-primary btn-sm open-view-notes-3" 
                                                            data-target-id="${application_notes_row.an_id}"
                                                            data-an_description="${application_notes_row.an_description}"
                                                            data-created_by="${application_notes_row.created_by}"
                                                            data-created_date="${application_notes_row.created_date}"
                                                            data-modified_by="${application_notes_row.created_by}"
                                                            data-modified_date="${application_notes_row.created_date}"
                                                            data-division="${application_notes_row.division}"
                                                            ${application_notes_row.an_status == false ? "disabled" : ""}>
                                                        <i class="fas fa-eye me-1"></i>
                                                        View
                                                    </button>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                         <div class="_gated_workflow_view_notes">
                            <div class="card border">
                                <div class="card-header bg-light py-2">
                                    <h6 class="mb-0">
                                        <i class="fas fa-sticky-note me-2"></i>
                                        Note Details
                                    </h6>
                                </div>
                                <div class="card-body p-0">
                                    <!-- Note details will be dynamically inserted here -->
                                    <div id="noteDetailsContainer_3" class="p-3">
                                        <div class="text-center text-muted py-5">
                                            <i class="fas fa-sticky-note fa-3x mb-3"></i>
                                            <p class="mb-0">Select a note to view details</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-chart-pie"></i> Summarize Search Reports
                            </div>
                            <div class="card-body">
                                <!-- The Form starts here -->
                                <div class="form-group">
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label for="lc_search_report_summary_details_3" class="form-label">Report Summary</label>
                                            <!-- <textarea id="lc_search_report_summary_details_3" 
                                                name="lc_search_report_summary_details" 
                                                class="form-control" 
                                                required 
                                                rows="7" 
                                                style="padding:50px !important;">${remark_or_comment}</textarea>
                                            </div> -->
                                            <div class="position-relative">
                                                <!-- <textarea id="lc_search_report_summary_details" 
                                                            name="lc_search_report_summary_details" 
                                                            class="form-control" 
                                                            required 
                                                            rows="7"
                                                            style="min-height: 200px; padding: 1.5rem !important;"
                                                            placeholder="Enter certificate summary and details...">${remark_or_comment}
                                                </textarea> -->
                                                <!-- <div id="lc_search_report_summary_details_3" class="quill-editor" style="height: 300px;">
                                                    ${remark_or_comment}
                                                </div> -->
                                                <textarea id="lc_search_report_summary_details_3">
                                                    ${remark_or_comment}
                                                </textarea>
                                                <div class="position-absolute top-0 end-0 p-3 text-muted">
                                                    <i class="fas fa-file-signature"></i>
                                                </div>
                                            </div>
                                        </div>
                                    
                                    <div class="row g-3 mt-2">
                                        <!-- <div class="col-auto">
                                        <button type="button" 
                                            name="btn_compose_certificate_template_2" 
                                            id="btn_compose_certificate_template_2" 
                                            class="btn btn-warning btn-icon-split">
                                            <span class="icon text-white-50"> 
                                            <i class="fas fa-edit"></i>
                                            </span>
                                            <span class="text">Compose Template</span>
                                        </button>
                                        </div> -->
                                        
                                        <div class="col-auto">
                                        <button type="button" 
                                            name="lc_btn_save_search_report_3" 
                                            id="lc_btn_save_search_report_3" 
                                            class="btn btn-success btn-icon-split">
                                            <span class="icon text-white-50"> 
                                            <i class="fas fa-upload"></i>
                                            </span>
                                            <span class="text">Save Report</span>
                                        </button>
                                        </div>
                                        
                                        <div class="col">
                                        <button type="button" 
                                            name="btn_preview_search_report" 
                                            id="btn_preview_search_report_3" 
                                            class="btn btn-info btn-icon-split">
                                            <span class="icon text-white-50"> 
                                            <i class="fas fa-print"></i>
                                            </span>
                                            <span class="text">Preview Search Report</span>
                                        </button>
                                        </div>
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
			</div>
			
			<div class="modal-footer">
				<button type="button" 
					class="btn btn-danger btn-icon-split"
					data-bs-dismiss="modal">
					<span class="icon text-white-50"> 
						<i class="fas fa-times"></i>
					</span>
					<span class="text">Close</span>
				</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade modal-blur effect-scale" id="preview_composed_report" tabindex="-1"
	role="dialog" aria-labelledby="compose_search_reportmodal" aria-hidden="true"
>
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="review_records_verification_label">
                    <i class="fas fa-eye me-2"></i>
                    Review Search Report
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			
			<div class="modal-body">
				<!-- Description Section -->
				<div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
					<div class="d-flex">
						<i class="fas fa-info-circle fa-lg me-3 mt-1 text-info"></i>
						<div>
							<h6 class="alert-heading mb-2">About Search Report Preview</h6>
							<p class="mb-2">Use this feature to review the composed search report before final submission. The preview will display the formatted report exactly as it will appear when generated.</p>
						</div>
					</div>
				</div>
				
				
				<!-- Preview Action Section -->
				<div class="text-center p-4 border-dashed rounded-3 bg-light">
					<i class="fas fa-file-pdf text-warning fa-3x mb-3"></i>
					<h5 class="mb-3">Ready to Preview Search Report</h5>
					<p class="text-muted mb-4">
						Click the button below to generate and view a preview of the search report. 
						The preview will open in a new window for easy review and printing.
					</p>
					
					<div class="d-grid gap-2 d-md-flex justify-content-center">
						<button type="button" id="btn_preview_search_report_2" class="btn btn-warning btn-lg px-4">
							<i class="fas fa-eye me-2"></i> 
							<span class="fw-semibold">View Search Report</span>
						</button>
					</div>
					
					<small class="text-muted d-block mt-3">
						<i class="fas fa-exclamation-circle me-1"></i>
						Note: Any unsaved changes will not appear in the preview.
					</small>
				</div>
			</div>
			
			<div class="modal-footer bg-light">
				<button type="button" 
					class="btn btn-outline-danger"
					data-bs-dismiss="modal">
					<i class="fas fa-times me-2"></i>
					Close Preview
				</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade modal-blur effect-scale" id="upload_signed_search_report" tabindex="-1"
	role="dialog" aria-labelledby="upload_signed_search_report_label" aria-hidden="true"
>
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="upload_signed_search_report_label">
                    <i class="fas fa-file-signature me-2"></i>
                    Upload Signed Search Report
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			
			<div class="modal-body">
				<!-- Description Section -->
				<!-- <div class="alert alert-success bg-success bg-opacity-10 border-success mb-4">
					<div class="d-flex">
						<i class="fas fa-info-circle fa-lg me-3 mt-1 text-success"></i>
						<div>
							<h6 class="alert-heading mb-2">About Signed Report Upload</h6>
							<p class="mb-2">Upload the final signed search report here. Once uploaded, this document will be attached to the applicant's public record and become part of the official case documentation.</p>
						</div>
					</div>
				</div> -->
				
				<!-- Upload Information Banner -->
				<div class="alert alert-warning bg-warning bg-opacity-10 border-warning mb-4">
					<div class="d-flex align-items-center">
						<i class="fas fa-exclamation-triangle fa-lg me-3 text-warning"></i>
						<div>
							<strong>Important:</strong> This action will upload the final signed report to the applicant's public document. Please ensure you have the correct signed version before proceeding.
						</div>
					</div>
				</div>
				
				<!-- Upload Section -->
				<div class="text-center p-5 border-dashed rounded-3 bg-light" style="border: 2px dashed #ccc;">
					<i class="fas fa-cloud-upload-alt text-primary fa-4x mb-3"></i>
					<h5 class="mb-3">Upload Signed Search Report</h5>
					<!-- <p class="text-muted mb-4">
						Select the final signed search report file to upload. 
						This document will be permanently attached to the applicant's public record.
					</p> -->
					
					<div class="d-grid gap-2 d-md-flex justify-content-center">
						<button type="button" id="btn_upload_signed_report" class="btn btn-primary btn-lg px-4">
							<i class="fas fa-upload me-2"></i> 
							<span class="fw-semibold">Upload Signed Report</span>
						</button>
					</div>
					
					<small class="text-muted d-block mt-4">
						<i class="fas fa-exclamation-circle me-1"></i>
						Note: Once uploaded, this document will be added to the applicant's public record and cannot be removed.
					</small>
				</div>
			</div>
			
			<div class="modal-footer bg-light">
				<button type="button" 
					class="btn btn-outline-secondary"
					data-bs-dismiss="modal">
					<i class="fas fa-times me-2"></i>
					Cancel
				</button>
				<!-- <button type="button" 
					class="btn btn-outline-primary"
					disabled>
					<i class="fas fa-upload me-2"></i>
					Upload
				</button> -->
			</div>
		</div>
	</div>
</div>

<div class="modal fade effect-scale modal-blur" id="confirm_otp_for_approval_search" tabindex="-1" 
     aria-labelledby="confirmOtpModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title text-white" id="confirmOtpModalLabel">
          <i class="fas fa-shield-alt me-2"></i>
          Request OTP For Approval
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Information Alert -->
        <div class="alert alert-danger bg-danger bg-opacity-10 border-danger mb-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>OTP Required</strong>
              <p class="mb-0 mt-1 fw-light">You need to generate a One-Time Password to proceed with search report approval.</p>
            </div>
          </div>
        </div>
        
        <!-- Optional Volume and Folio Display -->
        <!-- 
        <div class="row g-3 mb-4">
          <div class="col-md-6">
            <div class="form-group">
              <label for="" class="form-label fw-medium">
                <i class="fas fa-book me-1"></i>
                Volume Number
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="fas fa-hashtag"></i>
                </span>
                <input type="text" class="form-control" readonly value="${volume_number}">
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label for="" class="form-label fw-medium">
                <i class="fas fa-file-alt me-1"></i>
                Folio Number
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="fas fa-hashtag"></i>
                </span>
                <input type="text" class="form-control" readonly value="${folio_number}">
              </div>
            </div>
          </div>
        </div>
        -->
        
        <!-- Generate OTP Button -->
        <div class="text-center py-3">
          <button type="button" id="lc_btn_approve_search_for_signature" 
                  class="btn btn-danger btn-lg w-100 py-3">
            <i class="fas fa-key me-2"></i>
            Generate OTP
          </button>
          <div class="form-text mt-2">
            <i class="fas fa-lock me-1"></i>
            Secure one-time password will be sent for verification
          </div>
        </div>
        
        <!-- OTP Instructions -->
        <div class="alert alert-light border mt-4">
          <div class="d-flex">
            <i class="fas fa-lightbulb text-warning me-3 mt-1"></i>
            <div>
              <strong class="text-dark">How it works:</strong>
              <ul class="mb-0 mt-2 ps-3 fw-light">
                <li class="text-muted">Click "Generate OTP" to create a one-time password</li>
                <li class="text-muted">The OTP will be sent to authorized personnel</li>
                <li class="text-muted">Use the OTP to complete certificate approval</li>
              </ul>
            </div>
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade modal-blur effect-scale" id="check_signed_report" tabindex="-1"
	role="dialog" aria-labelledby="check_signed_report_modal" aria-hidden="true"
>
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="check_signed_report_modal">
                    <i class="fas fa-eye me-2"></i>
                    Check Signed Search Report
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			
			<div class="modal-body">
				<!-- Description Section -->
				<div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
					<div class="d-flex">
						<i class="fas fa-info-circle fa-lg me-3 mt-1 text-info"></i>
						<div>
							<h6 class="alert-heading mb-2">About Search Report Preview</h6>
							<p class="mb-2">Use this feature to review the composed search report before final submission. The preview will display the formatted report exactly as it will appear when generated.</p>
						</div>
					</div>
				</div>
				
				<!-- Report Summary Section -->
				<!-- <div class="card border-0 shadow-sm mb-4">
					<div class="card-header bg-light py-3">
						<h6 class="mb-0">
							<i class="fas fa-file-alt me-2"></i>
							Report Details
						</h6>
					</div>
					<div class="card-body">
						<div class="row g-3">
							<div class="col-md-6">
								<label class="form-label text-muted small mb-1">
									<i class="fas fa-hashtag me-1"></i> Job Number
								</label>
								<div class="form-control-plaintext border-bottom pb-2" id="preview_job_number">
									<span class="text-muted">Not specified</span>
								</div>
							</div>
							<div class="col-md-6">
								<label class="form-label text-muted small mb-1">
									<i class="fas fa-file-code me-1"></i> Case Number
								</label>
								<div class="form-control-plaintext border-bottom pb-2" id="preview_case_number">
									<span class="text-muted">Not specified</span>
								</div>
							</div>
							<div class="col-12">
								<label class="form-label text-muted small mb-1">
									<i class="fas fa-tasks me-1"></i> Process Type
								</label>
								<div class="form-control-plaintext border-bottom pb-2" id="preview_process_type">
									<span class="text-muted">Not specified</span>
								</div>
							</div>
							<div class="col-12">
								<label class="form-label text-muted small mb-1">
									<i class="fas fa-calendar-check me-1"></i> Last Modified
								</label>
								<div class="form-control-plaintext border-bottom pb-2" id="preview_last_modified">
									<span class="text-muted">Just now</span>
								</div>
							</div>
						</div>
					</div>
				</div> -->
				
				<!-- Preview Action Section -->
				<div class="text-center p-4 border-dashed rounded-3 bg-light">
					<i class="fas fa-file-pdf text-warning fa-3x mb-3"></i>
					<h5 class="mb-3">Ready to Preview Search Report</h5>
					<p class="text-muted mb-4">
						Click the button below to generate and view a preview of the search report. 
						The preview will open in a new window for easy review and printing.
					</p>
					
					<div class="d-grid gap-2 d-md-flex justify-content-center">
						<button type="button" id="btn_preview_search_report_4" class="btn btn-warning btn-lg px-4">
							<i class="fas fa-eye me-2"></i> 
							<span class="fw-semibold">View Search Report</span>
						</button>
					</div>
					
					<!-- <small class="text-muted d-block mt-3">
						<i class="fas fa-exclamation-circle me-1"></i>
						Note: Any unsaved changes will not appear in the preview.
					</small> -->
				</div>
			</div>
			
			<div class="modal-footer bg-light">
				<button type="button" 
					class="btn btn-outline-danger"
					data-bs-dismiss="modal">
					<i class="fas fa-times me-2"></i>
					Close Preview
				</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade effect-scale modal-blur" id="update_motherfile_certificate_number" tabindex="-1"
     aria-labelledby="update_motherfile_certificate_number_label" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content border-0 shadow-lg">
        
        <!-- Modal Header -->
        <div class="modal-header bg-primary text-white">
           <h5 class="modal-title text-white" id="update_motherfile_certificate_number_label">
              <i class="fas fa-certificate me-2"></i>
              Update Motherfile Certificate Number
           </h5>
           <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        
        <!-- Modal Body -->
        <div class="modal-body">
            <!-- Form Fields -->
            <div class="mb-4">
                <label for="txt_lc_plan_no_pl_smd" class="form-label fw-medium">
                    <i class="fas fa-hashtag me-1"></i>
                    Certificate Number
                </label>
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-certificate"></i>
                    </span>
                    <c:choose>
                        <c:when test="${not empty certificate_number and certificate_number != 'null' and not fn:contains(certificate_number, '-')}">
                            <input type="text" class="form-control bg-light" id="lc_xxx_certificate_number" 
                                   value="${certificate_number}" readonly />
                            <span class="input-group-text text-success">
                                <i class="fas fa-check"></i>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <input type="text" class="form-control" id="lc_xxx_certificate_number" 
                                   value="${certificate_number}" placeholder="Enter certificate number" />
                        </c:otherwise>
                    </c:choose>
                </div>
                <small class="form-text text-muted mt-1">Unique identifier for the certificate</small>
            </div>
            
            <!-- Update Button -->
            <div class="mt-4">
                <button class="btn btn-primary w-100 py-3" id="lc_btn_generate_certificate_number">
                    <div class="d-flex align-items-center justify-content-center">
                        <div class="me-3">
                            <i class="fas fa-save fa-lg"></i>
                        </div>
                        <div class="text-start">
                            <div class="fw-medium">
                                <c:choose>
                                    <c:when test="${not empty certificate_number and certificate_number != 'null' and not fn:contains(certificate_number, '-')}">
                                        Update Certificate Number
                                    </c:when>
                                    <c:otherwise>
                                        Save Certificate Number
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- <small class="d-block opacity-75">Save all plan information</small> -->
                        </div>
                    </div>
                </button>
            </div>
            
            <!-- Help Text -->
            <div class="alert alert-light border mt-4">
                <div class="d-flex">
                    <i class="fas fa-lightbulb text-warning me-2 mt-1"></i>
                    <div>
                        <h6 class="alert-heading mb-2">Instructions</h6>
                        <p class="small mb-0">
                            Update the certificate number if the certificate number has not been created.
                        </p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Modal Footer -->
        <div class="modal-footer bg-light">
            <div class="d-flex justify-content-end w-100 align-items-center">
                <!-- <div class="text-muted small">
                    <i class="fas fa-history me-1"></i>
                    Last updated: <span id="planLastUpdated">
                        <c:choose>
                            <c:when test="${not empty plan_no and plan_no != 'null'}">Recently</c:when>
                            <c:otherwise>Never</c:otherwise>
                        </c:choose>
                    </span>
                </div> -->
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>
                        Close
                    </button>
                    <!-- <button type="button" class="btn btn-outline-info" id="btn_view_plan_preview">
                        <i class="fas fa-eye me-1"></i>
                        Preview
                    </button> -->
                </div>
            </div>
        </div>
     </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="update_case_volume_and_folio" tabindex="-1"
     aria-labelledby="update_case_volume_and_folio_label" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content border-0 shadow-lg">
        
        <!-- Modal Header -->
        <div class="modal-header bg-primary text-white">
           <h5 class="modal-title text-white" id="update_case_volume_and_folio_label">
              <i class="fas fa-certificate me-2"></i>
              Update Case Volume and Folio
           </h5>
           <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        
        <!-- Modal Body -->
        <div class="modal-body">
            <!-- Form Fields -->
            
            <div class="row g-3 mb-4">
                <div class="col-md-12">
                    <div class="form-group">
                    <label for="" class="form-label fw-medium">
                        <i class="fas fa-book me-1"></i>
                        Volume Number
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">
                        <i class="fas fa-hashtag"></i>
                        </span>
                        <c:choose>
                        <c:when test="${not empty volume_number and volume_number != 'null' and not fn:contains(volume_number, '-')}">
                            <input type="text" class="form-control bg-light" id="lc_txt_volume_number_" 
                                   value="${volume_number}" readonly />
                            <span class="input-group-text text-success">
                                <i class="fas fa-check"></i>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <input type="text" class="form-control" id="lc_txt_volume_number_" 
                                   value="${volume_number}" placeholder="Enter volume number" />
                        </c:otherwise>
                    </c:choose>
                    </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                    <label for="" class="form-label fw-medium">
                        <i class="fas fa-file-alt me-1"></i>
                        Folio Number
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">
                        <i class="fas fa-hashtag"></i>
                        </span>
                        <c:choose>
                        <c:when test="${not empty folio_number and folio_number != 'null' and not fn:contains(folio_number, '-')}">
                            <input type="text" class="form-control bg-light" id="lc_txt_folio_number_" 
                                   value="${folio_number}" readonly />
                            <span class="input-group-text text-success">
                                <i class="fas fa-check"></i>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <input type="text" class="form-control" id="lc_txt_folio_number_" 
                                   value="${folio_number}" placeholder="Enter folio number" />
                        </c:otherwise>
                    </c:choose>
                    </div>
                    </div>
                </div>
                </div>
            
            <!-- Update Button -->
            <div class="mt-4">
                <button class="btn btn-primary w-100 py-3" id="btn_save_lrd_certificate_update_details_">
                    <div class="d-flex align-items-center justify-content-center">
                        <div class="me-3">
                            <i class="fas fa-save fa-lg"></i>
                        </div>
                        <div class="text-start">
                            <div class="fw-medium">
                                <c:choose>
                                    <c:when test="${not empty volume_number and volume_number != 'null' and not fn:contains(volume_number, '-')}">
                                        Update Details
                                    </c:when>
                                    <c:otherwise>
                                        Save Details
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- <small class="d-block opacity-75">Save all plan information</small> -->
                        </div>
                    </div>
                </button>
            </div>
            
            <!-- Help Text -->
            <div class="alert alert-light border mt-4">
                <div class="d-flex">
                    <i class="fas fa-lightbulb text-warning me-2 mt-1"></i>
                    <div>
                        <h6 class="alert-heading mb-2">Instructions</h6>
                        <p class="small mb-0">
                            Update the volume and folio number if the volume and folio number has not been created.
                        </p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Modal Footer -->
        <div class="modal-footer bg-light">
            <div class="d-flex justify-content-end w-100 align-items-center">
                <!-- <div class="text-muted small">
                    <i class="fas fa-history me-1"></i>
                    Last updated: <span id="planLastUpdated">
                        <c:choose>
                            <c:when test="${not empty plan_no and plan_no != 'null'}">Recently</c:when>
                            <c:otherwise>Never</c:otherwise>
                        </c:choose>
                    </span>
                </div> -->
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>
                        Close
                    </button>
                    <!-- <button type="button" class="btn btn-outline-info" id="btn_view_plan_preview">
                        <i class="fas fa-eye me-1"></i>
                        Preview
                    </button> -->
                </div>
            </div>
        </div>
     </div>
  </div>
</div>

 
<div class="modal fade effect-scale modal-blur" id="update_case_date_of_issue" tabindex="-1"
     aria-labelledby="update_case_date_of_issue_label" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content border-0 shadow-lg">
        
        <!-- Modal Header -->
        <div class="modal-header bg-primary text-white">
           <h5 class="modal-title text-white" id="update_case_date_of_issue_label">
              <i class="fas fa-calendar me-2"></i>
              Update Case Date of Issue
           </h5>
           <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        
        <!-- Modal Body -->
        <div class="modal-body">
            <!-- Form Fields -->
            <div class="mb-4">
                <label for="txt_lc_plan_no_pl_smd" class="form-label fw-medium">
                    <i class="fas fa-hashtag me-1"></i>
                    Date of Issue
                </label>
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-calendar"></i>
                    </span>
                    <c:choose>
                        <c:when test="${not empty date_of_issue and date_of_issue != 'null' and not fn:contains(date_of_issue, '-')}">
                            <input type="date" class="form-control bg-light" id="lc_txt_date_of_issue" 
                                   value="${date_of_issue}" readonly />
                            <span class="input-group-text text-success">
                                <i class="fas fa-check"></i>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <input type="date" class="form-control" id="lc_txt_date_of_issue" 
                                   value="${date_of_issue}" placeholder="Enter date of issue" />
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- <small class="form-text text-muted mt-1">Unique identifier for the certificate</small> -->
            </div>
            
            <!-- Update Button -->
            <div class="mt-4">
                <button class="btn btn-primary w-100 py-3" id="lc_btn_update_date_of_issue">
                    <div class="d-flex align-items-center justify-content-center">
                        <div class="me-3">
                            <i class="fas fa-save fa-lg"></i>
                        </div>
                        <div class="text-start">
                            <div class="fw-medium">
                                <c:choose>
                                    <c:when test="${not empty date_of_issue and date_of_issue != 'null' and not fn:contains(date_of_issue, '-')}">
                                        Update Date
                                    </c:when>
                                    <c:otherwise>
                                        Save Date
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- <small class="d-block opacity-75">Save all plan information</small> -->
                        </div>
                    </div>
                </button>
            </div>
            
            <!-- Help Text -->
            <div class="alert alert-light border mt-4">
                <div class="d-flex">
                    <i class="fas fa-lightbulb text-warning me-2 mt-1"></i>
                    <div>
                        <h6 class="alert-heading mb-2">Instructions</h6>
                        <p class="small mb-0">
                            Update the date of issue if the date of issue has not been created.
                        </p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Modal Footer -->
        <div class="modal-footer bg-light">
            <div class="d-flex justify-content-end w-100 align-items-center">
                <!-- <div class="text-muted small">
                    <i class="fas fa-history me-1"></i>
                    Last updated: <span id="planLastUpdated">
                        <c:choose>
                            <c:when test="${not empty plan_no and plan_no != 'null'}">Recently</c:when>
                            <c:otherwise>Never</c:otherwise>
                        </c:choose>
                    </span>
                </div> -->
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>
                        Close
                    </button>
                    <!-- <button type="button" class="btn btn-outline-info" id="btn_view_plan_preview">
                        <i class="fas fa-eye me-1"></i>
                        Preview
                    </button> -->
                </div>
            </div>
        </div>
     </div>
  </div>
</div>

<!-- Generate Interest Number Modal -->
<div class="modal fade effect-scale modal-blur" id="generate_interest_number" tabindex="-1"
     aria-labelledby="generateInterestNumberLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-md">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="generateInterestNumberLabel">
          <i class="fas fa-hashtag me-2"></i>
          Generate Interest Number
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Information Alert -->
        <div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>Interest Number Generation</strong>
              <p class="mb-0 mt-2">Click generate to create a unique interest number for this record.</p>
            </div>
          </div>
        </div>
        
        <!-- Interest Number Field -->
        <div class="mb-4">
          <label for="lc_txt_interest_number" class="form-label fw-medium">
            <i class="fas fa-hashtag me-1"></i>
            Interest Number
          </label>
          <div class="input-group">
            <span class="input-group-text bg-light">
              <i class="fas fa-tag"></i>
            </span>
            <input type="text" class="form-control bg-light" 
                   id="lc_txt_interest_number" readonly 
                   value="${interest_number}"
                   placeholder="Will be generated">
          </div>
          <div class="form-text">
            <i class="fas fa-lock me-1"></i>
            Auto-generated interest number for this record
          </div>
        </div>
        
        <!-- Generate Button -->
        <div class="mt-4">
          <button type="button" id="lc_btn_generate_interest_number" 
                  class="btn btn-primary w-100 py-3"
                  <c:if test="${not empty interest_number and interest_number ne 'null'}">disabled</c:if>>
            <i class="fas fa-magic me-2"></i>
            Generate Interest Number
          </button>
          <div class="form-text mt-2 text-center">
            <c:if test="${not empty interest_number and interest_number ne 'null'}">
              <i class="fas fa-check-circle text-success me-1"></i>
              <span class="text-success">Interest number already generated</span>
            </c:if>
            <c:if test="${empty interest_number or interest_number eq 'null'}">
              <i class="fas fa-lightbulb text-warning me-1"></i>
              <span class="text-warning">Click to generate a new interest number</span>
            </c:if>
          </div>
        </div>
        
        <!-- Information Section -->
        <div class="alert alert-light border mt-4">
          <h6 class="mb-3">
            <i class="fas fa-lightbulb text-primary me-2"></i>
            About Interest Numbers
          </h6>
          <p class="small mb-0">
            Interest numbers are unique identifiers used to track ownership interests in land records. 
            Once generated, they cannot be changed and serve as a permanent reference for this interest record.
          </p>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<!-- Generate Sub Interest Number Modal -->
<div class="modal fade effect-scale modal-blur" id="generate_sub_interest_number" tabindex="-1"
     aria-labelledby="generateSubInterestNumberLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-md">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="generateSubInterestNumberLabel">
          <i class="fas fa-hashtag me-2"></i>
          Generate Sub Interest Number
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Information Alert -->
        <div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>Sub Interest Number Generation</strong>
              <p class="mb-0 mt-2">Click generate to create a unique sub interest number for this record.</p>
            </div>
          </div>
        </div>
        
        <!-- Sub Interest Number Field -->
        <div class="mb-4">
          <label for="lc_txt_sub_interest_number" class="form-label fw-medium">
            <i class="fas fa-hashtag me-1"></i>
            Sub Interest Number
          </label>
          <div class="input-group">
            <span class="input-group-text bg-light">
              <i class="fas fa-tags"></i>
            </span>
            <input type="text" class="form-control bg-light" 
                   id="lc_txt_sub_interest_number" readonly 
                   value="${sub_interest_number}"
                   placeholder="Will be generated">
          </div>
          <div class="form-text">
            <i class="fas fa-lock me-1"></i>
            Auto-generated sub interest number for this record
          </div>
        </div>
        
        <!-- Generate Button -->
        <div class="mt-4">
          <button type="button" id="lc_btn_generate_sub_interest_number" 
                  class="btn btn-primary w-100 py-3"
                  <c:if test="${not empty sub_interest_number and sub_interest_number ne 'null'}">disabled</c:if>>
            <i class="fas fa-magic me-2"></i>
            Generate Sub Interest Number
          </button>
          <div class="form-text mt-2 text-center">
            <c:if test="${not empty sub_interest_number and sub_interest_number ne 'null'}">
              <i class="fas fa-check-circle text-success me-1"></i>
              <span class="text-success">Sub interest number already generated</span>
            </c:if>
            <c:if test="${empty sub_interest_number or sub_interest_number eq 'null'}">
              <i class="fas fa-lightbulb text-warning me-1"></i>
              <span class="text-warning">Click to generate a new sub interest number</span>
            </c:if>
          </div>
        </div>
        
        <!-- Information Section -->
        <div class="alert alert-light border mt-4">
          <h6 class="mb-3">
            <i class="fas fa-lightbulb text-primary me-2"></i>
            About Sub Interest Numbers
          </h6>
          <p class="small mb-0">
            Sub interest numbers are used to identify secondary or partial interests within a primary interest. 
            They help track complex ownership structures and ensure accurate record-keeping for subdivided interests.
          </p>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="ground_rent" tabindex="-1"
     aria-labelledby="ground_rent_label" aria-hidden="true" data-bs-backdrop="static">
     <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="ground_rent_label">
                    <i class="fas fa-money-bill-wave me-2"></i>
                    Ground Rent Management
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Current Status Card -->
                <div class="card border-warning border mb-4">
                    <div class="card-header bg-light-warning py-3">
                        <h6 class="mb-0 d-flex align-items-center">
                            <i class="fas fa-chart-line text-warning me-2"></i>
                            Current Ground Rent Status
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="avatar-sm bg-light-warning rounded-circle d-flex align-items-center justify-content-center me-3">
                                <i class="fas fa-dollar-sign text-warning"></i>
                            </div>
                            <div class="flex-grow-1">
                                <label class="form-label fw-medium mb-1">Current Amount</label>
                                <div class="d-flex align-items-center">
                                    <c:choose>
                                        <c:when test="${not empty ground_rent and ground_rent != 'null' and not fn:contains(ground_rent, '-')}">
                                            <h4 class="text-success mb-0">${ground_rent}</h4>
                                            <span class="badge bg-success ms-2">
                                                <i class="fas fa-check-circle me-1"></i> Set
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-danger">
                                                <i class="fas fa-exclamation-triangle me-1"></i>
                                                <span class="fw-medium">Not Set</span>
                                            </div>
                                            <span class="badge bg-warning ms-2">Pending</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Instructions -->
                <div class="alert alert-warning border-warning bg-warning bg-opacity-10 mb-4">
                    <div class="d-flex">
                        <div class="me-3">
                            <i class="fas fa-info-circle fa-lg text-warning"></i>
                        </div>
                        <div>
                            <h6 class="alert-heading mb-2">Ground Rent Information</h6>
                            <p class="small mb-0">
                                Enter the ground rent amount for this property. Once set, it cannot be updated unless the status is cleared.
                            </p>
                        </div>
                    </div>
                </div>
                
                <!-- Ground Rent Input Section -->
                <div class="mb-4">
                    <label for="lc_txt_ground_rent" class="form-label fw-medium">
                        <i class="fas fa-edit me-1 text-primary"></i>
                        Ground Rent Amount
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-money-bill text-muted"></i>
                        </span>
                        <c:choose>
                            <c:when test="${not empty ground_rent and ground_rent != 'null' and not fn:contains(ground_rent, '-')}">
                                <input type="text" class="form-control bg-light" 
                                       id="lc_txt_ground_rent" 
                                       value="${ground_rent}"
                                       style="cursor: not-allowed"
                                       readonly
                                       placeholder="Ground rent amount (e.g., 5000.00)" />
                            </c:when>
                            <c:otherwise>
                                <input type="text" class="form-control" 
                                       id="lc_txt_ground_rent" 
                                       value="${ground_rent}"
                                       placeholder="Enter ground rent amount (e.g., 5000.00)" />
                            </c:otherwise>
                        </c:choose>
                        <span class="input-group-text bg-light">
                            <span class="text-muted small">Per Annum</span>
                        </span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mt-2">
                        <small class="form-text text-muted">
                            <i class="fas fa-info-circle me-1"></i>
                            Enter the annual ground rent amount
                        </small>
                        <c:if test="${not empty ground_rent and ground_rent != 'null' and not fn:contains(ground_rent, '-')}">
                            <span class="badge bg-info">
                                <i class="fas fa-lock me-1"></i> Locked
                            </span>
                        </c:if>
                    </div>
                </div>

                <hr class="text-muted my-4">
                
                <!-- Update Button -->
                <div class="mb-3">
                    <button class="btn btn-primary w-100 py-3" 
                            id="lc_btn_generate_ground_rent_only"
                            <c:if test="${not empty ground_rent and ground_rent != 'null' and not fn:contains(ground_rent, '-')}">
                                disabled
                            </c:if>>
                        <div class="d-flex align-items-center justify-content-center">
                            <div class="me-3">
                                <i class="fas fa-sync-alt fa-lg"></i>
                            </div>
                            <div class="text-start">
                                <div class="fw-medium">Update Ground Rent</div>
                                <small class="d-block opacity-75">
                                    <c:choose>
                                        <c:when test="${not empty ground_rent and ground_rent != 'null' and not fn:contains(ground_rent, '-')}">
                                            <span class="text-warning">
                                                <i class="fas fa-lock me-1"></i> Amount already set
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            Save and update ground rent amount
                                        </c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                        </div>
                    </button>
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <!-- <i class="fas fa-calendar me-1"></i>
                        <span id="currentDateDisplay"></span> -->
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
     </div>
</div>


<div class="modal fade effect-scale modal-blur map-modal" id="add_new_records_Info_frrv" tabindex="-1" aria-labelledby="add_new_records_Info_frrvLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered  modal-fullscreen modal-dialog-scrollable">
    <div class="modal-content border-0 shadow-lg">
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <div class="d-flex align-items-center w-100">
          <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
            <i class="bi bi-card-text fs-4"></i>
          </div>
          <div class="flex-grow-1">
            <h5 class="modal-title text-white mb-1" id="add_new_records_Info_frrvLabel">
              Records Information
            </h5>
            <p class="mb-0 small opacity-75">
              <i class="bi bi-info-circle me-1"></i>
              Upload and manage parcel coordinates
            </p>
          </div>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>

      <!-- Modal Body -->
      <div class="modal-body p-4">
        <div class="row">
          <div class="col-md-6">
        <form action="${pageContext.request.contextPath}/processing_after_payment" method="post" id="parcelForm">
          <!-- WKT Polygon Input -->
          <div class="card border mb-4">
            <div class="card-header bg-light">
              <h6 class="mb-0 fw-semibold">
                <i class="bi bi-polygon me-2"></i>WKT Polygon Data
              </h6>
            </div>
            <div class="card-body">
              <div class="mb-0">
                <label for="lc_bl_wkt_polygon_2" class="form-label fw-semibold">
                  <i class="bi bi-code-slash me-2"></i>WKT Polygon
                </label>
                <div class="input-group">
                  <textarea class="form-control font-monospace" id="lc_bl_wkt_polygon_2" 
                            name="lc_bl_wkt_polygon" rows="3" 
                            placeholder="POLYGON((...))" readonly style="cursor: not-allowed;">${parcel_wkt}</textarea>
                  <button class="btn btn-outline-secondary" type="button" 
                          data-bs-toggle="tooltip" data-bs-placement="top" 
                          title="Copy to clipboard" onclick="copyWktToClipboard('lc_bl_wkt_polygon_2')">
                    <i class="bi bi-clipboard"></i>
                  </button>
                </div>
                <div class="form-text">
                  <i class="bi bi-info-circle me-1"></i>
                  Well-Known Text representation of the polygon
                </div>
              </div>
            </div>
          </div>

          <!-- Map Tools Section -->
          <div class="card border mb-4">
            <div class="card-header bg-light">
              <h6 class="mb-0 fw-semibold">
                <i class="bi bi-tools me-2"></i>Map Tools
              </h6>
            </div>
            <div class="card-body">
              <div class="d-flex flex-wrap gap-2 mb-3">
                <!-- Visualization Tools -->
                <button type="button" class="btn btn-primary btn-sm" 
                        id="lc_btn_visualise_wkt"
                        data-bs-toggle="tooltip" data-bs-placement="top" 
                        title="Visualize Polygon">
                  <i class="bi bi-eye me-1"></i> View WKT
                </button>

                <!-- <button type="button" class="btn btn-info btn-sm" 
                        id="lc_btn_visualise_search"
                        data-bs-toggle="tooltip" data-bs-placement="top" 
                        title="Plot Parcels">
                  <i class="bi bi-layers me-1"></i> Plot Parcels
                </button>

                <button type="button" class="btn btn-warning btn-sm" 
                        id="lc_btnprintmap"
                        data-bs-toggle="tooltip" data-bs-placement="top" 
                        title="Print Map">
                  <i class="bi bi-printer me-1"></i> Print
                </button> -->

                <!-- Scale Controls -->
                <div class="d-flex align-items-center ms-auto">
                  <label class="form-label me-2 mb-0 fw-medium">
                    <i class="bi bi-zoom-in me-1"></i>Scale:
                  </label>
                  <div class="input-group input-group-sm" style="width: 200px;">
                    <input type="text" class="form-control" id="lc_scale_value_e" 
                           placeholder="Custom scale">
                    <select class="form-select" data-trigger id="lc_scale_value" style="width: 100px;">
                      <option value="500">500</option>
                      <option value="1107">1107</option>
                      <option value="1250">1250</option>
                      <option value="2500" selected>2500</option>
                      <option value="2140">2140</option>
                      <option value="2670">2670</option>
                      <option value="2215">2215</option>
                      <option value="2825">2825</option>
                      <option value="5000">5000</option>
                      <option value="10000">10000</option>
                      <option value="15000">15000</option>
                      <option value="20000">20000</option>
                    </select>
                  </div>
                </div>

                <!-- Scale Lock -->
                <div class="d-flex align-items-center ms-2">
                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" 
                           id="lc_lockmapscale" checked>
                    <label class="form-check-label small" for="lc_lockmapscale">
                      Lock Scale
                    </label>
                  </div>
                  <button type="button" class="btn btn-outline-secondary btn-sm ms-2" 
                          id="lc_btn_scale_zoom"
                          data-bs-toggle="tooltip" data-bs-placement="top" 
                          title="Zoom to Scale">
                    <i class="bi bi-search"></i>
                  </button>
                </div>
              </div>
            </div>
          </div>

          <!-- Map Container -->
          <div class="card border mb-4">
            <div class="card-header bg-light d-flex justify-content-between align-items-center">
              <h6 class="mb-0 fw-semibold">
                <i class="bi bi-globe me-2"></i>Map Preview
              </h6>
              <small class="text-muted">
                <i class="bi bi-arrows-fullscreen me-1"></i>Click and drag to navigate
              </small>
            </div>
            <div class="card-body p-0">
              <div class="map-container" id="lc-map_2" style="height: 400px;"></div>
            </div>
          </div>

          <!-- Coordinate Management -->
          <div class="card border">
            <div class="card-header bg-light">
              <h6 class="mb-0 fw-semibold">
                <i class="bi bi-geo me-2"></i>Coordinate Management
              </h6>
            </div>
            <div class="card-body">
              <!-- Action Buttons -->
              <div class="d-flex flex-wrap gap-2 mb-4">
                <button type="button" class="btn btn-primary btn-sm" 
                        id="lc_btn_add_coordinate_2"
                        data-bs-placement="top" data-bs-title="Add Coordinate">
                  <i class="bi bi-plus-circle me-1"></i> Add Coordinate
                </button>

                <button type="button" class="btn btn-success btn-sm" 
                        id="lrd_btn_add_coordinate_by_csv_2"
                        data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv"
                        data-bs-placement="top" data-bs-title="Upload CSV">
                  <i class="bi bi-upload me-1"></i> Upload CSV
                </button>

                <button type="button" class="btn btn-info btn-sm" 
                        id="lc_btn_visualise_coordinate_gf_2"
                        data-bs-placement="top" data-bs-title="Visualize Polygon">
                  <i class="bi bi-eye me-1"></i> Visualize
                </button>

                <button type="button" class="btn btn-warning btn-sm" 
                        id="btn_lc_save_parcel_for_search"
                        data-bs-placement="top" data-bs-title="Save Parcel">
                  <i class="bi bi-save me-1"></i> Save Parcel
                </button>

                <button type="button" class="btn btn-outline-danger btn-sm ms-auto" 
                        id="btn_clear_all_coordinates_2"
                        data-bs-placement="top" data-bs-title="Clear All">
                  <i class="bi bi-trash me-1"></i> Clear All
                </button>
              </div>

              <!-- Coordinates Table -->
              <div class="table-responsive">
                <table class="table table-hover table-sm" id="coordinatelis_Table_2">
                  <thead class="table-light">
                    <tr>
                      <th width="30%">
                        <i class="bi bi-tag me-1"></i>Coordinate Name
                      </th>
                      <th width="25%">
                        <i class="bi bi-arrow-right me-1"></i>X Coordinate
                      </th>
                      <th width="25%">
                        <i class="bi bi-arrow-up me-1"></i>Y Coordinate
                      </th>
                      <th width="20%" class="text-center">
                        <i class="bi bi-gear me-1"></i>Actions
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    <!-- Data will be inserted dynamically -->
                    <tr id="noCoordinatesRow_2">
                      <td colspan="4" class="text-center py-4">
                        <div class="text-muted">
                          <i class="bi bi-geo fs-1 mb-2 d-block"></i>
                          <p class="mb-0">No coordinates added</p>
                          <small>Click "Add Coordinate" or "Upload CSV" to get started</small>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </form>
        </div>
        <div class="col-md-6">
            <div class="card card-body">
                <div class="table-responsive">
                    <div class="pb-4">
                        <button class="btn btn-warning label-btn float-end" id="add_records_information_notes"> 
                            <i class="ri-add-circle-line label-btn-icon me-2"></i> Add New Records Information Notes 
                        </button>
                    </div>
                    <table class="table table-hover mb-0 pt-4" id="lrd_notes_dataTable">
                        <thead class="table-light">
                            <tr>
                                <th>Records Info.</th>
                                <th>Entered By</th>
                                <th>Entered Date</th>
                                <th>Division</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${application_notes}" var="application_notes_row">
                            <tr class="${application_notes_row.an_status == false ? 'table-danger' : ''}" 
                                ${application_notes_row.an_status == false ? "data-bs-toggle='tooltip' data-bs-placement='top' title='Note has been disabled'" : ""}>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-comment text-muted me-2"></i>
                                        <span class="text-truncate" style="max-width: 200px;">
                                            ${application_notes_row.an_description}
                                        </span>
                                        ${application_notes_row.an_status == false ? 
                                            '<span class="badge bg-danger ms-2">Disabled</span>' : ''}
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-user-circle text-muted me-2"></i>
                                        <span>${application_notes_row.created_by}</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-calendar-alt text-muted me-2"></i>
                                        <span>${application_notes_row.created_date}</span>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-secondary bg-opacity-10 text-dark">
                                        ${application_notes_row.division}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-outline-primary btn-sm viewNotesModal" 
                                            data-target-id="${application_notes_row.an_id}"
                                            data-an_description="${application_notes_row.an_description}"
                                            data-created_by="${application_notes_row.created_by}"
                                            data-created_date="${application_notes_row.created_date}"
                                            data-modified_by="${application_notes_row.created_by}"
                                            data-modified_date="${application_notes_row.created_date}"
                                            data-division="${application_notes_row.division}"
                                            ${application_notes_row.an_status == false ? "disabled" : ""}>
                                        <i class="fas fa-eye me-1"></i>
                                        View
                                    </button>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer bg-light">
        <div class="d-flex justify-content-between w-100 align-items-center">
          <div>
            <small class="text-muted">
              <i class="bi bi-info-circle me-1"></i>
              <span id="coordinateSummary">No coordinates added</span>
            </small>
          </div>
          <div>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
              <i class="bi bi-x-circle me-1"></i>Close
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="newValuationModal" tabindex="-1" aria-labelledby="newValuationModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="newValuationModalLabel">
                    <i class="fas fa-money-bill-wave me-2"></i>
                    Valuation Section
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <form id="form_add_valuation">
                    
                    <!-- Hidden Fields -->
                    <input type="hidden" id="vs_id" name="vs_id" value="0">
                    
                    <!-- Form Content -->
                    <div class="row g-4" style="height: 100vh;">
                        
                        <!-- Left Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">

                          <div class="row g-4">
                            <div class="col-lg-6">
                              <!-- Case Number -->
                               <div class="mb-3">
                                  <label for="es_case_number" class="form-label fw-medium">
                                      <i class="fas fa-hashtag me-1"></i>
                                      Case Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-folder"></i>
                                      </span>
                                      <input type="text" name="es_case_number" id="vs_case_number" 
                                            class="form-control" required readonly value="${case_number}">
                                  </div>
                              </div>

                              <!-- Remarks -->
                            <div class="mb-3">
                                <label for="vs_remarks" class="form-label fw-medium">
                                    <i class="fas fa-sticky-note me-1"></i>
                                    Remarks
                                </label>
                                <textarea name="vs_remarks" id="vs_remarks" 
                                            class="form-control" rows="3" required
                                            placeholder="Additional remarks or notes"></textarea>
                                <div class="form-text">Internal notes or observations</div>
                            </div>
                              
                             

                            </div>

                            <div class="col-lg-6">
                              <!-- Date of Valuation -->
                              <div class="mb-3">
                                  <label for="vs_date_of_valuation" class="form-label fw-medium">
                                      <i class="fas fa-calendar-check me-1"></i>
                                     Date of Valuation
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-hashtag"></i>
                                      </span>
                                      <input type="date" name="vs_date_of_valuation" id="vs_date_of_valuation" 
                                            class="form-control" required>
                                  </div>
                              </div>
                              
                              <!-- Amount -->
                              <div class="mb-3">
                                  <label for="es_entry_number" class="form-label fw-medium">
                                      <i class="fas fa-fa-money-bill-wave me-1"></i>
                                      Amount
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-sort-numeric-up"></i>
                                      </span>
                                      <input type="number" name="vs_amount" id="vs_amount" 
                                            class="form-control" required>
                                  </div>
                              </div>
                              
                            </div>
                          </div>

                          <!-- Buttons moved to left column -->
                          <div class="border-top bg-light p-3 rounded" style="margin-top: auto !important;">
                              <div class="d-flex justify-content-between align-items-center">
                                  <div>
                                      <button type="button" class="btn btn-outline-danger btn_reg_root_delete_action" 
                                              data-action_type='encumbrances' style="display: none;">
                                          <i class="fas fa-trash me-1"></i>
                                          Delete
                                      </button>
                                  </div>
                                  <div class="d-flex gap-2">
                                      <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                          <i class="fas fa-times me-1"></i>
                                          Cancel
                                      </button>
                                      <button type="submit" id="btn_valution_section" class="btn btn-danger">
                                          <i class="fas fa-save me-1"></i>
                                          Save Valuation
                                      </button>
                                  </div>
                              </div>
                          </div>
                        </div>
                        
                        <!-- Right Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">
                            <div class="_gated_workflow_documents"></div>
                        </div>
                        
                    </div>
                    
                </form>
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="enter_assessed_value_and_duty_payable" tabindex="-1" 
     aria-labelledby="assessedValueModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content shadow-lg border-0">
            
            <!-- Modal Header - Modern Design -->
            <div class="modal-header bg-primary text-white border-0 py-3">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-white bg-opacity-20 px-3 py-3 me-3">
                        <i class="fas fa-calculator text-primary"></i>
                    </div>
                    <div>
                        <h5 class="modal-title fw-bold  text-white" id="assessedValueModalLabel">
                            Enter Assessed Value & Duty Payable
                        </h5>
                        <p class="text-white-50 small mb-0">Stamp duty assessment and valuation</p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- Comparable Data Card -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-white border-0 pt-3 pb-0">
                        <div class="d-flex align-items-center">
                            <div class="bg-warning p-2 rounded-circle me-2">
                                <i class="fas fa-chart-line text-dark"></i>
                            </div>
                            <h6 class="fw-bold mb-0 text-dark">
                                Comparable Data Analysis
                            </h6>
                            <span class="badge bg-light text-dark ms-2 px-3 py-2">
                                <i class="fas fa-info-circle me-1"></i> Market Reference
                            </span>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- Alert Display Space -->
                        <div id="alert-display-space" class="mb-3"></div>
                        
                        <form id="form_comparable" method="post" class="needs-validation" novalidate>
                            <!-- Land Development Status -->
                            <div class="row g-3 align-items-end mb-4">
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold text-muted small text-uppercase">
                                        <i class="fas fa-tree me-1"></i> Land Development
                                    </label>
                                </div>
                                <div class="col-md-8">
                                    <div class="btn-group w-100" role="group" aria-label="Land development status">
                                        <input type="radio" class="btn-check" name="land_state" id="land_yes" value="YES" autocomplete="off">
                                        <label class="btn btn-outline-primary rounded-start-3" for="land_yes">
                                            <i class="fas fa-check-circle me-2"></i> Yes - Developed
                                        </label>
                                        
                                        <input type="radio" class="btn-check" name="land_state" id="land_no" value="NO" autocomplete="off">
                                        <label class="btn btn-outline-primary rounded-end-3" for="land_no">
                                            <i class="fas fa-times-circle me-2"></i> No - Undeveloped
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Comparable Section (Hidden by default) -->
                            <div id="comparable_section_display" style="display: none;">
                                <div class="bg-light bg-opacity-50 rounded-3 p-4">
                                    <div class="row g-4">
                                        <!-- Locality/Land Size -->
                                        <div class="col-12">
                                            <label class="form-label fw-semibold text-muted small text-uppercase mb-2">
                                                <i class="fas fa-map-marker-alt me-1"></i> Locality / Land Size
                                            </label>
                                            <div class="d-flex gap-2">
                                                <div class="flex-grow-1">
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-white border-end-0">
                                                            <i class="fas fa-location-dot text-muted"></i>
                                                        </span>
                                                        <input type="text" class="form-control border-start-0 ps-0" 
                                                               id="new_comparable_locality" value="${locality}" 
                                                               placeholder="Locality" readonly>
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-white border-end-0">
                                                            <i class="fas fa-vector-square text-muted"></i>
                                                        </span>
                                                        <input type="text" class="form-control border-start-0 ps-0" 
                                                               id="new_comparable_size_of_land" value="${size_of_land}" 
                                                               placeholder="Size (acres)" readonly>
                                                    </div>
                                                </div>
                                                <div>
                                                    <button type="button" class="btn btn-warning h-100 px-4" 
                                                            id="btn_load_comparable_values">
                                                        <i class="fas fa-download me-2"></i> Load
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Max Value -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold text-muted small text-uppercase mb-2">
                                                <i class="fas fa-arrow-up me-1"></i> Maximum Value
                                            </label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-white">
                                                    <span class="fw-semibold text-success">GHS</span>
                                                </span>
                                                <input type="number" step="0.01" class="form-control border-start-0 ps-0" 
                                                       id="txt_comp_max_value" name="txt_comp_max_value" 
                                                       placeholder="0.00" required>
                                                <span class="input-group-text bg-white border-start-0">
                                                    <i class="fas fa-chevron-up text-success"></i>
                                                </span>
                                            </div>
                                            <div class="form-text">
                                                <i class="fas fa-info-circle text-muted me-1"></i> Highest comparable value
                                            </div>
                                        </div>
                                        
                                        <!-- Min Value -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold text-muted small text-uppercase mb-2">
                                                <i class="fas fa-arrow-down me-1"></i> Minimum Value
                                            </label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-white">
                                                    <span class="fw-semibold text-danger">GHS</span>
                                                </span>
                                                <input type="number" step="0.01" class="form-control border-start-0 ps-0" 
                                                       id="txt_comp_min_value" name="txt_comp_min_value" 
                                                       placeholder="0.00" required>
                                                <span class="input-group-text bg-white border-start-0">
                                                    <i class="fas fa-chevron-down text-danger"></i>
                                                </span>
                                            </div>
                                            <div class="form-text">
                                                <i class="fas fa-info-circle text-muted me-1"></i> Lowest comparable value
                                            </div>
                                        </div>
                                        
                                        <!-- Value Range Indicator (Hidden initially) -->
                                        <div class="col-12" id="label" style="display: none;">
                                            <div class="alert alert-info bg-info bg-opacity-10 border-info mb-0">
                                                <div class="d-flex align-items-center">
                                                    <i class="fas fa-sliders-h me-3 fa-lg"></i>
                                                    <div>
                                                        <strong>Value Range Selection</strong>
                                                        <p class="mb-0 text-muted">Please slide to select appropriate value range</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="assesedvalueRange" class="col-12"></div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Stamp Duty Assessment Card -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white border-0 pt-3 pb-0">
                        <div class="d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <div class="bg-primary p-2 rounded-circle me-2">
                                    <i class="fas fa-stamp text-white"></i>
                                </div>
                                <h6 class="fw-bold mb-0 text-dark">
                                    Stamp Duty Assessment
                                </h6>
                                <span class="badge bg-primary bg-opacity-10 text-primary ms-2 px-3 py-2">
                                    <i class="fas fa-calculator me-1"></i> Computation
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <form id="form_assessment" method="post" class="needs-validation" novalidate>
                            
                            <!-- Consideration & Currency Row -->
                            <div class="bg-gradient-secondary bg-opacity-10 rounded-3 p-4 mb-4">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold text-muted small text-uppercase">
                                            <i class="fas fa-hand-holding-usd me-1"></i> Consideration Fee
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white fw-bold">
                                                ${consideration_fee_currency}
                                            </span>
                                            <input type="number" class="form-control bg-white" 
                                                   value="${consideration_fee}" step="0.01" 
                                                   placeholder="0.00" readonly>
                                            <span class="input-group-text bg-light border-start-0 text-muted">
                                                <i class="fas fa-lock"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold text-muted small text-uppercase">
                                            <i class="fas fa-exchange-alt me-1"></i> Currency Rate
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white">
                                                <i class="fas fa-percent"></i>
                                            </span>
                                            <input type="number" step="0.0001" class="form-control" 
                                                   id="considertion_fee_adopted_rate" name="considertion_fee_adopted_rate"
                                                   value="${considertion_fee_adopted_rate}" 
                                                   placeholder="Exchange rate" required>
                                            <span class="input-group-text bg-white">
                                                <i class="fas fa-edit text-primary"></i>
                                            </span>
                                        </div>
                                        <div class="form-text">
                                            <i class="fas fa-info-circle me-1"></i> Bank of Ghana rate
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Assessment Values -->
                            <div class="row g-4 mb-4">
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold text-muted small text-uppercase">
                                        <i class="fas fa-check-circle me-1"></i> Adopted Value (Per Acre)
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white">GHS</span>
                                        <input type="number" step="0.01" class="form-control" 
                                               id="adopted_value" name="adopted_value" 
                                               placeholder="0.00" required>
                                        <span class="input-group-text bg-white border-start-0">
                                            <i class="fas fa-check text-success"></i>
                                        </span>
                                    </div>
                                    <div class="form-text">
                                        <i class="fas fa-tag me-1"></i> Adopted comparable value
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold text-muted small text-uppercase">
                                        <i class="fas fa-calculator me-1"></i> Assessed Value
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white">GHS</span>
                                        <input type="number" step="0.01" class="form-control" 
                                               id="assessed_value" name="assessed_value" 
                                               value="${assessed_value}" placeholder="0.00" required>
                                        <span class="input-group-text bg-white border-start-0">
                                            <i class="fas fa-edit"></i>
                                        </span>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold text-muted small text-uppercase">
                                        <i class="fas fa-hand-holding-usd me-1"></i> Stamp Duty Payable
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white">GHS</span>
                                        <input type="number" step="0.01" class="form-control fw-bold text-success" 
                                               id="stamp_duty" name="stamp_duty" 
                                               value="${stamp_duty_payable}" placeholder="0.00" required>
                                        <span class="input-group-text bg-white border-start-0">
                                            <i class="fas fa-file-invoice-dollar text-success"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <!-- Comments Section -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <label class="form-label fw-semibold text-muted small text-uppercase">
                                        <i class="fas fa-comment me-1"></i> Assessment Comments
                                    </label>
                                    <textarea class="form-control" id="assessed_comment" name="assessed_comment" 
                                              rows="3" placeholder="Enter any additional remarks or observations...">${stamp_duty_description}</textarea>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle me-1"></i> Provide justification for the assessed value
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <button type="submit" name="submit_assessment" id="submit_assessment" 
                                            class="btn btn-primary w-100 py-3 fw-semibold">
                                        <i class="fas fa-save me-2"></i> Save Assessment
                                        <!-- <span class="badge bg-white text-primary ms-2">Ctrl+S</span> -->
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex gap-2">
                                        <button type="button" name="submit_print_stamp_bill" id="submit_print_stamp_bill" 
                                                class="btn btn-warning flex-grow-1 py-3 fw-semibold">
                                            <i class="fas fa-print me-2"></i> Print Bill
                                        </button>
                                        <!-- <button type="button" class="btn btn-outline-secondary px-4" 
                                                data-bs-dismiss="modal" aria-label="Close">
                                            <i class="fas fa-times me-2"></i> Cancel
                                        </button> -->
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer - Simplified -->
            <div class="modal-footer bg-light border-0 py-3">
                <div class="d-flex align-items-center justify-content-between w-100">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i> 
                        All amounts are in Ghana Cedis (GHS)
                    </div>
                    <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">
                        <i class="fas fa-times-circle me-2"></i> Close Window
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Inspection Site Notification Modal -->
<div class="modal fade modal-blur" id="inspection_of_site" tabindex="-1" aria-labelledby="inspectionOfSiteModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header - Gradient Background -->
            <div class="modal-header bg-primary text-white border-0 py-3">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-white bg-opacity-20 py-2 px-3 me-3">
                        <i class="fas fa-clipboard-check text-primary fa-2x"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white fw-bold" id="inspectionOfSiteModalLabel">
                            Schedule Site Inspection
                        </h5>
                        <p class="text-white-50 small mb-0">
                             Notify applicant for land/property inspection
                        </p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                
                <!-- Case/Application Summary Card -->
                <div class="card border-0 bg-light bg-gradient mb-4">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center justify-content-between mb-2">
                            <h6 class="fw-bold mb-0 text-dark">
                                <i class="fas fa-briefcase me-2 text-primary"></i>Application Details
                            </h6>
                            <span class="badge bg-warning px-3 py-2">
                                <i class="fas fa-clock me-1"></i> Pending Inspection
                            </span>
                        </div>
                        
                        <div class="row g-3 mt-2">
                            <div class="col-md-6">
                                <div class="d-flex align-items-start">
                                    <div class="bg-primary bg-opacity-10 rounded p-2 me-2">
                                        <i class="fas fa-file-invoice text-primary"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Case Number</small>
                                        <span class="fw-semibold small" id="inspection_case_number">${case_number}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex align-items-start">
                                    <div class="bg-info bg-opacity-10 rounded p-2 me-2">
                                        <i class="fas fa-briefcase text-info"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Job Number</small>
                                        <span class="fw-semibold small" id="inspection_job_number">${job_number}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex align-items-start">
                                    <div class="bg-success bg-opacity-10 rounded p-2 me-2">
                                        <i class="fas fa-user text-success"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Applicant Name</small>
                                        <span class="fw-semibold small" id="inspection_applicant_name">${ar_name}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex align-items-start">
                                    <div class="bg-warning bg-opacity-10 rounded p-2 me-2">
                                        <i class="fas fa-tag text-warning"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Application Type</small>
                                        <span class="fw-semibold small" id="inspection_app_type">${business_process_sub_name}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Main Notification Form -->
                <form id="inspectionNotificationForm" method="post" class="needs-validation" novalidate>
                    
                    <!-- Notification Message Section -->
                    <div class="card shadow-sm mb-4">
                        <div class="card-header bg-white border-0 pt-3 pb-0">
                            <div class="d-flex align-items-center">
                                <div class="bg-info bg-opacity-10 p-2 rounded-circle me-2">
                                    <i class="fas fa-envelope text-info"></i>
                                </div>
                                <h6 class="fw-bold mb-0">Notification Message</h6>
                                <!-- <span class="badge bg-light text-dark ms-2 px-3 py-2">
                                    <i class="fas fa-edit me-1"></i> Customize
                                </span> -->
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold text-muted small text-uppercase">
                                        <i class="fas fa-bell me-1"></i> Notification Method
                                    </label>
                                    <div class="d-flex gap-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="method_sms" checked>
                                            <label class="form-check-label" for="method_sms">
                                                <i class="fas fa-sms text-primary me-1"></i> SMS
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="method_email" checked>
                                            <label class="form-check-label" for="method_email">
                                                <i class="fas fa-envelope text-primary me-1"></i> Email
                                            </label>
                                        </div>
                                        <!-- <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="method_letter">
                                            <label class="form-check-label" for="method_letter">
                                                <i class="fas fa-file-alt text-primary me-1"></i> Letter
                                            </label>
                                        </div> -->
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <!-- <label class="form-label fw-semibold text-muted small text-uppercase">
                                        <i class="fas fa-exclamation-triangle me-1"></i> Priority Level
                                    </label>
                                    <select class="form-select" id="inspection_priority">
                                        <option value="normal" selected>Normal</option>
                                        <option value="urgent">Urgent</option>
                                        <option value="high">High Priority</option>
                                    </select> -->
                                </div>
                                
                                <div class="col-12">
                                    <label class="form-label fw-semibold text-muted small text-uppercase">
                                        <i class="fas fa-comment-dots me-1"></i> Custom Message
                                    </label>
                                    <textarea class="form-control bg-light" id="inspection_custom_message" rows="7" 
                                              placeholder="Add any additional instructions or information for the applicant">Dear Applicant,

Your presence is required for a scheduled site inspection regarding your application. Please be available at the specified location and time.

Kindly bring along any relevant documents and ensure the property is accessible.

Thank you.</textarea>
                                    <div class="d-flex justify-content-between mt-1">
                                        <div class="form-text text-muted">
                                            <i class="fas fa-info-circle me-1"></i> 
                                            Maximum 500 characters
                                        </div>
                                        <span class="text-muted small" id="message_char_count">250/500</span>
                                    </div>
                                </div>
                                
                                <div class="col-12">
                                    <div class="alert alert-warning bg-warning bg-opacity-10 border-warning mb-0">
                                        <div class="d-flex">
                                            <div class="flex-shrink-0">
                                                <i class="fas fa-clock fa-fw"></i>
                                            </div>
                                            <div class="flex-grow-1 ms-2">
                                                <strong>Reminder:</strong> The applicant will be notified immediately via the selected channels. 
                                                A follow-up reminder will be sent 24 hours before the scheduled inspection.
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </form>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-0 px-4 py-3">
                <div class="d-flex flex-wrap align-items-center justify-content-between w-100 gap-2">
                    <div class="form-check mb-0">
                        <!-- <input class="form-check-input" type="checkbox" id="send_copy">
                        <label class="form-check-label small text-muted" for="send_copy">
                            Send a copy to my email
                        </label> -->
                    </div>
                    
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Cancel
                        </button>
                        <!-- <button type="button" class="btn btn-outline-primary px-4" id="previewNotification">
                            <i class="fas fa-eye me-2"></i>Preview
                        </button> -->
                        <button type="submit" form="inspectionNotificationForm" class="btn btn-success px-5" id="sendInspectionNotification">
                            <i class="fas fa-paper-plane me-2"></i>Send Notification
                            <span class="badge bg-white text-success ms-2 py-1 px-2">Now</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Generate Barcode on Plan Modal -->
<div class="modal fade effect-fade modal-blur" id="generate_barcode_on_plan" tabindex="-1" aria-labelledby="generateBarcodeModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header - Gradient Background -->
            <div class="modal-header bg-primary text-white border-0 py-3">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-white bg-opacity-20 py-2 px-2 me-3">
                        <i class="fas fa-barcode text-primary fa-2x"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white fw-bold" id="generateBarcodeModalLabel">
                            Generate Barcode on Plan
                        </h5>
                        <p class="text-white-50 small mb-0">
                            Create unique barcode for document tracking
                        </p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                
                <!-- Main Barcode Generation Form -->
                <form id="generateBarcodeForm" method="post" class="needs-validation" novalidate>
                    
                    <!-- Barcode Content -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold text-muted small text-uppercase">
                            <i class="fas fa-edit me-1"></i> Barcode Content
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="fas fa-hashtag text-muted"></i>
                            </span>
                            <input type="text" 
                                   class="form-control border-start-0 ps-0" 
                                   id="barcodeContent" 
                                   name="barcode_content"
                                   placeholder="e.g., PLAN-2024-001-001" 
                                   value="${job_number}"
                                   required>
                        </div>
                        <div class="form-text text-muted">
                            <i class="fas fa-info-circle me-1"></i> 
                            Unique identifier for this plan document
                        </div>
                    </div>
                    
                    
                    <!-- Information Alert -->
                    <div class="alert alert-info bg-info bg-opacity-10 border-info mb-0">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <i class="fas fa-info-circle fa-fw"></i>
                            </div>
                            <div class="flex-grow-1 ms-2">
                                <strong>Barcode Generation:</strong> This will create a unique barcode for the selected plan. 
                                The barcode will be embedded on the plan document for tracking and verification purposes.
                            </div>
                        </div>
                    </div>
                    
                </form>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-0 px-4 py-3">
                <div class="d-flex flex-wrap align-items-center justify-content-between w-100 gap-2">
                    <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <button type="button" class="btn btn-success px-5" id="btn_generate_smd_barcode_new_address_code">
                        <i class="fas fa-qrcode me-2"></i>Generate Barcode
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade modal-blur effect-scale" id="generate_deed_number" tabindex="-1" 
     aria-labelledby="generateDeedNumberLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header bg-primary text-white border-bottom-0">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="bg-white bg-opacity-10 px-3 py-2 rounded-circle">
                            <i class="bi bi-file-earmark-text text-primary fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h5 class="modal-title text-white mb-0" id="generateDeedNumberLabel">
                            Generate Deed Number
                        </h5>
                        <p class="mb-0 small opacity-75">Create or view deed reference</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white ms-auto" 
                            data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body p-4">
                <!-- Certificate Type (commented out but ready to use) -->
                <!-- 
                <div class="mb-4">
                    <label for="lc_txt_type_of_certificate" class="form-label fw-medium text-muted mb-2">
                        <i class="bi bi-award me-1"></i>
                        Certificate Type
                    </label>
                    <select name="lc_txt_type_of_certificate" 
                            id="lc_txt_type_of_certificate" 
                            class="form-select form-select-lg bg-light border-0" 
                            required>
                        <option value="${certificate_type == 'Individual' ? '' : certificate_type}">
                            ${certificate_type == 'Individual' ? '-- select certificate type --' : certificate_type}
                        </option>
                        <option value="Provisional Certificate">📄 Provisional Certificate</option>
                        <option value="Land Certificate">🏞️ Land Certificate</option>
                        <option value="Substituted Certificate">📋 Substituted Certificate</option>
                    </select>
                    <div class="form-text">
                        <i class="bi bi-info-circle me-1"></i>
                        Select the type of certificate to generate deed number
                    </div>
                </div>
                -->

                <!-- Deed Number Display -->
                <div class="deed-number-container mb-4">
                    <div class="d-flex align-items-center mb-2">
                        <label class="form-label fw-medium text-muted mb-0">
                            <i class="bi bi-hash me-1"></i>
                            Deed Number
                        </label>
                        <span class="ms-auto">
                            <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25">
                                <i class="bi bi-key me-1"></i>
                                Reference
                            </span>
                        </span>
                    </div>
                    
                    <div class="input-group input-group-lg">
                        <span class="input-group-text bg-primary bg-opacity-10 border-0" id="deedPrefix">
                            <i class="bi bi-file-text text-primary"></i>
                        </span>
                        <input type="text" 
                               class="form-control form-control-lg bg-light ${empty deed_number or deed_number == 'null' ? '' : 'text-primary fw-bold'}" 
                               id="lc_txt_deed_number" 
                               readonly 
                               value="${deed_number}"
                               aria-describedby="deedHelp">
                        <button class="btn btn-outline-secondary" 
                                type="button" 
                                onclick="copyDeedNumber()"
                                title="Copy to clipboard"
                                ${empty deed_number or deed_number == 'null' ? 'disabled' : ''}>
                            <i class="bi bi-clipboard"></i>
                        </button>
                    </div>
                    <div id="deedHelp" class="form-text">
                        <i class="bi bi-info-circle me-1"></i>
                        Deed number is auto-generated and read-only
                    </div>
                </div>

                <!-- Generation Status -->
                <div class="status-container mb-4" id="deedStatusContainer" style="display: none;">
                    <div class="alert alert-success border-0 bg-success bg-opacity-10 d-flex align-items-center" role="alert">
                        <div class="flex-shrink-0">
                            <i class="bi bi-check-circle-fill text-success fs-5"></i>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <h6 class="alert-heading mb-1 text-success">Deed Number Generated!</h6>
                            <p class="mb-0 small text-muted" id="deedStatusMessage"></p>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="action-section">
                    <!-- Generate Button -->
                    <button type="button" 
                            id="lc_btn_generate_deed_number_only" 
                            class="btn btn-primary btn-lg w-100 py-3 mb-3 generate-btn"
                            ${not empty deed_number and deed_number != 'null' and not fn:contains(deed_number, '-') ? 'disabled' : ''}>
                        <div class="d-flex align-items-center justify-content-center">
                            <span class="btn-icon me-2">
                                <i class="bi bi-gear-fill"></i>
                            </span>
                            <span class="btn-text">Generate New Deed Number</span>
                        </div>
                    </button>

                    <!-- Quick Actions (shown when deed number exists) -->
                    <!-- <div class="quick-actions d-flex gap-2 ${empty deed_number or deed_number == 'null' ? 'd-none' : ''}" 
                         id="quickActions">
                        <button type="button" class="btn btn-outline-primary flex-fill" onclick="useDeedNumber()">
                            <i class="bi bi-check-circle me-2"></i>Use Number
                        </button>
                        <button type="button" class="btn btn-outline-secondary flex-fill" onclick="regenerateDeedNumber()">
                            <i class="bi bi-arrow-repeat me-2"></i>Regenerate
                        </button>
                    </div> -->
                </div>

                <!-- Information Footer -->
                <div class="info-footer mt-4 pt-3 border-top">
                    <div class="d-flex align-items-center text-muted">
                        <div class="flex-shrink-0">
                            <i class="bi bi-shield-check text-primary"></i>
                        </div>
                        <div class="flex-grow-1 ms-2">
                            <small class="d-block fw-medium">Secure Generation</small>
                            <small class="text-muted">Deed numbers are generated following LIS standards</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer bg-light border-top-0">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-2"></i>
                    Close
                </button>
                <!-- <button type="button" class="btn btn-outline-primary" onclick="printDeedInfo()">
                    <i class="bi bi-printer me-2"></i>
                    Print
                </button> -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade modal-blur effect-slide" id="generate_concurrence_certificate" tabindex="-1"
     aria-labelledby="generateConcurrenceCertificateLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header bg-primary text-white border-bottom-0">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="bg-white bg-opacity-10 px-3 py-2 rounded-circle">
                            <i class="bi bi-file-earmark-check text-primary fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h5 class="modal-title text-white mb-0" id="generateConcurrenceCertificateLabel">
                            Generate Certificate
                        </h5>
                        <p class="mb-0 small opacity-75">Create and manage concurrence certificates</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white ms-auto" 
                            data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body p-4">
                <div class="certificate-container">
                    <!-- Certificate Summary Section -->
                    <div class="summary-section mb-4">
                        <div class="d-flex align-items-center mb-3">
                            <h6 class="fw-semibold text-primary mb-0">
                                <i class="bi bi-card-text me-2"></i>
                                Certificate Summary
                            </h6>
                            <span class="ms-auto">
                                <button class="btn btn-sm btn-danger" id="btn_compose_concurrence_certificate_template">
                                    <i class="bi bi-pencil-square me-1"></i>
                                    Compose Template
                                </button>
                            </span>
                        </div>
                        
                        <div class="form-floating">
                            <!-- <textarea id="lc_search_report_summary_details_cs" 
                                      name="lc_search_report_summary_details_cs" 
                                      class="form-control" 
                                      required 
                                      style="height: 180px;">${remark_or_comment}</textarea> -->
                            <!-- <label for="lc_search_report_summary_details_cs">
                                <i class="bi bi-chat-left-text me-1"></i>
                                Certificate Summary / Remarks
                            </label> -->
                            <div class="position-relative">
                                <!-- <textarea id="lc_search_report_summary_details" 
                                          name="lc_search_report_summary_details" 
                                          class="form-control" 
                                          required 
                                          rows="7"
                                          style="min-height: 200px; padding: 1.5rem !important;"
                                          placeholder="Enter certificate summary and details...">${remark_or_comment}
                                </textarea> -->
                                <div id="lc_concurrence_certificate_summary_details">
                                  ${remark_or_comment}
                                </div>
                                <div class="position-absolute top-0 end-0 p-3 text-muted">
                                    <i class="fas fa-file-signature"></i>
                                </div>
                            </div>
                        </div>
                        <div class="form-text mt-2">
                            <i class="bi bi-info-circle me-1 text-primary"></i>
                            Enter the summary details for the concurrence certificate
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <!-- Compose Template (commented out but ready to use) -->
                        <!-- 
                        <div class="col-4 mb-3">
                            <button type="button" name="btn_compose_certificate_template" 
                                    id="btn_compose_certificate_template" 
                                    class="btn btn-outline-primary w-100 py-3">
                                <i class="bi bi-file-earmark-plus me-2"></i>
                                <span>Compose Template</span>
                            </button>
                        </div>
                        -->

                        <div class="row g-3">
                            <!-- Save Certificate Button -->
                            <div class="col-md-6">
                                <button type="button" name="lc_btn_save_search_report_cs" 
                                        id="lc_btn_save_search_report_cs" 
                                        class="btn btn-outline-secondary w-100 py-3 save-btn">
                                    <div class="d-flex align-items-center justify-content-center">
                                        <i class="bi bi-cloud-arrow-up fs-5 me-2"></i>
                                        <span>Save Certificate</span>
                                    </div>
                                </button>
                            </div>

                            <!-- Generate Certificate Button -->
                            <div class="col-md-6">
                                <button type="button" name="lc_btn_activate_final_concurrence_certificate_cs" 
                                        id="lc_btn_activate_final_concurrence_certificate_cs" 
                                        class="btn btn-success w-100 py-3 generate-btn">
                                    <div class="d-flex align-items-center justify-content-center">
                                        <i class="bi bi-check2-circle fs-5 me-2"></i>
                                        <span>Generate Certificate</span>
                                    </div>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Hidden Inputs -->
                    <input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id" value="${transaction_id}">

                    <!-- Action Status -->
                    <div class="action-status mt-4" id="actionStatus" style="display: none;">
                        <div class="alert alert-success d-flex align-items-center border-0" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            <div id="statusMessage"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer bg-light border-top-0">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-2"></i>
                    Close
                </button>
                <!-- <button type="button" class="btn btn-outline-primary" onclick="previewCertificate()">
                    <i class="bi bi-eye me-2"></i>
                    Preview
                </button>
                <button type="button" class="btn btn-outline-info" onclick="printCertificate()">
                    <i class="bi bi-printer me-2"></i>
                    Print
                </button> -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-slide modal-blur" id="generate_ls_number" tabindex="-1"
     aria-labelledby="generateLsNumberLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header bg-primary text-white border-bottom-0">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="bg-white bg-opacity-10 text-primary px-3 py-2 rounded-circle">
                            <i class="bi bi-123 fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h5 class="modal-title text-white mb-0" id="generateLsNumberLabel">
                            Generate Serial Number
                        </h5>
                        <p class="mb-0 small opacity-75">Create a unique serial reference</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white ms-auto" 
                            data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body p-4">
                <div class="ls-number-container">
                 

                    <!-- LS Number Display -->
                    <div class="ls-display-container mb-4">
                        <div class="d-flex align-items-center mb-2">
                            <label class="form-label fw-medium text-muted mb-0">
                                <i class="bi bi-hash me-1"></i>
                                Serial Number
                            </label>
                            <!-- <span class="ms-auto">
                                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-3 py-2">
                                    <i class="bi bi-key me-1"></i>
                                    Unique Identifier
                                </span>
                            </span> -->
                        </div>
                        
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-primary bg-opacity-10" id="lsPrefix">
                                <i class="bi bi-geo-alt text-primary"></i>
                            </span>
                            <input type="text" 
                                   class="form-control form-control-lg bg-light ${empty ls_number or ls_number == 'null' ? '' : 'text-primary fw-bold'}" 
                                   id="lc_txt_ls_number" 
                                   readonly 
                                   value="${ls_number}"
                                   aria-describedby="lsHelp">
                            <button class="btn btn-outline-secondary" 
                                    type="button" 
                                    onclick="copyLsNumber()"
                                    title="Copy to clipboard"
                                    ${empty ls_number or ls_number == 'null' ? 'disabled' : ''}>
                                <i class="bi bi-clipboard"></i>
                            </button>
                        </div>
                        <!-- <div id="lsHelp" class="form-text">
                            <i class="bi bi-info-circle me-1"></i>
                            LS number format: LS-[DISTRICT]-[YEAR]-[SEQUENCE]
                        </div> -->
                    </div>

                    <!-- LS Number Preview (shown when generated) -->
                    <div class="ls-preview-container mb-4" id="lsPreviewContainer" style="display: none;">
                        <div class="card border-0 bg-light">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="flex-shrink-0">
                                        <div class="bg-success bg-opacity-10 p-2 rounded-circle">
                                            <i class="bi bi-check-circle-fill text-success"></i>
                                        </div>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h6 class="mb-1">Serial Number Generated</h6>
                                        <p class="mb-0 small text-muted" id="lsPreviewMessage"></p>
                                    </div>
                                    <button class="btn btn-sm btn-outline-primary" onclick="viewLsDetails()">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Generation Status -->
                    <div class="status-container mb-4" id="lsStatusContainer" style="display: none;">
                        <div class="alert alert-success border-0 bg-success bg-opacity-10 d-flex align-items-center" role="alert">
                            <div class="flex-shrink-0">
                                <i class="bi bi-check-circle-fill text-success fs-5"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="alert-heading mb-1 text-success">Serial Number Generated!</h6>
                                <p class="mb-0 small text-muted" id="lsStatusMessage"></p>
                            </div>
                        </div>
                    </div>

                    <!-- Generation Information -->
                    <div class="info-box bg-light rounded-3 p-3 mb-4">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <i class="bi bi-info-circle-fill text-primary"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="mb-1">About Serial Numbers</h6>
                                <p class="small text-muted mb-0">
                                  Serial numbers are unique identifiers assigned to land parcels 
                                    for tracking and reference purposes throughout the registration process.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-section">
                        <!-- Generate Button -->
                        <button type="button" 
                                id="lc_btn_generate_ls_number_only" 
                                class="btn btn-primary btn-lg w-100 py-3 mb-3 generate-btn"
                                ${not empty ls_number and ls_number != 'null' and not fn:contains(ls_number, '-') ? 'disabled' : ''}>
                            <div class="d-flex align-items-center justify-content-center">
                                <span class="btn-icon me-2">
                                    <i class="bi bi-gear-fill"></i>
                                </span>
                                <span class="btn-text">Generate Serial Number</span>
                            </div>
                        </button>

                        <!-- Quick Actions (shown when LS number exists) -->
                        <!-- <div class="quick-actions d-flex gap-2 ${empty ls_number or ls_number == 'null' ? 'd-none' : ''}" 
                             id="quickActions">
                            <button type="button" class="btn btn-outline-primary flex-fill" onclick="useLsNumber()">
                                <i class="bi bi-check-circle me-2"></i>Use Number
                            </button>
                            <button type="button" class="btn btn-outline-secondary flex-fill" onclick="regenerateLsNumber()">
                                <i class="bi bi-arrow-repeat me-2"></i>Regenerate
                            </button>
                        </div> -->
                    </div>

                </div>
            </div>

            <!-- Footer -->
            <div class="modal-footer bg-light border-top-0">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-2"></i>
                    Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-slide modal-blur" id="check_signed_certificate_of_registration_of_instrument" 
     tabindex="-1" aria-labelledby="checkSignedCertificateLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-md modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header bg-primary text-white border-bottom-0">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="bg-white bg-opacity-10 px-3 py-2 rounded-circle">
                            <i class="bi bi-file-earmark-check text-primary fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h5 class="modal-title text-white mb-0" id="checkSignedCertificateLabel">
                            Signed Certificate
                        </h5>
                        <p class="mb-0 small opacity-75">View signed certificate of registration</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white ms-auto" 
                            data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body p-4">
                <!-- Volume and Folio Information (commented out but ready to use) -->
                <!-- 
                <div class="info-section mb-4">
                    <h6 class="section-title mb-3">
                        <i class="bi bi-info-circle me-2 text-primary"></i>
                        Document Reference
                    </h6>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" class="form-control bg-light border-0" 
                                       id="volume_number" readonly value="${volume_number}" 
                                       placeholder="Volume number">
                                <label for="volume_number">
                                    <i class="bi bi-book me-1"></i>
                                    Volume Number
                                </label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" class="form-control bg-light border-0" 
                                       id="folio_number" readonly value="${folio_number}" 
                                       placeholder="Folio number">
                                <label for="folio_number">
                                    <i class="bi bi-file-text me-1"></i>
                                    Folio Number
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                -->

                <!-- Certificate Preview Card -->
                <div class="certificate-preview-card mb-4">
                    <div class="card border-0 bg-light">
                        <div class="card-body text-center p-4">
                            <div class="preview-icon mb-3">
                                <div class="bg-primary bg-opacity-10 p-3 rounded-circle d-inline-block">
                                    <i class="bi bi-file-earmark-pdf-fill text-primary fs-1"></i>
                                </div>
                            </div>
                            <h6 class="mb-2">Signed Certificate Ready</h6>
                            <p class="small text-muted mb-0">
                                Click the button below to view the signed certificate
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Certificate Status -->
                <!-- <div class="status-indicator mb-4">
                    <div class="d-flex align-items-center p-3 bg-success bg-opacity-10 rounded-3">
                        <div class="flex-shrink-0">
                            <i class="bi bi-shield-check text-success fs-4"></i>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <h6 class="mb-1 text-success">Digitally Signed</h6>
                            <p class="small text-muted mb-0">
                                Certificate has been digitally signed and verified
                            </p>
                        </div>
                    </div>
                </div> -->

                <!-- Action Buttons -->
                <div class="action-section">
                    <!-- View Certificate Button -->
                    <button type="button" 
                            id="lc_btn_activate_final_concurrence_certificate_" 
                            class="btn btn-primary btn-lg w-100 py-3 mb-3 view-certificate-btn">
                        <div class="d-flex align-items-center justify-content-center">
                            <span class="btn-icon me-2">
                                <i class="bi bi-eye-fill"></i>
                            </span>
                            <span class="btn-text">View Signed Certificate</span>
                        </div>
                    </button>

                    <!-- Quick Actions -->
                    <!-- <div class="quick-actions d-flex gap-2">
                        <button type="button" class="btn btn-outline-primary flex-fill" onclick="downloadCertificate()">
                            <i class="bi bi-download me-2"></i>Download
                        </button>
                        <button type="button" class="btn btn-outline-secondary flex-fill" onclick="printCertificate()">
                            <i class="bi bi-printer me-2"></i>Print
                        </button>
                    </div> -->
                </div>

            </div>

            <!-- Footer -->
            <div class="modal-footer bg-light border-top-0">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-2"></i>
                    Close
                </button>
                <button type="button" class="btn btn-outline-info" onclick="showCertificateInfo()">
                    <i class="bi bi-question-circle me-2"></i>
                    Certificate Info
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-slide modal-blur" id="preview_certificate_deed_land_serial_number" 
     tabindex="-1" aria-labelledby="previewCertificateLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header bg-primary text-white border-bottom-0">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="bg-white bg-opacity-10 text-primary px-3 py-2 rounded-circle">
                            <i class="bi bi-eye-fill fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h5 class="modal-title text-white mb-0" id="previewCertificateLabel">
                            Document Reference Numbers
                        </h5>
                        <p class="mb-0 small opacity-75">Preview Certificate, Deed & Land Serial Numbers</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white ms-auto" 
                            data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body p-4">
                <!-- Certificate Type (commented out but ready to use) -->
                <!-- 
                <div class="mb-4">
                    <label for="lc_txt_type_of_certificate" class="form-label fw-medium text-muted mb-2">
                        <i class="bi bi-award me-1"></i>
                        Certificate Type
                    </label>
                    <select name="lc_txt_type_of_certificate" 
                            id="lc_txt_type_of_certificate" 
                            class="form-select form-select-lg bg-light border-0" 
                            required>
                        <option value="${certificate_type == 'Individual' ? '' : certificate_type}">
                            ${certificate_type == 'Individual' ? '-- select certificate type --' : certificate_type}
                        </option>
                        <option value="Provisional Certificate">📄 Provisional Certificate</option>
                        <option value="Land Certificate">🏞️ Land Certificate</option>
                        <option value="Substituted Certificate">📋 Substituted Certificate</option>
                    </select>
                    <div class="form-text">
                        <i class="bi bi-info-circle me-1"></i>
                        Select certificate type to generate related numbers
                    </div>
                </div>
                -->

                <!-- Preview Summary -->
                <div class="preview-summary mb-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h6 class="fw-semibold text-primary mb-0">
                            <i class="bi bi-file-earmark-text me-2"></i>
                            Generated Numbers
                        </h6>
                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-3 py-2">
                            <i class="bi bi-check-circle me-1"></i>
                            Ready for Review
                        </span>
                    </div>
                    <div class="alert alert-light border d-flex align-items-center">
                        <i class="bi bi-info-circle me-2 text-primary"></i>
                        <small>The following reference numbers have been generated for this case.</small>
                    </div>
                </div>

                <!-- Numbers Display Cards -->
                <div class="numbers-container">
                    <!-- Land Serial (LS) Number Card -->
                    <div class="number-card mb-4">
                        <div class="d-flex align-items-center mb-3">
                            <div class="flex-shrink-0">
                                <div class="icon-wrapper bg-primary bg-opacity-10 p-2 rounded-3">
                                    <i class="bi bi-geo-alt-fill text-primary fs-5"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="mb-1">Serial Number</h6>
                                <p class="small text-muted mb-0">Unique identifier for land registration</p>
                            </div>
                        </div>
                        
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-primary bg-opacity-10 border-0" id="lsPreviewIcon">
                                <i class="bi bi-hash text-primary"></i>
                            </span>
                            <input type="text" 
                                   class="form-control form-control-lg bg-light ${empty ls_number or ls_number == 'null' ? 'text-muted' : 'text-primary fw-bold'}" 
                                   id="lc_view_ls_number" 
                                   readonly 
                                   value="${ls_number}"
                                   placeholder=""
                                   aria-describedby="lsPreviewHelp">
                            <button class="btn btn-outline-secondary" 
                                    type="button" 
                                    onclick="copyNumber('lc_view_ls_number', 'Serial number')"
                                    title="Copy Serial number"
                                    ${empty ls_number or ls_number == 'null' ? 'disabled' : ''}>
                                <i class="bi bi-clipboard"></i>
                            </button>
                        </div>
                        <div id="lsPreviewHelp" class="form-text">
                            <i class="bi bi-info-circle me-1"></i>
                            ${not empty ls_number and ls_number != 'null' ? 'Serial number generated' : 'No Serial number generated yet'}
                        </div>
                    </div>

                    <!-- Deed Number Card -->
                    <div class="number-card mb-4">
                        <div class="d-flex align-items-center mb-3">
                            <div class="flex-shrink-0">
                                <div class="icon-wrapper bg-success bg-opacity-10 p-2 rounded-3">
                                    <i class="bi bi-file-earmark-text-fill text-success fs-5"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="mb-1">Deed Number</h6>
                                <p class="small text-muted mb-0">Official deed registration reference</p>
                            </div>
                        </div>
                        
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-success bg-opacity-10 border-0" id="deedPreviewIcon">
                                <i class="bi bi-file-text text-success"></i>
                            </span>
                            <input type="text" 
                                   class="form-control form-control-lg bg-light ${empty deed_number or deed_number == 'null' ? 'text-muted' : 'text-success fw-bold'}" 
                                   id="lc_view_deed_number" 
                                   readonly 
                                   value="${deed_number}"
                                   placeholder=""
                                   aria-describedby="deedPreviewHelp">
                            <button class="btn btn-outline-secondary" 
                                    type="button" 
                                    onclick="copyNumber('lc_view_deed_number', 'Deed number')"
                                    title="Copy Deed number"
                                    ${empty deed_number or deed_number == 'null' ? 'disabled' : ''}>
                                <i class="bi bi-clipboard"></i>
                            </button>
                        </div>
                        <div id="deedPreviewHelp" class="form-text">
                            <i class="bi bi-info-circle me-1"></i>
                            ${not empty deed_number and deed_number != 'null' ? 'Deed number generated' : 'No deed number generated yet'}
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-section">
                        <!-- View Certificate Button -->
                        <button type="button" 
                                id="lc_btn_activate_final_concurrence_certificate__" 
                                class="btn btn-primary btn-lg w-100 py-3 mb-3 view-certificate-btn">
                            <div class="d-flex align-items-center justify-content-center">
                                <span class="btn-icon me-2">
                                    <i class="bi bi-eye-fill"></i>
                                </span>
                                <span class="btn-text">View Signed Certificate</span>
                            </div>
                        </button>

                        <!-- Quick Actions -->
                        <!-- <div class="quick-actions d-flex gap-2">
                            <button type="button" class="btn btn-outline-primary flex-fill" onclick="downloadCertificate()">
                                <i class="bi bi-download me-2"></i>Download
                            </button>
                            <button type="button" class="btn btn-outline-secondary flex-fill" onclick="printCertificate()">
                                <i class="bi bi-printer me-2"></i>Print
                            </button>
                        </div> -->
                    </div>

                    <!-- Volume & Folio Section (can be uncommented when needed) -->
                    <!-- 
                    <div class="row g-3 mt-3">
                        <div class="col-md-6">
                            <div class="number-card">
                                <label class="form-label small fw-medium text-muted mb-2">
                                    <i class="bi bi-book me-1"></i>
                                    Volume Number
                                </label>
                                <input type="text" class="form-control bg-light" readonly value="${volume_number}" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="number-card">
                                <label class="form-label small fw-medium text-muted mb-2">
                                    <i class="bi bi-file-text me-1"></i>
                                    Folio Number
                                </label>
                                <input type="text" class="form-control bg-light" readonly value="${folio_number}" />
                            </div>
                        </div>
                    </div>
                    -->
                </div>

            </div>

            <!-- Footer -->
            <div class="modal-footer bg-light border-top-0">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-2"></i>
                    Close
                </button>
                <!-- <button type="button" class="btn btn-outline-primary" onclick="refreshPreview()">
                    <i class="bi bi-arrow-clockwise me-2"></i>
                    Refresh
                </button> -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-fade modal-blur" id="generate_file_number" tabindex="-1"
     aria-labelledby="generateFileNumberLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered modal-md">
    <div class="modal-content border-0">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="generateFileNumberLabel">
          <i class="fas fa-folder-open me-2"></i>
          Generate File Number
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
         <div class="mb-3 fs-20">
            <label for="lc_txt_file_number" class="form-label">
              <i class="ri-map-2-line me-1"></i>
              Locality:
            </label>
            <span class="text-danger fw-bold">${locality}</span>
        </div>
        <div class="mb-3">
            <label for="lc_txt_file_number" class="form-label">
              <i class="fas fa-landmark me-1"></i>
              Type of Land Reference:
            </label>
            <select class="form-select" id="lc_txt_file_number_type">
              <option disabled selected value="">-- select --</option>
              
            </select>
        </div>
        <div class="mb-3">
          <label for="lc_txt_file_number" class="form-label">
            <i class="fas fa-hashtag me-1"></i>
            File Number:
          </label>
          <div class="input-group">
            <span class="input-group-text">
              <i class="fas fa-file"></i>
            </span>
            <input type="text" class="form-control form-control-lg bg-light" id="lc_txt_file_number" readonly value="${file_number}" style="cursor: not-allowed;" />
          </div>
        </div>
        
        <div class="mt-4">
          <button type="button" id="lc_btn_generate_file_number_only" 
                  class="btn btn-primary w-100 py-2" 
                  value="Generate"
                  <c:if test="${not empty file_number and file_number != 'null' and not fn:contains(file_number, '-')}">
                    disabled
                  </c:if>>
            <i class="fas fa-sync-alt me-2"></i>
            Generate File Number
          </button>
          
          <!-- Status Message -->
          <div class="form-text mt-2 text-center">
            <c:if test="${not empty file_number and file_number != 'null' and not fn:contains(file_number, '-')}">
              <i class="fas fa-check-circle text-success me-1"></i>
              <span class="text-success">File number already generated</span>
            </c:if>
            <c:if test="${empty file_number or file_number == 'null' or fn:contains(file_number, '-')}">
              <i class="fas fa-info-circle text-info me-1"></i>
              <span class="text-info selected_file_number">Click to generate a new file number</span>
            </c:if>
          </div>
        </div>
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<!-- Update Digital Workflow Milestone Modal - Bootstrap 5 -->
<div class="modal fade effect-fade modal-blur" id="update_digital_workflow_milestone" tabindex="-1" 
     aria-labelledby="updateDigitalWorkflowLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="updateDigitalWorkflowLabel">
                    <i class="bi bi-arrow-repeat me-2 text-primary"></i>
                    Update Digital Workflow Milestone
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" 
                        aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Hidden User ID -->
                <input id="up_userid" name="up_userid" type="hidden" value="${userid}">

                <!-- Full Name Field -->
                <div class="mb-4">
                    <label for="up_fullname" class="form-label fw-semibold">
                        <i class="bi bi-person-circle me-1 text-secondary"></i>
                        Full Name
                    </label>
                    <input class="form-control bg-light" type="text" 
                           id="up_fullname" readonly
                           placeholder="User full name will appear here">
                </div>

                <!-- Milestone List Card -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h6 class="mb-0 fw-semibold">
                            <i class="bi bi-list-check text-primary me-2"></i>
                            Milestone List
                        </h6>
                    </div>
                    <div class="card-body p-0">
                        <!-- Milestone Table -->
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" 
                                   id="tbl_baby_steps_list_dataTable" width="100%">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="px-3 py-3">Description</th>
                                        <th class="px-3 py-3 text-center" width="120">Option</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Table content will be loaded dynamically -->
                                    <tr>
                                        <td colspan="2" class="text-center text-muted py-4">
                                            <i class="bi bi-info-circle me-2"></i>
                                            No milestones available
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer bg-white py-2 text-muted small">
                        <i class="bi bi-info-circle me-1"></i>
                        Select milestones to update workflow status
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg me-1"></i>
                    Cancel
                </button>
                <button type="button" id="btn_process_updated_milestone" class="btn btn-success">
                    <i class="bi bi-check-lg me-1"></i>
                    Update Milestone
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="newCertificateModal" tabindex="-1" aria-labelledby="newCertificateModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title" id="newCertificateModalLabel">
                    <i class="fas fa-money-bill-wave me-2"></i>
                    Certificate Section
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <form id="form_add_certificate">
                    
                    <!-- Hidden Fields -->
                    <input type="hidden" id="cs_id" name="cs_id" value="0">
                    
                    <!-- Form Content -->
                    <div class="row g-4" style="height: 100vh;">
                        
                        <!-- Left Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">

                          <div class="row g-4">
                            <div class="col-lg-6">
                              <!-- Case Number -->
                               <div class="mb-3">
                                  <label for="cs_case_number" class="form-label fw-medium">
                                      <i class="fas fa-hashtag me-1"></i>
                                      Case Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-folder"></i>
                                      </span>
                                      <input type="text" name="cs_case_number" id="cs_case_number" 
                                            class="form-control" required readonly value="${case_number}">
                                  </div>
                              </div>
                              
                             <!-- Date of Issue -->
                              <div class="mb-3">
                                  <label for="cs_date_of_registration" class="form-label fw-medium">
                                      <i class="fas fa-calendar-check me-1"></i>
                                     Date of Issue
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-calendar-check"></i>
                                      </span>
                                      <input type="date" name="cs_date_of_registration" id="cs_date_of_registration" 
                                            class="form-control" required>
                                  </div>
                              </div>

                              <!-- >To Whom Issued -->
                              <div class="mb-3">
                                  <label for="cs_to_whom_issued" class="form-label fw-medium">
                                      <i class="fas fa-calendar-check me-1"></i>
                                     To Whom Issued
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-user"></i>
                                      </span>
                                      <input type="text" name="cs_to_whom_issued" id="cs_to_whom_issued" 
                                            class="form-control" required>
                                  </div>
                              </div>

                            </div>

                            <div class="col-lg-6">
                              
                              
                              <!-- Serial Number -->
                              <div class="mb-3">
                                  <label for="cs_serial_number" class="form-label fw-medium">
                                      <i class="fas fa-fa-money-bill-wave me-1"></i>
                                      Serial Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-sort-numeric-up"></i>
                                      </span>
                                      <input type="text" name="cs_serial_number" id="cs_serial_number" 
                                            class="form-control" required>
                                  </div>
                              </div>


                              <!-- Official Notes -->
                            <div class="mb-3">
                                <label for="cs_official_notes" class="form-label fw-medium">
                                    <i class="fas fa-sticky-note me-1"></i>
                                    Official Notes
                                </label>
                                <textarea name="cs_official_notes" id="cs_official_notes" 
                                            class="form-control" rows="3" required
                                            placeholder="Additional official notes or observations"></textarea>
                                <div class="form-text">Internal official notes or observations</div>
                            </div>
                              
                            </div>
                          </div>

                          <!-- Buttons moved to left column -->
                          <div class="border-top bg-light p-3 rounded" style="margin-top: auto !important;">
                              <div class="d-flex justify-content-between align-items-center">
                                  <div>
                                      <button type="button" class="btn btn-outline-danger btn_reg_root_delete_action" 
                                              data-action_type='encumbrances' style="display: none;">
                                          <i class="fas fa-trash me-1"></i>
                                          Delete
                                      </button>
                                  </div>
                                  <div class="d-flex gap-2">
                                      <button type="button" class="btn btn-outline-info" data-bs-dismiss="modal">
                                          <i class="fas fa-times me-1"></i>
                                          Cancel
                                      </button>
                                      <button type="submit" id="btn_certificate_section" class="btn btn-info">
                                          <i class="fas fa-save me-1"></i>
                                          Save Certificate
                                      </button>
                                  </div>
                              </div>
                          </div>
                        </div>
                        
                        <!-- Right Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">
                            <div class="_gated_workflow_documents"></div>
                        </div>
                        
                    </div>
                    
                </form>
            </div>

        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="transaction_details_for_deed" tabindex="-1"
     aria-labelledby="transaction_details_for_deed_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="transaction_details_for_deed_label">
                    <i class="fas fa-book me-2"></i>
                    Check Transactions Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">

                <div class="card">
                    <div class="card-header bg-success bg-opacity-10 justify-content-between">
                        <div class="card-title text-primary">
                            <i class="bi bi-geo-alt me-2"></i>Parcel Attributes
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Case Number</label>
                                <div class="fw-medium text-dark">${empty fn:trim(case_number) ? '--' : fn:trim(case_number)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Regional Number</label>
                                <div class="fw-medium text-dark">${empty fn:trim(regional_number) ? '--' : fn:trim(regional_number)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Locality</label>
                                <div class="fw-medium text-dark">${empty fn:trim(locality) || locality == '0' ? '--' : fn:trim(locality)}</div>
                            </div>
                            
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">District</label>
                                <div class="fw-medium text-dark">${empty fn:trim(district) ? '--' : fn:trim(district)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Region</label>
                                <div class="fw-medium text-dark">${empty fn:trim(region) ? '--' : fn:trim(region)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Land Size (Acres)</label>
                                <div class="fw-medium text-dark">${empty fn:trim(size_of_land) ? '--' : fn:trim(size_of_land)}</div>
                            </div>
                            
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">GLPIN</label>
                                <div class="fw-medium text-dark">${empty fn:trim(glpin) ? '--' : fn:trim(glpin)}</div>
                            </div>
                        </div>
                    </div>
                    </div>
                
                <!-- Transaction Details Section -->
                <div class="card">
                    <div class="card-header bg-success bg-opacity-10 justify-content-between">
                        <div class="card-title text-primary">
                            <i class="bi bi-receipt me-2"></i>Transaction Details
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Job Number</label>
                                <div class="fw-medium text-dark">${empty fn:trim(job_number) ? '--' : fn:trim(job_number)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Case Number</label>
                                <div class="fw-medium text-dark">${empty fn:trim(case_number) ? '--' : fn:trim(case_number)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Transaction Number</label>
                                <div class="fw-medium text-dark">${empty fn:trim(transaction_number) ? '--' : fn:trim(transaction_number)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Applicant Name</label>
                                <div class="fw-medium text-dark">${empty fn:trim(ar_name) ? '--' : fn:trim(ar_name)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Application Type</label>
                                <div class="fw-medium text-dark">${empty fn:trim(business_process_sub_name) ? '--' : fn:trim(business_process_sub_name)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Nature of Instrument</label>
                                <div class="fw-medium text-dark">${empty fn:trim(nature_of_instrument) ? '--' : fn:trim(nature_of_instrument)}</div>
                            </div>
                            
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Document Date</label>
                                <fmt:parseDate value="${date_of_document}" pattern="yyyy-MM-dd" var="parsedDocumentDate"/>
                                <fmt:formatDate value="${parsedDocumentDate}" pattern="dd MMM yyyy" var="formattedDocumentDate"/>
                                <div class="fw-medium text-dark">${empty formattedDocumentDate ? '--' : formattedDocumentDate}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Registration Date</label>
                                <fmt:parseDate value="${date_of_registration}" pattern="yyyy-MM-dd" var="parsedRegistrationDate"/>
                                <fmt:formatDate value="${parsedRegistrationDate}" pattern="dd MMM yyyy" var="formattedRegistrationDate"/>
                                <div class="fw-medium text-dark">${empty formattedRegistrationDate ? '--' : formattedRegistrationDate}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Type of Interest</label>
                                <div class="fw-medium text-dark">${empty fn:trim(type_of_interest) ? '--' : fn:trim(type_of_interest)}</div>
                            </div>
                            
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Type of Use</label>
                                <div class="fw-medium text-dark">${empty fn:trim(type_of_use) || type_of_use == '0' ? '--' : fn:trim(type_of_use)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Term</label>
                                <div class="fw-medium text-dark">${empty fn:trim(term) || term == '0' ? '--' : fn:trim(term)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Option for Renewal</label>
                                <div class="fw-medium text-dark">${empty fn:trim(renewal_term) || renewal_term == '0' ? '--' : fn:trim(renewal_term)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Commencement Date</label>
                                <fmt:parseDate value="${commencement_date}" pattern="yyyy-MM-dd" var="parsedCommencementDate"/>
                                <fmt:formatDate value="${parsedCommencementDate}" pattern="dd MMM yyyy" var="formattedCommencementDate"/>
                                <div class="fw-medium text-dark">${empty formattedCommencementDate ? '--' : formattedCommencementDate}</div>
                            </div>
                            
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Assessed Value</label>
                                <div class="fw-medium text-dark">${empty fn:trim(assessed_value) || assessed_value == '0' ? '--' : fn:trim(assessed_value)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Stamp Duty Payable</label>
                                <div class="fw-medium text-dark">${empty fn:trim(stamp_duty_payable) || stamp_duty_payable == '0' ? '--' : fn:trim(stamp_duty_payable)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Consideration in Document</label>
                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee) || consideration_fee == '0' ? '--' : fn:trim(consideration_fee)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Consideration Currency</label>
                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee_currency) ? '--' : fn:trim(consideration_fee_currency)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Adopted Currency Rate</label>
                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee_adopted_rate) || consideration_fee_adopted_rate == '0' ? '--' : fn:trim(consideration_fee_adopted_rate)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Annual Rent</label>
                                <div class="fw-medium text-dark">${empty fn:trim(annual_rent) || consideration_fee_adopted_rate == '0' ? '--' : fn:trim(annual_rent)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Rent Review Period</label>
                                <div class="fw-medium text-dark">${empty fn:trim(rent_review_period) || consideration_fee_adopted_rate == '0' ? '--' : fn:trim(rent_review_period)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Ground Rent</label>
                                <div class="fw-medium text-dark">${empty fn:trim(ground_rent) || consideration_fee_adopted_rate == '0' ? '--' : fn:trim(ground_rent)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Publication Date</label>
                                <fmt:parseDate value="${publicity_date}" pattern="yyyy-MM-dd" var="parsedPublicityDate"/>
                                <fmt:formatDate value="${parsedPublicityDate}" pattern="dd MMM yyyy" var="formattedPublicityDate"/>
                                <div class="fw-medium text-dark"> ${empty formattedPublicityDate ? '--' : formattedPublicityDate}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Date of Issue</label>
                                <fmt:parseDate value="${date_of_issue}" pattern="yyyy-MM-dd" var="parsedDateOfIssue"/>
                                <fmt:formatDate value="${parsedDateOfIssue}" pattern="dd MMM yyyy" var="formattedDateOfIssue"/>
                                <div class="fw-medium text-dark"> ${empty formattedDateOfIssue ? '--' : formattedDateOfIssue}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">File Number</label>
                                <div class="fw-medium text-dark">${empty fn:trim(file_number) ? '--' : fn:trim(file_number)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Serial Number</label>
                                <div class="fw-medium text-dark">${empty fn:trim(serial_number) ? '--' : fn:trim(serial_number)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Deed Number</label>
                                <div class="fw-medium text-dark">${empty fn:trim(deed_number) ? '--' : fn:trim(deed_number)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Extent of Land</label>
                                <div class="fw-medium text-dark">${empty fn:trim(intended_parcel) ? '--' : fn:trim(intended_parcel)}</div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small mb-1">Extent of Interest</label>
                                <div class="fw-medium text-dark">${empty fn:trim(intended_interest) ? '--' : fn:trim(intended_interest)}</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header bg-success bg-opacity-10 justify-content-between">
                        <div class="card-title text-primary">
                            <i class="bi bi-receipt me-2"></i>Parties
                        </div>
                    </div>
                    <div class="card-body">

                        <table class="table table-hover table-sm mb-0" id="party_details_datatable">
                            <thead class="table-light">
                            <tr>
                                <th width="25%">
                                <i class="bi bi-person me-1"></i>Name
                                </th>
                                <th width="10%">
                                <i class="bi bi-gender-ambiguous me-1"></i>Sex
                                </th>
                                <th width="20%">
                                <i class="bi bi-telephone me-1"></i>Contact
                                </th>
                                <th width="20%">
                                <i class="bi bi-address me-1"></i>Address
                                </th>
                                <th width="20%">
                                <i class="bi bi-person-badge me-1"></i>Role
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${parties}" var="parties_row">
                                <tr>
                                <td class="align-middle">
                                    <div class="fw-semibold">${parties_row.ar_name}</div>
                                </td>
                                <td class="align-middle">
                                    <span class="badge ${parties_row.ar_gender == 'MALE' ? 'bg-info' : parties_row.ar_gender == 'FEMALE' ? 'bg-pink' : 'bg-secondary'}">
                                    ${parties_row.ar_gender == 'MALE' ? 'Male' : parties_row.ar_gender == 'FEMALE' ? 'Female' : 'Other'}
                                    </span>
                                </td>
                                <td class="align-middle">
                                    <div class="contact-info">
                                    <div class="d-flex align-items-center mb-1">
                                        <i class="bi bi-phone text-primary me-2"></i>
                                        <small>${empty fn:trim(parties_row.ar_cell_phone) ? '--' : fn:trim(parties_row.ar_cell_phone)}</small>
                                    </div>
                                    <c:if test="${not empty parties_row.ar_cell_phone2}">
                                        <div class="d-flex align-items-center">
                                        <i class="bi bi-telephone-plus text-secondary me-2"></i>
                                        <small>${empty fn:trim(parties_row.ar_cell_phone2) ? '--' : fn:trim(parties_row.ar_cell_phone2)}</small>
                                        </div>
                                    </c:if>
                                    </div>
                                </td>
                                 <td class="align-middle">
                                    <div class="contact-info">
                                        <div class="d-flex align-items-center mb-1">
                                            <i class="bi bi-address text-primary me-2"></i>
                                            <small>${empty fn:trim(parties_row.ar_address) ? '--' : fn:trim(parties_row.ar_address)}</small>
                                        </div>
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <span class="badge ${parties_row.type_of_party == 'Grantor' ? 'bg-success' : parties_row.type_of_party == 'Applicant' ? 'bg-warning' : 'bg-info'}">
                                    ${parties_row.type_of_party}
                                    </span>
                                </td>
                                </tr>
                            </c:forEach>
                            
                            <!-- Empty State -->
                            <c:if test="${empty parties}">
                                <tr>
                                <td colspan="5" class="text-center py-4">
                                    <div class="text-muted">
                                    <i class="bi bi-people fs-1 mb-2 d-block"></i>
                                    <p class="mb-0">No parties added yet</p>
                                    <small>Click "Add Grantor" or "Add Applicant" to get started</small>
                                    </div>
                                </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Transaction Management
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                    </div>
                </div>
                <input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id">
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="newTransactionModal" tabindex="-1" aria-labelledby="newTransactionModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="newTransactionModalLabel">
                    <i class="fas fa-user-tie me-2"></i>
                    Transaction Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <form id="form_add_transaction">
                    
                    <!-- Hidden Fields -->
                    <input type="hidden" id="tr_id" name="tr_id" value="0">
                    
                    <!-- Form Content -->
                    <div class="row g-4" style="height: 100vh;">
                        
                        <!-- Left Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">

                          <div class="row g-4">
                            <div class="col-lg-6">
                              <!-- Case Number -->
                              <div class="mb-3">
                                  <label for="tr_case_number" class="form-label fw-medium">
                                      <i class="fas fa-hashtag me-1"></i>
                                      Case Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-folder"></i>
                                      </span>
                                      <input type="text" name="tr_case_number" id="tr_case_number" 
                                            value="${case_number}" class="form-control" required readonly>
                                  </div>
                              </div>
                              
                              <!-- Registered Number -->
                              <div class="mb-3">
                                  <label for="tr_registration_number" class="form-label fw-medium">
                                      <i class="fas fa-certificate me-1"></i>
                                      Transaction Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-hashtag"></i>
                                      </span>
                                      <input type="text" name="tr_registration_number" id="tr_registration_number" 
                                            value="${registered_number}" class="form-control" required>
                                  </div>
                              </div>
                              
                              <!-- Proprietor/Grantee -->
                              <div class="mb-3">
                                  <label for="tr_proprietor" class="form-label fw-medium">
                                      <i class="fas fa-user me-1"></i>
                                      Proprietor/Grantee
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-user-check"></i>
                                      </span>
                                      <input type="text" name="tr_proprietor" id="tr_proprietor" 
                                            value="${ar_name}" class="form-control" required>
                                  </div>
                              </div>
                              
                              <!-- Date of Instrument -->
                              <div class="mb-3">
                                  <label for="tr_date_of_instrument" class="form-label fw-medium">
                                      <i class="fas fa-calendar-alt me-1"></i>
                                      Date of Instrument
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-calendar"></i>
                                      </span>
                                      <input type="date" name="tr_date_of_instrument" id="tr_date_of_instrument" 
                                            class="form-control" required>
                                  </div>
                              </div>
                              
                              <!-- Nature of Instrument -->
                              <div class="mb-3">
                                  <label for="tr_nature_of_instrument" class="form-label fw-medium">
                                      <i class="fas fa-file-contract me-1"></i>
                                      Nature of Instrument
                                  </label>
                                  <textarea id="tr_nature_of_instrument" name="tr_nature_of_instrument" 
                                            class="form-control" rows="3" required
                                            placeholder="Describe the nature of the instrument"></textarea>
                                  <div class="form-text">
                                      <i class="fas fa-lightbulb me-1"></i>
                                      Examples: Lease, Conveyance, Mortgage, Gift, etc.
                                  </div>
                              </div>

                            </div>

                            <div class="col-lg-6">
                              <!-- Date of Registration -->
                              <div class="mb-3">
                                  <label for="tr_date_of_registration" class="form-label fw-medium">
                                      <i class="fas fa-calendar-check me-1"></i>
                                      Date of Registration
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-calendar-day"></i>
                                      </span>
                                      <input type="date" name="tr_date_of_registration" id="tr_date_of_registration" 
                                            class="form-control" required>
                                  </div>
                              </div>
                              
                              <!-- Term -->
                              <div class="mb-3">
                                  <label for="tr_term" class="form-label fw-medium">
                                      <i class="fas fa-clock me-1"></i>
                                      Term
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-history"></i>
                                      </span>
                                      <input type="text" name="tr_term" id="tr_term" 
                                            class="form-control" required 
                                            placeholder="e.g., 50 years, Perpetual">
                                  </div>
                              </div>
                              
                              <!-- Grantor -->
                              <div class="mb-3">
                                  <label for="tr_transferor" class="form-label fw-medium">
                                      <i class="fas fa-user-minus me-1"></i>
                                      Grantor (Transferor)
                                  </label>
                                  <textarea name="tr_transferor" id="tr_transferor" 
                                            class="form-control" rows="3" required
                                            placeholder="Enter grantor details"></textarea>
                              </div>
                              
                              <!-- Grantee -->
                              <div class="mb-3">
                                  <label for="tr_transferee" class="form-label fw-medium">
                                      <i class="fas fa-user-plus me-1"></i>
                                      Grantee (Transferee)
                                  </label>
                                  <textarea name="tr_transferee" id="tr_transferee" 
                                            class="form-control" rows="3" required
                                            placeholder="Enter grantee details">${ar_name}</textarea>
                              </div>
                              
                              <!-- Price Paid -->
                              <div class="mb-3">
                                  <label for="tr_price_paid" class="form-label fw-medium">
                                      <i class="fas fa-money-bill-wave me-1"></i>
                                      Price Paid
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-dollar-sign"></i>
                                      </span>
                                      <input type="text" name="tr_price_paid" id="tr_price_paid" 
                                            class="form-control" required 
                                            placeholder="Enter amount">
                                  </div>
                              </div>
                              
                            </div>
                            <div class="col-12">
                                
                                <!-- Remarks -->
                                <div class="mb-3">
                                    <label for="tr_remarks" class="form-label fw-medium">
                                        <i class="fas fa-sticky-note me-1"></i>
                                        Remarks
                                    </label>
                                    <textarea name="tr_remarks" id="tr_remarks" 
                                              class="form-control" rows="3" required
                                              placeholder="Additional remarks or notes"></textarea>
                                </div>
                                
                                <!-- Signed By -->
                                <div class="mb-3">
                                    <label for="tr_signature" class="form-label fw-medium">
                                        <i class="fas fa-signature me-1"></i>
                                        Signed By
                                    </label>
                                    <textarea name="tr_signature" id="tr_signature" 
                                              class="form-control" rows="2" required
                                              placeholder="Names and signatures of authorized persons"></textarea>
                                </div>
                                
                            </div>
                          </div>

                    
                          <!-- Modal Footer -->
                          <div class="border-top bg-light p-3 rounded" style="margin-top: auto !important;">
                              <div class="d-flex justify-content-between w-100 align-items-center">
                                  <div>
                                      <!-- <button type="button" class="btn btn-outline-danger btn_reg_root_delete_action" 
                                              data-action_type='proprietor'>
                                          <i class="fas fa-trash me-1"></i>
                                          Delete
                                      </button> -->
                                  </div>
                                  <div class="d-flex gap-2">
                                      <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                          <i class="fas fa-times me-1"></i>
                                          Cancel
                                      </button>
                                      <button type="submit" id="btn_transaction" class="btn btn-primary">
                                          <i class="fas fa-save me-1"></i>
                                          Save Changes
                                      </button>
                                  </div>
                              </div>
                          </div>
                        </div>
                        
                        <!-- Right Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">
                            
                            <div class="_gated_workflow_documents"></div>
                        </div>
                        
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="view_parcel_and_transaction_for_deed" tabindex="-1"
     aria-labelledby="view_parcel_and_transaction_for_deed_label" aria-hidden="true" data-bs-backdrop="static">
     <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="view_parcel_and_transaction_label">
                    <i class="fas fa-map-marked-alt me-2"></i>
                    View Parcel and Transaction
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Summary Card -->
                <div class="card border-0 bg-light mb-4">
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-sm bg-primary bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
                                        <i class="fas fa-hashtag text-primary"></i>
                                    </div>
                                    <div>
                                        <div class="text-muted small">Case Number</div>
                                        <div class="h6 mb-0">${empty fn:trim(case_number) ? '--' : fn:trim(case_number)}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-sm bg-success bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
                                        <i class="fas fa-file-contract text-success"></i>
                                    </div>
                                    <div>
                                        <div class="text-muted small">Job Number</div>
                                        <div class="h6 mb-0">${empty fn:trim(job_number) ? '--' : fn:trim(job_number)}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-sm bg-info bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
                                        <i class="fas fa-user text-info"></i>
                                    </div>
                                    <div>
                                        <div class="text-muted small">Applicant</div>
                                        <div class="h6 mb-0">${empty fn:trim(ar_name) ? '--' : fn:trim(ar_name)}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Tabs Navigation -->
                <ul class="nav nav-tabs mb-3 tab-style-6" id="parcelTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="details-tab-deed" data-bs-toggle="tab" 
                                data-bs-target="#details-deed" type="button" role="tab">
                            <i class="fas fa-info-circle me-2"></i>
                            Transaction Details
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="location-tab-deed" data-bs-toggle="tab" 
                                data-bs-target="#location-deed" type="button" role="tab">
                            <i class="fas fa-map-marker-alt me-2"></i>
                            Location Details
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="financial-tab-deed" data-bs-toggle="tab" 
                                data-bs-target="#financial-deed" type="button" role="tab">
                            <i class="fas fa-money-bill-wave me-2"></i>
                            Financial Details
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="map-tab-deed" data-bs-toggle="tab" 
                                data-bs-target="#map-deed" type="button" role="tab">
                            <i class="fas fa-map me-2"></i>
                            Map Visualization
                        </button>
                    </li>
                </ul>
                
                <!-- Tab Content -->
                <div class="tab-content" id="parcelTabContent">
                    
                    <!-- Transaction Details Tab -->
                    <div class="tab-pane fade show active" id="details-deed" role="tabpanel">
                        <div class="row g-3">
                            <!-- Column 1 -->
                            <div class="col-md-6">
                                <div class="card border h-100">
                                    <div class="card-header bg-light py-2">
                                        <h6 class="mb-0">
                                            <i class="fas fa-file-alt me-2"></i>
                                            Basic Information
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Transaction Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(transaction_number) ? '--' : fn:trim(transaction_number)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Regional Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(regional_number) ? '--' : fn:trim(regional_number)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Date of Document</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(date_of_document) ? '--' : fn:trim(date_of_document)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Date of Registration</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(date_of_registration) ? '--' : fn:trim(date_of_registration)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Nature of Instrument</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(nature_of_instrument) ? '--' : fn:trim(nature_of_instrument)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Type of Interest</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(type_of_interest) ? '--' : fn:trim(type_of_interest)}</div>
                                            </div>
                                            <!-- <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Date of Issue</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(date_of_issue) ? '--' : fn:trim(date_of_issue)}</div>
                                            </div> -->
                                            <div class="col-md-6">
                                                <label class="form-label text-muted small mb-1">Extent of Land</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(intended_parcel) ? '--' : fn:trim(intended_parcel)}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label text-muted small mb-1">Extent of Interest</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(intended_interest) ? '--' : fn:trim(intended_interest)}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Column 2 -->
                            <div class="col-md-6">
                                <div class="card border h-100">
                                    <div class="card-header bg-light py-2">
                                        <h6 class="mb-0">
                                            <i class="fas fa-calendar-alt me-2"></i>
                                            Term & Renewal & Generated Numbers
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Term</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(term) ? '--' : fn:trim(term)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Type of Use</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(type_of_use) ? '--' : fn:trim(type_of_use)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Commencement Date</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(commencement_date) ? '--' : fn:trim(commencement_date)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Option for Renewal</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(renewal_term) ? '--' : fn:trim(renewal_term)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Deed Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(deed_number) ? '--' : fn:trim(deed_number)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Serial Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(serial_number) ? '--' : fn:trim(serial_number)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">File Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(file_number) ? '--' : fn:trim(file_number)}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label text-muted small mb-1">Rent Review Period</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(rent_review_period) || consideration_fee_adopted_rate == '0' ? '--' : fn:trim(rent_review_period)}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label text-muted small mb-1">Ground Rent</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(ground_rent) || consideration_fee_adopted_rate == '0' ? '--' : fn:trim(ground_rent)}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label text-muted small mb-1">Consideration in Document</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee) || consideration_fee == '0' ? '--' : fn:trim(consideration_fee)}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label text-muted small mb-1">Consideration Currency</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee_currency) ? '--' : fn:trim(consideration_fee_currency)}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Column 3 -->
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header bg-success bg-opacity-10 justify-content-between">
                                        <div class="card-title text-primary">
                                            <i class="bi bi-receipt me-2"></i>Parties
                                        </div>
                                    </div>
                                    <div class="card-body">

                                        <table class="table table-hover table-sm mb-0" id="party_details_datatable">
                                            <thead class="table-light">
                                            <tr>
                                                <th width="25%">
                                                <i class="bi bi-person me-1"></i>Name
                                                </th>
                                                <th width="10%">
                                                <i class="bi bi-gender-ambiguous me-1"></i>Sex
                                                </th>
                                                <th width="20%">
                                                <i class="bi bi-telephone me-1"></i>Contact
                                                </th>
                                                <th width="20%">
                                                <i class="bi bi-address me-1"></i>Address
                                                </th>
                                                <th width="20%">
                                                <i class="bi bi-person-badge me-1"></i>Role
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${parties}" var="parties_row">
                                                <tr>
                                                <td class="align-middle">
                                                    <div class="fw-semibold">${parties_row.ar_name}</div>
                                                </td>
                                                <td class="align-middle">
                                                    <span class="badge ${parties_row.ar_gender == 'MALE' ? 'bg-info' : parties_row.ar_gender == 'FEMALE' ? 'bg-pink' : 'bg-secondary'}">
                                                    ${parties_row.ar_gender == 'MALE' ? 'Male' : parties_row.ar_gender == 'FEMALE' ? 'Female' : 'Other'}
                                                    </span>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="contact-info">
                                                    <div class="d-flex align-items-center mb-1">
                                                        <i class="bi bi-phone text-primary me-2"></i>
                                                        <small>${empty fn:trim(parties_row.ar_cell_phone) ? '--' : fn:trim(parties_row.ar_cell_phone)}</small>
                                                    </div>
                                                    <c:if test="${not empty parties_row.ar_cell_phone2}">
                                                        <div class="d-flex align-items-center">
                                                        <i class="bi bi-telephone-plus text-secondary me-2"></i>
                                                        <small>${empty fn:trim(parties_row.ar_cell_phone2) ? '--' : fn:trim(parties_row.ar_cell_phone2)}</small>
                                                        </div>
                                                    </c:if>
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <div class="contact-info">
                                                        <div class="d-flex align-items-center mb-1">
                                                            <i class="bi bi-address text-primary me-2"></i>
                                                            <small>${empty fn:trim(parties_row.ar_address) ? '--' : fn:trim(parties_row.ar_address)}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="align-middle">
                                                    <span class="badge ${parties_row.type_of_party == 'Grantor' ? 'bg-success' : parties_row.type_of_party == 'Applicant' ? 'bg-warning' : 'bg-info'}">
                                                    ${parties_row.type_of_party}
                                                    </span>
                                                </td>
                                                </tr>
                                            </c:forEach>
                                            
                                            <!-- Empty State -->
                                            <c:if test="${empty parties}">
                                                <tr>
                                                <td colspan="5" class="text-center py-4">
                                                    <div class="text-muted">
                                                    <i class="bi bi-people fs-1 mb-2 d-block"></i>
                                                    <p class="mb-0">No parties added yet</p>
                                                    <small>Click "Add Grantor" or "Add Applicant" to get started</small>
                                                    </div>
                                                </td>
                                                </tr>
                                            </c:if>
                                            </tbody>
                                        </table>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Location Details Tab -->
                    <div class="tab-pane fade" id="location-deed" role="tabpanel">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="card border h-100">
                                    <div class="card-header bg-light py-2">
                                        <h6 class="mb-0">
                                            <i class="fas fa-globe-africa me-2"></i>
                                            Location Information
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Region</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(region) ? '--' : fn:trim(region)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">District</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(district) ? '--' : fn:trim(district)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2 mb-3">
                                            <div class="col-12">
                                                <label class="form-label small text-muted mb-1">Locality</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(locality) ? '--' : fn:trim(locality)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Size of Land</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(size_of_land) ? '--' : fn:trim(size_of_land)}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
            
                        </div>
                    </div>
                    
                    <!-- Financial Details Tab -->
                    <div class="tab-pane fade" id="financial-deed" role="tabpanel">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="card border h-100">
                                    <div class="card-header bg-light py-2">
                                        <h6 class="mb-0">
                                            <i class="fas fa-calculator me-2"></i>
                                            Assessment Values
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-12">
                                                <label class="form-label small text-muted mb-1">Assessed Value</label>
                                                <div class="h5 fw-bold text-primary">${empty fn:trim(assessed_value) ? '--' : fn:trim(assessed_value)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Stamp Duty Payable</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(stamp_duty_payable) ? '--' : fn:trim(stamp_duty_payable)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Consideration in Document</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee) ? '--' : fn:trim(consideration_fee)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Consideration Currency</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee_currency) ? '--' : fn:trim(consideration_fee_currency)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Adopted Currency Rate</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee_adopted_rate) ? '--' : fn:trim(consideration_fee_adopted_rate)}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Map Visualization Tab -->
                    <div class="tab-pane fade border-0" id="map-deed" role="tabpanel">
                      <div class="row g-3"></div>
                        <div class="card border h-100">
                            <div class="card-header bg-light py-2">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0">
                                        <i class="fas fa-map me-2"></i>
                                        Map Visualization
                                    </h6>
                                    <div class="btn-group" role="group">
                                        <button type="button" class="btn btn-primary btn-sm" 
                                                id="lc_btn_visualise_wkt_" data-bs-toggle="tooltip" 
                                                data-bs-placement="top" title="Visualise Polygon">
                                            <i class="fas fa-map me-1"></i>
                                            Visualise
                                        </button>
                                        <button type="button" class="btn btn-outline-primary btn-sm" 
                                                id="lc_btn_visualise_search" data-bs-toggle="tooltip" 
                                                data-bs-placement="top" title="Visualise Search">
                                            <i class="fas fa-search me-1"></i>
                                            Search
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="lc_btnprintmap" data-bs-toggle="tooltip" 
                                                data-bs-placement="top" title="Print Map">
                                            <i class="fas fa-print me-1"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                
                                <!-- WKT Polygon Input -->
                                <div class="mb-3">
                                    <label for="lc_bl_wkt_polygon" class="form-label fw-medium">
                                        <i class="fas fa-draw-polygon me-1"></i>
                                        WKT Polygon
                                    </label>
                                    <div class="input-group">
                                        <input class="form-control" id="lc_bl_wkt_polygon" 
                                               name="lc_bl_wkt_polygon" type="text" value="${parcel_wkt}"
                                               placeholder="WKT polygon coordinates">
                                        <button class="btn btn-outline-secondary" type="button" 
                                                id="btn_copy_wkt" data-bs-toggle="tooltip" 
                                                data-bs-placement="top" title="Copy WKT">
                                            <i class="fas fa-copy"></i>
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Map Controls -->
                                <div class="d-flex flex-wrap gap-2 align-items-center mb-3">
                                    <div class="d-flex align-items-center me-3">
                                        <label class="me-2 mb-0">Scale:</label>
                                        <div class="input-group input-group-sm me-2" style="width: 120px;">
                                            <input class="form-control form-control-sm" id="lc_scale_value_e" 
                                                   name="lc_scale_value_e" type="text" placeholder="Custom scale">
                                        </div>
                                        <select class="form-select form-select-sm" name="lc_scale_value" 
                                                id="lc_scale_value" style="width: 120px;">
                                            <option value="500">1:500</option>
                                            <option value="1107">1:1,107</option>
                                            <option value="1250">1:1,250</option>
                                            <option value="2140">1:2,140</option>
                                            <option value="2215">1:2,215</option>
                                            <option value="2500">1:2,500</option>
                                            <option value="2670">1:2,670</option>
                                            <option value="2825">1:2,825</option>
                                            <option value="5000" selected>1:5,000</option>
                                            <option value="10000">1:10,000</option>
                                            <option value="15000">1:15,000</option>
                                            <option value="20000">1:20,000</option>
                                        </select>
                                    </div>
                                    
                                    <div class="d-flex align-items-center">
                                        <div class="form-check me-2">
                                            <input class="form-check-input" type="checkbox" 
                                                   checked id="lc_lockmapscale">
                                            <label class="form-check-label small mb-0" for="lc_lockmapscale">
                                                Lock Scale
                                            </label>
                                        </div>
                                        <button type="button" class="btn btn-outline-primary btn-sm" 
                                                id="lc_btn_scale_zoom" data-bs-toggle="tooltip" 
                                                data-bs-placement="top" title="Zoom to Scale">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                    
                                    <div class="ms-auto btn-group" role="group">
                                        <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_zoom_full">
                                            <i class="fas fa-expand"></i>
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_zoom_out">
                                            <i class="fas fa-search-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_zoom_in">
                                            <i class="fas fa-search-plus"></i>
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Map Container -->
                                <div class="mt-3 w-100">
                                  <div id="lc-map__deed"></div>
                                </div>
                                
                            </div>
                        </div>

                         <!-- Confirm Transaction Button -->
                        <div class="mt-4">
                            <button type="button" id="btn_confirm_registration_transaction_deed" 
                                    class="btn btn-success w-100 py-3 d-none">
                                <div class="d-flex align-items-center justify-content-center">
                                    <i class="fas fa-check-circle fa-lg me-3"></i>
                                    <div class="text-start">
                                        <div class="fw-medium">Confirm Transaction</div>
                                        <small class="d-block opacity-75">Finalize and approve this registration transaction</small>
                                    </div>
                                </div>
                            </button>
                        </div>
                    </div>
                </div>
            
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Viewing details for transaction: ${transaction_number}
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        <!-- <button type="button" class="btn btn-outline-primary" id="btn_export_details">
                            <i class="fas fa-download me-1"></i>
                            Export
                        </button>
                        <button type="button" class="btn btn-outline-info" id="btn_print_details">
                            <i class="fas fa-print me-1"></i>
                            Print
                        </button> -->
                    </div>
                </div>
            </div>
            
        </div>
     </div>
     </div>
</div>

<div class="modal fade effect-scale modal-blur" id="check_availability_of_mother_file_for_deed" tabindex="-1"
     aria-labelledby="checkMotherFileModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="checkMotherFileModalLabel">
          <i class="fas fa-archive me-2"></i>
          Check Availability of Mother File
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Search Form Card -->
        <div class="card">
          <div class="card-header bg-primary bg-opacity-10 text-primary">
            <h6 class="mb-0">
              <i class="fas fa-search me-2"></i>
              Search Mother File
            </h6>
          </div>
          <div class="card-body">
            <form id="linkSearchMotherfile_deed" method="post">
              
              <!-- Search Type Selection -->
              <div class="mb-4">
                <label class="form-label fw-medium mb-3">
                  <i class="fas fa-filter me-1"></i>
                  Search By:
                </label>
                <div class="d-flex flex-wrap gap-3">
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type_d" 
                           id="rbtn_search_type3_d" value="job_number" required>
                    <label class="form-check-label" for="rbtn_search_type3_d">
                      Job Number
                    </label>
                  </div>
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type_d" 
                           id="rbtn_search_type4_d" value="serial_number" required>
                    <label class="form-check-label" for="rbtn_search_type4_d">
                      Deed Number/ Serial Number
                    </label>
                  </div>
                </div>
              </div>
              
              <!-- Search Input -->
              <div class="row g-3 align-items-end">
                <div class="col-md-8">
                  <div class="form-group">
                    <label for="link_search_value" class="form-label fw-medium">
                      <i class="fas fa-keyboard me-1"></i>
                      Search Value
                    </label>
                    <div class="input-group">
                      <span class="input-group-text">
                        <i class="fas fa-search"></i>
                      </span>
                      <input class="form-control" id="link_search_value_d" name="link_search_value_d" 
                             type="text" placeholder="Enter job number or certificate number" required>
                    </div>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <button type="submit" class="btn btn-primary w-100" id="btnEnquiryJobSearch_d">
                      <i class="fas fa-search me-2"></i>
                      Search
                    </button>
                  </div>
                </div>
              </div>
              
              <div class="form-text">
                Enter the job number or certificate number to search for mother file
              </div>
            </form>
          </div>
        </div>
        
        <!-- Search Results Card -->
        <div class="card border-success mt-4" style="display:none" id="link-search-results-section-deed">
          <div class="card-header bg-success bg-opacity-10 text-success">
            <div class="d-flex justify-content-between align-items-center">
              <h6 class="mb-0">
                <i class="fas fa-file-alt me-2"></i>
                Search Results
              </h6>
              <span class="badge bg-success" id="resultsCount_d">0 results</span>
            </div>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-hover table-striped" id="link-search-results-table-deed">
                <thead class="table-light">
                  <tr>
                    <th width="25%">
                      <!-- <i class="fas fa-user me-1"></i> -->
                      Applicant Name
                    </th>
                    <th width="30%">
                      <!-- <i class="fas fa-certificate me-1"></i> -->
                      Serial Number/ Deed Number
                    </th>
                    <th width="15%">
                      <!-- <i class="fas fa-hashtag me-1"></i> -->
                      Job Number
                    </th>
                    <th width="20%">
                      <!-- <i class="fas fa-map-marker-alt me-1"></i> -->
                      Locality
                    </th>
                    <th width="10%" class="text-end">
                      <!-- <i class="fas fa-cogs me-1"></i> -->
                      Actions
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <!-- Results will be populated here -->
                </tbody>
              </table>
            </div>
            
            <!-- No Results Message -->
            <div id="noResultsMessage_d" class="text-center py-5 d-none">
              <div class="mb-3">
                <i class="fas fa-file-excel fa-3x text-muted"></i>
              </div>
              <h6 class="text-muted">No Mother Files Found</h6>
              <p class="text-muted small">Try searching with a different job number or certificate number</p>
            </div>
            
            <!-- Loading State -->
            <div id="loadingResults_d" class="text-center py-5 d-none">
              <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
              <p class="mt-3 text-muted">Searching for mother files...</p>
            </div>
            
          </div>
        </div>
        
        <!-- Information Alert -->
        <div class="alert alert-info bg-info bg-opacity-10 border-info mt-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>About Mother Files:</strong>
              <p class="mb-0 mt-2">
                Mother files contain the original documents and records for each land registration case.
                Use this search to check if a mother file exists for a specific job or certificate.
              </p>
            </div>
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="transitional_certificate_template_deed" tabindex="-1"
     aria-labelledby="certificateAndRegisterDetailsLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center justify-content-between w-100">
                    <div>
                        <!-- <i class="fas fa-certificate me-2"></i> -->
                        <h5 class="modal-title text-white mb-0" id="certificateAndRegisterDetailsLabel">
                            Certificate and Transaction Details
                        </h5>
                        <small class="opacity-75 text-white" id="modalCaseNumber">Case: Loading...</small>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-0">

                <input type="hidden" id="certificateAndRegisterDetailsCaseNumber_deed">
                <input type="hidden" id="certificateAndRegisterDetailsTransactionNumber_deed">
                <input type="hidden" id="certificateAndRegisterDetailsJobNumber_deed">
                
                <!-- Case Details Section -->
                <div class="accordion" id="caseDetailsAccordion_deed">
                    
                    <!-- Case Details Card -->
                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="caseDetailsHeading">
                            <button class="accordion-button bg-light text-dark fw-bold py-3 collapsed" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#caseDetailsAccordion_deed" 
                                    aria-expanded="false" aria-controls="caseDetailsAccordion_deed">
                                <div class="d-flex align-items-center w-100">
                                    <i class="fas fa-folder-open text-primary me-3 fa-lg"></i>
                                    <div>
                                        <h6 class="mb-0">Case Details</h6>
                                        <small class="text-muted">Complete case information and registration details</small>
                                    </div>
                                </div>
                            </button>
                        </h2>
                        <div id="caseDetailsAccordion_deed" class="accordion-collapse collapse" 
                             aria-labelledby="caseDetailsHeading" data-bs-parent="#caseDetailsAccordion_deed">
                            <div class="accordion-body bg-white p-4">
                                
                                <!-- Case Information Grid -->
                                <div class="row g-4">
                                    
                                    <!-- Basic Information -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i>Basic Information</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <label class="form-label small text-muted mb-1">Case Number</label>
                                                            <div class="d-flex align-items-center">
                                                                <i class="fas fa-hashtag text-primary me-2"></i>
                                                                <span class="fw-medium" id="ts_main_case_number_sm_d">-</span>
                                                            </div>
                                                        </div>
                                                        <span class="badge bg-primary bg-opacity-10 text-primary">ID</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Regional Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-map-marker-alt text-primary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_regional_number_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Locality</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-location-dot text-primary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_locality_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Transaction Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-exchange-alt text-primary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_transaction_number_sm_d">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    
                                    <!-- Land Details -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-mountain me-2 text-warning"></i>Land Information</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <label class="form-label small text-muted mb-1">Size of Land</label>
                                                            <div class="d-flex align-items-center">
                                                                <i class="fas fa-expand text-warning me-2"></i>
                                                                <span class="fw-medium" id="ts_main_size_of_land_sm_d">-</span>
                                                            </div>
                                                        </div>
                                                        <span class="badge bg-warning bg-opacity-10 text-warning">Area</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">GLPIN</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-fingerprint text-warning me-2"></i>
                                                        <span class="fw-medium" id="ts_main_glpin_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Region</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-globe text-warning me-2"></i>
                                                        <span class="fw-medium" id="ts_main_region_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">District</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-building text-success me-2"></i>
                                                        <span class="fw-medium" id="ts_main_district_sm_d">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Document Details -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-file-contract me-2 text-info"></i>Document Information</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Date of Document</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-calendar text-info me-2"></i>
                                                        <span class="fw-medium" id="ts_main_date_of_document_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Nature of Instrument</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-gavel text-info me-2"></i>
                                                        <span class="fw-medium" id="ts_main_nature_of_instrument_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Type of Interest</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-handshake text-info me-2"></i>
                                                        <span class="fw-medium" id="ts_main_type_of_interest_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Type of Use</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-tag text-info me-2"></i>
                                                        <span class="fw-medium" id="ts_main_type_of_use_sm_d">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Financial Details -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-money-bill-wave me-2 text-danger"></i>Financial Details</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <label class="form-label small text-muted mb-1">Assessed Value</label>
                                                            <div class="d-flex align-items-center">
                                                                <i class="fas fa-balance-scale text-danger me-2"></i>
                                                                <span class="fw-medium" id="ts_main_assessed_value_sm_d">-</span>
                                                            </div>
                                                        </div>
                                                        <span class="badge bg-danger bg-opacity-10 text-danger">Value</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Stamp Duty Payable</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-receipt text-danger me-2"></i>
                                                        <span class="fw-medium" id="ts_main_stamp_duty_payable_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Consideration Fee</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-hand-holding-usd text-danger me-2"></i>
                                                        <span class="fw-medium" id="ts_main_consideration_fee_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Consideration Currency</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-coins text-danger me-2"></i>
                                                        <span class="fw-medium" id="ts_main_case_consideration_fee_currency_sm_d">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Dates & Applicant -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-calendar-alt me-2 text-purple"></i>Dates & Applicant</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Commencement Date</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-play text-purple me-2"></i>
                                                        <span class="fw-medium" id="ts_main_commencement_date_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Date of Registration</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-calendar-check text-purple me-2"></i>
                                                        <span class="fw-medium" id="ts_main_date_of_registration_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Publication Date</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-newspaper text-purple me-2"></i>
                                                        <span class="fw-medium" id="ts_main_publicity_date_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Applicant Name</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-user text-purple me-2"></i>
                                                        <span class="fw-medium" id="ts_main_ar_name_sm_d">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Reference Numbers -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-hashtag me-2 text-teal"></i>Reference Numbers</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Job Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-briefcase text-teal me-2"></i>
                                                        <span class="fw-medium" id="ts_main_job_number_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Certificate Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-certificate text-teal me-2"></i>
                                                        <span class="fw-medium" id="ts_main_certificate_number_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Registered Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-registered text-teal me-2"></i>
                                                        <span class="fw-medium" id="ts_main_case_registered_number_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Date of Issue</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-calendar-day text-teal me-2"></i>
                                                        <span class="fw-medium" id="ts_main_case_date_of_issue_sm_d">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Additional Details -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-ellipsis-h me-2 text-secondary"></i>Additional Details</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Term</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-clock text-secondary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_term_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Adopted Rate</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-percentage text-secondary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_case_consideration_fee_adopted_rate_sm_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Interest Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-hashtag text-secondary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_interest_number_d">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Sub-Interest Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-hashtag text-secondary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_sub_interest_number_d">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Root of Title Section -->
                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="rootOfTitleHeading_deed">
                            <button class="accordion-button bg-light text-dark fw-bold py-3 collapsed" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#rootOfTitleCollapse_deed" 
                                    aria-expanded="false" aria-controls="rootOfTitleCollapse_deed">
                                <div class="d-flex align-items-center w-100">
                                    <i class="fas fa-sitemap text-success me-3 fa-lg"></i>
                                    <div>
                                        <h6 class="mb-0">Transaction Details</h6>
                                        <!-- <small class="text-muted">Proprietorship, memorials, valuations, certificates & encumbrances</small> -->
                                    </div>
                                </div>
                            </button>
                        </h2>
                        <div id="rootOfTitleCollapse_deed" class="accordion-collapse collapse" 
                             aria-labelledby="rootOfTitleHeading_deed" data-bs-parent="#caseDetailsAccordion_deed">
                            <div class="accordion-body bg-white p-4">
                                
                                <!-- Proprietorship Details -->
                                <div class="card border-light shadow-sm mb-4">
                                    <div class="card-header bg-success bg-opacity-10 border-success">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0">
                                                <i class="fas fa-user-tie text-success me-2"></i>
                                                Transaction Details
                                            </h6>
                                            <span class="badge bg-success" id="proprietorshipCount_d">0</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-sm" id="lrd_proprietorship_details_dataTable_3">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th><i class="fas fa-hashtag me-1"></i> Registered No.</th>
                                                        <th><i class="fas fa-user me-1"></i> Grantee</th>
                                                        <th><i class="fas fa-calendar-alt me-1"></i> Date of Instrument</th>
                                                        <th><i class="fas fa-file-contract me-1"></i> Nature of Instrument</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Data will be populated here -->
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="text-center py-4" id="noProprietorship_d">
                                            <i class="fas fa-user-tie fa-2x text-muted mb-3"></i>
                                            <p class="text-muted mb-0">No transaction records found</p>
                                        </div>
                                    </div>
                                </div>
                               
                            </div>
                        </div>
                    </div>
                    
                    <!-- Documents Section -->
                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="documentsHeading_deed">
                            <button class="accordion-button bg-light text-dark fw-bold py-3 collapsed" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#documentsCollapse_deed" 
                                    aria-expanded="false" aria-controls="documentsCollapse_deed">
                                <div class="d-flex align-items-center w-100">
                                    <i class="fas fa-file-alt text-info me-3 fa-lg"></i>
                                    <div>
                                        <h6 class="mb-0">Documents on Application</h6>
                                        <small class="text-muted">Scanned documents and attachments</small>
                                    </div>
                                </div>
                            </button>
                        </h2>
                        <div id="documentsCollapse_deed" class="accordion-collapse collapse" 
                             aria-labelledby="documentsHeading_deed" data-bs-parent="#caseDetailsAccordion_deed">
                            <div class="accordion-body bg-white p-4">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <button type="button" class="btn btn-outline-info" id="btn_load_scanned_documents_ts_deed">
                                        <i class="fas fa-eye me-2"></i>
                                        Load Documents
                                    </button>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm" id="lc_main_scanned_documents_dataTable_ts_deed">
                                        <thead class="table-light">
                                            <tr>
                                                <th><i class="fas fa-file me-1"></i> Document Name</th>
                                                <th><i class="fas fa-file-alt me-1"></i> Document Type</th>
                                                <th class="text-center"><i class="fas fa-cog me-1"></i> Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="documentsTableBody_ts_d">
                                            <!-- Data will be populated here -->
                                        </tbody>
                                    </table>
                                </div>
                                <div class="text-center py-5" id="tsNoDocuments_d">
                                    <i class="fas fa-file-alt fa-3x text-muted mb-3"></i>
                                    <h6 class="text-muted mb-2">No Documents Found</h6>
                                    <p class="text-muted small">Click "Load Documents" to view case documents</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>
                    Close
                </button>
                <input type="hidden" id="lrd_ps_fid_d" name="lrd_ps_fid">
            </div>

        </div>
    </div>
</div>