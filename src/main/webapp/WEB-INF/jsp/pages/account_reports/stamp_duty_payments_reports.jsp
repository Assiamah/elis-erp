<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
    .transaction-report-card {
        transition: all 0.3s ease;
        border: none;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .transaction-report-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1) !important;
    }

    .stat-card {
        border-left: 4px solid transparent;
        transition: all 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
    }

    .stat-card.border-warning { border-left-color: #ffc107; }
    .stat-card.border-info { border-left-color: #17a2b8; }
    .stat-card.border-primary { border-left-color: #667eea; }
    .stat-card.border-success { border-left-color: #28a745; }

    .form-control-sm {
        border-radius: 8px;
        border: 1px solid #dee2e6;
        padding: 0.5rem 0.75rem;
        font-size: 0.875rem;
    }

    .form-label {
        font-weight: 600;
        color: #495057;
        margin-bottom: 0.5rem;
        font-size: 0.875rem;
    }

    .action-btn {
        border-radius: 8px;
        padding: 0.5rem 1.5rem;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .action-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    .data-table {
        border-radius: 8px;
        overflow: hidden;
    }

    .data-table thead th {
        background-color: #f8f9fa;
        border-bottom: 2px solid #dee2e6;
        font-weight: 600;
        color: #495057;
        padding: 1rem;
    }

    .data-table tbody td {
        padding: 0.75rem 1rem;
        vertical-align: middle;
    }

    .stats-icon {
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
    }

    .stats-icon.bg-warning { background-color: rgba(255, 193, 7, 0.1); color: #ffc107; }
    .stats-icon.bg-info { background-color: rgba(23, 162, 184, 0.1); color: #17a2b8; }
    .stats-icon.bg-primary { background-color: rgba(102, 126, 234, 0.1); color: #667eea; }
    .stats-icon.bg-success { background-color: rgba(40, 167, 69, 0.1); color: #28a745; }

    .card-header-dark {
        background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
        color: white;
    }

    @media (max-width: 768px) {
        .stat-card {
            margin-bottom: 1rem;
        }
        
        .filter-card {
            margin-bottom: 1.5rem;
        }
    }

	.payment-badge{
    font-size:15px;
}
</style>

<!-- Begin Page Content -->
<div class="main-content app-content">
    <div class="container-fluid page-container">

        <!-- Start::page-header -->
        <div class="page-header-breadcrumb mb-4">
            <div class="d-flex align-center justify-content-between flex-wrap">
                <div class="d-flex align-center gap-2">
                    <div>
                        <h1 class="page-title fw-medium fs-20 mb-1"><i class="ri-stamp-line me-2 text-primary"></i>Stamp Duty Payments</h1>
                        <p class="text-muted fs-14 mb-0">Track and manage stamp duty payment transactions</p>
                    </div>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Stamp Duty Payments</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <!-- Hidden data -->
        <div id="acct_graph_data_values" style="display:none">${data}</div>

        <!-- Main Content -->
        <div class="row">
            <!-- Filter Column -->
            <div class="col-lg-3 mb-4">
                <div class="card transaction-report-card h-100 filter-card">
                    <div class="card-header bg-light border-0 py-3">
                        <h5 class="mb-0 fw-semibold">
                            <i class="ri-filter-line text-primary me-2"></i>
                            Filter Options
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post">
                            <div class="row g-3">
                                <div class="col-12">
                                    <label class="form-label">Date From</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="ri-calendar-line"></i>
                                        </span>
                                        <input type="date" class="form-control form-control-sm" name="date_from" id="date_from" value="${date_from}">
                                    </div>
                                </div>
                                
                                <div class="col-12">
                                    <label class="form-label">Date To</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="ri-calendar-line"></i>
                                        </span>
                                        <input type="date" class="form-control form-control-sm" name="date_to" id="date_to" value="${date_to}">
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
            
            <!-- Data Column -->
            <div class="col-lg-9">
                <!-- Stats Row -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card stat-card border-primary h-100">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon bg-primary me-3">
                                        <i class="ri-money-dollar-circle-line fs-4"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small fw-semibold mb-1">Total Amount</div>
                                        <h3 class="fw-bold text-primary mb-0">
                                            GHS <fmt:formatNumber type="number" maxFractionDigits="3" minFractionDigits="2" value="${total_amount}" />
                                        </h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card stat-card border-success h-100">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon bg-success me-3">
                                        <i class="ri-file-list-line fs-4"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="text-muted small fw-semibold mb-1">Total Payment Count</div>
                                        <h3 class="fw-bold text-success mb-0">
                                            <fmt:formatNumber type="number" maxFractionDigits="2" value="${total_count}" />
                                        </h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Data Table Card -->
                <div class="card transaction-report-card">
                    <div class="card-header card-header-dark d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-semibold text-white">
                            <i class="ri-list-check me-2"></i>
                            Stamp Duty Transactions List
                        </h5>
                        <div>
                            <button class="btn btn-sm btn-outline-light" title="Toggle fullscreen">
                                <i class="ri-fullscreen-line"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover data-table" id="tbl_transactions_stp_result">
                                <thead class="table-light">
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
                                    <c:forEach items='${data}' var="rec">
                                    <tr>
                                        <td>${rec.ref_number}</td>
                                        <td>${rec.payment_slip_number}</td>
                                        <td>${rec.payment_date}</td>
                                        <td>${rec.lessees_name}</td>
                                        <td class="fw-semibold text-primary">GHS <fmt:formatNumber type="number" maxFractionDigits="2" value="${rec.payment_amount}" /></td>
                                        <td>${rec.business_process_sub_name}</td>
                                        <td>
                                            <span class="badge bg-light text-dark px-3 py-2 payment-badge">${rec.payment_mode}</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-info bg-opacity-10 text-info px-3 py-2 payment-badge">${rec.job_number}</span>
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
        <!-- End Main Content -->

    </div>
</div>
<!-- End Page Content -->
 <script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    // Initialize any Bootstrap components if needed
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});


$(document)
		.ready(
				function() {




$("#tbl_transactions_stp_result").DataTable(
							{
								dom : 'Bfrtip',
								buttons : [ 'pageLength', 'copy', 'csv',
										'excel', 'pdf', 'print' ]
							});

		});
</script>