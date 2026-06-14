<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>


<div class="modal fade modal-blur effect-slide" id="recommend_execution_of_certificate_rh" tabindex="-1"
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
                        <h5 class="modal-title text-white mb-0" id="generateConcurrenceCertificateLabelrh">
                            Generate Certificate
                        </h5>
                        <p class="mb-0 small opacity-75">Create and manage certificates</p>
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
                            <!-- <span class="ms-auto">
                                <button class="btn btn-sm btn-danger" id="btn_compose_concurrence_certificate_template">
                                    <i class="bi bi-pencil-square me-1"></i>
                                    Compose Template
                                </button>
                            </span> -->
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
                                <div id="lc_concurrence_certificate_summary_details_rh">
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
                                <button type="button" name="lc_btn_save_search_report_cs_rh" 
                                        id="lc_btn_save_search_report_cs_rh" 
                                        class="btn btn-outline-secondary w-100 py-3 save-btn">
                                    <div class="d-flex align-items-center justify-content-center">
                                        <i class="bi bi-cloud-arrow-up fs-5 me-2"></i>
                                        <span>Save Certificate</span>
                                    </div>
                                </button>
                            </div>

                            <!-- Generate Certificate Button -->
                            <div class="col-md-6">
                                <button type="button" name="lc_btn_activate_final_concurrence_certificate_cs_rh" 
                                        id="lc_btn_activate_final_concurrence_certificate_cs_rh" 
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

                <div class="d-flex align-items-center mb-3 mt-4">
                    <h6 class="fw-semibold text-primary mb-0">
                        <i class="bi bi-card-text me-2"></i>
                        Application Minutes
                    </h6>
                    <!-- <span class="ms-auto">
                        <button class="btn btn-sm btn-danger" id="btn_compose_concurrence_certificate_template">
                            <i class="bi bi-pencil-square me-1"></i>
                            Compose Template
                        </button>
                    </span> -->
                </div>
                <div class="card">
                    <div class="card-body">
                        <button class="btn btn-sm btn-primary btn_add_minutes_rh">
                            <i class="bi bi-plus"></i> Add Minutes
                        </button>
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



<div class="modal fade modal-blur effect-scale" id="review_generated_concurrence_certificate" tabindex="-1"
	role="dialog" aria-labelledby="review_generated_concurrence_certificate" aria-hidden="true"
>
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="review_generated_concurrence_certificate_label">
                    <i class="fas fa-eye me-2"></i>
                    Review Generated Certificate
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			
			<div class="modal-body">
				<!-- Description Section -->
				<div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
					<div class="d-flex">
						<i class="fas fa-info-circle fa-lg me-3 mt-1 text-info"></i>
						<div>
							<h6 class="alert-heading mb-2">About Generated Certificate Preview</h6>
							<p class="mb-2">Use this feature to review the composed certificate before final submission. The preview will display the formatted certificate exactly as it will appear when generated.</p>
						</div>
					</div>
				</div>
				
				
				
				<!-- Preview Action Section -->
				<div class="text-center p-4 border-dashed rounded-3 bg-light">
					<i class="fas fa-file-pdf text-warning fa-3x mb-3"></i>
					<h5 class="mb-3">Ready to Preview Generated Certificate</h5>
					<p class="text-muted mb-4">
						Click the button below to generate and view a preview of the certificate. 
						The preview will open in a new window for easy review and printing.
					</p>
					
					<div class="d-grid gap-2 d-md-flex justify-content-center">
						<button type="button" id="lc_btn_activate_final_concurrence_certificate_cs_rh_2" class="btn btn-warning btn-lg px-4">
							<i class="fas fa-eye me-2"></i> 
							<span class="fw-semibold">View Generated Certificate</span>
						</button>
					</div>
					
					<small class="text-muted d-block mt-3">
						<i class="fas fa-exclamation-circle me-1"></i>
						Note: Any unsaved changes will not appear in the preview.
					</small>
				</div>

                <!-- <div class="d-flex align-items-center mb-3 mt-4">
                    <h6 class="fw-semibold text-primary mb-0">
                        <i class="bi bi-card-text me-2"></i>
                        Application Minutes
                    </h6>
                </div>
                <div class="card">
                    <div class="card-body">
                        <button class="btn btn-sm btn-primary btn_add_minutes_rh">
                            <i class="bi bi-plus"></i> Add Minutes
                        </button>
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
                </div> -->
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


<div class="modal fade modal-blur effect-scale" id="request_for_file_creation" tabindex="-1"
     role="dialog" aria-labelledby="request_for_file_creation_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header with Gradient -->
            <div class="modal-header bg-primary text-white border-0">
                <div>
                    <h5 class="modal-title text-white mb-0" id="request_for_file_creation_label">
                        <i class="bi bi-folder2-open me-2"></i>
                        Open File
                    </h5>
                    <p class="mb-0 small opacity-75 mt-1">
                        <i class="bi bi-info-circle me-1"></i>
                        This application process requires creation of a physical file at the file room
                    </p>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body p-4">
                
                <!-- Application Information Card -->
                <div class="card border-0 bg-light mb-4">
                    <div class="card-header bg-white bg-opacity-50 border-0">
                        <h6 class="mb-0">
                            <i class="bi bi-file-text me-2 text-primary"></i>
                            Application Details
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="d-flex align-items-center">
                                    <!-- <div class="avatar-sm bg-primary bg-opacity-10 rounded-circle me-2">
                                        <i class="bi bi-briefcase text-primary mt-5 ms-2"></i>
                                    </div> -->
                                    <div>
                                        <small class="text-muted d-block">Job Number</small>
                                        <strong class="text-dark">${job_number}</strong>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex align-items-center">
                                    <!-- <div class="avatar-sm bg-success bg-opacity-10 rounded-circle me-2">
                                        <i class="bi bi-person-badge text-success mt-5 ms-2"></i>
                                    </div> -->
                                    <div>
                                        <small class="text-muted d-block">Application Type</small>
                                        <strong class="text-dark">${business_process_sub_name}</strong>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex align-items-center">
                                    <!-- <div class="avatar-sm bg-info bg-opacity-10 rounded-circle me-2">
                                        <i class="bi bi-person text-info"></i>
                                    </div> -->
                                    <div>
                                        <small class="text-muted d-block">Applicant</small>
                                        <strong class="text-dark">${ar_name}</strong>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex align-items-center">
                                    <!-- <div class="avatar-sm bg-info bg-opacity-10 rounded-circle me-2">
                                        <i class="bi bi-person text-info"></i>
                                    </div> -->
                                    <div>
                                        <small class="text-muted d-block">File Number</small>
                                        <strong class="text-dark">${file_number}</strong>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex align-items-center">
                                    <!-- <div class="avatar-sm bg-info bg-opacity-10 rounded-circle me-2">
                                        <i class="bi bi-person text-info"></i>
                                    </div> -->
                                    <div>
                                        <small class="text-muted d-block">Deed Number</small>
                                        <strong class="text-dark">${deed_number}</strong>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex align-items-center">
                                    <!-- <div class="avatar-sm bg-info bg-opacity-10 rounded-circle me-2">
                                        <i class="bi bi-person text-info"></i>
                                    </div> -->
                                    <div>
                                        <small class="text-muted d-block">Locality</small>
                                        <strong class="text-dark">${locality}</strong>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex align-items-center">
                                    <!-- <div class="avatar-sm bg-info bg-opacity-10 rounded-circle me-2">
                                        <i class="bi bi-person text-info"></i>
                                    </div> -->
                                    <div>
                                        <small class="text-muted d-block">Type of Transfer</small>
                                        <strong class="text-dark">${intended_parcel}</strong>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Batch Information Card -->
                <!-- <div class="card border-0 mb-4">
                    <div class="card-header bg-white border-0">
                        <h6 class="mb-0">
                            <i class="bi bi-collection me-2 text-primary"></i>
                            File Creation Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-warning border-0">
                            <div class="d-flex">
                                <i class="bi bi-question-circle-fill fs-4 me-2"></i>
                                <div>
                                    <strong>Why physical file creation?</strong><br>
                                    <small>

                                    </small>
                                </div>
                            </div>
                        </div>
                        <small class="text-muted">Status: Ready for file creation</small>
                    </div>
                </div> -->
                
                <!-- Action Buttons -->
                <c:if test="${fn:containsIgnoreCase(business_process_sub_name, 'CONSENT') or fn:containsIgnoreCase(business_process_sub_name, 'CONCURRENCE')}">
                  <div class="d-flex gap-3">
                      <button class="btn btn-primary flex-grow-1 py-3" id="lc_btn_activate_final_concurrence_certificate_cs_rh_3">
                          <i class="bi bi-download me-2"></i>
                          Download Generated Certificate
                          <small class="d-block mt-1 fs-12">View and Download the certificate, and add to the physical file</small>
                      </button>
                      
                      <button class="btn btn-outline-secondary flex-grow-1 py-3" data-bs-dismiss="modal">
                          <i class="bi bi-x-circle me-2"></i>
                          Cancel
                          <small class="d-block mt-1 fs-12">Return to previous screen</small>
                      </button>
                  </div>
                </c:if>
                
            </div>

        </div>
    </div>
</div>


<div class="modal fade modal-blur effect-scale" id="recommend_execution_of_certificate_rlo" tabindex="-1"
	role="dialog" aria-labelledby="recommend_execution_of_certificate_rlo" aria-hidden="true"
>
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="recommend_execution_of_certificate_rlo_label">
                    <i class="bi bi-file-earmark me-2"></i>
                    Recommend Execution of Certificate
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			
			<div class="modal-body">
				
                <div class="card">
                    <div class="card-body">
                        <button class="btn btn-sm btn-primary btn_add_minutes_rh">
                            <i class="bi bi-plus"></i> Add Minutes
                        </button>
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
                                            <td class="fs-12">${application_munites_row.am_from_officer}</td>
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
			
			<div class="modal-footer bg-light">
				<button type="button" 
					class="btn btn-outline-danger"
					data-bs-dismiss="modal">
					<i class="fas fa-times me-2"></i>
					Close
				</button>
			</div>
		</div>
	</div>
</div>



<div class="modal fade modal-blur effect-scale" id="review_generated_lrd_numbers" tabindex="-1"
	role="dialog" aria-labelledby="review_generated_lrd_numbers" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="review_generated_lrd_numbers_label">
                    <i class="bi bi-file-earmark me-2"></i>
                    Generated Numbers
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			
			<div class="modal-body">
				<div class="text-center mb-4">
					<div class="avatar-lg bg-success bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 80px; height: 80px;">
						<i class="fas fa-check-circle text-success" style="font-size: 40px;"></i>
					</div>
					<h5 class="mb-1">Generated Numbers</h5>
					<p class="text-muted small">The following numbers have been generated for the application transaction</p>
				</div>
				
				<div class="card border shadow-none bg-light mb-3">
					<div class="card-body">
						
						<div class="d-flex align-items-center mb-3 pb-2 border-bottom">
							<div class="avatar-sm bg-info bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
								<i class="fas fa-briefcase text-info"></i>
							</div>
							<div>
								<span class="text-muted small d-block">Job Number</span>
								<strong class="fs-5">${job_number}</strong>
							</div>
						</div>

            <div class="d-flex align-items-center mb-3 pb-2 border-bottom">
							<div class="avatar-sm bg-danger bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
								<i class="ri-fingerprint-2-fill text-danger"></i>
							</div>
							<div>
								<span class="text-muted small d-block">GLPIN</span>
								<strong class="fs-5">${glpin}</strong>
							</div>
						</div>

            <div class="d-flex align-items-center mb-3 pb-2 border-bottom">
							<div class="avatar-sm bg-secondary bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
								<i class="ri-calendar-2-line text-secondary"></i>
							</div>
							<div>
								<span class="text-muted small d-block">Registration Date</span>
                <fmt:parseDate value="${date_of_registration}" pattern="yyyy-MM-dd" var="parsedRegistrationDate"/>
                <fmt:formatDate value="${parsedRegistrationDate}" pattern="dd MMM yyyy" var="formattedRegistrationDate"/>
                <div class="fw-medium text-dark"></div>
								<strong class="fs-5">${empty formattedRegistrationDate ? '--' : formattedRegistrationDate}</strong>
							</div>
						</div>
 
            <div class="d-flex align-items-center mb-3 pb-2 border-bottom">
							<div class="avatar-sm bg-info bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
								<i class="ri-time-line text-info"></i>
							</div>
							<div>
								<span class="text-muted small d-block">Registration Time</span>
								<strong class="fs-5">${empty time_of_registration ? '--' : time_of_registration}</strong>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 pb-2 border-bottom">
							<div class="avatar-sm bg-primary bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
								<i class="fas fa-folder-open text-primary"></i>
							</div>
							<div>
								<span class="text-muted small d-block">File Number</span>
								<strong class="fs-5">${file_number}</strong>
							</div>
						</div>
						
						<div class="d-flex align-items-center mb-3 pb-2 border-bottom">
							<div class="avatar-sm bg-warning bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
								<i class="fas fa-file-signature text-warning"></i>
							</div>
							<div>
								<span class="text-muted small d-block">Deed Number</span>
								<strong class="fs-5">${deed_number}</strong>
							</div>
						</div>
						
						<div class="d-flex align-items-center">
							<div class="avatar-sm bg-secondary bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
								<i class="fas fa-hashtag text-secondary"></i>
							</div>
							<div>
								<span class="text-muted small d-block">Serial Number</span>
								<strong class="fs-5">${ls_number}</strong>
							</div>
						</div>
					</div>
				</div>
				
				<!-- <div class="alert alert-info border-0 mb-0">
					<div class="d-flex">
						<div class="flex-shrink-0">
							<i class="fas fa-info-circle fa-lg"></i>
						</div>
						<div class="flex-grow-1 ms-2">
							<small>
								<strong>Information Note:</strong> Please verify that all generated numbers are correct before proceeding. 
								These numbers will be used for all related documentation and transactions.
							</small>
						</div>
					</div>
				</div> -->
			</div>
			
			<div class="modal-footer bg-light">
				<button type="button" 
					class="btn btn-outline-danger"
					data-bs-dismiss="modal">
					<i class="fas fa-times me-2"></i>
					Close
				</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="check_interest_and_sub_interest_mother_file_for_deed" tabindex="-1"
     aria-labelledby="checkInterestModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="checkInterestModalLabelDeed">
          <i class="fas fa-archive me-2"></i>
          Check Interest and Sub-Interest Mother File
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Search Form Card -->
        <div class="card mb-4">
          <div class="card-header bg-primary bg-opacity-10 text-primary">
            <h6 class="mb-0">
              <i class="fas fa-search me-2"></i>
              Search Mother File
            </h6>
          </div>
          <div class="card-body">
            <form id="linkSearchMotherfileInterest_deed" method="post">
              
              <!-- Search Type Selection -->
              <div class="mb-4">
                <label class="form-label fw-medium mb-3">
                  <i class="fas fa-filter me-1"></i>
                  Search By:
                </label>
                <div class="d-flex flex-wrap gap-3">
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type__deed" 
                           id="rbtn_search_type10_d" value="job_number" required>
                    <label class="form-check-label" for="rbtn_search_type10_d">
                      Job Number
                    </label>
                  </div>
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type__deed" 
                           id="rbtn_search_type11_d" value="certificate_number" required>
                    <label class="form-check-label" for="rbtn_search_type11_d">
                      File Number/ Deed Number/ Serial Number
                    </label>
                  </div>
                </div>
              </div>
              
              <!-- Search Input -->
              <div class="row g-3 align-items-end">
                <div class="col-md-8">
                  <div class="form-group">
                    <label for="link_search_value__deed" class="form-label fw-medium">
                      <i class="fas fa-keyboard me-1"></i>
                      Search Value
                    </label>
                    <div class="input-group">
                      <span class="input-group-text">
                        <i class="fas fa-search"></i>
                      </span>
                      <input class="form-control" id="link_search_value__deed" name="link_search_value__deed" 
                             type="text" placeholder="Enter job number or serial number or file number or deed number" required>
                    </div>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <button type="submit" class="btn btn-primary w-100" id="btnEnquiryJobSearch_deed">
                      <i class="fas fa-search me-2"></i>
                      Search
                    </button>
                  </div>
                </div>
                <div class="form-text">
                    Enter the job number or certificate number to search for mother file
                </div>
              </div>
              
            </form>
          </div>
        </div>
        
        <!-- Results Section -->
        <div class="card border-success" style="display:none" id="link-search-results-section__deed">
          <div class="card-header bg-success bg-opacity-10 text-success">
            <div class="d-flex justify-content-between align-items-center">
              <h6 class="mb-0">
                <i class="fas fa-file-alt me-2"></i>
                Search Results
              </h6>
              <span class="badge bg-success rounded-pill">Found</span>
            </div>
          </div>
          <div class="card-body">
            
            <!-- Loading State -->
            <div id="loadingResults_deed" class="text-center py-5 d-none">
              <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
              <p class="mt-3 text-muted">Searching for mother file...</p>
            </div>
            
            <!-- Results Content -->
            <div id="resultsContent_deed" class="d-none">
              <div class="row g-4">
                
                <!-- Interest Number Card -->
                <div class="col-md-6">
                  <div class="card border-info h-100">
                    <div class="card-header bg-info bg-opacity-10 text-info">
                      <div class="d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">
                          <i class="fas fa-hashtag me-2"></i>
                          Interest Number
                        </h6>
                        <span class="badge bg-info">Main</span>
                      </div>
                    </div>
                    <div class="card-body text-center p-4">
                      <div class="mb-3">
                        <i class="fas fa-key fa-3x text-info"></i>
                      </div>
                      <div class="display-value fs-5 fw-bold text-info mb-3" id="chk_interest_number_d">
                        -
                      </div>
                      <p class="text-muted small mb-0">
                        Primary interest identifier for the mother file
                      </p>
                    </div>
                  </div>
                </div>
                
                <!-- Sub-Interest Number Card -->
                <div class="col-md-6">
                  <div class="card border-warning h-100">
                    <div class="card-header bg-warning bg-opacity-10 text-warning">
                      <div class="d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">
                          <i class="fas fa-layer-group me-2"></i>
                          Sub-Interest Number
                        </h6>
                        <span class="badge bg-warning">Secondary</span>
                      </div>
                    </div>
                    <div class="card-body text-center p-4">
                      <div class="mb-3">
                        <i class="fas fa-sitemap fa-3x text-warning"></i>
                      </div>
                      <div class="display-value fs-5 fw-bold text-warning mb-3" id="chk_sub_interest_number_d">
                        -
                      </div>
                      <p class="text-muted small mb-0">
                        Secondary interest identifier under the main interest
                      </p>
                    </div>
                  </div>
                </div>
                
              </div>
              
              <!-- Additional Information -->
              <div class="alert alert-info bg-info bg-opacity-10 border-info mt-4">
                <div class="d-flex">
                  <i class="fas fa-info-circle me-3 mt-1"></i>
                  <div>
                    <strong>About Interest Numbers:</strong>
                    <ul class="mb-0 mt-2 ps-3">
                      <li>Interest Number identifies the primary legal interest in the property</li>
                      <li>Sub-Interest Number identifies subsidiary interests or divisions</li>
                      <li>Both numbers are essential for complete mother file identification</li>
                      <li>Used for cross-referencing and legal documentation</li>
                    </ul>
                  </div>
                </div>
              </div>
              
            </div>
            
            <!-- No Results Message -->
            <div id="noResultsMessage" class="text-center py-5 d-none">
              <div class="mb-3">
                <i class="fas fa-file-excel fa-3x text-muted"></i>
              </div>
              <h6 class="text-muted">No Mother Files Found</h6>
              <p class="text-muted small">Try searching with a different job number or certificate number</p>
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

