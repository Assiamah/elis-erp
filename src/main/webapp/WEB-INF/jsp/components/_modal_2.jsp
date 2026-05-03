<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%> 
<jsp:useBean id="now" class="java.util.Date" />

<div class="modal fade effect-scale modal-blur" id="addNotesModal" tabindex="-1" aria-labelledby="addNotesModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div>
                        <h5 class="modal-title text-white mb-0" id="addNotesModalLabel">
                            <i class="bi bi-journal-plus me-2"></i>Add Note or Report
                        </h5>
                        <p class="mb-0 small opacity-75">Create a new note or report entry</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <form id="form_add_notes">
                    <!-- Hidden Inputs -->
                    <input id="an_id" type="hidden" value="0">
                    <input type="hidden" id="an_job_number" value="${job_number}" class="form-control" required>
                    <input type="hidden" id="an_case_number" value="${case_number}" class="form-control" required>
                    <input type="hidden" id="an_type" value="Normal" class="form-control" required>

                    <!-- Main Content -->
                    <div class="row">
                        <!-- Description Field -->
                        <div class="col-12 mb-4">
                            <div class="card border">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0 fw-semibold">
                                        <i class="bi bi-card-text me-2"></i>Description
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="form-floating">
                                        <textarea id="an_description" class="form-control" 
                                                  placeholder="Enter note description" 
                                                  style="height: 150px" required></textarea>
                                        <label for="an_description">Note Description *</label>
                                    </div>
                                    <div class="form-text">
                                        <i class="bi bi-info-circle me-1"></i>Provide a detailed description of the note or report
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Reference -->
                        <div class="col-12">
                            <div class="card border">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0 fw-semibold">
                                        <i class="bi bi-link-45deg me-2"></i>Quick Reference
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label small fw-medium text-muted mb-1">
                                                <i class="bi bi-briefcase me-1"></i>Job Number
                                            </label>
                                            <div class="input-group input-group-sm">
                                                <input type="text" class="form-control bg-light" 
                                                       value="${job_number}" readonly>
                                                <button class="btn btn-outline-dark" type="button"
                                                        onclick="copyToClipboard('an_job_number')">
                                                    <i class="bi bi-clipboard"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label small fw-medium text-muted mb-1">
                                                <i class="bi bi-file-text me-1"></i>Case Number
                                            </label>
                                            <div class="input-group input-group-sm">
                                                <input type="text" class="form-control bg-light" 
                                                       value="${case_number}" readonly>
                                                <button class="btn btn-outline-dark" type="button"
                                                        onclick="copyToClipboard('an_case_number')">
                                                    <i class="bi bi-clipboard"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer -->
                    <div class="modal-footer bg-light mt-4">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i>Cancel
                        </button>
                        <button type="submit" id="btn_add_notes" class="btn btn-primary">
                            <i class="bi bi-save me-1"></i>Save Note
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="receiveDocsStampingModal" tabindex="-1" aria-labelledby="receiveDocsStampingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="bg-white bg-opacity-10 p-3 rounded-circle">
                            <i class="bi bi-file-earmark-arrow-down text-primary fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h5 class="modal-title text-white mb-0" id="receiveDocsStampingModalLabel">
                            Receive Hardcopy Documents
                        </h5>
                        <p class="mb-0 small opacity-85">Document Receipt for Stamp Duty Processing</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body">
                <form id="frmReceiveDocsStamping">
                    <!-- Application Summary -->
                    <div class="application-summary mb-4">
                        <div class="d-flex align-items-center mb-3">
                            <h4 class="mb-0 text-primary">
                                <i class="bi bi-file-earmark-text me-2"></i>
                                Application Summary
                            </h4>
                            <div class="ms-auto">
                                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-3 py-2">
                                    <i class="bi bi-clock-history me-1"></i>
                                    Document Receipt
                                </span>
                            </div>
                        </div>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" class="form-control bg-light" id="stmp_job_number" readonly>
                                    <label for="stmp_job_number">
                                        <i class="bi bi-briefcase me-1"></i>
                                        Job Number
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" class="form-control bg-light" id="stmp_business_process_sub_name" readonly>
                                    <label for="stmp_business_process_sub_name">
                                        <i class="bi bi-tags me-1"></i>
                                        Application Type
                                    </label>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-floating">
                                    <input type="text" class="form-control bg-light" id="stmp_ar_name" readonly>
                                    <label for="stmp_ar_name">
                                        <i class="bi bi-person-circle me-1"></i>
                                        Applicant Name
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Two Column Layout -->
                    <div class="row g-4">
                        <!-- Left Column - Depositor Details -->
                        <div class="col-lg-6">
                            <div class="depositor-section">
                                <div class="section-header mb-4">
                                    <h5 class="section-title">
                                        <i class="bi bi-person-badge me-2 text-primary"></i>
                                        Depositor Information
                                    </h5>
                                    <div class="section-subtitle">
                                        <small class="text-muted">
                                            <i class="bi bi-info-circle me-1"></i>
                                            Person submitting the documents
                                        </small>
                                    </div>
                                </div>
                                
                                <div class="form-floating mb-3">
                                    <textarea class="form-control" id="smtp_depositor_name" 
                                              placeholder="Depositor's full name" 
                                              style="height: 100px" required></textarea>
                                    <label for="smtp_depositor_name">
                                        <i class="bi bi-person-fill me-1"></i>
                                        Depositor Name
                                        <span class="text-danger">*</span>
                                    </label>
                                    <div class="form-text">
                                        <i class="bi bi-lightbulb me-1"></i>
                                        Enter full name of person submitting documents
                                    </div>
                                </div>
                                
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="smtp_depositor_phone" 
                                           placeholder="Contact number" required
                                           pattern="[0-9\s\-+()]{10,15}"
                                           title="Enter a valid phone number (e.g., 0244 222333)">
                                    <label for="smtp_depositor_phone">
                                        <i class="bi bi-telephone-fill me-1"></i>
                                        Contact Number
                                        <span class="text-danger">*</span>
                                    </label>
                                    <div class="form-text">
                                        <i class="bi bi-info-circle me-1"></i>
                                        Format: 0244 222333 or +233 244 222333
                                    </div>
                                </div>
                                
                                <!-- Additional Depositor Info (Optional) -->
                                <div class="additional-depositor-info mt-4 pt-3 border-top">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="depositorIsApplicant">
                                        <label class="form-check-label" for="depositorIsApplicant">
                                            <i class="bi bi-check-circle me-1"></i>
                                            Depositor is the applicant
                                        </label>
                                    </div>
                                    <div class="form-check mt-2">
                                        <input class="form-check-input" type="checkbox" id="depositorHasID">
                                        <label class="form-check-label" for="depositorHasID">
                                            <i class="bi bi-card-checklist me-1"></i>
                                            ID verified at reception
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Column - Document Details -->
                        <div class="col-lg-6">
                            <div class="document-section">
                                <div class="section-header mb-4">
                                    <h5 class="section-title">
                                        <i class="bi bi-file-earmark-text me-2 text-success"></i>
                                        Document Details
                                    </h5>
                                    <div class="section-subtitle">
                                        <small class="text-muted">
                                            <i class="bi bi-info-circle me-1"></i>
                                            Details of submitted documents
                                        </small>
                                    </div>
                                </div>
                                
                                <!-- Quick Selection Buttons -->
                                <div class="mb-4">
                                    <label class="form-label small fw-medium text-muted mb-2">
                                        <i class="bi bi-lightning-fill me-1"></i>
                                        Quick Document Selection
                                    </label>
                                    <div class="quick-buttons d-flex flex-wrap gap-2 mb-3">
                                        <button type="button" class="btn btn-outline-primary btn-sm quick-doc-btn" 
                                                data-doc="Indenture">
                                            <i class="bi bi-file-earmark me-1"></i>
                                            Indenture
                                        </button>
                                        <button type="button" class="btn btn-outline-primary btn-sm quick-doc-btn" 
                                                data-doc="Site Plan">
                                            <i class="bi bi-map me-1"></i>
                                            Site Plan
                                        </button>
                                        <button type="button" class="btn btn-outline-primary btn-sm quick-doc-btn" 
                                                data-doc="ID Card">
                                            <i class="bi bi-person-badge me-1"></i>
                                            ID Card
                                        </button>
                                        <button type="button" class="btn btn-outline-primary btn-sm quick-doc-btn" 
                                                data-doc="Deed">
                                            <i class="bi bi-file-text me-1"></i>
                                            Deed
                                        </button>
                                        <button type="button" class="btn btn-outline-primary btn-sm quick-doc-btn" 
                                                data-doc="Cover Letter">
                                            <i class="bi bi-envelope me-1"></i>
                                            Cover Letter
                                        </button>
                                    </div>
                                    <div class="quick-buttons d-flex flex-wrap gap-2">
                                        <button type="button" class="btn btn-outline-secondary btn-sm quick-doc-btn" 
                                                data-doc="Photocopy">
                                            <i class="bi bi-copy me-1"></i>
                                            Photocopy
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm quick-doc-btn" 
                                                data-doc="Original">
                                            <i class="bi bi-file-earmark-check me-1"></i>
                                            Original
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm clear-doc-btn">
                                            <i class="bi bi-x-circle me-1"></i>
                                            Clear
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Document Description -->
                                <div class="form-floating">
                                    <textarea class="form-control" id="smtp_document_description" 
                                              placeholder="Document description" 
                                              style="height: 180px" required></textarea>
                                    <label for="smtp_document_description">
                                        <i class="bi bi-card-text me-1"></i>
                                        Document Description
                                        <span class="text-danger">*</span>
                                    </label>
                                    <div class="form-text">
                                        <i class="bi bi-info-circle me-1"></i>
                                        Describe the documents being submitted
                                    </div>
                                </div>
                                
                                <!-- Document Preview -->
                                <div class="document-preview mt-3" id="documentPreview" style="display: none;">
                                    <div class="alert alert-light border">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h6 class="mb-1">
                                                    <i class="bi bi-file-earmark-text me-2 text-primary"></i>
                                                    Selected Documents
                                                </h6>
                                                <p class="mb-0 small text-muted" id="selectedDocsText"></p>
                                            </div>
                                            <button type="button" class="btn btn-sm btn-outline-danger" id="clearSelectedDocs">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Information -->
                    <div class="additional-info-section mt-4 pt-4 border-top">
                        <h6 class="mb-3">
                            <i class="bi bi-gear me-2 text-muted"></i>
                            Additional Information
                        </h6>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="number" class="form-control" id="documentCount" 
                                           placeholder="Number of documents" min="1" max="50" value="1">
                                    <label for="documentCount">
                                        <i class="bi bi-123 me-1"></i>
                                        Number of Documents
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="date" class="form-control" id="receiptDate" 
                                           value="">
                                    <label for="receiptDate">
                                        <i class="bi bi-calendar-event me-1"></i>
                                        Receipt Date
                                    </label>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-floating">
                                    <textarea class="form-control" id="additionalNotes" 
                                              placeholder="Additional notes or remarks" 
                                              style="height: 80px"></textarea>
                                    <label for="additionalNotes">
                                        <i class="bi bi-chat-left-text me-1"></i>
                                        Additional Notes
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Submission Section -->
                    <div class="submission-section mt-5 pt-4 border-top">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="confirmReceipt" required>
                                    <label class="form-check-label" for="confirmReceipt">
                                        <i class="bi bi-shield-check me-1 text-success"></i>
                                        I confirm that I have physically received all documents listed above
                                    </label>
                                </div>
                                <div class="form-check mt-2">
                                    <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                    <label class="form-check-label" for="agreeTerms">
                                        <i class="bi bi-file-earmark-text me-1 text-primary"></i>
                                        I agree to process these documents for stamping as per regulations
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 text-end">
                                <div id="btnSumitRecDocSecion">
                                    <button type="submit" class="btn btn-primary btn-lg px-4 py-3 w-100" 
                                            id="btnSumitRecDoc">
                                        <i class="bi bi-cloud-arrow-up me-2"></i>
                                        Submit Receipt
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Footer -->
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-1"></i>
                    Close
                </button>
                <!-- <button type="button" class="btn btn-outline-primary" onclick="printReceiptForm()">
                    <i class="bi bi-printer me-1"></i>
                    Print Form
                </button> -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="viewFilelistModal" tabindex="-1" aria-labelledby="viewFilelistModalLabel" aria-hidden="true" data-bs-backdrop="static">
   <div class="modal-dialog modal-xl">
      <div class="modal-content">
         <!-- Header - Clean and professional -->
         <div class="modal-header border-bottom">
            <h5 class="modal-title fw-semibold fs-5" id="viewFilelistModalLabel">
               <i class="ri-group-line me-2"></i>File Movement List Processing
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
         <div class="modal-body">
            <input id="lbl_file_type" name="lbl_file_type" type="hidden" value="">
            
            <!-- File Type Selection Card -->
            <div class="card mb-4 shadow-sm border">
               <div class="card-body">
                  <div class="row align-items-center mb-3">
                     <div class="col-md-4">
                        <label class="form-label fw-semibold mb-2">
                           <i class="ri-share-forward-line me-1"></i>Move To:
                        </label>
                        <div class="btn-group w-100" role="group" aria-label="File type selection">
                           <input type="radio" class="btn-check" name="file_type_radio" id="file_type_unit" autocomplete="off" value="Unit">
                           <label class="btn btn-outline-primary" for="file_type_unit">
                              <i class="ri-building-2-line me-1"></i>Unit
                           </label>
                           
                           <input type="radio" class="btn-check" name="file_type_radio" id="file_type_individual" autocomplete="off" value="Individual">
                           <label class="btn btn-outline-primary" for="file_type_individual">
                              <i class="ri-user-line me-1"></i>Individual
                           </label>
                        </div>
                        <input type="hidden" name="file_type" id="file_type">
                        <div class="text-muted small mt-3">
                           <i class="ri-information-line me-1"></i>
                           Select where to move the selected applications
                        </div>
                     </div>
                  </div>
                  
                  <!-- Unit File Section -->
                  <div class="batch-section bg-primary-transparent border rounded p-3 mb-3" id="unit-file-section" style="display: none;">
                     <h6 class="fw-semibold mb-3 text-primary">
                        <i class="ri-building-2-fill me-2"></i>Moving to a Unit
                     </h6>
                     <div class="row g-3">
                        <div class="col-md-6">
                           <label for="file_unit_division_to_send_to" class="form-label fw-medium">
                              Division <span class="text-danger">*</span>
                           </label>
                           <select id="file_unit_division_to_send_to" data-trigger class="form-select">
                              <option value="" selected disabled>Select Division</option>
                              <option value="LVD">LVD</option>
                              <option value="LRD">LRD</option>
                              <option value="PVLMD">PVLMD</option>
                              <option value="SMD">SMD</option>
                              <option value="RLO">RLO</option>
                              <option value="CORPORATE">CORPORATE</option>
                           </select>
                        </div>
                        <div class="col-md-6">
                            <label for="file_to_send_to" class="form-label fw-medium">
                                Unit <span class="text-danger">*</span>
                                <small class="text-muted ms-1" id="file_unit-count">(0 units)</small>
                            </label>
                            <div class="datalist-container">
                                <div class="input-group">
                                    <select class="form-select" 
                                        id="file_unit_to_send_to" 
                                        aria-describedby="unit-help">
                                        <option value="" selected disabled>Select a unit</option>
                                        <!-- Options will be populated dynamically -->
                                    </select>
                                    <span class="input-group-text">
                                        <i class="ri-building-2-line" id="unit-icon"></i>
                                    </span>
                                </div>
                            </div>
                            <div id="file_unit-help" class="form-text">
                                <i class="ri-information-line me-1"></i>
                                Select a unit from the dropdown list
                            </div>
                        </div>
                     </div>
                  </div>
                  
                  <!-- Individual Moving Section -->
                  <div class="batch-section bg-primary-transparent border rounded p-3 mb-3" id="individual-file-section" style="display: none;">
                     <h6 class="fw-semibold mb-3 text-primary">
                        <i class="ri-user-fill me-2"></i>Moving to an Individual
                     </h6>
                     <div class="row g-3">
                       <div class="col-md-6">
                            <label for="division_to_send_to" class="form-label fw-medium">
                                Division/Unit
                            </label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="file_division_to_send_to" 
                                    value="${unit_name}" readonly>
                                <span class="input-group-text">
                                    <i class="ri-lock-line text-muted"></i>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="user_to_send_to" class="form-label fw-medium">
                                User <span class="text-danger">*</span>
                                <small class="text-muted ms-1" id="file_user-count">(0 users)</small>
                            </label>
                            <div class="datalist-container">
                                <div class="input-group">
                                    <select class="form-select" id="file_user_to_send_to" required>
                                        <option value="" selected disabled>Select a user</option>
                                        <!-- Options will be populated dynamically -->
                                    </select>
                                    <span class="input-group-text">
                                        <i class="ri-user-line" id="file_user-icon"></i>
                                    </span>
                                </div>
                            </div>
                            <div id="file_user-help" class="form-text">
                                <i class="ri-information-line me-1"></i>
                                Select a user from the dropdown list
                            </div>
                        </div>
                     </div>
                  </div>
                  
               </div>
            </div>
            
            <!-- File List Table Card -->
            <div class="card shadow-sm border">
               <div class="card-header border-bottom bg-light">
                  <h6 class="mb-0 fw-semibold">
                     <i class="ri-list-check-2 me-2"></i>File List Items
                     <span class="badge bg-primary ms-2" id="file-count">0</span>
                  </h6>
               </div>
               <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped mb-0" id="filelistTable">
                            <thead class="table-light">
                                <tr>
                                    <th class="border-bottom">
                                        <i class="ri-hashtag me-1 text-muted"></i>Reference No.
                                    </th>
                                    <th class="border-bottom">
                                        <i class="ri-file-text-line me-1 text-muted"></i>Application Name
                                    </th>
                                    <th class="border-bottom">
                                        <i class="ri-file-list-3-fill me-1 text-muted"></i>Application Type
                                    </th>
                                    <th class="border-bottom">
                                        <i class="ri-chat-quote-line me-1 text-muted"></i>Locality
                                    </th>
                                    <th class="border-bottom">
                                        <i class="ri-sticky-note-line me-1 text-muted"></i>Purpose
                                    </th>
                                    <th class="border-bottom text-center">
                                        <i class="ri-settings-3-line me-1 text-muted"></i>Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="filelistdataTable">
                                <!-- Data will be populated here -->
                            </tbody>
                        </table>
                    </div>
                  
                  <!-- Empty State -->
                  <div class="text-center py-5" id="empty-file-state">
                        <div class="mb-3">
                            <i class="ri-inbox-line fs-1 text-muted"></i>
                        </div>
                        <h6 class="text-muted mb-2">No items in file list</h6>
                        <p class="text-muted small">Select applications from the table to add them to the file movement</p>
                    </div>
                </div>
            </div>
         </div>
         
         <!-- Footer - Clean and professional -->
         <div class="modal-footer border-top">
            <div class="me-auto">
               <button type="button" class="btn btn-outline-danger" id="remove_all_from_file_list">
                  <i class="ri-delete-bin-line me-1"></i>Clear All
               </button>
            </div>
            <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">
               <i class="ri-close-line me-1"></i>Cancel
            </button>
            <button type="button" id="btn_process_filelist_ft" class="btn btn-primary" >
               <i class="ri-send-plane-fill me-1"></i>Process Movement
            </button>
         </div>
      </div>
   </div>
