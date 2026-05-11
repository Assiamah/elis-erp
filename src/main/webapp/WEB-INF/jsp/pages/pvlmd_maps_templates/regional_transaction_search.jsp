<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="main-content app-content">
    <div class="container-fluid">
        <!-- Page Header -->
        <div class="d-md-flex d-block align-items-center justify-content-between my-4 page-header-breadcrumb">
            <div>
                <h1 class="page-title fw-semibold fs-18 mb-0">Regional PVLMD Transaction Search</h1>
                <nav>
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="javascript:void(0);">PVLMD</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Transaction Search</li>
                    </ol>
                </nav>
            </div>
            <div class="btn-list mt-3 mt-md-0">
                <button type="button" class="btn btn-success btn-icon" id="btn_export_search_results">
                    <i class="ri-download-line"></i> Export Results
                </button>
            </div>
        </div>

        <!-- Advanced Search Section -->
        <div class="card custom-card mb-4">
            <div class="card-header">
                <div class="card-title">Advanced Search</div>
            </div>
            <div class="card-body">
                <form id="advancedSearchForm">
                    <div class="row g-3">
                        <!-- Basic Search Fields -->
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_reference" class="form-label">Reference Number</label>
                            <input type="text" class="form-control" id="adv_search_reference" placeholder="Enter reference number">
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_file_number" class="form-label">File Number</label>
                            <input type="text" class="form-control" id="adv_search_file_number" placeholder="Enter file number">
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_jacket_name" class="form-label">Jacket Name</label>
                            <input type="text" class="form-control" id="adv_search_jacket_name" placeholder="Enter jacket name">
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_plan_number" class="form-label">Plan Number</label>
                            <input type="text" class="form-control" id="adv_search_plan_number" placeholder="Enter plan number">
                        </div>

                        <!-- Party Information -->
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_party1" class="form-label">Party 1 (Plaintiff)</label>
                            <input type="text" class="form-control" id="adv_search_party1" placeholder="Search by plaintiff name">
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_party2" class="form-label">Party 2 (Defendant)</label>
                            <input type="text" class="form-control" id="adv_search_party2" placeholder="Search by defendant name">
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_instrument_type" class="form-label">Instrument Type</label>
                            <select class="form-select" id="adv_search_instrument_type">
                                <option value="">All Types</option>
                                <option value="Lease">Lease</option>
                                <option value="Assignment">Assignment</option>
                                <option value="Mortgage">Mortgage</option>
                                <option value="Sublease">Sublease</option>
                                <option value="Power of Attorney">Power of Attorney</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_region" class="form-label">Region</label>
                            <select class="form-select" id="adv_search_region">
                                <option value="">All Regions</option>
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
                            </select>
                        </div>

                        <!-- Date Range -->
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_date_from" class="form-label">Date From</label>
                            <input type="date" class="form-control" id="adv_search_date_from">
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_date_to" class="form-label">Date To</label>
                            <input type="date" class="form-control" id="adv_search_date_to">
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_status" class="form-label">Status</label>
                            <select class="form-select" id="adv_search_status">
                                <option value="">All Status</option>
                                <option value="approved">Approved</option>
                                <option value="pending">Pending</option>
                                <option value="rejected">Rejected</option>
                            </select>
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <label for="adv_search_qc_status" class="form-label">QC Status</label>
                            <select class="form-select" id="adv_search_qc_status">
                                <option value="">All</option>
                                <option value="true">QC Approved</option>
                                <option value="false">Not QC Approved</option>
                            </select>
                        </div>

                        <!-- Action Buttons -->
                        <div class="col-xl-12">
                            <div class="d-flex gap-2 flex-wrap">
                                <button type="button" class="btn btn-primary" id="btn_advanced_search">
                                    <i class="ri-search-line me-1"></i> Search
                                </button>
                                <button type="button" class="btn btn-secondary" id="btn_reset_advanced_search">
                                    <i class="ri-refresh-line me-1"></i> Reset
                                </button>
                                <button type="button" class="btn btn-info" id="btn_save_search_criteria">
                                    <i class="ri-save-line me-1"></i> Save Criteria
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="row mb-4">
            <div class="col-xl-2 col-lg-4 col-md-6">
                <div class="card custom-card overflow-hidden">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-sm bg-primary-transparent me-3">
                                <i class="ri-database-2-line fs-4 text-primary"></i>
                            </div>
                            <div>
                                <p class="text-muted mb-0 small">Total Records</p>
                                <h5 class="mb-0 fw-semibold" id="stat_total_records">0</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-2 col-lg-4 col-md-6">
                <div class="card custom-card overflow-hidden">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-sm bg-success-transparent me-3">
                                <i class="ri-checkbox-circle-line fs-4 text-success"></i>
                            </div>
                            <div>
                                <p class="text-muted mb-0 small">Approved</p>
                                <h5 class="mb-0 fw-semibold" id="stat_approved_count">0</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-2 col-lg-4 col-md-6">
                <div class="card custom-card overflow-hidden">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-sm bg-warning-transparent me-3">
                                <i class="ri-time-line fs-4 text-warning"></i>
                            </div>
                            <div>
                                <p class="text-muted mb-0 small">Pending</p>
                                <h5 class="mb-0 fw-semibold" id="stat_pending_count">0</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-2 col-lg-4 col-md-6">
                <div class="card custom-card overflow-hidden">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-sm bg-danger-transparent me-3">
                                <i class="ri-close-circle-line fs-4 text-danger"></i>
                            </div>
                            <div>
                                <p class="text-muted mb-0 small">Rejected</p>
                                <h5 class="mb-0 fw-semibold" id="stat_rejected_count">0</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-2 col-lg-4 col-md-6">
                <div class="card custom-card overflow-hidden">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-sm bg-info-transparent me-3">
                                <i class="ri-shield-check-line fs-4 text-info"></i>
                            </div>
                            <div>
                                <p class="text-muted mb-0 small">QC Approved</p>
                                <h5 class="mb-0 fw-semibold" id="stat_qc_approved">0</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-2 col-lg-4 col-md-6">
                <div class="card custom-card overflow-hidden">
                    <div class="card-body p-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-sm bg-purple-transparent me-3">
                                <i class="ri-calendar-line fs-4 text-purple"></i>
                            </div>
                            <div>
                                <p class="text-muted mb-0 small">This Month</p>
                                <h5 class="mb-0 fw-semibold" id="stat_this_month">0</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search Results Table -->
        <div class="card custom-card">
            <div class="card-header justify-content-between">
                <div class="card-title">
                    <span id="search_results_title">Search Results</span>
                    <span class="badge bg-primary ms-2" id="results_count_badge">0 records found</span>
                </div>
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-outline-primary btn-sm" id="btn_toggle_filters">
                        <i class="ri-filter-line me-1"></i> Filters
                    </button>
                    <div class="btn-group">
                        <button type="button" class="btn btn-success btn-sm dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="ri-download-line me-1"></i> Export
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" id="export_excel"><i class="ri-file-excel-line me-2"></i>Excel</a></li>
                            <li><a class="dropdown-item" href="#" id="export_pdf"><i class="ri-file-pdf-line me-2"></i>PDF</a></li>
                            <li><a class="dropdown-item" href="#" id="export_csv"><i class="ri-file-text-line me-2"></i>CSV</a></li>
                        </ul>
                    </div>
                    <button type="button" class="btn btn-primary btn-sm" id="btn_print_results">
                        <i class="ri-printer-line me-1"></i> Print
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover datatable" id="search_results_table" width="100%">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Reference Number</th>
                                <th>Jacket Name</th>
                                <th>File Number</th>
                                <th>Instrument Type</th>
                                <th>Instrument Date</th>
                                <th>Party 1</th>
                                <th>Party 2</th>
                                <th>Consideration</th>
                                <th>Status</th>
                                <th>QC Status</th>
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

<!-- View Transaction Details Modal -->
<div class="modal fade" id="viewSearchTransactionModal" tabindex="-1" aria-labelledby="viewSearchTransactionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="viewSearchTransactionModalLabel">
                    <i class="ri-eye-line me-2"></i>Transaction Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="viewSearchTransactionContent">
                <!-- Content loaded dynamically -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="btn_print_transaction">
                    <i class="ri-printer-line me-1"></i> Print
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Compare Transactions Modal -->
<div class="modal fade" id="compareTransactionsModal" tabindex="-1" aria-labelledby="compareTransactionsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xxl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title" id="compareTransactionsModalLabel">
                    <i class="ri-compare-line me-2"></i>Compare Transactions
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-info">
                    <i class="ri-information-line me-2"></i>
                    Select up to 3 transactions to compare side by side.
                </div>
                <div id="comparison_container" class="row">
                    <!-- Comparison content will be loaded here -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js-pages/regional_transaction_search.js"></script>
