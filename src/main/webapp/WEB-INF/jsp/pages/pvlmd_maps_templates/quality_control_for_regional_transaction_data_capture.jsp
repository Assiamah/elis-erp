<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="main-content app-content">
    <div class="container-fluid">
        <!-- Page Header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Quality Control - Regional PVLMD Transactions</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">PVLMD</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Quality Control</li>
                </ol>
            </div>
        </div>

        <!-- Transactions Table -->
        <div class="card custom-card">
            <div class="card-header justify-content-between">
                <div class="d-flex align-items-center gap-2">
                    <div class="card-title mb-0">Transactions Pending Approval</div>
                </div>
                <div>
                    <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#updateRecordsModal">
                        <i class="ri-edit-line me-1"></i> Update Records
                    </button>
                    <button type="button" class="btn btn-success btn-sm" id="btn_batch_approve_selected" disabled>
                        <i class="ri-checkbox-multiple-line me-1"></i> Approve Selected
                        <span class="badge bg-light text-success ms-1" id="selected_qc_count">0</span>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-sm align-middle datatable" id="qc_transactions_table" width="100%">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 40px;" class="text-center">
                                    <input type="checkbox" class="form-check-input" id="select_all_qc_records">
                                </th>
                                <th>ID</th>
                                <th>Reference Number</th>
                                <th>Jacket Name</th>
                                <th>Instrument Type</th>
                                <th>Party 1</th>
                                <th>Party 2</th>
                                <th>Entered By</th>
                                <th>Created Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    #qc_transactions_table {
        table-layout: fixed;
        width: 100% !important;
    }

    #qc_transactions_table th,
    #qc_transactions_table td {
        vertical-align: middle;
    }

    #qc_transactions_table .qc-cell-clip {
        display: block;
        max-width: 100%;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    #qc_transactions_table .qc-actions {
        display: inline-flex;
        gap: 0.25rem;
        white-space: nowrap;
    }

    #qc_transactions_table .qc-actions .btn {
        height: 30px;
        width: 32px;
        padding: 0;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }
</style>