<div class="modal fade effect-scale modal-blur" id="link_to_mother_file_for_deed" tabindex="-1"
     aria-labelledby="linkToMotherFileModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="linkToMotherFileModalLabel_deed">
          <i class="fas fa-link me-2"></i>
          Link to Mother File
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
         <input class="form-control" hidden id="linkedMotherFile_deed" value="${mother_to_child_link_list}" />    
         <div class="mb-3" id="htmlLinkedMotherFile_deed"></div>
        <!-- Search Form Card -->
        <div class="card">
          <div class="card-header bg-primary bg-opacity-10 text-primary">
            <h6 class="mb-0">
              <i class="fas fa-search me-2"></i>
              Search Mother File
            </h6>
          </div>
          <div class="card-body">
            <form id="linkSearchMotherfile__deed" method="post">
              
              <!-- Search Type Selection -->
              <div class="mb-4">
                <label class="form-label fw-medium mb-3">
                  <i class="fas fa-filter me-1"></i>
                  Search By:
                </label>
                <div class="d-flex flex-wrap gap-3">
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type_deed" 
                           id="rbtn_search_type7_d" value="job_number" required>
                    <label class="form-check-label" for="rbtn_search_type7_d">
                      Job Number
                    </label>
                  </div>
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type_deed" 
                           id="rbtn_search_type8_d" value="certificate_number" required>
                    <label class="form-check-label" for="rbtn_search_type8_d">
                      File Number/ Deed Number/ Serial Number
                    </label>
                  </div>
                </div>
              </div>
              
              <!-- Search Input -->
              <div class="row g-3 align-items-end">
                <div class="col-md-8">
                  <div class="form-group">
                    <label for="link_search_value_" class="form-label fw-medium">
                      <i class="fas fa-keyboard me-1"></i>
                      Search Value
                    </label>
                    <div class="input-group">
                      <span class="input-group-text">
                        <i class="fas fa-search"></i>
                      </span>
                      <input class="form-control" id="link_search_value_deed" name="link_search_value_deed" 
                             type="text" placeholder="Enter job number or serial number or job number or deed number" required>
                    </div>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <button type="submit" class="btn btn-primary w-100" id="btnEnquiryJobSearch">
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
        <div class="card border-success mt-4" style="display:none" id="link-search-results-section_deed">
          <div class="card-header bg-success bg-opacity-10 text-success">
            <div class="d-flex justify-content-between align-items-center">
              <h6 class="mb-0">
                <i class="fas fa-file-alt me-2"></i>
                Search Results
              </h6>
              <span class="badge bg-success" id="resultsCount_deed">0 results</span>
            </div>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-hover table-striped" id="link-search-results-table_deed">
                <thead class="table-light">
                  <tr>
                    <th width="25%">
                      <!-- <i class="fas fa-user me-1"></i> -->
                      Applicant Name
                    </th>
                    <th width="30%">
                      <!-- <i class="fas fa-certificate me-1"></i> -->
                     File Number/ Deed Number/ Serial Number
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
            <div id="noResultsMessage_deed" class="text-center py-5 d-none">
              <div class="mb-3">
                <i class="fas fa-file-excel fa-3x text-muted"></i>
              </div>
              <h6 class="text-muted">No Mother Files Found</h6>
              <p class="text-muted small">Try searching with a different job number or certificate number</p>
            </div>
            
            <!-- Loading State -->
            <div id="loadingResults_deed" class="text-center py-5 d-none">
              <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
              <p class="mt-3 text-muted">Searching for mother files...</p>
            </div>
            
          </div>
        </div>
        
        <div class="card mt-2">
            <div class="card-header bg-primary bg-opacity-10 text-primary">
                <h6 class="mb-0">
                    <i class="fas fa-link me-2"></i>
                    Link Application to Mother File
                </h6>
            </div>
            <div class="card-body">
                
                <!-- Search Type Selection -->
                <div class="mb-4">
                    <label class="form-label fw-medium mb-3">
                        <i class="fas fa-filter me-1"></i>
                        Search By:
                    </label>
                    <div class="d-flex flex-wrap gap-3">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="rbtn_search_type_deed" 
                                id="rbtn_search_type5_d" value="job_number" required>
                            <label class="form-check-label" for="rbtn_search_type5_d">
                                Job Number
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="rbtn_search_type_deed" 
                                id="rbtn_search_type6_d" value="certificate_number" required>
                            <label class="form-check-label" for="rbtn_search_type6_d">
                               File Number/ Deed Number/ Serial Number
                            </label>
                        </div>
                    </div>
                </div>
                
                <!-- Search Input and Button -->
                <div class="row g-3 align-items-end">
                    <div class="col-md-8">
                        <div class="form-group">
                            <label for="lrd_search_for_mother_transction_to_child_deed" class="form-label fw-medium">
                                <i class="fas fa-search me-1"></i>
                                Search Value
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-file-contract"></i>
                                </span>
                                <input class="form-control bg-light" id="lrd_search_for_mother_transction_to_child_deed" 
                                    name="lrd_search_for_mother_transction_to_child_deed" type="text"  style="cursor: not-allowed;"
                                    placeholder="Enter Job Number or Serial Number or File Number or Deed Number of the Mother File" readonly required>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <button type="button" class="btn btn-primary w-100" 
                                    id="lrd_btn_search_for_mother_transction_to_child_deed"
                                    data-bs-toggle="tooltip" data-bs-placement="top" title="Search and Link">
                                <i class="fas fa-link me-2"></i>
                                Link Application
                            </button>
                        </div>
                    </div>
                    <div class="form-text">
                        Enter the Job Number or Certificate Number of the mother file to link
                    </div>
                </div>
                
                <!-- Optional: Information Alert -->
                <div class="alert alert-info bg-info bg-opacity-10 border-info mt-4">
                    <div class="d-flex">
                        <i class="fas fa-info-circle me-3 mt-1"></i>
                        <div>
                            <strong>About Linking:</strong>
                            <p class="mb-0 mt-2">
                                Linking applications to mother files creates a relationship between the current application 
                                and existing mother file records for reference and tracking purposes.
                            </p>
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
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="enter_transaction_details_for_deed" tabindex="-1" 
     aria-labelledby="enter_transaction_details_for_deed_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div>
                    <h5 class="modal-title text-white mb-0" id="enter_transaction_details_for_deed_label">
                        <i class="fas fa-file-contract me-2"></i>
                        Enter Transaction Details
                    </h5>
                    <p class="mb-0 small opacity-75 mt-1">Complete the deed transaction information below</p>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                <div class="row">
                    <div class="col-lg-6 d-flex flex-column scrollable-col">
                        <form id="form_transaction_details" novalidate>
                            <input type="hidden" id="td_id" name="td_id" value="0">
                            
                            <!-- Basic Information Section -->
                            <div class="card mb-4">
                                <div class="card-header bg-primary bg-opacity-10 border-primary">
                                    <h6 class="mb-0 text-primary">
                                        <i class="fas fa-info-circle me-2"></i>
                                        Basic Information
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3">
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control bg-light" id="td_region" name="region" 
                                                    placeholder="Region" value="${region}" readonly style="cursor: not-allowed;">
                                                <label for="td_region">
                                                    <i class="fas fa-map-marker-alt me-1 text-muted"></i>
                                                    Region
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control bg-light" id="td_reference_number" name="reference_number" 
                                                    placeholder="Reference Number" value="${glpin}" readonly style="cursor: not-allowed;">
                                                <label for="td_reference_number">
                                                    <i class="fas fa-hashtag me-1 text-muted"></i>
                                                    Reference Number
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control bg-light" id="td_file_number" name="file_number" 
                                                    placeholder="File Number" value="${file_number}" readonly style="cursor: not-allowed;">
                                                <label for="td_file_number">
                                                    <i class="fas fa-folder-open me-1 text-muted"></i>
                                                    File Number
                                                </label>
                                            </div>
                                        </div>
                                        <!-- <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control" id="td_property_number" name="property_number" 
                                                    placeholder="Property Number">
                                                <label for="td_property_number">
                                                    <i class="fas fa-home me-1 text-muted"></i>
                                                    Property Number
                                                </label>
                                            </div>
                                        </div> -->
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="date" class="form-control" id="td_submission_date" name="submission_date" 
                                                    placeholder="Submission Date" value="${created_date}" >
                                                <label for="td_submission_date">
                                                    <i class="fas fa-calendar-alt me-1 text-muted"></i>
                                                    Submission Date
                                                </label>
                                            </div>
                                        </div>
                                        <!-- <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="date" class="form-control" id="td_entered_date" name="entered_date" 
                                                    placeholder="Entered Date">
                                                <label for="td_entered_date">
                                                    <i class="fas fa-clock me-1 text-muted"></i>
                                                    Entered Date
                                                </label>
                                            </div>
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Deed Information Section -->
                            <div class="card mb-4">
                                <div class="card-header bg-info bg-opacity-10 border-info">
                                    <h6 class="mb-0 text-info">
                                        <i class="fas fa-file-signature me-2"></i>
                                        Deed Information
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3">
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control bg-light" id="td_deed_number" name="deed_number" 
                                                    placeholder="Deed Number" value="${deed_number}" readonly style="cursor: not-allowed;">
                                                <label for="td_deed_number">
                                                    <i class="fas fa-file-alt me-1 text-muted"></i>
                                                    Deed Number
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control bg-light" id="td_serial_number" name="serial_number" 
                                                    placeholder="Serial Number" value="${ls_number}" readonly style="cursor: not-allowed;">
                                                <label for="td_serial_number">
                                                    <i class="fas fa-barcode me-1 text-muted"></i>
                                                    Serial Number
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="date" class="form-control bg-light" id="td_instrument_date" name="instrument_date" 
                                                    placeholder="Instrument Date" value="${date_of_document}" readonly style="cursor: not-allowed;">
                                                <label for="td_instrument_date">
                                                    <i class="fas fa-calendar-check me-1 text-muted"></i>
                                                    Instrument Date
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control bg-light" id="td_instrument_type" name="instrument_type" 
                                                    placeholder="Instrument Type" value="${nature_of_instrument}" readonly style="cursor: not-allowed;">
                                                <label for="td_instrument_type">
                                                    <i class="fas fa-tag me-1 text-muted"></i>
                                                    Instrument Type
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control bg-light" id="td_doc_number" name="doc_number" 
                                                    placeholder="Job Number" value="${job_number}" readonly style="cursor: not-allowed;">
                                                <label for="td_doc_number">
                                                    <i class="fas fa-file-pdf me-1 text-muted"></i>
                                                    Job Number
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control bg-light" id="td_term" name="term" 
                                                    placeholder="Term" value="${term}" readonly style="cursor: not-allowed;">
                                                <label for="td_term">
                                                    <i class="fas fa-hourglass-half me-1 text-muted"></i>
                                                    Term
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="date" class="form-control bg-light" id="td_commencement_date" name="commencement_date" 
                                                    placeholder="Commencement Date" value="${commencement_date}" readonly style="cursor: not-allowed;">
                                                <label for="td_commencement_date">
                                                    <i class="fas fa-play-circle me-1 text-muted"></i>
                                                    Commencement Date
                                                </label>
                                            </div>
                                        </div>
                                        <!-- <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="text" class="form-control" id="td_purpose" name="purpose" 
                                                    placeholder="Purpose">
                                                <label for="td_purpose">
                                                    <i class="fas fa-bullseye me-1 text-muted"></i>
                                                    Purpose
                                                </label>
                                            </div>
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Party Information Section -->
                            <div class="card mb-4">
                                <div class="card-header bg-success bg-opacity-10 border-success">
                                    <h6 class="mb-0 text-success">
                                        <i class="fas fa-users me-2"></i>
                                        Party Information
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3">
                                        <!-- Party 1 (Plaintiff) -->
                                        <div class="col-md-6">
                                            <div class="card h-100 border">
                                                <div class="card-header bg-light">
                                                    <h6 class="mb-0">
                                                        <i class="fas fa-user-shield me-1 text-primary"></i>
                                                        Party 1 - Grantor
                                                    </h6>
                                                </div>
                                                <div class="card-body">
                                                    <div class="mb-3">
                                                        <label class="form-label fw-medium">
                                                            <i class="fas fa-user me-1 text-muted"></i>
                                                            Name
                                                        </label>
                                                        <textarea class="form-control" id="td_party1_plaintiff" name="party1_plaintiff" 
                                                                rows="2" placeholder="Enter plaintiff name"></textarea>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label fw-medium">
                                                            <i class="fas fa-phone me-1 text-muted"></i>
                                                            Telephone Number
                                                        </label>
                                                        <input type="tel" class="form-control" id="td_party1_plaintiff_tel_no" 
                                                            name="party1_plaintiff_tel_no" placeholder="+233 XX XXX XXXX">
                                                    </div>
                                                    <div class="mb-0">
                                                        <label class="form-label fw-medium">
                                                            <i class="fas fa-envelope me-1 text-muted"></i>
                                                            Email Address
                                                        </label>
                                                        <input type="email" class="form-control" id="td_party1_plaintiff_email" 
                                                            name="party1_plaintiff_email" placeholder="email@example.com">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Party 2 (Defendant) -->
                                        <div class="col-md-6">
                                            <div class="card h-100 border">
                                                <div class="card-header bg-light">
                                                    <h6 class="mb-0">
                                                        <i class="fas fa-user-graduate me-1 text-danger"></i>
                                                        Party 2 - Grantee
                                                    </h6>
                                                </div>
                                                <div class="card-body">
                                                    <div class="mb-3">
                                                        <label class="form-label fw-medium">
                                                            <i class="fas fa-user me-1 text-muted"></i>
                                                            Name
                                                        </label>
                                                        <textarea class="form-control" id="td_party2_defendant" name="party2_defendant" 
                                                                rows="2" placeholder="Enter defendant name"></textarea>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label fw-medium">
                                                            <i class="fas fa-phone me-1 text-muted"></i>
                                                            Telephone Number
                                                        </label>
                                                        <input type="tel" class="form-control" id="td_party2_defendant_tel_no" 
                                                            name="party2_defendant_tel_no" placeholder="+233 XX XXX XXXX">
                                                    </div>
                                                    <div class="mb-0">
                                                        <label class="form-label fw-medium">
                                                            <i class="fas fa-envelope me-1 text-muted"></i>
                                                            Email Address
                                                        </label>
                                                        <input type="email" class="form-control" id="td_party2_defendant_email" 
                                                            name="party2_defendant_email" placeholder="email@example.com">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Financial Information Section -->
                            <div class="card mb-4">
                                <div class="card-header bg-warning bg-opacity-10 border-warning">
                                    <h6 class="mb-0 text-warning">
                                        <i class="fas fa-coins me-2"></i>
                                        Financial Information
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3">
                                        <div class="col-md-4">
                                            <label class="form-label fw-medium">
                                                <i class="fas fa-money-bill-wave me-1 text-muted"></i>
                                                Consideration
                                            </label>
                                            <div class="input-group">
                                                <input type="number" class="form-control bg-light" id="td_consideration" name="consideration" 
                                                    placeholder="Amount" value="${consideration_fee}" readonly style="cursor: not-allowed;">
                                                <select class="form-select" id="td_consideration_currency" name="consideration_currency" 
                                                        style="max-width: 100px;">
                                                    <option value="GHS">GHS</option>
                                                    <option value="USD">USD</option>
                                                    <option value="GBP">GBP</option>
                                                    <option value="EUR">EUR</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-medium">
                                                <i class="fas fa-gem me-1 text-muted"></i>
                                                Premium
                                            </label>
                                            <div class="input-group">
                                                <input type="number" class="form-control" id="td_premium" name="premium" 
                                                    placeholder="Amount">
                                                <select class="form-select" id="td_premium_currency" name="premium_currency" 
                                                        style="max-width: 100px;">
                                                    <option value="GHS">GHS</option>
                                                    <option value="USD">USD</option>
                                                    <option value="GBP">GBP</option>
                                                    <option value="EUR">EUR</option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- <div class="col-md-4">
                                            <label for="td_compensation_status">
                                                <i class="fas fa-hand-holding-usd me-1 text-muted"></i>
                                                Compensation Status
                                            </label>
                                            <select class="form-select" id="td_compensation_status" name="compensation_status">
                                                <option value="">Select Status</option>
                                                <option value="Paid">Paid</option>
                                                <option value="Pending">Pending</option>
                                                <option value="Partially Paid">Partially Paid</option>
                                                <option value="Not Applicable">Not Applicable</option>
                                            </select>
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Remarks Section -->
                            <div class="card mb-4">
                                <div class="card-header bg-secondary bg-opacity-10 border-secondary">
                                    <h6 class="mb-0 text-secondary">
                                        <i class="fas fa-comment-dots me-2"></i>
                                        Additional Information
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="mb-0">
                                        <label class="form-label fw-medium">
                                            <i class="fas fa-sticky-note me-1 text-muted"></i>
                                            Remarks / Comments
                                        </label>
                                        <textarea class="form-control" id="td_remarks" name="remarks" rows="3" 
                                                placeholder="Enter any additional remarks or comments..."></textarea>
                                    </div>
                                </div>
                            </div>
                            
                        </form>
                    </div>

                    <!-- Right Column -->
                    <div class="col-lg-6 d-flex flex-column scrollable-col">
                        
                        <div class="_gated_workflow_documents"></div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        All fields marked with * are required
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Cancel
                        </button>
                        <button type="reset" class="btn btn-outline-warning" id="btn_reset_transaction">
                            <i class="fas fa-undo-alt me-1"></i>
                            Reset
                        </button>
                        <button type="submit" class="btn btn-primary" id="btn_save_transaction" form="form_transaction_details">
                            <i class="fas fa-save me-1"></i>
                            Save Transaction
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="verify_transaction_details_for_deed" tabindex="-1"
     aria-labelledby="verifyTransactionDetailsForDeedModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-xl">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="verifyTransactionDetailsForDeedModalLabel">
          <i class="fas fa-file-contract me-2"></i>
          Verify Transactions Details on Mother File
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Header with Add Button -->
        <div class="d-flex justify-content-between align-items-center mb-4">
          <div>
            <h6 class="mb-0">
              <i class="fas fa-list-ul me-2 text-danger"></i>
              Transaction Records
            </h6>
            <small class="text-muted">List of all transaction details on the mother file</small>
          </div>
          <button type="button" class="btn btn-danger enter_transaction_details_for_deed" 
                  data-bs-toggle="tooltip" data-bs-placement="top" title="Add New Transaction">
            <i class="fas fa-plus-circle me-2"></i>
            Add New Transaction
          </button>
        </div>
        
        <!-- Table -->
        <div class="table-responsive">
          <table class="table table-hover table-sm" id="lrd_encumberance_details_dataTable">
            <thead class="table-light">
              <tr>
                <th width="15%">
                  <i class="fas fa-hashtag me-1"></i>
                  Registered No.
                </th>
                <th width="15%">
                  <i class="fas fa-calendar-alt me-1"></i>
                  Date of Instrument
                </th>
                <th width="15%">
                  <i class="fas fa-calendar-check me-1"></i>
                  Date of Registration
                </th>
                <th width="40%">
                  <i class="fas fa-file-alt me-1"></i>
                  Memorials
                </th>
                <!-- <th width="15%">
                  <i class="fas fa-sticky-note me-1"></i>
                  Remarks
                </th> -->
                <th width="10%">
                  <i class="fas fa-list-ol me-1"></i>
                  Entry No.
                </th>
                <th width="5%" class="text-center">
                  <i class="fas fa-cog me-1"></i>
                  Actions
                </th>
              </tr>
            </thead>
            <tbody>
              <!-- Data will be populated here -->
            </tbody>
          </table>
        </div>
        
        <!-- Empty State -->
        <div class="text-center py-5" id="noEncumbrancesMc">
          <div class="mb-3">
            <i class="fas fa-file-contract fa-3x text-muted"></i>
          </div>
          <h6 class="text-muted mb-2">No Encumbrance Records Found</h6>
          <p class="text-muted small">Click "Add Encumbrance" to create new encumbrance transactions</p>
        </div>
        
        <!-- Loading State -->
        <div class="text-center py-5 d-none" id="loadingEncumbrances">
          <div class="spinner-border text-danger" role="status">
            <span class="visually-hidden">Loading...</span>
          </div>
          <p class="mt-3 text-muted">Loading encumbrance records...</p>
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


