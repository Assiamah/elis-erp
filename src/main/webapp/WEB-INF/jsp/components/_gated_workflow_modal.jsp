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

<jsp:useBean id="now" class="java.util.Date" />

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
                                        <th>Bill Amount (GHS)</th>
                                        <th>Receipt Number</th>
                                        <th>Payment Date</th>
                                        <th>Paid Amount (GHS)</th>
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
                                                <!-- <div class="d-flex align-items-center">
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
                                                                ${payment_bill_row.payment_amount > payment_bill_row.bill_amount ? 'Paid' : 'Not Paid'}
                                                            </small>
                                                        </c:if>
                                                    </div>
                                                </div> -->
                                                <span class="fw-semibold">${payment_bill_row.payment_amount}</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${payment_bill_row.payment_amount >= payment_bill_row.bill_amount}">
                                                        <span class="badge bg-success">
                                                            <i class="bi bi-check-circle me-1"></i>Fully Paid
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${payment_bill_row.payment_amount == 0 || payment_bill_row.payment_amount == null}">
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
                                                    <c:if test="${payment_bill_row.payment_amount == 0 || payment_bill_row.payment_amount == null || payment_bill_row.payment_amount == ''}">
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
                            Review Documents (Public Documents)
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
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i> Close
                        </button>
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
                    data-bs-toggle="modal" data-bs-target="#addeditpartyGeneral"
                    data-type_of_party="Grantor" data-bs-placement="top" data-bs-title="Add Grantor">
              <i class="bi bi-person-plus me-2"></i>Add Grantor
            </button>
          </div>
          <div class="col-md-6">
            <button type="button" class="btn btn-success addeditpartyGeneralBtn w-100" id="lrd_btn_add_grantee" 
                    data-bs-toggle="modal" data-bs-target="#addeditpartyGeneral"
                    data-type_of_party="Applicant" data-bs-placement="top" data-bs-title="Add Applicant">
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
                              data-bs-toggle="modal"
                              data-bs-target="#addeditpartyGeneral"
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
                              data-bs-toggle="modal"
                              data-bs-target="#deletepartyGeneral"
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
  <div class="modal-dialog modal-lg modal-dialog-centered modal-fullscreen modal-dialog-scrollable">
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
        <div class="row" style="height: 100vh;">
          <div class="col-md-6  d-flex flex-column scrollable-col">
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
              <!-- <span class="text-danger">*</span> -->
            </label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="bi bi-telephone"></i>
              </span>
              <input type="tel" class="form-control" placeholder="Enter phone number" 
                     id="party_ar_cell_phone_gen" required>
            </div>
            <small class="form-text text-muted">
              <i class="bi bi-info-circle me-1"></i>This field is required for applicant
            </small>
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
              <!-- <option value="Applicant">Applicant</option> -->
              <option value="Grantor">Grantor</option>
              <option value="Grantee">Grantee</option>
              <option value="Assignor">Assignor</option>
              <option value="Assignee">Assignee</option>
              <option value="Mortgagor">Mortgagor</option>
              <option value="Mortgagee">Mortgagee</option>
              <option value="Lessee">Lessee</option>
              <option value="Lessor">Lessor</option>
              <option value="Depositor">Depositor</option>
              <option value="Donor">Donor</option>
              <option value="Donee">Donee</option>
              <option value="Appointer">Appointer</option>
              <option value="Appointee">Appointee</option>
              <option value="Sub Lessee">Sub Lessee</option>
              <option value="Sub Lessor">Sub Lessor</option>
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
          <div class="col-md-6 d-flex flex-column scrollable-col">
            <div class="_gated_workflow_documents"></div>
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
  <div class="modal-dialog modal-dialog-centered modal-fullscreen modal-dialog-scrollable">
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
        <div class="row" style="height: 100vh;">
          <div class="col-md-6 d-flex flex-column scrollable-col">
            
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
                         value="${licensed_surveyor_number}" placeholder="Enter surveyor number">
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
                  <i class="bi bi-arrow-repeat me-2"></i>Option to Renew?
                  <span class="text-danger">*</span>
                </label>
                <div class="form-check ">
                  <input class="form-check-input" type="radio" name="fe_renewal_term_check" id="fe_renewal_term_yes" value="yes" ${renewal_term > 0 ? 'checked' : ''}>
                  <label class="form-check-label" for="fe_renewal_term_yes">
                    Yes
                  </label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="radio" name="fe_renewal_term_check" id="fe_renewal_term_no" value="no" ${renewal_term < 1 ? 'checked' : ''}>
                  <label class="form-check-label" for="fe_renewal_term_no">
                    No
                  </label>
                </div>
                <div id="fe_renewal_term_div" class="mt-2 ${renewal_term < 1 ? 'd-none' : ''}">
                  <label for="fe_renewal_term" class="form-label fw-semibold">
                    <i class="bi bi-arrow-repeat me-2"></i>Renewal Term (Years)
                    <span class="text-danger">*</span>
                  </label>
                  <input type="text" class="form-control" id="fe_renewal_term" 
                         value="${renewal_term}" required>
                </div>
              </div>

              <!-- Hidden Family Fields -->
              <input type="hidden" class="form-control" id="fe_family_name" 
                     placeholder="Stool/Family Name">
              <input type="hidden" class="form-control" id="fe_grantor_family">

              <!-- Extent -->
              <div class="mb-3">
                <label for="fe_extent" class="form-label fw-semibold">
                  <i class="bi bi-arrows-angle-expand me-2"></i>Extent (Land Size)
                  <span class="text-danger">*</span>
                </label>
                <div class="input-group">
                  <button class="btn btn-secondary" id="convert_acres_to_extent">
                    <i class="bi bi-arrow-repeat me-2"></i>Load Extent
                  </button>
                  <input type="text" class="form-control bg-light" id="fe_extent" value="${extent}" required readonly>
                </div>
                <!-- <input type="text" class="form-control" id="fe_extent" 
                       value="${extent}" required> -->
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
          <div class="col-md-6  d-flex flex-column scrollable-col">
            <div class="_gated_workflow_documents"></div>
          </div>
        </div>
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

                <!-- <button type="button" class="btn btn-info btn-sm" 
                        id="lc_btn_visualise_search"
                        data-bs-toggle="tooltip" data-bs-placement="top" 
                        title="Plot Parcels">
                  <i class="bi bi-layers me-1"></i> Plot Parcels
                </button> -->

                <!-- <button type="button" class="btn btn-warning btn-sm" 
                        id="lc_btnprintmap"
                        data-bs-toggle="tooltip" data-bs-placement="top" 
                        title="Print Map">
                  <i class="bi bi-printer me-1"></i> Print
                </button> -->

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

