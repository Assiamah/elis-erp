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

<div class="main-content app-content">
    <div class="container-fluid">

       <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">PVLMD Transaction Search</h1>
                    <!-- <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Manage and plot PVLMD noted proposal parcels</p> -->
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">PVLMD</a></li>
                    <li class="breadcrumb-item active text-success" aria-current="page">Transaction Search</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <!-- <div class="page-header-breadcrumb mb-3">
            <div class="d-md-flex d-block align-items-center justify-content-between flex-wrap gap-3">
                <div>
                    <h1 class="page-title fw-semibold fs-18 mb-1">PVLMD Transaction Search</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                            <li class="breadcrumb-item"><a href="javascript:void(0);">PVLMD</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Transaction Search</li>
                        </ol>
                    </nav>
                </div>
                
            </div>
        </div> -->

        <div class="card custom-card pvlmd-search-hero mb-4 border-0">
            <div class="card-body p-4 p-xl-5">
                <div class="row align-items-center g-4">
                    <div class="col-xl-7">
                        <div class="d-flex flex-column gap-3">
                            <div class="pvlmd-hero-badge">
                                <i class="ri-search-eye-line me-2"></i> Transaction lookup
                            </div>
                            <div>
                                <h2 class="mb-2 fw-semibold text-white">Find a PVLMD transaction and review its captured details.</h2>
                                <p class="mb-0 text-white-75">
                                    Search by reference number, then inspect the loaded records below. The page keeps the existing workflow intact while giving the search area a clearer focus.
                                </p>
                            </div>
                            <div class="d-flex flex-wrap gap-2">
                                <span class="pvlmd-hero-chip"><i class="ri-database-2-line me-1"></i> Reference-based search</span>
                                <span class="pvlmd-hero-chip"><i class="ri-file-list-3-line me-1"></i> Transaction table</span>
                                <!-- <span class="pvlmd-hero-chip"><i class="ri-eye-line me-1"></i> Batch list access</span> -->
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-5">
                        <div class="pvlmd-search-panel">
                            <div class="d-flex align-items-start justify-content-between mb-3">
                                <div>
                                    <h5 class="mb-1 fw-semibold">Quick Search</h5>
                                    <p class="mb-0 text-muted small">Enter a transaction reference number to load matching rows.</p>
                                </div>
                                <span class="badge bg-primary-subtle text-primary border border-primary-subtle">Live search</span>
                            </div>
                            <div class="row g-2 align-items-end">
                                <div class="col-12">
                                    <label for="pvlmd_search_by_text" class="form-label">Reference Number</label>
                                    <input class="form-control form-control-lg" id="pvlmd_search_by_text" name="pvlmd_search_by_text" type="text" placeholder="Search by Ref Number" required>
                                </div>
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button type="button" class="btn btn-primary btn-lg" id="pvlmd_btn_search_by_transaction_reference_number" data-placement="top" data-toggle="tooltip" title="Search">
                                            <i class="ri-search-line me-2"></i> Search Transactions
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-3 small text-muted">
                                Tip: use the exact reference number for the best match.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card custom-card overflow-hidden">
            <div class="card-header d-flex justify-content-between align-items-center flex-wrap gap-2">
                <div class="card-title mb-0 d-flex align-items-center gap-2">
                    <span>Transaction List</span>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <span class="text-muted small d-none d-md-inline">Loaded transactions will include document, parties, dates, and remarks.</span>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 data-table pvlmd-transaction-table" id="pvlmd_transaction_detailsdataTable" width="100%" cellspacing="0">
                        <thead class="table-light">
                            <tr>
                                <th>Document Number</th>
                                <th>Instrument Type</th>
                                <th>Instrument Date</th>
                                <th>Consent Date</th>
                                <th>Grantor</th>
                                <th>Grantee</th>
                                <th>Reference Number</th>
                                <th>Remarks</th>
                                <th class="text-center">Actions</th>
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

<jsp:include page="pvlmd_maps_modals.jsp"></jsp:include>

<style>
    .pvlmd-search-hero {
        position: relative;
        overflow: hidden;
        border-radius: 1.25rem;
        background:
            radial-gradient(circle at top right, rgba(255, 255, 255, 0.18), transparent 28%),
            linear-gradient(135deg, #0f766e 0%, #0b5d8a 55%, #12304f 100%);
        box-shadow: 0 18px 45px rgba(15, 23, 42, 0.14);
    }

    .pvlmd-search-hero::after {
        content: "";
        position: absolute;
        inset: auto -8% -42% auto;
        width: 260px;
        height: 260px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.08);
        pointer-events: none;
    }

    .pvlmd-search-hero .card-body {
        position: relative;
        z-index: 1;
    }

    .pvlmd-hero-badge {
        display: inline-flex;
        align-items: center;
        width: fit-content;
        padding: 0.45rem 0.8rem;
        border-radius: 999px;
        background: rgba(255, 255, 255, 0.14);
        color: #fff;
        font-size: 0.85rem;
        font-weight: 600;
        letter-spacing: 0.02em;
        backdrop-filter: blur(10px);
    }

    .pvlmd-hero-chip {
        display: inline-flex;
        align-items: center;
        padding: 0.45rem 0.75rem;
        border-radius: 999px;
        background: rgba(255, 255, 255, 0.12);
        color: rgba(255, 255, 255, 0.92);
        font-size: 0.85rem;
        border: 1px solid rgba(255, 255, 255, 0.16);
        backdrop-filter: blur(10px);
    }

    .pvlmd-search-panel {
        background: rgba(255, 255, 255, 0.96);
        border-radius: 1rem;
        padding: 1.25rem;
        box-shadow: 0 10px 30px rgba(15, 23, 42, 0.12);
    }

    .pvlmd-search-panel .form-control-lg {
        min-height: 3.25rem;
    }

    /* .pvlmd-transaction-table thead th {
        white-space: nowrap;
        font-weight: 600;
    }

    .pvlmd-transaction-table td,
    .pvlmd-transaction-table th {
        vertical-align: middle;
    }

    .pvlmd-transaction-table td {
        white-space: nowrap;
    }

    .pvlmd-transaction-table td:nth-child(8) {
        white-space: normal;
        min-width: 220px;
    }

    .pvlmd-transaction-table td:last-child,
    .pvlmd-transaction-table th:last-child {
        width: 120px;
        text-align: center;
    } */

    .text-white-75 {
        color: rgba(255, 255, 255, 0.75);
    }

    @media (max-width: 767.98px) {
        .pvlmd-search-panel {
            padding: 1rem;
        }

        .pvlmd-search-hero h2 {
            font-size: 1.35rem;
        }

        .pvlmd-transaction-table {
            min-width: 1150px;
        }
    }
</style>

<script src="${pageContext.request.contextPath}/js-pages/pvlmd_transaction_search.js"></script>