<div class="modal fade effect-fade modal-blur" id="update_file_number" tabindex="-1"
     aria-labelledby="updateFileNumberLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered modal-md">
    <div class="modal-content border-0">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="updateFileNumberLabel">
          <i class="fas fa-folder-open me-2"></i>
          Update File Number
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        <div class="mb-3">
          <label for="lc_txt_file_number" class="form-label">
            <i class="fas fa-hashtag me-1"></i>
            File Number:
          </label>
          <div class="input-group">
            <span class="input-group-text">
              <i class="fas fa-file"></i>
            </span>
            <input type="text" class="form-control form-control-lg bg-light" id="lc_txt_file_number_up" placeholder="Enter file number" value="${file_number}" />
          </div>
        </div>
        
        <div class="mt-4">
          <button type="button" id="lc_btn_update_file_number" 
                  class="btn btn-primary w-100 py-2" 
                  value="Update">
            <i class="fas fa-save me-2"></i>
            Update File Number
          </button>
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

<div class="modal fade effect-fade modal-blur" id="update_deed_number" tabindex="-1"
     aria-labelledby="updateDeedNumberLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered modal-md">
    <div class="modal-content border-0">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="updateDeedNumberLabel">
          <i class="fas fa-folder-open me-2"></i>
          Update Deed Number
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        <div class="mb-3">
          <label for="lc_txt_deed_number" class="form-label">
            <i class="fas fa-hashtag me-1"></i>
            Deed Number:
          </label>
          <div class="input-group">
            <span class="input-group-text">
              <i class="fas fa-file"></i>
            </span>
            <input type="text" class="form-control form-control-lg bg-light" id="lc_txt_deed_number_up" placeholder="Enter new deed number" value="${deed_number}" />
          </div>
        </div>
        
        <div class="mt-4">
          <button type="button" id="lc_btn_update_deed_number" 
                  class="btn btn-primary w-100 py-2" 
                  value="Update">
            <i class="fas fa-save me-2"></i>
            Update Deed Number
          </button>
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


<div class="modal fade effect-fade modal-blur" id="update_serial_number" tabindex="-1"
     aria-labelledby="updateSerialNumberLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered modal-md">
    <div class="modal-content border-0">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="updateSerialNumberLabel">
          <i class="fas fa-folder-open me-2"></i>
          Update Serial Number
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        <div class="mb-3">
          <label for="lc_txt_serial_number" class="form-label">
            <i class="fas fa-hashtag me-1"></i>
            Serial Number:
          </label>
          <div class="input-group">
            <span class="input-group-text">
              <i class="fas fa-file"></i>
            </span>
            <input type="text" class="form-control form-control-lg bg-light" id="lc_txt_serial_number_up" placeholder="Enter new serial number" value="${ls_number}" />
          </div>
        </div>
        
        <div class="mt-4">
          <button type="button" id="lc_btn_update_serial_number" 
                  class="btn btn-primary w-100 py-2" 
                  value="Update">
            <i class="fas fa-save me-2"></i>
            Update Serial Number
          </button>
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