<div class="modal map-modal fade effect-scale modal-blur" id="visualise_and_confirm" tabindex="-1" aria-labelledby="visualise_and_confirm_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center w-100">
                <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
                    <i class="bi bi-geo-alt fs-4"></i>
                </div>
                <div class="flex-grow-1">
                    <h5 class="modal-title text-white mb-1" id="uploadCoordinateLabel">
                    Visualise and Confirm
                    </h5>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- WKT Polygon Input Section -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body">
                        <h6 class="card-title mb-3">
                            <i class="fas fa-draw-polygon text-primary me-2"></i>
                            Polygon Definition
                        </h6>
                        <div class="mb-3">
                            <label for="lc_bl_wkt_polygon" class="form-label fw-medium">WKT Polygon</label>
                            <div class="input-group">
                                <input class="form-control" id="lc_bl_wkt_polygon" name="lc_bl_wkt_polygon" 
                                       type="text" value="${parcel_wkt}" placeholder="Enter WKT polygon">
                                <button class="btn btn-outline-secondary" type="button" id="btn_copy_wkt" onclick="copyWktToClipboard('lc_bl_wkt_polygon')">
                                    <i class="fas fa-copy"></i>
                                </button>
                            </div>
                            <small class="form-text text-muted mt-1">
                                <i class="fas fa-info-circle me-1"></i>
                                Well-Known Text representation of the polygon (e.g., POLYGON((x y, x y, ...)))
                            </small>
                        </div>
                    </div>
                </div>
                
                <!-- Map Controls Section -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body">
                        <h6 class="card-title mb-3">
                            <i class="fas fa-sliders-h text-primary me-2"></i>
                            Map Controls
                        </h6>
                        
                        <!-- Primary Action Buttons -->
                        <div class="d-flex flex-wrap gap-2 mb-4">
                            <button type="button" class="btn btn-primary" id="lc_btn_visualise_wkt" 
                                    data-bs-toggle="tooltip" data-bs-placement="top" title="Visualise Polygon from WKT">
                                <i class="fas fa-map me-2"></i>
                                Visualise Polygon
                            </button>
                            
                            <button type="button" class="btn btn-outline-primary" id="lc_btn_visualise_search" 
                                    data-bs-toggle="tooltip" data-bs-placement="top" title="Search and Visualise">
                                <i class="fas fa-search me-2"></i>
                                Search
                            </button>
                            
                            <button type="button" class="btn btn-outline-secondary" id="lc_btnprintmap" 
                                    data-bs-toggle="tooltip" data-bs-placement="top" title="Print Map View">
                                <i class="fas fa-print me-2"></i>
                                Print
                            </button>
                        </div>
                        
                        <!-- Scale Controls -->
                        <div class="row g-3 align-items-center mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Map Scale</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-ruler-combined"></i>
                                    </span>
                                    <select class="form-select" name="lc_scale_value" id="lc_scale_value">
                                        <option value="500">1:500</option>
                                        <option value="1107">1:1,107</option>
                                        <option value="1250">1:1,250</option>
                                        <option value="2140">1:2,140</option>
                                        <option value="2215">1:2,215</option>
                                        <option value="2500">1:2,500</option>
                                        <option value="2670">1:2,670</option>
                                        <option value="2825">1:2,825</option>
                                        <option value="5000" selected>1:5,000</option>
                                        <option value="10000">1:10,000</option>
                                        <option value="15000">1:15,000</option>
                                        <option value="20000">1:20,000</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Custom Scale</label>
                                <div class="input-group">
                                    <span class="input-group-text">1:</span>
                                    <input type="number" class="form-control" id="lc_scale_value_e" 
                                           name="lc_scale_value_e" placeholder="Enter custom scale">
                                    <div class="input-group-text">
                                        <div class="form-check form-check-inline m-0">
                                            <input class="form-check-input" type="checkbox" checked id="lc_lockmapscale">
                                            <label class="form-check-label small ms-1" for="lc_lockmapscale">
                                                Lock
                                            </label>
                                        </div>
                                    </div>
                                    <button class="btn btn-outline-primary" type="button" id="lc_btn_scale_zoom">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Zoom Controls -->
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <label class="form-label fw-medium me-3">Zoom Tools:</label>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-outline-secondary" id="btn_zoom_full"
                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Fit to Extent">
                                        <i class="fas fa-expand-arrows-alt"></i>
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary" id="btn_zoom_out"
                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Zoom Out">
                                        <i class="fas fa-search-minus"></i>
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary" id="btn_zoom_in"
                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Zoom In">
                                        <i class="fas fa-search-plus"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-center">
                                <div class="me-3">
                                    <span class="badge bg-info" id="mapStatus">
                                        <i class="fas fa-check-circle me-1"></i>
                                        Ready
                                    </span>
                                </div>
                                <button type="button" class="btn btn-outline-info btn-sm" id="btn_map_info">
                                    <i class="fas fa-info-circle"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Map Visualization Section -->
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-0">
                        <div class="d-flex justify-content-between align-items-center p-3 border-bottom">
                            <h6 class="card-title mb-0">
                                <i class="fas fa-globe-americas text-primary me-2"></i>
                                Map Visualization
                            </h6>
                            <div class="small text-muted">
                                <i class="fas fa-mouse-pointer me-1"></i>
                                Click and drag to navigate
                            </div>
                        </div>
                        
                        <div class="map-container" id="lc-map_" style="height: 400px;">
                            <!-- Loading placeholder -->
                            <!-- <div class="h-100 w-100 d-flex flex-column align-items-center justify-content-center bg-light">
                                <i class="fas fa-map-marked-alt fa-3x text-muted mb-3"></i>
                                <p class="text-muted mb-1">Map visualization will appear here</p>
                                <small class="text-muted">Click "Visualise Polygon" to load the map</small>
                            </div> -->
                        </div>
                    </div>
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-exclamation-circle me-1"></i>
                        Verify polygon before proceeding
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        <!-- <button type="button" class="btn btn-success" id="btn_confirm_visualisation">
                            <i class="fas fa-check me-1"></i>
                            Confirm & Proceed
                        </button> -->
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="send_to_frrv" tabindex="-1" aria-labelledby="sendToFrrvLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <div class="d-flex align-items-center w-100">
          <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
            <i class="bi bi-send fs-4"></i>
          </div>
          <div class="flex-grow-1">
            <h5 class="modal-title text-white mb-1" id="sendToFrrvLabel">
              Send to FRRV
            </h5>
            <p class="mb-0 small opacity-75">
              <i class="bi bi-info-circle me-1"></i>
              Forward case for first registration records reverification
            </p>
          </div>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>

      <!-- Modal Body -->
      <div class="modal-body p-4">
        <!-- Job Number Input -->
        <div class="mb-4">
          <label for="send_ffrv_job_number" class="form-label fw-semibold">
            <i class="bi bi-file-earmark-text me-2"></i>Job Number
          </label>
          <div class="input-group">
            <span class="input-group-text bg-light">
              <i class="bi bi-hash"></i>
            </span>
            <input type="text" class="form-control bg-light" 
                   id="send_ffrv_job_number" value="${job_number}" 
                   readonly>
            <button class="btn btn-outline-secondary" type="button" 
                    onclick="copyToClipboard('send_ffrv_job_number')"
                    data-bs-toggle="tooltip" data-bs-placement="top" 
                    title="Copy to clipboard">
              <i class="bi bi-clipboard"></i>
            </button>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="d-grid gap-2 mb-4">
          <button class="btn btn-primary btn-lg" id="btn_send_to_frrv">
            <i class="bi bi-send me-2"></i>Send to FRRV
          </button>
          
          <div class="text-center">
            <a href="#" class="text-decoration-none" 
               data-bs-toggle="modal" data-bs-target="#fileUploadModal">
              <i class="bi bi-upload me-1"></i>
              Upload Existing Records Information
            </a>
          </div>
        </div>

        <!-- Department Status -->
        <div class="card border">
          <div class="card-header bg-light">
            <h6 class="mb-0 fw-semibold">
              <i class="bi bi-building me-2"></i>Division Status
            </h6>
          </div>
          <div class="card-body p-0">
            <ul class="list-group list-group-flush">
              <!-- LRD Status -->
              <li class="list-group-item py-3">
                <div class="d-flex justify-content-between align-items-center">
                  <div class="d-flex align-items-center">
                    <div class="avatar avatar-sm text-primary bg-light-primary rounded-circle me-3">
                      <i class="bi bi-file-check"></i>
                    </div>
                    <div>
                      <span class="fw-semibold">LRD</span>
                      <small class="text-muted d-block">Land Registration Division</small>
                    </div>
                  </div>
                  <div>
                    <h5 class="mb-0" id="send_lrd_badge_ffrv_v">
                      <!-- <span class="badge bg-success">Completed</span> -->
                    </h5>
                  </div>
                </div>
              </li>
              
              <!-- SMD Status -->
              <li class="list-group-item py-3">
                <div class="d-flex justify-content-between align-items-center">
                  <div class="d-flex align-items-center">
                    <div class="avatar avatar-sm text-warning bg-light-warning rounded-circle me-3">
                      <i class="bi bi-clipboard-check"></i>
                    </div>
                    <div>
                      <span class="fw-semibold">SMD</span>
                      <small class="text-muted d-block">Survey & Mapping Division</small>
                    </div>
                  </div>
                  <div>
                    <h5 class="mb-0" id="send_smd_badge_ffrv_v">
                      <!-- <span class="badge bg-warning">Pending</span> -->
                    </h5>
                  </div>
                </div>
              </li>
              
              <!-- PVLMD Status -->
              <li class="list-group-item py-3">
                <div class="d-flex justify-content-between align-items-center">
                  <div class="d-flex align-items-center">
                    <div class="avatar avatar-sm text-info bg-light-info rounded-circle me-3">
                      <i class="bi bi-file-earmark-check"></i>
                    </div>
                    <div>
                      <span class="fw-semibold">PVLMD</span>
                      <small class="text-muted d-block">Public & Vested Land Management Division</small>
                    </div>
                  </div>
                  <div>
                    <h5 class="mb-0" id="send_pvlmd_badge_ffrv_v">
                      <!-- <span class="badge bg-secondary">Not Started</span> -->
                    </h5>
                  </div>
                </div>
              </li>
            </ul>
          </div>
          <!-- <div class="card-footer bg-light py-2">
            <small class="text-muted">
              <i class="bi bi-info-circle me-1"></i>
              All departments must be completed before sending to FRRV
            </small>
          </div> -->
        </div>

        <!-- Additional Information -->
        <div class="alert alert-info mt-4">
          <div class="d-flex">
            <div class="me-3">
              <i class="bi bi-clock-history fs-4"></i>
            </div>
            <div>
              <h6 class="alert-heading mb-2">Processing Timeline</h6>
              <p class="mb-0 small">
                • FRRV review typically takes 3-5 working days<br>
                • Ensure all documents are properly uploaded<br>
                • Case will be locked for editing during FRRV review
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer bg-light">
        <div class="d-flex justify-content-between w-100 align-items-center">
          <div class="text-start">
            <small class="text-muted">
              <i class="bi bi-calendar me-1"></i>
              <span id="currentDate">${now}</span>
            </small>
          </div>
          <div>
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
              <i class="bi bi-x-circle me-1"></i>Close
            </button>
          </div>
        </div>
        
        <!-- Hidden fields -->
        <input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id">
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="review_records_verification" tabindex="-1"
     aria-labelledby="review_records_verification_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="review_records_verification_label">
                    <i class="fas fa-clipboard-check me-2"></i>
                    Records Verification (FRRV)
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Application Notes Section -->
                <div class="card border">
                    <div class="card-header bg-light py-2">
                        <h6 class="mb-0">
                            <i class="fas fa-sticky-note me-2"></i>
                            Records Information
                        </h6>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover table-sm mb-0" id="lrd_notes_dataTable">
                                <thead class="table-light">
                                    <tr>
                                        <th>Records Info.</th>
                                        <th>Entered By</th>
                                        <th>Entered Date</th>
                                        <th>Division</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${application_notes}" var="application_notes_row">
                                    <tr class="${application_notes_row.an_status == false ? 'table-danger' : ''}" 
                                        ${application_notes_row.an_status == false ? "data-bs-toggle='tooltip' data-bs-placement='top' title='Note has been disabled'" : ""}>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="fas fa-comment text-muted me-2"></i>
                                                <span class="text-truncate" style="max-width: 200px;">
                                                    ${application_notes_row.an_description}
                                                </span>
                                                ${application_notes_row.an_status == false ? 
                                                    '<span class="badge bg-danger ms-2">Disabled</span>' : ''}
                                            </div>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="fas fa-user-circle text-muted me-2"></i>
                                                <span>${application_notes_row.created_by}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="fas fa-calendar-alt text-muted me-2"></i>
                                                <span>${application_notes_row.created_date}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-secondary bg-opacity-10 text-dark">
                                                ${application_notes_row.division}
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-outline-primary btn-sm viewNotesModal" 
                                                    data-target-id="${application_notes_row.an_id}"
                                                    data-an_description="${application_notes_row.an_description}"
                                                    data-created_by="${application_notes_row.created_by}"
                                                    data-created_date="${application_notes_row.created_date}"
                                                    data-modified_by="${application_notes_row.created_by}"
                                                    data-modified_date="${application_notes_row.created_date}"
                                                    data-division="${application_notes_row.division}"
                                                    ${application_notes_row.an_status == false ? "disabled" : ""}>
                                                <i class="fas fa-eye me-1"></i>
                                                View
                                            </button>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Attachments Section -->
                <div class="mb-4">
                    <a href="#" class="text-decoration-none" id="view_existing_records_info">
                        <i class="ri-attachment-line me-1"></i>
                        View Attachments (Existing Records Information)
                    </a>
                    
                    <div class="card border mt-2 d-none" id="exreinfo_table">
                        <div class="card-header bg-light py-2">
                            <h6 class="mb-0">
                                <i class="fas fa-folder me-2"></i>
                                Scanned Documents
                            </h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover table-sm mb-0" id="lc_frrv_scanned_documents_dataTable">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Document Name</th>
                                            <th>Document Type</th>
                                            <th>Action</th>
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
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Review all records before verification
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        <button type="button" id="btn_update_app_status_ffrv" style="display:none"
                                class="btn btn-success">
                            <i class="fas fa-check me-1"></i>
                            Confirm Final Approval
                        </button>
                    </div>
                </div>
                <input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id">
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="viewNotesModal" tabindex="-1" aria-labelledby="viewNotesModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" data-bs-backdrop="static">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white" style="cursor: move;">
                <h5 class="modal-title text-white" id="viewNotesModalLabel">
                    <i class="fas fa-sticky-note me-2"></i>
                    View Note Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <div class="card border-0">
                    <div class="card-body p-0">
                        <form id="form_view_notes">
                            
                            <!-- Hidden Fields -->
                            <input type="hidden" id="vi_note_id" name="vi_note_id" value="0">
                            <input type="hidden" id="vi_an_job_number" value="${job_number}">
                            <input type="hidden" id="vi_an_case_number" value="${case_number}">
                            <input type="hidden" id="vi_an_type" value="Normal">
                            
                            <!-- Description Section -->
                            <div class="mb-4">
                                <div class="form-group">
                                    <label for="vi_note_description" class="form-label fw-medium">
                                        <i class="fas fa-align-left me-1"></i>
                                        Note Description
                                    </label>
                                    <div class="border rounded p-3 bg-light" style="min-height: 150px;">
                                        <div id="vi_note_description" class="note-content"></div>
                                    </div>
                                </div>
                                <div class="form-group mt-2">
                                    <label for="vi_job_number" class="form-label fw-medium">
                                        <i class="fas fa-hashtag me-1"></i>
                                        Job Number
                                    </label>
                                    <div class="border rounded p-3">
                                        <div id="vi_job_number" class="note-content"></div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Metadata Section -->
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="card border">
                                        <div class="card-header bg-light py-2">
                                            <h6 class="mb-0">
                                                <i class="fas fa-user-plus me-1"></i>
                                                Creation Details
                                            </h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="mb-3">
                                                <label class="form-label small text-muted mb-1">Created By</label>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm bg-primary bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-2">
                                                        <i class="fas fa-user text-primary"></i>
                                                    </div>
                                                    <span id="vi_created_by" class="fw-medium"></span>
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label small text-muted mb-1">Created Date</label>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm bg-success bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-2">
                                                        <i class="fas fa-calendar text-success"></i>
                                                    </div>
                                                    <span id="vi_created_date" class="fw-medium"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="card border">
                                        <div class="card-header bg-light py-2">
                                            <h6 class="mb-0">
                                                <i class="fas fa-user-edit me-1"></i>
                                                Modification Details
                                            </h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="mb-3">
                                                <label class="form-label small text-muted mb-1">Modified By</label>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm bg-info bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-2">
                                                        <i class="fas fa-user-edit text-info"></i>
                                                    </div>
                                                    <span id="vi_modified_by" class="fw-medium">No modifications</span>
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label small text-muted mb-1">Modified Date</label>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm bg-warning bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-2">
                                                        <i class="fas fa-calendar-alt text-warning"></i>
                                                    </div>
                                                    <span id="vi_modified_date" class="fw-medium">Not modified</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <!-- <i class="fas fa-clock me-1"></i>
                        Last updated: <span id="vi_last_updated">Just now</span> -->
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        <button type="button" class="btn btn-outline-primary" id="btn_print_note">
                            <i class="fas fa-print me-1"></i>
                            Print
                        </button>
                        <!-- <button type="button" class="btn btn-primary" id="btn_edit_note">
                            <i class="fas fa-edit me-1"></i>
                            Edit Note
                        </button> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="review_documents" tabindex="-1"
     aria-labelledby="review_documents_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="review_documents_label">
                    <i class="fas fa-file-alt me-2"></i>
                    Review Documents (Application & Public Documents)
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Documents Accordion -->
                <div class="accordion" id="documentsAccordion">
                    
                    <!-- Application Documents Card -->
                    <div class="accordion-item border rounded mb-3">
                        <h2 class="accordion-header" id="headingApplication">
                            <button class="accordion-button collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#collapseApplication" 
                                    aria-expanded="false" aria-controls="collapseApplication">
                                <div class="d-flex align-items-center w-100">
                                    <div class="me-3">
                                        <i class="fas fa-folder-open fa-lg text-primary"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0">Application Documents</h6>
                                        <small class="text-muted">Private application documents</small>
                                    </div>
                                    <span class="badge bg-primary rounded-pill ms-2" id="appDocsCount">0</span>
                                </div>
                            </button>
                        </h2>
                        <div id="collapseApplication" class="accordion-collapse collapse" 
                             aria-labelledby="headingApplication" data-bs-parent="#documentsAccordion">
                            <div class="accordion-body">
                                
                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <button type="button" class="btn btn-success btn-sm me-2" 
                                                onclick="loadReviewApplicationDocuments()">
                                            <i class="fas fa-sync-alt me-1"></i>
                                            Refresh
                                        </button>
                                        <button type="button" class="btn btn-primary btn-sm" 
                                                data-bs-toggle="modal" data-bs-target="#fileUploadModal"
                                                data-bs-placement="top" title="Add Documents">
                                            <i class="fas fa-plus-circle me-1"></i>
                                            Add Document
                                        </button>
                                    </div>
                                    <div>
                                        <!-- <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_export_app_docs">
                                            <i class="fas fa-download me-1"></i>
                                            Export
                                        </button> -->
                                    </div>
                                </div>
                                
                                <!-- Documents Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lc_review_scanned_documents_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="55%">Document Name</th>
                                                <th width="30%">Document Type</th>
                                                <!-- <th width="15%">Size</th> -->
                                                <th width="15%" class="text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                           
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- Empty State -->
                                <div id="appDocsEmpty" class="text-center py-5 d-none">
                                    <div class="mb-3">
                                        <i class="fas fa-file-alt fa-3x text-muted"></i>
                                    </div>
                                    <h6 class="text-muted">No Application Documents</h6>
                                    <p class="text-muted small mb-0">Click "Add Document" to upload files</p>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    
                    <!-- Public Documents Card -->
                    <div class="accordion-item border rounded">
                        <h2 class="accordion-header" id="headingPublic">
                            <button class="accordion-button collapsed" type="button" 
                                    data-bs-toggle="collapse" data-bs-target="#collapsePublic" 
                                    aria-expanded="false" aria-controls="collapsePublic">
                                <div class="d-flex align-items-center w-100">
                                    <div class="me-3">
                                        <i class="fas fa-users fa-lg text-success"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-0">Public Documents</h6>
                                        <small class="text-muted">Publicly accessible documents</small>
                                    </div>
                                    <span class="badge bg-success rounded-pill ms-2" id="publicDocsCount">0</span>
                                </div>
                            </button>
                        </h2>
                        <div id="collapsePublic" class="accordion-collapse collapse" 
                             aria-labelledby="headingPublic" data-bs-parent="#documentsAccordion">
                            <div class="accordion-body">
                                
                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <button type="button" class="btn btn-success btn-sm me-2" onclick="loadReviewPublicDocuments()">
                                            <i class="fas fa-sync-alt me-1"></i>
                                            Refresh
                                        </button>
                                        <button type="button" class="btn btn-primary btn-sm" 
                                                data-bs-toggle="modal" data-bs-target="#publicFileUploadModal"
                                                data-bs-placement="top" title="Add Public Documents">
                                            <i class="fas fa-plus-circle me-1"></i>
                                            Add Public Document
                                        </button>
                                    </div>
                                    <div>
                                        <!-- <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_export_public_docs">
                                            <i class="fas fa-download me-1"></i>
                                            Export
                                        </button> -->
                                    </div>
                                </div>
                                
                                <!-- Public Documents Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lc_review_public_documents_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="55%">Document Name</th>
                                                <th width="30%">Document Type</th>
                                                <!-- <th width="15%">Size</th> -->
                                                <th width="15%" class="text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- Empty State -->
                                <div id="publicDocsEmpty" class="text-center py-5 d-none">
                                    <div class="mb-3">
                                        <i class="fas fa-users fa-3x text-muted"></i>
                                    </div>
                                    <h6 class="text-muted">No Public Documents</h6>
                                    <p class="text-muted small mb-0">Click "Add Public Document" to upload files</p>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Total Documents: 
                        <span class="fw-medium" id="totalDocumentsCount">0</span>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        <button type="button" id="btn_update_app_status_ffrv" style="display:none"
                                class="btn btn-success">
                            <i class="fas fa-check me-1"></i>
                            Confirm Final Approval
                        </button>
                    </div>
                </div>
                <input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id">
            </div>
            
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="sent_for_publication" tabindex="-1"
     aria-labelledby="sent_for_publication_label" aria-hidden="true" data-bs-backdrop="static">
     <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="sent_for_publication_label">
                    <i class="fas fa-bullhorn me-2"></i>
                    Check for Publication
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Publication Status Card -->
                <div class="card border mb-4">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 d-flex align-items-center">
                            <i class="fas fa-info-circle text-primary me-2"></i>
                            Publication Status
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="avatar-sm bg-light-primary rounded-circle d-flex align-items-center justify-content-center me-3">
                                <i class="fas fa-calendar-alt text-primary"></i>
                            </div>
                            <div class="flex-grow-1">
                                <label class="form-label fw-medium mb-1">Publication Date</label>
                                <div class="text-muted small">
                                    <c:choose>
                                        <c:when test="${(not empty fn:trim(publicity_date) and publicity_date != 'null') and not fn:contains(publicity_date, '-')}">
                                            <span class="badge bg-success">Already Set</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning">Not Set</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- <span>${publicity_date}</span> -->
                <!-- Publication Instructions -->
                <div class="alert alert-info border-info bg-info bg-opacity-10">
                    <div class="d-flex">
                        <div class="me-3">
                            <i class="fas fa-lightbulb fa-lg"></i>
                        </div>
                        <div>
                            <h6 class="alert-heading mb-2">Publication Notice</h6>
                            <p class="small mb-0">
                                Set the publication date if application has already been sent for publication otherwise click on the green button below to send for publication
                            </p>
                        </div>
                    </div>
                </div> 
                <!-- Publication Date Section -->
                <div class="mb-4">
                    <label for="lc_txt_publicity_date" class="form-label fw-medium">
                        <i class="fas fa-calendar-day me-1"></i>
                        Set Publication Date
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-calendar"></i>
                        </span>
                        <c:choose>
                            <c:when test="${(not empty fn:trim(publicity_date) and publicity_date != 'null') and not fn:contains(publicity_date, '-')}">
                                <input type="date" class="form-control bg-light" id="lc_txt_publicity_date" style="cursor:not-allowed" 
                                       value="${publicity_date}" readonly />
                            </c:when>
                            <c:otherwise>
                                <input type="date" class="form-control" id="lc_txt_publicity_date" 
                                       value="${publicity_date}" />
                            </c:otherwise>
                        </c:choose>
                        <button class="btn btn-warning" type="button" id="lc_btn_update_publication_date"
                            <c:if test="${(not empty fn:trim(publicity_date) and publicity_date ne 'null') and not fn:contains(publicity_date, '-')}">
                                disabled
                            </c:if>>
                            <i class="fas fa-save me-1"></i>
                            Update
                        </button>
                    </div>
                    <small class="form-text text-muted mt-1">
                        Select the date when it was published
                    </small>
                </div>

                <hr class="text-muted">
                
                <!-- Send for Publication Button -->
                <div class="mb-4 mt-2">
                    <button class="btn btn-primary w-100 py-3" id="lc_btn_add_to_publication_list"
                        <c:if test="${(not empty fn:trim(publicity_date) and publicity_date != 'null') and not fn:contains(publicity_date, '-')}">
                            disabled
                        </c:if>>
                        <div class="d-flex align-items-center justify-content-center">
                            <div class="me-3">
                                <i class="fas fa-upload fa-lg"></i>
                            </div>
                            <div class="text-start">
                                <div class="fw-medium">Send for Publication</div>
                                <small class="d-block opacity-75">Submit for public notice publishing</small>
                            </div>
                        </div>
                    </button>
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <!-- <i class="fas fa-clock me-1"></i>
                        Current Date: <span id="currentDateDisplay"></span> -->
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        <!-- <button type="button" class="btn btn-outline-info" id="btn_view_publication_schedule">
                            <i class="fas fa-list me-1"></i>
                            View Schedule
                        </button> -->
                    </div>
                </div>
            </div>
        </div>
     </div>
  </div>

  <div class="modal fade effect-scale modal-blur" id="send_for_title_plan_preparation" tabindex="-1"
     aria-labelledby="send_for_title_plan_preparation_label" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-md">
     <div class="modal-content border-0 shadow-lg">
        
        <!-- Modal Header -->
        <div class="modal-header bg-primary text-white">
           <h5 class="modal-title text-white" id="send_for_title_plan_preparation_label">
              <i class="fas fa-map-marked-alt me-2"></i>
              Title Plan Preparation
           </h5>
           <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        
        <!-- Modal Body -->
        <div class="modal-body">
            <input  id="gid_pl_smd" name="gid_pl_smd" type="hidden" value="0" >
            <input  id="lc_txt_transaction_number_pl_smd" name="lc_txt_transaction_number_pl_smd" type="hidden" value="0" >
            <!-- Status Indicator -->
            <div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
                <div class="d-flex align-items-center">
                    <i class="fas fa-info-circle me-2"></i>
                    <div>
                        <span class="fw-medium">Plan Status:</span>
                        <span class="badge ms-2 ${not empty plan_no and plan_no != 'null' and not fn:contains(plan_no, '-') ? 'bg-success' : 'bg-warning'}">
                            ${not empty plan_no and plan_no != 'null' and not fn:contains(plan_no, '-') ? 'Completed' : 'Pending'}
                        </span>
                    </div>
                </div>
            </div>
           
            <!-- Form Fields -->
            <div class="mb-4">
                <label for="txt_lc_plan_no_pl_smd" class="form-label fw-medium">
                    <i class="fas fa-hashtag me-1"></i>
                    Plan Number
                </label>
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-map"></i>
                    </span>
                    <c:choose>
                        <c:when test="${not empty plan_no and plan_no != 'null' and not fn:contains(plan_no, '-')}">
                            <input type="text" class="form-control bg-light" id="txt_lc_plan_no_pl_smd" 
                                   value="${plan_no}" readonly />
                            <span class="input-group-text text-success">
                                <i class="fas fa-check"></i>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <input type="text" class="form-control" id="txt_lc_plan_no_pl_smd" 
                                   value="${plan_no}" placeholder="Enter plan number" />
                        </c:otherwise>
                    </c:choose>
                </div>
                <small class="form-text text-muted mt-1">Unique identifier for the title plan</small>
            </div>
            
            <div class="mb-4">
                <label for="txt_lc_registry_mapref_pl_smd" class="form-label fw-medium">
                    <i class="fas fa-map-pin me-1"></i>
                    Registry Map Reference
                </label>
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-map-marker-alt"></i>
                    </span>
                    <c:choose>
                        <c:when test="${not empty registry_mapref and registry_mapref != 'null' and not fn:contains(registry_mapref, '-')}">
                            <input type="text" class="form-control bg-light" id="txt_lc_registry_mapref_pl_smd" 
                                   value="${registry_mapref}" readonly />
                            <span class="input-group-text text-success">
                                <i class="fas fa-check"></i>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <input type="text" class="form-control" id="txt_lc_registry_mapref_pl_smd" 
                                   value="${registry_mapref}" placeholder="Enter registry map reference" />
                        </c:otherwise>
                    </c:choose>
                </div>
                <small class="form-text text-muted mt-1">Official map reference from registry</small>
            </div>
            
            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <label for="txt_cc_no_pl_smd" class="form-label fw-medium">
                        <i class="fas fa-file-contract me-1"></i>
                        CC Number
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">CC</span>
                        <c:choose>
                            <c:when test="${not empty cc_no and cc_no != 'null' and not fn:contains(cc_no, '-')}">
                                <input type="text" class="form-control bg-light" id="txt_cc_no_pl_smd" 
                                       value="${cc_no}" readonly />
                            </c:when>
                            <c:otherwise>
                                <input type="text" class="form-control" id="txt_cc_no_pl_smd" 
                                       value="${cc_no}" placeholder="CC number" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <label for="ltr_plan_no_pl_smd" class="form-label fw-medium">
                        <i class="fas fa-file-signature me-1"></i>
                        LTR Number
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">LTR</span>
                        <c:choose>
                            <c:when test="${not empty ltr_plan_no and ltr_plan_no != 'null' and not fn:contains(ltr_plan_no, '-')}">
                                <input type="text" class="form-control bg-light" id="ltr_plan_no_pl_smd" 
                                       value="${ltr_plan_no}" readonly />
                            </c:when>
                            <c:otherwise>
                                <input type="text" class="form-control" id="ltr_plan_no_pl_smd" 
                                       value="${ltr_plan_no}" placeholder="LTR number" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <!-- Update Button -->
            <div class="mt-4">
                <button class="btn btn-primary w-100 py-3" id="btn_save_lrd_title_plan_update_details_smd_new_update">
                    <div class="d-flex align-items-center justify-content-center">
                        <div class="me-3">
                            <i class="fas fa-save fa-lg"></i>
                        </div>
                        <div class="text-start">
                            <div class="fw-medium">
                                <c:choose>
                                    <c:when test="${not empty plan_no and plan_no != 'null' and not fn:contains(plan_no, '-')}">
                                        Update Plan Details
                                    </c:when>
                                    <c:otherwise>
                                        Save Plan Details
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <small class="d-block opacity-75">Save all plan information</small>
                        </div>
                    </div>
                </button>
            </div>
            
            <!-- Help Text -->
            <div class="alert alert-light border mt-4">
                <div class="d-flex">
                    <i class="fas fa-lightbulb text-warning me-2 mt-1"></i>
                    <div>
                        <h6 class="alert-heading mb-2">Instructions</h6>
                        <p class="small mb-0">
                            Update the plan information if the title plan has already been prepared.
                        </p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Modal Footer -->
        <div class="modal-footer bg-light">
            <div class="d-flex justify-content-between w-100 align-items-center">
                <div class="text-muted small">
                    <i class="fas fa-history me-1"></i>
                    Last updated: <span id="planLastUpdated">
                        <c:choose>
                            <c:when test="${not empty plan_no and plan_no != 'null'}">Recently</c:when>
                            <c:otherwise>Never</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>
                        Close
                    </button>
                    <!-- <button type="button" class="btn btn-outline-info" id="btn_view_plan_preview">
                        <i class="fas fa-eye me-1"></i>
                        Preview
                    </button> -->
                </div>
            </div>
        </div>
     </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="check_for_objection" tabindex="-1"
     aria-labelledby="check_for_objection_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="check_for_objection_label">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Check for Objection
                    <span class="badge bg-white text-danger ms-2" id="objectionCount">${fn:length(case_objection)}</span>
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Objection Summary Card -->
                <div class="card border-danger mb-4">
                    <div class="card-header bg-danger bg-opacity-10 py-3 border-danger">
                        <div class="d-flex justify-content-between align-items-center">
                            <h6 class="mb-0 d-flex align-items-center">
                                <i class="fas fa-clipboard-list text-danger me-2"></i>
                                Objection Summary
                            </h6>
                            
                        </div>
                    </div>
                    
                </div>
                
                <!-- Objections Table -->
                <div class="card border">
                    <div class="card-header bg-light py-3">
                        <h6 class="mb-0 d-flex align-items-center">
                            <i class="fas fa-list text-primary me-2"></i>
                            Objection Details
                        </h6>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover table-sm mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th width="15%">Objector</th>
                                        <th width="20%">Address</th>
                                        <th width="10%">Contact</th>
                                        <th width="20%">Reasons</th>
                                        <th width="20%">Remarks</th>
                                        <th width="15%" class="text-center">Status/Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${case_objection}" var="case_objection_row" varStatus="loop">
                                        <tr class="${case_objection_row.status == 'pending' ? 'table-warning' : case_objection_row.status == 'resolved' ? 'table-success' : ''}">
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-sm bg-danger bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-2">
                                                        <i class="fas fa-user text-danger"></i>
                                                    </div>
                                                    <div>
                                                        <div class="fw-medium">${case_objection_row.objector_name}</div>
                                                        <small class="text-muted">ID: ${case_objection_row.id}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="text-truncate" style="max-width: 200px;" 
                                                     data-bs-toggle="tooltip" data-bs-placement="top" 
                                                     title="${case_objection_row.objector_address}">
                                                    ${case_objection_row.objector_address}
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge bg-info bg-opacity-10 text-info">
                                                    ${case_objection_row.objector_contact}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="text-truncate" style="max-width: 200px;" 
                                                     data-bs-toggle="tooltip" data-bs-placement="top" 
                                                     title="${case_objection_row.reasons}">
                                                    ${case_objection_row.reasons}
                                                </div>
                                            </td>
                                            <td>
                                                <div class="text-truncate" style="max-width: 200px;" 
                                                     data-bs-toggle="tooltip" data-bs-placement="top" 
                                                     title="${case_objection_row.remarks}">
                                                    ${case_objection_row.remarks}
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group" role="group">
                                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                                            data-bs-toggle="modal" data-bs-target="#newObjectionModal"
                                                            data-action="edit"
                                                            data-target-id="${case_objection_row.id}"
                                                            data-objector_name="${case_objection_row.objector_name}"
                                                            data-objector_address="${case_objection_row.objector_address}"
                                                            data-objector_contact="${case_objection_row.objector_contact}"
                                                            data-reasons="${case_objection_row.reasons}"
                                                            data-remarks="${case_objection_row.remarks}"
                                                            data-status="${case_objection_row.status}"
                                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Objection">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-outline-primary btn-sm btn-view-objection"
                                                            data-bs-toggle="tooltip" data-bs-placement="top" title="View Details"
                                                            data-objector-name="${case_objection_row.objector_name}"
                                                            data-reasons="${case_objection_row.reasons}">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-outline-success btn-sm btn-resolve-objection"
                                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Mark as Resolved"
                                                            data-objection-id="${case_objection_row.id}">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </div>
                                                <div class="mt-1">
                                                    <span class="badge ${case_objection_row.status == 'pending' ? 'bg-warning' : case_objection_row.status == 'resolved' ? 'bg-success' : 'bg-secondary'}">
                                                        ${case_objection_row.status}
                                                    </span>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Empty State -->
                        <c:if test="${empty case_objection}">
                            <div class="text-center py-5">
                                <div class="mb-3">
                                    <i class="fas fa-check-circle fa-3x text-success"></i>
                                </div>
                                <h5 class="text-muted">No Objections Found</h5>
                                <p class="text-muted small mb-0">This application has no pending objections</p>
                                <!-- <button type="button" class="btn btn-outline-primary btn-sm mt-3" 
                                        data-bs-toggle="modal" data-bs-target="#newObjectionModal">
                                    <i class="fas fa-plus me-1"></i>
                                    Add First Objection
                                </button> -->
                            </div>
                        </c:if>
                    </div>
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        <span id="objectionSummary">
                            <c:choose>
                                <c:when test="${empty case_objection}">
                                    No objections recorded
                                </c:when>
                                <c:when test="${fn:length(case_objection) == 1}">
                                    1 objection recorded
                                </c:when>
                                <c:otherwise>
                                    ${fn:length(case_objection)} objections recorded
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        <button type="button" class="btn btn-outline-danger" id="btn_export_objections">
                            <i class="fas fa-download me-1"></i>
                            Export
                        </button>
                        <!-- <button type="button" class="btn btn-success" id="btn_mark_all_resolved">
                            <i class="fas fa-check-double me-1"></i>
                            Mark All Resolved
                        </button> -->
                    </div>
                </div>
                <input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id">
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="view_parcel_and_transaction" tabindex="-1"
     aria-labelledby="view_parcel_and_transaction_label" aria-hidden="true" data-bs-backdrop="static">
     <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="view_parcel_and_transaction_label">
                    <i class="fas fa-map-marked-alt me-2"></i>
                    View Parcel and Transaction
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Summary Card -->
                <div class="card border-0 bg-light mb-4">
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-sm bg-primary bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
                                        <i class="fas fa-hashtag text-primary"></i>
                                    </div>
                                    <div>
                                        <div class="text-muted small">Case Number</div>
                                        <div class="h6 mb-0">${empty fn:trim(case_number) ? '--' : fn:trim(case_number)}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-sm bg-success bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
                                        <i class="fas fa-file-contract text-success"></i>
                                    </div>
                                    <div>
                                        <div class="text-muted small">Job Number</div>
                                        <div class="h6 mb-0">${empty fn:trim(job_number) ? '--' : fn:trim(job_number)}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-sm bg-info bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3">
                                        <i class="fas fa-user text-info"></i>
                                    </div>
                                    <div>
                                        <div class="text-muted small">Applicant</div>
                                        <div class="h6 mb-0">${empty fn:trim(ar_name) ? '--' : fn:trim(ar_name)}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Tabs Navigation -->
                <ul class="nav nav-tabs mb-3 tab-style-6" id="parcelTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="details-tab" data-bs-toggle="tab" 
                                data-bs-target="#details" type="button" role="tab">
                            <i class="fas fa-info-circle me-2"></i>
                            Transaction Details
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="location-tab" data-bs-toggle="tab" 
                                data-bs-target="#location" type="button" role="tab">
                            <i class="fas fa-map-marker-alt me-2"></i>
                            Location Details
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="financial-tab" data-bs-toggle="tab" 
                                data-bs-target="#financial" type="button" role="tab">
                            <i class="fas fa-money-bill-wave me-2"></i>
                            Financial Details
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="map-tab" data-bs-toggle="tab" 
                                data-bs-target="#map-" type="button" role="tab">
                            <i class="fas fa-map me-2"></i>
                            Map Visualization
                        </button>
                    </li>
                </ul>
                
                <!-- Tab Content -->
                <div class="tab-content" id="parcelTabContent">
                    
                    <!-- Transaction Details Tab -->
                    <div class="tab-pane fade show active" id="details" role="tabpanel">
                        <div class="row g-3">
                            <!-- Column 1 -->
                            <div class="col-md-6">
                                <div class="card border h-100">
                                    <div class="card-header bg-light py-2">
                                        <h6 class="mb-0">
                                            <i class="fas fa-file-alt me-2"></i>
                                            Basic Information
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Transaction Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(transaction_number) ? '--' : fn:trim(transaction_number)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Regional Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(regional_number) ? '--' : fn:trim(regional_number)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Date of Document</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(date_of_document) ? '--' : fn:trim(date_of_document)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Date of Registration</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(date_of_registration) ? '--' : fn:trim(date_of_registration)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Nature of Instrument</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(nature_of_instrument) ? '--' : fn:trim(nature_of_instrument)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Type of Interest</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(type_of_interest) ? '--' : fn:trim(type_of_interest)}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Column 2 -->
                            <div class="col-md-6">
                                <div class="card border h-100">
                                    <div class="card-header bg-light py-2">
                                        <h6 class="mb-0">
                                            <i class="fas fa-calendar-alt me-2"></i>
                                            Term & Renewal
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Term</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(term) ? '--' : fn:trim(term)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Type of Use</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(type_of_use) ? '--' : fn:trim(type_of_use)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Commencement Date</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(commencement_date) ? '--' : fn:trim(commencement_date)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Option for Renewal</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(renewal_term) ? '--' : fn:trim(renewal_term)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Certificate Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(certificate_number) ? '--' : fn:trim(certificate_number)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Date of Issue</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(date_of_issue) ? '--' : fn:trim(date_of_issue)}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Column 3 -->
                            <div class="col-12">
                                <div class="card border">
                                    <div class="card-header bg-light py-2">
                                        <h6 class="mb-0">
                                            <i class="fas fa-certificate me-2"></i>
                                            Registration & Planning Details
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">Plan Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(plan_no) ? '--' : fn:trim(plan_no)}</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">LTR Plan Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(ltr_plan_no) ? '--' : fn:trim(ltr_plan_no)}</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">Registry Map Ref</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(registry_mapref) ? '--' : fn:trim(registry_mapref)}</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">CC Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(cc_no) ? '--' : fn:trim(cc_no)}</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">GLPIN</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(glpin) ? '--' : fn:trim(glpin)}</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">Interest Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(interest_number) ? '--' : fn:trim(interest_number)}</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">Sub-Interest Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(sub_interest_number) ? '--' : fn:trim(sub_interest_number)}</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">Registered Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(registered_number) ? '--' : fn:trim(registered_number)}</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">Type of Plotting</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(smd_type_of_plotting) ? '--' : fn:trim(smd_type_of_plotting)}</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">SMD Reference Number</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(smd_reference_number) ? '--' : fn:trim(smd_reference_number)}</div>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small text-muted mb-1">Publication Date</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(publicity_date) ? '--' : fn:trim(publicity_date)}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Location Details Tab -->
                    <div class="tab-pane fade" id="location" role="tabpanel">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="card border h-100">
                                    <div class="card-header bg-light py-2">
                                        <h6 class="mb-0">
                                            <i class="fas fa-globe-africa me-2"></i>
                                            Location Information
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Region</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(region) ? '--' : fn:trim(region)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">District</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(district) ? '--' : fn:trim(district)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2 mb-3">
                                            <div class="col-12">
                                                <label class="form-label small text-muted mb-1">Locality</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(locality) ? '--' : fn:trim(locality)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Size of Land</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(size_of_land) ? '--' : fn:trim(size_of_land)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">GLPIN</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(glpin) ? '--' : fn:trim(glpin)}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="card border h-100">
                                    <div class="card-header bg-light py-2">
                                        <h6 class="mb-0">
                                            <i class="fas fa-landmark me-2"></i>
                                            Registration Details
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Registration District</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(registration_district_number) ? '--' : fn:trim(registration_district_number)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Registration Section</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(registration_section_number) ? '--' : fn:trim(registration_section_number)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Registration Block</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(registration_block_number) ? '--' : fn:trim(registration_block_number)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Created Date</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(created_date) ? '--' : fn:trim(created_date)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Modified Date</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(modified_date) ? '--' : fn:trim(modified_date)}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Financial Details Tab -->
                    <div class="tab-pane fade" id="financial" role="tabpanel">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="card border h-100">
                                    <div class="card-header bg-light py-2">
                                        <h6 class="mb-0">
                                            <i class="fas fa-calculator me-2"></i>
                                            Assessment Values
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-12">
                                                <label class="form-label small text-muted mb-1">Assessed Value</label>
                                                <div class="h5 fw-bold text-primary">${empty fn:trim(assessed_value) ? '--' : fn:trim(assessed_value)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Stamp Duty Payable</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(stamp_duty_payable) ? '--' : fn:trim(stamp_duty_payable)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Consideration in Document</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee) ? '--' : fn:trim(consideration_fee)}</div>
                                            </div>
                                        </div>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Consideration Currency</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee_currency) ? '--' : fn:trim(consideration_fee_currency)}</div>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted mb-1">Adopted Currency Rate</label>
                                                <div class="fw-medium text-dark">${empty fn:trim(consideration_fee_adopted_rate) ? '--' : fn:trim(consideration_fee_adopted_rate)}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Map Visualization Tab -->
                    <div class="tab-pane fade" id="map-" role="tabpanel">
                      <div class="row g-3"></div>
                        <div class="card border h-100">
                            <div class="card-header bg-light py-2">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0">
                                        <i class="fas fa-map me-2"></i>
                                        Map Visualization
                                    </h6>
                                    <div class="btn-group" role="group">
                                        <button type="button" class="btn btn-primary btn-sm" 
                                                id="lc_btn_visualise_wkt_" data-bs-toggle="tooltip" 
                                                data-bs-placement="top" title="Visualise Polygon">
                                            <i class="fas fa-map me-1"></i>
                                            Visualise
                                        </button>
                                        <button type="button" class="btn btn-outline-primary btn-sm" 
                                                id="lc_btn_visualise_search" data-bs-toggle="tooltip" 
                                                data-bs-placement="top" title="Visualise Search">
                                            <i class="fas fa-search me-1"></i>
                                            Search
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="lc_btnprintmap" data-bs-toggle="tooltip" 
                                                data-bs-placement="top" title="Print Map">
                                            <i class="fas fa-print me-1"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                
                                <!-- WKT Polygon Input -->
                                <div class="mb-3">
                                    <label for="lc_bl_wkt_polygon" class="form-label fw-medium">
                                        <i class="fas fa-draw-polygon me-1"></i>
                                        WKT Polygon
                                    </label>
                                    <div class="input-group">
                                        <input class="form-control" id="lc_bl_wkt_polygon" 
                                               name="lc_bl_wkt_polygon" type="text" value="${parcel_wkt}"
                                               placeholder="WKT polygon coordinates">
                                        <button class="btn btn-outline-secondary" type="button" 
                                                id="btn_copy_wkt" data-bs-toggle="tooltip" 
                                                data-bs-placement="top" title="Copy WKT">
                                            <i class="fas fa-copy"></i>
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Map Controls -->
                                <div class="d-flex flex-wrap gap-2 align-items-center mb-3">
                                    <div class="d-flex align-items-center me-3">
                                        <label class="me-2 mb-0">Scale:</label>
                                        <div class="input-group input-group-sm me-2" style="width: 120px;">
                                            <input class="form-control form-control-sm" id="lc_scale_value_e" 
                                                   name="lc_scale_value_e" type="text" placeholder="Custom scale">
                                        </div>
                                        <select class="form-select form-select-sm" name="lc_scale_value" 
                                                id="lc_scale_value" style="width: 120px;">
                                            <option value="500">1:500</option>
                                            <option value="1107">1:1,107</option>
                                            <option value="1250">1:1,250</option>
                                            <option value="2140">1:2,140</option>
                                            <option value="2215">1:2,215</option>
                                            <option value="2500">1:2,500</option>
                                            <option value="2670">1:2,670</option>
                                            <option value="2825">1:2,825</option>
                                            <option value="5000" selected>1:5,000</option>
                                            <option value="10000">1:10,000</option>
                                            <option value="15000">1:15,000</option>
                                            <option value="20000">1:20,000</option>
                                        </select>
                                    </div>
                                    
                                    <div class="d-flex align-items-center">
                                        <div class="form-check me-2">
                                            <input class="form-check-input" type="checkbox" 
                                                   checked id="lc_lockmapscale">
                                            <label class="form-check-label small mb-0" for="lc_lockmapscale">
                                                Lock Scale
                                            </label>
                                        </div>
                                        <button type="button" class="btn btn-outline-primary btn-sm" 
                                                id="lc_btn_scale_zoom" data-bs-toggle="tooltip" 
                                                data-bs-placement="top" title="Zoom to Scale">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                    
                                    <div class="ms-auto btn-group" role="group">
                                        <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_zoom_full">
                                            <i class="fas fa-expand"></i>
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_zoom_out">
                                            <i class="fas fa-search-minus"></i>
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                id="btn_zoom_in">
                                            <i class="fas fa-search-plus"></i>
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Map Container -->
                                <div class="mt-3 w-100">
                                  <div id="lc-map__"></div>
                                </div>

                                <!-- Confirm Transaction Button -->
                                <div class="mt-4">
                                    <button type="button" id="btn_confirm_registration_transaction" 
                                            class="btn btn-success w-100 py-3 d-none">
                                        <div class="d-flex align-items-center justify-content-center">
                                            <i class="fas fa-check-circle fa-lg me-3"></i>
                                            <div class="text-start">
                                                <div class="fw-medium">Confirm Transaction</div>
                                                <small class="d-block opacity-75">Finalize and approve this registration transaction</small>
                                            </div>
                                        </div>
                                    </button>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Viewing details for transaction: ${transaction_number}
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        
                    </div>
                </div>
            </div>
            
        </div>
     </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="enter_root_of_title" tabindex="-1"
     aria-labelledby="enter_root_of_title_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="enter_root_of_title_label">
                    <i class="fas fa-book me-2"></i>
                    Root of Title Register
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Tabs Navigation -->
                <ul class="nav nav-tabs mb-4" id="rootOfTitleTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="proprietorship-tab" data-bs-toggle="tab" 
                                data-bs-target="#proprietorship" type="button" role="tab">
                            <i class="fas fa-user-tie me-2"></i>
                            Proprietorship
                            <span class="badge bg-primary ms-2">${fn:length(lrd_proprietorship_section)}</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="memorial-tab" data-bs-toggle="tab" 
                                data-bs-target="#memorial" type="button" role="tab">
                            <i class="fas fa-file-signature me-2"></i>
                            Memorials
                            <span class="badge bg-primary ms-2">${fn:length(lrd_memorials_section)}</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="reservation-tab" data-bs-toggle="tab" 
                                data-bs-target="#reservation" type="button" role="tab">
                            <i class="fas fa-flag me-2"></i>
                            Reservations
                            <span class="badge bg-primary ms-2">${fn:length(lrd_reservation_section)}</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="encumbrance-tab" data-bs-toggle="tab" 
                                data-bs-target="#encumbrance" type="button" role="tab">
                            <i class="fas fa-lock me-2"></i>
                            Encumbrances
                            <span class="badge bg-primary ms-2">${fn:length(lrd_encumbrances_section)}</span>
                        </button>
                    </li>
                       <li class="nav-item" role="presentation">
                        <button class="nav-link" id="valuation-tab" data-bs-toggle="tab" 
                                data-bs-target="#valuation" type="button" role="tab">
                            <i class="fas fa-money-bill-wave me-2"></i>
                            Valuation
                            <span class="badge bg-primary ms-2">${fn:length(lrd_valuation_section)}</span>
                        </button>
                    </li>
                    </li>
                       <li class="nav-item" role="presentation">
                        <button class="nav-link" id="certificate-tab" data-bs-toggle="tab" 
                                data-bs-target="#certificate" type="button" role="tab">
                            <i class="fas fa-certificate me-2"></i>
                            Certificate
                            <span class="badge bg-primary ms-2">${fn:length(lrd_certificate_section)}</span>
                        </button>
                    </li>
                </ul>
                
                <!-- Tab Content -->
                <div class="tab-content" id="rootOfTitleTabContent">
                    
                    <!-- Proprietorship Tab -->
                    <div class="tab-pane fade show active" id="proprietorship" role="tabpanel">
                        <div class="card border">
                            <div class="card-header bg-primary bg-opacity-10 border-primary">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0 text-primary">
                                        <i class="fas fa-user-tie me-2"></i>
                                        Proprietorship Details
                                    </h6>
                                    <button type="button" class="btn btn-primary btn-sm newProprietorshipModal">
                                        <i class="fas fa-plus me-1"></i>
                                        Add Proprietor
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lrd_proprietorship_details_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Registered No.</th>
                                                <th>Proprietors</th>
                                                <th>Date of Instrument</th>
                                                <th>Nature of Instrument</th>
                                                <th>Date of Registration</th>
                                                <th>Parties</th>
                                                <th>Price Paid</th>
                                                <th>Term</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${lrd_proprietorship_section}" var="proprietorship_section">
                                                <tr>
                                                    <td>
                                                        <span class="badge bg-info bg-opacity-10 text-info">
                                                            ${proprietorship_section.ps_registration_number}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <i class="fas fa-user text-muted me-2"></i>
                                                            <span>${proprietorship_section.ps_proprietor}</span>
                                                        </div>
                                                    </td>
                                                    <td>${proprietorship_section.ps_date_of_instrument}</td>
                                                    <td>
                                                        <span class="badge bg-secondary">
                                                            ${proprietorship_section.ps_nature_of_instrument}
                                                        </span>
                                                    </td>
                                                    <td>${proprietorship_section.ps_date_of_registration}</td>
                                                    <td>
                                                        <div class="small">
                                                            <div><strong>From:</strong> ${proprietorship_section.ps_transferor}</div>
                                                            <div><strong>To:</strong> ${proprietorship_section.ps_transferee}</div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="fw-medium text-success">${proprietorship_section.ps_price_paid}</span>
                                                    </td>
                                                    <td>${proprietorship_section.ps_term}</td>
                                                    <td class="text-center">
                                                      <div class="d-flex justify-content-center">
                                                        <button class="btn btn-outline-primary btn-sm me-1 editProprietorshipModal ${proprietorship_section.approval_status == 1 ? 'd-none' : ''}"
                                                                data-target-id="${proprietorship_section.ps_id}"
                                                                data-ps_id="${proprietorship_section.ps_id}"
                                                                data-ps_case_number="${proprietorship_section.ps_case_number}"
                                                                data-ps_registration_number="${proprietorship_section.ps_registration_number}"
                                                                data-ps_proprietor="${proprietorship_section.ps_proprietor}"
                                                                data-ps_date_of_instrument="${proprietorship_section.ps_date_of_instrument}"
                                                                data-ps_nature_of_instrument="${proprietorship_section.ps_nature_of_instrument}"
                                                                data-ps_date_of_registration="${proprietorship_section.ps_date_of_registration}"
                                                                data-ps_transferor="${proprietorship_section.ps_transferor}"
                                                                data-ps_transferee="${proprietorship_section.ps_transferee}"
                                                                data-ps_price_paid="${proprietorship_section.ps_price_paid}"
                                                                data-ps_remarks="${proprietorship_section.ps_remarks}"
                                                                data-ps_signature="${proprietorship_section.ps_signature}"
                                                                data-ps_term="${proprietorship_section.ps_term}"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Proprietor">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-danger btn-sm deleteProprietorshipModal ${proprietorship_section.approval_status == 1 ? 'd-none' : ''}"
                                                                data-ps_id="${proprietorship_section.ps_id}"
                                                                data-ps_case_number="${proprietorship_section.ps_case_number}"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Delete Proprietorship">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
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
                    
                    <!-- Memorials Tab -->
                    <div class="tab-pane fade" id="memorial" role="tabpanel">
                        <div class="card border">
                            <div class="card-header bg-danger bg-opacity-10 border-danger">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0 text-danger">
                                        <i class="fas fa-file-signature me-2"></i>
                                        Memorial Details
                                    </h6>
                                    <button type="button" class="btn btn-danger btn-sm newMemorialsModal">
                                        <i class="fas fa-plus me-1"></i>
                                        Add Memorial
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lrd_memorial_details_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Registered No</th>
                                                <th>Memorials</th>
                                                <th>Date of Instrument</th>
                                                <th>Date of Registration</th>
                                                <th>Entry No</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${lrd_memorials_section}" var="memorials_section">
                                                <tr>
                                                    <td>
                                                        <span class="badge bg-danger bg-opacity-10 text-danger">
                                                            ${memorials_section.m_registered_no}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="text-truncate" style="max-width: 200px;">
                                                            ${memorials_section.m_memorials}
                                                        </div>
                                                    </td>
                                                    <td>${memorials_section.m_date_of_instrument}</td>
                                                    <td>${memorials_section.m_date_of_registration}</td>
                                                    <td>
                                                        <span class="badge bg-secondary">${memorials_section.m_entry_number}</span>
                                                    </td>
                                                    <td class="text-center">
                                                      <div class="d-flex justify-content-center">
                                                        <button class="btn btn-outline-danger btn-sm me-1 editMemorialsModal ${memorials_section.approval_status == 1 ? 'd-none' : ''}"
                                                                data-target-id="${memorials_section.mid}"
                                                                data-mid="${memorials_section.mid}"
                                                                data-m_case_number="${memorials_section.m_case_number}"
                                                                data-m_registered_no="${memorials_section.m_registered_no}"
                                                                data-m_memorials="${memorials_section.m_memorials}"
                                                                data-m_date_of_registration="${memorials_section.m_date_of_registration}"
                                                                data-m_date_of_instrument="${memorials_section.m_date_of_instrument}"
                                                                data-m_back="${memorials_section.m_back}"
                                                                data-m_remarks="${memorials_section.m_remarks}"
                                                                data-m_entry_number="${memorials_section.m_entry_number}"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Memorial">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-danger btn-sm deleteMemorialsModal ${memorials_section.approval_status == 1 ? 'd-none' : ''}"
                                                                data-target-id="${memorials_section.mid}"
                                                                data-mid="${memorials_section.mid}"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Delete Memorial">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
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
                    
                    <!-- Reservations Tab -->
                    <div class="tab-pane fade" id="reservation" role="tabpanel">
                        <div class="card border">
                            <div class="card-header bg-success bg-opacity-10 border-success">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0 text-success">
                                        <i class="fas fa-flag me-2"></i>
                                        Reservation Details
                                    </h6>
                                    <button type="button" class="btn btn-success btn-sm newReservationModal">
                                        <i class="fas fa-plus me-1"></i>
                                        Add Reservation
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lrd_reservation_details_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Reservation Description</th>
                                                <th>Created By</th>
                                                <th>Created On</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${lrd_reservation_section}" var="reservation_section">
                                                <tr>
                                                    <td>
                                                        <div class="text-truncate" style="max-width: 250px;">
                                                            ${reservation_section.reservation_description}
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <i class="fas fa-user-circle text-muted me-2"></i>
                                                            <span>${reservation_section.modified_by}</span>
                                                        </div>
                                                    </td>
                                                    <td>${reservation_section.created_date}</td>
                                                    <td class="text-center">
                                                      <div class="d-flex justify-content-center">
                                                        <button class="btn btn-outline-success btn-sm me-1 editReservationModal ${reservation_section.approval_status == 1 ? 'd-none' : ''}"
                                                                data-rs_id="${reservation_section.rs_id}"
                                                                data-rs_reservation_description="${reservation_section.reservation_description}"
                                                                data-rs_case_number="${reservation_section.case_number}"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Reservation">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-danger btn-sm deleteReservationModal ${reservation_section.approval_status == 1 ? 'd-none' : ''}"
                                                                data-rs_id="${reservation_section.rs_id}"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Delete Reservation">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
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
                    
                    <!-- Encumbrances Tab -->
                    <div class="tab-pane fade" id="encumbrance" role="tabpanel">
                        <div class="card border">
                            <div class="card-header bg-warning bg-opacity-10 border-warning">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0 text-warning">
                                        <i class="fas fa-lock me-2"></i>
                                        Encumbrance Details
                                    </h6>
                                    <button type="button" class="btn btn-warning btn-sm newEncumberancesModal">
                                        <i class="fas fa-plus me-1"></i>
                                        Add Encumbrance
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lrd_registration_encumbrance_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Registered Number</th>
                                                <th>Date of Instrument</th>
                                                <th>Date of Registration</th>
                                                <th>Memorials</th>
                                                <th>Entry No.</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${lrd_encumbrances_section}" var="lrd_encumbrances_section_row">
                                                <tr>
                                                    <td>
                                                        <span class="badge bg-warning bg-opacity-10 text-warning">
                                                            ${lrd_encumbrances_section_row.es_registered_number}
                                                        </span>
                                                    </td>
                                                    <td>${lrd_encumbrances_section_row.es_date_of_instrument}</td>
                                                    <td>${lrd_encumbrances_section_row.es_date_of_registration}</td>
                                                    <td>
                                                        <div class="text-truncate" style="max-width: 200px;">
                                                            ${lrd_encumbrances_section_row.es_memorials}
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-secondary">${lrd_encumbrances_section_row.es_entry_number}</span>
                                                    </td>
                                                    <td class="text-center">
                                                      <div class="d-flex justify-content-center">
                                                        <button class="btn btn-outline-warning btn-sm me-1 editEncumberancesModal ${lrd_encumbrances_section_row.approval_status == 1 ? 'd-none' : ''}"
                                                                data-es_id="${lrd_encumbrances_section_row.es_id}"
                                                                data-es_case_number="${lrd_encumbrances_section_row.es_case_number}"
                                                                data-es_registered_number="${lrd_encumbrances_section_row.es_registered_number}"
                                                                data-es_date_of_registration="${lrd_encumbrances_section_row.es_date_of_registration}"
                                                                data-es_date_of_instrument="${lrd_encumbrances_section_row.es_date_of_instrument}"
                                                                data-es_back="${lrd_encumbrances_section_row.es_back}"
                                                                data-es_forward="${lrd_encumbrances_section_row.es_forward}"
                                                                data-es_remarks="${lrd_encumbrances_section_row.es_remarks}"
                                                                data-es_memorials="${lrd_encumbrances_section_row.es_memorials}"
                                                                data-es_signature="${lrd_encumbrances_section_row.es_signature}"
                                                                data-es_entry_number="${lrd_encumbrances_section_row.es_entry_number}"
                                                                data-es_action_on_form_encumbrances="edit"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Encumbrance">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-danger btn-sm deleteEncumberancesModal ${lrd_encumbrances_section_row.approval_status == 1 ? 'd-none' : ''}"
                                                                data-es_id="${lrd_encumbrances_section_row.es_id}"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Delete Encumbrance">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
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

                     <!-- Valuation Tab -->
                    <div class="tab-pane fade" id="valuation" role="tabpanel">
                        <div class="card border">
                            <div class="card-header bg-danger bg-opacity-10 border-danger">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0 text-danger">
                                        <i class="fas fa-money-bill-wave me-2"></i>
                                        Valuation Details
                                    </h6>
                                    <button type="button" class="btn btn-danger btn-sm newValuationModal">
                                        <i class="fas fa-plus me-1"></i>
                                        Add Valuation
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lrd_valuation_details_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Date of Valuation</th>
                                                <th class="text-end">Amount (GHS)</th>
                                                <th>Remarks</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                           <c:forEach items="${lrd_valuation_section}" var="valuation_section">
                                                <tr>
                                                    <td>${valuation_section.vs_date_of_valuation}</td>
                                                    <td><div class="text-end text-success">${valuation_section.vs_amount}</div></td>
                                                    <td>
                                                        <div class="text-truncate" style="max-width: 250px;" title="${valuation_section.vs_remarks || ''}">
                                                            ${valuation_section.vs_remarks}
                                                        </div>
                                                    </td>
                                                    <td>
                                                      <div class="d-flex justify-content-center">
                                                        <button class="btn btn-outline-danger btn-sm me-1 editValuationModal ${valuation_section.approval_status == 1 ? 'd-none' : ''}"
                                                                data-vs_id="${valuation_section.vs_id}"
                                                                data-case_number="${valuation_section.case_number}"
                                                                data-vs_date_of_valuation="${valuation_section.vs_date_of_valuation}"
                                                                data-vs_amount="${valuation_section.vs_amount}"
                                                                data-vs_remarks="${valuation_section.vs_remarks}"
                                                                data-es_action_on_form_encumbrances="edit"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Valuation">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-danger btn-sm deleteValuationModal ${valuation_section.approval_status == 1 ? 'd-none' : ''}"
                                                                data-vs_id="${valuation_section.vs_id}"
                                                                data-case_number="${valuation_section.case_number}"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Delete Valuation">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
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

                     <!-- Certificate Tab -->
                    <div class="tab-pane fade" id="certificate" role="tabpanel">
                        <div class="card border">
                            <div class="card-header bg-info bg-opacity-10 border-info">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0 text-info">
                                        <i class="fas fa-certificate me-2"></i>
                                        Certificate Details
                                    </h6>
                                    <button type="button" class="btn btn-info btn-sm newCertificateModal">
                                        <i class="fas fa-plus me-1"></i>
                                        Add Certificate
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm mb-0" id="lrd_certificate_details_dataTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Date of Issue</th>
                                                <th>To Whom Issued</th>
                                                <th>Serial Number</th>
                                                <th>Official Notes</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${lrd_certificate_section}" var="certificate_section">
                                                <tr>
                                                    <td>${certificate_section.cs_date_of_registration}</td>
                                                    <td>${certificate_section.cs_to_whom_issued}</td>
                                                    <td>${certificate_section.cs_serial_number}</td>
                                                    <td>
                                                        <div class="text-truncate" style="max-width: 200px;">
                                                            ${certificate_section.cs_official_notes}
                                                        </div>
                                                    </td>
                                                    <td class="text-center">
                                                      <div class="d-flex justify-content-center">
                                                        <button class="btn btn-outline-info btn-sm me-1 editCertificateModal ${certificate_section.approval_status == 1 ? 'd-none' : ''}"
                                                                data-cs_id="${certificate_section.cs_id}"
                                                                data-cs_case_number="${certificate_section.case_number}"
                                                                data-cs_date_of_registration="${certificate_section.cs_date_of_registration}"
                                                                data-cs_to_whom_issued="${certificate_section.cs_to_whom_issued}"
                                                                data-cs_serial_number="${certificate_section.cs_serial_number}"
                                                                data-cs_official_notes="${certificate_section.cs_official_notes}"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Certificate">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-danger btn-sm deleteCertificateModal ${certificate_section.approval_status == 1 ? 'd-none' : ''}"
                                                                data-cs_id="${certificate_section.cs_id}"
                                                                data-cs_case_number="${certificate_section.case_number}"
                                                                data-cs_date_of_registration="${certificate_section.cs_date_of_registration}"
                                                                data-cs_to_whom_issued="${certificate_section.cs_to_whom_issued}"
                                                                data-cs_serial_number="${certificate_section.cs_serial_number}"
                                                                data-cs_official_notes="${certificate_section.cs_official_notes}"
                                                                data-bs-toggle="tooltip" data-bs-placement="top" title="Delete Certificate">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
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
                
                <!-- Register Description Section -->
                <div class="card border mt-4">
                    <div class="card-header  bg-success bg-opacity-10 text-success d-flex justify-content-between">
                        <h6 class="mb-0">
                            <i class="fas fa-file-alt me-2"></i>
                            Register: Description of Land
                        </h6>
                        <button class="btn btn-sm btn-danger" id="btn_compose_register_description">
                          <i class="fas fa-edit me-1"></i>Compose Template
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="lc_description_of_land_lrd" class="form-label fw-medium">Land Description</label>
                            <textarea id="lc_description_of_land_lrd" name="lc_description_of_land_lrd" 
                                      class="form-control" rows="5" required>${smd_region}</textarea>
                            <div class="form-text">Complete description of the land as it appears in the register</div>
                        </div>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <button type="button" name="lc_btn_save_register_description" 
                                        id="lc_btn_save_register_description" class="btn btn-primary w-100">
                                    <i class="fas fa-save me-2"></i>
                                    Save Register Description
                                </button>
                            </div>
                            <div class="col-md-6">
                                <button type="button" name="lc_btn_save_register_description" 
                                        id="lc_btn_activate_final_register_" class="btn btn-success w-100">
                                    <i class="fas fa-file-export me-2"></i>
                                    Generate Final Register
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header bg-success bg-opacity-10 text-success d-flex justify-content-between">
                        <h6 class="mb-0">
                            <i class="fas fa-file-alt me-2"></i>
                            Certificate Summary
                        </h6>
                        <!-- <button class="btn btn-sm btn-danger" id="btn_compose_certificate_template">
                          <i class="fas fa-edit me-1"></i>Compose Template
                        </button> -->
                    </div>
                    <div class="card-body">
                        <!-- Certificate Summary Textarea -->
                        <div class="mb-4">
                            <label for="lc_search_report_summary_details" class="form-label fw-medium">
                                <i class="fas fa-edit me-1"></i>
                                Certificate Content
                            </label>
                            <div class="position-relative">
                                <div id="lc_search_report_summary_details_rt">
                                  ${remark_or_comment}
                                </div>
                                <div class="position-absolute top-0 end-0 p-3 text-muted">
                                    <i class="fas fa-file-signature"></i>
                                </div>
                            </div>
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                Enter the complete certificate summary and details. This content will be used to generate the final certificate.
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="row g-3 mt-4">
                            <div class="col-md-6">
                                <button type="button" name="lc_btn_save_search_report_rt" 
                                        id="lc_btn_save_search_report_rt" 
                                        class="btn btn-primary w-100">
                                   
                                        <i class="fas fa-save me-2"></i>
                                        Save Certificate
                                    
                                </button>
                            </div>
                            
                            <div class="col-md-6">
                                <button type="button" name="lc_btn_activate_final_certificate_rt" 
                                        id="lc_btn_activate_final_certificate_rt" 
                                        class="btn btn-success w-100">
                                    
                                        <i class="fas fa-file-pdf me-2"></i>
                                        Generate Certificate
                                    
                                </button>
                            </div>
                        </div>
                        
                    </div>
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Root of Title Management
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                    </div>
                </div>
                <input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id">
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="newProprietorshipModal" tabindex="-1" aria-labelledby="newProprietorshipModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="newProprietorshipModalLabel">
                    <i class="fas fa-user-tie me-2"></i>
                    Proprietorship Section
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <form id="form_add_proprietory">
                    
                    <!-- Hidden Fields -->
                    <input type="hidden" id="ps_id" name="ps_id" value="0">
                    
                    <!-- Form Content -->
                    <div class="row g-4" style="height: 100vh;">
                        
                        <!-- Left Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">

                          <div class="row g-4">
                            <div class="col-lg-6">
                              <!-- Case Number -->
                              <div class="mb-3">
                                  <label for="ps_case_number" class="form-label fw-medium">
                                      <i class="fas fa-hashtag me-1"></i>
                                      Case Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-folder"></i>
                                      </span>
                                      <input type="text" name="ps_case_number" id="ps_case_number" 
                                            value="${case_number}" class="form-control" required readonly>
                                  </div>
                              </div>
                              
                              <!-- Registered Number -->
                              <div class="mb-3">
                                  <label for="ps_registration_number" class="form-label fw-medium">
                                      <i class="fas fa-certificate me-1"></i>
                                      Registered Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-hashtag"></i>
                                      </span>
                                      <input type="text" name="ps_registration_number" id="ps_registration_number" 
                                            value="${registered_number}" class="form-control" required>
                                  </div>
                              </div>
                              
                              <!-- Proprietor/Grantee -->
                              <div class="mb-3">
                                  <label for="ps_proprietor" class="form-label fw-medium">
                                      <i class="fas fa-user me-1"></i>
                                      Proprietor/Grantee
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-user-check"></i>
                                      </span>
                                      <input type="text" name="ps_proprietor" id="ps_proprietor" 
                                            value="${ar_name}" class="form-control" required>
                                  </div>
                              </div>
                              
                              <!-- Date of Instrument -->
                              <div class="mb-3">
                                  <label for="ps_date_of_instrument" class="form-label fw-medium">
                                      <i class="fas fa-calendar-alt me-1"></i>
                                      Date of Instrument
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-calendar"></i>
                                      </span>
                                      <input type="date" name="ps_date_of_instrument" id="ps_date_of_instrument" 
                                            class="form-control" required>
                                  </div>
                              </div>
                              
                              <!-- Nature of Instrument -->
                              <div class="mb-3">
                                  <label for="ps_nature_of_instrument" class="form-label fw-medium">
                                      <i class="fas fa-file-contract me-1"></i>
                                      Nature of Instrument
                                  </label>
                                  <textarea id="ps_nature_of_instrument" name="ps_nature_of_instrument" 
                                            class="form-control" rows="3" required
                                            placeholder="Describe the nature of the instrument"></textarea>
                                  <div class="form-text">
                                      <i class="fas fa-lightbulb me-1"></i>
                                      Examples: Lease, Conveyance, Mortgage, Gift, etc.
                                  </div>
                              </div>

                            </div>

                            <div class="col-lg-6">
                              <!-- Date of Registration -->
                              <div class="mb-3">
                                  <label for="ps_date_of_registration" class="form-label fw-medium">
                                      <i class="fas fa-calendar-check me-1"></i>
                                      Date of Registration
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-calendar-day"></i>
                                      </span>
                                      <input type="date" name="ps_date_of_registration" id="ps_date_of_registration" 
                                            class="form-control" required>
                                  </div>
                              </div>
                              
                              <!-- Term -->
                              <div class="mb-3">
                                  <label for="ps_term" class="form-label fw-medium">
                                      <i class="fas fa-clock me-1"></i>
                                      Term
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-history"></i>
                                      </span>
                                      <input type="text" name="ps_term" id="ps_term" 
                                            class="form-control" required 
                                            placeholder="e.g., 50 years, Perpetual">
                                  </div>
                              </div>
                              
                              <!-- Grantor -->
                              <div class="mb-3">
                                  <label for="ps_transferor" class="form-label fw-medium">
                                      <i class="fas fa-user-minus me-1"></i>
                                      Grantor (Transferor)
                                  </label>
                                  <textarea name="ps_transferor" id="ps_transferor" 
                                            class="form-control" rows="3" required
                                            placeholder="Enter grantor details"></textarea>
                              </div>
                              
                              <!-- Grantee -->
                              <div class="mb-3">
                                  <label for="ps_transferee" class="form-label fw-medium">
                                      <i class="fas fa-user-plus me-1"></i>
                                      Grantee (Transferee)
                                  </label>
                                  <textarea name="ps_transferee" id="ps_transferee" 
                                            class="form-control" rows="3" required
                                            placeholder="Enter grantee details">${ar_name}</textarea>
                              </div>
                              
                              <!-- Price Paid -->
                              <div class="mb-3">
                                  <label for="ps_price_paid" class="form-label fw-medium">
                                      <i class="fas fa-money-bill-wave me-1"></i>
                                      Price Paid
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-dollar-sign"></i>
                                      </span>
                                      <input type="text" name="ps_price_paid" id="ps_price_paid" 
                                            class="form-control" required 
                                            placeholder="Enter amount">
                                  </div>
                              </div>
                              
                            </div>
                            <div class="col-12">
                                
                                <!-- Remarks -->
                                <div class="mb-3">
                                    <label for="ps_remarks" class="form-label fw-medium">
                                        <i class="fas fa-sticky-note me-1"></i>
                                        Remarks
                                    </label>
                                    <textarea name="ps_remarks" id="ps_remarks" 
                                              class="form-control" rows="3" required
                                              placeholder="Additional remarks or notes"></textarea>
                                </div>
                                
                                <!-- Signed By -->
                                <div class="mb-3">
                                    <label for="ps_signature" class="form-label fw-medium">
                                        <i class="fas fa-signature me-1"></i>
                                        Signed By
                                    </label>
                                    <textarea name="ps_signature" id="ps_signature" 
                                              class="form-control" rows="2" required
                                              placeholder="Names and signatures of authorized persons"></textarea>
                                </div>
                                
                            </div>
                          </div>

                    
                          <!-- Modal Footer -->
                          <div class="border-top bg-light p-3 rounded" style="margin-top: auto !important;">
                              <div class="d-flex justify-content-between w-100 align-items-center">
                                  <div>
                                  </div>
                                  <div class="d-flex gap-2">
                                      <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                          <i class="fas fa-times me-1"></i>
                                          Cancel
                                      </button>
                                      <button type="submit" id="btn_proprietorship" class="btn btn-primary">
                                          <i class="fas fa-save me-1"></i>
                                          Save Changes
                                      </button>
                                  </div>
                              </div>
                          </div>
                        </div>
                        
                        <!-- Right Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">
                            
                            <div class="_gated_workflow_documents"></div>
                        </div>
                        
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="newMemorialsModal" tabindex="-1" aria-labelledby="newMemorialsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="newMemorialsModalLabel">
                    <i class="fas fa-file-signature me-2"></i>
                    Memorials Section
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <form id="form_add_memorials">
                    
                    <!-- Hidden Fields -->
                    <input type="hidden" id="mid" name="mid" value="0">
                    
                    <!-- Form Content -->
                    <div class="row g-4" style="height: 100vh;">
                        
                        <!-- Left Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">

                           <div class="row g-4">
                            <div class="col-lg-6">
                              <!-- Case Number -->
                              <div class="mb-3">
                                  <label for="m_case_number" class="form-label fw-medium">
                                      <i class="fas fa-hashtag me-1"></i>
                                      Case Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-folder"></i>
                                      </span>
                                      <input type="text" name="m_case_number" id="m_case_number" 
                                            value="${case_number}" class="form-control" readonly>
                                  </div>
                              </div>
                              
                              <!-- Registered Number -->
                              <div class="mb-3">
                                  <label for="m_registered_no" class="form-label fw-medium">
                                      <i class="fas fa-certificate me-1"></i>
                                      Registered Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-hashtag"></i>
                                      </span>
                                      <input type="text" name="m_registered_no" id="m_registered_no" 
                                            value="${registered_number}" class="form-control" required
                                            placeholder="Enter registered number">
                                  </div>
                              </div>
                              
                              <!-- Entry Number -->
                              <div class="mb-3">
                                  <label for="m_entry_number" class="form-label fw-medium">
                                      <i class="fas fa-list-ol me-1"></i>
                                      Entry Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-sort-numeric-up"></i>
                                      </span>
                                      <input type="text" name="m_entry_number" id="m_entry_number" 
                                            class="form-control" required
                                            placeholder="Enter entry number">
                                  </div>
                              </div>
                              
                              <!-- Date of Instrument -->
                              <div class="mb-3">
                                  <label for="m_date_of_instrument" class="form-label fw-medium">
                                      <i class="fas fa-calendar-alt me-1"></i>
                                      Date of Instrument
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-calendar"></i>
                                      </span>
                                      <input type="date" name="m_date_of_instrument" id="m_date_of_instrument" 
                                            class="form-control" required>
                                  </div>
                                  <div class="form-text">Date when the instrument was executed</div>
                              </div>
                            </div>

                            <div class="col-lg-6">
                              <!-- Date of Registration -->
                              <div class="mb-3">
                                  <label for="m_date_of_registration" class="form-label fw-medium">
                                      <i class="fas fa-calendar-check me-1"></i>
                                      Date of Registration
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-calendar-day"></i>
                                      </span>
                                      <input type="date" name="m_date_of_registration" id="m_date_of_registration" 
                                            class="form-control" required>
                                  </div>
                                  <div class="form-text">Date when the memorial was registered</div>
                              </div>
                              
                              <!-- Memorials -->
                              <div class="mb-3">
                                  <label for="m_memorials" class="form-label fw-medium">
                                      <i class="fas fa-file-alt me-1"></i>
                                      Memorials Text
                                  </label>
                                  <textarea name="m_memorials" id="m_memorials" 
                                            class="form-control" rows="6" required
                                            placeholder="Enter memorials text">
  Subject to the reservations, exceptions, restrictions, restrictive covenants and conditions contained or referred to in a lease (a true copy of which is annexed hereto) made between (Grantor_Here) of the one part and ${ar_name} of the other part.</textarea>
                                  <div class="form-text">
                                      <i class="fas fa-info-circle me-1"></i>
                                      Official memorial text describing the conditions and restrictions
                                  </div>
                              </div>
                            </div>
                        
                            <!-- Full Width Fields -->
                            <div class="col-12">
                                
                                <!-- Remarks -->
                                <div class="mb-3">
                                    <label for="m_remarks" class="form-label fw-medium">
                                        <i class="fas fa-sticky-note me-1"></i>
                                        Remarks
                                    </label>
                                    <textarea name="m_remarks" id="m_remarks" 
                                              class="form-control" rows="3"
                                              placeholder="Additional remarks or notes about this memorial"></textarea>
                                    <div class="form-text">Optional notes for internal reference</div>
                                </div>
                                
                            </div>
                          </div>
                    
                          <!-- Modal Footer -->
                          <div class="border-top bg-light p-3 rounded" style="margin-top: auto !important;">
                              <div class="d-flex justify-content-between w-100 align-items-center">
                                  <div>
                                  </div>
                                  <div class="d-flex gap-2">
                                      <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                          <i class="fas fa-times me-1"></i>
                                          Cancel
                                      </button>
                                      <button type="submit" id="btn_memorials" class="btn btn-danger">
                                          <i class="fas fa-save me-1"></i>
                                          Save Memorial
                                      </button>
                                  </div>
                              </div>
                          </div>
                            
                        </div>
                        
                        <!-- Right Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">
                            <div class="_gated_workflow_documents"></div>
                        </div>
                        
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="newReservationModal" tabindex="-1" aria-labelledby="newReservationModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title text-white" id="newReservationModalLabel">
                    <i class="fas fa-calendar-check me-2"></i>
                    Reservation Section
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <form id="form_add_reservation">
                    
                    <!-- Hidden Fields -->
                    <input type="hidden" id="rs_id" name="rs_id" value="0">
                    
                    <!-- Form Content -->
                    <div class="row g-3">
                        
                        <!-- Case Number -->
                        <div class="col-12">
                            <div class="mb-3">
                                <label for="rs_case_number" class="form-label fw-medium">
                                    <i class="fas fa-hashtag me-1"></i>
                                    Case Number
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-folder"></i>
                                    </span>
                                    <input type="text" name="rs_case_number" id="rs_case_number" 
                                          value="${case_number}" class="form-control" readonly>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Reservation Description -->
                        <div class="col-12">
                            <div class="mb-3">
                                <label for="rs_reservation_description" class="form-label fw-medium">
                                    <i class="fas fa-file-alt me-1"></i>
                                    Reservation Description
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-align-left"></i>
                                    </span>
                                    <textarea class="form-control" id="rs_reservation_description" 
                                              rows="10" required
                                              placeholder="Enter reservation description..."></textarea>
                                </div>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Provide detailed description of the reservation
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    
                </form>
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div>
                        <!-- Optional delete button (hidden by default) -->
                        <!-- <button type="button" class="btn btn-outline-danger btn_reg_root_delete_action" 
                                data-action_type='reservation' style="display: none;">
                            <i class="fas fa-trash me-1"></i>
                            Delete
                        </button> -->
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>
                            Close
                        </button>
                        <button type="submit" id="btn_reservation_section" class="btn btn-primary" form="form_add_reservation">
                            <i class="fas fa-save me-1"></i>
                            Save Changes
                        </button>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<div class="modal fade" id="newEncumberancesModal" tabindex="-1" aria-labelledby="newEncumberancesModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-warning text-white">
                <h5 class="modal-title" id="newEncumberancesModalLabel">
                    <i class="fas fa-lock me-2"></i>
                    Encumbrances Section
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                <form id="form_add_encumbrances">
                    
                    <!-- Hidden Fields -->
                    <input type="hidden" id="es_id" name="es_id" value="0">
                    <input type="hidden" id="action_on_form_encumbrances" name="action_on_form_encumbrances">
                    
                    <!-- Form Content -->
                    <div class="row g-4" style="height: 100vh;">
                        
                        <!-- Left Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">

                          <div class="row g-4">
                            <div class="col-lg-6">
                              <!-- Case Number -->
                               <div class="mb-3">
                                  <label for="es_case_number" class="form-label fw-medium">
                                      <i class="fas fa-hashtag me-1"></i>
                                      Case Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-folder"></i>
                                      </span>
                                      <input type="text" name="es_case_number" id="es_case_number" 
                                            class="form-control" required readonly value="${case_number}">
                                  </div>
                              </div>
                              
                              <!-- Registered Number -->
                              <div class="mb-3">
                                  <label for="es_registered_number" class="form-label fw-medium">
                                      <i class="fas fa-certificate me-1"></i>
                                      Registered Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-hashtag"></i>
                                      </span>
                                      <input type="text" name="es_registered_number" id="es_registered_number" 
                                            class="form-control" required
                                            placeholder="Enter registered number">
                                  </div>
                              </div>
                              
                              <!-- Entry Number -->
                              <div class="mb-3">
                                  <label for="es_entry_number" class="form-label fw-medium">
                                      <i class="fas fa-list-ol me-1"></i>
                                      Entry Number
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-sort-numeric-up"></i>
                                      </span>
                                      <input type="text" name="es_entry_number" id="es_entry_number" 
                                            class="form-control" required
                                            placeholder="Enter entry number">
                                  </div>
                              </div>
                              
                              <!-- Date of Registration -->
                              <div class="mb-3">
                                  <label for="es_date_of_registration" class="form-label fw-medium">
                                      <i class="fas fa-calendar-check me-1"></i>
                                      Date of Registration
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-calendar-day"></i>
                                      </span>
                                      <input type="date" name="es_date_of_registration" id="es_date_of_registration" 
                                            class="form-control" required>
                                  </div>
                                  <div class="form-text">Date when the encumbrance was registered</div>
                              </div>

                            </div>

                            <div class="col-lg-6">
                              <!-- Date of Instrument -->
                                <div class="mb-3">
                                  <label for="es_date_of_instrument" class="form-label fw-medium">
                                      <i class="fas fa-calendar-alt me-1"></i>
                                      Date of Instrument
                                  </label>
                                  <div class="input-group">
                                      <span class="input-group-text">
                                          <i class="fas fa-calendar"></i>
                                      </span>
                                      <input type="date" name="es_date_of_instrument" id="es_date_of_instrument" 
                                            class="form-control" required>
                                  </div>
                                  <div class="form-text">Date when the instrument was executed</div>
                              </div>
                              
                              <!-- Memorials -->
                              <div class="mb-3">
                                  <label for="es_memorials" class="form-label fw-medium">
                                      <i class="fas fa-file-alt me-1"></i>
                                      Memorials
                                  </label>
                                  <textarea name="es_memorials" id="es_memorials" 
                                            class="form-control" rows="4" required
                                            placeholder="Describe the memorials or encumbrances"></textarea>
                                  <div class="form-text">
                                      <i class="fas fa-info-circle me-1"></i>
                                      Description of memorials or encumbrances on the property
                                  </div>
                              </div>
                              
                            </div>
                            <!-- Full Width Fields - Back & Forward -->
                            <div class="col-12">
                                <div class="row g-4">
                                    <div class="col-lg-6">
                                        <!-- Back -->
                                        <div class="mb-3">
                                            <label for="es_back" class="form-label fw-medium">
                                                <i class="fas fa-arrow-left me-1"></i>
                                                Back (Source References)
                                            </label>
                                            <textarea name="es_back" id="es_back" 
                                                      class="form-control" rows="3" required
                                                      placeholder="References to previous entries or sources"></textarea>
                                            <div class="form-text">References to previous registry entries</div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <!-- Forward -->
                                        <div class="mb-3">
                                            <label for="es_forward" class="form-label fw-medium">
                                                <i class="fas fa-arrow-right me-1"></i>
                                                Forward (Forward References)
                                            </label>
                                            <textarea name="es_forward" id="es_forward" 
                                                      class="form-control" rows="3" required
                                                      placeholder="References to subsequent entries"></textarea>
                                            <div class="form-text">References to subsequent registry entries</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Full Width Fields - Remarks & Signature -->
                            <div class="col-12">
                                <div class="row g-4">
                                    <div class="col-lg-6">
                                        <!-- Remarks -->
                                        <div class="mb-3">
                                            <label for="es_remarks" class="form-label fw-medium">
                                                <i class="fas fa-sticky-note me-1"></i>
                                                Remarks
                                            </label>
                                            <textarea name="es_remarks" id="es_remarks" 
                                                      class="form-control" rows="3" required
                                                      placeholder="Additional remarks or notes"></textarea>
                                            <div class="form-text">Internal notes or observations</div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <!-- Signature -->
                                        <div class="mb-3">
                                            <label for="es_signature" class="form-label fw-medium">
                                                <i class="fas fa-signature me-1"></i>
                                                Signature
                                            </label>
                                            <textarea name="es_signature" id="es_signature" 
                                                      class="form-control" rows="3" required
                                                      placeholder="Authorized signatures"></textarea>
                                            <div class="form-text">Names and signatures of authorized persons</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                          </div>

                          <!-- Buttons moved to left column -->
                          <div class="border-top bg-light p-3 rounded" style="margin-top: auto !important;">
                              <div class="d-flex justify-content-between align-items-center">
                                  <div>
                                      <button type="button" class="btn btn-outline-danger btn_reg_root_delete_action" 
                                              data-action_type='encumbrances' style="display: none;">
                                          <i class="fas fa-trash me-1"></i>
                                          Delete
                                      </button>
                                  </div>
                                  <div class="d-flex gap-2">
                                      <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                          <i class="fas fa-times me-1"></i>
                                          Cancel
                                      </button>
                                      <button type="submit" id="btn_encumberances_section" class="btn btn-warning">
                                          <i class="fas fa-save me-1"></i>
                                          Save Encumbrance
                                      </button>
                                  </div>
                              </div>
                          </div>
                        </div>
                        
                        <!-- Right Column -->
                        <div class="col-lg-6 d-flex flex-column scrollable-col">
                            <div class="_gated_workflow_documents"></div>
                        </div>
                        
                    </div>
                    
                </form>
            </div>

        </div>
    </div>