</div>

<!-- Milestone Details Modal -->
<div class="modal fade effect-fade modal-blur" id="milestoneDetailsModal" tabindex="-1" aria-labelledby="milestoneDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header - Gradient Background -->
            <div class="modal-header bg-primary text-white border-0 py-3">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-white bg-opacity-20 py-2 px-2 me-3">
                        <i class="fas fa-tasks text-primary fa-2x"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white fw-bold" id="milestoneDetailsModalLabel">
                            Application Milestone Progress
                        </h5>
                        <p class="text-white-50 small mb-0">
                            <span id="modalJobNumber"></span> • <span id="modalCaseNumber"></span>
                        </p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                
                <!-- Summary Stats Cards -->
                <div class="row g-3 mb-4" id="milestoneStatsContainer">
                    <!-- Stats will be dynamically populated here -->
                </div>
                
                <!-- Progress Timeline -->
                <div class="mb-4" id="overallProgressContainer">
                    <!-- Overall progress will be dynamically populated here -->
                </div>
                
                <!-- Milestones Container -->
                <div id="milestonesContainer">
                    <!-- Milestones will be dynamically populated here -->
                </div>
                
                <!-- Loading Skeleton -->
                <div id="loadingSkeleton" class="text-center py-5" style="display: none;">
                    <div class="spinner-border text-primary mb-3" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mb-0">Loading milestone details...</p>
                    <small class="text-muted">Please wait while we fetch the progress data</small>
                </div>
                
                <!-- No Data Message -->
                <div id="noDataMessage" class="text-center py-5" style="display: none;">
                    <div class="bg-light bg-opacity-50 rounded-circle p-4 d-inline-block mb-3">
                        <i class="fas fa-tasks text-muted fa-3x"></i>
                    </div>
                    <h6 class="fw-bold mb-2">No Milestones Found</h6>
                    <p class="text-muted mb-2">No milestone data is available for this application</p>
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-0 px-4 py-3">
                <div class="d-flex flex-wrap align-items-center justify-content-between w-100 gap-2">
                    <!-- <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Last updated: <span id="lastUpdatedTime">Just now</span>
                    </div> -->
                    <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Close
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-slide modal-blur" id="btnSearchApplication" tabindex="-1" 
     aria-labelledby="searchApplicationModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <!-- Header -->
            <div class="modal-header bg-primary text-white border-bottom-0">
                <div class="d-flex align-items-center w-100">
                    <div class="flex-shrink-0">
                        <div class="bg-white bg-opacity-10 text-primary px-3 py-2 rounded-circle">
                            <i class="bi bi-search fs-4"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h5 class="modal-title text-white mb-0" id="searchApplicationModalLabel">
                            Search Applications
                        </h5>
                        <p class="mb-0 small opacity-75">Find applications by reference number, applicant name, or date</p>
                    </div>
                    <button type="button" class="btn-close btn-close-white ms-auto" 
                            data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Body -->
            <div class="modal-body p-4">
                <!-- Search Form -->
                <form id="applicationSearchForm">
                    <!-- Quick Search Section -->
                    <div class="quick-search-section mb-4">
                        <h6 class="fw-semibold mb-3">
                            <i class="bi bi-lightning-charge-fill text-warning me-2"></i>
                            Quick Search
                        </h6>
                        <div class="row g-3">
                            <div class="col-md-12">
                                <div class="input-group input-group-lg">
                                    <span class="input-group-text bg-light border-0">
                                        <i class="bi bi-search"></i>
                                    </span>
                                    <input type="text" class="form-control form-control-lg border-0 bg-light" 
                                           id="quickSearchInputQC" 
                                           placeholder="Enter Job Number">
                                    <button class="btn btn-primary" type="button" id="quickSearchQCBtn">
                                        <i class="bi bi-search me-2"></i>Search
                                    </button>
                                </div>
                                <div class="form-text">
                                    <i class="bi bi-info-circle me-1"></i>
                                    Search by any reference number, name, or keyword
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
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

