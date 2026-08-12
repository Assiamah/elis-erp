<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>

<style>
    .crb-destination-card {
        border: 1px solid #e2e8f0 !important;
        border-radius: 20px;
        box-shadow: 0 18px 45px rgba(15, 23, 42, 0.09) !important;
        overflow: hidden;
    }

    .crb-card-header {
        background: linear-gradient(135deg, #0f766e 0%, #0d9488 55%, #14b8a6 100%);
        padding: 1.5rem 1.75rem;
        position: relative;
    }

    .crb-card-header::after {
        background: rgba(255, 255, 255, 0.08);
        border-radius: 50%;
        content: "";
        height: 150px;
        position: absolute;
        right: -45px;
        top: -70px;
        width: 150px;
    }

    .crb-header-icon {
        align-items: center;
        background: rgba(255, 255, 255, 0.18);
        border: 1px solid rgba(255, 255, 255, 0.28);
        border-radius: 14px;
        display: flex;
        height: 48px;
        justify-content: center;
        width: 48px;
    }

    .crb-card-body {
        background: #ffffff;
        padding: 1.5rem 1.75rem 1.75rem;
    }

    .crb-card-body .form-label {
        color: #334155 !important;
        font-size: 0.82rem;
        letter-spacing: 0.01em;
        margin-bottom: 0.5rem;
    }

    .crb-card-body .form-control,
    .crb-card-body .form-select {
        border-color: #dbe3ec;
        border-radius: 10px;
        min-height: 44px;
    }

    .crb-card-body .form-control:focus,
    .crb-card-body .form-select:focus {
        border-color: #14b8a6;
        box-shadow: 0 0 0 0.2rem rgba(20, 184, 166, 0.13);
    }

    #crb_batch_target_tabs {
        background: #f1f5f9;
        border: 0;
        border-radius: 12px;
        gap: 6px;
        padding: 6px;
    }

    #crb_batch_target_tabs .nav-link {
        border: 0;
        border-radius: 9px;
        color: #64748b;
        padding: 0.7rem 1rem;
        transition: background-color 0.2s ease, color 0.2s ease, box-shadow 0.2s ease;
        width: 100%;
    }

    #crb_batch_target_tabs .nav-link.active {
        background: #ffffff;
        box-shadow: 0 4px 12px rgba(15, 118, 110, 0.13);
        color: #0f766e;
    }

    .crb-individual-panel {
        background: #f0fdfa;
        border: 1px solid #ccfbf1;
        border-radius: 12px;
        padding: 1rem;
    }

    .crb-process-button {
        background: linear-gradient(135deg, #0f766e, #14b8a6);
        border: 0;
        border-radius: 11px;
        box-shadow: 0 8px 18px rgba(15, 118, 110, 0.2);
        color: #ffffff;
        min-height: 46px;
    }

    .crb-process-button:hover,
    .crb-process-button:focus {
        background: linear-gradient(135deg, #115e59, #0d9488);
        color: #ffffff;
        transform: translateY(-1px);
    }
</style>


      <!-- Start::app-content -->
<div class="main-content app-content">
  <div class="container-fluid page-container">

    <!-- Start::page-header -->
    <div class="page-header-breadcrumb mb-3">
        <div class="d-flex align-center justify-content-between flex-wrap">
            <div>
                <h1 class="page-title fw-medium fs-18 mb-1">
        <i class="ri-arrow-left-right-line text-warning me-1"></i>Cross Regional Batch
      </h1>
                <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Transfer Application Data from one region to another</p>
            </div>
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                <li class="breadcrumb-item active" aria-current="page">Cross Regional Batch</li>
            </ol>
        </div>
    </div>  
  
 <div class="row g-4">
    <!-- Search Section -->
    <div class="col-lg-6">
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header bg-white border-0 pt-4 pb-0">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-primary bg-opacity-10 p-3 me-3">
                        <i class="fa fa-search text-primary fa-fw"></i>
                    </div>
                    <div>
                        <h5 class="mb-1 fw-bold">Job Search</h5>
                        <p class="text-muted small mb-0">Search and filter job records</p>
                    </div>
                </div>
            </div>
            
            <div class="card-body pt-4">
                <form id="frmEnquiryJobSearch" method="post">
                    <!-- Search Type Radio Buttons -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold text-secondary mb-3">
                            <i class="fa fa-filter me-2 text-primary"></i>Search By:
                        </label>
                        <div class="d-flex flex-wrap gap-4">
                            <div class="form-check">
                                <input type="radio" id="rbtn_search_type1" name="rbtn_search_type" 
                                       class="form-check-input" value="job_number" required>
                                <label class="form-check-label" for="rbtn_search_type1">
                                    <i class="fa fa-hashtag me-1 text-muted"></i>Job Number
                                </label>
                            </div>
                            <div class="form-check">
                                <input type="radio" id="rbtn_search_type2" name="rbtn_search_type" 
                                       class="form-check-input" value="applicant_name">
                                <label class="form-check-label" for="rbtn_search_type2">
                                    <i class="fa fa-user me-1 text-muted"></i>Applicant Name
                                </label>
                            </div>
                            <div class="form-check">
                                <input type="radio" id="rbtn_search_type3" name="rbtn_search_type" 
                                       class="form-check-input" value="case_number">
                                <label class="form-check-label" for="rbtn_search_type3">
                                    <i class="fa fa-folder me-1 text-muted"></i>Case Number
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Search Input -->
                    <div class="row g-2">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0">
                                    <i class="fa fa-search text-muted"></i>
                                </span>
                                <input class="form-control border-start-0 ps-0" 
                                       id="enq_search_value" name="enq_search_value" 
                                       type="text" placeholder="Enter job number, applicant name, or case number..." 
                                       required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary w-100" id="btnEnquiryJobSearch">
                                <i class="fa fa-search me-2"></i>Search
                            </button>
                        </div>
                    </div>
                </form>
                
                <!-- Alert Message -->
                <div class="alert alert-danger alert-dismissible fade show d-none mt-4" 
                     id="enquiry_alert" role="alert">
                    <i class="fa fa-exclamation-triangle me-2"></i>
                    No results found for your search criteria.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Regional Batching Section -->
    <div class="col-lg-6">
        <div class="card crb-destination-card mb-4">
            <div class="crb-card-header text-white">
                <div class="d-flex align-items-center position-relative" style="z-index: 1;">
                    <div class="crb-header-icon me-3">
                        <i class="fa fa-sitemap text-white fa-fw"></i>
                    </div>
                    <div>
                        <h5 class="mb-1 fw-bold text-white">Regional Batching</h5>
                        <p class="small mb-0" style="color: rgba(255,255,255,.78);">Choose where the selected applications should be sent</p>
                    </div>
                </div>
            </div>
            <div class="card-body crb-card-body">
                <div class="row g-3">
                    <!-- Destination Type Tabs -->
                    <div class="col-12">
                        <label class="form-label text-white fw-semibold">
                            <i class="fa fa-random me-2"></i>Batch To
                        </label>
                        <input type="hidden" id="crb_batch_target_type" value="Unit">
                        <ul class="nav nav-tabs nav-fill" id="crb_batch_target_tabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button type="button" class="nav-link active fw-semibold"
                                        data-crb-target="Unit" role="tab" aria-selected="true">
                                    <i class="fa fa-cubes me-2"></i>Unit
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button type="button" class="nav-link fw-semibold"
                                        data-crb-target="Individual" role="tab" aria-selected="false">
                                    <i class="fa fa-user me-2"></i>Individual
                                </button>
                            </li>
                        </ul>
                    </div>

                    <!-- Region Selection -->
                    <div class="col-12">
                        <label class="form-label text-white fw-semibold">
                            <i class="fa fa-globe me-2"></i>Select Region
                        </label>
                        <select id="get_change_region_compliance_crb" class="form-select" required>
                            <option selected disabled>-- Select Region --</option>
                            <c:forEach items="${officeregionlist}" var="officeregion">
                                <option value="${officeregion.ord_region_code}">
                                    ${officeregion.ord_region_name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Division and Unit -->
                    <div class="col-md-6">
                        <label class="form-label text-white fw-semibold">
                            <i class="fa fa-building me-2"></i>Division
                        </label>
                        <select id="unit_division_to_send_to_crb" class="form-select">
                            <option value="none">-- Select Division --</option>
                            <option value="LVD">LVD</option>
                            <option value="LRD">LRD</option>
                            <option value="PVLMD">PVLMD</option>
                            <option value="SMD">SMD</option>
                            <option value="RLO">RLO</option>
                            <option value="CORPORATE">CORPORATE</option>
                        </select>
                    </div>
                    
                    <div class="col-md-6">
                        <label class="form-label text-white fw-semibold">
                            <i class="fa fa-cubes me-2"></i>Unit
                        </label>
                        <input autocomplete="off" class="form-control" id="unit_to_send_to_crb" 
                               type="text" list="listofunitsbatching" 
                               placeholder="Select or enter unit" required>
                        <datalist id="listofunitsbatching"></datalist>
                    </div>

                    <div class="col-12 d-none" id="crb_individual_batching">
                        <div class="crb-individual-panel">
                        <label class="form-label text-white fw-semibold" for="user_to_send_to_crb">
                            <i class="fa fa-user me-2"></i>Individual
                        </label>
                        <input autocomplete="off" class="form-control" id="user_to_send_to_crb"
                               type="text" list="listofusersbatching_crb"
                               placeholder="Select an individual" required disabled>
                        <datalist id="listofusersbatching_crb"></datalist>
                        <div class="form-text text-muted">Individuals are loaded from the selected regional unit.</div>
                        </div>
                    </div>
                    
                    <!-- Purpose and Remarks -->
                    <div class="col-12">
                        <label class="form-label text-white fw-semibold">
                            <i class="fa fa-tag me-2"></i>Sent Purpose
                        </label>
                        <select name="bl_job_purpose_new" id="bl_job_purpose_new" 
                                class="form-select">
                            <!-- Options will be populated dynamically -->
                        </select>
                    </div>
                    
                    <div class="col-12">
                        <label class="form-label text-white fw-semibold">
                            <i class="fa fa-sticky-note me-2"></i>Remarks/Notes
                        </label>
                        <textarea rows="2" class="form-control" 
                                  id="bl_remarks_notes" 
                                  placeholder="Enter any additional notes or remarks..."></textarea>
                    </div>
                    
                    <!-- Process Button -->
                    <div class="col-12 mt-3">
                        <button type="submit" class="btn crb-process-button w-100 fw-semibold py-2"
                                id="btn_process_batchlist_crb">
                            <i class="fa fa-play-circle me-2"></i>Process Batch
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Search Results Section -->
<div class="row mt-2">
    <div class="col-12">
        <div class="card shadow-sm border-0" id="enq-search-results-section">
            <div class="card-header bg-white border-0 pt-4 pb-0">
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-info bg-opacity-10 p-3 me-3">
                            <i class="fa fa-table text-info fa-fw"></i>
                        </div>
                        <div>
                            <h5 class="mb-1 fw-bold">Search Results</h5>
                            <p class="text-muted small mb-0">Showing maximum 10 records</p>
                        </div>
                    </div>
                    <button type="button" id="btn-remove-all" class="btn btn-outline-danger">
                        <i class="fa fa-trash-alt me-2"></i>Remove All
                    </button>
                </div>
            </div>
            
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle" id="tbl-appData_tranfer">
                        <thead class="table-light">
                            <tr>
                                <th class="fw-semibold">
                                    <i class="fa fa-user me-2 text-muted"></i>Applicant Name
                                </th>
                                <th class="fw-semibold">
                                    <i class="fa fa-folder me-2 text-muted"></i>Case Number
                                </th>
                                <th class="fw-semibold">
                                    <i class="fa fa-hashtag me-2 text-muted"></i>Job Number
                                </th>
                                <th class="fw-semibold">
                                    <i class="fa fa-tag me-2 text-muted"></i>Application Type
                                </th>
                                <th class="fw-semibold">
                                    <i class="fa fa-map-marker me-2 text-muted"></i>Locality
                                </th>
                                <th class="fw-semibold">
                                    <i class="fa fa-hashtag me-2 text-muted"></i>Regional Number
                                </th>
                                <th class="fw-semibold">
                                    <i class="fa fa-cog me-2 text-muted"></i>Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Table content will be populated dynamically -->
                            <!-- <tr class="" id="no-results-row">
                                <td colspan="7" class="text-center text-muted py-5">
                                    <i class="fa fa-search fa-3x mb-3 opacity-50"></i>
                                    <p class="mb-0">No results to display. Use the search form above.</p>
                                </td>
                            </tr> -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</div>

</div>
</div>
