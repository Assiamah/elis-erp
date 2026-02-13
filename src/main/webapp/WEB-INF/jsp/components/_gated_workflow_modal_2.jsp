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
                    <button type="button" class="btn btn-warning ms-auto btn_send_request" 
                        data-job_number="${job_number}" 
                        data-ar_name="${ar_name}" 
                        data-business_process_sub_name="${business_process_sub_name}" 
                        data-locality="${locality}" 
                        data-bs-desc="${babyStep.bse_description}">
                        <i class="ri-send-plane-line me-1"></i>Send Request
                    </button>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
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
                                                    <button class="btn btn-outline-primary btn-sm open-view-notes" 
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
                                        <button type="button" class="btn btn-success btn-sm" 
                                            id="lc_btn_visualise_search" 
                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                            title="Plot Parcels">
                                            <i class="fas fa-object-ungroup me-1"></i>
                                            Plot Parcels
                                        </button>
                                        
                                        <!-- Print Map Button -->
                                        <button type="button" class="btn btn-info btn-sm" 
                                            id="lc_btnprintmap" 
                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                            title="Print Map">
                                            <i class="fas fa-print me-1"></i>
                                            Print
                                        </button>
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
                                        <button type="button" class="btn btn-success btn-sm" 
                                            id="lc_btn_visualise_search" 
                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                            title="Plot Parcels">
                                            <i class="fas fa-object-ungroup me-1"></i>
                                            Plot Parcels
                                        </button>
                                        
                                        <!-- Print Map Button -->
                                        <button type="button" class="btn btn-info btn-sm" 
                                            id="lc_btnprintmap" 
                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                            title="Print Map">
                                            <i class="fas fa-print me-1"></i>
                                            Print
                                        </button>
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
                                        <button type="button" class="btn btn-success btn-sm" 
                                            id="lc_btn_visualise_search">
                                            <i class="fas fa-object-ungroup me-1"></i>
                                            Plot Parcels
                                        </button>
                                        
                                        <!-- Print Map Button -->
                                        <button type="button" class="btn btn-info btn-sm" 
                                            id="lc_btnprintmap">
                                            <i class="fas fa-print me-1"></i>
                                            Print
                                        </button>

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
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="review_records_verification_label">
                    <i class="fas fa-edit me-2"></i>
                    Compose Search Report
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			<div class="modal-body">
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
                
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-chart-pie"></i> Summarize Search Reports
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
                                        <div id="lc_search_report_summary_details_2" class="quill-editor" style="height: 300px;">
                                            ${remark_or_comment}
                                        </div>
                                        <div class="position-absolute top-0 end-0 p-3 text-muted">
                                            <i class="fas fa-file-signature"></i>
                                        </div>
                                    </div>
                                </div>
                            
                            <div class="row g-3 mt-2">
                                <div class="col-auto">
                                <button type="button" 
                                    name="btn_compose_certificate_template_2" 
                                    id="btn_compose_certificate_template_2" 
                                    class="btn btn-warning btn-icon-split">
                                    <span class="icon text-white-50"> 
                                    <i class="fas fa-edit"></i>
                                    </span>
                                    <span class="text">Compose Template</span>
                                </button>
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
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="check_search_report_details">
                    <i class="fas fa-edit me-2"></i>
                    Check Search Report Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
			<div class="modal-body">
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
                
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-chart-pie"></i> Summarize Search Reports
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
                                        <div id="lc_search_report_summary_details_3" class="quill-editor" style="height: 300px;">
                                            ${remark_or_comment}
                                        </div>
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

                <button type="button" class="btn btn-info btn-sm" 
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
                </button>

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


<div class="modal fade" id="newValuationModal" tabindex="-1" aria-labelledby="newValuationModalLabel" aria-hidden="true">
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
     aria-labelledby="assessedValueModalLabel" aria-hidden="true">
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
<div class="modal fade" id="inspection_of_site" tabindex="-1" aria-labelledby="inspectionOfSiteModalLabel" aria-hidden="true">
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
<div class="modal fade effect-fade modal-blur" id="generate_barcode_on_plan" tabindex="-1" aria-labelledby="generateBarcodeModalLabel" aria-hidden="true">
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