</div>


<div class="modal fade effect-scale modal-blur" id="compose_certificate" tabindex="-1" aria-labelledby="composeCertificateLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="composeCertificateLabel">
                    <i class="fas fa-file-alt me-2"></i>
                    Compose Certificate
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Certificate Type Card (Hidden by default) -->
                <div class="card mb-3" id="cert_type_for_reg">
                    <div class="card-header bg-primary bg-opacity-10 text-primary">
                        <h6 class="mb-0">
                            <i class="fas fa-cogs me-2"></i>
                            Certificate Configuration
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <!-- Certificate Type -->
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label for="lc_txt_type_of_certificate_" class="form-label fw-medium">
                                        <i class="fas fa-certificate me-1"></i>
                                        Certificate Type
                                    </label>
                                    <select name="lc_txt_type_of_certificate_" id="lc_txt_type_of_certificate_" 
                                            class="form-select" data-trigger required>
                                        <option value="${certificate_type == 'Individual' ? '' : certificate_type}">
                                            ${certificate_type == 'Individual' ? '-- Select Certificate Type --' : certificate_type}
                                        </option>
                                        <option value="Provisional Certificate">Provisional Certificate</option>
                                        <option value="Land Certificate">Land Certificate</option>
                                        <option value="Substituted Certificate">Substituted Certificate</option>
                                    </select>
                                    <div class="form-text">Select the type of certificate to generate</div>
                                </div>
                            </div>
                            
                            <!-- Certificate Number -->
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="lc_txt_certificate_number_" class="form-label fw-medium">
                                        <i class="fas fa-hashtag me-1"></i>
                                        Certificate Number
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-tag"></i>
                                        </span>
                                        <input type="text" class="form-control" 
                                               id="lc_txt_certificate_number_" 
                                               readonly value="${certificate_number}">
                                    </div>
                                    <div class="form-text">Auto-generated certificate number</div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Update Button -->
                        <div class="mt-4">
                            <button type="button" id="btn_save_lrd_certificate_update_details" 
                                    class="btn btn-primary w-100">
                                <i class="fas fa-sync-alt me-2"></i>
                                Update Certificate Details
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Certificate Summary Card -->
                <div class="card">
                    <div class="card-header bg-success bg-opacity-10 text-success d-flex justify-content-between">
                        <h6 class="mb-0">
                            <i class="fas fa-file-alt me-2"></i>
                            Certificate Summary
                        </h6>
                        <button class="btn btn-sm btn-danger" id="btn_compose_certificate_template">
                          <i class="fas fa-edit me-1"></i>Compose Template
                        </button>
                    </div>
                    <div class="card-body">
                        <!-- Certificate Summary Textarea -->
                        <div class="mb-4">
                            <label for="lc_search_report_summary_details" class="form-label fw-medium">
                                <i class="fas fa-edit me-1"></i>
                                Certificate Content
                            </label>
                            <div class="position-relative">
                                <div id="lc_search_report_summary_details">
                                  ${remark_or_comment}
                                </div>
                                <div class="position-absolute top-0 end-0 p-3 text-muted">
                                    <i class="fas fa-file-signature"></i>
                                </div>
                            </div>
                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                Enter the complete certificate summary and details. This content will be used to generate the final certificate.
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="row g-3 mt-4">
                            <div class="col-md-6">
                                <button type="button" name="lc_btn_save_search_report" 
                                        id="lc_btn_save_search_report" 
                                        class="btn btn-outline-primary w-100 h-100 py-3">
                                    <div class="d-flex flex-column align-items-center">
                                        <i class="fas fa-save fa-2x mb-2"></i>
                                        <span class="fw-medium">Save Certificate</span>
                                    </div>
                                </button>
                            </div>
                            
                            <div class="col-md-6">
                                <button type="button" name="lc_btn_save_register_description" 
                                        id="lc_btn_activate_final_certificate_" 
                                        class="btn btn-success w-100 h-100 py-3">
                                    <div class="d-flex flex-column align-items-center">
                                        <i class="fas fa-file-pdf fa-2x mb-2"></i>
                                        <span class="fw-medium">Generate Certificate</span>
                                    </div>
                                </button>
                            </div>
                        </div>
                       
                    </div>
                </div>
                
            </div>
           
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="confirm_otp_for_approval_certificate" tabindex="-1" 
     aria-labelledby="confirmOtpModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title text-white" id="confirmOtpModalLabel">
          <i class="fas fa-shield-alt me-2"></i>
          Request OTP For Approval
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Information Alert -->
        <div class="alert alert-danger bg-danger bg-opacity-10 border-danger mb-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>OTP Required</strong>
              <p class="mb-0 mt-1 fw-light">You need to generate a One-Time Password to proceed with certificate and register approval.</p>
            </div>
          </div>
        </div>
      
        <!-- Generate OTP Button -->
        <div class="text-center py-3">
          <button type="button" id="lc_generate_otp_for_approval_for_certificate_and_register" 
                  class="btn btn-danger btn-lg w-100 py-3">
            <i class="fas fa-key me-2"></i>
            Generate OTP
          </button>
          <div class="form-text mt-2">
            <i class="fas fa-lock me-1"></i>
            Secure one-time password will be sent for verification
          </div>
        </div>
        
        <!-- OTP Instructions -->
        <div class="alert alert-light border mt-4">
          <div class="d-flex">
            <i class="fas fa-lightbulb text-warning me-3 mt-1"></i>
            <div>
              <strong class="text-dark">How it works:</strong>
              <ul class="mb-0 mt-2 ps-3 fw-light">
                <li class="text-muted">Click "Generate OTP" to create a one-time password</li>
                <li class="text-muted">The OTP will be sent to authorized personnel</li>
                <li class="text-muted">Use the OTP to complete certificate approval</li>
              </ul>
            </div>
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="view_certificate" tabindex="-1"
     aria-labelledby="viewCertificateModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="viewCertificateModalLabel">
          <i class="fas fa-file-pdf me-2"></i>
          View Certificate
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body text-center p-5">
        
        <!-- Certificate Icon -->
        <div class="mb-4">
          <div class="icon-circle bg-primary bg-opacity-10 text-primary mb-3 mx-auto" style="width: 80px; height: 80px; line-height: 80px;">
            <i class="fas fa-certificate fa-3x"></i>
          </div>
          <h5 class="mb-3">Certificate Ready</h5>
          <p class="text-muted mb-4">
            Generate and view the final certificate document in PDF format.
          </p>
        </div>
        
        <!-- Generate Certificate Button -->
        <div class="mb-4">
          <button type="button" id="lc_btn_activate_final_certificate" 
                  class="btn btn-primary btn-lg w-100 py-3 shadow-sm">
            <i class="fas fa-file-pdf me-2"></i>
            Generate Certificate
          </button>
          <div class="form-text mt-2">
            <i class="fas fa-info-circle me-1"></i>
            This will create a downloadable PDF certificate
          </div>
        </div>
        
        <!-- Certificate Information -->
        <div class="alert alert-light border">
          <div class="d-flex">
            <i class="fas fa-check-circle text-success me-3 mt-1"></i>
            <div class="text-start">
              <strong class="text-dark">Certificate Details:</strong>
              <ul class="mb-0 mt-2 ps-3">
                <li class="text-muted">High-quality PDF format</li>
                <li class="text-muted">Official signatures</li>
                <li class="text-muted">Ready for download and printing</li>
              </ul>
            </div>
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="view_register" tabindex="-1"
     aria-labelledby="viewRegisterModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="viewRegisterModalLabel">
          <i class="fas fa-book me-2"></i>
          View Register
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body text-center p-5">
        
        <!-- Register Icon -->
        <div class="mb-4">
          <div class="icon-circle bg-primary bg-opacity-10 text-primary mb-3 mx-auto" 
               style="width: 80px; height: 80px; line-height: 80px;">
            <i class="fas fa-book-open fa-3x"></i>
          </div>
          <h5 class="mb-3">Register Generation</h5>
          <p class="text-muted mb-4">
            Generate the official register document with all recorded entries.
          </p>
        </div>
        
        <!-- Generate Register Button -->
        <div class="mb-4">
          <button type="button" id="lc_btn_activate_final_register" 
                  class="btn btn-primary btn-lg w-100 py-3 shadow-sm">
            <i class="fas fa-file-alt me-2"></i>
            Generate Register
          </button>
          <div class="form-text mt-2">
            <i class="fas fa-info-circle me-1"></i>
            This will create an official register document
          </div>
        </div>
        
        <!-- Register Information -->
        <div class="alert alert-light border">
          <div class="d-flex">
            <i class="fas fa-list-check text-primary me-3 mt-1"></i>
            <div class="text-start">
              <strong class="text-dark">Register Contents:</strong>
              <ul class="mb-0 mt-2 ps-3">
                <li class="text-muted">Complete list of all entries</li>
                <li class="text-muted">Chronological record of transactions</li>
                <li class="text-muted">Official format with serial numbers</li>
                <li class="text-muted">Ready for archival and reference</li>
              </ul>
            </div>
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="preview_certificate" tabindex="-1" aria-labelledby="preview_certificate_label" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="preview_certificate_label">
          <i class="fas fa-file-alt me-2"></i>
          Preview Certificate
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row mt-2">
          <div class="col-12">
            <!-- Certificate Preview Options -->
            <div class="d-grid gap-3">
              <!-- Main Certificate View Button -->
              <button type="button" id="lc_btn_activate_final_certificate_" class="btn btn-primary btn-lg py-3">
                <i class="fas fa-eye me-2"></i>
                View Final Certificate
              </button>
             
            </div>
            
            <!-- Certificate Info (Optional) -->
            <div class="alert alert-info mt-4">
              <div class="d-flex">
                <i class="fas fa-info-circle me-2 mt-1"></i>
                <div>
                  <small>
                    <strong>Note:</strong> This preview shows the certificate as it will appear when generated. 
                    You can make adjustments before finalizing.
                  </small>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="send_a_message_to_client" tabindex="-1" aria-labelledby="send_a_message_to_client_label" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="send_a_message_to_client_label">
                    <i class="fas fa-folder me-2"></i>
                    Cabinet Job Application
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="cabinetBatchingForm">
                    <!-- Cabinet Batching Section -->
                    <div class="card mb-4" id="cabinet-batching">
                        <div class="card-header bg-primary bg-opacity-10 text-primary">
                            <h6 class="card-title mb-0">
                                <i class="fas fa-inbox me-2"></i>
                                Batching to Cabinet
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="cabinet_to_send_to" class="form-label fw-medium">
                                        <i class="fas fa-folder-open me-1"></i>
                                        Cabinet Name:
                                    </label>
                                </div>
                                <div class="col-md-8">
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-archive"></i>
                                        </span>
                                        <input type="text" 
                                               class="form-control" 
                                               id="cabinet_to_send_to" 
                                               required
                                               placeholder="Enter cabinet name">
                                        <!-- <button type="button" class="btn btn-outline-success" id="btnBrowseCabinets">
                                            <i class="fas fa-search"></i>
                                        </button> -->
                                    </div>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Enter the cabinet name where the application will be stored
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Application Details -->
                    <div class="card mb-3">
                        <div class="card-header bg-primary bg-opacity-10 text-primary">
                            <h6 class="card-title mb-0">
                                <i class="fas fa-file-alt me-2"></i>
                                Application Details
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <!-- Applicant Name -->
                                <div class="col-md-6">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-user me-1"></i>
                                        Applicant Name:
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-id-card"></i>
                                        </span>
                                        <input type="text" 
                                               id="cabinet_ar_name"
                                               class="form-control" 
                                               value="${ar_name}" 
                                               readonly>
                                    </div>
                                </div>

                                <!-- Job Number -->
                                <div class="col-md-6">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-hashtag me-1"></i>
                                        Job Number:
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-briefcase"></i>
                                        </span>
                                        <input type="text" 
                                               class="form-control" 
                                               value="${job_number}" 
                                               readonly>
                                    </div>
                                </div>

                                <!-- Locality -->
                                <div class="col-12">
                                    <label class="form-label fw-medium">
                                        <i class="fas fa-map-marker-alt me-1"></i>
                                        Locality:
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-location-dot"></i>
                                        </span>
                                        <input type="text" 
                                               id="cabinet_locality"
                                               class="form-control" 
                                               value="${locality}" 
                                               readonly>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Notes (Optional) -->
                    <div class="mb-3">
                        <label for="batchNotes" class="form-label fw-medium">
                            <i class="fas fa-sticky-note me-1"></i>
                            Notes (Optional):
                        </label>
                        <textarea class="form-control" 
                                  id="batchNotes" 
                                  rows="2" 
                                  placeholder="Add any notes or instructions for cabinet storage..."></textarea>
                        <div class="form-text">
                            <i class="fas fa-lightbulb me-1"></i>
                            Optional notes to help identify or categorize this batch
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <div class="w-100 d-flex justify-content-between">
                    <button type="button" 
                            class="btn btn-outline-secondary" 
                            data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>
                        Cancel
                    </button>
                    <div>
                        <button type="button" 
                                class="btn btn-primary" 
                                id="btn_process_completed_app_cabinet">
                            <i class="fas fa-paper-plane me-1"></i>
                            Process to Cabinet
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="enter_details_for_collection_and_print_collection" tabindex="-1" aria-labelledby="collection_details_label" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="collection_details_label">
          <i class="fas fa-user-check me-2"></i>
          Enter Details for Collector
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="frmSaveCollection" class="needs-validation" novalidate>
          
          <!-- Collector's Information Card -->
          <div class="card mb-4">
            <div class="card-header bg-primary bg-opacity-10 text-primary">
              <h6 class="card-title mb-0">
                <i class="fas fa-id-card me-2"></i>
                Collector's Information
              </h6>
            </div>
            <div class="card-body">
              <!-- Collected by -->
              <div class="row mb-3">
                <label class="col-md-3 col-form-label fw-medium">
                  <i class="fas fa-user me-1"></i>
                  Collected by:
                </label>
                <div class="col-md-9">
                  <div class="input-group">
                    <span class="input-group-text">
                      <i class="fas fa-signature"></i>
                    </span>
                    <input type="text" 
                           class="form-control" 
                           id="col_collected_by" 
                           required
                           placeholder="Enter full name of collector">
                  </div>
                  <div class="invalid-feedback">
                    Please enter the collector's name
                  </div>
                </div>
              </div>
              
              <!-- ID Type -->
              <div class="row mb-3">
                <label class="col-md-3 col-form-label fw-medium">
                  <i class="fas fa-id-card me-1"></i>
                  ID Type:
                </label>
                <div class="col-md-9">
                  <div class="input-group">
                    <span class="input-group-text">
                      <i class="fas fa-passport"></i>
                    </span>
                    <select id="col_id_type" 
                            class="form-select" 
                            required>
                      <option value="" selected disabled>Select ID Type</option>
                      <option value="NATIONAL ID">NATIONAL ID</option>
                      <option value="PASSPORT">PASSPORT</option>
                      <option value="DRIVERS LICENSE">DRIVERS LICENSE</option>
                      <option value="NHIS CARD">NHIS CARD</option>
                      <option value="VOTERS ID">VOTERS ID</option>
                      <option value="SSNIT ID CARD">SSNIT ID CARD</option>
                    </select>
                  </div>
                  <div class="invalid-feedback">
                    Please select an ID type
                  </div>
                </div>
              </div>
              
              <!-- ID Number -->
              <div class="row mb-3">
                <label class="col-md-3 col-form-label fw-medium">
                  <i class="fas fa-hashtag me-1"></i>
                  ID Number:
                </label>
                <div class="col-md-9">
                  <div class="input-group">
                    <span class="input-group-text">
                      <i class="fas fa-fingerprint"></i>
                    </span>
                    <input type="text" 
                           class="form-control" 
                           id="col_id_number" 
                           required
                           placeholder="Enter ID number">
                  </div>
                  <div class="invalid-feedback">
                    Please enter the ID number
                  </div>
                </div>
              </div>
              
              <!-- Phone Number -->
              <div class="row mb-2">
                <label class="col-md-3 col-form-label fw-medium">
                  <i class="fas fa-phone me-1"></i>
                  Phone Number:
                </label>
                <div class="col-md-9">
                  <div class="input-group">
                    <span class="input-group-text">
                      <i class="fas fa-mobile-alt"></i>
                    </span>
                    <input type="tel" 
                           class="form-control" 
                           id="col_phone_number" 
                           required
                           placeholder="Enter phone number">
                  </div>
                  <div class="invalid-feedback">
                    Please enter a valid phone number
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Document Attachment Section -->
          <div class="card border-warning mb-4">
            <div class="card-header bg-warning bg-opacity-10 text-warning">
              <h6 class="card-title mb-0">
                <i class="fas fa-paperclip me-2"></i>
                Document Attachment
              </h6>
            </div>
            <div class="card-body">
              <div class="d-flex align-items-center justify-content-between">
                <div>
                  <i class="fas fa-file-upload text-warning me-2"></i>
                  <span>Attach collector's identification document</span>
                </div>
                <button type="button" 
                        class="btn btn-outline-warning publicFileUploadModal">
                  <i class="fas fa-plus me-1"></i>
                  Attach Document
                </button>
              </div>
              <div class="form-text mt-2">
                <i class="fas fa-info-circle me-1"></i>
                Supported formats: PDF, JPG, PNG (Max: 5MB)
              </div>
              
              <!-- Uploaded files preview -->
              <div id="uploadedDocuments" class="mt-3" style="display: none;">
                <div class="alert alert-success">
                  <div class="d-flex justify-content-between align-items-center">
                    <div>
                      <i class="fas fa-check-circle me-2"></i>
                      <span class="uploaded-file-name">document.pdf</span>
                    </div>
                    <button type="button" class="btn btn-sm btn-outline-danger">
                      <i class="fas fa-times"></i>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Additional Notes -->
          <div class="mb-4">
            <label for="collectionNotes" class="form-label fw-medium">
              <i class="fas fa-sticky-note me-1"></i>
              Additional Notes (Optional):
            </label>
            <textarea class="form-control" 
                      id="collectionNotes" 
                      rows="2" 
                      placeholder="Any additional information about the collection..."></textarea>
          </div>
          
          <!-- Submit Button -->
          <div class="d-grid">
            <button type="submit" class="btn btn-primary btn-lg py-3">
              <i class="fas fa-save me-2"></i>
              Save Collection Details
            </button>
          </div>
          
        </form>
      </div>
      <div class="modal-footer">
        <div class="w-100 d-flex justify-content-between">
          <div class="form-check">
            <input class="form-check-input" type="checkbox" id="printReceipt">
            <label class="form-check-label" for="printReceipt">
              <i class="fas fa-print me-1"></i>
              Print receipt after save
            </label>
          </div>
          <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
            <i class="fas fa-times me-1"></i>
            Close
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="check_availability_of_mother_file" tabindex="-1"
     aria-labelledby="checkMotherFileModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="checkMotherFileModalLabel">
          <i class="fas fa-archive me-2"></i>
          Check Availability of Mother File
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Search Form Card -->
        <div class="card">
          <div class="card-header bg-primary bg-opacity-10 text-primary">
            <h6 class="mb-0">
              <i class="fas fa-search me-2"></i>
              Search Mother File
            </h6>
          </div>
          <div class="card-body">
            <form id="linkSearchMotherfile" method="post">
              
              <!-- Search Type Selection -->
              <div class="mb-4">
                <label class="form-label fw-medium mb-3">
                  <i class="fas fa-filter me-1"></i>
                  Search By:
                </label>
                <div class="d-flex flex-wrap gap-3">
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type" 
                           id="rbtn_search_type3" value="job_number" required>
                    <label class="form-check-label" for="rbtn_search_type3">
                      Job Number
                    </label>
                  </div>
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type" 
                           id="rbtn_search_type4" value="certificate_number" required>
                    <label class="form-check-label" for="rbtn_search_type4">
                      Certificate Number
                    </label>
                  </div>
                </div>
              </div>
              
              <!-- Search Input -->
              <div class="row g-3 align-items-end">
                <div class="col-md-8">
                  <div class="form-group">
                    <label for="link_search_value" class="form-label fw-medium">
                      <i class="fas fa-keyboard me-1"></i>
                      Search Value
                    </label>
                    <div class="input-group">
                      <span class="input-group-text">
                        <i class="fas fa-search"></i>
                      </span>
                      <input class="form-control" id="link_search_value" name="link_search_value" 
                             type="text" placeholder="Enter job number or certificate number" required>
                    </div>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <button type="submit" class="btn btn-primary w-100" id="btnEnquiryJobSearch">
                      <i class="fas fa-search me-2"></i>
                      Search
                    </button>
                  </div>
                </div>
              </div>
              
              <div class="form-text">
                Enter the job number or certificate number to search for mother file
              </div>
            </form>
          </div>
        </div>
        
        <!-- Search Results Card -->
        <div class="card border-success mt-4" style="display:none" id="link-search-results-section">
          <div class="card-header bg-success bg-opacity-10 text-success">
            <div class="d-flex justify-content-between align-items-center">
              <h6 class="mb-0">
                <i class="fas fa-file-alt me-2"></i>
                Search Results
              </h6>
              <span class="badge bg-success" id="resultsCount">0 results</span>
            </div>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-hover table-striped" id="link-search-results-table">
                <thead class="table-light">
                  <tr>
                    <th width="25%">
                      <!-- <i class="fas fa-user me-1"></i> -->
                      Applicant Name
                    </th>
                    <th width="30%">
                      <!-- <i class="fas fa-certificate me-1"></i> -->
                      Certificate Number
                    </th>
                    <th width="15%">
                      <!-- <i class="fas fa-hashtag me-1"></i> -->
                      Job Number
                    </th>
                    <th width="20%">
                      <!-- <i class="fas fa-map-marker-alt me-1"></i> -->
                      Locality
                    </th>
                    <th width="10%" class="text-end">
                      <!-- <i class="fas fa-cogs me-1"></i> -->
                      Actions
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <!-- Results will be populated here -->
                </tbody>
              </table>
            </div>
            
            <!-- No Results Message -->
            <div id="noResultsMessage" class="text-center py-5 d-none">
              <div class="mb-3">
                <i class="fas fa-file-excel fa-3x text-muted"></i>
              </div>
              <h6 class="text-muted">No Mother Files Found</h6>
              <p class="text-muted small">Try searching with a different job number or certificate number</p>
            </div>
            
            <!-- Loading State -->
            <div id="loadingResults" class="text-center py-5 d-none">
              <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
              <p class="mt-3 text-muted">Searching for mother files...</p>
            </div>
            
          </div>
        </div>
        
        <!-- Information Alert -->
        <div class="alert alert-info bg-info bg-opacity-10 border-info mt-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>About Mother Files:</strong>
              <p class="mb-0 mt-2">
                Mother files contain the original documents and records for each land registration case.
                Use this search to check if a mother file exists for a specific job or certificate.
              </p>
            </div>
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="transitional_certificate_template" tabindex="-1"
     aria-labelledby="certificateAndRegisterDetailsLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center justify-content-between w-100">
                    <div>
                        <!-- <i class="fas fa-certificate me-2"></i> -->
                        <h5 class="modal-title text-white mb-0" id="certificateAndRegisterDetailsLabel">
                            Certificate and Register Details
                        </h5>
                        <small class="opacity-75 text-white" id="modalCaseNumber">Case: Loading...</small>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-0">

                <input type="hidden" id="certificateAndRegisterDetailsCaseNumber">
                <input type="hidden" id="certificateAndRegisterDetailsTransactionNumber">
                <input type="hidden" id="certificateAndRegisterDetailsJobNumber">
                
                <!-- Case Details Section -->
                <div class="accordion" id="caseDetailsAccordion">
                    
                    <!-- Case Details Card -->
                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="caseDetailsHeading">
                            <button class="accordion-button bg-light text-dark fw-bold py-3 collapsed" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#caseDetailsCollapse" 
                                    aria-expanded="false" aria-controls="caseDetailsCollapse">
                                <div class="d-flex align-items-center w-100">
                                    <i class="fas fa-folder-open text-primary me-3 fa-lg"></i>
                                    <div>
                                        <h6 class="mb-0">Case Details</h6>
                                        <small class="text-muted">Complete case information and registration details</small>
                                    </div>
                                </div>
                            </button>
                        </h2>
                        <div id="caseDetailsCollapse" class="accordion-collapse collapse" 
                             aria-labelledby="caseDetailsHeading" data-bs-parent="#caseDetailsAccordion">
                            <div class="accordion-body bg-white p-4">
                                
                                <!-- Case Information Grid -->
                                <div class="row g-4">
                                    
                                    <!-- Basic Information -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i>Basic Information</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <label class="form-label small text-muted mb-1">Case Number</label>
                                                            <div class="d-flex align-items-center">
                                                                <i class="fas fa-hashtag text-primary me-2"></i>
                                                                <span class="fw-medium" id="ts_main_case_number_sm">-</span>
                                                            </div>
                                                        </div>
                                                        <span class="badge bg-primary bg-opacity-10 text-primary">ID</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Regional Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-map-marker-alt text-primary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_regional_number_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Locality</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-location-dot text-primary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_locality_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Transaction Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-exchange-alt text-primary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_transaction_number_sm">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Registration Details -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-book me-2 text-success"></i>Registration Details</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Registration District</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-map text-success me-2"></i>
                                                        <span class="fw-medium" id="ts_main_registration_district_number_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Registration Section</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-layer-group text-success me-2"></i>
                                                        <span class="fw-medium" id="ts_main_registration_section_number_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Registration Block</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-cube text-success me-2"></i>
                                                        <span class="fw-medium" id="ts_main_registration_block_number_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">District</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-building text-success me-2"></i>
                                                        <span class="fw-medium" id="ts_main_district_sm">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Land Details -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-mountain me-2 text-warning"></i>Land Information</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <label class="form-label small text-muted mb-1">Size of Land</label>
                                                            <div class="d-flex align-items-center">
                                                                <i class="fas fa-expand text-warning me-2"></i>
                                                                <span class="fw-medium" id="ts_main_size_of_land_sm">-</span>
                                                            </div>
                                                        </div>
                                                        <span class="badge bg-warning bg-opacity-10 text-warning">Area</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">GLPIN</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-fingerprint text-warning me-2"></i>
                                                        <span class="fw-medium" id="ts_main_glpin_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">CC Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-file-contract text-warning me-2"></i>
                                                        <span class="fw-medium" id="ts_main_cc_no_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Region</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-globe text-warning me-2"></i>
                                                        <span class="fw-medium" id="ts_main_region_sm">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Document Details -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-file-contract me-2 text-info"></i>Document Information</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Date of Document</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-calendar text-info me-2"></i>
                                                        <span class="fw-medium" id="ts_main_date_of_document_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Nature of Instrument</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-gavel text-info me-2"></i>
                                                        <span class="fw-medium" id="ts_main_nature_of_instrument_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Type of Interest</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-handshake text-info me-2"></i>
                                                        <span class="fw-medium" id="ts_main_type_of_interest_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Type of Use</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-tag text-info me-2"></i>
                                                        <span class="fw-medium" id="ts_main_type_of_use_sm">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Financial Details -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-money-bill-wave me-2 text-danger"></i>Financial Details</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <label class="form-label small text-muted mb-1">Assessed Value</label>
                                                            <div class="d-flex align-items-center">
                                                                <i class="fas fa-balance-scale text-danger me-2"></i>
                                                                <span class="fw-medium" id="ts_main_assessed_value_sm">-</span>
                                                            </div>
                                                        </div>
                                                        <span class="badge bg-danger bg-opacity-10 text-danger">Value</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Stamp Duty Payable</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-receipt text-danger me-2"></i>
                                                        <span class="fw-medium" id="ts_main_stamp_duty_payable_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Consideration Fee</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-hand-holding-usd text-danger me-2"></i>
                                                        <span class="fw-medium" id="ts_main_consideration_fee_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Consideration Currency</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-coins text-danger me-2"></i>
                                                        <span class="fw-medium" id="ts_main_case_consideration_fee_currency_sm">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Dates & Applicant -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-calendar-alt me-2 text-purple"></i>Dates & Applicant</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Commencement Date</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-play text-purple me-2"></i>
                                                        <span class="fw-medium" id="ts_main_commencement_date_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Date of Registration</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-calendar-check text-purple me-2"></i>
                                                        <span class="fw-medium" id="ts_main_date_of_registration_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Publication Date</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-newspaper text-purple me-2"></i>
                                                        <span class="fw-medium" id="ts_main_publicity_date_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Applicant Name</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-user text-purple me-2"></i>
                                                        <span class="fw-medium" id="ts_main_ar_name_sm">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Reference Numbers -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-hashtag me-2 text-teal"></i>Reference Numbers</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Job Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-briefcase text-teal me-2"></i>
                                                        <span class="fw-medium" id="ts_main_job_number_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Certificate Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-certificate text-teal me-2"></i>
                                                        <span class="fw-medium" id="ts_main_certificate_number_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Registered Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-registered text-teal me-2"></i>
                                                        <span class="fw-medium" id="ts_main_case_registered_number_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Date of Issue</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-calendar-day text-teal me-2"></i>
                                                        <span class="fw-medium" id="ts_main_case_date_of_issue_sm">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Plotting & Plans -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-drafting-compass me-2 text-indigo"></i>Plotting & Plans</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Type of Plotting</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-ruler-combined text-indigo me-2"></i>
                                                        <span class="fw-medium" id="ts_main_smd_type_of_plotting_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">SMD Reference</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-map-pin text-indigo me-2"></i>
                                                        <span class="fw-medium" id="ts_main_smd_reference_number_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Plan Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-map text-indigo me-2"></i>
                                                        <span class="fw-medium" id="ts_main_plan_no_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Registry Map Ref</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-map-marked-alt text-indigo me-2"></i>
                                                        <span class="fw-medium" id="ts_main_registry_mapref_sm">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Additional Details -->
                                    <div class="col-md-4">
                                        <div class="card h-100 border-light shadow-sm">
                                            <div class="card-header bg-light">
                                                <h6 class="mb-0"><i class="fas fa-ellipsis-h me-2 text-secondary"></i>Additional Details</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Term</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-clock text-secondary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_term_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Adopted Rate</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-percentage text-secondary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_case_consideration_fee_adopted_rate_sm">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item mb-3">
                                                    <label class="form-label small text-muted mb-1">Interest Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-hashtag text-secondary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_interest_number">-</span>
                                                    </div>
                                                </div>
                                                <div class="info-item">
                                                    <label class="form-label small text-muted mb-1">Sub-Interest Number</label>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-hashtag text-secondary me-2"></i>
                                                        <span class="fw-medium" id="ts_main_sub_interest_number">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Root of Title Section -->
                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="rootOfTitleHeading">
                            <button class="accordion-button bg-light text-dark fw-bold py-3 collapsed" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#rootOfTitleCollapse" 
                                    aria-expanded="false" aria-controls="rootOfTitleCollapse">
                                <div class="d-flex align-items-center w-100">
                                    <i class="fas fa-sitemap text-success me-3 fa-lg"></i>
                                    <div>
                                        <h6 class="mb-0">Root of Title</h6>
                                        <small class="text-muted">Proprietorship, memorials, valuations, certificates & encumbrances</small>
                                    </div>
                                </div>
                            </button>
                        </h2>
                        <div id="rootOfTitleCollapse" class="accordion-collapse collapse" 
                             aria-labelledby="rootOfTitleHeading" data-bs-parent="#caseDetailsAccordion">
                            <div class="accordion-body bg-white p-4">
                                
                                <!-- Proprietorship Details -->
                                <div class="card border-light shadow-sm mb-4">
                                    <div class="card-header bg-success bg-opacity-10 border-success">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0">
                                                <i class="fas fa-user-tie text-success me-2"></i>
                                                Proprietorship Details
                                            </h6>
                                            <span class="badge bg-success" id="proprietorshipCount">0</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-sm" id="lrd_proprietorship_details_dataTable_2">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th><i class="fas fa-hashtag me-1"></i> Registered No.</th>
                                                        <th><i class="fas fa-user me-1"></i> Proprietor</th>
                                                        <th><i class="fas fa-calendar-alt me-1"></i> Date of Instrument</th>
                                                        <th><i class="fas fa-file-contract me-1"></i> Nature of Instrument</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Data will be populated here -->
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="text-center py-4" id="noProprietorship">
                                            <i class="fas fa-user-tie fa-2x text-muted mb-3"></i>
                                            <p class="text-muted mb-0">No proprietorship records found</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Memorial Details -->
                                <div class="card border-light shadow-sm mb-4">
                                    <div class="card-header bg-info bg-opacity-10 border-info">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0">
                                                <i class="fas fa-file-signature text-info me-2"></i>
                                                Memorial Details
                                            </h6>
                                            <span class="badge bg-info" id="memorialsCount">0</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-sm" id="lrd_memorial_details_dataTable_2">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th><i class="fas fa-hashtag me-1"></i> Registered No.</th>
                                                        <th><i class="fas fa-file-alt me-1"></i> Memorials</th>
                                                        <th><i class="fas fa-calendar-alt me-1"></i> Date of Instrument</th>
                                                        <th><i class="fas fa-calendar-check me-1"></i> Date of Registration</th>
                                                        <th><i class="fas fa-list-ol me-1"></i> Entry No</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Data will be populated here -->
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="text-center py-4" id="noMemorials">
                                            <i class="fas fa-file-signature fa-2x text-muted mb-3"></i>
                                            <p class="text-muted mb-0">No memorial records found</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Valuation Details -->
                                <div class="card border-light shadow-sm mb-4">
                                    <div class="card-header bg-warning bg-opacity-10 border-warning">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0">
                                                <i class="fas fa-chart-line text-warning me-2"></i>
                                                Valuation Details
                                            </h6>
                                            <span class="badge bg-warning" id="valuationCount">0</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-sm" id="lrd_valuation_details_dataTable_2">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th><i class="fas fa-calendar-alt me-1"></i> Date of Valuation</th>
                                                        <th><i class="fas fa-money-bill-wave me-1"></i> Amount</th>
                                                        <th><i class="fas fa-sticky-note me-1"></i> Remarks</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Data will be populated here -->
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="text-center py-4" id="noValuations">
                                            <i class="fas fa-chart-line fa-2x text-muted mb-3"></i>
                                            <p class="text-muted mb-0">No valuation records found</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Certificate Details -->
                                <div class="card border-light shadow-sm mb-4">
                                    <div class="card-header bg-primary bg-opacity-10 border-primary">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0">
                                                <i class="fas fa-certificate text-primary me-2"></i>
                                                Certificate Details
                                            </h6>
                                            <span class="badge bg-primary" id="certificateCount">0</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-sm" id="lrd_certificate_details_dataTable_2">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th><i class="fas fa-calendar-check me-1"></i> Date of Registration</th>
                                                        <th><i class="fas fa-user-check me-1"></i> To Whom Issued</th>
                                                        <th><i class="fas fa-hashtag me-1"></i> Serial Number</th>
                                                        <th><i class="fas fa-sticky-note me-1"></i> Official Notes</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Data will be populated here -->
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="text-center py-4" id="noCertificates">
                                            <i class="fas fa-certificate fa-2x text-muted mb-3"></i>
                                            <p class="text-muted mb-0">No certificate records found</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Encumbrances Details -->
                                <div class="card border-light shadow-sm">
                                    <div class="card-header bg-danger bg-opacity-10 border-danger">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0">
                                                <i class="fas fa-file-contract text-danger me-2"></i>
                                                Encumbrances Details
                                            </h6>
                                            <span class="badge bg-danger" id="encumbrancesCount">0</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-sm" id="lrd_registration_encumbrance_dataTable_2">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th><i class="fas fa-hashtag me-1"></i> Registered Number</th>
                                                        <th><i class="fas fa-calendar-alt me-1"></i> Date of Instrument</th>
                                                        <th><i class="fas fa-calendar-check me-1"></i> Date of Registration</th>
                                                        <th><i class="fas fa-file-alt me-1"></i> Memorials</th>
                                                        <th><i class="fas fa-sticky-note me-1"></i> Remarks</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Data will be populated here -->
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="text-center py-4" id="noEncumbrances">
                                            <i class="fas fa-file-contract fa-2x text-muted mb-3"></i>
                                            <p class="text-muted mb-0">No encumbrance records found</p>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    
                    <!-- Documents Section -->
                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="documentsHeading">
                            <button class="accordion-button bg-light text-dark fw-bold py-3 collapsed" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#documentsCollapse" 
                                    aria-expanded="false" aria-controls="documentsCollapse">
                                <div class="d-flex align-items-center w-100">
                                    <i class="fas fa-file-alt text-info me-3 fa-lg"></i>
                                    <div>
                                        <h6 class="mb-0">Application Documents</h6>
                                        <small class="text-muted">Scanned documents and attachments</small>
                                    </div>
                                </div>
                            </button>
                        </h2>
                        <div id="documentsCollapse" class="accordion-collapse collapse" 
                             aria-labelledby="documentsHeading" data-bs-parent="#caseDetailsAccordion">
                            <div class="accordion-body bg-white p-4">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <button type="button" class="btn btn-outline-info" id="btn_load_scanned_documents_ts">
                                        <i class="fas fa-eye me-2"></i>
                                        Load Documents
                                    </button>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm" id="lc_main_scanned_documents_dataTable_ts">
                                        <thead class="table-light">
                                            <tr>
                                                <th><i class="fas fa-file me-1"></i> Document Name</th>
                                                <th><i class="fas fa-file-alt me-1"></i> Document Type</th>
                                                <th class="text-center"><i class="fas fa-cog me-1"></i> Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="documentsTableBody_ts">
                                            <!-- Data will be populated here -->
                                        </tbody>
                                    </table>
                                </div>
                                <!-- <div class="text-center py-5" id="tsNoDocuments">
                                    <i class="fas fa-file-alt fa-3x text-muted mb-3"></i>
                                    <h6 class="text-muted mb-2">No Documents Found</h6>
                                    <p class="text-muted small">Click "Load Documents" to view case documents</p>
                                </div> -->
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="publicDocumentsHeading">
                            <button class="accordion-button bg-light text-dark fw-bold py-3 collapsed" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#publicDocumentsCollapse" 
                                    aria-expanded="false" aria-controls="publicDocumentsCollapse">
                                <div class="d-flex align-items-center w-100">
                                    <i class="fas fa-file-alt text-secondary me-3 fa-lg"></i>
                                    <div>
                                        <h6 class="mb-0">Public Documents</h6>
                                        <small class="text-muted">Scanned public documents and attachments</small>
                                    </div>
                                </div>
                            </button>
                        </h2>
                        <div id="publicDocumentsCollapse" class="accordion-collapse collapse" 
                             aria-labelledby="publicDocumentsHeading" data-bs-parent="#caseDetailsAccordion">
                            <div class="accordion-body bg-white p-4">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <button type="button" class="btn btn-outline-secondary" id="btn_load_scanned_public_documents_ts_deed">
                                        <i class="fas fa-eye me-2"></i>
                                        Load Documents
                                    </button>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover table-sm" id="lc_main_scanned_public_documents_dataTable_ts">
                                        <thead class="table-light">
                                            <tr>
                                                <th><i class="fas fa-file me-1"></i> Document Name</th>
                                                <th><i class="fas fa-file-alt me-1"></i> Document Type</th>
                                                <th class="text-center"><i class="fas fa-cog me-1"></i> Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="publicDocumentsTableBody_ts">
                                            <!-- Data will be populated here -->
                                        </tbody>
                                    </table>
                                </div>
                                <!-- <div class="text-center py-5" id="tsNoDocuments_d">
                                    <i class="fas fa-file-alt fa-3x text-muted mb-3"></i>
                                    <h6 class="text-muted mb-2">No Documents Found</h6>
                                    <p class="text-muted small">Click "Load Documents" to view case documents</p>
                                </div> -->
                            </div>
                        </div>
                    </div>
                    
                    <!-- Previews Section -->
                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="previewsHeading">
                            <button class="accordion-button bg-light text-dark fw-bold py-3" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#previewsCollapse" 
                                    aria-expanded="true" aria-controls="previewsCollapse">
                                <div class="d-flex align-items-center w-100">
                                    <i class="fas fa-print text-purple me-3 fa-lg"></i>
                                    <div>
                                        <h6 class="mb-0">Previews & Generation</h6>
                                        <small class="text-muted">Generate registers and certificates</small>
                                    </div>
                                </div>
                                
                            </button>
                        </h2>
                        <div id="previewsCollapse" class="accordion-collapse collapse show" 
                             aria-labelledby="previewsHeading" data-bs-parent="#caseDetailsAccordion">
                            <div class="accordion-body bg-white p-4">
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <div class="card border-purple h-100">
                                            <div class="card-body text-center p-4">
                                                <i class="fas fa-book fa-3x text-purple mb-3"></i>
                                                <h5 class="card-title mb-3">Generate Register</h5>
                                                <p class="card-text text-muted mb-4">
                                                    Create the official register document with all case details and records.
                                                </p>
                                                <button type="button" id="lc_btn_activate_final_register_md" 
                                                        class="btn btn-purple w-100 py-3">
                                                    <i class="fas fa-print me-2"></i>
                                                    Generate Register
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>
                    Close
                </button>
                <input type="hidden" id="lrd_ps_fid" name="lrd_ps_fid">
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="check_interest_and_sub_interest_mother_file" tabindex="-1"
     aria-labelledby="checkInterestModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="checkInterestModalLabel">
          <i class="fas fa-archive me-2"></i>
          Check Interest and Sub-Interest Mother File
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Search Form Card -->
        <div class="card mb-4">
          <div class="card-header bg-primary bg-opacity-10 text-primary">
            <h6 class="mb-0">
              <i class="fas fa-search me-2"></i>
              Search Mother File
            </h6>
          </div>
          <div class="card-body">
            <form id="linkSearchMotherfileInterest" method="post">
              
              <!-- Search Type Selection -->
              <div class="mb-4">
                <label class="form-label fw-medium mb-3">
                  <i class="fas fa-filter me-1"></i>
                  Search By:
                </label>
                <div class="d-flex flex-wrap gap-3">
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type__" 
                           id="rbtn_search_type10" value="job_number" required>
                    <label class="form-check-label" for="rbtn_search_type10">
                      Job Number
                    </label>
                  </div>
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type__" 
                           id="rbtn_search_type11" value="certificate_number" required>
                    <label class="form-check-label" for="rbtn_search_type11">
                      Certificate Number
                    </label>
                  </div>
                </div>
              </div>
              
              <!-- Search Input -->
              <div class="row g-3 align-items-end">
                <div class="col-md-8">
                  <div class="form-group">
                    <label for="link_search_value__" class="form-label fw-medium">
                      <i class="fas fa-keyboard me-1"></i>
                      Search Value
                    </label>
                    <div class="input-group">
                      <span class="input-group-text">
                        <i class="fas fa-search"></i>
                      </span>
                      <input class="form-control" id="link_search_value__" name="link_search_value__" 
                             type="text" placeholder="Enter job number or certificate number" required>
                    </div>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <button type="submit" class="btn btn-primary w-100" id="btnEnquiryJobSearch">
                      <i class="fas fa-search me-2"></i>
                      Search
                    </button>
                  </div>
                </div>
                <div class="form-text">
                    Enter the job number or certificate number to search for mother file
                </div>
              </div>
              
            </form>
          </div>
        </div>
        
        <!-- Results Section -->
        <div class="card border-success" style="display:none" id="link-search-results-section__">
          <div class="card-header bg-success bg-opacity-10 text-success">
            <div class="d-flex justify-content-between align-items-center">
              <h6 class="mb-0">
                <i class="fas fa-file-alt me-2"></i>
                Search Results
              </h6>
              <span class="badge bg-success rounded-pill">Found</span>
            </div>
          </div>
          <div class="card-body">
            
            <!-- Loading State -->
            <div id="loadingResults" class="text-center py-5 d-none">
              <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
              <p class="mt-3 text-muted">Searching for mother file...</p>
            </div>
            
            <!-- Results Content -->
            <div id="resultsContent" class="d-none">
              <div class="row g-4">
                
                <!-- Interest Number Card -->
                <div class="col-md-6">
                  <div class="card border-info h-100">
                    <div class="card-header bg-info bg-opacity-10 text-info">
                      <div class="d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">
                          <i class="fas fa-hashtag me-2"></i>
                          Interest Number
                        </h6>
                        <span class="badge bg-info">Main</span>
                      </div>
                    </div>
                    <div class="card-body text-center p-4">
                      <div class="mb-3">
                        <i class="fas fa-key fa-3x text-info"></i>
                      </div>
                      <div class="display-value fs-5 fw-bold text-info mb-3" id="chk_interest_number">
                        -
                      </div>
                      <p class="text-muted small mb-0">
                        Primary interest identifier for the mother file
                      </p>
                    </div>
                  </div>
                </div>
                
                <!-- Sub-Interest Number Card -->
                <div class="col-md-6">
                  <div class="card border-warning h-100">
                    <div class="card-header bg-warning bg-opacity-10 text-warning">
                      <div class="d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">
                          <i class="fas fa-layer-group me-2"></i>
                          Sub-Interest Number
                        </h6>
                        <span class="badge bg-warning">Secondary</span>
                      </div>
                    </div>
                    <div class="card-body text-center p-4">
                      <div class="mb-3">
                        <i class="fas fa-sitemap fa-3x text-warning"></i>
                      </div>
                      <div class="display-value fs-5 fw-bold text-warning mb-3" id="chk_sub_interest_number">
                        -
                      </div>
                      <p class="text-muted small mb-0">
                        Secondary interest identifier under the main interest
                      </p>
                    </div>
                  </div>
                </div>
                
              </div>
              
              <!-- Additional Information -->
              <div class="alert alert-info bg-info bg-opacity-10 border-info mt-4">
                <div class="d-flex">
                  <i class="fas fa-info-circle me-3 mt-1"></i>
                  <div>
                    <strong>About Interest Numbers:</strong>
                    <ul class="mb-0 mt-2 ps-3">
                      <li>Interest Number identifies the primary legal interest in the property</li>
                      <li>Sub-Interest Number identifies subsidiary interests or divisions</li>
                      <li>Both numbers are essential for complete mother file identification</li>
                      <li>Used for cross-referencing and legal documentation</li>
                    </ul>
                  </div>
                </div>
              </div>
              
            </div>
            
            <!-- No Results Message -->
            <div id="noResultsMessage" class="text-center py-5 d-none">
              <div class="mb-3">
                <i class="fas fa-file-excel fa-3x text-muted"></i>
              </div>
              <h6 class="text-muted">No Mother Files Found</h6>
              <p class="text-muted small">Try searching with a different job number or certificate number</p>
            </div>
            
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>


