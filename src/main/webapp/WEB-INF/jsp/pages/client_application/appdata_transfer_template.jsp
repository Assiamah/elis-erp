<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


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
    
    <!-- Regional Unit Batching Section -->
    <div class="col-lg-6">
        <div class="card shadow-sm border-0 mb-4 bg-success text-white" style="background: linear-gradient(135deg, #28a745 0%, #20c997 100%);">
            <div class="card-body">
                <div class="d-flex align-items-center mb-4">
                    <div class="rounded-circle bg-white bg-opacity-25 p-3 me-3">
                        <i class="fa fa-sitemap text-success fa-fw"></i>
                    </div>
                    <div>
                        <h5 class="mb-1 fw-bold text-white">Regional Unit Batching</h5>
                        <p class="text-white-50 small mb-0">Batch jobs to regional units</p>
                    </div>
                </div>
                
                <div class="row g-3">
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
                        <button type="submit" class="btn btn-warning w-100 fw-semibold py-2" 
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
                            <tr class="" id="no-results-row">
                                <td colspan="7" class="text-center text-muted py-5">
                                    <i class="fa fa-search fa-3x mb-3 opacity-50"></i>
                                    <p class="mb-0">No results to display. Use the search form above.</p>
                                </td>
                            </tr>
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
 