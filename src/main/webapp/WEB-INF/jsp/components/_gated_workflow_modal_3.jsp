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
	role="dialog" aria-labelledby="request_for_file_creation" aria-hidden="true"
>
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="request_for_file_creation_label">
                    <i class="bi bi-file-earmark me-2"></i>
                    Request for File Creation
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			
			<div class="modal-body">
				<!-- Job Number -->
                <div class="mb-4">
                    <label for="bl_job_number" class="form-label fw-bold">
                        <i class="fas fa-hashtag me-2 text-primary"></i>
                        Job Number
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-barcode text-muted"></i>
                        </span>
                        <input class="form-control bg-light" type="text" placeholder="" value="${job_number}"
                               id="req_job_number_rh" readonly style="cursor: not-allowed;">
                    </div>
                </div>

                <!-- Applicant Name -->
                <div class="mb-4">
                    <label for="bl_ar_name" class="form-label fw-bold">
                        <i class="fas fa-user me-2 text-primary"></i>
                        Applicant Name
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-user-tag text-muted"></i>
                        </span>
                        <textarea rows="2" class="form-control bg-light" placeholder=""
                                  id="req_ar_name_rh" readonly style="cursor: not-allowed;">${ar_name}</textarea>
                    </div>
                </div>

                <!-- Application Type -->
                <div class="mb-4">
                    <label for="bl_business_process_sub_name" class="form-label fw-bold">
                        <i class="fas fa-file-alt me-2 text-primary"></i>
                        Application Type
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-file-signature text-muted"></i>
                        </span>
                        <textarea rows="2" class="form-control bg-light" placeholder="" 
                                  id="req_business_process_sub_name_rh" readonly style="cursor: not-allowed;">${business_process_sub_name}</textarea>
                    </div>
                </div>

                <!-- Locality -->
                <div class="mb-4">
                    <label for="bl_application_stage_name" class="form-label fw-bold">
                        <i class="fas fa-map-marker-alt me-2 text-primary"></i>
                        Locality
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-map-pin text-muted"></i>
                        </span>
                        <textarea rows="2" class="form-control bg-light" placeholder="" value="${locality}"
                                  id="req_locality_rh" readonly style="cursor: not-allowed;">${locality}</textarea>
                    </div>
                </div>

                <!-- Sent Purpose -->
                <div class="mb-4">
                    <label for="bl_job_purpose" class="form-label fw-bold">
                        <i class="fas fa-bullseye me-2 text-primary"></i>
                        Sent Purpose
                    </label>
                    <div class="input-group">
                        <input class="form-control bg-light" type="text" placeholder="" value="File Creation"
                               id="req_job_purpose_rh" readonly style="cursor: not-allowed;">
                    </div>
                    <small class="text-muted mt-1 d-block">
                        <i class="fas fa-lightbulb me-1"></i>
                        Select the purpose for sending this request
                    </small>
                </div>

                <!-- Remarks -->
                <div class="mb-4">
                    <label for="bl_application_stage_name_baby_step" class="form-label fw-bold">
                        <i class="fas fa-comment-dots me-2 text-primary"></i>
                        Remarks
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-sticky-note text-muted"></i>
                        </span>
                        <textarea rows="3" class="form-control" placeholder="Add any additional remarks or instructions..." 
                                  id="req_remarks_rh"></textarea>
                    </div>
                    <small class="text-muted mt-1 d-block">
                        <i class="fas fa-info-circle me-1"></i>
                        Optional: Add any special instructions or notes
                    </small>
                </div>
			</div>
			
			<div class="modal-footer bg-light">
				<button type="button" 
					class="btn btn-outline-danger"
					data-bs-dismiss="modal">
					<i class="fas fa-times me-2"></i>
					Close
				</button>
                <button type="button" 
					class="btn btn-success"
					id="req_file_creation_rh">
					<i class="fas fa-check me-2"></i>
					Request
				</button>
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