<div class="modal fade" id="newObjectionModal" tabindex="-1" aria-labelledby="newObjectionModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-primary text-white border-0">
        <h5 class="modal-title" id="newObjectionModalLabel">
          <i class="fas fa-gavel me-2"></i>Objection Section
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4">
        <div id="alert-display-space-objection"></div>
        <form id="form_add_objection">
          <input id="action_on_form" type="hidden">
          <input id="obj_id" name="obj_id" type="hidden" value="${userid}">
          
          <div class="row g-3">
            <div class="col-lg-6 col-md-6 col-sm-12">
              <div class="form-group mb-3">
                <label for="obj_job_number" class="form-label fw-semibold">
                  <i class="fas fa-briefcase me-1"></i>Job Number
                </label>
                <input type="text" name="obj_job_number" id="obj_job_number" class="form-control bg-light" required readonly value="${job_number}">
              </div>
              <div class="form-group mb-3">
                <label for="obj_case_number" class="form-label fw-semibold">
                  <i class="fas fa-folder-open me-1"></i>Case Number
                </label>
                <input type="text" name="obj_case_number" id="obj_case_number" class="form-control bg-light" required readonly value="${case_number}">
              </div>
              <div class="form-group mb-3">
                <label for="obj_objector_name" class="form-label fw-semibold">
                  <i class="fas fa-user me-1"></i>Objector Name
                </label>
                <input type="text" name="obj_objector_name" id="obj_objector_name" class="form-control" required>
              </div>
              <div class="form-group mb-3">
                <label for="obj_objector_address" class="form-label fw-semibold">
                  <i class="fas fa-map-marker-alt me-1"></i>Objector Address
                </label>
                <input type="text" name="obj_objector_address" id="obj_objector_address" class="form-control" required>
              </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12">
              <div class="form-group mb-3">
                <label for="obj_object_contact" class="form-label fw-semibold">
                  <i class="fas fa-phone-alt me-1"></i>Objector Contact
                </label>
                <input type="text" name="obj_object_contact" id="obj_object_contact" class="form-control" required>
              </div>
              <div class="form-group mb-3">
                <label for="obj_reasons" class="form-label fw-semibold">
                  <i class="fas fa-exclamation-triangle me-1"></i>Reasons
                </label>
                <textarea name="obj_reasons" id="obj_reasons" class="form-control" rows="3" required></textarea>
              </div>
              <div class="form-group mb-3">
                <label for="obj_remarks" class="form-label fw-semibold">
                  <i class="fas fa-comment me-1"></i>Remarks
                </label>
                <textarea name="obj_remarks" id="obj_remarks" class="form-control" rows="3" required></textarea>
              </div>
              <div class="form-group mb-3">
                <label for="obj_status" class="form-label fw-semibold">
                  <i class="fas fa-toggle-on me-1"></i>Status
                </label>
                <select name="obj_status" id="obj_status" class="form-select" required>
                  <option value="true">Active</option>
                  <option value="false">Inactive</option>
                </select>
              </div>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer bg-light border-0">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>Close
        </button>
        <button type="button" id="btn_update_objection_section" class="btn btn-primary">
          <i class="fas fa-save me-1"></i>Save Changes
        </button>
      </div>
    </div>
  </div>
</div>