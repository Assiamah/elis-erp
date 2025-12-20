
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

<style>
    .table th, .table td {
        font-size: 12px;
		/* font-size: 0.75rem; */
    }

    /* Process Timeline Styles */
    .process-timeline {
        position: relative;
    }
    
    .process-step-card {
        position: relative;
        padding: 1.5rem;
        background: #fff;
        border-radius: 0.75rem;
        border: 1px solid #e9ecef;
        transition: all 0.3s ease;
        background: rgba(0, 0, 0, 0.06);
    }
    
    /* .process-step-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.1);
    } */
    
    .process-step-card[data-status="completed"] {
        border-left: 4px solid #198754;
        background: rgba(25, 135, 84, 0.02);
    }
    
    .process-step-card[data-status="ongoing"] {
        border-left: 4px solid #ffc107;
        background: rgba(255, 193, 7, 0.02);
    }
    
    .process-step-card[data-status="pending"] {
        border-left: 4px solid #f36060;
        background: rgba(243, 96, 96, 0.02);
    }
    
    .timeline-connector {
        position: absolute;
        left: 2rem;
        bottom: -1.5rem;
        width: 2px;
        height: 1.5rem;
        background: linear-gradient(to bottom, #dee2e6, #6c757d);
    }
    
    /* Avatar Styles */
    .avatar {
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }
    
    .avatar-sm {
        width: 32px;
        height: 32px;
    }
    
    .avatar-md {
        width: 48px;
        height: 48px;
    }
    
    .avatar-lg {
        width: 64px;
        height: 64px;
    }
    
    /* Step Details */
    .step-details {
        border-left: 2px dashed #dee2e6;
        padding-left: 2rem;
        margin-left: 2rem;
    }
    
    
    /* Step Actions */
    .step-actions .btn {
        padding: 0.375rem 0.75rem;
        font-size: 0.875rem;
    }
    
    /* Badge Styles */
    .badge {
        padding: 0.35em 0.65em;
        font-weight: 500;
    }
    
    /* Responsive Adjustments */
    @media (max-width: 768px) {
        .process-step-card {
            padding: 1rem;
        }
        
        .step-details {
            padding-left: 1rem;
            margin-left: 1rem;
        }
        
        .step-header {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .step-number {
            margin-bottom: 1rem;
        }
        
        .step-quick-actions {
            width: 100%;
            margin-top: 1rem;
            text-align: right;
        }
        
        .step-actions {
            flex-direction: column;
            align-items: stretch;
        }
        
        .step-actions .btn {
            width: 100%;
            justify-content: center;
        }
    }
    
    /* Status Indicator Animation */
    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.05); }
        100% { transform: scale(1); }
    }
    
    .process-step-card[data-status="ongoing"] .step-number .avatar {
        animation: pulse 2s infinite;
    }
    
    /* Progress Bar Alternative (Optional) */
    .progress-indicator {
        position: relative;
        height: 4px;
        background: #e9ecef;
        border-radius: 2px;
        overflow: hidden;
    }
    
    .progress-indicator::after {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        height: 100%;
        background: #0d6efd;
        width: var(--progress-width, 0%);
        transition: width 0.5s ease;
    }

    .bg-pink {
  background-color: #e83e8c !important;
  color: white !important;
}

