<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
    .deed-step-shell {
        background: linear-gradient(135deg, #f8fbff 0%, #eef8f2 100%);
        border: 1px solid rgba(15, 23, 42, 0.08);
        border-radius: 1.25rem;
        padding: 1.5rem;
    }

    .deed-stepper {
        display: grid;
        gap: 1rem;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        margin-bottom: 1.5rem;
    }

    .deed-stepper-item {
        align-items: center;
        background: #fff;
        border: 1px solid #dbe7f3;
        border-radius: 1rem;
        display: flex;
        gap: 1rem;
        padding: 1rem 1.1rem;
        transition: all 0.2s ease;
    }

    .deed-stepper-item.active {
        border-color: #0d6efd;
        box-shadow: 0 0.75rem 1.5rem rgba(13, 110, 253, 0.08);
    }

    .deed-stepper-item.complete {
        border-color: #198754;
        box-shadow: 0 0.75rem 1.5rem rgba(25, 135, 84, 0.08);
    }

    .deed-step-badge {
        align-items: center;
        background: #eaf2ff;
        border-radius: 999px;
        color: #0d6efd;
        display: inline-flex;
        font-size: 0.95rem;
        font-weight: 700;
        height: 3rem;
        justify-content: center;
        min-width: 3rem;
    }

    .deed-stepper-item.complete .deed-step-badge {
        background: #e7f6ec;
        color: #198754;
    }

    .deed-stepper-item.active .deed-step-badge {
        background: #0d6efd;
        color: #fff;
    }

    .deed-stage-card,
    .deed-action-card,
    .deed-summary-card {
        background: #fff;
        border: 1px solid #e5edf5;
        border-radius: 1rem;
        box-shadow: 0 0.5rem 1.25rem rgba(15, 23, 42, 0.04);
    }

    .deed-action-card {
        height: 100%;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .deed-action-card:hover {
        box-shadow: 0 1rem 2rem rgba(15, 23, 42, 0.08);
        transform: translateY(-2px);
    }

    .deed-icon {
        align-items: center;
        border-radius: 1rem;
        display: inline-flex;
        font-size: 1.2rem;
        height: 3.25rem;
        justify-content: center;
        width: 3.25rem;
    }

    .deed-stage-locked {
        background: linear-gradient(135deg, #fff8ea 0%, #fff 100%);
        border: 1px dashed #f0c36c;
        border-radius: 1rem;
        padding: 1.25rem;
    }

    .deed-stage-ready {
        display: none;
    }

    .deed-stage-ready.is-visible {
        display: block;
    }

    .deed-field-label {
        color: #64748b;
        display: block;
        font-size: 0.78rem;
        letter-spacing: 0.03em;
        margin-bottom: 0.2rem;
        text-transform: uppercase;
    }

    @media (max-width: 767.98px) {
        .deed-stepper {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="main-content app-content">
    <div class="container-fluid page-container">

        <input type="hidden" id="is_deed_data_capture" value="true" />
        <input class="form-control" type="hidden" id="cs_main_case_number" name="cs_main_case_number">
		<input class="form-control" type="hidden" id="cs_main_job_number" name="cs_main_job_number" >
        <input class="form-control" type="hidden" id="cs_main_business_process_id" >
        <input class="form-control" type="hidden" id="cs_main_business_process_name" >
        <input class="form-control" type="hidden" id="cs_main_business_process_sub_id" >
        <input class="form-control" type="hidden" id="cs_main_business_process_sub_name">
        <input class="form-control" type="hidden" id="cs_main_client_number">
        <input class="form-control" type="hidden" id="cs_main_transaction_number" name="cs_main_transaction_number">

        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Deed Data Capture</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Verify a job, create it when missing, then complete document, party and further entry work.</p>
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
                    <div>
                        <h5 class="mb-1">Verify Job Number</h5>
                        <p class="text-muted small mb-0">Search the application by job number and create it if it does not exist.</p>
                    </div>
                </div>
                <div class="deed-stepper-item" id="deedStepTwoIndicator">
                    <span class="deed-step-badge">2</span>
                    <div>
                        <h5 class="mb-1">Continue Data Capture</h5>
                        <p class="text-muted small mb-0">Once loaded, continue with documents, parties and further entry details.</p>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-xl-6">
                    <div class="deed-stage-card h-100 p-4">
                        <div class="d-flex align-items-start justify-content-between flex-wrap gap-3 mb-4">
                            <div>
                                <span class="badge bg-primary-subtle text-primary">Step 1</span>
                                <h4 class="mt-2 mb-1">Search Existing Application</h4>
                                <p class="text-muted mb-0">Enter the job number to check whether the deed application already exists.</p>
                            </div>
                            <div class="deed-icon bg-primary-subtle text-primary">
                                <i class="bi bi-search"></i>
                            </div>
                        </div>

                        <form id="deedJobLookupForm" novalidate>
                            <div class="mb-3">
                                <label for="deed_job_number" class="form-label fw-semibold">Job Number</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-hash"></i></span>
                                    <input type="text" class="form-control" id="deed_job_number" placeholder="Enter job number" autocomplete="off" required>
                                    <button class="btn btn-primary" type="submit" id="deedLookupButton">
                                        <i class="bi bi-search me-1"></i>Check Job
                                    </button>
                                </div>
                                <div class="form-text">If the application is missing, the existing-job modal will open so you can create it immediately.</div>
                            </div>
                        </form>

                        <div class="alert alert-light border d-none mb-3" id="deedLookupStatus"></div>

                        <!-- <div class="deed-stage-locked" id="deedCreationPrompt">
                            <div class="d-flex align-items-start gap-3">
                                <div class="deed-icon bg-warning-subtle text-warning">
                                    <i class="bi bi-folder-plus"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <h6 class="mb-1">Application not found?</h6>
                                    <p class="text-muted small mb-3">Use the existing-job modal to create the deed application, then we will reload the newly created job into step two.</p>
                                    <button type="button" class="btn btn-warning text-dark" id="deedCreateMissingJobButton" data-bs-toggle="modal" data-bs-target="#CreateJobNumberModalExisting">
                                        <i class="bi bi-plus-circle me-1"></i>Create Missing Job
                                    </button>
                                </div>
                            </div>
                        </div> -->
                    </div>
                </div>

                <div class="col-xl-6">
                    <div class="deed-summary-card h-100 p-4">
                        <div class="d-flex align-items-start justify-content-between flex-wrap gap-3 mb-4">
                            <div>
                                <span class="badge bg-success-subtle text-success">Loaded Job</span>
                                <h4 class="mt-2 mb-1">Application Snapshot</h4>
                                <p class="text-muted mb-0">This panel updates as soon as a valid application is loaded into deed data capture.</p>
                            </div>
                            <div class="deed-icon bg-success-subtle text-success">
                                <i class="bi bi-file-earmark-check"></i>
                            </div>
                        </div>

                        <div class="row g-3" id="deedLoadedDetails">
                            <div class="col-md-6">
                                <div class="border rounded-3 p-3 h-100">
                                    <span class="deed-field-label">Job Number</span>
                                    <div class="fw-semibold" id="deedLoadedJobNumber">Not loaded yet</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="border rounded-3 p-3 h-100">
                                    <span class="deed-field-label">Case Number</span>
                                    <div class="fw-semibold" id="deedLoadedCaseNumber">Not loaded yet</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="border rounded-3 p-3 h-100">
                                    <span class="deed-field-label">Applicant</span>
                                    <div class="fw-semibold" id="deedLoadedApplicant">Not loaded yet</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="border rounded-3 p-3 h-100">
                                    <span class="deed-field-label">Sub Service</span>
                                    <div class="fw-semibold" id="deedLoadedSubService">Not loaded yet</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="border rounded-3 p-3 h-100">
                                    <span class="deed-field-label">Locality</span>
                                    <div class="fw-semibold" id="deedLoadedLocality">Not loaded yet</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="border rounded-3 p-3 h-100">
                                    <span class="deed-field-label">Status</span>
                                    <div class="fw-semibold" id="deedLoadedStatus">Awaiting search</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="deed-stage-ready mt-4" id="deedStepTwoSection">
                <div class="deed-stage-card p-4">
                    <div class="d-flex align-items-start justify-content-between flex-wrap gap-3 mb-4">
                        <div>
                            <span class="badge bg-info-subtle text-info">Step 2</span>
                            <h4 class="mt-2 mb-1">Continue With Data Capture</h4>
                            <p class="text-muted mb-0">These are the three required deed data capture actions for the currently loaded job.</p>
                        </div>
                        <div class="text-end">
                            <div class="small text-muted">Current Job</div>
                            <div class="fw-semibold" id="deedCurrentJobPill">Not loaded</div>
                        </div>
                    </div>

                    <div class="row g-4">
                        <div class="col-lg-4">
                            <div class="deed-action-card p-4">
                                <div class="deed-icon bg-primary-subtle text-primary mb-3">
                                    <i class="bi bi-file-earmark-arrow-up"></i>
                                </div>
                                <h5 class="mb-2">Upload Documents</h5>
                                <p class="text-muted small mb-4">Open the Upload Documents modal to review existing uploads and add missing application or public documents.</p>
                                <button type="button" class="btn btn-primary w-100 deed-action-launch" data-bs-toggle="modal" data-bs-target="#review_documents" data-action-name="review_documents">
                                    <i class="bi bi-folder2-open me-1"></i>Open Documents
                                </button>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="deed-action-card p-4">
                                <div class="deed-icon bg-success-subtle text-success mb-3">
                                    <i class="bi bi-people"></i>
                                </div>
                                <h5 class="mb-2">Add/Edit Parties</h5>
                                <p class="text-muted small mb-4">Open the Add/Edit Parties modal to capture or revise grantors, applicants and other parties for this job.</p>
                                <button type="button" class="btn btn-success w-100 deed-action-launch" data-bs-toggle="modal" data-bs-target="#add_edit_parties" data-action-name="add_edit_parties">
                                    <i class="bi bi-person-lines-fill me-1"></i>Open Parties
                                </button>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="deed-action-card p-4">
                                <div class="deed-icon bg-warning-subtle text-warning mb-3">
                                    <i class="bi bi-pencil-square"></i>
                                </div>
                                <h5 class="mb-2">Further Entry Details</h5>
                                <p class="text-muted small mb-4">Open the Further Entry Details modal to complete the additional deed entry details for the loaded application.</p>
                                <button type="button" class="btn btn-warning text-dark w-100 deed-action-launch" data-bs-toggle="modal" data-bs-target="#further_entry" data-action-name="further_entry">
                                    <i class="bi bi-journal-richtext me-1"></i>Open Further Entry
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../components/_gated_workflow_modal.jsp"></jsp:include>
<jsp:include page="../../components/_gated_workflow_modal_2.jsp"></jsp:include>
