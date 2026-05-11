<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="main-content app-content">
    <div class="container-fluid">
        <!-- Page Header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <h1 class="page-title fw-medium fs-18 mb-0">Regional PVLMD Transaction Search</h1>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">PVLMD</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Transaction Search</li>
                </ol>
            </div>
        </div>

        <!-- Simple Search Section -->
        <div class="card custom-card mb-4">
            <div class="card-body">
                <div class="row g-3 align-items-end">
                    <div class="col-md-8">
                        <label for="simple_search" class="form-label">Search Transactions</label>
                        <input type="text" class="form-control" id="simple_search" placeholder="Enter reference number, file number, jacket name, or party name...">
                    </div>
                    <div class="col-md-4">
                        <button type="button" class="btn btn-primary w-100" id="btn_simple_search">
                            <i class="ri-search-line me-1"></i> Search
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search Results Table -->
        <div class="card custom-card">
            <div class="card-header">
                <div class="card-title">
                    <span id="search_results_title">Search Results</span>
                    <span class="badge bg-primary ms-2" id="results_count_badge">0 records found</span>
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

<script src="${pageContext.request.contextPath}/js-pages/regional_transaction_search.js"></script>