<div class="modal fade effect-scale modal-blur" id="final_lrd_vetting" tabindex="-1"
     aria-labelledby="finalLrdVettingLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-fullscreen">
    <div class="modal-content border-0 final-vetting-shell">
      <div class="modal-header border-0 px-4 px-lg-5 pt-4 pb-0 justify-content-end">
        <button type="button" class="btn-close ms-3 mt-2" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body px-4 px-lg-5 pb-4 pb-lg-5 pt-4">
        <div class="final-vetting-hero p-4 p-lg-5 mb-4">
          <div class="d-flex flex-column flex-xl-row align-items-xl-start justify-content-between gap-4">
            <div>
              <div class="d-inline-flex align-items-center gap-2 px-3 py-2 mb-3 final-vetting-soft">
                <i class="fas fa-shield-alt"></i>
                <span class="fw-semibold">Final LRD Vetting Workspace</span>
              </div>
              <h3 class="mb-2 text-white" id="finalLrdVettingLabel">Review, validate and finalize in one place</h3>
              <p class="mb-0 opacity-75">
                Parcel review, root of title vetting and certificate composition are grouped here so the team can complete the final checks without bouncing between modals.
              </p>
            </div>
            <div class="row g-3 flex-grow-1">
              <div class="col-sm-6 col-xl-4">
                <div class="final-vetting-soft p-3 h-100">
                  <div class="small opacity-75 mb-1">Case Number</div>
                  <div class="fw-bold">${empty fn:trim(case_number) ? '--' : fn:trim(case_number)}</div>
                </div>
              </div>
              <div class="col-sm-6 col-xl-4">
                <div class="final-vetting-soft p-3 h-100">
                  <div class="small opacity-75 mb-1">Job Number</div>
                  <div class="fw-bold">${empty fn:trim(job_number) ? '--' : fn:trim(job_number)}</div>
                </div>
              </div>
              <div class="col-sm-6 col-xl-4">
                <div class="final-vetting-soft p-3 h-100">
                  <div class="small opacity-75 mb-1">Applicant</div>
                  <div class="fw-bold">${empty fn:trim(ar_name) ? '--' : fn:trim(ar_name)}</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="row g-4 mb-4">
          <div class="col-md-6 col-xl-3">
            <div class="final-vetting-stat">
              <div class="final-vetting-stat-label mb-2">Parcel GLPIN</div>
              <div class="final-vetting-stat-value">${empty fn:trim(glpin) ? '--' : fn:trim(glpin)}</div>
            </div>
          </div>
          <div class="col-md-6 col-xl-3">
            <div class="final-vetting-stat">
              <div class="final-vetting-stat-label mb-2">Certificate Number</div>
              <div class="final-vetting-stat-value">${empty fn:trim(certificate_number) ? '--' : fn:trim(certificate_number)}</div>
            </div>
          </div>
          <div class="col-md-6 col-xl-3">
            <div class="final-vetting-stat">
              <div class="final-vetting-stat-label mb-2">Registered Number</div>
              <div class="final-vetting-stat-value">${empty fn:trim(registered_number) ? '--' : fn:trim(registered_number)}</div>
            </div>
          </div>
          <div class="col-md-6 col-xl-3">
            <div class="final-vetting-stat">
              <div class="final-vetting-stat-label mb-2">Certificate Type</div>
              <div class="final-vetting-stat-value">${empty fn:trim(certificate_type) ? '--' : fn:trim(certificate_type)}</div>
            </div>
          </div>
        </div>

        <div class="row g-4 align-items-start">
          <div class="col-12 col-xl-6">
            <div class="final-vetting-column-inner">
            <div class="card final-vetting-card h-100">
              <div class="card-header bg-white border-0 pb-0 px-4 pt-4">
                <div class="d-flex align-items-start justify-content-between gap-3">
                  <div>
                    <div class="final-vetting-section-title">
                      <i class="fas fa-map-marked-alt text-primary me-2"></i>
                      Parcel and transaction review
                    </div>
                    <div class="final-vetting-subtle small mt-1">Cross-check the transaction, location, financials and final confirmation details.</div>
                  </div>
                  <span class="badge bg-light text-primary border border-primary">Stage 1</span>
                </div>
              </div>
              <div class="card-body p-4">
                <ul class="nav nav-pills flex-wrap mb-3 final-vetting-pill-nav" role="tablist">
                  <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="flv-details-tab" data-bs-toggle="tab"
                            data-bs-target="#flv-details" type="button" role="tab">
                      Details
                    </button>
                  </li>
                  <li class="nav-item" role="presentation">
                    <button class="nav-link" id="flv-location-tab" data-bs-toggle="tab"
                            data-bs-target="#flv-location" type="button" role="tab">
                      Location
                    </button>
                  </li>
                  <li class="nav-item" role="presentation">
                    <button class="nav-link" id="flv-financial-tab" data-bs-toggle="tab"
                            data-bs-target="#flv-financial" type="button" role="tab">
                      Financials
                    </button>
                  </li>
                  <li class="nav-item" role="presentation">
                    <button class="nav-link" id="flv-map-tab" data-bs-toggle="tab"
                            data-bs-target="#flv-map" type="button" role="tab">
                      Map
                    </button>
                  </li>
                </ul>

                <div class="tab-content">
                  <div class="tab-pane fade show active" id="flv-details" role="tabpanel">
                    <div class="row g-3">
                      <div class="col-lg-6">
                        <div class="card border h-100">
                          <div class="card-header bg-light border-0 py-3">
                            <h6 class="mb-0"><i class="fas fa-file-contract me-2"></i>Basic information</h6>
                          </div>
                          <div class="card-body">
                            <div class="row g-3">
                              <div class="col-sm-6">
                                <div class="small text-muted">Transaction Number</div>
                                <div class="fw-semibold">${empty fn:trim(transaction_number) ? '--' : fn:trim(transaction_number)}</div>
                              </div>
                              <div class="col-sm-6">
                                <div class="small text-muted">Regional Number</div>
                                <div class="fw-semibold">${empty fn:trim(regional_number) ? '--' : fn:trim(regional_number)}</div>
                              </div>
                              <div class="col-sm-6">
                                <div class="small text-muted">Date of Document</div>
                                <div class="fw-semibold">${empty fn:trim(date_of_document) ? '--' : fn:trim(date_of_document)}</div>
                              </div>
                              <div class="col-sm-6">
                                <div class="small text-muted">Date of Registration</div>
                                <div class="fw-semibold">${empty fn:trim(date_of_registration) ? '--' : fn:trim(date_of_registration)}</div>
                              </div>
                              <div class="col-sm-6">
                                <div class="small text-muted">Nature of Instrument</div>
                                <div class="fw-semibold">${empty fn:trim(nature_of_instrument) ? '--' : fn:trim(nature_of_instrument)}</div>
                              </div>
                              <div class="col-sm-6">
                                <div class="small text-muted">Type of Interest</div>
                                <div class="fw-semibold">${empty fn:trim(type_of_interest) ? '--' : fn:trim(type_of_interest)}</div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-lg-6">
                        <div class="card border h-100">
                          <div class="card-header bg-light border-0 py-3">
                            <h6 class="mb-0"><i class="fas fa-calendar-alt me-2"></i>Term and renewal</h6>
                          </div>
                          <div class="card-body">
                            <div class="row g-3">
                              <div class="col-sm-6">
                                <div class="small text-muted">Term</div>
                                <div class="fw-semibold">${empty fn:trim(term) ? '--' : fn:trim(term)}</div>
                              </div>
                              <div class="col-sm-6">
                                <div class="small text-muted">Type of Use</div>
                                <div class="fw-semibold">${empty fn:trim(type_of_use) ? '--' : fn:trim(type_of_use)}</div>
                              </div>
                              <div class="col-sm-6">
                                <div class="small text-muted">Commencement Date</div>
                                <div class="fw-semibold">${empty fn:trim(commencement_date) ? '--' : fn:trim(commencement_date)}</div>
                              </div>
                              <div class="col-sm-6">
                                <div class="small text-muted">Option for Renewal</div>
                                <div class="fw-semibold">${empty fn:trim(renewal_term) ? '--' : fn:trim(renewal_term)}</div>
                              </div>
                              <div class="col-sm-6">
                                <div class="small text-muted">Certificate Number</div>
                                <div class="fw-semibold">${empty fn:trim(certificate_number) ? '--' : fn:trim(certificate_number)}</div>
                              </div>
                              <div class="col-sm-6">
                                <div class="small text-muted">Date of Issue</div>
                                <div class="fw-semibold">${empty fn:trim(date_of_issue) ? '--' : fn:trim(date_of_issue)}</div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-12">
                        <div class="card border">
                          <div class="card-header bg-light border-0 py-3">
                            <h6 class="mb-0"><i class="fas fa-certificate me-2"></i>Registration and planning details</h6>
                          </div>
                          <div class="card-body">
                            <div class="row g-3">
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">Plan Number</div>
                                <div class="fw-semibold">${empty fn:trim(plan_no) ? '--' : fn:trim(plan_no)}</div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">LTR Plan Number</div>
                                <div class="fw-semibold">${empty fn:trim(ltr_plan_no) ? '--' : fn:trim(ltr_plan_no)}</div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">Registry Map Ref</div>
                                <div class="fw-semibold">${empty fn:trim(registry_mapref) ? '--' : fn:trim(registry_mapref)}</div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">CC Number</div>
                                <div class="fw-semibold">${empty fn:trim(cc_no) ? '--' : fn:trim(cc_no)}</div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">GLPIN</div>
                                <div class="fw-semibold">${empty fn:trim(glpin) ? '--' : fn:trim(glpin)}</div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">Interest Number</div>
                                <div class="fw-semibold">${empty fn:trim(interest_number) ? '--' : fn:trim(interest_number)}</div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">Sub-Interest Number</div>
                                <div class="fw-semibold">${empty fn:trim(sub_interest_number) ? '--' : fn:trim(sub_interest_number)}</div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">Registered Number</div>
                                <div class="fw-semibold">${empty fn:trim(registered_number) ? '--' : fn:trim(registered_number)}</div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">Type of Plotting</div>
                                <div class="fw-semibold">${empty fn:trim(smd_type_of_plotting) ? '--' : fn:trim(smd_type_of_plotting)}</div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">SMD Reference Number</div>
                                <div class="fw-semibold">${empty fn:trim(smd_reference_number) ? '--' : fn:trim(smd_reference_number)}</div>
                              </div>
                              <div class="col-md-3 col-sm-6">
                                <div class="small text-muted">Publication Date</div>
                                <div class="fw-semibold">${empty fn:trim(publicity_date) ? '--' : fn:trim(publicity_date)}</div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="tab-pane fade" id="flv-location" role="tabpanel">
                    <div class="card border">
                      <div class="card-header bg-light border-0 py-3">
                        <h6 class="mb-0"><i class="fas fa-globe-africa me-2"></i>Location and registration details</h6>
                      </div>
                      <div class="card-body">
                        <div class="row g-3">
                          <div class="col-sm-6">
                            <div class="small text-muted">Region</div>
                            <div class="fw-semibold">${empty fn:trim(region) ? '--' : fn:trim(region)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">District</div>
                            <div class="fw-semibold">${empty fn:trim(district) ? '--' : fn:trim(district)}</div>
                          </div>
                          <div class="col-12">
                            <div class="small text-muted">Locality</div>
                            <div class="fw-semibold">${empty fn:trim(locality) ? '--' : fn:trim(locality)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">Size of Land</div>
                            <div class="fw-semibold">${empty fn:trim(size_of_land) ? '--' : fn:trim(size_of_land)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">GLPIN</div>
                            <div class="fw-semibold">${empty fn:trim(glpin) ? '--' : fn:trim(glpin)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">Registration District</div>
                            <div class="fw-semibold">${empty fn:trim(registration_district_number) ? '--' : fn:trim(registration_district_number)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">Registration Section</div>
                            <div class="fw-semibold">${empty fn:trim(registration_section_number) ? '--' : fn:trim(registration_section_number)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">Registration Block</div>
                            <div class="fw-semibold">${empty fn:trim(registration_block_number) ? '--' : fn:trim(registration_block_number)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">Created Date</div>
                            <div class="fw-semibold">${empty fn:trim(created_date) ? '--' : fn:trim(created_date)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">Modified Date</div>
                            <div class="fw-semibold">${empty fn:trim(modified_date) ? '--' : fn:trim(modified_date)}</div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="tab-pane fade" id="flv-financial" role="tabpanel">
                    <div class="card border">
                      <div class="card-header bg-light border-0 py-3">
                        <h6 class="mb-0"><i class="fas fa-money-bill-wave me-2"></i>Financial review</h6>
                      </div>
                      <div class="card-body">
                        <div class="row g-3">
                          <div class="col-12">
                            <div class="small text-muted">Assessed Value</div>
                            <div class="h4 text-primary mb-0">${empty fn:trim(assessed_value) ? '--' : fn:trim(assessed_value)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">Stamp Duty Payable</div>
                            <div class="fw-semibold">${empty fn:trim(stamp_duty_payable) ? '--' : fn:trim(stamp_duty_payable)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">Consideration in Document</div>
                            <div class="fw-semibold">${empty fn:trim(consideration_fee) ? '--' : fn:trim(consideration_fee)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">Consideration Currency</div>
                            <div class="fw-semibold">${empty fn:trim(consideration_fee_currency) ? '--' : fn:trim(consideration_fee_currency)}</div>
                          </div>
                          <div class="col-sm-6">
                            <div class="small text-muted">Adopted Currency Rate</div>
                            <div class="fw-semibold">${empty fn:trim(consideration_fee_adopted_rate) ? '--' : fn:trim(consideration_fee_adopted_rate)}</div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="tab-pane fade" id="flv-map" role="tabpanel">
                    <div class="card border">
                      <div class="card-header bg-light border-0 py-3">
                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                          <h6 class="mb-0"><i class="fas fa-map me-2"></i>Map visualization</h6>
                          <div class="btn-group" role="group">
                            <button type="button" class="btn btn-primary btn-sm" id="lc_btn_visualise_wkt_flv">
                              <i class="fas fa-map me-1"></i>
                              Visualise
                            </button>
                            <button type="button" class="btn btn-outline-primary btn-sm" id="lc_btn_visualise_search_flv">
                              <i class="fas fa-search me-1"></i>
                              Search
                            </button>
                            <button type="button" class="btn btn-outline-secondary btn-sm final-lrd-open-parcel-view">
                              <i class="fas fa-expand me-1"></i>
                              Full View
                            </button>
                          </div>
                        </div>
                      </div>
                      <div class="card-body">
                        <div class="mb-3">
                          <label for="lc_bl_wkt_polygon_flv" class="form-label fw-semibold">WKT Polygon</label>
                          <div class="input-group">
                            <input class="form-control" id="lc_bl_wkt_polygon_flv" name="lc_bl_wkt_polygon_flv" type="text" value="${parcel_wkt}" placeholder="WKT polygon coordinates">
                            <button class="btn btn-outline-secondary" type="button" id="btn_copy_wkt_flv" onclick="copyWktToClipboard('lc_bl_wkt_polygon_flv')">
                              <i class="fas fa-copy"></i>
                            </button>
                          </div>
                        </div>

                        <div class="d-flex flex-wrap gap-2 align-items-center mb-3">
                          <div class="d-flex align-items-center me-3">
                            <label class="me-2 mb-0">Scale:</label>
                            <div class="input-group input-group-sm me-2" style="width: 120px;">
                              <input class="form-control form-control-sm" id="lc_scale_value_e_flv" name="lc_scale_value_e_flv" type="text" placeholder="Custom scale">
                            </div>
                            <select class="form-select form-select-sm" name="lc_scale_value_flv" id="lc_scale_value_flv" style="width: 120px;">
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
                              <input class="form-check-input" type="checkbox" checked id="lc_lockmapscale_flv">
                              <label class="form-check-label small mb-0" for="lc_lockmapscale_flv">
                                Lock Scale
                              </label>
                            </div>
                            <button type="button" class="btn btn-outline-primary btn-sm" id="lc_btn_scale_zoom_flv">
                              <i class="fas fa-search"></i>
                            </button>
                          </div>

                          <div class="ms-auto btn-group" role="group">
                            <button type="button" class="btn btn-outline-secondary btn-sm" id="btn_zoom_full_flv">
                              <i class="fas fa-expand"></i>
                            </button>
                            <button type="button" class="btn btn-outline-secondary btn-sm" id="btn_zoom_out_flv">
                              <i class="fas fa-search-minus"></i>
                            </button>
                            <button type="button" class="btn btn-outline-secondary btn-sm" id="btn_zoom_in_flv">
                              <i class="fas fa-search-plus"></i>
                            </button>
                          </div>
                        </div>

                        <div class="mt-3 w-100">
                          <div id="lc-map__flv"></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="d-grid mt-4">
                  <button type="button" id="btn_confirm_registration_transaction_flv"
                          class="btn btn-success btn-lg py-3 d-none">
                    <i class="fas fa-check-circle me-2"></i>
                    Confirm Registration Transaction
                  </button>
                </div>
              </div>
            </div>

            <div class="card final-vetting-card mt-4">
                  <div class="card-header bg-white border-0 pb-0 px-4 pt-4">
                    <div class="final-vetting-section-title">
                      <i class="fas fa-folder-open text-primary me-2"></i>
                      Supporting documents
                    </div>
                    <div class="final-vetting-subtle small mt-1">Load application and public documents directly inside the final vetting workspace.</div>
                  </div>
                  <div class="card-body p-4 pt-3">
                    <div class="_gated_workflow_documents"></div>
                  </div>
                </div>
            </div>
          </div>

          <div class="col-12 col-xl-6">
            <div class="final-vetting-column-inner">
            <div class="row g-4">
              <div class="col-12">
                <div class="card final-vetting-card">
                  <div class="card-header bg-white border-0 px-4 pt-4 pb-0">
                    <div class="d-flex align-items-start justify-content-between gap-3 flex-wrap">
                      <div>
                        <div class="final-vetting-section-title">
                          <i class="fas fa-file-alt text-primary me-2"></i>
                          Register: Description of Land
                        </div>
                        <div class="final-vetting-subtle small mt-1">Keep the official land description updated before generating the final register.</div>
                      </div>
                      <span class="badge bg-light text-primary border border-primary">Stage 2</span>
                    </div>
                  </div>
                  <div class="card-body p-4">
                    <div class="mb-3">
                      <label for="lc_description_of_land_lrd_flv" class="form-label fw-semibold">Land Description</label>
                      <textarea id="lc_description_of_land_lrd_flv" name="lc_description_of_land_lrd_flv" class="form-control" rows="5" required>${smd_region}</textarea>
                      <div class="form-text">Complete description of the land as it appears in the register.</div>
                    </div>
                    <div class="row g-3">
                      <div class="col-md-6">
                        <button type="button" id="lc_btn_save_register_description_flv" class="btn btn-primary w-100 py-3">
                          <i class="fas fa-save me-2"></i>
                          Save Register Description
                        </button>
                      </div>
                      <div class="col-md-6">
                        <button type="button" id="lc_btn_activate_final_register_flv" class="btn btn-success w-100 py-3">
                          <i class="fas fa-file-export me-2"></i>
                          Generate Final Register
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>


              <div class="col-12">
                <div class="card final-vetting-card">
                  <div class="card-header bg-white border-0 px-4 pt-4 pb-0">
                    <div class="d-flex align-items-start justify-content-between gap-3 flex-wrap">
                      <div>
                        <div class="final-vetting-section-title">
                          <i class="fas fa-book text-primary me-2"></i>
                          Root of title register
                        </div>
                        <div class="final-vetting-subtle small mt-1">Review or update the register sections without leaving the vetting flow.</div>
                      </div>
                      <span class="badge bg-light text-warning border border-warning">Stage 3</span>
                    </div>
                  </div>
                  <div class="card-body p-4">
                    <ul class="nav nav-pills flex-wrap mb-4 final-vetting-pill-nav" role="tablist">
                      <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="flv-proprietorship-tab" data-bs-toggle="tab"
                                data-bs-target="#flv-proprietorship" type="button" role="tab">
                          Proprietorship <span class="badge bg-primary ms-1">${fn:length(lrd_proprietorship_section)}</span>
                        </button>
                      </li>
                      <li class="nav-item" role="presentation">
                        <button class="nav-link" id="flv-memorial-tab" data-bs-toggle="tab"
                                data-bs-target="#flv-memorial" type="button" role="tab">
                          Memorials <span class="badge bg-primary ms-1">${fn:length(lrd_memorials_section)}</span>
                        </button>
                      </li>
                      <li class="nav-item" role="presentation">
                        <button class="nav-link" id="flv-reservation-tab" data-bs-toggle="tab"
                                data-bs-target="#flv-reservation" type="button" role="tab">
                          Reservations <span class="badge bg-primary ms-1">${fn:length(lrd_reservation_section)}</span>
                        </button>
                      </li>
                      <li class="nav-item" role="presentation">
                        <button class="nav-link" id="flv-encumbrance-tab" data-bs-toggle="tab"
                                data-bs-target="#flv-encumbrance" type="button" role="tab">
                          Encumbrances <span class="badge bg-primary ms-1">${fn:length(lrd_encumbrances_section)}</span>
                        </button>
                      </li>
                      <li class="nav-item" role="presentation">
                        <button class="nav-link" id="flv-valuation-tab" data-bs-toggle="tab"
                                data-bs-target="#flv-valuation" type="button" role="tab">
                          Valuation <span class="badge bg-primary ms-1">${fn:length(lrd_valuation_section)}</span>
                        </button>
                      </li>
                      <li class="nav-item" role="presentation">
                        <button class="nav-link" id="flv-certificate-tab" data-bs-toggle="tab"
                                data-bs-target="#flv-certificate" type="button" role="tab">
                          Certificate <span class="badge bg-primary ms-1">${fn:length(lrd_certificate_section)}</span>
                        </button>
                      </li>
                    </ul>

                    <div class="tab-content">
                      <div class="tab-pane fade show active" id="flv-proprietorship" role="tabpanel">
                        <div class="card border">
                          <div class="card-header bg-primary bg-opacity-10 border-0">
                            <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap">
                              <h6 class="mb-0 text-primary"><i class="fas fa-user-tie me-2"></i>Proprietorship Details</h6>
                              <button type="button" class="btn btn-primary btn-sm newProprietorshipModal">
                                <i class="fas fa-plus me-1"></i>Add Proprietor
                              </button>
                            </div>
                          </div>
                          <div class="card-body p-0">
                            <div class="table-responsive final-vetting-scroll">
                              <table class="table table-hover table-sm mb-0" id="flv_lrd_proprietorship_details_dataTable">
                                <thead class="table-light">
                                  <tr>
                                    <th>Registered No.</th>
                                    <th>Proprietors</th>
                                    <th>Date of Instrument</th>
                                    <th>Nature of Instrument</th>
                                    <th>Date of Registration</th>
                                    <th>Parties</th>
                                    <th>Price Paid</th>
                                    <th>Term</th>
                                    <th class="text-center">Action</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
                                    <tr>
                                      <td><span class="badge bg-info bg-opacity-10 text-info">${proprietorship_section.ps_registration_number}</span></td>
                                      <td>${proprietorship_section.ps_proprietor}</td>
                                      <td>${proprietorship_section.ps_date_of_instrument}</td>
                                      <td><span class="badge bg-secondary">${proprietorship_section.ps_nature_of_instrument}</span></td>
                                      <td>${proprietorship_section.ps_date_of_registration}</td>
                                      <td>
                                        <div class="small">
                                          <div><strong>From:</strong> ${proprietorship_section.ps_transferor}</div>
                                          <div><strong>To:</strong> ${proprietorship_section.ps_transferee}</div>
                                        </div>
                                      </td>
                                      <td>${proprietorship_section.ps_price_paid}</td>
                                      <td>${proprietorship_section.ps_term}</td>
                                      <td class="text-center">
                                        <div class="d-flex justify-content-center">
                                          <button class="btn btn-outline-primary btn-sm me-1 editProprietorshipModal ${proprietorship_section.approval_status == 1 ? 'd-none' : ''}"
                                                  data-target-id="${proprietorship_section.ps_id}"
                                                  data-ps_id="${proprietorship_section.ps_id}"
                                                  data-ps_case_number="${proprietorship_section.ps_case_number}"
                                                  data-ps_registration_number="${proprietorship_section.ps_registration_number}"
                                                  data-ps_proprietor="${proprietorship_section.ps_proprietor}"
                                                  data-ps_date_of_instrument="${proprietorship_section.ps_date_of_instrument}"
                                                  data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
                                                  data-ps_date_of_registration="${proprietorship_section.ps_date_of_registration}"
                                                  data-ps_transferor="${proprietorship_section.ps_transferor}"
                                                  data-ps_transferee="${proprietorship_section.ps_transferee}"
                                                  data-ps_price_paid="${proprietorship_section.ps_price_paid}"
                                                  data-ps_remarks="${proprietorship_section.ps_remarks}"
                                                  data-ps_signature="${proprietorship_section.ps_signature}"
                                                  data-ps_term="${proprietorship_section.ps_term}">
                                            <i class="fas fa-edit"></i>
                                          </button>
                                          <button class="btn btn-danger btn-sm deleteProprietorshipModal ${proprietorship_section.approval_status == 1 ? 'd-none' : ''}"
                                                  data-ps_id="${proprietorship_section.ps_id}"
                                                  data-ps_case_number="${proprietorship_section.ps_case_number}">
                                            <i class="fas fa-trash"></i>
                                          </button>
                                        </div>
                                      </td>
                                    </tr>
                                  </c:forEach>
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div class="tab-pane fade" id="flv-memorial" role="tabpanel">
                        <div class="card border">
                          <div class="card-header bg-danger bg-opacity-10 border-0">
                            <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap">
                              <h6 class="mb-0 text-danger"><i class="fas fa-file-signature me-2"></i>Memorial Details</h6>
                              <button type="button" class="btn btn-danger btn-sm newMemorialsModal">
                                <i class="fas fa-plus me-1"></i>Add Memorial
                              </button>
                            </div>
                          </div>
                          <div class="card-body p-0">
                            <div class="table-responsive final-vetting-scroll">
                              <table class="table table-hover table-sm mb-0" id="flv_lrd_memorial_details_dataTable">
                                <thead class="table-light">
                                  <tr>
                                    <th>Registered No</th>
                                    <th>Memorials</th>
                                    <th>Date of Instrument</th>
                                    <th>Date of Registration</th>
                                    <th>Entry No</th>
                                    <th class="text-center">Action</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <c:forEach items="${lrd_memorials_section}" var="memorials_section">
                                    <tr>
                                      <td><span class="badge bg-danger bg-opacity-10 text-danger">${memorials_section.m_registered_no}</span></td>
                                      <td>${memorials_section.m_memorials}</td>
                                      <td>${memorials_section.m_date_of_instrument}</td>
                                      <td>${memorials_section.m_date_of_registration}</td>
                                      <td><span class="badge bg-secondary">${memorials_section.m_entry_number}</span></td>
                                      <td class="text-center">
                                        <div class="d-flex justify-content-center">
                                          <button class="btn btn-outline-danger btn-sm me-1 editMemorialsModal ${memorials_section.approval_status == 1 ? 'd-none' : ''}"
                                                  data-target-id="${memorials_section.mid}"
                                                  data-mid="${memorials_section.mid}"
                                                  data-m_case_number="${memorials_section.m_case_number}"
                                                  data-m_registered_no="${memorials_section.m_registered_no}"
                                                  data-m_memorials="${memorials_section.m_memorials}"
                                                  data-m_date_of_registration="${memorials_section.m_date_of_registration}"
                                                  data-m_date_of_instrument="${memorials_section.m_date_of_instrument}"
                                                  data-m_back="${memorials_section.m_back}"
                                                  data-m_remarks="${memorials_section.m_remarks}"
                                                  data-m_entry_number="${memorials_section.m_entry_number}">
                                            <i class="fas fa-edit"></i>
                                          </button>
                                          <button class="btn btn-danger btn-sm deleteMemorialsModal ${memorials_section.approval_status == 1 ? 'd-none' : ''}"
                                                  data-target-id="${memorials_section.mid}"
                                                  data-mid="${memorials_section.mid}">
                                            <i class="fas fa-trash"></i>
                                          </button>
                                        </div>
                                      </td>
                                    </tr>
                                  </c:forEach>
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div class="tab-pane fade" id="flv-reservation" role="tabpanel">
                        <div class="card border">
                          <div class="card-header bg-success bg-opacity-10 border-0">
                            <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap">
                              <h6 class="mb-0 text-success"><i class="fas fa-flag me-2"></i>Reservation Details</h6>
                              <button type="button" class="btn btn-success btn-sm newReservationModal">
                                <i class="fas fa-plus me-1"></i>Add Reservation
                              </button>
                            </div>
                          </div>
                          <div class="card-body p-0">
                            <div class="table-responsive final-vetting-scroll">
                              <table class="table table-hover table-sm mb-0" id="flv_lrd_reservation_details_dataTable">
                                <thead class="table-light">
                                  <tr>
                                    <th>Reservation Description</th>
                                    <th>Created By</th>
                                    <th>Created On</th>
                                    <th class="text-center">Action</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <c:forEach items="${lrd_reservation_section}" var="reservation_section">
                                    <tr>
                                      <td>${reservation_section.reservation_description}</td>
                                      <td>${reservation_section.modified_by}</td>
                                      <td>${reservation_section.created_date}</td>
                                      <td class="text-center">
                                        <div class="d-flex justify-content-center">
                                          <button class="btn btn-outline-success btn-sm me-1 editReservationModal ${reservation_section.approval_status == 1 ? 'd-none' : ''}"
                                                  data-rs_id="${reservation_section.rs_id}"
                                                  data-rs_reservation_description="${reservation_section.reservation_description}"
                                                  data-rs_case_number="${reservation_section.case_number}">
                                            <i class="fas fa-edit"></i>
                                          </button>
                                          <button class="btn btn-danger btn-sm deleteReservationModal ${reservation_section.approval_status == 1 ? 'd-none' : ''}"
                                                  data-rs_id="${reservation_section.rs_id}">
                                            <i class="fas fa-trash"></i>
                                          </button>
                                        </div>
                                      </td>
                                    </tr>
                                  </c:forEach>
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div class="tab-pane fade" id="flv-encumbrance" role="tabpanel">
                        <div class="card border">
                          <div class="card-header bg-warning bg-opacity-10 border-0">
                            <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap">
                              <h6 class="mb-0 text-warning"><i class="fas fa-lock me-2"></i>Encumbrance Details</h6>
                              <button type="button" class="btn btn-warning btn-sm newEncumberancesModal">
                                <i class="fas fa-plus me-1"></i>Add Encumbrance
                              </button>
                            </div>
                          </div>
                          <div class="card-body p-0">
                            <div class="table-responsive final-vetting-scroll">
                              <table class="table table-hover table-sm mb-0" id="flv_lrd_registration_encumbrance_dataTable">
                                <thead class="table-light">
                                  <tr>
                                    <th>Registered Number</th>
                                    <th>Date of Instrument</th>
                                    <th>Date of Registration</th>
                                    <th>Memorials</th>
                                    <th>Entry No.</th>
                                    <th class="text-center">Action</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <c:forEach items="${lrd_encumbrances_section}" var="lrd_encumbrances_section_row">
                                    <tr>
                                      <td><span class="badge bg-warning bg-opacity-10 text-warning">${lrd_encumbrances_section_row.es_registered_number}</span></td>
                                      <td>${lrd_encumbrances_section_row.es_date_of_instrument}</td>
                                      <td>${lrd_encumbrances_section_row.es_date_of_registration}</td>
                                      <td>${lrd_encumbrances_section_row.es_memorials}</td>
                                      <td><span class="badge bg-secondary">${lrd_encumbrances_section_row.es_entry_number}</span></td>
                                      <td class="text-center">
                                        <div class="d-flex justify-content-center">
                                          <button class="btn btn-outline-warning btn-sm me-1 editEncumberancesModal ${lrd_encumbrances_section_row.approval_status == 1 ? 'd-none' : ''}"
                                                  data-es_id="${lrd_encumbrances_section_row.es_id}"
                                                  data-es_case_number="${lrd_encumbrances_section_row.es_case_number}"
                                                  data-es_registered_number="${lrd_encumbrances_section_row.es_registered_number}"
                                                  data-es_date_of_registration="${lrd_encumbrances_section_row.es_date_of_registration}"
                                                  data-es_date_of_instrument="${lrd_encumbrances_section_row.es_date_of_instrument}"
                                                  data-es_back="${lrd_encumbrances_section_row.es_back}"
                                                  data-es_forward="${lrd_encumbrances_section_row.es_forward}"
                                                  data-es_remarks="${lrd_encumbrances_section_row.es_remarks}"
                                                  data-es_memorials="${lrd_encumbrances_section_row.es_memorials}"
                                                  data-es_signature="${lrd_encumbrances_section_row.es_signature}"
                                                  data-es_entry_number="${lrd_encumbrances_section_row.es_entry_number}"
                                                  data-es_action_on_form_encumbrances="edit">
                                            <i class="fas fa-edit"></i>
                                          </button>
                                          <button class="btn btn-danger btn-sm deleteEncumberancesModal ${lrd_encumbrances_section_row.approval_status == 1 ? 'd-none' : ''}"
                                                  data-es_id="${lrd_encumbrances_section_row.es_id}">
                                            <i class="fas fa-trash"></i>
                                          </button>
                                        </div>
                                      </td>
                                    </tr>
                                  </c:forEach>
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div class="tab-pane fade" id="flv-valuation" role="tabpanel">
                        <div class="card border">
                          <div class="card-header bg-danger bg-opacity-10 border-0">
                            <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap">
                              <h6 class="mb-0 text-danger"><i class="fas fa-money-bill-wave me-2"></i>Valuation Details</h6>
                              <button type="button" class="btn btn-danger btn-sm newValuationModal">
                                <i class="fas fa-plus me-1"></i>Add Valuation
                              </button>
                            </div>
                          </div>
                          <div class="card-body p-0">
                            <div class="table-responsive final-vetting-scroll">
                              <table class="table table-hover table-sm mb-0" id="flv_lrd_valuation_details_dataTable">
                                <thead class="table-light">
                                  <tr>
                                    <th>Date of Valuation</th>
                                    <th class="text-end">Amount (GHS)</th>
                                    <th>Remarks</th>
                                    <th class="text-center">Action</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <c:forEach items="${lrd_valuation_section}" var="valuation_section">
                                    <tr>
                                      <td>${valuation_section.vs_date_of_valuation}</td>
                                      <td class="text-end text-success">${valuation_section.vs_amount}</td>
                                      <td>${valuation_section.vs_remarks}</td>
                                      <td class="text-center">
                                        <div class="d-flex justify-content-center">
                                          <button class="btn btn-outline-danger btn-sm me-1 editValuationModal ${valuation_section.approval_status == 1 ? 'd-none' : ''}"
                                                  data-vs_id="${valuation_section.vs_id}"
                                                  data-case_number="${valuation_section.case_number}"
                                                  data-vs_date_of_valuation="${valuation_section.vs_date_of_valuation}"
                                                  data-vs_amount="${valuation_section.vs_amount}"
                                                  data-vs_remarks="${valuation_section.vs_remarks}"
                                                  data-es_action_on_form_encumbrances="edit">
                                            <i class="fas fa-edit"></i>
                                          </button>
                                          <button class="btn btn-danger btn-sm deleteValuationModal ${valuation_section.approval_status == 1 ? 'd-none' : ''}"
                                                  data-vs_id="${valuation_section.vs_id}"
                                                  data-case_number="${valuation_section.case_number}">
                                            <i class="fas fa-trash"></i>
                                          </button>
                                        </div>
                                      </td>
                                    </tr>
                                  </c:forEach>
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div class="tab-pane fade" id="flv-certificate" role="tabpanel">
                        <div class="card border">
                          <div class="card-header bg-info bg-opacity-10 border-0">
                            <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap">
                              <h6 class="mb-0 text-info"><i class="fas fa-certificate me-2"></i>Certificate Details</h6>
                              <button type="button" class="btn btn-info btn-sm newCertificateModal">
                                <i class="fas fa-plus me-1"></i>Add Certificate
                              </button>
                            </div>
                          </div>
                          <div class="card-body p-0">
                            <div class="table-responsive final-vetting-scroll">
                              <table class="table table-hover table-sm mb-0" id="flv_lrd_certificate_details_dataTable">
                                <thead class="table-light">
                                  <tr>
                                    <th>Date of Issue</th>
                                    <th>To Whom Issued</th>
                                    <th>Serial Number</th>
                                    <th>Official Notes</th>
                                    <th class="text-center">Action</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <c:forEach items="${lrd_certificate_section}" var="certificate_section">
                                    <tr>
                                      <td>${certificate_section.cs_date_of_registration}</td>
                                      <td>${certificate_section.cs_to_whom_issued}</td>
                                      <td>${certificate_section.cs_serial_number}</td>
                                      <td>${certificate_section.cs_official_notes}</td>
                                      <td class="text-center">
                                        <div class="d-flex justify-content-center">
                                          <button class="btn btn-outline-info btn-sm me-1 editCertificateModal ${certificate_section.approval_status == 1 ? 'd-none' : ''}"
                                                  data-cs_id="${certificate_section.cs_id}"
                                                  data-cs_case_number="${certificate_section.case_number}"
                                                  data-cs_date_of_registration="${certificate_section.cs_date_of_registration}"
                                                  data-cs_to_whom_issued="${certificate_section.cs_to_whom_issued}"
                                                  data-cs_serial_number="${certificate_section.cs_serial_number}"
                                                  data-cs_official_notes="${certificate_section.cs_official_notes}">
                                            <i class="fas fa-edit"></i>
                                          </button>
                                          <button class="btn btn-danger btn-sm deleteCertificateModal ${certificate_section.approval_status == 1 ? 'd-none' : ''}"
                                                  data-cs_id="${certificate_section.cs_id}"
                                                  data-cs_case_number="${certificate_section.case_number}"
                                                  data-cs_date_of_registration="${certificate_section.cs_date_of_registration}"
                                                  data-cs_to_whom_issued="${certificate_section.cs_to_whom_issued}"
                                                  data-cs_serial_number="${certificate_section.cs_serial_number}"
                                                  data-cs_official_notes="${certificate_section.cs_official_notes}">
                                            <i class="fas fa-trash"></i>
                                          </button>
                                        </div>
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
                  </div>
                </div>
              </div>

              <div class="col-12">
                <div class="card final-vetting-card">
                  <div class="card-header bg-white border-0 px-4 pt-4 pb-0">
                    <div class="d-flex align-items-start justify-content-between gap-3 flex-wrap">
                      <div>
                        <div class="final-vetting-section-title">
                          <i class="fas fa-file-signature text-primary me-2"></i>
                          Certificate composition
                        </div>
                        <div class="final-vetting-subtle small mt-1">Update certificate details, review the content and generate the final certificate from the same workspace.</div>
                      </div>
                      <span class="badge bg-light text-success border border-success">Stage 4</span>
                    </div>
                  </div>
                  <div class="card-body p-4">
                    <div class="row g-4">
                      <div class="col-12 col-lg-4">
                        <div class="card border h-100">
                          <div class="card-header bg-primary bg-opacity-10 border-0">
                            <h6 class="mb-0 text-primary"><i class="fas fa-cogs me-2"></i>Certificate configuration</h6>
                          </div>
                          <div class="card-body">
                            <div class="mb-3">
                              <label for="lc_txt_type_of_certificate_flv" class="form-label fw-semibold">Certificate Type</label>
                              <select name="lc_txt_type_of_certificate_flv" id="lc_txt_type_of_certificate_flv" class="form-select">
                                <option value="${certificate_type == 'Individual' ? '' : certificate_type}">
                                  ${certificate_type == 'Individual' ? '-- Select Certificate Type --' : certificate_type}
                                </option>
                                <option value="Provisional Certificate">Provisional Certificate</option>
                                <option value="Land Certificate">Land Certificate</option>
                                <option value="Substituted Certificate">Substituted Certificate</option>
                              </select>
                            </div>
                            <div class="mb-3">
                              <label for="lc_txt_certificate_number_flv" class="form-label fw-semibold">Certificate Number</label>
                              <input type="text" class="form-control" id="lc_txt_certificate_number_flv" value="${certificate_number}">
                            </div>
                            <!-- <div class="alert alert-info bg-info bg-opacity-10 border-info mb-0">
                              <div class="small">
                                <strong>Tip:</strong> Use <em>Compose Template</em> to generate a base draft, then review the text before saving or generating the certificate.
                              </div>
                            </div> -->
                            <button type="button" id="btn_save_lrd_certificate_update_details_flv"
                                    class="btn btn-primary w-100 mt-3">
                              <i class="fas fa-save me-2"></i>
                              Update Certificate Details
                            </button>
                          </div>
                        </div>
                      </div>

                      <div class="col-12 col-lg-8">
                        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                          <div>
                            <div class="fw-semibold">Certificate Content</div>
                            <div class="small text-muted">Review the generated content and keep the final wording here.</div>
                          </div>
                          <!-- <button type="button" class="btn btn-outline-danger" id="btn_compose_certificate_template_flv">
                            <i class="fas fa-edit me-2"></i>
                            Compose Template
                          </button> -->
                        </div>
                        <div class="final-vetting-editor">
                          <div id="lc_search_report_summary_details_flv">${remark_or_comment}</div>
                        </div>
                        <div class="row g-3 mt-1">
                          <div class="col-md-6">
                            <button type="button" id="lc_btn_save_search_report_flv"
                                    class="btn btn-outline-primary w-100 py-3">
                              <i class="fas fa-cloud-upload-alt me-2"></i>
                              Save Certificate
                            </button>
                          </div>
                          <div class="col-md-6">
                            <button type="button" id="lc_btn_activate_final_certificate_flv"
                                    class="btn btn-success w-100 py-3">
                              <i class="fas fa-file-pdf me-2"></i>
                              Generate Certificate
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
          </div>
        </div>
      </div>

      <div class="modal-footer bg-white border-0 px-4 px-lg-5 pb-4 pt-0">
        <div class="d-flex flex-column flex-lg-row gap-3 justify-content-between align-items-lg-center w-100">
          <div class="small text-muted">
            Existing modals remain available. This workspace only adds a consolidated final-review flow.
          </div>
          <div class="d-flex gap-2 flex-wrap">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
              <i class="fas fa-times me-2"></i>
              Close Workspace
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade modal-blur effect-scale" id="upload_signed_certificate_and_register" tabindex="-1"
	role="dialog" aria-labelledby="upload_signed_search_report_label" aria-hidden="true"
>
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="upload_signed_search_report_label">
                    <i class="fas fa-file-signature me-2"></i>
                    Upload Signed Certificate & Register
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
							<strong>Important:</strong> This action will upload the final signed certificate and registr to the application document. Please ensure you have the correct signed version before proceeding.
						</div>
					</div>
				</div>
				
				<!-- Upload Section -->
				<div class="text-center p-5 border-dashed rounded-3 bg-light" style="border: 2px dashed #ccc;">
					<i class="fas fa-cloud-upload-alt text-primary fa-4x mb-3"></i>
					<h5 class="mb-3">Upload Signed Certificate & Register</h5>
					<!-- <p class="text-muted mb-4">
						Select the final signed search report file to upload. 
						This document will be permanently attached to the applicant's public record.
					</p> -->
					
					<div class="d-grid gap-2 d-md-flex justify-content-center">
						<button type="button" id="btn_upload_signed_certificate_and_register" class="btn btn-primary btn-lg px-4">
							<i class="fas fa-upload me-2"></i> 
							<span class="fw-semibold">Upload Signed Certificate & Register</span>
						</button>
					</div>
					
					<small class="text-muted d-block mt-4">
						<i class="fas fa-exclamation-circle me-1"></i>
						Note: Once uploaded, this document will be added to the application document record and cannot be removed.
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


<div class="modal fade effect-fade modal-blur" id="reset_certificate_number_and_indexing" tabindex="-1"
     aria-labelledby="resetCertificateAndIndexingLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered modal-md">
    <div class="modal-content border-0">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="resetCertificateAndIndexingLabel">
          <i class="fas fa-key me-2"></i>
          Reset Certificate Number and Indexing
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        <div class="mb-3">
          <label for="lc_txt_type_of_reset" class="form-label fw-semibold">Reset Type</label>
          <select name="lc_txt_type_of_reset" id="lc_txt_type_of_reset" class="form-select">
            <option value="">-- Select Reset Type --</option>
            <option value="Certificate Number">Certificate Number</option>
            <option value="Volume and Folio">Volume and Folio</option>
          </select>
        </div>
        <div class="mb-3">
          <label for="lc_txt_remarks" class="form-label">
            <i class="fas fa-sticky-note me-1"></i>
            Remarks:
          </label>
          <div class="input-group">
            <span class="input-group-text">
              <i class="fas fa-file"></i>
            </span>
            <textarea type="text" class="form-control" id="lc_txt_remarks"></textarea>
          </div>
        </div>
        
        <div class="mt-4">
          <button type="button" id="lc_btn_confirm_reset_of_certificate_number_and_indexing" 
                  class="btn btn-primary w-100 py-2" 
                  value="Confirm">
            <i class="fas fa-save me-2"></i>
            Confirm
          </button>
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


<div class="modal fade modal-blur effect-scale" id="update_and_review_plan_details" tabindex="-1"
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
                                        <input class="form-control bg-light" type="text" style="cursor: not-allowed;"
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
                                        <input class="form-control bg-light" type="text" style="cursor: not-allowed;"
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
                                        <input class="form-control bg-light" type="text" style="cursor: not-allowed;"
                                            name="txt_lc_smd_reference_number" type="text"
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
                                        <input class="form-control bg-light" style="cursor: not-allowed;" readonly
                                            name="txt_lc_registration_district_number" type="text"
                                            value="${registration_district_number}">
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
                                        <input class="form-control bg-light" style="cursor: not-allowed;" readonly
                                            type="text" value="${registration_section_number}">
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
                                        <input class="form-control bg-light"  style="cursor: not-allowed;" readonly
                                            type="text" value="${registration_block_number}">
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
                                        <input class="form-control bg-light" 
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
                                        <input class="form-control" id="txt_lc_plan_no_up" 
                                            type="text" value="${plan_no}">
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
                                        <input class="form-control" id="ltr_plan_no_up" 
                                            type="text"  value="${ltr_plan_no}">
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
                                        <input class="form-control" id="txt_lc_registry_mapref_up" 
                                            type="text"  value="${registry_mapref}">
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
                                        <input class="form-control" id="txt_lc_cc_no_up" 
                                            type="text" value="${cc_no}">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Close
                </button>
                <button type="button" class="btn btn-primary" id="update_smd_plan_details">
                    <i class="fas fa-save me-1"></i>Update Details
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="deed_further_entry" tabindex="-1" aria-labelledby="deedFurtherEntryLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered modal-fullscreen modal-dialog-scrollable">
    <div class="modal-content border-0 shadow-lg">
      <div class="modal-header bg-warning text-dark">
        <div class="d-flex align-items-center w-100">
          <div class="avatar avatar-lg bg-white text-warning rounded-circle me-3">
            <i class="bi bi-pencil-square fs-4"></i>
          </div>
          <div class="flex-grow-1">
            <h5 class="modal-title text-dark mb-1" id="deedFurtherEntryLabel">Deed Further Entry Details</h5>
            <p class="mb-0 small opacity-75">
              <i class="bi bi-info-circle me-1"></i>
              Additional deed information, reference numbers and specifications
            </p>
          </div>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>

      <div class="modal-body p-4">
        <div class="row" style="height: 100vh;">
          <div class="col-md-6 d-flex flex-column scrollable-col">
            <form id="frmDeedFurtherEntries_only_" novalidate>
              <div class="row g-4">
                <div class="col-lg-6">
                  <div class="mb-3">
                    <label for="dfe_job_number" class="form-label fw-semibold">
                      <i class="bi bi-file-earmark-text me-2"></i>Job Number
                    </label>
                    <input type="text" class="form-control bg-light" id="dfe_job_number" value="${job_number}" readonly>
                  </div>

                  <input type="hidden" id="dfe_client_name" value="${ar_name}">
                  <input type="hidden" id="dfe_business_process_sub_name" value="${business_process_sub_name}">

                  <div class="mb-3">
                    <label for="dfe_surveyor_number" class="form-label fw-semibold">
                      <i class="bi bi-rulers me-2"></i>Surveyors Number
                    </label>
                    <div class="input-group">
                      <span class="input-group-text bg-light"><i class="bi bi-123"></i></span>
                      <input type="text" class="form-control" id="dfe_surveyor_number" value="${licensed_surveyor_number}" placeholder="Enter surveyor number">
                    </div>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_regional_number" class="form-label fw-semibold">
                      <i class="bi bi-geo-alt me-2"></i>Regional Number
                    </label>
                    <div class="input-group">
                      <span class="input-group-text bg-light"><i class="bi bi-pin-map"></i></span>
                      <input type="text" class="form-control" id="dfe_regional_number" value="${regional_number}" placeholder="Enter regional number">
                    </div>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_land_size" class="form-label fw-semibold">
                      <i class="bi bi-aspect-ratio me-2"></i>Land Size
                    </label>
                    <div class="input-group">
                      <input type="text" class="form-control" id="dfe_land_size" value="${size_of_land}" placeholder="Enter land size" step="0.111">
                      <span class="input-group-text bg-light">Acre</span>
                    </div>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_nature_of_instrument" class="form-label fw-semibold">
                      <i class="bi bi-file-earmark me-2"></i>Nature of Instrument
                    </label>
                    <input type="text" class="form-control" id="dfe_nature_of_instrument" value="${nature_of_instrument}">
                  </div>

                  <div class="mb-3">
                    <label for="dfe_type_of_use" class="form-label fw-semibold">
                      <i class="bi bi-building me-2"></i>Type of Use
                    </label>
                    <input type="text" class="form-control" id="dfe_type_of_use" value="${type_of_use}">
                  </div>

                  <div class="mb-3">
                    <label for="dfe_type_of_interest" class="form-label fw-semibold">
                      <i class="bi bi-briefcase me-2"></i>Type of Interest
                      <span class="text-danger">*</span>
                    </label>
                    <select class="form-select" id="dfe_type_of_interest" required>
                      <option value="">Select Type of Interest</option>
                      <option value="LEASEHOLD" ${type_of_interest=="LEASEHOLD" ? "selected" : ""}>LEASEHOLD</option>
                      <option value="FREEHOLD" ${type_of_interest=="FREEHOLD" ? "selected" : ""}>FREEHOLD</option>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_consideration_currency" class="form-label fw-semibold">
                      <i class="bi bi-currency-exchange me-2"></i>Consideration Currency
                      <span class="text-danger">*</span>
                    </label>
                    <select class="form-select" id="dfe_consideration_currency" required>
                      <option value="GHS" ${consideration_fee_currency=="GHS" ? "selected":"" }>Ghana Cedis (GHS)</option>
                      <option value="USD" ${consideration_fee_currency=="USD" ? "selected":"" }>US Dollars (USD)</option>
                      <option value="GBP" ${consideration_fee_currency=="GBP" ? "selected":"" }>Pound Sterling (GBP)</option>
                      <option value="EUR" ${consideration_fee_currency=="EUR" ? "selected":"" }>Euro (EUR)</option>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_date_of_document" class="form-label fw-semibold">
                      <i class="bi bi-calendar-date me-2"></i>Date of Document
                      <span class="text-danger">*</span>
                    </label>
                    <input type="date" class="form-control" id="dfe_date_of_document" value="${date_of_document}" required>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_commencement_date" class="form-label fw-semibold">
                      <i class="bi bi-calendar-check me-2"></i>Commencement Date
                      <span class="text-danger">*</span>
                    </label>
                    <input type="date" class="form-control" id="dfe_commencement_date" value="${commencement_date}" required>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_publication_date" class="form-label fw-semibold">
                      <i class="bi bi-calendar-event me-2"></i>Publication Date
                    </label>
                    <input type="date" class="form-control" id="dfe_publication_date" value="${publicity_date}">
                  </div>

                   <div class="mb-3">
                    <label for="dfe_publication_date" class="form-label fw-semibold">
                      <i class="bi bi-calendar-event me-2"></i>Registration Date
                    </label>
                    <input type="date" class="form-control" id="dfe_date_of_registration" value="${date_of_registration}">
                  </div>
                </div>

                <div class="col-lg-6">
                  <div class="mb-3">
                    <label for="dfe_case_number" class="form-label fw-semibold">
                      <i class="bi bi-journal-text me-2"></i>Case Number
                    </label>
                    <input type="text" class="form-control bg-light" id="dfe_case_number" value="${case_number}" readonly>
                  </div>

                  <div class="row g-2 mb-3">
                    <div class="col-md-4">
                      <label for="dfe_locality" class="form-label fw-semibold">
                        <i class="bi bi-geo me-2"></i>Locality
                      </label>
                      <input type="text" class="form-control" id="dfe_locality" value="${locality}" required>
                    </div>
                    <div class="col-md-4">
                      <label for="dfe_district" class="form-label fw-semibold">
                        <i class="bi bi-geo me-2"></i>District
                      </label>
                      <input type="text" class="form-control" id="dfe_district" value="${district}" required>
                    </div>
                    <div class="col-md-4">
                      <label for="dfe_region" class="form-label fw-semibold">
                        <i class="bi bi-geo me-2"></i>Region
                      </label>
                      <input type="text" class="form-control" id="dfe_region" value="${region}" required>
                    </div>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_term" class="form-label fw-semibold">
                      <i class="bi bi-clock-history me-2"></i>Term (Years)
                      <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                      <input type="number" class="form-control" id="dfe_term" value="${term}" placeholder="Enter term in years" required>
                      <span class="input-group-text bg-light">Years</span>
                    </div>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_renewal_term" class="form-label fw-semibold">
                      <i class="bi bi-arrow-repeat me-2"></i>Option to Renew?
                      <span class="text-danger">*</span>
                    </label>
                    <div class="form-check">
                      <input class="form-check-input" type="radio" name="dfe_renewal_term_check" id="dfe_renewal_term_yes" value="yes" ${renewal_term > 0 ? 'checked' : ''}>
                      <label class="form-check-label" for="dfe_renewal_term_yes">Yes</label>
                    </div>
                    <div class="form-check">
                      <input class="form-check-input" type="radio" name="dfe_renewal_term_check" id="dfe_renewal_term_no" value="no" ${renewal_term < 1 ? 'checked' : ''}>
                      <label class="form-check-label" for="dfe_renewal_term_no">No</label>
                    </div>
                    <div id="dfe_renewal_term_div" class="mt-2 ${renewal_term < 1 ? 'd-none' : ''}">
                      <label for="dfe_renewal_term" class="form-label fw-semibold">
                        <i class="bi bi-arrow-repeat me-2"></i>Renewal Term (Years)
                        <span class="text-danger">*</span>
                      </label>
                      <input type="text" class="form-control" id="dfe_renewal_term" value="${renewal_term}" required>
                    </div>
                  </div>

                  <input type="hidden" class="form-control" id="dfe_family_name" placeholder="Stool/Family Name">
                  <input type="hidden" class="form-control" id="dfe_grantor_family">

                  <div class="mb-3">
                    <label for="dfe_extent" class="form-label fw-semibold">
                      <i class="bi bi-arrows-angle-expand me-2"></i>Extent (Land Size)
                      <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                      <button class="btn btn-secondary" id="convert_acres_to_extent_deed">
                        <i class="bi bi-arrow-repeat me-2"></i>Load Extent
                      </button>
                      <input type="text" class="form-control bg-light" id="dfe_extent" value="${extent}" required readonly>
                    </div>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_consideration_fee" class="form-label fw-semibold">
                      <i class="bi bi-cash-coin me-2"></i>Consideration Fee
                      <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                      <span class="input-group-text bg-light" id="dfe_currencySymbol">
                        ${empty fn:trim(consideration_fee_currency) ? 'GHS' : fn:trim(consideration_fee_currency)}
                      </span>
                      <input type="number" class="form-control" id="dfe_consideration_fee" value="${consideration_fee}" placeholder="Enter amount" step="0.01" required>
                    </div>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_annual_rent" class="form-label fw-semibold">
                      <i class="bi bi-cash-stack me-2"></i>Annual Rent
                      <span class="text-danger">*</span>
                    </label>
                    <div class="input-group">
                      <span class="input-group-text bg-light">GHS</span>
                      <input type="number" class="form-control" id="dfe_annual_rent" value="${annual_rent}" placeholder="Enter annual rent" step="0.01" required>
                    </div>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_transaction_number" class="form-label fw-semibold">
                      <i class="bi bi-receipt me-2"></i>Transaction Number
                    </label>
                    <input type="text" class="form-control bg-light" id="dfe_transaction_number" value="${transaction_number}" readonly>
                  </div>

                  <div class="mb-3">
                    <label for="dfe_serial_number" class="form-label fw-semibold">
                      <i class="bi bi-upc-scan me-2"></i>Serial Number
                    </label>
                    <input type="text" class="form-control" id="dfe_serial_number" value="${ls_number}" placeholder="Enter serial number">
                  </div>

                  <div class="mb-3">
                    <label for="dfe_deed_number" class="form-label fw-semibold">
                      <i class="bi bi-file-earmark-ruled me-2"></i>Deed Number
                    </label>
                    <input type="text" class="form-control" id="dfe_deed_number" value="${deed_number}" placeholder="Enter deed number">
                  </div>

                  <div class="mb-3">
                    <label for="dfe_file_number" class="form-label fw-semibold">
                      <i class="bi bi-folder2-open me-2"></i>File Number
                    </label>
                    <input type="text" class="form-control" id="dfe_file_number" value="${file_number}" placeholder="Enter file number">
                  </div>

                  <div class="mb-3">
                    <label for="dfe_property_number" class="form-label fw-semibold">
                      <i class="bi bi-folder2-open me-2"></i>Property Number
                    </label>
                    <input type="text" class="form-control" id="dfe_property_number" value="${property_number}" placeholder="Enter property number">
                  </div>
                </div>
              </div>

              <hr class="my-4">
              <div id="deed-alert-display-space" class="mb-4"></div>

              <div class="d-flex justify-content-between align-items-center">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                  <i class="bi bi-x-circle me-2"></i>Close
                </button>
                <button type="submit" id="btnAddDeedFurtherDetails" class="btn btn-warning text-dark">
                  <i class="bi bi-check-circle me-2"></i>Save Changes
                </button>
              </div>
            </form>
          </div>
          <div class="col-md-6 d-flex flex-column scrollable-col">
            <div class="_gated_workflow_documents"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur map-modal" id="deed_check_polygon" tabindex="-1" aria-labelledby="deedCheckPolygonLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable">
    <div class="modal-content border-0 shadow-lg">
      <div class="modal-header bg-danger text-white">
        <div class="d-flex align-items-center w-100">
          <div class="avatar avatar-lg bg-white text-danger rounded-circle me-3">
            <i class="bi bi-pentagon fs-4"></i>
          </div>
          <div class="flex-grow-1">
            <h5 class="modal-title text-white mb-1" id="deedCheckPolygonLabel">Check Polygon</h5>
            <p class="mb-0 small opacity-75">
              <i class="bi bi-info-circle me-1"></i>
              Review the WKT polygon and view it on the map
            </p>
          </div>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>

      <div class="modal-body p-4">
        <div class="card border mb-4">
          <div class="card-header bg-light">
            <h6 class="mb-0 fw-semibold">
              <i class="bi bi-polygon me-2"></i>WKT Polygon Data
            </h6>
          </div>
          <div class="card-body">
            <label for="deed_check_wkt_polygon" class="form-label fw-semibold">
              <i class="bi bi-code-slash me-2"></i>WKT Polygon
            </label>
            <div class="input-group">
              <textarea class="form-control font-monospace" id="deed_check_wkt_polygon" rows="4" placeholder="POLYGON((...))" readonly style="cursor: not-allowed;">${parcel_wkt}</textarea>
              <button class="btn btn-outline-secondary" type="button" onclick="copyWktToClipboard('deed_check_wkt_polygon')" data-bs-toggle="tooltip" data-bs-placement="top" title="Copy to clipboard">
                <i class="bi bi-clipboard"></i>
              </button>
            </div>
            <div class="form-text">
              <i class="bi bi-info-circle me-1"></i>
              This is the current parcel polygon for the loaded deed application.
            </div>
          </div>
        </div>

        <div class="card border mb-4">
          <div class="card-header bg-light">
            <h6 class="mb-0 fw-semibold">
              <i class="bi bi-tools me-2"></i>Map Tools
            </h6>
          </div>
          <div class="card-body">
            <div class="d-flex flex-wrap gap-2 align-items-center">
              <button type="button" class="btn btn-danger btn-sm" id="lc_btn_visualise_wkt">
                <i class="bi bi-eye me-1"></i> View WKT
              </button>
              <button type="button" class="btn btn-outline-secondary btn-sm" id="deed_btn_polygon_zoom_full">
                <i class="bi bi-arrows-fullscreen me-1"></i> Fit Polygon
              </button>
              <span class="badge bg-light text-dark border ms-auto" id="deedPolygonMapStatus">
                <i class="bi bi-circle me-1"></i>Ready
              </span>
            </div>
          </div>
        </div>

        <div class="card border">
          <div class="card-header bg-light d-flex justify-content-between align-items-center">
            <h6 class="mb-0 fw-semibold">
              <i class="bi bi-globe me-2"></i>Map Preview
            </h6>
            <small class="text-muted">
              <i class="bi bi-arrows-fullscreen me-1"></i>Click and drag to navigate
            </small>
          </div>
          <div class="card-body p-0">
            <div class="map-container" id="deed-check-polygon-map" style="height: 460px;"></div>
          </div>
        </div>
      </div>

      <div class="modal-footer bg-light">
        <div class="d-flex justify-content-between w-100 align-items-center">
          <small class="text-muted">
            <i class="bi bi-shield-check me-1"></i>Verify the polygon before proceeding with deed capture
          </small>
          <div class="d-flex flex-wrap gap-2 justify-content-end">
            <button type="button" class="btn btn-primary" id="btn_send_deed_noting_request">
              <i class="ri-send-plane-line me-1"></i>Send Request
            </button>
            <c:if test="${(division == 'LRD' or division == 'PVLMD') and user_level > 1}">
              <button type="button" class="btn btn-danger d-none" id="btn_confirm_lrd_parcel_noting_deed_data_capture" data-deed-polygon-confirm="true">
                <i class="ri-checkbox-circle-line me-1"></i>Confirm Noting
              </button>
            </c:if>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
              <i class="bi bi-x-circle me-1"></i>Close
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<div class="modal fade modal-blur" id="schedule_adjudication_hearing" tabindex="-1" aria-labelledby="inspectionOfSiteModalLabel" aria-hidden="true" data-bs-backdrop="static">
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
                            Schedule Adjudication Hearing
                        </h5>
                        <!-- <p class="text-white-50 small mb-0">
                             Notify applicant for land/property inspection
                        </p> -->
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
                                        <span class="fw-semibold small" id="adjudication_hearing_case_number">${case_number}</span>
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
                                        <span class="fw-semibold small" id="adjudication_hearing_job_number">${job_number}</span>
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
                                        <span class="fw-semibold small" id="adjudication_hearing_applicant_name">${ar_name}</span>
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
                                        <span class="fw-semibold small" id="adjudication_hearing_app_type">${business_process_sub_name}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Main Notification Form -->
                <form id="adjudicationHearingNotificationForm" method="post" class="needs-validation" novalidate>
                    
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
                                    <textarea class="form-control bg-light" id="adjudication_hearing_custom_message" rows="7" 
                                              placeholder="Compose your message here..."></textarea>
                                    <div class="d-flex justify-content-between mt-1">
                                        <div class="form-text text-muted">
                                            <i class="fas fa-info-circle me-1"></i> 
                                            Maximum 500 characters
                                        </div>
                                        <span class="text-muted small" id="message_char_count">250/500</span>
                                    </div>
                                </div>
                                
                                <div class="col-12">
                                    <!-- <div class="alert alert-warning bg-warning bg-opacity-10 border-warning mb-0">
                                        <div class="d-flex">
                                            <div class="flex-shrink-0">
                                                <i class="fas fa-clock fa-fw"></i>
                                            </div>
                                            <div class="flex-grow-1 ms-2">
                                                <strong>Reminder:</strong> The applicant will be notified immediately via the selected channels. 
                                                A follow-up reminder will be sent 24 hours before the scheduled inspection.
                                            </div>
                                        </div>
                                    </div> -->
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
                        <button type="submit" form="adjudicationHearingNotificationForm" class="btn btn-success px-5" id="sendAdjudicationHearingNotification">
                            <i class="fas fa-paper-plane me-2"></i>Send Notification
                            <span class="badge bg-white text-success ms-2 py-1 px-2">Now</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade modal-blur" id="determine_outcome_of_objection" tabindex="-1" aria-labelledby="determineOutcomeModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered ">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header - Gradient Background -->
            <div class="modal-header bg-primary text-white border-0 py-3">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-white bg-opacity-20 py-2 px-3 me-3">
                        <i class="fas fa-gavel text-primary fa-2x"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white fw-bold" id="determineOutcomeModalLabel">
                            Determine Outcome of Objection
                        </h5>
                        <p class="text-white-50 small mb-0">
                            Review and decide on the objection case
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
                                <i class="fas fa-briefcase me-2 text-primary"></i>Objection Details
                            </h6>
                            <span class="badge bg-warning px-3 py-2">
                                <i class="fas fa-clock me-1"></i> Pending Determination
                            </span>
                        </div>
                        
                        <div class="row g-3 mt-2">
                            <div class="col-md-4">
                                <div class="d-flex align-items-start">
                                    <div class="bg-primary bg-opacity-10 rounded p-2 me-2">
                                        <i class="fas fa-file-invoice text-primary"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Case Number</small>
                                        <span class="fw-semibold small" id="obj_case_number_display">${case_number}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-start">
                                    <div class="bg-info bg-opacity-10 rounded p-2 me-2">
                                        <i class="fas fa-briefcase text-info"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Job Number</small>
                                        <span class="fw-semibold small" id="obj_job_number_display">${job_number}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-start">
                                    <div class="bg-success bg-opacity-10 rounded p-2 me-2">
                                        <i class="fas fa-user text-success"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Applicant Name</small>
                                        <span class="fw-semibold small" id="obj_applicant_name_display">${ar_name}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Outcome Selection Card -->
                <div class="card shadow-sm mb-4">
                    <!-- <div class="card-header bg-white border-0 pt-3 pb-0">
                        <div class="d-flex align-items-center">
                            <div class="bg-info bg-opacity-10 p-2 rounded-circle me-2">
                                <i class="fas fa-balance-scale text-info"></i>
                            </div>
                            <h6 class="fw-bold mb-0">Decision Outcome</h6>
                            <span class="badge bg-light text-dark ms-2 px-3 py-2">
                                <i class="fas fa-gavel me-1"></i> Select Ruling
                            </span>
                        </div>
                    </div> -->
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12">
                                <label class="form-label fw-semibold text-muted small text-uppercase mb-3">
                                    <!-- <i class="fas fa-legal me-1"></i> -->
                                     Choose Determination
                                </label>
                                <div class="d-flex gap-3 flex-wrap">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="objection_outcome" id="outcome_upheld" value="upheld" checked>
                                        <label class="form-check-label fw-semibold" for="outcome_upheld">
                                            <!-- <span class="badge bg-success bg-opacity-10 text-primary px-3 py-2">
                                                <i class="fas fa-check-circle me-1"></i>
                                            </span> --> Objection Upheld
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="objection_outcome" id="outcome_not_upheld" value="not_upheld">
                                        <label class="form-check-label fw-semibold" for="outcome_not_upheld">
                                            <!-- <span class="badge bg-danger bg-opacity-10 text-danger px-3 py-2">
                                                <i class="fas fa-times-circle me-1"></i>
                                            </span> -->  Objection Not Upheld
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Dynamic Forms Container -->
                <div id="dynamic_form_container">
                    <!-- Objection Upheld Form (Initially Visible) -->
                    <div id="form_upheld_container" class="card shadow-sm mb-4">
                        <div class="card-header bg-white border-0 pt-3 pb-0">
                            <div class="d-flex align-items-center">
                                <div class="bg-success bg-opacity-10 p-2 rounded-circle me-2">
                                    <i class="fas fa-trophy text-success"></i>
                                </div>
                                <h6 class="fw-bold mb-0 text-primary">Objection Upheld Details</h6>
                                <span class="badge bg-success text-white ms-2 px-3 py-2">Approved</span>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="form_objection_upheld">
                                <input id="action_on_form_upheld" type="hidden" value="upheld">
                                <input id="obj_id_upheld" name="obj_id" type="hidden" value="${userid}">
                                
                                <div class="row g-3">
                                    <div class="col-lg-6 col-md-6 col-sm-12">
                                        <div class="form-group mb-3">
                                            <label for="upheld_reasons" class="form-label fw-semibold">
                                                <i class="fas fa-exclamation-triangle me-1 text-primary"></i>Reasons for Upheld <span class="text-danger">*</span>
                                            </label>
                                            <textarea name="obj_reasons" id="upheld_reasons" class="form-control" rows="3" required placeholder="Provide detailed reasons for upholding the objection"></textarea>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="upheld_remarks" class="form-label fw-semibold">
                                                <i class="fas fa-comment me-1 text-primary"></i>Notify Applicant of Suspension <span class="text-danger">*</span>
                                            </label>
                                            <textarea name="obj_remarks" id="notification_suspension" class="form-control" rows="3" required placeholder="Provide detailed reasons for suspending the application"></textarea>
                                        </div>
                                        <!-- <div class="form-group mb-3">
                                            <label for="upheld_status" class="form-label fw-semibold">
                                                <i class="fas fa-toggle-on me-1 text-primary"></i>Status
                                            </label>
                                            <select name="obj_status" id="upheld_status" class="form-select" required>
                                                <option value="true">Active</option>
                                                <option value="false">Inactive</option>
                                            </select>
                                        </div> -->
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12">
                                        <div class="form-group mb-3">
                                            <label for="upheld_remarks" class="form-label fw-semibold">
                                                <i class="fas fa-comment me-1 text-primary"></i>Remarks <span class="text-danger">*</span>
                                            </label>
                                            <textarea name="obj_remarks" id="upheld_remarks" class="form-control" rows="3" required placeholder="Additional remarks or recommendations"></textarea>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="upheld_reasons" class="form-label fw-semibold">
                                                <i class="fas fa-exclamation-triangle me-1 text-primary"></i>Advise Objector to Submit Document <span class="text-danger">*</span>
                                            </label>
                                            <textarea name="obj_reasons" id="advise_objector" class="form-control" rows="3" required placeholder="Provide detailed advise for the objector to submit the required document"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="alert alert-success bg-success bg-opacity-10 border-success">
                                            <div class="d-flex text-primary">
                                                <div class="flex-shrink-0">
                                                    <i class="fas fa-info-circle fa-fw"></i>
                                                </div>
                                                <div class="flex-grow-1 ms-2">
                                                    <strong>Note:</strong> Upholding this objection means the objector's claims are valid. The application will be rejected, and appropriate actions will be taken.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Objection Not Upheld Form (Initially Hidden) -->
                    <div id="form_not_upheld_container" class="card shadow-sm mb-4" style="display: none;">
                        <div class="card-header bg-white border-0 pt-3 pb-0">
                            <div class="d-flex align-items-center">
                                <div class="bg-danger bg-opacity-10 p-2 rounded-circle me-2">
                                    <i class="fas fa-ban text-danger"></i>
                                </div>
                                <h6 class="fw-bold mb-0 text-danger">Objection Not Upheld Details</h6>
                                <span class="badge bg-danger text-white ms-2 px-3 py-2">Rejected</span>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="form_objection_not_upheld">
                                <input id="action_on_form_not_upheld" type="hidden" value="not_upheld">
                                <input id="obj_id_not_upheld" name="obj_id" type="hidden" value="${userid}">
                                
                                <div class="row g-3">
                                    <div class="col-lg-6 col-md-6 col-sm-12">
                                        <div class="form-group mb-3">
                                            <label for="not_upheld_reasons" class="form-label fw-semibold">
                                                <i class="fas fa-exclamation-triangle me-1 text-danger"></i>Reasons for Not Upheld <span class="text-danger">*</span>
                                            </label>
                                            <textarea name="obj_reasons" id="not_upheld_reasons" class="form-control" rows="3" required placeholder="Provide detailed reasons for not upholding the objection"></textarea>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="not_upheld_remarks" class="form-label fw-semibold">
                                                <i class="fas fa-exclamation-circle me-1 text-danger"></i>Notify Objector of Rejection <span class="text-danger">*</span>
                                            </label>
                                            <textarea name="obj_remarks" id="notification_rejection" class="form-control" rows="3" required placeholder="Provide detailed reasons for rejecting the objection"></textarea>
                                        </div>
                                        <!-- <div class="form-group mb-3">
                                            <label for="not_upheld_status" class="form-label fw-semibold">
                                                <i class="fas fa-toggle-on me-1 text-danger"></i>Status
                                            </label>
                                            <select name="obj_status" id="not_upheld_status" class="form-select" required>
                                                <option value="true">Active</option>
                                                <option value="false">Inactive</option>
                                            </select>
                                        </div> -->
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12">
                                        <div class="form-group mb-3">
                                            <label for="not_upheld_remarks" class="form-label fw-semibold">
                                                <i class="fas fa-comment me-1 text-danger"></i>Remarks <span class="text-danger">*</span>
                                            </label>
                                            <textarea name="obj_remarks" id="not_upheld_remarks" class="form-control" rows="3" required placeholder="Additional remarks or recommendations"></textarea>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="not_upheld_remarks" class="form-label fw-semibold">
                                                <i class="fas fa-comment me-1 text-danger"></i>Notify Applicant <span class="text-danger">*</span>
                                            </label>
                                            <textarea name="obj_remarks" id="notification_rejection" class="form-control" rows="3" required placeholder="Provide detailed reasons for rejecting the objection"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="alert alert-warning bg-warning bg-opacity-10 border-warning">
                                            <div class="d-flex">
                                                <div class="flex-shrink-0">
                                                    <i class="fas fa-info-circle fa-fw"></i>
                                                </div>
                                                <div class="flex-grow-1 ms-2">
                                                    <strong>Note:</strong> Not upholding this objection means the objector's claims are invalid. The application will proceed, and appropriate notifications will be sent.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-0 px-4 py-3">
                <div class="d-flex flex-wrap align-items-center justify-content-end w-100 gap-2">
                    <!-- <div class="form-check mb-0">
                        <input class="form-check-input" type="checkbox" id="notify_parties">
                        <label class="form-check-label small text-muted" for="notify_parties">
                            <i class="fas fa-bell me-1"></i> Notify all parties of outcome
                        </label>
                    </div> -->
                    
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Cancel
                        </button>
                        <!-- <button type="button" class="btn btn-primary px-4" id="previewOutcome">
                            <i class="fas fa-eye me-2"></i>Preview Decision
                        </button> -->
                        <button type="submit" class="btn btn-success px-5" id="submitOutcomeDecision">
                            <i class="fas fa-check-circle me-2"></i>Submit Decision
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade modal-blur" id="delink_jobs_mother_from_baby" tabindex="-1" aria-labelledby="delinkMotherBabyModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header - Gradient Background -->
            <div class="modal-header bg-danger text-white border-0 py-3">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-white bg-opacity-20 py-2 px-3 me-3">
                        <i class="fas fa-unlink text-danger fa-2x"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white fw-bold" id="delinkMotherBabyModalLabel">
                            Delink Mother from Baby
                        </h5>
                        <p class="text-white-50 small mb-0">
                            Disassociate relationship between jobs
                        </p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body p-4">
                
                <!-- Warning Alert -->
                <div class="alert alert-danger bg-danger bg-opacity-10 border-danger mb-4">
                    <div class="d-flex">
                        <div class="flex-shrink-0">
                            <i class="fas fa-exclamation-triangle fa-fw fs-4"></i>
                        </div>
                        <div class="flex-grow-1 ms-2">
                            <strong class="text-danger">Warning!</strong>
                            <p class="mb-0 small">Delinking will remove the relationship between mother and baby job. This action can be undone by relinking them later.</p>
                        </div>
                    </div>
                </div>
                
                <!-- Main Form -->
                <form id="delinkJobsForm" method="post" class="needs-validation" novalidate>
                    
                    <!-- Baby Job Details Card -->
                    <div class="card shadow-sm mb-4 border-0">
                        <div class="card-header bg-white border-0 pt-3 pb-0">
                            <div class="d-flex align-items-center">
                                <h6 class="fw-bold mb-0">Baby Job Details</h6>
                                <span class="badge bg-warning text-dark ms-2 px-3 py-2">Child Application</span>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-12">
                                    <label for="baby_job_number" class="form-label fw-semibold">
                                        <i class="fas fa-briefcase me-1 text-warning"></i>Job Number
                                        <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-hashtag text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control bg-light" id="baby_job_number" 
                                               name="baby_job_number" value="${job_number}" placeholder="Enter baby job number" 
                                               required readonly autocomplete="off" style="cursor: not-allowed;">
                                    </div>
                                    <!-- <div class="form-text text-muted">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Enter the job number of the baby/child application
                                    </div> -->
                                </div>
                                
                                <div class="col-12">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-info-circle me-1 text-warning"></i>Current Mother Information
                                    </label>
                                    <div class="bg-light p-3 rounded-3">
                                        <!-- <div class="d-flex justify-content-between align-items-center mb-2"> -->
                                            <!-- <span class="small text-muted">Linked Mother Job:</span> -->

                                            <div class="table-responsive">
                                              <table class="table table-sm table-hover w-100" width="100%">
                                                  <thead>
                                                      <tr>
                                                          <th>Job Number</th>
                                                          <th>Case Number</th>
                                                          <th>Type of Relationship</th>
                                                          <th>Date</th>
                                                          <th>Action</th>
                                                      </tr>
                                                  </thead>
                                                  <tbody>
                                                      <c:forEach items="${mother_to_child_link_list}" var="mother_to_child_link_row">
                                                          <tr>
                                                          
                                                              <td>${mother_to_child_link_row.job_number}</td>
                                                              <td>${mother_to_child_link_row.mc_case_number}</td>
                                                              <td>${mother_to_child_link_row.mc_type_of_relationship}</td>
                                                              <td>${mother_to_child_link_row.created_date}</td>
                                                              <td>
                                                                  <c:choose>
                                                                      <c:when test="${not empty business_process_sub_name and fn:containsIgnoreCase(business_process_sub_name, 'deed')}">
                                                                          <button type="button"  
                                                                              data-job_number="${mother_to_child_link_row.mc_job_number}" 
                                                                              data-case_number="${mother_to_child_link_row.mc_case_number}" 
                                                                              data-transaction_number="${mother_to_child_link_row.mc_transaction_number}"
                                                                              class="btn btn-sm btn-warning btn-view-mother-Child-details-deed"
                                                                          >
                                                                              <i class="fas fa-eye"></i>
                                                                          </button> 
                                                                      </c:when>

                                                                      <c:otherwise>
                                                                          <button type="button"  
                                                                              data-job_number="${mother_to_child_link_row.mc_job_number}" 
                                                                              data-case_number="${mother_to_child_link_row.mc_case_number}" 
                                                                              data-transaction_number="${mother_to_child_link_row.mc_transaction_number}"
                                                                              class="btn btn-sm btn-warning btn-view-mother-Child-details"
                                                                          >
                                                                              <i class="fas fa-eye"></i>
                                                                          </button> 
                                                                      </c:otherwise>
                                                                  </c:choose>
                                                              </td>
                                                          </tr>
                                                      </c:forEach>
                                                  </tbody>
                                              </table>
                                          </div>
                                        <!-- </div> -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Mother Job Details Card -->
                    <div class="card shadow-sm mb-4 border-0">
                        <div class="card-header bg-white border-0 pt-3 pb-0">
                            <div class="d-flex align-items-center">
                                <h6 class="fw-bold mb-0">Mother Job Details</h6>
                                <span class="badge bg-primary text-white ms-2 px-3 py-2">Parent Application</span>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-12">
                                    <label for="mother_job_number" class="form-label fw-semibold">
                                        <i class="fas fa-briefcase me-1 text-primary"></i>Job Number
                                        <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-hashtag text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control" id="mother_job_number" 
                                               name="mother_job_number" placeholder="Enter mother job number" 
                                               required autocomplete="off">
                                    </div>
                                    <div class="form-text text-muted">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Enter the job number of the mother/parent application
                                    </div>
                                </div>
                                
                                <!-- <div class="col-12">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-children me-1 text-primary"></i>Associated Baby Jobs
                                    </label>
                                    <div class="bg-light p-3 rounded-3" style="max-height: 150px; overflow-y: auto;">
                                        <div class="text-muted text-center" id="associated_babies_list">
                                            <i class="fas fa-spinner fa-spin me-2"></i>Enter mother job to view associated babies
                                        </div>
                                    </div>
                                </div> -->
                            </div>
                        </div>
                    </div>
                    
                    <!-- Confirmation Section -->
                    <!-- <div class="card border-0 bg-light">
                        <div class="card-body">
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" id="confirm_delink" required>
                                <label class="form-check-label fw-semibold" for="confirm_delink">
                                    I confirm that I want to delink this mother from baby job
                                </label>
                            </div>
                        </div>
                    </div> -->
                </form>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-0 px-4 py-3">
                <div class="d-flex flex-wrap align-items-center justify-content-end w-100 gap-2">
                    <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <button type="button" class="btn btn-danger px-5" id="confirmDelinkBtn" >
                        <i class="fas fa-unlink me-2"></i>Delink Jobs
                        <span class="badge bg-white text-danger ms-2 py-1 px-2">Confirm</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade modal-blur effect-scale" id="confirm_notation_of_objection" tabindex="-1" aria-labelledby="lrd_initial_approvalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                    <h5 class="modal-title text-white" id="lrd_initial_approvalLabel">
                        <i class="fas fa-user-tie me-2"></i>
                        Confirmation Notation of Objection
                    </h5>
                    <div class="ms-auto">
                        <c:if test="${(division == 'LRD' or division == 'PVLMD') and user_level > 1}">
                            <button type="button" class="btn btn-danger" id="btn_confirm_notation_of_objection">
                                <i class="ri-checkbox-circle-line me-1"></i>Confirm Noting
                            </button>
                        </c:if>
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