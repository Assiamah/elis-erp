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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />

<%-- Colour-only rules: preserve template sizing, positioning and JS behaviour. --%>
<%-- Staff Case Management: colour-only emerald theme.
     Include immediately before the page's main-content element.
     Does not change widths, display, margins, positioning, or JavaScript. --%>
<style>
/* Scoped to the Staff Case Management page only. */
.staff-case-green {
    --scg-deep: #07543f;
    --scg-forest: #087453;
    --scg-emerald: #0b9569;
    --scg-mint: #e8f7ef;
    --scg-border: #d4eadf;
}
.staff-case-green .page-header-breadcrumb {
    background: transparent !important;
    border-color: transparent !important;
}
.staff-case-green .staff-case-title-card {
    background: linear-gradient(110deg, #07543f, #0b9569) !important;
    border: 1px solid #087453;
    border-radius: 12px;
    padding: 18px 22px;
    box-shadow: 0 5px 15px rgba(7, 84, 63, 0.14);
}
.staff-case-green .page-header-breadcrumb .page-title,
.staff-case-green .page-header-breadcrumb .breadcrumb-item,
.staff-case-green .page-header-breadcrumb .breadcrumb-item.active,
.staff-case-green .page-header-breadcrumb .breadcrumb-item a {
    color: #fff !important;
}
.staff-case-green .page-header-breadcrumb .breadcrumb-item + .breadcrumb-item::before {
    color: #bfead5 !important;
}
.staff-case-green .custom-card:not(.bg-info-transparent) > .card-header {
    background: linear-gradient(110deg,#07543f,#0b9569) !important;
    border-bottom-color: #087453 !important;
    color: #fff !important;
}
.staff-case-green .custom-card:not(.bg-info-transparent) > .card-header .card-title,
.staff-case-green .custom-card:not(.bg-info-transparent) > .card-header h5,
.staff-case-green .custom-card:not(.bg-info-transparent) > .card-header .text-muted,
.staff-case-green .custom-card:not(.bg-info-transparent) > .card-header a {
    color: #fff !important;
}
.staff-case-green .custom-card.bg-info-transparent {
    background-color: #e8f7ef !important;
    border-color: #d4eadf !important;
    color: #07543f !important;
}
.staff-case-green .custom-card.bg-info-transparent .avatar.bg-info {
    background-color: #0b9569 !important;
}
.staff-case-green .top-customers-list .bg-primary-transparent {
    background-color: #e8f7ef !important;
    color: #087453 !important;
}
.staff-case-green .top-customers-list .bg-primary-transparent i { color: #087453 !important; }
.staff-case-green .top-customers-list li:hover { background-color: #f0faf4 !important; }
.staff-case-green #applicationTable thead,
.staff-case-green #applicationTable thead.table-light,
.staff-case-green #applicationTable thead th {
    background-color: #087453 !important;
    color: #fff !important;
    border-color: #087453 !important;
}
.staff-case-green #applicationTable tbody tr:not(.table-danger):hover td {
    background-color: #f0faf4 !important;
}
/* Preserve objection warning rows and overdue/danger buttons. */
.staff-case-green #applicationTable tbody tr.table-danger td {
    background-color: var(--bs-table-bg, #f8d7da) !important;
}
.staff-case-green #applicationTable .text-primary,
.staff-case-green #applicationTable .fw-bold.text-primary { color: #087453 !important; }
.staff-case-green .btn-primary,
.staff-case-green .btn-info,
.staff-case-green .btn-success {
    background-color: #0b9569 !important;
    border-color: #0b9569 !important;
    color: #fff !important;
}
.staff-case-green .btn-primary:hover,
.staff-case-green .btn-info:hover,
.staff-case-green .btn-success:hover {
    background-color: #07543f !important;
    border-color: #07543f !important;
}
.staff-case-green .btn-outline-dark {
    border-color: #087453 !important;
    color: #087453 !important;
}
.staff-case-green .btn-outline-dark:hover {
    background-color: #087453 !important;
    color: #fff !important;
}
.staff-case-green .dropdown-menu .dropdown-item:hover,
.staff-case-green .dropdown-menu .dropdown-item:focus {
    background-color: #e8f7ef !important;
    color: #07543f !important;
}
.staff-case-green .form-control:focus,
.staff-case-green .form-select:focus {
    border-color: #0b9569 !important;
    box-shadow: 0 0 0 .2rem rgba(11,149,105,.13) !important;
}
.staff-case-green .page-link { color: #087453 !important; }
.staff-case-green .page-item.active .page-link {
    background-color: #087453 !important;
    border-color: #087453 !important;
    color: #fff !important;
}
.staff-case-green .dataTables_wrapper .dt-button:hover {
    border-color: #0b9569 !important;
    color: #07543f !important;
}
</style>

<div class="main-content app-content staff-case-green">
    <div class="container-fluid page-container">
        <div class="page-header-breadcrumb mb-3">
            <div class="staff-case-title-card">
              <div class="d-flex align-center justify-content-between flex-wrap">
                <div><h1 class="page-title fw-medium fs-18 mb-1">Staff Case Management</h1></div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Staff Case Management</li>
                </ol>
              </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xl-3">
                <div class="card custom-card bg-info-transparent border-0 shadow-none">
                    <div class="card-body">
                        <div class="d-flex align-items-start gap-3 flex-wrap">
                            <div class="lh-1">
                                <span class="avatar avatar-lg avatar-rounded bg-info svg-white">
                                    <i class="ri-download-2-line fs-5"></i>
                                </span>
                            </div>
                            <div>
                                <span class="d-block mb-1">Incoming Applications</span>
                                <div class="d-flex align-items-center gap-2"><h5 class="fw-semibold mb-0">${applicationlist.size()}</h5></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card custom-card">
                    <div class="card-header justify-content-between">
                        <div><h5 class="card-title mb-0">Application List</h5></div>
                        <a href="javascript:void(0);" class="text-muted fs-12 text-decoration-underline">View All<i class="ti ti-arrow-narrow-right"></i></a>
                    </div>
                    <div class="card-body" style="max-height: 800px; overflow-y: auto;">
                        <ul class="list-unstyled top-customers-list">
                            <c:forEach items="${applicationlist}" var="appfiles" varStatus="loop">
                                <li>
                                    <div class="d-flex align-items-center gap-3 flex-wrap">
                                        <div class="lh-1"><span class="avatar avatar-md bg-primary-transparent"><i class="ri-folder-open-line"></i></span></div>
                                        <div class="flex-fill">
                                            <span class="d-block fw-semibold">${appfiles.job_number}</span>
                                            <span class="fs-12 text-muted">${fn:substring(appfiles.ar_name, 0, 20)}${fn:length(appfiles.ar_name) > 20 ? '...' : ''}</span>
                                        </div>
                                        <div class="text-end">
                                            <fmt:parseDate value="${appfiles.job_datesend}" pattern="yyyy-MM-dd" var="parsedJobDateSend"/>
                                            <fmt:formatDate value="${parsedJobDateSend}" pattern="dd MMM yyyy" var="formattedParsedJobDateSend"/>
                                            <span class="fs-12 text-muted">${formattedParsedJobDateSend}</span>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-xl-9">
                <div class="card custom-card">
                    <div class="card-header justify-content-between">
                        <div>
                            <h5 class="card-title mb-0">My Applications</h5>
                            <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Applications assigned to you</p>
                        </div>
                        <div class="d-flex flex-wrap gap-2">
                            <button class="btn btn-warning btn-sm" id="btnViewBatchlist"><i class="ri-list-check fs-13"></i> View Batch List</button>
                            <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#awaitingInspectionApplicationsModal"><i class="bi bi-eyeglasses fs-13"></i> Awaiting Inspection [ <span class="fw-semibold">${total_inspection}</span> ]</button>
                            <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#batchedApplicationsModal"><i class="ri-folders-line fs-13"></i> Batched Applications [ <span class="fw-semibold">${applicationlist_all.size() > 0 ? applicationlist_all.size() : 0}</span> ]</button>
                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#appsPassedDueModal"><i class="ri-error-warning-line fs-13"></i> Overdue Applications</button>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-dark dropdown-toggle" type="button" data-bs-toggle="dropdown"><i class="fas fa-ellipsis-v me-2"></i> More</button>
                                <ul class="dropdown-menu" style="min-width: 250px;">
                                    <li><a class="dropdown-item small" href="#" data-bs-toggle="modal" data-bs-target="#appsReceivedMonthModal"><i class="fas fa-inbox me-2"></i>This Month's Received</a></li>
                                    <li><a class="dropdown-item small" href="#" data-bs-toggle="modal" data-bs-target="#appsCompletedMonthModal"><i class="fas fa-check-circle me-2"></i>This Month's Completed</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="card-body p-3 position-relative" id="todo-content">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="applicationTable">
                                <thead class="table-light"><tr>
                                    <th>Job Details</th><th>Application Type</th><th>Job Category</th><th>Purpose</th><th>Sent By</th><th>Timeline</th><th class="text-center">Actions</th>
                                </tr></thead>
                                <tbody>
                                    <c:forEach items="${applicationlist}" var="appfiles" varStatus="loop">
                                        <fmt:parseDate value="${appfiles.job_datesend}" pattern="yyyy-MM-dd" var="jobSentDate" />
                                        <c:set var="daysDiff" value="${(now.time - jobSentDate.time) / (1000 * 60 * 60 * 24)}" />
                                        <tr class="${appfiles.objections > 0 && appfiles.job_purpose != 'Update Objection Status' ? 'table-danger' : ''}"
                                            ${appfiles.objections > 0 ? "data-bs-toggle='tooltip' data-bs-placement='left' title='Application has pending Objections'" : ""}>
                                            <td>
                                                <div class="fw-bold text-primary small">${appfiles.job_number}</div>
                                                <small class="text-muted small" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary" title="${appfiles.ar_name}">${fn:substring(appfiles.ar_name, 0, 20)}${fn:length(appfiles.ar_name) > 20 ? '...' : ''}</small>
                                            </td>
                                            <td><span class="small">${appfiles.business_process_sub_name}</span></td>
                                            <td><span class="small">${appfiles.request_category == 'SpecificWorkRequest' ? 'Specific Work Request' : appfiles.request_category == 'GeneralWorkRequest' ? 'General Work Request' : appfiles.request_category}</span></td>
                                            <td><span class="small">${appfiles.job_purpose == 'SpecificWorkRequest' ? 'Specific Work Request' : appfiles.job_purpose == 'GeneralWorkRequest' ? 'General Work Request' : appfiles.job_purpose}</span></td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar avatar-xs bg-light rounded-circle me-2"><i class="ri-user-line text-muted"></i></div>
                                                    <div class="fw-medium small">${appfiles.job_forwarded_by}</div>
                                                </div>
                                            </td>
                                            <td width="100">
                                                <div class="d-flex flex-column">
                                                    <fmt:parseDate value="${appfiles.job_datesend}" pattern="yyyy-MM-dd" var="parsedJobDateSend"/>
                                                    <fmt:formatDate value="${parsedJobDateSend}" pattern="dd MMM yyyy" var="formattedParsedJobDateSend"/>
                                                    <small><i class="fas fa-calendar-alt me-1 text-muted"></i>${formattedParsedJobDateSend}</small>
                                                    <small><i class="fas fa-history me-1 text-muted"></i>Days: <fmt:formatNumber value="${daysDiff}" maxFractionDigits="0" /></small>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-2">
                                                    <form action="front_office_view_application" method="post" class="d-inline ${appfiles.job_purpose != 'Add Plotting' && appfiles.job_purpose != 'Archive Plotting' ? '' : 'd-none'}">
                                                        <input type="hidden" name="search_text" value="${appfiles.case_number}">
                                                        <input type="hidden" name="case_number" value="${appfiles.transaction_number}">
                                                        <input type="hidden" name="job_number" value="${appfiles.job_number}">
                                                        <input type="hidden" name="business_process_sub_name" value="${appfiles.business_process_sub_name}">
                                                        <button type="submit" class="btn btn-sm btn-primary" data-bs-custom-class="tooltip-primary" title="View Application" data-bs-toggle="tooltip"><i class="ri-eye-line"></i></button>
                                                    </form>
                                                    <form action="${appfiles.job_purpose != 'Add Plotting' && appfiles.job_purpose != 'Archive Plotting' ? 'request_application_progress_details_ai' : 'request_application_progress_details_pd'}" method="post" class="d-inline">
                                                        <input type="hidden" name="case_number" value="${appfiles.case_number}">
                                                        <input type="hidden" name="transaction_number" value="${appfiles.transaction_number}">
                                                        <input type="hidden" name="job_number" value="${appfiles.job_number}">
                                                        <input type="hidden" name="business_process_sub_name" value="${appfiles.business_process_sub_name}">
                                                        <input type="hidden" name="review_type" value="${appfiles.request_category}">
                                                        <input type="hidden" name="rq_id" value="${appfiles.rq_id}">
                                                        <input type="hidden" name="review_instruction" value="${appfiles.request_comments}">
                                                        <input type="hidden" name="job_purpose" value="${appfiles.job_purpose}">
                                                        <button type="submit" class="btn btn-sm btn-warning" data-bs-custom-class="tooltip-primary" title="Work" data-bs-toggle="tooltip"><i class="ri-folder-open-line"></i></button>
                                                    </form>
                                                    <form action="request_application_progress_details_ai_short" method="post" class="d-inline">
                                                        <input type="hidden" name="case_number" value="${appfiles.case_number}">
                                                        <input type="hidden" name="transaction_number" value="${appfiles.transaction_number}">
                                                        <input type="hidden" name="job_number" value="${appfiles.job_number}">
                                                        <input type="hidden" name="business_process_sub_name" value="${appfiles.business_process_sub_name}">
                                                        <input type="hidden" name="review_type" value="${appfiles.request_category}">
                                                        <input type="hidden" name="rq_id" value="${appfiles.rq_id}">
                                                        <input type="hidden" name="review_instruction" value="${appfiles.request_comments}">
                                                        <input type="hidden" name="job_purpose" value="${appfiles.job_purpose}">
                                                        <button type="submit" class="btn btn-sm btn-danger" data-bs-custom-class="tooltip-primary" title="Smart Work" data-bs-toggle="tooltip"><i class="ri-folder-shared-line"></i></button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        var datatable = $("#applicationTable").DataTable({
            stateSave: true,
            dom: 'Bfrtip',
            buttons: ['pageLength', 'copy', 'csv', 'excel', 'pdf', 'print']
        });
        setTimeout(function() {
            if (typeof window.initializeTooltips === 'function') {
                window.initializeTooltips();
            }
        }, 50);
    });
</script>
