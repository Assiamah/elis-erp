<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="ws.casemgt.Ws_client_application"%>
<%@ page import="ws.users.Ws_users"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>

<%@ page import="org.codehaus.jettison.json.JSONArray"%>
<%@ page import="org.codehaus.jettison.json.JSONException"%>
<%@ page import="org.codehaus.jettison.json.JSONObject"%>

<!-- Check For Payment Modal -->
<div class="modal fade effect-scale modal-blur" id="check_for_payment" tabindex="-1" aria-labelledby="checkForPaymentLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center">
                    <div class="avatar avatar-md bg-white text-primary rounded-circle me-3">
                        <i class="bi bi-credit-card fs-5"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white mb-0" id="checkForPaymentLabel">
                            Payment Records
                        </h5>
                        <p class="mb-0 small opacity-75">
                            <i class="bi bi-info-circle me-1"></i>
                            Review payment history and details
                        </p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-0">
                <!-- Payment Summary -->
                <div class="bg-light p-4 border-bottom">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="d-flex align-items-center">
                                <div class="avatar avatar-sm bg-success text-white rounded-circle me-2">
                                    <i class="bi bi-cash-stack"></i>
                                </div>
                                <div>
                                    <small class="text-muted d-block">Total Amount</small>
                                    <h6 class="mb-0 fw-semibold" id="totalAmount">
                                        <c:set var="totalAmount" value="0" />
                                        <c:forEach items="${payment_invoice}" var="payment_bill_row">
                                            <c:set var="totalAmount" value="${totalAmount + payment_bill_row.bill_amount}" />
                                        </c:forEach>
                                        ${totalAmount}
                                    </h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="d-flex align-items-center">
                                <div class="avatar avatar-sm bg-info text-white rounded-circle me-2">
                                    <i class="bi bi-cash-coin"></i>
                                </div>
                                <div>
                                    <small class="text-muted d-block">Total Paid</small>
                                    <h6 class="mb-0 fw-semibold" id="totalPaid">
                                        <c:set var="totalPaid" value="0" />
                                        <c:forEach items="${payment_invoice}" var="payment_bill_row">
                                            <c:set var="totalPaid" value="${totalPaid + payment_bill_row.payment_amount}" />
                                        </c:forEach>
                                        ${totalPaid}
                                    </h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="d-flex align-items-center">
                                <div class="avatar avatar-sm bg-warning text-dark rounded-circle me-2">
                                    <i class="bi bi-receipt"></i>
                                </div>
                                <div>
                                    <small class="text-muted d-block">Total Receipts</small>
                                    <h6 class="mb-0 fw-semibold">${fn:length(payment_invoice)}</h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="d-flex align-items-center">
                                <div class="avatar avatar-sm bg-danger text-white rounded-circle me-2">
                                    <i class="bi bi-calendar-check"></i>
                                </div>
                                <div>
                                    <small class="text-muted d-block">Latest Payment</small>
                                    <h6 class="mb-0 fw-semibold" id="latestPaymentDate">
                                        <c:if test="${not empty payment_invoice}">
                                            ${payment_invoice[0].payment_date}
                                        </c:if>
                                        <c:if test="${empty payment_invoice}">
                                            No payments
                                        </c:if>
                                    </h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Payment Records Table -->
                <div class="table-responsive p-4">
                    <c:choose>
                        <c:when test="${not empty payment_invoice}">
                            <table class="table table-hover align-middle" id="bill_payment_dataTable">
                                <thead class="table-light">
                                    <tr>
                                        <th width="80">Action</th>
                                        <th>Payment Mode</th>
                                        <th>Bill Amount</th>
                                        <th>Receipt Number</th>
                                        <th>Payment Date</th>
                                        <th>Paid Amount</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${payment_invoice}" var="payment_bill_row" varStatus="status">
                                        <tr>
                                            <td>
                                                <div class="d-flex gap-2">
                                                    <button class="btn btn-sm btn-outline-primary view-bill-btn"
                                                            data-bs-toggle="modal" 
                                                            data-bs-target="#generateEGCRModal"
                                                            data-egcr_id="${payment_bill_row.payment_slip_number}"
                                                            data-ref_number="${payment_bill_row.ref_number}"
                                                            title="View Bill Details">
                                                        <i class="bi bi-eye"></i>
                                                    </button>
                                                    <!-- <button class="btn btn-sm btn-outline-success print-receipt-btn"
                                                            data-receipt-number="${payment_bill_row.payment_slip_number}"
                                                            title="Print Receipt">
                                                        <i class="bi bi-printer"></i>
                                                    </button> -->
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge 
                                                    ${payment_bill_row.payment_mode == 'Cash' ? 'bg-success' : 
                                                      payment_bill_row.payment_mode == 'Bank' ? 'bg-primary' : 
                                                      payment_bill_row.payment_mode == 'Mobile Money' ? 'bg-info' : 'bg-secondary'}">
                                                    <i class="bi 
                                                        ${payment_bill_row.payment_mode == 'Cash' ? 'bi-cash' : 
                                                          payment_bill_row.payment_mode == 'Bank' ? 'bi-bank' : 
                                                          payment_bill_row.payment_mode == 'Mobile Money' ? 'bi-phone' : 'bi-credit-card'} me-1"></i>
                                                    ${payment_bill_row.payment_mode}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="fw-semibold">${payment_bill_row.bill_amount}</span>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar avatar-sm bg-light rounded-circle me-2">
                                                        <i class="bi bi-receipt text-primary"></i>
                                                    </div>
                                                    <div>
                                                        <div class="fw-medium">${payment_bill_row.payment_slip_number}</div>
                                                        <small class="text-muted">Ref: ${payment_bill_row.ref_number}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar avatar-sm bg-light rounded-circle me-2">
                                                        <i class="bi bi-calendar text-success"></i>
                                                    </div>
                                                    <div>
                                                        <div class="fw-medium">${payment_bill_row.payment_date}</div>
                                                        <small class="text-muted">
                                                            <c:if test="${not empty payment_bill_row.payment_time}">
                                                                ${payment_bill_row.payment_time}
                                                            </c:if>
                                                        </small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <c:set var="paymentStatus" value="success" />
                                                    <c:choose>
                                                        <c:when test="${payment_bill_row.payment_amount < payment_bill_row.bill_amount}">
                                                            <c:set var="paymentStatus" value="warning" />
                                                        </c:when>
                                                        <c:when test="${payment_bill_row.payment_amount > payment_bill_row.bill_amount}">
                                                            <c:set var="paymentStatus" value="info" />
                                                        </c:when>
                                                    </c:choose>
                                                    <div class="avatar avatar-sm bg-light-${paymentStatus} text-${paymentStatus} rounded-circle me-2">
                                                        <i class="bi bi-cash-coin"></i>
                                                    </div>
                                                    <div>
                                                        <div class="fw-semibold text-${paymentStatus}">${payment_bill_row.payment_amount}</div>
                                                        <c:if test="${payment_bill_row.bill_amount != payment_bill_row.payment_amount}">
                                                            <small class="text-${paymentStatus}">
                                                                ${payment_bill_row.payment_amount > payment_bill_row.bill_amount ? 'Overpaid' : 'Underpaid'}
                                                            </small>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${payment_bill_row.payment_amount >= payment_bill_row.bill_amount}">
                                                        <span class="badge bg-success">
                                                            <i class="bi bi-check-circle me-1"></i>Fully Paid
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${payment_bill_row.payment_amount == 0}">
                                                        <span class="badge bg-danger">
                                                            <i class="bi bi-x-circle me-1"></i>Unpaid
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning text-dark">
                                                            <i class="bi bi-exclamation-circle me-1"></i>Partial
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <!-- Empty State -->
                            <div class="text-center py-5">
                                <div class="mb-3">
                                    <i class="bi bi-credit-card display-1 text-muted"></i>
                                </div>
                                <h5 class="text-muted mb-2">No Payment Records Found</h5>
                                <p class="text-muted mb-4">No payment records are available for this case.</p>
                                <button class="btn btn-primary prFileUploadModal">
                                    <i class="bi bi-plus-circle me-1"></i>Add New Payment
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <p class="mb-2 ms-4 small opacity-75">
                    <i class="bi bi-info-circle me-1"></i>
                    Note: Uploaded payment records are available at the application documents.
                </p>

                <!-- Payment Summary Footer -->
                <c:if test="${not empty payment_invoice}">
                    <div class="bg-light p-4 border-top">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-md bg-light rounded-circle me-3">
                                        <i class="bi bi-graph-up text-primary"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">Payment Summary</h6>
                                        <div class="d-flex gap-4">
                                            <small class="text-muted">
                                                <span class="fw-medium text-success">Fully Paid:</span> 
                                                <c:set var="fullyPaidCount" value="0" />
                                                <c:forEach items="${payment_invoice}" var="payment_bill_row">
                                                    <c:if test="${payment_bill_row.payment_amount >= payment_bill_row.bill_amount}">
                                                        <c:set var="fullyPaidCount" value="${fullyPaidCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${fullyPaidCount}
                                            </small>
                                            <small class="text-muted">
                                                <span class="fw-medium text-warning">Partial:</span> 
                                                <c:set var="partialCount" value="0" />
                                                <c:forEach items="${payment_invoice}" var="payment_bill_row">
                                                    <c:if test="${payment_bill_row.payment_amount > 0 && payment_bill_row.payment_amount < payment_bill_row.bill_amount}">
                                                        <c:set var="partialCount" value="${partialCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${partialCount}
                                            </small>
                                            <small class="text-muted">
                                                <span class="fw-medium text-danger">Unpaid:</span> 
                                                <c:set var="unpaidCount" value="0" />
                                                <c:forEach items="${payment_invoice}" var="payment_bill_row">
                                                    <c:if test="${payment_bill_row.payment_amount == 0}">
                                                        <c:set var="unpaidCount" value="${unpaidCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${unpaidCount}
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="text-end">
                                    <button class="btn btn-outline-primary me-2" id="exportPayments">
                                        <i class="bi bi-download me-1"></i>Export
                                    </button>
                                    <button class="btn btn-primary prFileUploadModal">
                                        <i class="bi bi-plus-circle me-1"></i>Add Payment
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-white">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="check_review_documents" data-bs-backdrop="static" tabindex="-1" aria-labelledby="check_review_documents_label" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center">
                    <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
                        <i class="bi bi-folder2-open fs-4"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white mb-1" id="check_review_documents_label">
                            Review Documents
                        </h5>
                        <p class="mb-0 small opacity-75">
                            <i class="bi bi-info-circle me-1"></i>
                            Manage and review case documents
                        </p>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4">
                <!-- Loading Indicator -->
                <div id="documentsLoading" class="d-none mb-4">
                    <div class="d-flex align-items-center">
                        <div class="spinner-border spinner-border-sm text-primary me-2" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <small class="text-muted">Loading documents...</small>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="d-flex flex-wrap gap-2 mb-4">
                    <button type="button" class="btn btn-primary btn-sm" id="btn_load_scanned_documents_public_gated_workflow">
                        <i class="bi bi-eye me-1"></i> Load Documents
                    </button>
                    
                    <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" 
                            data-bs-target="#publicFileUploadModal">
                        <i class="bi bi-plus-circle me-1"></i> Add Documents
                    </button>
                    
                    <button type="button" class="btn btn-info btn-sm" id="btn_refresh_documents">
                        <i class="bi bi-arrow-clockwise me-1"></i> Refresh
                    </button>
                    
                    <button type="button" class="btn btn-outline-secondary btn-sm" id="btn_export_documents">
                        <i class="bi bi-download me-1"></i> Export
                    </button>
                </div>

                <!-- Case Information -->
                <div class="card border mb-4">
                    <div class="card-header bg-light">
                        <h6 class="mb-0 fw-semibold">
                            <i class="bi bi-info-circle me-2"></i>Case Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-medium text-muted mb-1">
                                    <i class="bi bi-file-text me-1"></i>Case Number
                                </label>
                                <div class="input-group">
                                    <input type="text" 
                                           class="form-control bg-light" 
                                           id="cs_main_case_number" 
                                           value="${case_number}" 
                                           readonly>
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="copyToClipboard('cs_main_case_number')">
                                        <i class="bi bi-clipboard"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-medium text-muted mb-1">
                                    <i class="bi bi-person me-1"></i>Applicant Name
                                </label>
                                <input type="text" 
                                       class="form-control bg-light" 
                                       value="${ar_name}" 
                                       readonly>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Documents Table -->
                <div class="table-responsive border rounded mb-4">
                    <table class="table table-hover table-sm mb-0" id="lc_public_documents_dataTable_gated_workflow">
                        <thead class="table-light">
                            <tr>
                                <th width="40%">
                                    <i class="bi bi-file-earmark-text me-1"></i>Document Name
                                </th>
                                <th width="25%">
                                    <i class="bi bi-tag me-1"></i>Document Type
                                </th>
                                <th width="15%" class="text-center">
                                    <i class="bi bi-filetype-pdf me-1"></i>Format
                                </th>
                                <th width="20%" class="text-center">
                                    <i class="bi bi-gear me-1"></i>Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody id="documentsTableBody_gated_workflow">
                            
                        </tbody>
                    </table>
                </div>
                
                <!-- Document Statistics -->
                <!-- <div class="row g-3 mb-4" id="documentStatistics">
                    <div class="col-md-6">
                        <div class="card border">
                            <div class="card-body py-3">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-sm bg-light-primary rounded-circle me-3">
                                        <i class="bi bi-file-earmark-text"></i>
                                    </div>
                                    <div>
                                        <h5 class="mb-0" id="totalDocumentsCount">${fn:length(casescanneddocuments_public)}</h5>
                                        <small class="text-muted">Total Documents</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border">
                            <div class="card-body py-3">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-sm bg-light-success rounded-circle me-3">
                                        <i class="bi bi-check-circle"></i>
                                    </div>
                                    <div>
                                        <h5 class="mb-0" id="reviewedCount">0</h5>
                                        <small class="text-muted">Reviewed</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border">
                            <div class="card-body py-3">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-sm bg-light-warning rounded-circle me-3">
                                        <i class="bi bi-clock"></i>
                                    </div>
                                    <div>
                                        <h5 class="mb-0" id="pendingCount">0</h5>
                                        <small class="text-muted">Pending</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border">
                            <div class="card-body py-3">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-sm bg-light-danger rounded-circle me-3">
                                        <i class="bi bi-exclamation-circle"></i>
                                    </div>
                                    <div>
                                        <h5 class="mb-0" id="rejectedCount">0</h5>
                                        <small class="text-muted">Rejected</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> -->

                <!-- Review Actions -->
                <!-- <div class="card border">
                    <div class="card-header bg-light">
                        <h6 class="mb-0 fw-semibold">
                            <i class="bi bi-clipboard-check me-2"></i>Review Actions
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-check form-switch mb-2">
                                    <input class="form-check-input" type="checkbox" id="toggleAllDocuments">
                                    <label class="form-check-label" for="toggleAllDocuments">
                                        Select/Deselect All Documents for Review
                                    </label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="reviewStatus" id="reviewApprove" value="approved">
                                    <label class="form-check-label text-success" for="reviewApprove">
                                        <i class="bi bi-check-circle me-1"></i>Approve Selected
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="reviewStatus" id="reviewReject" value="rejected">
                                    <label class="form-check-label text-danger" for="reviewReject">
                                        <i class="bi bi-x-circle me-1"></i>Reject Selected
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-grid">
                                    <button type="button" class="btn btn-primary" id="btn_save_review">
                                        <i class="bi bi-save me-1"></i> Save Review
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> -->
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div>
                        <!-- <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="showApprovalButton">
                            <label class="form-check-label small" for="showApprovalButton">
                                Show Final Approval
                            </label>
                        </div> -->
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i> Close
                        </button>
                        <!-- <button type="button" id="btn_update_app_status_ffrv" style="display:none"
                                class="btn btn-success">
                            <i class="bi bi-check-circle me-1"></i> Confirm Final Approval
                        </button> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="add_edit_parties" tabindex="-1" aria-labelledby="addEditPartiesLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
    <div class="modal-content border-0 shadow-lg">
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <div class="d-flex align-items-center w-100">
          <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
            <i class="bi bi-people fs-4"></i>
          </div>
          <div class="flex-grow-1">
            <h5 class="modal-title text-white mb-1" id="addEditPartiesLabel">
              Manage Parties
            </h5>
            <p class="mb-0 small opacity-75">
              <i class="bi bi-info-circle me-1"></i>
              Add or edit parties involved in this case
            </p>
          </div>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>

      <!-- Modal Body -->
      <div class="modal-body p-4">
        <!-- Action Buttons -->
        <div class="row g-3 mb-4">
          <div class="col-md-6">
            <button type="button" class="btn btn-primary addeditpartyGeneralBtn w-100" id="lrd_btn_add_grantor" 
                    data-bs-placement="top" data-bs-title="Add Grantor">
              <i class="bi bi-person-plus me-2"></i>Add Grantor
            </button>
          </div>
          <div class="col-md-6">
            <button type="button" class="btn btn-success addeditpartyGeneralBtn w-100" id="lrd_btn_add_grantee" 
                    data-bs-placement="top" data-bs-title="Add Applicant">
              <i class="bi bi-person-plus me-2"></i>Add Applicant
            </button>
          </div>
        </div>

        <!-- Parties Statistics -->
         <c:forEach var="party" items="${parties}">
            <c:choose>
                <c:when test="${party.type_of_party == 'Grantor'}">
                    <c:set var="grantorCount" value="${grantorCount + 1}" />
                </c:when>
                <c:when test="${party.type_of_party == 'Applicant'}">
                    <c:set var="applicantCount" value="${applicantCount + 1}" />
                </c:when>
                <c:otherwise>
                    <c:set var="otherCount" value="${otherCount + 1}" />
                </c:otherwise>
            </c:choose>
        </c:forEach>
        
        <div class="row g-3 mb-4">

            <div class="col-md-3">
                <div class="card border">
                <div class="card-body py-2">
                    <div class="d-flex align-items-center">
                    <div class="avatar avatar-sm bg-light-primary text-primary rounded-circle me-3">
                        <i class="bi bi-people"></i>
                    </div>
                    <div>
                        <h6 class="mb-0">${fn:length(parties)}</h6>
                        <small class="text-muted">Total Parties</small>
                    </div>
                    </div>
                </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card border">
                <div class="card-body py-2">
                    <div class="d-flex align-items-center">
                    <div class="avatar avatar-sm bg-light-success text-success rounded-circle me-3">
                        <i class="bi bi-person-check"></i>
                    </div>
                    <div>
                        <h6 class="mb-0">${empty fn:trim(grantorCount) ? '0' : fn:trim(grantorCount)}</h6>
                        <small class="text-muted">Grantors</small>
                    </div>
                    </div>
                </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card border">
                <div class="card-body py-2">
                    <div class="d-flex align-items-center">
                    <div class="avatar avatar-sm bg-light-warning text-warning rounded-circle me-3">
                        <i class="bi bi-person-badge"></i>
                    </div>
                    <div>
                        <h6 class="mb-0">${empty fn:trim(applicantCount) ? '0' : fn:trim(applicantCount)}</h6>
                        <small class="text-muted">Applicants</small>
                    </div>
                    </div>
                </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card border">
                <div class="card-body py-2">
                    <div class="d-flex align-items-center">
                    <div class="avatar avatar-sm bg-light-info text-info rounded-circle me-3">
                        <i class="bi bi-person"></i>
                    </div>
                    <div>
                        <h6 class="mb-0">${empty fn:trim(otherCount) ? '0' : fn:trim(otherCount)}</h6>
                        <small class="text-muted">Others</small>
                    </div>
                    </div>
                </div>
                </div>
            </div>

            </div>

        <!-- Parties Table -->
        <div class="table-responsive border rounded">
          <table class="table table-hover table-sm mb-0" id="party_details_datatable">
            <thead class="table-light">
              <tr>
                <th width="25%">
                  <i class="bi bi-person me-1"></i>Name
                </th>
                <th width="10%">
                  <i class="bi bi-gender-ambiguous me-1"></i>Sex
                </th>
                <th width="20%">
                  <i class="bi bi-telephone me-1"></i>Contact
                </th>
                <th width="20%">
                  <i class="bi bi-person-badge me-1"></i>Role
                </th>
                <th width="25%" class="text-center">
                  <i class="bi bi-gear me-1"></i>Actions
                </th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${parties}" var="parties_row">
                <tr>
                  <td class="align-middle">
                    <div class="fw-semibold">${parties_row.ar_name}</div>
                  </td>
                  <td class="align-middle">
                    <span class="badge ${parties_row.ar_gender == 'MALE' ? 'bg-info' : parties_row.ar_gender == 'FEMALE' ? 'bg-pink' : 'bg-secondary'}">
                      ${parties_row.ar_gender == 'MALE' ? 'Male' : parties_row.ar_gender == 'FEMALE' ? 'Female' : 'Other'}
                    </span>
                  </td>
                  <td class="align-middle">
                    <div class="contact-info">
                      <div class="d-flex align-items-center mb-1">
                        <i class="bi bi-phone text-primary me-2"></i>
                        <small>${empty fn:trim(parties_row.ar_cell_phone) ? '--' : fn:trim(parties_row.ar_cell_phone)}</small>
                      </div>
                      <c:if test="${not empty parties_row.ar_cell_phone2}">
                        <div class="d-flex align-items-center">
                          <i class="bi bi-telephone-plus text-secondary me-2"></i>
                          <small>${empty fn:trim(parties_row.ar_cell_phone2) ? '--' : fn:trim(parties_row.ar_cell_phone2)}</small>
                        </div>
                      </c:if>
                    </div>
                  </td>
                  <td class="align-middle">
                    <span class="badge ${parties_row.type_of_party == 'Grantor' ? 'bg-success' : parties_row.type_of_party == 'Applicant' ? 'bg-warning' : 'bg-info'}">
                      ${parties_row.type_of_party}
                    </span>
                  </td>
                  <td class="align-middle text-center">
                    <div class="d-flex justify-content-center gap-2">
                      <!-- Edit Button -->
                      <button class="btn btn-outline-primary btn-sm addeditpartyGeneralBtn" 
                              data-bs-placement="top" data-bs-title="Edit Party"
                              data-target-id="${parties_row.ar_client_id}"  
                              data-ar_name="${parties_row.ar_name}"
                              data-ar_gender="${parties_row.ar_gender}"
                              data-ar_address="${parties_row.ar_address}"
                              data-ar_cell_phone="${parties_row.ar_cell_phone}"
                              data-ar_cell_phone2="${parties_row.ar_cell_phone2}"
                              data-ar_tin_no="${parties_row.ar_tin_no}"
                              data-ar_id_type="${parties_row.ar_id_type}"
                              data-ar_id_number="${parties_row.ar_id_number}"
                              data-ar_location="${parties_row.ar_location}"
                              data-ar_district="${parties_row.ar_district}"
                              data-type_of_party="${parties_row.type_of_party}"
                              data-ar_region="${parties_row.ar_region}"
                              data-ar_person_type="${parties_row.ar_person_type}"
                              data-p_uid="${parties_row.p_uid}"
                              data-ar_id="${parties_row.ar_id}">
                        <i class="bi bi-pencil"></i> Edit
                      </button>
                      
                      <!-- Delete Button -->
                      <button class="btn btn-outline-danger btn-sm deletepartyGeneralBtn" 
                              data-bs-placement="top" data-bs-title="Delete Party"
                              data-target-id="${parties_row.ar_client_id}"  
                              data-ar_name="${parties_row.ar_name}"
                              data-ar_gender="${parties_row.ar_gender}"
                              data-ar_address="${parties_row.ar_address}"
                              data-ar_cell_phone="${parties_row.ar_cell_phone}"
                              data-ar_cell_phone2="${parties_row.ar_cell_phone2}"
                              data-ar_tin_no="${parties_row.ar_tin_no}"
                              data-ar_id_type="${parties_row.ar_id_type}"
                              data-ar_id_number="${parties_row.ar_id_number}"
                              data-ar_location="${parties_row.ar_location}"
                              data-ar_district="${parties_row.ar_district}"
                              data-type_of_party="${parties_row.type_of_party}"
                              data-ar_region="${parties_row.ar_region}"
                              data-ar_person_type="${parties_row.ar_person_type}"
                              data-p_uid="${parties_row.p_uid}"
                              data-ar_id="${parties_row.ar_id}">
                        <i class="bi bi-trash"></i> Delete
                      </button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
              
              <!-- Empty State -->
              <c:if test="${empty parties}">
                <tr>
                  <td colspan="5" class="text-center py-4">
                    <div class="text-muted">
                      <i class="bi bi-people fs-1 mb-2 d-block"></i>
                      <p class="mb-0">No parties added yet</p>
                      <small>Click "Add Grantor" or "Add Applicant" to get started</small>
                    </div>
                  </td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>

        <!-- Additional Info -->
        <div class="alert alert-dark mt-4">
          <div class="d-flex">
            <div class="me-3">
              <i class="bi bi-info-circle fs-4"></i>
            </div>
            <div>
              <h6 class="alert-heading mb-2">Party Management</h6>
              <p class="mb-2 small">
                • <strong>Grantor:</strong> The person/entity granting rights or property<br>
                • <strong>Applicant:</strong> The person/entity applying for rights or property<br>
                • Click <i class="bi bi-pencil"></i> to edit party details<br>
                • Click <i class="bi bi-trash"></i> to remove a party
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer bg-light">
        <div class="d-flex justify-content-between w-100">
          <div class="text-start">
            <small class="text-muted">
              <i class="bi bi-shield-check me-1"></i>
              Total Parties: <strong>${fn:length(parties)}</strong>
            </small>
          </div>
          <div>
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
              <i class="bi bi-x-circle me-1"></i>Close
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="addeditpartyGeneral" tabindex="-1" aria-labelledby="addEditPartyGeneralLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content border-0 shadow-lg">
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <div class="d-flex align-items-center w-100">
          <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
            <i class="bi bi-person-plus fs-4"></i>
          </div>
          <div class="flex-grow-1">
            <h5 class="modal-title text-white mb-1" id="addEditPartyGeneralLabel">
              Add/Edit Party
            </h5>
            <p class="mb-0 small opacity-75">
              <i class="bi bi-info-circle me-1"></i>
              Enter party details
            </p>
          </div>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>

      <!-- Modal Body -->
      <div class="modal-body p-4">
        <input type="hidden" id="party_id_gen" value="">
        
        <!-- Validation Summary -->
        <div class="alert alert-dark">
          <div class="d-flex">
            <div class="me-3">
              <i class="bi bi-exclamation-circle fs-4"></i>
            </div>
            <div>
              <h6 class="alert-heading mb-2">Required Information</h6>
              <p class="mb-0 small">
                Fields marked with <span class="text-danger">*</span> are required.
                <br>
                <i class="bi bi-check-circle text-success me-1"></i> Name, Sex, Phone, and Party Type are mandatory
              </p>
            </div>
          </div>
        </div>
        
        <div class="row g-3">
          <!-- Name -->
          <div class="col-md-12">
            <label for="party_ar_name_gen" class="form-label fw-semibold">
              <i class="bi bi-person me-1"></i>Full Name
              <span class="text-danger">*</span>
            </label>
            <textarea rows="2" class="form-control" placeholder="Enter full name" 
                     id="party_ar_name_gen" required></textarea>
            <div class="form-text">
              <i class="bi bi-info-circle me-1"></i>Enter the party's complete name
            </div>
          </div>
          
          <!-- Address -->
          <div class="col-md-12">
            <label for="party_ar_address_gen" class="form-label fw-semibold">
              <i class="bi bi-geo-alt me-1"></i>Address
            </label>
            <textarea rows="2" class="form-control" placeholder="Enter full address" 
                     id="party_ar_address_gen"></textarea>
          </div>
          
          <!-- Gender and Person Type -->
          <div class="col-md-6">
            <label for="party_ar_gender_gen" class="form-label fw-semibold">
              <i class="bi bi-gender-ambiguous me-1"></i>Sex
              <span class="text-danger">*</span>
            </label>
            <select name="bl_txt_ar_gender" id="party_ar_gender_gen" class="form-select" required>
              <option value="">Select Gender</option>
              <c:forEach items="${genderlist}" var="gender">
                <option value="${gender.gender_name}">${gender.gender_name}</option>
              </c:forEach>
            </select>
          </div>
          
          <div class="col-md-6">
            <label for="party_ar_person_type_gen" class="form-label fw-semibold">
              <i class="bi bi-person-badge me-1"></i>Person Type
            </label>
            <select name="bl_txt_ar_gender" id="party_ar_person_type_gen" class="form-select">
              <option value="Natural Person">Natural Person</option>
              <option value="Company">Company</option>
            </select>
          </div>
          
          <!-- Phone Numbers -->
          <div class="col-md-6">
            <label for="party_ar_cell_phone_gen" class="form-label fw-semibold">
              <i class="bi bi-phone me-1"></i>Phone Number
              <span class="text-danger">*</span>
            </label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="bi bi-telephone"></i>
              </span>
              <input type="tel" class="form-control" placeholder="Enter phone number" 
                     id="party_ar_cell_phone_gen" required>
            </div>
          </div>
          
          <div class="col-md-6">
            <label for="party_ar_cell_phone2_gen" class="form-label fw-semibold">
              <i class="bi bi-phone me-1"></i>Alternate Phone
            </label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="bi bi-telephone-plus"></i>
              </span>
              <input type="tel" class="form-control" placeholder="Enter alternate number" 
                     id="party_ar_cell_phone2_gen">
            </div>
          </div>
          
          <!-- ID Type and Number -->
          <div class="col-md-6">
            <label for="party_ar_id_type_gen" class="form-label fw-semibold">
              <i class="bi bi-card-text me-1"></i>ID Type
            </label>
            <select name="party_ar_id_type_gen" id="party_ar_id_type_gen" class="form-select">
              <option value="">Select ID Type</option>
              <option value="National ID">National ID</option>
              <option value="Drivers License">Drivers License</option>
              <option value="NHIS">NHIS</option>
              <option value="Passport">Passport</option>
              <option value="Other">Other</option>
            </select>
          </div>
          
          <div class="col-md-6">
            <label for="party_ar_id_number_gen" class="form-label fw-semibold">
              <i class="bi bi-123 me-1"></i>ID Number
            </label>
            <input type="text" class="form-control" placeholder="Enter ID number" 
                   id="party_ar_id_number_gen">
          </div>
          
          <!-- TIN and Nationality -->
          <div class="col-md-6">
            <label for="party_ar_tin_no_gen" class="form-label fw-semibold">
              <i class="bi bi-building me-1"></i>TIN Number
            </label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="bi bi-file-text"></i>
              </span>
              <input type="text" class="form-control" placeholder="Enter TIN" 
                     id="party_ar_tin_no_gen">
            </div>
          </div>
          
          <div class="col-md-6">
            <label for="party_ar_nationality_gen" class="form-label fw-semibold">
              <i class="bi bi-globe me-1"></i>Nationality
            </label>
            <select id="party_ar_nationality_gen" class="form-select">
              <option value="Ghanaian">Ghanaian</option>
              <option value="Foreigner">Foreigner</option>
            </select>
          </div>
          
          <!-- Party Type -->
          <div class="col-md-12">
            <label for="party_ar_type_of_party_gen" class="form-label fw-semibold">
              <i class="bi bi-person-rolodex me-1"></i>Type of Party
              <span class="text-danger">*</span>
            </label>
            <select name="party_ar_type_of_party_gen" id="party_ar_type_of_party_gen" 
                    class="form-select" required>
              <option value="">Select Party Type</option>
              <option value="Applicant">Applicant</option>
              <option value="Grantor">Grantor</option>
              <option value="Assignor">Assignor</option>
              <option value="Assignee">Assignee</option>
              <option value="Mortgagor">Mortgagor</option>
              <option value="Mortgagee">Mortgagee</option>
              <option value="Lessee">Lessee</option>
              <option value="Lessor">Lessor</option>
              <option value="Depositor">Depositor</option>
            </select>
            <div class="form-text">
              <i class="bi bi-info-circle me-1"></i>Select the role this party plays in the transaction
            </div>
          </div>
          
          <!-- Grantor Family Section (Hidden by default) -->
          <div class="col-12 d-none" id="grantor-family-div">
            <div class="card border mt-2">
              <div class="card-header bg-light">
                <h6 class="mb-0 fw-semibold">
                  <i class="bi bi-people me-2"></i>Family/Stool Information
                </h6>
              </div>
              <div class="card-body">
                <div class="row g-3">
                  <div class="col-md-6">
                    <label for="family_name_gen" class="form-label">
                      <i class="bi bi-person-bounding-box me-1"></i>Stool/Family Name
                    </label>
                    <input type="text" class="form-control" id="family_name_gen"
                           placeholder="Enter stool/family name">
                  </div>
                  <div class="col-md-6">
                    <label for="grantor_family_gen" class="form-label">
                      <i class="bi bi-diagram-3 me-1"></i>Grantor's Family
                    </label>
                    <input type="text" class="form-control" id="grantor_family_gen"
                           placeholder="Enter family information">
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Residential Address -->
          <div class="col-md-12">
            <label for="party_ar_location_gen" class="form-label fw-semibold">
              <i class="bi bi-house me-1"></i>Residential/GhanaPost Address
            </label>
            <input type="text" class="form-control" id="party_ar_location_gen"
                   placeholder="Enter residential or GhanaPost address">
          </div>
          
          <!-- Optional: District and Region if available -->
          <div class="col-md-6">
            <label for="party_ar_district_gen" class="form-label">
              <i class="bi bi-geo me-1"></i>District
            </label>
            <input type="text" class="form-control" id="party_ar_district_gen"
                   placeholder="Enter district">
          </div>
          
          <div class="col-md-6">
            <label for="party_ar_region_gen" class="form-label">
              <i class="bi bi-map me-1"></i>Region
            </label>
            <input type="text" class="form-control" id="party_ar_region_gen"
                   placeholder="Enter region">
          </div>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer bg-light">
        <div class="d-flex justify-content-between w-100 align-items-center">
          <div>
            <small class="text-muted">
              <i class="bi bi-shield-check me-1"></i>
              All information is securely stored
            </small>
          </div>
          <div class="d-flex gap-2">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
              <i class="bi bi-x-circle me-1"></i>Cancel
            </button>
            <button type="button" id="btnsavenewpartyGeneral" class="btn btn-primary">
              <i class="bi bi-check-circle me-1"></i>Save Party
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="further_entry" tabindex="-1" aria-labelledby="furtherEntryLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
    <div class="modal-content border-0 shadow-lg">
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <div class="d-flex align-items-center w-100">
          <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
            <i class="bi bi-pencil-square fs-4"></i>
          </div>
          <div class="flex-grow-1">
            <h5 class="modal-title text-white mb-1" id="furtherEntryLabel">
              Further Entry Details
            </h5>
            <p class="mb-0 small opacity-75">
              <i class="bi bi-info-circle me-1"></i>
              Additional case information and specifications
            </p>
          </div>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>

      <!-- Modal Body -->
      <div class="modal-body p-4">
        <form id='frmFurtherEntries_only_' novalidate>
          <div class="row g-4">
            <!-- Left Column -->
            <div class="col-lg-6">
              <!-- Job Number -->
              <div class="mb-3">
                <label for="fe_job_number" class="form-label fw-semibold">
                  <i class="bi bi-file-earmark-text me-2"></i>Job Number
                </label>
                <input type="text" class="form-control bg-light" id="fe_job_number" 
                       value="${job_number}" readonly>
              </div>

              <!-- Hidden Fields -->
              <input type="hidden" id="fe_client_name" value="${ar_name}">
              <input type="hidden" id="fe_business_process_sub_name" value="${business_process_sub_name}">

              <!-- Surveyors Number -->
              <div class="mb-3">
                <label for="fe_surveyor_number" class="form-label fw-semibold">
                  <i class="bi bi-rulers me-2"></i>Surveyors Number
                </label>
                <div class="input-group">
                  <span class="input-group-text bg-light">
                    <i class="bi bi-123"></i>
                  </span>
                  <input type="text" class="form-control" id="fe_surveyor_number" 
                         value="${surveyor_number}" placeholder="Enter surveyor number">
                </div>
              </div>

              <!-- Regional Number -->
              <div class="mb-3">
                <label for="fe_regional_number" class="form-label fw-semibold">
                  <i class="bi bi-geo-alt me-2"></i>Regional Number
                </label>
                <div class="input-group">
                  <span class="input-group-text bg-light">
                    <i class="bi bi-pin-map"></i>
                  </span>
                  <input type="text" class="form-control" id="fe_regional_number" 
                         value="${regional_number}" placeholder="Enter regional number">
                </div>
              </div>

              <!-- Land Size -->
              <div class="mb-3">
                <label for="fe_land_size" class="form-label fw-semibold">
                  <i class="bi bi-aspect-ratio me-2"></i>Land Size
                </label>
                <div class="input-group">
                  <input type="text" class="form-control" id="fe_land_size" 
                         value="${size_of_land}" placeholder="Enter land size" step="0.111">
                  <span class="input-group-text bg-light">Acre</span>
                </div>
                <!-- <div class="form-text">
                  <i class="bi bi-info-circle me-1"></i>Enter size in acreage
                </div> -->
              </div>

              <!-- Nature of Instrument -->
              <div class="mb-3">
                <label for="fe_nature_of_instrument" class="form-label fw-semibold">
                  <i class="bi bi-file-earmark me-2"></i>Nature of Instrument
                </label>
                <input type="text" class="form-control" id="fe_nature_of_instrument" 
                       value="${nature_of_instrument}">
              </div>

              <!-- Type of Use -->
              <div class="mb-3">
                <label for="fe_type_of_use" class="form-label fw-semibold">
                  <i class="bi bi-building me-2"></i>Type of Use
                </label>
                <input type="text" class="form-control" id="fe_type_of_use" 
                       value="${type_of_use}">
              </div>

              <!-- Type of Interest -->
              <div class="mb-3">
                <label for="fe_type_of_interest" class="form-label fw-semibold">
                  <i class="bi bi-briefcase me-2"></i>Type of Interest
                  <span class="text-danger">*</span>
                </label>
                <select class="form-select" id="fe_type_of_interest" required>
                  <option value="">Select Type of Interest</option>
                  <option value="LEASEHOLD" ${type_of_interest=="LEASEHOLD" ? "selected" : ""}>LEASEHOLD</option>
                  <option value="FREEHOLD" ${type_of_interest=="FREEHOLD" ? "selected" : ""}>FREEHOLD</option>
                </select>
              </div>

              <!-- Consideration Currency -->
              <div class="mb-3">
                <label for="fe_consideration_currency" class="form-label fw-semibold">
                  <i class="bi bi-currency-exchange me-2"></i>Consideration Currency
                  <span class="text-danger">*</span>
                </label>
                <select class="form-select" id="fe_consideration_currency" required>
                  <option value="GHS" ${consideration_fee_currency=="GHS" ? "selected":"" }>Ghana Cedis (GHS)</option>
                  <option value="USD" ${consideration_fee_currency=="USD" ? "selected":"" }>US Dollars (USD)</option>
                  <option value="GBP" ${consideration_fee_currency=="GBP" ? "selected":"" }>Pound Sterling (GBP)</option>
                  <option value="EUR" ${consideration_fee_currency=="EUR" ? "selected":"" }>Euro (EUR)</option>
                </select>
              </div>

              <!-- Date of Document -->
              <div class="mb-3">
                <label for="fe_date_of_document" class="form-label fw-semibold">
                  <i class="bi bi-calendar-date me-2"></i>Date of Document
                  <span class="text-danger">*</span>
                </label>
                <input type="date" class="form-control" id="fe_date_of_document" 
                       value="${date_of_document}" required>
              </div>

              <!-- Commencement Date -->
              <div class="mb-3">
                <label for="fe_commencement_date" class="form-label fw-semibold">
                  <i class="bi bi-calendar-check me-2"></i>Commencement Date
                  <span class="text-danger">*</span>
                </label>
                <input type="date" class="form-control" id="fe_commencement_date" 
                       value="${commencement_date}" required>
              </div>
            </div>

            <!-- Right Column -->
            <div class="col-lg-6">
              <!-- Case Number -->
              <div class="mb-3">
                <label for="fe_case_number" class="form-label fw-semibold">
                  <i class="bi bi-journal-text me-2"></i>Case Number
                </label>
                <input type="text" class="form-control bg-light" id="fe_case_number" 
                       value="${case_number}" readonly>
              </div>

              <!-- Location Fields -->
              <div class="row g-2 mb-3">
                <div class="col-md-4">
                  <label for="fe_locality" class="form-label fw-semibold">
                    <i class="bi bi-geo me-2"></i>Locality
                  </label>
                  <input type="text" class="form-control" id="fe_locality" 
                         value="${locality}" required>
                </div>
                <div class="col-md-4">
                  <label for="fe_district" class="form-label fw-semibold">
                    <i class="bi bi-geo me-2"></i>District
                  </label>
                  <input type="text" class="form-control" id="fe_district" 
                         value="${district}" required>
                </div>
                <div class="col-md-4">
                  <label for="fe_region" class="form-label fw-semibold">
                    <i class="bi bi-geo me-2"></i>Region
                  </label>
                  <input type="text" class="form-control" id="fe_region" 
                         value="${region}" required>
                </div>
              </div>

              <!-- Term -->
              <div class="mb-3">
                <label for="fe_term" class="form-label fw-semibold">
                  <i class="bi bi-clock-history me-2"></i>Term (Years)
                  <span class="text-danger">*</span>
                </label>
                <div class="input-group">
                  <input type="number" class="form-control" id="fe_term" 
                         value="${term}" placeholder="Enter term in years" required>
                  <span class="input-group-text bg-light">Years</span>
                </div>
              </div>

              <!-- Option to Renew -->
              <div class="mb-3">
                <label for="fe_renewal_term" class="form-label fw-semibold">
                  <i class="bi bi-arrow-repeat me-2"></i>Option to Renew
                  <span class="text-danger">*</span>
                </label>
                <input type="text" class="form-control" id="fe_renewal_term" 
                       value="${renewal_term}" required>
              </div>

              <!-- Hidden Family Fields -->
              <input type="hidden" class="form-control" id="fe_family_name" 
                     placeholder="Stool/Family Name">
              <input type="hidden" class="form-control" id="fe_grantor_family">

              <!-- Extent -->
              <div class="mb-3">
                <label for="fe_extent" class="form-label fw-semibold">
                  <i class="bi bi-arrows-angle-expand me-2"></i>Extent
                  <span class="text-danger">*</span>
                </label>
                <input type="text" class="form-control" id="fe_extent" 
                       value="${extent}" required>
              </div>

              <!-- Consideration Fee -->
              <div class="mb-3">
                <label for="fe_consideration_fee" class="form-label fw-semibold">
                  <i class="bi bi-cash-coin me-2"></i>Consideration Fee
                  <span class="text-danger">*</span>
                </label>
                <div class="input-group">
                  <span class="input-group-text bg-light" id="currencySymbol">
                    ${empty fn:trim(consideration_fee_currency) ? 'GHS' : fn:trim(consideration_fee_currency)}
                  </span>
                  <input type="number" class="form-control" id="fe_consideration_fee" 
                         value="${consideration_fee}" placeholder="Enter amount" step="0.01" required>
                </div>
              </div>

              <!-- Annual Rent -->
              <div class="mb-3">
                <label for="fe_annual_rent" class="form-label fw-semibold">
                  <i class="bi bi-cash-stack me-2"></i>Annual Rent
                  <span class="text-danger">*</span>
                </label>
                <div class="input-group">
                  <span class="input-group-text bg-light">GHS</span>
                  <input type="number" class="form-control" id="fe_annual_rent" 
                         value="${annual_rent}" placeholder="Enter annual rent" step="0.01" required>
                </div>
              </div>

              <!-- Transaction Number -->
              <div class="mb-3">
                <label for="fe_transaction_number" class="form-label fw-semibold">
                  <i class="bi bi-receipt me-2"></i>Transaction Number
                </label>
                <input type="text" class="form-control bg-light" id="fe_transaction_number" 
                       value="${transaction_number}" readonly>
              </div>
            </div>
          </div>

          <!-- Divider -->
          <hr class="my-4">

          <!-- Alert Display Space -->
          <div id="alert-display-space" class="mb-4"></div>

          <!-- Form Actions -->
          <div class="d-flex justify-content-between align-items-center">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
              <i class="bi bi-x-circle me-2"></i>Close
            </button>
            <button type="submit" id="btnAddFurtherDetails" class="btn btn-primary">
              <i class="bi bi-check-circle me-2"></i>Save Changes
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur map-modal" id="upload_coordinate" tabindex="-1" aria-labelledby="uploadCoordinateLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable">
    <div class="modal-content border-0 shadow-lg">
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <div class="d-flex align-items-center w-100">
          <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
            <i class="bi bi-geo-alt fs-4"></i>
          </div>
          <div class="flex-grow-1">
            <h5 class="modal-title text-white mb-1" id="uploadCoordinateLabel">
              Noting of Parcel
            </h5>
            <p class="mb-0 small opacity-75">
              <i class="bi bi-info-circle me-1"></i>
              Upload and manage parcel coordinates
            </p>
          </div>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>

      <!-- Modal Body -->
      <div class="modal-body p-4">
        <form action="${pageContext.request.contextPath}/processing_after_payment" method="post" id="parcelForm">
          
          <!-- WKT Polygon Input -->
          <div class="card border mb-4">
            <div class="card-header bg-light">
              <h6 class="mb-0 fw-semibold">
                <i class="bi bi-polygon me-2"></i>WKT Polygon Data
              </h6>
            </div>
            <div class="card-body">
              <div class="mb-0">
                <label for="lc_bl_wkt_polygon" class="form-label fw-semibold">
                  <i class="bi bi-code-slash me-2"></i>WKT Polygon
                </label>
                <div class="input-group">
                  <textarea class="form-control font-monospace" id="lc_bl_wkt_polygon" 
                            name="lc_bl_wkt_polygon" rows="3" 
                            placeholder="POLYGON((...))" readonly style="cursor: not-allowed;">${parcel_wkt}</textarea>
                  <button class="btn btn-outline-secondary" type="button" 
                          data-bs-toggle="tooltip" data-bs-placement="top" 
                          title="Copy to clipboard" onclick="copyWktToClipboard('lc_bl_wkt_polygon')">
                    <i class="bi bi-clipboard"></i>
                  </button>
                </div>
                <div class="form-text">
                  <i class="bi bi-info-circle me-1"></i>
                  Well-Known Text representation of the polygon
                </div>
              </div>
            </div>
          </div>

          <!-- Map Tools Section -->
          <div class="card border mb-4">
            <div class="card-header bg-light">
              <h6 class="mb-0 fw-semibold">
                <i class="bi bi-tools me-2"></i>Map Tools
              </h6>
            </div>
            <div class="card-body">
              <div class="d-flex flex-wrap gap-2 mb-3">
                <!-- Visualization Tools -->
                <button type="button" class="btn btn-primary btn-sm" 
                        id="lc_btn_visualise_wkt"
                        data-bs-toggle="tooltip" data-bs-placement="top" 
                        title="Visualize Polygon">
                  <i class="bi bi-eye me-1"></i> View WKT
                </button>

                <button type="button" class="btn btn-info btn-sm" 
                        id="lc_btn_visualise_search"
                        data-bs-toggle="tooltip" data-bs-placement="top" 
                        title="Plot Parcels">
                  <i class="bi bi-layers me-1"></i> Plot Parcels
                </button>

                <button type="button" class="btn btn-warning btn-sm" 
                        id="lc_btnprintmap"
                        data-bs-toggle="tooltip" data-bs-placement="top" 
                        title="Print Map">
                  <i class="bi bi-printer me-1"></i> Print
                </button>

                <!-- Scale Controls -->
                <div class="d-flex align-items-center ms-auto">
                  <label class="form-label me-2 mb-0 fw-medium">
                    <i class="bi bi-zoom-in me-1"></i>Scale:
                  </label>
                  <div class="input-group input-group-sm" style="width: 200px;">
                    <input type="text" class="form-control" id="lc_scale_value_e" 
                           placeholder="Custom scale">
                    <select class="form-select" data-trigger id="lc_scale_value" style="width: 100px;">
                      <option value="500">500</option>
                      <option value="1107">1107</option>
                      <option value="1250">1250</option>
                      <option value="2500" selected>2500</option>
                      <option value="2140">2140</option>
                      <option value="2670">2670</option>
                      <option value="2215">2215</option>
                      <option value="2825">2825</option>
                      <option value="5000">5000</option>
                      <option value="10000">10000</option>
                      <option value="15000">15000</option>
                      <option value="20000">20000</option>
                    </select>
                  </div>
                </div>

                <!-- Scale Lock -->
                <div class="d-flex align-items-center ms-2">
                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" 
                           id="lc_lockmapscale" checked>
                    <label class="form-check-label small" for="lc_lockmapscale">
                      Lock Scale
                    </label>
                  </div>
                  <button type="button" class="btn btn-outline-secondary btn-sm ms-2" 
                          id="lc_btn_scale_zoom"
                          data-bs-toggle="tooltip" data-bs-placement="top" 
                          title="Zoom to Scale">
                    <i class="bi bi-search"></i>
                  </button>
                </div>
              </div>
            </div>
          </div>

          <!-- Map Container -->
          <div class="card border mb-4">
            <div class="card-header bg-light d-flex justify-content-between align-items-center">
              <h6 class="mb-0 fw-semibold">
                <i class="bi bi-globe me-2"></i>Map Preview
              </h6>
              <small class="text-muted">
                <i class="bi bi-arrows-fullscreen me-1"></i>Click and drag to navigate
              </small>
            </div>
            <div class="card-body p-0">
              <div class="map-container" id="lc-map" style="height: 400px;"></div>
            </div>
          </div>

          <!-- Coordinate Management -->
          <div class="card border">
            <div class="card-header bg-light">
              <h6 class="mb-0 fw-semibold">
                <i class="bi bi-geo me-2"></i>Coordinate Management
              </h6>
            </div>
            <div class="card-body">
              <!-- Action Buttons -->
              <div class="d-flex flex-wrap gap-2 mb-4">
                <button type="button" class="btn btn-primary btn-sm" 
                        id="lc_btn_add_coordinate"
                        data-bs-placement="top" data-bs-title="Add Coordinate">
                  <i class="bi bi-plus-circle me-1"></i> Add Coordinate
                </button>

                <button type="button" class="btn btn-success btn-sm" 
                        id="lrd_btn_add_coordinate_by_csv"
                        data-bs-toggle="modal" data-bs-target="#uploadcoordiantecsv"
                        data-bs-placement="top" data-bs-title="Upload CSV">
                  <i class="bi bi-upload me-1"></i> Upload CSV
                </button>

                <button type="button" class="btn btn-info btn-sm" 
                        id="lc_btn_visualise_coordinate_gf"
                        data-bs-placement="top" data-bs-title="Visualize Polygon">
                  <i class="bi bi-eye me-1"></i> Visualize
                </button>

                <button type="button" class="btn btn-warning btn-sm" 
                        id="btn_lc_save_parcel_for_general_noting"
                        data-bs-placement="top" data-bs-title="Save Parcel">
                  <i class="bi bi-save me-1"></i> Save Parcel
                </button>

                <button type="button" class="btn btn-outline-danger btn-sm ms-auto" 
                        id="btn_clear_all_coordinates"
                        data-bs-placement="top" data-bs-title="Clear All">
                  <i class="bi bi-trash me-1"></i> Clear All
                </button>
              </div>

              <!-- Coordinates Table -->
              <div class="table-responsive">
                <table class="table table-hover table-sm" id="coordinatelis_Table">
                  <thead class="table-light">
                    <tr>
                      <th width="30%">
                        <i class="bi bi-tag me-1"></i>Coordinate Name
                      </th>
                      <th width="25%">
                        <i class="bi bi-arrow-right me-1"></i>X Coordinate
                      </th>
                      <th width="25%">
                        <i class="bi bi-arrow-up me-1"></i>Y Coordinate
                      </th>
                      <th width="20%" class="text-center">
                        <i class="bi bi-gear me-1"></i>Actions
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    <!-- Data will be inserted dynamically -->
                    <tr id="noCoordinatesRow">
                      <td colspan="4" class="text-center py-4">
                        <div class="text-muted">
                          <i class="bi bi-geo fs-1 mb-2 d-block"></i>
                          <p class="mb-0">No coordinates added</p>
                          <small>Click "Add Coordinate" or "Upload CSV" to get started</small>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </form>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer bg-light">
        <div class="d-flex justify-content-between w-100 align-items-center">
          <div>
            <small class="text-muted">
              <i class="bi bi-info-circle me-1"></i>
              <span id="coordinateSummary">No coordinates added</span>
            </small>
          </div>
          <div>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
              <i class="bi bi-x-circle me-1"></i>Close
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>