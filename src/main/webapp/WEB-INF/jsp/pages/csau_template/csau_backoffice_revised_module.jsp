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

<div class="main-content app-content elis-open-green">
 <div class="container-fluid page-container">
  <div class="page-header-breadcrumb mb-4">
   <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
    <div><div class="elis-eyebrow"><i class="fas fa-layer-group me-1"></i> ELIS • CASE MANAGEMENT</div><h1 class="page-title fw-semibold mb-1"><i class="fas fa-folder-open me-2"></i>Open Application</h1><p class="mb-0 elis-header-subtitle"><i class="ri-information-line me-1"></i>View and manage job applications.</p></div>
    <ol class="breadcrumb mb-0"><li class="breadcrumb-item"><a href="#">ELIS</a></li><li class="breadcrumb-item active" aria-current="page">Open Application</li></ol>
   </div>
  </div>
  <div class="row g-4">
   <div class="col-lg-8">
    <div class="card elis-card mb-4">
     <div class="card-header elis-card-header"><h5 class="mb-0"><i class="fas fa-search me-2"></i>Search for Job Applications</h5></div>
     <div class="card-body p-4"><div class="tab-content">
      <div class="tab-pane fade show active" id="search-jobs" role="tabpanel"><div id="searchJobErrorAlert"></div><label for="scm_job_number_search" class="form-label fw-semibold">Job Number</label><div class="row g-3"><div class="col-md-10"><div class="input-group"><span class="input-group-text"><i class="fas fa-briefcase"></i></span><input type="text" class="form-control" id="scm_job_number_search" placeholder="Enter Job Number" oninput="this.value = this.value.toUpperCase()"></div></div><div class="col-md-2"><button type="button" class="btn btn-elis-primary w-100" id="btn_scm_job_number_search_open"><i class="fas fa-search me-1"></i>Search</button></div></div></div>
      <div class="tab-pane fade" id="view-batchlist" role="tabpanel"><div class="text-center py-4"><i class="fas fa-list fa-3x elis-icon mb-3"></i><h6 class="fw-semibold">View and manage your batch lists</h6><p class="text-muted small mb-3">Access your saved batch lists and continue processing</p><button type="button" class="btn btn-elis-primary" id="btnViewBatchlist"><i class="fas fa-eye me-1"></i>View Batch Lists</button></div></div>
     </div></div>
    </div>
    <div class="card elis-card mb-4">
     <div class="card-header elis-card-header d-flex justify-content-between align-items-center"><h5 class="mb-0"><i class="fas fa-folder-open me-2"></i>Application Details</h5><span class="elis-header-pill"><i class="fas fa-table me-1"></i>Application records</span></div>
     <div class="card-body p-3 p-md-4"><div class="table-responsive"><table class="table table-hover align-middle elis-app-table" id="tbl_search_for_job_details_datatable" width="100%"><thead><tr><th>Job Number</th><th>Applicant Name</th><th>Application Type</th><th>Status</th><th class="text-center">Action</th></tr></thead><tbody>
      <c:forEach items="${applicationlist}" var="appfiles"><tr class="${appfiles.objections > 0 ? 'elis-objection-row' : ''}" data-bs-toggle="${appfiles.objections > 0 ? 'tooltip' : ''}" data-bs-placement="left" title="${appfiles.objections > 0 ? 'Application has pending Objections' : ''}"><td><span class="fw-semibold elis-job-number">${appfiles.job_number}</span></td><td><div class="d-flex align-items-center"><span class="elis-user-avatar me-2"><i class="fas fa-user"></i></span><span data-bs-toggle="tooltip" data-bs-placement="top" title="${fn:length(appfiles.ar_name) > 20 ? appfiles.ar_name : ''}">${fn:substring(appfiles.ar_name, 0, 20)}${fn:length(appfiles.ar_name) > 20 ? "..." : ""}</span></div></td><td><span class="badge elis-type-badge">${appfiles.business_process_sub_name}</span></td><td><span data-bs-toggle="tooltip" data-bs-placement="top" title="${fn:length(appfiles.current_application_status) > 20 ? appfiles.current_application_status : ''}" class="badge ${appfiles.objections > 0 ? 'elis-status-objection' : 'elis-status-normal'}"><i class="fas fa-circle me-1 small"></i>${fn:substring(appfiles.current_application_status, 0, 20)}${fn:length(appfiles.current_application_status) > 20 ? "..." : ""}</span></td><td class="text-center"><form action="registration_application_progress_details" method="post" class="d-inline"><input type="hidden" name="case_number" value="${appfiles.transaction_number}"><input type="hidden" name="job_number" value="${appfiles.job_number}"><input type="hidden" name="business_process_sub_name" value="${appfiles.business_process_sub_name}"><button type="submit" name="save" class="btn btn-elis-outline btn-sm"><i class="fas fa-folder-open me-1"></i>Work</button></form></td></tr></c:forEach>
      <c:if test="${empty applicationlist}"><tr><td colspan="5" class="text-center py-5"><i class="fas fa-inbox fa-3x elis-empty-icon mb-3"></i><h6 class="fw-semibold text-muted">No Applications Found</h6><p class="text-muted small mb-0">Search for a job number to view applications</p></td></tr></c:if>
     </tbody></table></div></div>
    </div>
   </div>
   <div class="col-lg-4"><div class="card elis-card mb-4"><div class="card-header elis-card-header"><h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Instructions</h5></div><div class="card-body p-4"><div class="elis-guide-item"><span class="elis-guide-icon"><i class="fas fa-check"></i></span><span>Enter Job Number in the search field and click <strong>Search</strong>.</span></div><div class="elis-guide-item"><span class="elis-guide-icon"><i class="fas fa-check"></i></span><span>Click the <strong>Work</strong> button to open the application.</span></div></div></div></div>
  </div>
 </div>
