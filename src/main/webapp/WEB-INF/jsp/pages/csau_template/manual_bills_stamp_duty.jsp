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
                <h1 class="page-title fw-medium fs-18 mb-0">Stamp Duty Bills</span></h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Stamp Duty Bills</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

       
        

       <div class="row g-4">
    <!-- Main Form Section - Left Column -->
    <div class="col-lg-7">
        <!-- Stamp Duty Bills Card -->
        <div class="card shadow-sm hover-lift">
            <!-- Card Header with Gradient -->
            <div class="card-header py-4">
                <div class="d-flex align-items-center gap-3">
                    <div class="bg-primary text-white rounded-3 p-3">
                        <i class="fas fa-file-invoice-dollar fa-2x"></i>
                    </div>
                    <div>
                        <h2 class="h4 fw-bold mb-1">Create Stamp Duty Bills</h2>
                        <p class="small text-muted mb-0">Generate and manage stamp duty payment bills</p>
                    </div>
                </div>
            </div>

            <!-- Card Body with Form -->
            <div class="card-body p-4">
                <form method="post" id="generateManualStampDutyBillForm" class="needs-validation" novalidate>
                    <!-- Hidden Service Fields -->
                    <div class="row g-3 d-none">
                        <div class="col-md-6">
                            <label class="form-label text-muted small fw-semibold">Service Type</label>
                            <select class="form-select form-select-sm bg-light" 
                                    id="stp_main_service_cp" 
                                    name="stp_main_service_cp" 
                                    readonly disabled>
                                <option value="411-APPLICATION FOR STAMP DUTY PAYMENT" selected>
                                    APPLICATION FOR STAMPING
                                </option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-muted small fw-semibold">Sub Service</label>
                            <select class="form-select form-select-sm bg-light" 
                                    name="stp_sub_service_cp" 
                                    id="stp_sub_service_cp" 
                                    readonly disabled>
                                <option value="411-STAMP DUTY PAYMENT" selected>
                                    STAMP DUTY PAYMENT
                                </option>
                            </select>
                        </div>
                    </div>

                    <!-- Main Form Fields -->
                    <div class="row g-4">
                        <!-- Applicant Name -->
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" 
                                       class="form-control" 
                                       id="stp_applicant_name" 
                                       placeholder="Applicant Name"
                                       required>
                                <label for="stp_applicant_name">
                                    <i class="fas fa-user me-2 text-primary"></i>Applicant Name
                                </label>
                                <div class="invalid-feedback">
                                    Please enter applicant name.
                                </div>
                            </div>
                        </div>

                        <!-- Stamp Duty Amount -->
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" 
                                       class="form-control" 
                                       id="stp_bill_amount" 
                                       name="stp_bill_amount" 
                                       placeholder="0.00"
                                       required>
                                <label for="stp_bill_amount">
                                    <i class="fas fa-money-bill-wave me-2 text-success"></i>Stamp Duty Amount (GHS)
                                </label>
                                <div class="invalid-feedback">
                                    Please enter bill amount.
                                </div>
                            </div>
                        </div>

                        <!-- Document/Job Number -->
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" 
                                       class="form-control" 
                                       id="stp_bill_description" 
                                       name="stp_bill_description" 
                                       placeholder="Document/Job Number"
                                       required>
                                <label for="stp_bill_description">
                                    <i class="fas fa-hashtag me-2 text-info"></i>Document / Job Number
                                </label>
                                <div class="invalid-feedback">
                                    Please enter document or job number.
                                </div>
                            </div>
                        </div>

                        <!-- Generate Button -->
                        <div class="col-md-6 d-flex align-items-end">
                            <button type="button"
                                    id="btn_generate_stamp_duty_bill"
                                    class="btn btn-primary btn-lg w-100 py-3">
                                <i class="fas fa-file-invoice me-2"></i>
                                Generate Bill
                            </button>
                        </div>
                    </div>

                    <!-- Bill Preview Section -->
                    <div class="mt-5">
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <div class="bg-primary bg-opacity-10 rounded-circle p-2">
                                <i class="fas fa-eye text-primary"></i>
                            </div>
                            <h5 class="fw-semibold mb-0">Bill Preview</h5>
                            <span class="badge bg-light text-dark ms-2">PDF Preview</span>
                        </div>
                        
                        <!-- Preview Frame -->
                        <div class="preview-container border rounded-3 overflow-hidden bg-light">
                            <div class="preview-toolbar bg-white border-bottom p-2 d-flex justify-content-between align-items-center">
                                <div class="d-flex gap-2">
                                    <span class="btn btn-sm btn-light px-3 disabled">
                                        <i class="fas fa-file-pdf text-danger me-1"></i>stamp_duty_bill.pdf
                                    </span>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm btn-outline-secondary" type="button" disabled>
                                        <i class="fas fa-download"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-secondary" type="button" disabled>
                                        <i class="fas fa-print"></i>
                                    </button>
                                </div>
                            </div>
                            <iframe src=""  
                                    id="stpbillblobfile" 
                                    width="100%" 
                                    height="400" 
                                    class="border-0"
                                    title="Stamp Duty Bill Preview">
                            </iframe>
                            <div class="preview-footer bg-white border-top p-2 text-center text-muted small">
                                <i class="fas fa-info-circle me-1"></i>
                                Bill preview will appear here after generation
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="reset" class="btn btn-outline-secondary px-4">
                            <i class="fas fa-undo me-2"></i>Reset
                        </button>
                        <button type="submit" class="btn btn-success px-4" id="submitBillForm" style="display: none;">
                            <i class="fas fa-check me-2"></i>Submit
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Instructions & Info Section - Right Column -->
    <div class="col-lg-5">
        <!-- Instructions Card -->
        <div class="card mt-1 shadow-sm sticky-top">
            <div class="card-body p-0">
                <!-- Modern Accordion -->
                <div class="accordion modern-accordion" id="accordionInstructions">
                    <!-- Instructions Panel -->
                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="headingInstructions">
                            <button class="accordion-button bg-info text-white" 
                                    type="button" 
                                    data-bs-toggle="collapse" 
                                    data-bs-target="#instructionsPanel" 
                                    aria-expanded="true">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="bg-white rounded-circle p-2">
                                        <i class="fas fa-clipboard-list text-info"></i>
                                    </div>
                                    <span class="fw-semibold">Bill Generation Instructions</span>
                                </div>
                            </button>
                        </h2>
                        <div id="instructionsPanel" 
                             class="accordion-collapse collapse show" 
                             aria-labelledby="headingInstructions">
                            <div class="accordion-body p-4">
                                <!-- Step-by-step guide -->
                                <div class="instruction-steps">
                                    <div class="step-item d-flex gap-3 mb-4">
                                        <div class="step-number bg-primary bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                            <span class="fw-bold text-primary">1</span>
                                        </div>
                                        <div>
                                            <h6 class="fw-semibold mb-1">Enter Applicant Details</h6>
                                            <p class="small text-muted mb-0">Provide the full name of the applicant as it appears on legal documents.</p>
                                        </div>
                                    </div>
                                    
                                    <div class="step-item d-flex gap-3 mb-4">
                                        <div class="step-number bg-success bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                            <span class="fw-bold text-success">2</span>
                                        </div>
                                        <div>
                                            <h6 class="fw-semibold mb-1">Specify Bill Amount</h6>
                                            <p class="small text-muted mb-0">Enter the stamp duty amount in GHS (Ghana Cedis).</p>
                                        </div>
                                    </div>
                                    
                                    <div class="step-item d-flex gap-3 mb-4">
                                        <div class="step-number bg-info bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                            <span class="fw-bold text-info">3</span>
                                        </div>
                                        <div>
                                            <h6 class="fw-semibold mb-1">Add Reference Number</h6>
                                            <p class="small text-muted mb-0">Input the document or job number for tracking purposes.</p>
                                        </div>
                                    </div>
                                    
                                    <div class="step-item d-flex gap-3">
                                        <div class="step-number bg-warning bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                            <span class="fw-bold text-warning">4</span>
                                        </div>
                                        <div>
                                            <h6 class="fw-semibold mb-1">Generate & Review</h6>
                                            <p class="small text-muted mb-0">Click "Generate Bill" to create the document and preview it in the PDF viewer.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Tips Panel -->
                    <div class="accordion-item border-0 mt-3">
                        <h2 class="accordion-header" id="headingTips">
                            <button class="accordion-button collapsed bg-success text-white" 
                                    type="button" 
                                    data-bs-toggle="collapse" 
                                    data-bs-target="#tipsPanel" 
                                    aria-expanded="false">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="bg-white rounded-circle p-2">
                                        <i class="fas fa-lightbulb text-success"></i>
                                    </div>
                                    <span class="fw-semibold">Quick Tips</span>
                                </div>
                            </button>
                        </h2>
                        <div id="tipsPanel" 
                             class="accordion-collapse collapse" 
                             aria-labelledby="headingTips">
                            <div class="accordion-body p-4">
                                <div class="tips-list">
                                    <div class="tip-item d-flex gap-3 mb-3">
                                        <i class="fas fa-check-circle text-success mt-1"></i>
                                        <p class="small mb-0">Ensure all amounts are entered in the correct format (e.g., 1500.00)</p>
                                    </div>
                                    <div class="tip-item d-flex gap-3 mb-3">
                                        <i class="fas fa-check-circle text-success mt-1"></i>
                                        <p class="small mb-0">Double-check the applicant's name for spelling accuracy</p>
                                    </div>
                                    <div class="tip-item d-flex gap-3 mb-3">
                                        <i class="fas fa-check-circle text-success mt-1"></i>
                                        <p class="small mb-0">Reference numbers should match your physical file records</p>
                                    </div>
                                    <div class="tip-item d-flex gap-3">
                                        <i class="fas fa-check-circle text-success mt-1"></i>
                                        <p class="small mb-0">Preview the bill before downloading or printing</p>
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
</div>

  
  
  
  