<div class="modal fade effect-scale modal-blur" id="link_to_mother_file" tabindex="-1"
     aria-labelledby="linkToMotherFileModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="linkToMotherFileModalLabel">
          <i class="fas fa-link me-2"></i>
          Link to Mother File
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
         <input class="form-control" hidden id="linkedMotherFile" value="${mother_to_child_link_list}" />    
         <div class="mb-3" id="htmlLinkedMotherFile"></div>
        <!-- Search Form Card -->
        <div class="card">
          <div class="card-header bg-primary bg-opacity-10 text-primary">
            <h6 class="mb-0">
              <i class="fas fa-search me-2"></i>
              Search Mother File
            </h6>
          </div>
          <div class="card-body">
            <form id="linkSearchMotherfile_" method="post">
              
              <!-- Search Type Selection -->
              <div class="mb-4">
                <label class="form-label fw-medium mb-3">
                  <i class="fas fa-filter me-1"></i>
                  Search By:
                </label>
                <div class="d-flex flex-wrap gap-3">
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type_" 
                           id="rbtn_search_type7" value="job_number" required>
                    <label class="form-check-label" for="rbtn_search_type7">
                      Job Number
                    </label>
                  </div>
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="link_search_type_" 
                           id="rbtn_search_type8" value="certificate_number" required>
                    <label class="form-check-label" for="rbtn_search_type8">
                      Certificate Number
                    </label>
                  </div>
                </div>
              </div>
              
              <!-- Search Input -->
              <div class="row g-3 align-items-end">
                <div class="col-md-8">
                  <div class="form-group">
                    <label for="link_search_value_" class="form-label fw-medium">
                      <i class="fas fa-keyboard me-1"></i>
                      Search Value
                    </label>
                    <div class="input-group">
                      <span class="input-group-text">
                        <i class="fas fa-search"></i>
                      </span>
                      <input class="form-control" id="link_search_value_" name="link_search_value_" 
                             type="text" placeholder="Enter job number or certificate number" required>
                    </div>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <button type="submit" class="btn btn-primary w-100" id="btnEnquiryJobSearch">
                      <i class="fas fa-search me-2"></i>
                      Search
                    </button>
                  </div>
                </div>
              </div>
              
              <div class="form-text">
                Enter the job number or certificate number to search for mother file
              </div>
            </form>
          </div>
        </div>
        
        <!-- Search Results Card -->
        <div class="card border-success mt-4" style="display:none" id="link-search-results-section_">
          <div class="card-header bg-success bg-opacity-10 text-success">
            <div class="d-flex justify-content-between align-items-center">
              <h6 class="mb-0">
                <i class="fas fa-file-alt me-2"></i>
                Search Results
              </h6>
              <span class="badge bg-success" id="resultsCount_">0 results</span>
            </div>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-hover table-striped" id="link-search-results-table_">
                <thead class="table-light">
                  <tr>
                    <th width="25%">
                      <!-- <i class="fas fa-user me-1"></i> -->
                      Applicant Name
                    </th>
                    <th width="30%">
                      <!-- <i class="fas fa-certificate me-1"></i> -->
                      Certificate Number
                    </th>
                    <th width="15%">
                      <!-- <i class="fas fa-hashtag me-1"></i> -->
                      Job Number
                    </th>
                    <th width="20%">
                      <!-- <i class="fas fa-map-marker-alt me-1"></i> -->
                      Locality
                    </th>
                    <th width="10%" class="text-end">
                      <!-- <i class="fas fa-cogs me-1"></i> -->
                      Actions
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <!-- Results will be populated here -->
                </tbody>
              </table>
            </div>
            
            <!-- No Results Message -->
            <div id="noResultsMessage_" class="text-center py-5 d-none">
              <div class="mb-3">
                <i class="fas fa-file-excel fa-3x text-muted"></i>
              </div>
              <h6 class="text-muted">No Mother Files Found</h6>
              <p class="text-muted small">Try searching with a different job number or certificate number</p>
            </div>
            
            <!-- Loading State -->
            <div id="loadingResults_" class="text-center py-5 d-none">
              <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
              <p class="mt-3 text-muted">Searching for mother files...</p>
            </div>
            
          </div>
        </div>
        
        <div class="card mt-2">
            <div class="card-header bg-primary bg-opacity-10 text-primary">
                <h6 class="mb-0">
                    <i class="fas fa-link me-2"></i>
                    Link Application to Mother File
                </h6>
            </div>
            <div class="card-body">
                
                <!-- Search Type Selection -->
                <div class="mb-4">
                    <label class="form-label fw-medium mb-3">
                        <i class="fas fa-filter me-1"></i>
                        Search By:
                    </label>
                    <div class="d-flex flex-wrap gap-3">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                id="rbtn_search_type5" value="job_number" required>
                            <label class="form-check-label" for="rbtn_search_type5">
                                Job Number
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="rbtn_search_type" 
                                id="rbtn_search_type6" value="certificate_number" required>
                            <label class="form-check-label" for="rbtn_search_type6">
                                Certificate Number
                            </label>
                        </div>
                    </div>
                </div>
                
                <!-- Search Input and Button -->
                <div class="row g-3 align-items-end">
                    <div class="col-md-8">
                        <div class="form-group">
                            <label for="lrd_search_for_mother_transction_to_child" class="form-label fw-medium">
                                <i class="fas fa-search me-1"></i>
                                Search Value
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-file-contract"></i>
                                </span>
                                <input class="form-control bg-light" id="lrd_search_for_mother_transction_to_child" 
                                    name="lrd_search_for_mother_transction_to_child" type="text"  style="cursor: not-allowed;"
                                    placeholder="Enter Job Number or Certificate Number of the Mother File" readonly required>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <button type="button" class="btn btn-primary w-100" 
                                    id="lrd_btn_search_for_mother_transction_to_child"
                                    data-bs-toggle="tooltip" data-bs-placement="top" title="Search and Link">
                                <i class="fas fa-link me-2"></i>
                                Link Application
                            </button>
                        </div>
                    </div>
                    <div class="form-text">
                        Enter the Job Number or Certificate Number of the mother file to link
                    </div>
                </div>
                
                <!-- Optional: Information Alert -->
                <div class="alert alert-info bg-info bg-opacity-10 border-info mt-4">
                    <div class="d-flex">
                        <i class="fas fa-info-circle me-3 mt-1"></i>
                        <div>
                            <strong>About Linking:</strong>
                            <p class="mb-0 mt-2">
                                Linking applications to mother files creates a relationship between the current application 
                                and existing mother file records for reference and tracking purposes.
                            </p>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="determining_type_of_transfer" tabindex="-1"
     aria-labelledby="determiningTypeOfTransferLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="determiningTypeOfTransferLabel">
          <i class="fas fa-exchange-alt me-2"></i>
          Determine Type of Transfer
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Information Alert -->
        <div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>Transfer Type Determination</strong>
              <p class="mb-0 mt-2">Select the extent of land and interest to determine the appropriate transfer type.</p>
            </div>
          </div>
        </div>
        
        <!-- Form Content -->
        <form id="transferTypeForm">
          
          <!-- Extent Land -->
          <div class="mb-4">
            <label for="lc_intended_parcel" class="form-label fw-medium">
              <i class="fas fa-map me-1"></i>
              Extent of Land
            </label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="fas fa-mountain"></i>
              </span>
              <select name="lc_intended_parcel" id="lc_intended_parcel" 
                      class="form-select" required>
                <option ${empty fn:trim(intended_parcel) ? 'selected disabled' : ''}>-- Select Extent of Land --</option>
                <option value="Whole Parcel" ${intended_parcel == 'Whole Parcel' ? 'selected' : ''}>Whole Parcel</option>
                <option value="Part of parcel" ${intended_parcel == 'Part of parcel' ? 'selected' : ''}>Part of Parcel</option>
              </select>
            </div>
            <div class="form-text">
              <i class="fas fa-question-circle me-1"></i>
              Select whether the transfer involves the entire parcel or only a portion
            </div>
          </div>
          
          <!-- Extent Interest -->
          <div class="mb-4">
            <label for="lc_intended_interest" class="form-label fw-medium">
              <i class="fas fa-handshake me-1"></i>
              Extent of Interest
            </label>
            <div class="input-group">
              <span class="input-group-text">
                <i class="fas fa-percentage"></i>
              </span>
              <select name="lc_intended_interest" id="lc_intended_interest" 
                      class="form-select" required>
                <option ${empty fn:trim(intended_interest) ? 'selected disabled' : ''}>-- Select Extent of Interest --</option>
                <option value="Whole Interest" ${intended_interest == 'Whole Interest' ? 'selected' : ''}>Whole Interest</option>
                <option value="Part of Interest" ${intended_interest == 'Part of Interest' ? 'selected' : ''}>Part of Interest</option>
              </select>
            </div>
            <div class="form-text">
              <i class="fas fa-question-circle me-1"></i>
              Select whether the transfer involves the entire interest or only a portion
            </div>
          </div>
          
          <!-- Submit Button -->
          <div class="mt-4">
            <button type="button" id="lc_btn_determine_type_of_transfer" 
                    class="btn btn-primary w-100 py-3">
              <i class="fas fa-calculator me-2"></i>
              Determine Transfer Type
            </button>
          </div>
          
          <!-- Result Display (Optional) -->
          <!-- 
          <div class="alert alert-success mt-3 d-none" id="transferTypeResult">
            <div class="d-flex align-items-center">
              <i class="fas fa-check-circle me-3"></i>
              <div>
                <strong>Determined Transfer Type:</strong>
                <span id="calculatedTransferType" class="fw-bold ms-2"></span>
              </div>
            </div>
          </div>
          -->
          
        </form>
        
        <!-- Explanation Section -->
        <div class="alert alert-light border mt-4">
          <h6 class="mb-3">
            <i class="fas fa-lightbulb text-warning me-2"></i>
            Understanding Transfer Types
          </h6>
          <div class="row g-3">
            <div class="col-md-6">
              <div class="d-flex align-items-start mb-2">
                <i class="fas fa-check text-success me-2 mt-1"></i>
                <div>
                  <strong>Whole Parcel</strong>
                  <p class="small text-muted mb-0">Transfer of entire land parcel</p>
                </div>
              </div>
              <div class="d-flex align-items-start mb-2">
                <i class="fas fa-check text-success me-2 mt-1"></i>
                <div>
                  <strong>Part of Parcel</strong>
                  <p class="small text-muted mb-0">Transfer of only a portion of land</p>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="d-flex align-items-start mb-2">
                <i class="fas fa-check text-success me-2 mt-1"></i>
                <div>
                  <strong>Whole Interest</strong>
                  <p class="small text-muted mb-0">Transfer of complete ownership rights</p>
                </div>
              </div>
              <div class="d-flex align-items-start mb-2">
                <i class="fas fa-check text-success me-2 mt-1"></i>
                <div>
                  <strong>Part of Interest</strong>
                  <p class="small text-muted mb-0">Transfer of partial ownership rights</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="generate_certificate_number" tabindex="-1"
     aria-labelledby="generateCertificateNumberLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="generateCertificateNumberLabel">
          <i class="fas fa-hashtag me-2"></i>
          Generate Certificate Number
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Information Alert -->
        <div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>Certificate Number Generation</strong>
              <p class="mb-0 mt-2">Select certificate type to generate a unique certificate number.</p>
            </div>
          </div>
        </div>
        
        <!-- Certificate Type Selection -->
        <div class="mb-4">
          <label for="lc_txt_type_of_certificate" class="form-label fw-medium">
            <i class="fas fa-certificate me-1"></i>
            Certificate Type
          </label>
          <div class="input-group">
            <span class="input-group-text">
              <i class="fas fa-file-alt"></i>
            </span>
            <select name="lc_txt_type_of_certificate" id="lc_txt_type_of_certificate" 
                    class="form-select" required>
              <option ${certificate_type == 'Individual' ? 'selected disabled' : empty fn:trim(certificate_type) ? 'selected disabled' : ''}>-- Select Certificate Type --</option>
              <option value="Provisional Certificate" ${certificate_type == 'Provisional Certificate' ? 'selected' : ''}>Provisional Certificate</option>
              <option value="Land Certificate" ${certificate_type == 'Land Certificate' ? 'selected' : ''}>Land Certificate</option>
              <option value="Substituted Certificate" ${certificate_type == 'Substituted Certificate' ? 'selected' : ''}>Substituted Certificate</option>
            </select>
          </div>
          <div class="form-text">
            <i class="fas fa-question-circle me-1"></i>
            Select the type of certificate to generate a number for
          </div>
        </div>
        
        <!-- Generated Certificate Number -->
        <div class="mb-4">
          <label class="form-label fw-medium">
            <i class="fas fa-hashtag me-1"></i>
            Certificate Number
          </label>
          <div class="input-group">
            <span class="input-group-text bg-light">
              <i class="fas fa-tag"></i>
            </span>
            <input type="text" class="form-control bg-light" 
                   id="lc_txt_certificate_number" readonly 
                   value="${certificate_number}"
                   placeholder="Will be generated after selection">
          </div>
          <div class="form-text">
            <i class="fas fa-lock me-1"></i>
            Auto-generated certificate number based on selected type
          </div>
        </div>
        
        <!-- Generate Button -->
        <div class="mt-4">
          <button type="button" id="lc_btn_generate_certificate_number_only" 
                  class="btn btn-primary w-100 py-3"
                  ${not empty certificate_number and certificate_number != 'null' and not fn:contains(certificate_number, '-') ? 'disabled' : ''}>
            <i class="fas fa-magic me-2"></i>
            Generate Certificate Number
          </button>
          <div class="form-text mt-2 text-center">
            <c:if test="${not empty certificate_number and certificate_number != 'null' and not fn:contains(certificate_number, '-')}">
              <i class="fas fa-check-circle text-success me-1"></i>
              <span class="text-success">Certificate number already generated</span>
            </c:if>
            <c:if test="${empty certificate_number or certificate_number == 'null' or fn:contains(certificate_number, '-')}">
              <i class="fas fa-lightbulb text-warning me-1"></i>
              <span class="text-warning">Click to generate a new certificate number</span>
            </c:if>
          </div>
        </div>
        
        <!-- Certificate Types Explanation -->
        <div class="alert alert-light border mt-4">
          <h6 class="mb-3">
            <i class="fas fa-lightbulb text-primary me-2"></i>
            Certificate Types Explained
          </h6>
          <div class="row g-3">
            <div class="col-md-4">
              <div class="text-center p-2">
                <i class="fas fa-clock fa-2x text-warning mb-2"></i>
                <div class="small fw-bold">Provisional</div>
                <small class="text-muted">Temporary certificate</small>
              </div>
            </div>
            <div class="col-md-4">
              <div class="text-center p-2">
                <i class="fas fa-landmark fa-2x text-success mb-2"></i>
                <div class="small fw-bold">Land Certificate</div>
                <small class="text-muted">Permanent land title</small>
              </div>
            </div>
            <div class="col-md-4">
              <div class="text-center p-2">
                <i class="fas fa-exchange-alt fa-2x text-info mb-2"></i>
                <div class="small fw-bold">Substituted</div>
                <small class="text-muted">Replacement certificate</small>
              </div>
            </div>
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="generate_volume_and_folio" tabindex="-1"
     aria-labelledby="generateVolumeFolioLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="generateVolumeFolioLabel">
          <i class="fas fa-book-open me-2"></i>
          Generate Volume and Folio
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Information Alert -->
        <div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>Volume and Folio Numbers</strong>
              <p class="mb-0 mt-2">Generate unique volume and folio numbers for registry referencing.</p>
            </div>
          </div>
        </div>
        
        <!-- Volume Number -->
        <div class="mb-4">
          <label for="lc_txt_volume_number" class="form-label fw-medium">
            <i class="fas fa-book me-1"></i>
            Volume Number
          </label>
          <div class="input-group">
            <span class="input-group-text bg-light">
              <i class="fas fa-hashtag"></i>
            </span>
            <input type="text" class="form-control bg-light" 
                   id="lc_txt_volume_number" readonly 
                   value="${volume_number}"
                   placeholder="Will be generated">
          </div>
          <div class="form-text">
            <i class="fas fa-layer-group me-1"></i>
            Registry volume number for physical file organization
          </div>
        </div>
        
        <!-- Folio Number -->
        <div class="mb-4">
          <label for="lc_txt_folio_number" class="form-label fw-medium">
            <i class="fas fa-file-alt me-1"></i>
            Folio Number
          </label>
          <div class="input-group">
            <span class="input-group-text bg-light">
              <i class="fas fa-list-ol"></i>
            </span>
            <input type="text" class="form-control bg-light" 
                   id="lc_txt_folio_number" readonly 
                   value="${folio_number}"
                   placeholder="Will be generated">
          </div>
          <div class="form-text">
            <i class="fas fa-file me-1"></i>
            Page or file number within the registry volume
          </div>
        </div>
        
        <!-- Generate Button -->
        <div class="mt-4">
          <button type="button" id="lc_btn_generate_volume_folio_number_only" 
                  class="btn btn-primary w-100 py-3"
                  ${not empty volume_number and volume_number != 'null' and not fn:contains(volume_number, '-') ? 'disabled' : ''}>
            <i class="fas fa-gears me-2"></i>
            Generate Volume & Folio
          </button>
          <div class="form-text mt-2 text-center">
            <c:choose>
              <c:when test="${not empty volume_number and volume_number != 'null' and not fn:contains(volume_number, '-')}">
                <i class="fas fa-check-circle text-success me-1"></i>
                <span class="text-success">Volume and folio numbers already generated</span>
              </c:when>
              <c:otherwise>
                <i class="fas fa-lightbulb text-warning me-1"></i>
                <span class="text-warning">Click to generate new volume and folio numbers</span>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
        
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="enter_encumbrance_transaction_on_mother" tabindex="-1"
     aria-labelledby="encumbranceTransactionModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-xl">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="encumbranceTransactionModalLabel">
          <i class="fas fa-file-contract me-2"></i>
          Encumbrance Transactions on Mother File
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Header with Add Button -->
        <div class="d-flex justify-content-between align-items-center mb-4">
          <div>
            <h6 class="mb-0">
              <i class="fas fa-list-ul me-2 text-danger"></i>
              Encumbrance Records
            </h6>
            <small class="text-muted">List of all encumbrance transactions on the mother file</small>
          </div>
          <button type="button" class="btn btn-danger newEncumberancesModalonMother" 
                  data-bs-toggle="tooltip" data-bs-placement="top" title="Add New Encumbrance">
            <i class="fas fa-plus-circle me-2"></i>
            Add Encumbrance
          </button>
        </div>
        
        <!-- Table -->
        <div class="table-responsive">
          <table class="table table-hover table-sm" id="lrd_encumberance_details_dataTable">
            <thead class="table-light">
              <tr>
                <th width="15%">
                  <i class="fas fa-hashtag me-1"></i>
                  Registered No.
                </th>
                <th width="15%">
                  <i class="fas fa-calendar-alt me-1"></i>
                  Date of Instrument
                </th>
                <th width="15%">
                  <i class="fas fa-calendar-check me-1"></i>
                  Date of Registration
                </th>
                <th width="40%">
                  <i class="fas fa-file-alt me-1"></i>
                  Memorials
                </th>
                <!-- <th width="15%">
                  <i class="fas fa-sticky-note me-1"></i>
                  Remarks
                </th> -->
                <th width="10%">
                  <i class="fas fa-list-ol me-1"></i>
                  Entry No.
                </th>
                <th width="5%" class="text-center">
                  <i class="fas fa-cog me-1"></i>
                  Actions
                </th>
              </tr>
            </thead>
            <tbody>
              <!-- Data will be populated here -->
            </tbody>
          </table>
        </div>
        
        <!-- Empty State -->
        <div class="text-center py-5" id="noEncumbrancesMc">
          <div class="mb-3">
            <i class="fas fa-file-contract fa-3x text-muted"></i>
          </div>
          <h6 class="text-muted mb-2">No Encumbrance Records Found</h6>
          <p class="text-muted small">Click "Add Encumbrance" to create new encumbrance transactions</p>
        </div>
        
        <!-- Loading State -->
        <div class="text-center py-5 d-none" id="loadingEncumbrances">
          <div class="spinner-border text-danger" role="status">
            <span class="visually-hidden">Loading...</span>
          </div>
          <p class="mt-3 text-muted">Loading encumbrance records...</p>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="verify_transaction_on_mother" tabindex="-1"
     aria-labelledby="verifyTransactionModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="verifyTransactionModalLabel">
          <i class="fas fa-check-circle me-2"></i>
          Verify Transaction on Mother File
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        
        <!-- Information Alert -->
        <div class="alert alert-info bg-info bg-opacity-10 border-info mb-4">
          <div class="d-flex">
            <i class="fas fa-info-circle me-3 mt-1"></i>
            <div>
              <strong>Linked Transactions Verification</strong>
              <p class="mb-0 mt-2">View and verify all transactions linked to this mother file.</p>
            </div>
          </div>
        </div>
        
        <!-- Table -->
        <div class="table-responsive">
          <table class="table table-hover table-sm" id="linkdetails_dataTable">
            <thead class="table-light">
              <tr>
                <th width="20%">
                  <i class="fas fa-hashtag me-1"></i>
                  Job Number
                </th>
                <th width="20%">
                  <i class="fas fa-file-alt me-1"></i>
                  Case Number
                </th>
                <th width="25%">
                  <i class="fas fa-link me-1"></i>
                  Relationship Type
                </th>
                <th width="20%">
                  <i class="fas fa-calendar me-1"></i>
                  Date Linked
                </th>
                <th width="15%" class="text-center">
                  <i class="fas fa-cog me-1"></i>
                  Actions
                </th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${mother_to_child_link_list}" var="mother_to_child_link_row">
                <tr>
                  <td>
                    <span class="badge bg-primary bg-opacity-10 text-primary">
                      ${mother_to_child_link_row.job_number}
                    </span>
                  </td>
                  <td>
                    <span class="fw-medium">${mother_to_child_link_row.mc_case_number}</span>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${mother_to_child_link_row.mc_type_of_relationship == 'Mother-Child'}">
                        <span class="badge bg-success">
                          <i class="fas fa-link me-1"></i>
                          ${mother_to_child_link_row.mc_type_of_relationship}
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-info">
                          ${mother_to_child_link_row.mc_type_of_relationship}
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <div class="small text-muted">
                      <i class="fas fa-clock me-1"></i>
                      ${mother_to_child_link_row.created_date}
                    </div>
                  </td>
                  <td class="text-center">
                    <button type="button" class="btn btn-outline-primary btn-sm btn-view-mother-Child-details"
                            data-job_number="${mother_to_child_link_row.mc_job_number}"
                            data-case_number="${mother_to_child_link_row.mc_case_number}"
                            data-transaction_number="[0, 0]"
                            business_process_sub_name="-"
                            data-bs-toggle="modal"
                            data-bs-target="#transitional_certificate_template"
                            data-bs-toggle="tooltip"
                            data-bs-placement="top"
                            title="View Full Case Details">
                      <i class="fas fa-eye me-1"></i>
                      View
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        
        <!-- Empty State -->
        <c:if test="${empty mother_to_child_link_list}">
          <div class="text-center py-5">
            <div class="mb-3">
              <i class="fas fa-search fa-3x text-muted"></i>
            </div>
            <h6 class="text-muted mb-2">No Linked Transactions Found</h6>
            <p class="text-muted small">No transactions are currently linked to this mother file</p>
          </div>
        </c:if>
        
        <!-- Statistics (Optional) -->
        <c:if test="${not empty mother_to_child_link_list}">
          <div class="alert alert-light border mt-4">
            <div class="row g-3">
              <div class="col-md-4">
                <div class="text-center">
                  <div class="h4 fw-bold text-primary mb-1">${fn:length(mother_to_child_link_list)}</div>
                  <div class="small text-muted">Total Links</div>
                </div>
              </div>
              <div class="col-md-4">
                <div class="text-center">
                  <div class="h4 fw-bold text-success mb-1">
                    <c:set var="motherChildCount" value="0" />
                    <c:forEach items="${mother_to_child_link_list}" var="link">
                      <c:if test="${link.mc_type_of_relationship == 'Mother'}">
                        <c:set var="motherChildCount" value="${motherChildCount + 1}" />
                      </c:if>
                    </c:forEach>
                    ${motherChildCount}
                  </div>
                  <div class="small text-muted">Mother-Child Links</div>
                </div>
              </div>
              <div class="col-md-4">
                <div class="text-center">
                  <c:set var="latestDate" value="" />
                  <c:forEach items="${mother_to_child_link_list}" var="link">
                    <c:if test="${empty latestDate or link.created_date gt latestDate}">
                      <c:set var="latestDate" value="${link.created_date}" />
                    </c:if>
                  </c:forEach>
                  <div class="small text-muted">Last Linked</div>
                  <div class="small fw-medium">${latestDate}</div>
                </div>
              </div>
            </div>
          </div>
        </c:if>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="enter_mortgage_transaction" tabindex="-1"
     aria-labelledby="mortgageTransactionModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title text-white" id="mortgageTransactionModalLabel">
                    <i class="fas fa-file-contract me-2"></i>
                    Mortgage Transaction
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <!-- Modal Body -->
            <div class="modal-body">
                
                <!-- Header with Add Button -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h6 class="mb-0">
                            <i class="fas fa-list-alt me-2 text-primary"></i>
                            Memorial Records
                        </h6>
                        <small class="text-muted">Manage memorial transactions for mortgage processing</small>
                    </div>
                    <button type="button" class="btn btn-primary newMemorialsModal" 
                            id="getMCRegistered_no"
                            title="Add New Memorial">
                        <i class="fas fa-plus-circle me-2"></i>
                        Add Memorial
                    </button>
                </div>
                
                <!-- Table -->
                <div class="table-responsive">
                    <table class="table table-hover table-sm" id="lrd_memorial_details_dataTable_3">
                        <thead class="table-light">
                            <tr>
                                <th width="15%">
                                    <i class="fas fa-hashtag me-1"></i>
                                    Registered No.
                                </th>
                                <th width="30%">
                                    <i class="fas fa-file-alt me-1"></i>
                                    Memorials
                                </th>
                                <th width="15%">
                                    <i class="fas fa-calendar-alt me-1"></i>
                                    Date of Instrument
                                </th>
                                <th width="15%">
                                    <i class="fas fa-calendar-check me-1"></i>
                                    Date of Registration
                                </th>
                                <th width="10%">
                                    <i class="fas fa-list-ol me-1"></i>
                                    Entry No.
                                </th>
                                <th width="15%" class="text-center">
                                    <i class="fas fa-cog me-1"></i>
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${lrd_memorials_section}" var="memorials_section">
                                <tr>
                                    <td>
                                        <span class="badge bg-danger bg-opacity-10 text-danger">
                                            ${memorials_section.m_registered_no}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="text-truncate" style="max-width: 250px;">
                                            ${memorials_section.m_memorials}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="small">
                                            <i class="fas fa-calendar text-muted me-1"></i>
                                            ${memorials_section.m_date_of_instrument}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="small">
                                            <i class="fas fa-calendar-check text-muted me-1"></i>
                                            ${memorials_section.m_date_of_registration}
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary">${memorials_section.m_entry_number}</span>
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-outline-danger btn-sm editMemorialsModal"
                                                data-mid="${memorials_section.mid}"
                                                data-m_case_number="${memorials_section.m_case_number}"
                                                data-m_registered_no="${memorials_section.m_registered_no}"
                                                data-m_memorials="${memorials_section.m_memorials}"
                                                data-m_date_of_registration="${memorials_section.m_date_of_registration}"
                                                data-m_date_of_instrument="${memorials_section.m_date_of_instrument}"
                                                data-m_back="${memorials_section.m_back}"
                                                data-m_remarks="${memorials_section.m_remarks}"
                                                data-m_entry_number="${memorials_section.m_entry_number}"
                                                data-bs-toggle="tooltip"
                                                data-bs-placement="top"
                                                title="Edit Memorial">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Empty State -->
                <c:if test="${empty lrd_memorials_section}">
                    <div class="text-center py-5" id="noMemorialsMD">
                        <div class="mb-3">
                            <i class="fas fa-file-contract fa-3x text-muted"></i>
                        </div>
                        <h6 class="text-muted mb-2">No Memorial Records Found</h6>
                        <p class="text-muted small">Click "Add Memorial" to create new mortgage transaction records</p>
                    </div>
                </c:if>
                
                <!-- Information Alert -->
                <div class="alert alert-info bg-info bg-opacity-10 border-info mt-4">
                    <div class="d-flex">
                        <i class="fas fa-info-circle me-3 mt-1"></i>
                        <div>
                            <strong>About Mortgage Memorials:</strong>
                            <p class="mb-0 mt-2">
                                Memorials record the details of mortgage transactions including registration dates, 
                                instrument details, and entry numbers for legal documentation.
                            </p>
                        </div>
                    </div>
                </div>
                
            </div>
            
            <!-- Modal Footer -->
            <div class="modal-footer bg-light border-top">
                <div class="d-flex justify-content-between w-100">
                    <input type="hidden" id="lbl_transaction_id" name="lbl_transaction_id">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>
                        Close
                    </button>
                </div>
            </div>
            
        </div>
    </div>