</div>

<style>
.elis-open-green{--elis-dark:#064b39;--elis-primary:#087f5b;--elis-bright:#0ba26f;--elis-pale:#e8f7ee;--elis-border:#d2eadc;--elis-ink:#173f32;color:var(--elis-ink)}
.elis-open-green .page-header-breadcrumb{padding:1.65rem 1.85rem;border-radius:1.15rem;background:radial-gradient(circle at 92% 10%,rgba(255,255,255,.15),transparent 30%),linear-gradient(120deg,#064b39 0%,#087f5b 60%,#0ba26f 100%);box-shadow:0 12px 28px rgba(6,75,57,.18)}
.elis-open-green .page-header-breadcrumb .page-title{font-size:1.4rem;color:#fff!important}.elis-open-green .elis-eyebrow{font-size:.72rem;letter-spacing:.11em;font-weight:700;color:#c4f4db;margin-bottom:.35rem}.elis-open-green .elis-header-subtitle{color:#d8f7e8}.elis-open-green .breadcrumb-item,.elis-open-green .breadcrumb-item.active,.elis-open-green .breadcrumb-item a{color:#f2fff8!important}.elis-open-green .breadcrumb-item+.breadcrumb-item::before{color:#b6e8d1}
.elis-open-green .elis-card{border:1px solid var(--elis-border)!important;border-radius:1rem;overflow:hidden;box-shadow:0 8px 25px rgba(6,75,57,.07)!important;background:#fff}
.elis-open-green .elis-card-header{background:linear-gradient(105deg,#064b39,#087f5b)!important;color:#fff!important;padding:1rem 1.25rem;border:0!important}.elis-open-green .elis-card-header h5{color:#fff!important;font-size:1rem;font-weight:650}.elis-open-green .elis-header-pill{border:1px solid rgba(255,255,255,.28);border-radius:2rem;padding:.3rem .65rem;font-size:.73rem;color:#fff;background:rgba(255,255,255,.13)}
.elis-open-green .form-label{color:#205944}.elis-open-green .form-control,.elis-open-green .form-select{border-color:#cddfd5;border-radius:.55rem;min-height:42px}.elis-open-green .form-control:focus,.elis-open-green .form-select:focus{border-color:var(--elis-bright);box-shadow:0 0 0 .2rem rgba(11,162,111,.14)}.elis-open-green .input-group-text{color:var(--elis-primary);background:var(--elis-pale);border-color:#cddfd5}
.elis-open-green .btn-elis-primary{background:linear-gradient(110deg,#087f5b,#0ba26f);border:1px solid #087f5b;color:#fff;font-weight:600;border-radius:.55rem;box-shadow:0 4px 12px rgba(8,127,91,.15)}.elis-open-green .btn-elis-primary:hover{background:linear-gradient(110deg,#064b39,#087f5b);color:#fff;transform:translateY(-1px)}.elis-open-green .btn-elis-outline{color:#087f5b;border:1px solid #087f5b;background:#f4fcf7;border-radius:.5rem;font-weight:600}.elis-open-green .btn-elis-outline:hover{color:#fff;background:#087f5b}
.elis-open-green .elis-app-table{border-collapse:separate;border-spacing:0}.elis-open-green .elis-app-table thead th{background:#e8f7ee!important;color:#07563d!important;font-weight:700;border-bottom:2px solid #a9d9bd;white-space:nowrap;padding:1rem .8rem}.elis-open-green .elis-app-table tbody td{padding:.9rem .8rem;border-bottom:1px solid #edf4ef;vertical-align:middle}.elis-open-green .elis-app-table tbody tr:hover td{background:#f0faf4}.elis-open-green .elis-app-table .elis-objection-row td{background:#fff4f2}.elis-open-green .elis-job-number{color:#075b41}.elis-open-green .elis-user-avatar{display:inline-flex;align-items:center;justify-content:center;width:34px;height:34px;border-radius:50%;background:#e6f5ec;color:#087f5b;flex-shrink:0}.elis-open-green .elis-type-badge{background:#e6f5ec;color:#087f5b;border:1px solid #c7e7d4;padding:.55rem .7rem;font-weight:600}.elis-open-green .elis-status-normal{background:#e6f5ec;color:#087f5b;padding:.55rem .7rem}.elis-open-green .elis-status-objection{background:#fff0ee;color:#b53a2d;padding:.55rem .7rem}.elis-open-green .elis-empty-icon,.elis-open-green .elis-icon{color:#087f5b}
.elis-open-green .elis-guide-item{display:flex;align-items:flex-start;gap:.75rem;padding:.85rem 0;border-bottom:1px solid #e9f4ec;font-size:.9rem;line-height:1.6}.elis-open-green .elis-guide-item:last-child{border-bottom:0}.elis-open-green .elis-guide-icon{display:inline-flex;align-items:center;justify-content:center;width:26px;height:26px;border-radius:50%;background:#e8f7ee;color:#087f5b;flex-shrink:0}
.elis-open-green .dataTables_filter input,.elis-open-green .dataTables_length select{border:1px solid #cddfd5;border-radius:.45rem;padding:.4rem .6rem;outline:none}.elis-open-green .dataTables_filter input:focus{border-color:#0ba26f;box-shadow:0 0 0 .18rem rgba(11,162,111,.12)}.elis-open-green .dataTables_wrapper .dataTables_paginate .paginate_button.current,.elis-open-green .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover{background:#087f5b!important;border-color:#087f5b!important;color:#fff!important}.elis-open-green .pagination .page-item.active .page-link{background:#087f5b;border-color:#087f5b}.elis-open-green .pagination .page-link{color:#087f5b}
@media(max-width:767.98px){.elis-open-green .page-header-breadcrumb{padding:1.25rem}.elis-open-green .elis-card-header{padding:.9rem 1rem}.elis-open-green .elis-header-pill{display:none}.elis-open-green .dataTables_wrapper>div{flex-wrap:wrap;gap:.75rem}}
</style>

<script>
$(document).ready(function() {
    if ($.fn.DataTable && !$.fn.DataTable.isDataTable('#tbl_search_for_job_details_datatable')) {
        $('#tbl_search_for_job_details_datatable').DataTable({
            responsive: true,
            pageLength: 10,
            language: {
                search: '_INPUT_', searchPlaceholder: 'Search...',
                lengthMenu: 'Show _MENU_ entries',
                info: 'Showing _START_ to _END_ of _TOTAL_ entries',
                paginate: {first:'<i class="fas fa-angle-double-left"></i>',previous:'<i class="fas fa-angle-left"></i>',next:'<i class="fas fa-angle-right"></i>',last:'<i class="fas fa-angle-double-right"></i>'}
            },
            dom: '<"d-flex justify-content-between align-items-center mb-3"<"d-flex"l><"d-flex"f>>rt<"d-flex justify-content-between align-items-center mt-3"<"d-flex"i><"d-flex"p>>'
        });
    }
    if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
        document.querySelectorAll('.elis-open-green [data-bs-toggle="tooltip"]').forEach(function(el) {
            if (!bootstrap.Tooltip.getInstance(el)) new bootstrap.Tooltip(el);
        });
    }
    $('#btn_scm_job_number_search_open, #btn_scm_job_number_search').on('click', function() {
        var jobNumber = $('#scm_job_number_search').val();
        if (jobNumber) { console.log('Searching for job number:', jobNumber); }
        else { $('#searchJobErrorAlert').html('<div class="alert alert-warning alert-dismissible fade show" role="alert"><i class="fas fa-exclamation-triangle me-2"></i>Please enter a job number to search.<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>'); }
    });
    $('#btnViewBatchlist, #btnViewBatchlistSidebar').on('click', function() { console.log('View Batch List clicked'); });
    $('#confirmAddToBatch').on('click', function() {
        var purpose = $('#batchPurpose').val();
        if (!purpose) { alert('Please enter a batch purpose'); return; }
        console.log('Adding to batch with purpose:', purpose);
        $('#askForPurposeOfBatching').modal('hide');
        var successAlert = '<div class="alert alert-success alert-dismissible fade show position-fixed bottom-0 end-0 m-3" role="alert" style="z-index:9999;min-width:300px"><i class="fas fa-check-circle me-2"></i>Application successfully added to batch list.<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>';
        $('body').append(successAlert);
        $('#batchPurpose, #batchNotes').val('');
    });
    $('#askForPurposeOfBatching').on('hidden.bs.modal', function() { $('#batchPurpose, #batchNotes').val(''); });
    $('#scm_job_number_search').on('keypress', function(e) { if (e.which === 13) $('#btn_scm_job_number_search_open').click(); });
});
</script>
