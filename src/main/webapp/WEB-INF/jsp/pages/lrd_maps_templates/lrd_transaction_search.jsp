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
                    <h1 class="page-title fw-medium fs-18 mb-1">LRD Transaction Search</h1>
                    <!-- <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Manage and plot PVLMD noted proposal parcels</p> -->
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">ELIS</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);" class="text-dark">LRD</a></li>
                    <li class="breadcrumb-item active text-success" aria-current="page">Transaction Search</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <div class="card custom-card lrd-search-hero mb-4 border-0">
            <div class="card-body p-4 p-xl-5">
                <div class="row align-items-center g-4">
                    <div class="col-xl-7">
                        <div class="d-flex flex-column gap-3">
                            <div class="lrd-hero-badge">
                                <i class="ri-search-eye-line me-2"></i> Certificate lookup
                            </div>
                            <div>
                                <h2 class="mb-2 fw-semibold text-white">Search LRD transactions by certificate number and inspect the matching records.</h2>
                                <p class="mb-0 text-white-75">
                                    The page keeps the existing search flow intact while presenting the results in a clearer, more focused layout.
                                </p>
                            </div>
                            <div class="d-flex flex-wrap gap-2">
                                <span class="lrd-hero-chip"><i class="ri-database-2-line me-1"></i> Certificate-based search</span>
                                <span class="lrd-hero-chip"><i class="ri-file-list-3-line me-1"></i> Transaction table</span>
                                <!-- <span class="lrd-hero-chip"><i class="ri-eye-line me-1"></i> Batch list access</span> -->
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-5">
                        <div class="lrd-search-panel">
                            <div class="d-flex align-items-start justify-content-between mb-3">
                                <div>
                                    <h5 class="mb-1 fw-semibold">Quick Search</h5>
                                    <p class="mb-0 text-muted small">Enter a certificate number to load matching rows.</p>
                                </div>
                                <span class="badge bg-primary-subtle text-primary border border-primary-subtle">Live search</span>
                            </div>
                            <div class="row g-2 align-items-end">
                                <div class="col-12">
                                    <label for="lrd_search_by_text" class="form-label">Certificate Number</label>
                                    <input class="form-control form-control-lg" id="lrd_search_by_text" name="lrd_search_by_text" type="text" placeholder="Search by Certificate Number" required>
                                </div>
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button type="button" class="btn btn-primary btn-lg" id="lrd_btn_search_by_transaction_reference_number" data-placement="top" data-toggle="tooltip" title="Search">
                                            <i class="ri-search-line me-2"></i> Search Transactions
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-3 small text-muted">
                                Tip: use the exact certificate number for the best match.
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
                    <!-- <span class="badge bg-success-subtle text-success border border-success-subtle">Results appear below</span> -->
                </div>
                <div class="d-flex align-items-center gap-2">
                    <span class="text-muted small d-none d-md-inline">Loaded transactions include name, grantor, certificate number, and instrument type.</span>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 data-table lrd-transaction-table" id="lrd_transaction_dataTable" width="100%" cellspacing="0">
                        <thead class="table-light">
                            <tr>
                                <th>Name</th>
                                <th>Grantor</th>
                                <th>Certificate Number</th>
                                <th>Instrument Type</th>
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

<jsp:include page="../../components/lrd_maps_modals.jsp"></jsp:include>

<style>
    .lrd-search-hero {
        position: relative;
        overflow: hidden;
        border-radius: 1.25rem;
        background:
            radial-gradient(circle at top right, rgba(255, 255, 255, 0.18), transparent 28%),
            linear-gradient(135deg, #7c2d12 0%, #a16207 50%, #14532d 100%);
        box-shadow: 0 18px 45px rgba(15, 23, 42, 0.14);
    }

    .lrd-search-hero::after {
        content: "";
        position: absolute;
        inset: auto -8% -42% auto;
        width: 260px;
        height: 260px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.08);
        pointer-events: none;
    }

    .lrd-search-hero .card-body {
        position: relative;
        z-index: 1;
    }

    .lrd-hero-badge {
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

    .lrd-hero-chip {
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

    .lrd-search-panel {
        background: rgba(255, 255, 255, 0.96);
        border-radius: 1rem;
        padding: 1.25rem;
        box-shadow: 0 10px 30px rgba(15, 23, 42, 0.12);
    }

    .lrd-search-panel .form-control-lg {
        min-height: 3.25rem;
    }

    /* .lrd-transaction-table thead th {
        white-space: nowrap;
        font-weight: 600;
    }

    .lrd-transaction-table td,
    .lrd-transaction-table th {
        vertical-align: middle;
    }

    .lrd-transaction-table td {
        white-space: nowrap;
    }

    .lrd-transaction-table td:last-child,
    .lrd-transaction-table th:last-child {
        width: 120px;
        text-align: center;
    } */

    .text-white-75 {
        color: rgba(255, 255, 255, 0.75);
    }

    @media (max-width: 767.98px) {
        .lrd-search-panel {
            padding: 1rem;
        }

        .lrd-search-hero h2 {
            font-size: 1.35rem;
        }

        .lrd-transaction-table {
            min-width: 820px;
        }
    }
</style>

<script src="${pageContext.request.contextPath}/js-pages/lrd_transaction_search.js"></script>