<!-- Review Transaction Modal -->
<div class="modal fade" id="reviewTransactionModal" tabindex="-1" aria-labelledby="reviewTransactionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xxl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-warning text-dark">
                <h5 class="modal-title" id="reviewTransactionModalLabel">
                    <i class="ri-eye-line me-2"></i>Review Transaction for Quality Control
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="review_transaction_id">
                
                <!-- Transaction Details Display -->
                <div class="card mb-3 border-warning">
                    <div class="card-header bg-warning-subtle">
                        <h6 class="mb-0"><i class="ri-information-line me-2"></i>Transaction Information</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3" id="review_transaction_details">
                            <!-- Will be populated dynamically -->
                        </div>
                    </div>
                </div>

                <!-- Quality Control Checklist -->
                <div class="card mb-3">
                    <div class="card-header bg-light">
                        <h6 class="mb-0"><i class="ri-task-line me-2"></i>Quality Control Checklist</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="qc_check_1">
                                    <label class="form-check-label" for="qc_check_1">
                                        All required fields are completed
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="qc_check_2">
                                    <label class="form-check-label" for="qc_check_2">
                                        Reference number format is correct
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="qc_check_3">
                                    <label class="form-check-label" for="qc_check_3">
                                        Party information is complete and valid
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="qc_check_4">
                                    <label class="form-check-label" for="qc_check_4">
                                        Financial details are accurate
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="qc_check_5">
                                    <label class="form-check-label" for="qc_check_5">
                                        Document dates are valid
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="qc_check_6">
                                    <label class="form-check-label" for="qc_check_6">
                                        Instrument type is appropriate
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="qc_check_7">
                                    <label class="form-check-label" for="qc_check_7">
                                        Remarks are clear and adequate
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="qc_check_8">
                                    <label class="form-check-label" for="qc_check_8">
                                        No duplicate entries detected
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="qc_check_9">
                                    <label class="form-check-label" for="qc_check_9">
                                        Data consistency verified
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Review Notes -->
                <div class="card mb-3">
                    <div class="card-header bg-light">
                        <h6 class="mb-0"><i class="ri-sticky-note-line me-2"></i>Review Notes</h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="review_note" class="form-label">Review Comments/Notes</label>
                            <textarea class="form-control" id="review_note" rows="3" placeholder="Enter your review comments here..."></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="approve_note" class="form-label">Approval Note (if approving)</label>
                            <textarea class="form-control" id="approve_note" rows="2" placeholder="Optional approval note..."></textarea>
                        </div>
                        <div>
                            <label for="decline_note" class="form-label">Decline Reason (if declining)</label>
                            <textarea class="form-control" id="decline_note" rows="2" placeholder="Required if declining - explain why..."></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i> Close
                </button>
                <button type="button" class="btn btn-warning" id="btn_mark_under_review">
                    <i class="ri-eye-line me-1"></i> Mark Under Review
                </button>
                <button type="button" class="btn btn-danger" id="btn_decline_transaction">
                    <i class="ri-close-circle-line me-1"></i> Decline
                </button>
                <button type="button" class="btn btn-success" id="btn_approve_transaction">
                    <i class="ri-checkbox-circle-line me-1"></i> Approve
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Batch Approval Modal -->
<div class="modal fade" id="batchApprovalModal" tabindex="-1" aria-labelledby="batchApprovalModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="batchApprovalModalLabel">
                    <i class="ri-checkbox-multiple-line me-2"></i>Batch Approval
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-info">
                    <i class="ri-information-line me-2"></i>
                    You are about to approve multiple transactions. Please confirm your action.
                </div>
                <div class="mb-3">
                    <label for="batch_approval_note" class="form-label">Batch Approval Note</label>
                    <textarea class="form-control" id="batch_approval_note" rows="3" placeholder="Enter a note for this batch approval..."></textarea>
                </div>
                <div id="batch_transactions_list">
                    <!-- Selected transactions will be listed here -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-success" id="btn_confirm_batch_approve">
                    <i class="ri-checkbox-circle-line me-1"></i> Confirm Batch Approval
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Update Records Modal -->
<div class="modal fade" id="updateRecordsModal" tabindex="-1" aria-labelledby="updateRecordsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="updateRecordsModalLabel">
                    <i class="ri-edit-line me-2"></i>Update Transaction Records
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Search Section -->
                <div class="card mb-3 border-success">
                    <div class="card-header bg-primary-subtle">
                        <h6 class="mb-0"><i class="ri-search-line me-2"></i>Search for Transaction</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-8">
                                <label for="update_search_reference" class="form-label">Search Transactions</label>
                                <input type="text" class="form-control" id="update_search_reference" placeholder="Enter a keyword">
                            </div>
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="button" class="btn btn-primary w-100" id="btn_search_update_record">
                                    <i class="ri-search-line me-1"></i> Search
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Transaction Details Form (Readonly except deed and serial) -->
                <div id="update_record_form_section" style="display: none;">
                    <input type="hidden" id="update_t_id">
                    
                    <!-- Basic Information -->
                    <div class="card mb-3">
                        <div class="card-header bg-light">
                            <h6 class="mb-0"><i class="ri-information-line me-2"></i>Basic Information</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="update_region" class="form-label">Region</label>
                                    <input type="text" class="form-control bg-light" id="update_region" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_reference_number" class="form-label">Reference Number</label>
                                    <input type="text" class="form-control bg-light" id="update_reference_number" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_file_number" class="form-label">File Number</label>
                                    <input type="text" class="form-control bg-light" id="update_file_number" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_property_number" class="form-label">Property Number</label>
                                    <input type="text" class="form-control bg-light" id="update_property_number" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_jacket_name" class="form-label">Jacket Name</label>
                                    <input type="text" class="form-control bg-light" id="update_jacket_name" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_submission_date" class="form-label">Submission Date</label>
                                    <input type="text" class="form-control bg-light" id="update_submission_date" readonly style="cursor: not-allowed;">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Document Details -->
                    <div class="card mb-3">
                        <div class="card-header bg-light">
                            <h6 class="mb-0"><i class="ri-file-text-line me-2"></i>Document Details</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="update_mutation_number" class="form-label">Mutation Number</label>
                                    <input type="text" class="form-control bg-light" id="update_mutation_number" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_deed_number" class="form-label">Deed Number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control border-primary" id="update_deed_number" placeholder="Enter deed number" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="update_serial_number" class="form-label">Serial Number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control border-primary" id="update_serial_number" placeholder="Enter serial number" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="update_sheet_number" class="form-label">Sheet Number</label>
                                    <input type="text" class="form-control bg-light" id="update_sheet_number" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_plan_number" class="form-label">Plan Number</label>
                                    <input type="text" class="form-control bg-light" id="update_plan_number" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_plot_number" class="form-label">Plot Number</label>
                                    <input type="text" class="form-control bg-light" id="update_plot_number" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_lvb_number" class="form-label">LVB Number</label>
                                    <input type="text" class="form-control bg-light" id="update_lvb_number" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_instrument_date" class="form-label">Instrument Date</label>
                                    <input type="text" class="form-control bg-light" id="update_instrument_date" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_instrument_type" class="form-label">Instrument Type</label>
                                    <input type="text" class="form-control bg-light" id="update_instrument_type" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_doc_number" class="form-label">Document Number</label>
                                    <input type="text" class="form-control bg-light" id="update_doc_number" readonly style="cursor: not-allowed;">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Parties Information -->
                    <div class="card mb-3">
                        <div class="card-header bg-light">
                            <h6 class="mb-0"><i class="ri-user-line me-2"></i>Parties Information</h6>
                        </div>
                        <div class="card-body">
                            <h6 class="mb-3 text-primary">Party 1 (Plaintiff/Grantor)</h6>
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label for="update_party1_plaintiff" class="form-label">Name</label>
                                    <input type="text" class="form-control bg-light" id="update_party1_plaintiff" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-3">
                                    <label for="update_party1_plaintiff_tel_no" class="form-label">Phone Number</label>
                                    <input type="text" class="form-control bg-light" id="update_party1_plaintiff_tel_no" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-3">
                                    <label for="update_party1_plaintiff_email" class="form-label">Email</label>
                                    <input type="text" class="form-control bg-light" id="update_party1_plaintiff_email" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-12">
                                    <label for="update_party1_plantiff_add" class="form-label">Address</label>
                                    <textarea class="form-control bg-light" id="update_party1_plantiff_add" rows="2" readonly style="cursor: not-allowed;"></textarea>
                                </div>
                            </div>

                            <h6 class="mb-3 text-primary">Party 2 (Defendant/Grantee)</h6>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="update_party2_defendant" class="form-label">Name</label>
                                    <input type="text" class="form-control bg-light" id="update_party2_defendant" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-3">
                                    <label for="update_party2_defendant_tel_no" class="form-label">Phone Number</label>
                                    <input type="text" class="form-control bg-light" id="update_party2_defendant_tel_no" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-3">
                                    <label for="update_party2_defendant_email" class="form-label">Email</label>
                                    <input type="text" class="form-control bg-light" id="update_party2_defendant_email" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-12">
                                    <label for="update_party2_defendant_add" class="form-label">Address</label>
                                    <textarea class="form-control bg-light" id="update_party2_defendant_add" rows="2" readonly style="cursor: not-allowed;"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Financial Details -->
                    <div class="card mb-3">
                        <div class="card-header bg-light">
                            <h6 class="mb-0"><i class="ri-money-dollar-circle-line me-2"></i>Financial Details</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="update_consideration" class="form-label">Consideration Amount</label>
                                    <input type="text" class="form-control bg-light" id="update_consideration" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_consideration_currency" class="form-label">Currency</label>
                                    <input type="text" class="form-control bg-light" id="update_consideration_currency" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_premium" class="form-label">Premium Amount</label>
                                    <input type="text" class="form-control bg-light" id="update_premium" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_premium_currency" class="form-label">Premium Currency</label>
                                    <input type="text" class="form-control bg-light" id="update_premium_currency" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_rent" class="form-label">Rent</label>
                                    <input type="text" class="form-control bg-light" id="update_rent" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_compensation_status" class="form-label">Compensation Status</label>
                                    <input type="text" class="form-control bg-light" id="update_compensation_status" readonly style="cursor: not-allowed;">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Details -->
                    <div class="card mb-3">
                        <div class="card-header bg-light">
                            <h6 class="mb-0"><i class="ri-settings-3-line me-2"></i>Additional Details</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="update_term" class="form-label">Term</label>
                                    <input type="text" class="form-control bg-light" id="update_term" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_commencement_date" class="form-label">Commencement Date</label>
                                    <input type="text" class="form-control bg-light" id="update_commencement_date" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_purpose" class="form-label">Purpose</label>
                                    <input type="text" class="form-control bg-light" id="update_purpose" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_entered_date" class="form-label">Entered Date</label>
                                    <input type="text" class="form-control bg-light" id="update_entered_date" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_consent_date" class="form-label">Consent Date</label>
                                    <input type="text" class="form-control bg-light" id="update_consent_date" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_suit_number" class="form-label">Suit Number</label>
                                    <input type="text" class="form-control bg-light" id="update_suit_number" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_judgement_in_favour_of" class="form-label">Judgement In Favour Of</label>
                                    <input type="text" class="form-control bg-light" id="update_judgement_in_favour_of" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_floor_level" class="form-label">Floor Level</label>
                                    <input type="text" class="form-control bg-light" id="update_floor_level" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="update_apartment_number" class="form-label">Apartment Number</label>
                                    <input type="text" class="form-control bg-light" id="update_apartment_number" readonly style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-12">
                                    <label for="update_remarks" class="form-label">Remarks</label>
                                    <textarea class="form-control bg-light" id="update_remarks" rows="3" readonly style="cursor: not-allowed;"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- No Results Message -->
                <div id="update_no_results" class="alert alert-warning" style="display: none;">
                    <i class="ri-error-warning-line me-2"></i>No transaction found matching your search criteria.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i> Close
                </button>
                <button type="button" class="btn btn-primary" id="btn_save_updated_record" style="display: none;">
                    <i class="ri-save-line me-1"></i> Save Changes
                </button>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js-pages/quality_control_for_regional_transaction_data_capture.js"></script>
