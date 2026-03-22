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