.avatar {
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.avatar-lg {
  width: 56px;
  height: 56px;
}

.avatar-sm {
  width: 36px;
  height: 36px;
}

.avatar-xs {
  width: 28px;
  height: 28px;
}

.bg-light-primary {
  background-color: rgba(13, 110, 253, 0.1) !important;
}

.bg-light-success {
  background-color: rgba(25, 135, 84, 0.1) !important;
}

.bg-light-warning {
  background-color: rgba(255, 193, 7, 0.1) !important;
}

.bg-light-info {
  background-color: rgba(13, 202, 240, 0.1) !important;
}

.contact-info {
  font-size: 0.875rem;
}

.table-hover tbody tr:hover {
  background-color: rgba(13, 110, 253, 0.05);
}
</style>
<div class="main-content app-content">
    <div class="container-fluid page-container">
        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Application Details</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Application Details</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="badge bg-primary fs-6">${job_number}</span>
                            <div class="h5 mb-0">${ar_name}</div>
                        </div>
                    </div>
                    <div>
                        <button onclick="javascript:history.go(-1)" 
                                class="btn btn-outline-primary d-flex align-items-center gap-2">
                            <i class="bi bi-arrow-left"></i>
                            <span>Back to List</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <input class="form-control" type="hidden" id="cs_main_case_number" name="cs_main_case_number" value="${case_number}">
		<input class="form-control" type="hidden" id="cs_main_job_number" name="cs_main_job_number" value="${job_number}">
        <input class="form-control" type="hidden" id="cs_main_business_process_id" value="${business_process_id}">
        <input class="form-control" type="hidden" id="cs_main_business_process_name" value="${business_process_name}">
        <input class="form-control" type="hidden" id="cs_main_business_process_sub_id" value="${business_process_sub_id}">
        <input class="form-control" type="hidden" id="cs_main_business_process_sub_name" value="${business_process_sub_name}">
        <input class="form-control" type="hidden" id="cs_main_client_number" value="${phone_number}">
        <input class="form-control" type="hidden" id="cs_main_case_number" value="${case_number}">
        <input class="form-control" type="hidden" id="cs_main_transaction_number"  name="cs_main_transaction_number" value="${transaction_number}" >

        <div class="row">
            <!-- Main Content Column -->
            <div class="col-lg-8">
                <!-- Case Summary Card -->
                <div class="card shadow-sm">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-md bg-primary text-white rounded-circle me-3">
                                <i class="bi bi-file-text fs-15"></i>
                            </div>
                            <div>
                                <h6 class="mb-0 fw-medium">Case Summary</h6>
                            </div>
                        </div>
                        <button class="btn btn-sm btn-outline-secondary" type="button" data-bs-toggle="collapse" 
                                data-bs-target="#caseSummaryCollapse" aria-expanded="true">
                            <i class="bi bi-chevron-down"></i>
                        </button>
                    </div>
                    
                    <div class="collapse" id="caseSummaryCollapse">
                        <div class="card-body">
                            <!-- Parcel Attributes Section -->
							<div class="card">
								<div class="card-header justify-content-between">
									<div class="card-title text-primary">
										<i class="bi bi-geo-alt me-2"></i>Parcel Attributes
									</div>
								</div>
								<div class="card-body">
									<div class="row g-3">
										<input type="hidden" id="cs_main_business_process_id" value="${business_process_id}">
										<input type="hidden" id="cs_main_business_process_name" value="${business_process_name}">
										<input type="hidden" id="cs_main_business_process_sub_id" value="${business_process_sub_id}">
										<input type="hidden" id="cs_main_business_process_sub_name" value="${business_process_sub_name}">
										<input type="hidden" id="cs_main_client_number" value="${phone_number}">
										
										<div class="col-md-4">
											<label class="form-label text-muted small mb-1">Date Created</label>
											<div class="fw-medium text-dark">${empty fn:trim(created_date) ? '--' : fn:trim(created_date)}</div>
										</div>
										<div class="col-md-4">
											<label class="form-label text-muted small mb-1">Last Modified</label>
											<div class="fw-medium text-dark">${empty fn:trim(modified_date) ? '--' : fn:trim(modified_date)}</div>
										</div>
										
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
										<div class="col-md-4">
											<label class="form-label text-muted small mb-1">New Transaction Ready</label>
											<div class="fw-medium text-dark ${empty fn:trim(need_for_new_transaction) == 'Yes' ? 'bg-success text-white' : ''}">
												${empty fn:trim(need_for_new_transaction) ? '--' : fn:trim(need_for_new_transaction)}
											</div>
										</div>
									</div>
								</div>
							 </div>
                            
                            <!-- Transaction Details Section -->
							<div class="card">
								<div class="card-header justify-content-between">
									<div class="card-title text-primary">
										<i class="bi bi-receipt me-2"></i>Transaction Details
									</div>
								</div>
								<div class="card-body">
									<div class="row g-3">
										<div class="col-md-4">
											<label class="form-label text-muted small mb-1">Transaction Number</label>
											<div class="fw-medium text-dark">${empty fn:trim(transaction_number) ? '--' : fn:trim(transaction_number)}</div>
										</div>
										<div class="col-md-4">
											<label class="form-label text-muted small mb-1">Applicant Name</label>
											<div class="fw-medium text-dark">${empty fn:trim(ar_name) ? '--' : fn:trim(ar_name)}</div>
										</div>
										<div class="col-md-4">
											<label class="form-label text-muted small mb-1">Nature of Instrument</label>
											<div class="fw-medium text-dark">${empty fn:trim(nature_of_instrument) ? '--' : fn:trim(nature_of_instrument)}</div>
										</div>
										
										<div class="col-md-4">
											<label class="form-label text-muted small mb-1">Document Date</label>
											<div class="fw-medium text-dark">${empty fn:trim(date_of_document) ? '--' : fn:trim(date_of_document)}</div>
										</div>
										<div class="col-md-4">
											<label class="form-label text-muted small mb-1">Registration Date</label>
											<div class="fw-medium text-dark">${empty fn:trim(date_of_registration) ? '--' : fn:trim(date_of_registration)}</div>
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
											<label class="form-label text-muted small mb-1">Commencement Date</label>
											<div class="fw-medium text-dark">${empty fn:trim(commencement_date) ? '--' : fn:trim(commencement_date)}</div>
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
											<label class="form-label text-muted small mb-1">Certificate Number</label>
											<div class="fw-medium text-dark">${empty fn:trim(certificate_number) ? '--' : fn:trim(certificate_number)}</div>
										</div>
									</div>
								</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Process Status and Actions Card -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-primary">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <div class="avatar avatar-md bg-primary text-white rounded-circle me-3">
                                    <i class="bi bi-clipboard-check fs-15"></i>
                                </div>
                                <div>
                                    <h6 class="mb-2 fw-medium">Process Status & Actions</h6>
                                    <p class="mb-0 small opacity-75">
                                        <i class="bi bi-info-circle me-1"></i>
                                        ${job_number} - ${ar_name}
                                    </p>
                                </div>
                            </div>
                            <div class="action-buttons">
                                <!-- Primary Action Button -->
                                <button class="btn btn-warning label-btn"
                                        data-bs-toggle="modal" 
                                        data-bs-target="#askForPurposeOfBatching"
                                        data-job_number="${job_number}" 
                                        data-ar_name="${ar_name}"
                                        data-business_process_sub_name="${business_process_sub_name}">
                                    <i class="bi bi-plus-circle label-btn-icon"></i>
                                    Add to Batch
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Process Steps List -->
                    <div class="card-body p-4">
                        <!-- Process Steps Timeline -->
                        <div class="process-timeline">
                            <c:forEach var="babyStep" items="${active_digital_workflow_step_list}" varStatus="loop">
                                <!-- Process Step Card -->
                                <div class="process-step-card mb-4" 
                                    data-status="${babyStep.bse_status.toLowerCase()}">
                                    
                                    <!-- Step Header -->
                                    <div class="step-header d-flex align-items-center mb-3">
                                        <!-- Step Number -->
                                        <div class="step-number me-3">
                                            <div class="avatar avatar-md rounded-circle 
                                                ${babyStep.bse_status == 'Completed' ? 'bg-success text-white' : 
                                                babyStep.bse_status == 'Ongoing' ? 'bg-warning text-dark' : 
                                                'bg-danger text-white'}">
                                                <span>${loop.index + 1}</span>
                                            </div>
                                        </div>
                                        
                                        <!-- Step Info -->
                                        <div class="step-info flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h6 class="mb-1 fw-semibold">
                                                        ${babyStep.bse_description}
                                                    </h6>
                                                    <div class="d-flex align-items-center gap-3">
                                                        <!-- Status Badge -->
                                                        <span class="badge 
                                                            ${babyStep.bse_status == 'Completed' ? 'bg-success' : 
                                                            babyStep.bse_status == 'Ongoing' ? 'bg-warning text-dark' : 
                                                            'bg-danger'}">
                                                            <i class="bi 
                                                                ${babyStep.bse_status == 'Completed' ? 'bi-check-circle' : 
                                                                babyStep.bse_status == 'Ongoing' ? 'bi-clock' : 
                                                                'bi-exclamation-circle'} me-1"></i>
                                                            ${babyStep.bse_status}
                                                        </span>
                                                        
                                                        <!-- Timeline Info -->
                                                        <small class="text-muted">
                                                            <i class="bi bi-calendar me-1"></i>
                                                            Started: ${empty fn:trim(babyStep.start_date) ? '--' : fn:trim(babyStep.start_date)}
                                                        </small>
                                                    </div>
                                                </div>
                                                
                                                <!-- Quick Actions -->
                                                <div class="step-quick-actions">
                                                    <button class="btn btn-sm btn-outline-info" 
                                                            data-bs-toggle="modal" 
                                                            data-bs-target="#${babyStep.bse_description_key}"
                                                            data-bs-id="${babyStep.bse_id}" 
                                                            data-bse-id="${babyStep.bse_id}" 
                                                            data-bs-desc="${babyStep.bse_description}" 
                                                            data-bs-username="${babyStep.username}" 
                                                            data-bs-date="${babyStep.date}" 
                                                            data-bs-time="${babyStep.time}"
                                                            ${babyStep.bse_status == 'Pending' || babyStep.bse_status == 'Completed' ? 'disabled' : ''}>
                                                        <i class="bi bi-eye"></i> Details
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Step Details -->
                                    <div class="step-details ps-5 ms-2">
                                        
                                        
                                        <!-- Action Buttons -->
                                        <div class="row mt-4">
                                            <div class="col-7">
                                                <!-- Approve Button -->
                                                <div class="btn-group">
                                                    <button class="btn btn-sm btn-success"
                                                        onclick="reviewStep('${babyStep.bse_id}','${job_number}')"
                                                        ${babyStep.bse_status == 'Pending' || babyStep.bse_status == 'Completed' ? 'disabled' : ''}>
                                                        <i class="bi bi-check-circle"></i>
                                                        Approve
                                                    </button>
                                                
                                                    <!-- Send Request Button -->
                                                    <button class="btn btn-sm btn-primary"
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#askForPurposeOfSendingRequest"
                                                        data-job_number="${job_number}" 
                                                        data-ar_name="${ar_name}" 
                                                        data-business_process_sub_name="${business_process_sub_name}" 
                                                        data-locality="${locality}" 
                                                        data-bs-desc="${babyStep.bse_description}"
                                                        id="btnAddRequest"
                                                        ${babyStep.bse_status == 'Pending' || babyStep.bse_status == 'Completed' ? 'disabled' : ''}>
                                                        <i class="bi bi-send"></i>
                                                        Send Request
                                                    </button>
                                                
                                                    <!-- Query Button -->
                                                    <button class="btn btn-sm btn-warning"
                                                            data-bs-toggle="modal" 
                                                            data-bs-target="#newQueryModal"
                                                            data-job_number="${job_number}" 
                                                            data-ar_name="${ar_name}" 
                                                            data-business_process_sub_name="${business_process_sub_name}" 
                                                            data-locality="${locality}"
                                                            ${babyStep.bse_status == 'Pending' || babyStep.bse_status == 'Completed' ? 'disabled' : ''}>
                                                        <i class="bi bi-question-circle"></i>
                                                        Query
                                                    </button>
                                                </div>
                                            </div>

                                            <!-- Approval Information -->
                                            <div class="col-5">
                                                <div class="d-flex justify-content-between">
                                                    <div>
                                                        <div class="d-flex align-items-center">
                                                            <div class="avatar avatar-sm bg-light rounded-circle me-2">
                                                                <i class="bi bi-person text-muted"></i>
                                                            </div>
                                                            <div>
                                                                <small class="text-muted d-block">Approved By</small>
                                                                <small class="fw-medium text-dark">
                                                                    ${empty fn:trim(babyStep.completed_by) || babyStep.completed_by == 'null, null' ? 'Pending' : fn:trim(babyStep.completed_by)}
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <div class="d-flex align-items-center">
                                                            <div class="avatar avatar-sm bg-light rounded-circle me-2">
                                                                <i class="bi bi-calendar-check text-muted"></i>
                                                            </div>
                                                            <div>
                                                                <small class="text-muted d-block">Approval Date</small>
                                                                <small class="fw-medium text-dark">
                                                                    ${empty fn:trim(babyStep.complete_by_date) ? 'Not approved' : fn:trim(babyStep.complete_by_date)}
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                    
                                    <!-- Timeline Connector (except for last item) -->
                                    <c:if test="${!loop.last}">
                                        <div class="timeline-connector"></div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Empty State -->
                        <c:if test="${empty active_digital_workflow_step_list}">
                            <div class="text-center py-5">
                                <div class="mb-3">
                                    <i class="bi bi-clipboard-x display-4 text-muted"></i>
                                </div>
                                <h6 class="text-muted mb-2">No Process Steps Found</h6>
                                <p class="text-muted small">No active process steps are available for this application.</p>
                            </div>
                        </c:if>
                        
                        <!-- Process Summary -->
                        <div class="row mt-4 pt-3 border-top">
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-md bg-success text-white rounded-circle me-3">
                                        <i class="bi bi-check-all"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">Completed</h6>
                                        <p class="mb-0 fw-bold">
                                            <c:set var="completedCount" value="0" />
                                            <c:forEach var="step" items="${active_digital_workflow_step_list}">
                                                <c:if test="${step.bse_status == 'Completed'}">
                                                    <c:set var="completedCount" value="${completedCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${completedCount}
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-md bg-warning text-dark rounded-circle me-3">
                                        <i class="bi bi-clock"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">In Progress</h6>
                                        <p class="mb-0 fw-bold">
                                            <c:set var="ongoingCount" value="0" />
                                            <c:forEach var="step" items="${active_digital_workflow_step_list}">
                                                <c:if test="${step.bse_status == 'Ongoing'}">
                                                    <c:set var="ongoingCount" value="${ongoingCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${ongoingCount}
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-md bg-danger text-white rounded-circle me-3">
                                        <i class="bi bi-hourglass"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">Pending</h6>
                                        <p class="mb-0 fw-bold">
                                            <c:set var="pendingCount" value="0" />
                                            <c:forEach var="step" items="${active_digital_workflow_step_list}">
                                                <c:if test="${step.bse_status == 'Pending'}">
                                                    <c:set var="pendingCount" value="${pendingCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${pendingCount}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar Column -->
            <div class="col-lg-4">
                <!-- Accordion for Sidebar Sections -->
                <div class="accordion shadow-sm" id="sidebarAccordion">
                    <!-- Map Section -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseMap" aria-expanded="true">
                                <i class="bi bi-map me-2"></i>
                                Map
                            </button>
                        </h2>
                        <div id="collapseMap" class="accordion-collapse collapse show" data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div id="parcelMap" style="height: 300px;"></div>
                            </div>
                        </div>
                    </div>
                    <!-- Related Jobs -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseJobs" aria-expanded="false">
                                <i class="bi bi-briefcase me-2"></i>
                                Related Jobs
                            </button>
                        </h2>
                        <div id="collapseJobs" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div  class="table-responsive">
									<table class="table table-bordered table-hover table-sm">
										<thead>
											<tr>
												<th>Job Number</th>
												<th>Application Type</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${job_details}" var="job_row">
												<tr>
													<td>${job_row.job_number}</td>
													<td>${job_row.business_process_sub_name}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
                            </div>
                        </div>
                    </div>

                    <!-- Parties -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseParties">
                                <i class="bi bi-people me-2"></i>
                                Parties
                                <span class="badge bg-primary ms-2">${parties.size()}</span>
                            </button>
                        </h2>
                        <div id="collapseParties" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Gender</th>
                                                <th>Contact</th>
                                                <th>Role</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${parties}" var="parties_row">
                                                <tr>
                                                    <td class="fw-medium">${parties_row.ar_name}</td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">
                                                            ${parties_row.ar_gender}
                                                        </span>
                                                    </td>
                                                    <td>${parties_row.ar_cell_phone}</td>
                                                    <td>
                                                        <span class="badge bg-info">
                                                            ${parties_row.type_of_party}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bills & Payments -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseBills">
                                <i class="bi bi-cash-coin me-2"></i>
                                Bills & Payments
                            </button>
                        </h2>
                        <div id="collapseBills" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Action</th>
                                                <th>Mode</th>
                                                <th>Amount</th>
                                                <th>Receipt</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${payment_invoice}" var="payment_bill_row">
                                                <tr>
                                                    <td>
                                                        <button class="btn btn-sm btn-primary"
                                                                data-bs-toggle="modal" 
																data-bs-target="#generateEGCRModal"
                                                                data-egcr_id="${payment_bill_row.payment_slip_number}"
                                                                data-ref_number="${payment_bill_row.ref_number}">
                                                            <i class="bi bi-eye"></i>
                                                        </button>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">
                                                            ${payment_bill_row.payment_mode}
                                                        </span>
                                                    </td>
                                                    <td class="fw-medium">${payment_bill_row.bill_amount}</td>
                                                    <td>${payment_bill_row.payment_slip_number}</td>
                                                    <td>${payment_bill_row.payment_date}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Application Minutes -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseMinutes">
                                <i class="bi bi-journal-text me-2"></i>
                                Application Minutes
                            </button>
                        </h2>
                        <div id="collapseMinutes" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Description</th>
                                                <th>From</th>
                                                <th>To</th>
                                                <th>Date</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${application_munites}" var="application_munites_row">
                                                <tr>
                                                    <td class="fs-15">${application_munites_row.am_description}</td>
                                                    <td class="fs-12">${application_munites_row.ar_name}</td>
                                                    <td class="fs-12">${application_munites_row.am_to_officer}</td>
                                                    <td class="fs-12">${application_munites_row.am_activity_date}</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-info text-dark view-minute-btn"
															data-bs-toggle="modal" 
															data-bs-target="#viewMinutesModal"
															data-minute-id="${application_munites_row.am_id}"
															data-minute-description="${application_munites_row.am_description}"
															data-minute-from="${application_munites_row.ar_name}"
															data-minute-to="${application_munites_row.am_to_officer}"
															data-minute-date="${application_munites_row.am_activity_date}"
															data-minute-case-number="${case_number}"
															data-minute-job-number="${job_number}"
															data-minute-status="${application_munites_row.status || 'active'}">
                                                            <i class="bi bi-eye"></i>
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

                    <!-- Documents -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseDocuments">
                                <i class="bi bi-files me-2"></i>
                                Application Documents
                            </button>
                        </h2>
                        <div id="collapseDocuments" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="d-flex gap-2 mb-3">
                                    <button class="btn btn-sm btn-outline-primary" id="btn_load_scanned_documents">
                                        <i class="bi bi-eye"></i> Load Docs
                                    </button>
                                    <button class="btn btn-sm btn-primary" id="btn_add_public_document"
                                            data-bs-toggle="modal" data-bs-target="#fileUploadModal">
                                        <i class="bi bi-plus"></i> Add
                                    </button>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover" id="lc_main_scanned_documents_dataTable">
                                        <thead>
                                            <tr>
                                                <th>Document Name</th>
                                                <th>Type</th>
                                                <!-- <th>Action</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Public Documents -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapsePublicDocs">
                                <i class="bi bi-globe me-2"></i>
                                Public Documents
                            </button>
                        </h2>
                        <div id="collapsePublicDocs" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="d-flex gap-2 mb-3">
                                    <button class="btn btn-sm btn-outline-primary" id="btn_load_scanned_documents_public">
                                        <i class="bi bi-eye"></i> Load Docs
                                    </button>
                                    <button class="btn btn-sm btn-primary" id="btn_add_public_document"
                                            data-bs-toggle="modal" data-bs-target="#publicFileUploadModal">
                                        <i class="bi bi-plus"></i> Add
                                    </button>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover" id="lc_public_documents_dataTable">
                                        <thead>
                                            <tr>
                                                <th>Document Name</th>
                                                <th>Type</th>
                                                <!-- <th>Action</th> -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Queries -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseQueries">
                                <i class="bi bi-question-circle me-2"></i>
                                Queries
                                <span class="badge bg-danger ms-2">${case_query.size()}</span>
                            </button>
                        </h2>
                        <div id="collapseQueries" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover">
                                        <thead>
                                            <tr>
                                                <th>Reason</th>
                                                <th>Date</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${case_query}" var="case_query_row">
                                                <tr>
                                                    <td>${case_query_row.reasons}</td>
                                                    <td>${case_query_row.created_date}</td>
                                                    <td>
                                                        <span class="badge ${case_query_row.status == 1 ? 'bg-danger text-white' : 'bg-success text-white'}">
                                                            ${case_query_row.status == 1 ? 'Pending' : 'Resolved'}
                                                        </span>
                                                    </td>
                                                    <td class="d-flex gap-1">
                                                        <button class="btn btn-sm ${case_query_row.status == 1 ? 'btn-warning' : 'btn-outline-info'}"
                                                                data-bs-toggle="modal" data-bs-target="#viewQueryModal"
                                                                data-action="${case_query_row.status == 1 ? 'edit' : 'view'}"
                                                                data-id="${case_query_row.qid}"
                                                                data-job_number="${case_query_row.job_number}"
																data-case_number="${case_query_row.case_number}"
                                                                data-reasons="${case_query_row.reasons}"
                                                                data-remarks="${case_query_row.remarks}"
																data-general_reason="${case_query_row.query_general_reason}"
																data-query_response="${case_query_row.query_response}"
                                                                data-status="${case_query_row.status}"
																data-created_by="${case_query_row.created_by}"
																data-created_date="${case_query_row.created_date}"
																data-modified_by="${case_query_row.modified_by}"
																data-modified_date="${case_query_row.modified_date}"
																data-attachment_required="${case_query_row.attachment_required}">
                                                            <i class="bi bi-eye"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-danger"
                                                                data-bs-toggle="modal" data-bs-target="#newQueryModal"
                                                                data-action="edit"
                                                                data-id="${case_query_row.qid}"
                                                                data-job_number="${case_query_row.job_number}"
																data-case_number="${case_query_row.case_number}"
                                                                data-reasons="${case_query_row.reasons}"
                                                                data-remarks="${case_query_row.remarks}"
																data-general_reason="${case_query_row.query_general_reason}"
																data-query_response="${case_query_row.query_response}"
                                                                data-status="${case_query_row.status}"
																data-created_by="${case_query_row.created_by}"
																data-created_date="${case_query_row.created_date}"
																data-modified_by="${case_query_row.modified_by}"
																data-modified_date="${case_query_row.modified_date}"
																data-attachment_required="${case_query_row.attachment_required}">
                                                            <i class="bi bi-pencil"></i>
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

                    <!-- Case Steps -->
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#collapseCaseSteps">
                                <i class="bi bi-list me-2"></i>
                                Case Steps
                            </button>
                        </h2>
                        <div id="collapseCaseSteps" class="accordion-collapse collapse" 
                             data-bs-parent="#sidebarAccordion">
                            <div class="accordion-body">
                                <ul class="process-list">
                                    <c:forEach items="${baby_step_milestone_list}" var="milestone">
                                        <div class="milestone">
                                            <h6>${milestone.milestone_description} (Status: ${milestone.mile_stone_status})</h6>
                                            <ul>
                                                <c:forEach items="${milestone.baby_steps}" var="process">
                                                    <li>
                                                        <i class="fas ${process.bse_status == 'Completed' ? 'fa-check-circle text-success' : process.bse_status == 'Ongoing' ? 'fa-spinner text-warning' : 'fa-times-circle text-danger'}"></i>
                                                        <div>
                                                            <div class="process-item">${process.bse_description}</div>
                                                            <div class="process-details">
                                                                <span>Performed by: ${process.completed_by != null ? process.completed_by : 'Pending'}</span>
                                                                <span>Date: 
                                                                    <c:choose>
                                                                        <c:when test="${process.complete_by_date != null}">
                                                                            <fmt:parseDate value="${process.complete_by_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                                                                            <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
                                                                        </c:when>
                                                                        <c:otherwise>N/A</c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                                <span>Time: 
                                                                    <c:choose>
                                                                        <c:when test="${process.complete_by_date != null}">
                                                                            <fmt:parseDate value="${process.complete_by_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                                                                            <fmt:formatDate value="${parsedDate}" pattern="HH:mm:ss" />
                                                                        </c:when>
                                                                        <c:otherwise>N/A</c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Define EPSG:2136 projection
    //   proj4.defs('EPSG:2136', '+proj=utm +zone=36 +south +ellps=clrk80 +units=m +no_defs');

    function editStep(stepId) {
        alert('Editing step with ID: '+stepId);
    }

    // Function to handle deleting a step
    function deleteStep(stepId) {
        const confirmation = confirm('Are you sure you want to delete the step with ID: '+stepId+'?');
        if (confirmation) {
            alert('Deleted step with ID: '+stepId);
            // Replace the alert with your logic for deleting
        }
    }

    function reviewStep(bse_id, job_number) {
        Swal.fire({
            title: 'Confirm Approval',
            text: 'Are you sure you want to approve this step?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, approve it!',
            cancelButtonText: 'Cancel',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                if (!bse_id || !job_number) {
                    Swal.fire({
                        title: 'Error!',
                        text: 'Sorry! An error occurred, try again.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                // Show loading state
                Swal.fire({
                    title: 'Processing...',
                    text: 'Please wait while we approve the step',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });

                $.ajax({
                    type: "POST",
                    url: "Case_Management_Serv",
                    data: {
                        request_type: 'select_review_baby_steps_check_for_completion',
                        bse_id: parseInt(bse_id),
                        job_number: job_number
                    },
                    cache: false,
                    success: function(response) {
                        console.log(response);
                        var json_result = JSON.parse(response);
                        
                        Swal.close();
                        
                        if (json_result.success) {
                            Swal.fire({
                                title: 'Success!',
                                text: json_result.msg,
                                icon: 'success',
                                confirmButtonText: 'OK',
                                timer: 2000,
                                timerProgressBar: true,
                                willClose: () => {
                                    location.reload();
                                }
                            });
                        } else {
                            Swal.fire({
                                title: 'Failed!',
                                text: json_result.msg,
                                icon: 'error',
                                confirmButtonText: 'OK'
                            });
                        }
                    },
                    error: function() {
                        Swal.fire({
                            title: 'Error!',
                            text: 'An error occurred while processing your request.',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    }
                });
            }
        });
    }

    // Initialize the map when the DOM is fully loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Placeholder coordinates (longitude, latitude) for the parcel
        // In a real implementation, these should be dynamically fetched based on GLPIN or other parcel data
        var parcel_lrd_dataSource = new ol.source.TileWMS({
            url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
            params : {
                'LAYERS' : 'csau_geospatial:lc_spatial_objects',
                'TILED' : true
            },
            serverType : 'geoserver',
            transition : 0
        }) 

        var lrd_parcels_dataLayer = new ol.layer.Tile({
            title : 'LRD Parcels Layer',
            source : parcel_lrd_dataSource

        })


        var lrd_certificate_region_dataSource = new ol.source.TileWMS({
            url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
            params : {
                'LAYERS' : 'csau_geospatial:lrd_certificate_region',
                'TILED' : true
            },

            serverType : 'geoserver',
            transition : 0
        })

        var lrd_certificate_region_dataLayer = new ol.layer.Tile({
            title : 'LRD Certificate Region',
            visible : false,
            source : lrd_certificate_region_dataSource

        })


        var lcfrs_grid_lrd_dataSource = new ol.source.TileWMS({
            url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
            params : {
                'LAYERS' : 'csau_geospatial:gng_grid',
                'TILED' : true
            },
            
            serverType : 'geoserver',
            transition : 0
        })
                    
        var lcfrs_grid_lrd_dataLayer = new ol.layer.Tile({
            title : 'Grid',
            visible : false,
            source : lcfrs_grid_lrd_dataSource
        })
                    
        var lcfrs_registration_district_dataSource = new ol.source.TileWMS({
            url : getGeoServerEndPoint() + '/geoserver/csau_geospatial/wms',
            params : {
                'LAYERS' : 'csau_geospatial:district',
                'TILED' : true
            },
                    
            serverType : 'geoserver',
            transition : 0
        })
                    
        var lcfrs_registration_district_dataLayer = new ol.layer.Tile({
            title : 'Registration District',
            visible : false,
            source : lcfrs_registration_district_dataSource
        })

        var googleLayerHybrid = new ol.layer.Tile({
            title : "Google Satellite & Roads",
            // 'type': 'base',
            visible : false,
            opacity : 1.000000,
            source : new ol.source.XYZ({
                attributions : [ new ol.Attribution({
                    html : '<a href=""></a>'
                }) ],
                url : 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga'
            }),
        });  

        var projObj = new ol.proj.Projection({
            // code: 'EPSG:3857',
            code : 'EPSG:2136',
            extent : [ 80935.4497355444, 1209.0295731349593, 1711780.3060929566,
                    2358523.124783509 ],
            units : 'ft',
            axisOrientation : 'enu',
            global : false,
            // worldExtent: [-199,32,322,0],
            worldExtent : [ -3.79, 1.4, 2.1, 11.16 ],
            getPointResolution : function(r) {
                return r;
            },
            // worldExtent: [-118905.86588345, -1185221.57235827,
            // 2011055.53818079,
            // 2360318.82691170]
            // extent: [32000000,5900000,33000000,6000000]
            // extent: [32502277,5970203,32513486,5971984]
        });

        ol.proj.setProj4(proj4);
        proj4 .defs( "EPSG:2136",'+proj=tmerc +lat_0=4.666666666666667 +lon_0=-1 +k=0.99975 +x_0=274319.7391633579 +y_0=0 +a=6378300 +b=6356751.689189189 +towgs84=-199,32,322,0,0,0,0 +to_meter=0.3047997101815088 +no_defs');


        const wktPolygon = '${parcel_wkt}';

        // console.log('wktPolygon')
        // console.log(wktPolygon)

        // Parse WKT to OpenLayers geometry
               
        //   vectorLayer.setSource(new ol.source.Vector({features : (new ol.format.WKT()).readFeatures(wktPolygon)}));
             
        // Initialize OpenLayers map
        const map = new ol.Map({
            target: 'parcelMap',
            controls : ol.control.defaults().extend(
			[ new ol.control.LayerSwitcher(),
			new ol.control.OverviewMap(),
			new ol.control.ZoomSlider(), new ol.control.Attribution(),
					new ol.control.MousePosition(),
					new ol.control.ZoomToExtent(), new ol.control.FullScreen()
			]),
	        renderer : 'canvas',
            layers: [
                new ol.layer.Tile({
                    source: new ol.source.OSM()
                })
            ],
            view: new ol.View({
              projection : projObj,
              extent : ol.proj.get('EPSG:2136').getExtent(),
                center : [ 1187433.58822084, 327091.107070208 ],
                zoom: 12
            })
        });

        // Add the polygon to the map
        // const vectorSource = new ol.source.Vector({
        //     features: [polygonFeature]
        // });

        const vectorLayer = new ol.layer.Vector({
            source: new ol.source.Vector(),
            style: new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: '#ff0000',
                    width: 2
                }),
                fill: new ol.style.Fill({
                    color: 'rgba(255, 0, 0, 0.2)'
                })
            })
        });

        map.addLayer(googleLayerHybrid);
        map.addLayer(lcfrs_registration_district_dataLayer);
        map.addLayer(lrd_parcels_dataLayer);
        map.addLayer(vectorLayer);

        // console.log("wktPolygon")
        // console.log(wktPolygon)
        vectorLayer.setSource(new ol.source.Vector({features : (new ol.format.WKT()).readFeatures(wktPolygon)}));
        map.getView().fit(vectorLayer.getSource().getExtent(),{size : map.getSize(),maxZoom : 16})
        

    });

    
</script>

<jsp:include page="../../components/_gated_workflow_modal.jsp"></jsp:include>