</div>

<div class="modal fade effect-scale modal-blur" id="compose_mmemo" tabindex="-1"
     aria-labelledby="previewMemoModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title text-white" id="previewMemoModalLabel">
          <i class="fas fa-file-alt me-2"></i>
          Preview Memo
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body text-center p-5">
        
        <!-- Memo Icon -->
        <div class="mb-4">
          <div class="icon-circle bg-primary bg-opacity-10 text-primary mb-3 mx-auto" style="width: 80px; height: 80px; line-height: 80px;">
            <i class="fas fa-file-invoice fa-3x"></i>
          </div>
          <h5 class="mb-3">Memo Generation</h5>
          <p class="text-muted mb-4">
            Generate an official memo document for this transaction.
          </p>
        </div>
        
        <!-- Generate Memo Button -->
        <div class="mb-4">
          <button type="button" id="lc_btn_generate_memo_for_certificate_2" 
                  class="btn btn-primary btn-lg w-100 py-3 shadow-sm">
            <i class="fas fa-file-pdf me-2"></i>
            Generate Memo
          </button>
          <div class="form-text mt-2">
            <i class="fas fa-info-circle me-1"></i>
            Creates an official memo document in pdf format
          </div>
        </div>
        
      </div>
      
      <!-- Modal Footer -->
      <div class="modal-footer bg-light border-top">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="fas fa-times me-1"></i>
          Close
        </button>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade effect-scale modal-blur" id="check_review_application_documents" data-bs-backdrop="static" tabindex="-1" aria-labelledby="check_review_documents_label" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-info text-white">
                <div class="d-flex align-items-center">
                    <div class="avatar avatar-lg bg-white text-primary rounded-circle me-3">
                        <i class="bi bi-folder2-open fs-4"></i>
                    </div>
                    <div>
                        <h5 class="modal-title text-white mb-1" id="check_review_documents_label">
                            Review Documents (Application Documents)
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
                <div id="appDocumentsLoading" class="d-none mb-4">
                    <div class="d-flex align-items-center">
                        <div class="spinner-border spinner-border-sm text-primary me-2" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <small class="text-muted">Loading documents...</small>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="d-flex flex-wrap gap-2 mb-4">
                    <button type="button" class="btn btn-primary btn-sm" id="btn_load_scanned_documents_application_gated_workflow">
                        <i class="bi bi-eye me-1"></i> Load Documents
                    </button>
                    
                    <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" 
                            data-bs-target="#fileUploadModal">
                        <i class="bi bi-plus-circle me-1"></i> Add Documents
                    </button>
                    
                    <button type="button" class="btn btn-info btn-sm" id="btn_refresh_application_documents">
                        <i class="bi bi-arrow-clockwise me-1"></i> Refresh
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
                    <table class="table table-hover table-sm mb-0" id="lc_application_documents_dataTable_gated_workflow">
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
                        <tbody id="appDocumentsTableBody_gated_workflow">
                            
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i> Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
