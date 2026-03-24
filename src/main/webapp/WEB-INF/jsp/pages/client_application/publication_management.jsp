<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<!-- Start::app-content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-3">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div>
                    <h1 class="page-title fw-medium fs-18 mb-1">Publication Management</h1>
                    <p class="text-muted mb-0"><i class="ri-information-line me-1"></i>Manage publication lists and monitor publication status</p>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Publication Management</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <!-- Start::row-1 -->
        <div class="row">
            <c:if test="${published_but_not_worked_on > 0}">
                <div class="col-xl-6 col-md-6">
                    <div class="card custom-card bg-danger-transparent border-0 shadow-none" 
                         data-bs-toggle="modal" data-bs-target="#publishedButNotWorkedOnModal" 
                         style="cursor: pointer">
                        <div class="card-body">
                            <div class="d-flex align-items-start gap-3 flex-wrap">
                                <div class="lh-1">
                                    <span class="avatar avatar-lg avatar-rounded bg-danger svg-white">
                                        <i class="ri-alarm-warning-line fs-5"></i>
                                    </span>
                                </div>
                                <div class="flex-fill">
                                    <span class="d-block mb-1">
                                        Passed 14 days after Publication
                                    </span>
                                    <div class="d-flex align-items-center gap-2">
                                        <h5 class="fw-semibold mb-0">${published_but_not_worked_on}</h5>
                                        <span class="badge bg-danger ms-2">Overdue</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Publication Tabs -->
        <div class="row">
            <div class="col-xl-12">
                <div class="card custom-card">
                    <div class="card-header justify-content-between">
                        <div>
                            <h5 class="card-title mb-0">Publication Lists</h5>
                            <p class="text-muted small mb-0"><i class="ri-information-line me-1"></i>Manage different publication statuses</p>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- Tab Navigation -->
                        <ul class="nav nav-tabs nav-style-1 border-bottom-0" id="publicationTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="unpublished-tab" data-bs-toggle="tab" 
                                        data-bs-target="#unpublishedList" type="button" role="tab">
                                    <i class="ri-list-check me-1 align-middle"></i>
                                    Ready for Publication
                                    <span class="badge bg-success ms-2">${fn:length(ready_for_publication_list)}</span>
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="published-tab" data-bs-toggle="tab" 
                                        data-bs-target="#publishedList" type="button" role="tab">
                                    <i class="ri-calendar-event-line me-1 align-middle"></i>
                                    Awaiting Publication Date
                                    <span class="badge bg-warning ms-2">${fn:length(awaiting_publication_date_list)}</span>
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link text-success" id="special-tab" data-bs-toggle="tab" 
                                        data-bs-target="#specialPublicationList" type="button" role="tab">
                                    <i class="ri-star-line me-1 align-middle"></i>
                                    Special Publication
                                </button>
                            </li>
                        </ul>

                        <!-- Tab Content -->
                        <div class="tab-content" id="publicationTabsContent">
                            <!-- Tab 1: Ready for Publication -->
                            <div class="tab-pane fade show active mt-3" id="unpublishedList" role="tabpanel">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div>
                                        <h5 class="mb-0">Ready for Publication</h5>
                                        <p class="text-muted small mb-0">Applications ready to be sent for publication</p>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-sm btn-primary" id="btnViewPublicationList">
                                            <i class="ri-printer-line me-1"></i>Print List
                                        </button>
                                        <button class="btn btn-sm btn-secondary" id="btnAddOldCase" 
                                                data-bs-toggle="modal" data-bs-target="#addOldCaseModal">
                                            <i class="ri-add-line me-1"></i>Add Application
                                        </button>
                                        <button class="btn btn-sm btn-danger" id="btnSendPublicationList">
                                            <i class="ri-newspaper-line me-1"></i>Send for Publication
                                        </button>
                                    </div>
                                </div>

                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0" id="unpublishedDataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="50">#</th>
                                                <th>Job Number</th>
                                                <th>Applicant Name</th>
                                                <th>Case Number</th>
                                                <th>Application Type</th>
                                                <th>GLPIN</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${ready_for_publication_list}" var="appfiles" varStatus="applicationLoop">
                                                <tr>
                                                    <td>${applicationLoop.index + 1}</td>
                                                    <td>
                                                        <span class="fw-semibold text-primary">${appfiles.job_number}</span>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="me-2">
                                                                <span class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle">
                                                                    <i class="ri-user-line text-muted"></i>
                                                                </span>
                                                            </div>
                                                            <div>
                                                                <span class="d-block fw-medium" 
                                                                      data-bs-toggle="tooltip" 
                                                                      title="${appfiles.ar_name}">
                                                                    ${fn:substring(appfiles.ar_name, 0, 20)}
                                                                    ${fn:length(appfiles.ar_name) > 20 ? '...' : ''}
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">${appfiles.case_number}</span>
                                                    </td>
                                                    <td>
                                                        <span class="small">${appfiles.business_process_sub_name}</span>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">${appfiles.glpin}</span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Tab 2: Awaiting Publication Date -->
                            <div class="tab-pane fade mt-3" id="publishedList" role="tabpanel">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div>
                                        <h5 class="mb-0">Awaiting Publication Date</h5>
                                        <p class="text-muted small mb-0">Applications sent for publication awaiting date assignment</p>
                                    </div>
                                    <div class="col-md-6">
                                        <form id="frmSentForPublication">
                                            <div class="input-group">
                                                <span class="input-group-text">
                                                    <i class="ri-calendar-line"></i>
                                                </span>
                                                <input class="form-control" id="date_sent_for_publication" 
                                                       name="user_to_send_to" type="date" required>
                                                <button class="btn btn-primary" type="button" 
                                                        id="btnPublishedListDateUpdate">
                                                    <i class="ri-calendar-event-line me-1"></i>Add Date
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0" id="publishedDataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="50">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" id="selectAll">
                                                    </div>
                                                </th>
                                                <th>Job Number</th>
                                                <th>Applicant Name</th>
                                                <th>Case Number</th>
                                                <th>Application Type</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${awaiting_publication_date_list}" var="appfiles" varStatus="applicationLoop">
                                                <tr>
                                                    <td>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox">
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="fw-semibold text-primary">${appfiles.job_number}</span>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="me-2">
                                                                <span class="avatar avatar-xs bg-light bg-opacity-10 rounded-circle">
                                                                    <i class="ri-user-line text-muted"></i>
                                                                </span>
                                                            </div>
                                                            <div>
                                                                <span class="d-block fw-medium" 
                                                                      data-bs-toggle="tooltip" 
                                                                      title="${appfiles.ar_name}">
                                                                    ${fn:substring(appfiles.ar_name, 0, 20)}
                                                                    ${fn:length(appfiles.ar_name) > 20 ? '...' : ''}
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">${appfiles.case_number}</span>
                                                    </td>
                                                    <td>
                                                        <span class="small">${appfiles.business_process_sub_name}</span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Tab 3: Special Publication -->
                            <div class="tab-pane fade mt-3" id="specialPublicationList" role="tabpanel">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div>
                                        <h5 class="mb-0 text-success">Special Publication</h5>
                                        <p class="text-muted small mb-0">Manage special publication cases</p>
                                    </div>
                                    <button class="btn btn-sm btn-success" id="btnAddOldCaseSpecial" 
                                            data-bs-toggle="modal" data-bs-target="#addOldCaseModal">
                                        <i class="ri-add-line me-1"></i>Add to Special Publication
                                    </button>
                                </div>

                                <div class="row">
                                    <div class="col-lg-8">
                                        <div class="card custom-card mb-3">
                                            <div class="card-header">
                                                <h6 class="mb-0"><i class="ri-file-text-line me-2"></i>Publication Details</h6>
                                            </div>
                                            <div class="card-body">
                                                <textarea id="lc_search_report_summary_details" 
                                                          name="lc_search_report_summary_details" 
                                                          class="form-control" rows="12" 
                                                          placeholder="Enter publication details here..."></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-4">
                                        <div class="card custom-card">
                                            <div class="card-header">
                                                <h6 class="mb-0"><i class="ri-information-line me-2"></i>Application Details</h6>
                                            </div>
                                            <div class="card-body">
                                                <form id="frmSPPublicationList">
                                                    <div class="mb-3">
                                                        <label class="form-label small">Applicant Name</label>
                                                        <input class="form-control form-control-sm" 
                                                               id="sp_ar_name" type="text" readonly>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label small">Grantor Name</label>
                                                        <input class="form-control form-control-sm" 
                                                               id="sp_grantor_name" type="text" readonly>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-6">
                                                            <label class="form-label small">Job Number</label>
                                                            <input class="form-control form-control-sm" 
                                                                   id="sp_job_number" type="text" readonly>
                                                        </div>
                                                        <div class="col-6">
                                                            <label class="form-label small">Case Number</label>
                                                            <input class="form-control form-control-sm" 
                                                                   id="sp_case_number" type="text" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-6">
                                                            <label class="form-label small">Locality</label>
                                                            <input class="form-control form-control-sm" 
                                                                   id="sp_locality" type="text" readonly>
                                                        </div>
                                                        <div class="col-6">
                                                            <label class="form-label small">Type of Interest</label>
                                                            <input class="form-control form-control-sm" 
                                                                   id="sp_type_of_interest" type="text" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-6">
                                                            <label class="form-label small">Extent</label>
                                                            <input class="form-control form-control-sm" 
                                                                   id="sp_extent" type="text" readonly>
                                                        </div>
                                                        <div class="col-6">
                                                            <label class="form-label small">Registry Map Ref</label>
                                                            <input class="form-control form-control-sm" 
                                                                   id="sp_registry_mapref" type="text" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="row mt-4" id="btnActionsSP" style="display:none">
                                                        <div class="col-6">
                                                            <button type="button" class="btn btn-success w-100 btn-sm" 
                                                                    id="btnPreviewSP">
                                                                <i class="ri-eye-line me-1"></i>Preview
                                                            </button>
                                                        </div>
                                                        <div class="col-6">
                                                            <button type="button" class="btn btn-primary w-100 btn-sm" 
                                                                    id="btnSaveSP">
                                                                <i class="ri-send-plane-line me-1"></i>Send Publication
                                                            </button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End::row-1 -->
    </div>
