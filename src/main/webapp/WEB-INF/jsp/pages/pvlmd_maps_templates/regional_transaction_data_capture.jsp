<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="main-content app-content">
    <div class="container-fluid">
        <!-- Page Header -->
        <!-- <div class="d-md-flex d-block align-items-center justify-content-between my-4 page-header-breadcrumb">
            <div>
                <h1 class="page-title fw-semibold fs-18 mb-0">Regional PVLMD Transaction Data Capture</h1>
                <nav>
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="javascript:void(0);">PVLMD</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Data Capture</li>
                    </ol>
                </nav>
            </div>
            
        </div> -->

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Regional PVLMD Transaction Data Capture</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">PVLMD</a></li>
                    <li class="breadcrumb-item active" aria-current="page">AData Capture</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <!-- Transactions Table -->
        <div class="card custom-card">
            <div class="card-header justify-content-between">
                <div class="card-title">Regional PVLMD Transactions</div>
                <button type="button" class="btn btn-primary btn-sm" id="btn_add_new_transaction">
                    <i class="ri-add-line me-1"></i> Add New Transaction
                </button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered datatable" id="regional_transactions_table" width="100%">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Reference Number</th>
                                <th>Jacket Name</th>
                                <th>File Number</th>
                                <th>Instrument Type</th>
                                <th>Instrument Date</th>
                                <th>Party 1 (Plaintiff)</th>
                                <th>Party 2 (Defendant)</th>
                                <th>Status</th>
                                <th>Created Date</th>
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

