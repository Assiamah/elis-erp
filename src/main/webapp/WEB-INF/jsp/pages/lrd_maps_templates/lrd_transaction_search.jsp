<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
.lrd-transaction-page { --lrd-green:#087f5b; --lrd-dark:#064b39; --lrd-bright:#0b9469; --lrd-pale:#e9f8ef; --lrd-border:#ccebd9; }
.lrd-transaction-page .page-header-breadcrumb {background:linear-gradient(120deg,#064b39,#087f5b 65%,#0b9469);padding:1.25rem 1.5rem;border-radius:1rem;box-shadow:0 10px 26px rgba(6,75,57,.16)}
.lrd-transaction-page .page-header-breadcrumb .page-title,.lrd-transaction-page .page-header-breadcrumb .breadcrumb-item,.lrd-transaction-page .page-header-breadcrumb .breadcrumb-item a {color:#fff!important}
.lrd-transaction-page .page-header-breadcrumb .breadcrumb-item.active {color:#d8f9e6!important}
.lrd-transaction-page .breadcrumb-item+.breadcrumb-item::before {color:rgba(255,255,255,.7)}
.lrd-transaction-page .lrd-search-hero {position:relative;overflow:hidden;border-radius:1.25rem;background:radial-gradient(circle at top right,rgba(255,255,255,.14),transparent 32%),linear-gradient(135deg,#064b39 0%,#087f5b 58%,#0b9469 100%);box-shadow:0 18px 42px rgba(6,75,57,.2)}
.lrd-transaction-page .lrd-search-hero::after {content:"";position:absolute;right:-80px;bottom:-150px;width:330px;height:330px;border:1px solid rgba(255,255,255,.17);border-radius:50%;pointer-events:none}
.lrd-transaction-page .lrd-search-hero .card-body {position:relative;z-index:1}
.lrd-transaction-page .lrd-hero-badge,.lrd-transaction-page .lrd-hero-chip {display:inline-flex;align-items:center;width:fit-content;padding:.45rem .8rem;border-radius:999px;color:#fff;background:rgba(255,255,255,.13);border:1px solid rgba(255,255,255,.19);font-size:.85rem;backdrop-filter:blur(8px)}
.lrd-transaction-page .lrd-hero-badge {font-weight:700}
.lrd-transaction-page .text-white-75 {color:rgba(255,255,255,.82)}
.lrd-transaction-page .lrd-search-panel {background:#fff;border:1px solid #d8f1e3;border-radius:1.1rem;padding:1.5rem;box-shadow:0 16px 35px rgba(4,61,43,.18)}
.lrd-transaction-page .lrd-search-panel h5 {color:var(--lrd-dark)}
.lrd-transaction-page .lrd-search-panel .form-label {font-weight:600;color:#215544}
.lrd-transaction-page .lrd-search-panel .form-control-lg {min-height:3.25rem;border:1px solid #b9ddca;border-radius:.7rem}
.lrd-transaction-page .lrd-search-panel .form-control:focus {border-color:var(--lrd-green);box-shadow:0 0 0 .22rem rgba(8,127,91,.14)}
.lrd-transaction-page .lrd-search-panel .badge {background:var(--lrd-pale)!important;color:var(--lrd-dark)!important;border:1px solid var(--lrd-border)!important}
.lrd-transaction-page .btn-primary {background:linear-gradient(135deg,#087f5b,#064b39);border-color:#087f5b;color:#fff;box-shadow:0 4px 10px rgba(8,127,91,.14)}
.lrd-transaction-page .btn-primary:hover,.lrd-transaction-page .btn-primary:focus {background:#064b39;border-color:#064b39;color:#fff}
.lrd-transaction-page .lrd-results-card {border:1px solid var(--lrd-border);border-radius:1rem;box-shadow:0 10px 28px rgba(6,75,57,.07);overflow:hidden}
.lrd-transaction-page .lrd-results-card>.card-header {background:linear-gradient(115deg,#064b39,#087f5b);color:#fff;border-bottom:0;padding:1rem 1.3rem}
.lrd-transaction-page .lrd-results-card>.card-header .card-title,.lrd-transaction-page .lrd-results-card>.card-header .text-muted {color:#fff!important}
.lrd-transaction-page .lrd-transaction-table {width:100%!important;margin-bottom:0}
.lrd-transaction-page .lrd-transaction-table thead th {background:#e9f8ef!important;color:#064b39!important;border-bottom:2px solid #a4d9bb!important;font-weight:700;padding:1rem;white-space:nowrap}
.lrd-transaction-page .lrd-transaction-table tbody td {padding:.85rem 1rem;vertical-align:middle;border-color:#e5f2eb}
.lrd-transaction-page .lrd-transaction-table tbody tr:hover td {background:#f1fbf5!important}
.lrd-transaction-page .lrd-transaction-table th:last-child,.lrd-transaction-page .lrd-transaction-table td:last-child {text-align:center;min-width:115px}
.lrd-transaction-page .dataTables_wrapper .dataTables_filter input,.lrd-transaction-page .dataTables_wrapper .dataTables_length select {border:1px solid #b9ddca;border-radius:.5rem;padding:.35rem .6rem}
.lrd-transaction-page .dataTables_wrapper .dataTables_filter input:focus {outline:0;border-color:#087f5b;box-shadow:0 0 0 .2rem rgba(8,127,91,.13)}
.lrd-transaction-page .dataTables_wrapper .dataTables_paginate .paginate_button.current,.lrd-transaction-page .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover,.lrd-transaction-page .page-item.active .page-link {background:#087f5b!important;border-color:#087f5b!important;color:#fff!important}
.lrd-transaction-page .dataTables_wrapper {padding-bottom:.75rem}
@media(max-width:767.98px){.lrd-transaction-page .lrd-search-panel{padding:1rem}.lrd-transaction-page .lrd-search-hero h2{font-size:1.35rem}.lrd-transaction-page .lrd-transaction-table{min-width:820px}.lrd-transaction-page .page-header-breadcrumb{padding:1rem}}
</style>

<div class="main-content app-content lrd-transaction-page">
    <div class="container-fluid">
        <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap gap-2">
                <div><h1 class="page-title fw-semibold fs-18 mb-1">LRD Transaction Search</h1></div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">LRD</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Transaction Search</li>
                </ol>
            </div>
        </div>

        <div class="card custom-card lrd-search-hero mb-4 border-0">
            <div class="card-body p-4 p-xl-5">
                <div class="row align-items-center g-4">
                    <div class="col-xl-7">
                        <div class="d-flex flex-column gap-3">
                            <div class="lrd-hero-badge"><i class="ri-search-eye-line me-2"></i> Certificate lookup</div>
                            <div>
                                <h2 class="mb-2 fw-semibold text-white">Search LRD transactions by certificate number and inspect the matching records.</h2>
                                <p class="mb-0 text-white-75">The page keeps the existing search flow intact while presenting the results in a clearer, more focused layout.</p>
                            </div>
                            <div class="d-flex flex-wrap gap-2">
                                <span class="lrd-hero-chip"><i class="ri-database-2-line me-1"></i> Certificate-based search</span>
                                <span class="lrd-hero-chip"><i class="ri-file-list-3-line me-1"></i> Transaction table</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-5">
                        <div class="lrd-search-panel">
                            <div class="d-flex align-items-start justify-content-between mb-3 gap-2">
                                <div><h5 class="mb-1 fw-semibold">Quick Search</h5><p class="mb-0 text-muted small">Enter a certificate number to load matching rows.</p></div>
                                <span class="badge">Live search</span>
                            </div>
                            <div class="row g-2 align-items-end">
                                <div class="col-12">
                                    <label for="lrd_search_by_text" class="form-label">Certificate Number</label>
                                    <input class="form-control form-control-lg" id="lrd_search_by_text" name="lrd_search_by_text" type="text" placeholder="Search by Certificate Number" required>
                                </div>
                                <div class="col-12"><div class="d-grid">
                                    <button type="button" class="btn btn-primary btn-lg" id="lrd_btn_search_by_transaction_reference_number" data-placement="top" data-toggle="tooltip" title="Search"><i class="ri-search-line me-2"></i> Search Transactions</button>
                                </div></div>
                            </div>
                            <div class="mt-3 small text-muted">Tip: use the exact certificate number for the best match.</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card custom-card lrd-results-card">
            <div class="card-header d-flex justify-content-between align-items-center flex-wrap gap-2">
                <div class="card-title mb-0 d-flex align-items-center gap-2"><i class="ri-file-list-3-line"></i><span>Transaction List</span></div>
                <div class="d-flex align-items-center gap-2"><span class="text-muted small d-none d-md-inline">Loaded transactions include name, grantor, certificate number, and instrument type.</span></div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 data-table lrd-transaction-table" id="lrd_transaction_dataTable" width="100%" cellspacing="0">
                        <thead class="table-light"><tr><th>Name</th><th>Grantor</th><th>Certificate Number</th><th>Instrument Type</th><th class="text-center">Actions</th></tr></thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../components/lrd_maps_modals.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/js-pages/lrd_transaction_search.js"></script>
