<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<style>
/* ELIS Enquiry Teller: scoped emerald design, existing element IDs preserved */
.elis-enquiry{--eq-deep:#06472f;--eq-forest:#07583d;--eq-primary:#087e58;--eq-bright:#0ca678;--eq-mint:#eaf8f1;--eq-border:#cce9da;--eq-text:#193e30;--eq-muted:#678576;color:var(--eq-text)}
.elis-enquiry .eq-hero{position:relative;overflow:hidden;background:linear-gradient(112deg,#06472f 0%,#087e58 66%,#18a977 100%);border-radius:18px;padding:25px 30px;color:#fff;box-shadow:0 12px 30px rgba(6,71,47,.18)}
.elis-enquiry .eq-hero:after{content:"";position:absolute;right:-65px;top:-110px;width:340px;height:340px;border:1px solid rgba(255,255,255,.16);border-radius:50%;box-shadow:0 0 0 55px rgba(255,255,255,.035),0 0 0 110px rgba(255,255,255,.025);pointer-events:none}
.elis-enquiry .eq-eyebrow{font-size:11px;letter-spacing:1.5px;font-weight:800;text-transform:uppercase;color:#bdf4d8}
.elis-enquiry .eq-hero h1{font-size:25px;line-height:1.25;font-weight:800;color:#fff;margin:7px 0}
.elis-enquiry .eq-hero p{font-size:13px;color:#ddf9eb;margin:0}
.elis-enquiry .eq-hero .breadcrumb,.elis-enquiry .eq-hero .breadcrumb a,.elis-enquiry .eq-hero .breadcrumb-item{color:#e3fff0!important}
.elis-enquiry .eq-hero .breadcrumb-item+.breadcrumb-item:before{color:#bdf4d8!important}
.elis-enquiry .eq-card{background:#fff;border:1px solid var(--eq-border);border-radius:17px;box-shadow:0 5px 24px rgba(6,71,47,.07);overflow:hidden;margin-bottom:20px}
.elis-enquiry .eq-card-header{display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;background:linear-gradient(112deg,#07583d,#0b9569);padding:18px 23px;color:#fff}
.elis-enquiry .eq-card-header h2{font-size:17px;font-weight:800;color:#fff;margin:0 0 4px}
.elis-enquiry .eq-card-header small{font-size:12px;color:#d7f8e7}
.elis-enquiry .eq-header-icon{width:42px;height:42px;flex-shrink:0;border-radius:12px;background:rgba(255,255,255,.15);display:inline-flex;align-items:center;justify-content:center;font-size:20px;color:#fff}
.elis-enquiry .eq-card-body{padding:24px}
.elis-enquiry .eq-step{display:inline-flex;align-items:center;gap:8px;color:var(--eq-primary);font-size:11px;font-weight:800;text-transform:uppercase;letter-spacing:.8px;margin-bottom:12px}
.elis-enquiry .eq-step-number{display:inline-flex;align-items:center;justify-content:center;width:23px;height:23px;border-radius:50%;background:#d8f3e4;color:#07583d;font-size:12px}
.elis-enquiry .eq-selector{background:#f5fbf7;border:1px solid #deeee4;border-radius:13px;padding:17px}
.elis-enquiry .eq-selector .btn-check+label{min-height:74px;padding:12px 8px;border:1px solid #cde6d7;border-radius:11px;background:#fff;color:#2a5541;font-size:12px;font-weight:700;display:flex!important;flex-direction:column;gap:8px;transition:all .18s ease;box-shadow:0 2px 5px rgba(8,84,57,.025)}
.elis-enquiry .eq-selector .btn-check+label i{font-size:19px;color:#0b8e63;margin:0!important}
.elis-enquiry .eq-selector .btn-check+label:hover{background:#ecf9f1;border-color:#0ca678;transform:translateY(-2px)}
.elis-enquiry .eq-selector .btn-check:checked+label{color:#fff;background:linear-gradient(135deg,#07583d,#0ca678);border-color:#087e58;box-shadow:0 5px 13px rgba(8,126,88,.19)}
.elis-enquiry .eq-selector .btn-check:checked+label i{color:#fff}
.elis-enquiry .eq-selector .btn-check:focus-visible+label{outline:3px solid #92dfb7;outline-offset:2px}
.elis-enquiry .eq-form-label{font-size:13px;font-weight:750;color:#254d3a;margin-bottom:10px}
.elis-enquiry .eq-input-wrap{display:flex;align-items:stretch;border:1px solid #c7e3d3;border-radius:12px;overflow:hidden;background:#fff;transition:box-shadow .2s,border-color .2s}
.elis-enquiry .eq-input-wrap:focus-within{border-color:#0ca678;box-shadow:0 0 0 4px rgba(12,166,120,.11)}
.elis-enquiry .eq-input-wrap .input-group-text{background:#f0faf4;color:#087e58;border:0;border-right:1px solid #d9ecdf;border-radius:0;padding:0 18px}
.elis-enquiry .eq-input-wrap .form-control{min-width:0;flex:1;border:0!important;box-shadow:none!important;border-radius:0!important;padding:13px 15px;font-size:14px;min-height:51px}
.elis-enquiry .eq-btn-search{border:0;background:linear-gradient(110deg,#087e58,#0ca678);color:#fff;font-weight:800;font-size:13px;padding:0 25px;white-space:nowrap;transition:filter .2s}
.elis-enquiry .eq-btn-search:hover,.elis-enquiry .eq-btn-search:focus{filter:brightness(.9);color:#fff}
.elis-enquiry .eq-tip{font-size:12px;color:var(--eq-muted);margin-top:11px}
.elis-enquiry .eq-results-tools{display:flex;gap:8px;flex-wrap:wrap}
.elis-enquiry .eq-tool-btn{background:rgba(255,255,255,.13);border:1px solid rgba(255,255,255,.35);color:#fff;border-radius:8px;font-size:12px;font-weight:700;padding:8px 12px}
.elis-enquiry .eq-tool-btn:hover{background:#fff;color:#07583d}
.elis-enquiry .eq-table{font-size:12px;width:100%;border-collapse:separate;border-spacing:0}
.elis-enquiry .eq-table thead th{background:#eaf7ef;color:#07583d;border-bottom:2px solid #c5e8d3;padding:15px 14px;font-size:11px;font-weight:800;white-space:nowrap}
.elis-enquiry .eq-table thead th i{color:#0b9569}
.elis-enquiry .eq-table tbody td{padding:13px 14px;vertical-align:middle;border-bottom:1px solid #e3f0e8}
.elis-enquiry .eq-table tbody tr:nth-child(even){background:#f8fcf9}
.elis-enquiry .eq-table tbody tr:hover{background:#eaf8f0}
.elis-enquiry .eq-results-footer{background:#f7fcf9;border-top:1px solid #dcefe3;padding:15px 22px}
.elis-enquiry .eq-results-footer .btn-outline-primary{color:#087e58;border-color:#a9d8be}
.elis-enquiry .eq-results-footer .btn-outline-primary:hover{color:#fff;background:#087e58;border-color:#087e58}
.elis-enquiry .eq-results-footer .text-muted{color:#6c8878!important}
.elis-enquiry #enquiry_alert{border-radius:11px}
.elis-enquiry .table-dropdown{min-width:220px}
@media(max-width:767.98px){.elis-enquiry .eq-hero{padding:20px}.elis-enquiry .eq-hero h1{font-size:21px}.elis-enquiry .eq-card-body{padding:16px}.elis-enquiry .eq-card-header{padding:16px}.elis-enquiry .eq-input-wrap{flex-wrap:wrap}.elis-enquiry .eq-input-wrap .form-control{min-width:calc(100% - 57px)}.elis-enquiry .eq-btn-search{width:100%;min-height:46px}.elis-enquiry .eq-selector .btn-check+label{min-height:68px}}

/* 2026 redesigned enquiry workspace: polished light surface + emerald accents */
.elis-enquiry{--eq-deep:#073e2e;--eq-forest:#07543d;--eq-primary:#087d58;--eq-bright:#0da676;--eq-mint:#f0faf5;--eq-border:#dcece3;--eq-text:#173a2b;--eq-muted:#718879;background:linear-gradient(180deg,#f5faf7 0,#fbfdfb 390px,#fff 100%);min-height:100vh}
.elis-enquiry .page-container{max-width:1540px;padding-top:16px;padding-bottom:38px}
.elis-enquiry .eq-hero{background:linear-gradient(115deg,#073d2d 0%,#086445 56%,#119a6c 100%);border-radius:22px;padding:32px 36px;box-shadow:0 15px 34px rgba(5,76,49,.16);border:1px solid rgba(255,255,255,.14)}
.elis-enquiry .eq-hero:after{right:-20px;top:-180px;width:440px;height:440px;border:1px solid rgba(255,255,255,.18);box-shadow:0 0 0 48px rgba(255,255,255,.035),0 0 0 105px rgba(255,255,255,.025)}
.elis-enquiry .eq-hero h1{font-size:clamp(25px,2.4vw,34px);letter-spacing:-.7px;margin:9px 0}
.elis-enquiry .eq-title-accent{color:#a8f3ca}
.elis-enquiry .eq-hero p{font-size:14px;color:#d7f4e5}
.elis-enquiry .eq-eyebrow{font-size:10px;letter-spacing:1.8px}
.elis-enquiry .eq-card{border:1px solid #dcece3;border-radius:20px;box-shadow:0 10px 30px rgba(9,68,43,.06);margin-bottom:24px}
.elis-enquiry .eq-card-header{background:#fff;color:#173e2c;padding:23px 27px;border-bottom:1px solid #e5f0e9}
.elis-enquiry .eq-card-header h2{color:#123d2b;font-size:18px;letter-spacing:-.2px}
.elis-enquiry .eq-card-header small{color:#789184}
.elis-enquiry .eq-header-icon{background:#e6f7ee;color:#087f59;width:47px;height:47px;border-radius:14px}
.elis-enquiry .eq-header-tag{border:1px solid #cdebd9;background:#effaf4;color:#087b55;border-radius:100px;padding:8px 14px;font-size:11px;font-weight:800}
.elis-enquiry .eq-card-body{padding:26px 28px 30px}
.elis-enquiry .eq-step{display:flex;align-items:center;gap:9px;font-size:12px;color:#174b35;letter-spacing:.3px;margin-bottom:14px}
.elis-enquiry .eq-step-number{width:30px;height:30px;border-radius:10px;background:#0b855d;color:#fff;font-size:10px;letter-spacing:0}
.elis-enquiry .eq-step-hint{font-size:11px;color:#9aaa9f;font-weight:500;letter-spacing:0;text-transform:none;margin-left:auto}
.elis-enquiry .eq-selector{padding:10px;border-radius:15px;background:#f7fbf8;border:1px solid #e3f0e7}
.elis-enquiry .eq-selector .btn-check+label{min-height:96px;border-radius:12px;background:#fff;border:1px solid #e2eee6;font-size:12px;gap:11px;box-shadow:0 2px 7px rgba(8,65,39,.025)}
.elis-enquiry .eq-selector .btn-check+label i{font-size:22px;background:#ecf9f1;color:#078358;width:42px;height:42px;border-radius:12px;display:flex;align-items:center;justify-content:center}
.elis-enquiry .eq-selector .btn-check+label:hover{transform:translateY(-2px);border-color:#5abf93;box-shadow:0 7px 16px rgba(8,110,71,.08)}
.elis-enquiry .eq-selector .btn-check:checked+label{background:#eaf8f0;border-color:#0c9669;color:#07573d;box-shadow:inset 0 0 0 1px #0c9669,0 7px 18px rgba(9,125,78,.1)}
.elis-enquiry .eq-selector .btn-check:checked+label i{background:#0b8d63;color:white}
.elis-enquiry .eq-form-label{font-size:12px;margin-bottom:9px}
.elis-enquiry .eq-input-wrap{border-radius:13px;border:1px solid #cbded2;box-shadow:0 3px 11px rgba(9,68,43,.03)}
.elis-enquiry .eq-input-wrap .input-group-text{background:#fff;border-right:0;color:#0b875e}
.elis-enquiry .eq-input-wrap .form-control{min-height:58px;font-size:14px}
.elis-enquiry .eq-btn-search{background:linear-gradient(120deg,#086d4e,#0ba16f);padding:0 28px;border-radius:0;font-size:13px}
.elis-enquiry .eq-tip{margin-top:12px}
.elis-enquiry .eq-table thead th{background:#0a5d43;color:white;border:0;padding:15px 14px}
.elis-enquiry .eq-table thead th i{color:#b2f1ce}
.elis-enquiry .eq-table tbody tr:hover{background:#effaf3}
.elis-enquiry .eq-results-tools .eq-tool-btn{background:#eef8f2;color:#0a704f;border:1px solid #cfe9d9;padding:9px 14px;border-radius:10px}
.elis-enquiry .eq-results-tools .eq-tool-btn:hover{background:#0b805a;color:#fff}
.elis-enquiry .eq-results-footer{background:#fbfdfb}
.elis-enquiry #enquiry_alert{border-radius:12px}
@media(max-width:767.98px){.elis-enquiry .eq-hero{padding:23px 20px}.elis-enquiry .eq-card-header{padding:17px}.elis-enquiry .eq-card-body{padding:17px}.elis-enquiry .eq-selector .btn-check+label{min-height:85px}.elis-enquiry .eq-header-tag{display:none}.elis-enquiry .eq-step-hint{display:none}}
</style>

<div class="main-content app-content elis-enquiry">
    <div class="container-fluid page-container">
        <div class="eq-hero mb-4">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3 position-relative" style="z-index:1">
                <div>
                    <div class="eq-eyebrow"><i class="fas fa-circle me-2" style="font-size:7px"></i>LANDS COMMISSION · ENTERPRISE LAND INFORMATION SYSTEM</div>
                    <h1>Application Enquiry <span class="eq-title-accent">Teller</span></h1>
                    <p>One place to find, review and manage land application enquiries.</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Enquiry Teller</li>
                </ol>
            </div>
        </div>

        <div class="row g-3">
            <div class="col-12">
                <section class="eq-card" aria-labelledby="enquirySearchTitle">
                    <div class="eq-card-header">
                        <div class="d-flex align-items-center gap-3">
                            <span class="eq-header-icon"><i class="fas fa-search"></i></span>
                            <div>
                                <h2 id="enquirySearchTitle">Search Applications</h2>
                                <small>Search by job, case, regional reference, GLPIN or applicant name</small>
                            </div>
                        </div>
                        <span class="eq-header-tag"><i class="fas fa-bolt me-1"></i> Quick lookup</span>
                    </div>
                    <div class="eq-card-body">
                        <form id="frmEnquiryJobSearch" method="post" class="needs-validation" novalidate>
                            <div class="mb-4">
                                <div class="eq-step"><span class="eq-step-number">01</span> Choose how to search <span class="eq-step-hint">Select one option</span></div>
                                <div class="eq-selector search-type-selector">
                                    <div class="row g-2 row-cols-2 row-cols-sm-3 row-cols-lg-6">
                                        <div class="col">
                                            <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" class="btn-check" value="job_number" required>
                                            <label class="btn w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type1"><i class="fas fa-hashtag"></i><span>Job Number</span></label>
                                        </div>
                                        <div class="col">
                                            <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" class="btn-check" value="case_number" required>
                                            <label class="btn w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type2"><i class="fas fa-folder"></i><span>Case Number</span></label>
                                        </div>
                                        <div class="col">
                                            <input type="radio" id="rbtn_search_type3" name="rbtn_search_type" class="btn-check" value="regional_number" required>
                                            <label class="btn w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type3"><i class="fas fa-map-marker-alt"></i><span>Regional Number</span></label>
                                        </div>
                                        <div class="col">
                                            <input type="radio" id="rbtn_search_type4" name="rbtn_search_type" class="btn-check" value="glpin" required>
                                            <label class="btn w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type4"><i class="fas fa-fingerprint"></i><span>GLPIN</span></label>
                                        </div>
                                        <div class="col">
                                            <input type="radio" id="rbtn_search_type6" name="rbtn_search_type" class="btn-check" value="ref_number" required>
                                            <label class="btn w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type6"><i class="fas fa-file-alt"></i><span>Ref Number</span></label>
                                        </div>
                                        <div class="col">
                                            <input type="radio" id="rbtn_search_type5" name="rbtn_search_type" class="btn-check" value="ar_name" required>
                                            <label class="btn w-100 d-flex align-items-center justify-content-center" for="rbtn_search_type5"><i class="fas fa-user"></i><span>Applicant Name</span></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-2">
                                <div class="eq-step"><span class="eq-step-number">02</span> Enter your reference <span class="eq-step-hint">Search ELIS records</span></div>
                                <label for="enq_search_value" class="form-label eq-form-label d-block"><i class="fas fa-keyboard me-2"></i>Search Value</label>
                                <div class="eq-input-wrap input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" class="form-control" id="enq_search_value" name="enq_search_value" placeholder="Enter job number, case number, GLPIN or name..." oninput="this.value = this.value.toUpperCase()" required>
                                    <button type="submit" class="btn eq-btn-search" id="btnEnquiryJobSearch"><i class="fas fa-search me-2"></i>Search Applications</button>
                                </div>
                                <div class="invalid-feedback">Please select a search type and enter a search term.</div>
                                <div class="eq-tip"><i class="fas fa-lock me-1"></i>Use the exact application reference or applicant name for best results.</div>
                            </div>
                        </form>
                        <div class="alert alert-danger border border-danger mt-3 mb-0 p-3 d-none" id="enquiry_alert" role="alert">
                            <div class="d-flex align-items-start gap-2">
                                <i class="fas fa-exclamation-circle fs-5 mt-1"></i>
                                <div class="flex-grow-1"><div class="fw-bold">No Results Found</div><div class="small">Try using a different search term or criteria.</div></div>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="eq-card" id="enq-search-results-section" style="display: none;" aria-labelledby="enquiryResultsTitle">
                    <div class="eq-card-header">
                        <div class="d-flex align-items-center gap-3">
                            <span class="eq-header-icon"><i class="fas fa-table"></i></span>
                            <div><h2 id="enquiryResultsTitle">Matching Applications</h2><small id="resultsCount">0 applications found</small></div>
                        </div>
                        <div class="eq-results-tools">
                            <button type="button" class="btn eq-tool-btn" id="btnExportResults"><i class="fas fa-download me-2"></i>Export</button>
                            <button type="button" class="btn eq-tool-btn" id="btnPrintResults"><i class="fas fa-print me-2"></i>Print</button>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 eq-table" id="enq-search-results-table">
                                <thead><tr>
                                    <th class="text-nowrap"><i class="fas fa-user me-2"></i>Applicant</th>
                                    <th class="text-nowrap"><i class="fas fa-folder me-2"></i>Case Number</th>
                                    <th class="text-nowrap"><i class="fas fa-hashtag me-2"></i>Job Number</th>
                                    <th class="text-nowrap"><i class="fas fa-fingerprint me-2"></i>GLPIN</th>
                                    <th class="text-nowrap"><i class="fas fa-map-marker-alt me-2"></i>Locality</th>
                                    <th class="text-nowrap"><i class="fas fa-map-pin me-2"></i>Regional Number</th>
                                    <th class="text-center text-nowrap"><i class="fas fa-cogs me-2"></i>Actions</th>
                                </tr></thead>
                                <tbody class="align-middle">
                                    <tr id="noResultsRow" style="display: none;"><td colspan="7" class="text-center py-5">
                                        <div class="d-flex flex-column align-items-center"><i class="fas fa-search fa-3x text-muted mb-3"></i><h6 class="fw-semibold mb-2">No applications found</h6><p class="text-muted small mb-0">Try adjusting your search criteria</p></div>
                                    </td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="eq-results-footer">
                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                            <div class="text-muted small" id="tableInfo">Showing <span id="currentCount">0</span> of <span id="totalCount">0</span> applications</div>
                            <div class="d-flex gap-2" id="paginationControls" style="display: none;">
                                <button type="button" class="btn btn-sm btn-outline-primary" id="btnPrevPage" aria-label="Previous page"><i class="fas fa-chevron-left"></i></button>
                                <span class="align-self-center small fw-medium">Page <span id="currentPage">1</span></span>
                                <button type="button" class="btn btn-sm btn-outline-primary" id="btnNextPage" aria-label="Next page"><i class="fas fa-chevron-right"></i></button>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
</div>
