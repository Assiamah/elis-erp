<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
/* Scoped emerald theme: avoids changing unrelated ELIS pages */
.stamp-duty-page {
    --sd-deep: #064b39;
    --sd-dark: #075c43;
    --sd-primary: #087f5b;
    --sd-green: #0b9469;
    --sd-mint: #e8f7ee;
    --sd-pale: #f5fbf7;
    --sd-border: #d8e9df;
    --sd-ink: #193b2d;
    color: var(--sd-ink);
}
.stamp-duty-page .sd-hero {
    background: linear-gradient(115deg, #064b39 0%, #087f5b 60%, #13a474 100%);
    border-radius: 16px;
    padding: 23px 28px;
    box-shadow: 0 12px 30px rgba(6,75,57,.16);
    position: relative;
    overflow: hidden;
}
.stamp-duty-page .sd-hero::after {
    content: "";
    position: absolute;
    right: -65px;
    top: -105px;
    width: 260px;
    height: 260px;
    border: 44px solid rgba(255,255,255,.075);
    border-radius: 50%;
    pointer-events: none;
}
.stamp-duty-page .sd-hero .page-title,
.stamp-duty-page .sd-hero p,
.stamp-duty-page .sd-hero .breadcrumb-item,
.stamp-duty-page .sd-hero .breadcrumb-item a,
.stamp-duty-page .sd-hero .breadcrumb-item.active {
    color: #fff !important;
}
.stamp-duty-page .sd-hero p { opacity: .85; }
.stamp-duty-page .sd-hero .breadcrumb-item + .breadcrumb-item::before { color: rgba(255,255,255,.65); }
.stamp-duty-page .sd-hero .sd-heading-icon {
    display: inline-flex;
    width: 44px;
    height: 44px;
    align-items: center;
    justify-content: center;
    background: rgba(255,255,255,.15);
    border: 1px solid rgba(255,255,255,.22);
    border-radius: 12px;
    margin-right: 12px;
}
.stamp-duty-page .transaction-report-card,
.stamp-duty-page .stat-card {
    border: 1px solid var(--sd-border) !important;
    border-radius: 14px;
    overflow: hidden;
    box-shadow: 0 5px 20px rgba(6,75,57,.065);
    transition: box-shadow .2s ease, transform .2s ease;
    background: #fff;
}
.stamp-duty-page .transaction-report-card:hover,
.stamp-duty-page .stat-card:hover {
    box-shadow: 0 10px 26px rgba(6,75,57,.12);
    transform: translateY(-2px);
}
.stamp-duty-page .sd-panel-header,
.stamp-duty-page .card-header-dark {
    background: linear-gradient(110deg, var(--sd-deep), var(--sd-primary)) !important;
    color: #fff !important;
    border: 0;
    padding: 16px 20px;
}
.stamp-duty-page .sd-panel-header h5,
.stamp-duty-page .card-header-dark h5 { color: #fff !important; }
.stamp-duty-page .sd-panel-header i { color: #bff7d9; }
.stamp-duty-page .form-label { font-size: .875rem; font-weight: 650; color: #315447; margin-bottom: 7px; }
.stamp-duty-page .form-control,
.stamp-duty-page .form-select {
    border: 1px solid #cddfd5;
    border-radius: 9px;
    min-height: 41px;
    background-color: #fff;
    color: var(--sd-ink);
}
.stamp-duty-page .form-control:focus,
.stamp-duty-page .form-select:focus {
    border-color: var(--sd-green);
    box-shadow: 0 0 0 .2rem rgba(11,148,105,.14);
}
.stamp-duty-page .input-group-text {
    background: var(--sd-mint);
    color: var(--sd-primary);
    border: 1px solid #cddfd5;
    border-radius: 9px 0 0 9px;
}
.stamp-duty-page .input-group > .form-control,
.stamp-duty-page .input-group > .form-select { border-radius: 0 9px 9px 0; }
.stamp-duty-page .action-btn,
.stamp-duty-page .btn-primary {
    background: linear-gradient(110deg, var(--sd-primary), var(--sd-green)) !important;
    border-color: var(--sd-primary) !important;
    color: #fff !important;
    font-weight: 600;
    border-radius: 9px;
    padding: 10px 17px;
    transition: filter .2s ease, box-shadow .2s ease;
}
.stamp-duty-page .action-btn:hover,
.stamp-duty-page .btn-primary:hover { filter: brightness(.92); box-shadow: 0 5px 15px rgba(8,127,91,.22); }
.stamp-duty-page .stat-card { border-left: 5px solid var(--sd-primary) !important; }
.stamp-duty-page .stat-card.border-success { border-left-color: #19a873 !important; }
.stamp-duty-page .stats-icon {
    width: 56px;
    height: 56px;
    flex: 0 0 56px;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--sd-mint) !important;
    color: var(--sd-primary) !important;
}
.stamp-duty-page .stat-card.border-success .stats-icon { background: #ddf7e9 !important; color: #087f5b !important; }
.stamp-duty-page .stat-card h3 { color: var(--sd-deep) !important; font-size: clamp(1.3rem, 2.2vw, 1.85rem); overflow-wrap: anywhere; }
.stamp-duty-page .sd-subtitle { font-size: .8rem; color: #6d8377; }
.stamp-duty-page .data-table { width: 100%; border-collapse: separate; border-spacing: 0; }
.stamp-duty-page .data-table thead th {
    background: #e3f3e9 !important;
    color: var(--sd-deep) !important;
    border-bottom: 2px solid #a6d6bc !important;
    font-size: .79rem;
    font-weight: 700;
    padding: 13px 12px;
    white-space: nowrap;
}
.stamp-duty-page .data-table tbody td { padding: 12px; vertical-align: middle; border-bottom: 1px solid #e9f0eb; }
.stamp-duty-page .data-table tbody tr:nth-child(even) { background: #f8fcf9; }
.stamp-duty-page .data-table tbody tr:hover { background: #eaf8ef !important; }
.stamp-duty-page .sd-amount { color: var(--sd-primary) !important; font-weight: 700; white-space: nowrap; }
.stamp-duty-page .payment-badge {
    background: #e8f7ee !important;
    color: #087f5b !important;
    border: 1px solid #bfe6d0;
    border-radius: 7px;
    font-size: .82rem;
    font-weight: 600;
}
.stamp-duty-page .sd-job-badge {
    background: #f0f7f3 !important;
    color: #25684e !important;
    border: 1px solid #d6e9dd;
    border-radius: 7px;
    font-size: .82rem;
}
.stamp-duty-page #tbl_transactions_stp_result_wrapper .dt-buttons {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
    margin-bottom: 12px;
}
.stamp-duty-page #tbl_transactions_stp_result_wrapper .dt-button {
    background: #f0f9f3 !important;
    border: 1px solid #bddfca !important;
    border-radius: 7px !important;
    color: var(--sd-deep) !important;
    padding: 6px 11px !important;
    box-shadow: none !important;
}
.stamp-duty-page #tbl_transactions_stp_result_wrapper .dt-button:hover {
    background: #d9f1e3 !important;
    border-color: var(--sd-primary) !important;
}
.stamp-duty-page #tbl_transactions_stp_result_wrapper .dataTables_filter input,
.stamp-duty-page #tbl_transactions_stp_result_wrapper .dataTables_length select {
    border: 1px solid #cddfd5;
    border-radius: 7px;
    padding: 6px 9px;
    outline-color: var(--sd-primary);
}
.stamp-duty-page #tbl_transactions_stp_result_wrapper .paginate_button.current {
    background: var(--sd-primary) !important;
    color: #fff !important;
    border: 1px solid var(--sd-primary) !important;
    border-radius: 6px;
}
.stamp-duty-page .sd-fullscreen-btn { border-color: rgba(255,255,255,.7); color: #fff; }
.stamp-duty-page .sd-fullscreen-btn:hover { background: rgba(255,255,255,.16); color: #fff; }
@media (max-width: 767px) {
    .stamp-duty-page .sd-hero { padding: 18px; }
    .stamp-duty-page .sd-hero .breadcrumb { margin-top: 12px !important; }
    .stamp-duty-page .stat-card { margin-bottom: 12px; }
}
</style>

<div class="main-content app-content stamp-duty-page">
    <div class="container-fluid page-container">
        <div class="page-header-breadcrumb sd-hero mb-4">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                <div class="d-flex align-items-center">
                    <span class="sd-heading-icon"><i class="ri-stamp-line fs-24 text-white"></i></span>
                    <div>
                        <h1 class="page-title fw-semibold fs-20 mb-1">Stamp Duty Payments</h1>
                        <p class="fs-14 mb-0">Track and manage stamp duty payment transactions</p>
                    </div>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Stamp Duty Payments</li>
                </ol>
            </div>
        </div>

        <div id="acct_graph_data_values" style="display:none">${data}</div>

        <div class="row g-3">
            <div class="col-lg-3 mb-3">
                <div class="card transaction-report-card filter-card h-100">
                    <div class="card-header sd-panel-header">
                        <h5 class="mb-0 fw-semibold"><i class="ri-filter-line me-2"></i>Filter Options</h5>
                    </div>
                    <div class="card-body p-4">
                        <form method="post">
                            <div class="row g-3">
                                <div class="col-12">
                                    <label class="form-label" for="date_from">Date From</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="ri-calendar-line"></i></span>
                                        <input type="date" class="form-control form-control-sm" name="date_from" id="date_from" value="${date_from}">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <label class="form-label" for="date_to">Date To</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="ri-calendar-line"></i></span>
                                        <input type="date" class="form-control form-control-sm" name="date_to" id="date_to" value="${date_to}">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <label class="form-label" for="region_id">Region</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="ri-map-pin-line"></i></span>
                                        <select id="region_id" name="region_id" class="form-select form-control-sm" required>
                                            <option value="-1">-- select --</option>
                                            <c:forEach items="${officeregionlist}" var="officeregion">
                                                <option value="${fn:replace(officeregion.ord_region_code, '.0', '')}"
                                                        data-name="${officeregion.ord_region_name}"
                                                        ${fn:replace(region_id, '.0', '') == fn:replace(officeregion.ord_region_code, '.0', '') ? 'selected' : ''}>
                                                    ${officeregion.ord_region_name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="d-grid mt-4">
                                <button type="submit" class="btn btn-primary action-btn">
                                    <i class="ri-filter-3-line me-2"></i>Apply Filter
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <div class="card stat-card border-primary h-100">
                            <div class="card-body p-4">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon me-3"><i class="ri-money-dollar-circle-line fs-3"></i></div>
                                    <div class="flex-grow-1">
                                        <div class="sd-subtitle fw-semibold mb-1">TOTAL AMOUNT</div>
                                        <h3 class="fw-bold mb-0">GHS <fmt:formatNumber type="number" maxFractionDigits="3" minFractionDigits="2" value="${total_amount}" /></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card stat-card border-success h-100">
                            <div class="card-body p-4">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon me-3"><i class="ri-file-list-line fs-3"></i></div>
                                    <div class="flex-grow-1">
                                        <div class="sd-subtitle fw-semibold mb-1">TOTAL PAYMENT COUNT</div>
                                        <h3 class="fw-bold mb-0"><fmt:formatNumber type="number" maxFractionDigits="2" value="${total_count}" /></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card transaction-report-card mb-4" id="stamp-duty-table-card">
                    <div class="card-header card-header-dark d-flex justify-content-between align-items-center gap-2">
                        <h5 class="mb-0 fw-semibold text-white"><i class="ri-list-check me-2"></i>Stamp Duty Transactions List</h5>
                        <button class="btn btn-sm btn-outline-light sd-fullscreen-btn" title="Toggle fullscreen" type="button" id="stamp-duty-fullscreen-btn" aria-label="Toggle fullscreen">
                            <i class="ri-fullscreen-line"></i>
                        </button>
                    </div>
                    <div class="card-body p-3 p-md-4">
                        <div class="table-responsive">
                            <table class="table table-hover data-table" id="tbl_transactions_stp_result" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Bill Number</th>
                                        <th>Payment Ref</th>
                                        <th>Payment Date</th>
                                        <th>Applicant</th>
                                        <th>Amount</th>
                                        <th>Application Type</th>
                                        <th>Payment Mode</th>
                                        <th>Related Job</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${data}" var="rec">
                                        <tr>
                                            <td><c:out value="${rec.ref_number}" /></td>
                                            <td><c:out value="${rec.payment_slip_number}" /></td>
                                            <td><c:out value="${rec.payment_date}" /></td>
                                            <td><c:out value="${rec.lessees_name}" /></td>
                                            <td class="sd-amount">GHS <fmt:formatNumber type="number" maxFractionDigits="2" value="${rec.payment_amount}" /></td>
                                            <td><c:out value="${rec.business_process_sub_name}" /></td>
                                            <td><span class="badge px-3 py-2 payment-badge"><c:out value="${rec.payment_mode}" /></span></td>
                                            <td><span class="badge px-3 py-2 sd-job-badge"><c:out value="${rec.job_number}" /></span></td>
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

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
    if (window.bootstrap && bootstrap.Tooltip) {
        document.querySelectorAll('.stamp-duty-page [data-bs-toggle="tooltip"]').forEach(function (el) {
            bootstrap.Tooltip.getOrCreateInstance(el);
        });
    }

    if (window.jQuery && jQuery.fn.DataTable && !jQuery.fn.DataTable.isDataTable('#tbl_transactions_stp_result')) {
        var hasButtons = !!(jQuery.fn.dataTable && jQuery.fn.dataTable.Buttons);
        var options = {
            pageLength: 25,
            autoWidth: false,
            scrollX: true,
            order: [[2, 'desc']]
        };
        if (hasButtons) {
            options.dom = 'Bfrtip';
            options.buttons = ['pageLength', 'copy', 'csv', 'excel', 'pdf', 'print'];
        }
        jQuery('#tbl_transactions_stp_result').DataTable(options);
    }

    var fullscreenButton = document.getElementById('stamp-duty-fullscreen-btn');
    var fullscreenCard = document.getElementById('stamp-duty-table-card');
    if (fullscreenButton && fullscreenCard) {
        fullscreenButton.addEventListener('click', function () {
            if (!document.fullscreenElement && fullscreenCard.requestFullscreen) {
                fullscreenCard.requestFullscreen();
            } else if (document.fullscreenElement && document.exitFullscreen) {
                document.exitFullscreen();
            }
        });
    }
});
</script>
