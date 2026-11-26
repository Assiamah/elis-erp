<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
/* Scoped ELIS emerald-green styling: preserves existing element IDs and modal hooks. */
.deed-capture-page { --deed-primary:#087f5b; --deed-dark:#064b39; --deed-deep:#043c2e; --deed-bright:#0ba674; --deed-pale:#eaf8ef; --deed-border:#d5e9dc; --deed-text:#193d30; color:var(--deed-text); }
.deed-capture-page .deed-page-heading { border-radius:17px; padding:22px 26px; color:#fff; background:linear-gradient(115deg,var(--deed-deep),var(--deed-primary) 75%,var(--deed-bright)); box-shadow:0 12px 28px rgba(4,75,57,.17); }
.deed-capture-page .deed-page-heading h1,.deed-capture-page .deed-page-heading p { color:#fff !important; }
.deed-capture-page .deed-page-heading p { opacity:.88; }
.deed-capture-page .deed-page-heading .breadcrumb-item,.deed-capture-page .deed-page-heading .breadcrumb-item a { color:#e0fae9; }
.deed-capture-page .deed-page-heading .breadcrumb-item.active { color:#fff; }
.deed-capture-page .deed-page-heading .breadcrumb-item+.breadcrumb-item::before { color:#d6f5e0; }
.deed-capture-page .deed-step-shell { background:linear-gradient(145deg,#f6fcf8,#eaf6ee); border:1px solid var(--deed-border); border-radius:20px; padding:clamp(16px,2.4vw,30px); box-shadow:0 14px 35px rgba(5,80,50,.06); }
.deed-capture-page .deed-stepper { display:grid; grid-template-columns:minmax(0,1fr) auto minmax(0,1fr); align-items:center; gap:16px; margin-bottom:26px; }
.deed-capture-page .deed-stepper-item { display:flex; align-items:center; gap:16px; padding:18px 20px; background:#fff; border:1px solid var(--deed-border); border-radius:16px; transition:.2s ease; min-height:112px; }
.deed-capture-page .deed-stepper-item h5 { font-weight:700; }
.deed-capture-page .deed-stepper-item.active { background:#ffc107; border-color:#e0a800; color:#212529; box-shadow:0 10px 24px rgba(196,145,0,.2); }
.deed-capture-page .deed-stepper-item.complete { background:linear-gradient(125deg,#087b46,#12a46b); border-color:#087b46; color:#fff; box-shadow:0 10px 24px rgba(8,127,91,.17); }
.deed-capture-page .deed-stepper-item.active .text-muted { color:#493800 !important; }
.deed-capture-page .deed-stepper-item.complete .text-muted { color:#e0f8e9 !important; }
.deed-capture-page .deed-step-badge { display:inline-flex; align-items:center; justify-content:center; flex-shrink:0; width:49px; height:49px; border-radius:50%; font-weight:800; color:#664d03; background:#fff3cd; }
.deed-capture-page .deed-stepper-item.active .deed-step-badge { background:#fff; color:#664d03; }
.deed-capture-page .deed-stepper-item.complete .deed-step-badge { background:#fff; color:var(--deed-primary); }
.deed-capture-page .deed-stepper-arrow { display:inline-flex; align-items:center; justify-content:center; width:44px; height:44px; border-radius:50%; background:#fff; border:1px solid #e0a800; color:#664d03; font-size:22px; box-shadow:0 5px 13px rgba(196,145,0,.12); }
.deed-capture-page .deed-stage-card,.deed-capture-page .deed-action-card,.deed-capture-page .deed-summary-card { background:#fff; border:1px solid var(--deed-border); border-radius:17px; box-shadow:0 8px 20px rgba(4,75,57,.055); }
.deed-capture-page .deed-stage-card,.deed-capture-page .deed-summary-card { border-top:4px solid var(--deed-primary); }
.deed-capture-page .deed-action-card { height:100%; display:flex; flex-direction:column; transition:transform .2s ease,box-shadow .2s ease,border-color .2s ease; }
.deed-capture-page .deed-action-card:hover { transform:translateY(-4px); border-color:#8fcfb0; box-shadow:0 14px 26px rgba(4,75,57,.12); }
.deed-capture-page .deed-action-card p { flex-grow:1; }
.deed-capture-page .deed-icon { display:inline-flex; align-items:center; justify-content:center; width:54px; height:54px; border-radius:15px; font-size:23px; background:var(--deed-pale) !important; color:var(--deed-primary) !important; }
.deed-capture-page .deed-stage-locked { padding:20px; border-radius:15px; border:1px dashed #90c7a6; background:#f5fbf6; }
.deed-capture-page .deed-stage-ready { display:none; }
.deed-capture-page .deed-stage-ready.is-visible { display:block; }
.deed-capture-page .deed-field-label { display:block; color:#557466; font-size:12px; font-weight:700; letter-spacing:.045em; text-transform:uppercase; margin-bottom:5px; }
.deed-capture-page #deedLoadedDetails > div > .border { border-color:var(--deed-border) !important; background:#f8fcf9; border-radius:12px !important; }
.deed-capture-page #deedLoadedDetails .fw-semibold { overflow-wrap:anywhere; }
.deed-capture-page .deed-step-label { background:var(--deed-pale); color:var(--deed-primary); border:1px solid #c8e9d4; padding:7px 12px; border-radius:999px; font-weight:700; }
.deed-capture-page .btn-primary,.deed-capture-page .btn-success,.deed-capture-page .btn-warning,.deed-capture-page .btn-danger,.deed-capture-page .btn-info { background:linear-gradient(110deg,var(--deed-primary),var(--deed-bright)); color:#fff !important; border-color:var(--deed-primary); font-weight:600; }
.deed-capture-page .btn-primary:hover,.deed-capture-page .btn-success:hover,.deed-capture-page .btn-warning:hover,.deed-capture-page .btn-danger:hover,.deed-capture-page .btn-info:hover { background:var(--deed-dark); border-color:var(--deed-dark); color:#fff !important; }
.deed-capture-page .deed-action-launch.btn-primary { background:#0d6efd; border-color:#0d6efd; color:#fff !important; }
.deed-capture-page .deed-action-launch.btn-primary:hover { background:#0b5ed7; border-color:#0a58ca; color:#fff !important; }
.deed-capture-page .deed-action-launch.btn-success { background:#198754; border-color:#198754; color:#fff !important; }
.deed-capture-page .deed-action-launch.btn-success:hover { background:#157347; border-color:#146c43; color:#fff !important; }
.deed-capture-page .deed-action-launch.btn-warning { background:#ffc107; border-color:#ffc107; color:#212529 !important; }
.deed-capture-page .deed-action-launch.btn-warning:hover { background:#ffca2c; border-color:#ffc720; color:#212529 !important; }
.deed-capture-page .deed-action-launch.btn-danger { background:#dc3545; border-color:#dc3545; color:#fff !important; }
.deed-capture-page .deed-action-launch.btn-danger:hover { background:#bb2d3b; border-color:#b02a37; color:#fff !important; }
.deed-capture-page .deed-action-launch.btn-info { background:#0dcaf0; border-color:#0dcaf0; color:#212529 !important; }
.deed-capture-page .deed-action-launch.btn-info:hover { background:#31d2f2; border-color:#25cff2; color:#212529 !important; }
.deed-capture-page .deed-link-existing-job { background:#dc3545 !important; border-color:#dc3545 !important; color:#fff !important; }
.deed-capture-page .deed-link-existing-job:hover { background:#bb2d3b !important; border-color:#b02a37 !important; color:#fff !important; }
.deed-capture-page #addToBatchBtn .btn { background:#ffc107 !important; border-color:#ffc107 !important; color:#212529 !important; }
.deed-capture-page #addToBatchBtn .btn:hover { background:#ffca2c !important; border-color:#ffc720 !important; color:#212529 !important; }
.deed-capture-page .btn:focus-visible,.deed-capture-page .form-control:focus { border-color:var(--deed-bright); box-shadow:0 0 0 .2rem rgba(11,166,116,.16); }
.deed-capture-page .input-group-text { background:var(--deed-pale); color:var(--deed-primary); border-color:var(--deed-border); }
.deed-capture-page .form-control { border-color:var(--deed-border); }
.deed-capture-page #deedLookupStatus { border-color:var(--deed-border) !important; }
.deed-capture-page .deed-current-job { border-color:var(--deed-border) !important; background:#f4fbf6; }
@media(max-width:767.98px){.deed-capture-page .deed-stepper{grid-template-columns:1fr}.deed-capture-page .deed-stepper-arrow{justify-self:center;transform:rotate(90deg)}.deed-capture-page .deed-page-heading{padding:18px}.deed-capture-page .deed-stage-card,.deed-capture-page .deed-summary-card{padding:20px !important}.deed-capture-page #deedLookupButton{padding-left:12px;padding-right:12px}}
</style>

<div class="main-content app-content deed-capture-page">
    <div class="container-fluid page-container">
        <input type="hidden" id="is_deed_data_capture" value="true" />
        <input class="form-control" type="hidden" id="cs_main_case_number" name="cs_main_case_number">
        <input class="form-control" type="hidden" id="cs_main_job_number" name="cs_main_job_number">
        <input class="form-control" type="hidden" id="cs_main_business_process_id">
        <input class="form-control" type="hidden" id="cs_main_business_process_name">
        <input class="form-control" type="hidden" id="cs_main_business_process_sub_id">
        <input class="form-control" type="hidden" id="cs_main_business_process_sub_name">
        <input class="form-control" type="hidden" id="cs_main_client_number">
        <input class="form-control" type="hidden" id="cs_main_transaction_number" name="cs_main_transaction_number">

        <div class="page-header-breadcrumb deed-page-heading mb-4">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                <div>
                    <h1 class="page-title fw-bold fs-20 mb-2"><i class="bi bi-file-earmark-text me-2"></i>Deed Data Capture</h1>
                    <p class="mb-0"><i class="ri-information-line me-1"></i>Verify a job, create it when missing, then complete document, party and further entry work.</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Deed Data Capture</li>
                </ol>
            </div>
        </div>

        <div class="deed-step-shell">
            <div class="deed-stepper">
                <div class="deed-stepper-item active" id="deedStepOneIndicator">
                    <span class="deed-step-badge">1</span>
                    <div><h5 class="mb-1">Verify Job Number</h5><p class="text-muted small mb-0">Search the application by job number and create it if it does not exist.</p></div>
                </div>
                <div class="deed-stepper-arrow" aria-hidden="true"><i class="bi bi-arrow-right"></i></div>
                <div class="deed-stepper-item" id="deedStepTwoIndicator">
                    <span class="deed-step-badge">2</span>
                    <div><h5 class="mb-1">Continue Data Capture</h5><p class="text-muted small mb-0">Once loaded, continue with documents, parties and further entry details.</p></div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-xl-6">
                    <div class="deed-stage-card h-100 p-4">
                        <div class="d-flex align-items-start justify-content-between flex-wrap gap-3 mb-4">
                            <div><span class="deed-step-label">Step 1 · Verification</span><h4 class="mt-3 mb-1">Search Existing Application</h4><p class="text-muted mb-0">Enter the job number to check whether the deed application already exists.</p></div>
                            <div class="deed-icon"><i class="bi bi-search"></i></div>
                        </div>
                        <form id="deedJobLookupForm" novalidate>
                            <div class="mb-3">
                                <label for="deed_job_number" class="form-label fw-semibold">Job Number</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-hash"></i></span>
                                    <input type="text" class="form-control" id="deed_job_number" placeholder="Enter job number" autocomplete="off" required>
                                    <button class="btn btn-primary" type="submit" id="deedLookupButton"><i class="bi bi-search me-1"></i>Check Job</button>
                                </div>
                                <div class="form-text">If the application is missing, the existing-job modal will open so you can create it immediately.</div>
                            </div>
                        </form>
                        <div class="alert alert-light border d-none mb-3" id="deedLookupStatus"></div>
                        <!-- Optional existing-job creation prompt; kept inactive as in the original page.
                        <div class="deed-stage-locked" id="deedCreationPrompt">
                            <div class="d-flex align-items-start gap-3">
                                <div class="deed-icon"><i class="bi bi-folder-plus"></i></div>
                                <div class="flex-grow-1"><h6 class="mb-1">Application not found?</h6><p class="text-muted small mb-3">Use the existing-job modal to create the deed application.</p>
                                    <button type="button" class="btn btn-success" id="deedCreateMissingJobButton" data-bs-toggle="modal" data-bs-target="#CreateJobNumberModalExisting"><i class="bi bi-plus-circle me-1"></i>Create Missing Job</button>
                                </div>
                            </div>
                        </div> -->
                    </div>
                </div>

                <div class="col-xl-6">
                    <div class="deed-summary-card h-100 p-4">
                        <div class="d-flex align-items-start justify-content-between flex-wrap gap-3 mb-4">
                            <div><span class="deed-step-label">Loaded Job</span><h4 class="mt-3 mb-1">Application Snapshot</h4><p class="text-muted mb-0">This panel updates as soon as a valid application is loaded into deed data capture.</p></div>
                            <div class="deed-icon"><i class="bi bi-file-earmark-check"></i></div>
                        </div>
                        <div class="row g-3" id="deedLoadedDetails">
                            <div class="col-md-6"><div class="border rounded-3 p-3 h-100"><span class="deed-field-label">Job Number</span><div class="fw-semibold" id="deedLoadedJobNumber">Not loaded yet</div></div></div>
                            <div class="col-md-6"><div class="border rounded-3 p-3 h-100"><span class="deed-field-label">Case Number</span><div class="fw-semibold" id="deedLoadedCaseNumber">Not loaded yet</div></div></div>
                            <div class="col-md-6"><div class="border rounded-3 p-3 h-100"><span class="deed-field-label">Applicant</span><div class="fw-semibold" id="deedLoadedApplicant">Not loaded yet</div></div></div>
                            <div class="col-md-6"><div class="border rounded-3 p-3 h-100"><span class="deed-field-label">Sub Service</span><div class="fw-semibold" id="deedLoadedSubService">Not loaded yet</div></div></div>
                            <div class="col-md-6"><div class="border rounded-3 p-3 h-100"><span class="deed-field-label">Locality</span><div class="fw-semibold" id="deedLoadedLocality">Not loaded yet</div></div></div>
                            <div class="col-md-6"><div class="border rounded-3 p-3 h-100"><span class="deed-field-label">Status</span><div class="fw-semibold" id="deedLoadedStatus">Awaiting search</div></div></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="deed-stage-ready mt-4" id="deedStepTwoSection">
                <div class="deed-stage-card p-4">
                    <div class="d-flex align-items-start justify-content-between flex-wrap gap-3 mb-4">
                        <div><span class="deed-step-label">Step 2 · Data Capture</span><h4 class="mt-3 mb-1">Continue With Data Capture</h4><p class="text-muted mb-0">These are the five required deed data capture actions for the currently loaded job.</p></div>
                        <div class="text-end d-flex align-items-center gap-2"><button type="button" class="btn btn-danger deed-link-existing-job d-none" id="btnOpenDeedLinkExistingJob"><i class="bi bi-link-45deg me-1"></i>Link Existing Job</button><div id="addToBatchBtn" class="me-2"></div><div class="border rounded-3 p-2 deed-current-job"><div class="small text-muted">Current Job</div><div class="fw-semibold" id="deedCurrentJobPill">Not loaded</div></div></div>
                    </div>
                    <div class="row g-4">
                        <div class="col-xl col-lg-4 col-md-6"><div class="deed-action-card p-4"><div class="deed-icon mb-3"><i class="bi bi-file-earmark-arrow-up"></i></div><h5 class="mb-2">Upload Documents</h5><p class="text-muted small mb-4">Open the Upload Documents modal to review existing uploads and add missing application or public documents.</p><button type="button" class="btn btn-primary w-100 deed-action-launch" data-bs-toggle="modal" data-bs-target="#review_documents" data-action-name="review_documents"><i class="bi bi-folder2-open me-1"></i>Open Documents</button></div></div>
                        <div class="col-xl col-lg-4 col-md-6"><div class="deed-action-card p-4"><div class="deed-icon mb-3"><i class="bi bi-people"></i></div><h5 class="mb-2">Add/Edit Parties</h5><p class="text-muted small mb-4">Open the Add/Edit Parties modal to capture or revise grantors, applicants and other parties for this job.</p><button type="button" class="btn btn-success w-100 deed-action-launch" data-bs-toggle="modal" data-bs-target="#add_edit_parties" data-action-name="add_edit_parties"><i class="bi bi-person-lines-fill me-1"></i>Open Parties</button></div></div>
                        <div class="col-xl col-lg-4 col-md-6"><div class="deed-action-card p-4"><div class="deed-icon mb-3"><i class="bi bi-pencil-square"></i></div><h5 class="mb-2">Further Entry Details</h5><p class="text-muted small mb-4">Open the Further Entry Details modal to complete the additional deed entry details for the loaded application.</p><button type="button" class="btn btn-warning w-100 deed-action-launch" data-bs-toggle="modal" data-bs-target="#deed_further_entry" data-action-name="deed_further_entry"><i class="bi bi-journal-richtext me-1"></i>Open Further Entry</button></div></div>
                        <div class="col-xl col-lg-4 col-md-6"><div class="deed-action-card p-4"><div class="deed-icon mb-3"><i class="bi bi-pentagon"></i></div><h5 class="mb-2">Check Polygon</h5><p class="text-muted small mb-4">Open the polygon check modal to review the WKT polygon data and view it on the map.</p><button type="button" class="btn btn-danger w-100 deed-action-launch" data-bs-toggle="modal" data-bs-target="#deed_check_polygon" data-action-name="deed_check_polygon"><i class="bi bi-map me-1"></i>Open Polygon</button></div></div>
                        <div class="col-xl col-lg-4 col-md-6"><div class="deed-action-card p-4"><div class="deed-icon mb-3"><i class="bi bi-list-check"></i></div><h5 class="mb-2">Update Milestones</h5><p class="text-muted small mb-4">Open the Update Digital Workflow Milestone modal to move the loaded job to the right workflow stage.</p><button type="button" class="btn btn-info w-100 deed-action-launch" data-bs-toggle="modal" data-bs-target="#update_digital_workflow_milestone" data-action-name="update_digital_workflow_milestone"><i class="bi bi-arrow-repeat me-1"></i>Open Milestones</button></div></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deedLinkExistingJobModal" tabindex="-1" aria-labelledby="deedLinkExistingJobModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deedLinkExistingJobModalLabel"><i class="bi bi-link-45deg me-2"></i>Link Existing Job</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-info py-2"><i class="bi bi-info-circle me-1"></i>The job number or file number entered here will be used as the new job number and linked to the checked job’s case.</div>
                <div class="mb-3">
                    <label for="deedLinkedReference" class="form-label">Job Number/File Number</label>
                    <input type="text" class="form-control" id="deedLinkedReference" placeholder="Enter the existing job number or file number" autocomplete="off">
                </div>
                <div class="form-label fw-semibold">New job details</div>
                <div class="form-check border rounded p-3 mb-2">
                    <input class="form-check-input ms-0 me-2" type="radio" name="deedLinkedJobMode" id="deedLinkedJobModeDifferent" value="different" checked>
                    <label class="form-check-label" for="deedLinkedJobModeDifferent"><span class="fw-semibold">Enter different details</span><span class="d-block small text-muted">Create the new job with its own details and link it to the checked job’s case.</span></label>
                </div>
                <div class="form-check border rounded p-3">
                    <input class="form-check-input ms-0 me-2" type="radio" name="deedLinkedJobMode" id="deedLinkedJobModeCopy" value="copy">
                    <label class="form-check-label" for="deedLinkedJobModeCopy"><span class="fw-semibold">Use the checked job’s details</span><span class="d-block small text-muted">Copy its application details; keep the same case number so parties and further-entry details remain associated.</span></label>
                </div>
                <div class="alert alert-warning d-none mt-3 mb-0" id="deedLinkedJobError" role="alert"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="btnContinueDeedLinkedJob"><i class="bi bi-arrow-right-circle me-1"></i>Continue to Create Job</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deedCreateLinkedJobModal" tabindex="-1" aria-labelledby="deedCreateLinkedJobModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-danger text-white">
                <div>
                    <h5 class="modal-title mb-1" id="deedCreateLinkedJobModalLabel"><i class="bi bi-file-earmark-plus me-2"></i>Create Linked Job</h5>
                    <small class="text-white-50">The new job will use the checked job’s case number.</small>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="deed_link_main_service" class="form-label">Main Service</label>
                        <select class="form-select" id="deed_link_main_service"><option value="0">-- Select --</option></select>
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_sub_service" class="form-label">Sub Service</label>
                        <select class="form-select" id="deed_link_sub_service"><option value="0">-- Select --</option></select>
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_client_name" class="form-label">Client Name</label>
                        <input class="form-control" id="deed_link_client_name" type="text" required>
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_land_size" class="form-label">Land Size</label>
                        <input class="form-control" id="deed_link_land_size" type="text">
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_office_region" class="form-label">Office Region</label>
                        <select class="form-select" id="deed_link_office_region"><option value="0">-- Select --</option></select>
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_locality" class="form-label">Locality</label>
                        <select class="form-select" id="deed_link_locality"><option value="0">-- Select --</option></select>
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_type_of_use" class="form-label">Type of Use</label>
                        <select class="form-select" id="deed_link_type_of_use"><option value="0">-- Select --</option></select>
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_type_of_interest" class="form-label">Type of Interest</label>
                        <select class="form-select" id="deed_link_type_of_interest">
                            <option value="">-- Select --</option><option>LEASEHOLD</option><option>FREEHOLD</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_nature_of_instrument" class="form-label">Nature of Instrument</label>
                        <select class="form-select" id="deed_link_nature_of_instrument">
                            <option value="">-- Select --</option><option>Leasehold</option><option>Assignment</option><option>Sub-Lease</option><option>Conveyance</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_surveyor_number" class="form-label">Licensed Surveyor No.</label>
                        <input class="form-control" id="deed_link_surveyor_number" type="text">
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_file_number" class="form-label">File Number</label>
                        <input class="form-control" id="deed_link_file_number" type="text">
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_job_number" class="form-label">Job Number</label>
                        <input class="form-control" id="deed_link_job_number" type="text" required readonly>
                    </div>
                    <div class="col-md-6">
                        <label for="deed_link_case_number" class="form-label">Linked Case Number</label>
                        <input class="form-control" id="deed_link_case_number" type="text" readonly>
                    </div>
                </div>
                <div class="alert alert-warning d-none mt-3 mb-0" id="deedCreateLinkedJobError" role="alert"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="btnCreateDeedLinkedJob"><i class="bi bi-link-45deg me-1"></i>Create and Link Job</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../components/_gated_workflow_modal.jsp"></jsp:include>
<jsp:include page="../../components/_gated_workflow_modal_2.jsp"></jsp:include>
<jsp:include page="../../components/_gated_workflow_modal_3.jsp"></jsp:include>
