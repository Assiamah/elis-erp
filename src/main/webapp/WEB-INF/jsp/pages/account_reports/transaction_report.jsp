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
    .stat-card.border-primary { border-left-color: #2d7d42; }
    .stat-card.border-success { border-left-color: #28a745; }

    .nav-tabs .nav-link {
        border: none;
        padding: 0.75rem 1.5rem;
        font-weight: 500;
        color: #6c757d;
        transition: all 0.3s ease;
        border-radius: 8px 8px 0 0;
    }

    .nav-tabs .nav-link.active {
        color: #2d7d42;
        background-color: white;
        border-bottom: 3px solid #2d7d42;
    }

    .nav-tabs .nav-link:hover:not(.active) {
        color: #495057;
        background-color: rgba(102, 126, 234, 0.05);
    }

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
    .stats-icon.bg-primary { background-color: rgba(102, 234, 115, 0.1); color: #2d7d42; }
    .stats-icon.bg-success { background-color: rgba(40, 167, 69, 0.1); color: #28a745; }

    .chart-container {
        background: white;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .card-header-dark {
        background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
        color: white;
    }

    .modal-header.bg-gradient-primary {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 12px 12px 0 0;
    }

    @media (max-width: 768px) {
        .nav-tabs .nav-link {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
        }
        
        .stat-card {
            margin-bottom: 1rem;
        }
        
        .chart-container {
            padding: 15px;
        }
        
        .filter-card {
            margin-bottom: 1.5rem;
        }
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
                        <h1 class="page-title fw-medium fs-20 mb-1"><i class="ri-pie-chart-line me-2 text-primary"></i>Transaction Reports</h1>
                        <p class="text-muted fs-14 mb-0">Comprehensive revenue tracking and financial analytics</p>
                    </div>
                </div>
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">ELIS</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Transaction Reports</li>
                </ol>
            </div>
        </div>
        <!-- End::page-header -->

        <!-- Hidden data for charts -->
        <div id="acct_graph_data_values" style="display:none">${data}</div>

        <!-- Tab Navigation -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header bg-transparent border-0 px-4 pt-4 pb-0">
                <ul class="nav nav-tabs nav-tabs-line" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link ${(active == 'graph') ? 'active' : ''}" data-bs-toggle="tab" data-bs-target="#summarized-revenue" type="button" role="tab">
                            <i class="ri-pie-chart-line me-2"></i>Summarized Revenues
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link ${(active == 'trans') ? 'active' : ''}" data-bs-toggle="tab" data-bs-target="#transactions-report" type="button" role="tab">
                            <i class="ri-list-check me-2"></i>Transactions Report
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#bill-item-report" type="button" role="tab">
                            <i class="ri-file-list-line me-2"></i>Report Per Bill Item
                        </button>
                    </li>
                </ul>
            </div>
            
            <div class="card-body px-4 pt-4">
                <div class="tab-content">
                    
                    <!-- Tab 1: Summarized Revenues -->
                    <div class="tab-pane fade ${(active == 'graph') ? 'show active' : ''}" id="summarized-revenue" role="tabpanel">
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

                                                <div class="col-12">
                                                    <label class="form-label">Region</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="ri-map-pin-line"></i>
                                                        </span>
                                                        <select id="region_id" name="region_id" class="form-select form-control-sm" required>
                                                            <option value="-1">-- select --</option>
                                                            <c:forEach items="${officeregionlist}" var="officeregion">
                                                                <option value="${officeregion.ord_region_code}"
                                                                        data-name="${officeregion.ord_region_name}"
                                                                        ${region_id == officeregion.ord_region_code ? 'selected' : ''}>
                                                                    ${officeregion.ord_region_name}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <label class="form-label">Summarize by</label>
                                                    <select class="form-select form-control-sm" name="type" id="type" required>
                                                        <option value="values" ${(type == "values") ? "selected" : ""}>Value</option>
                                                        <option value="count" ${(type == "count") ? "selected" : ""}>Count</option>
                                                    </select>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <label class="form-label">Division</label>
                                                    <select class="form-select form-control-sm" name="division" id="division" multiple required>
                                                        <option value="PVLMD" ${fn:contains(division, 'PVLMD') ? 'selected' : ''}>PVLMD</option>
                                                        <option value="SMD" ${fn:contains(division, 'SMD') ? 'selected' : ''}>SMD</option>
                                                        <option value="LVD" ${fn:contains(division, 'LVD') ? 'selected' : ''}>LVD</option>
                                                        <option value="LRD" ${fn:contains(division, 'LRD') ? 'selected' : ''}>LRD</option>
                                                    </select>
                                                    <small class="text-muted">Hold Ctrl/Cmd to select multiple</small>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <label class="form-label">Cut-Off Point on Graph</label>
                                                    <input type="number" step="1" class="form-control form-control-sm" name="limit" value="${limit}" min="3" id="limit" required>
                                                </div>
                                            </div>
                                            
                                            <div class="d-grid gap-2 mt-4">
                                                <button type="submit" class="btn btn-primary action-btn">
                                                    <i class="ri-filter-3-line me-2"></i>Apply Filter
                                                </button>
                                            </div>
                                            
                                            <hr class="my-4">
                                            
                                            <div class="export-section">
                                                <label class="form-label">Export Type</label>
                                                <div class="d-grid gap-2 mb-3">
                                                    <button type="button" class="btn btn-outline-dark" data-bs-toggle="export_type" data-title="PDF">
                                                        <i class="ri-file-pdf-line me-2"></i>Export as PDF
                                                    </button>
                                                    <button type="button" class="btn btn-outline-dark" data-bs-toggle="export_type" data-title="CSV">
                                                        <i class="ri-file-excel-line me-2"></i>Export as CSV
                                                    </button>
                                                </div>
                                                <input type="hidden" name="export_type" id="export_type">
                                                
                                                <div class="d-grid">
                                                    <button class="btn btn-danger action-btn" id="btn_export_data">
                                                        <i class="ri-download-line me-2"></i>Export Data
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Chart Column -->
                            <div class="col-lg-9">
                                <!-- Stats Row -->
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <div class="card stat-card border-success h-100">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center">
                                                    <div class="stats-icon bg-primary me-3">
                                                        <i class="ri-money-dollar-circle-line fs-4 text-white"></i>
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
                                                        <i class="ri-file-list-line fs-4 text-white"></i>
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
                                
                                <!-- Chart Card -->
                                <div class="card transaction-report-card">
                                    <div class="card-header card-header-dark d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0 fw-semibold text-white">
                                            <i class="ri-pie-chart-line me-2"></i>
                                            Revenue per Service
                                        </h5>
                                        <div>
                                            <button class="btn btn-sm btn-outline-light" title="Toggle fullscreen">
                                                <i class="ri-fullscreen-line"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="chart-container">
                                            <div id="main-echart" style="width: 100%; height: 500px;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Tab 2: Transactions Report -->
                    <div class="tab-pane fade ${(active == 'trans') ? 'show active' : ''}" id="transactions-report" role="tabpanel">
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
                                                        <input type="date" class="form-control form-control-sm" name="t_date_from" id="t_date_from" value="${t_date_from}">
                                                    </div>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <label class="form-label">Date To</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="ri-calendar-line"></i>
                                                        </span>
                                                        <input type="date" class="form-control form-control-sm" name="t_date_to" id="t_date_to" value="${t_date_to}">
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <label class="form-label">Region</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="ri-map-pin-line"></i>
                                                        </span>
                                                        <select id="t_region_id" name="t_region_id" class="form-select form-control-sm" required>
                                                            <option value="-1">-- select --</option>
                                                            <c:forEach items="${officeregionlist}" var="officeregion">
                                                                <option value="${officeregion.ord_region_code}"
                                                                        data-name="${officeregion.ord_region_name}"
                                                                        ${region_id == officeregion.ord_region_code ? 'selected' : ''}>
                                                                    ${officeregion.ord_region_name}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <label class="form-label">Division</label>
                                                    <select class="form-select form-control-sm" name="t_division" id="t_division" multiple required>
                                                        <option value="PVLMD" ${fn:contains(t_division, 'PVLMD') ? 'selected' : ''}>PVLMD</option>
                                                        <option value="SMD" ${fn:contains(t_division, 'SMD') ? 'selected' : ''}>SMD</option>
                                                        <option value="LVD" ${fn:contains(t_division, 'LVD') ? 'selected' : ''}>LVD</option>
                                                        <option value="LRD" ${fn:contains(t_division, 'LRD') ? 'selected' : ''}>LRD</option>
                                                    </select>
                                                    <small class="text-muted">Hold Ctrl/Cmd to select multiple</small>
                                                </div>
                                            </div>
                                            
                                            <div class="d-grid mt-4">
                                                <button type="submit" name="transactions_form" value="1" class="btn btn-primary action-btn">
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
                                                            GHS <fmt:formatNumber type="number" maxFractionDigits="3" minFractionDigits="2" value="${t_total_amount}" />
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
                                                            <fmt:formatNumber type="number" maxFractionDigits="2" value="${t_total_count}" />
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
                                        <h5 class="mb-0 fw-semibold text-white" >
                                            <i class="ri-list-check me-2"></i>
                                            Revenue Transactions List
                                        </h5>
                                        <div>
                                            <button class="btn btn-sm btn-outline-light" title="Toggle fullscreen">
                                                <i class="ri-fullscreen-line"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover data-table" id="tbl_transactions_result">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Bill Number</th>
                                                        <th>GOG Invoice No.</th>
                                                        <th>Created Date</th>
                                                        <th>Payment Date</th>
                                                        <th>Bill Amount</th>
                                                        <th>Payment Amount</th>
                                                        <th>Payment Slip No.</th>
                                                        <th>Payment Mode</th>
                                                        <th>Job Number</th>
                                                        <th>Application Type</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items='${t_applicationlist}' var="row">
                                                    <tr>
                                                        <td>${row.ref_number}</td>
                                                        <td>${row.gog_invoice_number}</td>
                                                        <td>${row.created_date}</td>
                                                        <td>${row.payment_date}</td>
                                                        <td>${row.bill_amount}</td>
                                                        <td>${row.payment_amount}</td>
                                                        <td>${row.payment_slip_number}</td>
                                                        <td>${row.payment_mode}</td>
                                                        <td>${row.job_number}</td>
                                                        <td>${row.business_process_sub_name}</td>
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
                    
                    <!-- Tab 3: Report Per Bill Item -->
                    <div class="tab-pane fade" id="bill-item-report" role="tabpanel">
                        <div class="container-fluid">
                            <!-- Filter Row -->
                            <div class="row mb-4">
                                <div class="col-md-4">
                                    <div class="card transaction-report-card">
                                        <div class="card-body">
                                            <label class="form-label">Date From</label>
                                            <input type="date" id="datefrom" class="form-control form-control-sm" placeholder="Select Date">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <div class="card transaction-report-card">
                                        <div class="card-body">
                                            <label class="form-label">Date To</label>
                                            <input type="date" id="dateto" class="form-control form-control-sm" placeholder="Select Date">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <div class="card transaction-report-card">
                                        <div class="card-body">
                                            <label class="form-label">Office Region</label>
                                            <select id="sel_change_region_compliance" class="form-select form-control-sm" required>
                                                <option selected value="-1">-- select --</option>
                                                <option value="0">Nationwide</option>
                                                <c:forEach items="${officeregionlist}" var="officeregion">
                                                    <option value="${officeregion.ord_region_code}" data-name="${officeregion.ord_region_name}">
                                                        ${officeregion.ord_region_name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Hidden Fields -->
                            <input type="hidden" id="start_date">
                            <input type="hidden" id="end_date">
                            <input type="hidden" id="region_select">
                            
                            <!-- Stats Row -->
                            <div class="row mb-4">
                                <div class="col-md-6" id="totalrevenue">
                                    <div class="card stat-card border-warning h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="stats-icon bg-warning me-3">
                                                    <i class="ri-money-dollar-circle-line fs-4"></i>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <div class="text-muted small fw-semibold mb-1">Total Revenue</div>
                                                    <h3 id="total_revenue" class="fw-bold text-warning mb-0">GHS 0.00</h3>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6" id="totalTransactions">
                                    <div class="card stat-card border-info h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="stats-icon bg-info me-3">
                                                    <i class="ri-file-list-line fs-4"></i>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <div class="text-muted small fw-semibold mb-1">Total Transactions</div>
                                                    <h3 id="total_transactions" class="fw-bold text-info mb-0">0</h3>
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
        </div>
    </div>
</div>

<!-- Modals (Bootstrap 5 Structure) -->
<div class="modal fade" id="sub_service_modal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header bg-gradient-primary">
                <h5 class="modal-title text-white" id="sub_service_modalLabel"></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover data-table" id="sub_service_table">
                        <thead class="table-light">
                            <tr>
                                <th>Sub Service Name</th>
                                <th>Amount</th>
                                <th>Count</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Content loaded dynamically -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="bill_items" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header bg-gradient-primary">
                <h5 class="modal-title text-white">Bill Items</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover data-table" id="banks_table">
                        <thead class="table-light">
                            <tr>
                                <th>Bill Item Name</th>
                                <th>Amount</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Content loaded dynamically -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="transactions_modal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content">
            <div class="modal-header bg-gradient-primary">
                <h5 class="modal-title text-white" id="transactions_Label"></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover data-table" id="transactions_table">
                        <thead class="table-light">
                            <tr>
                                <th>Applicant Name</th>
                                <th>Job Number</th>
                                <th>Application Type</th>
                                <th>Bill Number</th>
                                <th>Bill Amount</th>
                                <th>Amount Paid</th>
                                <th>GHANA.GOV Ref Number</th>
                                <th>EGRC Number</th>
                                <th>Payment Mode</th>
                                <th>Payment Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Content loaded dynamically -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="job_numberbill_items" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header bg-gradient-primary">
                <h5 class="modal-title text-white" id="job_numberbillLabel"></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Bill Number</label>
                        <input type="text" id="bill_number" disabled class="form-control" value="">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Bill Amount</label>
                        <input type="text" id="bill_amount" disabled class="form-control" value="">
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col-12">
                        <label class="form-label">Applicant Name</label>
                        <input type="text" id="applicant_name" disabled class="form-control" value="">
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover data-table" id="job_numberbill_table">
                        <thead class="table-light">
                            <tr>
                                <th>Bill Item Name</th>
                                <th>Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Content loaded dynamically -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                    <i class="ri-close-line me-1"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Additional Modals (Minimal Structure) -->
<div class="modal fade" id="bill_items_new" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">

      <!-- Header -->
      <div class="modal-header bg-gradient-primary">
        <h5 class="modal-title text-white" id="banks_modalLabel_1">
          Applications Received
        </h5>
        <button
          type="button"
          class="btn-close btn-close-white"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>

      <!-- Body -->
      <div class="modal-body">

        <!-- Summary Row -->
        <div class="row mb-3">
          <div id="bills_created_and_paid_today" class="col-lg-6">
            <div class="card shadow-sm">
              <div class="card-header py-2">
                <h6 class="m-0 fw-semibold text-dark">
                  Total :
                  <span class="count text-primary" id="total_span2"></span>
                </h6>
              </div>
            </div>
          </div>
        </div>

        <!-- Hidden Inputs -->
        <input type="hidden" id="subprocessid">
        <input type="hidden" id="completed_subprocessid">
        <input type="hidden" id="service_to_bank_name">

        <!-- Table -->
        <div class="table-responsive">
          <table
            class="table table-bordered table-hover align-middle"
            id="banks_table_1"
            width="100%"
            cellspacing="0"
          >
            <thead class="table-light">
              <tr>
                <th>Bill Item Name</th>
                <th>Amount</th>
              </tr>
            </thead>
            <tbody>
              <!-- Populated dynamically -->
            </tbody>
          </table>
        </div>

      </div>

      <!-- Footer -->
      <div class="modal-footer">
        <button
          type="button"
          class="btn btn-danger"
          data-bs-dismiss="modal"
        >
          Close
        </button>
      </div>

    </div>
  </div>
</div>


<div class="modal fade" id="bill_items_regional_modal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">

      <!-- Header -->
      <div class="modal-header bg-gradient-primary">
        <h5 class="modal-title text-white" id="bill_items_regional_Label"></h5>
        <button
          type="button"
          class="btn-close btn-close-white"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>

      <!-- Body -->
      <div class="modal-body">

        <!-- Summary Row -->
        <div class="row mb-3">
          <div id="bills_created_and_paid_today" class="col-lg-6">
            <div class="card shadow-sm">
              <div class="card-header py-2">
                <h6 class="m-0 fw-semibold text-dark">
                  Total :
                  <span class="count text-primary" id="total_span"></span>
                </h6>
              </div>
            </div>
          </div>
        </div>

        <!-- Hidden Inputs -->
        <input type="hidden" id="subprocessid">
        <input type="hidden" id="completed_subprocessid">
        <input type="hidden" id="service_to_bank_name">

        <!-- Table -->
        <div class="table-responsive">
          <table
            class="table table-bordered table-hover align-middle"
            id="bill_items_regional_table"
            width="100%"
            cellspacing="0"
          >
            <thead class="table-light">
              <tr>
                <th>Bill Item Name</th>
                <th>Amount</th>
              </tr>
            </thead>
            <tbody>
              <!-- Populated dynamically -->
            </tbody>
          </table>
        </div>

      </div>

      <!-- Footer -->
      <div class="modal-footer">
        <button
          type="button"
          class="btn btn-danger"
          data-bs-dismiss="modal"
        >
          Close
        </button>
      </div>

    </div>
  </div>
</div>



<div class="modal fade" id="bill_items" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">

      <!-- Header -->
      <div class="modal-header bg-gradient-primary">
        <h5 class="modal-title text-white" id="banks_modalLabel">
          Applications Received
        </h5>
        <button
          type="button"
          class="btn-close btn-close-white"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>

      <!-- Body -->
      <div class="modal-body">

        <!-- Summary Row -->
        <div class="row mb-3">
          <div id="bills_created_and_paid_today" class="col-lg-6">
            <div class="card shadow-sm">
              <div class="card-header py-2">
                <h6 class="m-0 fw-semibold text-dark">
                  Total :
                  <span class="count text-primary" id="total_span1"></span>
                </h6>
              </div>
            </div>
          </div>
        </div>

        <!-- Hidden Inputs -->
        <input type="hidden" id="subprocessid">
        <input type="hidden" id="completed_subprocessid">
        <input type="hidden" id="service_to_bank_name">

        <!-- Table -->
        <div class="table-responsive">
          <table
            class="table table-bordered table-hover align-middle"
            id="banks_table"
            width="100%"
            cellspacing="0"
          >
            <thead class="table-light">
              <tr>
                <th>Bill Item Name</th>
                <th>Amount</th>
                <th class="text-center">Action</th>
              </tr>
            </thead>
            <tbody>
              <!-- Populated dynamically -->
            </tbody>
          </table>
        </div>

      </div>

      <!-- Footer -->
      <div class="modal-footer">
        <button
          type="button"
          class="btn btn-danger"
          data-bs-dismiss="modal"
        >
          Close
        </button>
      </div>

    </div>
  </div>
</div>

<script type="text/javascript" src="client_application/audit_report.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Bootstrap tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Initialize Bootstrap popovers
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl);
    });
    
    // Initialize select elements (if using selectpicker)
    if ($('.selectpicker').length) {
        $('.selectpicker').selectpicker();
    }
});
</script>