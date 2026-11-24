<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
/* ELIS Ground Rent Payments — scoped emerald theme */
.elis-rent-payments{--erp-dark:#064b39;--erp-green:#087f5b;--erp-bright:#0ba26f;--erp-mint:#e8f7ee;--erp-border:#d8e9df;--erp-text:#173b2e;color:var(--erp-text)}
.elis-rent-payments .erp-hero{background:linear-gradient(115deg,#064b39,#087f5b 70%,#31a477);border-radius:17px;padding:24px 28px;color:#fff;box-shadow:0 10px 28px rgba(6,75,57,.16)}
.elis-rent-payments .erp-hero h1{font-size:24px;font-weight:800;color:#fff;margin:5px 0}.elis-rent-payments .erp-hero p{color:#d8f8e7;margin:0;font-size:13px}.elis-rent-payments .erp-eyebrow{color:#bdf2d4;font-size:11px;font-weight:800;letter-spacing:1.2px}
.elis-rent-payments .erp-hero .breadcrumb-item,.elis-rent-payments .erp-hero .breadcrumb-item a{color:#e6fff0!important}.elis-rent-payments .erp-hero .breadcrumb-item+.breadcrumb-item::before{color:#bdf2d4}
.elis-rent-payments .transaction-report-card,.elis-rent-payments .stat-card{background:#fff;border:1px solid var(--erp-border)!important;border-radius:15px;overflow:hidden;box-shadow:0 5px 20px rgba(6,75,57,.07);transition:box-shadow .2s,transform .2s}
.elis-rent-payments .transaction-report-card:hover,.elis-rent-payments .stat-card:hover{box-shadow:0 9px 26px rgba(6,75,57,.12);transform:translateY(-2px)}
.elis-rent-payments .erp-card-header,.elis-rent-payments .card-header-dark{background:linear-gradient(110deg,#064b39,#0b9064)!important;border:0;padding:17px 20px;color:#fff}.elis-rent-payments .erp-card-header h5,.elis-rent-payments .card-header-dark h5{color:#fff!important;font-size:15px;font-weight:800}
.elis-rent-payments .erp-filter-description{color:#d8f8e7;font-size:12px;margin:4px 0 0}.elis-rent-payments .form-label{font-size:12px;font-weight:750;color:#365d49;margin-bottom:7px}
.elis-rent-payments .form-control,.elis-rent-payments .form-select{border:1px solid #cfe4d7;border-radius:9px;min-height:43px;font-size:13px;color:#214b35}.elis-rent-payments .form-control:focus,.elis-rent-payments .form-select:focus{border-color:#0b9469;box-shadow:0 0 0 .2rem rgba(11,148,105,.12)}
.elis-rent-payments .input-group-text{background:#f0faf3;border:1px solid #cfe4d7;color:#087f5b;border-radius:9px 0 0 9px}.elis-rent-payments .input-group .form-control{border-radius:0 9px 9px 0}
.elis-rent-payments .erp-btn{border-radius:9px;font-weight:750;font-size:13px;padding:10px 15px;transition:background .2s,transform .2s}.elis-rent-payments .erp-btn-primary,.elis-rent-payments .btn-primary{background:linear-gradient(110deg,#087f5b,#0ba26f)!important;border-color:#087f5b!important;color:#fff!important}.elis-rent-payments .erp-btn-primary:hover,.elis-rent-payments .btn-primary:hover{background:#065c44!important;transform:translateY(-1px)}
.elis-rent-payments .stat-card{border-left:4px solid #087f5b!important}.elis-rent-payments .stat-card.border-success{border-left-color:#31a477!important}.elis-rent-payments .stats-icon{width:52px;height:52px;border-radius:13px;display:flex;align-items:center;justify-content:center;flex:none;background:#e8f7ee!important;color:#087f5b!important}.elis-rent-payments .stat-card.border-success .stats-icon{background:#e1f5e9!important;color:#0b9064!important}
.elis-rent-payments .erp-stat-label{font-size:12px;color:#698475;font-weight:750}.elis-rent-payments .erp-stat-number{color:#064b39!important;font-size:clamp(18px,2vw,25px);overflow-wrap:anywhere}.elis-rent-payments .erp-stat-number.success{color:#087f5b!important}
.elis-rent-payments .erp-table-scroll{overflow:auto}.elis-rent-payments #tbl_transactions_result{font-size:12px;white-space:nowrap;width:100%}.elis-rent-payments #tbl_transactions_result thead th{background:linear-gradient(110deg,#07543f,#0b9064);color:#fff;border:0;padding:14px 12px;font-weight:750}.elis-rent-payments #tbl_transactions_result tbody td{padding:12px;border-bottom:1px solid #e4eee7;vertical-align:middle}.elis-rent-payments #tbl_transactions_result tbody tr:nth-child(even){background:#f7fcf9}.elis-rent-payments #tbl_transactions_result tbody tr:hover{background:#eaf7ef}.elis-rent-payments #tbl_transactions_result tbody tr.table-success{background:#e2f5e8!important}
.elis-rent-payments .erp-payment-badge{background:#e8f7ed!important;color:#07543f!important;border:1px solid #cce8d6;font-size:11px;font-weight:750;border-radius:50px;padding:7px 11px}.elis-rent-payments .status-badge{min-width:105px;display:inline-flex;justify-content:center;align-items:center;border-radius:50px;font-size:11px;font-weight:750;padding:7px 11px}.elis-rent-payments .erp-status-pending{background:#fff1e1!important;color:#a66b0b!important}.elis-rent-payments .erp-status-recorded{background:#e4f7eb!important;color:#087f5b!important}
.elis-rent-payments .set_as_recorded{white-space:nowrap;border-radius:8px;font-size:12px;font-weight:750;padding:8px 12px}.elis-rent-payments .erp-note{background:#f1faf5;border:1px solid #d8e9df;border-radius:10px;color:#587667;font-size:12px;padding:12px 14px}
.elis-rent-payments #tbl_transactions_result_wrapper .dt-buttons{display:flex;flex-wrap:wrap;gap:7px;margin-bottom:12px}.elis-rent-payments #tbl_transactions_result_wrapper .dt-button{background:#e8f7ee;border:1px solid #bce2ca;color:#07543f;border-radius:8px;padding:7px 11px}.elis-rent-payments #tbl_transactions_result_wrapper .dataTables_filter input{border:1px solid #cfe4d7;border-radius:8px;padding:7px}.elis-rent-payments #tbl_transactions_result_wrapper .paginate_button.current{background:#087f5b!important;color:#fff!important;border-color:#087f5b!important}
@media(max-width:767px){.elis-rent-payments .erp-hero{padding:18px}.elis-rent-payments .erp-hero h1{font-size:20px}.elis-rent-payments .stat-card{margin-bottom:12px}}
</style>

<div class="main-content app-content elis-rent-payments">
 <div class="container-fluid page-container">
  <div class="erp-hero mb-4">
   <div class="d-flex align-items-center justify-content-between gap-3 flex-wrap">
    <div><div class="erp-eyebrow"><i class="ri-government-line me-1"></i> ELIS / GROUND RENT MANAGEMENT</div>
     <h1><i class="ri-home-4-line me-2"></i>Ground Rent Payments</h1>
     <p>Review ground rent payments, verify payment records and track ledger update status.</p>
    </div>
    <ol class="breadcrumb mb-0"><li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li><li class="breadcrumb-item active" aria-current="page">Ground Rent Payments</li></ol>
   </div>
  </div>

  <div id="acct_graph_data_values" style="display:none">${data}</div>
  <div class="row g-3">
   <div class="col-lg-3 mb-4">
    <div class="card transaction-report-card filter-card h-100">
     <div class="card-header erp-card-header"><h5 class="mb-0"><i class="ri-filter-3-line me-2"></i>Filter Payments</h5><p class="erp-filter-description">Select a date range to retrieve transactions.</p></div>
     <div class="card-body p-4">
      <form method="post">
       <div class="mb-3"><label class="form-label" for="t_date_from">Date From</label><div class="input-group"><span class="input-group-text"><i class="ri-calendar-line"></i></span><input type="date" class="form-control form-control-sm" name="t_date_from" id="t_date_from" value="<c:out value='${t_date_from}'/>"></div></div>
       <div class="mb-3"><label class="form-label" for="t_date_to">Date To</label><div class="input-group"><span class="input-group-text"><i class="ri-calendar-line"></i></span><input type="date" class="form-control form-control-sm" name="t_date_to" id="t_date_to" value="<c:out value='${t_date_to}'/>"></div></div>
       <div class="d-grid mt-4"><button type="submit" name="transactions_form" value="1" class="btn erp-btn erp-btn-primary"><i class="ri-search-line me-2"></i>Apply Filter</button></div>
      </form>
      <div class="erp-note mt-4"><i class="ri-information-line me-1"></i>Use the date filters to review payment records and identify transactions not yet updated.</div>
     </div>
    </div>
   </div>

   <div class="col-lg-9">
    <div class="row g-3 mb-4">
     <div class="col-md-6"><div class="card stat-card border-primary h-100"><div class="card-body p-4"><div class="d-flex align-items-center gap-3"><div class="stats-icon"><i class="ri-money-dollar-circle-line fs-3"></i></div><div class="flex-grow-1"><div class="erp-stat-label mb-1">Total Amount</div><h3 class="fw-bold erp-stat-number mb-0">GHS <fmt:formatNumber type="number" maxFractionDigits="3" minFractionDigits="2" value="${t_total_amount}" /></h3></div></div></div></div></div>
     <div class="col-md-6"><div class="card stat-card border-success h-100"><div class="card-body p-4"><div class="d-flex align-items-center gap-3"><div class="stats-icon"><i class="ri-file-list-3-line fs-3"></i></div><div class="flex-grow-1"><div class="erp-stat-label mb-1">Total Payment Count</div><h3 class="fw-bold erp-stat-number success mb-0"><fmt:formatNumber type="number" maxFractionDigits="2" value="${t_total_count}" /></h3></div></div></div></div></div>
    </div>
    <div class="card transaction-report-card mb-4">
     <div class="card-header card-header-dark d-flex align-items-center justify-content-between gap-2 flex-wrap"><div><h5 class="mb-0"><i class="ri-list-check-2 me-2"></i>Ground Rent Payments List</h5><p class="erp-filter-description">Review transaction details and ledger update status.</p></div><button class="btn btn-sm btn-outline-light" title="Toggle fullscreen" type="button"><i class="ri-fullscreen-line"></i></button></div>
     <div class="card-body p-3 p-md-4"><div class="erp-table-scroll table-responsive">
      <table class="table table-hover data-table mb-0" id="tbl_transactions_result">
       <thead><tr><th>Bill Number</th><th>Bill Date</th><th>Payment Date</th><th>Bill Amount</th><th>Payment Amount</th><th>Payment Slip Number</th><th>Invoice Number</th><th>Payment Mode</th><th>Plot Details</th><th>Updated Status</th><th>Action</th></tr></thead>
       <tbody>
        <c:forEach items="${t_applicationlist}" var="row">
         <tr <c:if test="${fn:contains(row.is_sync, '1')}">class="tr-completed-work table-success"</c:if>>
          <td><c:out value="${row.ref_number}"/></td><td><c:out value="${row.created_date}"/></td><td><c:out value="${row.payment_date}"/></td><td><c:out value="${row.bill_amount}"/></td>
          <td class="fw-semibold" style="color:#087f5b"><c:out value="${row.payment_amount}"/></td><td><c:out value="${row.payment_slip_number}"/></td><td><c:out value="${row.gog_invoice_number}"/></td>
          <td><span class="badge erp-payment-badge"><c:out value="${row.payment_mode}"/></span></td><td><c:out value="${row.business_process_sub_name}"/></td>
          <td><c:if test="${fn:contains(row.is_sync, '1')}"><span class="badge status-badge erp-status-recorded"><i class="ri-checkbox-circle-line me-1"></i>Recorded</span></c:if><c:if test="${fn:contains(row.is_sync, '0')}"><span class="badge status-badge erp-status-pending"><i class="ri-time-line me-1"></i>Not Updated</span></c:if></td>
          <td><c:if test="${fn:contains(row.is_sync, '0')}"><button class="btn btn-primary btn-sm set_as_recorded" data-ref_number="<c:out value='${row.ref_number}'/>" type="button"><i class="ri-check-double-line me-1"></i>Set as Updated</button></c:if></td>
         </tr>
        </c:forEach>
       </tbody>
      </table>
     </div></div>
    </div>
   </div>
  </div>
 </div>
</div>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
 if (window.bootstrap && bootstrap.Tooltip) {
  document.querySelectorAll('.elis-rent-payments [data-bs-toggle="tooltip"]').forEach(function (el) { bootstrap.Tooltip.getOrCreateInstance(el); });
 }
});
</script>
