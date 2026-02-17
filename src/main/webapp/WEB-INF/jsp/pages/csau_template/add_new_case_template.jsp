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
						<i class="ri-folder-5-fill text-warning me-1"></i>New Case Template
					</h1>
                    <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Create and manage job applications efficiently</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">New Case Template</li>
                </ol>
            </div>
        </div>
          
        
        

       <div class="row g-4">
    <!-- Left Column - Action Cards (8 columns) -->
    <div class="col-lg-8">
        <!-- Welcome Header -->
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h4 class="text-primary mb-1">
                    <i class="bi bi-grid-3x3-gap-fill me-2"></i>
                    Application Management
                </h4>
                <!-- <p class="text-muted mb-0">Create and manage job applications efficiently</p> -->
            </div>
            <!-- <div class="d-none d-sm-block">
                <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill">
                    <i class="bi bi-clock-history me-1"></i>
                    Last updated: Today, 10:30 AM
                </span>
            </div> -->
        </div>

        <!-- Action Cards Grid -->
        <div class="row g-3">
            <!-- Create New Job Card -->
            <div class="col-md-6">
                <div class="card h-100 border-0 shadow-sm hover-lift">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4">
                            <div class="flex-shrink-0">
                                <div class="icon-circle bg-primary bg-opacity-10">
                                    <i class="bi bi-plus-circle-fill text-primary fs-4"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="mb-1 fw-semibold">New Application</h5>
                                <p class="text-muted small mb-0">Create from scratch</p>
                            </div>
                        </div>
                        
                        <p class="text-muted small mb-4">
                            Start a brand new job application with all required fields and documentation.
                        </p>
                        
                        <div class="mb-3">
                            <div class="d-flex align-items-center text-success small mb-2">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                <span>Fresh application process</span>
                            </div>
                            <div class="d-flex align-items-center text-success small mb-2">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                <span>Auto-generate job number</span>
                            </div>
                            <div class="d-flex align-items-center text-success small">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                <span>Complete workflow</span>
                            </div>
                        </div>
                        
                        <button class="btn btn-primary w-100 py-3" 
                                data-action="edit"
                                data-bs-toggle="modal" 
                                data-bs-target="#CreateJobNumberModal" 
                                data-target-id="${proprietorship_section.ps_id}" 
                                data-whatever="edit" 
                                data-backdrop="static" 
                                data-keyboard="false">
                            <i class="bi bi-plus-circle me-2"></i>
                            Create New Application
                        </button>
                    </div>
                </div>
            </div>

            <!-- Create Existing Job Card -->
            <div class="col-md-6">
                <div class="card h-100 border-0 shadow-sm hover-lift">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4">
                            <div class="flex-shrink-0">
                                <div class="icon-circle bg-info bg-opacity-10">
                                    <i class="bi bi-folder-plus text-info fs-4"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="mb-1 fw-semibold">Existing Job</h5>
                                <p class="text-muted small mb-0">With job number</p>
                            </div>
                        </div>
                        
                        <p class="text-muted small mb-4">
                            Create an application using an existing job number for continuation or updates.
                        </p>
                        
                        <div class="mb-4">
                            <div class="d-flex align-items-center text-info small mb-2">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                <span>Use existing job number</span>
                            </div>
                            <div class="d-flex align-items-center text-info small mb-2">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                <span>Quick continuation</span>
                            </div>
                            <div class="d-flex align-items-center text-info small">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                <span>Preserve history</span>
                            </div>
                        </div>
                        
                        <button class="btn btn-info text-white w-100 py-3" 
                                data-action="edit"
                                data-bs-toggle="modal" 
                                data-bs-target="#CreateJobNumberModalExisting" 
                                data-target-id="${proprietorship_section.ps_id}" 
                                data-whatever="edit" 
                                data-backdrop="static" 
                                data-keyboard="false">
                            <i class="bi bi-folder-plus me-2"></i>
                            Create Existing Job
                        </button>
                    </div>
                </div>
            </div>

            <!-- Quick Stats Cards -->
           
        </div>
    </div>

    <!-- Right Column - Instructions & Info Panel (4 columns) -->
    <div class="col-lg-4">
        <!-- Instructions Card -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <h5 class="mb-1 fw-semibold">
                            <i class="bi bi-info-circle-fill text-primary me-2"></i>
                            Instructions & Guidelines
                        </h5>
                        <p class="text-muted small mb-0">Quick reference guide</p>
                    </div>
                    <span class="badge bg-primary bg-opacity-10 text-primary">
                        <i class="bi bi-lightbulb me-1"></i>
                        3 tips
                    </span>
                </div>
            </div>
            <div class="card-body px-4 pt-2">
                <!-- Accordion for instructions -->
                <div class="accordion accordion-flush" id="instructionsAccordion">
                    <!-- Getting Started -->
                    <div class="accordion-item border-0 mb-2">
                        <h6 class="accordion-header" id="headingStart">
                            <button class="accordion-button collapsed bg-light rounded-3 p-3" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseStart">
                                <i class="bi bi-rocket-takeoff me-2 text-primary"></i>
                                Getting Started
                            </button>
                        </h6>
                        <div id="collapseStart" class="accordion-collapse collapse" 
                             data-bs-parent="#instructionsAccordion">
                            <div class="accordion-body px-3 py-3">
                                <ul class="list-unstyled mb-0">
                                    <li class="mb-2 d-flex">
                                        <i class="bi bi-1-circle-fill text-primary me-2 flex-shrink-0"></i>
                                        <span class="small">Click "Create New Application" for fresh submissions</span>
                                    </li>
                                    <li class="mb-2 d-flex">
                                        <i class="bi bi-2-circle-fill text-primary me-2 flex-shrink-0"></i>
                                        <span class="small">Use "Existing Job" for continuing applications</span>
                                    </li>
                                    <li class="d-flex">
                                        <i class="bi bi-3-circle-fill text-primary me-2 flex-shrink-0"></i>
                                        <span class="small">Ensure all required documents are ready</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Document Requirements -->
                    <div class="accordion-item border-0 mb-2">
                        <h6 class="accordion-header" id="headingDocs">
                            <button class="accordion-button collapsed bg-light rounded-3 p-3" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseDocs">
                                <i class="bi bi-file-earmark-text me-2 text-success"></i>
                                Document Requirements
                            </button>
                        </h6>
                        <div id="collapseDocs" class="accordion-collapse collapse" 
                             data-bs-parent="#instructionsAccordion">
                            <div class="accordion-body px-3 py-3">
                                <div class="list-group list-group-flush">
                                    <div class="list-group-item border-0 px-0 py-2">
                                        <i class="bi bi-check-circle-fill text-success me-2 small"></i>
                                        Application form (signed)
                                    </div>
                                    <div class="list-group-item border-0 px-0 py-2">
                                        <i class="bi bi-check-circle-fill text-success me-2 small"></i>
                                        Site plans (2 copies)
                                    </div>
                                    <div class="list-group-item border-0 px-0 py-2">
                                        <i class="bi bi-check-circle-fill text-success me-2 small"></i>
                                        Proof of ownership
                                    </div>
                                    <div class="list-group-item border-0 px-0 py-2">
                                        <i class="bi bi-check-circle-fill text-success me-2 small"></i>
                                        Identification documents
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Processing Times -->
                    <!-- <div class="accordion-item border-0 mb-2">
                        <h6 class="accordion-header" id="headingTime">
                            <button class="accordion-button collapsed bg-light rounded-3 p-3" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseTime">
                                <i class="bi bi-clock-history me-2 text-warning"></i>
                                Processing Times
                            </button>
                        </h6>
                        <div id="collapseTime" class="accordion-collapse collapse" 
                             data-bs-parent="#instructionsAccordion">
                            <div class="accordion-body px-3 py-3">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="small">Standard processing</span>
                                    <span class="badge bg-light text-dark">5-7 days</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="small">Express processing</span>
                                    <span class="badge bg-success">2-3 days</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="small">Complex cases</span>
                                    <span class="badge bg-warning">10-14 days</span>
                                </div>
                            </div>
                        </div>
                    </div> -->

                    <!-- Contact Support -->
                    <div class="accordion-item border-0">
                        <h6 class="accordion-header" id="headingContact">
                            <button class="accordion-button collapsed bg-light rounded-3 p-3" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseContact">
                                <i class="bi bi-headset me-2 text-info"></i>
                                Need Help?
                            </button>
                        </h6>
                        <div id="collapseContact" class="accordion-collapse collapse" 
                             data-bs-parent="#instructionsAccordion">
                            <div class="accordion-body px-3 py-3">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="bg-info bg-opacity-10 p-2 rounded-circle me-3">
                                        <i class="bi bi-telephone text-info"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted">Support Hotline</small>
                                        <h6 class="mb-0">+233 30 123 4567</h6>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center">
                                    <div class="bg-info bg-opacity-10 p-2 rounded-circle me-3">
                                        <i class="bi bi-envelope text-info"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted">Email Support</small>
                                        <h6 class="mb-0">itsupport@lc.gov.gh</h6>
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
      
       
<jsp:include page="../../components/_gated_workflow_modal_2.jsp"></jsp:include>
           
        

  
  
  
  
  