</div>

<!-- Published But Not Worked On Modal -->
<div class="modal fade" id="publishedButNotWorkedOnModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Applications Published &amp; Over-due List</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0" 
                           id="jobs_publishedButNotWorkedOnTable">
                        <thead class="table-light">
                            <tr>
                                <th>Job Number</th>
                                <th>Applicant Name</th>
                                <th>Application Type</th>
                                <th>Date Published</th>
                                <th width="100">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" 
                        data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Add Old Case Modal -->
<div class="modal fade" id="addOldCaseModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add Application to Publication List</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="card custom-card mb-3">
                            <div class="card-header">
                                <h6 class="mb-0"><i class="ri-search-line me-2"></i>Find Application</h6>
                            </div>
                            <div class="card-body">
                                <form id="frmFindJobForPublication">
                                    <div class="input-group">
                                        <input class="form-control" id="job_search_value" 
                                               type="text" placeholder="Enter Job number">
                                        <button class="btn btn-primary" type="submit">
                                            <i class="ri-search-line me-1"></i>Search
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card custom-card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h6 class="mb-0"><i class="ri-information-line me-2"></i>Application Details</h6>
                                <button class="btn btn-sm btn-warning" 
                                        data-bs-toggle="modal" 
                                        data-bs-target="#edit_application_for_publication">
                                    <i class="ri-edit-line me-1"></i>Edit
                                </button>
                            </div>
                            <div class="card-body">
                                <form id="frmAddToPublicationList">
                                    <div class="mb-3">
                                        <label class="form-label small">Applicant Name</label>
                                        <input class="form-control form-control-sm" 
                                               id="rs_ar_name" type="text" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label small">Grantor Name</label>
                                        <input class="form-control form-control-sm" 
                                               id="rs_grantor_name" type="text" readonly>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-6">
                                            <label class="form-label small">Job Number</label>
                                            <input class="form-control form-control-sm" 
                                                   id="rs_job_number" type="text" readonly>
                                        </div>
                                        <div class="col-6">
                                            <label class="form-label small">Case Number</label>
                                            <input class="form-control form-control-sm" 
                                                   id="rs_case_number" type="text" readonly>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-6">
                                            <label class="form-label small">Locality</label>
                                            <input class="form-control form-control-sm" 
                                                   id="rs_locality" type="text" readonly>
                                        </div>
                                        <div class="col-6">
                                            <label class="form-label small">Type of Interest</label>
                                            <input class="form-control form-control-sm" 
                                                   id="rs_type_of_interest" type="text" readonly>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-6">
                                            <label class="form-label small">Extent</label>
                                            <input class="form-control form-control-sm" 
                                                   id="rs_extent" type="text" readonly>
                                        </div>
                                        <div class="col-6">
                                            <label class="form-label small">Registry Map Ref</label>
                                            <input class="form-control form-control-sm" 
                                                   id="rs_registry_mapref" type="text" readonly>
                                        </div>
                                    </div>
                                    <div class="row mt-4">
                                        <div class="col-6">
                                            <button type="submit" class="btn btn-success w-100 btn-sm" 
                                                    id="btnBarcoder" data-btn_name="NP">
                                                <i class="ri-add-circle-line me-1"></i>Add to List
                                            </button>
                                        </div>
                                        <div class="col-6">
                                            <button type="button" class="btn btn-primary w-100 btn-sm" 
                                                    id="btnAddToSP" data-btn_name="SP">
                                                <i class="ri-star-line me-1"></i>Special Publication
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" 
                        data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Application Modal -->
