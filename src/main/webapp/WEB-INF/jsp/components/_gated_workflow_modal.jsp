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
<div class="modal fade effect-scale modal-blur" id="check_for_payment" tabindex="-1" aria-labelledby="checkForPaymentLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content border-0 shadow-lg">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <div class="d-flex align-items-center">
                    <div class="avatar avatar-md bg-white text-primary rounded-circle me-3">
                        <i class="bi bi-credit-card fs-5"></i>
                    </div>
                    <div>
                        <h5 class="modal-title mb-0" id="checkForPaymentLabel">
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
                                                            data-bs-target="#viewBillModal"
                                                            data-egcr_id="${payment_bill_row.payment_slip_number}"
                                                            data-ref_number="${payment_bill_row.ref_number}"
                                                            data-bill_amount="${payment_bill_row.bill_amount}"
                                                            data-payment_amount="${payment_bill_row.payment_amount}"
                                                            data-payment_date="${payment_bill_row.payment_date}"
                                                            data-payment_mode="${payment_bill_row.payment_mode}"
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
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPaymentModal">
                                    <i class="bi bi-plus-circle me-1"></i>Add New Payment
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

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
                                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPaymentModal">
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