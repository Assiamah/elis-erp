<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
/* Scoped ELIS emerald-green styling: does not affect other pages. */
.elis-stamp-green {
    --elis-dark: #064b39;
    --elis-primary: #087f5b;
    --elis-bright: #0ba26f;
    --elis-pale: #e8f7ee;
    --elis-border: #cce8d8;
    --elis-ink: #173f32;
    color: var(--elis-ink);
}
.elis-stamp-green .page-header-breadcrumb {
    padding: 22px 25px;
    margin-bottom: 24px !important;
    border-radius: 14px;
    background: linear-gradient(115deg, #064b39 0%, #087f5b 58%, #0ba26f 100%);
    box-shadow: 0 9px 24px rgba(6, 75, 57, .15);
}
.elis-stamp-green .page-header-breadcrumb .page-title,
.elis-stamp-green .page-header-breadcrumb .breadcrumb-item,
.elis-stamp-green .page-header-breadcrumb .breadcrumb-item a {
    color: #fff !important;
}
.elis-stamp-green .page-header-breadcrumb .breadcrumb-item.active { color: #d7f9e5 !important; }
.elis-stamp-green .page-header-breadcrumb .breadcrumb-item + .breadcrumb-item::before { color: #c9e8db; }
.elis-stamp-green .card {
    border: 1px solid #e0eee6;
    border-radius: 14px;
    overflow: hidden;
    box-shadow: 0 5px 18px rgba(8, 75, 53, .07) !important;
}
.elis-stamp-green .card .card-header {
    background: linear-gradient(110deg, #064b39, #087f5b) !important;
    color: #fff !important;
    border: 0;
    padding: 17px 21px !important;
}
.elis-stamp-green .card .card-header h5,
.elis-stamp-green .card .card-header small,
.elis-stamp-green .card .card-header i,
.elis-stamp-green .card .card-header a { color: #fff !important; }
.elis-stamp-green .card .card-header small { color: #d7f5e4 !important; }
.elis-stamp-green .card .card-header .fs-4 { color: #bdf4d4 !important; }
.elis-stamp-green .card .card-body { background: #fff; }
.elis-stamp-green .form-label { color: var(--elis-dark); }
.elis-stamp-green .form-control,
.elis-stamp-green .input-group-text {
    border-color: var(--elis-border);
    border-radius: 9px;
}
.elis-stamp-green .input-group-text {
    background: var(--elis-pale);
    color: var(--elis-primary);
}
.elis-stamp-green .input-group > .input-group-text:first-child { border-radius: 9px 0 0 9px; }
.elis-stamp-green .input-group > .form-control:last-child { border-radius: 0 9px 9px 0; }
.elis-stamp-green .form-control:focus {
    border-color: var(--elis-bright);
    box-shadow: 0 0 0 .22rem rgba(11, 162, 111, .14);
}
.elis-stamp-green .btn { border-radius: 9px; font-weight: 600; transition: all .2s ease; }
.elis-stamp-green .btn-success,
.elis-stamp-green .btn-primary {
    background: linear-gradient(110deg, #087f5b, #0ba26f);
    border-color: #087f5b;
    color: #fff;
}
.elis-stamp-green .btn-success:hover,
.elis-stamp-green .btn-primary:hover {
    background: #064b39;
    border-color: #064b39;
    transform: translateY(-1px);
}
.elis-stamp-green .btn-outline-primary,
.elis-stamp-green .btn-outline-info {
    color: var(--elis-primary);
    border-color: var(--elis-primary);
}
.elis-stamp-green .btn-outline-primary:hover,
.elis-stamp-green .btn-outline-info:hover {
    color: #fff;
    background: var(--elis-primary);
    border-color: var(--elis-primary);
}
.elis-stamp-green #payment_details_section {
    border: 1px dashed #b9dfc9;
    border-radius: 12px;
    background: linear-gradient(180deg, #f4fbf6, #fff);
}
.elis-stamp-green #payment_details_section .fa-inbox { color: var(--elis-primary); opacity: .55 !important; }
.elis-stamp-green .table { --bs-table-hover-bg: #edf8f1; }
.elis-stamp-green .table thead th {
    background: #e8f7ee !important;
    color: #064b39 !important;
    border-bottom: 2px solid #a9d8bf;
    font-weight: 700;
    vertical-align: middle;
}
.elis-stamp-green .table tbody td { border-color: #e1eee7; }
.elis-stamp-green .text-primary,
.elis-stamp-green .text-info { color: var(--elis-primary) !important; }
.elis-stamp-green .btn-link { color: #fff !important; }
.elis-stamp-green .card .card-header .btn-link:hover { opacity: .8; }
.elis-stamp-green #document-section .card-header { padding: 14px 18px !important; }
.elis-stamp-green #document-section .card-header h5 { font-size: 1rem; font-weight: 700; }
.elis-stamp-green #document-section .card-body { padding: 18px; }
@media (max-width: 767px) {
    .elis-stamp-green .page-header-breadcrumb { padding: 18px; }
    .elis-stamp-green .card .card-body { padding: 17px; }
}
</style>

<!-- Start::app-content -->
<div class="main-content app-content elis-stamp-green">
    <div class="container-fluid page-container">
        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Verify Stamp Duty Payment</h1>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Verify Stamp Duty Payment</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <div class="row g-4">
            <!-- Main Content Area -->
            <div class="col-lg-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-danger py-3">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-search me-3 fs-4 text-warning"></i>
                            <div>
                                <h5 class="mb-0 fw-semibold">Search Bills</h5>
                                <small class="opacity-75">Search bills or job number to verify stamp duty payment</small>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row align-items-end g-3 mb-4">
                            <div class="col-md-7">
                                <label for="txt_ref_number_for_payment_rec" class="form-label fw-semibold">
                                    <i class="fas fa-search me-1"></i>Reference/Job Number
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                    <input class="form-control form-control-lg"
                                           id="txt_ref_number_for_payment_rec"
                                           type="text"
                                           placeholder="Enter reference or job number"
                                           required>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <button class="btn btn-success btn-lg w-100"
                                        id="btn_load_bill_details_after_payment_stamp_duty_receive">
                                    <i class="fas fa-search me-2"></i>Search Bills
                                </button>
                            </div>
                        </div>
                        <div class="card border-light shadow-sm">
                            <div class="card-body">
                                <div id="payment_details_section" class="p-3 text-center">
                                    <div class="text-muted mb-3"><i class="fas fa-inbox fa-3x opacity-25"></i></div>
                                    <h5 class="text-muted">Bill Details Will Appear Here</h5>
                                    <p class="small text-muted">Enter a reference number and click search to view bill details</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Documents Sidebar -->
            <div class="col-lg-4" id="document-section" style="display: none;">
                <!-- Application Documents -->
                <div class="card mb-4 shadow-sm">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center py-3">
                        <h5 class="mb-0"><i class="fas fa-file-alt text-primary me-2"></i>Application Documents</h5>
                        <a class="btn btn-link p-0 text-decoration-none"
                           data-bs-toggle="collapse" href="#collapsedocs" role="button">
                            <i class="fas fa-chevron-down"></i>
                        </a>
                    </div>
                    <div class="collapse show" id="collapsedocs">
                        <div class="card-body">
                            <div class="d-flex gap-2 mb-3">
                                <button type="button" class="btn btn-outline-primary"
                                        id="btn_load_scanned_documents" title="View Documents">
                                    <i class="fas fa-eye me-2"></i>View Docs
                                </button>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover table-sm" id="lc_main_scanned_documents_dataTable">
                                    <thead class="table-light">
                                        <tr><th>Document Name</th><th width="120">Type</th></tr>
                                    </thead>
                                    <tbody class="small">
                                        <tr class="text-center text-muted">
                                            <td colspan="2" class="py-4"><i class="fas fa-folder-open me-2"></i>No documents loaded</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Public Documents -->
                <div class="card mb-4 shadow-sm">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center py-3">
                        <h5 class="mb-0"><i class="fas fa-users text-info me-2"></i>Public Documents</h5>
                        <a class="btn btn-link p-0 text-decoration-none"
                           data-bs-toggle="collapse" href="#collapsepudocs" role="button">
                            <i class="fas fa-chevron-down"></i>
                        </a>
                    </div>
                    <div class="collapse" id="collapsepudocs">
                        <div class="card-body">
                            <div class="d-flex gap-2 mb-3">
                                <button type="button" class="btn btn-outline-info"
                                        id="btn_load_scanned_documents_public" title="View Public Documents">
                                    <i class="fas fa-eye me-2"></i>View Public Docs
                                </button>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover table-sm" id="lc_public_documents_dataTable">
                                    <thead class="table-light">
                                        <tr><th>Document Name</th><th width="120">Type</th></tr>
                                    </thead>
                                    <tbody class="small">
                                        <tr class="text-center text-muted">
                                            <td colspan="2" class="py-4"><i class="fas fa-folder-open me-2"></i>No public documents</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Print Button -->
                <div class="d-grid">
                    <button class="btn btn-primary btn-lg shadow-sm" id="btnPrintEgcr2">
                        <i class="fas fa-print me-2"></i>Print eGCR
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