<div class="modal fade" id="edit_application_for_publication" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Update Application Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="accordion custom-accordion" id="applicationAccordion">
                            <!-- Parties Section -->
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingParties">
                                    <button class="accordion-button" type="button" 
                                            data-bs-toggle="collapse" 
                                            data-bs-target="#collapseParties">
                                        <i class="ri-group-line me-2"></i>Parties
                                    </button>
                                </h2>
                                <div id="collapseParties" class="accordion-collapse collapse show">
                                    <div class="accordion-body">
                                        <button type="button" class="btn btn-primary btn-sm mb-3"
                                                id="lrd_btn_add_parties"
                                                data-bs-toggle="modal" 
                                                data-bs-target="#addeditpartyGeneral">
                                            <i class="ri-user-add-line me-1"></i>Add Party
                                        </button>
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0" 
                                                   id="party_details_datatable">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Sex</th>
                                                        <th>Contact</th>
                                                        <th>Role</th>
                                                        <th width="100">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Application Details Section -->
                            <div class="accordion-item mt-3">
                                <h2 class="accordion-header" id="headingDetails">
                                    <button class="accordion-button collapsed" type="button" 
                                            data-bs-toggle="collapse" 
                                            data-bs-target="#collapseDetails">
                                        <i class="ri-file-list-line me-2"></i>Application Details
                                    </button>
                                </h2>
                                <div id="collapseDetails" class="accordion-collapse collapse">
                                    <div class="accordion-body">
                                        <form id="frmFurtherEntries_pm">
                                            <input type="hidden" id="main_service_id_fe" name="main_service_id_fe">
                                            <input type="hidden" id="main_service_sub_id_fe" name="main_service_sub_id_fe">
                                            
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Job Number</label>
                                                        <input type="text" class="form-control" 
                                                               id="fe_job_number" readonly>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Type of Interest</label>
                                                        <select class="form-select" id="fe_type_of_interest">
                                                            <option>Select Type of Interest</option>
                                                            <option value="LEASEHOLD">LEASEHOLD</option>
                                                            <option value="FREEHOLD">FREEHOLD</option>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Registry Map Ref.</label>
                                                        <input type="text" class="form-control" 
                                                               id="fe_registry_mapref">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Transaction Number</label>
                                                        <input type="text" class="form-control" 
                                                               id="fe_transaction_number" readonly>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Case Number</label>
                                                        <input type="text" class="form-control" 
                                                               id="fe_case_number" readonly>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Locality</label>
                                                        <input type="text" class="form-control" 
                                                               id="fe_locality">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Extent</label>
                                                        <input type="text" class="form-control" 
                                                               id="fe_extent">
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="d-flex justify-content-end gap-2 mt-4">
                                                <button type="button" class="btn btn-secondary" 
                                                        data-bs-dismiss="modal">Close</button>
                                                <button type="submit" id="btnAddFurtherDetails" 
                                                        class="btn btn-success">
                                                    Save Changes
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $("#publishedDataTable").DataTable({
            stateSave: true,
            // stateDuration: 60 * 60 * 24 * 30,
            // stateSaveCallback: function(settings, data) {
            //     localStorage.setItem('DataTables_' + settings.sInstance, JSON.stringify(data));
            // },
            // stateLoadCallback: function(settings) {
            //     return JSON.parse(localStorage.getItem('DataTables_' + settings.sInstance));
            // },
            // lengthMenu: [10, 25, 50, 100],
            // pageLength: 10,
            // responsive: true,
            // autoWidth: false,
            // order: [[0, 'desc']],
            // columnDefs: [
            //     { targets: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], orderable: false }
            // ]
        });

        $("#unpublishedDataTable").DataTable({
            stateSave: true,
            // stateDuration: 60 * 60 * 24 * 30,
            // stateSaveCallback: function(settings, data) {
            //     localStorage.setItem('DataTables_' + settings.sInstance, JSON.stringify(data));
            // },
            // stateLoadCallback: function(settings) {
            //     return JSON.parse(localStorage.getItem('DataTables_' + settings.sInstance));
            // },
            // lengthMenu: [10, 25, 50, 100],
            // pageLength: 10,
            // responsive: true,
            // autoWidth: false,
            // order: [[0, 'desc']],
            // columnDefs: [
            //     { targets: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], orderable: false }
            // ]
        });
    });
</script>

<script src="${pageContext.request.contextPath}/js-pages/publication.js"></script>