<!-- Add/Edit Transaction Modal -->
<div class="modal fade" id="transactionModal" tabindex="-1" aria-labelledby="transactionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="transactionModalLabel">
                    <i class="ri-add-circle-line me-2"></i>Add New Transaction
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="transactionForm">
                    <input type="hidden" id="transaction_id" name="transaction_id">
                    
                    <!-- Basic Information -->
                    <div class="card mb-3">
                        <div class="card-header bg-light">
                            <h6 class="mb-0"><i class="ri-information-line me-2"></i>Basic Information</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="region" class="form-label">Region <span class="text-danger">*</span></label>
                                    <!-- <select class="form-select" id="region" name="region" required>
                                        <option value="">Select Region</option>
                                        <option value="Greater Accra">Greater Accra</option>
                                        <option value="Ashanti">Ashanti</option>
                                        <option value="Western">Western</option>
                                        <option value="Eastern">Eastern</option>
                                        <option value="Central">Central</option>
                                        <option value="Volta">Volta</option>
                                        <option value="Northern">Northern</option>
                                        <option value="Upper East">Upper East</option>
                                        <option value="Upper West">Upper West</option>
                                        <option value="Brong Ahafo">Brong Ahafo</option>
                                    </select> -->
                                     <input type="text" class="form-control bg-light" id="region" name="region" value="${region_name}" readonly required style="cursor: not-allowed;">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_reference_number" class="form-label">Reference Number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="reg_txn_reference_number" name="reference_number" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_file_number" class="form-label">File Number</label>
                                    <input type="text" class="form-control" id="reg_txn_file_number" name="file_number">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_property_number" class="form-label">Property Number</label>
                                    <input type="text" class="form-control" id="reg_txn_property_number" name="property_number">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_jacket_name" class="form-label">Jacket Name </label>
                                    <input type="text" class="form-control" id="reg_txn_jacket_name" name="jacket_name">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_submission_date" class="form-label">Submission Date</label>
                                    <input type="date" class="form-control" id="reg_txn_submission_date" name="submission_date">
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
                                    <label for="reg_txn_mutation_number" class="form-label">Mutation Number</label>
                                    <input type="text" class="form-control" id="reg_txn_mutation_number" name="mutation_number">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_deed_number" class="form-label">Deed Number</label>
                                    <input type="text" class="form-control" id="reg_txn_deed_number" name="deed_number">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_serial_number" class="form-label">Serial Number</label>
                                    <input type="text" class="form-control" id="reg_txn_serial_number" name="serial_number">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_sheet_number" class="form-label">Sheet Number</label>
                                    <input type="text" class="form-control" id="reg_txn_sheet_number" name="sheet_number">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_plan_number" class="form-label">Plan Number</label>
                                    <input type="text" class="form-control" id="reg_txn_plan_number" name="plan_number">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_plot_number" class="form-label">Plot Number</label>
                                    <input type="text" class="form-control" id="reg_txn_plot_number" name="plot_number">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_lvb_number" class="form-label">LVB Number</label>
                                    <input type="text" class="form-control" id="reg_txn_lvb_number" name="lvb_number">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_instrument_date" class="form-label">Instrument Date</label>
                                    <input type="date" class="form-control" id="reg_txn_instrument_date" name="instrument_date">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_instrument_type" class="form-label">Instrument Type <span class="text-danger">*</span></label>
                                    <select class="form-select" id="reg_txn_instrument_type" name="instrument_type" required>
                                        <option value="">Select Type</option>
                                        <option value="Lease">Lease</option>
                                        <option value="Assignment">Assignment</option>
                                        <option value="Mortgage">Mortgage</option>
                                        <option value="Sublease">Sublease</option>
                                        <option value="Power of Attorney">Power of Attorney</option>
                                         <option value="Conveyance">Conveyance</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_doc_number" class="form-label">Document Number</label>
                                    <input type="text" class="form-control" id="reg_txn_doc_number" name="doc_number">
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
                                    <label for="reg_txn_party1_plaintiff" class="form-label">Name</label>
                                    <input type="text" class="form-control" id="reg_txn_party1_plaintiff" name="party1_plaintiff">
                                </div>
                                <div class="col-md-3">
                                    <label for="reg_txn_party1_plaintiff_tel_no" class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" id="reg_txn_party1_plaintiff_tel_no" name="party1_plaintiff_tel_no">
                                </div>
                                <div class="col-md-3">
                                    <label for="reg_txn_party1_plaintiff_email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="reg_txn_party1_plaintiff_email" name="party1_plaintiff_email">
                                </div>
                                <div class="col-md-12">
                                    <label for="reg_txn_party1_plantiff_add" class="form-label">Address</label>
                                    <textarea class="form-control" id="reg_txn_party1_plantiff_add" name="party1_plantiff_add" rows="2"></textarea>
                                </div>
                            </div>

                            <h6 class="mb-3 text-primary">Party 2 (Defendant/Grantee)</h6>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="reg_txn_party2_defendant" class="form-label">Name</label>
                                    <input type="text" class="form-control" id="reg_txn_party2_defendant" name="party2_defendant">
                                </div>
                                <div class="col-md-3">
                                    <label for="reg_txn_party2_defendant_tel_no" class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" id="reg_txn_party2_defendant_tel_no" name="party2_defendant_tel_no">
                                </div>
                                <div class="col-md-3">
                                    <label for="reg_txn_party2_defendant_email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="reg_txn_party2_defendant_email" name="party2_defendant_email">
                                </div>
                                <div class="col-md-12">
                                    <label for="reg_txn_party2_defendant_add" class="form-label">Address</label>
                                    <textarea class="form-control" id="reg_txn_party2_defendant_add" name="party2_defendant_add" rows="2"></textarea>
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
                                    <label for="reg_txn_consideration" class="form-label">Consideration Amount</label>
                                    <input type="number" step="0.01" class="form-control" id="reg_txn_consideration" name="consideration">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_consideration_currency" class="form-label">Currency</label>
                                    <select class="form-select" id="reg_txn_consideration_currency" name="consideration_currency">
                                        <option value="GHS">GHS</option>
                                        <option value="USD">USD</option>
                                        <option value="EUR">EUR</option>
                                        <option value="GBP">GBP</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_premium" class="form-label">Premium Amount</label>
                                    <input type="number" step="0.01" class="form-control" id="reg_txn_premium" name="premium">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_premium_currency" class="form-label">Premium Currency</label>
                                    <select class="form-select" id="reg_txn_premium_currency" name="premium_currency">
                                        <option value="GHS">GHS</option>
                                        <option value="USD">USD</option>
                                        <option value="EUR">EUR</option>
                                        <option value="GBP">GBP</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_rent" class="form-label">Rent</label>
                                    <input type="text" class="form-control" id="reg_txn_rent" name="rent">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_compensation_status" class="form-label">Compensation Status</label>
                                    <select class="form-select" id="reg_txn_compensation_status" name="compensation_status">
                                        <option value="">Select Status</option>
                                        <option value="Paid">Paid</option>
                                        <option value="Pending">Pending</option>
                                        <option value="Not Applicable">Not Applicable</option>
                                    </select>
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
                                    <label for="reg_txn_term" class="form-label">Term</label>
                                    <input type="text" class="form-control" id="reg_txn_term" name="term">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_commencement_date" class="form-label">Commencement Date</label>
                                    <input type="date" class="form-control" id="reg_txn_commencement_date" name="commencement_date">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_purpose" class="form-label">Purpose</label>
                                    <input type="text" class="form-control" id="reg_txn_purpose" name="purpose">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_entered_date" class="form-label">Entered Date</label>
                                    <input type="date" class="form-control" id="reg_txn_entered_date" name="entered_date">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_consent_date" class="form-label">Consent Date</label>
                                    <input type="date" class="form-control" id="reg_txn_consent_date" name="consent_date">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_suit_number" class="form-label">Suit Number</label>
                                    <input type="text" class="form-control" id="reg_txn_suit_number" name="suit_number">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_judgement_in_favour_of" class="form-label">Judgement In Favour Of</label>
                                    <input type="text" class="form-control" id="reg_txn_judgement_in_favour_of" name="judgement_in_favour_of">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_floor_level" class="form-label">Floor Level</label>
                                    <input type="text" class="form-control" id="reg_txn_floor_level" name="floor_level">
                                </div>
                                <div class="col-md-4">
                                    <label for="reg_txn_apartment_number" class="form-label">Apartment Number</label>
                                    <input type="text" class="form-control" id="reg_txn_apartment_number" name="apartment_number">
                                </div>
                                <!-- <div class="col-md-4">
                                    <label for="unit_description" class="form-label">Unit Description</label>
                                    <input type="text" class="form-control" id="unit_description" name="unit_description">
                                </div>
                                <div class="col-md-4">
                                    <label for="hqfile_id" class="form-label">HQ File ID</label>
                                    <input type="text" class="form-control" id="hqfile_id" name="hqfile_id">
                                </div>
                                <div class="col-md-4">
                                    <label for="gid_unique_across" class="form-label">GID Unique Across</label>
                                    <input type="text" class="form-control" id="gid_unique_across" name="gid_unique_across">
                                </div> -->
                                <div class="col-md-12">
                                    <label for="reg_txn_remarks" class="form-label">Remarks</label>
                                    <textarea class="form-control" id="reg_txn_remarks" name="remarks" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i> Cancel
                </button>
                <button type="button" class="btn btn-primary" id="btn_save_transaction">
                    <i class="ri-save-line me-1"></i> Save Transaction
                </button>
            </div>
        </div>
    </div>
</div>

<!-- View Transaction Modal -->
<div class="modal fade" id="viewTransactionModal" tabindex="-1" aria-labelledby="viewTransactionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-gradient-primary text-white">
                <h5 class="modal-title" id="viewTransactionModalLabel">
                    <i class="ri-file-text-line me-2"></i>Transaction Details
                </h5>
                <div>
                    <button type="button" class="btn btn-sm btn-light me-2" onclick="printTransactionDetails()" title="Print">
                        <i class="ri-printer-line"></i> Print
                    </button>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            <div class="modal-body p-4" id="viewTransactionContent">
                <!-- Content will be loaded dynamically -->
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js-pages/regional_transaction_data_capture.js"></script>
