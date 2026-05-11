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
                <div class="card-title">Transactions Pending Approval</div>
                <button type="button" class="btn btn-success btn-sm" id="btn_batch_approve_selected" disabled>
                    <i class="ri-checkbox-multiple-line me-1"></i> Approve Selected
                    <span class="badge bg-light text-success ms-1" id="selected_qc_count">0</span>
                </button>
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

<script src="${pageContext.request.contextPath}/js-pages/quality_control_for_regional_transaction_data_capture.js"></script>
